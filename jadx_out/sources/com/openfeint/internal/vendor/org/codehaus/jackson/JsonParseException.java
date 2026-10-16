package com.openfeint.internal.vendor.org.codehaus.jackson;

/* JADX INFO: loaded from: classes.dex */
public final class JsonParseException extends JsonProcessingException {
    public JsonParseException(String str, JsonLocation jsonLocation) {
        super(str, jsonLocation);
    }

    public JsonParseException(String str, JsonLocation jsonLocation, Throwable th) {
        super(str, jsonLocation, th);
    }
}
