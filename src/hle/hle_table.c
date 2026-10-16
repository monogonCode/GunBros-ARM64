#include "hle_internal.h"
#include "gunbros/compatibility/jni_virtual_machine.h"
#include <time.h>
#include <unistd.h>
#include <pthread.h>

static const char* s_plt_names[N_PLT] = {
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

_Static_assert(sizeof(s_plt_names) / sizeof(s_plt_names[0]) == N_PLT, "s_plt_names length must equal N_PLT");

static hle_fn s_hle_table[N_PLT] = {0};
static volatile int s_guest_dead = 0;
static volatile uint64_t s_call_start_ns = 0;

int hle_find_plt_index(const char *name) {
    if (!name) return -1;
    for (int i = 0; i < N_PLT; i++) {
        if (strcmp(name, s_plt_names[i]) == 0) return i;
    }
    return -1;
}

const char* hle_get_plt_name(int idx) {
    if (idx >= 0 && idx < N_PLT) return s_plt_names[idx];
    return "unknown";
}

static uint64_t now_ns(void) {
    struct timespec ts;
    if (clock_gettime(CLOCK_MONOTONIC, &ts) != 0) return 0;
    return ((uint64_t)ts.tv_sec * 1000000000ull) + (uint64_t)ts.tv_nsec;
}

static void register_defs(const hle_def_t *defs, size_t count) {
    for (size_t i = 0; i < count; i++) {
        int idx = hle_find_plt_index(defs[i].name);
        if (idx >= 0) {
            s_hle_table[idx] = defs[i].fn;
        } else {
            LOGE("hle_init: '%s' not found in s_plt_names", defs[i].name);
        }
    }
}

void hle_init(void) {
    memset(s_hle_table, 0, sizeof(s_hle_table));
    register_defs(g_hle_libc_string_defs, g_hle_libc_string_defs_count);
    register_defs(g_hle_libc_time_defs, g_hle_libc_time_defs_count);
    register_defs(g_hle_libc_stdio_defs, g_hle_libc_stdio_defs_count);
    register_defs(g_hle_net_stubs_defs, g_hle_net_stubs_defs_count);
    register_defs(g_hle_gles1_defs, g_hle_gles1_defs_count);
}

void on_dynarmic_svc(uint32_t swi) {
    if (swi >= 0x1000 && swi < 0x1010) {
        int vm_idx = swi - 0x1000;
        uint32_t r0 = dynarmic_backend_get_reg(0);
        uint32_t r1 = dynarmic_backend_get_reg(1);
        uint32_t r2 = dynarmic_backend_get_reg(2);
        uint32_t r3 = dynarmic_backend_get_reg(3);
        uint32_t sp = dynarmic_backend_get_reg(13);
        uint32_t lr = dynarmic_backend_get_reg(14);
        handle_jvm_call(vm_idx, &r0, &r1, &r2, &r3, sp, lr);
        dynarmic_backend_set_reg(0, r0);
        dynarmic_backend_set_reg(1, r1);
        return;
    }

    if (swi >= 0x2000 && swi < 0x2100) {
        int jni_idx = swi - 0x2000;
        uint32_t r0 = dynarmic_backend_get_reg(0);
        uint32_t r1 = dynarmic_backend_get_reg(1);
        uint32_t r2 = dynarmic_backend_get_reg(2);
        uint32_t r3 = dynarmic_backend_get_reg(3);
        uint32_t sp = dynarmic_backend_get_reg(13);
        uint32_t lr = dynarmic_backend_get_reg(14);
        handle_jni_call(jni_idx, &r0, &r1, &r2, &r3, sp, lr);
        dynarmic_backend_set_reg(0, r0);
        dynarmic_backend_set_reg(1, r1);
        return;
    }

    if (swi < N_PLT) {
        int idx = (int)swi;
        hle_fn fn = s_hle_table[idx];
        if (fn) {
            hle_t c;
            memset(&c, 0, sizeof(c));
            c.r0 = dynarmic_backend_get_reg(0);
            c.r1 = dynarmic_backend_get_reg(1);
            c.r2 = dynarmic_backend_get_reg(2);
            c.r3 = dynarmic_backend_get_reg(3);
            c.sp = dynarmic_backend_get_reg(13);
            c.lr = dynarmic_backend_get_reg(14);
            c.pc = dynarmic_backend_get_reg(15);
            fn(&c);
            dynarmic_backend_set_reg(0, c.r0);
            if (c.set_r1) {
                dynarmic_backend_set_reg(1, c.out_r1);
            }
            return;
        }

        static uint32_t seen[N_PLT] = {0};
        if (seen[idx]++ < 3) {
            uint32_t r0 = dynarmic_backend_get_reg(0);
            uint32_t r1 = dynarmic_backend_get_reg(1);
            uint32_t r2 = dynarmic_backend_get_reg(2);
            uint32_t lr = dynarmic_backend_get_reg(14);
            LOGI("UNHANDLED PLT %s (idx=%d) r0=0x%x r1=0x%x r2=0x%x lr=0x%x",
                 s_plt_names[idx], idx, r0, r1, r2, lr);
        }
        return;
    }

    LOGE("Unhandled on_dynarmic_svc: swi=0x%x", swi);
}

void prepare_call_arm(uint32_t arg0) {
    uint32_t cpsr = 0x10; // USR mode, ARM state
    uint32_t sp = GUEST_STACK_TOP;
    uint32_t stop_lr = STOP_ADDR;
    dynarmic_backend_set_cpsr(cpsr);
    dynarmic_backend_set_reg(13, sp);
    dynarmic_backend_set_reg(14, stop_lr);
    dynarmic_backend_set_reg(0, arg0);
}

static volatile const char *s_current_call_tag = NULL;
static volatile uint32_t s_current_entry = 0;

run_result_t run_guest(uint32_t entry, const char *tag) {
    if (s_guest_dead || !dynarmic_backend_is_active()) return RUN_DEAD;
    s_current_call_tag = tag;
    s_current_entry = entry;
    s_call_start_ns = now_ns();
    dynarmic_backend_run(entry);
    s_call_start_ns = 0;
    s_current_call_tag = NULL;
    if (s_guest_dead) return RUN_DEAD;
    return RUN_OK;
}

static void *watchdog_thread(void *arg) {
    (void)arg;
    for (;;) {
        sleep(1);
        uint64_t st = s_call_start_ns;
        if (st) {
            uint64_t elapsed_ns = now_ns() - st;
            if (elapsed_ns > 2ull * 1000000000ull) {
                uint32_t pc = dynarmic_backend_get_reg(15);
                uint32_t lr = dynarmic_backend_get_reg(14);
                uint32_t r0 = dynarmic_backend_get_reg(0);
                uint32_t r1 = dynarmic_backend_get_reg(1);
                uint32_t r2 = dynarmic_backend_get_reg(2);
                uint32_t r3 = dynarmic_backend_get_reg(3);
                LOGI("WATCHDOG: call '%s' (entry=0x%08x) running for %.1fs pc=0x%08x lr=0x%08x r0=0x%x r1=0x%x r2=0x%x r3=0x%x",
                     s_current_call_tag ? s_current_call_tag : "none", s_current_entry,
                     elapsed_ns / 1000000000.0, pc, lr, r0, r1, r2, r3);
            }
            if (elapsed_ns > 20ull * 1000000000ull) {
                LOGE("WATCHDOG: halting Dynarmic after 20s");
                dynarmic_backend_halt();
            }
        }
    }
    return NULL;
}

void start_watchdog_once(void) {
    static int started = 0;
    if (started) return;
    started = 1;
    pthread_t t;
    pthread_create(&t, NULL, watchdog_thread, NULL);
}
