package com.openfeint.internal.vendor.org.codehaus.jackson.io;

import java.io.IOException;
import java.io.InputStream;

/* JADX INFO: loaded from: classes.dex */
public final class MergedStream extends InputStream {
    byte[] _buffer;
    protected final IOContext _context;
    final int _end;
    final InputStream _in;
    int _ptr;

    public MergedStream(IOContext iOContext, InputStream inputStream, byte[] bArr, int i, int i2) {
        this._context = iOContext;
        this._in = inputStream;
        this._buffer = bArr;
        this._ptr = i;
        this._end = i2;
    }

    private void freeMergedBuffer() {
        byte[] bArr = this._buffer;
        if (bArr != null) {
            this._buffer = null;
            this._context.releaseReadIOBuffer(bArr);
        }
    }

    @Override // java.io.InputStream
    public final int available() throws IOException {
        return this._buffer != null ? this._end - this._ptr : this._in.available();
    }

    @Override // java.io.InputStream, java.io.Closeable, java.lang.AutoCloseable
    public final void close() throws IOException {
        freeMergedBuffer();
        this._in.close();
    }

    @Override // java.io.InputStream
    public final void mark(int i) {
        if (this._buffer == null) {
            this._in.mark(i);
        }
    }

    @Override // java.io.InputStream
    public final boolean markSupported() {
        return this._buffer == null && this._in.markSupported();
    }

    @Override // java.io.InputStream
    public final int read() throws IOException {
        if (this._buffer == null) {
            return this._in.read();
        }
        byte[] bArr = this._buffer;
        int i = this._ptr;
        this._ptr = i + 1;
        int i2 = bArr[i] & 255;
        if (this._ptr < this._end) {
            return i2;
        }
        freeMergedBuffer();
        return i2;
    }

    @Override // java.io.InputStream
    public final int read(byte[] bArr) throws IOException {
        return read(bArr, 0, bArr.length);
    }

    @Override // java.io.InputStream
    public final int read(byte[] bArr, int i, int i2) throws IOException {
        if (this._buffer == null) {
            return this._in.read(bArr, i, i2);
        }
        int i3 = this._end - this._ptr;
        if (i2 > i3) {
            i2 = i3;
        }
        System.arraycopy(this._buffer, this._ptr, bArr, i, i2);
        this._ptr += i2;
        if (this._ptr < this._end) {
            return i2;
        }
        freeMergedBuffer();
        return i2;
    }

    @Override // java.io.InputStream
    public final void reset() throws IOException {
        if (this._buffer == null) {
            this._in.reset();
        }
    }

    @Override // java.io.InputStream
    public final long skip(long j) throws IOException {
        long jSkip;
        if (this._buffer != null) {
            int i = this._end - this._ptr;
            if (i > j) {
                this._ptr += (int) j;
                return j;
            }
            freeMergedBuffer();
            jSkip = ((long) i) + 0;
            j -= (long) i;
        } else {
            jSkip = 0;
        }
        if (j > 0) {
            jSkip += this._in.skip(j);
        }
        return jSkip;
    }
}
