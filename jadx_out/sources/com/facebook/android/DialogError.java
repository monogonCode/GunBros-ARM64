package com.facebook.android;

/* JADX INFO: loaded from: classes.dex */
public final class DialogError extends Throwable {
    private int mErrorCode;
    private String mFailingUrl;

    public DialogError(String str, int i, String str2) {
        super(str);
        this.mErrorCode = i;
        this.mFailingUrl = str2;
    }
}
