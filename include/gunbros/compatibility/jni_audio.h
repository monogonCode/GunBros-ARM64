#ifndef GUNBROS_JNI_AUDIO_H
#define GUNBROS_JNI_AUDIO_H

#include "gunbros/compatibility/jni_methods.h"

GUNBROS_EXTERN_C_BEGIN

bool jni_audio_initialise_sound_engine(const jni_call_context_t *ctx);
bool jni_audio_start_audio_stream(const jni_call_context_t *ctx);
bool jni_audio_stop_audio_stream(const jni_call_context_t *ctx);
bool jni_audio_get_min_buffer_size(const jni_call_context_t *ctx);
bool jni_audio_mp3_event(const jni_call_context_t *ctx);
bool jni_audio_set_volume(const jni_call_context_t *ctx);

GUNBROS_EXTERN_C_END

#endif // GUNBROS_JNI_AUDIO_H
