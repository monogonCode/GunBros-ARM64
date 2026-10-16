package com.urbanairship;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import com.urbanairship.analytics.Analytics;
import com.urbanairship.push.PushManager;

/* JADX INFO: loaded from: classes.dex */
public class CoreReceiver extends BroadcastReceiver {
    @Override // android.content.BroadcastReceiver
    public void onReceive(Context context, Intent intent) {
        String action = intent.getAction();
        if (action.equals("android.intent.action.ACTION_SHUTDOWN")) {
            PushManager.stopService();
            return;
        }
        if (action.equals("android.intent.action.BOOT_COMPLETED")) {
            PushManager.startService();
            return;
        }
        if (Analytics.ACTION_ANALYTICS_START.equals(action)) {
            UAirship.shared().getAnalytics().startUploadingIfNecessary();
            return;
        }
        if (action.startsWith(PushManager.ACTION_NOTIFICATION_OPENED_PROXY)) {
            Logger.debug("Received push conversion: " + intent.getStringExtra(PushManager.EXTRA_PUSH_ID));
            UAirship.shared().getAnalytics().setConversionPushId(intent.getStringExtra(PushManager.EXTRA_PUSH_ID));
            if (PushManager.shared().getIntentReceiver() == null) {
                Logger.debug("No intent receiver set, not sending ACTION_NOTIFICATION_OPENED");
                return;
            }
            Intent intent2 = new Intent(PushManager.ACTION_NOTIFICATION_OPENED);
            intent2.setClass(UAirship.shared().getApplicationContext(), PushManager.shared().getIntentReceiver());
            intent2.putExtras(intent.getExtras());
            UAirship.shared().getApplicationContext().sendBroadcast(intent2);
        }
    }
}
