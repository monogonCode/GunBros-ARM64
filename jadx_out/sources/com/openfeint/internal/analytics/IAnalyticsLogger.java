package com.openfeint.internal.analytics;

import java.util.Map;

/* JADX INFO: loaded from: classes.dex */
public interface IAnalyticsLogger {
    Map<String, Object> getMap();

    void makeEvent(String str, Object obj);
}
