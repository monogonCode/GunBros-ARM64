package com.openfeint.internal.request;

/* JADX INFO: loaded from: classes.dex */
public class ExternalBitmapRequest extends BitmapRequest {
    private String mURL;

    public ExternalBitmapRequest(String str) {
        this.mURL = str;
    }

    @Override // com.openfeint.internal.request.BaseRequest
    public final String path() {
        return "";
    }

    @Override // com.openfeint.internal.request.BaseRequest
    public final boolean signed() {
        return false;
    }

    @Override // com.openfeint.internal.request.BaseRequest
    public final String url() {
        return this.mURL;
    }
}
