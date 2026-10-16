#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
#include <stdbool.h>
#include <assert.h>
#include <sys/stat.h>

#include "gunbros/common/common.h"
#include "gunbros/emulator/guest_memory.h"
#include "gunbros/emulator/hle_dispatcher.h"
#include "gunbros/hle/hle_libc.h"
#include "gunbros/filesystem/path_mapper.h"
#include "gunbros/filesystem/file_operations.h"
#include "gunbros/filesystem/directory_operations.h"

#define TEST_PASS(name) printf("  [PASS] %s\n", name)
#define TEST_FAIL(name, msg) do { printf("  [FAIL] %s: %s\n", name, msg); exit(1); } while(0)
#define ASSERT_TRUE(cond, name, msg) do { if (!(cond)) TEST_FAIL(name, msg); } while(0)
#define ASSERT_EQ(a, b, name, msg) do { if ((a) != (b)) { printf("Expected %ld got %ld\n", (long)(b), (long)(a)); TEST_FAIL(name, msg); } } while(0)

static uint32_t write_guest_str(const char *s) {
    size_t len = strlen(s) + 1;
    uint32_t ga = guest_alloc((uint32_t)len);
    char *p = (char*)guest_to_host(ga);
    if (p) memcpy(p, s, len);
    return ga;
}

static void test_fseek_negative_offset(void) {
    printf("--- Testing h_fseek with negative offsets and h_ftell ---\n");
    const char *test_path = "hle_test_seek.dat";

    // Setup: write a 100-byte test file
    int fd = gunbros_fopen(test_path, "wb");
    ASSERT_TRUE(fd > 0, "fseek_neg", "failed to open test file for write");
    uint8_t buffer[100];
    for (int i = 0; i < 100; i++) buffer[i] = (uint8_t)i;
    size_t written = gunbros_fwrite(buffer, 1, 100, fd);
    ASSERT_EQ(written, 100, "fseek_neg", "failed to write 100 bytes");
    gunbros_fclose(fd);

    // Open file using h_fopen
    hle_t c = {0};
    c.r0 = write_guest_str(test_path);
    c.r1 = write_guest_str("rb");
    h_fopen(&c);
    uint32_t handle = c.r0;
    ASSERT_TRUE(handle > 0, "fseek_neg", "h_fopen failed");

    // Seek -20 bytes from SEEK_END (2)
    // Guest passes 32-bit uint32_t representation of -20 (0xFFFFFFEC)
    c.r0 = handle;
    c.r1 = (uint32_t)(int32_t)-20;
    c.r2 = 2; // SEEK_END
    h_fseek(&c);
    ASSERT_EQ(c.r0, 0, "fseek_neg", "h_fseek SEEK_END -20 failed");

    // Verify ftell is 80 (100 - 20)
    c.r0 = handle;
    h_ftell(&c);
    ASSERT_EQ(c.r0, 80, "fseek_neg", "h_ftell after SEEK_END -20 expected 80");

    // Read 5 bytes from position 80
    uint32_t read_buf_ga = guest_alloc(16);
    c.r0 = read_buf_ga;
    c.r1 = 1;
    c.r2 = 5;
    c.r3 = handle;
    h_fread(&c);
    ASSERT_EQ(c.r0, 5, "fseek_neg", "h_fread failed to read 5 bytes");
    uint8_t *read_ptr = (uint8_t*)guest_to_host(read_buf_ga);
    for (int i = 0; i < 5; i++) {
        ASSERT_EQ(read_ptr[i], 80 + i, "fseek_neg", "data mismatch after seek");
    }

    // Now seek -10 bytes from SEEK_CUR (1): current pos is 85, should end at 75
    c.r0 = handle;
    c.r1 = (uint32_t)(int32_t)-10;
    c.r2 = 1; // SEEK_CUR
    h_fseek(&c);
    ASSERT_EQ(c.r0, 0, "fseek_neg", "h_fseek SEEK_CUR -10 failed");

    c.r0 = handle;
    h_ftell(&c);
    ASSERT_EQ(c.r0, 75, "fseek_neg", "h_ftell after SEEK_CUR -10 expected 75");

    // Close file
    c.r0 = handle;
    h_fclose(&c);

    gunbros_remove(test_path);
    TEST_PASS("h_fseek negative offset (SEEK_END, SEEK_CUR) and h_ftell");
}

