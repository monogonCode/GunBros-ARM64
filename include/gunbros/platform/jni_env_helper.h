#ifndef GUNBROS_JNI_ENV_HELPER_H
#define GUNBROS_JNI_ENV_HELPER_H

#include "gunbros/common/common.h"
#include <jni.h>

GUNBROS_EXTERN_C_BEGIN

void platform_set_jvm(JavaVM *jvm);
JavaVM* platform_get_jvm(void);
JNIEnv* platform_get_env(void);

void platform_set_callback(JNIEnv *env, jobject cb);
jobject platform_get_callback(void);

GUNBROS_EXTERN_C_END

#endif // GUNBROS_JNI_ENV_HELPER_H
