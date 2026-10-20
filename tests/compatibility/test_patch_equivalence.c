#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
#include <stdbool.h>

#include "gunbros/compatibility/game_patches.h"
#include "gunbros/compatibility/guest_helpers_bin.h"

#define TEST_PASS(name) printf("  [PASS] %s\n", name)
#define TEST_FAIL(name, msg) do { printf("  [FAIL] %s: %s\n", name, msg); exit(1); } while(0)
#define ASSERT_TRUE(cond, name, msg) do { if (!(cond)) TEST_FAIL(name, msg); } while(0)

#define BUFFER_SIZE 0x00500000 /* 5 MB to cover all addresses up to 0x004f0080 */

/**
 * Exact replica of game_patches_apply_all from legacy-archive:src/compatibility/game_patches.c
 */
static void legacy_apply_all(uint8_t *code_base) {
    if (!code_base) return;

    // Patch: CResourceLoader::LoadNext at 0x00366878
    *(uint32_t*)(code_base + 0x00366878) = 0xe1a00000;

    // Patch A: CGun::Draw Muzzle Flash Guard
    uint32_t tramp_a[7] = {
        0xe5d030e8, // ldrb r3, [r0, #232]  ; isShooting
        0xe3530000, // cmp  r3, #0
        0x0af7156c, // beq  0x002b55c0      ; if !isShooting -> return
        0xe5903008, // ldr  r3, [r0, #8]    ; m_flashMesh
        0xe3530000, // cmp  r3, #0
        0x0af71569, // beq  0x002b55c0      ; if !m_flashMesh -> return
        0xeaf714cf  // b    0x002b535c      ; continue flash drawing
    };
    memcpy(code_base + 0x004f0000, tramp_a, sizeof(tramp_a));
    *(uint32_t*)(code_base + 0x002b5350) = 0xea08eb2a; // b 0x004f0000
    *(uint32_t*)(code_base + 0x002b5354) = 0xe1a00000; // nop
    *(uint32_t*)(code_base + 0x002b5358) = 0xe1a00000; // nop

    // Patch B: CMesh::GetNodeAt NULL & uninitialized m_frames Guard
    uint32_t tramp_b[8] = {
        0xe3500206, // cmp  r0, #0x60000000
        0x312fff1e, // bxlo lr
        0xe590c028, // ldr  r12, [r0, #0x28]
        0xe35c0206, // cmp  r12, #0x60000000
        0x312fff1e, // bxlo lr
        0xe92d4ff0, // push {r4, r5, r6, r7, r8, r9, sl, fp, lr}
        0xe24dd02c, // sub  sp, sp, #44
        0xeaf91e84  // b    0x00337a74
    };
    memcpy(code_base + 0x004f0040, tramp_b, sizeof(tramp_b));
    *(uint32_t*)(code_base + 0x00337a6c) = 0xea06e173; // b 0x004f0040

    // Patch C: CMesh::GetInterpolationValues Zero-Frame Fix
    *(uint32_t*)(code_base + 0x00337904) = 0x9a000052;

    // Patch D: Enable Multitouch support in engine
    *(uint8_t*)(code_base + 0x004c966c) = 1; // g_multipleTouchSupported = 1
    *(uint32_t*)(code_base + 0x0015751c) = 0xe3a00001; // CanMultipleTouch() -> mov r0, #1
    *(uint32_t*)(code_base + 0x00157520) = 0xe12fff1e; // bx lr
    *(uint32_t*)(code_base + 0x00157530) = 0xe3a00001; // IsMultipleTouchEnabled() -> mov r0, #1
    *(uint32_t*)(code_base + 0x00157534) = 0xe12fff1e; // bx lr

    // Patch E: Uncap multitouch in CGameApp::OnSystemEvent by removing forced single-touch pid=0
    *(uint32_t*)(code_base + 0x0024d5d4) = 0xe1a00000; // nop (was mov r7, #0)

    // Patch F: Hardware::GetSupportedArtSetEv -> return 2 (xga)
    *(uint32_t*)(code_base + 0x002e5170) = 0xe3a00002; // mov r0, #2
    *(uint32_t*)(code_base + 0x002e5174) = 0xe12fff1e; // bx lr

    // Patch G: CResourceLoader::Init NULL this guard
    uint32_t tramp_g[5] = {
        0xe3500000, // cmp  r0, #0
        0x012fff1e, // bxeq lr
        0xe92d41f0, // push {r4, r5, r6, r7, r8, lr}
        0xe1a05000, // mov  r5, r0
        0xeaf9da2f  // b    0x00366934
    };
    memcpy(code_base + 0x004f0060, tramp_g, sizeof(tramp_g));
    *(uint32_t*)(code_base + 0x0036692c) = 0xea0625cb; // b 0x004f0060


    // Patch I: Fix CFileMgr_Android local file operations (Delete, Rename, Size, Exists, MkDir, absoluteLocalPath)
    *(uint32_t*)(code_base + 0x00159ca0) = 0xe1a00000; // nop in absoluteLocalPath
    *(uint32_t*)(code_base + 0x00159cc0) = 0xe1a00000; // nop in absoluteLocalPath
    *(uint32_t*)(code_base + 0x00159ce0) = 0xe1a00000; // nop in absoluteLocalPath
    *(uint32_t*)(code_base + 0x00159dcc) = 0xea000002; // b 0x00159ddc in MkDir
    *(uint32_t*)(code_base + 0x00159e60) = 0xe1a00000; // nop in Size
    *(uint32_t*)(code_base + 0x00159f48) = 0xea00000c; // b 0x00159f80 in Exists
    *(uint32_t*)(code_base + 0x0015a27c) = 0xea000002; // b 0x0015a28c in Delete
    *(uint32_t*)(code_base + 0x0015a30c) = 0xe1a00000; // nop in Rename src
    *(uint32_t*)(code_base + 0x0015a324) = 0xe1a00000; // nop in Rename dst

    // Patch J: Disabled to allow OpenSpy multiplayer polling
    // *(uint32_t*)(code_base + 0x003c5c88) = 0xe12fff1e; // gt2Think -> bx lr
    // *(uint32_t*)(code_base + 0x003a65d0) = 0xe12fff1e; // peerThink -> bx lr
    // *(uint32_t*)(code_base + 0x003cbc68) = 0xe12fff1e; // NNThink -> bx lr
    // *(uint32_t*)(code_base + 0x003c44f0) = 0xe3a00000; // gti2ConnectionThink -> mov r0, #0
    // *(uint32_t*)(code_base + 0x003c44f4) = 0xe12fff1e; // bx lr

    // Patch K: CProfileManager::LoginInitResourceLoaderCallback bypass server isReady
    *(uint32_t*)(code_base + 0x0035c264) = 0xe59f41d0; // ldr r4, [pc, #0x1d0]
    *(uint32_t*)(code_base + 0x0035c268) = 0xe08f4004; // add r4, pc, r4
    *(uint32_t*)(code_base + 0x0035c26c) = 0xe59f71cc; // ldr r7, [pc, #0x1cc]
    *(uint32_t*)(code_base + 0x0035c270) = 0xea00001a; // b 0x0035c2e0

    // Patch L: SyncLocalDataResourceLoaderCallback return 1 (success) immediately
    *(uint32_t*)(code_base + 0x0035c964) = 0xe3a00001; // mov r0, #1
    *(uint32_t*)(code_base + 0x0035c968) = 0xe12fff1e; // bx lr

    // Patch M: CMeshAnimationController::Render mesh/frames/vertexBuffer validation & sync
    uint32_t tramp_m[22] = {
        0xe3500206, 0x38bd8010, 0xe5903028, 0xe3530206,
        0x38bd8010, 0xe590302c, 0xe3530000, 0x08bd8010,
        0xe5903004, 0xe3530206, 0x38bd8010, 0xe5902000,
        0xe3520206, 0x38bd8010, 0xe5923000, 0xe3530601,
        0x38bd8010, 0xe3530605, 0x28bd8010, 0xe5842008,
        0xe594100c, 0xeaf9235e
    };
    memcpy(code_base + 0x004f0080, tramp_m, sizeof(tramp_m));
    *(uint32_t*)(code_base + 0x00338e44) = 0xea06dc8d; // b 0x004f0080
}

