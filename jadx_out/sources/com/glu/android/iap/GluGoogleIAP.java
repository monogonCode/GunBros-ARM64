package com.glu.android.iap;

import android.app.PendingIntent;
import android.app.Service;
import android.content.ComponentName;
import android.content.Intent;
import android.content.ServiceConnection;
import android.content.SharedPreferences;
import android.os.Build;
import android.os.Bundle;
import android.os.Handler;
import android.os.IBinder;
import android.os.RemoteException;
import com.android.vending.billing.IMarketBillingService;
import com.glu.googleiap.Consts;
import com.glu.googleiap.PurchaseObserver;
import com.glu.googleiap.ResponseHandler;
import com.glu.googleiap.Security;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.LinkedList;
import java.util.Vector;

/* JADX INFO: loaded from: classes.dex */
public class GluGoogleIAP extends Service implements ServiceConnection, IAP.IAPObject {
    private static final String DB_INITIALIZED = "db_initialized";
    private static final String DEFAULT_LANGUAGE = "en";
    private static final String GOOGLE_IAP_FAILED_STRING = "~";
    private static int m_asynchronousItemGiveTimer;
    private static int m_asynchronousItemRemoveTimer;
    private static IMarketBillingService m_billingService;
    private static boolean m_billingSupported;
    private static boolean m_billingVerified;
    private static Thread m_buyProductThread;
    private static int m_initRetryTimer;
    private static boolean m_initialized;
    private static LinkedList<BillingRequest> m_pendingRequests;
    private static GluPurchaseObserver m_purchaseObserver;
    private static int m_purchaseTimeoutTimer;
    private static GIAPSaveFile m_purchasedItemLog;
    private static int m_purchasingState;
    private static GIAPSaveFile m_refundedItemLog;
    private static boolean m_restoreTransactionsInProgress;
    private static boolean m_restoredTransactions;
    private static String m_savedProductId;
    private static HashMap<Long, BillingRequest> m_sentRequests;
    private static boolean m_subscriptionSupported;
    private static Handler m_handler = null;
    public static GluGoogleIAP instance = null;
    private static final Object ITEM_MANAGEMENT_LOCK = new Object();

    public static abstract class BillingRequest {
        protected long m_requestId;
        private final int m_startId;

        public BillingRequest(int i) {
            Debug.log$552c4e01();
            this.m_startId = i;
        }

        protected static void logResponseCode(String str, Bundle bundle) {
            String str2 = str + " received " + Consts.ResponseCode.valueOf(bundle.getInt("RESPONSE_CODE")).toString();
            Debug.log$552c4e01();
        }

        protected static Bundle makeRequestBundle(String str) {
            return makeRequestBundle(str, 1);
        }

        protected static Bundle makeRequestBundle(String str, int i) {
            Bundle bundle = new Bundle();
            bundle.putString("BILLING_REQUEST", str);
            String str2 = "makeRequestBundle.method - " + str;
            Debug.log$552c4e01();
            bundle.putInt("API_VERSION", i);
            bundle.putString("PACKAGE_NAME", IAPJava.m_activity.getPackageName());
            String str3 = "makeRequestBundle.package - " + IAPJava.m_activity.getPackageName();
            Debug.log$552c4e01();
            return bundle;
        }

        public final int getStartId() {
            return this.m_startId;
        }

        protected void onRemoteException(RemoteException remoteException) {
            Debug.log$2d473e19();
            GluGoogleIAP gluGoogleIAP = GluGoogleIAP.instance;
            IMarketBillingService unused = GluGoogleIAP.m_billingService = null;
        }

        protected void responseCodeReceived(Consts.ResponseCode responseCode) {
        }

        protected abstract long run() throws RemoteException;

        public final boolean runIfConnected() {
            getClass().getSimpleName();
            Debug.log$552c4e01();
            GluGoogleIAP gluGoogleIAP = GluGoogleIAP.instance;
            if (GluGoogleIAP.m_billingService != null) {
                try {
                    this.m_requestId = run();
                    String str = "request id: " + this.m_requestId;
                    Debug.log$552c4e01();
                    if (this.m_requestId >= 0) {
                        GluGoogleIAP gluGoogleIAP2 = GluGoogleIAP.instance;
                        GluGoogleIAP.m_sentRequests.put(Long.valueOf(this.m_requestId), this);
                    }
                    return true;
                } catch (RemoteException e) {
                    onRemoteException(e);
                }
            }
            return false;
        }

        public final boolean runRequest() {
            if (runIfConnected()) {
                return true;
            }
            if (!GluGoogleIAP.instance.bindToMarketBillingService()) {
                return false;
            }
            Debug.log$552c4e01();
            GluGoogleIAP gluGoogleIAP = GluGoogleIAP.instance;
            GluGoogleIAP.m_pendingRequests.add(this);
            return true;
        }
    }

    public static class CheckBillingSupported extends BillingRequest {
        public CheckBillingSupported() {
            super(-1);
            Debug.log$552c4e01();
        }

