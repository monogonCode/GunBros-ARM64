#include "gunbros/platform/android_audio.h"
#include <pthread.h>
#include <string.h>

#ifdef __ANDROID__
#include <aaudio/AAudio.h>
#endif

static pcm_ring_t s_pcm_ring;
static uint32_t s_pcm_rate = 44100;
static uint32_t s_pcm_channels = 2;
static uint32_t s_pcm_frame_bytes = 4;
static uint32_t s_pcm_chunk = 0;
static bool     s_native_audio = false;
static bool     s_sound_engine_ready = false;

#ifdef __ANDROID__
static AAudioStream *s_aa_stream = NULL;
static volatile int s_aa_error = 0;
static volatile int s_aa_want_run = 0;
static uint32_t s_aa_underrun_cb = 0;

static aaudio_data_callback_result_t aa_data_cb(AAudioStream *st, void *ud, void *data, int32_t frames) {
    (void)st; (void)ud;
    size_t want = (size_t)frames * s_pcm_frame_bytes;
    size_t got = pcm_ring_read(&s_pcm_ring, (uint8_t*)data, want);
    if (got < want) {
        memset((uint8_t*)data + got, 0, want - got);
        if (got == 0) __atomic_fetch_add(&s_aa_underrun_cb, 1, __ATOMIC_RELAXED);
    }
    return AAUDIO_CALLBACK_RESULT_CONTINUE;
}

static void aa_error_cb(AAudioStream *st, void *ud, aaudio_result_t err) {
    (void)st; (void)ud; (void)err;
    __atomic_store_n(&s_aa_error, 1, __ATOMIC_RELEASE);
}

static bool aa_open_start_internal(void) {
    if (s_aa_stream) {
        AAudioStream_requestStop(s_aa_stream);
        AAudioStream_close(s_aa_stream);
        s_aa_stream = NULL;
    }
    AAudioStreamBuilder *b = NULL;
    if (AAudio_createStreamBuilder(&b) != AAUDIO_OK) return false;
    AAudioStreamBuilder_setDirection(b, AAUDIO_DIRECTION_OUTPUT);
    AAudioStreamBuilder_setPerformanceMode(b, AAUDIO_PERFORMANCE_MODE_LOW_LATENCY);
    AAudioStreamBuilder_setSharingMode(b, AAUDIO_SHARING_MODE_SHARED);
    AAudioStreamBuilder_setFormat(b, AAUDIO_FORMAT_PCM_I16);
    AAudioStreamBuilder_setChannelCount(b, (int32_t)s_pcm_channels);
    AAudioStreamBuilder_setSampleRate(b, (int32_t)s_pcm_rate);
    AAudioStreamBuilder_setUsage(b, AAUDIO_USAGE_GAME);
    AAudioStreamBuilder_setContentType(b, AAUDIO_CONTENT_TYPE_SONIFICATION);
    AAudioStreamBuilder_setDataCallback(b, aa_data_cb, NULL);
    AAudioStreamBuilder_setErrorCallback(b, aa_error_cb, NULL);
    aaudio_result_t r = AAudioStreamBuilder_openStream(b, &s_aa_stream);
    AAudioStreamBuilder_delete(b);
    if (r != AAUDIO_OK || !s_aa_stream) {
        s_aa_stream = NULL;
        LOGE("AAudio open failed: %d", r);
        return false;
    }
    int32_t burst = AAudioStream_getFramesPerBurst(s_aa_stream);
    AAudioStream_setBufferSizeInFrames(s_aa_stream, burst * 2);
    r = AAudioStream_requestStart(s_aa_stream);
    LOGI("AAudio started r=%d rate=%d ch=%d burst=%d buf=%d", r,
         AAudioStream_getSampleRate(s_aa_stream),
         AAudioStream_getChannelCount(s_aa_stream),
         burst, AAudioStream_getBufferSizeInFrames(s_aa_stream));
    __atomic_store_n(&s_aa_error, 0, __ATOMIC_RELEASE);
    return r == AAUDIO_OK;
}
#endif

void audio_init(void) {
    pcm_ring_init(&s_pcm_ring);
}

