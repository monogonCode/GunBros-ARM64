package com.openfeint.internal.eventlog;

import com.openfeint.internal.OpenFeintInternal;
import com.openfeint.internal.analytics.AnalyticsManager;
import com.openfeint.internal.analytics.SDKAnalyticsLogFactory;
import com.openfeint.internal.logcat.OFLog;

/* JADX INFO: loaded from: classes.dex */
public final class SDKEventListener implements IEventListener {
    public static String tag = "SDKEventListener";
    private String name = "SDKEventListener";

    @Override // com.openfeint.internal.eventlog.IEventListener
    public final String getName() {
        return this.name;
    }

    @Override // com.openfeint.internal.eventlog.IEventListener
    public final void handleEvent(String str, Object obj) {
        OFLog.d(tag, "MakeEvent in SDKEventListener:" + str);
        if (str.equals("new_user.openfeint.com")) {
            if (this.name.equals(obj)) {
                OpenFeintInternal.setUserEnableSource("");
            }
            AnalyticsManager.instance().makelog(SDKAnalyticsLogFactory.getNewClientSDKBaseLog("new_user"), tag);
            return;
        }
        if (str.equals("enabled_of.openfeint.com")) {
            OFLog.d(tag, "ENABLE OLD USER " + (obj == null ? "" : "from " + obj));
            if (this.name.equals(obj)) {
                OpenFeintInternal.setUserEnableSource("");
            }
            AnalyticsManager.instance().makelog(SDKAnalyticsLogFactory.getNewClientSDKBaseLog("enabled_of"), tag);
            return;
        }
        if (str.equals("prompt_enable_of.openfeint.com")) {
            OFLog.d(tag, "PROMPT_ENABLE_OF " + (obj == null ? "" : "from " + obj));
            if (this.name.equals(obj)) {
                OpenFeintInternal.setUserEnableSource("");
            }
            AnalyticsManager.instance().makelog(SDKAnalyticsLogFactory.getNewClientSDKBaseLog("prompt_enable_of"), tag);
            return;
        }
        if (str.equals("accepted_of.openfeint.com")) {
            OFLog.d(tag, "ACCEPTED_OF " + (obj == null ? "" : "from " + obj));
            if (this.name.equals(obj)) {
                OpenFeintInternal.setUserEnableSource("");
            }
            AnalyticsManager.instance().makelog(SDKAnalyticsLogFactory.getNewClientSDKBaseLog("accepted_of"), tag);
            return;
        }
        if (str.equals("declined_of.openfeint.com")) {
            OFLog.d(tag, "DECLINED_OF " + (obj == null ? "" : "from " + obj));
            if (this.name.equals(obj)) {
                OpenFeintInternal.setUserEnableSource("");
            }
            AnalyticsManager.instance().makelog(SDKAnalyticsLogFactory.getNewClientSDKBaseLog("declined_of"), tag);
            return;
        }
        if (str.equals("game_start.openfeint.com")) {
            OFLog.d(tag, "GAME_START " + (obj == null ? "" : "from " + obj));
            if (this.name.equals(obj)) {
                OpenFeintInternal.setUserEnableSource("");
            }
            AnalyticsManager.instance().makelog(SDKAnalyticsLogFactory.getNewClientSDKBaseLog("game_launch"), tag);
            return;
        }
        if (str.equals("game_background.openfeint.com")) {
            OFLog.d(tag, "GAME_BACKGROUND " + (obj == null ? "" : "from " + obj));
            if (this.name.equals(obj)) {
                OpenFeintInternal.setUserEnableSource("");
            }
            AnalyticsManager.instance().makelog(SDKAnalyticsLogFactory.getNewClientSDKBaseLog("game_background"), tag);
            return;
        }
        if (str.equals("game_foreground.openfeint.com")) {
            OFLog.d(tag, "GAME_FOREGROUND " + (obj == null ? "" : "from " + obj));
            if (this.name.equals(obj)) {
                OpenFeintInternal.setUserEnableSource("");
            }
            AnalyticsManager.instance().makelog(SDKAnalyticsLogFactory.getNewClientSDKBaseLog("game_foreground"), tag);
            return;
        }
        if (str.equals("game_exit.openfeint.com")) {
            OFLog.d(tag, "GAME_EXIT " + (obj == null ? "" : "from " + obj));
            if (this.name.equals(obj)) {
                OpenFeintInternal.setUserEnableSource("");
            }
            AnalyticsManager.instance().makelog(SDKAnalyticsLogFactory.getNewClientSDKBaseLog("game_exit"), tag);
        }
    }
}
