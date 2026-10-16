#include "gunbros/filesystem/file_operations.h"
#include "gunbros/filesystem/path_mapper.h"
#include "gunbros/filesystem/file_handles.h"
#include "gunbros/filesystem/filesystem_logger.h"
#include <sys/stat.h>
#include <unistd.h>
#include <errno.h>

static inline bool is_save_file_path(const char *path) {
    if (!path) return false;
    if (strstr(path, "savegame.dat")) return true;
    if (strstr(path, "prefs.dat")) return true;
    if (strstr(path, "crashcheck.dat")) return true;
    if (strstr(path, "temp.dat")) return true;
    if (strstr(path, "-1_")) return true;
    if (strncmp(path, "data:", 5) == 0) return true;
    return false;
}

int gunbros_fopen(const char *path, const char *mode) {
    if (!path || !mode) {
        fs_log_open("fopen", path, NULL, mode, 0, EINVAL);
        return 0;
    }

    char norm_path[GUNBROS_PATH_MAX];
    const char *target_path = path_mapper_normalize(path, norm_path, sizeof(norm_path));

    FILE *fp = (target_path && mode) ? fopen(target_path, mode) : NULL;
    int err = errno;

    if (fp == NULL && path != target_path && path && mode) {
        fp = fopen(path, mode);
        if (fp != NULL) {
            target_path = path;
            err = 0;
        } else {
            err = errno;
        }
    }

    int slot = 0;
    if (fp != NULL) {
        slot = file_handles_alloc(fp, target_path, mode);
        fs_log_open("fopen", path, target_path, mode, slot, 0);
    } else {
        fs_log_open("fopen", path, target_path, mode, 0, err);
    }

#ifdef BRIDGE_DEBUG
    if (is_save_file_path(path) || is_save_file_path(target_path)) {
        LOGI("[FS:SAVE:fopen] path='%s' (target='%s') mode='%s' slot=%d err=%d",
             path, target_path ? target_path : "", mode ? mode : "", slot, slot > 0 ? 0 : err);
    }
#endif

    return slot;
}

int gunbros_fclose(int slot) {
    gunbros_file_entry_t *entry = file_handles_get_entry(slot);
    char saved_path[GUNBROS_PATH_MAX] = {0};
    char saved_mode[16] = {0};
    bool is_wb = false;
    bool is_save = false;

    if (entry) {
        if (entry->path[0]) strncpy(saved_path, entry->path, sizeof(saved_path) - 1);
        if (entry->mode[0]) strncpy(saved_mode, entry->mode, sizeof(saved_mode) - 1);
        is_wb = (strstr(saved_mode, "wb") != NULL);
        is_save = is_save_file_path(saved_path);
    }

    FILE *fp = file_handles_free(slot);
    if (fp != NULL) {
        fflush(fp);
        int res = fclose(fp);
        int err = (res == 0) ? 0 : errno;
        fs_log_close(slot, saved_path, err);

#ifdef BRIDGE_DEBUG
        if (is_save || is_wb) {
            LOGI("[FS:SAVE:fclose] slot=%d path='%s' mode='%s' res=%d err=%d",
                 slot, saved_path, saved_mode, res, err);
        }
        if (is_wb && saved_path[0]) {
            FILE *dfp = fopen(saved_path, "rb");
            if (dfp) {
                fseek(dfp, 0, SEEK_END);
                long file_sz = ftell(dfp);
                fseek(dfp, 0, SEEK_SET);

                uint8_t hex_buf[64];
                size_t n_dump = fread(hex_buf, 1, sizeof(hex_buf), dfp);
                fclose(dfp);

                char hex_str[64 * 3 + 1];
                hex_str[0] = '\0';
                for (size_t i = 0; i < n_dump; i++) {
                    snprintf(hex_str + i * 3, 4, "%02x ", hex_buf[i]);
                }
                LOGI("[FS:SAVE:HEXDUMP] path='%s' size=%ld first_%zu_bytes: %s",
                     saved_path, file_sz, n_dump, hex_str);
            }
        }
#endif
        return res;
    }
    errno = EBADF;
    return EOF;
}

