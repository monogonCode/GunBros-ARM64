package com.glu.googleiap;

import android.app.Activity;
import android.app.PendingIntent;
import android.content.Intent;
import android.content.IntentSender;
import android.os.Handler;
import com.glu.android.iap.Debug;
import com.glu.android.iap.GluGoogleIAP;
import java.lang.reflect.Method;

/* JADX INFO: loaded from: classes.dex */
public abstract class PurchaseObserver {
    private static final Class[] START_INTENT_SENDER_SIG = {IntentSender.class, Intent.class, Integer.TYPE, Integer.TYPE, Integer.TYPE};
    private final Activity mActivity;
    private final Handler mHandler;
    private Method mStartIntentSender;
    private Object[] mStartIntentSenderArgs = new Object[5];

    public PurchaseObserver(Activity activity, Handler handler) {
        this.mActivity = activity;
        this.mHandler = handler;
        try {
            this.mStartIntentSender = this.mActivity.getClass().getMethod("startIntentSender", START_INTENT_SENDER_SIG);
        } catch (NoSuchMethodException e) {
            this.mStartIntentSender = null;
        } catch (SecurityException e2) {
            this.mStartIntentSender = null;
        }
    }

    public abstract void onBillingSupported(boolean z);

    public abstract void onPurchaseStateChange$af83840(Consts.PurchaseState purchaseState, String str, long j);

    public abstract void onRequestPurchaseResponse(GluGoogleIAP.RequestPurchase requestPurchase, Consts.ResponseCode responseCode);

    public abstract void onRestoreTransactionsResponse$5f3371d6(Consts.ResponseCode responseCode);

    public abstract void onSubscriptionSupported(boolean z);

    final void postPurchaseStateChange$af83840(Consts.PurchaseState purchaseState, String str, long j) {
        onPurchaseStateChange$af83840(purchaseState, str, j);
    }

    final void startBuyPageActivity(PendingIntent pendingIntent, Intent intent) {
        if (this.mStartIntentSender == null) {
            try {
                pendingIntent.send(this.mActivity, 0, intent);
                return;
            } catch (PendingIntent.CanceledException e) {
                Debug.log$2d473e19();
                return;
            }
        }
        try {
            this.mStartIntentSenderArgs[0] = pendingIntent.getIntentSender();
            this.mStartIntentSenderArgs[1] = intent;
            this.mStartIntentSenderArgs[2] = 0;
            this.mStartIntentSenderArgs[3] = 0;
            this.mStartIntentSenderArgs[4] = 0;
            this.mStartIntentSender.invoke(this.mActivity, this.mStartIntentSenderArgs);
        } catch (Exception e2) {
            Debug.log$2d473e19();
        }
    }
}
