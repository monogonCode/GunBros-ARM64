#include <jni.h>
#include <EGL/egl.h>
#include <GLES/gl.h>
#define GL_GLEXT_PROTOTYPES 1
#include <GLES/glext.h>
#include <android/native_window.h>
#include <android/native_window_jni.h>
#include <android/asset_manager.h>
#include <android/asset_manager_jni.h>
#include <android/log.h>
#include <unicorn/unicorn.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <time.h>
#include <unistd.h>
#include <sys/time.h>
#include <pthread.h>
#include <sys/mman.h>
#include <errno.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <netdb.h>
#include <fcntl.h>
#include <sys/stat.h>
#include <ctype.h>
#include <dirent.h>

#define MAX_OPEN_FILES 256
static FILE* g_file_table[MAX_OPEN_FILES] = {0};
static char g_real_files_dir[512] = "/sdcard/Android/data/com.glu.android.gunbros_free/files/";

#define LOG_TAG "GunBrosARM64"
#define LOGI(...) __android_log_print(ANDROID_LOG_INFO, LOG_TAG, __VA_ARGS__)
#define LOGE(...) __android_log_print(ANDROID_LOG_ERROR, LOG_TAG, __VA_ARGS__)

#ifndef DLOG
#ifdef BRIDGE_DEBUG
#define DLOG(...) LOGI(__VA_ARGS__)
#else
#define DLOG(...) ((void)0)
#endif
#endif

static JavaVM *g_real_jvm = NULL;
static jobject g_real_callback = NULL;
static char g_last_jni_string[512] = {0};

static JNIEnv* get_real_env(void) {
    if (!g_real_jvm) return NULL;
    JNIEnv *env = NULL;
    jint res = (*g_real_jvm)->GetEnv(g_real_jvm, (void**)&env, JNI_VERSION_1_6);
    if (res == JNI_EDETACHED) {
        if ((*g_real_jvm)->AttachCurrentThread(g_real_jvm, &env, NULL) != 0) {
            return NULL;
        }
    }
    return env;
}

static const char* normalize_game_path(const char *in_path, char *out_buf, size_t out_sz) {
    if (!in_path || in_path[0] == '\0') return in_path;

    // Check if path contains "com.glu.android.gunbros_free/files"
    const char *files_ptr = strstr(in_path, "com.glu.android.gunbros_free/files");
    if (files_ptr != NULL) {
        const char *after_files = files_ptr + strlen("com.glu.android.gunbros_free/files");
        if (*after_files == '/') {
            after_files++;
        }
        if (strncmp(after_files, "ackTOC", 6) == 0) {
            snprintf(out_buf, out_sz, "%sp%s", g_real_files_dir, after_files);
        } else {
            snprintf(out_buf, out_sz, "%s%s", g_real_files_dir, after_files);
        }
    } else {
        const char *files_sub = strstr(in_path, "/files");
        if (files_sub != NULL && files_sub[6] != '/' && files_sub[6] != '\0') {
            const char *fname = files_sub + 6;
            snprintf(out_buf, out_sz, "%s%s", g_real_files_dir, fname);
        } else if (in_path[0] != '/') {
            if (strncmp(in_path, "ackTOC", 6) == 0) {
                snprintf(out_buf, out_sz, "%sp%s", g_real_files_dir, in_path);
            } else {
                snprintf(out_buf, out_sz, "%s%s", g_real_files_dir, in_path);
            }
        } else if (strncmp(in_path, "/sdcard/", 8) == 0 && strncmp(g_real_files_dir, "/storage/", 9) == 0) {
            snprintf(out_buf, out_sz, "/storage/emulated/0/%s", in_path + 8);
        } else {
            strncpy(out_buf, in_path, out_sz);
            out_buf[out_sz - 1] = '\0';
        }
    }

    // Alias/fallback: if path refers to a "wvga" file, fallback to "xga" if wvga doesn't exist
    if (strstr(out_buf, "wvga")) {
        char candidate[512];
        strncpy(candidate, out_buf, sizeof(candidate));
        candidate[sizeof(candidate) - 1] = '\0';
        char *p = strstr(candidate, "wvga");
        if (p) {
            p[0] = 'x'; p[1] = 'g'; p[2] = 'a';
            memmove(p + 3, p + 4, strlen(p + 4) + 1);
            if (access(candidate, F_OK) == 0 || access(out_buf, F_OK) != 0) {
                strncpy(out_buf, candidate, out_sz);
                out_buf[out_sz - 1] = '\0';
            }
        }
    }

    return out_buf;
}

extern void init_get_clock(void);
extern void init_real_host_page_size(void *uc);
extern void init_cache_info(void *uc);

void qemu_system_reset_request(void) {}
void qemu_system_shutdown_request(void) {}

int machine_initialize(void *uc) {
    LOGI("machine_initialize: safe native C implementation invoked with uc=%p", uc);
    init_get_clock();
    init_real_host_page_size(uc);
    init_cache_info(uc);

    typedef void (*cb_fn)(void *);
    typedef void (*cb_fn2)(void *, int);
    typedef int (*cb_tail)(void *, void *);

    cb_fn cb1 = *(cb_fn*)((char*)uc + 240);
    if (cb1) cb1(uc);

    cb_fn cb2 = *(cb_fn*)((char*)uc + 248);
    if (cb2) cb2(uc);

    cb_fn cb3 = *(cb_fn*)((char*)uc + 352);
    if (cb3) cb3(uc);

    cb_fn2 cb4 = *(cb_fn2*)((char*)uc + 264);
    if (cb4) {
        int val = *(int*)((char*)uc + 18960);
        cb4(uc, val);
    }

    cb_tail cb5 = *(cb_tail*)((char*)uc + 344);
    if (cb5) cb5(uc, NULL);
    LOGI("machine_initialize: completed successfully!");
    return 0;
}

static void dummy_cpu_noop(void *cpu) { (void)cpu; }

extern bool unicorn_fill_tlb_arm(void *cs, uint64_t address, int size, int rw, int mmu_idx, bool probe, uintptr_t retaddr);

void cpu_class_init(void* uc, void* klass) {
    LOGI("cpu_class_init called with uc=%p, klass=%p", uc, klass);
    void **methods = (void**)klass;
    for (int i = 0; i < 64; i++) {
        methods[i] = (void*)dummy_cpu_noop;
    }
    methods[9] = (void*)unicorn_fill_tlb_arm;
    LOGI("cpu_class_init: methods[9] (tlb_fill)=%p", unicorn_fill_tlb_arm);
}
void cpu_common_initfn(void* obj) { (void)obj; }
void cpu_exit(void* cpu) { (void)cpu; }

static int g_in_cpu_reset = 0;
void cpu_reset(void* cpu) {
    if (g_in_cpu_reset) return;
    g_in_cpu_reset = 1;
    void **methods = *(void***)((char*)cpu + 33264);
    if (methods && methods[0]) {
        typedef void (*reset_fn)(void*);
        reset_fn fn = (reset_fn)methods[0];
        fn(cpu);
    }
    g_in_cpu_reset = 0;
}
void cpu_reset_interrupt(void* cpu, int mask) {
    *(int*)((char*)cpu + 33240) &= ~mask;
}
void cpu_stop(void* cpu) { (void)cpu; }

static uc_engine *g_uc = NULL;
static pthread_mutex_t g_emu_mutex = PTHREAD_MUTEX_INITIALIZER;
static pthread_mutex_t g_egl_mutex = PTHREAD_MUTEX_INITIALIZER;
static EGLDisplay g_display = EGL_NO_DISPLAY;
static EGLSurface g_surface = EGL_NO_SURFACE;
static EGLContext g_context = EGL_NO_CONTEXT;
static ANativeWindow* g_window = NULL;
static ANativeWindow* g_new_window = NULL;
static bool g_window_changed = false;
static int g_real_screen_w = 2631;
static int g_real_screen_h = 1216;
static int g_surf_width = 1038;
static int g_surf_height = 480;

static bool g_sound_engine_ready = false;

// Audio callbacks must not wait behind a long emulated frame. The old path
// blocked on g_emu_mutex and copied from a shared guest buffer after unlocking;
// this could stall rendering and let a second callback overwrite the PCM block.
#define BRIDGE_PCM_MAX_BYTES 16384u
static uint8_t g_pcm_cache[BRIDGE_PCM_MAX_BYTES];
static size_t g_pcm_cache_len = 0;
static pthread_mutex_t g_pcm_cache_mutex = PTHREAD_MUTEX_INITIALIZER;
static uint32_t g_pcm_contention_count = 0;

static uint64_t bridge_monotonic_ns(void) {
    struct timespec ts;
    if (clock_gettime(CLOCK_MONOTONIC, &ts) != 0) return 0;
    return ((uint64_t)ts.tv_sec * 1000000000ull) + (uint64_t)ts.tv_nsec;
}

static void bridge_copy_cached_pcm(uint8_t *dst, size_t len) {
    if (!dst || len == 0) return;
    pthread_mutex_lock(&g_pcm_cache_mutex);
    size_t n = g_pcm_cache_len < len ? g_pcm_cache_len : len;
    if (n != 0) memcpy(dst, g_pcm_cache, n);
    if (n < len) memset(dst + n, 0, len - n);
    pthread_mutex_unlock(&g_pcm_cache_mutex);
}


static uint8_t *g_host_code = NULL;      // 0x00000000 - 0x00600000 (6MB)
static uint8_t *g_host_heap = NULL;      // 0x60000000 - 0x68000000 (128MB)
static uint8_t *g_host_stack = NULL;     // 0x70000000 - 0x70800000 (8MB)
static uint8_t *g_host_stubs = NULL;     // 0x80000000 - 0x80010000 (64KB)
static uint8_t *g_host_commpage = NULL;  // 0xffff0000 - 0xffff1000 (64KB)

static uint32_t g_heap_top = 0x60100000;
#define GUEST_HEAP_END 0x70000000u
static uint32_t g_free_bins[256];

static inline uint32_t heap_round(uint32_t sz) {
    // Original rounding could overflow in (sz + step - 1), producing a
    // smaller capacity and allowing the allocator to under-allocate memory.
    if (sz == 0) sz = 1;
    if (sz <= 1024) return (sz + 15u) & ~15u;
    if (sz > 0x40000000u) return 0; // Cannot be rounded safely in this allocator.
    int p = 31 - __builtin_clz(sz - 1u);
    if (p < 2 || p >= 31) return 0;
    uint32_t step = 1u << (p - 2);
    uint64_t rounded = (((uint64_t)sz + step - 1u) / step) * step;
    return (rounded > UINT32_MAX) ? 0 : (uint32_t)rounded;
}
static inline int heap_bin(uint32_t cap) {
    if (cap == 0) return -1; // heap_round() uses zero to report overflow.
    if (cap <= 1024) return cap / 16;
    int p = 31 - __builtin_clz(cap - 1);
    uint32_t step = 1u << (p - 2);
    int sub = (int)((cap - 1 - (1u << p)) / step);
    return 65 + (p - 10) * 4 + sub;
}
static uint32_t g_capplet_inst = 0;
static int g_insn_count = 0;

static inline void* guest_to_host(uint32_t addr) {
    if (addr == 0) return NULL;
    if (addr < 0x00600000) return (void*)(g_host_code + addr);
    if (addr >= 0x60000000 && addr < GUEST_HEAP_END) return (void*)(g_host_heap + (addr - 0x60000000));
    if (addr >= 0x70000000 && addr < 0x70800000) return (void*)(g_host_stack + (addr - 0x70000000));
    if (addr >= 0x80000000 && addr < 0x80010000) return (void*)(g_host_stubs + (addr - 0x80000000));
    if (addr >= 0xffff0000 && addr < 0xffff0000 + 0x10000) return (void*)(g_host_commpage + (addr - 0xffff0000));
    return NULL;
}


static uint32_t guest_alloc(uint32_t sz) {
    uint32_t cap = heap_round(sz);
    int b = heap_bin(cap);
    // Do not index the free-bin array if size rounding failed or returned an
    // invalid bin. The original path trusted both values unconditionally.
    if (cap == 0 || b < 0 || b >= (int)(sizeof(g_free_bins) / sizeof(g_free_bins[0]))) return 0;
    uint32_t blk = g_free_bins[b];
    if (blk) {
        g_free_bins[b] = *(uint32_t*)guest_to_host(blk - 12);
        memset(guest_to_host(blk), 0, cap);
        return blk;
    }
    uint32_t hdr = g_heap_top;
    if ((uint64_t)hdr + 16 + cap > GUEST_HEAP_END) return 0;
    g_heap_top = hdr + 16 + cap;
    *(uint32_t*)guest_to_host(hdr) = cap;
    memset(guest_to_host(hdr + 16), 0, cap);
    return hdr + 16;
}
static void guest_free(uint32_t ptr) {
    if (ptr < 0x60100010u || ptr >= GUEST_HEAP_END || (ptr & 15)) return;
    uint32_t cap = *(uint32_t*)guest_to_host(ptr - 16);
    if (cap == 0 || cap != heap_round(cap)) return;
    int b = heap_bin(cap);
    // Validate metadata-derived bin indexes before touching the free list.
    if (b < 0 || b >= (int)(sizeof(g_free_bins) / sizeof(g_free_bins[0]))) return;
    *(uint32_t*)guest_to_host(ptr - 12) = g_free_bins[b];
    g_free_bins[b] = ptr;
}
static uint32_t guest_cap(uint32_t ptr) {
    if (ptr < 0x60100010u || ptr >= GUEST_HEAP_END || (ptr & 15)) return 0;
    uint32_t cap = *(uint32_t*)guest_to_host(ptr - 16);
    // Reject corrupt capacity metadata rather than propagating it to realloc.
    if (cap == 0 || cap > GUEST_HEAP_END - ptr || heap_round(cap) != cap) return 0;
    return cap;
}

typedef struct {
    unsigned char e_ident[16];
    uint16_t e_type;
    uint16_t e_machine;
    uint32_t e_version;
    uint32_t e_entry;
    uint32_t e_phoff;
    uint32_t e_shoff;
    uint32_t e_flags;
    uint16_t e_ehsize;
    uint16_t e_phentsize;
    uint16_t e_phnum;
    uint16_t e_shentsize;
    uint16_t e_shnum;
    uint16_t e_shstrndx;
} Elf32_Ehdr;

typedef struct {
    uint32_t p_type;
    uint32_t p_offset;
    uint32_t p_vaddr;
    uint32_t p_paddr;
    uint32_t p_filesz;
    uint32_t p_memsz;
    uint32_t p_flags;
    uint32_t p_align;
} Elf32_Phdr;

typedef struct {
    uint32_t r_offset;
    uint32_t r_info;
} Elf32_Rel;

typedef struct {
    uint32_t st_name;
    uint32_t st_value;
    uint32_t st_size;
    uint8_t  st_info;
    uint8_t  st_other;
    uint16_t st_shndx;
} Elf32_Sym;

#define ELF32_R_SYM(val) ((val) >> 8)
#define ELF32_R_TYPE(val) ((val) & 0xff)

static const char* g_plt_names[] = {
    "clock", "rewind", "bind", "glGenRenderbuffersOES", "glEnable", "modff", "glTexCoordPointer", "gethostbyname",
    "difftime", "glCopyTexImage2D", "strftime", "calloc", "glDeleteRenderbuffersOES", "glHint", "clock_gettime", "fwrite",
    "glEnableClientState", "glFrontFace", "glDeleteFramebuffersOES", "usleep", "memcpy", "connect", "glFramebufferTexture2DOES", "glMatrixMode",
    "glDisable", "sinf", "realloc", "send", "glAlphaFunc", "glClear", "pthread_mutex_init", "glClearStencil",
    "srand48", "strspn", "getsockname", "gettimeofday", "strcat", "glColor4x", "remove", "glGetError",
    "rmdir", "glScalex", "strcasecmp", "__cxa_finalize", "__cxa_guard_release", "glRenderbufferStorageOES", "mkdir", "malloc",
    "glStencilMask", "strrchr", "strncmp", "glCompressedTexImage2D", "__gnu_Unwind_Find_exidx", "ioctl", "__cxa_begin_cleanup", "recv",
    "strlen", "glLoadIdentity", "pthread_mutex_lock", "ctime", "glClearColor", "opendir", "strtod", "acosf",
    "stat", "__cxa_atexit", "glBindFramebufferOES", "sqrtf", "sendto", "gmtime", "snprintf", "__cxa_pure_virtual",
    "glReadPixels", "dup", "glShadeModel", "atexit", "select", "strncasecmp", "glActiveTexture", "__android_log_print",
    "fdopen", "pthread_mutex_destroy", "glColorMask", "mktime", "glGenFramebuffersOES", "memmove", "fclose", "glBlendFunc",
    "setsockopt", "fread", "strncat", "fopen", "vsprintf", "gethostname", "__android_log_assert", "ceilf",
    "glBindTexture", "glDepthRangex", "time", "strtok", "glDepthMask", "getsockopt", "atoll", "closedir",
    "glDepthRangef", "glLoadMatrixf", "glDeleteTextures", "localtime", "close", "glDisableClientState", "glCullFace", "glPixelStorei",
    "glGetIntegerv", "asinf", "sscanf", "strncpy", "glBindRenderbufferOES", "strptime", "__cxa_guard_acquire", "glDrawElements",
    "glColor4f", "memset", "floorf", "inet_ntoa", "glTexImage2D", "cosf", "__android_log_vprint", "qsort",
    "glDepthFunc", "glDrawArrays", "fprintf", "mkstemp", "inet_addr", "glClearDepthf", "strcspn", "abort",
    "memcmp", "vsnprintf", "recvfrom", "glScissor", "sprintf", "socket", "fseek", "memchr",
    "atan2f", "__cxa_type_match", "glGetString", "glBindBuffer", "glPolygonOffset", "rename", "pthread_mutex_unlock", "raise",
    "strstr", "strcmp", "__errno", "lrand48", "glVertexPointer", "glViewport", "ftell", "free",
    "atanf", "atoi", "readdir", "strchr", "glTexEnvx", "glClientActiveTexture", "glColorPointer", "glAlphaFuncx",
    "strdup", "puts", "glTexParameteri", "glFramebufferRenderbufferOES", "gethostbyaddr", "glGenTextures", "glCheckFramebufferStatusOES", "wcslen",
    "strcpy", "shutdown"
};

static int find_plt_index(const char *name) {
    for (int i = 0; i < 178; i++) {
        if (strcmp(name, g_plt_names[i]) == 0) return i;
    }
    return -1;
}

