package com.tapjoy;

import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import java.io.ByteArrayInputStream;
import javax.xml.parsers.DocumentBuilderFactory;
import org.w3c.dom.Document;

/* JADX INFO: loaded from: classes.dex */
public class TapjoyFeaturedApp {
    private static TapjoyFeaturedAppNotifier featuredAppNotifier;
    public static String featuredAppURLParams;
    private static TapjoyURLConnection tapjoyURLConnection = null;
    private Context context;
    private String currencyID;
    private TapjoyFeaturedAppObject featuredAppObject = null;
    private int displayCount = 5;
    final String TAPJOY_FEATURED_APP = "Featured App";

    public TapjoyFeaturedApp(Context context) {
        this.context = context;
        tapjoyURLConnection = new TapjoyURLConnection();
    }

    /* JADX INFO: Access modifiers changed from: private */
    public boolean buildResponse(String str) {
        boolean z;
        try {
            Document document = DocumentBuilderFactory.newInstance().newDocumentBuilder().parse(new ByteArrayInputStream(str.getBytes("UTF-8")));
            this.featuredAppObject.cost = TapjoyUtil.getNodeTrimValue(document.getElementsByTagName("Cost"));
            String nodeTrimValue = TapjoyUtil.getNodeTrimValue(document.getElementsByTagName("Amount"));
            if (nodeTrimValue != null) {
                this.featuredAppObject.amount = Integer.parseInt(nodeTrimValue);
            }
            this.featuredAppObject.description = TapjoyUtil.getNodeTrimValue(document.getElementsByTagName("Description"));
            this.featuredAppObject.iconURL = TapjoyUtil.getNodeTrimValue(document.getElementsByTagName("IconURL"));
            this.featuredAppObject.name = TapjoyUtil.getNodeTrimValue(document.getElementsByTagName("Name"));
            this.featuredAppObject.redirectURL = TapjoyUtil.getNodeTrimValue(document.getElementsByTagName("RedirectURL"));
            this.featuredAppObject.storeID = TapjoyUtil.getNodeTrimValue(document.getElementsByTagName("StoreID"));
            this.featuredAppObject.fullScreenAdURL = TapjoyUtil.getNodeTrimValue(document.getElementsByTagName("FullScreenAdURL"));
            TapjoyLog.i("Featured App", "cost: " + this.featuredAppObject.cost);
            TapjoyLog.i("Featured App", "amount: " + this.featuredAppObject.amount);
            TapjoyLog.i("Featured App", "description: " + this.featuredAppObject.description);
            TapjoyLog.i("Featured App", "iconURL: " + this.featuredAppObject.iconURL);
            TapjoyLog.i("Featured App", "name: " + this.featuredAppObject.name);
            TapjoyLog.i("Featured App", "redirectURL: " + this.featuredAppObject.redirectURL);
            TapjoyLog.i("Featured App", "storeID: " + this.featuredAppObject.storeID);
            TapjoyLog.i("Featured App", "fullScreenAdURL: " + this.featuredAppObject.fullScreenAdURL);
            z = (this.featuredAppObject.fullScreenAdURL == null || this.featuredAppObject.fullScreenAdURL.length() == 0) ? false : true;
        } catch (Exception e) {
            TapjoyLog.e("Featured App", "Error parsing XML: " + e.toString());
            z = false;
        }
        if (!z) {
            featuredAppNotifier.getFeaturedAppResponseFailed("Failed to parse XML file from response");
            return true;
        }
        featuredAppNotifier.getFeaturedAppResponse(this.featuredAppObject);
        if (TapjoyConnectCore.getAppID().equals(this.featuredAppObject.storeID)) {
            return z;
        }
        incrementDisplayCountForStoreID(this.featuredAppObject.storeID);
        return z;
    }

    private int getDisplayCountForStoreID(String str) {
        int i = this.context.getSharedPreferences(TapjoyConstants.TJC_FEATURED_APP_PREFERENCE, 0).getInt(str, 0);
        TapjoyLog.i("Featured App", "getDisplayCount: " + i + ", storeID: " + str);
        return i;
    }

    private void incrementDisplayCountForStoreID(String str) {
        SharedPreferences sharedPreferences = this.context.getSharedPreferences(TapjoyConstants.TJC_FEATURED_APP_PREFERENCE, 0);
        SharedPreferences.Editor editorEdit = sharedPreferences.edit();
        int i = sharedPreferences.getInt(str, 0) + 1;
        TapjoyLog.i("Featured App", "incrementDisplayCount: " + i + ", storeID: " + str);
        editorEdit.putInt(str, i);
        editorEdit.commit();
    }

    public void getFeaturedApp(TapjoyFeaturedAppNotifier tapjoyFeaturedAppNotifier) {
        TapjoyLog.i("Featured App", "Getting Featured App");
        getFeaturedApp(null, tapjoyFeaturedAppNotifier);
    }

    public void getFeaturedApp(String str, TapjoyFeaturedAppNotifier tapjoyFeaturedAppNotifier) {
        this.currencyID = str;
        TapjoyLog.i("Featured App", "Getting Featured App userID: " + TapjoyConnectCore.getUserID() + ", currencyID: " + this.currencyID);
        featuredAppNotifier = tapjoyFeaturedAppNotifier;
        this.featuredAppObject = new TapjoyFeaturedAppObject();
        featuredAppURLParams = TapjoyConnectCore.getURLParams();
        featuredAppURLParams += "&publisher_user_id=" + TapjoyConnectCore.getUserID();
        if (this.currencyID != null) {
            featuredAppURLParams += "&currency_id=" + this.currencyID;
        }
        new Thread(new Runnable() { // from class: com.tapjoy.TapjoyFeaturedApp.1
            @Override // java.lang.Runnable
            public void run() {
                String strConnectToURL = TapjoyFeaturedApp.tapjoyURLConnection.connectToURL("https://ws.tapjoyads.com/get_offers/featured?", TapjoyFeaturedApp.featuredAppURLParams);
                if (strConnectToURL != null ? TapjoyFeaturedApp.this.buildResponse(strConnectToURL) : false) {
                    return;
                }
                TapjoyFeaturedApp.featuredAppNotifier.getFeaturedAppResponseFailed("Error retrieving featured app data from the server.");
            }
        }).start();
    }

    public TapjoyFeaturedAppObject getFeaturedAppObject() {
        return this.featuredAppObject;
    }

    public void setDisplayCount(int i) {
        this.displayCount = i;
    }

    public void showFeaturedAppFullScreenAd() {
        String str = this.featuredAppObject != null ? this.featuredAppObject.fullScreenAdURL : "";
        TapjoyLog.i("Featured App", "Displaying Full Screen AD with URL: " + str);
        if (str.length() != 0) {
            String uRLParams = TapjoyConnectCore.getURLParams();
            if (this.currencyID != null && this.currencyID.length() > 0) {
                uRLParams = uRLParams + "&currency_id=" + this.currencyID;
            }
            Intent intent = new Intent(this.context, (Class<?>) TapjoyFeaturedAppWebView.class);
            intent.setFlags(268435456);
            intent.putExtra(TapjoyConstants.EXTRA_USER_ID, TapjoyConnectCore.getUserID());
            intent.putExtra(TapjoyConstants.EXTRA_URL_PARAMS, uRLParams);
            intent.putExtra(TapjoyConstants.EXTRA_FEATURED_APP_FULLSCREEN_AD_URL, str);
            this.context.startActivity(intent);
        }
    }
}
