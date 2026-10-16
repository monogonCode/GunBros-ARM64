#include "hle_internal.h"
#include "gunbros/filesystem/file_operations.h"
#include "gunbros/filesystem/directory_operations.h"

static void h_fopen(hle_t *c) {
    const char *path = (const char*)guest_to_host(c->r0);
    const char *mode = (const char*)guest_to_host(c->r1);
    c->r0 = (uint32_t)gunbros_fopen(path, mode);
}

static void h_fclose(hle_t *c) {
    gunbros_fclose((int)c->r0);
    c->r0 = 0;
}

static void h_fread(hle_t *c) {
    void *dst = guest_to_host(c->r0);
    c->r0 = (uint32_t)gunbros_fread(dst, c->r1, c->r2, (int)c->r3);
}

static void h_fwrite(hle_t *c) {
    const void *src = guest_to_host(c->r0);
    c->r0 = (uint32_t)gunbros_fwrite(src, c->r1, c->r2, (int)c->r3);
}

static void h_fseek(hle_t *c) {
    c->r0 = (uint32_t)gunbros_fseek((int)c->r0, (long)(int32_t)c->r1, (int)c->r2);
}

static void h_ftell(hle_t *c) {
    c->r0 = (uint32_t)gunbros_ftell((int)c->r0);
}

static void h_rewind(hle_t *c) {
    gunbros_rewind((int)c->r0);
    c->r0 = 0;
}

static void h_stat(hle_t *c) {
    const char *path = (const char*)guest_to_host(c->r0);
    void *st32 = c->r1 ? guest_to_host(c->r1) : NULL;
    c->r0 = (uint32_t)gunbros_stat(path, st32);
}

static void h_remove(hle_t *c) {
    const char *p = (const char*)guest_to_host(c->r0);
    c->r0 = (uint32_t)gunbros_remove(p);
}

static void h_rename(hle_t *c) {
    const char *p1 = (const char*)guest_to_host(c->r0);
    const char *p2 = (const char*)guest_to_host(c->r1);
    c->r0 = (uint32_t)gunbros_rename(p1, p2);
}

static void h_opendir(hle_t *c) {
    const char *p = (const char*)guest_to_host(c->r0);
    c->r0 = (uint32_t)gunbros_opendir(p);
}

static void h_readdir(hle_t *c) {
    uint32_t h = c->r0;
    static uint32_t s_dirent_guest = 0;
    if (!s_dirent_guest) s_dirent_guest = guest_alloc(GUNBROS_DIRENT_SIZE);
    void *g = guest_to_host(s_dirent_guest);
    int res = gunbros_readdir((int)h, g);
    c->r0 = (res > 0) ? s_dirent_guest : 0;
}

static void h_closedir(hle_t *c) {
    gunbros_closedir((int)c->r0);
    c->r0 = 0;
}

static void h_mkdir(hle_t *c) {
    const char *p = (const char*)guest_to_host(c->r0);
    c->r0 = (uint32_t)gunbros_mkdir(p, (mode_t)c->r1);
}

static void h_rmdir(hle_t *c) {
    const char *p = (const char*)guest_to_host(c->r0);
    c->r0 = (uint32_t)gunbros_rmdir(p);
}

const hle_def_t g_hle_libc_stdio_defs[] = {
    {"fopen", h_fopen}, {"fclose", h_fclose}, {"fread", h_fread}, {"fwrite", h_fwrite},
    {"fseek", h_fseek}, {"ftell", h_ftell}, {"rewind", h_rewind}, {"stat", h_stat},
    {"remove", h_remove}, {"rename", h_rename}, {"opendir", h_opendir}, {"readdir", h_readdir},
    {"closedir", h_closedir}, {"mkdir", h_mkdir}, {"rmdir", h_rmdir},
};

const size_t g_hle_libc_stdio_defs_count = sizeof(g_hle_libc_stdio_defs) / sizeof(g_hle_libc_stdio_defs[0]);
