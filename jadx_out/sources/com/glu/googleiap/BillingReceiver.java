package com.glu.googleiap;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import com.glu.android.iap.Debug;
import com.glu.android.iap.GluGoogleIAP;

/* JADX INFO: loaded from: classes.dex */
public class BillingReceiver extends BroadcastReceiver {
    @Override // android.content.BroadcastReceiver
    public void onReceive(Context context, Intent intent) {
        String action = intent.getAction();
        String str = "BillingReceiver.onReceive - " + action;
        Debug.log$552c4e01();
        if ("com.android.vending.billing.PURCHASE_STATE_CHANGED".equals(action)) {
            String stringExtra = intent.getStringExtra("inapp_signed_data");
            String stringExtra2 = intent.getStringExtra("inapp_signature");
            Intent intent2 = new Intent("com.android.vending.billing.PURCHASE_STATE_CHANGED");
            intent2.setClass(context, GluGoogleIAP.class);
            intent2.putExtra("inapp_signed_data", stringExtra);
            intent2.putExtra("inapp_signature", stringExtra2);
            context.startService(intent2);
            return;
        }
        if ("com.android.vending.billing.IN_APP_NOTIFY".equals(action)) {
            String stringExtra3 = intent.getStringExtra("notification_id");
            Intent intent3 = new Intent("com.glu.googleiap.GET_PURCHASE_INFORMATION");
            intent3.setClass(context, GluGoogleIAP.class);
            intent3.putExtra("notification_id", stringExtra3);
            context.startService(intent3);
            return;
        }
        if (!"com.android.vending.billing.RESPONSE_CODE".equals(action)) {
            String str2 = "unexpected action: " + action;
            Debug.log$552c4e01();
            return;
        }
        long longExtra = intent.getLongExtra("request_id", -1L);
        int intExtra = intent.getIntExtra("response_code", Consts.ResponseCode.RESULT_ERROR.ordinal());
        Intent intent4 = new Intent("com.android.vending.billing.RESPONSE_CODE");
        intent4.setClass(context, GluGoogleIAP.class);
        intent4.putExtra("request_id", longExtra);
        intent4.putExtra("response_code", intExtra);
        context.startService(intent4);
    }
}
