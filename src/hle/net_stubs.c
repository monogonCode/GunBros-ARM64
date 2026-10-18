#include "hle_internal.h"
#include <unistd.h>
#include <pthread.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <netdb.h>

#ifdef __ANDROID__
#include <android/log.h>
#endif

/* ---------------- Abort / Halt ---------------- */
static void h_abort(hle_t *c) {
    LOGE("guest abort()/raise() lr=0x%x r0=0x%x", c->lr, c->r0);
    dynarmic_backend_halt();
}

/* ---------------- Network Stubs (Dead Glu Endpoints) ---------------- */
static void h_net_fail(hle_t *c) { set_guest_errno(ENETUNREACH); c->r0 = (uint32_t)-1; }
static void h_ret0(hle_t *c)     { c->r0 = 0; }
static void h_retm1(hle_t *c)    { c->r0 = (uint32_t)-1; }

static void log_stub_call_once(const char *name, uint32_t lr, const char *extra) {
    #define MAX_STUB_SEEN 64
    static struct { const char *name; uint32_t lr; } s_seen[MAX_STUB_SEEN];
    static int s_seen_count = 0;

    for (int i = 0; i < s_seen_count; i++) {
        if (s_seen[i].name == name && s_seen[i].lr == lr) return;
    }
    if (s_seen_count < MAX_STUB_SEEN) {
        s_seen[s_seen_count].name = name;
        s_seen[s_seen_count].lr = lr;
        s_seen_count++;
    }

    if (extra && extra[0]) {
        LOGI("[STUB:%s] called from guest lr=0x%08x: %s", name, lr, extra);
    } else {
        LOGI("[STUB:%s] called from guest lr=0x%08x", name, lr);
    }
}

static void h_stub_fprintf(hle_t *c) {
    uint32_t stream_val = c->r0;
    const char *fmt = (const char*)guest_to_host(c->r1);
    char extra[256];
    bool is_std = (stream_val == 1 || stream_val == 2);
    if ((void*)(uintptr_t)stream_val == (void*)stdout || (void*)(uintptr_t)stream_val == (void*)stderr) {
        is_std = true;
    }

    if (!is_std) {
        snprintf(extra, sizeof(extra), "NON-STANDARD stream fp=0x%x (fmt='%s') - possible lost data write!",
                 stream_val, fmt ? fmt : "NULL");
        LOGE("[STUB:fprintf] NON-STANDARD stream fp=0x%x (fmt='%s') lr=0x%x - possible lost data write!",
             stream_val, fmt ? fmt : "NULL", c->lr);
    } else {
        snprintf(extra, sizeof(extra), "stream=std (fp=0x%x, fmt='%s')", stream_val, fmt ? fmt : "NULL");
    }
    log_stub_call_once("fprintf", c->lr, extra);
    c->r0 = 0;
}

static void h_stub_fdopen(hle_t *c) {
    int fd = (int)c->r0;
    const char *mode = (const char*)guest_to_host(c->r1);
    char extra[128];
    bool is_std = (fd == 0 || fd == 1 || fd == 2);
    if (!is_std) {
        snprintf(extra, sizeof(extra), "NON-STANDARD fd=%d mode='%s' - possible lost data file!",
                 fd, mode ? mode : "NULL");
        LOGE("[STUB:fdopen] NON-STANDARD fd=%d mode='%s' lr=0x%x - possible lost data file!",
             fd, mode ? mode : "NULL", c->lr);
    } else {
        snprintf(extra, sizeof(extra), "fd=%d mode='%s'", fd, mode ? mode : "NULL");
    }
    log_stub_call_once("fdopen", c->lr, extra);
    c->r0 = 0;
}

static void h_stub_puts(hle_t *c) {
    const char *str = (const char*)guest_to_host(c->r0);
    char extra[128] = {0};
    if (str) snprintf(extra, sizeof(extra), "msg='%.64s'", str);
    log_stub_call_once("puts", c->lr, extra);
#ifdef __ANDROID__
    if (str) __android_log_print(ANDROID_LOG_INFO, LOG_TAG, "[GUEST:puts] %s", str);
#else
    if (str) printf("[GUEST:puts] %s\n", str);
#endif
    c->r0 = 0;
}