size_t gunbros_fread(void *dst, size_t size, size_t count, int slot) {
    if (!dst || size == 0 || count == 0) return 0;
    gunbros_file_entry_t *entry = file_handles_get_entry(slot);
    if (!entry || !entry->fp) {
        fs_log_io("fread", slot, size * count, 0, EBADF);
        return 0;
    }

    size_t items_read = fread(dst, size, count, entry->fp);
    size_t bytes_read = items_read * size;
    entry->bytes_read += bytes_read;
    int err = (items_read < count && ferror(entry->fp)) ? errno : 0;
    fs_log_io("fread", slot, size * count, bytes_read, err);

#ifdef BRIDGE_DEBUG
    if (is_save_file_path(entry->path)) {
        LOGI("[FS:SAVE:fread] slot=%d path='%s' req=%zu got=%zu err=%d",
             slot, entry->path, size * count, bytes_read, err);
    }
#endif

    return items_read;
}

size_t gunbros_fwrite(const void *src, size_t size, size_t count, int slot) {
    if (!src || size == 0 || count == 0) return 0;
    gunbros_file_entry_t *entry = file_handles_get_entry(slot);
    if (!entry || !entry->fp) {
        fs_log_io("fwrite", slot, size * count, 0, EBADF);
        return 0;
    }

    size_t items_written = fwrite(src, size, count, entry->fp);
    size_t bytes_written = items_written * size;
    entry->bytes_written += bytes_written;
    fflush(entry->fp);
    int err = (items_written < count && ferror(entry->fp)) ? errno : 0;
    fs_log_io("fwrite", slot, size * count, bytes_written, err);
    return items_written;
}

int gunbros_fseek(int slot, long offset, int whence) {
    FILE *fp = file_handles_get(slot);
    if (!fp) {
        fs_log_seek(slot, offset, whence, -1, EBADF);
        return -1;
    }
    int res = fseek(fp, offset, whence);
    int err = (res == 0) ? 0 : errno;
    fs_log_seek(slot, offset, whence, res, err);

#ifdef BRIDGE_DEBUG
    gunbros_file_entry_t *entry = file_handles_get_entry(slot);
    if (entry && is_save_file_path(entry->path)) {
        LOGI("[FS:SAVE:fseek] slot=%d path='%s' offset=%ld whence=%d res=%d err=%d",
             slot, entry->path, offset, whence, res, err);
    }
#endif

    return res;
}

long gunbros_ftell(int slot) {
    FILE *fp = file_handles_get(slot);
    if (!fp) {
        errno = EBADF;
        return -1L;
    }
    long res = ftell(fp);

#ifdef BRIDGE_DEBUG
    gunbros_file_entry_t *entry = file_handles_get_entry(slot);
    if (entry && is_save_file_path(entry->path)) {
        LOGI("[FS:SAVE:ftell] slot=%d path='%s' pos=%ld", slot, entry->path, res);
    }
#endif

    return res;
}

void gunbros_rewind(int slot) {
    FILE *fp = file_handles_get(slot);
    if (fp) rewind(fp);

#ifdef BRIDGE_DEBUG
    gunbros_file_entry_t *entry = file_handles_get_entry(slot);
    if (entry && is_save_file_path(entry->path)) {
        LOGI("[FS:SAVE:rewind] slot=%d path='%s'", slot, entry->path);
    }
#endif
}

