#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>
#include "gunbros/platform/pcm_ring.h"

#define TEST_PASS(name) printf("  [PASS] %s\n", name)

int main(void) {
    printf("=== Running PCM Ring Buffer Test Suite ===\n");

    pcm_ring_t ring;
    pcm_ring_init(&ring);
    assert(pcm_ring_available(&ring) == 0);
    assert(pcm_ring_space(&ring) == PCM_RING_CAP);
    TEST_PASS("pcm_ring_init initial state");

    // Test writing samples
    uint8_t sample_data[512];
    for (int i = 0; i < 512; i++) {
        sample_data[i] = (uint8_t)(i & 0xFF);
    }

    size_t written = pcm_ring_write(&ring, sample_data, 512);
    assert(written == 512);
    assert(pcm_ring_available(&ring) == 512);
    TEST_PASS("pcm_ring_write 512 bytes");

    // Test reading samples
    uint8_t read_data[512] = {0};
    size_t read_count = pcm_ring_read(&ring, read_data, 512);
    assert(read_count == 512);
    assert(pcm_ring_available(&ring) == 0);
    assert(memcmp(sample_data, read_data, sizeof(sample_data)) == 0);
    TEST_PASS("pcm_ring_read verified data integrity");

    // Test wrap-around behavior
    uint8_t large_block[40000];
    for (size_t i = 0; i < sizeof(large_block); i++) large_block[i] = (uint8_t)(i & 0xFF);
    assert(pcm_ring_write(&ring, large_block, sizeof(large_block)) == sizeof(large_block));
    assert(pcm_ring_read(&ring, large_block, sizeof(large_block)) == sizeof(large_block));

    // Second write to force pointer past the 65536 wrap boundary
    uint8_t wrap_write[30000];
    for (size_t i = 0; i < sizeof(wrap_write); i++) wrap_write[i] = (uint8_t)((i + 7) & 0xFF);
    assert(pcm_ring_write(&ring, wrap_write, sizeof(wrap_write)) == sizeof(wrap_write));

    uint8_t wrap_read[30000] = {0};
    assert(pcm_ring_read(&ring, wrap_read, sizeof(wrap_read)) == sizeof(wrap_read));
    assert(memcmp(wrap_write, wrap_read, sizeof(wrap_write)) == 0);
    TEST_PASS("pcm_ring wrap-around circular boundary");

    printf("=== All PCM Ring Buffer tests PASSED! ===\n\n");
    return 0;
}
