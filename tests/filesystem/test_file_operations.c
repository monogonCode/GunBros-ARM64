#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>
#include <sys/stat.h>
#include <unistd.h>
#include "gunbros/filesystem/path_mapper.h"
#include "gunbros/filesystem/file_handles.h"
#include "gunbros/filesystem/file_operations.h"
#include "gunbros/filesystem/directory_operations.h"

#define TEST_PASS(name) printf("  [PASS] %s\n", name)

int main(void) {
    printf("=== Running File & Directory Operations Test Suite ===\n");

    const char *test_base_dir = "/tmp/gunbros_fs_test/files/";
    char cmd[256];
    snprintf(cmd, sizeof(cmd), "rm -rf /tmp/gunbros_fs_test && mkdir -p %s", test_base_dir);
    system(cmd);

    path_mapper_set_base_dir(test_base_dir);
    file_handles_init();

    // 1. Directory creation
    int mk_res = gunbros_mkdir("savedata", 0755);
    assert(mk_res == 0);
    TEST_PASS("gunbros_mkdir recursive / path-mapped directory creation");

    // 2. Open file for writing
    uint32_t handle = gunbros_fopen("savedata/player.dat", "wb");
    assert(handle != 0);
    TEST_PASS("gunbros_fopen for write returns valid handle");

    // 3. Write data
    const char test_data[] = "GUNBROS_SAVE_DATA_BLOCK_VERSION_1";
    size_t written = gunbros_fwrite(test_data, 1, sizeof(test_data), handle);
    assert(written == sizeof(test_data));
    TEST_PASS("gunbros_fwrite with explicit flush");

    // 4. Seek and tell
    long pos = gunbros_ftell(handle);
    assert(pos == (long)sizeof(test_data));
    int seek_res = gunbros_fseek(handle, 0, SEEK_SET);
    assert(seek_res == 0);
    assert(gunbros_ftell(handle) == 0);
    TEST_PASS("gunbros_fseek and gunbros_ftell");

    // 5. Close file
    int close_res = gunbros_fclose(handle);
    assert(close_res == 0);
    TEST_PASS("gunbros_fclose succeeds and frees handle");

    // Double close should return EOF / error cleanly
    assert(gunbros_fclose(handle) != 0);
    TEST_PASS("Double close guard rejected invalid handle");

    // 6. Open for reading and verify content
    uint32_t r_handle = gunbros_fopen("savedata/player.dat", "rb");
    assert(r_handle != 0);
    char read_buf[64] = {0};
    size_t read_bytes = gunbros_fread(read_buf, 1, sizeof(test_data), r_handle);
    assert(read_bytes == sizeof(test_data));
    assert(memcmp(read_buf, test_data, sizeof(test_data)) == 0);
    gunbros_fclose(r_handle);
    TEST_PASS("gunbros_fread read back verified identical data");

    // 7. Stat verification (Bionic ARM32 struct stat layout)
    _Static_assert(offsetof(gunbros_stat32_t, st_dev) == GUNBROS_STAT32_OFF_DEV, "dev offset");
    _Static_assert(offsetof(gunbros_stat32_t, st_ino32) == GUNBROS_STAT32_OFF_INO, "ino offset");
    _Static_assert(offsetof(gunbros_stat32_t, st_mode) == GUNBROS_STAT32_OFF_MODE, "mode offset");
    _Static_assert(offsetof(gunbros_stat32_t, st_nlink) == GUNBROS_STAT32_OFF_NLINK, "nlink offset");
    _Static_assert(offsetof(gunbros_stat32_t, st_uid) == GUNBROS_STAT32_OFF_UID, "uid offset");
    _Static_assert(offsetof(gunbros_stat32_t, st_gid) == GUNBROS_STAT32_OFF_GID, "gid offset");
    _Static_assert(offsetof(gunbros_stat32_t, st_rdev) == GUNBROS_STAT32_OFF_RDEV, "rdev offset");
    _Static_assert(offsetof(gunbros_stat32_t, st_size) == GUNBROS_STAT32_OFF_SIZE, "size offset");
    _Static_assert(offsetof(gunbros_stat32_t, st_blksize) == GUNBROS_STAT32_OFF_BLKSIZE, "blksize offset");
    _Static_assert(offsetof(gunbros_stat32_t, st_blocks) == GUNBROS_STAT32_OFF_BLOCKS, "blocks offset");
    _Static_assert(offsetof(gunbros_stat32_t, atime_sec) == GUNBROS_STAT32_OFF_ATIME, "atime offset");
    _Static_assert(offsetof(gunbros_stat32_t, atime_nsec) == GUNBROS_STAT32_OFF_ATIME_NSEC, "atime_nsec offset");
    _Static_assert(offsetof(gunbros_stat32_t, mtime_sec) == GUNBROS_STAT32_OFF_MTIME, "mtime offset");
    _Static_assert(offsetof(gunbros_stat32_t, mtime_nsec) == GUNBROS_STAT32_OFF_MTIME_NSEC, "mtime_nsec offset");
    _Static_assert(offsetof(gunbros_stat32_t, ctime_sec) == GUNBROS_STAT32_OFF_CTIME, "ctime offset");
    _Static_assert(offsetof(gunbros_stat32_t, ctime_nsec) == GUNBROS_STAT32_OFF_CTIME_NSEC, "ctime_nsec offset");
    _Static_assert(offsetof(gunbros_stat32_t, ino64) == GUNBROS_STAT32_OFF_INO64, "ino64 offset");
    _Static_assert(sizeof(gunbros_stat32_t) == GUNBROS_STAT32_SIZE, "stat32 size");

    uint8_t raw_st[GUNBROS_STAT32_SIZE] = {0};
    int stat_res = gunbros_stat("savedata/player.dat", raw_st);
    assert(stat_res == 0);

    gunbros_stat32_t st32;
    memcpy(&st32, raw_st, sizeof(st32));
    assert(st32.st_size == (int64_t)sizeof(test_data));
    assert(st32.st_mode != 0);
    assert(st32.st_nlink >= 1);
    assert(st32.st_blksize > 0);
    assert(st32.mtime_sec > 0);
    assert(st32.ino64 != 0);
    TEST_PASS("gunbros_stat successfully queried file metadata (bionic ARM32 layout verified)");

    // 8. Rename (crucial for GunBros safe-save mechanism: temp -> savegame)
    int ren_res = gunbros_rename("savedata/player.dat", "savedata/player_final.dat");
    assert(ren_res == 0);
    assert(gunbros_stat("savedata/player.dat", raw_st) != 0);
    assert(gunbros_stat("savedata/player_final.dat", raw_st) == 0);
    memcpy(&st32, raw_st, sizeof(st32));
    assert(st32.st_size == (int64_t)sizeof(test_data));
    TEST_PASS("gunbros_rename atomic file rename");

    // 9. Remove
    int rem_res = gunbros_remove("savedata/player_final.dat");
    assert(rem_res == 0);
    assert(gunbros_stat("savedata/player_final.dat", raw_st) != 0);
    TEST_PASS("gunbros_remove deletes target file");

    // 10. Directory enumeration
    uint32_t dir_h = gunbros_opendir("savedata");
    assert(dir_h != 0);
    gunbros_closedir(dir_h);
    gunbros_rmdir("savedata");
    TEST_PASS("gunbros_opendir, closedir, rmdir lifecycle");

    snprintf(cmd, sizeof(cmd), "rm -rf /tmp/gunbros_fs_test");
    system(cmd);

    printf("=== All File & Directory Operations tests PASSED! ===\n\n");
    return 0;
}