static bool hook_mem_invalid_cb(uc_engine *uc, uc_mem_type type, uint64_t address, int size, int64_t value, void *user_data) {
    uint32_t pc, lr, r0, r1, r2, r3, sp, cpsr;
    uint32_t r4, r5, r6, r7, r8, r9, r10, r11, r12;
    uc_reg_read(uc, UC_ARM_REG_PC, &pc);
    uc_reg_read(uc, UC_ARM_REG_LR, &lr);
    uc_reg_read(uc, UC_ARM_REG_R0, &r0);
    uc_reg_read(uc, UC_ARM_REG_R1, &r1);
    uc_reg_read(uc, UC_ARM_REG_R2, &r2);
    uc_reg_read(uc, UC_ARM_REG_R3, &r3);
    uc_reg_read(uc, UC_ARM_REG_R4, &r4);
    uc_reg_read(uc, UC_ARM_REG_R5, &r5);
    uc_reg_read(uc, UC_ARM_REG_R6, &r6);
    uc_reg_read(uc, UC_ARM_REG_R7, &r7);
    uc_reg_read(uc, UC_ARM_REG_R8, &r8);
    uc_reg_read(uc, UC_ARM_REG_R9, &r9);
    uc_reg_read(uc, UC_ARM_REG_R10, &r10);
    uc_reg_read(uc, UC_ARM_REG_R11, &r11);
    uc_reg_read(uc, UC_ARM_REG_R12, &r12);
    uc_reg_read(uc, UC_ARM_REG_SP, &sp);
    uc_reg_read(uc, UC_ARM_REG_CPSR, &cpsr);
    LOGE("UNICORN MEMORY FAULT type=%d addr=0x%lx sz=%d val=0x%lx pc=0x%x lr=0x%x cpsr=0x%x",
         type, (unsigned long)address, size, (long)value, pc, lr, cpsr);
    LOGE("  r0=0x%08x r1=0x%08x r2=0x%08x r3=0x%08x", r0, r1, r2, r3);
    LOGE("  r4=0x%08x r5=0x%08x r6=0x%08x r7=0x%08x", r4, r5, r6, r7);
    LOGE("  r8=0x%08x r9=0x%08x r10=0x%08x r11=0x%08x r12=0x%08x sp=0x%08x lr=0x%08x pc=0x%08x",
         r8, r9, r10, r11, r12, sp, lr, pc);

    uint32_t stk[32] = {0};
    uc_mem_read(uc, sp, stk, sizeof(stk));
    LOGE("STACK DUMP at sp=0x%08x:", sp);
    for (int i = 0; i < 32; i += 4) {
        LOGE("  [sp+%02d]: 0x%08x 0x%08x 0x%08x 0x%08x", i * 4, stk[i], stk[i+1], stk[i+2], stk[i+3]);
    }

    if (r4 >= 0x60000000 && r4 < 0x70000000) {
        uint32_t obj[16] = {0};
        uc_mem_read(uc, r4, obj, sizeof(obj));
        LOGE("OBJECT DUMP at r4=0x%08x:", r4);
        for (int i = 0; i < 16; i += 4) {
            LOGE("  [r4+%02d]: 0x%08x 0x%08x 0x%08x 0x%08x", i * 4, obj[i], obj[i+1], obj[i+2], obj[i+3]);
        }
    }

    if ((type == UC_MEM_READ_UNMAPPED || type == UC_MEM_WRITE_UNMAPPED) && address < 0xff000000ULL && address >= 0x1000) {
        uint64_t page = address & ~0xfffULL;
        LOGI("Auto-mapping 64KB unmapped memory at 0x%lx", (unsigned long)page);
        if (uc_mem_map(uc, page, 0x10000, UC_PROT_ALL) == UC_ERR_OK) {
            return true;
        }
    }
    return false;
}

typedef struct {
    char name[64];
    char sig[64];
} JniMethodInfo;

#define MAX_JNI_METHODS 512
static JniMethodInfo g_jni_methods[MAX_JNI_METHODS];
static int g_jni_method_count = 1;

static int register_jni_method(const char *name, const char *sig) {
    if (!name) return 0;
    if (strcmp(name, "eglGetError") == 0) return 0x00003000;
    if (strcmp(name, "GetDeviceOrientation") == 0) return 0x00003001;
    for (int i = 1; i < g_jni_method_count; i++) {
        if (strcmp(g_jni_methods[i].name, name) == 0) {
            return i;
        }
    }
    if (g_jni_method_count < MAX_JNI_METHODS) {
        int id = g_jni_method_count++;
        strncpy(g_jni_methods[id].name, name, sizeof(g_jni_methods[id].name) - 1);
        if (sig) strncpy(g_jni_methods[id].sig, sig, sizeof(g_jni_methods[id].sig) - 1);
        return id;
    }
    return 1;
}

static const char* get_jni_method_name(uint32_t id) {
    if (id == 0x00003000) return "eglGetError";
    if (id == 0x00003001) return "GetDeviceOrientation";
    if (id > 0 && id < (uint32_t)g_jni_method_count) {
        return g_jni_methods[id].name;
    }
    return "unknown";
}

static void handle_jvm_call(uc_engine *uc, int idx, uint32_t *r0, uint32_t *r1, uint32_t *r2, uint32_t *r3, uint32_t sp, uint32_t lr) {
    DLOG("JVM Call: idx=%d (r0=0x%x, r1=0x%x, r2=0x%x, lr=0x%x)", idx, *r0, *r1, *r2, lr);
    if (idx == 4) { // AttachCurrentThread(JavaVM*, JNIEnv**, void*)
        uint32_t *p_env = (uint32_t*)guest_to_host(*r1);
        if (p_env) *p_env = 0x60001000;
        *r0 = 0; // JNI_OK
    } else if (idx == 6) { // GetEnv(JavaVM*, void**, jint)
        uint32_t *p_env = (uint32_t*)guest_to_host(*r1);
        if (p_env) *p_env = 0x60001000;
        *r0 = 0; // JNI_OK
    } else {
        *r0 = 0;
    }
}

static uint32_t get_jni_method_arg(int idx, uint32_t r3, uint32_t sp, int arg_idx) {
    int is_va = (idx == 35 || idx == 36 || idx == 38 || idx == 39 ||
                 idx == 41 || idx == 42 || idx == 44 || idx == 45 ||
                 idx == 47 || idx == 48 || idx == 50 || idx == 51 ||
                 idx == 53 || idx == 54 || idx == 56 || idx == 57 ||
                 idx == 59 || idx == 60 || idx == 62 || idx == 63 ||
                 idx == 68 || idx == 69 || idx == 80 || idx == 81 ||
                 idx == 92 || idx == 93 || idx == 118 || idx == 119 ||
                 idx == 130 || idx == 131 || idx == 142 || idx == 143);

    if (is_va || (r3 >= 0x70000000 && r3 < 0x70800000)) {
        uint32_t *args = (uint32_t*)guest_to_host(r3);
        if (args) return args[arg_idx];
        return 0;
    }

    if (arg_idx == 0) return r3;
    uint32_t *sp_args = (uint32_t*)guest_to_host(sp);
    if (sp_args) return sp_args[arg_idx - 1];
    return 0;
}

static void handle_jni_call(uc_engine *uc, int idx, uint32_t *r0, uint32_t *r1, uint32_t *r2, uint32_t *r3, uint32_t sp, uint32_t lr) {
    switch (idx) {
        case 4: // GetVersion
            *r0 = 0x00010006; // JNI 1.6
            break;

        case 6: // FindClass(env, name)
        case 10: // GetSuperclass
        case 31: // GetObjectClass
        {
            const char *cname = (const char*)guest_to_host(*r1);
            if (idx == 6) {
                DLOG("JNI FindClass: '%s'", cname ? cname : "NULL");
            }
            *r0 = 0x00001111;
            break;
        }

        case 11: // IsAssignableFrom
        case 32: // IsInstanceOf
            *r0 = 1;
            break;

        case 21: // NewGlobalRef
        case 25: // NewLocalRef
            *r0 = *r1;
            break;

        case 22: // DeleteGlobalRef
        case 23: // DeleteLocalRef
            *r0 = 0;
            break;

        case 24: // IsSameObject
            *r0 = (*r1 == *r2) ? 1 : 0;
            break;

        case 27: // AllocObject
        case 28: // NewObject
        case 29: // NewObjectV
        case 30: // NewObjectA
            *r0 = 0x60002000;
            break;

        case 33: // GetMethodID(env, clazz, name, sig)
        case 113: // GetStaticMethodID(env, clazz, name, sig)
        {
            const char *name = (const char*)guest_to_host(*r2);
            const char *sig = (const char*)guest_to_host(*r3);
            int mid = register_jni_method(name, sig);
            DLOG("JNI Get%sMethodID: '%s' ('%s') -> 0x%x", (idx == 113 ? "Static" : ""), name ? name : "NULL", sig ? sig : "NULL", mid);
            *r0 = (uint32_t)mid;
            break;
        }

        case 34: // CallObjectMethod
        case 35: // CallObjectMethodV
        case 36: // CallObjectMethodA
        case 64: // CallNonvirtualObjectMethod
        case 65:
        case 66:
        case 114: // CallStaticObjectMethod
        case 115: // CallStaticObjectMethodV
        case 116: // CallStaticObjectMethodA
        {
            const char *mname = get_jni_method_name(*r2);
            DLOG("JNI CallObjectMethod: mid=0x%x ('%s')", *r2, mname);
            if (strcmp(mname, "resdlStringEvent") == 0) {
                strcpy((char*)(g_host_heap + 0x4000), g_real_files_dir);
                *r0 = 0x60002100; // byte array handle
            } else if (strcmp(mname, "OpenAPKFile") == 0) {
                DLOG("JNI OpenAPKFile: returning NULL (resources exist on disk)");
                *r0 = 0; // return NULL so it falls back to disk fopen!
            } else {
                *r0 = 0x60002000;
            }
            break;
        }

        case 37: // CallBooleanMethod
        case 38: // CallBooleanMethodV
        case 39: // CallBooleanMethodA
        case 67: // CallNonvirtualBooleanMethod
        case 68:
        case 69:
        case 117: // CallStaticBooleanMethod
        case 118: // CallStaticBooleanMethodV
        case 119: // CallStaticBooleanMethodA
        {
            uint32_t mid_val = (idx >= 64 && idx <= 93) ? *r3 : *r2;
            const char *mname = get_jni_method_name(mid_val);
            DLOG("JNI CallBooleanMethod: mid=0x%x ('%s')", mid_val, mname);
            if (strcmp(mname, "InitialiseSoundEngine") == 0) {
                uint32_t use_pcm  = get_jni_method_arg(idx, *r3, sp, 0);
                uint32_t rate     = get_jni_method_arg(idx, *r3, sp, 1);
                uint32_t channels = get_jni_method_arg(idx, *r3, sp, 2);
                uint32_t bits     = get_jni_method_arg(idx, *r3, sp, 3);
                uint32_t bufsz    = get_jni_method_arg(idx, *r3, sp, 4);
                uint32_t period   = get_jni_method_arg(idx, *r3, sp, 5);

                // Sanitize parameters to ensure valid AudioTrack configuration
                if (rate == 0 || rate > 192000) rate = 22050;
                if (channels != 1 && channels != 2) channels = 2;
                if (bits != 8 && bits != 16) bits = 16;
                if (bufsz <= 0 || bufsz > 1024 * 1024) bufsz = 4096;
                if (period <= 0 || period > 1024 * 1024) period = 1024;

                JNIEnv *real_env = get_real_env();
                jboolean ok = JNI_TRUE;
                if (real_env && g_real_callback) {
                    jclass cls = (*real_env)->GetObjectClass(real_env, g_real_callback);
                    jmethodID mid = (*real_env)->GetMethodID(real_env, cls, "InitialiseSoundEngine", "(ZIIIII)Z");
                    if (mid) {
                        ok = (*real_env)->CallBooleanMethod(real_env, g_real_callback, mid,
                                                            (jboolean)(use_pcm ? JNI_TRUE : JNI_FALSE),
                                                            (jint)rate, (jint)channels, (jint)bits, (jint)bufsz, (jint)period);
                        LOGI("Forwarded InitialiseSoundEngine(pcm=%u, rate=%u, ch=%u, bits=%u, buf=%u, per=%u) -> %d",
                             use_pcm, rate, channels, bits, bufsz, period, ok);
                        if (ok) {
                            g_sound_engine_ready = true;
                        }
                    }
                }
                *r0 = ok ? 1 : 0;
            } else if (strcmp(mname, "StartAudioStream") == 0) {
                JNIEnv *real_env = get_real_env();
                jboolean ok = JNI_TRUE;
                if (real_env && g_real_callback) {
                    jclass cls = (*real_env)->GetObjectClass(real_env, g_real_callback);
                    jmethodID mid = (*real_env)->GetMethodID(real_env, cls, "StartAudioStream", "()Z");
                    if (mid) {
                        ok = (*real_env)->CallBooleanMethod(real_env, g_real_callback, mid);
                        LOGI("Forwarded StartAudioStream() -> %d", ok);
                    }
                }
                *r0 = ok ? 1 : 0;
            } else if (strcmp(mname, "StopAudioStream") == 0) {
                JNIEnv *real_env = get_real_env();
                jboolean ok = JNI_TRUE;
                if (real_env && g_real_callback) {
                    jclass cls = (*real_env)->GetObjectClass(real_env, g_real_callback);
                    jmethodID mid = (*real_env)->GetMethodID(real_env, cls, "StopAudioStream", "()Z");
                    if (mid) {
                        ok = (*real_env)->CallBooleanMethod(real_env, g_real_callback, mid);
                        LOGI("Forwarded StopAudioStream() -> %d", ok);
                    }
                }
                *r0 = ok ? 1 : 0;
            } else if (strcmp(mname, "IsPSP") == 0 ||
                       strcmp(mname, "interfaceIsOpen") == 0 ||
                       strcmp(mname, "isVisible") == 0 ||
                       strcmp(mname, "canDisplayInterface") == 0 ||
                       strcmp(mname, "getFeaturedAppQueryState") == 0) {
                *r0 = 0;
            } else {
                *r0 = 1;
            }
            break;
        }

        case 49: // CallIntMethod
        case 50: // CallIntMethodV
        case 51: // CallIntMethodA
        case 79: // CallNonvirtualIntMethod
        case 80:
        case 81:
        case 129: // CallStaticIntMethod
        case 130: // CallStaticIntMethodV
        case 131: // CallStaticIntMethodA
        {
            uint32_t mid_val = (idx >= 64 && idx <= 93) ? *r3 : *r2;
            const char *mname = get_jni_method_name(mid_val);
            DLOG("JNI CallIntMethod: mid=0x%x ('%s')", mid_val, mname);
            if (mid_val == 0x00003000 || mid_val == 12288 || strcmp(mname, "eglGetError") == 0) {
                *r0 = 12288; // 0x3000 = EGL_SUCCESS!
            } else if (mid_val == 0x00003001 || strcmp(mname, "GetDeviceOrientation") == 0) {
                *r0 = 0; // ActivityInfo.SCREEN_ORIENTATION_LANDSCAPE
            } else if (strcmp(mname, "resdlEvent") == 0) {
                *r0 = 1;
            } else if (strcmp(mname, "GetAndroidMinBufferSize") == 0) {
                uint32_t rate     = get_jni_method_arg(idx, *r3, sp, 0);
                uint32_t channels = get_jni_method_arg(idx, *r3, sp, 1);
                uint32_t bits     = get_jni_method_arg(idx, *r3, sp, 2);

                if (rate == 0 || rate > 192000) rate = 22050;
                if (channels != 1 && channels != 2) channels = 2;
                if (bits != 8 && bits != 16) bits = 16;

                JNIEnv *real_env = get_real_env();
                jint min_buf = 4096;
                if (real_env && g_real_callback) {
                    jclass cls = (*real_env)->GetObjectClass(real_env, g_real_callback);
                    jmethodID mid = (*real_env)->GetMethodID(real_env, cls, "GetAndroidMinBufferSize", "(III)I");
                    if (mid) {
                        min_buf = (*real_env)->CallIntMethod(real_env, g_real_callback, mid, (jint)rate, (jint)channels, (jint)bits);
                        LOGI("Forwarded GetAndroidMinBufferSize(%u, %u, %u) -> %d", rate, channels, bits, min_buf);
                    }
                }
                *r0 = (uint32_t)(min_buf > 0 ? min_buf : 4096);
            } else if (strcmp(mname, "mp3Event") == 0) {
                uint32_t event = get_jni_method_arg(idx, *r3, sp, 0);
                uint32_t loop  = get_jni_method_arg(idx, *r3, sp, 1);
                JNIEnv *real_env = get_real_env();
                jint ret = 0;
                if (real_env && g_real_callback) {
                    jclass cls = (*real_env)->GetObjectClass(real_env, g_real_callback);
                    jmethodID mid = (*real_env)->GetMethodID(real_env, cls, "mp3Event", "(IILjava/lang/String;)I");
                    if (mid) {
                        jstring jstr = (*real_env)->NewStringUTF(real_env, g_last_jni_string);
                        ret = (*real_env)->CallIntMethod(real_env, g_real_callback, mid, (jint)event, (jint)loop, jstr);
                        if (jstr) (*real_env)->DeleteLocalRef(real_env, jstr);
                        LOGI("Forwarded mp3Event(event=%u, loop=%u, file='%s') -> %d", event, loop, g_last_jni_string, ret);
                    }
                }
                *r0 = (uint32_t)ret;
            } else {
                *r0 = 0;
            }
            break;
        }

        case 52: // CallLongMethod
        case 53: // CallLongMethodV
        case 54: // CallLongMethodA
        case 82:
        case 83:
        case 84:
        case 132:
        case 133:
        case 134:
        {
            uint32_t mid_val = (idx >= 64 && idx <= 93) ? *r3 : *r2;
            const char *mname = get_jni_method_name(mid_val);
            DLOG("JNI CallLongMethod: mid=0x%x ('%s')", mid_val, mname);
            if (strcmp(mname, "GetDeviceAvailableMemory") == 0) {
                *r0 = 64 * 1024 * 1024;
                *r1 = 0;
            } else {
                *r0 = 0;
                *r1 = 0;
            }
            break;
        }

        case 61: // CallVoidMethod
        case 62: // CallVoidMethodV
        case 63: // CallVoidMethodA
        case 91:
        case 92:
        case 93:
        case 141: // CallStaticVoidMethod
        case 142: // CallStaticVoidMethodV
        case 143: // CallStaticVoidMethodA
        {
            uint32_t mid_val = (idx >= 64 && idx <= 93) ? *r3 : *r2;
            const char *mname = get_jni_method_name(mid_val);
            DLOG("JNI CallVoidMethod: mid=0x%x ('%s')", mid_val, mname);
            if (strcmp(mname, "EnableMultipleTouch") == 0) {
                uint32_t enable = get_jni_method_arg(idx, *r3, sp, 0);
                JNIEnv *real_env = get_real_env();
                if (real_env && g_real_callback) {
                    jclass cls = (*real_env)->GetObjectClass(real_env, g_real_callback);
                    jmethodID mid = (*real_env)->GetMethodID(real_env, cls, "EnableMultipleTouch", "(Z)V");
                    if (mid) {
                        (*real_env)->CallVoidMethod(real_env, g_real_callback, mid, (jboolean)(enable ? JNI_TRUE : JNI_FALSE));
                        LOGI("Forwarded EnableMultipleTouch(%u) to Java", enable);
                    }
                }
            } else if (strcmp(mname, "SetVolume") == 0) {
                uint32_t vol = get_jni_method_arg(idx, *r3, sp, 0);
                JNIEnv *real_env = get_real_env();
                if (real_env && g_real_callback) {
                    jclass cls = (*real_env)->GetObjectClass(real_env, g_real_callback);
                    jmethodID mid = (*real_env)->GetMethodID(real_env, cls, "SetVolume", "(B)V");
                    if (mid) {
                        (*real_env)->CallVoidMethod(real_env, g_real_callback, mid, (jbyte)vol);
                        LOGI("Forwarded SetVolume(%u) to Java", vol);
                    }
                }
            }
            *r0 = 0;
            break;
        }

        case 94: // GetFieldID
        case 144: // GetStaticFieldID
        {
            const char *fname = (const char*)guest_to_host(*r2);
            DLOG("JNI Get%sFieldID: '%s'", (idx == 144 ? "Static" : ""), fname ? fname : "NULL");
            *r0 = 0x00004444;
            break;
        }

        case 95: // GetObjectField
            *r0 = 0x60002000;
            break;

        case 145: // GetStaticObjectField
            // Critical sentinel for EGL_NO_DISPLAY / EGL_NO_SURFACE / EGL_NO_CONTEXT
            *r0 = 0x60002080;
            break;

        case 96: // GetBooleanField
        case 146: // GetStaticBooleanField
            *r0 = 1;
            break;

        case 100: // GetIntField
        case 150: // GetStaticIntField
            *r0 = 0;
            break;

        case 104: // SetObjectField
        case 105: // SetBooleanField
        case 109: // SetIntField
        case 154: // SetStaticObjectField
        case 155: // SetStaticBooleanField
        case 159: // SetStaticIntField
            *r0 = 0;
            break;

        case 163: // NewString(env, unicodeChars, len)
        {
            const uint16_t *uchars = (const uint16_t*)guest_to_host(*r1);
            uint32_t ulen = *r2;
            if (uchars && ulen > 0) {
                if (ulen >= sizeof(g_last_jni_string)) ulen = sizeof(g_last_jni_string) - 1;
                for (uint32_t i = 0; i < ulen; i++) {
                    g_last_jni_string[i] = (char)(uchars[i] & 0x7f);
                }
                g_last_jni_string[ulen] = '\0';
                LOGI("JNI NewString: '%s'", g_last_jni_string);
            } else {
                g_last_jni_string[0] = '\0';
            }
            *r0 = 0x60002000;
            break;
        }

        case 167: // NewStringUTF(env, bytes)
        {
            const char *str = (const char*)guest_to_host(*r1);
            if (str) {
                strncpy(g_last_jni_string, str, sizeof(g_last_jni_string) - 1);
                g_last_jni_string[sizeof(g_last_jni_string) - 1] = '\0';
                LOGI("JNI NewStringUTF: '%s'", g_last_jni_string);
            } else {
                g_last_jni_string[0] = '\0';
            }
            *r0 = 0x60002000;
            break;
        }

        case 164: // GetStringLength
        case 168: // GetStringUTFLength
            *r0 = 0;
            break;

        case 165: // GetStringChars
        case 169: // GetStringUTFChars
        case 224: // GetStringCritical
            *r0 = 0x60003000; // Pointer to empty string
            break;

        case 166: // ReleaseStringChars
        case 170: // ReleaseStringUTFChars
        case 225: // ReleaseStringCritical
            *r0 = 0;
            break;

        case 171: // GetArrayLength
            if (*r1 == 0x60002100) {
                *r0 = (uint32_t)strlen(g_real_files_dir) + 1;
            } else {
                *r0 = 2;
            }
            break;

        case 172: case 173: case 174: case 175: case 176:
        case 177: case 178: case 179: case 180: case 181: case 182:
            *r0 = 0x60002000;
            break;

        case 183: case 184: case 185: case 186: case 187:
        case 188: case 189: case 190:
            if (*r1 == 0x60002100) {
                *r0 = 0x60004000; // contains resource path string
            } else {
                *r0 = 0x60006000;
            }
            break;

        case 191: case 192: case 193: case 194: case 195:
        case 196: case 197: case 198:
            *r0 = 0;
            break;

        case 208: // SetByteArrayRegion
        case 211: // SetIntArrayRegion
            *r0 = 0;
            break;

        case 203: // GetIntArrayRegion(env, array, start, len, buf)
        {
            uint32_t buf_ptr = 0;
            uc_mem_read(uc, sp, &buf_ptr, 4);
            DLOG("JNI GetIntArrayRegion: start=%u, len=%u, buf_ptr=0x%x", *r2, *r3, buf_ptr);
            uint32_t *dst = (uint32_t*)guest_to_host(buf_ptr);
            if (dst) {
                dst[0] = 1; // EGL 1.x
                if (*r3 > 1) dst[1] = 4; // EGL 1.4
            }
            *r0 = 0;
            break;
        }

        case 219: // GetJavaVM(env, JavaVM**)
        {
            uint32_t *dst = (uint32_t*)guest_to_host(*r1);
            if (dst) *dst = 0x60000100;
            *r0 = 0;
            break;
        }

        case 228: // ExceptionCheck
        case 15:  // ExceptionOccurred
            *r0 = 0;
            break;

        case 16:  // ExceptionDescribe
        case 17:  // ExceptionClear
            *r0 = 0;
            break;

        case 229: // NewDirectByteBuffer
            *r0 = 0x60002000;
            break;

        case 230: // GetDirectBufferAddress
            *r0 = 0x60006000;
            break;

        case 231: // GetDirectBufferCapacity
            *r0 = 65536;
            break;

        default:
            DLOG("JNI unhandled index: %d", idx);
            *r0 = 0;
            break;
    }
}

