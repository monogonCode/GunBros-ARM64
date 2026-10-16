package com.facebook.android;

/* JADX INFO: loaded from: classes.dex */
public final class FacebookError extends Throwable {
    private int mErrorCode;
    private String mErrorType;

    public FacebookError(String str) {
        super(str);
        this.mErrorCode = 0;
    }

    public FacebookError(String str, String str2, int i) {
        super(str);
        this.mErrorCode = 0;
        this.mErrorType = str2;
        this.mErrorCode = i;
    }
}
