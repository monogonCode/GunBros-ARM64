#include "gunbros/emulator/hle_dispatcher.h"
#include "gunbros/emulator/guest_memory.h"
#include "gunbros/emulator/dynarmic_backend.h"
#include "gunbros/compatibility/jni_virtual_machine.h"
#include "gunbros/filesystem/file_operations.h"
#include "gunbros/filesystem/directory_operations.h"
#include "gunbros/platform/android_window.h"
#include <math.h>
#include <time.h>
#include <unistd.h>
#include <sys/time.h>
#include <pthread.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <netdb.h>

#ifdef __ANDROID__
#include <GLES/gl.h>
#define GL_GLEXT_PROTOTYPES 1
#include <GLES/glext.h>
#endif

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

static void ret64(hle_t *c, uint64_t v) {
    c->r0 = (uint32_t)v;
    c->out_r1 = (uint32_t)(v >> 32);
    c->set_r1 = true;
}

static void retdouble(hle_t *c, double d) {
    uint64_t u;
    memcpy(&u, &d, 8);
    ret64(c, u);
}

/* ---------------- Memory HLE ---------------- */
static void h_malloc(hle_t *c)  { c->r0 = guest_alloc(c->r0); }
static void h_free(hle_t *c)    { guest_free(c->r0); c->r0 = 0; }
static void h_calloc(hle_t *c) {
    uint64_t sz = (uint64_t)c->r0 * c->r1;
    if (sz > 0xffffffffu) { set_guest_errno(ENOMEM); c->r0 = 0; return; }
    c->r0 = guest_alloc((uint32_t)sz);
    void *p = guest_to_host(c->r0);
    if (p) memset(p, 0, (size_t)sz);
}
static void h_realloc(hle_t *c) {
    uint32_t old_ptr = c->r0, sz = c->r1, oldcap = guest_cap(old_ptr);
    if (old_ptr != 0 && sz == 0) { guest_free(old_ptr); c->r0 = 0; return; }
    if (old_ptr != 0 && oldcap >= sz) { c->r0 = old_ptr; return; }
    uint32_t np = guest_alloc(sz);
    if (old_ptr != 0 && np) {
        void *src = guest_to_host(old_ptr), *dst = guest_to_host(np);
        uint32_t n = oldcap ? oldcap : sz;
        if (n > sz) n = sz;
        if (src && dst) memcpy(dst, src, n);
        guest_free(old_ptr);
    }
    c->r0 = np;
}
static void h_memcpy(hle_t *c) {
    uint32_t n = c->r2;
    if (!n) return;
    void *d = guest_ptr(c->r0, n), *s = guest_ptr(c->r1, n);
    if (d && s) memmove(d, s, n);
    else LOGE("memcpy/memmove out of bounds dst=0x%x src=0x%x n=%u lr=0x%x", c->r0, c->r1, n, c->lr);
}
static void h_memset(hle_t *c) {
    if (!c->r2) return;
    void *d = guest_ptr(c->r0, c->r2);
    if (d) memset(d, (uint8_t)c->r1, c->r2);
    else LOGE("memset out of bounds dst=0x%x n=%u lr=0x%x", c->r0, c->r2, c->lr);
}
static void h_memcmp(hle_t *c) {
    void *a = guest_ptr(c->r0, c->r2), *b = guest_ptr(c->r1, c->r2);
    c->r0 = (a && b && c->r2) ? (uint32_t)memcmp(a, b, c->r2) : 0;
}
static void h_memchr(hle_t *c) {
    void *src = guest_ptr(c->r0, c->r2);
    void *p = (src && c->r2 > 0) ? memchr(src, c->r1, c->r2) : NULL;
    c->r0 = p ? (c->r0 + (uint32_t)((uint8_t*)p - (uint8_t*)src)) : 0;
}
static void h_strlen(hle_t *c) { const char *s = guest_ptr(c->r0, 1); c->r0 = s ? (uint32_t)strlen(s) : 0; }
static void h_strcmp(hle_t *c) {
    const char *a = guest_ptr(c->r0, 1), *b = guest_ptr(c->r1, 1);
    c->r0 = (a && b) ? (uint32_t)strcmp(a, b) : 0;
}
static void h_strncmp(hle_t *c) {
    const char *s1 = guest_ptr(c->r0, 1), *s2 = guest_ptr(c->r1, 1);
    c->r0 = (s1 && s2) ? (uint32_t)strncmp(s1, s2, c->r2) : 0;
}
static void h_strcasecmp(hle_t *c) {
    const char *s1 = guest_ptr(c->r0, 1), *s2 = guest_ptr(c->r1, 1);
    c->r0 = (s1 && s2) ? (uint32_t)strcasecmp(s1, s2) : 0;
}
static void h_strncasecmp(hle_t *c) {
    const char *s1 = guest_ptr(c->r0, 1), *s2 = guest_ptr(c->r1, 1);
    c->r0 = (s1 && s2) ? (uint32_t)strncasecmp(s1, s2, c->r2) : 0;
}
static void h_strcpy(hle_t *c) {
    char *dst = guest_ptr(c->r0, 1);
    const char *src = guest_ptr(c->r1, 1);
    if (dst && src) strcpy(dst, src);
}
static void h_strncpy(hle_t *c) {
    char *dst = guest_ptr(c->r0, c->r2);
    const char *src = guest_ptr(c->r1, 1);
    if (dst && src) strncpy(dst, src, c->r2);
}
static void h_strcat(hle_t *c) {
    char *dst = guest_ptr(c->r0, 1);
    const char *src = guest_ptr(c->r1, 1);
    if (dst && src) strcat(dst, src);
}
static void h_strncat(hle_t *c) {
    char *dst = guest_ptr(c->r0, 1);
    const char *src = guest_ptr(c->r1, 1);
    if (dst && src) strncat(dst, src, c->r2);
}
static void h_strchr(hle_t *c) {
    const char *s = guest_ptr(c->r0, 1);
    char *p = s ? strchr(s, c->r1) : NULL;
    c->r0 = p ? (c->r0 + (uint32_t)(p - s)) : 0;
}
static void h_strrchr(hle_t *c) {
    const char *s = guest_ptr(c->r0, 1);
    char *p = s ? strrchr(s, c->r1) : NULL;
    c->r0 = p ? (c->r0 + (uint32_t)(p - s)) : 0;
}
static void h_strstr(hle_t *c) {
    const char *s1 = guest_ptr(c->r0, 1), *s2 = guest_ptr(c->r1, 1);
    char *p = (s1 && s2) ? strstr(s1, s2) : NULL;
    c->r0 = p ? (c->r0 + (uint32_t)(p - s1)) : 0;
}
static void h_strdup(hle_t *c) {
    const char *s = guest_ptr(c->r0, 1);
    if (s) {
        uint32_t len = (uint32_t)strlen(s) + 1;
        c->r0 = guest_alloc(len);
        char *dst = (char*)guest_to_host(c->r0);
        if (dst) memcpy(dst, s, len);
    } else {
        c->r0 = 0;
    }
}
static void h_strspn(hle_t *c) {
    const char *s1 = guest_ptr(c->r0, 1), *s2 = guest_ptr(c->r1, 1);
    c->r0 = (s1 && s2) ? (uint32_t)strspn(s1, s2) : 0;
}
static void h_strcspn(hle_t *c) {
    const char *s1 = guest_ptr(c->r0, 1), *s2 = guest_ptr(c->r1, 1);
    c->r0 = (s1 && s2) ? (uint32_t)strcspn(s1, s2) : 0;
}
static void h_wcslen(hle_t *c) {
    const uint16_t *ws = (const uint16_t*)guest_ptr(c->r0, 2);
    uint32_t cnt = 0;
    if (ws) { while (*ws++) cnt++; }
    c->r0 = cnt;
}

