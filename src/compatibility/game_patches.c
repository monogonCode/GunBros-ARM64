#include "gunbros/compatibility/game_patches.h"
#include "gunbros/compatibility/guest_helpers_bin.h"
#include "gunbros/compatibility/guest_symbols.h"
#include <string.h>

#define GUEST_HELPERS_OFF 0xd000u /* offset in g_host_stubs -> guest 0x8000d000 */

void game_patches_apply_all(uint8_t *code_base) {
    if (!code_base) return;

    // Patch: CResourceLoader::LoadNext
    // Original: beq 0x3667a0 (0x0affffc8) -> exits without advancing when waiting for dead servers
    // Patched: nop (0xe1a00000) -> falls through to b 0x366838, completing resource loading
    *(uint32_t*)(code_base + GUEST_PATCH_RESLOADER_LOADNEXT) = 0xe1a00000;
    LOGI("[PATCH] CResourceLoader::LoadNext at 0x%08x -> 0xe1a00000 (nop)", GUEST_PATCH_RESLOADER_LOADNEXT);

    // Patch A: CGun::Draw Muzzle Flash Guard
    // When m_flashMesh ([r0, #8]) is NULL or !isShooting ([r0, #232]), skip flash drawing to epilogue at 0x002b55c0.
    // Trampoline at 0x004f0000
    uint32_t tramp_a[7] = {
        0xe5d030e8, // ldrb r3, [r0, #232]  ; isShooting
        0xe3530000, // cmp  r3, #0
        0x0af7156c, // beq  0x002b55c0      ; if !isShooting -> return
        0xe5903008, // ldr  r3, [r0, #8]    ; m_flashMesh
        0xe3530000, // cmp  r3, #0
        0x0af71569, // beq  0x002b55c0      ; if !m_flashMesh -> return
        0xeaf714cf  // b    0x002b535c      ; continue flash drawing
    };
    memcpy(code_base + GUEST_PATCH_TRAMPOLINE_A, tramp_a, sizeof(tramp_a));
    *(uint32_t*)(code_base + GUEST_PATCH_GUN_DRAW) = 0xea08eb2a; // b 0x004f0000
    *(uint32_t*)(code_base + GUEST_PATCH_GUN_DRAW_NOP1) = 0xe1a00000; // nop
    *(uint32_t*)(code_base + GUEST_PATCH_GUN_DRAW_NOP2) = 0xe1a00000; // nop
    LOGI("[PATCH] CGun::Draw at 0x%08x -> trampoline at 0x%08x", GUEST_PATCH_GUN_DRAW, GUEST_PATCH_TRAMPOLINE_A);

    // Patch B: CMesh::GetNodeAt NULL Guard
    // If this == NULL (r0 == 0), return immediately without touching mesh memory.
    // Trampoline at 0x004f0040
    uint32_t tramp_b[5] = {
        0xe3500000, // cmp  r0, #0
        0x012fff1e, // bxeq lr
        0xe92d4ff0, // push {r4, r5, r6, r7, r8, r9, sl, fp, lr}
        0xe24dd02c, // sub  sp, sp, #44
        0xeaf91e87  // b    0x00337a74
    };
    memcpy(code_base + GUEST_PATCH_TRAMPOLINE_B, tramp_b, sizeof(tramp_b));
    *(uint32_t*)(code_base + GUEST_PATCH_MESH_GETNODEAT) = 0xea06e173; // b 0x004f0040
    LOGI("[PATCH] CMesh::GetNodeAt at 0x%08x -> trampoline at 0x%08x", GUEST_PATCH_MESH_GETNODEAT, GUEST_PATCH_TRAMPOLINE_B);

    // Patch C: CMesh::GetInterpolationValues Zero-Frame Fix
    // Original: beq 0x337a54 (0x0a000052)
    // Patched:  bls 0x337a54 (0x9a000052) -> handles keyframeCount <= 1 (prevents underflow when 0)
    *(uint32_t*)(code_base + GUEST_PATCH_MESH_GETINTERP) = 0x9a000052;
    LOGI("[PATCH] CMesh::GetInterpolationValues at 0x%08x -> 0x9a000052 (bls 0x337a54)", GUEST_PATCH_MESH_GETINTERP);

    // Patch D: Enable Multitouch support in engine
    *(uint8_t*)(code_base + GUEST_PATCH_MULTITOUCH_FLAG) = 1; // g_multipleTouchSupported = 1
    *(uint32_t*)(code_base + GUEST_PATCH_CAN_MULTITOUCH_MOV) = 0xe3a00001; // CanMultipleTouch() -> mov r0, #1
    *(uint32_t*)(code_base + GUEST_PATCH_CAN_MULTITOUCH_BX) = 0xe12fff1e; // bx lr
    *(uint32_t*)(code_base + GUEST_PATCH_IS_MULTITOUCH_MOV) = 0xe3a00001; // IsMultipleTouchEnabled() -> mov r0, #1
    *(uint32_t*)(code_base + GUEST_PATCH_IS_MULTITOUCH_BX) = 0xe12fff1e; // bx lr
    LOGI("[PATCH] Multitouch: g_multipleTouchSupported=1, CanMultipleTouch()=1, IsMultipleTouchEnabled()=1");

    // Patch E: Uncap multitouch in CGameApp::OnSystemEvent by removing forced single-touch pid=0
    *(uint32_t*)(code_base + GUEST_PATCH_SYSTEM_EVENT_PID) = 0xe1a00000; // nop (was mov r7, #0)
    LOGI("[PATCH] CGameApp::OnSystemEvent at 0x%08x -> nop (preserve pointer ID for dual sticks)", GUEST_PATCH_SYSTEM_EVENT_PID);

    // Patch F: Hardware::GetSupportedArtSetEv -> return 2 (xga)
    *(uint32_t*)(code_base + GUEST_PATCH_ART_SET_MOV) = 0xe3a00002; // mov r0, #2
    *(uint32_t*)(code_base + GUEST_PATCH_ART_SET_BX) = 0xe12fff1e; // bx lr
    LOGI("[PATCH] Hardware::GetSupportedArtSetEv at 0x%08x -> return 2 (xga)", GUEST_PATCH_ART_SET_MOV);

    // Patch G: CResourceLoader::Init NULL this guard
    uint32_t tramp_g[5] = {
        0xe3500000, // cmp  r0, #0
        0x012fff1e, // bxeq lr
        0xe92d41f0, // push {r4, r5, r6, r7, r8, lr}
        0xe1a05000, // mov  r5, r0
        0xeaf9da2f  // b    0x00366934
    };
    memcpy(code_base + GUEST_PATCH_TRAMPOLINE_G, tramp_g, sizeof(tramp_g));
    *(uint32_t*)(code_base + GUEST_PATCH_RESLOADER_INIT) = 0xea0625cb; // b 0x004f0060
    LOGI("[PATCH] CResourceLoader::Init at 0x%08x -> trampoline at 0x%08x", GUEST_PATCH_RESLOADER_INIT, GUEST_PATCH_TRAMPOLINE_G);

    // Patch H: Fix CMenuNavigationBar button label and meter/metric region indexing
    *(uint32_t*)(code_base + GUEST_PATCH_NAV_BAR_LABEL_R10) = 0xe3a0a007; // mov r10, #7
    *(uint32_t*)(code_base + GUEST_PATCH_NAV_BAR_SUB_R7) = 0xe2417007; // sub r7, r1, #7
    *(uint32_t*)(code_base + GUEST_PATCH_NAV_BAR_WARBUCKS) = 0xe3a0100e; // mov r1, #14
    *(uint32_t*)(code_base + GUEST_PATCH_NAV_BAR_COINS) = 0xe3a0100f; // mov r1, #15
    *(uint32_t*)(code_base + GUEST_PATCH_NAV_BAR_GUNBADGE) = 0xe3a01010; // mov r1, #16
    LOGI("[PATCH] CMenuNavigationBar regions: start_label=7, label_sub=7, warbucks=14, coins=15, gunbadge=16");

    // Patch I: Fix CFileMgr_Android local file operations (Delete, Rename, Size, Exists, MkDir, absoluteLocalPath)
    *(uint32_t*)(code_base + GUEST_PATCH_FILEMGR_LOCAL_DATA) = 0xe1a00000; // nop in absoluteLocalPath (skip 5-char data: strip)
    *(uint32_t*)(code_base + GUEST_PATCH_FILEMGR_LOCAL_CACHE) = 0xe1a00000; // nop in absoluteLocalPath (skip 6-char cache: strip)
    *(uint32_t*)(code_base + GUEST_PATCH_FILEMGR_LOCAL_TEMP) = 0xe1a00000; // nop in absoluteLocalPath (skip 5-char temp: strip)
    *(uint32_t*)(code_base + GUEST_PATCH_FILEMGR_MKDIR) = 0xea000002; // b 0x00159ddc in MkDir
    *(uint32_t*)(code_base + GUEST_PATCH_FILEMGR_SIZE) = 0xe1a00000; // nop in Size (always use localFileSize)
    *(uint32_t*)(code_base + GUEST_PATCH_FILEMGR_EXISTS) = 0xea00000c; // b 0x00159f80 in Exists (always use localFileExists)
    *(uint32_t*)(code_base + GUEST_PATCH_FILEMGR_DELETE) = 0xea000002; // b 0x0015a28c in Delete (bypass read-only guard)
    *(uint32_t*)(code_base + GUEST_PATCH_FILEMGR_RENAME_SRC) = 0xe1a00000; // nop in Rename (bypass read-only guard for src)
    *(uint32_t*)(code_base + GUEST_PATCH_FILEMGR_RENAME_DST) = 0xe1a00000; // nop in Rename (bypass read-only guard for dst)
    LOGI("[PATCH] CFileMgr_Android local file operations (Delete, Rename, Size, Exists, MkDir, absoluteLocalPath)");

    // Patch J: Disable dead GameSpy network polling busy-loops (gt2Think, peerThink, NNThink, gti2ConnectionThink)
    *(uint32_t*)(code_base + GUEST_PATCH_GAMESPY_GT2_THINK) = 0xe12fff1e; // gt2Think -> bx lr
    *(uint32_t*)(code_base + GUEST_PATCH_GAMESPY_PEER_THINK) = 0xe12fff1e; // peerThink -> bx lr
    *(uint32_t*)(code_base + GUEST_PATCH_GAMESPY_NN_THINK) = 0xe12fff1e; // NNThink -> bx lr
    *(uint32_t*)(code_base + GUEST_PATCH_GAMESPY_GTI2_MOV) = 0xe3a00000; // gti2ConnectionThink -> mov r0, #0
    *(uint32_t*)(code_base + GUEST_PATCH_GAMESPY_GTI2_BX) = 0xe12fff1e; // bx lr
    LOGI("[PATCH] Disabled dead GameSpy network polling busy-loops (gt2Think, peerThink, NNThink, gti2ConnectionThink)");
}

void game_patches_install_helpers(uint8_t *stubs_base, int qsort_plt_idx) {
    if (!stubs_base) return;
    if (guest_helpers_bin_len > 0x1000) {
        LOGE("guest_helpers too large (%u bytes)", guest_helpers_bin_len);
        return;
    }
    memcpy(stubs_base + GUEST_HELPERS_OFF, guest_helpers_bin, guest_helpers_bin_len);
    if (qsort_plt_idx >= 0) {
        // Replace "svc; bx lr" with "ldr pc, [pc, #-4]; .word destination"
        uint32_t slot[2] = { 0xe51ff004u, 0x80000000u + GUEST_HELPERS_OFF };
        memcpy(stubs_base + qsort_plt_idx * 8, slot, 8);
        LOGI("[PATCH] Installed guest_qsort helper at 0x8000d000 (PLT slot %d)", qsort_plt_idx);
    }
}