        @Override // com.glu.android.iap.GluGoogleIAP.BillingRequest
        protected final long run() throws RemoteException {
            Bundle bundleMakeRequestBundle = makeRequestBundle("CHECK_BILLING_SUPPORTED");
            GluGoogleIAP gluGoogleIAP = GluGoogleIAP.instance;
            int i = GluGoogleIAP.m_billingService.sendBillingRequest(bundleMakeRequestBundle).getInt("RESPONSE_CODE");
            String str = "CheckBillingSupported response code: " + Consts.ResponseCode.valueOf(i) + "  packageID=" + IAPJava.m_activity.getPackageName();
            Debug.log$552c4e01();
            ResponseHandler.checkBillingSupportedResponse(i == Consts.ResponseCode.RESULT_OK.ordinal());
            return Consts.BILLING_RESPONSE_INVALID_REQUEST_ID;
        }
    }

    public static class CheckSubscriptionSupported extends BillingRequest {
        public CheckSubscriptionSupported() {
            super(-1);
            Debug.log$552c4e01();
        }

        @Override // com.glu.android.iap.GluGoogleIAP.BillingRequest
        protected final long run() throws RemoteException {
            Bundle bundleMakeRequestBundle = makeRequestBundle("CHECK_BILLING_SUPPORTED", 2);
            bundleMakeRequestBundle.putString("ITEM_TYPE", "subs");
            GluGoogleIAP gluGoogleIAP = GluGoogleIAP.instance;
            int i = GluGoogleIAP.m_billingService.sendBillingRequest(bundleMakeRequestBundle).getInt("RESPONSE_CODE");
            String str = "CheckSubSupported response code: " + Consts.ResponseCode.valueOf(i) + "  packageID=" + IAPJava.m_activity.getPackageName();
            Debug.log$552c4e01();
            ResponseHandler.checkSubscriptionSupportedResponse(i == Consts.ResponseCode.RESULT_OK.ordinal());
            return Consts.BILLING_RESPONSE_INVALID_REQUEST_ID;
        }
    }

    public static class ConfirmNotifications extends BillingRequest {
        final String[] m_notifyIds;

        public ConfirmNotifications(int i, String[] strArr) {
            super(i);
            this.m_notifyIds = strArr;
        }

        @Override // com.glu.android.iap.GluGoogleIAP.BillingRequest
        protected final long run() throws RemoteException {
            Bundle bundleMakeRequestBundle = makeRequestBundle("CONFIRM_NOTIFICATIONS");
            bundleMakeRequestBundle.putStringArray("NOTIFY_IDS", this.m_notifyIds);
            GluGoogleIAP gluGoogleIAP = GluGoogleIAP.instance;
            Bundle bundleSendBillingRequest = GluGoogleIAP.m_billingService.sendBillingRequest(bundleMakeRequestBundle);
            logResponseCode("confirmNotifications", bundleSendBillingRequest);
            return bundleSendBillingRequest.getLong("REQUEST_ID", Consts.BILLING_RESPONSE_INVALID_REQUEST_ID);
        }
    }

    private static class GIAPSaveFile {
        private String m_filename;
        private Vector<GIAPSingleItem> m_items = new Vector<>();
        private boolean m_loaded = false;
        private boolean m_exceptionOnSave = false;

        private class GIAPSingleItem {
            private String productId = null;
            private boolean consumed = false;
            private long longId = 0;
            private byte[] reserved = new byte[32];

            public GIAPSingleItem() {
                for (int i = 0; i < this.reserved.length; i++) {
                    this.reserved[i] = 0;
                }
            }
        }

        public GIAPSaveFile(String str) {
            this.m_filename = null;
            this.m_filename = str;
        }

        private GIAPSingleItem getTopItem() {
            int i = 0;
            while (true) {
                int i2 = i;
                if (i2 >= this.m_items.size()) {
                    Debug.log$552c4e01();
                    return null;
                }
                if (!this.m_items.elementAt(i2).consumed) {
                    return this.m_items.elementAt(i2);
                }
                i = i2 + 1;
            }
        }

        private void loadFile() {
            if (this.m_loaded) {
                return;
            }
            this.m_loaded = true;
            String str = "Loading " + this.m_filename;
            Debug.log$552c4e01();
            try {
                File file = new File(GluUtil.getSecureSaveDirectory() + this.m_filename);
                if (file.exists()) {
                    FileInputStream fileInputStream = new FileInputStream(file);
                    fileInputStream.skip(8L);
                    boolean z = false;
                    while (fileInputStream.available() > 0) {
                        GIAPSingleItem gIAPSingleItem = new GIAPSingleItem();
                        gIAPSingleItem.productId = GluUtil.readString(fileInputStream);
                        gIAPSingleItem.longId = GluUtil.readLong(fileInputStream);
                        gIAPSingleItem.consumed = fileInputStream.read() == 1;
                        fileInputStream.read(gIAPSingleItem.reserved);
                        this.m_items.add(gIAPSingleItem);
                        String str2 = "Loading " + gIAPSingleItem.productId + " " + gIAPSingleItem.longId + " " + gIAPSingleItem.consumed;
                        Debug.log$552c4e01();
                        z = true;
                    }
                    fileInputStream.close();
                    if (!z || GluUtil.verifySecureFile(file)) {
                        return;
                    }
                    String str3 = "File " + this.m_filename + " integrity failed.";
                    Debug.log$552c4e01();
                    file.delete();
                    this.m_items.removeAllElements();
                }
            } catch (Exception e) {
                String str4 = "Exception loading file " + this.m_filename + ". Come on, you can be cleaner than that.";
                Debug.log$2d473e19();
            }
        }

        private void removeTopItem() {
            getTopItem().consumed = true;
            saveFile();
        }

