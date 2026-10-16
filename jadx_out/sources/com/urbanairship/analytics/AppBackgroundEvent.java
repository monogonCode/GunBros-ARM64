package com.urbanairship.analytics;

import com.tapjoy.TapjoyConstants;
import com.urbanairship.Logger;
import org.json.JSONException;
import org.json.JSONObject;

/* JADX INFO: loaded from: classes.dex */
class AppBackgroundEvent extends Event {
    static final String TYPE = "app_background";

    AppBackgroundEvent() {
    }

    @Override // com.urbanairship.analytics.Event
    JSONObject getData() {
        JSONObject jSONObject = new JSONObject();
        Event.Environment environment = getEnvironment();
        try {
            jSONObject.put(EventDataManager.Events.COLUMN_NAME_SESSION_ID, getEnvironment().getSessionId());
            jSONObject.put(TapjoyConstants.TJC_CONNECTION_TYPE, environment.getConnectionType());
            String connectionSubType = environment.getConnectionSubType();
            if (connectionSubType.length() > 0) {
                jSONObject.put("connection_subtype", connectionSubType);
            }
            jSONObject.put(EventDataManager.Events.COLUMN_NAME_SESSION_ID, environment.getSessionId());
            jSONObject.put("push_id", environment.getPushId());
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
