#include "gunbros/compatibility/game_patches.h"
#include "gunbros/compatibility/guest_helpers_bin.h"
#include "gunbros/compatibility/guest_symbols.h"
#include <string.h>

#define GUEST_HELPERS_OFF 0xd000u /* offset in g_host_stubs -> guest 0x8000d000 */

static const game_patch_entry_t s_game_patches[] = {
    /* CResourceLoader::LoadNext */
    { GUEST_PATCH_RESLOADER_LOADNEXT, false, 0, 0xe1a00000, 4, "CResourceLoader::LoadNext nop" },

    /* Patch A: CGun::Draw (hooks into Trampoline A) */
    { GUEST_PATCH_GUN_DRAW,           false, 0, 0xea08eb2a, 4, "CGun::Draw trampoline branch" },
    { GUEST_PATCH_GUN_DRAW_NOP1,      false, 0, 0xe1a00000, 4, "CGun::Draw nop1" },
    { GUEST_PATCH_GUN_DRAW_NOP2,      false, 0, 0xe1a00000, 4, "CGun::Draw nop2" },

    /* Patch B: CMesh::GetNodeAt (hooks into Trampoline B) */
    { GUEST_PATCH_MESH_GETNODEAT,     false, 0, 0xea06e173, 4, "CMesh::GetNodeAt trampoline branch" },

    /* Patch C: CMesh::GetInterpolationValues */
    { GUEST_PATCH_MESH_GETINTERP,     false, 0, 0x9a000052, 4, "CMesh::GetInterpolationValues bls" },

    /* Patch D: Multitouch support */
    { GUEST_PATCH_MULTITOUCH_FLAG,    false, 0, 1,          1, "g_multipleTouchSupported = 1" },
    { GUEST_PATCH_CAN_MULTITOUCH_MOV, false, 0, 0xe3a00001, 4, "CanMultipleTouch mov r0, 1" },
    { GUEST_PATCH_CAN_MULTITOUCH_BX,  false, 0, 0xe12fff1e, 4, "CanMultipleTouch bx lr" },
    { GUEST_PATCH_IS_MULTITOUCH_MOV,  false, 0, 0xe3a00001, 4, "IsMultipleTouchEnabled mov r0, 1" },
    { GUEST_PATCH_IS_MULTITOUCH_BX,   false, 0, 0xe12fff1e, 4, "IsMultipleTouchEnabled bx lr" },

    /* Patch E: CGameApp::OnSystemEvent (preserve pointer ID) */
    { GUEST_PATCH_SYSTEM_EVENT_PID,   false, 0, 0xe1a00000, 4, "CGameApp::OnSystemEvent preserve pid nop" },

    /* Patch F: Hardware::GetSupportedArtSetEv */
    { GUEST_PATCH_ART_SET_MOV,        false, 0, 0xe3a00002, 4, "Hardware::GetSupportedArtSetEv mov r0, 2" },
    { GUEST_PATCH_ART_SET_BX,         false, 0, 0xe12fff1e, 4, "Hardware::GetSupportedArtSetEv bx lr" },

    /* Patch G: CResourceLoader::Init (hooks into Trampoline G) */
    { GUEST_PATCH_RESLOADER_INIT,     false, 0, 0xea0625cb, 4, "CResourceLoader::Init trampoline branch" },

    /* Patch H: CMenuNavigationBar button label / metrics offsets */
    { GUEST_PATCH_NAV_BAR_LABEL_R10,  false, 0, 0xe3a0a007, 4, "CMenuNavigationBar label r10=7" },
    { GUEST_PATCH_NAV_BAR_SUB_R7,     false, 0, 0xe2417007, 4, "CMenuNavigationBar label sub r7, r1, 7" },
    { GUEST_PATCH_NAV_BAR_WARBUCKS,   false, 0, 0xe3a0100e, 4, "CMenuNavigationBar warbucks r1=14" },
    { GUEST_PATCH_NAV_BAR_COINS,      false, 0, 0xe3a0100f, 4, "CMenuNavigationBar coins r1=15" },
    { GUEST_PATCH_NAV_BAR_GUNBADGE,   false, 0, 0xe3a01010, 4, "CMenuNavigationBar gunbadge r1=16" },

    /* Patch I: CFileMgr_Android local file operations */
    { GUEST_PATCH_FILEMGR_LOCAL_DATA, false, 0, 0xe1a00000, 4, "CFileMgr_Android skip data: strip nop" },
    { GUEST_PATCH_FILEMGR_LOCAL_CACHE,false, 0, 0xe1a00000, 4, "CFileMgr_Android skip cache: strip nop" },
    { GUEST_PATCH_FILEMGR_LOCAL_TEMP, false, 0, 0xe1a00000, 4, "CFileMgr_Android skip temp: strip nop" },
    { GUEST_PATCH_FILEMGR_MKDIR,      false, 0, 0xea000002, 4, "CFileMgr_Android MkDir branch" },
    { GUEST_PATCH_FILEMGR_SIZE,       false, 0, 0xe1a00000, 4, "CFileMgr_Android Size nop" },
    { GUEST_PATCH_FILEMGR_EXISTS,     false, 0, 0xea00000c, 4, "CFileMgr_Android Exists branch" },
    { GUEST_PATCH_FILEMGR_DELETE,     false, 0, 0xea000002, 4, "CFileMgr_Android Delete branch" },
    { GUEST_PATCH_FILEMGR_RENAME_SRC, false, 0, 0xe1a00000, 4, "CFileMgr_Android Rename src nop" },
    { GUEST_PATCH_FILEMGR_RENAME_DST, false, 0, 0xe1a00000, 4, "CFileMgr_Android Rename dst nop" },

    /* Patch J: GameSpy network polling busy loops */
    { GUEST_PATCH_GAMESPY_GT2_THINK,  false, 0, 0xe12fff1e, 4, "gt2Think bx lr" },
    { GUEST_PATCH_GAMESPY_PEER_THINK, false, 0, 0xe12fff1e, 4, "peerThink bx lr" },
    { GUEST_PATCH_GAMESPY_NN_THINK,   false, 0, 0xe12fff1e, 4, "NNThink bx lr" },
    { GUEST_PATCH_GAMESPY_GTI2_MOV,   false, 0, 0xe3a00000, 4, "gti2ConnectionThink mov r0, 0" },
    { GUEST_PATCH_GAMESPY_GTI2_BX,    false, 0, 0xe12fff1e, 4, "gti2ConnectionThink bx lr" },
};