        private void saveFile() {
            String str = "Saving " + this.m_filename;
            Debug.log$552c4e01();
            try {
                File file = new File(GluUtil.getSecureSaveDirectory() + this.m_filename);
                FileOutputStream fileOutputStream = new FileOutputStream(GluUtil.getTmpSecureFile(), false);
                for (int i = 0; i < this.m_items.size(); i++) {
                    GluUtil.writeString(fileOutputStream, this.m_items.elementAt(i).productId);
                    GluUtil.writeLong(fileOutputStream, this.m_items.elementAt(i).longId);
                    fileOutputStream.write(this.m_items.elementAt(i).consumed ? 1 : 0);
                    fileOutputStream.write(this.m_items.elementAt(i).reserved);
                    String str2 = "Saving " + this.m_items.elementAt(i).productId + " " + this.m_items.elementAt(i).longId + " " + this.m_items.elementAt(i).consumed;
                    Debug.log$552c4e01();
                }
                fileOutputStream.close();
                GluUtil.saveSecureFile(file);
                this.m_exceptionOnSave = false;
            } catch (Exception e) {
                String str3 = "Exception saving file " + this.m_filename + ". Come on, you can be cleaner than that.";
                Debug.log$2d473e19();
                this.m_exceptionOnSave = true;
            }
        }

        public final void addItem(String str, long j) {
            loadFile();
            for (int i = 0; i < this.m_items.size(); i++) {
                if (this.m_items.elementAt(i).longId == j) {
                    return;
                }
            }
            GIAPSingleItem gIAPSingleItem = new GIAPSingleItem();
            gIAPSingleItem.productId = str;
            gIAPSingleItem.longId = j;
            gIAPSingleItem.consumed = false;
            this.m_items.add(gIAPSingleItem);
            saveFile();
        }

        public final boolean hasUnhandledItems() {
            loadFile();
            boolean z = false;
            for (int i = 0; i < this.m_items.size(); i++) {
                if (!this.m_items.elementAt(i).consumed) {
                    z = true;
                }
            }
            return z;
        }

        public final boolean immediatelyGiveSpecificItem(String str) {
            GIAPSingleItem gIAPSingleItemElementAt;
            if (!hasUnhandledItems()) {
                Debug.log$552c4e01();
                return false;
            }
            for (int i = 0; i < this.m_items.size(); i++) {
                if (this.m_items.elementAt(i).productId.equals(str) && !this.m_items.elementAt(i).consumed) {
                    gIAPSingleItemElementAt = this.m_items.elementAt(i);
                    String str2 = "immediatelyGiveSpecificItem " + str;
                    Debug.log$552c4e01();
                    IAPJava.iapCallbackEventS(2, 0, IAP.m_realToNativeProductIdHash.get(gIAPSingleItemElementAt.productId));
                    gIAPSingleItemElementAt.consumed = true;
                    saveFile();
                    return true;
                }
            }
            Debug.log$552c4e01();
            gIAPSingleItemElementAt = null;
            String str3 = "immediatelyGiveSpecificItem " + str;
            Debug.log$552c4e01();
            IAPJava.iapCallbackEventS(2, 0, IAP.m_realToNativeProductIdHash.get(gIAPSingleItemElementAt.productId));
            gIAPSingleItemElementAt.consumed = true;
            saveFile();
            return true;
        }

        public final boolean isValid() {
            return !this.m_exceptionOnSave;
        }

        public final boolean tryGivingOneItem(boolean z) {
            if (!hasUnhandledItems()) {
                Debug.log$552c4e01();
                return false;
            }
            if (!GluGoogleIAP.instance.asynchronousGiveUserItem(getTopItem().productId, z)) {
                return false;
            }
            removeTopItem();
            return true;
        }

        public final boolean tryRefundingOneItem() {
            if (!hasUnhandledItems()) {
                Debug.log$552c4e01();
                return false;
            }
            if (!GluGoogleIAP.instance.asynchronousRemoveUserItem(getTopItem().productId)) {
                return false;
            }
            removeTopItem();
            return true;
        }
    }

    public static class GetPurchaseInformation extends BillingRequest {
        long m_cryptographicNonce;
        final String[] m_notifyIds;

        public GetPurchaseInformation(int i, String[] strArr) {
            super(i);
            this.m_notifyIds = strArr;
        }

        @Override // com.glu.android.iap.GluGoogleIAP.BillingRequest
        protected final void onRemoteException(RemoteException remoteException) {
            super.onRemoteException(remoteException);
            Security.removeNonce(this.m_cryptographicNonce);
        }

        @Override // com.glu.android.iap.GluGoogleIAP.BillingRequest
        protected final long run() throws RemoteException {
            this.m_cryptographicNonce = Security.generateNonce();
            Bundle bundleMakeRequestBundle = makeRequestBundle("GET_PURCHASE_INFORMATION");
            bundleMakeRequestBundle.putLong("NONCE", this.m_cryptographicNonce);
            bundleMakeRequestBundle.putStringArray("NOTIFY_IDS", this.m_notifyIds);
            GluGoogleIAP gluGoogleIAP = GluGoogleIAP.instance;
            Bundle bundleSendBillingRequest = GluGoogleIAP.m_billingService.sendBillingRequest(bundleMakeRequestBundle);
            logResponseCode("getPurchaseInformation", bundleSendBillingRequest);
            return bundleSendBillingRequest.getLong("REQUEST_ID", Consts.BILLING_RESPONSE_INVALID_REQUEST_ID);
        }
    }

