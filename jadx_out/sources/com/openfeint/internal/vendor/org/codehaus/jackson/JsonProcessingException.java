package com.openfeint.internal.vendor.org.codehaus.jackson;

import java.io.IOException;

/* JADX INFO: loaded from: classes.dex */
public class JsonProcessingException extends IOException {
    protected JsonLocation mLocation;

    protected JsonProcessingException(String str, JsonLocation jsonLocation) {
        this(str, jsonLocation, null);
    }

    protected JsonProcessingException(String str, JsonLocation jsonLocation, Throwable th) {
        super(str);
        if (th != null) {
            initCause(th);
        }
        this.mLocation = jsonLocation;
    }

    @Override // java.lang.Throwable
    public String getMessage() {
        String message = super.getMessage();
        if (message == null) {
            message = "N/A";
        }
        JsonLocation jsonLocation = this.mLocation;
        if (jsonLocation == null) {
            return message;
        }
        return message + "\n at " + jsonLocation.toString();
    }

    @Override // java.lang.Throwable
    public String toString() {
        return getClass().getName() + ": " + getMessage();
    }
}
