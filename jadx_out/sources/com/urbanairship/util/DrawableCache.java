package com.urbanairship.util;

import android.graphics.drawable.Drawable;
import com.urbanairship.Logger;
import java.util.Collections;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.Set;

/* JADX INFO: loaded from: classes.dex */
public class DrawableCache {
    private int currentSize;
    private final Map<String, Drawable> drawableMap = Collections.synchronizedMap(new LRUCache(20, 0.75f));
    private int maxSize;

    private class LRUCache<K, V> extends LinkedHashMap<K, V> {
        private static final long serialVersionUID = 1;

        public LRUCache(int i, float f) {
            super(i, f, true);
        }

        @Override // java.util.HashMap, java.util.AbstractMap, java.util.Map
        public V put(K k, V v) {
            DrawableCache.this.incrementSizeBy(v);
            return (V) super.put(k, v);
        }

        @Override // java.util.HashMap, java.util.AbstractMap, java.util.Map
        public V remove(Object obj) {
            V v = (V) super.remove(obj);
            DrawableCache.this.decrementSizeBy(v);
            return v;
        }

        @Override // java.util.LinkedHashMap
        protected boolean removeEldestEntry(Map.Entry<K, V> entry) {
            return false;
        }
    }

    public DrawableCache(int i) {
        setMaxSize(i);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void decrementSizeBy(Object obj) {
        this.currentSize -= estimatedSize((Drawable) obj);
        Logger.verbose("DrawableCache decrement: ~" + this.currentSize + " bytes");
    }

    private int estimatedSize(Drawable drawable) {
        int intrinsicWidth = drawable.getIntrinsicWidth();
        int intrinsicHeight = drawable.getIntrinsicHeight();
        if (intrinsicWidth < 0 || intrinsicHeight < 0) {
            return 0;
        }
        return intrinsicWidth * intrinsicHeight * 4;
    }

    private void housekeeping() {
        if (this.currentSize > this.maxSize) {
            Logger.verbose("DrawableCache: purge");
            Set<Map.Entry<String, Drawable>> setEntrySet = this.drawableMap.entrySet();
            synchronized (this.drawableMap) {
                Iterator<Map.Entry<String, Drawable>> it = setEntrySet.iterator();
                while (it.hasNext() && this.currentSize > this.maxSize) {
                    Logger.verbose("DrawableCache: removing " + it.next().getKey());
                    it.remove();
                }
            }
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void incrementSizeBy(Object obj) {
        this.currentSize += estimatedSize((Drawable) obj);
        Logger.verbose("DrawableCache increment: ~" + this.currentSize + " bytes");
    }

    public boolean containsKey(String str) {
        return this.drawableMap.containsKey(str);
    }

    public Drawable get(String str) {
        return this.drawableMap.get(str);
    }

    public Drawable put(String str, Drawable drawable) {
        this.drawableMap.put(str, drawable);
        housekeeping();
        return drawable;
    }

    public Drawable remove(String str) {
        return this.drawableMap.remove(str);
    }

    public void setMaxSize(int i) {
        this.maxSize = i;
    }
}