/* ---------------- String Formatting & Conversion ---------------- */
static void h_sprintf(hle_t *c) {
    char *dst = (char*)guest_to_host(c->r0);
    const char *fmt = (const char*)guest_to_host(c->r1);
    uint32_t reg_args[2] = { c->r2, c->r3 };
    c->r0 = (uint32_t)safe_guest_snprintf(dst, 1024, fmt, reg_args, 2, c->sp);
}
static void h_snprintf(hle_t *c) {
    char *dst = (char*)guest_to_host(c->r0);
    uint32_t max_len = c->r1;
    const char *fmt = (const char*)guest_to_host(c->r2);
    uint32_t reg_args[1] = { c->r3 };
    c->r0 = (uint32_t)safe_guest_snprintf(dst, max_len, fmt, reg_args, 1, c->sp);
}
static void h_vsprintf(hle_t *c) {
    char *dst = (char*)guest_to_host(c->r0);
    const char *fmt = (const char*)guest_to_host(c->r1);
    uint32_t va_sp = c->r2;
    c->r0 = (uint32_t)safe_guest_snprintf(dst, 1024, fmt, NULL, 0, va_sp);
}
static void h_vsnprintf(hle_t *c) {
    char *dst = (char*)guest_to_host(c->r0);
    uint32_t max_len = c->r1;
    const char *fmt = (const char*)guest_to_host(c->r2);
    uint32_t va_sp = c->r3;
    c->r0 = (uint32_t)safe_guest_snprintf(dst, max_len, fmt, NULL, 0, va_sp);
}
static void h_sscanf(hle_t *c) {
    const char *str = (const char*)guest_to_host(c->r0);
    const char *fmt = (const char*)guest_to_host(c->r1);
    void *arg0 = guest_to_host(c->r2);
    void *arg1 = guest_to_host(c->r3);
    if (str && fmt && arg0 && arg1) {
        c->r0 = (uint32_t)sscanf(str, fmt, arg0, arg1);
    } else if (str && fmt && arg0) {
        c->r0 = (uint32_t)sscanf(str, fmt, arg0);
    } else {
        c->r0 = 0;
    }
}
static void h_atoi(hle_t *c) {
    const char *s = guest_ptr(c->r0, 1);
    c->r0 = s ? (uint32_t)atoi(s) : 0;
}
static void h_atoll(hle_t *c) {
    const char *s = guest_ptr(c->r0, 1);
    ret64(c, s ? (uint64_t)atoll(s) : 0);
}
static void h_strtod(hle_t *c) {
    const char *s = guest_ptr(c->r0, 1);
    if (!s) { ret64(c, 0); return; }
    char *end = NULL;
    double d = strtod(s, &end);
    if (c->r1) {
        uint32_t *pe = guest_ptr(c->r1, 4);
        if (pe) *pe = c->r0 + (uint32_t)(end - s);
    }
    retdouble(c, d);
}
static void h_strtok(hle_t *c) {
    char *s = c->r0 ? (char *)guest_ptr(c->r0, 1) : NULL;
    const char *d = guest_ptr(c->r1, 1);
    if (!d || (c->r0 && !s)) { c->r0 = 0; return; }
    char *r = strtok(s, d);
    c->r0 = r ? host_to_guest(r) : 0;
}

