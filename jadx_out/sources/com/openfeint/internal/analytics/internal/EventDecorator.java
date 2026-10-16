package com.openfeint.internal.analytics.internal;

import com.openfeint.internal.analytics.IAnalyticsLogger;
import java.util.HashMap;
import java.util.Map;

/* JADX INFO: loaded from: classes.dex */
public final class EventDecorator extends BaseAnalyticsDecorator {
    protected Map<String, Object> event;

    public EventDecorator(IAnalyticsLogger iAnalyticsLogger) {
        super(iAnalyticsLogger);
        this.event = new HashMap();
        iAnalyticsLogger.makeEvent("event", this.event);
    }

    @Override // com.openfeint.internal.analytics.internal.BaseAnalyticsDecorator, com.openfeint.internal.analytics.IAnalyticsLogger
    public final Map<String, Object> getMap() {
        return this.logger.getMap();
    }

    @Override // com.openfeint.internal.analytics.internal.BaseAnalyticsDecorator, com.openfeint.internal.analytics.IAnalyticsLogger
    public final void makeEvent(String str, Object obj) {
        this.event.put(str, obj);
    }
}
