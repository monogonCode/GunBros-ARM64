#include "gunbros/compatibility/jni_virtual_machine.h"
#include "gunbros/emulator/guest_memory.h"
#include "gunbros/platform/jni_env_helper.h"
#include "gunbros/platform/android_audio.h"
#include <string.h>
#include <stdio.h>

typedef struct {
    char name[64];
    char sig[64];
} JniMethodInfo;

#define MAX_JNI_METHODS 512
static JniMethodInfo s_jni_methods[MAX_JNI_METHODS];
static int s_jni_method_count = 1;
static char s_last_jni_string[512] = {0};

void jvm_virtual_init(uint8_t *heap_base, uint8_t *stubs_base, const char *game_dir) {
    if (!heap_base || !stubs_base) return;

    // Setup 16 fake JavaVM stubs at 0x8000b000
    for (int i = 0; i < 16; i++) {
        uint32_t *s = (uint32_t*)(stubs_base + 0xb000 + i * 8);
        s[0] = 0xef000000 | (0x1000 + i); // svc 0x1000 + i
        s[1] = 0xe12fff1e;                 // bx lr
    }

    // Setup 256 fake JNIEnv stubs at 0x8000c000
    for (int i = 0; i < 256; i++) {
        uint32_t *s = (uint32_t*)(stubs_base + 0xc000 + i * 8);
        s[0] = 0xef000000 | (0x2000 + i); // svc 0x2000 + i
        s[1] = 0xe12fff1e;                 // bx lr
    }

    // Setup fake JavaVM object at 0x60000100 -> vtable at 0x60000120
    *(uint32_t*)(heap_base + 0x100) = GUEST_JVM_VTABLE;
    uint32_t *jvm_table = (uint32_t*)(heap_base + 0x120);
    for (int i = 0; i < 16; i++) {
        jvm_table[i] = GUEST_JVM_STUBS + i * 8;
    }

    // Setup fake JNIEnv object at 0x60001000 -> vtable at 0x60001100
    *(uint32_t*)(heap_base + 0x1000) = GUEST_ENV_VTABLE;
    uint32_t *env_table = (uint32_t*)(heap_base + 0x1100);
    for (int i = 0; i < 256; i++) {
        env_table[i] = GUEST_ENV_STUBS + i * 8;
    }

    // Initialize dummy heap pointers and handles
    *(uint32_t*)(heap_base + 0x2000) = GUEST_DUMMY_OBJ;
    *(uint32_t*)(heap_base + 0x2080) = GUEST_SENTINEL_OBJ; // EGL_NO_xxx
    *(uint32_t*)(heap_base + 0x2100) = GUEST_RESDL_STRING;
    *(char*)(heap_base + 0x3000) = '\0';                   // empty string
    if (game_dir) {
        strncpy((char*)(heap_base + 0x4000), game_dir, 511);
    }
    *(uint32_t*)(heap_base + 0x6000) = 0;                  // general array / direct buffer
    *(uint32_t*)(heap_base + 0x7000) = GUEST_TLS_BASE;     // tls[0] = self
    *(uint32_t*)(heap_base + 0x7020) = 0;                  // errno = 0

    s_jni_method_count = 1;
}

int jvm_register_method(const char *name, const char *sig) {
    if (!name) return 0;
    if (strcmp(name, "eglGetError") == 0) return 0x00003000;
    if (strcmp(name, "GetDeviceOrientation") == 0) return 0x00003001;
    for (int i = 1; i < s_jni_method_count; i++) {
        if (strcmp(s_jni_methods[i].name, name) == 0) {
            return i;
        }
    }
    if (s_jni_method_count < MAX_JNI_METHODS) {
        int id = s_jni_method_count++;
        strncpy(s_jni_methods[id].name, name, sizeof(s_jni_methods[id].name) - 1);
        s_jni_methods[id].name[sizeof(s_jni_methods[id].name) - 1] = '\0';
        if (sig) {
            strncpy(s_jni_methods[id].sig, sig, sizeof(s_jni_methods[id].sig) - 1);
            s_jni_methods[id].sig[sizeof(s_jni_methods[id].sig) - 1] = '\0';
        }
        return id;
    }
    return 1;
}

const char* jvm_get_method_name(uint32_t id) {
    if (id == 0x00003000) return "eglGetError";
    if (id == 0x00003001) return "GetDeviceOrientation";
    if (id > 0 && id < (uint32_t)s_jni_method_count) {
        return s_jni_methods[id].name;
    }
    return "unknown";
}

