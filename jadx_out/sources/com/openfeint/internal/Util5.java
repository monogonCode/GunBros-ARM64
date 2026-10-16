package com.openfeint.internal;

import android.content.Context;

/* JADX INFO: loaded from: classes.dex */
public final class Util5 {
    public static String getAccountNameEclair(Context context) {
        try {
            Class<?> cls = Class.forName("android.accounts.AccountManager");
            return (String) Class.forName("android.accounts.Account").getField("name").get(((Object[]) cls.getMethod("getAccountsByType", String.class).invoke(cls.getMethod("get", Context.class).invoke(cls, context), "com.google"))[0]);
        } catch (Exception e) {
            return null;
        }
    }
}
