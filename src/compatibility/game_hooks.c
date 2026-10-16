#include "gunbros/compatibility/game_hooks.h"
#include "gunbros/compatibility/guest_symbols.h"
#include "gunbros/emulator/guest_memory.h"
#include "gunbros/emulator/dynarmic_backend.h"
#include "gunbros/emulator/hle_dispatcher.h"
#include "gunbros/platform/android_window.h"

void game_hooks_on_touch_ended(int x, int y) {
    (void)y;
    uint32_t app_ptr = 0;
    guest_mem_read(GUEST_ADDR_APP_PTR, &app_ptr, 4);
    if (app_ptr == 0) return;

    uint32_t gunbros = 0;
    guest_mem_read(app_ptr + GUEST_OFF_APP_GUNBROS, &gunbros, 4);
    if (gunbros == 0) return;

    uint32_t gstate = 0;
    guest_mem_read(gunbros + GUEST_OFF_GB_GSTATE, &gstate, 4);
    if (gstate != 5) return; // PLAYER_SELECT state

    uint32_t menu_sys = 0;
    guest_mem_read(gunbros + GUEST_OFF_GB_MENUSYS, &menu_sys, 4);
    if (menu_sys == 0) return;

    uint32_t top_menu = 0;
    guest_mem_read(menu_sys + GUEST_OFF_MENU_TOP, &top_menu, 4);
    if (top_menu == 0) return;

    int gw = 1024, gh = 640;
    window_get_dimensions(&gw, &gh);
    uint32_t sel = (x < gw / 2) ? 0 : 1;
    DLOG("TouchEnded in PLAYER_SELECT: selecting %s (index %d, top=0x%x)",
         sel == 0 ? "Percy Gun" : "Francis Gun", sel, top_menu);
    prepare_call_arm(top_menu);
    dynarmic_backend_set_reg(1, sel);
    run_guest(GUEST_FN_SELECT_CHAR, "select_char");
}
