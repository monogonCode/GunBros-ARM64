#ifndef GUNBROS_COMMON_H
#define GUNBROS_COMMON_H

#include <stdint.h>
#include <stdbool.h>
#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>

#define LOG_TAG "GunBrosARM64"

#ifdef __ANDROID__
#include <android/log.h>
#define LOGI(...) __android_log_print(ANDROID_LOG_INFO, LOG_TAG, __VA_ARGS__)
#define LOGE(...) __android_log_print(ANDROID_LOG_ERROR, LOG_TAG, __VA_ARGS__)
#else
#define LOGI(...) do { printf("[INFO] " __VA_ARGS__); printf("\n"); } while(0)
#define LOGE(...) do { fprintf(stderr, "[ERROR] " __VA_ARGS__); fprintf(stderr, "\n"); } while(0)
#endif

#ifndef DLOG
#ifdef BRIDGE_DEBUG
#define DLOG(...) LOGI(__VA_ARGS__)
#else
#define DLOG(...) ((void)0)
#endif
#endif

#ifdef __cplusplus
#define GUNBROS_EXTERN_C extern "C"
#define GUNBROS_EXTERN_C_BEGIN extern "C" {
#define GUNBROS_EXTERN_C_END }
#else
#define GUNBROS_EXTERN_C
#define GUNBROS_EXTERN_C_BEGIN
#define GUNBROS_EXTERN_C_END
#endif

#endif // GUNBROS_COMMON_H
