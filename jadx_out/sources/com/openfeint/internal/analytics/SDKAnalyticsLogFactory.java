package com.openfeint.internal.analytics;

import com.openfeint.api.resource.CurrentUser;
import com.openfeint.internal.OpenFeintInternal;
import com.openfeint.internal.analytics.internal.BaseAnalyticsLog;
import com.openfeint.internal.analytics.internal.Client_sdk_AnalyticsDecorator;
import com.openfeint.internal.analytics.internal.EventDecorator;
import com.openfeint.internal.analytics.internal.TimeUtil;
import com.urbanairship.analytics.EventDataManager;

/* JADX INFO: loaded from: classes.dex */
public final class SDKAnalyticsLogFactory {
    public static IAnalyticsLogger getNewClientSDKBaseLog(String str) {
        EventDecorator eventDecorator = new EventDecorator(new Client_sdk_AnalyticsDecorator(new BaseAnalyticsLog()));
        eventDecorator.makeEvent("gsdi", OpenFeintInternal.getInstance().getGSDI());
        eventDecorator.makeEvent(EventDataManager.Events.COLUMN_NAME_SESSION_ID, OpenFeintInternal.getInstance().getSessionID());
        eventDecorator.makeEvent("session_length", Float.valueOf((System.currentTimeMillis() - OpenFeintInternal.getInstance().getSessionStartDate().getTime()) / 1000.0f));
        CurrentUser currentUser = OpenFeintInternal.getInstance().getCurrentUser();
        eventDecorator.makeEvent("user_id", currentUser != null ? currentUser.userID() : "0");
        eventDecorator.makeEvent("session_play_time", Float.valueOf(TimeUtil.getAccumulated_ms() / 1000.0f));
        eventDecorator.makeEvent("action", str);
        return eventDecorator;
    }
}
