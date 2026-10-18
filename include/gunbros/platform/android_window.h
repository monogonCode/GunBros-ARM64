#ifndef GUNBROS_ANDROID_WINDOW_H
#define GUNBROS_ANDROID_WINDOW_H

#include "gunbros/common/common.h"
#include <jni.h>

#ifdef __ANDROID__
#include <EGL/egl.h>
#include <GLES/gl.h>
#include <android/native_window.h>
#include <android/native_window_jni.h>
#endif

GUNBROS_EXTERN_C_BEGIN

void window_init(void);
void window_set_dimensions(int w, int h);
void window_get_dimensions(int *w, int *h);
void window_set_screen_dimensions(int sw, int sh);
void window_get_screen_dimensions(int *sw, int *sh);

void window_compute_viewport(int sw, int sh);
void window_get_origin(int *ox, int *oy);
void window_screen_to_game(int sx, int sy, int *gx, int *gy);
void window_clear_bars(void);

void window_set_surface(JNIEnv *env, jobject holder);
void window_check_surface(JNIEnv *env);
bool window_ensure_egl(void);
void window_swap_buffers(void);
void window_release(void);

GUNBROS_EXTERN_C_END

#endif // GUNBROS_ANDROID_WINDOW_H
