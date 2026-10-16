package com.urbanairship.analytics;

import android.app.Activity;
import com.urbanairship.Logger;
import org.json.JSONException;
import org.json.JSONObject;

/* JADX INFO: loaded from: classes.dex */
class ActivityStoppedEvent extends Event {
    static final String TYPE = "activity_stopped";
    private String className;

    ActivityStoppedEvent(Activity activity) {
        this.className = activity.getComponentName().getClassName();
    }

    @Override // com.urbanairship.analytics.Event
    JSONObject getData() {
        JSONObject jSONObject = new JSONObject();
        Event.Environment environment = getEnvironment();
        try {
            jSONObject.put("class_name", this.className);
            jSONObject.put(EventDataManager.Events.COLUMN_NAME_SESSION_ID, environment.getSessionId());
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
