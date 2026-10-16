#ifndef GUNBROS_GAME_HOOKS_H
#define GUNBROS_GAME_HOOKS_H

#include "gunbros/common/common.h"

GUNBROS_EXTERN_C_BEGIN

/**
 * Game-specific hook invoked on TouchEnded (touch type 2).
 * In PLAYER_SELECT state (5), detects tapping Percy Gun vs Francis Gun
 * and calls the guest character selection procedure.
 */
void game_hooks_on_touch_ended(int x, int y);

GUNBROS_EXTERN_C_END

#endif // GUNBROS_GAME_HOOKS_H