static void test_time_4byte_write(void) {
    printf("--- Testing h_time writes only 4 bytes (no 8-byte host time_t overflow) ---\n");

    // Allocate 8 bytes: first 4 bytes for time_t, next 4 bytes for canary
    uint32_t time_buf_ga = guest_alloc(8);
    uint32_t *time_ptr = (uint32_t*)guest_to_host(time_buf_ga);
    ASSERT_TRUE(time_ptr != NULL, "time_4byte", "guest_alloc returned NULL");

    time_ptr[0] = 0xAAAAAAAA;
    time_ptr[1] = 0x55AA55AA; // Canary!

    hle_t c = {0};
    c.r0 = time_buf_ga;
    h_time(&c);

    // c.r0 should be current unix timestamp (> 1.7 billion)
    ASSERT_TRUE(c.r0 > 1700000000u, "time_4byte", "invalid timestamp returned in r0");
    ASSERT_EQ(time_ptr[0], c.r0, "time_4byte", "time value not written to guest buffer");
    ASSERT_EQ(time_ptr[1], 0x55AA55AA, "time_4byte", "canary corrupted by 64-bit time_t host overflow!");

    // Test with NULL pointer (r0 = 0): should not crash and still return timestamp in r0
    c.r0 = 0;
    h_time(&c);
    ASSERT_TRUE(c.r0 > 1700000000u, "time_4byte", "h_time with NULL argument failed");

    TEST_PASS("h_time writes strictly 4 bytes without adjacent memory corruption");
}

static void test_stat_bionic_layout(void) {
    printf("--- Testing h_stat populates bionic ARM32 struct stat layout (104 bytes) ---\n");
    const char *test_path = "hle_test_stat.dat";

    // Setup: create file with known size 2048 bytes
    int fd = gunbros_fopen(test_path, "wb");
    ASSERT_TRUE(fd > 0, "stat_layout", "failed to open test file");
    uint8_t buf[2048];
    memset(buf, 0x42, sizeof(buf));
    gunbros_fwrite(buf, 1, sizeof(buf), fd);
    gunbros_fclose(fd);

    // Allocate 108 bytes in guest memory (104 bytes for stat + 4 bytes canary)
    uint32_t stat_ga = guest_alloc(108);
    uint8_t *st_bytes = (uint8_t*)guest_to_host(stat_ga);
    ASSERT_TRUE(st_bytes != NULL, "stat_layout", "guest_alloc failed");
    memset(st_bytes, 0, 108);
    uint32_t canary = 0xCAFEBABE;
    memcpy(st_bytes + 104, &canary, 4);

    hle_t c = {0};
    c.r0 = write_guest_str(test_path);
    c.r1 = stat_ga;
    h_stat(&c);
    ASSERT_EQ(c.r0, 0, "stat_layout", "h_stat returned non-zero");

    // Verify fields per bionic ARM32 struct stat:
    // ino@12, mode@16, nlink@20, uid@24, gid@28, size@48 (8 bytes), blksize@56,
    // blocks@64 (8 bytes), atime@72, mtime@80, ctime@88
    uint32_t mode = 0;
    memcpy(&mode, st_bytes + 16, 4);
    ASSERT_TRUE(S_ISREG(mode), "stat_layout", "mode is not S_ISREG");

    uint32_t nlink = 0;
    memcpy(&nlink, st_bytes + 20, 4);
    ASSERT_TRUE(nlink >= 1, "stat_layout", "nlink should be >= 1");

    uint64_t size = 0;
    memcpy(&size, st_bytes + 48, 8);
    ASSERT_EQ(size, 2048, "stat_layout", "st_size at offset 48 mismatch");

    uint32_t atime = 0, mtime = 0, ctime = 0;
    memcpy(&atime, st_bytes + 72, 4);
    memcpy(&mtime, st_bytes + 80, 4);
    memcpy(&ctime, st_bytes + 88, 4);
    ASSERT_TRUE(atime > 1700000000u, "stat_layout", "st_atime at offset 72 invalid");
    ASSERT_TRUE(mtime > 1700000000u, "stat_layout", "st_mtime at offset 80 invalid");
    ASSERT_TRUE(ctime > 1700000000u, "stat_layout", "st_ctime at offset 88 invalid");

    // Verify canary at offset 104
    uint32_t read_canary = 0;
    memcpy(&read_canary, st_bytes + 104, 4);
    ASSERT_EQ(read_canary, 0xCAFEBABE, "stat_layout", "stat write overflowed 104 bytes!");

    gunbros_remove(test_path);
    TEST_PASS("h_stat conforms to bionic ARM32 104-byte struct stat layout");
}

