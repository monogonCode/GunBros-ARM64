package com.glu.platform.android;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;

/* JADX INFO: loaded from: classes.dex */
public class GluBroadcastHandler extends BroadcastReceiver {
    private static Intent createNotificationsStartIntent(Context context) {
        Intent intent = new Intent(context, (Class<?>) GluNotificationService.class);
        intent.setAction("com.glu.platform.android.START_NOTIFICATIONS");
        return intent;
    }

    private static Intent createNotificationsStopIntent(Context context) {
        Intent intent = new Intent(context, (Class<?>) GluNotificationService.class);
        intent.setAction("com.glu.platform.android.STOP_NOTIFICATIONS");
        return intent;
    }

    @Override // android.content.BroadcastReceiver
    public void onReceive(Context context, Intent intent) {
        String action = intent.getAction();
        if (action.equals("com.glu.platform.android.ENABLE_NOTIFICATIONS")) {
            boolean booleanExtra = intent.getBooleanExtra("com.glu.platform.android.ENABLE_NOTIFICATIONS_ENABLE", false);
            String str = "Handling ACTION_ENABLE_NOTIFICATIONS: " + booleanExtra;
            if (!booleanExtra) {
                context.startService(createNotificationsStopIntent(context));
            }
            Intent intent2 = new Intent(context, (Class<?>) GluNotificationService.class);
            intent2.setAction("com.glu.platform.android.ENABLE_NOTIFICATIONS");
            intent2.putExtra("com.glu.platform.android.ENABLE_NOTIFICATIONS_ENABLE", booleanExtra);
            context.startService(intent2);
            if (booleanExtra) {
                context.startService(createNotificationsStartIntent(context));
                return;
            }
            return;
        }
        if (action.equals("android.intent.action.BOOT_COMPLETED")) {
            if (GluNotificationService.AreNotificationsEnabled(context)) {
                context.startService(createNotificationsStartIntent(context));
            }
        } else if (action.equals("android.intent.action.ACTION_SHUTDOWN")) {
            if (GluNotificationService.AreNotificationsEnabled(context)) {
                context.startService(createNotificationsStopIntent(context));
            }
        } else {
            if (action.equals("android.intent.action.SCREEN_ON") || action.equals("android.intent.action.DATE_CHANGED") || action.equals("android.intent.action.LOCALE_CHANGED") || action.equals("android.intent.action.TIMEZONE_CHANGED")) {
                return;
            }
            action.equals("android.intent.action.TIME_SET");
        }
    }
}
