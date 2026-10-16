package com.urbanairship.util;

import android.content.Context;
import android.widget.Toast;
import com.urbanairship.Logger;
import com.urbanairship.UAirship;

/* JADX INFO: loaded from: classes.dex */
public class Toaster {
    public static void longerToast(String str) {
        toast(str, 1);
    }

    public static void simpleToast(String str) {
        toast(str, 0);
    }

    public static void toast(String str, int i) {
        Context applicationContext = UAirship.shared().getApplicationContext();
        if (applicationContext == null) {
            Logger.info("Toaster - applicationContext is null, bailing out");
        } else {
            Toast.makeText(applicationContext, str, i).show();
        }
    }
}