static void test_sscanf_multi_args(void) {
    printf("--- Testing h_sscanf with multi-args, guest integer widths and stack args ---\n");

    const char *text = "Hero: Francis Rank: 15 Score: 987654 Coins: 321 Multiplier: 2.50";
    const char *fmt = "Hero: %s Rank: %d Score: %ld Coins: %u Multiplier: %f";

    uint32_t g_text = write_guest_str(text);
    uint32_t g_fmt  = write_guest_str(fmt);

    // Prepare destination variables with guards/canaries
    uint32_t g_hero = guest_alloc(32);
    char *h_hero = (char*)guest_to_host(g_hero);

    // Rank: 4 bytes int + 4 bytes canary
    uint32_t g_rank = guest_alloc(8);
    uint32_t *h_rank = (uint32_t*)guest_to_host(g_rank);
    h_rank[1] = 0x11223344;

    // Score: 4 bytes int (%ld) + 4 bytes canary
    uint32_t g_score = guest_alloc(8);
    uint32_t *h_score = (uint32_t*)guest_to_host(g_score);
    h_score[1] = 0x55667788;

    // Coins: 4 bytes uint (%u) + 4 bytes canary
    uint32_t g_coins = guest_alloc(8);
    uint32_t *h_coins = (uint32_t*)guest_to_host(g_coins);
    h_coins[1] = 0x99AABBCC;

    // Multiplier: 4 bytes float (%f) + 4 bytes canary
    uint32_t g_mult = guest_alloc(8);
    uint32_t *h_mult = (uint32_t*)guest_to_host(g_mult);
    h_mult[1] = 0xDDEEFF00;

    // Setup stack for arguments 3..5 (idx 2..4 in 0-based varargs)
    // ARM calling convention for variadic:
    // r0 = str, r1 = fmt, r2 = arg0 (&hero), r3 = arg1 (&rank)
    // sp[0] = arg2 (&score), sp[1] = arg3 (&coins), sp[2] = arg4 (&mult)
    uint32_t stack_sp = GUEST_STACK_BASE + 0x1000;
    uint32_t *sp_ptr = (uint32_t*)guest_to_host(stack_sp);
    sp_ptr[0] = g_score;
    sp_ptr[1] = g_coins;
    sp_ptr[2] = g_mult;

    hle_t c = {0};
    c.r0 = g_text;
    c.r1 = g_fmt;
    c.r2 = g_hero;
    c.r3 = g_rank;
    c.sp = stack_sp;

    h_sscanf(&c);
    ASSERT_EQ(c.r0, 5, "sscanf_multi", "h_sscanf did not parse 5 items");

    ASSERT_TRUE(strcmp(h_hero, "Francis") == 0, "sscanf_multi", "hero string mismatch");
    ASSERT_EQ(h_rank[0], 15, "sscanf_multi", "rank integer mismatch");
    ASSERT_EQ(h_score[0], 987654, "sscanf_multi", "score %ld mismatch");
    ASSERT_EQ(h_coins[0], 321, "sscanf_multi", "coins %u mismatch");

    float mult_val = 0;
    memcpy(&mult_val, &h_mult[0], 4);
    ASSERT_TRUE(mult_val >= 2.49f && mult_val <= 2.51f, "sscanf_multi", "multiplier float mismatch");

    // Verify all canaries are intact (verifies %ld didn't perform an 8-byte write!)
    ASSERT_EQ(h_rank[1], 0x11223344, "sscanf_multi", "rank canary corrupted");
    ASSERT_EQ(h_score[1], 0x55667788, "sscanf_multi", "score canary corrupted (%ld 8-byte overwrite!)");
    ASSERT_EQ(h_coins[1], 0x99AABBCC, "sscanf_multi", "coins canary corrupted");
    ASSERT_EQ(h_mult[1], 0xDDEEFF00, "sscanf_multi", "mult canary corrupted");

    TEST_PASS("h_sscanf handles multi-args on stack and normalizes %ld without memory corruption");
}

int main(void) {
    printf("=== Running HLE Libc Test Suite ===\n");

    // Initialize subsystems
    mkdir("/tmp/gunbros_hle_test", 0755);
    mkdir("/tmp/gunbros_hle_test/files", 0755);
    const char *test_dir = "/tmp/gunbros_hle_test/files";
    guest_memory_init();
    path_mapper_set_base_dir(test_dir);

    test_fseek_negative_offset();
    test_time_4byte_write();
    test_stat_bionic_layout();
    test_sscanf_multi_args();

    guest_memory_release();
    printf("=== All HLE Libc tests PASSED! ===\n");
    return 0;
}
