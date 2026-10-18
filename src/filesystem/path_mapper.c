#include "gunbros/filesystem/path_mapper.h"
#include <unistd.h>
#include <string.h>
#include <stdio.h>

static char s_real_files_dir[GUNBROS_PATH_MAX] = "/sdcard/Android/data/com.glu.android.gunbros_free/files/";
static char s_real_save_dir[GUNBROS_PATH_MAX] = "";

void path_mapper_set_base_dir(const char *dir) {
    if (!dir || dir[0] == '\0') return;
    size_t len = strlen(dir);
    if (len >= sizeof(s_real_files_dir) - 2) {
        len = sizeof(s_real_files_dir) - 2;
    }
    memcpy(s_real_files_dir, dir, len);
    if (len > 0 && s_real_files_dir[len - 1] != '/') {
        s_real_files_dir[len] = '/';
        s_real_files_dir[len + 1] = '\0';
    } else {
        s_real_files_dir[len] = '\0';
    }
}

const char* path_mapper_get_base_dir(void) {
    return s_real_files_dir;
}

void path_mapper_set_save_dir(const char *dir) {
    if (!dir || dir[0] == '\0') return;
    size_t len = strlen(dir);
    if (len >= sizeof(s_real_save_dir) - 2) {
        len = sizeof(s_real_save_dir) - 2;
    }
    memcpy(s_real_save_dir, dir, len);
    if (len > 0 && s_real_save_dir[len - 1] != '/') {
        s_real_save_dir[len] = '/';
        s_real_save_dir[len + 1] = '\0';
    } else {
        s_real_save_dir[len] = '\0';
    }
}

const char* path_mapper_get_save_dir(void) {
    return s_real_save_dir;
}

const char* path_mapper_normalize(const char *in_path, char *out_buf, size_t out_sz) {
    if (!out_buf || out_sz == 0) return in_path;
    if (!in_path || in_path[0] == '\0') {
        out_buf[0] = '\0';
        return in_path ? out_buf : NULL;
    }

    // Strip Glu virtual filesystem scheme prefixes ("data:", "temp:", "cache:", "apk:")
    // whether they appear standalone (e.g. "data:/prefs.dat") or embedded after path concatenation
    // (e.g. "/.../files/data:/prefs.dat").
    const char *scheme_ptr = NULL;
    if ((scheme_ptr = strstr(in_path, "data:")) != NULL) {
        in_path = scheme_ptr + 5;
        while (*in_path == '/') in_path++;
    } else if ((scheme_ptr = strstr(in_path, "temp:")) != NULL) {
        in_path = scheme_ptr + 5;
        while (*in_path == '/') in_path++;
    } else if ((scheme_ptr = strstr(in_path, "cache:")) != NULL) {
        in_path = scheme_ptr + 6;
        while (*in_path == '/') in_path++;
    } else if ((scheme_ptr = strstr(in_path, "apk:")) != NULL) {
        in_path = scheme_ptr + 4;
        while (*in_path == '/') in_path++;
    }

    const char *files_pkg = "com.glu.android.gunbros_free/files";
    size_t files_pkg_len = strlen(files_pkg);
    const char *files_ptr = strstr(in_path, files_pkg);

    if (files_ptr != NULL) {
        const char *next_ptr;
        while ((next_ptr = strstr(files_ptr + 1, files_pkg)) != NULL) {
            files_ptr = next_ptr;
        }
        const char *after_files = files_ptr + files_pkg_len;
        if (*after_files == '/') {
            after_files++;
        }
        if (strncmp(after_files, "ackTOC", 6) == 0) {
            snprintf(out_buf, out_sz, "%sp%s", s_real_files_dir, after_files);
        } else {
            snprintf(out_buf, out_sz, "%s%s", s_real_files_dir, after_files);
        }
    } else {
        const char *files_sub = strstr(in_path, "/files");
        if (files_sub != NULL && files_sub[6] != '/' && files_sub[6] != '\0') {
            const char *fname = files_sub + 6;
            snprintf(out_buf, out_sz, "%s%s", s_real_files_dir, fname);
        } else if (in_path[0] != '/') {
            if (strncmp(in_path, "ackTOC", 6) == 0) {
                snprintf(out_buf, out_sz, "%sp%s", s_real_files_dir, in_path);
            } else {
                snprintf(out_buf, out_sz, "%s%s", s_real_files_dir, in_path);
            }
        } else if (strncmp(in_path, "/sdcard/", 8) == 0 && strncmp(s_real_files_dir, "/storage/", 9) == 0) {
            snprintf(out_buf, out_sz, "/storage/emulated/0/%s", in_path + 8);
        } else if (strncmp(in_path, "/Android/", 9) == 0 && strncmp(s_real_files_dir, "/storage/", 9) == 0) {
            snprintf(out_buf, out_sz, "/storage/emulated/0/Android/%s", in_path + 9);
        } else {
            strncpy(out_buf, in_path, out_sz);
            out_buf[out_sz - 1] = '\0';
        }
    }

    // Alias/fallback: if path refers to a "wvga" file, fallback to "xga" if wvga doesn't exist
    if (strstr(out_buf, "wvga")) {
        char candidate[GUNBROS_PATH_MAX];
        strncpy(candidate, out_buf, sizeof(candidate));
        candidate[sizeof(candidate) - 1] = '\0';
        char *p = strstr(candidate, "wvga");
        if (p) {
            p[0] = 'x'; p[1] = 'g'; p[2] = 'a';
            memmove(p + 3, p + 4, strlen(p + 4) + 1);
            if (access(candidate, F_OK) == 0 || access(out_buf, F_OK) != 0) {
                strncpy(out_buf, candidate, out_sz);
                out_buf[out_sz - 1] = '\0';
            }
        }
    }

    // Alias/fallback: if target doesn't exist in base files dir, check internal save dir (e.g. app_save)
    if (s_real_save_dir[0] != '\0' && access(out_buf, F_OK) != 0) {
        const char *fname = strrchr(out_buf, '/');
        fname = fname ? fname + 1 : out_buf;
        char candidate_save[GUNBROS_PATH_MAX];
        snprintf(candidate_save, sizeof(candidate_save), "%s%s", s_real_save_dir, fname);
        if (access(candidate_save, F_OK) == 0) {
            strncpy(out_buf, candidate_save, out_sz);
            out_buf[out_sz - 1] = '\0';
        }
    }

    return out_buf;
}