bool audio_configure(uint32_t rate, uint32_t channels, uint32_t bits, uint32_t bufsz, uint32_t period) {
    (void)period;
    if (rate == 0 || rate > 192000) rate = 22050;
    if (channels != 1 && channels != 2) channels = 2;
    if (bits != 8 && bits != 16) bits = 16;
    if (bufsz <= 0 || bufsz > 1024 * 1024) bufsz = 4096;

    if (bits == 16) {
        s_pcm_rate = rate;
        s_pcm_channels = channels;
        s_pcm_frame_bytes = channels * 2u;
        uint32_t chunk = (bufsz / 4u) / s_pcm_frame_bytes * s_pcm_frame_bytes;
        if (chunk < s_pcm_frame_bytes * 64u) chunk = s_pcm_frame_bytes * 64u;
        if (chunk > BRIDGE_PCM_MAX_BYTES) chunk = BRIDGE_PCM_MAX_BYTES;
        s_pcm_chunk = chunk;
        s_native_audio = true;
        s_sound_engine_ready = true;
        LOGI("Native audio configured: rate=%u ch=%u bufsz=%u chunk=%u", rate, channels, bufsz, chunk);
        return true;
    }
    return false;
}

void audio_start_stream(void) {
#ifdef __ANDROID__
    if (!s_native_audio) return;
    __atomic_store_n(&s_aa_want_run, 1, __ATOMIC_RELEASE);
    if (s_aa_stream == NULL) {
        aa_open_start_internal();
    } else {
        AAudioStream_requestStart(s_aa_stream);
    }
#endif
}

void audio_stop_stream(void) {
#ifdef __ANDROID__
    if (!s_native_audio) return;
    __atomic_store_n(&s_aa_want_run, 0, __ATOMIC_RELEASE);
    if (s_aa_stream) {
        AAudioStream_requestPause(s_aa_stream);
    }
#endif
}

void audio_close(void) {
#ifdef __ANDROID__
    if (s_aa_stream) {
        AAudioStream_requestStop(s_aa_stream);
        AAudioStream_close(s_aa_stream);
        s_aa_stream = NULL;
    }
#endif
}

void audio_pump_locked(gunbros_audio_mix_fn mix_fn, void *user_data) {
    if (!s_native_audio || s_pcm_chunk == 0 || !s_sound_engine_ready || !mix_fn) return;
#ifdef __ANDROID__
    if (__atomic_load_n(&s_aa_want_run, __ATOMIC_ACQUIRE) &&
        (__atomic_load_n(&s_aa_error, __ATOMIC_ACQUIRE) || s_aa_stream == NULL)) {
        aa_open_start_internal();
    }
#endif
    size_t target = (size_t)s_pcm_rate * s_pcm_frame_bytes * 60u / 1000u;
    if (target > PCM_RING_CAP / 2u) target = PCM_RING_CAP / 2u;
    uint8_t tmp[BRIDGE_PCM_MAX_BYTES];
    for (int i = 0; i < 8 && pcm_ring_available(&s_pcm_ring) < target
                          && pcm_ring_space(&s_pcm_ring) >= s_pcm_chunk; i++) {
        mix_fn(tmp, s_pcm_chunk, user_data);
        pcm_ring_write(&s_pcm_ring, tmp, s_pcm_chunk);
    }
}

void audio_feed_pcm_java(JNIEnv *env, jbyteArray array, jint len, gunbros_audio_mix_fn mix_fn, void *user_data) {
    (void)mix_fn;
    (void)user_data;
    if (env == NULL || array == NULL || len <= 0) return;
    jsize array_len = (*env)->GetArrayLength(env, array);
    if ((*env)->ExceptionCheck(env) || array_len <= 0) return;
    size_t req = (size_t)len;
    if (req > (size_t)array_len) req = (size_t)array_len;
    if (req > BRIDGE_PCM_MAX_BYTES) req = BRIDGE_PCM_MAX_BYTES;
    if (req == 0) return;

    uint8_t pcm[BRIDGE_PCM_MAX_BYTES];
    size_t got = pcm_ring_read(&s_pcm_ring, pcm, req);

    if (got < req) {
        memset(pcm + got, 0, req - got);
        s_pcm_ring.underruns++;
    }
    (*env)->SetByteArrayRegion(env, array, 0, (jsize)req, (const jbyte*)pcm);
}

bool audio_is_native(void) {
    return s_native_audio;
}

void audio_set_engine_ready(bool ready) {
    s_sound_engine_ready = ready;
}

bool audio_is_engine_ready(void) {
    return s_sound_engine_ready;
}