void handle_jvm_call(int idx, uint32_t *r0, uint32_t *r1, uint32_t *r2, uint32_t *r3, uint32_t sp, uint32_t lr) {
    (void)r2; (void)r3; (void)sp; (void)lr;
    DLOG("JVM Call: idx=%d (r0=0x%x, r1=0x%x, lr=0x%x)", idx, *r0, *r1, lr);
    if (idx == 4) { // AttachCurrentThread(JavaVM*, JNIEnv**, void*)
        uint32_t *p_env = (uint32_t*)guest_to_host(*r1);
        if (p_env) *p_env = GUEST_ENV_OBJ;
        *r0 = 0; // JNI_OK
    } else if (idx == 6) { // GetEnv(JavaVM*, void**, jint)
        uint32_t *p_env = (uint32_t*)guest_to_host(*r1);
        if (p_env) *p_env = GUEST_ENV_OBJ;
        *r0 = 0; // JNI_OK
    } else {
        *r0 = 0;
    }
}

static uint32_t get_jni_method_arg(int idx, uint32_t r3, uint32_t sp, int arg_idx) {
    int is_va = (idx == 35 || idx == 36 || idx == 38 || idx == 39 ||
                 idx == 41 || idx == 42 || idx == 44 || idx == 45 ||
                 idx == 47 || idx == 48 || idx == 50 || idx == 51 ||
                 idx == 53 || idx == 54 || idx == 56 || idx == 57 ||
                 idx == 59 || idx == 60 || idx == 62 || idx == 63 ||
                 idx == 68 || idx == 69 || idx == 80 || idx == 81 ||
                 idx == 92 || idx == 93 || idx == 118 || idx == 119 ||
                 idx == 130 || idx == 131 || idx == 142 || idx == 143);

    if (is_va || (r3 >= GUEST_STACK_BASE && r3 < GUEST_STACK_BASE + GUEST_STACK_SIZE)) {
        uint32_t *args = (uint32_t*)guest_to_host(r3);
        if (args) return args[arg_idx];
        return 0;
    }

    if (arg_idx == 0) return r3;
    uint32_t *sp_args = (uint32_t*)guest_to_host(sp);
    if (sp_args) return sp_args[arg_idx - 1];
    return 0;
}

