package com.openfeint.internal.ui;

/* JADX INFO: loaded from: classes.dex */
public abstract class WebViewCacheCallback {
    public abstract void failLoaded();

    public void onTrackingNeeded() {
    }

    public abstract void pathLoaded(String str);
}