/* ---------------- Time & Math ---------------- */
static void h_clock(hle_t *c) { c->r0 = (uint32_t)clock(); }
static void h_time(hle_t *c) {
    time_t t = time(NULL);
    if (c->r0) {
        time_t *tp = (time_t*)guest_to_host(c->r0);
        if (tp) *tp = t;
    }
    c->r0 = (uint32_t)t;
}
static void h_gettimeofday(hle_t *c) {
    struct timeval tv;
    gettimeofday(&tv, NULL);
    if (c->r0) {
        uint32_t *gtv = (uint32_t*)guest_to_host(c->r0);
        if (gtv) {
            gtv[0] = (uint32_t)tv.tv_sec;
            gtv[1] = (uint32_t)tv.tv_usec;
        }
    }
    c->r0 = 0;
}
static void h_clock_gettime(hle_t *c) {
    struct timespec ts;
    int res = clock_gettime((clockid_t)c->r0, &ts);
    if (c->r1 && res == 0) {
        uint32_t *gts = (uint32_t*)guest_to_host(c->r1);
        if (gts) {
            gts[0] = (uint32_t)ts.tv_sec;
            gts[1] = (uint32_t)ts.tv_nsec;
        }
    }
    c->r0 = (uint32_t)res;
}
static void h_difftime(hle_t *c) {
    retdouble(c, difftime((time_t)(int32_t)c->r0, (time_t)(int32_t)c->r1));
}

static uint32_t s_tm_static = 0, s_ctime_static = 0;
static void tm_to_guest(const struct tm *t, uint32_t ga, bool full) {
    int32_t *d = guest_ptr(ga, full ? 44 : 36);
    if (!d) return;
    d[0] = t->tm_sec;  d[1] = t->tm_min;  d[2] = t->tm_hour;
    d[3] = t->tm_mday; d[4] = t->tm_mon;  d[5] = t->tm_year;
    d[6] = t->tm_wday; d[7] = t->tm_yday; d[8] = t->tm_isdst;
    if (full) { d[9] = (int32_t)t->tm_gmtoff; d[10] = 0; }
}
static bool guest_to_tm(uint32_t ga, struct tm *t) {
    const int32_t *d = guest_ptr(ga, 36);
    if (!d) return false;
    memset(t, 0, sizeof(*t));
    t->tm_sec = d[0];  t->tm_min = d[1];  t->tm_hour = d[2];
    t->tm_mday = d[3]; t->tm_mon = d[4];  t->tm_year = d[5];
    t->tm_wday = d[6]; t->tm_yday = d[7]; t->tm_isdst = d[8];
    t->tm_zone = "";
    return true;
}
static uint32_t tm_static(void) {
    if (!s_tm_static) s_tm_static = guest_alloc(64);
    return s_tm_static;
}
static void h_localtime(hle_t *c) {
    const int32_t *tp = guest_ptr(c->r0, 4);
    if (!tp) { c->r0 = 0; return; }
    time_t t = (time_t)*tp; struct tm tv;
    localtime_r(&t, &tv);
    uint32_t g = tm_static(); tm_to_guest(&tv, g, true); c->r0 = g;
}
static void h_gmtime(hle_t *c) {
    const int32_t *tp = guest_ptr(c->r0, 4);
    if (!tp) { c->r0 = 0; return; }
    time_t t = (time_t)*tp; struct tm tv;
    gmtime_r(&t, &tv);
    uint32_t g = tm_static(); tm_to_guest(&tv, g, true); c->r0 = g;
}
static void h_mktime(hle_t *c) {
    struct tm t;
    if (!guest_to_tm(c->r0, &t)) { c->r0 = (uint32_t)-1; return; }
    time_t r = mktime(&t);
    tm_to_guest(&t, c->r0, false);
    c->r0 = (uint32_t)r;
}
static void h_ctime(hle_t *c) {
    const int32_t *tp = guest_ptr(c->r0, 4);
    if (!tp) { c->r0 = 0; return; }
    time_t t = (time_t)*tp; char buf[32];
    if (!ctime_r(&t, buf)) { c->r0 = 0; return; }
    if (!s_ctime_static) s_ctime_static = guest_alloc(32);
    char *dst = guest_ptr(s_ctime_static, 32);
    if (dst) { strncpy(dst, buf, 31); dst[31] = 0; }
    c->r0 = s_ctime_static;
}
static void h_strftime(hle_t *c) {
    char *s = guest_ptr(c->r0, c->r1);
    const char *fmt = guest_ptr(c->r2, 1);
    struct tm t;
    if (!s || !fmt || !c->r1 || !guest_to_tm(c->r3, &t)) { c->r0 = 0; return; }
    c->r0 = (uint32_t)strftime(s, c->r1, fmt, &t);
}
static void h_strptime(hle_t *c) {
    const char *s = guest_ptr(c->r0, 1), *fmt = guest_ptr(c->r1, 1);
    struct tm t;
    if (!s || !fmt || !guest_to_tm(c->r2, &t)) { c->r0 = 0; return; }
    char *e = strptime(s, fmt, &t);
    if (!e) { c->r0 = 0; return; }
    tm_to_guest(&t, c->r2, false);
    c->r0 = c->r0 + (uint32_t)(e - s);
}

static void float_ret(hle_t *c, float f) { memcpy(&c->r0, &f, 4); }
static float float_arg0(hle_t *c) { float f; memcpy(&f, &c->r0, 4); return f; }
static float float_arg1(hle_t *c) { float f; memcpy(&f, &c->r1, 4); return f; }
static void h_sinf(hle_t *c)   { float_ret(c, sinf(float_arg0(c))); }
static void h_cosf(hle_t *c)   { float_ret(c, cosf(float_arg0(c))); }
static void h_sqrtf(hle_t *c)  { float_ret(c, sqrtf(float_arg0(c))); }
static void h_atan2f(hle_t *c) { float_ret(c, atan2f(float_arg0(c), float_arg1(c))); }
static void h_atanf(hle_t *c)  { float_ret(c, atanf(float_arg0(c))); }
static void h_asinf(hle_t *c)  { float_ret(c, asinf(float_arg0(c))); }
static void h_acosf(hle_t *c)  { float_ret(c, acosf(float_arg0(c))); }
static void h_floorf(hle_t *c) { float_ret(c, floorf(float_arg0(c))); }
static void h_ceilf(hle_t *c)  { float_ret(c, ceilf(float_arg0(c))); }
static void h_modff(hle_t *c) {
    float i_part = 0;
    float res = modff(float_arg0(c), &i_part);
    if (c->r1) {
        float *pi = (float*)guest_to_host(c->r1);
        if (pi) *pi = i_part;
    }
    float_ret(c, res);
}

