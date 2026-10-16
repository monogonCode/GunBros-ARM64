package com.glu.platform.android.facebook;

import android.content.Context;
import android.graphics.Canvas;
import android.graphics.Paint;
import android.view.View;
import java.io.File;

/* JADX INFO: loaded from: classes.dex */
public final class Debug {
    private static File m_debugFile = null;
    public static char[] rawLine = new char[80];
    protected static boolean sm_fileInvalid = false;
    protected static boolean sm_appMustClose = false;
    protected static String sm_debugPopupMessage = null;
    public static final int[] EGL_ATTRIBUTES = {12320, 12321, 12322, 12323, 12324, 12325, 12326, 12327, 12328, 12329, 12330, 12331, 12332, 12333, 12334, 12335, 12336, 12337, 12338, 12339, 12340, 12343, 12342, 12341, 12345, 12346, 12347, 12348, 12349, 12350, 12351, 12352, 12354};
    public static final String[] EGL_ATTRIBUTE_NAMES = {"EGL_BUFFER_SIZE", "EGL_ALPHA_SIZE", "EGL_BLUE_SIZE", "EGL_GREEN_SIZE", "EGL_RED_SIZE", "EGL_DEPTH_SIZE", "EGL_STENCIL_SIZE", "EGL_CONFIG_CAVEAT", "EGL_CONFIG_ID", "EGL_LEVEL", "EGL_MAX_PBUFFER_HEIGHT", "EGL_MAX_PBUFFER_PIXELS", "EGL_MAX_PBUFFER_WIDTH", "EGL_NATIVE_RENDERABLE", "EGL_NATIVE_VISUAL_ID", "EGL_NATIVE_VISUAL_TYPE", "EGL_PRESERVED_RESOURCES", "EGL_SAMPLES", "EGL_SAMPLE_BUFFERS", "EGL_SURFACE_TYPE", "EGL_TRANSPARENT_TYPE", "EGL_TRANSPARENT_RED_VALUE", "EGL_TRANSPARENT_GREEN_VALUE", "EGL_TRANSPARENT_BLUE_VALUE", "EGL_BIND_TO_TEXTURE_RGB", "EGL_BIND_TO_TEXTURE_RGBA", "EGL_MIN_SWAP_INTERVAL", "EGL_MAX_SWAP_INTERVAL", "EGL_LUMINANCE_SIZE", "EGL_ALPHA_MASK_SIZE", "EGL_COLOR_BUFFER_TYPE", "EGL_RENDERABLE_TYPE", "EGL_CONFORMANT"};

    public static class Watermark extends View {
        private final int BASE_ALPHA;
        private final int BASE_COLOR;
        private final int BASE_COLOR_SHADOW;
        private final int FADE_TIMER;
        private int m_fadeTimer;
        private String m_forTheLoveOfGodDontReleaseThisBuildText;
        private long m_lastTickTime;
        private Paint m_textPaint;

        public Watermark(Context context) {
            super(context);
            this.FADE_TIMER = 10000;
            this.BASE_COLOR = 16777215;
            this.BASE_COLOR_SHADOW = 0;
            this.BASE_ALPHA = 192;
            this.m_lastTickTime = Long.MAX_VALUE;
            this.m_fadeTimer = 10000;
            this.m_textPaint = null;
            this.m_forTheLoveOfGodDontReleaseThisBuildText = "DEV BUILD Not for sale or distribution";
        }

        @Override // android.view.View
        public void onDraw(Canvas canvas) {
        }
    }

    public static void log$16da05f7() {
    }

    public static void log$2d473e19() {
    }

    public static void log$552c4e01() {
    }

    public static void relDie(String str) {
        throw new RuntimeException("Post-sterilization FAILURE: " + str);
    }
}
