package com.openfeint.internal.vendor.org.codehaus.jackson.util;

/* JADX INFO: loaded from: classes.dex */
public final class BufferRecycler {
    protected final byte[][] mByteBuffers = new byte[ByteBufferType.values().length][];
    protected final char[][] mCharBuffers = new char[CharBufferType.values().length][];

    public enum ByteBufferType {
        READ_IO_BUFFER(4000),
        WRITE_ENCODING_BUFFER(4000),
        WRITE_CONCAT_BUFFER(2000);

        private final int size;

        ByteBufferType(int i) {
            this.size = i;
        }
    }

    public enum CharBufferType {
        TOKEN_BUFFER(2000),
        CONCAT_BUFFER(2000),
        TEXT_BUFFER(200),
        NAME_COPY_BUFFER(200);

        private final int size;

        CharBufferType(int i) {
            this.size = i;
        }
    }

    public final byte[] allocByteBuffer(ByteBufferType byteBufferType) {
        int iOrdinal = byteBufferType.ordinal();
        byte[] bArr = this.mByteBuffers[iOrdinal];
        if (bArr == null) {
            return new byte[byteBufferType.size];
        }
        this.mByteBuffers[iOrdinal] = null;
        return bArr;
    }

    public final char[] allocCharBuffer(CharBufferType charBufferType) {
        return allocCharBuffer(charBufferType, 0);
    }

    public final char[] allocCharBuffer(CharBufferType charBufferType, int i) {
        if (charBufferType.size > i) {
            i = charBufferType.size;
        }
        int iOrdinal = charBufferType.ordinal();
        char[] cArr = this.mCharBuffers[iOrdinal];
        if (cArr == null || cArr.length < i) {
            return new char[i];
        }
        this.mCharBuffers[iOrdinal] = null;
        return cArr;
    }

    public final void releaseByteBuffer(ByteBufferType byteBufferType, byte[] bArr) {
        this.mByteBuffers[byteBufferType.ordinal()] = bArr;
    }

    public final void releaseCharBuffer(CharBufferType charBufferType, char[] cArr) {
        this.mCharBuffers[charBufferType.ordinal()] = cArr;
    }
}
