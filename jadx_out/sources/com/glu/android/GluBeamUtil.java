package com.glu.android;

import android.os.Bundle;

/* JADX INFO: loaded from: classes.dex */
public final class GluBeamUtil {
    public static char[] rawLine = new char[80];

    private static String getIntHexNice(int i) {
        String hexString = Integer.toHexString(i);
        while (hexString.length() < 8) {
            hexString = "0" + hexString;
        }
        return "0x" + hexString;
    }

    private static String getMiniHexValue(int i) {
        return (i <= 9 ? (char) (i + 48) : (char) ((i - 10) + 65)) + "";
    }

    public static void printBundle(Bundle bundle) {
        if (bundle == null) {
            return;
        }
        for (String str : bundle.keySet()) {
            try {
                if (!(bundle.get(str) instanceof String)) {
                    throw new Exception();
                }
                GluBeam.log(str + " = " + bundle.getString(str));
            } catch (Exception e) {
                Object obj = bundle.get(str);
                GluBeam.log(str + " = " + (obj == null ? "[NULL]" : obj.getClass().getCanonicalName()));
            }
        }
    }

    public static void printHexDump(String str, byte[] bArr) {
        int length = bArr.length;
        if (length != 0) {
            StringBuilder sbAppend = new StringBuilder().append("Printing hex dump... ");
            if (str == null) {
                str = "";
            }
            GluBeam.log(sbAppend.append(str).toString());
            for (int i = 0; i < length; i += 16) {
                String string = getIntHexNice(i) + "   ";
                for (int i2 = i; i2 < i + 16; i2++) {
                    if (i2 < length) {
                        StringBuilder sbAppend2 = new StringBuilder().append(string);
                        int i3 = bArr[i2];
                        if (i3 < 0) {
                            i3 += 256;
                        }
                        string = sbAppend2.append(getMiniHexValue(i3 >> 4) + getMiniHexValue(i3 & 15)).append(" ").toString();
                    } else {
                        string = string + "   ";
                    }
                }
                String string2 = string + "   ";
                for (int i4 = i; i4 < i + 16; i4++) {
                    if (i4 < length) {
                        StringBuilder sbAppend3 = new StringBuilder().append(string2);
                        int i5 = bArr[i4];
                        string2 = sbAppend3.append((i5 < 32 || i5 > 127) ? "." : ((char) i5) + "").toString();
                    }
                }
                GluBeam.log(string2);
            }
        }
    }
}