static uint32_t get_guest_vararg(uc_engine *uc, uint32_t *reg_args, int reg_count, uint32_t sp, int *arg_idx) {
    int idx = *arg_idx;
    (*arg_idx)++;
    if (idx < reg_count && reg_args != NULL) {
        return reg_args[idx];
    } else {
        uint32_t val = 0;
        int stack_offset = (reg_args != NULL) ? (idx - reg_count) * 4 : idx * 4;
        uc_mem_read(uc, sp + stack_offset, &val, 4);
        return val;
    }
}

static int safe_guest_snprintf(char *dst, size_t max_len, const char *fmt, uc_engine *uc, uint32_t *reg_args, int reg_count, uint32_t sp) {
    if (!dst || max_len == 0) return 0;
    if (!fmt) { dst[0] = '\0'; return 0; }

    char temp[1024];
    size_t out_len = 0;
    int arg_idx = 0;
    const char *p = fmt;

    while (*p != '\0' && out_len + 1 < sizeof(temp)) {
        if (*p != '%') {
            temp[out_len++] = *p++;
            continue;
        }

        p++; // skip '%'
        if (*p == '%') {
            temp[out_len++] = '%';
            p++;
            continue;
        }

        char spec[32];
        int s_idx = 0;
        spec[s_idx++] = '%';
        while (*p && strchr("0123456789.-+ #lhjzt", *p) && s_idx < 30) {
            spec[s_idx++] = *p++;
        }
        char type = *p ? *p++ : '\0';
        spec[s_idx++] = type;
        spec[s_idx] = '\0';

        char formatted[256];
        formatted[0] = '\0';

        if (type == 's') {
            uint32_t guest_ptr = get_guest_vararg(uc, reg_args, reg_count, sp, &arg_idx);
            const char *str = (const char*)guest_to_host(guest_ptr);
            if (!str) str = "";
            snprintf(formatted, sizeof(formatted), spec, str);
        } else if (type == 'd' || type == 'i') {
            uint32_t val = get_guest_vararg(uc, reg_args, reg_count, sp, &arg_idx);
            snprintf(formatted, sizeof(formatted), spec, (int32_t)val);
        } else if (type == 'u' || type == 'x' || type == 'X' || type == 'p') {
            uint32_t val = get_guest_vararg(uc, reg_args, reg_count, sp, &arg_idx);
            snprintf(formatted, sizeof(formatted), spec, val);
        } else if (type == 'c') {
            uint32_t val = get_guest_vararg(uc, reg_args, reg_count, sp, &arg_idx);
            snprintf(formatted, sizeof(formatted), spec, (char)val);
        } else if (type == 'f' || type == 'g' || type == 'e') {
            if (arg_idx & 1) arg_idx++;
            uint32_t lo = get_guest_vararg(uc, reg_args, reg_count, sp, &arg_idx);
            uint32_t hi = get_guest_vararg(uc, reg_args, reg_count, sp, &arg_idx);
            uint64_t dval = ((uint64_t)hi << 32) | lo;
            double d;
            memcpy(&d, &dval, 8);
            snprintf(formatted, sizeof(formatted), spec, d);
        } else {
            snprintf(formatted, sizeof(formatted), "%s", spec);
        }

        size_t flen = strlen(formatted);
        if (out_len + flen < sizeof(temp)) {
            memcpy(temp + out_len, formatted, flen);
            out_len += flen;
        } else {
            size_t avail = sizeof(temp) - 1 - out_len;
            memcpy(temp + out_len, formatted, avail);
            out_len += avail;
            break;
        }
    }

    temp[out_len] = '\0';
    if (out_len >= max_len) {
        memcpy(dst, temp, max_len - 1);
        dst[max_len - 1] = '\0';
    } else {
        memcpy(dst, temp, out_len + 1);
    }
    return (int)out_len;
}

#include "bridge_hle_patch.h"

