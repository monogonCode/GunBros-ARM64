#include "gunbros/platform/android_window.h"
#include <pthread.h>

#ifdef __ANDROID__
#define GL_GLEXT_PROTOTYPES 1
#include <GLES/glext.h>
#endif

static pthread_mutex_t s_egl_mutex = PTHREAD_MUTEX_INITIALIZER;

static int s_real_screen_w = 2631;
static int s_real_screen_h = 1216;
static int s_game_w = 1024;
static int s_game_h = 640;
static int s_buf_w = 1024;
static int s_buf_h = 640;
static int s_game_ox = 0;
static int s_game_oy = 0;

#ifdef __ANDROID__
static EGLDisplay s_display = EGL_NO_DISPLAY;
static EGLSurface s_surface = EGL_NO_SURFACE;
static EGLContext s_context = EGL_NO_CONTEXT;
static ANativeWindow* s_window = NULL;
static ANativeWindow* s_new_window = NULL;
static bool s_window_changed = false;
#endif

void window_init(void) {
    window_compute_viewport(s_real_screen_w, s_real_screen_h);
}

void window_set_dimensions(int w, int h) {
    if (w >= 320 && h >= 200) {
        pthread_mutex_lock(&s_egl_mutex);
        s_game_w = w;
        s_game_h = h;
        window_compute_viewport(s_real_screen_w, s_real_screen_h);
        pthread_mutex_unlock(&s_egl_mutex);
    }
}

void window_get_dimensions(int *w, int *h) {
    pthread_mutex_lock(&s_egl_mutex);
    if (w) *w = s_game_w;
    if (h) *h = s_game_h;
    pthread_mutex_unlock(&s_egl_mutex);
}

void window_set_screen_dimensions(int sw, int sh) {
    pthread_mutex_lock(&s_egl_mutex);
    s_real_screen_w = sw;
    s_real_screen_h = sh;
    window_compute_viewport(sw, sh);
    pthread_mutex_unlock(&s_egl_mutex);
}

void window_get_screen_dimensions(int *sw, int *sh) {
    pthread_mutex_lock(&s_egl_mutex);
    if (sw) *sw = s_real_screen_w;
    if (sh) *sh = s_real_screen_h;
    pthread_mutex_unlock(&s_egl_mutex);
}

void window_compute_viewport(int sw, int sh) {
    if (sw <= 0 || sh <= 0) return;
    if ((int64_t)sw * s_game_h >= (int64_t)sh * s_game_w) {
        s_buf_h = s_game_h;
        s_buf_w = (int)(((int64_t)s_game_h * sw + sh / 2) / sh);
    } else {
        s_buf_w = s_game_w;
        s_buf_h = (int)(((int64_t)s_game_w * sh + sw / 2) / sw);
    }
    if (s_buf_w < s_game_w) s_buf_w = s_game_w;
    if (s_buf_h < s_game_h) s_buf_h = s_game_h;
    s_game_ox = (s_buf_w - s_game_w) / 2;
    s_game_oy = (s_buf_h - s_game_h) / 2;
}

void window_get_origin(int *ox, int *oy) {
    pthread_mutex_lock(&s_egl_mutex);
    if (ox) *ox = s_game_ox;
    if (oy) *oy = s_game_oy;
    pthread_mutex_unlock(&s_egl_mutex);
}

void window_screen_to_game(int sx, int sy, int *gx, int *gy) {
    int sw = s_real_screen_w > 0 ? s_real_screen_w : s_game_w;
    int sh = s_real_screen_h > 0 ? s_real_screen_h : s_game_h;
    int bx = (int)(((int64_t)sx * s_buf_w) / sw);
    int by = (int)(((int64_t)sy * s_buf_h) / sh);
    int x = bx - s_game_ox, y = by - s_game_oy;
    if (gx) *gx = x < 0 ? 0 : (x >= s_game_w ? s_game_w - 1 : x);
    if (gy) *gy = y < 0 ? 0 : (y >= s_game_h ? s_game_h - 1 : y);
}

