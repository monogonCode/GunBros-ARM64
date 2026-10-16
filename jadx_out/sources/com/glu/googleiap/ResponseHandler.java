package com.glu.googleiap;

import android.app.PendingIntent;
import android.content.Intent;
import com.glu.android.iap.GluGoogleIAP;

/* JADX INFO: loaded from: classes.dex */
public class ResponseHandler {
    private static PurchaseObserver sPurchaseObserver;

    public static void buyPageIntentResponse(PendingIntent pendingIntent, Intent intent) {
        if (sPurchaseObserver == null) {
            return;
        }
        sPurchaseObserver.startBuyPageActivity(pendingIntent, intent);
    }

    public static void checkBillingSupportedResponse(boolean z) {
        if (sPurchaseObserver != null) {
            sPurchaseObserver.onBillingSupported(z);
        }
    }

    public static void checkSubscriptionSupportedResponse(boolean z) {
        if (sPurchaseObserver != null) {
            sPurchaseObserver.onSubscriptionSupported(z);
        }
    }

    public static void purchaseResponse$20db4f51$63f6ffa7(Consts.PurchaseState purchaseState, String str, long j) {
        synchronized (ResponseHandler.class) {
            if (sPurchaseObserver != null) {
                sPurchaseObserver.postPurchaseStateChange$af83840(purchaseState, str, j);
            }
        }
    }

    public static synchronized void register(PurchaseObserver purchaseObserver) {
        sPurchaseObserver = purchaseObserver;
    }

    public static void responseCodeReceived$2193dfa7(GluGoogleIAP.RequestPurchase requestPurchase, Consts.ResponseCode responseCode) {
        if (sPurchaseObserver != null) {
            sPurchaseObserver.onRequestPurchaseResponse(requestPurchase, responseCode);
        }
    }

    public static void responseCodeReceived$7a897b94$5f3371d6(Consts.ResponseCode responseCode) {
        if (sPurchaseObserver != null) {
            sPurchaseObserver.onRestoreTransactionsResponse$5f3371d6(responseCode);
        }
    }

    public static synchronized void unregister$4b5e3270() {
        sPurchaseObserver = null;
    }
}