static void hook_intr_cb(uc_engine *uc, uint32_t intno, void *user_data) {
    uint32_t pc, lr, r0, r1, r2, r3, sp;
    uc_reg_read(uc, UC_ARM_REG_PC, &pc);
    uc_reg_read(uc, UC_ARM_REG_LR, &lr);
    uc_reg_read(uc, UC_ARM_REG_R0, &r0);
    uc_reg_read(uc, UC_ARM_REG_R1, &r1);
    uc_reg_read(uc, UC_ARM_REG_R2, &r2);
    uc_reg_read(uc, UC_ARM_REG_R3, &r3);
    uc_reg_read(uc, UC_ARM_REG_SP, &sp);

    // Check if interrupt is in JavaVM stubs range [0x8000b000, 0x8000b000 + 16 * 8)
    if (pc >= 0x8000b000 && pc < 0x8000b000 + 16 * 8) {
        int vm_idx = (pc - 4 - 0x8000b000) / 8;
        handle_jvm_call(uc, vm_idx, &r0, &r1, &r2, &r3, sp, lr);
        uc_reg_write(uc, UC_ARM_REG_R0, &r0);
        uc_reg_write(uc, UC_ARM_REG_R1, &r1);
        uc_reg_write(uc, UC_ARM_REG_PC, &lr);
        return;
    }

    // Check if interrupt is in JNIEnv stubs range [0x8000c000, 0x8000c000 + 256 * 8)
    if (pc >= 0x8000c000 && pc < 0x8000c000 + 256 * 8) {
        int jni_idx = (pc - 4 - 0x8000c000) / 8;
        handle_jni_call(uc, jni_idx, &r0, &r1, &r2, &r3, sp, lr);
        uc_reg_write(uc, UC_ARM_REG_R0, &r0);
        uc_reg_write(uc, UC_ARM_REG_R1, &r1);
        uc_reg_write(uc, UC_ARM_REG_PC, &lr);
        return;
    }

    if (pc < 0x80000000 || pc >= 0x80000000 + 178 * 8) return;
    int idx = (pc - 4 - 0x80000000) / 8;
    if (idx < 0 || idx >= 178) return;

    hle_fn fn = g_hle[idx];
    if (fn) {
        hle_t c = { .uc = uc, .r0 = r0, .r1 = r1, .r2 = r2, .r3 = r3, .sp = sp, .lr = lr, .pc = pc };
        fn(&c);
        uc_reg_write(uc, UC_ARM_REG_R0, &c.r0);
        if (c.set_r1) uc_reg_write(uc, UC_ARM_REG_R1, &c.out_r1);
        uc_reg_write(uc, UC_ARM_REG_PC, &lr);
        return;
    }

    const char* name = g_plt_names[idx];

    if (strcmp(name, "malloc") == 0) {
        r0 = guest_alloc(r0);
    } else if (strcmp(name, "calloc") == 0) {
        uint32_t sz = r0 * r1;
        r0 = guest_alloc(sz);
        void *p = guest_to_host(r0);
        if (p) memset(p, 0, sz);
    } else if (strcmp(name, "realloc") == 0) {
        uint32_t old_ptr = r0, sz = r1;
        uint32_t oldcap = guest_cap(old_ptr);
        if (old_ptr != 0 && sz == 0) { guest_free(old_ptr); r0 = 0; }
        else if (old_ptr != 0 && oldcap >= sz) { r0 = old_ptr; }
        else {
            uint32_t np = guest_alloc(sz);
            if (old_ptr != 0 && np) {
                void *src = guest_to_host(old_ptr);
                void *dst = guest_to_host(np);
                uint32_t n = oldcap ? oldcap : sz;
                if (n > sz) n = sz;
                if (src && dst) memcpy(dst, src, n);
                guest_free(old_ptr);
            }
            r0 = np;
        }
    } else if (strcmp(name, "free") == 0) {
        guest_free(r0);
        r0 = 0;
    } else if (strcmp(name, "memcpy") == 0 || strcmp(name, "memmove") == 0) {
        void *dst = guest_to_host(r0);
        void *src = guest_to_host(r1);
        if (dst && src && r2 > 0) memmove(dst, src, r2);
    } else if (strcmp(name, "memset") == 0) {
        void *dst = guest_to_host(r0);
        if (dst && r2 > 0) memset(dst, (uint8_t)r1, r2);
    } else if (strcmp(name, "memcmp") == 0) {
        void *b1 = guest_to_host(r0);
        void *b2 = guest_to_host(r1);
        r0 = (b1 && b2 && r2 > 0) ? (uint32_t)memcmp(b1, b2, r2) : 0;
    } else if (strcmp(name, "memchr") == 0) {
        void *src = guest_to_host(r0);
        void *p = (src && r2 > 0) ? memchr(src, r1, r2) : NULL;
        r0 = p ? (r0 + (uint32_t)((uint8_t*)p - (uint8_t*)src)) : 0;
    } else if (strcmp(name, "strlen") == 0) {
        const char *s = (const char*)guest_to_host(r0);
        r0 = s ? (uint32_t)strlen(s) : 0;
    } else if (strcmp(name, "strcmp") == 0) {
        const char *s1 = (const char*)guest_to_host(r0);
        const char *s2 = (const char*)guest_to_host(r1);
        r0 = (s1 && s2) ? (uint32_t)strcmp(s1, s2) : 0;
    } else if (strcmp(name, "strncmp") == 0) {
        const char *s1 = (const char*)guest_to_host(r0);
        const char *s2 = (const char*)guest_to_host(r1);
        r0 = (s1 && s2) ? (uint32_t)strncmp(s1, s2, r2) : 0;
    } else if (strcmp(name, "strcasecmp") == 0) {
        const char *s1 = (const char*)guest_to_host(r0);
        const char *s2 = (const char*)guest_to_host(r1);
        r0 = (s1 && s2) ? (uint32_t)strcasecmp(s1, s2) : 0;
    } else if (strcmp(name, "strncasecmp") == 0) {
        const char *s1 = (const char*)guest_to_host(r0);
        const char *s2 = (const char*)guest_to_host(r1);
        r0 = (s1 && s2) ? (uint32_t)strncasecmp(s1, s2, r2) : 0;
    } else if (strcmp(name, "strcpy") == 0) {
        char *dst = (char*)guest_to_host(r0);
        const char *src = (const char*)guest_to_host(r1);
        if (dst && src) strcpy(dst, src);
    } else if (strcmp(name, "strncpy") == 0) {
        char *dst = (char*)guest_to_host(r0);
        const char *src = (const char*)guest_to_host(r1);
        if (dst && src) strncpy(dst, src, r2);
    } else if (strcmp(name, "strcat") == 0) {
        char *dst = (char*)guest_to_host(r0);
        const char *src = (const char*)guest_to_host(r1);
        if (dst && src) strcat(dst, src);
    } else if (strcmp(name, "strncat") == 0) {
        char *dst = (char*)guest_to_host(r0);
        const char *src = (const char*)guest_to_host(r1);
        if (dst && src) strncat(dst, src, r2);
    } else if (strcmp(name, "strchr") == 0) {
        const char *s = (const char*)guest_to_host(r0);
        char *p = s ? strchr(s, r1) : NULL;
        r0 = p ? (r0 + (uint32_t)(p - s)) : 0;
    } else if (strcmp(name, "strrchr") == 0) {
        const char *s = (const char*)guest_to_host(r0);
        char *p = s ? strrchr(s, r1) : NULL;
        r0 = p ? (r0 + (uint32_t)(p - s)) : 0;
    } else if (strcmp(name, "strstr") == 0) {
        const char *s1 = (const char*)guest_to_host(r0);
        const char *s2 = (const char*)guest_to_host(r1);
        char *p = (s1 && s2) ? strstr(s1, s2) : NULL;
        r0 = p ? (r0 + (uint32_t)(p - s1)) : 0;
    } else if (strcmp(name, "strdup") == 0) {
        const char *s = (const char*)guest_to_host(r0);
        if (s) {
            uint32_t len = (uint32_t)strlen(s) + 1;
            r0 = guest_alloc(len);
            char *dst = (char*)guest_to_host(r0);
            if (dst) memcpy(dst, s, len);
        } else {
            r0 = 0;
        }
    } else if (strcmp(name, "strspn") == 0) {
        const char *s1 = (const char*)guest_to_host(r0);
        const char *s2 = (const char*)guest_to_host(r1);
        r0 = (s1 && s2) ? (uint32_t)strspn(s1, s2) : 0;
    } else if (strcmp(name, "strcspn") == 0) {
        const char *s1 = (const char*)guest_to_host(r0);
        const char *s2 = (const char*)guest_to_host(r1);
        r0 = (s1 && s2) ? (uint32_t)strcspn(s1, s2) : 0;
    } else if (strcmp(name, "wcslen") == 0) {
        const uint16_t *ws = (const uint16_t*)guest_to_host(r0);
        uint32_t cnt = 0;
        if (ws) { while (*ws++) cnt++; }
        r0 = cnt;
    } else if (strcmp(name, "sprintf") == 0) {
        char *dst = (char*)guest_to_host(r0);
        const char *fmt = (const char*)guest_to_host(r1);
        uint32_t args[2] = { r2, r3 };
        r0 = safe_guest_snprintf(dst, 1024, fmt, uc, args, 2, sp);
        DLOG("PLT sprintf: fmt='%s' -> '%s'", fmt ? fmt : "NULL", dst ? dst : "NULL");
    } else if (strcmp(name, "snprintf") == 0) {
        char *dst = (char*)guest_to_host(r0);
        uint32_t max_len = r1;
        const char *fmt = (const char*)guest_to_host(r2);
        uint32_t args[1] = { r3 };
        r0 = safe_guest_snprintf(dst, max_len, fmt, uc, args, 1, sp);
        DLOG("PLT snprintf: fmt='%s' -> '%s'", fmt ? fmt : "NULL", dst ? dst : "NULL");
    } else if (strcmp(name, "vsprintf") == 0 || strcmp(name, "vsnprintf") == 0) {
        char *dst = (char*)guest_to_host(r0);
        const char *fmt;
        uint32_t max_len = 1024;
        uint32_t va_ptr;
        if (strcmp(name, "vsnprintf") == 0) {
            max_len = r1;
            fmt = (const char*)guest_to_host(r2);
            va_ptr = r3;
        } else {
            fmt = (const char*)guest_to_host(r1);
            va_ptr = r2;
        }
        r0 = safe_guest_snprintf(dst, max_len, fmt, uc, NULL, 0, va_ptr);
        DLOG("PLT %s: fmt='%s' -> '%s'", name, fmt ? fmt : "NULL", dst ? dst : "NULL");
    } else if (strcmp(name, "sscanf") == 0) {
        const char *str = (const char*)guest_to_host(r0);
        const char *fmt = (const char*)guest_to_host(r1);
        void *p1 = guest_to_host(r2);
        void *p2 = guest_to_host(r3);
        r0 = (str && fmt) ? (uint32_t)sscanf(str, fmt, p1, p2) : 0;
    } else if (strcmp(name, "atoi") == 0) {
        const char *s = (const char*)guest_to_host(r0);
        r0 = s ? (uint32_t)atoi(s) : 0;
    } else if (strcmp(name, "atoll") == 0) {
        const char *s = (const char*)guest_to_host(r0);
        r0 = s ? (uint32_t)atoll(s) : 0;
    } else if (strcmp(name, "strtod") == 0) {
        const char *s = (const char*)guest_to_host(r0);
        double d = s ? strtod(s, NULL) : 0.0;
        float f = (float)d;
        memcpy(&r0, &f, 4);
    } else if (strcmp(name, "clock") == 0) {
        r0 = (uint32_t)clock();
    } else if (strcmp(name, "time") == 0) {
        time_t t = time(NULL);
        r0 = (uint32_t)t;
    } else if (strcmp(name, "gettimeofday") == 0) {
        struct timeval tv;
        gettimeofday(&tv, NULL);
        if (r0 != 0) {
            uint32_t tv32[2] = { (uint32_t)tv.tv_sec, (uint32_t)tv.tv_usec };
            void *dst = guest_to_host(r0);
            if (dst) memcpy(dst, tv32, 8);
        }
        r0 = 0;
    } else if (strcmp(name, "clock_gettime") == 0) {
        struct timespec ts;
        clock_gettime((clockid_t)r0, &ts);
        if (r1 != 0) {
            uint32_t ts32[2] = { (uint32_t)ts.tv_sec, (uint32_t)ts.tv_nsec };
            void *dst = guest_to_host(r1);
            if (dst) memcpy(dst, ts32, 8);
        }
        r0 = 0;
    } else if (strcmp(name, "sinf") == 0) {
        float f; memcpy(&f, &r0, 4); f = sinf(f); memcpy(&r0, &f, 4);
    } else if (strcmp(name, "cosf") == 0) {
        float f; memcpy(&f, &r0, 4); f = cosf(f); memcpy(&r0, &f, 4);
    } else if (strcmp(name, "sqrtf") == 0) {
        float f; memcpy(&f, &r0, 4); f = sqrtf(f); memcpy(&r0, &f, 4);
    } else if (strcmp(name, "atan2f") == 0) {
        float y, x; memcpy(&y, &r0, 4); memcpy(&x, &r1, 4); float res = atan2f(y, x); memcpy(&r0, &res, 4);
    } else if (strcmp(name, "atanf") == 0) {
        float f; memcpy(&f, &r0, 4); f = atanf(f); memcpy(&r0, &f, 4);
    } else if (strcmp(name, "asinf") == 0) {
        float f; memcpy(&f, &r0, 4); f = asinf(f); memcpy(&r0, &f, 4);
    } else if (strcmp(name, "acosf") == 0) {
        float f; memcpy(&f, &r0, 4); f = acosf(f); memcpy(&r0, &f, 4);
    } else if (strcmp(name, "floorf") == 0) {
        float f; memcpy(&f, &r0, 4); f = floorf(f); memcpy(&r0, &f, 4);
    } else if (strcmp(name, "ceilf") == 0) {
        float f; memcpy(&f, &r0, 4); f = ceilf(f); memcpy(&r0, &f, 4);
    } else if (strcmp(name, "modff") == 0) {
        float f, i; memcpy(&f, &r0, 4);
        float frac = modff(f, &i);
        void *iptr = guest_to_host(r1);
        if (iptr) memcpy(iptr, &i, 4);
        memcpy(&r0, &frac, 4);
    } else if (strncmp(name, "pthread_mutex_", 14) == 0) {
        r0 = 0;
    } else if (strcmp(name, "__cxa_guard_acquire") == 0) {
        uint32_t *guard = (uint32_t*)guest_to_host(r0);
        r0 = (guard && *guard == 0) ? 1 : 0;
    } else if (strcmp(name, "__cxa_guard_release") == 0) {
        uint32_t *guard = (uint32_t*)guest_to_host(r0);
        if (guard) *guard = 1;
        r0 = 0;
    } else if (strcmp(name, "__cxa_atexit") == 0 || strcmp(name, "atexit") == 0 || strcmp(name, "__cxa_finalize") == 0) {
        r0 = 0;
    } else if (strcmp(name, "__errno") == 0) {
        r0 = 0x60007020;
    } else if (strcmp(name, "srand48") == 0) {
        srand48(r0);
        r0 = 0;
    } else if (strcmp(name, "lrand48") == 0) {
        r0 = (uint32_t)lrand48();
    } else if (strcmp(name, "fopen") == 0) {
        const char *path = (const char*)guest_to_host(r0);
        const char *mode = (const char*)guest_to_host(r1);
        char norm_path[512];
        const char *target_path = normalize_game_path(path, norm_path, sizeof(norm_path));
        DLOG("PLT fopen: '%s' (target: '%s', mode: '%s')", path ? path : "NULL", target_path ? target_path : "NULL", mode ? mode : "NULL");
        FILE *fp = (target_path && mode) ? fopen(target_path, mode) : NULL;
        if (fp == NULL && path != target_path && path && mode) {
            fp = fopen(path, mode);
        }
        if (fp != NULL) {
            int slot = 0;
            for (int i = 1; i < MAX_OPEN_FILES; i++) {
                if (g_file_table[i] == NULL) {
                    slot = i;
                    g_file_table[i] = fp;
                    break;
                }
            }
            DLOG("PLT fopen SUCCESS: slot=%d for '%s'", slot, target_path);
            r0 = slot;
        } else {
            DLOG("PLT fopen FAILED: '%s' (errno=%d: %s)", target_path ? target_path : "NULL", errno, strerror(errno));
            r0 = 0;
        }
    } else if (strcmp(name, "fclose") == 0) {
        if (r0 > 0 && r0 < MAX_OPEN_FILES && g_file_table[r0] != NULL) {
            fclose(g_file_table[r0]);
            g_file_table[r0] = NULL;
        }
        r0 = 0;
    } else if (strcmp(name, "fread") == 0) {
        uint32_t dst_addr = r0, sz = r1, count = r2, slot = r3;
        void *dst = guest_to_host(dst_addr);
        if (slot > 0 && slot < MAX_OPEN_FILES && g_file_table[slot] != NULL && dst) {
            r0 = (uint32_t)fread(dst, sz, count, g_file_table[slot]);
        } else {
            r0 = 0;
        }
    } else if (strcmp(name, "fwrite") == 0) {
        uint32_t src_addr = r0, sz = r1, count = r2, slot = r3;
        void *src = guest_to_host(src_addr);
        if (slot > 0 && slot < MAX_OPEN_FILES && g_file_table[slot] != NULL && src) {
            r0 = (uint32_t)fwrite(src, sz, count, g_file_table[slot]);
        } else {
            r0 = 0;
        }
    } else if (strcmp(name, "fseek") == 0) {
        if (r0 > 0 && r0 < MAX_OPEN_FILES && g_file_table[r0] != NULL) {
            r0 = fseek(g_file_table[r0], (long)r1, (int)r2);
        } else {
            r0 = -1;
        }
    } else if (strcmp(name, "ftell") == 0) {
        if (r0 > 0 && r0 < MAX_OPEN_FILES && g_file_table[r0] != NULL) {
            r0 = (uint32_t)ftell(g_file_table[r0]);
        } else {
            r0 = 0;
        }
    } else if (strcmp(name, "rewind") == 0) {
        if (r0 > 0 && r0 < MAX_OPEN_FILES && g_file_table[r0] != NULL) {
            rewind(g_file_table[r0]);
        }
        r0 = 0;
    } else if (strcmp(name, "stat") == 0) {
        const char *path = (const char*)guest_to_host(r0);
        char norm_path[512];
        const char *target_path = normalize_game_path(path, norm_path, sizeof(norm_path));
        struct stat st;
        int res = target_path ? stat(target_path, &st) : -1;
        if (res != 0 && path != target_path && path) {
            res = stat(path, &st);
        }
        if (res == 0 && r1 != 0) {
            uint8_t *st32 = (uint8_t*)guest_to_host(r1);
            if (st32) {
                memset(st32, 0, 128);
                *(uint32_t*)(st32 + 16) = st.st_mode;
                *(uint32_t*)(st32 + 44) = (uint32_t)st.st_size;
                *(uint32_t*)(st32 + 48) = (uint32_t)(st.st_size >> 32);
            }
            r0 = 0;
        } else {
            r0 = -1;
        }
    } else if (strcmp(name, "mkdir") == 0) {
        const char *p = (const char*)guest_to_host(r0);
        r0 = p ? mkdir(p, (mode_t)r1) : -1;
    } else if (strcmp(name, "rmdir") == 0) {
        const char *p = (const char*)guest_to_host(r0);
        r0 = p ? rmdir(p) : -1;
    } else if (strcmp(name, "remove") == 0) {
        const char *p = (const char*)guest_to_host(r0);
        char norm_p[512];
        const char *target_p = normalize_game_path(p, norm_p, sizeof(norm_p));
        DLOG("PLT remove: '%s' (target: '%s')", p ? p : "NULL", target_p ? target_p : "NULL");
        r0 = target_p ? remove(target_p) : -1;
    } else if (strcmp(name, "rename") == 0) {
        const char *p1 = (const char*)guest_to_host(r0);
        const char *p2 = (const char*)guest_to_host(r1);
        char norm_p1[512], norm_p2[512];
        const char *target_p1 = normalize_game_path(p1, norm_p1, sizeof(norm_p1));
        const char *target_p2 = normalize_game_path(p2, norm_p2, sizeof(norm_p2));
        DLOG("PLT rename: '%s' -> '%s' to '%s' -> '%s'", p1 ? p1 : "NULL", target_p1 ? target_p1 : "NULL", p2 ? p2 : "NULL", target_p2 ? target_p2 : "NULL");
        r0 = (target_p1 && target_p2) ? rename(target_p1, target_p2) : -1;
    } else if (strcmp(name, "socket") == 0) {
        int sock = socket(r0, r1, r2);
        DLOG("PLT socket(%d, %d, %d) = %d", r0, r1, r2, sock);
        r0 = sock >= 0 ? sock : -1;
    } else if (strcmp(name, "bind") == 0) {
        void *addr = guest_to_host(r1);
        r0 = addr ? bind(r0, (struct sockaddr*)addr, (socklen_t)r2) : -1;
    } else if (strcmp(name, "connect") == 0) {
        void *addr = guest_to_host(r1);
        r0 = addr ? connect(r0, (struct sockaddr*)addr, (socklen_t)r2) : -1;
    } else if (strcmp(name, "send") == 0) {
        void *buf = guest_to_host(r1);
        r0 = buf ? (uint32_t)send(r0, buf, r2, r3) : -1;
    } else if (strcmp(name, "recv") == 0) {
        void *buf = guest_to_host(r1);
        r0 = buf ? (uint32_t)recv(r0, buf, r2, r3) : -1;
    } else if (strcmp(name, "sendto") == 0) {
        uint32_t sp_args[2];
        uc_mem_read(uc, sp, sp_args, sizeof(sp_args));
        void *buf = guest_to_host(r1);
        void *to = guest_to_host(sp_args[0]);
        r0 = (buf && to) ? (uint32_t)sendto(r0, buf, r2, r3, (struct sockaddr*)to, (socklen_t)sp_args[1]) : -1;
    } else if (strcmp(name, "recvfrom") == 0) {
        uint32_t sp_args[2];
        uc_mem_read(uc, sp, sp_args, sizeof(sp_args));
        void *buf = guest_to_host(r1);
        void *from = guest_to_host(sp_args[0]);
        void *fromlen = guest_to_host(sp_args[1]);
        r0 = (buf) ? (uint32_t)recvfrom(r0, buf, r2, r3, (struct sockaddr*)from, (socklen_t*)fromlen) : -1;
    } else if (strcmp(name, "setsockopt") == 0) {
        uint32_t optlen = 0;
        uc_mem_read(uc, sp, &optlen, 4);
        void *optval = guest_to_host(r3);
        r0 = optval ? setsockopt(r0, r1, r2, optval, (socklen_t)optlen) : -1;
    } else if (strcmp(name, "getsockopt") == 0) {
        uint32_t optlen_ptr = 0;
        uc_mem_read(uc, sp, &optlen_ptr, 4);
        void *optval = guest_to_host(r3);
        void *optlen = guest_to_host(optlen_ptr);
        r0 = (optval && optlen) ? getsockopt(r0, r1, r2, optval, (socklen_t*)optlen) : -1;
    } else if (strcmp(name, "getsockname") == 0) {
        void *addr = guest_to_host(r1);
        void *addrlen = guest_to_host(r2);
        r0 = (addr && addrlen) ? getsockname(r0, (struct sockaddr*)addr, (socklen_t*)addrlen) : -1;
    } else if (strcmp(name, "gethostbyname") == 0) {
        const char *host = (const char*)guest_to_host(r0);
        DLOG("PLT gethostbyname('%s')", host ? host : "NULL");
        if (host && strstr(host, "glu.com") != NULL) {
            LOGI("Intercepted dead Glu endpoint: %s (returning NULL)", host);
            r0 = 0;
        } else if (host) {
            struct hostent *he = gethostbyname(host);
            if (he != NULL) {
                uint32_t he_addr = 0x60008000;
                uint32_t addr_list_ptr = 0x60008100;
                uint32_t ip_ptr = 0x60008120;
                if (he->h_addr_list && he->h_addr_list[0]) {
                    memcpy(guest_to_host(ip_ptr), he->h_addr_list[0], 4);
                    uint32_t list[2] = { ip_ptr, 0 };
                    memcpy(guest_to_host(addr_list_ptr), list, 8);
                }
                uint32_t hostent_data[5] = { 0, 0, (uint32_t)he->h_addrtype, (uint32_t)he->h_length, addr_list_ptr };
                memcpy(guest_to_host(he_addr), hostent_data, sizeof(hostent_data));
                r0 = he_addr;
            } else {
                r0 = 0;
            }
        } else {
            r0 = 0;
        }
    } else if (strcmp(name, "inet_addr") == 0) {
        const char *cp = (const char*)guest_to_host(r0);
        r0 = cp ? inet_addr(cp) : INADDR_NONE;
    } else if (strcmp(name, "inet_ntoa") == 0) {
        struct in_addr in; in.s_addr = r0;
        char *s = inet_ntoa(in);
        if (s) {
            uint32_t len = (uint32_t)strlen(s) + 1;
            r0 = guest_alloc(len);
            char *dst = (char*)guest_to_host(r0);
            if (dst) memcpy(dst, s, len);
        } else {
            r0 = 0;
        }
    } else if (strcmp(name, "gethostname") == 0) {
        char *name_buf = (char*)guest_to_host(r0);
        r0 = name_buf ? gethostname(name_buf, r1) : -1;
    } else if (strcmp(name, "shutdown") == 0) {
        r0 = shutdown(r0, r1);
    } else if (strcmp(name, "close") == 0) {
        "close", h_ret0
    } else if (strcmp(name, "__android_log_print") == 0 || strcmp(name, "__android_log_assert") == 0) {
        const char *tag = (const char*)guest_to_host(r1);
        const char *fmt = (const char*)guest_to_host(r2);
        if (fmt && strcmp(fmt, "%s") == 0 && r3) {
            const char *msg = (const char*)guest_to_host(r3);
            LOGI("[GunBrosLib][%s] %s", tag ? tag : "LOG", msg ? msg : "NULL");
        } else {
            LOGI("[GunBrosLib][%s] %s", tag ? tag : "LOG", fmt ? fmt : "EMPTY");
        }
        r0 = 0;
    } else if (strcmp(name, "__android_log_vprint") == 0) {
        const char *tag = (const char*)guest_to_host(r1);
        const char *fmt = (const char*)guest_to_host(r2);
        if (fmt && strcmp(fmt, "%s") == 0 && r3) {
            uint32_t *ap = (uint32_t*)guest_to_host(r3);
            const char *msg = ap ? (const char*)guest_to_host(*ap) : NULL;
            LOGI("[GunBrosLib][%s] %s", tag ? tag : "LOG", msg ? msg : "NULL");
        } else {
            LOGI("[GunBrosLib][%s] %s", tag ? tag : "LOG", fmt ? fmt : "EMPTY");
        }
        r0 = 0;
    } else if (strcmp(name, "glEnable") == 0) {
        glEnable(r0);
    } else if (strcmp(name, "glDisable") == 0) {
        glDisable(r0);
    } else if (strcmp(name, "glClear") == 0) {
        glClear(r0);
    } else if (strcmp(name, "glClearColor") == 0) {
        float red, green, blue, alpha;
        memcpy(&red, &r0, 4); memcpy(&green, &r1, 4); memcpy(&blue, &r2, 4); memcpy(&alpha, &r3, 4);
        glClearColor(red, green, blue, alpha);
    } else if (strcmp(name, "glViewport") == 0) {
        glViewport(r0, r1, r2, r3);
    } else if (strcmp(name, "glMatrixMode") == 0) {
        glMatrixMode(r0);
    } else if (strcmp(name, "glLoadIdentity") == 0) {
        glLoadIdentity();
    } else if (strcmp(name, "glBindTexture") == 0) {
        glBindTexture(r0, r1);
    } else if (strcmp(name, "glGenTextures") == 0) {
        void *p = guest_to_host(r1);
        if (p) glGenTextures(r0, (GLuint*)p);
    } else if (strcmp(name, "glDeleteTextures") == 0) {
        void *p = guest_to_host(r1);
        if (p) glDeleteTextures(r0, (const GLuint*)p);
    } else if (strcmp(name, "glTexParameteri") == 0) {
        glTexParameteri(r0, r1, r2);
    } else if (strcmp(name, "glDrawArrays") == 0) {
        glDrawArrays(r0, r1, r2);
    } else if (strcmp(name, "glEnableClientState") == 0) {
        glEnableClientState(r0);
    } else if (strcmp(name, "glDisableClientState") == 0) {
        glDisableClientState(r0);
    } else if (strcmp(name, "glVertexPointer") == 0) {
        void *p = guest_to_host(r3);
        glVertexPointer(r0, r1, r2, p);
    } else if (strcmp(name, "glTexCoordPointer") == 0) {
        void *p = guest_to_host(r3);
        glTexCoordPointer(r0, r1, r2, p);
    } else if (strcmp(name, "glColorPointer") == 0) {
        void *p = guest_to_host(r3);
        glColorPointer(r0, r1, r2, p);
    } else if (strcmp(name, "glDrawElements") == 0) {
        void *p = guest_to_host(r3);
        glDrawElements(r0, r1, r2, p);
    } else if (strcmp(name, "glLoadMatrixf") == 0) {
        void *p = guest_to_host(r0);
        if (p) glLoadMatrixf((const GLfloat*)p);
    } else if (strcmp(name, "glBlendFunc") == 0) {
        glBlendFunc(r0, r1);
    } else if (strcmp(name, "glCullFace") == 0) {
        glCullFace(r0);
    } else if (strcmp(name, "glDepthFunc") == 0) {
        glDepthFunc(r0);
    } else if (strcmp(name, "glDepthMask") == 0) {
        glDepthMask(r0);
    } else if (strcmp(name, "glDepthRangef") == 0) {
        float zn, zf; memcpy(&zn, &r0, 4); memcpy(&zf, &r1, 4); glDepthRangef(zn, zf);
    } else if (strcmp(name, "glDepthRangex") == 0) {
        glDepthRangex(r0, r1);
    } else if (strcmp(name, "glClearDepthf") == 0) {
        float d; memcpy(&d, &r0, 4); glClearDepthf(d);
    } else if (strcmp(name, "glScissor") == 0) {
        glScissor(r0, r1, r2, r3);
    } else if (strcmp(name, "glShadeModel") == 0) {
        glShadeModel(r0);
    } else if (strcmp(name, "glAlphaFunc") == 0) {
        float ref; memcpy(&ref, &r1, 4); glAlphaFunc(r0, ref);
    } else if (strcmp(name, "glAlphaFuncx") == 0) {
        glAlphaFuncx(r0, r1);
    } else if (strcmp(name, "glColor4f") == 0) {
        float r, g, b, a; memcpy(&r, &r0, 4); memcpy(&g, &r1, 4); memcpy(&b, &r2, 4); memcpy(&a, &r3, 4);
        glColor4f(r, g, b, a);
    } else if (strcmp(name, "glColor4x") == 0) {
        glColor4x(r0, r1, r2, r3);
    } else if (strcmp(name, "glColorMask") == 0) {
        glColorMask(r0, r1, r2, r3);
    } else if (strcmp(name, "glScalex") == 0) {
        glScalex(r0, r1, r2);
    } else if (strcmp(name, "glTexEnvx") == 0) {
        glTexEnvx(r0, r1, r2);
    } else if (strcmp(name, "glActiveTexture") == 0) {
        glActiveTexture(r0);
    } else if (strcmp(name, "glClientActiveTexture") == 0) {
        glClientActiveTexture(r0);
    } else if (strcmp(name, "glFrontFace") == 0) {
        glFrontFace(r0);
    } else if (strcmp(name, "glHint") == 0) {
        glHint(r0, r1);
    } else if (strcmp(name, "glPixelStorei") == 0) {
        glPixelStorei(r0, r1);
    } else if (strcmp(name, "glPolygonOffset") == 0) {
        float factor, units; memcpy(&factor, &r0, 4); memcpy(&units, &r1, 4); glPolygonOffset(factor, units);
    } else if (strcmp(name, "glClearStencil") == 0) {
        glClearStencil(r0);
    } else if (strcmp(name, "glStencilMask") == 0) {
        glStencilMask(r0);
    } else if (strcmp(name, "glGetIntegerv") == 0) {
        void *p = guest_to_host(r1);
        if (p) glGetIntegerv(r0, (GLint*)p);
    } else if (strcmp(name, "glGetError") == 0) {
        r0 = glGetError();
    } else if (strcmp(name, "glGetString") == 0) {
        const GLubyte *str = glGetString(r0);
        if (str) {
            uint32_t len = (uint32_t)strlen((const char*)str) + 1;
            r0 = guest_alloc(len);
            char *dst = (char*)guest_to_host(r0);
            if (dst) memcpy(dst, str, len);
        } else {
            r0 = 0;
        }
    } else if (strcmp(name, "glBindBuffer") == 0) {
        glBindBuffer(r0, r1);
    } else if (strcmp(name, "glTexImage2D") == 0) {
        uint32_t sp_args[5];
        uc_mem_read(uc, sp, sp_args, sizeof(sp_args));
        void *pixels = guest_to_host(sp_args[4]);
        glTexImage2D(r0, r1, r2, r3, sp_args[0], sp_args[1], sp_args[2], sp_args[3], pixels);
    } else if (strcmp(name, "glCompressedTexImage2D") == 0) {
        uint32_t sp_args[4];
        uc_mem_read(uc, sp, sp_args, sizeof(sp_args));
        void *data = guest_to_host(sp_args[3]);
        glCompressedTexImage2D(r0, r1, r2, r3, sp_args[0], sp_args[1], sp_args[2], data);
    } else if (strcmp(name, "glCopyTexImage2D") == 0) {
        uint32_t sp_args[4];
        uc_mem_read(uc, sp, sp_args, sizeof(sp_args));
        glCopyTexImage2D(r0, r1, r2, r3, sp_args[0], sp_args[1], sp_args[2], sp_args[3]);
    } else if (strcmp(name, "glReadPixels") == 0) {
        uint32_t sp_args[3];
        uc_mem_read(uc, sp, sp_args, sizeof(sp_args));
        void *pixels = guest_to_host(sp_args[2]);
        glReadPixels(r0, r1, r2, r3, sp_args[0], sp_args[1], pixels);
    } else if (strcmp(name, "glGenRenderbuffersOES") == 0) {
        void *p = guest_to_host(r1);
        if (p) glGenRenderbuffersOES(r0, (GLuint*)p);
    } else if (strcmp(name, "glDeleteRenderbuffersOES") == 0) {
        void *p = guest_to_host(r1);
        if (p) glDeleteRenderbuffersOES(r0, (const GLuint*)p);
    } else if (strcmp(name, "glBindRenderbufferOES") == 0) {
        glBindRenderbufferOES(r0, r1);
    } else if (strcmp(name, "glRenderbufferStorageOES") == 0) {
        glRenderbufferStorageOES(r0, r1, r2, r3);
    } else if (strcmp(name, "glGenFramebuffersOES") == 0) {
        void *p = guest_to_host(r1);
        if (p) glGenFramebuffersOES(r0, (GLuint*)p);
    } else if (strcmp(name, "glDeleteFramebuffersOES") == 0) {
        void *p = guest_to_host(r1);
        if (p) glDeleteFramebuffersOES(r0, (const GLuint*)p);
    } else if (strcmp(name, "glBindFramebufferOES") == 0) {
        glBindFramebufferOES(r0, r1);
    } else if (strcmp(name, "glFramebufferTexture2DOES") == 0) {
        uint32_t sp_args[1];
        uc_mem_read(uc, sp, sp_args, 4);
        glFramebufferTexture2DOES(r0, r1, r2, r3, sp_args[0]);
    } else if (strcmp(name, "glFramebufferRenderbufferOES") == 0) {
        glFramebufferRenderbufferOES(r0, r1, r2, r3);
    } else if (strcmp(name, "glCheckFramebufferStatusOES") == 0) {
        r0 = glCheckFramebufferStatusOES(r0);
    } else if (strcmp(name, "__cxa_pure_virtual") == 0) {
        LOGE("__cxa_pure_virtual called!");
    }

    uc_reg_write(uc, UC_ARM_REG_R0, &r0);
    uc_reg_write(uc, UC_ARM_REG_PC, &lr);
}

