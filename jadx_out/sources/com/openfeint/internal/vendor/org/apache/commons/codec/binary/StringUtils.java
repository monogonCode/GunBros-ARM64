package com.openfeint.internal.vendor.org.apache.commons.codec.binary;

import java.io.UnsupportedEncodingException;

/* JADX INFO: loaded from: classes.dex */
public final class StringUtils {
    public static String newString(byte[] bArr, String str) {
        if (bArr == null) {
            return null;
        }
        try {
            return new String(bArr, str);
        } catch (UnsupportedEncodingException e) {
            throw new IllegalStateException(str + ": " + e);
        }
    }
}
