package com.openfeint.internal.vendor.org.codehaus.jackson.io;

import java.io.CharConversionException;
import java.io.IOException;
import java.io.InputStream;

/* JADX INFO: loaded from: classes.dex */
public final class UTF32Reader extends BaseReader {
    final boolean mBigEndian;
    int mByteCount;
    int mCharCount;
    char mSurrogate;

    public UTF32Reader(IOContext iOContext, InputStream inputStream, byte[] bArr, int i, int i2, boolean z) {
        super(iOContext, inputStream, bArr, i, i2);
        this.mSurrogate = (char) 0;
        this.mCharCount = 0;
        this.mByteCount = 0;
        this.mBigEndian = z;
    }

    private boolean loadMore(int i) throws IOException {
        this.mByteCount += this.mLength - i;
        if (i > 0) {
            if (this.mPtr > 0) {
                for (int i2 = 0; i2 < i; i2++) {
                    this.mBuffer[i2] = this.mBuffer[this.mPtr + i2];
                }
                this.mPtr = 0;
            }
            this.mLength = i;
        } else {
            this.mPtr = 0;
            int i3 = this.mIn.read(this.mBuffer);
            if (i3 <= 0) {
                this.mLength = 0;
                if (i3 < 0) {
                    freeBuffers();
                    return false;
                }
                reportStrangeStream();
            }
            this.mLength = i3;
        }
        while (this.mLength < 4) {
            int i4 = this.mIn.read(this.mBuffer, this.mLength, this.mBuffer.length - this.mLength);
            if (i4 <= 0) {
                if (i4 < 0) {
                    freeBuffers();
                    int i5 = this.mLength;
                    throw new CharConversionException("Unexpected EOF in the middle of a 4-byte UTF-32 char: got " + i5 + ", needed 4, at char #" + this.mCharCount + ", byte #" + (this.mByteCount + i5) + ")");
                }
                reportStrangeStream();
            }
            this.mLength = i4 + this.mLength;
        }
        return true;
    }

    @Override // com.openfeint.internal.vendor.org.codehaus.jackson.io.BaseReader, java.io.Reader, java.io.Closeable, java.lang.AutoCloseable
    public final /* bridge */ /* synthetic */ void close() throws IOException {
        super.close();
    }

    @Override // com.openfeint.internal.vendor.org.codehaus.jackson.io.BaseReader, java.io.Reader
    public final /* bridge */ /* synthetic */ int read() throws IOException {
        return super.read();
    }

    @Override // java.io.Reader
    public final int read(char[] cArr, int i, int i2) throws IOException {
        int i3;
        int i4;
        int i5;
        if (this.mBuffer == null) {
            return -1;
        }
        if (i2 <= 0) {
            return i2;
        }
        if (i < 0 || i + i2 > cArr.length) {
            throw new ArrayIndexOutOfBoundsException("read(buf," + i + "," + i2 + "), cbuf[" + cArr.length + "]");
        }
        int i6 = i2 + i;
        if (this.mSurrogate != 0) {
            i3 = i + 1;
            cArr[i] = this.mSurrogate;
            this.mSurrogate = (char) 0;
        } else {
            int i7 = this.mLength - this.mPtr;
            if (i7 < 4 && !loadMore(i7)) {
                return -1;
            }
            i3 = i;
        }
        while (i3 < i6) {
            int i8 = this.mPtr;
            if (this.mBigEndian) {
                i5 = (this.mBuffer[i8 + 3] & 255) | (this.mBuffer[i8] << 24) | ((this.mBuffer[i8 + 1] & 255) << 16) | ((this.mBuffer[i8 + 2] & 255) << 8);
            } else {
                i5 = (this.mBuffer[i8 + 3] << 24) | (this.mBuffer[i8] & 255) | ((this.mBuffer[i8 + 1] & 255) << 8) | ((this.mBuffer[i8 + 2] & 255) << 16);
            }
            this.mPtr += 4;
            if (i5 > 65535) {
                if (i5 > 1114111) {
                    int i9 = i3 - i;
                    throw new CharConversionException("Invalid UTF-32 character 0x" + Integer.toHexString(i5) + ("(above " + Integer.toHexString(1114111) + ") ") + " at char #" + (i9 + this.mCharCount) + ", byte #" + ((this.mByteCount + this.mPtr) - 1) + ")");
                }
                int i10 = i5 - 65536;
                i4 = i3 + 1;
                cArr[i3] = (char) (55296 + (i10 >> 10));
                i5 = (i10 & 1023) | 56320;
                if (i4 >= i6) {
                    this.mSurrogate = (char) i5;
                }
                int i11 = i4 - i;
                this.mCharCount += i11;
                return i11;
            }
            i4 = i3;
            i3 = i4 + 1;
            cArr[i4] = (char) i5;
            if (this.mPtr >= this.mLength) {
                break;
            }
        }
        i4 = i3;
        int i12 = i4 - i;
        this.mCharCount += i12;
        return i12;
    }
}
