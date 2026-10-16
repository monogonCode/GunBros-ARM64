package com.openfeint.internal.analytics.internal;

import com.openfeint.internal.analytics.IAnalyticsLogger;
import java.util.HashMap;
import java.util.Map;

/* JADX INFO: loaded from: classes.dex */
public final class BaseAnalyticsLog implements IAnalyticsLogger {
    protected Map<String, Object> base = new HashMap();

    @Override // com.openfeint.internal.analytics.IAnalyticsLogger
    public final Map<String, Object> getMap() {
        return this.base;
    }

    @Override // com.openfeint.internal.analytics.IAnalyticsLogger
    public final void makeEvent(String str, Object obj) {
        this.base.put(str, obj);
    }
}
