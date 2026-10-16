#ifndef GUNBROS_HLE_INTERNAL_H
#define GUNBROS_HLE_INTERNAL_H

#include "gunbros/emulator/hle_dispatcher.h"
#include "gunbros/emulator/guest_memory.h"
#include "gunbros/emulator/dynarmic_backend.h"
#include "gunbros/compatibility/jni_virtual_machine.h"
#include <string.h>

typedef struct {
    const char *name;
    hle_fn fn;
} hle_def_t;

static inline void hle_ret64(hle_t *c, uint64_t v) {
    c->r0 = (uint32_t)v;
    c->out_r1 = (uint32_t)(v >> 32);
    c->set_r1 = true;
}

static inline void hle_retdouble(hle_t *c, double d) {
    uint64_t u;
    memcpy(&u, &d, 8);
    hle_ret64(c, u);
}

static inline void hle_float_ret(hle_t *c, float f) { memcpy(&c->r0, &f, 4); }
static inline float hle_float_arg0(hle_t *c) { float f; memcpy(&f, &c->r0, 4); return f; }
static inline float hle_float_arg1(hle_t *c) { float f; memcpy(&f, &c->r1, 4); return f; }

extern const hle_def_t g_hle_libc_string_defs[];
extern const size_t   g_hle_libc_string_defs_count;

extern const hle_def_t g_hle_libc_time_defs[];
extern const size_t   g_hle_libc_time_defs_count;

extern const hle_def_t g_hle_libc_stdio_defs[];
extern const size_t   g_hle_libc_stdio_defs_count;

extern const hle_def_t g_hle_net_stubs_defs[];
extern const size_t   g_hle_net_stubs_defs_count;

extern const hle_def_t g_hle_gles1_defs[];
extern const size_t   g_hle_gles1_defs_count;

#endif // GUNBROS_HLE_INTERNAL_H
