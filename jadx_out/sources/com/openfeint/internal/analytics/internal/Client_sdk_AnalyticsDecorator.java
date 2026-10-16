package com.openfeint.internal.analytics.internal;

import com.openfeint.internal.analytics.IAnalyticsLogger;
import java.util.HashMap;
import java.util.Map;

/* JADX INFO: loaded from: classes.dex */
public final class Client_sdk_AnalyticsDecorator extends BaseAnalyticsDecorator {
    protected Map<String, Object> client_sdk;

    public Client_sdk_AnalyticsDecorator(IAnalyticsLogger iAnalyticsLogger) {
        super(iAnalyticsLogger);
        this.client_sdk = new HashMap();
        iAnalyticsLogger.makeEvent("client_sdk", this.client_sdk);
    }

    @Override // com.openfeint.internal.analytics.internal.BaseAnalyticsDecorator, com.openfeint.internal.analytics.IAnalyticsLogger
    public final Map<String, Object> getMap() {
        return this.logger.getMap();
    }

    @Override // com.openfeint.internal.analytics.internal.BaseAnalyticsDecorator, com.openfeint.internal.analytics.IAnalyticsLogger
    public final void makeEvent(String str, Object obj) {
        this.client_sdk.put(str, obj);
    }
}
