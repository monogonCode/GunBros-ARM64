package com.tapjoy;

import android.R;
import android.app.Activity;
import android.app.AlertDialog;
import android.app.Dialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.graphics.Bitmap;
import android.net.Uri;
import android.os.Bundle;
import android.view.KeyEvent;
import android.webkit.WebView;
import android.webkit.WebViewClient;
import android.widget.ProgressBar;
import android.widget.RelativeLayout;
import java.util.Hashtable;

/* JADX INFO: loaded from: classes.dex */
public class TJCOffersWebView extends Activity {
    private ProgressBar progressBar;
    private WebView webView = null;
    private String offersURL = null;
    private Dialog dialog = null;
    private String clientPackage = "";
    private String urlParams = "";
    private String userID = "";
    final String TAPJOY_OFFERS = "Offers";
    private boolean skipOfferWall = false;

    private class TapjoyWebViewClient extends WebViewClient {
        private TapjoyWebViewClient() {
        }

        @Override // android.webkit.WebViewClient
        public void onPageFinished(WebView webView, String str) {
            TJCOffersWebView.this.progressBar.setVisibility(8);
        }

        @Override // android.webkit.WebViewClient
        public void onPageStarted(WebView webView, String str, Bitmap bitmap) {
            TJCOffersWebView.this.progressBar.setVisibility(0);
            TJCOffersWebView.this.progressBar.bringToFront();
        }

        @Override // android.webkit.WebViewClient
        public boolean shouldOverrideUrlLoading(WebView webView, String str) {
            TapjoyLog.i("Offers", "URL = [" + str + "]");
            if (str.indexOf("market") >= 0) {
                TapjoyLog.i("Offers", "Market URL = [" + str + "]");
                try {
                    String str2 = "http://market.android.com/details?id=" + str.split("q=")[1] + "&referrer=" + TJCOffersWebView.this.clientPackage;
                    TJCOffersWebView.this.startActivity(new Intent("android.intent.action.VIEW", Uri.parse(str2)));
                    TapjoyLog.i("Offers", "Open URL of application = [" + str2 + "]");
                } catch (Exception e) {
                    TJCOffersWebView.this.dialog = new AlertDialog.Builder(TJCOffersWebView.this).setTitle("").setMessage("Android market is unavailable at this device. To view this link install market.").setPositiveButton("OK", new DialogInterface.OnClickListener() { // from class: com.tapjoy.TJCOffersWebView.TapjoyWebViewClient.1
                        @Override // android.content.DialogInterface.OnClickListener
                        public void onClick(DialogInterface dialogInterface, int i) {
                            dialogInterface.dismiss();
                        }
                    }).create();
                    try {
                        TJCOffersWebView.this.dialog.show();
                    } catch (Exception e2) {
                        e2.printStackTrace();
                    }
                    TapjoyLog.i("Offers", "Android market is unavailable at this device. To view this link install market.");
                }
                TapjoyLog.i("Offers", "skipOfferWall: " + TJCOffersWebView.this.skipOfferWall);
                if (TJCOffersWebView.this.skipOfferWall) {
                    TJCOffersWebView.this.finish();
                }
            } else if (str.startsWith("tjvideo://")) {
                Hashtable hashtable = new Hashtable();
                String str3 = "";
                String strDecode = "";
                boolean z = false;
                for (int iIndexOf = str.indexOf("://") + "://".length(); iIndexOf < str.length() && iIndexOf != -1; iIndexOf++) {
                    char cCharAt = str.charAt(iIndexOf);
                    if (z) {
                        if (z) {
                            if (cCharAt == '&') {
                                String strDecode2 = Uri.decode(str3);
                                str3 = "";
                                TapjoyLog.i("Offers", "k:v: " + strDecode + ", " + strDecode2);
                                hashtable.put(strDecode, strDecode2);
                                z = false;
                            } else {
                                str3 = str3 + cCharAt;
                            }
                        }
                    } else if (cCharAt == '=') {
                        strDecode = Uri.decode(str3);
                        str3 = "";
                        z = true;
                    } else {
                        str3 = str3 + cCharAt;
                    }
                }
                if (z && str3.length() > 0) {
                    String strDecode3 = Uri.decode(str3);
                    TapjoyLog.i("Offers", "k:v: " + strDecode + ", " + strDecode3);
                    hashtable.put(strDecode, strDecode3);
                }
                String str4 = (String) hashtable.get("video_id");
                String str5 = (String) hashtable.get("amount");
                String str6 = (String) hashtable.get("currency_name");
                String str7 = (String) hashtable.get("click_url");
                TapjoyLog.i("Offers", "videoID: " + str4);
                TapjoyLog.i("Offers", "currencyAmount: " + str5);
                TapjoyLog.i("Offers", "currencyName: " + str6);
                TapjoyLog.i("Offers", "clickURL: " + str7);
                if (TapjoyVideo.getInstance().startVideo(str4, str6, str5, str7)) {
                    TapjoyLog.i("Offers", "VIDEO");
                } else {
                    TapjoyLog.e("Offers", "Unable to play video: " + str4);
                    TJCOffersWebView.this.dialog = new AlertDialog.Builder(TJCOffersWebView.this).setTitle("").setMessage("Unable to play video.").setPositiveButton("OK", new DialogInterface.OnClickListener() { // from class: com.tapjoy.TJCOffersWebView.TapjoyWebViewClient.2
                        @Override // android.content.DialogInterface.OnClickListener
                        public void onClick(DialogInterface dialogInterface, int i) {
                            dialogInterface.dismiss();
                        }
                    }).create();
                    try {
                        TJCOffersWebView.this.dialog.show();
                    } catch (Exception e3) {
                        TapjoyLog.e("Offers", "e: " + e3.toString());
                    }
                }
            } else if (str.contains(TapjoyConstants.TJC_BASE_REDIRECT_DOMAIN)) {
                TapjoyLog.i("Offers", "Open redirecting URL = [" + str + "]");
                webView.loadUrl(str);
            } else {
                TapjoyLog.i("Offers", "Opening URL in new browser = [" + str + "]");
                TJCOffersWebView.this.startActivity(new Intent("android.intent.action.VIEW", Uri.parse(str)));
                TapjoyLog.i("Offers", "skipOfferWall: " + TJCOffersWebView.this.skipOfferWall);
                if (TJCOffersWebView.this.skipOfferWall) {
                    TJCOffersWebView.this.finish();
                }
            }
            return true;
        }
    }

