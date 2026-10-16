#ifndef GUNBROS_GUEST_MEMORY_H
#define GUNBROS_GUEST_MEMORY_H

#include "gunbros/common/common.h"

GUNBROS_EXTERN_C_BEGIN

#define GUEST_CODE_BASE     0x00000000u
#define GUEST_CODE_SIZE     0x00600000u // 6 MB

#define GUEST_HEAP_BASE     0x60000000u
#define GUEST_HEAP_SIZE     0x10000000u // 256 MB
#define GUEST_HEAP_END      0x70000000u

#define GUEST_STACK_BASE    0x70000000u
#define GUEST_STACK_SIZE    0x00800000u // 8 MB
#define GUEST_STACK_TOP     0x707ff000u

#define GUEST_STUBS_BASE    0x80000000u
#define GUEST_STUBS_SIZE    0x00010000u // 64 KB

#define GUEST_COMMPAGE_BASE 0xffff0000u
#define GUEST_COMMPAGE_SIZE 0x00010000u // 64 KB

#define GUEST_ERRNO_ADDR    0x60007020u

bool guest_memory_init(void);
void guest_memory_setup_commpage(void);
void guest_memory_release(void);

uint8_t* guest_memory_get_code(void);
uint8_t* guest_memory_get_heap(void);
uint8_t* guest_memory_get_stack(void);
uint8_t* guest_memory_get_stubs(void);
uint8_t* guest_memory_get_commpage(void);

void* guest_to_host(uint32_t addr);
uint32_t host_to_guest(const void *p);
bool guest_range_ok(uint32_t addr, uint32_t len);
void* guest_ptr(uint32_t addr, uint32_t len);
void guest_mem_read(uint32_t addr, void *dst, size_t sz);
void guest_mem_write(uint32_t addr, const void *src, size_t sz);
void set_guest_errno(int err);

uint32_t guest_alloc(uint32_t sz);
void guest_free(uint32_t ptr);
uint32_t guest_cap(uint32_t ptr);

GUNBROS_EXTERN_C_END

#endif // GUNBROS_GUEST_MEMORY_H
