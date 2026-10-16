#ifndef DYNARMIC_BACKEND_H
#define DYNARMIC_BACKEND_H

#include <stdint.h>
#include <stdbool.h>

#ifdef __cplusplus
extern "C" {
#endif

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

#ifdef __cplusplus
}
#endif

#endif // DYNARMIC_BACKEND_H
