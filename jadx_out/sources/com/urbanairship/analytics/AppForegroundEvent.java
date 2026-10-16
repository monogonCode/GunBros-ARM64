package com.urbanairship.analytics;

import com.tapjoy.TapjoyConstants;
import com.urbanairship.Logger;
import java.util.Collection;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

/* JADX INFO: loaded from: classes.dex */
class AppForegroundEvent extends Event {
    static final String TYPE = "app_foreground";

    AppForegroundEvent() {
    }

    @Override // com.urbanairship.analytics.Event
    JSONObject getData() {
        JSONObject jSONObject = new JSONObject();
        Event.Environment environment = getEnvironment();
        try {
            jSONObject.put(TapjoyConstants.TJC_CONNECTION_TYPE, environment.getConnectionType());
            String connectionSubType = environment.getConnectionSubType();
            if (connectionSubType.length() > 0) {
                jSONObject.put("connection_subtype", connectionSubType);
            }
            jSONObject.put("carrier", environment.getCarrier());
            jSONObject.put("time_zone", environment.getTimezone());
            jSONObject.put("daylight_savings", environment.isDaylightSavingsTime());
            jSONObject.put("notification_types", new JSONArray((Collection) environment.getNotificationTypes()));
            jSONObject.put(TapjoyConstants.TJC_DEVICE_OS_VERSION_NAME, environment.getOsVersion());
            jSONObject.put("lib_version", environment.getLibVersion());
            jSONObject.put("package_version", environment.getPackageVersion());
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
