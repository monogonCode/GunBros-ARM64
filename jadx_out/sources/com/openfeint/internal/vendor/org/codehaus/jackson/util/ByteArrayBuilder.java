package com.openfeint.internal.vendor.org.codehaus.jackson.util;

import java.io.IOException;
import java.io.OutputStream;
import java.util.LinkedList;

/* JADX INFO: loaded from: classes.dex */
public final class ByteArrayBuilder extends OutputStream {
    private static final byte[] NO_BYTES = new byte[0];
    private int _currBlockPtr;
    private int _pastLen;
    private final LinkedList<byte[]> _pastBlocks = new LinkedList<>();
    private final BufferRecycler _bufferRecycler = null;
    private byte[] _currBlock = new byte[500];

    private ByteArrayBuilder() {
    }

    private void _allocMore() {
        this._pastLen += this._currBlock.length;
        int iMax = Math.max(this._pastLen >> 1, 1000);
        int i = iMax <= 262144 ? iMax : 262144;
        this._pastBlocks.add(this._currBlock);
        this._currBlock = new byte[i];
        this._currBlockPtr = 0;
    }

    @Override // java.io.OutputStream, java.io.Closeable, java.lang.AutoCloseable
    public final void close() {
    }

    @Override // java.io.OutputStream, java.io.Flushable
    public final void flush() {
    }

    @Override // java.io.OutputStream
    public final void write(int i) throws IOException {
        byte b = (byte) i;
        if (this._currBlockPtr >= this._currBlock.length) {
            _allocMore();
        }
        byte[] bArr = this._currBlock;
        int i2 = this._currBlockPtr;
        this._currBlockPtr = i2 + 1;
        bArr[i2] = b;
    }

    @Override // java.io.OutputStream
    public final void write(byte[] bArr) {
        write(bArr, 0, bArr.length);
    }

    @Override // java.io.OutputStream
    public final void write(byte[] bArr, int i, int i2) {
        while (true) {
            int iMin = Math.min(this._currBlock.length - this._currBlockPtr, i2);
            if (iMin > 0) {
                System.arraycopy(bArr, i, this._currBlock, this._currBlockPtr, iMin);
                i += iMin;
                this._currBlockPtr += iMin;
                i2 -= iMin;
            }
            if (i2 <= 0) {
                return;
            } else {
                _allocMore();
            }
        }
    }
}