static void apply_relocations(const uint8_t *buf, size_t buf_len) {
    Elf32_Ehdr *ehdr = (Elf32_Ehdr*)buf;
    Elf32_Phdr *phdr = (Elf32_Phdr*)(buf + ehdr->e_phoff);
    Elf32_Phdr *dyn_phdr = NULL;
    for (int i = 0; i < ehdr->e_phnum; i++) {
        if (phdr[i].p_type == 2) { // PT_DYNAMIC
            dyn_phdr = &phdr[i];
            break;
        }
    }
    if (!dyn_phdr) return;

    uint32_t *dyn = (uint32_t*)(buf + dyn_phdr->p_offset);
    uint32_t rel_off = 0, rel_sz = 0, jmprel_off = 0, jmprel_sz = 0;
    uint32_t symtab_off = 0, strtab_off = 0;

    for (int i = 0; dyn[i] != 0; i += 2) {
        uint32_t tag = dyn[i];
        uint32_t val = dyn[i+1];
        if (tag == 23) jmprel_off = val;        // DT_JMPREL
        else if (tag == 2) jmprel_sz = val;     // DT_PLTRELSZ
        else if (tag == 17) rel_off = val;      // DT_REL
        else if (tag == 18) rel_sz = val;       // DT_RELSZ
        else if (tag == 6) symtab_off = val;    // DT_SYMTAB
        else if (tag == 5) strtab_off = val;    // DT_STRTAB
    }

    Elf32_Sym *symtab = (Elf32_Sym*)(buf + symtab_off);
    const char *strtab = (const char*)(buf + strtab_off);

    // Relocate JMPREL (PLT imports)
    if (jmprel_off && jmprel_sz) {
        Elf32_Rel *rel = (Elf32_Rel*)(buf + jmprel_off);
        uint32_t count = jmprel_sz / sizeof(Elf32_Rel);
        for (uint32_t i = 0; i < count; i++) {
            uint32_t sym_idx = ELF32_R_SYM(rel[i].r_info);
            const char *sym_name = strtab + symtab[sym_idx].st_name;
            int plt_idx = find_plt_index(sym_name);
            if (plt_idx >= 0) {
                uint32_t stub_addr = 0x80000000 + plt_idx * 8;
                *(uint32_t*)(g_host_code + rel[i].r_offset) = stub_addr;
            }
        }
    }

    // Relocate REL (data/vtable/relative relocations)
    if (rel_off && rel_sz) {
        Elf32_Rel *rel = (Elf32_Rel*)(buf + rel_off);
        uint32_t count = rel_sz / sizeof(Elf32_Rel);
        int relocated_count = 0;
        for (uint32_t i = 0; i < count; i++) {
            uint32_t type = ELF32_R_TYPE(rel[i].r_info);
            if (type == 23) { // R_ARM_RELATIVE
                relocated_count++;
            } else if (type == 2 || type == 21) { // R_ARM_ABS32 or R_ARM_GLOB_DAT
                uint32_t sym_idx = ELF32_R_SYM(rel[i].r_info);
                uint32_t sym_val = symtab[sym_idx].st_value;
                uint32_t addend = *(uint32_t*)(g_host_code + rel[i].r_offset);
                if (sym_val != 0) {
                    uint32_t target = sym_val + addend;
                    *(uint32_t*)(g_host_code + rel[i].r_offset) = target;
                } else {
                    const char *sym_name = strtab + symtab[sym_idx].st_name;
                    int plt_idx = find_plt_index(sym_name);
                    if (plt_idx >= 0) {
                        uint32_t stub_addr = 0x80000000 + plt_idx * 8;
                        *(uint32_t*)(g_host_code + rel[i].r_offset) = stub_addr;
                    } else if (strcmp(sym_name, "__cxa_call_unexpected") == 0) {
                        uint32_t stub_addr = 0x80000000 + find_plt_index("__cxa_pure_virtual") * 8;
                        *(uint32_t*)(g_host_code + rel[i].r_offset) = stub_addr;
                    }
                }
                relocated_count++;
            }
        }
        LOGI("Relocated %d symbols in REL section", relocated_count);
    }
}

static void prepare_call_arm(uint32_t arg0) {
    uint32_t cpsr = 0x10; // USR mode, ARM state
    uint32_t sp = 0x707ff000;
    uint32_t stop_lr = 0x8000e000;
    uc_reg_write(g_uc, UC_ARM_REG_CPSR, &cpsr);
    uc_reg_write(g_uc, UC_ARM_REG_SP, &sp);
    uc_reg_write(g_uc, UC_ARM_REG_LR, &stop_lr);
    uc_reg_write(g_uc, UC_ARM_REG_R0, &arg0);
}

