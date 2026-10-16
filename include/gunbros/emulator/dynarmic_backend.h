#ifndef GUNBROS_DYNARMIC_BACKEND_H
#define GUNBROS_DYNARMIC_BACKEND_H

#include "gunbros/common/common.h"

GUNBROS_EXTERN_C_BEGIN

typedef void* (*dynarmic_guest_to_host_fn)(uint32_t addr);
typedef void (*dynarmic_call_svc_fn)(uint32_t swi);

void dynarmic_backend_init(dynarmic_guest_to_host_fn g2h, dynarmic_call_svc_fn svc_cb);
void dynarmic_backend_map(uint32_t guest_addr, uint32_t size, void *host_ptr);
void dynarmic_backend_set_reg(int reg, uint32_t val);
uint32_t dynarmic_backend_get_reg(int reg);
void dynarmic_backend_set_cpsr(uint32_t val);
uint32_t dynarmic_backend_get_cpsr(void);
uint32_t dynarmic_backend_run(uint32_t entry);
void dynarmic_backend_halt(void);
bool dynarmic_backend_is_active(void);

GUNBROS_EXTERN_C_END

#endif // GUNBROS_DYNARMIC_BACKEND_H
