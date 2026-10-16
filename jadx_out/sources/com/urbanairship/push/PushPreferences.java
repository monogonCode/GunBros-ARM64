package com.urbanairship.push;

import com.urbanairship.Logger;
import com.urbanairship.Preferences;
import com.urbanairship.UAirship;
import com.urbanairship.analytics.PushPreferencesChangedEvent;
import java.util.Calendar;
import java.util.Collection;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;
import java.util.regex.Pattern;
import org.json.JSONArray;
import org.json.JSONException;

/* JADX INFO: loaded from: classes.dex */
public class PushPreferences extends Preferences {
    private static final String ALIAS_KEY = "com.urbanairship.push.ALIAS";
    private static final String APID_KEY = "com.urbanairship.push.APID";
    private static final String APID_READY_KEY = "com.urbanairship.push.APID_READY";
    private static final String APID_UPDATE_NEEDED_KEY = "com.urbanairship.push.APID_UPDATE_NEEDED";
    private static final String BOX_OFFICE_SECRET_KEY = "com.urbanairship.push.BOX_OFFICE_SECRET";
    private static final String C2DM_ID_KEY = "com.urbanairship.push.C2DM_KEY";
    private static final String PUSH_ENABLED_KEY = "com.urbanairship.push.PUSH_ENABLED";
    private static final String RETRY_AFTER_KEY = "com.urbanairship.push.RETRY_AFTER";
    private static final String SOUND_ENABLED_KEY = "com.urbanairship.push.SOUND_ENABLED";
    private static final String TAGS_KEY = "com.urbanairship.push.TAGS";
    private static final String VIBRATE_ENABLED_KEY = "com.urbanairship.push.VIBRATE_ENABLED";

    private static final class QuietTime {
        public static final String ENABLED = "com.urbanairship.push.QuietTime.ENABLED";
        public static final String END_HOUR_KEY = "com.urbanairship.push.QuietTime.END_HOUR";
        public static final String END_MIN_KEY = "com.urbanairship.push.QuietTime.END_MINUTE";
        public static final int NOT_SET_VAL = -1;
        public static final String START_HOUR_KEY = "com.urbanairship.push.QuietTime.START_HOUR";
        public static final String START_MIN_KEY = "com.urbanairship.push.QuietTime.START_MINUTE";

        private QuietTime() {
        }
    }

    public PushPreferences() {
        super("com.urbanairship.push");
    }

    private void sendPrefsChangedEvent() {
        UAirship.shared().getAnalytics().addEvent(new PushPreferencesChangedEvent());
    }

    public String getAlias() {
        return getString(ALIAS_KEY, null);
    }

    public String getC2DMId() {
        return getString(C2DM_ID_KEY, null);
    }

    public String getPushId() {
        return getString("com.urbanairship.push.APID", null);
    }

    public String getPushSecret() {
        return getString(BOX_OFFICE_SECRET_KEY, null);
    }

    public Date[] getQuietTimeInterval() {
        int i = getInt(QuietTime.START_HOUR_KEY, -1);
        int i2 = getInt(QuietTime.START_MIN_KEY, -1);
        int i3 = getInt(QuietTime.END_HOUR_KEY, -1);
        int i4 = getInt(QuietTime.END_MIN_KEY, -1);
        if (i == -1 || i2 == -1 || i3 == -1 || i4 == -1) {
            return null;
        }
        Calendar calendar = Calendar.getInstance();
        calendar.set(11, i);
        calendar.set(12, i2);
        calendar.set(13, 0);
        Date time = calendar.getTime();
        Calendar calendar2 = Calendar.getInstance();
        calendar2.set(11, i3);
        calendar2.set(12, i4);
        calendar2.set(13, 0);
        if (i3 < i) {
            calendar2.add(5, 1);
        }
        return new Date[]{time, calendar2.getTime()};
    }

    public long getRetryAfter() {
        return getLong(RETRY_AFTER_KEY, 0L);
    }

    public Set<String> getTags() {
        HashSet hashSet = new HashSet();
        String string = getString(TAGS_KEY, "[]");
        if (string != null) {
            try {
                JSONArray jSONArray = new JSONArray(string);
                int length = jSONArray.length();
                for (int i = 0; i < length; i++) {
                    hashSet.add(jSONArray.getString(i));
                }
            } catch (JSONException e) {
            }
        }
        return hashSet;
    }

    boolean isAPIDReady() {
        return getBoolean(APID_READY_KEY, false);
    }

    boolean isApidUpdateNeeded() {
        return getBoolean(APID_UPDATE_NEEDED_KEY, true);
    }

