#ifndef GUNBROS_DIRECTORY_OPERATIONS_H
#define GUNBROS_DIRECTORY_OPERATIONS_H

#include "gunbros/common/common.h"
#include <sys/stat.h>

GUNBROS_EXTERN_C_BEGIN

#define GUNBROS_MAX_DIRS 16
#define GUNBROS_DIRENT_SIZE 288

int gunbros_opendir(const char *path);
int gunbros_readdir(int dir_slot, void *guest_dirent_buf);
int gunbros_closedir(int dir_slot);
int gunbros_mkdir(const char *path, mode_t mode);
int gunbros_rmdir(const char *path);
void gunbros_closedir_all(void);

GUNBROS_EXTERN_C_END

#endif // GUNBROS_DIRECTORY_OPERATIONS_H
