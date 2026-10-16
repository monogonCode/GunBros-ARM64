package com.openfeint.internal.request.multipart;

import java.io.IOException;
import java.io.OutputStream;

/* JADX INFO: loaded from: classes.dex */
public final class StringPart extends PartBase {
    private byte[] content;
    private String value;

    public StringPart(String str, String str2) {
        this(str, str2, (byte) 0);
    }

    private StringPart(String str, String str2, byte b) {
        super(str, "text/html", "UTF-8", "8bit");
        if (str2 == null) {
            throw new IllegalArgumentException("Value may not be null");
        }
        if (str2.indexOf(0) != -1) {
            throw new IllegalArgumentException("NULs may not be present in string parts");
        }
        this.value = str2;
    }

    private byte[] getContent() {
        if (this.content == null) {
            this.content = EncodingUtil.getBytes(this.value, getCharSet());
        }
        return this.content;
    }

    @Override // com.openfeint.internal.request.multipart.Part
    protected final long lengthOfData() throws IOException {
        return getContent().length;
    }

    @Override // com.openfeint.internal.request.multipart.Part
    protected final void sendData(OutputStream outputStream) throws IOException {
        outputStream.write(getContent());
    }
}
