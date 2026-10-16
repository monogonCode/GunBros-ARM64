package com.openfeint.internal.analytics.internal;

import com.openfeint.internal.analytics.IAnalyticsLogger;
import java.util.Map;

/* JADX INFO: loaded from: classes.dex */
public abstract class BaseAnalyticsDecorator implements IAnalyticsLogger {
    protected IAnalyticsLogger logger;

    public BaseAnalyticsDecorator(IAnalyticsLogger iAnalyticsLogger) {
        this.logger = iAnalyticsLogger;
    }

    @Override // com.openfeint.internal.analytics.IAnalyticsLogger
    public Map<String, Object> getMap() {
        return this.logger.getMap();
    }

    @Override // com.openfeint.internal.analytics.IAnalyticsLogger
    public void makeEvent(String str, Object obj) {
        this.logger.makeEvent(str, obj);
    }
}