/* ---------------- C++ Guards & AtExit ---------------- */
static void h_cxa_guard_acquire(hle_t *c) {
    uint32_t *g = (uint32_t*)guest_to_host(c->r0);
    c->r0 = (g && *g == 0) ? 1 : 0;
}
static void h_cxa_guard_release(hle_t *c) {
    uint32_t *g = (uint32_t*)guest_to_host(c->r0);
    if (g) *g = 1;
    c->r0 = 0;
}
static void h_cxa_pure_virtual(hle_t *c) {
    LOGE("__cxa_pure_virtual called! lr=0x%x", c->lr);
    c->r0 = 0;
}
static void hle_errno(hle_t *c) { c->r0 = GUEST_ERRNO_ADDR; }
static void h_srand48(hle_t *c) { srand48(c->r0); c->r0 = 0; }
static void h_lrand48(hle_t *c) { c->r0 = (uint32_t)lrand48(); }

/* ---------------- Filesystem Operations HLE ---------------- */
static void h_fopen(hle_t *c) {
    const char *path = (const char*)guest_to_host(c->r0);
    const char *mode = (const char*)guest_to_host(c->r1);
    c->r0 = (uint32_t)gunbros_fopen(path, mode);
}
static void h_fclose(hle_t *c) {
    gunbros_fclose((int)c->r0);
    c->r0 = 0;
}
static void h_fread(hle_t *c) {
    void *dst = guest_to_host(c->r0);
    c->r0 = (uint32_t)gunbros_fread(dst, c->r1, c->r2, (int)c->r3);
}
static void h_fwrite(hle_t *c) {
    const void *src = guest_to_host(c->r0);
    c->r0 = (uint32_t)gunbros_fwrite(src, c->r1, c->r2, (int)c->r3);
}
static void h_fseek(hle_t *c) {
    c->r0 = (uint32_t)gunbros_fseek((int)c->r0, (long)(int32_t)c->r1, (int)c->r2);
}
static void h_ftell(hle_t *c) {
    c->r0 = (uint32_t)gunbros_ftell((int)c->r0);
}
static void h_rewind(hle_t *c) {
    gunbros_rewind((int)c->r0);
    c->r0 = 0;
}
static void h_stat(hle_t *c) {
    const char *path = (const char*)guest_to_host(c->r0);
    void *st32 = c->r1 ? guest_to_host(c->r1) : NULL;
    c->r0 = (uint32_t)gunbros_stat(path, st32);
}
static void h_remove(hle_t *c) {
    const char *p = (const char*)guest_to_host(c->r0);
    c->r0 = (uint32_t)gunbros_remove(p);
}
static void h_rename(hle_t *c) {
    const char *p1 = (const char*)guest_to_host(c->r0);
    const char *p2 = (const char*)guest_to_host(c->r1);
    c->r0 = (uint32_t)gunbros_rename(p1, p2);
}
static void h_opendir(hle_t *c) {
    const char *p = (const char*)guest_to_host(c->r0);
    c->r0 = (uint32_t)gunbros_opendir(p);
}
static void h_readdir(hle_t *c) {
    uint32_t h = c->r0;
    static uint32_t s_dirent_guest = 0;
    if (!s_dirent_guest) s_dirent_guest = guest_alloc(GUNBROS_DIRENT_SIZE);
    void *g = guest_to_host(s_dirent_guest);
    int res = gunbros_readdir((int)h, g);
    c->r0 = (res > 0) ? s_dirent_guest : 0;
}
static void h_closedir(hle_t *c) {
    gunbros_closedir((int)c->r0);
    c->r0 = 0;
}
static void h_mkdir(hle_t *c) {
    const char *p = (const char*)guest_to_host(c->r0);
    c->r0 = (uint32_t)gunbros_mkdir(p, (mode_t)c->r1);
}
static void h_rmdir(hle_t *c) {
    const char *p = (const char*)guest_to_host(c->r0);
    c->r0 = (uint32_t)gunbros_rmdir(p);
}

/* ---------------- Abort / Halt ---------------- */
static void h_abort(hle_t *c) {
    LOGE("guest abort()/raise() lr=0x%x r0=0x%x", c->lr, c->r0);
    s_guest_dead = 1;
    dynarmic_backend_halt();
}

/* ---------------- Network Stubs (Dead Glu Endpoints) ---------------- */
static void h_net_fail(hle_t *c) { set_guest_errno(ENETUNREACH); c->r0 = (uint32_t)-1; }
static void h_ret0(hle_t *c)     { c->r0 = 0; }
static void h_retm1(hle_t *c)    { c->r0 = (uint32_t)-1; }

static void h_gethostbyname(hle_t *c) {
    const char *host = (const char*)guest_to_host(c->r0);
    if (host && strstr(host, "glu.com") != NULL) {
        LOGI("Intercepted dead Glu endpoint: %s (returning NULL)", host);
        c->r0 = 0;
    } else if (host) {
        struct hostent *he = gethostbyname(host);
        if (he != NULL && he->h_addr_list && he->h_addr_list[0]) {
            uint32_t ip_ptr = 0x60008120;
            memcpy(guest_to_host(ip_ptr), he->h_addr_list[0], 4);
            c->r0 = ip_ptr;
        } else {
            c->r0 = 0;
        }
    } else {
        c->r0 = 0;
    }
}

