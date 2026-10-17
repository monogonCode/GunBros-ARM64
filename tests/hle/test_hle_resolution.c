#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
#include <stdbool.h>

#include "gunbros/emulator/hle_dispatcher.h"

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

    printf("=== All Dynamic Import Resolution tests PASSED! ===\n");
    return 0;
}