    private static class GluPurchaseObserver extends PurchaseObserver {
        public GluPurchaseObserver(Handler handler) {
            super(IAPJava.m_activity, handler);
        }

        @Override // com.glu.googleiap.PurchaseObserver
        public final void onBillingSupported(boolean z) {
            String str = "supported: " + z;
            Debug.log$552c4e01();
            GluGoogleIAP gluGoogleIAP = GluGoogleIAP.instance;
            boolean unused = GluGoogleIAP.m_billingSupported = z;
            GluGoogleIAP gluGoogleIAP2 = GluGoogleIAP.instance;
            boolean unused2 = GluGoogleIAP.m_billingVerified = true;
        }

        /* JADX WARN: Code duplicated, block: B:14:0x002a A[Catch: all -> 0x002e, TRY_LEAVE, TryCatch #0 {, blocks: (B:4:0x0005, B:6:0x0009, B:8:0x0011, B:10:0x001d, B:11:0x0023, B:12:0x0028, B:14:0x002a, B:19:0x0031, B:21:0x0035, B:22:0x003b, B:24:0x003f, B:26:0x004a, B:27:0x0051), top: B:29:0x0005 }] */
        @Override // com.glu.googleiap.PurchaseObserver
        public final void onPurchaseStateChange$af83840(Consts.PurchaseState purchaseState, String str, long j) {
            synchronized (GluGoogleIAP.ITEM_MANAGEMENT_LOCK) {
                if (purchaseState == Consts.PurchaseState.PURCHASED) {
                    if (GluGoogleIAP.instance.transactionInProgress()) {
                        GluGoogleIAP gluGoogleIAP = GluGoogleIAP.instance;
                        if (str.equals(GluGoogleIAP.m_savedProductId)) {
                            GluGoogleIAP gluGoogleIAP2 = GluGoogleIAP.instance;
                            int unused = GluGoogleIAP.m_purchasingState = 1;
                        } else {
                            IAP.displayAsyncSuccessMessage();
                        }
                    } else {
                        IAP.displayAsyncSuccessMessage();
                    }
                    GluGoogleIAP.instance.storeItemToAdd(str, j);
                } else if (purchaseState == Consts.PurchaseState.REFUNDED) {
                    GluGoogleIAP.instance.storeItemToRemove(str, j);
                } else if (purchaseState == Consts.PurchaseState.CANCELED) {
                    Debug.log$552c4e01();
                    if (GluGoogleIAP.instance.transactionInProgress()) {
                        GluGoogleIAP gluGoogleIAP3 = GluGoogleIAP.instance;
                        int unused2 = GluGoogleIAP.m_purchasingState = 2;
                    } else {
                        IAP.displayAsyncFailureMessage();
                    }
                }
            }
        }

        @Override // com.glu.googleiap.PurchaseObserver
        public final void onRequestPurchaseResponse(RequestPurchase requestPurchase, Consts.ResponseCode responseCode) {
            String str = requestPurchase.m_productId + ": " + responseCode;
            Debug.log$552c4e01();
            if (responseCode == Consts.ResponseCode.RESULT_OK) {
                Debug.log$552c4e01();
                return;
            }
            if (responseCode == Consts.ResponseCode.RESULT_USER_CANCELED) {
                Debug.log$552c4e01();
                GluGoogleIAP gluGoogleIAP = GluGoogleIAP.instance;
                int unused = GluGoogleIAP.m_purchasingState = 3;
            } else {
                Debug.log$552c4e01();
                GluGoogleIAP gluGoogleIAP2 = GluGoogleIAP.instance;
                int unused2 = GluGoogleIAP.m_purchasingState = 2;
            }
        }

        @Override // com.glu.googleiap.PurchaseObserver
        public final void onRestoreTransactionsResponse$5f3371d6(Consts.ResponseCode responseCode) {
            String str = "completed RestoreTransactions request = " + responseCode;
            Debug.log$552c4e01();
            if (responseCode == Consts.ResponseCode.RESULT_OK) {
                SharedPreferences.Editor editorEdit = IAPJava.m_activity.getPreferences(0).edit();
                editorEdit.putBoolean(GluGoogleIAP.DB_INITIALIZED, true);
                editorEdit.commit();
            }
        }

        @Override // com.glu.googleiap.PurchaseObserver
        public final void onSubscriptionSupported(boolean z) {
            String str = "subs supported: " + z;
            Debug.log$552c4e01();
            GluGoogleIAP gluGoogleIAP = GluGoogleIAP.instance;
            boolean unused = GluGoogleIAP.m_subscriptionSupported = z;
            GluGoogleIAP gluGoogleIAP2 = GluGoogleIAP.instance;
            boolean unused2 = GluGoogleIAP.m_billingVerified = true;
        }
    }

    public static class RequestPurchase extends BillingRequest {
        public final String m_developerPayload;
        public final String m_productId;

        public RequestPurchase(String str) {
            this(str, null);
        }

        public RequestPurchase(String str, String str2) {
            super(-1);
            this.m_productId = str;
            this.m_developerPayload = str2;
        }

