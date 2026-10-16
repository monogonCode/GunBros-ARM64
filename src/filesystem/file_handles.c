#include "gunbros/filesystem/file_handles.h"
#include <pthread.h>
#include <string.h>

static gunbros_file_entry_t s_file_table[GUNBROS_MAX_OPEN_FILES];
static pthread_mutex_t s_handles_mutex = PTHREAD_MUTEX_INITIALIZER;
static bool s_initialized = false;

void file_handles_init(void) {
    pthread_mutex_lock(&s_handles_mutex);
    memset(s_file_table, 0, sizeof(s_file_table));
    s_initialized = true;
    pthread_mutex_unlock(&s_handles_mutex);
}

int file_handles_alloc(FILE *fp, const char *path, const char *mode) {
    if (!fp) return 0;
    pthread_mutex_lock(&s_handles_mutex);
    if (!s_initialized) {
        memset(s_file_table, 0, sizeof(s_file_table));
        s_initialized = true;
    }

    int slot = 0;
    for (int i = 1; i < GUNBROS_MAX_OPEN_FILES; i++) {
        if (s_file_table[i].fp == NULL) {
            slot = i;
            s_file_table[i].fp = fp;
            s_file_table[i].bytes_read = 0;
            s_file_table[i].bytes_written = 0;
            if (path) {
                strncpy(s_file_table[i].path, path, sizeof(s_file_table[i].path) - 1);
                s_file_table[i].path[sizeof(s_file_table[i].path) - 1] = '\0';
            } else {
                s_file_table[i].path[0] = '\0';
            }
            if (mode) {
                strncpy(s_file_table[i].mode, mode, sizeof(s_file_table[i].mode) - 1);
                s_file_table[i].mode[sizeof(s_file_table[i].mode) - 1] = '\0';
            } else {
                s_file_table[i].mode[0] = '\0';
            }
            break;
        }
    }
    pthread_mutex_unlock(&s_handles_mutex);

    if (slot == 0) {
        LOGE("file_handles_alloc: Table full! (max %d open files)", GUNBROS_MAX_OPEN_FILES);
        fclose(fp);
    }
    return slot;
}

FILE* file_handles_get(int slot) {
    if (slot <= 0 || slot >= GUNBROS_MAX_OPEN_FILES) return NULL;
    pthread_mutex_lock(&s_handles_mutex);
    FILE *fp = s_file_table[slot].fp;
    pthread_mutex_unlock(&s_handles_mutex);
    return fp;
}

gunbros_file_entry_t* file_handles_get_entry(int slot) {
    if (slot <= 0 || slot >= GUNBROS_MAX_OPEN_FILES) return NULL;
    if (s_file_table[slot].fp == NULL) return NULL;
    return &s_file_table[slot];
}

FILE* file_handles_free(int slot) {
    if (slot <= 0 || slot >= GUNBROS_MAX_OPEN_FILES) return NULL;
    pthread_mutex_lock(&s_handles_mutex);
    FILE *fp = s_file_table[slot].fp;
    memset(&s_file_table[slot], 0, sizeof(s_file_table[slot]));
    pthread_mutex_unlock(&s_handles_mutex);
    return fp;
}

void file_handles_close_all(void) {
    pthread_mutex_lock(&s_handles_mutex);
    for (int i = 1; i < GUNBROS_MAX_OPEN_FILES; i++) {
        if (s_file_table[i].fp != NULL) {
            fclose(s_file_table[i].fp);
            memset(&s_file_table[i], 0, sizeof(s_file_table[i]));
        }
    }
    pthread_mutex_unlock(&s_handles_mutex);
}