void window_clear_bars(void) {
#ifdef __ANDROID__
    if (s_game_ox == 0 && s_game_oy == 0) return;
    GLfloat cc[4];
    GLint sb[4];
    GLboolean st = glIsEnabled(GL_SCISSOR_TEST);
    glGetFloatv(GL_COLOR_CLEAR_VALUE, cc);
    glGetIntegerv(GL_SCISSOR_BOX, sb);
    glClearColor(0, 0, 0, 1);
    glEnable(GL_SCISSOR_TEST);
    if (s_game_ox > 0) {
        glScissor(0, 0, s_game_ox, s_buf_h);
        glClear(GL_COLOR_BUFFER_BIT);
        glScissor(s_game_ox + s_game_w, 0, s_buf_w - s_game_ox - s_game_w, s_buf_h);
        glClear(GL_COLOR_BUFFER_BIT);
    }
    if (s_game_oy > 0) {
        glScissor(0, 0, s_buf_w, s_game_oy);
        glClear(GL_COLOR_BUFFER_BIT);
        glScissor(0, s_game_oy + s_game_h, s_buf_w, s_buf_h - s_game_oy - s_game_h);
        glClear(GL_COLOR_BUFFER_BIT);
    }
    glScissor(sb[0], sb[1], sb[2], sb[3]);
    if (!st) glDisable(GL_SCISSOR_TEST);
    glClearColor(cc[0], cc[1], cc[2], cc[3]);
#endif
}

void window_set_surface(JNIEnv *env, jobject holder) {
#ifdef __ANDROID__
    if (holder != NULL && env != NULL) {
        jclass holderClass = (*env)->GetObjectClass(env, holder);
        jmethodID getSurface = (*env)->GetMethodID(env, holderClass, "getSurface", "()Landroid/view/Surface;");
        if (getSurface != NULL) {
            jobject surface = (*env)->CallObjectMethod(env, holder, getSurface);
            if (surface != NULL) {
                jclass surfClass = (*env)->GetObjectClass(env, surface);
                jmethodID isValidMethod = (*env)->GetMethodID(env, surfClass, "isValid", "()Z");
                jboolean valid = JNI_TRUE;
                if (isValidMethod != NULL) {
                    valid = (*env)->CallBooleanMethod(env, surface, isValidMethod);
                }
                if (valid) {
                    pthread_mutex_lock(&s_egl_mutex);
                    ANativeWindow *win = ANativeWindow_fromSurface(env, surface);
                    if (win != NULL) {
                        s_new_window = win;
                        s_window_changed = true;
                    }
                    pthread_mutex_unlock(&s_egl_mutex);
                }
            }
        }
    }
#else
    (void)env; (void)holder;
#endif
}

