package com.glu.platform.android;

import android.os.Environment;
import java.io.File;

/* JADX INFO: loaded from: classes.dex */
public final class GluUtil {
    private static String filePathNoEnder(String str) {
        if (str == null || str.equals("")) {
            return ".";
        }
        String strSubstring = str.endsWith("/") ? str.substring(0, str.length() - 1) : str;
        return (strSubstring == null || strSubstring.equals("")) ? "." : strSubstring;
    }

    public static File findMediaResourceFile(String str) {
        String str2;
        StringBuilder sb = new StringBuilder();
        GluApplication gluApplication = GluApplication.instance;
        if (gluApplication == null) {
            str2 = "null";
        } else {
            str2 = filePathNoEnder(gluApplication.getDir("save", 0).getAbsolutePath()) + "/";
        }
        File file = new File(sb.append(str2).append(str).toString());
        if (file.exists()) {
            return file;
        }
        String str3 = filePathNoEnder(Environment.getExternalStorageDirectory().getAbsolutePath()) + "/Android/data/" + GluApplication.instance.getPackageName() + "/files/";
        File file2 = new File(str3 + "/" + str);
        if (file2.exists()) {
            return file2;
        }
        File file3 = new File(replaceAllNotRegex(str3, "/sdcard/", "/sdcard/sd/") + "/" + str);
        if (file3.exists()) {
            return file3;
        }
        return null;
    }

    private static String replaceAllNotRegex(String str, String str2, String str3) {
        int length = 0;
        while (true) {
            int iIndexOf = str.indexOf(str2, length);
            if (iIndexOf == -1) {
                return str;
            }
            str = str.replace(str2, str3);
            length = iIndexOf + str3.length();
        }
    }
}
