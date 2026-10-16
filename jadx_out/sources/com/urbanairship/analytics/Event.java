package com.urbanairship.analytics;

import android.net.ConnectivityManager;
import android.net.NetworkInfo;
import android.os.Build;
import android.telephony.TelephonyManager;
import com.urbanairship.Logger;
import com.urbanairship.UAirship;
import com.urbanairship.push.PushManager;
import com.urbanairship.push.PushPreferences;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.UUID;
import org.json.JSONException;
import org.json.JSONObject;

/* JADX INFO: loaded from: classes.dex */
public abstract class Event {
    private String eventId = UUID.randomUUID().toString();
    private String time = Long.toString(System.currentTimeMillis() / 1000);
    private Environment environment = new Environment();
    private String sessionId = this.environment.sessionId;

    class Environment {
        String pushId = UAirship.shared().getAnalytics().getConversionPushId();
        String sessionId = UAirship.shared().getAnalytics().getSession().getId();

        public Environment() {
        }

        public String getApid() {
            return PushManager.shared().getPreferences().getPushId();
        }

        public String getCarrier() {
            return ((TelephonyManager) UAirship.shared().getApplicationContext().getSystemService("phone")).getNetworkOperatorName();
        }

        public String getConnectionSubType() {
            NetworkInfo activeNetworkInfo;
            ConnectivityManager connectivityManager = (ConnectivityManager) UAirship.shared().getApplicationContext().getSystemService("connectivity");
            return (connectivityManager == null || (activeNetworkInfo = connectivityManager.getActiveNetworkInfo()) == null) ? "" : activeNetworkInfo.getSubtypeName();
        }

        public String getConnectionType() {
            NetworkInfo activeNetworkInfo;
            ConnectivityManager connectivityManager = (ConnectivityManager) UAirship.shared().getApplicationContext().getSystemService("connectivity");
            switch ((connectivityManager == null || (activeNetworkInfo = connectivityManager.getActiveNetworkInfo()) == null) ? -1 : activeNetworkInfo.getType()) {
                case 0:
                    return "cell";
                case 1:
                    return "wifi";
                case 6:
                    return "wimax";
                default:
                    return "none";
            }
        }

        public String getLibVersion() {
            return UAirship.getVersion();
        }

        public ArrayList<String> getNotificationTypes() {
            PushPreferences preferences = PushManager.shared().getPreferences();
            ArrayList<String> arrayList = new ArrayList<>();
            if (preferences.isSoundEnabled()) {
                arrayList.add("sound");
            }
            if (preferences.isVibrateEnabled()) {
                arrayList.add("vibrate");
            }
            return arrayList;
        }

        public String getOsVersion() {
            return Build.VERSION.RELEASE;
        }

        public String getPackageVersion() {
            return UAirship.getPackageInfo().versionName;
        }

        public String getPushId() {
            return this.pushId;
        }

        public String getPushTransport() {
            return UAirship.shared().getAirshipConfigOptions().getTransport().toString();
        }

        public String getSessionId() {
            return this.sessionId;
        }

        public long getTimezone() {
            return Calendar.getInstance().getTimeZone().getOffset(System.currentTimeMillis()) / 1000;
        }

        public boolean isDaylightSavingsTime() {
            return Calendar.getInstance().getTimeZone().inDaylightTime(new Date());
        }
    }

    Event() {
    }

    abstract JSONObject getData();

    Environment getEnvironment() {
        return this.environment;
    }

    String getEventId() {
        return this.eventId;
    }

    String getSessionId() {
        return this.sessionId;
    }

    String getTime() {
        return this.time;
    }

    abstract String getType();

    JSONObject jsonRepresentation() {
        JSONObject jSONObject = new JSONObject();
        JSONObject data = getData();
        try {
            jSONObject.put(EventDataManager.Events.COLUMN_NAME_TYPE, getType());
            jSONObject.put(EventDataManager.Events.COLUMN_NAME_EVENT_ID, this.eventId);
            jSONObject.put(EventDataManager.Events.COLUMN_NAME_TIME, this.time);
            jSONObject.put(EventDataManager.Events.COLUMN_NAME_DATA, data);
        } catch (JSONException e) {
            Logger.error("Error constructing JSON " + getType() + " representation");
        }
        return jSONObject;
    }

    void log() {
        Logger.verbose(getClass().getName() + " - " + jsonRepresentation().toString());
    }
}
