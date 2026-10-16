package com.openfeint.internal.request.multipart;

/* JADX INFO: loaded from: classes.dex */
public abstract class PartBase extends Part {
    private String charSet;
    private String contentType;
    private String name;
    private String transferEncoding;

    public PartBase(String str, String str2, String str3, String str4) {
        if (str == null) {
            throw new IllegalArgumentException("Name must not be null");
        }
        this.name = str;
        this.contentType = str2;
        this.charSet = str3;
        this.transferEncoding = str4;
    }

    @Override // com.openfeint.internal.request.multipart.Part
    public final String getCharSet() {
        return this.charSet;
    }

    @Override // com.openfeint.internal.request.multipart.Part
    public final String getContentType() {
        return this.contentType;
    }

    @Override // com.openfeint.internal.request.multipart.Part
    public final String getName() {
        return this.name;
    }

    @Override // com.openfeint.internal.request.multipart.Part
    public final String getTransferEncoding() {
        return this.transferEncoding;
    }
}