    public boolean isInQuietTime() {
        if (!isQuietTimeEnabled()) {
            return false;
        }
        Calendar calendar = Calendar.getInstance();
        int i = getInt(QuietTime.START_HOUR_KEY, -1);
        int i2 = getInt(QuietTime.START_MIN_KEY, -1);
        int i3 = getInt(QuietTime.END_HOUR_KEY, -1);
        int i4 = getInt(QuietTime.END_MIN_KEY, -1);
        if (-1 == i || -1 == i2 || -1 == i3 || -1 == i4) {
            return false;
        }
        Calendar calendar2 = Calendar.getInstance();
        calendar2.set(11, i);
        calendar2.set(12, i2);
        calendar2.set(13, 0);
        Calendar calendar3 = Calendar.getInstance();
        calendar3.set(11, i3);
        calendar3.set(12, i4);
        calendar3.set(13, 0);
        if (calendar2.after(calendar) && calendar3.before(calendar2)) {
            calendar2.add(6, -1);
        }
        if (calendar3.before(calendar2)) {
            calendar3.add(6, 1);
        }
        return calendar.after(calendar2) && calendar.before(calendar3);
    }

    public boolean isPushEnabled() {
        return getBoolean(PUSH_ENABLED_KEY, false);
    }

    public boolean isQuietTimeEnabled() {
        return getBoolean(QuietTime.ENABLED, false);
    }

    public boolean isSoundEnabled() {
        return getBoolean(SOUND_ENABLED_KEY, true);
    }

    public boolean isVibrateEnabled() {
        return getBoolean(VIBRATE_ENABLED_KEY, true);
    }

    boolean setAPIDReady(boolean z) {
        if (isAPIDReady() != z) {
            return putBoolean(APID_READY_KEY, z);
        }
        return true;
    }

    public boolean setAlias(String str) {
        return putString(ALIAS_KEY, str);
    }

    boolean setApidUpdateNeeded(boolean z) {
        return putBoolean(APID_UPDATE_NEEDED_KEY, z);
    }

    public boolean setC2DMId(String str) {
        return putString(C2DM_ID_KEY, str);
    }

    boolean setPushEnabled(boolean z) {
        if (isPushEnabled() == z) {
            return true;
        }
        boolean zPutBoolean = putBoolean(PUSH_ENABLED_KEY, z);
        if (!zPutBoolean) {
            return zPutBoolean;
        }
        sendPrefsChangedEvent();
        return zPutBoolean;
    }

    public boolean setPushId(String str) {
        Pattern patternCompile = Pattern.compile("[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}");
        if (str == null || patternCompile.matcher(str).matches()) {
            return putString("com.urbanairship.push.APID", str);
        }
        Logger.warn("PushPreferences - attempted to save malformed APID.");
        return false;
    }

    public boolean setPushSecret(String str) {
        if (str == null || str.length() > 0) {
            return putString(BOX_OFFICE_SECRET_KEY, str);
        }
        Logger.warn("PushPreferences - attempted to save malformed secret.");
        return false;
    }

    public boolean setQuietTimeEnabled(boolean z) {
        if (isQuietTimeEnabled() == z) {
            return true;
        }
        boolean zPutBoolean = putBoolean(QuietTime.ENABLED, z);
        if (!zPutBoolean) {
            return zPutBoolean;
        }
        sendPrefsChangedEvent();
        return zPutBoolean;
    }

    public boolean setQuietTimeInterval(Date date, Date date2) {
        boolean z = true;
        int i = getInt(QuietTime.START_HOUR_KEY, -1);
        int i2 = getInt(QuietTime.START_MIN_KEY, -1);
        int i3 = getInt(QuietTime.END_HOUR_KEY, -1);
        int i4 = getInt(QuietTime.END_MIN_KEY, -1);
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date);
        int i5 = calendar.get(11);
        int i6 = calendar.get(12);
        Calendar calendar2 = Calendar.getInstance();
        calendar2.setTime(date2);
        int i7 = calendar2.get(11);
        int i8 = calendar2.get(12);
        if (i != i5 || i2 != i6 || i3 != i7 || i4 != i8) {
            z = putInt(QuietTime.START_HOUR_KEY, i5) && putInt(QuietTime.START_MIN_KEY, i6) && putInt(QuietTime.END_HOUR_KEY, i7) && putInt(QuietTime.END_MIN_KEY, i8);
            if (z) {
                sendPrefsChangedEvent();
            }
        }
        return z;
    }

    public boolean setRetryAfter(long j) {
        return putLong(RETRY_AFTER_KEY, j);
    }

    public boolean setSoundEnabled(boolean z) {
        if (isSoundEnabled() == z) {
            return true;
        }
        boolean zPutBoolean = putBoolean(SOUND_ENABLED_KEY, z);
        if (!zPutBoolean) {
            return zPutBoolean;
        }
        sendPrefsChangedEvent();
        return zPutBoolean;
    }

    public boolean setTags(Set<String> set) {
        if (set == null) {
            return false;
        }
        return putString(TAGS_KEY, new JSONArray((Collection) set).toString());
    }

    public boolean setVibrateEnabled(boolean z) {
        if (isVibrateEnabled() == z) {
            return true;
        }
        boolean zPutBoolean = putBoolean(VIBRATE_ENABLED_KEY, z);
        if (!zPutBoolean) {
            return zPutBoolean;
        }
        sendPrefsChangedEvent();
        return zPutBoolean;
    }
}
