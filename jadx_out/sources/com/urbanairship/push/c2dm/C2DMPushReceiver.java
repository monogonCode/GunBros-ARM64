package com.urbanairship.push.c2dm;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import com.urbanairship.AirshipConfigOptions;
import com.urbanairship.Logger;
import com.urbanairship.UAirship;
import com.urbanairship.push.PushManager;
import java.util.HashMap;

/* JADX INFO: loaded from: classes.dex */
public class C2DMPushReceiver extends BroadcastReceiver {
    public static final String INTENT_RECEIVE = "com.google.android.c2dm.intent.RECEIVE";
    public static final String INTENT_REGISTRATION = "com.google.android.c2dm.intent.REGISTRATION";

    private void handleRegistrationIntent(Context context, Intent intent) {
        if (UAirship.shared().getAirshipConfigOptions().getTransport() == AirshipConfigOptions.TransportType.HELIUM) {
            return;
        }
        String stringExtra = intent.getStringExtra("registration_id");
        String stringExtra2 = intent.getStringExtra("error");
        String stringExtra3 = intent.getStringExtra("unregistered");
        if (stringExtra2 != null) {
            Logger.error("Got error:" + stringExtra2);
            PushManager.shared().c2dmRegistrationFailed(stringExtra2);
        } else if (stringExtra3 != null) {
            Logger.info("Unregistered from C2DM: " + stringExtra3);
        } else if (stringExtra != null) {
            Logger.info("Got C2DM registration id:" + stringExtra);
            PushManager.shared().c2dmRegistrationResponseReceived(stringExtra);
        }
    }

    protected void handleMessage(Context context, Intent intent) {
        HashMap map = new HashMap();
        for (String str : intent.getExtras().keySet()) {
            map.put(str, intent.getStringExtra(str));
        }
        String str2 = (String) map.remove(PushManager.EXTRA_ALERT);
        String str3 = (String) map.remove(PushManager.EXTRA_PUSH_ID);
        Logger.info("Got C2DM push: " + str3);
        PushManager.deliverPush(str2, str3, map);
    }

    @Override // android.content.BroadcastReceiver
    public void onReceive(Context context, Intent intent) {
        String action = intent.getAction();
        if (action.equals(INTENT_REGISTRATION)) {
            handleRegistrationIntent(context, intent);
            setResult(-1, null, null);
        } else if (!action.equals(INTENT_RECEIVE)) {
            Logger.warn("Received unknown action: " + action);
        } else {
            handleMessage(context, intent);
            setResult(-1, null, null);
        }
    }
}
