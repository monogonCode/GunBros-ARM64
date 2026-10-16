package com.glu.googleiap;

/* JADX INFO: loaded from: classes.dex */
public class Base64 {
    static final /* synthetic */ boolean $assertionsDisabled;
    private static final byte[] ALPHABET;
    private static final byte[] DECODABET;
    private static final byte[] WEBSAFE_ALPHABET;
    private static final byte[] WEBSAFE_DECODABET;

    static {
        $assertionsDisabled = !Base64.class.desiredAssertionStatus();
        ALPHABET = new byte[]{65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 43, 47};
        WEBSAFE_ALPHABET = new byte[]{65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 45, 95};
        DECODABET = new byte[]{-9, -9, -9, -9, -9, -9, -9, -9, -9, -5, -5, -9, -9, -5, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -5, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, 62, -9, -9, -9, 63, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, -9, -9, -9, -1, -9, -9, -9, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, -9, -9, -9, -9, -9, -9, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, -9, -9, -9, -9, -9};
        WEBSAFE_DECODABET = new byte[]{-9, -9, -9, -9, -9, -9, -9, -9, -9, -5, -5, -9, -9, -5, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -5, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, 62, -9, -9, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, -9, -9, -9, -1, -9, -9, -9, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, -9, -9, -9, -9, 63, -9, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, -9, -9, -9, -9, -9};
    }

    private Base64() {
    }

    public static byte[] decode(String str) throws Base64DecoderException {
        int i;
        int iDecode4to3$355785af;
        byte[] bytes = str.getBytes();
        int length = bytes.length;
        byte[] bArr = DECODABET;
        byte[] bArr2 = new byte[((length * 3) / 4) + 2];
        byte[] bArr3 = new byte[4];
        int i2 = 0;
        int i3 = 0;
        int iDecode4to3$355785af2 = 0;
        while (i2 < length) {
            byte b = (byte) (bytes[i2 + 0] & 127);
            byte b2 = bArr[b];
            if (b2 < -5) {
                throw new Base64DecoderException("Bad Base64 input character at " + i2 + ": " + ((int) bytes[i2 + 0]) + "(decimal)");
            }
            if (b2 < -1) {
                i = i3;
                iDecode4to3$355785af = iDecode4to3$355785af2;
            } else {
                if (b == 61) {
                    int i4 = length - i2;
                    byte b3 = (byte) (bytes[(length - 1) + 0] & 127);
                    if (i3 == 0 || i3 == 1) {
                        throw new Base64DecoderException("invalid padding byte '=' at byte offset " + i2);
                    }
                    if ((i3 == 3 && i4 > 2) || (i3 == 4 && i4 > 1)) {
                        throw new Base64DecoderException("padding byte '=' falsely signals end of encoded value at offset " + i2);
                    }
                    if (b3 != 61 && b3 != 10) {
                        throw new Base64DecoderException("encoded value has invalid trailing byte");
                    }
                    break;
                    break;
                }
                i = i3 + 1;
                bArr3[i3] = b;
                if (i == 4) {
                    iDecode4to3$355785af = decode4to3$355785af(bArr3, bArr2, iDecode4to3$355785af2, bArr) + iDecode4to3$355785af2;
                    i = 0;
                } else {
                    iDecode4to3$355785af = iDecode4to3$355785af2;
                }
            }
            i2++;
            iDecode4to3$355785af2 = iDecode4to3$355785af;
            i3 = i;
        }
        if (i3 != 0) {
            if (i3 == 1) {
                throw new Base64DecoderException("single trailing character at offset " + (length - 1));
            }
            bArr3[i3] = 61;
            iDecode4to3$355785af2 += decode4to3$355785af(bArr3, bArr2, iDecode4to3$355785af2, bArr);
        }
        byte[] bArr4 = new byte[iDecode4to3$355785af2];
        System.arraycopy(bArr2, 0, bArr4, 0, iDecode4to3$355785af2);
        return bArr4;
    }

    private static int decode4to3$355785af(byte[] bArr, byte[] bArr2, int i, byte[] bArr3) {
        if (bArr[2] == 61) {
            bArr2[i] = (byte) ((((bArr3[bArr[0]] << 24) >>> 6) | ((bArr3[bArr[1]] << 24) >>> 12)) >>> 16);
            return 1;
        }
        if (bArr[3] == 61) {
            int i2 = ((bArr3[bArr[1]] << 24) >>> 12) | ((bArr3[bArr[0]] << 24) >>> 6) | ((bArr3[bArr[2]] << 24) >>> 18);
            bArr2[i] = (byte) (i2 >>> 16);
            bArr2[i + 1] = (byte) (i2 >>> 8);
            return 2;
        }
        int i3 = ((bArr3[bArr[1]] << 24) >>> 12) | ((bArr3[bArr[0]] << 24) >>> 6) | ((bArr3[bArr[2]] << 24) >>> 18) | ((bArr3[bArr[3]] << 24) >>> 24);
        bArr2[i] = (byte) (i3 >> 16);
        bArr2[i + 1] = (byte) (i3 >> 8);
        bArr2[i + 2] = (byte) i3;
        return 3;
    }
}
