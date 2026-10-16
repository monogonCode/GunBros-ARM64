#ifndef GUNBROS_FILE_OPERATIONS_H
#define GUNBROS_FILE_OPERATIONS_H

#include "gunbros/common/common.h"

GUNBROS_EXTERN_C_BEGIN

int gunbros_fopen(const char *path, const char *mode);
int gunbros_fclose(int slot);
size_t gunbros_fread(void *dst, size_t size, size_t count, int slot);
size_t gunbros_fwrite(const void *src, size_t size, size_t count, int slot);
int gunbros_fseek(int slot, long offset, int whence);
long gunbros_ftell(int slot);
void gunbros_rewind(int slot);
int gunbros_stat(const char *path, void *st32_out);
int gunbros_remove(const char *path);
int gunbros_rename(const char *old_path, const char *new_path);

GUNBROS_EXTERN_C_END

#endif // GUNBROS_FILE_OPERATIONS_H
