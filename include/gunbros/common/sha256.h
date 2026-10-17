#ifndef GUNBROS_SHA256_H
#define GUNBROS_SHA256_H

#include <stddef.h>
#include <stdint.h>
#include "gunbros/common/common.h"

GUNBROS_EXTERN_C_BEGIN

typedef struct {
    uint8_t  data[64];
    uint32_t datalen;
    uint64_t bitlen;
    uint32_t state[8];
} gunbros_sha256_ctx;

/**
 * Initializes a SHA-256 context.
 */
void gunbros_sha256_init(gunbros_sha256_ctx *ctx);

/**
 * Feeds data into the active SHA-256 context.
 */
void gunbros_sha256_update(gunbros_sha256_ctx *ctx, const uint8_t *data, size_t len);

/**
 * Finalizes the SHA-256 calculation and produces a 32-byte raw binary digest.
 */
void gunbros_sha256_final(gunbros_sha256_ctx *ctx, uint8_t hash[32]);

/**
 * Computes the SHA-256 hash of a buffer in a single call and returns a 64-char
 * lowercase hex string followed by a null terminator in out_hex (minimum 65 bytes).
 */
void gunbros_sha256_hex(const uint8_t *data, size_t len, char out_hex[65]);

GUNBROS_EXTERN_C_END

#endif // GUNBROS_SHA256_H
