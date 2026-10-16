package com.glu.googleiap;

/* JADX INFO: loaded from: classes.dex */
public final class Consts {
    public static long BILLING_RESPONSE_INVALID_REQUEST_ID = -1;

    public enum PurchaseState {
        PURCHASED,
        CANCELED,
        REFUNDED;

        public static PurchaseState valueOf(int i) {
            PurchaseState[] purchaseStateArrValues = values();
            return (i < 0 || i >= purchaseStateArrValues.length) ? CANCELED : purchaseStateArrValues[i];
        }
    }

    public enum ResponseCode {
        RESULT_OK,
        RESULT_USER_CANCELED,
        RESULT_SERVICE_UNAVAILABLE,
        RESULT_BILLING_UNAVAILABLE,
        RESULT_ITEM_UNAVAILABLE,
        RESULT_DEVELOPER_ERROR,
        RESULT_ERROR;

        public static ResponseCode valueOf(int i) {
            ResponseCode[] responseCodeArrValues = values();
            return (i < 0 || i >= responseCodeArrValues.length) ? RESULT_ERROR : responseCodeArrValues[i];
        }
    }
}
