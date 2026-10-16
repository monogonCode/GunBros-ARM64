package com.urbanairship;

import android.content.SharedPreferences;

/* JADX INFO: loaded from: classes.dex */
public class Preferences {
    private String filename;

    public Preferences(String str) {
        this.filename = str;
    }

    private synchronized SharedPreferences getPreferences() {
        return UAirship.shared().getApplicationContext().getSharedPreferences(this.filename, 4);
    }

    public boolean getBoolean(String str, boolean z) {
        return getPreferences().getBoolean(str, z);
    }

    public float getFloat(String str, float f) {
        return getPreferences().getFloat(str, f);
    }

    public int getInt(String str, int i) {
        return getPreferences().getInt(str, i);
    }

    public long getLong(String str, long j) {
        return getPreferences().getLong(str, j);
    }

    public String getString(String str, String str2) {
        return getPreferences().getString(str, str2);
    }

    public boolean putBoolean(String str, boolean z) {
        return getPreferences().edit().putBoolean(str, z).commit();
    }

    public boolean putFloat(String str, float f) {
        return getPreferences().edit().putFloat(str, f).commit();
    }

    public boolean putInt(String str, int i) {
        return getPreferences().edit().putInt(str, i).commit();
    }

    public boolean putLong(String str, long j) {
        return getPreferences().edit().putLong(str, j).commit();
    }

    public boolean putString(String str, String str2) {
        return getPreferences().edit().putString(str, str2).commit();
    }

    public boolean remove(String str) {
        return getPreferences().edit().remove(str).commit();
    }
}
