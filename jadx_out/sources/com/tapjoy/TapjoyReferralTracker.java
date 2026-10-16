package com.tapjoy;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;

/* JADX INFO: loaded from: classes.dex */
public class TapjoyReferralTracker extends BroadcastReceiver {
    final String REFERRAL_TRACKING = "ReferralTracking";

    @Override // android.content.BroadcastReceiver
    public void onReceive(Context context, Intent intent) {
        TapjoyLog.i("ReferralTracking", "----------------------------------------");
        TapjoyLog.i("ReferralTracking", "RECEIVED REFERRAL INFO");
        String uri = intent.toURI();
        TapjoyLog.i("ReferralTracking", "referrer: [" + uri + "]");
        if (uri != null && uri.length() > 0) {
            int iIndexOf = uri.indexOf("referrer=");
            if (iIndexOf >= 0) {
                String strSubstring = uri.substring(iIndexOf, uri.length() - 4);
                TapjoyLog.i("ReferralTracking", "Referral URI: [" + strSubstring + "]");
                SharedPreferences.Editor editorEdit = context.getSharedPreferences(TapjoyConstants.TJC_PREFERENCE, 0).edit();
                editorEdit.putString(TapjoyConstants.PREF_REFERRAL_URL, strSubstring);
                editorEdit.putString(TapjoyConstants.PREF_REFERRER_DEBUG, uri);
                editorEdit.commit();
            } else {
                TapjoyLog.i("ReferralTracking", "No Referral URL.");
            }
        }
        TapjoyLog.i("ReferralTracking", "----------------------------------------");
    }
}
