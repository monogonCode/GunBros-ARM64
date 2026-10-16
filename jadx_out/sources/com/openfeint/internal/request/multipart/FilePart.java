package com.openfeint.internal.request.multipart;

import com.google.protobuf.CodedOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

/* JADX INFO: loaded from: classes.dex */
public final class FilePart extends PartBase {
    private static final byte[] FILE_NAME_BYTES = EncodingUtil.getAsciiBytes("; filename=");
    private PartSource source;

    public FilePart(String str, PartSource partSource, String str2) {
        super(str, str2 == null ? "application/octet-stream" : str2, "ISO-8859-1", "binary");
        if (partSource == null) {
            throw new IllegalArgumentException("Source may not be null");
        }
        this.source = partSource;
    }

    @Override // com.openfeint.internal.request.multipart.Part
    protected final long lengthOfData() throws IOException {
        return this.source.getLength();
    }

    @Override // com.openfeint.internal.request.multipart.Part
    protected final void sendData(OutputStream outputStream) throws IOException {
        if (lengthOfData() == 0) {
            return;
        }
        byte[] bArr = new byte[CodedOutputStream.DEFAULT_BUFFER_SIZE];
        InputStream inputStreamCreateInputStream = this.source.createInputStream();
        while (true) {
            try {
                int i = inputStreamCreateInputStream.read(bArr);
                if (i < 0) {
                    inputStreamCreateInputStream.close();
                    return;
                }
                outputStream.write(bArr, 0, i);
            } catch (Throwable th) {
                inputStreamCreateInputStream.close();
                throw th;
            }
        }
    }

    @Override // com.openfeint.internal.request.multipart.Part
    protected final void sendDispositionHeader(OutputStream outputStream) throws IOException {
        super.sendDispositionHeader(outputStream);
        String fileName = this.source.getFileName();
        if (fileName != null) {
            outputStream.write(FILE_NAME_BYTES);
            outputStream.write(QUOTE_BYTES);
            outputStream.write(EncodingUtil.getAsciiBytes(fileName));
            outputStream.write(QUOTE_BYTES);
        }
    }
}
