package com.urbanairship.analytics;

import com.urbanairship.Logger;
import org.json.JSONException;
import org.json.JSONObject;

/* JADX INFO: loaded from: classes.dex */
public class PushArrivedEvent extends Event {
    static final String TYPE = "push_arrived";
    private String pushId;

    public PushArrivedEvent(String str) {
        this.pushId = str;
    }

    @Override // com.urbanairship.analytics.Event
    JSONObject getData() {
        JSONObject jSONObject = new JSONObject();
        try {
            jSONObject.put(EventDataManager.Events.COLUMN_NAME_SESSION_ID, getEnvironment().getSessionId());
            jSONObject.put("push_id", this.pushId);
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
