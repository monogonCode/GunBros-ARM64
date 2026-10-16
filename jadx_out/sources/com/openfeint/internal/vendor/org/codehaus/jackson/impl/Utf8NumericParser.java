package com.openfeint.internal.vendor.org.codehaus.jackson.impl;

import com.openfeint.internal.vendor.org.codehaus.jackson.JsonToken;
import com.openfeint.internal.vendor.org.codehaus.jackson.io.IOContext;
import java.io.IOException;
import java.io.InputStream;

/* JADX INFO: loaded from: classes.dex */
public abstract class Utf8NumericParser extends StreamBasedParserBase {
    public Utf8NumericParser(IOContext iOContext, int i, InputStream inputStream, byte[] bArr, int i2, int i3, boolean z) {
        super(iOContext, i, inputStream, bArr, i2, i3, z);
    }

    protected final JsonToken parseNumberText(int i) throws IOException {
        int i2;
        boolean z;
        int i3;
        int i4;
        int i5;
        int i6;
        int i7;
        int i8;
        boolean z2;
        int i9;
        int i10;
        int i11;
        int i12;
        boolean z3;
        int i13;
        int i14 = 0;
        char[] cArrEmptyAndGetCurrentSegment = this._textBuffer.emptyAndGetCurrentSegment();
        boolean z4 = i == 45;
        if (z4) {
            cArrEmptyAndGetCurrentSegment[0] = '-';
            if (this._inputPtr >= this._inputEnd) {
                loadMoreGuaranteed();
            }
            byte[] bArr = this._inputBuffer;
            int i15 = this._inputPtr;
            this._inputPtr = i15 + 1;
            i = bArr[i15] & 255;
            i2 = 1;
        } else {
            i2 = 0;
        }
        int i16 = 0;
        int i17 = i;
        while (true) {
            if (i17 >= 48 && i17 <= 57) {
                i16++;
                if (i16 == 2 && cArrEmptyAndGetCurrentSegment[i2 - 1] == '0') {
                    reportInvalidNumber("Leading zeroes not allowed");
                }
                if (i2 >= cArrEmptyAndGetCurrentSegment.length) {
                    cArrEmptyAndGetCurrentSegment = this._textBuffer.finishCurrentSegment();
                    i2 = 0;
                }
                i4 = i2 + 1;
                cArrEmptyAndGetCurrentSegment[i2] = (char) i17;
                if (this._inputPtr >= this._inputEnd && !loadMore()) {
                    z = true;
                    i3 = i16;
                    i5 = 0;
                    break;
                }
                byte[] bArr2 = this._inputBuffer;
                int i18 = this._inputPtr;
                this._inputPtr = i18 + 1;
                i17 = bArr2[i18] & 255;
                i2 = i4;
            } else {
                z = false;
                i3 = i16;
                i4 = i2;
                i5 = i17;
                break;
            }
        }
        if (i3 == 0) {
            reportInvalidNumber("Missing integer part (next char " + _getCharDesc(i5) + ")");
        }
        if (i5 == 46) {
            int i19 = i4 + 1;
            cArrEmptyAndGetCurrentSegment[i4] = (char) i5;
            int i20 = i5;
            char[] cArrFinishCurrentSegment = cArrEmptyAndGetCurrentSegment;
            int i21 = i19;
            int i22 = 0;
            while (true) {
                if (this._inputPtr >= this._inputEnd && !loadMore()) {
                    i8 = i20;
                    z2 = true;
                    break;
                }
                byte[] bArr3 = this._inputBuffer;
                int i23 = this._inputPtr;
                this._inputPtr = i23 + 1;
                i20 = bArr3[i23] & 255;
                if (i20 < 48 || i20 > 57) {
                    i8 = i20;
                    z2 = z;
                    break;
                }
                i22++;
                if (i21 >= cArrFinishCurrentSegment.length) {
                    cArrFinishCurrentSegment = this._textBuffer.finishCurrentSegment();
                    i13 = 0;
                } else {
                    i13 = i21;
                }
                i21 = i13 + 1;
                cArrFinishCurrentSegment[i13] = (char) i20;
            }
            if (i22 == 0) {
                reportUnexpectedNumberChar(i8, "Decimal point not followed by a digit");
            }
            i6 = i22;
            i7 = i21;
            cArrEmptyAndGetCurrentSegment = cArrFinishCurrentSegment;
        } else {
            i6 = 0;
            i7 = i4;
            i8 = i5;
            z2 = z;
        }
        if (i8 == 101 || i8 == 69) {
            if (i7 >= cArrEmptyAndGetCurrentSegment.length) {
                cArrEmptyAndGetCurrentSegment = this._textBuffer.finishCurrentSegment();
                i7 = 0;
            }
            int i24 = i7 + 1;
            cArrEmptyAndGetCurrentSegment[i7] = (char) i8;
            if (this._inputPtr >= this._inputEnd) {
                loadMoreGuaranteed();
            }
            byte[] bArr4 = this._inputBuffer;
            int i25 = this._inputPtr;
            this._inputPtr = i25 + 1;
            int i26 = bArr4[i25] & 255;
            if (i26 == 45 || i26 == 43) {
                if (i24 >= cArrEmptyAndGetCurrentSegment.length) {
                    cArrEmptyAndGetCurrentSegment = this._textBuffer.finishCurrentSegment();
                    i9 = 0;
                } else {
                    i9 = i24;
                }
                int i27 = i9 + 1;
                cArrEmptyAndGetCurrentSegment[i9] = (char) i26;
                if (this._inputPtr >= this._inputEnd) {
                    loadMoreGuaranteed();
                }
                byte[] bArr5 = this._inputBuffer;
                int i28 = this._inputPtr;
                this._inputPtr = i28 + 1;
                i10 = bArr5[i28] & 255;
                i11 = i27;
            } else {
                i11 = i24;
                i10 = i26;
            }
            while (true) {
                if (i10 <= 57 && i10 >= 48) {
                    i14++;
                    if (i11 >= cArrEmptyAndGetCurrentSegment.length) {
                        cArrEmptyAndGetCurrentSegment = this._textBuffer.finishCurrentSegment();
                        i11 = 0;
                    }
                    int i29 = i11 + 1;
                    cArrEmptyAndGetCurrentSegment[i11] = (char) i10;
                    if (this._inputPtr >= this._inputEnd && !loadMore()) {
                        i14 = i14;
                        z3 = true;
                        i12 = i29;
                        break;
                    }
                    byte[] bArr6 = this._inputBuffer;
                    int i30 = this._inputPtr;
                    this._inputPtr = i30 + 1;
                    i10 = bArr6[i30] & 255;
                    i11 = i29;
                } else {
                    i14 = i14;
                    i12 = i11;
                    z3 = z2;
                    break;
                }
            }
            if (i14 == 0) {
                reportUnexpectedNumberChar(i10, "Exponent indicator not followed by a digit");
            }
        } else {
            i12 = i7;
            z3 = z2;
        }
        if (!z3) {
            this._inputPtr--;
        }
        this._textBuffer.setCurrentLength(i12);
        return reset(z4, i3, i6, i14);
    }
}
