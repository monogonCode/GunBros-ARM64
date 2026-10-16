package com.glu.platform.android.resdl;

import java.util.Hashtable;

/* JADX INFO: loaded from: classes.dex */
public final class CaseInsensitiveHash<K, V> extends Hashtable<K, V> {
    @Override // java.util.Hashtable, java.util.Dictionary, java.util.Map
    public final V get(Object obj) {
        if (obj instanceof String) {
            obj = ((String) obj).toLowerCase();
        }
        return (V) super.get(obj);
    }

    /* JADX WARN: Multi-variable type inference failed */
    /* JADX WARN: Type inference failed for: r1v0, types: [com.glu.platform.android.resdl.CaseInsensitiveHash<K, V>, java.util.Hashtable] */
    /* JADX WARN: Type inference failed for: r2v0, types: [K] */
    /* JADX WARN: Type inference failed for: r2v1, types: [java.lang.Object] */
    /* JADX WARN: Type inference failed for: r2v5 */
    /* JADX WARN: Type inference failed for: r2v6 */
    @Override // java.util.Hashtable, java.util.Dictionary, java.util.Map
    public final V put(K k, V v) {
        boolean z = k instanceof String;
        ?? r2 = k;
        if (z) {
            r2 = (K) ((String) k).toLowerCase();
        }
        return (V) super.put(r2, v);
    }
}
