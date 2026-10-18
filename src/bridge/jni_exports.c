#include "gunbros/bridge/jni_exports.h"
#include "gunbros/bridge/bridge_core.h"
#include "gunbros/filesystem/path_mapper.h"
#include "gunbros/platform/jni_env_helper.h"
#include "gunbros/platform/android_window.h"
#include "gunbros/platform/android_audio.h"

#ifdef __ANDROID__
#include <sys/system_properties.h>
#endif

JNIEXPORT jint JNICALL JNI_OnLoad(JavaVM *vm, void *reserved) {
    (void)reserved;
    platform_set_jvm(vm);
    audio_init();

    int gw = 1024, gh = 640;
#ifdef __ANDROID__
    char v[PROP_VALUE_MAX];
    if (__system_property_get("debug.gunbros.vw", v) > 0) gw = atoi(v);
    if (__system_property_get("debug.gunbros.vh", v) > 0) gh = atoi(v);
#endif
    if (gw < 320 || gh < 200) {
        gw = 1024;
        gh = 640;
    }
    window_set_dimensions(gw, gh);

    LOGI("Host JNI_OnLoad called: vm=%p (game_w=%d, game_h=%d)", vm, gw, gh);
    return JNI_VERSION_1_6;
}

JNIEXPORT void JNICALL Java_com_glu_platform_android_GluPlatformActivityJNI_initialise(
    JNIEnv *env, jobject thiz, jobject context, jobject handler,
    jstring s1, jstring s2, jstring s3, jstring s4, jstring s5, jstring s6,
    jboolean b1, jboolean b2, jboolean b3,
    jstring s7, jstring s8, jstring s9, jstring s10,
    jint i1, jint i2, jint i3, jint i4, jstring s11) {
    (void)thiz; (void)handler;
    (void)s3; (void)s4; (void)s5; (void)s6;
    (void)b1; (void)b2; (void)b3;
    (void)s7; (void)s8; (void)s9; (void)s10;
    (void)i1; (void)i2; (void)i3; (void)i4; (void)s11;

    LOGI("GluPlatformActivityJNI_initialise called");
    if (env != NULL) {
        JavaVM *jvm = NULL;
        (*env)->GetJavaVM(env, &jvm);
        platform_set_jvm(jvm);

        if (s1 != NULL) {
            const char *cs1 = (*env)->GetStringUTFChars(env, s1, NULL);
            if (cs1) {
                path_mapper_set_save_dir(cs1);
                LOGI("JNI initialise: registered internal save dir: '%s'", cs1);
                (*env)->ReleaseStringUTFChars(env, s1, cs1);
            }
        }
        if (s2 != NULL) {
            const char *cs2 = (*env)->GetStringUTFChars(env, s2, NULL);
            if (cs2) {
                path_mapper_set_base_dir(cs2);
                LOGI("JNI initialise: registered external files dir: '%s'", cs2);
                (*env)->ReleaseStringUTFChars(env, s2, cs2);
            }
        }
    }
    bridge_init(env, context);
}

JNIEXPORT jint JNICALL Java_com_glu_platform_android_GluPlatformActivityJNI_onCreate(
    JNIEnv *env, jobject thiz, jbyteArray array, jobject callback) {
    return bridge_on_create(env, thiz, array, callback);
}

JNIEXPORT void JNICALL Java_com_glu_platform_android_GluPlatformActivityJNI_setWindow(
    JNIEnv *env, jobject thiz, jobject holder) {
    (void)thiz;
    LOGI("GluPlatformActivityJNI_setWindow called, holder=%p", holder);
    window_set_surface(env, holder);
}

JNIEXPORT void JNICALL Java_com_glu_platform_android_GluPlatformActivityJNI_surfaceCreated(
    JNIEnv *env, jobject thiz, jint id) {
    (void)thiz;
    LOGI("GluPlatformActivityJNI_surfaceCreated called");
    if (env) window_check_surface(env);
    bridge_on_surface_created(id);
}