/* ---------------- Android Log HLE ---------------- */
static void h_android_log_print(hle_t *c) {
    int prio = (int)c->r0;
    const char *tag = (const char*)guest_to_host(c->r1);
    const char *fmt = (const char*)guest_to_host(c->r2);
    char buf[1024];
    uint32_t reg_args[1] = { c->r3 };
    safe_guest_snprintf(buf, sizeof(buf), fmt, reg_args, 1, c->sp);
#ifdef __ANDROID__
    __android_log_print(prio, tag ? tag : LOG_TAG, "%s", buf);
#else
    printf("[GUEST:%s:%d] %s\n", tag ? tag : "APP", prio, buf);
#endif
    c->r0 = 0;
}

/* ---------------- OpenGL ES 1.x Wrappers & Extensions ---------------- */
#ifdef __ANDROID__
static GLuint s_bound_fbo = 0;

static void h_glBindTexture(hle_t *c)       { glBindTexture(c->r0, c->r1); }
static void h_glEnable(hle_t *c)            { glEnable(c->r0); }
static void h_glDisable(hle_t *c)           { glDisable(c->r0); }
static void h_glClear(hle_t *c)             { glClear(c->r0); }
static void h_glClearColor(hle_t *c) {
    float r, g, b, a;
    memcpy(&r, &c->r0, 4); memcpy(&g, &c->r1, 4); memcpy(&b, &c->r2, 4); memcpy(&a, &c->r3, 4);
    glClearColor(r, g, b, a);
}
static void h_glViewport(hle_t *c) {
    int ox = 0, oy = 0;
    window_get_origin(&ox, &oy);
    if (s_bound_fbo == 0) glViewport(c->r0 + ox, c->r1 + oy, c->r2, c->r3);
    else glViewport(c->r0, c->r1, c->r2, c->r3);
}
static void h_glMatrixMode(hle_t *c)        { glMatrixMode(c->r0); }
static void h_glLoadIdentity(hle_t *c)      { (void)c; glLoadIdentity(); }
static void h_glGenTextures(hle_t *c) {
    GLuint *tex = (GLuint*)guest_to_host(c->r1);
    if (tex) glGenTextures(c->r0, tex);
}
static void h_glDeleteTextures(hle_t *c) {
    const GLuint *tex = (const GLuint*)guest_to_host(c->r1);
    if (tex) glDeleteTextures(c->r0, tex);
}
static void h_glTexParameteri(hle_t *c)     { glTexParameteri(c->r0, c->r1, c->r2); }
static void h_glDrawArrays(hle_t *c)        { glDrawArrays(c->r0, c->r1, c->r2); }
static void h_glDrawElements(hle_t *c)      { glDrawElements(c->r0, c->r1, c->r2, guest_ptr(c->r3, 1)); }
static void h_glEnableClientState(hle_t *c) { glEnableClientState(c->r0); }
static void h_glDisableClientState(hle_t *c){ glDisableClientState(c->r0); }
static void h_glVertexPointer(hle_t *c)     { glVertexPointer(c->r0, c->r1, c->r2, guest_ptr(c->r3, 1)); }
static void h_glTexCoordPointer(hle_t *c)   { glTexCoordPointer(c->r0, c->r1, c->r2, guest_ptr(c->r3, 1)); }
static void h_glColorPointer(hle_t *c)      { glColorPointer(c->r0, c->r1, c->r2, guest_ptr(c->r3, 1)); }
static void h_glLoadMatrixf(hle_t *c)       { void *p = guest_ptr(c->r0, 64); if (p) glLoadMatrixf((const GLfloat *)p); }
static void h_glBlendFunc(hle_t *c)         { glBlendFunc(c->r0, c->r1); }
static void h_glCullFace(hle_t *c)          { glCullFace(c->r0); }
static void h_glDepthFunc(hle_t *c)         { glDepthFunc(c->r0); }
static void h_glDepthMask(hle_t *c)         { glDepthMask((GLboolean)c->r0); }
static void h_glDepthRangef(hle_t *c) {
    float n, f; memcpy(&n, &c->r0, 4); memcpy(&f, &c->r1, 4); glDepthRangef(n, f);
}
static void h_glDepthRangex(hle_t *c)       { glDepthRangex(c->r0, c->r1); }
static void h_glClearDepthf(hle_t *c)       { float d; memcpy(&d, &c->r0, 4); glClearDepthf(d); }
static void h_glScissor(hle_t *c) {
    int ox = 0, oy = 0;
    window_get_origin(&ox, &oy);
    if (s_bound_fbo == 0) glScissor(c->r0 + ox, c->r1 + oy, c->r2, c->r3);
    else glScissor(c->r0, c->r1, c->r2, c->r3);
}
static void h_glShadeModel(hle_t *c)        { glShadeModel(c->r0); }
static void h_glAlphaFunc(hle_t *c) {
    float ref; memcpy(&ref, &c->r1, 4); glAlphaFunc(c->r0, ref);
}
static void h_glAlphaFuncx(hle_t *c)        { glAlphaFuncx(c->r0, c->r1); }
static void h_glColor4f(hle_t *c) {
    float r, g, b, a;
    memcpy(&r, &c->r0, 4); memcpy(&g, &c->r1, 4); memcpy(&b, &c->r2, 4); memcpy(&a, &c->r3, 4);
    glColor4f(r, g, b, a);
}
static void h_glColor4x(hle_t *c)           { glColor4x(c->r0, c->r1, c->r2, c->r3); }
static void h_glColorMask(hle_t *c)         { glColorMask(c->r0, c->r1, c->r2, c->r3); }
static void h_glScalex(hle_t *c)            { glScalex(c->r0, c->r1, c->r2); }
static void h_glTexEnvx(hle_t *c)           { glTexEnvx(c->r0, c->r1, c->r2); }
static void h_glActiveTexture(hle_t *c)     { glActiveTexture(c->r0); }
static void h_glClientActiveTexture(hle_t *c){ glClientActiveTexture(c->r0); }
static void h_glFrontFace(hle_t *c)         { glFrontFace(c->r0); }
static void h_glHint(hle_t *c)              { glHint(c->r0, c->r1); }
static void h_glPixelStorei(hle_t *c)       { glPixelStorei(c->r0, c->r1); }
static void h_glPolygonOffset(hle_t *c)     { float f, u; memcpy(&f, &c->r0, 4); memcpy(&u, &c->r1, 4); glPolygonOffset(f, u); }
static void h_glClearStencil(hle_t *c)      { glClearStencil(c->r0); }
static void h_glStencilMask(hle_t *c)       { glStencilMask(c->r0); }
static void h_glGetIntegerv(hle_t *c) {
    GLint *p = (GLint*)guest_to_host(c->r1);
    if (p) glGetIntegerv(c->r0, p);
}
static void h_glGetError(hle_t *c)          { c->r0 = glGetError(); }
static void h_glGetString(hle_t *c) {
    const GLubyte *s = glGetString(c->r0);
    if (s) {
        uint32_t len = (uint32_t)strlen((const char*)s) + 1;
        c->r0 = guest_alloc(len);
        char *dst = (char*)guest_to_host(c->r0);
        if (dst) memcpy(dst, s, len);
    } else {
        c->r0 = 0;
    }
}
static void h_glBindBuffer(hle_t *c)        { glBindBuffer(c->r0, c->r1); }
static void h_glTexImage2D(hle_t *c) {
    uint32_t sp_args[5];
    guest_mem_read(c->sp, sp_args, sizeof(sp_args));
    void *pix = guest_to_host(sp_args[4]);
    glTexImage2D(c->r0, c->r1, c->r2, c->r3, sp_args[0], sp_args[1], sp_args[2], sp_args[3], pix);
}
static void h_glCompressedTexImage2D(hle_t *c) {
    uint32_t sp_args[4];
    guest_mem_read(c->sp, sp_args, sizeof(sp_args));
    void *data = guest_to_host(sp_args[3]);
    glCompressedTexImage2D(c->r0, c->r1, c->r2, c->r3, sp_args[0], sp_args[1], sp_args[2], data);
}
static void h_glCopyTexImage2D(hle_t *c) {
    uint32_t sp_args[4];
    guest_mem_read(c->sp, sp_args, sizeof(sp_args));
    glCopyTexImage2D(c->r0, c->r1, c->r2, c->r3, sp_args[0], sp_args[1], sp_args[2], sp_args[3]);
}
static void h_glReadPixels(hle_t *c) {
    uint32_t sp_args[3];
    guest_mem_read(c->sp, sp_args, sizeof(sp_args));
    void *pixels = guest_to_host(sp_args[2]);
    glReadPixels(c->r0, c->r1, c->r2, c->r3, sp_args[0], sp_args[1], pixels);
}
static void h_glGenRenderbuffersOES(hle_t *c) {
    GLuint *p = (GLuint*)guest_to_host(c->r1);
    if (p) glGenRenderbuffersOES(c->r0, p);
}
static void h_glDeleteRenderbuffersOES(hle_t *c) {
    const GLuint *p = (const GLuint*)guest_to_host(c->r1);
    if (p) glDeleteRenderbuffersOES(c->r0, p);
}
static void h_glBindRenderbufferOES(hle_t *c) {
    glBindRenderbufferOES(c->r0, c->r1);
}
static void h_glRenderbufferStorageOES(hle_t *c) {
    glRenderbufferStorageOES(c->r0, c->r1, c->r2, c->r3);
}
static void h_glGenFramebuffersOES(hle_t *c) {
    GLuint *p = (GLuint*)guest_to_host(c->r1);
    if (p) glGenFramebuffersOES(c->r0, p);
}
static void h_glDeleteFramebuffersOES(hle_t *c) {
    const GLuint *p = (const GLuint*)guest_to_host(c->r1);
    if (p) glDeleteFramebuffersOES(c->r0, p);
}
static void h_glBindFramebufferOES(hle_t *c) {
    s_bound_fbo = c->r1;
    glBindFramebufferOES(c->r0, c->r1);
}
static void h_glFramebufferTexture2DOES(hle_t *c) {
    uint32_t sp_args[1];
    guest_mem_read(c->sp, sp_args, 4);
    glFramebufferTexture2DOES(c->r0, c->r1, c->r2, c->r3, sp_args[0]);
}
static void h_glFramebufferRenderbufferOES(hle_t *c) {
    glFramebufferRenderbufferOES(c->r0, c->r1, c->r2, c->r3);
}
static void h_glCheckFramebufferStatusOES(hle_t *c) {
    c->r0 = glCheckFramebufferStatusOES(c->r0);
}
#else
static void h_gl_stub(hle_t *c) { c->r0 = 0; }
#endif