static void load_elf_from_buffer(const uint8_t *buf, size_t buf_len) {
    if (g_uc == NULL || buf == NULL) return;
    // Validate all file-backed PT_LOAD ranges before allocating memory or copying
    // any segment. The original loader trusted offsets and sizes from the ELF.
    if (buf_len < sizeof(Elf32_Ehdr)) {
        LOGE("ELF buffer too small for header (%zu bytes)", buf_len);
        return;
    }
    Elf32_Ehdr *ehdr = (Elf32_Ehdr*)buf;
    if (memcmp(ehdr->e_ident, "\177ELF", 4) != 0 ||
        ehdr->e_ident[4] != 1 || ehdr->e_ident[5] != 1 ||
        ehdr->e_machine != 40 || ehdr->e_ehsize < sizeof(Elf32_Ehdr) ||
        ehdr->e_phentsize != sizeof(Elf32_Phdr)) {
        LOGE("Invalid or unsupported ELF header (expected little-endian 32-bit ARM)");
        return;
    }
    if (ehdr->e_phoff > buf_len ||
        (size_t)ehdr->e_phnum > (buf_len - ehdr->e_phoff) / sizeof(Elf32_Phdr)) {
        LOGE("ELF program-header table exceeds input buffer");
        return;
    }
    Elf32_Phdr *validated_phdr = (Elf32_Phdr*)(buf + ehdr->e_phoff);
    bool has_load_segment = false;
    for (uint32_t i = 0; i < ehdr->e_phnum; ++i) {
        const Elf32_Phdr *ph = &validated_phdr[i];
        if (ph->p_type != 1) continue; // PT_LOAD
        has_load_segment = true;
        if (ph->p_filesz > ph->p_memsz || ph->p_offset > buf_len ||
            (size_t)ph->p_filesz > buf_len - ph->p_offset ||
            ph->p_vaddr > 0x00600000u ||
            ph->p_memsz > 0x00600000u - ph->p_vaddr) {
            LOGE("Invalid PT_LOAD segment %u: off=0x%x filesz=0x%x vaddr=0x%x memsz=0x%x",
                 i, ph->p_offset, ph->p_filesz, ph->p_vaddr, ph->p_memsz);
            return;
        }
    }
    if (!has_load_segment) {
        LOGE("ELF contains no PT_LOAD segments");
        return;
    }

    g_host_code = (uint8_t*)mmap(NULL, 0x00600000, PROT_READ | PROT_WRITE, MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
    g_host_heap = (uint8_t*)mmap(NULL, 0x10000000, PROT_READ | PROT_WRITE, MAP_ANONYMOUS | MAP_PRIVATE | MAP_NORESERVE, -1, 0);
    g_host_stack = (uint8_t*)mmap(NULL, 0x00800000, PROT_READ | PROT_WRITE, MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
    g_host_stubs = (uint8_t*)mmap(NULL, 0x00010000, PROT_READ | PROT_WRITE, MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
    g_host_commpage = (uint8_t*)mmap(NULL, 0x00010000, PROT_READ | PROT_WRITE, MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);

    // mmap returns MAP_FAILED, not NULL, on failure. Check every region before
    // passing its pointer to Unicorn or writing into it.
    if (g_host_code == MAP_FAILED || g_host_heap == MAP_FAILED ||
        g_host_stack == MAP_FAILED || g_host_stubs == MAP_FAILED ||
        g_host_commpage == MAP_FAILED) {
        LOGE("Failed to allocate guest memory regions: errno=%d", errno);
        if (g_host_code != MAP_FAILED && g_host_code) munmap(g_host_code, 0x00600000);
        if (g_host_heap != MAP_FAILED && g_host_heap) munmap(g_host_heap, 0x10000000);
        if (g_host_stack != MAP_FAILED && g_host_stack) munmap(g_host_stack, 0x00800000);
        if (g_host_stubs != MAP_FAILED && g_host_stubs) munmap(g_host_stubs, 0x00010000);
        if (g_host_commpage != MAP_FAILED && g_host_commpage) munmap(g_host_commpage, 0x00010000);
        g_host_code = g_host_heap = g_host_stack = g_host_stubs = g_host_commpage = NULL;
        return;
    }

    uc_mem_map_ptr(g_uc, 0x00000000, 0x00600000, UC_PROT_ALL, g_host_code);
    uc_mem_map_ptr(g_uc, 0x60000000, 0x10000000, UC_PROT_ALL, g_host_heap);
    uc_mem_map_ptr(g_uc, 0x70000000, 0x00800000, UC_PROT_ALL, g_host_stack);
    uc_mem_map_ptr(g_uc, 0x80000000, 0x00010000, UC_PROT_ALL, g_host_stubs);
    uc_mem_map_ptr(g_uc, 0xffff0000, 0x00010000, UC_PROT_ALL, g_host_commpage);

    // 0xffff0fa0: __kuser_memory_barrier (dmb; bx lr)
    uint32_t mb_code[2] = { 0xe12fff1e, 0xe12fff1e };
    memcpy(g_host_commpage + 0x0fa0, mb_code, sizeof(mb_code));

    // 0xffff0fc0: __kuser_cmpxchg (r0=old, r1=new, r2=ptr)
    uint32_t cmpxchg_code[5] = { 0xe5923000, 0xe0533000, 0x05821000, 0xe1a00003, 0xe12fff1e };
    memcpy(g_host_commpage + 0x0fc0, cmpxchg_code, sizeof(cmpxchg_code));

    // 0xffff0fe0: __kuser_get_tls (returns pointer in r0)
    uint32_t tls_code[3] = { 0xe59f0000, 0xe12fff1e, 0x60007000 };
    memcpy(g_host_commpage + 0x0fe0, tls_code, sizeof(tls_code));

    // 0xffff0ffc: __kuser_helper_version
    *(uint32_t*)(g_host_commpage + 0x0ffc) = 5;

    memset(g_host_code, 0, 0x00600000);
    Elf32_Phdr *phdr = (Elf32_Phdr*)(buf + ehdr->e_phoff);
    for (int i = 0; i < ehdr->e_phnum; i++) {
        if (phdr[i].p_type == 1) { // PT_LOAD
            memcpy(g_host_code + phdr[i].p_vaddr, buf + phdr[i].p_offset, phdr[i].p_filesz);
            if (phdr[i].p_memsz > phdr[i].p_filesz) {
                memset(g_host_code + phdr[i].p_vaddr + phdr[i].p_filesz, 0, phdr[i].p_memsz - phdr[i].p_filesz);
            }
            LOGI("Mapped PT_LOAD segment vaddr=0x%x, filesz=0x%x, memsz=0x%x",
                 phdr[i].p_vaddr, phdr[i].p_filesz, phdr[i].p_memsz);
        }
    }

    // Setup 178 PLT import stubs at 0x80000000
    uint32_t stub_code[2] = { 0xef000000, 0xe12fff1e }; // svc 0; bx lr
    for (int i = 0; i < 178; i++) {
        memcpy(g_host_stubs + i * 8, stub_code, 8);
    }
    hle_init();
    install_guest_helpers();

    // Setup stop stub at 0x8000e000 (bx lr)
    uint32_t stop_code[2] = { 0xe12fff1e, 0xe12fff1e };
    memcpy(g_host_stubs + 0xe000, stop_code, 8);

    // Setup fake JavaVM stubs at 0x8000b000 (16 functions)
    for (int i = 0; i < 16; i++) {
        memcpy(g_host_stubs + 0xb000 + i * 8, stub_code, 8);
    }

    // Setup fake JNIEnv stubs at 0x8000c000 (256 functions)
    for (int i = 0; i < 256; i++) {
        memcpy(g_host_stubs + 0xc000 + i * 8, stub_code, 8);
    }

    // Setup fake JavaVM object at 0x60000100 -> vtable at 0x60000120
    *(uint32_t*)(g_host_heap + 0x100) = 0x60000120; // points to vtable
    uint32_t *jvm_table = (uint32_t*)(g_host_heap + 0x120);
    for (int i = 0; i < 16; i++) {
        jvm_table[i] = 0x8000b000 + i * 8;
    }

    // Setup fake JNIEnv object at 0x60001000 -> vtable at 0x60001100
    *(uint32_t*)(g_host_heap + 0x1000) = 0x60001100; // points to env vtable
    uint32_t *env_table = (uint32_t*)(g_host_heap + 0x1100);
    for (int i = 0; i < 256; i++) {
        env_table[i] = 0x8000c000 + i * 8;
    }

    // Initialize dummy heap pointers and handles
    *(uint32_t*)(g_host_heap + 0x2000) = 0x60002000; // dummy jobject
    *(uint32_t*)(g_host_heap + 0x2080) = 0x60002080; // sentinel jobject (EGL_NO_xxx)
    *(uint32_t*)(g_host_heap + 0x2100) = 0x60002100; // resdlString byte array handle
    *(char*)(g_host_heap + 0x3000) = '\0';           // empty string
    strcpy((char*)(g_host_heap + 0x4000), g_real_files_dir); // resdlString byte array content
    *(uint32_t*)(g_host_heap + 0x6000) = 0;          // general array / direct buffer
    *(uint32_t*)(g_host_heap + 0x7000) = 0x60007000; // tls[0] = self
    *(uint32_t*)(g_host_heap + 0x7020) = 0;          // errno = 0

    // Set g_javaVM at 0x004c95b8
    *(uint32_t*)(g_host_code + 0x004c95b8) = 0x60000100;

    // Set GOT entry for g_callbackJNI at 0x004c4a94
    *(uint32_t*)(g_host_code + 0x004c4a94) = 0x004c95bc;

    uc_hook h_intr, h_mem;
    uc_hook_add(g_uc, &h_intr, UC_HOOK_INTR, (void*)hook_intr_cb, NULL, 1, 0);
    uc_hook_add(g_uc, &h_mem, UC_HOOK_MEM_READ_UNMAPPED | UC_HOOK_MEM_WRITE_UNMAPPED | UC_HOOK_MEM_FETCH_UNMAPPED, (void*)hook_mem_invalid_cb, NULL, 0, (uint64_t)-1);

    apply_relocations(buf, buf_len);

    // Initialize application file paths for CFileMgr_Android
    const char *game_dir = g_real_files_dir;
    strncpy((char*)(g_host_code + 0x004c91a4), game_dir, 1023); // sm_resFilePath

    uint16_t *w_game_dir = (uint16_t*)(g_host_heap + 0x5000);
    int gdir_len = (int)strlen(game_dir);
    for (int i = 0; i <= gdir_len; i++) {
        w_game_dir[i] = (uint16_t)game_dir[i];
    }
    uint32_t w_game_dir_guest = 0x60005000;
    *(uint32_t*)(g_host_code + 0x004c5d68) = w_game_dir_guest; // kApplicationPath
    *(uint32_t*)(g_host_code + 0x004c5d6c) = w_game_dir_guest; // kApplicationDataPath
    *(uint32_t*)(g_host_code + 0x004c5d70) = w_game_dir_guest; // kApplicationTempPath
    *(uint32_t*)(g_host_code + 0x004c5d74) = w_game_dir_guest; // kApplicationCachePath
    *(uint32_t*)(g_host_code + 0x00462cd0) = (uint32_t)gdir_len; // kApplicationPathLength
    *(uint32_t*)(g_host_code + 0x00462cd4) = (uint32_t)gdir_len; // kApplicationDataPathLength
    *(uint32_t*)(g_host_code + 0x00462cd8) = (uint32_t)gdir_len; // kApplicationTempPathLength
    *(uint32_t*)(g_host_code + 0x00462cdc) = (uint32_t)gdir_len; // kApplicationCachePathLength

    // Initialize g_externalPath and g_internalPath used by CFileMgr_Android::absoluteExternalPath
    *(uint32_t*)(g_host_code + 0x004c9658) = w_game_dir_guest; // g_externalPath
    *(uint32_t*)(g_host_code + 0x004c964c) = (uint32_t)gdir_len; // g_externalPathLength
    *(uint32_t*)(g_host_code + 0x004c9654) = w_game_dir_guest; // g_internalPath
    *(uint32_t*)(g_host_code + 0x004c9648) = (uint32_t)gdir_len; // g_internalPathLength

    // Initialize Bionic libc _ctype_, _tolower_tab_, _toupper_tab_ in commpage
    uint8_t *ctype_buf = g_host_commpage + 0x1000;
    int16_t *tolower_buf = (int16_t*)(g_host_commpage + 0x1200);
    int16_t *toupper_buf = (int16_t*)(g_host_commpage + 0x1500);

    ctype_buf[0] = 0;
    tolower_buf[0] = -1;
    toupper_buf[0] = -1;
    for (int i = 0; i < 256; i++) {
        uint8_t flags = 0;
        if (i >= 'A' && i <= 'Z') flags |= 0x01; // _U
        if (i >= 'a' && i <= 'z') flags |= 0x02; // _L
        if (i >= '0' && i <= '9') flags |= 0x04; // _N
        if (i == ' ' || (i >= 0x09 && i <= 0x0d)) flags |= 0x08; // _S
        if ((i >= 0x21 && i <= 0x2f) || (i >= 0x3a && i <= 0x40) ||
            (i >= 0x5b && i <= 0x60) || (i >= 0x7b && i <= 0x7e)) flags |= 0x10; // _P
        if (i < 0x20 || i == 0x7f) flags |= 0x20; // _C
        if ((i >= '0' && i <= '9') || (i >= 'a' && i <= 'f') || (i >= 'A' && i <= 'F')) flags |= 0x40; // _X
        if (i == ' ' || i == '\t') flags |= 0x80; // _B
        ctype_buf[i + 1] = flags;

        tolower_buf[i + 1] = (i >= 'A' && i <= 'Z') ? (i + 32) : i;
        toupper_buf[i + 1] = (i >= 'a' && i <= 'z') ? (i - 32) : i;
    }

    // Pointer variables in commpage:
    *(uint32_t*)(g_host_commpage + 0x1800) = 0xffff1000;
    *(uint32_t*)(g_host_commpage + 0x1804) = 0xffff1200;
    *(uint32_t*)(g_host_commpage + 0x1808) = 0xffff1500;

    // GOT entries point to the pointer variables:
    *(uint32_t*)(g_host_code + 0x004c50c0) = 0xffff1800;
    *(uint32_t*)(g_host_code + 0x004c4ce8) = 0xffff1804;
    *(uint32_t*)(g_host_code + 0x004c4a2c) = 0xffff1808;
    LOGI("Bionic ctype, tolower, toupper tables and pointer variables initialized in commpage");

    // Patch CResourceLoader::LoadNext at 0x00366878:
    // Original: beq 0x3667a0 (0x0affffc8) -> exits without advancing when callback returns 0 (waiting for dead servers)
    // Patched: nop (0xe1a00000) -> falls through to b 0x366838, advancing to next item and completing loading!
    uint32_t orig_insn = *(uint32_t*)(g_host_code + 0x00366878);
    LOGI("CResourceLoader::LoadNext at 0x00366878 orig=0x%08x", orig_insn);
    *(uint32_t*)(g_host_code + 0x00366878) = 0xe1a00000;
    LOGI("Patched CResourceLoader::LoadNext at 0x00366878 -> 0xe1a00000 (nop)");

    // Patch A: CGun::Draw Muzzle Flash Guard
    // When m_flashMesh ([r0, #8]) is NULL or !isShooting ([r0, #232]), skip flash drawing to epilogue at 0x002b55c0.
    // Trampoline at 0x004f0000:
    //   4f0000: ldrb r3, [r0, #232]  ; isShooting
    //   4f0004: cmp  r3, #0
    //   4f0008: beq  0x002b55c0      ; if !isShooting -> return
    //   4f000c: ldr  r3, [r0, #8]    ; m_flashMesh
    //   4f0010: cmp  r3, #0
    //   4f0014: beq  0x002b55c0      ; if !m_flashMesh -> return
    //   4f0018: b    0x002b535c      ; continue flash drawing
    uint32_t tramp_a[7] = {
        0xe5d030e8, // ldrb r3, [r0, #232]
        0xe3530000, // cmp  r3, #0
        0x0af7156c, // beq  0x002b55c0
        0xe5903008, // ldr  r3, [r0, #8]
        0xe3530000, // cmp  r3, #0
        0x0af71569, // beq  0x002b55c0
        0xeaf714cf  // b    0x002b535c
    };
    memcpy(g_host_code + 0x004f0000, tramp_a, sizeof(tramp_a));
    *(uint32_t*)(g_host_code + 0x002b5350) = 0xea08eb2a; // b 0x004f0000
    *(uint32_t*)(g_host_code + 0x002b5354) = 0xe1a00000; // nop
    *(uint32_t*)(g_host_code + 0x002b5358) = 0xe1a00000; // nop
    LOGI("Patched CGun::Draw at 0x002b5350 -> trampoline at 0x004f0000");

    // Patch B: CMesh::GetNodeAt NULL Guard
    // If this == NULL (r0 == 0), return immediately without touching mesh memory.
    // Trampoline at 0x004f0040:
    //   4f0040: cmp  r0, #0
    //   4f0044: bxeq lr
    //   4f0048: push {r4, r5, r6, r7, r8, r9, sl, fp, lr}
    //   4f004c: sub  sp, sp, #44
    //   4f0050: b    0x00337a74
    uint32_t tramp_b[5] = {
        0xe3500000, // cmp  r0, #0
        0x012fff1e, // bxeq lr
        0xe92d4ff0, // push {r4, r5, r6, r7, r8, r9, sl, fp, lr}
        0xe24dd02c, // sub  sp, sp, #44
        0xeaf91e87  // b    0x00337a74
    };
    memcpy(g_host_code + 0x004f0040, tramp_b, sizeof(tramp_b));
    *(uint32_t*)(g_host_code + 0x00337a6c) = 0xea06e173; // b 0x004f0040
    LOGI("Patched CMesh::GetNodeAt at 0x00337a6c -> trampoline at 0x004f0040");

    // Patch C: CMesh::GetInterpolationValues Zero-Frame Fix
    // Original: beq 0x337a54 (0x0a000052)
    // Patched:  bls 0x337a54 (0x9a000052) -> handles keyframeCount <= 1 (prevents underflow when 0)
    *(uint32_t*)(g_host_code + 0x00337904) = 0x9a000052;
    LOGI("Patched CMesh::GetInterpolationValues at 0x00337904 -> 0x9a000052 (bls 0x337a54)");

    // Patch D: Enable Multitouch support in engine
    *(uint8_t*)(g_host_code + 0x004c966c) = 1; // g_multipleTouchSupported = 1
    *(uint32_t*)(g_host_code + 0x0015751c) = 0xe3a00001; // CanMultipleTouch() -> mov r0, #1
    *(uint32_t*)(g_host_code + 0x00157520) = 0xe12fff1e; // bx lr
    *(uint32_t*)(g_host_code + 0x00157530) = 0xe3a00001; // IsMultipleTouchEnabled() -> mov r0, #1
    *(uint32_t*)(g_host_code + 0x00157534) = 0xe12fff1e; // bx lr
    LOGI("Patched Multitouch: g_multipleTouchSupported=1, CanMultipleTouch()=1, IsMultipleTouchEnabled()=1");

    // Patch E: Uncap multitouch in CGameApp::OnSystemEvent by removing forced single-touch pid=0
    *(uint32_t*)(g_host_code + 0x0024d5d4) = 0xe1a00000; // nop (was mov r7, #0)
    LOGI("Patched CGameApp::OnSystemEvent at 0x0024d5d4 -> nop (preserve pointer ID for dual stick multitouch)");

    // Patch F: Hardware::GetSupportedArtSetEv -> return 2 (xga)
    // Ensures the engine loads XGA art packs matching the packs installed on the device,
    // regardless of the scaled virtual framebuffer resolution (e.g. 1038x480).
    *(uint32_t*)(g_host_code + 0x002e5170) = 0xe3a00002; // mov r0, #2
    *(uint32_t*)(g_host_code + 0x002e5174) = 0xe12fff1e; // bx lr
    LOGI("Patched Hardware::GetSupportedArtSetEv at 0x002e5170 -> return 2 (xga)");

    // Patch G: CResourceLoader::Init NULL this guard
    // If this == NULL (r0 == 0), return immediately instead of dereferencing [0x10]
    // Trampoline at 0x004f0060:
    //   4f0060: cmp  r0, #0
    //   4f0064: bxeq lr
    //   4f0068: push {r4, r5, r6, r7, r8, lr}
    //   4f006c: mov  r5, r0
    //   4f0070: b    0x00366934
    uint32_t tramp_g[5] = {
        0xe3500000, // cmp  r0, #0
        0x012fff1e, // bxeq lr
        0xe92d41f0, // push {r4, r5, r6, r7, r8, lr}
        0xe1a05000, // mov  r5, r0
        0xeaf9da2f  // b    0x00366934
    };
    memcpy(g_host_code + 0x004f0060, tramp_g, sizeof(tramp_g));
    *(uint32_t*)(g_host_code + 0x0036692c) = 0xea0625cb; // b 0x004f0060
    LOGI("Patched CResourceLoader::Init at 0x0036692c -> trampoline at 0x004f0060");

    // Execute .init_array constructors
    LOGI("Executing .init_array constructors...");
    uint32_t init_array_addr = 0x0049406c;
    int init_count = 51;
    for (int i = 0; i < init_count; i++) {
        uint32_t fn = *(uint32_t*)(g_host_code + init_array_addr + i * 4);
        if (fn != 0 && fn != 0xffffffff) {
            LOGI("Executing .init_array[%d] at 0x%08x...", i, fn);
            prepare_call_arm(0);
            run_result_t r = run_guest(fn, "init_array");
            if (r != RUN_OK) {
                LOGE(".init_array[%d] (0x%08x) failed: %d", i, fn, r);
            } else {
                LOGI(".init_array[%d] finished OK", i);
            }
        }
    }

    LOGI("ELF loaded, relocated, and .init_array constructors executed successfully!");

    // Execute JNI_OnLoad at 0x00161cac
    LOGI("Calling JNI_OnLoad at 0x161cac...");
    prepare_call_arm(0x60000100); // r0 = vm
    uint32_t zero = 0;
    uc_reg_write(g_uc, UC_ARM_REG_R1, &zero); // r1 = reserved
    run_result_t err = run_guest(0x00161cac, "JNI_OnLoad");
    uint32_t jni_ver = 0;
    uc_reg_read(g_uc, UC_ARM_REG_R0, &jni_ver);
    DLOG("JNI_OnLoad returned res=%d, jni_ver=0x%x", err, jni_ver);
}

static void init_unicorn(JNIEnv *env, jobject context) {
    if (g_uc != NULL) return;

    uc_err err = uc_open(UC_ARCH_ARM, UC_MODE_ARM, &g_uc);
    if (err != UC_ERR_OK) {
        LOGE("Failed on uc_open(): %u (%s)", err, uc_strerror(err));
        return;
    }

    LOGI("Unicorn Engine ARM32 translator initialized successfully!");

    if (context != NULL) {
        jclass contextClass = (*env)->GetObjectClass(env, context);
        jmethodID getExtFilesMethod = (*env)->GetMethodID(env, contextClass, "getExternalFilesDir", "(Ljava/lang/String;)Ljava/io/File;");
        if (getExtFilesMethod != NULL) {
            jobject fileObj = (*env)->CallObjectMethod(env, context, getExtFilesMethod, NULL);
            if (fileObj != NULL) {
                jclass fileClass = (*env)->GetObjectClass(env, fileObj);
                jmethodID getAbsPathMethod = (*env)->GetMethodID(env, fileClass, "getAbsolutePath", "()Ljava/lang/String;");
                if (getAbsPathMethod != NULL) {
                    jstring pathStr = (jstring)(*env)->CallObjectMethod(env, fileObj, getAbsPathMethod);
                    if (pathStr != NULL) {
                        const char *cpath = (*env)->GetStringUTFChars(env, pathStr, NULL);
                        if (cpath != NULL) {
                            snprintf(g_real_files_dir, sizeof(g_real_files_dir), "%s/", cpath);
                            (*env)->ReleaseStringUTFChars(env, pathStr, cpath);
                            LOGI("Resolved canonical external files dir: '%s'", g_real_files_dir);
                        }
                    }
                }
            }
        }

        jmethodID getAssetsMethod = (*env)->GetMethodID(env, contextClass, "getAssets", "()Landroid/content/res/AssetManager;");
        if (getAssetsMethod != NULL) {
            jobject assetManagerObj = (*env)->CallObjectMethod(env, context, getAssetsMethod);
            if (assetManagerObj != NULL) {
                AAssetManager* mgr = AAssetManager_fromJava(env, assetManagerObj);
                AAsset* asset = AAssetManager_open(mgr, "libandroidplatformjni.so", AASSET_MODE_BUFFER);
                if (asset != NULL) {
                    const void* buffer = AAsset_getBuffer(asset);
                    off_t length = AAsset_getLength(asset);
                    LOGI("Loaded libandroidplatformjni.so asset: %ld bytes", length);
                    load_elf_from_buffer((const uint8_t*)buffer, length);
                    AAsset_close(asset);
                }
            }
        }
    }
}

JNIEXPORT jint JNICALL JNI_OnLoad(JavaVM *vm, void *reserved) {
    (void)reserved;
    g_real_jvm = vm;
    LOGI("Host JNI_OnLoad called: vm=%p", vm);
    return JNI_VERSION_1_6;
}

JNIEXPORT void JNICALL Java_com_glu_platform_android_GluPlatformActivityJNI_initialise(JNIEnv *env, jobject thiz, jobject context, jobject handler, jstring s1, jstring s2, jstring s3, jstring s4, jstring s5, jstring s6, jboolean b1, jboolean b2, jboolean b3, jstring s7, jstring s8, jstring s9, jstring s10, jint i1, jint i2, jint i3, jint i4, jstring s11) {
    LOGI("GluPlatformActivityJNI_initialise called");
    if (env != NULL) {
        (*env)->GetJavaVM(env, &g_real_jvm);
    }
    if (s2 != NULL) {
        const char *epath = (*env)->GetStringUTFChars(env, s2, NULL);
        if (epath != NULL) {
            snprintf(g_real_files_dir, sizeof(g_real_files_dir), "%s%s", epath, epath[strlen(epath)-1] == '/' ? "" : "/");
            (*env)->ReleaseStringUTFChars(env, s2, epath);
            LOGI("Initialise received external path: '%s'", g_real_files_dir);
        }
    }
    init_unicorn(env, context);
}

JNIEXPORT jint JNICALL Java_com_glu_platform_android_GluPlatformActivityJNI_onCreate(JNIEnv *env, jobject thiz, jbyteArray array, jobject callback) {
    LOGI("GluPlatformActivityJNI_onCreate called");
    if (env != NULL) {
        (*env)->GetJavaVM(env, &g_real_jvm);
    }
    if (callback != NULL && g_real_callback == NULL) {
        g_real_callback = (*env)->NewGlobalRef(env, callback);
        LOGI("Saved g_real_callback global ref: %p", g_real_callback);
    }
    if (g_uc != NULL && g_capplet_inst == 0) {
        pthread_mutex_lock(&g_emu_mutex);
        drain_pending();
        prepare_call_arm(0x60001000); // r0 = env
        uint32_t dummy_thiz = 0x60002000;
        uint32_t dummy_arr = 0x60002000;
        uint32_t dummy_cb = 0x60002000;
        uc_reg_write(g_uc, UC_ARM_REG_R1, &dummy_thiz);
        uc_reg_write(g_uc, UC_ARM_REG_R2, &dummy_arr);
        uc_reg_write(g_uc, UC_ARM_REG_R3, &dummy_cb);
        LOGI("Calling original Java_com_glu_platform_android_GluPlatformActivityJNI_onCreate at 0x162638...");
        run_result_t err = run_guest(0x00162638, "onCreate");
        uint32_t ret_capplet = 0;
        uc_reg_read(g_uc, UC_ARM_REG_R0, &ret_capplet);
        LOGI("Original onCreate returned res=%d, capplet=0x%x", err, ret_capplet);
        if (err == RUN_OK && ret_capplet != 0) {
            g_capplet_inst = ret_capplet;
        } else {
            g_capplet_inst = ret_capplet ? ret_capplet : 0x60010160;
        }
        pthread_mutex_unlock(&g_emu_mutex);
    }
    LOGI("GluPlatformActivityJNI_onCreate returning CApplet pointer 0x%x", g_capplet_inst);
    return (jint)g_capplet_inst;
}

static void ensure_egl_initialized(int w, int h);

JNIEXPORT void JNICALL Java_com_glu_platform_android_GluPlatformActivityJNI_setWindow(JNIEnv *env, jobject thiz, jobject holder) {
    LOGI("GluPlatformActivityJNI_setWindow called, holder=%p", holder);
    if (holder != NULL) {
        jclass holderClass = (*env)->GetObjectClass(env, holder);
        jmethodID getSurface = (*env)->GetMethodID(env, holderClass, "getSurface", "()Landroid/view/Surface;");
        if (getSurface != NULL) {
            jobject surface = (*env)->CallObjectMethod(env, holder, getSurface);
            LOGI("GluPlatformActivityJNI_setWindow: getSurface returned %p", surface);
            if (surface != NULL) {
                jclass surfClass = (*env)->GetObjectClass(env, surface);
                jmethodID isValidMethod = (*env)->GetMethodID(env, surfClass, "isValid", "()Z");
                jboolean valid = JNI_TRUE;
                if (isValidMethod != NULL) {
                    valid = (*env)->CallBooleanMethod(env, surface, isValidMethod);
                    LOGI("GluPlatformActivityJNI_setWindow: surface->isValid() = %d", valid);
                }
                if (valid) {
                    pthread_mutex_lock(&g_egl_mutex);
                    ANativeWindow *win = ANativeWindow_fromSurface(env, surface);
                    LOGI("ANativeWindow_fromSurface created window: %p", win);
                    if (win != NULL) {
                        g_new_window = win;
                        g_window_changed = true;
                    }
                    pthread_mutex_unlock(&g_egl_mutex);
                }
            }
        }
    }
}

static void ensure_egl_initialized(int w, int h) {
    if (g_window == NULL) {
        LOGI("ensure_egl_initialized: g_window is NULL, cannot initialize EGL yet");
        return;
    }

    if (g_display == EGL_NO_DISPLAY) {
        g_display = eglGetDisplay(EGL_DEFAULT_DISPLAY);
        if (!eglInitialize(g_display, NULL, NULL)) {
            LOGI("eglInitialize failed: 0x%x", eglGetError());
            return;
        }
    }

    if (g_surface == EGL_NO_SURFACE && g_display != EGL_NO_DISPLAY) {
        EGLint attribs[] = {
            EGL_SURFACE_TYPE, EGL_WINDOW_BIT,
            EGL_RENDERABLE_TYPE, EGL_OPENGL_ES_BIT,
            EGL_RED_SIZE, 8,
            EGL_GREEN_SIZE, 8,
            EGL_BLUE_SIZE, 8,
            EGL_DEPTH_SIZE, 16,
            EGL_NONE
        };
        EGLConfig config;
        EGLint numConfigs = 0;
        if (!eglChooseConfig(g_display, attribs, &config, 1, &numConfigs) || numConfigs <= 0) {
            LOGI("eglChooseConfig with depth 16 failed (err 0x%x, num=%d), retrying without depth",
                 eglGetError(), numConfigs);
            EGLint attribs_nodepth[] = {
                EGL_SURFACE_TYPE, EGL_WINDOW_BIT,
                EGL_RENDERABLE_TYPE, EGL_OPENGL_ES_BIT,
                EGL_NONE
            };
            numConfigs = 0;
            if (!eglChooseConfig(g_display, attribs_nodepth, &config, 1, &numConfigs) || numConfigs <= 0) {
                LOGE("eglChooseConfig retry without depth failed: 0x%x (num=%d)", eglGetError(), numConfigs);
                return; // Never use an uninitialized EGLConfig.
            }
        }

        EGLint format = 0;
        if (eglGetConfigAttrib(g_display, config, EGL_NATIVE_VISUAL_ID, &format)) {
            LOGI("Setting ANativeWindow_setBuffersGeometry: %dx%d (format=0x%x)",
                 g_surf_width, g_surf_height, format);
            ANativeWindow_setBuffersGeometry(g_window, g_surf_width, g_surf_height, format);
        }

        EGLSurface s = eglCreateWindowSurface(g_display, config, g_window, NULL);
        if (s == EGL_NO_SURFACE) {
            LOGI("eglCreateWindowSurface failed: 0x%x", eglGetError());
            return;
        }
        g_surface = s;

        if (g_context == EGL_NO_CONTEXT) {
            g_context = eglCreateContext(g_display, config, EGL_NO_CONTEXT, NULL);
            if (g_context == EGL_NO_CONTEXT) {
                LOGI("eglCreateContext failed: 0x%x", eglGetError());
                // Roll back the surface created above so a later retry can start cleanly.
                if (g_surface != EGL_NO_SURFACE) {
                    eglDestroySurface(g_display, g_surface);
                    g_surface = EGL_NO_SURFACE;
                }
                return;
            }
        }
        if (g_surface != EGL_NO_SURFACE && g_context != EGL_NO_CONTEXT) {
            if (!eglMakeCurrent(g_display, g_surface, g_surface, g_context)) {
                LOGI("eglMakeCurrent failed: 0x%x", eglGetError());
            } else {
                glViewport(0, 0, g_surf_width, g_surf_height);
                EGLint act_w = 0, act_h = 0;
                eglQuerySurface(g_display, g_surface, EGL_WIDTH, &act_w);
                eglQuerySurface(g_display, g_surface, EGL_HEIGHT, &act_h);
                LOGI("Host EGL and GLES1 Initialized successfully (actual surface %dx%d, virtual %dx%d, context=%p)!",
                     act_w, act_h, g_surf_width, g_surf_height, g_context);
            }
        }
    }
}

JNIEXPORT void JNICALL Java_com_glu_platform_android_GluPlatformActivityJNI_surfaceCreated(JNIEnv *env, jobject thiz, jint id) {
    LOGI("GluPlatformActivityJNI_surfaceCreated id=0x%x", id);
    if (g_uc != NULL && g_capplet_inst != 0) {
        pthread_mutex_lock(&g_emu_mutex);
        drain_pending();
        prepare_call_arm(g_capplet_inst);
        run_guest(0x00156718, "surfaceCreated");
        pthread_mutex_unlock(&g_emu_mutex);
    }
}

JNIEXPORT void JNICALL Java_com_glu_platform_android_GluPlatformActivityJNI_surfaceChanged(JNIEnv *env, jobject thiz, jint id, jint format, jint w, jint h) {
    LOGI("GluPlatformActivityJNI_surfaceChanged id=0x%x format=%d w=%d h=%d", id, format, w, h);
    pthread_mutex_lock(&g_egl_mutex);
    g_real_screen_w = w;
    g_real_screen_h = h;
    int vh = 480;
    int vw = (h > 0) ? ((vh * w) / h) : 1038;
    if (vw % 2 != 0) vw++;
    g_surf_width = vw;
    g_surf_height = vh;
    LOGI("Virtual resolution calculated: %dx%d (real screen: %dx%d, scale: %.2fx)",
         vw, vh, w, h, (float)h / vh);
    pthread_mutex_unlock(&g_egl_mutex);
    if (g_uc != NULL && g_capplet_inst != 0) {
        pthread_mutex_lock(&g_emu_mutex);
        drain_pending();
        prepare_call_arm(g_capplet_inst);
        uc_reg_write(g_uc, UC_ARM_REG_R1, &format);
        uc_reg_write(g_uc, UC_ARM_REG_R2, &vw);
        uc_reg_write(g_uc, UC_ARM_REG_R3, &vh);
        run_guest(0x001568d8, "surfaceChanged");
        pthread_mutex_unlock(&g_emu_mutex);
    }
}

JNIEXPORT void JNICALL Java_com_glu_platform_android_GluPlatformActivityJNI_onSurfaceCreated(JNIEnv *env, jobject thiz, jint id) {
    LOGI("GluPlatformActivityJNI_onSurfaceCreated id=0x%x", id);
    if (g_uc != NULL && g_capplet_inst != 0) {
        pthread_mutex_lock(&g_emu_mutex);
        drain_pending();
        prepare_call_arm(g_capplet_inst);
        run_guest(0x0015676c, "onSurfaceCreated");
        pthread_mutex_unlock(&g_emu_mutex);
    }
}

JNIEXPORT void JNICALL Java_com_glu_platform_android_GluPlatformActivityJNI_onSurfaceChanged(JNIEnv *env, jobject thiz, jint id, jint w, jint h) {
    LOGI("GluPlatformActivityJNI_onSurfaceChanged id=0x%x w=%d, h=%d", id, w, h);
    pthread_mutex_lock(&g_egl_mutex);
    g_real_screen_w = w;
    g_real_screen_h = h;
    int vh = 480;
    int vw = (h > 0) ? ((vh * w) / h) : 1038;
    if (vw % 2 != 0) vw++;
    g_surf_width = vw;
    g_surf_height = vh;
    pthread_mutex_unlock(&g_egl_mutex);
    if (g_uc != NULL && g_capplet_inst != 0) {
        pthread_mutex_lock(&g_emu_mutex);
        drain_pending();
        prepare_call_arm(g_capplet_inst);
        uc_reg_write(g_uc, UC_ARM_REG_R1, &vw);
        uc_reg_write(g_uc, UC_ARM_REG_R2, &vh);
        run_guest(0x00156750, "onSurfaceChanged");
        pthread_mutex_unlock(&g_emu_mutex);
    }
}

static void touch_drain(void);
static int g_frame_count = 0;

JNIEXPORT void JNICALL Java_com_glu_platform_android_GluPlatformActivityJNI_onDrawFrame(JNIEnv *env, jobject thiz, jint id, jlong time, jboolean b) {
    uint64_t frame_start_ns = bridge_monotonic_ns();
    g_frame_count++;
    start_watchdog_once();
    if (g_frame_count <= 10 || g_frame_count % 60 == 0) {
        LOGI("onDrawFrame [#%d] time=%ld, flag=%d, capplet=0x%x, surface=%p",
             g_frame_count, (long)time, b, g_capplet_inst, g_surface);
    }

    pthread_mutex_lock(&g_egl_mutex);
    if (g_window_changed) {
        if (g_surface != EGL_NO_SURFACE) {
            eglMakeCurrent(g_display, EGL_NO_SURFACE, EGL_NO_SURFACE, EGL_NO_CONTEXT);
            eglDestroySurface(g_display, g_surface);
            g_surface = EGL_NO_SURFACE;
        }
        if (g_window != NULL) {
            ANativeWindow_release(g_window);
        }
        g_window = g_new_window;
        g_new_window = NULL;
        g_window_changed = false;
        LOGI("onDrawFrame: Bound new g_window=%p", g_window);
    }

    if (g_surface == EGL_NO_SURFACE && g_window != NULL) {
        int w = ANativeWindow_getWidth(g_window);
        int h = ANativeWindow_getHeight(g_window);
        if (w > 0 && h > 0) {
            g_real_screen_w = w;
            g_real_screen_h = h;
            int vh = 480;
            int vw = (vh * w) / h;
            if (vw % 2 != 0) vw++;
            g_surf_width = vw;
            g_surf_height = vh;
        }
        ensure_egl_initialized(g_surf_width, g_surf_height);
    }
    pthread_mutex_unlock(&g_egl_mutex);

    if (g_display != EGL_NO_DISPLAY && g_surface != EGL_NO_SURFACE) {
        eglMakeCurrent(g_display, g_surface, g_surface, g_context);

        if (g_uc != NULL && g_capplet_inst != 0) {
            uint64_t lock_wait_start_ns = bridge_monotonic_ns();
            pthread_mutex_lock(&g_emu_mutex);
            uint64_t lock_acquired_ns = bridge_monotonic_ns();
            touch_drain();
            uint32_t t = (uint32_t)time;
            uint32_t flag = b ? 1 : 0;
            prepare_call_arm(g_capplet_inst);
            uc_reg_write(g_uc, UC_ARM_REG_R1, &t);
            uc_reg_write(g_uc, UC_ARM_REG_R2, &flag);
            uint64_t guest_frame_start_ns = bridge_monotonic_ns();
            run_guest(0x00156b10, "frame");
            uint64_t guest_frame_elapsed_ns = bridge_monotonic_ns() - guest_frame_start_ns;
            uint64_t lock_wait_elapsed_ns = lock_acquired_ns - lock_wait_start_ns;
            if (guest_frame_elapsed_ns > 50000000ull || lock_wait_elapsed_ns > 10000000ull) {
                LOGI("FRAME STALL: guest=%.2f ms emu_lock_wait=%.2f ms frame=%d",
                     guest_frame_elapsed_ns / 1000000.0,
                     lock_wait_elapsed_ns / 1000000.0, g_frame_count);
            }

            if (g_frame_count <= 10 || g_frame_count % 60 == 0) {
                uint32_t app_ptr = 0;
                uc_mem_read(g_uc, 0x004c909c, &app_ptr, 4);
                if (app_ptr != 0) {
                    uint32_t res_loader = 0, gunbros = 0, input_ptr = 0;
                    uc_mem_read(g_uc, app_ptr + 96, &res_loader, 4);
                    uc_mem_read(g_uc, app_ptr + 104, &input_ptr, 4);
                    uc_mem_read(g_uc, app_ptr + 108, &gunbros, 4);

                    uint16_t res_tot = 0, res_cur = 0;
                    if (res_loader) {
                        uc_mem_read(g_uc, res_loader + 12, &res_tot, 2);
                        uc_mem_read(g_uc, res_loader + 14, &res_cur, 2);
                    }

                    uint32_t gstate = 0, substate = 0, menu_sys = 0;
                    if (gunbros) {
                        uc_mem_read(g_uc, gunbros + 4, &menu_sys, 4);
                        uc_mem_read(g_uc, gunbros + 320, &gstate, 4);
                        uc_mem_read(g_uc, gunbros + 316, &substate, 4);
                    }

                    uint32_t cur_menu = 0;
                    if (menu_sys) {
                        uc_mem_read(g_uc, menu_sys + 140, &cur_menu, 4);
                    }

                    uint32_t movie = 0, mode = 0, timer = 0;
                    uint8_t b1880 = 0, b1881 = 0, b1882 = 0, b1884 = 0, b1885 = 0;
                    uint16_t state16 = 0;
                    if (cur_menu) {
                        uc_mem_read(g_uc, cur_menu + 12, &movie, 4);
                        uc_mem_read(g_uc, cur_menu + 16, &state16, 2);
                        uc_mem_read(g_uc, cur_menu + 1852, &mode, 4);
                        uc_mem_read(g_uc, cur_menu + 1876, &timer, 4);
                        uc_mem_read(g_uc, cur_menu + 1880, &b1880, 1);
                        uc_mem_read(g_uc, cur_menu + 1881, &b1881, 1);
                        uc_mem_read(g_uc, cur_menu + 1882, &b1882, 1);
                        uc_mem_read(g_uc, cur_menu + 1884, &b1884, 1);
                        uc_mem_read(g_uc, cur_menu + 1885, &b1885, 1);
                    }

                    uint32_t mov_cur = 0, mov_tot = 0;
                    uint8_t mov_chap = 0, mov_fin = 0;
                    if (movie) {
                        uc_mem_read(g_uc, movie + 160, &mov_cur, 4);
                        uc_mem_read(g_uc, movie + 168, &mov_tot, 4);
                        uc_mem_read(g_uc, movie + 174, &mov_chap, 1);
                        uc_mem_read(g_uc, movie + 175, &mov_fin, 1);
                    }

                    LOGI("STATE [#%d]: app=0x%x res=%d/%d gb=0x%x gstate=%d sub=%d ms=0x%x menu=0x%x (mode=%d tm=%d b1882=%d b1884=%d s16=%d) mov=0x%x (cur=%d tot=%d ch=%d fin=%d)",
                         g_frame_count, app_ptr, res_cur, res_tot, gunbros, gstate, substate, menu_sys, cur_menu,
                         mode, timer, b1882, b1884, state16, movie, mov_cur, mov_tot, mov_chap, mov_fin);

                    if (gstate == 5 && menu_sys != 0) {
                        uint32_t top_menu = 0;
                        uc_mem_read(g_uc, menu_sys + 256, &top_menu, 4);
                        int32_t r1[4] = {0}, r2[4] = {0};
                        uint8_t sel0 = 0, sel1 = 0, shown = 0;
                        if (top_menu != 0) {
                            uc_mem_read(g_uc, top_menu + 32, r1, 16);
                            uc_mem_read(g_uc, top_menu + 48, r2, 16);
                            uc_mem_read(g_uc, top_menu + 64, &sel0, 1);
                            uc_mem_read(g_uc, top_menu + 65, &sel1, 1);
                            uc_mem_read(g_uc, top_menu + 70, &shown, 1);
                        }
                        LOGI("PLAYER_SELECT: top=0x%x shown=%d sel=[%d,%d] Card1(Percy)=[%d,%d,%d,%d] Card2(Francis)=[%d,%d,%d,%d]",
                             top_menu, shown, sel0, sel1,
                             r1[0], r1[1], r1[2], r1[3],
                             r2[0], r2[1], r2[2], r2[3]);
                    }

                    if (res_loader) {
                        uint32_t head = 0, tail = 0, cur = 0;
                        uc_mem_read(g_uc, res_loader + 0, &head, 4);
                        uc_mem_read(g_uc, res_loader + 4, &tail, 4);
                        uc_mem_read(g_uc, res_loader + 8, &cur, 4);
                        uint16_t cid = 0;
                        uint8_t ctype = 0;
                        uint32_t cfn = 0;
                        if (cur) {
                            uc_mem_read(g_uc, cur + 4, &cid, 2);
                            uc_mem_read(g_uc, cur + 6, &ctype, 1);
                            uc_mem_read(g_uc, cur + 8, &cfn, 4);
                        }
                        LOGI("RES_LOADER [#%d]: tot=%d cur_cnt=%d head=0x%x tail=0x%x cur=0x%x (typ=%d id=%d fn=0x%x)",
                             g_frame_count, res_tot, res_cur, head, tail, cur, ctype, cid, cfn);
                    }
                }
            }

            pthread_mutex_unlock(&g_emu_mutex);
        } else {
            glClearColor(0.1f, 0.5f, 0.2f, 1.0f);
            glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
        }

        eglSwapBuffers(g_display, g_surface);
    }
    uint64_t frame_elapsed_ns = bridge_monotonic_ns() - frame_start_ns;
    if (frame_elapsed_ns > 50000000ull) {
        LOGI("SLOW onDrawFrame: %.2f ms frame=%d", frame_elapsed_ns / 1000000.0, g_frame_count);
    }
}

JNIEXPORT void JNICALL Java_com_glu_platform_android_GluPlatformActivityJNI_onDestroy(JNIEnv *env, jobject thiz, jint id) {
    if (g_uc != NULL && g_capplet_inst != 0) {
        pthread_mutex_lock(&g_emu_mutex);
        drain_pending();
        prepare_call_arm(g_capplet_inst);
        run_guest(0x001569bc, "onDestroy");
        pthread_mutex_unlock(&g_emu_mutex);
    }
}

JNIEXPORT void JNICALL Java_com_glu_platform_android_GluPlatformActivityJNI_onPause(JNIEnv *env, jobject thiz, jint id) {
    if (g_uc != NULL && g_capplet_inst != 0) {
        pthread_mutex_lock(&g_emu_mutex);
        drain_pending();
        prepare_call_arm(g_capplet_inst);
        run_guest(0x001569d4, "onPause");
        pthread_mutex_unlock(&g_emu_mutex);
    }
}

JNIEXPORT void JNICALL Java_com_glu_platform_android_GluPlatformActivityJNI_onResume(JNIEnv *env, jobject thiz, jint id) {
    if (g_uc != NULL && g_capplet_inst != 0) {
        pthread_mutex_lock(&g_emu_mutex);
        drain_pending();
        prepare_call_arm(g_capplet_inst);
        run_guest(0x00156614, "onResume");
        pthread_mutex_unlock(&g_emu_mutex);
    }
}

JNIEXPORT void JNICALL Java_com_glu_platform_android_GluPlatformActivityJNI_onStart(JNIEnv *env, jobject thiz, jint id) {
    if (g_uc != NULL && g_capplet_inst != 0) {
        pthread_mutex_lock(&g_emu_mutex);
        drain_pending();
        prepare_call_arm(g_capplet_inst);
        run_guest(0x00156610, "onStart");
        pthread_mutex_unlock(&g_emu_mutex);
    }
}

JNIEXPORT void JNICALL Java_com_glu_platform_android_GluPlatformActivityJNI_onStop(JNIEnv *env, jobject thiz, jint id) {
    if (g_uc != NULL && g_capplet_inst != 0) {
        pthread_mutex_lock(&g_emu_mutex);
        drain_pending();
        prepare_call_arm(g_capplet_inst);
        run_guest(0x00156620, "onStop");
        pthread_mutex_unlock(&g_emu_mutex);
    }
}

JNIEXPORT void JNICALL Java_com_glu_platform_android_GluPlatformActivityJNI_onRestart(JNIEnv *env, jobject thiz, jint id) {
    if (g_uc != NULL && g_capplet_inst != 0) {
        pthread_mutex_lock(&g_emu_mutex);
        drain_pending();
        prepare_call_arm(g_capplet_inst);
        run_guest(0x00156624, "onRestart");
        pthread_mutex_unlock(&g_emu_mutex);
    }
}

JNIEXPORT void JNICALL Java_com_glu_platform_android_GluPlatformActivityJNI_onLowMemory(JNIEnv *env, jobject thiz, jint id) {
    if (g_uc != NULL && g_capplet_inst != 0) {
        pthread_mutex_lock(&g_emu_mutex);
        drain_pending();
        prepare_call_arm(g_capplet_inst);
        run_guest(0x001569a4, "onLowMemory");
        pthread_mutex_unlock(&g_emu_mutex);
    }
}

JNIEXPORT void JNICALL Java_com_glu_platform_android_GluPlatformActivityJNI_onOrientationChanged(JNIEnv *env, jobject thiz, jint orientation) {
    if (g_uc != NULL && g_capplet_inst != 0) {
        pthread_mutex_lock(&g_emu_mutex);
        drain_pending();
        prepare_call_arm(g_capplet_inst);
        uc_reg_write(g_uc, UC_ARM_REG_R1, &orientation);
        run_guest(0x00156864, "onOrientationChanged");
        pthread_mutex_unlock(&g_emu_mutex);
    }
}

JNIEXPORT jboolean JNICALL Java_com_glu_platform_android_GluPlatformActivityJNI_onKeyDown(JNIEnv *env, jobject thiz, jint code, jint event) { return 1; }
JNIEXPORT jboolean JNICALL Java_com_glu_platform_android_GluPlatformActivityJNI_onKeyUp(JNIEnv *env, jobject thiz, jint code, jint event) { return 1; }

JNIEXPORT void JNICALL Java_com_glu_platform_android_GluPlatformActivityJNI_surfaceDestroyed(JNIEnv *env, jobject thiz, jint id) {
    if (g_uc != NULL && g_capplet_inst != 0) {
        pthread_mutex_lock(&g_emu_mutex);
        drain_pending();
        prepare_call_arm(g_capplet_inst);
        run_guest(0x0015671c, "surfaceDestroyed");
        pthread_mutex_unlock(&g_emu_mutex);
    }
}

#define TOUCH_Q_SIZE 1024
typedef struct { int type, x, y, pid; } TouchEvt;
static TouchEvt g_touch_q[TOUCH_Q_SIZE];
static int g_touch_h = 0, g_touch_t = 0;
static pthread_mutex_t g_touch_mutex = PTHREAD_MUTEX_INITIALIZER;

static void touch_push(int type, int x, int y, int pid) {
    if (g_real_screen_w > 0 && g_real_screen_h > 0) {
        x = (x * g_surf_width) / g_real_screen_w;
        y = (y * g_surf_height) / g_real_screen_h;
        if (x < 0) x = 0;
        if (x >= g_surf_width) x = g_surf_width - 1;
        if (y < 0) y = 0;
        if (y >= g_surf_height) y = g_surf_height - 1;
    }
    pthread_mutex_lock(&g_touch_mutex);
    int n = (g_touch_t + 1) & (TOUCH_Q_SIZE - 1);
    if (n == g_touch_h) {
        // Queue full: advance head to discard oldest move event rather than dropping new events
        g_touch_h = (g_touch_h + 1) & (TOUCH_Q_SIZE - 1);
    }
    g_touch_q[g_touch_t] = (TouchEvt){type, x, y, pid};
    g_touch_t = n;
    pthread_mutex_unlock(&g_touch_mutex);
}

// Must be called with g_emu_mutex held (GL thread)
static void touch_dispatch(int type, int x, int y, int pid) {
    static const uint32_t entry[4] = {0x00162440, 0x00162418, 0x001623f0, 0x001623c8};
    drain_pending();
    prepare_call_arm(0);
    uc_reg_write(g_uc, UC_ARM_REG_R2, &g_capplet_inst);
    uc_reg_write(g_uc, UC_ARM_REG_R3, &x);
    uint32_t sp = 0x707ff000;
    uint32_t sp_args[2] = { (uint32_t)y, (uint32_t)pid };
    memcpy(g_host_stack + (sp - 0x70000000), sp_args, 8);
    run_guest(entry[type], "touch");
    if (type == 2) {
        uint32_t app_ptr = 0;
        uc_mem_read(g_uc, 0x004c909c, &app_ptr, 4);
        if (app_ptr != 0) {
            uint32_t gunbros = 0;
            uc_mem_read(g_uc, app_ptr + 108, &gunbros, 4);
            if (gunbros != 0) {
                uint32_t gstate = 0;
                uc_mem_read(g_uc, gunbros + 320, &gstate, 4);
                if (gstate == 5) {
                    uint32_t menu_sys = 0;
                    uc_mem_read(g_uc, gunbros + 4, &menu_sys, 4);
                    if (menu_sys != 0) {
                        uint32_t top_menu = 0;
                        uc_mem_read(g_uc, menu_sys + 256, &top_menu, 4);
                        if (top_menu != 0) {
                            uint8_t sel = (x < g_surf_width / 2) ? 0 : 1;
                            DLOG("TouchEnded in PLAYER_SELECT: selecting %s (index %d, top=0x%x)",
                                 sel == 0 ? "Percy Gun" : "Francis Gun", sel, top_menu);
                            prepare_call_arm(top_menu);
                            uint32_t sel32 = sel;
                            uc_reg_write(g_uc, UC_ARM_REG_R1, &sel32);
                            run_guest(0x0031f1bc, "select_char");
                        }
                    }
                }
            }
        }
    }
}

static void touch_drain(void) {
    for (;;) {
        TouchEvt e;
        pthread_mutex_lock(&g_touch_mutex);
        if (g_touch_h == g_touch_t) { pthread_mutex_unlock(&g_touch_mutex); return; }
        e = g_touch_q[g_touch_h];
        g_touch_h = (g_touch_h + 1) & (TOUCH_Q_SIZE - 1);
        pthread_mutex_unlock(&g_touch_mutex);
        DLOG("Touch type=%d x=%d y=%d pid=%d", e.type, e.x, e.y, e.pid);
        touch_dispatch(e.type, e.x, e.y, e.pid);
    }
}

JNIEXPORT void JNICALL Java_com_glu_platform_android_GluPlatformActivityJNI_TouchBegan(JNIEnv *env, jobject thiz, jint id, jint x, jint y, jint pid) { touch_push(0, x, y, pid); }
JNIEXPORT void JNICALL Java_com_glu_platform_android_GluPlatformActivityJNI_TouchMoved(JNIEnv *env, jobject thiz, jint id, jint x, jint y, jint pid) { touch_push(1, x, y, pid); }
JNIEXPORT void JNICALL Java_com_glu_platform_android_GluPlatformActivityJNI_TouchEnded(JNIEnv *env, jobject thiz, jint id, jint x, jint y, jint pid) { touch_push(2, x, y, pid); }
JNIEXPORT void JNICALL Java_com_glu_platform_android_GluPlatformActivityJNI_TouchCancelled(JNIEnv *env, jobject thiz, jint id, jint x, jint y, jint pid) { touch_push(3, x, y, pid); }

JNIEXPORT void JNICALL Java_com_glu_platform_android_GluPlatformActivityJNI_MouseButtonDown(JNIEnv *env, jobject thiz, jint id, jint x, jint y) {}
JNIEXPORT void JNICALL Java_com_glu_platform_android_GluPlatformActivityJNI_MouseButtonUp(JNIEnv *env, jobject thiz, jint id, jint x, jint y) {}
JNIEXPORT void JNICALL Java_com_glu_platform_android_GluPlatformActivityJNI_MouseMove(JNIEnv *env, jobject thiz, jint id, jint x, jint y) {}
JNIEXPORT void JNICALL Java_com_glu_platform_android_GluPlatformActivityJNI_pushAccelerometerValues(JNIEnv *env, jobject thiz, jint id, jfloat x, jfloat y, jfloat z) {}
// Java invokes this when an Android MediaPlayer sound finishes. The decompiled
// Java signature is known, but the corresponding guest callback/address is not
// mapped in this bridge yet. Keep the JNI symbol present to prevent
// UnsatisfiedLinkError; do not guess a guest function address here.
JNIEXPORT void JNICALL Java_com_glu_platform_android_GluPlatformActivityJNI_SoundEventCompleted(JNIEnv *env, jobject thiz, jint id, jlong event_id) {
    (void)env; (void)thiz;
    DLOG("SoundEventCompleted received (handle=%d, event=%lld); guest dispatch not mapped", id, (long long)event_id);
}

JNIEXPORT void JNICALL Java_com_glu_platform_android_GluPlatformActivityJNI_feedPCMMediaPlayer(JNIEnv *env, jobject thiz, jint id, jbyteArray array, jint len) {
    (void)thiz;
    (void)id;
    if (env == NULL || array == NULL || len <= 0) return;

    // Validate against the actual Java byte[] size and the guest scratch limit.
    jsize array_len = (*env)->GetArrayLength(env, array);
    if ((*env)->ExceptionCheck(env) || array_len <= 0) return;
    size_t req = (size_t)len;
    if (req > (size_t)array_len) req = (size_t)array_len;
    if (req > BRIDGE_PCM_MAX_BYTES) req = BRIDGE_PCM_MAX_BYTES;
    if (req == 0) return;

    // Private per-call copy prevents another callback from overwriting samples
    // between releasing g_emu_mutex and SetByteArrayRegion().
    uint8_t pcm[BRIDGE_PCM_MAX_BYTES];

    if (!g_sound_engine_ready || g_uc == NULL || g_capplet_inst == 0 || g_host_heap == NULL) {
        memset(pcm, 0, req);
        (*env)->SetByteArrayRegion(env, array, 0, (jsize)req, (const jbyte*)pcm);
        return;
    }

    // AudioTrack notifications can arrive while a frame is being emulated.
    // Never block the render thread waiting for the audio callback: return the
    // most recent complete PCM block (silence until the first block exists).
    if (pthread_mutex_trylock(&g_emu_mutex) != 0) {
        bridge_copy_cached_pcm(pcm, req);
        uint32_t misses = __sync_add_and_fetch(&g_pcm_contention_count, 1);
        if (misses == 1 || misses % 100 == 0) {
            LOGI("PCM callback deferred: emulation mutex busy (%u occurrences)", misses);
        }
        (*env)->SetByteArrayRegion(env, array, 0, (jsize)req, (const jbyte*)pcm);
        return;
    }

    // Recheck while holding the lock in case initialization/teardown changed.
    if (!g_sound_engine_ready || g_uc == NULL || g_capplet_inst == 0 || g_host_heap == NULL) {
        pthread_mutex_unlock(&g_emu_mutex);
        memset(pcm, 0, req);
        (*env)->SetByteArrayRegion(env, array, 0, (jsize)req, (const jbyte*)pcm);
        return;
    }

    uint32_t guest_buf = 0x60080000;
    uint32_t guest_req = (uint32_t)req;
    uint8_t *host_pcm = g_host_heap + 0x80000;
    memset(host_pcm, 0, req);
    // Do not drain touch/input events on AudioTrack's callback thread. The GL
    // frame path owns that queue; processing it here adds unpredictable work to
    // a real-time audio callback and can worsen both sound underruns and frame lag.
    prepare_call_arm(g_capplet_inst);
    uc_reg_write(g_uc, UC_ARM_REG_R1, &guest_buf);
    uc_reg_write(g_uc, UC_ARM_REG_R2, &guest_req);
    uint64_t audio_start_ns = bridge_monotonic_ns();
    run_guest(0x00156ee0, "feedPCMMediaPlayer");
    memcpy(pcm, host_pcm, req); // Copy before unlocking; the scratch area is shared.
    pthread_mutex_unlock(&g_emu_mutex);

    // Publish the complete block only after guest execution has finished.
    pthread_mutex_lock(&g_pcm_cache_mutex);
    memcpy(g_pcm_cache, pcm, req);
    g_pcm_cache_len = req;
    pthread_mutex_unlock(&g_pcm_cache_mutex);

    uint64_t audio_elapsed_ns = bridge_monotonic_ns() - audio_start_ns;
    if (audio_elapsed_ns > 20000000ull) {
        LOGI("Slow PCM generation: %.2f ms for %zu bytes", audio_elapsed_ns / 1000000.0, req);
    }
    (*env)->SetByteArrayRegion(env, array, 0, (jsize)req, (const jbyte*)pcm);
}

JNIEXPORT void JNICALL Java_com_glu_platform_android_GluPlatformActivityJNI_javaToNativeFacebook(JNIEnv *env, jobject thiz, jint i1, jint i2, jint i3, jbyteArray b, jobjectArray c) {}
JNIEXPORT void JNICALL Java_com_glu_platform_android_GluPlatformActivityJNI_LocalEvent(JNIEnv *env, jobject thiz, jstring s1, jstring s2) {}
JNIEXPORT void JNICALL Java_com_glu_platform_android_GluPlatformActivityJNI_tidy(JNIEnv *env, jobject thiz, jint id) {}
JNIEXPORT void JNICALL Java_com_glu_platform_android_GluPlatformActivityJNI_uninitialise(JNIEnv *env, jobject thiz) {}
JNIEXPORT void JNICALL Java_com_glu_platform_android_GluPlatformActivityJNI_setUseBeam(JNIEnv *env, jobject thiz, jint id, jboolean b) {}
JNIEXPORT void JNICALL Java_com_glu_platform_gwallet_GWallet_create(JNIEnv *env, jobject thiz) {}
JNIEXPORT void JNICALL Java_com_glu_platform_gwallet_GWallet_destroy(JNIEnv *env, jobject thiz) {}
JNIEXPORT void JNICALL Java_com_glu_platform_gwallet_GWallet_start(JNIEnv *env, jobject thiz) {}
JNIEXPORT void JNICALL Java_com_glu_platform_gwallet_GWallet_stop(JNIEnv *env, jobject thiz) {}
JNIEXPORT void JNICALL Java_com_glu_platform_gwallet_GWallet_pause(JNIEnv *env, jobject thiz) {}
JNIEXPORT void JNICALL Java_com_glu_platform_gwallet_GWallet_resume(JNIEnv *env, jobject thiz) {}
JNIEXPORT void JNICALL Java_com_glu_platform_gwallet_GWallet_restart(JNIEnv *env, jobject thiz) {}
JNIEXPORT void JNICALL Java_com_glu_platform_gwallet_GWallet_initialise(JNIEnv *env, jobject thiz) {}
JNIEXPORT void JNICALL Java_com_glu_platform_gwallet_GWallet_uninitialise(JNIEnv *env, jobject thiz) {}
JNIEXPORT void JNICALL Java_com_glu_platform_gwallet_GWallet_getBalance(JNIEnv *env, jobject thiz) {}
JNIEXPORT void JNICALL Java_com_glu_platform_gwallet_GWallet_addCurrency(JNIEnv *env, jobject thiz) {}
JNIEXPORT void JNICALL Java_com_glu_platform_gwallet_GWallet_subtractCurrency(JNIEnv *env, jobject thiz) {}
JNIEXPORT void JNICALL Java_com_glu_platform_gwallet_GWallet_subscribeWithReceipt(JNIEnv *env, jobject thiz) {}
JNIEXPORT void JNICALL Java_com_glu_platform_gwallet_GWallet_handleupdate(JNIEnv *env, jobject thiz) {}
JNIEXPORT void JNICALL Java_com_glu_platform_gwallet_GWalletJNI_enableHTTPTransfers(JNIEnv *env, jobject thiz) {}
JNIEXPORT void JNICALL Java_com_glu_platform_gwallet_GWalletJNI_onHandleResponse(JNIEnv *env, jobject thiz, jstring s, jint i) {}
JNIEXPORT jboolean JNICALL Java_com_glu_android_GluBeam_onIncomingNFCDataReceived(JNIEnv *env, jobject thiz, jbyteArray b) { return 0; }
JNIEXPORT jint JNICALL Java_com_glu_android_iap_IAPJava_iapCallbackEvent(JNIEnv *env, jobject thiz, jint i1, jint i2, jbyteArray b) { return 0; }
