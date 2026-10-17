#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "gunbros/common/sha256.h"

#define TEST_PASS(name) printf("  [PASS] %s\n", name)
#define TEST_FAIL(name, msg) do { printf("  [FAIL] %s: %s\n", name, msg); exit(1); } while(0)
#define ASSERT_STR_EQ(a, b, name, msg) do { \
    if (strcmp((a), (b)) != 0) { \
        printf("Expected '%s'\nGot      '%s'\n", (b), (a)); \
        TEST_FAIL(name, msg); \
    } \
} while(0)

int main(void) {
    printf("=== Running SHA-256 Self-Contained Test Suite ===\n");

    char out[65];

    // Vector 1: Empty string ""
    // NIST/RFC 6234: e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855
    gunbros_sha256_hex((const uint8_t*)"", 0, out);
    ASSERT_STR_EQ(out, "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855",
                  "sha256_empty", "Hash of empty string does not match NIST vector");
    TEST_PASS("sha256 empty string vector");

    // Vector 2: "abc"
    // NIST/RFC 6234: ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad
    gunbros_sha256_hex((const uint8_t*)"abc", 3, out);
    ASSERT_STR_EQ(out, "ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad",
                  "sha256_abc", "Hash of 'abc' does not match NIST vector");
    TEST_PASS("sha256 'abc' NIST test vector");

    // Vector 3: "abcdbcdecdefdefgefghfghighijhijkijkljklmklmnlmnomnopnopq" (56 bytes)
    // NIST/RFC 6234: 248d6a61d20638b8e5c026930c3e6039a33ce45964ff2167f6ecedd419db06c1
    const char *v3 = "abcdbcdecdefdefgefghfghighijhijkijkljklmklmnlmnomnopnopq";
    gunbros_sha256_hex((const uint8_t*)v3, strlen(v3), out);
    ASSERT_STR_EQ(out, "248d6a61d20638b8e5c026930c3e6039a33ce45964ff2167f6ecedd419db06c1",
                  "sha256_56bytes", "Hash of 56-byte vector does not match NIST vector");
    TEST_PASS("sha256 56-byte block boundary NIST test vector");

    // Vector 4: Incremental chunked update equivalence
    gunbros_sha256_ctx ctx;
    uint8_t raw_hash[32];
    gunbros_sha256_init(&ctx);
    // Feed in small non-aligned chunks
    gunbros_sha256_update(&ctx, (const uint8_t*)"a", 1);
    gunbros_sha256_update(&ctx, (const uint8_t*)"b", 1);
    gunbros_sha256_update(&ctx, (const uint8_t*)"c", 1);
    gunbros_sha256_final(&ctx, raw_hash);
    for (int i = 0; i < 32; i++) {
        snprintf(&out[i * 2], 3, "%02x", raw_hash[i]);
    }
    out[64] = '\0';
    ASSERT_STR_EQ(out, "ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad",
                  "sha256_chunked", "Incremental chunked hash differs from one-shot hash");
    TEST_PASS("sha256 incremental streaming chunk equivalence");

    printf("=== All SHA-256 tests PASSED! ===\n");
    return 0;
}