JNIEXPORT void JNICALL Java_com_glu_platform_android_GluPlatformActivityJNI_surfaceChanged(
    JNIEnv *env, jobject thiz, jint id, jint format, jint w, jint h) {
    (void)thiz;
    LOGI("GluPlatformActivityJNI_surfaceChanged called: format=%d w=%d h=%d", format, w, h);
    if (env) window_check_surface(env);
    bridge_on_surface_changed(id, format, w, h);
}

JNIEXPORT void JNICALL Java_com_glu_platform_android_GluPlatformActivityJNI_onSurfaceCreated(
    JNIEnv *env, jobject thiz, jint id) {
    (void)env; (void)thiz;
    bridge_on_gl_surface_created(id);
}

JNIEXPORT void JNICALL Java_com_glu_platform_android_GluPlatformActivityJNI_onSurfaceChanged(
    JNIEnv *env, jobject thiz, jint id, jint w, jint h) {
    (void)env; (void)thiz;
    bridge_on_gl_surface_changed(id, w, h);
}

JNIEXPORT void JNICALL Java_com_glu_platform_android_GluPlatformActivityJNI_onDrawFrame(
    JNIEnv *env, jobject thiz, jint id, jlong time, jboolean b) {
    bridge_on_draw_frame(env, thiz, id, time, b);
}

JNIEXPORT void JNICALL Java_com_glu_platform_android_GluPlatformActivityJNI_onDestroy(
    JNIEnv *env, jobject thiz, jint id) {
    (void)env; (void)thiz;
    bridge_on_destroy(id);
}

JNIEXPORT void JNICALL Java_com_glu_platform_android_GluPlatformActivityJNI_onPause(
    JNIEnv *env, jobject thiz, jint id) {
    (void)env; (void)thiz;
    bridge_on_pause(id);
}

JNIEXPORT void JNICALL Java_com_glu_platform_android_GluPlatformActivityJNI_onResume(
    JNIEnv *env, jobject thiz, jint id) {
    (void)env; (void)thiz;
    bridge_on_resume(id);
}

JNIEXPORT void JNICALL Java_com_glu_platform_android_GluPlatformActivityJNI_onStart(
    JNIEnv *env, jobject thiz, jint id) {
    (void)env; (void)thiz;
    bridge_on_start(id);
}

JNIEXPORT void JNICALL Java_com_glu_platform_android_GluPlatformActivityJNI_onStop(
    JNIEnv *env, jobject thiz, jint id) {
    (void)env; (void)thiz;
    bridge_on_stop(id);
}

JNIEXPORT void JNICALL Java_com_glu_platform_android_GluPlatformActivityJNI_onRestart(
    JNIEnv *env, jobject thiz, jint id) {
    (void)env; (void)thiz;
    bridge_on_restart(id);
}

JNIEXPORT void JNICALL Java_com_glu_platform_android_GluPlatformActivityJNI_onLowMemory(
    JNIEnv *env, jobject thiz, jint id) {
    (void)env; (void)thiz;
    bridge_on_low_memory(id);
}

JNIEXPORT void JNICALL Java_com_glu_platform_android_GluPlatformActivityJNI_onOrientationChanged(
    JNIEnv *env, jobject thiz, jint orientation) {
    (void)env; (void)thiz;
    bridge_on_orientation_changed(orientation);
}

JNIEXPORT jboolean JNICALL Java_com_glu_platform_android_GluPlatformActivityJNI_onKeyDown(
    JNIEnv *env, jobject thiz, jint code, jint event) {
    (void)env; (void)thiz; (void)code; (void)event;
    return 1;
}

JNIEXPORT jboolean JNICALL Java_com_glu_platform_android_GluPlatformActivityJNI_onKeyUp(
    JNIEnv *env, jobject thiz, jint code, jint event) {
    (void)env; (void)thiz; (void)code; (void)event;
    return 1;
}

JNIEXPORT void JNICALL Java_com_glu_platform_android_GluPlatformActivityJNI_surfaceDestroyed(
    JNIEnv *env, jobject thiz, jint id) {
    (void)env; (void)thiz;
    bridge_on_surface_destroyed(id);
}

