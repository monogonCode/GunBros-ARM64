#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
#include <stdbool.h>

#include "gunbros/emulator/hle_dispatcher.h"
#include "gunbros/emulator/guest_memory.h"
#include <sys/socket.h>
#include <sys/select.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <netdb.h>
#include <unistd.h>

#define TEST_PASS(name) printf("  [PASS] %s\n", name)
#define TEST_FAIL(name, msg) do { printf("  [FAIL] %s: %s\n", name, msg); exit(1); } while(0)
#define ASSERT_TRUE(cond, name, msg) do { if (!(cond)) TEST_FAIL(name, msg); } while(0)
#define ASSERT_EQ(a, b, name, msg) do { if ((a) != (b)) { printf("Expected %ld got %ld\n", (long)(b), (long)(a)); TEST_FAIL(name, msg); } } while(0)
#define ASSERT_STR_EQ(a, b, name, msg) do { if (strcmp((a), (b)) != 0) { printf("Expected '%s' got '%s'\n", (b), (a)); TEST_FAIL(name, msg); } } while(0)

// Stubs for linker dependencies not exercised in this test
uint32_t dynarmic_backend_get_reg(size_t reg) { (void)reg; return 0; }
void dynarmic_backend_set_reg(size_t reg, uint32_t val) { (void)reg; (void)val; }
void dynarmic_backend_set_cpsr(uint32_t cpsr) { (void)cpsr; }
bool dynarmic_backend_is_active(void) { return false; }
int dynarmic_backend_run(void) { return 0; }
void dynarmic_backend_halt(void) { }
void handle_jvm_call(int idx, uint32_t *r0, uint32_t *r1, uint32_t *r2, uint32_t *r3, uint32_t sp, uint32_t lr) {
    (void)idx; (void)r0; (void)r1; (void)r2; (void)r3; (void)sp; (void)lr;
}
void handle_jni_call(int idx, uint32_t *r0, uint32_t *r1, uint32_t *r2, uint32_t *r3, uint32_t sp, uint32_t lr) {
    (void)idx; (void)r0; (void)r1; (void)r2; (void)r3; (void)sp; (void)lr;
}

