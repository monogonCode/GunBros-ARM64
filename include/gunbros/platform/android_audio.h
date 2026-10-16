#ifndef GUNBROS_ANDROID_AUDIO_H
#define GUNBROS_ANDROID_AUDIO_H

#include "gunbros/common/common.h"
#include "gunbros/platform/pcm_ring.h"
#include <jni.h>

GUNBROS_EXTERN_C_BEGIN

#define BRIDGE_PCM_MAX_BYTES 16384u

typedef size_t (*gunbros_audio_mix_fn)(uint8_t *out, size_t len, void *user_data);

void audio_init(void);
bool audio_configure(uint32_t rate, uint32_t channels, uint32_t bits, uint32_t bufsz, uint32_t period);
void audio_start_stream(void);
void audio_stop_stream(void);
void audio_close(void);
void audio_pump_locked(gunbros_audio_mix_fn mix_fn, void *user_data);
void audio_feed_pcm_java(JNIEnv *env, jbyteArray array, jint len, gunbros_audio_mix_fn mix_fn, void *user_data);

bool audio_is_native(void);
void audio_set_engine_ready(bool ready);
bool audio_is_engine_ready(void);

GUNBROS_EXTERN_C_END

#endif // GUNBROS_ANDROID_AUDIO_H
