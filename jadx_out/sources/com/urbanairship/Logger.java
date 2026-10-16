package com.urbanairship;

import android.util.Log;

/* JADX INFO: loaded from: classes.dex */
public class Logger {
    public static int logLevel = 6;
    public static String TAG = "UrbanAirship";

    private Logger() {
    }

    public static void debug(String str) {
        if (logLevel <= 3) {
            Log.d(TAG, str);
        }
    }

    public static void error(String str) {
        if (logLevel <= 6) {
            Log.e(TAG, str);
        }
    }

    public static void error(String str, Throwable th) {
        if (logLevel <= 6) {
            Log.e(TAG, str, th);
        }
    }

    public static void error(Throwable th) {
        if (logLevel <= 6) {
            Log.e(TAG, null, th);
        }
    }

    public static void info(String str) {
        if (logLevel <= 4) {
            Log.i(TAG, str);
        }
    }

    public static void info(String str, Throwable th) {
        if (logLevel <= 4) {
            Log.i(TAG, str, th);
        }
    }

    public static void verbose(String str) {
        if (logLevel <= 2) {
            Log.v(TAG, str);
        }
    }

    public static void warn(String str) {
        if (logLevel <= 5) {
            Log.w(TAG, str);
        }
    }

    public static void warn(String str, Throwable th) {
        if (logLevel <= 5) {
            Log.w(TAG, str, th);
        }
    }

    public static void warn(Throwable th) {
        if (logLevel <= 5) {
            Log.w(TAG, th);
        }
    }
}
