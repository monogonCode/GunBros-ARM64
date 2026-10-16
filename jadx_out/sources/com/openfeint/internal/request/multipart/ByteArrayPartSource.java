package com.openfeint.internal.request.multipart;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;

/* JADX INFO: loaded from: classes.dex */
public final class ByteArrayPartSource implements PartSource {
    private byte[] bytes;
    private String fileName;

    public ByteArrayPartSource(String str, byte[] bArr) {
        this.fileName = str;
        this.bytes = bArr;
    }

    @Override // com.openfeint.internal.request.multipart.PartSource
    public final InputStream createInputStream() throws IOException {
        return new ByteArrayInputStream(this.bytes);
    }

    @Override // com.openfeint.internal.request.multipart.PartSource
    public final String getFileName() {
        return this.fileName;
    }

    @Override // com.openfeint.internal.request.multipart.PartSource
    public final long getLength() {
        return this.bytes.length;
    }
}
