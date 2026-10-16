package com.urbanairship.analytics;

import com.urbanairship.Logger;
import com.urbanairship.push.PushManager;
import com.urbanairship.push.PushPreferences;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

/* JADX INFO: loaded from: classes.dex */
public class PushPreferencesChangedEvent extends Event {
    static final String TYPE = "push_preferences_changed";

    @Override // com.urbanairship.analytics.Event
    JSONObject getData() {
        JSONObject jSONObject = new JSONObject();
        PushPreferences preferences = PushManager.shared().getPreferences();
        try {
            jSONObject.put(EventDataManager.Events.COLUMN_NAME_SESSION_ID, getEnvironment().getSessionId());
            jSONObject.put("notification_types", new JSONArray((Collection) getEnvironment().getNotificationTypes()));
            Date[] quietTimeInterval = preferences.getQuietTimeInterval();
            if (preferences.isQuietTimeEnabled() && quietTimeInterval != null) {
                SimpleDateFormat simpleDateFormat = new SimpleDateFormat("HH:mm");
                ArrayList arrayList = new ArrayList(2);
                arrayList.add(simpleDateFormat.format(quietTimeInterval[0]));
                arrayList.add(simpleDateFormat.format(quietTimeInterval[1]));
                jSONObject.put("quiet_time", new JSONArray((Collection) arrayList));
            }
            jSONObject.put("push_enabled", preferences.isPushEnabled());
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
