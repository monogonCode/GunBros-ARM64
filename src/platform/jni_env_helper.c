#include "gunbros/platform/jni_env_helper.h"
#include <pthread.h>

static JavaVM *s_real_jvm = NULL;
static jobject s_real_callback = NULL;
static pthread_mutex_t s_jvm_mutex = PTHREAD_MUTEX_INITIALIZER;

void platform_set_jvm(JavaVM *jvm) {
    pthread_mutex_lock(&s_jvm_mutex);
    s_real_jvm = jvm;
    pthread_mutex_unlock(&s_jvm_mutex);
}

JavaVM* platform_get_jvm(void) {
    pthread_mutex_lock(&s_jvm_mutex);
    JavaVM *jvm = s_real_jvm;
    pthread_mutex_unlock(&s_jvm_mutex);
    return jvm;
}

JNIEnv* platform_get_env(void) {
    JavaVM *jvm = platform_get_jvm();
    if (!jvm) return NULL;
    JNIEnv *env = NULL;
    jint res = (*jvm)->GetEnv(jvm, (void**)&env, JNI_VERSION_1_6);
    if (res == JNI_EDETACHED) {
#ifdef __ANDROID__
        if ((*jvm)->AttachCurrentThread(jvm, &env, NULL) != 0) {
#else
        if ((*jvm)->AttachCurrentThread(jvm, (void**)&env, NULL) != 0) {
#endif
            return NULL;
        }
    }
    return env;
}

void platform_set_callback(JNIEnv *env, jobject cb) {
    pthread_mutex_lock(&s_jvm_mutex);
    if (s_real_callback != NULL && env != NULL) {
        (*env)->DeleteGlobalRef(env, s_real_callback);
        s_real_callback = NULL;
    }
    if (cb != NULL && env != NULL) {
        s_real_callback = (*env)->NewGlobalRef(env, cb);
        LOGI("platform_set_callback: saved global ref %p", s_real_callback);
    }
    pthread_mutex_unlock(&s_jvm_mutex);
}

jobject platform_get_callback(void) {
    pthread_mutex_lock(&s_jvm_mutex);
    jobject cb = s_real_callback;
    pthread_mutex_unlock(&s_jvm_mutex);
    return cb;
}
