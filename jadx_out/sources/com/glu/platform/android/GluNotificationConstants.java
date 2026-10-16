package com.glu.platform.android;

import android.content.Intent;
import com.urbanairship.push.PushManager;
import java.util.Arrays;
import java.util.List;
import java.util.Set;

/* JADX INFO: loaded from: classes.dex */
public final class GluNotificationConstants {
    static void logIntent(Intent intent) {
        Set<String> setKeySet = intent.getExtras().keySet();
        List listAsList = Arrays.asList("collapse_key", "from", PushManager.EXTRA_NOTIFICATION_ID, PushManager.EXTRA_PUSH_ID);
        String str = "Action: " + intent.getAction();
        for (String str2 : setKeySet) {
            if (!listAsList.contains(str2)) {
                String str3 = "Extra: " + str2 + ", value: " + intent.getStringExtra(str2);
            }
        }
    }
}
