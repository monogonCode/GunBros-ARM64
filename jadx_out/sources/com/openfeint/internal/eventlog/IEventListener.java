package com.openfeint.internal.eventlog;

/* JADX INFO: loaded from: classes.dex */
public interface IEventListener {
    String getName();

    void handleEvent(String str, Object obj);
}
