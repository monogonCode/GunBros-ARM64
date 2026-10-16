package com.openfeint.internal.logcat;

import android.util.Log;

/* JADX INFO: loaded from: classes.dex */
public final class OFLog {
    public static int LEVEL = 4;

    public static void d(String str, String str2) {
        if (LEVEL <= 3) {
            StringBuilder sbAppend = new StringBuilder().append(str).append(':');
            if (str2 == null) {
                str2 = "(null)";
            }
            Log.d("Openfeint", sbAppend.append(str2).toString());
        }
    }

    public static void e(String str, String str2) {
        if (LEVEL <= 6) {
            StringBuilder sbAppend = new StringBuilder().append(str).append(':');
            if (str2 == null) {
                str2 = "(null)";
            }
            Log.e("Openfeint", sbAppend.append(str2).toString());
        }
    }

    public static void i(String str, String str2) {
        if (LEVEL <= 4) {
            StringBuilder sbAppend = new StringBuilder().append(str).append(':');
            if (str2 == null) {
                str2 = "(null)";
            }
            Log.i("Openfeint", sbAppend.append(str2).toString());
        }
    }

    public static void v(String str, String str2) {
        if (LEVEL <= 2) {
            StringBuilder sbAppend = new StringBuilder().append(str).append(':');
            if (str2 == null) {
                str2 = "(null)";
            }
            Log.v("Openfeint", sbAppend.append(str2).toString());
        }
    }

    public static void w(String str, String str2) {
        if (LEVEL <= 5) {
            StringBuilder sbAppend = new StringBuilder().append(str).append(':');
            if (str2 == null) {
                str2 = "(null)";
            }
            Log.w("Openfeint", sbAppend.append(str2).toString());
        }
    }

    public static boolean willLog$134632() {
        return LEVEL <= 3;
    }
}