static void h_stub_close(hle_t *c) {
    char extra[64];
    snprintf(extra, sizeof(extra), "fd=%d", (int)c->r0);
    log_stub_call_once("close", c->lr, extra);
    c->r0 = 0;
}

static void h_stub_dup(hle_t *c) {
    char extra[64];
    snprintf(extra, sizeof(extra), "fd=%d", (int)c->r0);
    log_stub_call_once("dup", c->lr, extra);
    set_guest_errno(EBADF);
    c->r0 = (uint32_t)-1;
}

static void h_stub_ioctl(hle_t *c) {
    char extra[64];
    snprintf(extra, sizeof(extra), "fd=%d req=0x%x", (int)c->r0, c->r1);
    log_stub_call_once("ioctl", c->lr, extra);
    c->r0 = 0;
}

static void h_stub_mkstemp(hle_t *c) {
    const char *tmpl = (const char*)guest_to_host(c->r0);
    char extra[128];
    snprintf(extra, sizeof(extra), "template='%s'", tmpl ? tmpl : "NULL");
    log_stub_call_once("mkstemp", c->lr, extra);
    set_guest_errno(EACCES);
    c->r0 = (uint32_t)-1;
}

static void h_gethostbyname(hle_t *c) {
    const char *host = (const char*)guest_to_host(c->r0);
    if (host && strstr(host, "glu.com") != NULL) {
        log_stub_call_once("gethostbyname:dead_glu_endpoint", c->lr, host);
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

const hle_def_t g_hle_net_stubs_defs[] = {
    // Threading & synchronization stubs
    {"pthread_mutex_init", h_ret0}, {"pthread_mutex_destroy", h_ret0},
    {"pthread_mutex_lock", h_ret0}, {"pthread_mutex_unlock", h_ret0},

    // C++ runtime, guards, exceptions & unwinding
    {"__cxa_guard_acquire", h_cxa_guard_acquire}, {"__cxa_guard_release", h_cxa_guard_release},
    {"__cxa_pure_virtual", h_cxa_pure_virtual}, {"__cxa_call_unexpected", h_cxa_pure_virtual},
    {"__cxa_atexit", h_ret0}, {"atexit", h_ret0},
    {"__cxa_finalize", h_ret0}, {"__gnu_Unwind_Find_exidx", h_ret0}, {"__cxa_begin_cleanup", h_ret0},
    {"__cxa_type_match", h_ret0}, {"__errno", hle_errno},

    // Abort & signals
    {"abort", h_abort}, {"raise", h_abort},

    // Network & POSIX stubs
    {"socket", h_retm1}, {"bind", h_net_fail}, {"connect", h_net_fail}, {"send", h_net_fail},
    {"recv", h_net_fail}, {"sendto", h_net_fail}, {"recvfrom", h_net_fail}, {"setsockopt", h_ret0},
    {"getsockopt", h_ret0}, {"getsockname", h_ret0}, {"gethostbyname", h_gethostbyname},
    {"gethostbyaddr", h_ret0}, {"inet_addr", h_retm1}, {"inet_ntoa", h_ret0}, {"gethostname", h_ret0},
    {"shutdown", h_ret0}, {"close", h_stub_close}, {"usleep", h_ret0}, {"puts", h_stub_puts}, {"fprintf", h_stub_fprintf},
    {"fdopen", h_stub_fdopen}, {"dup", h_stub_dup}, {"select", h_ret0}, {"ioctl", h_stub_ioctl}, {"mkstemp", h_stub_mkstemp},
    {"qsort", h_ret0},

    // Android logging
    {"__android_log_print", h_android_log_print}, {"__android_log_assert", h_android_log_print},
    {"__android_log_vprint", h_android_log_print},
};

const size_t g_hle_net_stubs_defs_count = sizeof(g_hle_net_stubs_defs) / sizeof(g_hle_net_stubs_defs[0]);
