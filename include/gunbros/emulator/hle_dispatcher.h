#ifndef GUNBROS_HLE_DISPATCHER_H
#define GUNBROS_HLE_DISPATCHER_H

#include "gunbros/common/common.h"

GUNBROS_EXTERN_C_BEGIN

#define MAX_HLE_STUBS 512
#define N_PLT MAX_HLE_STUBS
#define STOP_ADDR 0x8000e000u

typedef enum {
    RUN_OK = 0,
    RUN_PREEMPTED,
    RUN_ERROR,
    RUN_DEAD
} run_result_t;

typedef struct {
    void *uc;
    uint32_t r0, r1, r2, r3, sp, lr, pc;
    uint32_t out_r1;
    bool     set_r1;
} hle_t;

typedef void (*hle_fn)(hle_t *c);

typedef struct {
    const char *name;
    hle_fn fn;
} hle_def_t;

void hle_init(void);
void hle_register_module(const hle_def_t *defs, size_t count);
int  hle_resolve_import(const char *name);
int  hle_find_plt_index(const char *name);
const char* hle_get_plt_name(int idx);

void on_dynarmic_svc(uint32_t swi);
run_result_t run_guest(uint32_t entry, const char *tag);
void prepare_call_arm(uint32_t arg0);
void start_watchdog_once(void);

GUNBROS_EXTERN_C_END

#endif // GUNBROS_HLE_DISPATCHER_H
