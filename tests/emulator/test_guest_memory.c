#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>
#include "gunbros/emulator/guest_memory.h"

#define TEST_PASS(name) printf("  [PASS] %s\n", name)

int main(void) {
    printf("=== Running Guest Memory Subsystem Test Suite ===\n");

    bool ok = guest_memory_init();
    assert(ok == true);
    assert(guest_memory_get_code() != NULL);
    assert(guest_memory_get_heap() != NULL);
    assert(guest_memory_get_stubs() != NULL);
    TEST_PASS("guest_memory_init allocated virtual space");

    // Test 1: Translation inside guest RAM / Code [0x00000000, 0x00600000)
    uint32_t guest_addr = 0x00100000;
    uint8_t *host_ptr = (uint8_t*)guest_to_host(guest_addr);
    assert(host_ptr == (guest_memory_get_code() + guest_addr));
    assert(host_to_guest(host_ptr) == guest_addr);
    TEST_PASS("guest_to_host & host_to_guest translation in Code region");

    // Test 2: Translation inside guest Heap [0x60000000, 0x70000000)
    uint32_t heap_guest_addr = GUEST_HEAP_BASE + 0x1000;
    uint8_t *heap_host_ptr = (uint8_t*)guest_to_host(heap_guest_addr);
    assert(heap_host_ptr == (guest_memory_get_heap() + 0x1000));
    assert(host_to_guest(heap_host_ptr) == heap_guest_addr);
    TEST_PASS("guest_to_host & host_to_guest translation in Heap region");

    // Test 3: Guest bump allocator
    uint32_t alloc1 = guest_alloc(64);
    assert(alloc1 != 0);
    assert((alloc1 & 7) == 0); // 8-byte aligned

    uint32_t alloc2 = guest_alloc(128);
    assert(alloc2 != 0);
    assert(alloc2 >= alloc1 + 64);
    assert((alloc2 & 7) == 0);
    TEST_PASS("guest_alloc bump allocator with alignment");

    // Test 4: Commpage setup validation
    guest_memory_setup_commpage();
    // Validate that kuser helper addresses have non-zero instruction bytes
    uint8_t *kuser_cmpxchg = (uint8_t*)guest_to_host(0xffff0fc0);
    assert(kuser_cmpxchg != NULL);
    assert(*(uint32_t*)kuser_cmpxchg != 0);
    TEST_PASS("guest_memory_setup_commpage kuser_cmpxchg instructions populated");

    guest_memory_release();
    TEST_PASS("guest_memory_release unmapped memory regions");

    printf("=== All Guest Memory tests PASSED! ===\n\n");
    return 0;
}
