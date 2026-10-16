#ifndef GUNBROS_ELF_LOADER_H
#define GUNBROS_ELF_LOADER_H

#include "gunbros/common/common.h"

GUNBROS_EXTERN_C_BEGIN

/**
 * Loads the original 32-bit ARM libandroidplatformjni.so from memory buffer.
 * Performs validation, allocation, mapping, relocation, patching, and constructor execution.
 */
bool elf_loader_load(const uint8_t *buf, size_t buf_len, const char *game_dir);

GUNBROS_EXTERN_C_END

#endif // GUNBROS_ELF_LOADER_H
