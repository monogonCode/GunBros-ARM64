#ifndef GUNBROS_GAME_PATCHES_H
#define GUNBROS_GAME_PATCHES_H

#include "gunbros/common/common.h"

GUNBROS_EXTERN_C_BEGIN

typedef struct {
    uint32_t addr;
    bool     check_expected;
    uint32_t expected_old;
    uint32_t new_value;
    uint8_t  size; /* 1 or 4 bytes */
    const char *name;
} game_patch_entry_t;

/**
 * Applies all game-specific compatibility patches directly into guest code memory:
 * - CGun::Draw Muzzle Flash Guard
 * - CMesh::GetNodeAt NULL Guard
 * - CMesh::GetInterpolationValues Zero-Frame Fix
 * - Multitouch enablement and pointer preservation
 * - Hardware art set override (forcing XGA)
 * - CResourceLoader::Init NULL this guard
 * - CMenuNavigationBar button label / metrics offsets
 * - CFileMgr_Android local file operations (Delete, Rename, Size, Exists, MkDir)
 * - CResourceLoader::LoadNext timeout bypass
 */
void game_patches_apply_all(uint8_t *code_base);

/**
 * Returns pointer to static table of patches and its count.
 */
const game_patch_entry_t* game_patches_get_table(size_t *count);

/**
 * Installs ARM32 binary helpers into guest stubs area:
 * - guest_qsort heapsort implementation at 0x8000d000
 * - PLT slot hook pointing qsort to guest helper
 */
void game_patches_install_helpers(uint8_t *stubs_base, int qsort_plt_idx);

GUNBROS_EXTERN_C_END

#endif // GUNBROS_GAME_PATCHES_H