int gunbros_stat(const char *path, void *st32_out) {
    if (!path) return -1;
    char norm_path[GUNBROS_PATH_MAX];
    const char *target_path = path_mapper_normalize(path, norm_path, sizeof(norm_path));
    struct stat st;
    int res = target_path ? stat(target_path, &st) : -1;
    int err = errno;

    if (res != 0 && path != target_path && path) {
        res = stat(path, &st);
        if (res == 0) {
            target_path = path;
            err = 0;
        } else {
            err = errno;
        }
    }

    if (res == 0) {
        if (st32_out != NULL) {
            uint8_t *st32 = (uint8_t*)st32_out;
            memset(st32, 0, GUNBROS_STAT32_SIZE);

            uint64_t dev = (uint64_t)st.st_dev;
            uint32_t ino32 = (uint32_t)st.st_ino;
            uint32_t mode = (uint32_t)st.st_mode;
            uint32_t nlink = (uint32_t)st.st_nlink;
            uint32_t uid = (uint32_t)st.st_uid;
            uint32_t gid = (uint32_t)st.st_gid;
            uint64_t rdev = (uint64_t)st.st_rdev;
            int64_t size = (int64_t)st.st_size;
            uint32_t blksize = (uint32_t)st.st_blksize;
            int64_t blocks = (int64_t)st.st_blocks;

#if defined(__APPLE__)
            uint32_t atime = (uint32_t)st.st_atimespec.tv_sec;
            uint32_t atime_nsec = (uint32_t)st.st_atimespec.tv_nsec;
            uint32_t mtime = (uint32_t)st.st_mtimespec.tv_sec;
            uint32_t mtime_nsec = (uint32_t)st.st_mtimespec.tv_nsec;
            uint32_t ctime = (uint32_t)st.st_ctimespec.tv_sec;
            uint32_t ctime_nsec = (uint32_t)st.st_ctimespec.tv_nsec;
#else
            uint32_t atime = (uint32_t)st.st_atim.tv_sec;
            uint32_t atime_nsec = (uint32_t)st.st_atim.tv_nsec;
            uint32_t mtime = (uint32_t)st.st_mtim.tv_sec;
            uint32_t mtime_nsec = (uint32_t)st.st_mtim.tv_nsec;
            uint32_t ctime = (uint32_t)st.st_ctim.tv_sec;
            uint32_t ctime_nsec = (uint32_t)st.st_ctim.tv_nsec;
#endif
            uint64_t ino64 = (uint64_t)st.st_ino;

            memcpy(st32 + GUNBROS_STAT32_OFF_DEV,        &dev,        8);
            memcpy(st32 + GUNBROS_STAT32_OFF_INO,        &ino32,      4);
            memcpy(st32 + GUNBROS_STAT32_OFF_MODE,       &mode,       4);
            memcpy(st32 + GUNBROS_STAT32_OFF_NLINK,      &nlink,      4);
            memcpy(st32 + GUNBROS_STAT32_OFF_UID,        &uid,        4);
            memcpy(st32 + GUNBROS_STAT32_OFF_GID,        &gid,        4);
            memcpy(st32 + GUNBROS_STAT32_OFF_RDEV,       &rdev,       8);
            memcpy(st32 + GUNBROS_STAT32_OFF_SIZE,       &size,       8);
            memcpy(st32 + GUNBROS_STAT32_OFF_BLKSIZE,    &blksize,    4);
            memcpy(st32 + GUNBROS_STAT32_OFF_BLOCKS,     &blocks,     8);
            memcpy(st32 + GUNBROS_STAT32_OFF_ATIME,      &atime,      4);
            memcpy(st32 + GUNBROS_STAT32_OFF_ATIME_NSEC, &atime_nsec, 4);
            memcpy(st32 + GUNBROS_STAT32_OFF_MTIME,      &mtime,      4);
            memcpy(st32 + GUNBROS_STAT32_OFF_MTIME_NSEC, &mtime_nsec, 4);
            memcpy(st32 + GUNBROS_STAT32_OFF_CTIME,      &ctime,      4);
            memcpy(st32 + GUNBROS_STAT32_OFF_CTIME_NSEC, &ctime_nsec, 4);
            memcpy(st32 + GUNBROS_STAT32_OFF_INO64,      &ino64,      8);
        }
        fs_log_stat(path, target_path, 0, (uint64_t)st.st_size, (uint32_t)st.st_mode, 0);
#ifdef BRIDGE_DEBUG
        if (is_save_file_path(path) || is_save_file_path(target_path)) {
            LOGI("[FS:SAVE:stat] path='%s' (target='%s') res=0 size=%lld mode=0%o",
                 path, target_path ? target_path : "", (long long)st.st_size, st.st_mode);
        }
#endif
        return 0;
    } else {
        fs_log_stat(path, target_path, -1, 0, 0, err);
#ifdef BRIDGE_DEBUG
        if (is_save_file_path(path) || is_save_file_path(target_path)) {
            LOGI("[FS:SAVE:stat] path='%s' (target='%s') res=-1 err=%d",
                 path, target_path ? target_path : "", err);
        }
#endif
        return -1;
    }
}

int gunbros_remove(const char *path) {
    if (!path) return -1;
    char norm_path[GUNBROS_PATH_MAX];
    const char *target_path = path_mapper_normalize(path, norm_path, sizeof(norm_path));
    int res = target_path ? remove(target_path) : -1;
    int err = (res == 0) ? 0 : errno;
    fs_log_path_op("remove", path, target_path, res, err);
    return res;
}

int gunbros_rename(const char *old_path, const char *new_path) {
    if (!old_path || !new_path) return -1;
    char norm_old[GUNBROS_PATH_MAX];
    char norm_new[GUNBROS_PATH_MAX];
    const char *target_old = path_mapper_normalize(old_path, norm_old, sizeof(norm_old));
    const char *target_new = path_mapper_normalize(new_path, norm_new, sizeof(norm_new));
    int res = (target_old && target_new) ? rename(target_old, target_new) : -1;
    int err = (res == 0) ? 0 : errno;
    fs_log_rename(old_path, target_old, new_path, target_new, res, err);
    return res;
}
