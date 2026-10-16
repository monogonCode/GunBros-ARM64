package com.tapjoy;

import android.content.Context;
import android.content.Intent;
import java.util.UUID;
import org.w3c.dom.Document;

/* JADX INFO: loaded from: classes.dex */
public class TJCOffers {
    public static final String TAPJOY_OFFERS = "TapjoyOffers";
    public static final String TAPJOY_POINTS = "TapjoyPoints";
    private static TapjoyAwardPointsNotifier tapjoyAwardPointsNotifier;
    private static TapjoyEarnedPointsNotifier tapjoyEarnedPointsNotifier;
    private static TapjoyNotifier tapjoyNotifier;
    private static TapjoySpendPointsNotifier tapjoySpendPointsNotifier;
    Context context;
    String spendTapPoints = null;
    int awardTapPoints = 0;
    private String multipleCurrencyID = "";
    private String multipleCurrencySelector = "";

    public TJCOffers(Context context) {
        this.context = context;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public boolean handleAwardPointsResponse(String str) {
        Document documentBuildDocument = TapjoyUtil.buildDocument(str);
        if (documentBuildDocument != null) {
            String nodeTrimValue = TapjoyUtil.getNodeTrimValue(documentBuildDocument.getElementsByTagName("Success"));
            if (nodeTrimValue != null && nodeTrimValue.equals("true")) {
                String nodeTrimValue2 = TapjoyUtil.getNodeTrimValue(documentBuildDocument.getElementsByTagName("TapPoints"));
                String nodeTrimValue3 = TapjoyUtil.getNodeTrimValue(documentBuildDocument.getElementsByTagName("CurrencyName"));
                if (nodeTrimValue2 != null && nodeTrimValue3 != null) {
                    TapjoyConnectCore.saveTapPointsTotal(Integer.parseInt(nodeTrimValue2));
                    TapjoyAwardPointsNotifier tapjoyAwardPointsNotifier2 = tapjoyAwardPointsNotifier;
                    Integer.parseInt(nodeTrimValue2);
                    return true;
                }
                TapjoyLog.e(TAPJOY_POINTS, "Invalid XML: Missing tags.");
            } else {
                if (nodeTrimValue != null && nodeTrimValue.endsWith("false")) {
                    TapjoyLog.i(TAPJOY_POINTS, TapjoyUtil.getNodeTrimValue(documentBuildDocument.getElementsByTagName("Message")));
                    TapjoyAwardPointsNotifier tapjoyAwardPointsNotifier3 = tapjoyAwardPointsNotifier;
                    return true;
                }
                TapjoyLog.e(TAPJOY_POINTS, "Invalid XML: Missing <Success> tag.");
            }
        }
        return false;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public boolean handleGetPointsResponse(String str) {
        Document documentBuildDocument = TapjoyUtil.buildDocument(str);
        if (documentBuildDocument != null) {
            String nodeTrimValue = TapjoyUtil.getNodeTrimValue(documentBuildDocument.getElementsByTagName("Success"));
            if (nodeTrimValue == null || !nodeTrimValue.equals("true")) {
                TapjoyLog.e(TAPJOY_POINTS, "Invalid XML: Missing <Success> tag.");
            } else {
                String nodeTrimValue2 = TapjoyUtil.getNodeTrimValue(documentBuildDocument.getElementsByTagName("TapPoints"));
                String nodeTrimValue3 = TapjoyUtil.getNodeTrimValue(documentBuildDocument.getElementsByTagName("CurrencyName"));
                if (nodeTrimValue2 != null && nodeTrimValue3 != null) {
                    int i = Integer.parseInt(nodeTrimValue2);
                    int localTapPointsTotal = TapjoyConnectCore.getLocalTapPointsTotal();
                    if (tapjoyEarnedPointsNotifier != null && localTapPointsTotal != -9999 && i > localTapPointsTotal) {
                        TapjoyEarnedPointsNotifier tapjoyEarnedPointsNotifier2 = tapjoyEarnedPointsNotifier;
                    }
                    TapjoyConnectCore.saveTapPointsTotal(Integer.parseInt(nodeTrimValue2));
                    tapjoyNotifier.getUpdatePoints(nodeTrimValue3, Integer.parseInt(nodeTrimValue2));
                    return true;
                }
                TapjoyLog.e(TAPJOY_POINTS, "Invalid XML: Missing tags.");
            }
        }
        return false;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public boolean handleSpendPointsResponse(String str) {
        Document documentBuildDocument = TapjoyUtil.buildDocument(str);
        if (documentBuildDocument != null) {
            String nodeTrimValue = TapjoyUtil.getNodeTrimValue(documentBuildDocument.getElementsByTagName("Success"));
            if (nodeTrimValue != null && nodeTrimValue.equals("true")) {
                String nodeTrimValue2 = TapjoyUtil.getNodeTrimValue(documentBuildDocument.getElementsByTagName("TapPoints"));
                String nodeTrimValue3 = TapjoyUtil.getNodeTrimValue(documentBuildDocument.getElementsByTagName("CurrencyName"));
                if (nodeTrimValue2 != null && nodeTrimValue3 != null) {
                    TapjoyConnectCore.saveTapPointsTotal(Integer.parseInt(nodeTrimValue2));
                    tapjoySpendPointsNotifier.getSpendPointsResponse(nodeTrimValue3, Integer.parseInt(nodeTrimValue2));
                    return true;
                }
                TapjoyLog.e(TAPJOY_POINTS, "Invalid XML: Missing tags.");
            } else {
                if (nodeTrimValue != null && nodeTrimValue.endsWith("false")) {
                    String nodeTrimValue4 = TapjoyUtil.getNodeTrimValue(documentBuildDocument.getElementsByTagName("Message"));
                    TapjoyLog.i(TAPJOY_POINTS, nodeTrimValue4);
                    tapjoySpendPointsNotifier.getSpendPointsResponseFailed(nodeTrimValue4);
                    return true;
                }
                TapjoyLog.e(TAPJOY_POINTS, "Invalid XML: Missing <Success> tag.");
            }
        }
        return false;
    }

    public void awardTapPoints(int i, TapjoyAwardPointsNotifier tapjoyAwardPointsNotifier2) {
        if (i < 0) {
            TapjoyLog.e(TAPJOY_POINTS, "spendTapPoints error: amount must be a positive number");
            return;
        }
        this.awardTapPoints = i;
        tapjoyAwardPointsNotifier = tapjoyAwardPointsNotifier2;
        new Thread(new Runnable() { // from class: com.tapjoy.TJCOffers.3
            @Override // java.lang.Runnable
            public void run() {
                String string = UUID.randomUUID().toString();
                long jCurrentTimeMillis = System.currentTimeMillis() / 1000;
                String strConnectToURL = new TapjoyURLConnection().connectToURL("https://ws.tapjoyads.com/points/award?", ((((TapjoyConnectCore.getURLParams() + "&tap_points=" + TJCOffers.this.awardTapPoints) + "&publisher_user_id=" + TapjoyConnectCore.getUserID()) + "&guid=" + string) + "&timestamp=" + jCurrentTimeMillis) + "&verifier=" + TapjoyConnectCore.getAwardPointsVerifier(jCurrentTimeMillis, TJCOffers.this.awardTapPoints, string));
                if (strConnectToURL != null ? TJCOffers.this.handleAwardPointsResponse(strConnectToURL) : false) {
                    return;
                }
                TapjoyAwardPointsNotifier unused = TJCOffers.tapjoyAwardPointsNotifier;
            }
        }).start();
    }

    public void getTapPoints(TapjoyNotifier tapjoyNotifier2) {
        tapjoyNotifier = tapjoyNotifier2;
        new Thread(new Runnable() { // from class: com.tapjoy.TJCOffers.1
            @Override // java.lang.Runnable
            public void run() {
                String strConnectToURL = new TapjoyURLConnection().connectToURL("https://ws.tapjoyads.com/get_vg_store_items/user_account?", TapjoyConnectCore.getURLParams() + "&publisher_user_id=" + TapjoyConnectCore.getUserID());
                if (strConnectToURL != null ? TJCOffers.this.handleGetPointsResponse(strConnectToURL) : false) {
                    return;
                }
                TJCOffers.tapjoyNotifier.getUpdatePointsFailed("Failed to retrieve points from server");
            }
        }).start();
    }

    public void setEarnedPointsNotifier(TapjoyEarnedPointsNotifier tapjoyEarnedPointsNotifier2) {
        tapjoyEarnedPointsNotifier = tapjoyEarnedPointsNotifier2;
    }

    public void showOffers() {
        TapjoyLog.i(TAPJOY_OFFERS, "Showing offers with userID: " + TapjoyConnectCore.getUserID());
        Intent intent = new Intent(this.context, (Class<?>) TJCOffersWebView.class);
        intent.setFlags(268435456);
        intent.putExtra(TapjoyConstants.EXTRA_USER_ID, TapjoyConnectCore.getUserID());
        intent.putExtra(TapjoyConstants.EXTRA_URL_PARAMS, TapjoyConnectCore.getURLParams());
        this.context.startActivity(intent);
    }

    public void showOffersWithCurrencyID(String str, boolean z) {
        TapjoyLog.i(TAPJOY_OFFERS, "Showing offers with currencyID: " + str + ", selector: " + z + " (userID = " + TapjoyConnectCore.getUserID() + ")");
        this.multipleCurrencyID = str;
        this.multipleCurrencySelector = z ? "1" : "0";
        String str2 = (TapjoyConnectCore.getURLParams() + "&currency_id=" + this.multipleCurrencyID) + "&currency_selector=" + this.multipleCurrencySelector;
        Intent intent = new Intent(this.context, (Class<?>) TJCOffersWebView.class);
        intent.setFlags(268435456);
        intent.putExtra(TapjoyConstants.EXTRA_USER_ID, TapjoyConnectCore.getUserID());
        intent.putExtra(TapjoyConstants.EXTRA_URL_PARAMS, str2);
        this.context.startActivity(intent);
    }

    public void spendTapPoints(int i, TapjoySpendPointsNotifier tapjoySpendPointsNotifier2) {
        if (i < 0) {
            TapjoyLog.e(TAPJOY_POINTS, "spendTapPoints error: amount must be a positive number");
            return;
        }
        this.spendTapPoints = "" + i;
        tapjoySpendPointsNotifier = tapjoySpendPointsNotifier2;
        new Thread(new Runnable() { // from class: com.tapjoy.TJCOffers.2
            @Override // java.lang.Runnable
            public void run() {
                String strConnectToURL = new TapjoyURLConnection().connectToURL("https://ws.tapjoyads.com/points/spend?", (TapjoyConnectCore.getURLParams() + "&tap_points=" + TJCOffers.this.spendTapPoints) + "&publisher_user_id=" + TapjoyConnectCore.getUserID());
                if (strConnectToURL != null ? TJCOffers.this.handleSpendPointsResponse(strConnectToURL) : false) {
                    return;
                }
                TJCOffers.tapjoySpendPointsNotifier.getSpendPointsResponseFailed("Failed to spend points.");
            }
        }).start();
    }
}
