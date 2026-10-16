#include "gunbros/filesystem/directory_operations.h"
#include "gunbros/filesystem/path_mapper.h"
#include "gunbros/filesystem/filesystem_logger.h"
#include <dirent.h>
#include <unistd.h>
#include <pthread.h>
#include <string.h>
#include <errno.h>

static DIR *s_dirs[GUNBROS_MAX_DIRS];
static pthread_mutex_t s_dirs_mutex = PTHREAD_MUTEX_INITIALIZER;

int gunbros_opendir(const char *path) {
    if (!path) return 0;
    char norm_path[GUNBROS_PATH_MAX];
    const char *target_path = path_mapper_normalize(path, norm_path, sizeof(norm_path));
    DIR *d = target_path ? opendir(target_path) : NULL;
    int err = errno;

    if (!d && path != target_path && path) {
        d = opendir(path);
        if (d) {
            target_path = path;
            err = 0;
        } else {
            err = errno;
        }
    }

    if (!d) {
        fs_log_path_op("opendir", path, target_path, -1, err);
        return 0;
    }

    pthread_mutex_lock(&s_dirs_mutex);
    int slot = 0;
    for (int i = 1; i < GUNBROS_MAX_DIRS; i++) {
        if (!s_dirs[i]) {
            s_dirs[i] = d;
            slot = i;
            break;
        }
    }
    pthread_mutex_unlock(&s_dirs_mutex);

    if (slot == 0) {
        closedir(d);
        LOGE("gunbros_opendir: Directory handles table full! (max %d)", GUNBROS_MAX_DIRS);
        return 0;
    }

    fs_log_path_op("opendir", path, target_path, (slot > 0 ? 0 : -1), 0);
    return slot;
}

int gunbros_readdir(int dir_slot, void *guest_dirent_buf) {
    if (dir_slot <= 0 || dir_slot >= GUNBROS_MAX_DIRS || !guest_dirent_buf) return -1;
    pthread_mutex_lock(&s_dirs_mutex);
    DIR *d = s_dirs[dir_slot];
    pthread_mutex_unlock(&s_dirs_mutex);

    if (!d) return -1;

    struct dirent *e = readdir(d);
    if (!e) return 0; // EOF or error

    uint8_t *g = (uint8_t*)guest_dirent_buf;
    memset(g, 0, GUNBROS_DIRENT_SIZE);
    uint64_t ino = e->d_ino;
    int64_t off = e->d_off;
    uint16_t rl = 280;
    memcpy(g, &ino, 8);
    memcpy(g + 8, &off, 8);
    memcpy(g + 16, &rl, 2);
    g[18] = e->d_type;
    strncpy((char*)g + 19, e->d_name, 255);
    g[287] = '\0';
    return 1;
}

int gunbros_closedir(int dir_slot) {
    if (dir_slot <= 0 || dir_slot >= GUNBROS_MAX_DIRS) return -1;
    pthread_mutex_lock(&s_dirs_mutex);
    DIR *d = s_dirs[dir_slot];
    s_dirs[dir_slot] = NULL;
    pthread_mutex_unlock(&s_dirs_mutex);

    if (d) {
        int res = closedir(d);
        fs_log_close(dir_slot, "directory", (res == 0) ? 0 : errno);
        return res;
    }
    return 0;
}

int gunbros_mkdir(const char *path, mode_t mode) {
    if (!path) return -1;
    char norm_path[GUNBROS_PATH_MAX];
    const char *target_path = path_mapper_normalize(path, norm_path, sizeof(norm_path));
    int res = target_path ? mkdir(target_path, mode) : -1;
    int err = (res == 0) ? 0 : errno;
    fs_log_path_op("mkdir", path, target_path, res, err);
    return res;
}

int gunbros_rmdir(const char *path) {
    if (!path) return -1;
    char norm_path[GUNBROS_PATH_MAX];
    const char *target_path = path_mapper_normalize(path, norm_path, sizeof(norm_path));
    int res = target_path ? rmdir(target_path) : -1;
    int err = (res == 0) ? 0 : errno;
    fs_log_path_op("rmdir", path, target_path, res, err);
    return res;
}

void gunbros_closedir_all(void) {
    pthread_mutex_lock(&s_dirs_mutex);
    for (int i = 1; i < GUNBROS_MAX_DIRS; i++) {
        if (s_dirs[i]) {
            closedir(s_dirs[i]);
            s_dirs[i] = NULL;
        }
    }
    pthread_mutex_unlock(&s_dirs_mutex);
}