JNIEXPORT void JNICALL Java_com_glu_platform_android_GluPlatformActivityJNI_TouchBegan(
    JNIEnv *env, jobject thiz, jint id, jint x, jint y, jint pid) {
    (void)env; (void)thiz; (void)id;
    bridge_touch_push(0, x, y, pid);
}

JNIEXPORT void JNICALL Java_com_glu_platform_android_GluPlatformActivityJNI_TouchMoved(
    JNIEnv *env, jobject thiz, jint id, jint x, jint y, jint pid) {
    (void)env; (void)thiz; (void)id;
    bridge_touch_push(1, x, y, pid);
}

JNIEXPORT void JNICALL Java_com_glu_platform_android_GluPlatformActivityJNI_TouchEnded(
    JNIEnv *env, jobject thiz, jint id, jint x, jint y, jint pid) {
    (void)env; (void)thiz; (void)id;
    bridge_touch_push(2, x, y, pid);
}

JNIEXPORT void JNICALL Java_com_glu_platform_android_GluPlatformActivityJNI_TouchCancelled(
    JNIEnv *env, jobject thiz, jint id, jint x, jint y, jint pid) {
    (void)env; (void)thiz; (void)id;
    bridge_touch_push(3, x, y, pid);
}

JNIEXPORT void JNICALL Java_com_glu_platform_android_GluPlatformActivityJNI_MouseButtonDown(
    JNIEnv *env, jobject thiz, jint id, jint x, jint y) {
    (void)env; (void)thiz; (void)id; (void)x; (void)y;
}

JNIEXPORT void JNICALL Java_com_glu_platform_android_GluPlatformActivityJNI_MouseButtonUp(
    JNIEnv *env, jobject thiz, jint id, jint x, jint y) {
    (void)env; (void)thiz; (void)id; (void)x; (void)y;
}

JNIEXPORT void JNICALL Java_com_glu_platform_android_GluPlatformActivityJNI_MouseMove(
    JNIEnv *env, jobject thiz, jint id, jint x, jint y) {
    (void)env; (void)thiz; (void)id; (void)x; (void)y;
}

JNIEXPORT void JNICALL Java_com_glu_platform_android_GluPlatformActivityJNI_pushAccelerometerValues(
    JNIEnv *env, jobject thiz, jint id, jfloat x, jfloat y, jfloat z) {
    (void)env; (void)thiz; (void)id; (void)x; (void)y; (void)z;
}

JNIEXPORT void JNICALL Java_com_glu_platform_android_GluPlatformActivityJNI_SoundEventCompleted(
    JNIEnv *env, jobject thiz, jint id, jlong event_id) {
    (void)env; (void)thiz;
    DLOG("SoundEventCompleted received handle=%d, event=%lld", id, (long long)event_id);
}

JNIEXPORT void JNICALL Java_com_glu_platform_android_GluPlatformActivityJNI_feedPCMMediaPlayer(
    JNIEnv *env, jobject thiz, jint id, jbyteArray array, jint len) {
    (void)thiz; (void)id;
    audio_feed_pcm_java(env, array, len, bridge_audio_mixer, NULL);
}

JNIEXPORT void JNICALL Java_com_glu_platform_android_GluPlatformActivityJNI_javaToNativeFacebook(
    JNIEnv *env, jobject thiz, jint i1, jint i2, jint i3, jbyteArray b, jobjectArray c) {
    (void)env; (void)thiz; (void)i1; (void)i2; (void)i3; (void)b; (void)c;
}

JNIEXPORT void JNICALL Java_com_glu_platform_android_GluPlatformActivityJNI_LocalEvent(
    JNIEnv *env, jobject thiz, jstring s1, jstring s2) {
    (void)env; (void)thiz; (void)s1; (void)s2;
}

JNIEXPORT void JNICALL Java_com_glu_platform_android_GluPlatformActivityJNI_tidy(
    JNIEnv *env, jobject thiz, jint id) {
    (void)env; (void)thiz; (void)id;
}