void handle_jni_call(int idx, uint32_t *r0, uint32_t *r1, uint32_t *r2, uint32_t *r3, uint32_t sp, uint32_t lr) {
    (void)lr;
    switch (idx) {
        case 4: // GetVersion
            *r0 = 0x00010006; // JNI 1.6
            break;

        case 6: // FindClass(env, name)
        case 10: // GetSuperclass
        case 31: // GetObjectClass
        {
            const char *cname = (const char*)guest_to_host(*r1);
            if (idx == 6) {
                DLOG("JNI FindClass: '%s'", cname ? cname : "NULL");
            }
            *r0 = 0x00001111;
            break;
        }

        case 11: // IsAssignableFrom
        case 32: // IsInstanceOf
            *r0 = 1;
            break;

        case 21: // NewGlobalRef
        case 25: // NewLocalRef
            *r0 = *r1;
            break;

        case 22: // DeleteGlobalRef
        case 23: // DeleteLocalRef
            *r0 = 0;
            break;

        case 24: // IsSameObject
            *r0 = (*r1 == *r2) ? 1 : 0;
            break;

        case 27: // AllocObject
        case 28: // NewObject
        case 29: // NewObjectV
        case 30: // NewObjectA
            *r0 = GUEST_DUMMY_OBJ;
            break;

        case 33: // GetMethodID(env, clazz, name, sig)
        case 113: // GetStaticMethodID(env, clazz, name, sig)
        {
            const char *name = (const char*)guest_to_host(*r2);
            const char *sig = (const char*)guest_to_host(*r3);
            int mid = jvm_register_method(name, sig);
            DLOG("JNI Get%sMethodID: '%s' ('%s') -> 0x%x", (idx == 113 ? "Static" : ""), name ? name : "NULL", sig ? sig : "NULL", mid);
            *r0 = (uint32_t)mid;
            break;
        }

        case 34: // CallObjectMethod
        case 35: // CallObjectMethodV
        case 36: // CallObjectMethodA
        case 64: // CallNonvirtualObjectMethod
        case 65:
        case 66:
        case 114: // CallStaticObjectMethod
        case 115: // CallStaticObjectMethodV
        case 116: // CallStaticObjectMethodA
        {
            const char *mname = jvm_get_method_name(*r2);
            DLOG("JNI CallObjectMethod: mid=0x%x ('%s')", *r2, mname);
            if (strcmp(mname, "resdlStringEvent") == 0) {
                *r0 = GUEST_RESDL_STRING;
            } else if (strcmp(mname, "OpenAPKFile") == 0) {
                DLOG("JNI OpenAPKFile: returning NULL (resources exist on disk)");
                *r0 = 0;
            } else {
                *r0 = GUEST_DUMMY_OBJ;
            }
            break;
        }

        case 37: // CallBooleanMethod
        case 38: // CallBooleanMethodV
        case 39: // CallBooleanMethodA
        case 67: // CallNonvirtualBooleanMethod
        case 68:
        case 69:
        case 117: // CallStaticBooleanMethod
        case 118: // CallStaticBooleanMethodV
        case 119: // CallStaticBooleanMethodA
        {
            uint32_t mid_val = (idx >= 64 && idx <= 93) ? *r3 : *r2;
            const char *mname = jvm_get_method_name(mid_val);
            DLOG("JNI CallBooleanMethod: mid=0x%x ('%s')", mid_val, mname);
            if (strcmp(mname, "InitialiseSoundEngine") == 0) {
                uint32_t use_pcm  = get_jni_method_arg(idx, *r3, sp, 0);
                uint32_t rate     = get_jni_method_arg(idx, *r3, sp, 1);
                uint32_t channels = get_jni_method_arg(idx, *r3, sp, 2);
                uint32_t bits     = get_jni_method_arg(idx, *r3, sp, 3);
                uint32_t bufsz    = get_jni_method_arg(idx, *r3, sp, 4);
                uint32_t period   = get_jni_method_arg(idx, *r3, sp, 5);

                if (use_pcm && bits == 16) {
                    audio_configure(rate, channels, bits, bufsz, period);
                    *r0 = 1;
                    break;
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
                *r0 = ok ? 1 : 0;
            } else if (strcmp(mname, "StartAudioStream") == 0) {
                if (audio_is_native()) {
                    audio_start_stream();
                    *r0 = 1;
                } else {
                    JNIEnv *real_env = platform_get_env();
                    jobject real_callback = platform_get_callback();
                    jboolean ok = JNI_TRUE;
                    if (real_env && real_callback) {
                        jclass cls = (*real_env)->GetObjectClass(real_env, real_callback);
                        jmethodID mid = (*real_env)->GetMethodID(real_env, cls, "StartAudioStream", "()Z");
                        if (mid) ok = (*real_env)->CallBooleanMethod(real_env, real_callback, mid);
                    }
                    *r0 = ok ? 1 : 0;
                }
            } else if (strcmp(mname, "StopAudioStream") == 0) {
                if (audio_is_native()) {
                    audio_stop_stream();
                    *r0 = 1;
                } else {
                    JNIEnv *real_env = platform_get_env();
                    jobject real_callback = platform_get_callback();
                    jboolean ok = JNI_TRUE;
                    if (real_env && real_callback) {
                        jclass cls = (*real_env)->GetObjectClass(real_env, real_callback);
                        jmethodID mid = (*real_env)->GetMethodID(real_env, cls, "StopAudioStream", "()Z");
                        if (mid) ok = (*real_env)->CallBooleanMethod(real_env, real_callback, mid);
                    }
                    *r0 = ok ? 1 : 0;
                }
            } else if (strcmp(mname, "IsPSP") == 0 ||
                       strcmp(mname, "interfaceIsOpen") == 0 ||
                       strcmp(mname, "isVisible") == 0 ||
                       strcmp(mname, "canDisplayInterface") == 0 ||
                       strcmp(mname, "getFeaturedAppQueryState") == 0) {
                *r0 = 0;
            } else {
                *r0 = 1;
            }
            break;
        }

        case 49: // CallIntMethod
        case 50: // CallIntMethodV
        case 51: // CallIntMethodA
        case 79: // CallNonvirtualIntMethod
        case 80:
        case 81:
        case 129: // CallStaticIntMethod
        case 130: // CallStaticIntMethodV
        case 131: // CallStaticIntMethodA
        {
            uint32_t mid_val = (idx >= 64 && idx <= 93) ? *r3 : *r2;
            const char *mname = jvm_get_method_name(mid_val);
            DLOG("JNI CallIntMethod: mid=0x%x ('%s')", mid_val, mname);
            if (mid_val == 0x00003000 || mid_val == 12288 || strcmp(mname, "eglGetError") == 0) {
                *r0 = 12288; // 0x3000 = EGL_SUCCESS
            } else if (mid_val == 0x00003001 || strcmp(mname, "GetDeviceOrientation") == 0) {
                *r0 = 0; // Landscape
            } else if (strcmp(mname, "resdlEvent") == 0) {
                *r0 = 1;
            } else if (strcmp(mname, "GetAndroidMinBufferSize") == 0) {
                uint32_t rate     = get_jni_method_arg(idx, *r3, sp, 0);
                uint32_t channels = get_jni_method_arg(idx, *r3, sp, 1);
                uint32_t bits     = get_jni_method_arg(idx, *r3, sp, 2);

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
                *r0 = (uint32_t)(min_buf > 0 ? min_buf : 4096);
            } else if (strcmp(mname, "mp3Event") == 0) {
                uint32_t event = get_jni_method_arg(idx, *r3, sp, 0);
                uint32_t loop  = get_jni_method_arg(idx, *r3, sp, 1);
                JNIEnv *real_env = platform_get_env();
                jobject real_callback = platform_get_callback();
                jint ret = 0;
                if (real_env && real_callback) {
                    jclass cls = (*real_env)->GetObjectClass(real_env, real_callback);
                    jmethodID mid = (*real_env)->GetMethodID(real_env, cls, "mp3Event", "(IILjava/lang/String;)I");
                    if (mid) {
                        jstring jstr = (*real_env)->NewStringUTF(real_env, s_last_jni_string);
                        ret = (*real_env)->CallIntMethod(real_env, real_callback, mid, (jint)event, (jint)loop, jstr);
                        if (jstr) (*real_env)->DeleteLocalRef(real_env, jstr);
                    }
                }
                *r0 = (uint32_t)ret;
            } else {
                *r0 = 0;
            }
            break;
        }

        case 52: // CallLongMethod
        case 53: // CallLongMethodV
        case 54: // CallLongMethodA
        case 82:
        case 83:
        case 84:
        case 132:
        case 133:
        case 134:
        {
            uint32_t mid_val = (idx >= 64 && idx <= 93) ? *r3 : *r2;
            const char *mname = jvm_get_method_name(mid_val);
            DLOG("JNI CallLongMethod: mid=0x%x ('%s')", mid_val, mname);
            if (strcmp(mname, "GetDeviceAvailableMemory") == 0) {
                *r0 = 64 * 1024 * 1024;
                *r1 = 0;
            } else {
                *r0 = 0;
                *r1 = 0;
            }
            break;
        }

        case 61: // CallVoidMethod
        case 62: // CallVoidMethodV
        case 63: // CallVoidMethodA
        case 91:
        case 92:
        case 93:
        case 141: // CallStaticVoidMethod
        case 142: // CallStaticVoidMethodV
        case 143: // CallStaticVoidMethodA
        {
            uint32_t mid_val = (idx >= 64 && idx <= 93) ? *r3 : *r2;
            const char *mname = jvm_get_method_name(mid_val);
            DLOG("JNI CallVoidMethod: mid=0x%x ('%s')", mid_val, mname);
            if (strcmp(mname, "EnableMultipleTouch") == 0) {
                uint32_t enable = get_jni_method_arg(idx, *r3, sp, 0);
                JNIEnv *real_env = platform_get_env();
                jobject real_callback = platform_get_callback();
                if (real_env && real_callback) {
                    jclass cls = (*real_env)->GetObjectClass(real_env, real_callback);
                    jmethodID mid = (*real_env)->GetMethodID(real_env, cls, "EnableMultipleTouch", "(Z)V");
                    if (mid) (*real_env)->CallVoidMethod(real_env, real_callback, mid, (jboolean)(enable ? JNI_TRUE : JNI_FALSE));
                }
            } else if (strcmp(mname, "SetVolume") == 0) {
                uint32_t vol = get_jni_method_arg(idx, *r3, sp, 0);
                JNIEnv *real_env = platform_get_env();
                jobject real_callback = platform_get_callback();
                if (real_env && real_callback) {
                    jclass cls = (*real_env)->GetObjectClass(real_env, real_callback);
                    jmethodID mid = (*real_env)->GetMethodID(real_env, cls, "SetVolume", "(B)V");
                    if (mid) (*real_env)->CallVoidMethod(real_env, real_callback, mid, (jbyte)vol);
                }
            }
            *r0 = 0;
            break;
        }

        case 94: // GetFieldID
        case 144: // GetStaticFieldID
        {
            const char *fname = (const char*)guest_to_host(*r2);
            DLOG("JNI Get%sFieldID: '%s'", (idx == 144 ? "Static" : ""), fname ? fname : "NULL");
            *r0 = 0x00004444;
            break;
        }

        case 95: // GetObjectField
            *r0 = GUEST_DUMMY_OBJ;
            break;

        case 145: // GetStaticObjectField
            *r0 = GUEST_SENTINEL_OBJ; // EGL_NO_xxx
            break;

        case 96: // GetBooleanField
        case 146: // GetStaticBooleanField
            *r0 = 1;
            break;

        case 100: // GetIntField
        case 150: // GetStaticIntField
            *r0 = 0;
            break;

        case 104: // SetObjectField
        case 105: // SetBooleanField
        case 109: // SetIntField
        case 154: // SetStaticObjectField
        case 155: // SetStaticBooleanField
        case 159: // SetStaticIntField
            *r0 = 0;
            break;

        case 163: // NewString(env, unicodeChars, len)
        {
            const uint16_t *uchars = (const uint16_t*)guest_to_host(*r1);
            uint32_t ulen = *r2;
            if (uchars && ulen > 0) {
                if (ulen >= sizeof(s_last_jni_string)) ulen = sizeof(s_last_jni_string) - 1;
                for (uint32_t i = 0; i < ulen; i++) {
                    s_last_jni_string[i] = (char)(uchars[i] & 0x7f);
                }
                s_last_jni_string[ulen] = '\0';
                LOGI("JNI NewString: '%s'", s_last_jni_string);
            } else {
                s_last_jni_string[0] = '\0';
            }
            *r0 = GUEST_DUMMY_OBJ;
            break;
        }

        case 167: // NewStringUTF(env, bytes)
        {
            const char *str = (const char*)guest_to_host(*r1);
            if (str) {
                strncpy(s_last_jni_string, str, sizeof(s_last_jni_string) - 1);
                s_last_jni_string[sizeof(s_last_jni_string) - 1] = '\0';
                DLOG("JNI NewStringUTF: '%s'", s_last_jni_string);
            } else {
                s_last_jni_string[0] = '\0';
            }
            *r0 = GUEST_DUMMY_OBJ;
            break;
        }

        case 164: // GetStringLength
        case 168: // GetStringUTFLength
            *r0 = 0;
            break;

        case 165: // GetStringChars
        case 169: // GetStringUTFChars
        case 224: // GetStringCritical
            *r0 = GUEST_EMPTY_STRING;
            break;

        case 166: // ReleaseStringChars
        case 170: // ReleaseStringUTFChars
        case 225: // ReleaseStringCritical
            *r0 = 0;
            break;

        case 171: // GetArrayLength
            if (*r1 == GUEST_RESDL_STRING) {
                const char *res_str = (const char*)guest_to_host(GUEST_RESDL_BUF);
                *r0 = res_str ? (uint32_t)strlen(res_str) + 1 : 1;
            } else {
                *r0 = 2;
            }
            break;

        case 172: case 173: case 174: case 175: case 176:
        case 177: case 178: case 179: case 180: case 181: case 182:
            *r0 = GUEST_DUMMY_OBJ;
            break;

        case 183: case 184: case 185: case 186: case 187:
        case 188: case 189: case 190:
            if (*r1 == GUEST_RESDL_STRING) {
                *r0 = GUEST_RESDL_BUF;
            } else {
                *r0 = GUEST_DIRECT_BUF;
            }
            break;

        case 191: case 192: case 193: case 194: case 195:
        case 196: case 197: case 198:
            *r0 = 0;
            break;

        case 208: // SetByteArrayRegion
        case 211: // SetIntArrayRegion
            *r0 = 0;
            break;

        case 203: // GetIntArrayRegion(env, array, start, len, buf)
        {
            uint32_t buf_ptr = 0;
            guest_mem_read(sp, &buf_ptr, 4);
            uint32_t *dst = (uint32_t*)guest_to_host(buf_ptr);
            if (dst) {
                dst[0] = 1; // EGL 1.x
                if (*r3 > 1) dst[1] = 4; // EGL 1.4
            }
            *r0 = 0;
            break;
        }

        case 219: // GetJavaVM(env, JavaVM**)
        {
            uint32_t *dst = (uint32_t*)guest_to_host(*r1);
            if (dst) *dst = GUEST_JVM_OBJ;
            *r0 = 0;
            break;
        }

        case 228: // ExceptionCheck
        case 15:  // ExceptionOccurred
            *r0 = 0;
            break;

        case 16:  // ExceptionDescribe
        case 17:  // ExceptionClear
            *r0 = 0;
            break;

        case 229: // NewDirectByteBuffer
            *r0 = GUEST_DUMMY_OBJ;
            break;

        case 230: // GetDirectBufferAddress
            *r0 = GUEST_DIRECT_BUF;
            break;

        case 231: // GetDirectBufferCapacity
            *r0 = 65536;
            break;

        default:
            DLOG("JNI unhandled index: %d", idx);
            *r0 = 0;
            break;
    }
}

static uint32_t get_guest_vararg(uint32_t *reg_args, int reg_count, uint32_t sp, int *arg_idx) {
    int idx = *arg_idx;
    (*arg_idx)++;
    if (idx < reg_count && reg_args != NULL) {
        return reg_args[idx];
    } else {
        uint32_t val = 0;
        int stack_offset = (reg_args != NULL) ? (idx - reg_count) * 4 : idx * 4;
        guest_mem_read(sp + stack_offset, &val, 4);
        return val;
    }
}

int safe_guest_snprintf(char *dst, size_t max_len, const char *fmt, uint32_t *reg_args, int reg_count, uint32_t sp) {
    if (!dst || max_len == 0) return 0;
    if (!fmt) { dst[0] = '\0'; return 0; }

    char temp[1024];
    size_t out_len = 0;
    int arg_idx = 0;
    const char *p = fmt;

    while (*p != '\0' && out_len + 1 < sizeof(temp)) {
        if (*p != '%') {
            temp[out_len++] = *p++;
            continue;
        }

        p++; // skip '%'
        if (*p == '%') {
            temp[out_len++] = '%';
            p++;
            continue;
        }

        char spec[32];
        int s_idx = 0;
        spec[s_idx++] = '%';
        while (*p && strchr("0123456789.-+ #lhjzt", *p) && s_idx < 30) {
            spec[s_idx++] = *p++;
        }
        char type = *p ? *p++ : '\0';
        spec[s_idx++] = type;
        spec[s_idx] = '\0';

        char formatted[256];
        formatted[0] = '\0';

        if (type == 's') {
            uint32_t guest_ptr_val = get_guest_vararg(reg_args, reg_count, sp, &arg_idx);
            const char *str = (const char*)guest_to_host(guest_ptr_val);
            if (!str) str = "";
            snprintf(formatted, sizeof(formatted), spec, str);
        } else if (type == 'd' || type == 'i') {
            uint32_t val = get_guest_vararg(reg_args, reg_count, sp, &arg_idx);
            snprintf(formatted, sizeof(formatted), spec, (int32_t)val);
        } else if (type == 'u' || type == 'x' || type == 'X' || type == 'p') {
            uint32_t val = get_guest_vararg(reg_args, reg_count, sp, &arg_idx);
            snprintf(formatted, sizeof(formatted), spec, val);
        } else if (type == 'c') {
            uint32_t val = get_guest_vararg(reg_args, reg_count, sp, &arg_idx);
            snprintf(formatted, sizeof(formatted), spec, (char)val);
        } else if (type == 'f' || type == 'g' || type == 'e') {
            if (arg_idx & 1) arg_idx++;
            uint32_t lo = get_guest_vararg(reg_args, reg_count, sp, &arg_idx);
            uint32_t hi = get_guest_vararg(reg_args, reg_count, sp, &arg_idx);
            uint64_t dval = ((uint64_t)hi << 32) | lo;
            double d;
            memcpy(&d, &dval, 8);
            snprintf(formatted, sizeof(formatted), spec, d);
        } else {
            snprintf(formatted, sizeof(formatted), "%s", spec);
        }

        size_t flen = strlen(formatted);
        if (out_len + flen < sizeof(temp)) {
            memcpy(temp + out_len, formatted, flen);
            out_len += flen;
        } else {
            size_t avail = sizeof(temp) - 1 - out_len;
            memcpy(temp + out_len, formatted, avail);
            out_len += avail;
            break;
        }
    }

    temp[out_len] = '\0';
    if (out_len >= max_len) {
        memcpy(dst, temp, max_len - 1);
        dst[max_len - 1] = '\0';
    } else {
        memcpy(dst, temp, out_len + 1);
    }
    return (int)out_len;
}