bool window_ensure_egl(void) {
#ifdef __ANDROID__
    pthread_mutex_lock(&s_egl_mutex);
    if (s_window_changed) {
        if (s_surface != EGL_NO_SURFACE) {
            eglMakeCurrent(s_display, EGL_NO_SURFACE, EGL_NO_SURFACE, EGL_NO_CONTEXT);
            eglDestroySurface(s_display, s_surface);
            s_surface = EGL_NO_SURFACE;
        }
        if (s_window != NULL) {
            ANativeWindow_release(s_window);
        }
        s_window = s_new_window;
        s_new_window = NULL;
        s_window_changed = false;
        LOGI("window_ensure_egl: Bound new s_window=%p", s_window);
    }

    if (s_window == NULL) {
        pthread_mutex_unlock(&s_egl_mutex);
        return false;
    }

    if (s_display == EGL_NO_DISPLAY) {
        s_display = eglGetDisplay(EGL_DEFAULT_DISPLAY);
        if (!eglInitialize(s_display, NULL, NULL)) {
            LOGE("eglInitialize failed: 0x%x", eglGetError());
            pthread_mutex_unlock(&s_egl_mutex);
            return false;
        }
    }

    if (s_surface == EGL_NO_SURFACE && s_display != EGL_NO_DISPLAY) {
        EGLint attribs[] = {
            EGL_SURFACE_TYPE, EGL_WINDOW_BIT,
            EGL_RENDERABLE_TYPE, EGL_OPENGL_ES_BIT,
            EGL_RED_SIZE, 8,
            EGL_GREEN_SIZE, 8,
            EGL_BLUE_SIZE, 8,
            EGL_DEPTH_SIZE, 16,
            EGL_NONE
        };
        EGLConfig config;
        EGLint numConfigs = 0;
        if (!eglChooseConfig(s_display, attribs, &config, 1, &numConfigs) || numConfigs <= 0) {
            EGLint attribs_nodepth[] = {
                EGL_SURFACE_TYPE, EGL_WINDOW_BIT,
                EGL_RENDERABLE_TYPE, EGL_OPENGL_ES_BIT,
                EGL_NONE
            };
            numConfigs = 0;
            if (!eglChooseConfig(s_display, attribs_nodepth, &config, 1, &numConfigs) || numConfigs <= 0) {
                LOGE("eglChooseConfig failed: 0x%x", eglGetError());
                pthread_mutex_unlock(&s_egl_mutex);
                return false;
            }
        }

        EGLint format = 0;
        if (eglGetConfigAttrib(s_display, config, EGL_NATIVE_VISUAL_ID, &format)) {
            window_compute_viewport(s_real_screen_w, s_real_screen_h);
            ANativeWindow_setBuffersGeometry(s_window, s_buf_w, s_buf_h, format);
        }

        EGLSurface s = eglCreateWindowSurface(s_display, config, s_window, NULL);
        if (s == EGL_NO_SURFACE) {
            LOGE("eglCreateWindowSurface failed: 0x%x", eglGetError());
            pthread_mutex_unlock(&s_egl_mutex);
            return false;
        }
        s_surface = s;

        if (s_context == EGL_NO_CONTEXT) {
            s_context = eglCreateContext(s_display, config, EGL_NO_CONTEXT, NULL);
            if (s_context == EGL_NO_CONTEXT) {
                LOGE("eglCreateContext failed: 0x%x", eglGetError());
                eglDestroySurface(s_display, s_surface);
                s_surface = EGL_NO_SURFACE;
                pthread_mutex_unlock(&s_egl_mutex);
                return false;
            }
        }

        if (s_surface != EGL_NO_SURFACE && s_context != EGL_NO_CONTEXT) {
            if (!eglMakeCurrent(s_display, s_surface, s_surface, s_context)) {
                LOGE("eglMakeCurrent failed: 0x%x", eglGetError());
            } else {
                glViewport(s_game_ox, s_game_oy, s_game_w, s_game_h);
                LOGI("Host EGL & GLES1 initialized (buf %dx%d, game %dx%d @ (%d,%d))",
                     s_buf_w, s_buf_h, s_game_w, s_game_h, s_game_ox, s_game_oy);
            }
        }
    }

    if (s_display != EGL_NO_DISPLAY && s_surface != EGL_NO_SURFACE) {
        eglMakeCurrent(s_display, s_surface, s_surface, s_context);
    }
    pthread_mutex_unlock(&s_egl_mutex);
    return true;
#else
    return true;
#endif
}

void window_swap_buffers(void) {
#ifdef __ANDROID__
    pthread_mutex_lock(&s_egl_mutex);
    if (s_display != EGL_NO_DISPLAY && s_surface != EGL_NO_SURFACE) {
        window_clear_bars();
        eglSwapBuffers(s_display, s_surface);
    }
    pthread_mutex_unlock(&s_egl_mutex);
#endif
}

void window_release(void) {
#ifdef __ANDROID__
    pthread_mutex_lock(&s_egl_mutex);
    if (s_display != EGL_NO_DISPLAY) {
        eglMakeCurrent(s_display, EGL_NO_SURFACE, EGL_NO_SURFACE, EGL_NO_CONTEXT);
        if (s_surface != EGL_NO_SURFACE) {
            eglDestroySurface(s_display, s_surface);
            s_surface = EGL_NO_SURFACE;
        }
        if (s_context != EGL_NO_CONTEXT) {
            eglDestroyContext(s_display, s_context);
            s_context = EGL_NO_CONTEXT;
        }
    }
    if (s_window != NULL) {
        ANativeWindow_release(s_window);
        s_window = NULL;
    }
    pthread_mutex_unlock(&s_egl_mutex);
#endif
}
