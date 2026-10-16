package com.openfeint.internal.vendor.org.apache.commons.codec.binary;

/* JADX INFO: loaded from: classes.dex */
public final class Base64 {
    private byte[] buffer;
    private int currentLinePos;
    private final int decodeSize;
    private final int encodeSize;
    private final byte[] encodeTable;
    private boolean eof;
    private final int lineLength;
    private final byte[] lineSeparator;
    private int modulus;
    private int pos;
    private int readPos;
    private int x;
    static final byte[] CHUNK_SEPARATOR = {13, 10};
    private static final byte[] STANDARD_ENCODE_TABLE = {65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 43, 47};
    private static final byte[] URL_SAFE_ENCODE_TABLE = {65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 45, 95};
    private static final byte[] DECODE_TABLE = {-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 62, -1, 62, -1, 63, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, -1, -1, -1, -1, -1, -1, -1, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, -1, -1, -1, -1, 63, -1, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51};

    private Base64() {
        this(76, CHUNK_SEPARATOR);
    }

    private Base64(int i, byte[] bArr) {
        if (bArr == null) {
            bArr = CHUNK_SEPARATOR;
            i = 0;
        }
        this.lineLength = i > 0 ? (i / 4) * 4 : 0;
        this.lineSeparator = new byte[bArr.length];
        System.arraycopy(bArr, 0, this.lineSeparator, 0, bArr.length);
        if (i > 0) {
            this.encodeSize = bArr.length + 4;
        } else {
            this.encodeSize = 4;
        }
        this.decodeSize = this.encodeSize - 1;
        if (containsBase64Byte(bArr)) {
            throw new IllegalArgumentException("lineSeperator must not contain base64 characters: [" + StringUtils.newString(bArr, "UTF-8") + "]");
        }
        this.encodeTable = STANDARD_ENCODE_TABLE;
    }

    private static boolean containsBase64Byte(byte[] bArr) {
        for (int i = 0; i < bArr.length; i++) {
            byte b = bArr[i];
            if (b == 61 || (b >= 0 && b < DECODE_TABLE.length && DECODE_TABLE[b] != -1)) {
                return true;
            }
        }
        return false;
    }

    private void encode(byte[] bArr, int i, int i2) {
        if (this.eof) {
            return;
        }
        if (i2 >= 0) {
            int i3 = 0;
            while (i3 < i2) {
                if (this.buffer == null || this.buffer.length - this.pos < this.encodeSize) {
                    resizeBuffer();
                }
                int i4 = this.modulus + 1;
                this.modulus = i4;
                this.modulus = i4 % 3;
                int i5 = i + 1;
                int i6 = bArr[i];
                if (i6 < 0) {
                    i6 += 256;
                }
                this.x = i6 + (this.x << 8);
                if (this.modulus == 0) {
                    byte[] bArr2 = this.buffer;
                    int i7 = this.pos;
                    this.pos = i7 + 1;
                    bArr2[i7] = this.encodeTable[(this.x >> 18) & 63];
                    byte[] bArr3 = this.buffer;
                    int i8 = this.pos;
                    this.pos = i8 + 1;
                    bArr3[i8] = this.encodeTable[(this.x >> 12) & 63];
                    byte[] bArr4 = this.buffer;
                    int i9 = this.pos;
                    this.pos = i9 + 1;
                    bArr4[i9] = this.encodeTable[(this.x >> 6) & 63];
                    byte[] bArr5 = this.buffer;
                    int i10 = this.pos;
                    this.pos = i10 + 1;
                    bArr5[i10] = this.encodeTable[this.x & 63];
                    this.currentLinePos += 4;
                    if (this.lineLength > 0 && this.lineLength <= this.currentLinePos) {
                        System.arraycopy(this.lineSeparator, 0, this.buffer, this.pos, this.lineSeparator.length);
                        this.pos += this.lineSeparator.length;
                        this.currentLinePos = 0;
                    }
                }
                i3++;
                i = i5;
            }
            return;
        }
        this.eof = true;
        if (this.buffer == null || this.buffer.length - this.pos < this.encodeSize) {
            resizeBuffer();
        }
        switch (this.modulus) {
            case 1:
                byte[] bArr6 = this.buffer;
                int i11 = this.pos;
                this.pos = i11 + 1;
                bArr6[i11] = this.encodeTable[(this.x >> 2) & 63];
                byte[] bArr7 = this.buffer;
                int i12 = this.pos;
                this.pos = i12 + 1;
                bArr7[i12] = this.encodeTable[(this.x << 4) & 63];
                if (this.encodeTable == STANDARD_ENCODE_TABLE) {
                    byte[] bArr8 = this.buffer;
                    int i13 = this.pos;
                    this.pos = i13 + 1;
                    bArr8[i13] = 61;
                    byte[] bArr9 = this.buffer;
                    int i14 = this.pos;
                    this.pos = i14 + 1;
                    bArr9[i14] = 61;
                }
                break;
            case 2:
                byte[] bArr10 = this.buffer;
                int i15 = this.pos;
                this.pos = i15 + 1;
                bArr10[i15] = this.encodeTable[(this.x >> 10) & 63];
                byte[] bArr11 = this.buffer;
                int i16 = this.pos;
                this.pos = i16 + 1;
                bArr11[i16] = this.encodeTable[(this.x >> 4) & 63];
                byte[] bArr12 = this.buffer;
                int i17 = this.pos;
                this.pos = i17 + 1;
                bArr12[i17] = this.encodeTable[(this.x << 2) & 63];
                if (this.encodeTable == STANDARD_ENCODE_TABLE) {
                    byte[] bArr13 = this.buffer;
                    int i18 = this.pos;
                    this.pos = i18 + 1;
                    bArr13[i18] = 61;
                }
                break;
        }
        if (this.lineLength <= 0 || this.pos <= 0) {
            return;
        }
        System.arraycopy(this.lineSeparator, 0, this.buffer, this.pos, this.lineSeparator.length);
        this.pos += this.lineSeparator.length;
    }