        @Override // com.glu.android.iap.GluGoogleIAP.BillingRequest
        protected final void responseCodeReceived(Consts.ResponseCode responseCode) {
            GluGoogleIAP gluGoogleIAP = GluGoogleIAP.instance;
            ResponseHandler.responseCodeReceived$2193dfa7(this, responseCode);
        }

        @Override // com.glu.android.iap.GluGoogleIAP.BillingRequest
        protected final long run() throws RemoteException {
            Bundle bundleMakeRequestBundle = makeRequestBundle("REQUEST_PURCHASE", this.m_productId.endsWith("monthly") ? 2 : 1);
            if (this.m_productId.endsWith("monthly")) {
                bundleMakeRequestBundle.putString("ITEM_TYPE", "subs");
            }
            bundleMakeRequestBundle.putString("ITEM_ID", this.m_productId);
            String str = "run.m_productId - " + this.m_productId;
            Debug.log$552c4e01();
            if (this.m_developerPayload != null) {
                bundleMakeRequestBundle.putString("DEVELOPER_PAYLOAD", this.m_developerPayload);
                String str2 = this.m_developerPayload;
                Debug.log$16da05f7();
            }
            GluGoogleIAP gluGoogleIAP = GluGoogleIAP.instance;
            Bundle bundleSendBillingRequest = GluGoogleIAP.m_billingService.sendBillingRequest(bundleMakeRequestBundle);
            PendingIntent pendingIntent = (PendingIntent) bundleSendBillingRequest.getParcelable("PURCHASE_INTENT");
            if (pendingIntent == null) {
                Debug.log$552c4e01();
                GluGoogleIAP.instance.currentItemFailed();
                return Consts.BILLING_RESPONSE_INVALID_REQUEST_ID;
            }
            Intent intent = new Intent();
            Debug.log$552c4e01();
            ResponseHandler.buyPageIntentResponse(pendingIntent, intent);
            long j = bundleSendBillingRequest.getLong("REQUEST_ID", Consts.BILLING_RESPONSE_INVALID_REQUEST_ID);
            String str3 = "Done with RequestPurchase, requestId(this still valid?) = " + j;
            Debug.log$552c4e01();
            return j;
        }
    }

    public static class RestoreTransactions extends BillingRequest {
        long m_cryptographicNonce;

        public RestoreTransactions() {
            super(-1);
        }

        @Override // com.glu.android.iap.GluGoogleIAP.BillingRequest
        protected final void onRemoteException(RemoteException remoteException) {
            super.onRemoteException(remoteException);
            Security.removeNonce(this.m_cryptographicNonce);
        }

        @Override // com.glu.android.iap.GluGoogleIAP.BillingRequest
        protected final void responseCodeReceived(Consts.ResponseCode responseCode) {
            GluGoogleIAP gluGoogleIAP = GluGoogleIAP.instance;
            ResponseHandler.responseCodeReceived$7a897b94$5f3371d6(responseCode);
        }

        @Override // com.glu.android.iap.GluGoogleIAP.BillingRequest
        protected final long run() throws RemoteException {
            this.m_cryptographicNonce = Security.generateNonce();
            Bundle bundleMakeRequestBundle = makeRequestBundle("RESTORE_TRANSACTIONS");
            bundleMakeRequestBundle.putLong("NONCE", this.m_cryptographicNonce);
            GluGoogleIAP gluGoogleIAP = GluGoogleIAP.instance;
            Bundle bundleSendBillingRequest = GluGoogleIAP.m_billingService.sendBillingRequest(bundleMakeRequestBundle);
            logResponseCode("restoreTransactions", bundleSendBillingRequest);
            return bundleSendBillingRequest.getLong("REQUEST_ID", Consts.BILLING_RESPONSE_INVALID_REQUEST_ID);
        }
    }

    public GluGoogleIAP() {
        Debug.log$552c4e01();
    }

