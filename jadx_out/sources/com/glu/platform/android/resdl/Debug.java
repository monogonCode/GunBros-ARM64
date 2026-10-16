package com.glu.platform.android.resdl;

import android.os.StatFs;
import android.util.Log;
import java.io.File;
import java.util.List;
import java.util.Map;

/* JADX INFO: loaded from: classes.dex */
public final class Debug {
    public static boolean DEBUG = false;
    private static File m_debugFile = null;
    public static char[] rawLine = new char[80];

    public static void devDie(String str) {
        if (DEBUG) {
            throw new RuntimeException(str);
        }
        Log.e("GluGame", "SERIOUS ISSUE: " + str);
    }

    public static void log(String str) {
        if (DEBUG) {
            Log.i("GluGame", str);
            String str2 = "GluGame: " + str;
        }
    }

    public static void log(String str, Throwable th) {
        if (DEBUG) {
            Log.i("GluGame", str + " " + th);
            String str2 = "GluGame: " + str + " " + th;
            th.printStackTrace();
        }
    }

    public static void printMapListStringProperties(String str, Map<String, List<String>> map) {
        String str2;
        if (DEBUG) {
            Object[] array = map.keySet().toArray();
            Object[] array2 = map.values().toArray();
            log(str + "... Keys length: " + array.length + "   Values length: " + array2.length);
            for (int i = 0; i < array.length && i < array2.length; i++) {
                List list = (List) array2[i];
                StringBuilder sbAppend = new StringBuilder().append("map[" + i + "]: ");
                if (i >= array.length) {
                    str2 = "OUTOFRANGE";
                } else if (array[i] == null) {
                    str2 = "NULL";
                } else {
                    str2 = array[i] instanceof String ? (String) array[i] : "NOTSTRING";
                }
                String str3 = sbAppend.append(str2).toString() + " : ";
                int i2 = 0;
                while (i2 < list.size()) {
                    String str4 = str3 + (i2 == 0 ? "" : " ~ ") + ((String) list.get(i2));
                    i2++;
                    str3 = str4;
                }
                log(str3);
            }
        }
    }

    public static void printStatFs(String str, StatFs statFs) {
        if (DEBUG) {
            log(str + ": blocksAvail=" + statFs.getAvailableBlocks() + " blockCount=" + statFs.getBlockCount() + " blockSize=" + statFs.getBlockSize() + " freeBlocks(donotuse)=" + statFs.getFreeBlocks());
        }
    }
}
