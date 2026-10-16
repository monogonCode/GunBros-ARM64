#ifndef GUNBROS_FILESYSTEM_LOGGER_H
#define GUNBROS_FILESYSTEM_LOGGER_H

#include "gunbros/common/common.h"

GUNBROS_EXTERN_C_BEGIN

typedef enum {
    FS_LOG_LEVEL_NONE = 0,
    FS_LOG_LEVEL_ERROR = 1,
    FS_LOG_LEVEL_INFO = 2,
    FS_LOG_LEVEL_VERBOSE = 3
} fs_log_level_t;

void fs_logger_set_level(fs_log_level_t level);
fs_log_level_t fs_logger_get_level(void);

void fs_log_open(const char *op, const char *orig_path, const char *norm_path, const char *mode, int slot, int err);
void fs_log_close(int slot, const char *path, int err);
void fs_log_io(const char *op, int slot, size_t requested_bytes, size_t actual_bytes, int err);
void fs_log_seek(int slot, long offset, int whence, int res, int err);
void fs_log_stat(const char *orig_path, const char *norm_path, int res, uint64_t size, uint32_t mode, int err);
void fs_log_path_op(const char *op, const char *orig_path, const char *norm_path, int res, int err);
void fs_log_rename(const char *orig_old, const char *norm_old, const char *orig_new, const char *norm_new, int res, int err);

GUNBROS_EXTERN_C_END

#endif // GUNBROS_FILESYSTEM_LOGGER_H