// Full list of 178 imports from legacy s_plt_names in legacy-archive
static const char *s_legacy_imports[] = {
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

#define NUM_LEGACY_IMPORTS (sizeof(s_legacy_imports) / sizeof(s_legacy_imports[0]))

static void call_hle(const char *name, hle_t *c) {
    int idx = hle_find_plt_index(name);
    ASSERT_TRUE(idx >= 0, name, "PLT index not found");
    hle_fn fn = hle_get_handler(idx);
    ASSERT_TRUE(fn != NULL, name, "handler is NULL");
    fn(c);
}

static void test_network_passthrough(void) {
    printf("--- Testing BSD Sockets & OpenSpy HLE Passthrough ---\n");
    guest_memory_init();

    hle_t c = {0};

    // 1. inet_addr
    uint32_t g_ip_str = 0x60010000;
    strcpy((char*)guest_to_host(g_ip_str), "127.0.0.1");
    c.r0 = g_ip_str;
    call_hle("inet_addr", &c);
    uint32_t parsed_ip = c.r0;
    ASSERT_EQ(parsed_ip, inet_addr("127.0.0.1"), "inet_addr", "127.0.0.1 mismatch");

    // 2. inet_ntoa
    c.r0 = parsed_ip;
    call_hle("inet_ntoa", &c);
    ASSERT_TRUE(c.r0 != 0, "inet_ntoa", "returned NULL");
    const char *ntoa_str = (const char*)guest_to_host(c.r0);
    ASSERT_STR_EQ(ntoa_str, "127.0.0.1", "inet_ntoa", "dotted quad mismatch");
    TEST_PASS("inet_addr & inet_ntoa conversion");

    // 3. gethostbyname with glu.com (blocked)
    uint32_t g_glu = 0x60010020;
    strcpy((char*)guest_to_host(g_glu), "dead.glu.com");
    c.r0 = g_glu;
    call_hle("gethostbyname", &c);
    ASSERT_EQ(c.r0, 0, "gethostbyname_glu", "glu.com was not blocked");
    TEST_PASS("gethostbyname blocks dead glu.com endpoint");

    // 4. gethostbyname with 127.0.0.1
    uint32_t g_host = 0x60010040;
    strcpy((char*)guest_to_host(g_host), "127.0.0.1");
    c.r0 = g_host;
    call_hle("gethostbyname", &c);
    ASSERT_EQ(c.r0, 0x60008000, "gethostbyname_he", "hostent not at 0x60008000");

    uint32_t *h32 = (uint32_t*)guest_to_host(0x60008000);
    ASSERT_EQ(h32[2], AF_INET, "gethostbyname_addrtype", "addrtype != AF_INET");
    ASSERT_EQ(h32[3], 4, "gethostbyname_len", "length != 4");
    uint32_t *addr_list = (uint32_t*)guest_to_host(h32[4]);
    ASSERT_TRUE(addr_list != NULL && addr_list[0] != 0, "gethostbyname_addrlist", "addr_list empty");
    uint32_t resolved_ip = *(uint32_t*)guest_to_host(addr_list[0]);
    ASSERT_EQ(resolved_ip, inet_addr("127.0.0.1"), "gethostbyname_ip", "resolved IP mismatch");
    TEST_PASS("gethostbyname formats guest hostent32 at 0x60008000");

    // 4b. gethostbyname with peerchat.openspy.net
    uint32_t g_openspy = 0x60010050;
    strcpy((char*)guest_to_host(g_openspy), "peerchat.openspy.net");
    c.r0 = g_openspy;
    call_hle("gethostbyname", &c);
    ASSERT_EQ(c.r0, 0x60008000, "gethostbyname_openspy", "peerchat.openspy.net resolution failed");
    TEST_PASS("gethostbyname resolves peerchat.openspy.net successfully");

    // 5. socket: create UDP socket
    c.r0 = AF_INET;
    c.r1 = SOCK_DGRAM;
    c.r2 = 0;
    call_hle("socket", &c);
    int fd = (int)c.r0;
    ASSERT_TRUE(fd >= 0, "socket_udp", "socket creation failed");

    // 6. setsockopt SO_REUSEADDR
    int optval = 1;
    uint32_t g_opt = 0x60010060;
    *(int*)guest_to_host(g_opt) = optval;
    uint32_t stack_sp = GUEST_STACK_BASE + 0x2000;
    *(uint32_t*)guest_to_host(stack_sp) = sizeof(optval);
    c.r0 = (uint32_t)fd;
    c.r1 = SOL_SOCKET;
    c.r2 = SO_REUSEADDR;
    c.r3 = g_opt;
    c.sp = stack_sp;
    call_hle("setsockopt", &c);
    ASSERT_EQ(c.r0, 0, "setsockopt_reuse", "SO_REUSEADDR failed");

    // 7. setsockopt SO_RCVTIMEO with 32-bit timeval
    uint32_t g_tv = 0x60010070;
    int32_t *gtv = (int32_t*)guest_to_host(g_tv);
    gtv[0] = 1; // 1 sec
    gtv[1] = 500000; // 500 ms
    *(uint32_t*)guest_to_host(stack_sp) = 8; // 8 bytes timeval32
    c.r0 = (uint32_t)fd;
    c.r1 = SOL_SOCKET;
    c.r2 = SO_RCVTIMEO;
    c.r3 = g_tv;
    c.sp = stack_sp;
    call_hle("setsockopt", &c);
    ASSERT_EQ(c.r0, 0, "setsockopt_rcvtimeo", "SO_RCVTIMEO failed");

    // 8. getsockopt SO_RCVTIMEO
    uint32_t g_tv_out = 0x60010080;
    uint32_t g_len_ptr = 0x60010090;
    *(uint32_t*)guest_to_host(g_len_ptr) = 8;
    *(uint32_t*)guest_to_host(stack_sp) = g_len_ptr;
    c.r0 = (uint32_t)fd;
    c.r1 = SOL_SOCKET;
    c.r2 = SO_RCVTIMEO;
    c.r3 = g_tv_out;
    c.sp = stack_sp;
    call_hle("getsockopt", &c);
    ASSERT_EQ(c.r0, 0, "getsockopt_rcvtimeo", "getsockopt SO_RCVTIMEO failed");
    int32_t *gtv_out = (int32_t*)guest_to_host(g_tv_out);
    ASSERT_EQ(gtv_out[0], 1, "getsockopt_sec", "tv_sec mismatch");
    ASSERT_EQ(gtv_out[1], 500000, "getsockopt_usec", "tv_usec mismatch");
    ASSERT_EQ(*(uint32_t*)guest_to_host(g_len_ptr), 8, "getsockopt_len", "len != 8");
    TEST_PASS("setsockopt & getsockopt with 32-bit timeval translation");

    // 9. bind UDP socket to 127.0.0.1:0
    uint32_t g_sin = 0x600100a0;
    struct sockaddr_in *sin = (struct sockaddr_in*)guest_to_host(g_sin);
    memset(sin, 0, sizeof(*sin));
    sin->sin_family = AF_INET;
    sin->sin_addr.s_addr = inet_addr("127.0.0.1");
    sin->sin_port = 0; // ephemeral
    c.r0 = (uint32_t)fd;
    c.r1 = g_sin;
    c.r2 = sizeof(struct sockaddr_in);
    call_hle("bind", &c);
    ASSERT_EQ(c.r0, 0, "bind_udp", "bind failed");

    // 10. getsockname
    uint32_t g_bound_sin = 0x600100c0;
    uint32_t g_bound_len = 0x600100e0;
    *(uint32_t*)guest_to_host(g_bound_len) = sizeof(struct sockaddr_in);
    c.r0 = (uint32_t)fd;
    c.r1 = g_bound_sin;
    c.r2 = g_bound_len;
    call_hle("getsockname", &c);
    ASSERT_EQ(c.r0, 0, "getsockname", "getsockname failed");
    struct sockaddr_in *bound = (struct sockaddr_in*)guest_to_host(g_bound_sin);
    ASSERT_TRUE(ntohs(bound->sin_port) > 0, "getsockname_port", "port == 0");
    uint16_t port = bound->sin_port;
    TEST_PASS("bind & getsockname ephemeral port assignment");

    // 11. select before send: should timeout with 0
    uint32_t g_rfds = 0x60010100;
    fd_set *rfds = (fd_set*)guest_to_host(g_rfds);
    FD_ZERO(rfds);
    FD_SET(fd, rfds);
    uint32_t g_sel_tv = 0x60010180;
    int32_t *sel_tv = (int32_t*)guest_to_host(g_sel_tv);
    sel_tv[0] = 0;
    sel_tv[1] = 1000; // 1 ms
    *(uint32_t*)guest_to_host(stack_sp) = g_sel_tv;
    c.r0 = (uint32_t)(fd + 1);
    c.r1 = g_rfds;
    c.r2 = 0;
    c.r3 = 0;
    c.sp = stack_sp;
    call_hle("select", &c);
    ASSERT_EQ(c.r0, 0, "select_timeout", "select didn't return 0 on timeout");

    // 12. sendto loopback
    uint32_t g_payload = 0x60010200;
    strcpy((char*)guest_to_host(g_payload), "GUNBROS_UDP_TEST");
    uint32_t g_dest = 0x60010220;
    struct sockaddr_in *dest = (struct sockaddr_in*)guest_to_host(g_dest);
    memset(dest, 0, sizeof(*dest));
    dest->sin_family = AF_INET;
    dest->sin_addr.s_addr = inet_addr("127.0.0.1");
    dest->sin_port = port;

    uint32_t *sp_args = (uint32_t*)guest_to_host(stack_sp);
    sp_args[0] = g_dest;
    sp_args[1] = sizeof(struct sockaddr_in);
    c.r0 = (uint32_t)fd;
    c.r1 = g_payload;
    c.r2 = 16;
    c.r3 = 0;
    c.sp = stack_sp;
    call_hle("sendto", &c);
    ASSERT_EQ(c.r0, 16, "sendto", "sendto failed");

    // 13. select after send: should return 1
    FD_ZERO(rfds);
    FD_SET(fd, rfds);
    sel_tv[0] = 1;
    sel_tv[1] = 0;
    sp_args[0] = g_sel_tv;
    c.r0 = (uint32_t)(fd + 1);
    c.r1 = g_rfds;
    c.r2 = 0;
    c.r3 = 0;
    c.sp = stack_sp;
    call_hle("select", &c);
    ASSERT_EQ(c.r0, 1, "select_readable", "select didn't report readable socket");

    // 14. recvfrom
    uint32_t g_recv_buf = 0x60010240;
    uint32_t g_from_addr = 0x60010280;
    uint32_t g_from_len = 0x600102a0;
    *(uint32_t*)guest_to_host(g_from_len) = sizeof(struct sockaddr_in);
    sp_args[0] = g_from_addr;
    sp_args[1] = g_from_len;
    c.r0 = (uint32_t)fd;
    c.r1 = g_recv_buf;
    c.r2 = 64;
    c.r3 = 0;
    c.sp = stack_sp;
    call_hle("recvfrom", &c);
    ASSERT_EQ(c.r0, 16, "recvfrom_len", "recvfrom did not receive 16 bytes");
    char *recv_msg = (char*)guest_to_host(g_recv_buf);
    recv_msg[16] = '\0';
    ASSERT_STR_EQ(recv_msg, "GUNBROS_UDP_TEST", "recvfrom_data", "payload mismatch");
    TEST_PASS("sendto & recvfrom UDP loopback communication");

    // 15. close
    c.r0 = (uint32_t)fd;
    call_hle("close", &c);
    ASSERT_EQ(c.r0, 0, "close", "close failed");
    TEST_PASS("close socket descriptor");
}

int main(void) {
    printf("=== Running Dynamic Import Resolution Test Suite ===\n");

    // 1. Initialize HLE table
    hle_init();
    TEST_PASS("hle_init completed");

    // 2. Verify all 178 legacy symbols resolve to valid slots with non-NULL handlers
    for (size_t i = 0; i < NUM_LEGACY_IMPORTS; i++) {
        const char *name = s_legacy_imports[i];
        int idx = hle_resolve_import(name);
        ASSERT_TRUE(idx >= 0, "resolve", "hle_resolve_import returned negative index");
        ASSERT_STR_EQ(hle_get_plt_name(idx), name, "plt_name", "hle_get_plt_name mismatch");

        hle_fn fn = hle_get_handler(idx);
        if (fn == NULL) {
            printf("  [ERROR] Symbol '%s' (idx %d) has NO registered HLE handler!\n", name, idx);
            TEST_FAIL("handler_check", "Legacy import missing concrete handler");
        }

        // Test caching / idempotency: second query must return exact same index
        int idx2 = hle_resolve_import(name);
        ASSERT_EQ(idx, idx2, "idempotency", "Repeated import resolution returned different slot index");
    }
    printf("  [INFO] Successfully verified %zu legacy symbols with non-NULL handlers\n", NUM_LEGACY_IMPORTS);
    TEST_PASS("All 178 legacy imports dynamically resolved and verified with non-NULL handlers");

    // 3. Test resolution of unmapped import
    const char *unmapped = "__unknown_guest_symbol_404__";
    int unk_idx = hle_resolve_import(unmapped);
    ASSERT_TRUE(unk_idx >= 0, "unmapped_resolve", "Unmapped symbol returned invalid index");
    ASSERT_STR_EQ(hle_get_plt_name(unk_idx), unmapped, "unmapped_name", "Unmapped symbol name mismatch");
    ASSERT_TRUE(hle_get_handler(unk_idx) == NULL, "unmapped_fn", "Unmapped symbol unexpectedly had non-NULL handler");
    TEST_PASS("Unmapped guest import safely assigned stub with NULL handler and warning");

    // 4. Test BSD Sockets & OpenSpy HLE Passthrough
    test_network_passthrough();

    printf("=== All Dynamic Import Resolution tests PASSED! ===\n");
    return 0;
}
