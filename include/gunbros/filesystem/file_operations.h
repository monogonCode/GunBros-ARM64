#ifndef GUNBROS_FILE_OPERATIONS_H
#define GUNBROS_FILE_OPERATIONS_H

#include "gunbros/common/common.h"

GUNBROS_EXTERN_C_BEGIN

#define GUNBROS_STAT32_SIZE 104
#define GUNBROS_STAT32_OFF_DEV        0
#define GUNBROS_STAT32_OFF_INO        12
#define GUNBROS_STAT32_OFF_MODE       16
#define GUNBROS_STAT32_OFF_NLINK      20
#define GUNBROS_STAT32_OFF_UID        24
#define GUNBROS_STAT32_OFF_GID        28
#define GUNBROS_STAT32_OFF_RDEV       32
#define GUNBROS_STAT32_OFF_SIZE       48
#define GUNBROS_STAT32_OFF_BLKSIZE    56
#define GUNBROS_STAT32_OFF_BLOCKS     64
#define GUNBROS_STAT32_OFF_ATIME      72
#define GUNBROS_STAT32_OFF_ATIME_NSEC 76
#define GUNBROS_STAT32_OFF_MTIME      80
#define GUNBROS_STAT32_OFF_MTIME_NSEC 84
#define GUNBROS_STAT32_OFF_CTIME      88
#define GUNBROS_STAT32_OFF_CTIME_NSEC 92
#define GUNBROS_STAT32_OFF_INO64      96

#pragma pack(push, 4)
typedef struct {
    uint64_t st_dev;
    uint8_t  __pad0[4];
    uint32_t st_ino32;
    uint32_t st_mode;
    uint32_t st_nlink;
    uint32_t st_uid;
    uint32_t st_gid;
    uint64_t st_rdev;
    uint8_t  __pad3[4];
    uint32_t __pad4;
    int64_t  st_size;
    uint32_t st_blksize;
    uint32_t __pad5;
    int64_t  st_blocks;
    uint32_t atime_sec;
    uint32_t atime_nsec;
    uint32_t mtime_sec;
    uint32_t mtime_nsec;
    uint32_t ctime_sec;
    uint32_t ctime_nsec;
    uint64_t ino64;
} gunbros_stat32_t;
#pragma pack(pop)

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