    @Override // android.app.Activity
    protected void onCreate(Bundle bundle) {
        Bundle extras = getIntent().getExtras();
        if (extras == null) {
            TapjoyLog.e("Offers", "Tapjoy offers meta data initialization fail.");
        } else if (extras.getString(TapjoyConstants.EXTRA_DISPLAY_AD_URL) != null) {
            this.skipOfferWall = true;
            this.offersURL = extras.getString(TapjoyConstants.EXTRA_DISPLAY_AD_URL);
        } else {
            this.skipOfferWall = false;
            this.urlParams = extras.getString(TapjoyConstants.EXTRA_URL_PARAMS);
            this.userID = extras.getString(TapjoyConstants.EXTRA_USER_ID);
            this.urlParams += "&publisher_user_id=" + this.userID;
            if (TapjoyConnectCore.getVideoIDs().length() > 0) {
                this.urlParams += "&video_offer_ids=" + TapjoyConnectCore.getVideoIDs();
                TapjoyLog.i("Offers", "getVideoIDs: [" + TapjoyConnectCore.getVideoIDs() + "]");
            }
            TapjoyLog.i("Offers", "urlParams: [" + this.urlParams + "]");
            this.offersURL = "https://ws.tapjoyads.com/get_offers/webpage?" + this.urlParams;
        }
        this.offersURL = this.offersURL.replaceAll(" ", "%20");
        this.clientPackage = TapjoyConnectCore.getClientPackage();
        TapjoyLog.i("Offers", "clientPackage: [" + this.clientPackage + "]");
        super.onCreate(bundle);
        requestWindowFeature(1);
        RelativeLayout relativeLayout = new RelativeLayout(this);
        this.webView = new WebView(this);
        this.webView.setWebViewClient(new TapjoyWebViewClient());
        this.webView.getSettings().setJavaScriptEnabled(true);
        this.progressBar = new ProgressBar(this, null, R.attr.progressBarStyleLarge);
        this.progressBar.setVisibility(0);
        RelativeLayout.LayoutParams layoutParams = new RelativeLayout.LayoutParams(-2, -2);
        layoutParams.addRule(13);
        this.progressBar.setLayoutParams(layoutParams);
        relativeLayout.addView(this.webView, -1, -1);
        relativeLayout.addView(this.progressBar);
        setContentView(relativeLayout);
        this.webView.loadUrl(this.offersURL);
        TapjoyLog.i("Offers", "Opening URL = [" + this.offersURL + "]");
    }

    @Override // android.app.Activity
    protected void onDestroy() {
        super.onDestroy();
        if (this.webView != null) {
            this.webView.clearCache(true);
            this.webView.destroyDrawingCache();
            this.webView.destroy();
        }
    }

    @Override // android.app.Activity, android.view.KeyEvent.Callback
    public boolean onKeyDown(int i, KeyEvent keyEvent) {
        if (i != 4 || !this.webView.canGoBack()) {
            return super.onKeyDown(i, keyEvent);
        }
        this.webView.goBack();
        return true;
    }

    @Override // android.app.Activity
    protected void onResume() {
        super.onResume();
        if (this.offersURL == null || this.webView == null) {
            return;
        }
        this.webView.loadUrl(this.offersURL);
    }
}
