package com.glu.platform.android;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.net.Uri;
import com.urbanairship.UAirship;
import com.urbanairship.push.PushManager;
import java.util.Arrays;
import java.util.Iterator;
import java.util.Set;

/* JADX INFO: loaded from: classes.dex */
public class GluPushHandler extends BroadcastReceiver {
    private static void logPushExtras(Intent intent) {
        for (String str : intent.getExtras().keySet()) {
            if (!Arrays.asList("collapse_key", "from", PushManager.EXTRA_NOTIFICATION_ID, PushManager.EXTRA_PUSH_ID, PushManager.EXTRA_ALERT).contains(str)) {
                String str2 = "Extra: " + str + ", value: " + intent.getStringExtra(str);
            }
        }
    }

    @Override // android.content.BroadcastReceiver
    public void onReceive(Context context, Intent intent) {
        boolean z;
        String str = "Received: " + intent.toString();
        String action = intent.getAction();
        if (action.equals(PushManager.ACTION_PUSH_RECEIVED)) {
            return;
        }
        if (!action.equals(PushManager.ACTION_NOTIFICATION_OPENED)) {
            if (action.equals(PushManager.ACTION_REGISTRATION_FINISHED)) {
                String str2 = "Handling ACTION_REGISTRATION_FINISHED - apid: " + intent.getStringExtra(PushManager.EXTRA_APID) + ", valid: " + intent.getBooleanExtra(PushManager.EXTRA_REGISTRATION_VALID, false);
                return;
            }
            return;
        }
        Set<String> setKeySet = intent.getExtras().keySet();
        Iterator<String> it = setKeySet.iterator();
        while (true) {
            if (!it.hasNext()) {
                z = false;
                break;
            }
            String next = it.next();
            if (next.toLowerCase().equals("url")) {
                String stringExtra = intent.getStringExtra(next);
                Uri uri = Uri.parse(stringExtra);
                String str3 = "launching url: " + stringExtra;
                Intent intent2 = new Intent("android.intent.action.VIEW", uri);
                intent2.setFlags(268435456);
                UAirship.shared().getApplicationContext().startActivity(intent2);
                z = true;
                break;
            }
        }
        if (z) {
            return;
        }
        String str4 = new String("{\"android\": {\"alert\": \"" + intent.getStringExtra(PushManager.EXTRA_ALERT) + "\"}");
        Iterator<String> it2 = setKeySet.iterator();
        while (true) {
            String str5 = str4;
            if (!it2.hasNext()) {
                String str6 = str5 + "}";
                String str7 = "Handling ACTION_NOTIFICATION_OPENED - payload: " + str6;
                logPushExtras(intent);
                Intent intent3 = new Intent(intent);
                intent3.setAction("com.glu.platform.android.CLEAR_PUSH_NOTIFICATION_OPENED");
                intent3.putExtra("com.glu.platform.android.PUSH_NOTIFICATION_PAYLOAD", str6);
                intent3.setClass(context, GluNotificationService.class);
                context.startService(intent3);
                return;
            }
            String next2 = it2.next();
            str4 = !Arrays.asList("collapse_key", "from", PushManager.EXTRA_NOTIFICATION_ID, PushManager.EXTRA_PUSH_ID, PushManager.EXTRA_ALERT).contains(next2) ? str5 + ", \"" + next2 + "\": " + intent.getStringExtra(next2) : str5;
        }
    }
}
