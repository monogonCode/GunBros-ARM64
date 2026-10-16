package com.urbanairship.util;

import android.content.SharedPreferences;
import com.urbanairship.Logger;
import com.urbanairship.UAirship;

/* JADX INFO: loaded from: classes.dex */
public class NotificationIDGenerator {
    private static final String COUNT_KEY = "count";
    private static final String SHARED_PREFERENCES_FILE = "com.urbanairship.notificationidgenerator";
    private static int START = 1000;
    private static int RANGE = 100;

    private static int getInt(String str, int i) {
        return getPreferences().getInt(str, i);
    }

    private static SharedPreferences getPreferences() {
        return UAirship.shared().getApplicationContext().getSharedPreferences(SHARED_PREFERENCES_FILE, 0);
    }

    public static int getRange() {
        int i;
        synchronized (NotificationIDGenerator.class) {
            i = RANGE;
        }
        return i;
    }

    public static int getStart() {
        int i;
        synchronized (NotificationIDGenerator.class) {
            i = START;
        }
        return i;
    }

    public static int nextID() {
        int i;
        synchronized (NotificationIDGenerator.class) {
            int start = getStart();
            int range = getRange();
            i = getInt(COUNT_KEY, start);
            if (i < range + start) {
                Logger.verbose("incrementing notification id count");
                putInt(COUNT_KEY, i + 1);
            } else {
                Logger.verbose("resetting notification id count");
                putInt(COUNT_KEY, start);
            }
            Logger.verbose("notification id: " + i);
        }
        return i;
    }

    private static void putInt(String str, int i) {
        SharedPreferences.Editor editorEdit = getPreferences().edit();
        editorEdit.putInt(str, i);
        editorEdit.commit();
    }

    public static void setRange(int i) {
        synchronized (NotificationIDGenerator.class) {
            putInt(COUNT_KEY, START);
            RANGE = i;
        }
    }

    public static void setStart(int i) {
        synchronized (NotificationIDGenerator.class) {
            putInt(COUNT_KEY, i);
            START = i;
        }
    }
}
