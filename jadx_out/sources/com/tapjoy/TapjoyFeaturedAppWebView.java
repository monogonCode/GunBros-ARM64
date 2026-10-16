package com.tapjoy;

import android.R;
import android.app.Activity;
import android.content.Intent;
import android.content.res.Configuration;
import android.graphics.Bitmap;
import android.net.Uri;
import android.os.AsyncTask;
import android.os.Bundle;
import android.webkit.WebView;
import android.webkit.WebViewClient;
import android.widget.ProgressBar;
import android.widget.RelativeLayout;

/* JADX INFO: loaded from: classes.dex */
public class TapjoyFeaturedAppWebView extends Activity {
    private ProgressBar progressBar;
    private WebView webView = null;
    private String clientPackage = "";
    private String fullScreenAdURL = "";
    private String userID = "";
    private String urlParams = "";
    final String TAPJOY_FEATURED_APP = "Featured App";

    private class RefreshTask extends AsyncTask<Void, Void, Boolean> {
        private RefreshTask() {
        }

        /* JADX INFO: Access modifiers changed from: protected */
        @Override // android.os.AsyncTask
        public Boolean doInBackground(Void... voidArr) {
            try {
                Thread.sleep(200L);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
            return true;
        }

        /* JADX INFO: Access modifiers changed from: protected */
        @Override // android.os.AsyncTask
        public void onPostExecute(Boolean bool) {
            if (TapjoyFeaturedAppWebView.this.webView != null) {
                TapjoyFeaturedAppWebView.this.webView.loadUrl("javascript:window.onorientationchange();");
            }
        }
    }

    private class TapjoyWebViewClient extends WebViewClient {
        private TapjoyWebViewClient() {
        }

        @Override // android.webkit.WebViewClient
        public void onPageFinished(WebView webView, String str) {
            TapjoyFeaturedAppWebView.this.progressBar.setVisibility(8);
        }

        @Override // android.webkit.WebViewClient
        public void onPageStarted(WebView webView, String str, Bitmap bitmap) {
            TapjoyFeaturedAppWebView.this.progressBar.setVisibility(0);
            TapjoyFeaturedAppWebView.this.progressBar.bringToFront();
        }

        @Override // android.webkit.WebViewClient
        public boolean shouldOverrideUrlLoading(WebView webView, String str) {
            TapjoyLog.i("Featured App", "URL = [" + str + "]");
            if (str.contains("showOffers")) {
                TapjoyLog.i("Featured App", "show offers");
                TapjoyFeaturedAppWebView.this.showOffers();
            } else if (str.contains("dismiss")) {
                TapjoyLog.i("Featured App", "dismiss");
                TapjoyFeaturedAppWebView.this.finish();
            } else if (str.indexOf("market") >= 0) {
                TapjoyLog.i("Featured App", "Market URL = [" + str + "]");
                try {
                    String str2 = "http://market.android.com/details?id=" + str.split("q=")[1] + "&referrer=" + TapjoyFeaturedAppWebView.this.clientPackage;
                    TapjoyFeaturedAppWebView.this.startActivity(new Intent("android.intent.action.VIEW", Uri.parse(str2)));
                    TapjoyLog.i("Featured App", "Open URL of application = [" + str2 + "]");
                } catch (Exception e) {
                    TapjoyLog.i("Featured App", "Android market is unavailable at this device. To view this link install market.");
                }
            } else if (str.contains(TapjoyConstants.TJC_BASE_REDIRECT_DOMAIN)) {
                TapjoyLog.i("Featured App", "Open redirecting URL = [" + str + "]");
                webView.loadUrl(str);
            } else {
                TapjoyLog.i("Featured App", "Opening URL in new browser = [" + str + "]");
                TapjoyFeaturedAppWebView.this.startActivity(new Intent("android.intent.action.VIEW", Uri.parse(str)));
            }
            return true;
        }
    }

    private void finishActivity() {
        finish();
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void showOffers() {
        TapjoyLog.i("Featured App", "Showing offers, userID: " + this.userID);
        TapjoyLog.i("Featured App", "Showing offers, URL PARAMS: " + this.urlParams);
        Intent intent = new Intent(this, (Class<?>) TJCOffersWebView.class);
        intent.putExtra(TapjoyConstants.EXTRA_USER_ID, this.userID);
        intent.putExtra(TapjoyConstants.EXTRA_URL_PARAMS, this.urlParams);
        startActivity(intent);
    }

    @Override // android.app.Activity, android.content.ComponentCallbacks
    public void onConfigurationChanged(Configuration configuration) {
        super.onConfigurationChanged(configuration);
        if (this.webView != null) {
            new RefreshTask().execute(new Void[0]);
        }
    }

    @Override // android.app.Activity
    protected void onCreate(Bundle bundle) {
        Bundle extras = getIntent().getExtras();
        this.userID = extras.getString(TapjoyConstants.EXTRA_USER_ID);
        this.clientPackage = TapjoyConnectCore.getClientPackage();
        this.urlParams = extras.getString(TapjoyConstants.EXTRA_URL_PARAMS);
        this.fullScreenAdURL = extras.getString(TapjoyConstants.EXTRA_FEATURED_APP_FULLSCREEN_AD_URL);
        this.fullScreenAdURL = this.fullScreenAdURL.replaceAll(" ", "%20");
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
        this.webView.loadUrl(this.fullScreenAdURL);
        TapjoyLog.i("Featured App", "Opening Full Screen AD URL = [" + this.fullScreenAdURL + "]");
    }
}
