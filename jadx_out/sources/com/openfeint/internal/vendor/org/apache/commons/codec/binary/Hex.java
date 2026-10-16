package com.openfeint.internal.vendor.org.apache.commons.codec.binary;

/* JADX INFO: loaded from: classes.dex */
public final class Hex {
    private static final char[] DIGITS_LOWER = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f'};
    private static final char[] DIGITS_UPPER = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F'};
    private final String charsetName = "UTF-8";

    public static char[] encodeHex(byte[] bArr) {
        int i = 0;
        char[] cArr = DIGITS_LOWER;
        int length = bArr.length;
        char[] cArr2 = new char[length << 1];
        for (int i2 = 0; i2 < length; i2++) {
            int i3 = i + 1;
            cArr2[i] = cArr[(bArr[i2] & 240) >>> 4];
            i = i3 + 1;
            cArr2[i3] = cArr[bArr[i2] & 15];
        }
        return cArr2;
    }

    public final String toString() {
        return super.toString() + "[charsetName=" + this.charsetName + "]";
    }
}