const game_patch_entry_t* game_patches_get_table(size_t *count) {
    if (count) *count = sizeof(s_game_patches) / sizeof(s_game_patches[0]);
    return s_game_patches;
}

void game_patches_apply_all(uint8_t *code_base) {
    if (!code_base) return;

    // Trampoline A: CGun::Draw Muzzle Flash Guard
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

    // Trampoline B: CMesh::GetNodeAt NULL Guard
    uint32_t tramp_b[5] = {
        0xe3500000, // cmp  r0, #0
        0x012fff1e, // bxeq lr
        0xe92d4ff0, // push {r4, r5, r6, r7, r8, r9, sl, fp, lr}
        0xe24dd02c, // sub  sp, sp, #44
        0xeaf91e87  // b    0x00337a74
    };
    memcpy(code_base + GUEST_PATCH_TRAMPOLINE_B, tramp_b, sizeof(tramp_b));

    // Trampoline G: CResourceLoader::Init NULL this guard
    uint32_t tramp_g[5] = {
        0xe3500000, // cmp  r0, #0
        0x012fff1e, // bxeq lr
        0xe92d41f0, // push {r4, r5, r6, r7, r8, lr}
        0xe1a05000, // mov  r5, r0
        0xeaf9da2f  // b    0x00366934
    };
    memcpy(code_base + GUEST_PATCH_TRAMPOLINE_G, tramp_g, sizeof(tramp_g));

    // Apply patch table with verification and BRIDGE_DEBUG capture
    size_t num_patches = sizeof(s_game_patches) / sizeof(s_game_patches[0]);
    for (size_t i = 0; i < num_patches; i++) {
        const game_patch_entry_t *p = &s_game_patches[i];
        if (p->size == 1) {
            uint8_t actual_old = *(uint8_t*)(code_base + p->addr);
#ifdef BRIDGE_DEBUG
            LOGI("[PATCH:CAPTURE] %s at 0x%08x: actual_old=0x%02x (new=0x%02x)",
                 p->name, p->addr, actual_old, (uint8_t)p->new_value);
#endif
            if (p->check_expected && actual_old != (uint8_t)p->expected_old) {
                LOGE("[PATCH:MISMATCH] '%s' at 0x%08x: expected 0x%02x, found 0x%02x. Patch aborted!",
                     p->name, p->addr, (uint8_t)p->expected_old, actual_old);
                continue;
            }
            *(uint8_t*)(code_base + p->addr) = (uint8_t)p->new_value;
            LOGI("[PATCH] %s at 0x%08x -> 0x%02x", p->name, p->addr, (uint8_t)p->new_value);
        } else {
            uint32_t actual_old = *(uint32_t*)(code_base + p->addr);
#ifdef BRIDGE_DEBUG
            LOGI("[PATCH:CAPTURE] %s at 0x%08x: actual_old=0x%08x (new=0x%08x)",
                 p->name, p->addr, actual_old, p->new_value);
#endif
            if (p->check_expected && actual_old != p->expected_old) {
                LOGE("[PATCH:MISMATCH] '%s' at 0x%08x: expected 0x%08x, found 0x%08x. Patch aborted!",
                     p->name, p->addr, p->expected_old, actual_old);
                continue;
            }
            *(uint32_t*)(code_base + p->addr) = p->new_value;
            LOGI("[PATCH] %s at 0x%08x -> 0x%08x", p->name, p->addr, p->new_value);
        }
    }
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
