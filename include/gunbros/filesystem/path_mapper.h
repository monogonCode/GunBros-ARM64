#ifndef GUNBROS_PATH_MAPPER_H
#define GUNBROS_PATH_MAPPER_H

#include "gunbros/common/common.h"

GUNBROS_EXTERN_C_BEGIN

#define GUNBROS_PATH_MAX 512

void path_mapper_set_base_dir(const char *dir);
const char* path_mapper_get_base_dir(void);

/**
 * Normalizes an incoming game path into the real canonical storage path.
 * Applies Glu-specific rules:
 * - Redirection of com.glu.android.gunbros_free/files/
 * - Handling of missing 'p' prefix in packTOC (ackTOC rule)
 * - Mapping relative paths to base storage directory
 * - Redirection of legacy /sdcard/ to /storage/emulated/0/
 * - WVGA to XGA fallback when WVGA asset pack is missing
 */
const char* path_mapper_normalize(const char *in_path, char *out_buf, size_t out_sz);

GUNBROS_EXTERN_C_END

#endif // GUNBROS_PATH_MAPPER_H
