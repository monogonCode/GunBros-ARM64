#include "gunbros/filesystem/filesystem_logger.h"
#include <string.h>

#ifdef __ANDROID__
#undef LOG_TAG
#define LOG_TAG "GunBrosFS"
#undef LOGI
#undef LOGE
#define LOGI(...) __android_log_print(ANDROID_LOG_INFO, LOG_TAG, __VA_ARGS__)
#define LOGE(...) __android_log_print(ANDROID_LOG_ERROR, LOG_TAG, __VA_ARGS__)
#endif

#ifdef BRIDGE_DEBUG
static fs_log_level_t s_log_level = FS_LOG_LEVEL_VERBOSE;
#else
static fs_log_level_t s_log_level = FS_LOG_LEVEL_INFO;
#endif

void fs_logger_set_level(fs_log_level_t level) {
    s_log_level = level;
}

fs_log_level_t fs_logger_get_level(void) {
    return s_log_level;
}

void fs_log_open(const char *op, const char *orig_path, const char *norm_path, const char *mode, int slot, int err) {
    if (s_log_level < FS_LOG_LEVEL_ERROR) return;
    if (slot > 0) {
        if (s_log_level >= FS_LOG_LEVEL_INFO) {
            LOGI("[FS:%s] SUCCESS slot=%d mode='%s' path='%s' (orig='%s')",
                 op, slot, mode ? mode : "", norm_path ? norm_path : "", orig_path ? orig_path : "");
        }
    } else {
        LOGE("[FS:%s] FAILED mode='%s' path='%s' (orig='%s') errno=%d: %s",
             op, mode ? mode : "", norm_path ? norm_path : "", orig_path ? orig_path : "", err, strerror(err));
    }
}

void fs_log_close(int slot, const char *path, int err) {
    if (s_log_level < FS_LOG_LEVEL_INFO) return;
    if (err == 0) {
        DLOG("[FS:fclose] slot=%d path='%s' OK", slot, path ? path : "");
    } else {
        LOGE("[FS:fclose] slot=%d path='%s' FAILED errno=%d: %s", slot, path ? path : "", err, strerror(err));
    }
}

void fs_log_io(const char *op, int slot, size_t requested_bytes, size_t actual_bytes, int err) {
    if (s_log_level < FS_LOG_LEVEL_VERBOSE && err == 0) return;
    if (err != 0 || actual_bytes < requested_bytes) {
        LOGI("[FS:%s] slot=%d req=%zu got=%zu errno=%d", op, slot, requested_bytes, actual_bytes, err);
    } else {
        DLOG("[FS:%s] slot=%d bytes=%zu", op, slot, actual_bytes);
    }
}

void fs_log_seek(int slot, long offset, int whence, int res, int err) {
    if (s_log_level < FS_LOG_LEVEL_VERBOSE && res == 0) return;
    if (res != 0) {
        LOGE("[FS:fseek] slot=%d off=%ld whence=%d FAILED errno=%d: %s", slot, offset, whence, err, strerror(err));
    } else {
        DLOG("[FS:fseek] slot=%d off=%ld whence=%d OK", slot, offset, whence);
    }
}

void fs_log_stat(const char *orig_path, const char *norm_path, int res, uint64_t size, uint32_t mode, int err) {
    if (s_log_level < FS_LOG_LEVEL_INFO) return;
    if (res == 0) {
        LOGI("[FS:stat] SUCCESS '%s' (orig='%s') -> size=%llu mode=0%o",
             norm_path ? norm_path : "", orig_path ? orig_path : "", (unsigned long long)size, mode);
        (void)err;
    } else {
        DLOG("[FS:stat] FAILED '%s' (orig='%s') errno=%d: %s",
             norm_path ? norm_path : "", orig_path ? orig_path : "", err, strerror(err));
    }
}

void fs_log_path_op(const char *op, const char *orig_path, const char *norm_path, int res, int err) {
    if (s_log_level < FS_LOG_LEVEL_INFO) return;
    if (res == 0) {
        LOGI("[FS:%s] SUCCESS '%s' (orig='%s')", op, norm_path ? norm_path : "", orig_path ? orig_path : "");
    } else {
        LOGE("[FS:%s] FAILED '%s' (orig='%s') errno=%d: %s", op, norm_path ? norm_path : "", orig_path ? orig_path : "", err, strerror(err));
    }
}

void fs_log_rename(const char *orig_old, const char *norm_old, const char *orig_new, const char *norm_new, int res, int err) {
    if (s_log_level < FS_LOG_LEVEL_INFO) return;
    if (res == 0) {
        LOGI("[FS:rename] SUCCESS '%s' -> '%s'", norm_old ? norm_old : "", norm_new ? norm_new : "");
    } else {
        LOGE("[FS:rename] FAILED '%s' -> '%s' (orig: '%s' -> '%s') errno=%d: %s",
             norm_old ? norm_old : "", norm_new ? norm_new : "",
             orig_old ? orig_old : "", orig_new ? orig_new : "",
             err, strerror(err));
    }
}
