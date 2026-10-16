package com.openfeint.internal.vendor.com.google.api.client.escape;

/* JADX INFO: loaded from: classes.dex */
public abstract class UnicodeEscaper extends Escaper {
    private static char[] growBuffer(char[] cArr, int i, int i2) {
        char[] cArr2 = new char[i2];
        if (i > 0) {
            System.arraycopy(cArr, 0, cArr2, 0, i);
        }
        return cArr2;
    }

    protected abstract char[] escape(int i);

    protected final String escapeSlow(String str, int i) {
        int codePoint;
        int i2;
        int i3;
        int length = str.length();
        char[] cArrCharBufferFromThreadLocal = Platform.charBufferFromThreadLocal();
        int i4 = 0;
        int length2 = 0;
        while (i < length) {
            if (i >= length) {
                throw new IndexOutOfBoundsException("Index exceeds specified range");
            }
            int i5 = i + 1;
            char cCharAt = str.charAt(i);
            if (cCharAt >= 55296 && cCharAt <= 57343) {
                if (cCharAt > 56319) {
                    codePoint = cCharAt;
                    codePoint = cCharAt;
                    throw new IllegalArgumentException("Unexpected low surrogate character '" + cCharAt + "' with value " + ((int) cCharAt) + " at index " + (i5 - 1));
                }
                if (i5 == length) {
                    codePoint = -cCharAt;
                } else {
                    char cCharAt2 = str.charAt(i5);
                    if (!Character.isLowSurrogate(cCharAt2)) {
                        throw new IllegalArgumentException("Expected low surrogate but got char '" + cCharAt2 + "' with value " + ((int) cCharAt2) + " at index " + i5);
                    }
                    codePoint = Character.toCodePoint(cCharAt, cCharAt2);
                }
            }
            if (codePoint < 0) {
                throw new IllegalArgumentException("Trailing high surrogate at end of input");
            }
            char[] cArrEscape = escape(codePoint);
            int i6 = (Character.isSupplementaryCodePoint(codePoint) ? 2 : 1) + i;
            if (cArrEscape != null) {
                int i7 = i - i4;
                int length3 = length2 + i7 + cArrEscape.length;
                if (cArrCharBufferFromThreadLocal.length < length3) {
                    cArrCharBufferFromThreadLocal = growBuffer(cArrCharBufferFromThreadLocal, length2, length3 + (length - i) + 32);
                }
                if (i7 > 0) {
                    str.getChars(i4, i, cArrCharBufferFromThreadLocal, length2);
                    length2 += i7;
                }
                if (cArrEscape.length > 0) {
                    System.arraycopy(cArrEscape, 0, cArrCharBufferFromThreadLocal, length2, cArrEscape.length);
                    length2 += cArrEscape.length;
                }
                i2 = length2;
                i3 = i6;
            } else {
                int i8 = i4;
                i2 = length2;
                i3 = i8;
            }
            i = nextEscapeIndex(str, i6, length);
            int i9 = i3;
            length2 = i2;
            i4 = i9;
        }
        int i10 = length - i4;
        if (i10 > 0) {
            int i11 = i10 + length2;
            if (cArrCharBufferFromThreadLocal.length < i11) {
                cArrCharBufferFromThreadLocal = growBuffer(cArrCharBufferFromThreadLocal, length2, i11);
            }
            str.getChars(i4, length, cArrCharBufferFromThreadLocal, length2);
            length2 = i11;
        }
        return new String(cArrCharBufferFromThreadLocal, 0, length2);
    }

    protected abstract int nextEscapeIndex(CharSequence charSequence, int i, int i2);
}
