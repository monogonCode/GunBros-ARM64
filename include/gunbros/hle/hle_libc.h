#ifndef GUNBROS_HLE_LIBC_H
#define GUNBROS_HLE_LIBC_H

#include "gunbros/emulator/hle_dispatcher.h"

GUNBROS_EXTERN_C_BEGIN

/* Handlers from libc_stdio.c */
void h_fseek(hle_t *c);
void h_ftell(hle_t *c);
void h_stat(hle_t *c);
void h_fopen(hle_t *c);
void h_fclose(hle_t *c);
void h_fread(hle_t *c);
void h_fwrite(hle_t *c);
void h_rewind(hle_t *c);
void h_remove(hle_t *c);
void h_rename(hle_t *c);
void h_mkdir(hle_t *c);
void h_rmdir(hle_t *c);
void h_opendir(hle_t *c);
void h_readdir(hle_t *c);
void h_closedir(hle_t *c);

/* Handlers from libc_time.c */
void h_time(hle_t *c);
void h_clock(hle_t *c);
void h_gettimeofday(hle_t *c);
void h_clock_gettime(hle_t *c);
void h_difftime(hle_t *c);
void h_localtime(hle_t *c);
void h_gmtime(hle_t *c);
void h_mktime(hle_t *c);
void h_ctime(hle_t *c);

/* Handlers from libc_string.c */
void h_sscanf(hle_t *c);
void h_sprintf(hle_t *c);
void h_snprintf(hle_t *c);
void h_vsprintf(hle_t *c);
void h_vsnprintf(hle_t *c);

/* Module tables */
extern const hle_def_t g_hle_libc_string_defs[];
extern const size_t   g_hle_libc_string_defs_count;
extern const hle_def_t g_hle_libc_time_defs[];
extern const size_t   g_hle_libc_time_defs_count;
extern const hle_def_t g_hle_libc_stdio_defs[];
extern const size_t   g_hle_libc_stdio_defs_count;

GUNBROS_EXTERN_C_END

#endif // GUNBROS_HLE_LIBC_H
