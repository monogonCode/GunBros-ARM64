package com.tapjoy;

import android.util.Log;

/* JADX INFO: loaded from: classes.dex */
public class TapjoyLog {
    private static boolean showLog = false;

    public static void d(String str, String str2) {
        if (showLog) {
            Log.d(str, str2);
        }
    }

    public static void e(String str, String str2) {
        if (showLog) {
            Log.e(str, str2);
        }
    }

    public static void enableLogging(boolean z) {
        Log.i("TapjoyLog", "enableLogging: " + z);
        showLog = z;
    }

    public static void i(String str, String str2) {
        if (showLog) {
            Log.i(str, str2);
        }
    }

    public static void v(String str, String str2) {
        if (showLog) {
            Log.v(str, str2);
        }
    }

    public static void w(String str, String str2) {
        if (showLog) {
            Log.w(str, str2);
        }
    }
}