static const struct { const char *name; hle_fn fn; } s_hle_defs[] = {
    // Memory
    {"malloc", h_malloc}, {"free", h_free}, {"calloc", h_calloc}, {"realloc", h_realloc},
    {"memcpy", h_memcpy}, {"memmove", h_memcpy}, {"memset", h_memset}, {"memcmp", h_memcmp},
    {"memchr", h_memchr}, {"strlen", h_strlen}, {"strcmp", h_strcmp}, {"strncmp", h_strncmp},
    {"strcasecmp", h_strcasecmp}, {"strncasecmp", h_strncasecmp}, {"strcpy", h_strcpy},
    {"strncpy", h_strncpy}, {"strcat", h_strcat}, {"strncat", h_strncat}, {"strchr", h_strchr},
    {"strrchr", h_strrchr}, {"strstr", h_strstr}, {"strdup", h_strdup}, {"strspn", h_strspn},
    {"strcspn", h_strcspn}, {"wcslen", h_wcslen},

    // Formatting & numbers
    {"sprintf", h_sprintf}, {"snprintf", h_snprintf}, {"vsprintf", h_vsprintf}, {"vsnprintf", h_vsnprintf},
    {"sscanf", h_sscanf}, {"atoi", h_atoi}, {"atoll", h_atoll}, {"strtod", h_strtod}, {"strtok", h_strtok},

    // Time & Math
    {"clock", h_clock}, {"time", h_time}, {"gettimeofday", h_gettimeofday}, {"clock_gettime", h_clock_gettime},
    {"difftime", h_difftime}, {"localtime", h_localtime}, {"gmtime", h_gmtime}, {"mktime", h_mktime},
    {"ctime", h_ctime}, {"strftime", h_strftime}, {"strptime", h_strptime},
    {"sinf", h_sinf}, {"cosf", h_cosf}, {"sqrtf", h_sqrtf}, {"atan2f", h_atan2f},
    {"atanf", h_atanf}, {"asinf", h_asinf}, {"acosf", h_acosf}, {"floorf", h_floorf},
    {"ceilf", h_ceilf}, {"modff", h_modff},

    // Threading & synchronization stubs
    {"pthread_mutex_init", h_ret0}, {"pthread_mutex_destroy", h_ret0},
    {"pthread_mutex_lock", h_ret0}, {"pthread_mutex_unlock", h_ret0},

    // C++ runtime, guards, exceptions & unwinding
    {"__cxa_guard_acquire", h_cxa_guard_acquire}, {"__cxa_guard_release", h_cxa_guard_release},
    {"__cxa_pure_virtual", h_cxa_pure_virtual}, {"__cxa_atexit", h_ret0}, {"atexit", h_ret0},
    {"__cxa_finalize", h_ret0}, {"__gnu_Unwind_Find_exidx", h_ret0}, {"__cxa_begin_cleanup", h_ret0},
    {"__cxa_type_match", h_ret0}, {"__errno", hle_errno}, {"srand48", h_srand48}, {"lrand48", h_lrand48},

    // Filesystem
    {"fopen", h_fopen}, {"fclose", h_fclose}, {"fread", h_fread}, {"fwrite", h_fwrite},
    {"fseek", h_fseek}, {"ftell", h_ftell}, {"rewind", h_rewind}, {"stat", h_stat},
    {"remove", h_remove}, {"rename", h_rename}, {"opendir", h_opendir}, {"readdir", h_readdir},
    {"closedir", h_closedir}, {"mkdir", h_mkdir}, {"rmdir", h_rmdir},

    // Abort & signals
    {"abort", h_abort}, {"raise", h_abort},

    // Network & POSIX stubs
    {"socket", h_retm1}, {"bind", h_net_fail}, {"connect", h_net_fail}, {"send", h_net_fail},
    {"recv", h_net_fail}, {"sendto", h_net_fail}, {"recvfrom", h_net_fail}, {"setsockopt", h_ret0},
    {"getsockopt", h_ret0}, {"getsockname", h_ret0}, {"gethostbyname", h_gethostbyname},
    {"gethostbyaddr", h_ret0}, {"inet_addr", h_retm1}, {"inet_ntoa", h_ret0}, {"gethostname", h_ret0},
    {"shutdown", h_ret0}, {"close", h_ret0}, {"usleep", h_ret0}, {"puts", h_ret0}, {"fprintf", h_ret0},
    {"fdopen", h_ret0}, {"dup", h_retm1}, {"select", h_ret0}, {"ioctl", h_ret0}, {"mkstemp", h_retm1},
    {"qsort", h_ret0},

    // Android logging
    {"__android_log_print", h_android_log_print}, {"__android_log_assert", h_android_log_print},
    {"__android_log_vprint", h_android_log_print},

#ifdef __ANDROID__
    // OpenGL ES 1.x & OES extensions
    {"glBindTexture", h_glBindTexture}, {"glEnable", h_glEnable}, {"glDisable", h_glDisable},
    {"glClear", h_glClear}, {"glClearColor", h_glClearColor}, {"glViewport", h_glViewport},
    {"glMatrixMode", h_glMatrixMode}, {"glLoadIdentity", h_glLoadIdentity},
    {"glGenTextures", h_glGenTextures}, {"glDeleteTextures", h_glDeleteTextures},
    {"glTexParameteri", h_glTexParameteri}, {"glDrawArrays", h_glDrawArrays},
    {"glDrawElements", h_glDrawElements}, {"glEnableClientState", h_glEnableClientState},
    {"glDisableClientState", h_glDisableClientState}, {"glVertexPointer", h_glVertexPointer},
    {"glTexCoordPointer", h_glTexCoordPointer}, {"glColorPointer", h_glColorPointer},
    {"glLoadMatrixf", h_glLoadMatrixf}, {"glBlendFunc", h_glBlendFunc}, {"glCullFace", h_glCullFace},
    {"glDepthFunc", h_glDepthFunc}, {"glDepthMask", h_glDepthMask}, {"glDepthRangef", h_glDepthRangef},
    {"glDepthRangex", h_glDepthRangex}, {"glClearDepthf", h_glClearDepthf}, {"glScissor", h_glScissor},
    {"glShadeModel", h_glShadeModel}, {"glAlphaFunc", h_glAlphaFunc}, {"glAlphaFuncx", h_glAlphaFuncx},
    {"glColor4f", h_glColor4f}, {"glColor4x", h_glColor4x}, {"glColorMask", h_glColorMask},
    {"glScalex", h_glScalex}, {"glTexEnvx", h_glTexEnvx}, {"glActiveTexture", h_glActiveTexture},
    {"glClientActiveTexture", h_glClientActiveTexture}, {"glFrontFace", h_glFrontFace},
    {"glHint", h_glHint}, {"glPixelStorei", h_glPixelStorei}, {"glPolygonOffset", h_glPolygonOffset},
    {"glClearStencil", h_glClearStencil}, {"glStencilMask", h_glStencilMask},
    {"glGetIntegerv", h_glGetIntegerv}, {"glGetError", h_glGetError}, {"glGetString", h_glGetString},
    {"glBindBuffer", h_glBindBuffer}, {"glTexImage2D", h_glTexImage2D},
    {"glCompressedTexImage2D", h_glCompressedTexImage2D}, {"glCopyTexImage2D", h_glCopyTexImage2D},
    {"glReadPixels", h_glReadPixels},
    {"glGenRenderbuffersOES", h_glGenRenderbuffersOES}, {"glDeleteRenderbuffersOES", h_glDeleteRenderbuffersOES},
    {"glBindRenderbufferOES", h_glBindRenderbufferOES}, {"glRenderbufferStorageOES", h_glRenderbufferStorageOES},
    {"glGenFramebuffersOES", h_glGenFramebuffersOES}, {"glDeleteFramebuffersOES", h_glDeleteFramebuffersOES},
    {"glBindFramebufferOES", h_glBindFramebufferOES}, {"glFramebufferTexture2DOES", h_glFramebufferTexture2DOES},
    {"glFramebufferRenderbufferOES", h_glFramebufferRenderbufferOES}, {"glCheckFramebufferStatusOES", h_glCheckFramebufferStatusOES},
#else
    // Host mock OpenGL stubs
    {"glBindTexture", h_gl_stub}, {"glEnable", h_gl_stub}, {"glDisable", h_gl_stub},
    {"glClear", h_gl_stub}, {"glClearColor", h_gl_stub}, {"glViewport", h_gl_stub},
    {"glMatrixMode", h_gl_stub}, {"glLoadIdentity", h_gl_stub},
    {"glGenTextures", h_gl_stub}, {"glDeleteTextures", h_gl_stub},
    {"glTexParameteri", h_gl_stub}, {"glDrawArrays", h_gl_stub},
    {"glDrawElements", h_gl_stub}, {"glEnableClientState", h_gl_stub},
    {"glDisableClientState", h_gl_stub}, {"glVertexPointer", h_gl_stub},
    {"glTexCoordPointer", h_gl_stub}, {"glColorPointer", h_gl_stub},
    {"glLoadMatrixf", h_gl_stub}, {"glBlendFunc", h_gl_stub}, {"glCullFace", h_gl_stub},
    {"glDepthFunc", h_gl_stub}, {"glDepthMask", h_gl_stub}, {"glDepthRangef", h_gl_stub},
    {"glDepthRangex", h_gl_stub}, {"glClearDepthf", h_gl_stub}, {"glScissor", h_gl_stub},
    {"glShadeModel", h_gl_stub}, {"glAlphaFunc", h_gl_stub}, {"glAlphaFuncx", h_gl_stub},
    {"glColor4f", h_gl_stub}, {"glColor4x", h_gl_stub}, {"glColorMask", h_gl_stub},
    {"glScalex", h_gl_stub}, {"glTexEnvx", h_gl_stub}, {"glActiveTexture", h_gl_stub},
    {"glClientActiveTexture", h_gl_stub}, {"glFrontFace", h_gl_stub},
    {"glHint", h_gl_stub}, {"glPixelStorei", h_gl_stub}, {"glPolygonOffset", h_gl_stub},
    {"glClearStencil", h_gl_stub}, {"glStencilMask", h_gl_stub},
    {"glGetIntegerv", h_gl_stub}, {"glGetError", h_gl_stub}, {"glGetString", h_gl_stub},
    {"glBindBuffer", h_gl_stub}, {"glTexImage2D", h_gl_stub},
    {"glCompressedTexImage2D", h_gl_stub}, {"glCopyTexImage2D", h_gl_stub},
    {"glReadPixels", h_gl_stub},
    {"glGenRenderbuffersOES", h_gl_stub}, {"glDeleteRenderbuffersOES", h_gl_stub},
    {"glBindRenderbufferOES", h_gl_stub}, {"glRenderbufferStorageOES", h_gl_stub},
    {"glGenFramebuffersOES", h_gl_stub}, {"glDeleteFramebuffersOES", h_gl_stub},
    {"glBindFramebufferOES", h_gl_stub}, {"glFramebufferTexture2DOES", h_gl_stub},
    {"glFramebufferRenderbufferOES", h_gl_stub}, {"glCheckFramebufferStatusOES", h_gl_stub},
#endif
};

void hle_init(void) {
    memset(s_hle_table, 0, sizeof(s_hle_table));
    for (size_t i = 0; i < sizeof(s_hle_defs) / sizeof(s_hle_defs[0]); i++) {
        int idx = hle_find_plt_index(s_hle_defs[i].name);
        if (idx >= 0) {
            s_hle_table[idx] = s_hle_defs[i].fn;
        } else {
            LOGE("hle_init: '%s' not found in s_plt_names", s_hle_defs[i].name);
        }
    }
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
