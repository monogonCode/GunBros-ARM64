package com.openfeint.internal.analytics.internal;

import com.openfeint.internal.analytics.AnalyticsManager;
import com.openfeint.internal.logcat.OFLog;
import com.openfeint.internal.request.BaseRequest;
import com.openfeint.internal.request.OrderedArgList;

/* JADX INFO: loaded from: classes.dex */
public final class AnalyticsRequest extends BaseRequest {
    Long endid;
    Long startid;
    public final String tag;

    public AnalyticsRequest(Long l, Long l2, OrderedArgList orderedArgList) {
        super(orderedArgList);
        this.tag = "AnalyticsRequest";
        this.startid = l;
        this.endid = l2;
    }

    @Override // com.openfeint.internal.request.BaseRequest
    public final String method() {
        return "POST";
    }

    @Override // com.openfeint.internal.request.BaseRequest
    public final void onResponse(int i, byte[] bArr) {
        OFLog.v("AnalyticsRequest", "ResponseCode:" + i);
        if (200 > i || i >= 300) {
            OFLog.w("AnalyticsRequest", String.format("push log num form %d to %d, Failed!", this.startid, this.endid));
            AnalyticsManager.instance().unlock();
        } else {
            OFLog.d("AnalyticsRequest", String.format("push log num form %d to %d, Success!", this.startid, this.endid));
            AnalyticsManager.instance().deleteLog(this.startid, this.endid);
            AnalyticsManager.instance().unlock();
        }
    }

    @Override // com.openfeint.internal.request.BaseRequest
    public final String path() {
        return "/xp/events";
    }
}
