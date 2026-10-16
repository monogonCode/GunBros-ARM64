#ifndef GUNBROS_JNI_EXPORTS_H
#define GUNBROS_JNI_EXPORTS_H

#include "gunbros/common/common.h"
#include <jni.h>

GUNBROS_EXTERN_C_BEGIN

JNIEXPORT jint JNICALL JNI_OnLoad(JavaVM *vm, void *reserved);

JNIEXPORT void JNICALL Java_com_glu_platform_android_GluPlatformActivityJNI_initialise(
    JNIEnv *env, jobject thiz, jobject context, jobject handler,
    jstring s1, jstring s2, jstring s3, jstring s4, jstring s5, jstring s6,
    jboolean b1, jboolean b2, jboolean b3,
    jstring s7, jstring s8, jstring s9, jstring s10,
    jint i1, jint i2, jint i3, jint i4, jstring s11);

JNIEXPORT jint JNICALL Java_com_glu_platform_android_GluPlatformActivityJNI_onCreate(
    JNIEnv *env, jobject thiz, jbyteArray array, jobject callback);

JNIEXPORT void JNICALL Java_com_glu_platform_android_GluPlatformActivityJNI_setWindow(
    JNIEnv *env, jobject thiz, jobject holder);

JNIEXPORT void JNICALL Java_com_glu_platform_android_GluPlatformActivityJNI_surfaceCreated(
    JNIEnv *env, jobject thiz, jint id);

JNIEXPORT void JNICALL Java_com_glu_platform_android_GluPlatformActivityJNI_surfaceChanged(
    JNIEnv *env, jobject thiz, jint id, jint format, jint w, jint h);

JNIEXPORT void JNICALL Java_com_glu_platform_android_GluPlatformActivityJNI_onSurfaceCreated(
    JNIEnv *env, jobject thiz, jint id);

JNIEXPORT void JNICALL Java_com_glu_platform_android_GluPlatformActivityJNI_onSurfaceChanged(
    JNIEnv *env, jobject thiz, jint id, jint w, jint h);

JNIEXPORT void JNICALL Java_com_glu_platform_android_GluPlatformActivityJNI_onDrawFrame(
    JNIEnv *env, jobject thiz, jint id, jlong time, jboolean b);

JNIEXPORT void JNICALL Java_com_glu_platform_android_GluPlatformActivityJNI_onDestroy(
    JNIEnv *env, jobject thiz, jint id);

JNIEXPORT void JNICALL Java_com_glu_platform_android_GluPlatformActivityJNI_onPause(
    JNIEnv *env, jobject thiz, jint id);

JNIEXPORT void JNICALL Java_com_glu_platform_android_GluPlatformActivityJNI_onResume(
    JNIEnv *env, jobject thiz, jint id);

JNIEXPORT void JNICALL Java_com_glu_platform_android_GluPlatformActivityJNI_onStart(
    JNIEnv *env, jobject thiz, jint id);

JNIEXPORT void JNICALL Java_com_glu_platform_android_GluPlatformActivityJNI_onStop(
    JNIEnv *env, jobject thiz, jint id);

JNIEXPORT void JNICALL Java_com_glu_platform_android_GluPlatformActivityJNI_onRestart(
    JNIEnv *env, jobject thiz, jint id);

JNIEXPORT void JNICALL Java_com_glu_platform_android_GluPlatformActivityJNI_onLowMemory(
    JNIEnv *env, jobject thiz, jint id);

JNIEXPORT void JNICALL Java_com_glu_platform_android_GluPlatformActivityJNI_onOrientationChanged(
    JNIEnv *env, jobject thiz, jint orientation);

JNIEXPORT jboolean JNICALL Java_com_glu_platform_android_GluPlatformActivityJNI_onKeyDown(
    JNIEnv *env, jobject thiz, jint code, jint event);

JNIEXPORT jboolean JNICALL Java_com_glu_platform_android_GluPlatformActivityJNI_onKeyUp(
    JNIEnv *env, jobject thiz, jint code, jint event);

JNIEXPORT void JNICALL Java_com_glu_platform_android_GluPlatformActivityJNI_surfaceDestroyed(
    JNIEnv *env, jobject thiz, jint id);

JNIEXPORT void JNICALL Java_com_glu_platform_android_GluPlatformActivityJNI_TouchBegan(
    JNIEnv *env, jobject thiz, jint id, jint x, jint y, jint pid);

JNIEXPORT void JNICALL Java_com_glu_platform_android_GluPlatformActivityJNI_TouchMoved(
    JNIEnv *env, jobject thiz, jint id, jint x, jint y, jint pid);

JNIEXPORT void JNICALL Java_com_glu_platform_android_GluPlatformActivityJNI_TouchEnded(
    JNIEnv *env, jobject thiz, jint id, jint x, jint y, jint pid);

JNIEXPORT void JNICALL Java_com_glu_platform_android_GluPlatformActivityJNI_TouchCancelled(
    JNIEnv *env, jobject thiz, jint id, jint x, jint y, jint pid);

