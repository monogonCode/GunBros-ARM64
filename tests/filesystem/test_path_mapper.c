#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>
#include <unistd.h>
#include <sys/stat.h>
#include "gunbros/filesystem/path_mapper.h"

#define TEST_PASS(name) printf("  [PASS] %s\n", name)

int main(void) {
    printf("=== Running Path Mapper Test Suite ===\n");

    const char *test_base_dir = "/tmp/gunbros_test_env/files/";
    char mkdir_cmd[256];
    snprintf(mkdir_cmd, sizeof(mkdir_cmd), "rm -rf /tmp/gunbros_test_env && mkdir -p %s", test_base_dir);
    system(mkdir_cmd);

    path_mapper_set_base_dir(test_base_dir);
    assert(strcmp(path_mapper_get_base_dir(), test_base_dir) == 0);
    TEST_PASS("path_mapper_set_base_dir & get_base_dir");

    // Test 1: NULL and empty path
    char out[GUNBROS_PATH_MAX];
    const char *res_null = path_mapper_normalize(NULL, out, sizeof(out));
    assert(res_null == NULL && out[0] == '\0');

    const char *res_empty = path_mapper_normalize("", out, sizeof(out));
    assert(res_empty != NULL && out[0] == '\0');
    TEST_PASS("NULL and empty path handling");

    // Test 2: Relative path mapping to base dir
    path_mapper_normalize("savegame.dat", out, sizeof(out));
    assert(strcmp(out, "/tmp/gunbros_test_env/files/savegame.dat") == 0);
    TEST_PASS("Relative path mapped to base directory");

    // Test 3: URI schemes (data:/, data:, temp:/, apk:, cache:)
    path_mapper_normalize("data:/prefs.dat", out, sizeof(out));
    assert(strcmp(out, "/tmp/gunbros_test_env/files/prefs.dat") == 0);
    path_mapper_normalize("data:savegame.dat", out, sizeof(out));
    assert(strcmp(out, "/tmp/gunbros_test_env/files/savegame.dat") == 0);
    path_mapper_normalize("temp:/temp.dat", out, sizeof(out));
    assert(strcmp(out, "/tmp/gunbros_test_env/files/temp.dat") == 0);
    path_mapper_normalize("cache:/temp_cache.bin", out, sizeof(out));
    assert(strcmp(out, "/tmp/gunbros_test_env/files/temp_cache.bin") == 0);
    path_mapper_normalize("/storage/emulated/0/Android/data/com.glu.android.gunbros_free/files/data:/prefs.dat", out, sizeof(out));
    assert(strcmp(out, "/tmp/gunbros_test_env/files/prefs.dat") == 0);
    path_mapper_normalize("/storage/emulated/0/Android/data/com.glu.android.gunbros_free/files/data:/temp.dat", out, sizeof(out));
    assert(strcmp(out, "/tmp/gunbros_test_env/files/temp.dat") == 0);
    TEST_PASS("Glu URI schemes (standalone & embedded) normalization");

    // Test 4: ackTOC rule (GunBros missing 'p' prefix)
    path_mapper_normalize("ackTOC_WVGA_300.dat", out, sizeof(out));
    assert(strstr(out, "packTOC_WVGA_300.dat") != NULL);
    TEST_PASS("ackTOC -> packTOC prepend rule");

    // Test 4: Package path extraction with com.glu.android.gunbros_free/files/
    path_mapper_normalize("/data/data/com.glu.android.gunbros_free/files/profiles.xml", out, sizeof(out));
    assert(strcmp(out, "/tmp/gunbros_test_env/files/profiles.xml") == 0);
    TEST_PASS("com.glu.android.gunbros_free/files/ redirection");

    // Test 5: Package path extraction with ackTOC inside
    path_mapper_normalize("/data/data/com.glu.android.gunbros_free/files/ackTOC_data.dat", out, sizeof(out));
    assert(strcmp(out, "/tmp/gunbros_test_env/files/packTOC_data.dat") == 0);
    TEST_PASS("Package path ackTOC prepend rule");

    // Test 6: WVGA to XGA fallback resolution
    char xga_path[256];
    snprintf(xga_path, sizeof(xga_path), "%satlas_xga.png", test_base_dir);
    FILE *f = fopen(xga_path, "wb");
    assert(f != NULL);
    fputc(0, f);
    fclose(f);

    path_mapper_normalize("atlas_wvga.png", out, sizeof(out));
    assert(strcmp(out, xga_path) == 0);
    // Test 7: Internal save directory fallback resolution
    const char *test_save_dir = "/tmp/gunbros_test_env/save/";
    snprintf(mkdir_cmd, sizeof(mkdir_cmd), "mkdir -p %s", test_save_dir);
    system(mkdir_cmd);
    path_mapper_set_save_dir(test_save_dir);
    assert(strcmp(path_mapper_get_save_dir(), test_save_dir) == 0);

    char save_file_path[256];
    snprintf(save_file_path, sizeof(save_file_path), "%spack0_core_xga.big", test_save_dir);
    FILE *f_save = fopen(save_file_path, "wb");
    assert(f_save != NULL);
    fputc(0, f_save);
    fclose(f_save);

    path_mapper_normalize("pack0_core_xga.big", out, sizeof(out));
    assert(strcmp(out, save_file_path) == 0);
    TEST_PASS("Internal save directory fallback resolution when target missing in base");

    // Clean up
    snprintf(mkdir_cmd, sizeof(mkdir_cmd), "rm -rf /tmp/gunbros_test_env");
    system(mkdir_cmd);

    printf("=== All Path Mapper tests PASSED! ===\n\n");
    return 0;
}
