package com.urbanairship.analytics;

import com.urbanairship.Logger;
import com.urbanairship.push.PushManager;
import org.json.JSONException;
import org.json.JSONObject;

/* JADX INFO: loaded from: classes.dex */
public class PushServiceStartedEvent extends Event {
    static final String TYPE = "push_service_started";

    @Override // com.urbanairship.analytics.Event
    JSONObject getData() {
        JSONObject jSONObject = new JSONObject();
        try {
            jSONObject.put(EventDataManager.Events.COLUMN_NAME_SESSION_ID, getEnvironment().getSessionId());
            jSONObject.put("apid", getEnvironment().getApid());
            jSONObject.put("transport", getEnvironment().getPushTransport());
            jSONObject.put("push_enabled", PushManager.shared().getPreferences().isPushEnabled());
        } catch (JSONException e) {
            Logger.error("Error constructing JSON data for " + getType());
        }
        return jSONObject;
    }

    @Override // com.urbanairship.analytics.Event
    String getType() {
        return TYPE;
    }
}