JNIEXPORT void JNICALL Java_com_glu_platform_android_GluPlatformActivityJNI_uninitialise(
    JNIEnv *env, jobject thiz) {
    (void)env; (void)thiz;
}

JNIEXPORT void JNICALL Java_com_glu_platform_android_GluPlatformActivityJNI_setUseBeam(
    JNIEnv *env, jobject thiz, jint id, jboolean b) {
    (void)env; (void)thiz; (void)id; (void)b;
}

JNIEXPORT void JNICALL Java_com_glu_platform_gwallet_GWallet_create(JNIEnv *env, jobject thiz) { (void)env; (void)thiz; }
JNIEXPORT void JNICALL Java_com_glu_platform_gwallet_GWallet_destroy(JNIEnv *env, jobject thiz) { (void)env; (void)thiz; }
JNIEXPORT void JNICALL Java_com_glu_platform_gwallet_GWallet_start(JNIEnv *env, jobject thiz) { (void)env; (void)thiz; }
JNIEXPORT void JNICALL Java_com_glu_platform_gwallet_GWallet_stop(JNIEnv *env, jobject thiz) { (void)env; (void)thiz; }
JNIEXPORT void JNICALL Java_com_glu_platform_gwallet_GWallet_pause(JNIEnv *env, jobject thiz) { (void)env; (void)thiz; }
JNIEXPORT void JNICALL Java_com_glu_platform_gwallet_GWallet_resume(JNIEnv *env, jobject thiz) { (void)env; (void)thiz; }
JNIEXPORT void JNICALL Java_com_glu_platform_gwallet_GWallet_restart(JNIEnv *env, jobject thiz) { (void)env; (void)thiz; }
JNIEXPORT void JNICALL Java_com_glu_platform_gwallet_GWallet_initialise(JNIEnv *env, jobject thiz) { (void)env; (void)thiz; }
JNIEXPORT void JNICALL Java_com_glu_platform_gwallet_GWallet_uninitialise(JNIEnv *env, jobject thiz) { (void)env; (void)thiz; }
JNIEXPORT void JNICALL Java_com_glu_platform_gwallet_GWallet_getBalance(JNIEnv *env, jobject thiz) { (void)env; (void)thiz; }
JNIEXPORT void JNICALL Java_com_glu_platform_gwallet_GWallet_addCurrency(JNIEnv *env, jobject thiz) { (void)env; (void)thiz; }
JNIEXPORT void JNICALL Java_com_glu_platform_gwallet_GWallet_subtractCurrency(JNIEnv *env, jobject thiz) { (void)env; (void)thiz; }
JNIEXPORT void JNICALL Java_com_glu_platform_gwallet_GWallet_subscribeWithReceipt(JNIEnv *env, jobject thiz) { (void)env; (void)thiz; }
JNIEXPORT void JNICALL Java_com_glu_platform_gwallet_GWallet_handleupdate(JNIEnv *env, jobject thiz) { (void)env; (void)thiz; }
JNIEXPORT void JNICALL Java_com_glu_platform_gwallet_GWalletJNI_enableHTTPTransfers(JNIEnv *env, jobject thiz) { (void)env; (void)thiz; }
JNIEXPORT void JNICALL Java_com_glu_platform_gwallet_GWalletJNI_onHandleResponse(JNIEnv *env, jobject thiz, jstring s, jint i) { (void)env; (void)thiz; (void)s; (void)i; }
JNIEXPORT jboolean JNICALL Java_com_glu_android_GluBeam_onIncomingNFCDataReceived(JNIEnv *env, jobject thiz, jbyteArray b) { (void)env; (void)thiz; (void)b; return 0; }
JNIEXPORT jint JNICALL Java_com_glu_android_iap_IAPJava_iapCallbackEvent(JNIEnv *env, jobject thiz, jint i1, jint i2, jbyteArray b) { (void)env; (void)thiz; (void)i1; (void)i2; (void)b; return 0; }