JNIEXPORT void JNICALL Java_com_glu_platform_android_GluPlatformActivityJNI_MouseButtonDown(
    JNIEnv *env, jobject thiz, jint id, jint x, jint y);

JNIEXPORT void JNICALL Java_com_glu_platform_android_GluPlatformActivityJNI_MouseButtonUp(
    JNIEnv *env, jobject thiz, jint id, jint x, jint y);

JNIEXPORT void JNICALL Java_com_glu_platform_android_GluPlatformActivityJNI_MouseMove(
    JNIEnv *env, jobject thiz, jint id, jint x, jint y);

JNIEXPORT void JNICALL Java_com_glu_platform_android_GluPlatformActivityJNI_pushAccelerometerValues(
    JNIEnv *env, jobject thiz, jint id, jfloat x, jfloat y, jfloat z);

JNIEXPORT void JNICALL Java_com_glu_platform_android_GluPlatformActivityJNI_SoundEventCompleted(
    JNIEnv *env, jobject thiz, jint id, jlong event_id);

JNIEXPORT void JNICALL Java_com_glu_platform_android_GluPlatformActivityJNI_feedPCMMediaPlayer(
    JNIEnv *env, jobject thiz, jint id, jbyteArray array, jint len);

JNIEXPORT void JNICALL Java_com_glu_platform_android_GluPlatformActivityJNI_javaToNativeFacebook(
    JNIEnv *env, jobject thiz, jint i1, jint i2, jint i3, jbyteArray b, jobjectArray c);

JNIEXPORT void JNICALL Java_com_glu_platform_android_GluPlatformActivityJNI_LocalEvent(
    JNIEnv *env, jobject thiz, jstring s1, jstring s2);

JNIEXPORT void JNICALL Java_com_glu_platform_android_GluPlatformActivityJNI_tidy(
    JNIEnv *env, jobject thiz, jint id);

JNIEXPORT void JNICALL Java_com_glu_platform_android_GluPlatformActivityJNI_uninitialise(
    JNIEnv *env, jobject thiz);

JNIEXPORT void JNICALL Java_com_glu_platform_android_GluPlatformActivityJNI_setUseBeam(
    JNIEnv *env, jobject thiz, jint id, jboolean b);

JNIEXPORT void JNICALL Java_com_glu_platform_gwallet_GWallet_create(JNIEnv *env, jobject thiz);
JNIEXPORT void JNICALL Java_com_glu_platform_gwallet_GWallet_destroy(JNIEnv *env, jobject thiz);
JNIEXPORT void JNICALL Java_com_glu_platform_gwallet_GWallet_start(JNIEnv *env, jobject thiz);
JNIEXPORT void JNICALL Java_com_glu_platform_gwallet_GWallet_stop(JNIEnv *env, jobject thiz);
JNIEXPORT void JNICALL Java_com_glu_platform_gwallet_GWallet_pause(JNIEnv *env, jobject thiz);
JNIEXPORT void JNICALL Java_com_glu_platform_gwallet_GWallet_resume(JNIEnv *env, jobject thiz);
JNIEXPORT void JNICALL Java_com_glu_platform_gwallet_GWallet_restart(JNIEnv *env, jobject thiz);
JNIEXPORT void JNICALL Java_com_glu_platform_gwallet_GWallet_initialise(JNIEnv *env, jobject thiz);
JNIEXPORT void JNICALL Java_com_glu_platform_gwallet_GWallet_uninitialise(JNIEnv *env, jobject thiz);
JNIEXPORT void JNICALL Java_com_glu_platform_gwallet_GWallet_getBalance(JNIEnv *env, jobject thiz);
JNIEXPORT void JNICALL Java_com_glu_platform_gwallet_GWallet_addCurrency(JNIEnv *env, jobject thiz);
JNIEXPORT void JNICALL Java_com_glu_platform_gwallet_GWallet_subtractCurrency(JNIEnv *env, jobject thiz);
JNIEXPORT void JNICALL Java_com_glu_platform_gwallet_GWallet_subscribeWithReceipt(JNIEnv *env, jobject thiz);
JNIEXPORT void JNICALL Java_com_glu_platform_gwallet_GWallet_handleupdate(JNIEnv *env, jobject thiz);
JNIEXPORT void JNICALL Java_com_glu_platform_gwallet_GWalletJNI_enableHTTPTransfers(JNIEnv *env, jobject thiz);
JNIEXPORT void JNICALL Java_com_glu_platform_gwallet_GWalletJNI_onHandleResponse(JNIEnv *env, jobject thiz, jstring s, jint i);
JNIEXPORT jboolean JNICALL Java_com_glu_android_GluBeam_onIncomingNFCDataReceived(JNIEnv *env, jobject thiz, jbyteArray b);
JNIEXPORT jint JNICALL Java_com_glu_android_iap_IAPJava_iapCallbackEvent(JNIEnv *env, jobject thiz, jint i1, jint i2, jbyteArray b);

GUNBROS_EXTERN_C_END

#endif // GUNBROS_JNI_EXPORTS_H
