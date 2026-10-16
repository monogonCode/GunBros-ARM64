package com.openfeint.internal.vendor.org.codehaus.jackson.util;

import java.util.LinkedHashMap;
import java.util.Map;

/* JADX INFO: loaded from: classes.dex */
public final class InternCache extends LinkedHashMap<String, String> {
    public static final InternCache instance = new InternCache();

    private InternCache() {
        super(192, 0.8f, true);
    }

    public final synchronized String intern(String str) {
        String strIntern;
        strIntern = get(str);
        if (strIntern == null) {
            strIntern = str.intern();
            put(strIntern, strIntern);
        }
        return strIntern;
    }

    @Override // java.util.LinkedHashMap
    protected final boolean removeEldestEntry(Map.Entry<String, String> entry) {
        return size() > 192;
    }
}
