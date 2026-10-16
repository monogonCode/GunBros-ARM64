package com.openfeint.internal;

import android.os.Bundle;
import com.openfeint.internal.logcat.OFLog;
import java.util.Date;
import java.util.HashSet;
import org.apache.http.cookie.Cookie;
import org.apache.http.impl.client.BasicCookieStore;
import org.apache.http.impl.cookie.BasicClientCookie;
import org.apache.http.impl.cookie.DateParseException;
import org.apache.http.impl.cookie.DateUtils;

/* JADX INFO: loaded from: classes.dex */
public final class CookieStore extends BasicCookieStore {
    static final int COOKIE_PREFIX_LEN = "_of_cookie_".length();
    static final int COOKIE_VALUE_TAG_LEN = "value".length();
    SyncedStore mSharedPreferences;

    public CookieStore(SyncedStore syncedStore) {
        this.mSharedPreferences = syncedStore;
        SyncedStore.Reader reader = this.mSharedPreferences.read();
        try {
            for (String str : SyncedStore.this.mMap.keySet()) {
                if (str.startsWith("_of_cookie_") && str.endsWith("value")) {
                    super.addCookie(cookieFromPrefs(reader, str.substring(COOKIE_PREFIX_LEN, str.length() - COOKIE_VALUE_TAG_LEN)));
                }
            }
            reader.complete();
        } catch (Throwable th) {
            reader.complete();
            throw th;
        }
    }

    private static BasicClientCookie cookieFromPrefs(SyncedStore.Reader reader, String str) {
        String str2 = "_of_cookie_" + str;
        String string = reader.getString(str2 + "value", null);
        if (string == null) {
            return null;
        }
        String string2 = reader.getString(str2 + "path", null);
        String string3 = reader.getString(str2 + "domain", null);
        String string4 = reader.getString(str2 + "expiry", null);
        BasicClientCookie basicClientCookie = new BasicClientCookie(str, string);
        basicClientCookie.setPath(string2);
        basicClientCookie.setDomain(string3);
        basicClientCookie.setExpiryDate(dateFromString(string4));
        return basicClientCookie;
    }

    private static final Date dateFromString(String str) {
        try {
            return DateUtils.parseDate(str);
        } catch (DateParseException e) {
            OFLog.e("CookieStore", "Couldn't parse date: '" + str + "'");
            return null;
        }
    }

    @Override // org.apache.http.impl.client.BasicCookieStore, org.apache.http.client.CookieStore
    public final synchronized void addCookie(Cookie cookie) {
        try {
            super.addCookie(cookie);
            String name = cookie.getName();
            SyncedStore.Reader reader = this.mSharedPreferences.read();
            try {
                BasicClientCookie basicClientCookieCookieFromPrefs = cookieFromPrefs(reader, name);
                reader.complete();
                if (basicClientCookieCookieFromPrefs == null || !basicClientCookieCookieFromPrefs.getValue().equals(cookie.getValue()) || !basicClientCookieCookieFromPrefs.getPath().equals(cookie.getPath()) || !basicClientCookieCookieFromPrefs.getDomain().equals(cookie.getDomain()) || !basicClientCookieCookieFromPrefs.getExpiryDate().equals(cookie.getExpiryDate())) {
                    SyncedStore.Editor editorEdit = this.mSharedPreferences.edit();
                    try {
                        String str = "_of_cookie_" + name;
                        for (String str2 : new HashSet(SyncedStore.this.mMap.keySet())) {
                            if (str2.startsWith(str)) {
                                editorEdit.remove(str2);
                            }
                        }
                        if (cookie.getExpiryDate() != null) {
                            String name2 = cookie.getName();
                            editorEdit.putString("_of_cookie_" + name2 + "value", cookie.getValue());
                            editorEdit.putString("_of_cookie_" + name2 + "path", cookie.getPath());
                            editorEdit.putString("_of_cookie_" + name2 + "domain", cookie.getDomain());
                            editorEdit.putString("_of_cookie_" + name2 + "expiry", DateUtils.formatDate(cookie.getExpiryDate()));
                        }
                        editorEdit.commit();
                    } catch (Throwable th) {
                        editorEdit.commit();
                        throw th;
                    }
                }
            } catch (Throwable th2) {
                reader.complete();
                throw th2;
            }
        } catch (Throwable th3) {
            throw th3;
        }
    }

    public final synchronized void restoreInstanceState(Bundle bundle) {
        BasicClientCookie basicClientCookie;
        for (String str : bundle.keySet()) {
            if (str.startsWith("_of_cookie_") && str.endsWith("value")) {
                String strSubstring = str.substring(COOKIE_PREFIX_LEN, str.length() - COOKIE_VALUE_TAG_LEN);
                String str2 = "_of_cookie_" + strSubstring;
                String string = bundle.getString(str2 + "value");
                if (string == null) {
                    basicClientCookie = null;
                } else {
                    String string2 = bundle.getString(str2 + "path");
                    String string3 = bundle.getString(str2 + "domain");
                    String string4 = bundle.getString(str2 + "expiry");
                    basicClientCookie = new BasicClientCookie(strSubstring, string);
                    basicClientCookie.setPath(string2);
                    basicClientCookie.setDomain(string3);
                    if (string4 != null) {
                        basicClientCookie.setExpiryDate(dateFromString(string4));
                    }
                }
                super.addCookie(basicClientCookie);
            }
        }
    }

    public final synchronized void saveInstanceState(Bundle bundle) {
        for (Cookie cookie : super.getCookies()) {
            String name = cookie.getName();
            bundle.putString("_of_cookie_" + name + "value", cookie.getValue());
            bundle.putString("_of_cookie_" + name + "path", cookie.getPath());
            bundle.putString("_of_cookie_" + name + "domain", cookie.getDomain());
            Date expiryDate = cookie.getExpiryDate();
            if (expiryDate != null) {
                bundle.putString("_of_cookie_" + name + "expiry", DateUtils.formatDate(expiryDate));
            }
        }
    }
}