    /* JADX WARN: Code duplicated, block: B:29:0x009e  */
    public static byte[] encodeBase64(byte[] bArr) {
        byte[] bArr2;
        if (bArr == null || bArr.length == 0) {
            return bArr;
        }
        long encodeLength = getEncodeLength(bArr, 76, CHUNK_SEPARATOR);
        if (encodeLength > 2147483647L) {
            throw new IllegalArgumentException("Input array too big, the output array would be bigger (" + encodeLength + ") than the specified maxium size of 2147483647");
        }
        Base64 base64 = new Base64(0, CHUNK_SEPARATOR);
        base64.buffer = null;
        base64.pos = 0;
        base64.readPos = 0;
        base64.currentLinePos = 0;
        base64.modulus = 0;
        base64.eof = false;
        if (bArr == null || bArr.length == 0) {
            return bArr;
        }
        byte[] bArr3 = new byte[(int) getEncodeLength(bArr, base64.lineLength, base64.lineSeparator)];
        if (bArr3.length == bArr3.length) {
            base64.buffer = bArr3;
            base64.pos = 0;
            base64.readPos = 0;
        }
        base64.encode(bArr, 0, bArr.length);
        base64.encode(bArr, 0, -1);
        if (base64.buffer != bArr3) {
            int length = bArr3.length;
            if (base64.buffer != null) {
                int iMin = Math.min(base64.buffer != null ? base64.pos - base64.readPos : 0, length);
                if (base64.buffer != bArr3) {
                    System.arraycopy(base64.buffer, base64.readPos, bArr3, 0, iMin);
                    base64.readPos = iMin + base64.readPos;
                    if (base64.readPos >= base64.pos) {
                        base64.buffer = null;
                    }
                } else {
                    base64.buffer = null;
                }
            } else {
                boolean z = base64.eof;
            }
        }
        if (!(base64.encodeTable == URL_SAFE_ENCODE_TABLE) || base64.pos >= bArr3.length) {
            bArr2 = bArr3;
        } else {
            bArr2 = new byte[base64.pos];
            System.arraycopy(bArr3, 0, bArr2, 0, base64.pos);
        }
        return bArr2;
    }

    private static long getEncodeLength(byte[] bArr, int i, byte[] bArr2) {
        int i2 = (i / 4) * 4;
        long length = (bArr.length * 4) / 3;
        long j = length % 4;
        if (j != 0) {
            length += 4 - j;
        }
        if (i2 > 0) {
            boolean z = length % ((long) i2) == 0;
            length += (length / ((long) i2)) * ((long) bArr2.length);
            if (!z) {
                return length + ((long) bArr2.length);
            }
        }
        return length;
    }

    private void resizeBuffer() {
        if (this.buffer == null) {
            this.buffer = new byte[8192];
            this.pos = 0;
            this.readPos = 0;
        } else {
            byte[] bArr = new byte[this.buffer.length * 2];
            System.arraycopy(this.buffer, 0, bArr, 0, this.buffer.length);
            this.buffer = bArr;
        }
    }
}
