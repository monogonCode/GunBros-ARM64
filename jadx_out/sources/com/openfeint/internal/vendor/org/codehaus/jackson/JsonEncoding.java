package com.openfeint.internal.vendor.org.codehaus.jackson;

/* JADX INFO: loaded from: classes.dex */
public enum JsonEncoding {
    UTF8("UTF-8", false),
    UTF16_BE("UTF-16BE", true),
    UTF16_LE("UTF-16LE", false),
    UTF32_BE("UTF-32BE", true),
    UTF32_LE("UTF-32LE", false);

    final boolean mBigEndian;
    final String mJavaName;

    JsonEncoding(String str, boolean z) {
        this.mJavaName = str;
        this.mBigEndian = z;
    }

    public final String getJavaName() {
        return this.mJavaName;
    }

    public final boolean isBigEndian() {
        return this.mBigEndian;
    }
}
