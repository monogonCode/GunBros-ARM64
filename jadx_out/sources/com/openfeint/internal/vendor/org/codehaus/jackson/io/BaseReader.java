package com.openfeint.internal.vendor.org.codehaus.jackson.io;

import java.io.IOException;
import java.io.InputStream;
import java.io.Reader;

/* JADX INFO: loaded from: classes.dex */
abstract class BaseReader extends Reader {
    protected byte[] mBuffer;
    protected final IOContext mContext;
    protected InputStream mIn;
    protected int mLength;
    protected int mPtr;
    char[] mTmpBuf = null;

    protected BaseReader(IOContext iOContext, InputStream inputStream, byte[] bArr, int i, int i2) {
        this.mContext = iOContext;
        this.mIn = inputStream;
        this.mBuffer = bArr;
        this.mPtr = i;
        this.mLength = i2;
    }

    protected static void reportStrangeStream() throws IOException {
        throw new IOException("Strange I/O stream, returned 0 bytes on read");
    }

    @Override // java.io.Reader, java.io.Closeable, java.lang.AutoCloseable
    public void close() throws IOException {
        InputStream inputStream = this.mIn;
        if (inputStream != null) {
            this.mIn = null;
            freeBuffers();
            inputStream.close();
        }
    }

    public final void freeBuffers() {
        byte[] bArr = this.mBuffer;
        if (bArr != null) {
            this.mBuffer = null;
            this.mContext.releaseReadIOBuffer(bArr);
        }
    }

    @Override // java.io.Reader
    public int read() throws IOException {
        if (this.mTmpBuf == null) {
            this.mTmpBuf = new char[1];
        }
        if (read(this.mTmpBuf, 0, 1) <= 0) {
            return -1;
        }
        return this.mTmpBuf[0];
    }
}
