#ifndef GUNBROS_FILE_HANDLES_H
#define GUNBROS_FILE_HANDLES_H

#include "gunbros/common/common.h"
#include <stdio.h>

GUNBROS_EXTERN_C_BEGIN

#define GUNBROS_MAX_OPEN_FILES 256

typedef struct {
    FILE *fp;
    char path[256];
    char mode[16];
    uint64_t bytes_read;
    uint64_t bytes_written;
} gunbros_file_entry_t;

void file_handles_init(void);
int file_handles_alloc(FILE *fp, const char *path, const char *mode);
FILE* file_handles_get(int slot);
gunbros_file_entry_t* file_handles_get_entry(int slot);
FILE* file_handles_free(int slot);
void file_handles_close_all(void);

GUNBROS_EXTERN_C_END

#endif // GUNBROS_FILE_HANDLES_H