    public GluGoogleIAP(IAP iap) {
        initStatics();
        Debug.log$552c4e01();
        IAP.instance = this;
        instance = this;
        attachBaseContext(IAPJava.m_activity);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public boolean asynchronousGiveUserItem(String str, boolean z) {
        return IAPJava.iapCallbackEventS(5, z ? 1 : 0, str) != 0;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public boolean asynchronousRemoveUserItem(String str) {
        return IAPJava.iapCallbackEventS(6, 0, IAP.m_realToNativeProductIdHash.get(str)) != 0;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public boolean bindToMarketBillingService() {
        if (IAPJava.m_activity == null) {
            Debug.log$552c4e01();
            return false;
        }
        try {
            Debug.log$552c4e01();
            if (bindService(new Intent("com.android.vending.billing.MarketBillingService.BIND"), this, 1)) {
                return true;
            }
            Debug.log$552c4e01();
            return false;
        } catch (SecurityException e) {
            String str = "Security exception: " + e;
            Debug.log$552c4e01();
            return false;
        }
    }

    private void cancelCurrentItem() {
        IAPJava.iapCallbackEventS(1, 0, IAP.m_realToNativeProductIdHash.get(m_savedProductId));
        m_savedProductId = null;
        m_purchaseTimeoutTimer = 16435934;
        m_purchasingState = 0;
    }

    private boolean checkBillingSupported() {
        Debug.log$552c4e01();
        return new CheckBillingSupported().runRequest();
    }

    private void checkResponseCode(long j, Consts.ResponseCode responseCode) {
        String str = "received response for request " + j + ": " + responseCode;
        Debug.log$552c4e01();
        BillingRequest billingRequest = m_sentRequests.get(Long.valueOf(j));
        if (billingRequest == null) {
            return;
        }
        synchronized (ITEM_MANAGEMENT_LOCK) {
            if ((billingRequest instanceof RequestPurchase) && responseCode != Consts.ResponseCode.RESULT_OK) {
                if (responseCode == Consts.ResponseCode.RESULT_USER_CANCELED) {
                    m_purchasingState = 3;
                } else {
                    m_purchasingState = 2;
                }
            }
        }
        billingRequest.responseCodeReceived(responseCode);
        m_sentRequests.remove(Long.valueOf(j));
    }

    private boolean checkSubscriptionSupported() {
        Debug.log$552c4e01();
        return new CheckSubscriptionSupported().runRequest();
    }

    private boolean confirmNotifications(int i, String[] strArr) {
        return new ConfirmNotifications(i, strArr).runRequest();
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void currentItemFailed() {
        IAPJava.iapCallbackEventS(4, 0, IAP.m_realToNativeProductIdHash.get(m_savedProductId));
        m_savedProductId = null;
        m_purchaseTimeoutTimer = 16435934;
        m_purchasingState = 0;
    }

    private void currentItemTimeout() {
        IAPJava.iapCallbackEventS(8, 0, IAP.m_realToNativeProductIdHash.get(m_savedProductId));
        m_savedProductId = null;
        m_purchaseTimeoutTimer = 16435934;
        m_purchasingState = 0;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void doBuyProduct(String str) {
        String str2 = "Requesting purchase for " + str;
        Debug.log$552c4e01();
        if (requestPurchase(str)) {
            return;
        }
        Debug.log$552c4e01();
        m_purchasingState = 2;
    }

    private boolean getPurchaseInformation(int i, String str) {
        return new GetPurchaseInformation(i, new String[]{str}).runRequest();
    }

    private void giveUserCurrentItem() {
        m_purchasedItemLog.immediatelyGiveSpecificItem(m_savedProductId);
        m_savedProductId = null;
        m_purchaseTimeoutTimer = 16435934;
        m_purchasingState = 0;
    }

    private void handleCommand(Intent intent, int i) {
        if (intent == null) {
            if (IAPJava.m_activity != null) {
                Debug.log$552c4e01();
                return;
            }
            return;
        }
        String action = intent.getAction();
        String str = "handleCommand() action: " + action;
        Debug.log$552c4e01();
        if ("com.glu.googleiap.CONFIRM_NOTIFICATION".equals(action)) {
            confirmNotifications(i, intent.getStringArrayExtra("notification_id"));
            return;
        }
        if ("com.glu.googleiap.GET_PURCHASE_INFORMATION".equals(action)) {
            getPurchaseInformation(i, intent.getStringExtra("notification_id"));
        } else if ("com.android.vending.billing.PURCHASE_STATE_CHANGED".equals(action)) {
            purchaseStateChanged(i, intent.getStringExtra("inapp_signed_data"), intent.getStringExtra("inapp_signature"));
        } else if ("com.android.vending.billing.RESPONSE_CODE".equals(action)) {
            checkResponseCode(intent.getLongExtra("request_id", -1L), Consts.ResponseCode.valueOf(intent.getIntExtra("response_code", Consts.ResponseCode.RESULT_ERROR.ordinal())));
        }
    }

    private void initStatics() {
        Debug.log$552c4e01();
        m_billingService = null;
        m_pendingRequests = new LinkedList<>();
        m_sentRequests = new HashMap<>();
        m_handler = null;
        m_purchaseObserver = null;
        m_billingVerified = false;
        m_billingSupported = true;
        m_subscriptionSupported = true;
        m_initRetryTimer = 16435934;
        m_purchaseTimeoutTimer = 16435934;
        m_asynchronousItemGiveTimer = 60000;
        m_asynchronousItemRemoveTimer = 16435934;
        m_purchasingState = 0;
        m_restoredTransactions = false;
        m_restoreTransactionsInProgress = false;
        m_savedProductId = null;
        m_initialized = false;
        m_buyProductThread = null;
        m_purchasedItemLog = new GIAPSaveFile("giapa.dat");
        m_refundedItemLog = new GIAPSaveFile("giapr.dat");
    }

    private void managedCallRestoreTransactions() {
        if (m_restoreTransactionsInProgress) {
            return;
        }
        Debug.log$552c4e01();
        m_restoreTransactionsInProgress = true;
        SharedPreferences preferences = IAPJava.m_activity.getPreferences(0);
        preferences.getBoolean(DB_INITIALIZED, false);
        if (!preferences.getBoolean(DB_INITIALIZED, false)) {
            m_restoredTransactions = restoreTransactions();
        } else {
            m_restoredTransactions = true;
            m_restoreTransactionsInProgress = false;
        }
    }

    private void purchaseStateChanged(int i, String str, String str2) {
        String str3 = "purchaseStateChanged(" + i + ", " + str + ", " + str2 + ")";
        Debug.log$552c4e01();
        ArrayList<Security.VerifiedPurchase> arrayListVerifyPurchase = Security.verifyPurchase(str, str2);
        if (arrayListVerifyPurchase == null) {
            return;
        }
        Debug.log$552c4e01();
        ArrayList arrayList = new ArrayList();
        for (Security.VerifiedPurchase verifiedPurchase : arrayListVerifyPurchase) {
            String str4 = "purchaseStateChanged.purchases " + verifiedPurchase.productId;
            Debug.log$552c4e01();
            if (verifiedPurchase.notificationId != null) {
                arrayList.add(verifiedPurchase.notificationId);
            }
            Consts.PurchaseState purchaseState = verifiedPurchase.purchaseState;
            String str5 = verifiedPurchase.productId;
            String str6 = verifiedPurchase.orderId;
            long j = verifiedPurchase.purchaseTime;
            String str7 = verifiedPurchase.developerPayload;
            ResponseHandler.purchaseResponse$20db4f51$63f6ffa7(purchaseState, str5, j);
        }
        if (arrayList.isEmpty()) {
            return;
        }
        String[] strArr = (String[]) arrayList.toArray(new String[arrayList.size()]);
        if (m_purchasedItemLog.isValid()) {
            confirmNotifications(i, strArr);
        }
    }

    private boolean requestPurchase(String str) {
        return new RequestPurchase(str).runRequest();
    }

    private boolean requestPurchase(String str, String str2) {
        return new RequestPurchase(str, str2).runRequest();
    }

    private boolean restoreTransactions() {
        return new RestoreTransactions().runRequest();
    }

    private void runPendingRequests() {
        Debug.log$552c4e01();
        int startId = -1;
        while (true) {
            BillingRequest billingRequestPeek = m_pendingRequests.peek();
            if (billingRequestPeek == null) {
                if (startId >= 0) {
                    String str = "stopping service, startId: " + startId;
                    Debug.log$552c4e01();
                    stopSelf(startId);
                }
                Debug.log$552c4e01();
                return;
            }
            if (!billingRequestPeek.runIfConnected()) {
                Debug.log$552c4e01();
                bindToMarketBillingService();
                return;
            } else {
                m_pendingRequests.remove();
                if (startId < billingRequestPeek.getStartId()) {
                    startId = billingRequestPeek.getStartId();
                }
            }
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void storeItemToAdd(String str, long j) {
        m_purchasedItemLog.addItem(str, j);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void storeItemToRemove(String str, long j) {
        m_refundedItemLog.addItem(str, j);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public boolean transactionInProgress() {
        return m_purchaseTimeoutTimer != 16435934;
    }

    @Override // com.glu.android.iap.IAP.IAPObject
    public void buyProduct(String str) {
        String realProductId = getRealProductId(str);
        IAP.initSingleProduct(str);
        if (m_buyProductThread != null) {
            Debug.log$552c4e01();
            return;
        }
        if (!m_billingSupported) {
            IAPJava.iapCallbackEventS(4, 0, str);
            return;
        }
        if (forceAsynchronousPurchaseAward()) {
            return;
        }
        m_savedProductId = realProductId;
        m_purchaseTimeoutTimer = 60000;
        m_purchasingState = 0;
        Thread thread = new Thread() { // from class: com.glu.android.iap.GluGoogleIAP.1
            @Override // java.lang.Thread, java.lang.Runnable
            public final void run() {
                try {
                    Thread.sleep(1000L);
                } catch (Exception e) {
                    Debug.log$2d473e19();
                }
                GluGoogleIAP.this.doBuyProduct(GluGoogleIAP.m_savedProductId);
                Thread unused = GluGoogleIAP.m_buyProductThread = null;
            }
        };
        m_buyProductThread = thread;
        thread.start();
    }

    @Override // com.glu.android.iap.IAP.IAPObject
    public final boolean forceAsynchronousPurchaseAward() {
        boolean z = false;
        while (m_purchasedItemLog.hasUnhandledItems()) {
            if (!m_purchasedItemLog.tryGivingOneItem(true)) {
                throw new RuntimeException("this MUST succeed. fix your native code.");
            }
            z = true;
        }
        if (!z) {
            return false;
        }
        IAPJava.iapCallbackEvent(9, 0, null);
        return true;
    }

    public String getAttribute(int i, String str) {
        return GOOGLE_IAP_FAILED_STRING;
    }

    public String getCurrencySymbol() {
        return IAP.getCurrencySymbol$7157d249();
    }

    @Override // com.glu.android.iap.IAP.IAPObject
    public final int getIAPId() {
        return 1;
    }

    @Override // com.glu.android.iap.IAP.IAPObject
    public int getProductType(String str) {
        getRealProductId(str);
        Debug.log$552c4e01();
        return 1;
    }

    @Override // com.glu.android.iap.IAP.IAPObject
    public String getRealProductId(String str) {
        return str.toLowerCase();
    }

    @Override // com.glu.android.iap.IAP.IAPObject
    public final boolean hasInventoryLoaded() {
        return true;
    }

    @Override // com.glu.android.iap.IAP.IAPObject
    public void init() {
        Debug.log$552c4e01();
        if (!m_initialized) {
            GluPurchaseObserver gluPurchaseObserver = new GluPurchaseObserver(m_handler);
            m_purchaseObserver = gluPurchaseObserver;
            ResponseHandler.register(gluPurchaseObserver);
            if (m_purchasedItemLog.hasUnhandledItems()) {
                m_asynchronousItemGiveTimer = 60000;
            }
            if (m_refundedItemLog.hasUnhandledItems()) {
                m_asynchronousItemRemoveTimer = 60000;
            }
        }
        if (!checkBillingSupported()) {
            m_billingSupported = false;
            m_initRetryTimer = 10000;
        }
        if (!checkSubscriptionSupported()) {
            m_subscriptionSupported = false;
            m_initRetryTimer = 10000;
        }
        m_initialized = true;
    }

    @Override // com.glu.android.iap.IAP.IAPObject
    public boolean isGoogleServiceConnected() {
        return m_billingSupported;
    }

    @Override // com.glu.android.iap.IAP.IAPObject
    public boolean isIAPConnected() {
        return true;
    }

    @Override // com.glu.android.iap.IAP.IAPObject
    public boolean isIAPSupported() {
        if (Build.VERSION.SDK_INT < 4) {
            return false;
        }
        return m_billingSupported;
    }

    @Override // com.glu.android.iap.IAP.IAPObject
    public final boolean isItemAvailable(String str) {
        return true;
    }

    @Override // com.glu.android.iap.IAP.IAPObject
    public boolean isProductValid(String str) {
        getRealProductId(str);
        Debug.log$552c4e01();
        return true;
    }

    @Override // com.glu.android.iap.IAP.IAPObject
    public boolean isSubscriptionSupported() {
        if (Build.VERSION.SDK_INT < 4) {
            return false;
        }
        return m_subscriptionSupported;
    }

    public void onAppStart() {
        if (m_initialized) {
            ResponseHandler.register(m_purchaseObserver);
        }
    }

    public void onAppStop() {
        if (m_initialized) {
            GluPurchaseObserver gluPurchaseObserver = m_purchaseObserver;
            ResponseHandler.unregister$4b5e3270();
        }
    }

    @Override // android.app.Service
    public IBinder onBind(Intent intent) {
        Debug.log$552c4e01();
        return null;
    }

    @Override // com.glu.android.iap.IAP.IAPObject
    public void onIAPDestroy() {
        ResponseHandler.unregister$4b5e3270();
        unbind();
    }

    public final void onInventoryFailure() {
    }

    public final void onInventoryReceived(Hashtable<String, IAP.Inventory> hashtable) {
    }

    @Override // android.content.ServiceConnection
    public void onServiceConnected(ComponentName componentName, IBinder iBinder) {
        Debug.log$552c4e01();
        m_billingService = IMarketBillingService.Stub.asInterface(iBinder);
    }

    @Override // android.content.ServiceConnection
    public void onServiceDisconnected(ComponentName componentName) {
        Debug.log$552c4e01();
        m_billingService = null;
    }

    @Override // android.app.Service
    public void onStart(Intent intent, int i) {
        Debug.log$552c4e01();
        if (instance != null && IAPJava.m_activity != null) {
            handleCommand(intent, i);
        } else if (IAPJava.m_activity != null) {
            Debug.log$552c4e01();
        }
    }

    @Override // com.glu.android.iap.IAP.IAPObject
    public void querySingleProduct(String str) {
        getRealProductId(str);
        buyProduct(str);
    }

    @Override // com.glu.android.iap.IAP.IAPObject
    public void restoreUnclaimedItems() {
    }

    @Override // com.glu.android.iap.IAP.IAPObject
    public void setButtonCenterXY(int i) {
    }

    @Override // com.glu.android.iap.IAP.IAPObject
    public void setButtonVisible(int i) {
    }

    @Override // com.glu.android.iap.IAP.IAPObject
    public void tick(int i) {
        boolean z = false;
        if (m_pendingRequests.peek() != null) {
            runPendingRequests();
        } else if (!m_restoredTransactions && m_billingSupported && m_billingVerified) {
            managedCallRestoreTransactions();
        }
        synchronized (ITEM_MANAGEMENT_LOCK) {
            if (m_purchaseTimeoutTimer != 16435934) {
                m_purchaseTimeoutTimer -= i;
                if (m_purchasingState == 1) {
                    giveUserCurrentItem();
                } else if (m_purchasingState == 2) {
                    currentItemFailed();
                } else if (m_purchasingState == 3) {
                    cancelCurrentItem();
                } else if (m_purchaseTimeoutTimer <= 0) {
                    currentItemTimeout();
                }
            }
            if (m_asynchronousItemGiveTimer != 16435934) {
                int i2 = m_asynchronousItemGiveTimer - i;
                m_asynchronousItemGiveTimer = i2;
                if (i2 <= 0) {
                    while (m_purchasedItemLog.hasUnhandledItems() && m_purchasedItemLog.tryGivingOneItem(false)) {
                        z = true;
                    }
                    m_asynchronousItemGiveTimer = 60000;
                    if (z) {
                        IAPJava.iapCallbackEvent(9, 0, null);
                    }
                }
            }
            if (m_asynchronousItemRemoveTimer != 16435934) {
                int i3 = m_asynchronousItemRemoveTimer - i;
                m_asynchronousItemRemoveTimer = i3;
                if (i3 <= 0) {
                    while (m_refundedItemLog.hasUnhandledItems()) {
                        if (!m_refundedItemLog.tryRefundingOneItem()) {
                            m_asynchronousItemRemoveTimer = 60000;
                            break;
                        }
                    }
                }
                if (m_asynchronousItemRemoveTimer <= 0) {
                    m_asynchronousItemRemoveTimer = 16435934;
                }
            }
        }
    }

    public void unbind() {
        try {
            unbindService(this);
        } catch (IllegalArgumentException e) {
        }
    }
}
