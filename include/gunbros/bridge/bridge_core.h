#ifndef GUNBROS_BRIDGE_CORE_H
#define GUNBROS_BRIDGE_CORE_H

#include "gunbros/common/common.h"
#include <jni.h>
#include <pthread.h>

GUNBROS_EXTERN_C_BEGIN

extern pthread_mutex_t g_emu_mutex;

void bridge_init(JNIEnv *env, jobject context);
uint32_t bridge_get_capplet(void);
void bridge_set_capplet(uint32_t capplet);

void bridge_touch_push(int type, int x, int y, int pid);
void bridge_touch_drain(void);

void bridge_on_draw_frame(JNIEnv *env, jobject thiz, jint id, jlong time, jboolean b);

jint bridge_on_create(JNIEnv *env, jobject thiz, jbyteArray array, jobject callback);
void bridge_on_surface_created(jint id);
void bridge_on_surface_changed(jint id, jint format, jint w, jint h);
void bridge_on_gl_surface_created(jint id);
void bridge_on_gl_surface_changed(jint id, jint w, jint h);
void bridge_on_surface_destroyed(jint id);

void bridge_on_destroy(jint id);
void bridge_on_pause(jint id);
void bridge_on_resume(jint id);
void bridge_on_start(jint id);
void bridge_on_stop(jint id);
void bridge_on_restart(jint id);
void bridge_on_low_memory(jint id);
void bridge_on_orientation_changed(jint orientation);

size_t bridge_audio_mixer(uint8_t *out, size_t len, void *user_data);

GUNBROS_EXTERN_C_END

#endif // GUNBROS_BRIDGE_CORE_H