int main(void) {
    printf("=== Running Game Patches Equivalence Test Suite ===\n");

    uint8_t *buf_legacy = (uint8_t*)calloc(1, BUFFER_SIZE);
    uint8_t *buf_new    = (uint8_t*)calloc(1, BUFFER_SIZE);
    ASSERT_TRUE(buf_legacy && buf_new, "alloc", "Failed to allocate 5MB buffers");

    // Pre-fill both buffers with arbitrary pattern (e.g. 0x55) to verify untouched areas remain identical
    memset(buf_legacy, 0x55, BUFFER_SIZE);
    memset(buf_new,    0x55, BUFFER_SIZE);

    // Pre-fill patch locations with expected_old original bytes so that
    // check_expected verification in game_patches_apply_all validates and succeeds
    size_t patch_count = 0;
    const game_patch_entry_t *patches = game_patches_get_table(&patch_count);
    ASSERT_TRUE(patches != NULL && patch_count > 0, "patch_table", "Patch table is empty");

    for (size_t i = 0; i < patch_count; i++) {
        const game_patch_entry_t *p = &patches[i];
        if (p->size == 1) {
            buf_legacy[p->addr] = (uint8_t)p->expected_old;
            buf_new[p->addr]    = (uint8_t)p->expected_old;
        } else {
            *(uint32_t*)(buf_legacy + p->addr) = p->expected_old;
            *(uint32_t*)(buf_new + p->addr)    = p->expected_old;
        }
    }

    // Apply patches
    legacy_apply_all(buf_legacy);
    game_patches_apply_all(buf_new);

    // Verify byte-for-byte equivalence
    bool identical = true;
    size_t diff_count = 0;
    for (size_t i = 0; i < BUFFER_SIZE; i++) {
        if (buf_legacy[i] != buf_new[i]) {
            if (diff_count < 10) {
                printf("  [DIFF] Offset 0x%08zx: legacy=0x%02x, new=0x%02x\n",
                       i, buf_legacy[i], buf_new[i]);
            }
            diff_count++;
            identical = false;
        }
    }

    if (!identical) {
        printf("Total differing bytes: %zu out of %d\n", diff_count, BUFFER_SIZE);
        TEST_FAIL("patch_equivalence", "Table-driven patches produce different memory image than legacy code!");
    }
    TEST_PASS("Table-driven game_patches byte-for-byte identical to legacy-archive (5MB verified)");

    // Test helper installation equivalence
    uint8_t *stubs_legacy = (uint8_t*)calloc(1, 0x10000);
    uint8_t *stubs_new    = (uint8_t*)calloc(1, 0x10000);
    ASSERT_TRUE(stubs_legacy && stubs_new, "stubs_alloc", "Failed to allocate stubs buffers");

    // Legacy helpers logic
    memcpy(stubs_legacy + 0xd000u, guest_helpers_bin, guest_helpers_bin_len);
    int qsort_plt_idx = 42;
    uint32_t slot[2] = { 0xe51ff004u, 0x80000000u + 0xd000u };
    memcpy(stubs_legacy + qsort_plt_idx * 8, slot, 8);

    // New helpers logic
    game_patches_install_helpers(stubs_new, qsort_plt_idx);

    ASSERT_TRUE(memcmp(stubs_legacy, stubs_new, 0x10000) == 0,
                "helpers_equivalence", "guest_helpers_install differs between legacy and new!");
    TEST_PASS("game_patches_install_helpers byte-for-byte identical to legacy");

    // Test expected_old verification safety:
    // A corrupted memory location must NOT be patched when check_expected = true
    uint8_t *corrupted_buf = (uint8_t*)malloc(BUFFER_SIZE);
    ASSERT_TRUE(corrupted_buf != NULL, "corrupt_alloc", "Failed to allocate buffer");
    memset(corrupted_buf, 0xaa, BUFFER_SIZE);
    game_patches_apply_all(corrupted_buf);
    // Verify that none of the checked patches were applied
    for (size_t i = 0; i < patch_count; i++) {
        const game_patch_entry_t *p = &patches[i];
        if (p->check_expected) {
            if (p->size == 1) {
                ASSERT_TRUE(corrupted_buf[p->addr] == 0xaa, "safety_check_1", "Corrupted memory was patched despite check_expected!");
            } else {
                ASSERT_TRUE(*(uint32_t*)(corrupted_buf + p->addr) == 0xaaaaaaaa, "safety_check_4", "Corrupted memory was patched despite check_expected!");
            }
        }
    }
    free(corrupted_buf);
    TEST_PASS("check_expected safety abort successfully verified (no patches applied on mismatched bytes)");
    TEST_PASS("game_patches_get_table exposes valid table entries");

    free(buf_legacy);
    free(buf_new);
    free(stubs_legacy);
    free(stubs_new);

    printf("=== All Game Patches Equivalence tests PASSED! ===\n");
    return 0;
}
