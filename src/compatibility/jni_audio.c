#include "gunbros/compatibility/jni_audio.h"
#include "gunbros/compatibility/jni_virtual_machine.h"
#include "gunbros/platform/jni_env_helper.h"
#include "gunbros/platform/android_audio.h"
#include <string.h>

bool jni_audio_initialise_sound_engine(const jni_call_context_t *ctx) {
    uint32_t use_pcm  = get_jni_method_arg(ctx->idx, *ctx->r3, ctx->sp, 0);
    uint32_t rate     = get_jni_method_arg(ctx->idx, *ctx->r3, ctx->sp, 1);
    uint32_t channels = get_jni_method_arg(ctx->idx, *ctx->r3, ctx->sp, 2);
    uint32_t bits     = get_jni_method_arg(ctx->idx, *ctx->r3, ctx->sp, 3);
    uint32_t bufsz    = get_jni_method_arg(ctx->idx, *ctx->r3, ctx->sp, 4);
    uint32_t period   = get_jni_method_arg(ctx->idx, *ctx->r3, ctx->sp, 5);

    if (use_pcm && bits == 16) {
        audio_configure(rate, channels, bits, bufsz, period);
        *ctx->r0 = 1;
        return true;
    }

    JNIEnv *real_env = platform_get_env();
    jobject real_callback = platform_get_callback();
    jboolean ok = JNI_TRUE;
    if (real_env && real_callback) {
        jclass cls = (*real_env)->GetObjectClass(real_env, real_callback);
        jmethodID mid = (*real_env)->GetMethodID(real_env, cls, "InitialiseSoundEngine", "(ZIIIII)Z");
        if (mid) {
            ok = (*real_env)->CallBooleanMethod(real_env, real_callback, mid,
                                                (jboolean)(use_pcm ? JNI_TRUE : JNI_FALSE),
                                                (jint)rate, (jint)channels, (jint)bits, (jint)bufsz, (jint)period);
            LOGI("Forwarded InitialiseSoundEngine(pcm=%u, rate=%u, ch=%u, bits=%u, buf=%u, per=%u) -> %d",
                 use_pcm, rate, channels, bits, bufsz, period, ok);
            if (ok) audio_set_engine_ready(true);
        }
    }
    *ctx->r0 = ok ? 1 : 0;
    return true;
}

bool jni_audio_start_audio_stream(const jni_call_context_t *ctx) {
    if (audio_is_native()) {
        audio_start_stream();
        *ctx->r0 = 1;
    } else {
        JNIEnv *real_env = platform_get_env();
        jobject real_callback = platform_get_callback();
        jboolean ok = JNI_TRUE;
        if (real_env && real_callback) {
            jclass cls = (*real_env)->GetObjectClass(real_env, real_callback);
            jmethodID mid = (*real_env)->GetMethodID(real_env, cls, "StartAudioStream", "()Z");
            if (mid) ok = (*real_env)->CallBooleanMethod(real_env, real_callback, mid);
        }
        *ctx->r0 = ok ? 1 : 0;
    }
    return true;
}

bool jni_audio_stop_audio_stream(const jni_call_context_t *ctx) {
    if (audio_is_native()) {
        audio_stop_stream();
        *ctx->r0 = 1;
    } else {
        JNIEnv *real_env = platform_get_env();
        jobject real_callback = platform_get_callback();
        jboolean ok = JNI_TRUE;
        if (real_env && real_callback) {
            jclass cls = (*real_env)->GetObjectClass(real_env, real_callback);
            jmethodID mid = (*real_env)->GetMethodID(real_env, cls, "StopAudioStream", "()Z");
            if (mid) ok = (*real_env)->CallBooleanMethod(real_env, real_callback, mid);
        }
        *ctx->r0 = ok ? 1 : 0;
    }
    return true;
}

bool jni_audio_get_min_buffer_size(const jni_call_context_t *ctx) {
    uint32_t rate     = get_jni_method_arg(ctx->idx, *ctx->r3, ctx->sp, 0);
    uint32_t channels = get_jni_method_arg(ctx->idx, *ctx->r3, ctx->sp, 1);
    uint32_t bits     = get_jni_method_arg(ctx->idx, *ctx->r3, ctx->sp, 2);

    if (rate == 0 || rate > 192000) rate = 22050;
    if (channels != 1 && channels != 2) channels = 2;
    if (bits != 8 && bits != 16) bits = 16;

    JNIEnv *real_env = platform_get_env();
    jobject real_callback = platform_get_callback();
    jint min_buf = 4096;
    if (real_env && real_callback) {
        jclass cls = (*real_env)->GetObjectClass(real_env, real_callback);
        jmethodID mid = (*real_env)->GetMethodID(real_env, cls, "GetAndroidMinBufferSize", "(III)I");
        if (mid) {
            min_buf = (*real_env)->CallIntMethod(real_env, real_callback, mid, (jint)rate, (jint)channels, (jint)bits);
        }
    }
    *ctx->r0 = (uint32_t)(min_buf > 0 ? min_buf : 4096);
    return true;
}

bool jni_audio_mp3_event(const jni_call_context_t *ctx) {
    uint32_t event = get_jni_method_arg(ctx->idx, *ctx->r3, ctx->sp, 0);
    uint32_t loop  = get_jni_method_arg(ctx->idx, *ctx->r3, ctx->sp, 1);
    JNIEnv *real_env = platform_get_env();
    jobject real_callback = platform_get_callback();
    jint ret = 0;
    if (real_env && real_callback) {
        jclass cls = (*real_env)->GetObjectClass(real_env, real_callback);
        jmethodID mid = (*real_env)->GetMethodID(real_env, cls, "mp3Event", "(IILjava/lang/String;)I");
        if (mid) {
            jstring jstr = (*real_env)->NewStringUTF(real_env, jvm_get_last_string());
            ret = (*real_env)->CallIntMethod(real_env, real_callback, mid, (jint)event, (jint)loop, jstr);
            if (jstr) (*real_env)->DeleteLocalRef(real_env, jstr);
        }
    }
    *ctx->r0 = (uint32_t)ret;
    return true;
}

bool jni_audio_set_volume(const jni_call_context_t *ctx) {
    uint32_t vol = get_jni_method_arg(ctx->idx, *ctx->r3, ctx->sp, 0);
    JNIEnv *real_env = platform_get_env();
    jobject real_callback = platform_get_callback();
    if (real_env && real_callback) {
        jclass cls = (*real_env)->GetObjectClass(real_env, real_callback);
        jmethodID mid = (*real_env)->GetMethodID(real_env, cls, "SetVolume", "(B)V");
        if (mid) (*real_env)->CallVoidMethod(real_env, real_callback, mid, (jbyte)vol);
    }
    *ctx->r0 = 0;
    return true;
}
