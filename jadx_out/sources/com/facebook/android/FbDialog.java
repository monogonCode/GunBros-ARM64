package com.facebook.android;

import android.app.Dialog;
import android.app.ProgressDialog;
import android.content.Context;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.Typeface;
import android.graphics.drawable.Drawable;
import android.net.Uri;
import android.os.Bundle;
import android.view.Display;
import android.webkit.WebView;
import android.webkit.WebViewClient;
import android.widget.FrameLayout;
import android.widget.LinearLayout;
import android.widget.TextView;
import com.glu.platform.android.facebook.Debug;

/* JADX INFO: loaded from: classes.dex */
public final class FbDialog extends Dialog {
    static final float[] DIMENSIONS_LANDSCAPE = {460.0f, 260.0f};
    static final float[] DIMENSIONS_PORTRAIT = {280.0f, 420.0f};
    static final FrameLayout.LayoutParams FILL = new FrameLayout.LayoutParams(-1, -1);
    private LinearLayout mContent;
    private Facebook.DialogListener mListener;
    private ProgressDialog mSpinner;
    private TextView mTitle;
    private String mUrl;
    private WebView mWebView;
    private boolean m_dismissHandledElsewhere;

    private class FbWebViewClient extends WebViewClient {
        /* synthetic */ FbWebViewClient(FbDialog fbDialog) {
            this((byte) 0);
        }

        private FbWebViewClient(byte b) {
        }

        @Override // android.webkit.WebViewClient
        public final void onPageFinished(WebView webView, String str) {
            super.onPageFinished(webView, str);
            String title = FbDialog.this.mWebView.getTitle();
            if (title != null && title.length() > 0) {
                FbDialog.this.mTitle.setText(title);
            }
            FbDialog.this.mSpinner.dismiss();
        }

        @Override // android.webkit.WebViewClient
        public final void onPageStarted(WebView webView, String str, Bitmap bitmap) {
            String str2 = "Webview loading URL: " + str;
            Debug.log$16da05f7();
            super.onPageStarted(webView, str, bitmap);
            FbDialog.this.dismiss();
        }

        @Override // android.webkit.WebViewClient
        public final void onReceivedError(WebView webView, int i, String str, String str2) {
            super.onReceivedError(webView, i, str, str2);
            FbDialog.this.mListener.onError(new DialogError(str, i, str2));
            FbDialog.access$202$1753a915(FbDialog.this);
            FbDialog.this.dismiss();
        }

        @Override // android.webkit.WebViewClient
        public final boolean shouldOverrideUrlLoading(WebView webView, String str) {
            String str2 = "Redirect URL: " + str;
            Debug.log$16da05f7();
            if (!str.startsWith("fbconnect://success")) {
                if (!str.startsWith("fbconnect://cancel")) {
                    if (str.contains("touch")) {
                        return false;
                    }
                    FbDialog.this.getContext().startActivity(new Intent("android.intent.action.VIEW", Uri.parse(str)));
                    return true;
                }
                Debug.log$552c4e01();
                FbDialog.this.mListener.onCancel();
                FbDialog.access$202$1753a915(FbDialog.this);
                FbDialog.this.dismiss();
                return true;
            }
            Bundle url = Util.parseUrl(str);
            String string = url.getString("error");
            if (string == null) {
                string = url.getString("error_type");
            }
            if (string == null) {
                FbDialog.this.mListener.onComplete(url);
            } else if (string.equals("access_denied") || string.equals("OAuthAccessDeniedException")) {
                Debug.log$552c4e01();
                FbDialog.this.mListener.onCancel();
            } else {
                FbDialog.this.mListener.onFacebookError(new FacebookError(string));
            }
            FbDialog.access$202$1753a915(FbDialog.this);
            FbDialog.this.dismiss();
            return true;
        }
    }

    public FbDialog(Context context, String str, Facebook.DialogListener dialogListener) {
        super(context);
        this.m_dismissHandledElsewhere = false;
        this.mUrl = str;
        this.mListener = dialogListener;
    }

    static /* synthetic */ boolean access$202$1753a915(FbDialog fbDialog) {
        fbDialog.m_dismissHandledElsewhere = true;
        return true;
    }

    @Override // android.app.Dialog, android.content.DialogInterface
    public final void dismiss() {
        super.dismiss();
        String str = "dialog dismissed. handled elsewhere=" + this.m_dismissHandledElsewhere;
        Debug.log$552c4e01();
        if (this.m_dismissHandledElsewhere) {
            return;
        }
        this.mListener.onCancel();
    }

    @Override // android.app.Dialog
    protected final void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        this.mSpinner = new ProgressDialog(getContext());
        this.mSpinner.requestWindowFeature(1);
        this.mSpinner.setMessage("Loading...");
        this.mContent = new LinearLayout(getContext());
        this.mContent.setOrientation(1);
        requestWindowFeature(1);
        this.mTitle = new TextView(getContext());
        this.mTitle.setText("Facebook");
        this.mTitle.setTextColor(-1);
        this.mTitle.setTypeface(Typeface.DEFAULT_BOLD);
        this.mTitle.setBackgroundColor(-9599820);
        this.mTitle.setPadding(6, 4, 4, 4);
        this.mTitle.setCompoundDrawablePadding(6);
        this.mTitle.setCompoundDrawablesWithIntrinsicBounds((Drawable) null, (Drawable) null, (Drawable) null, (Drawable) null);
        this.mContent.addView(this.mTitle);
        this.mWebView = new WebView(getContext());
        this.mWebView.setVerticalScrollBarEnabled(false);
        this.mWebView.setHorizontalScrollBarEnabled(false);
        this.mWebView.setWebViewClient(new FbWebViewClient(this));
        this.mWebView.getSettings().setJavaScriptEnabled(true);
        this.mWebView.loadUrl(this.mUrl);
        this.mWebView.setLayoutParams(FILL);
        this.mContent.addView(this.mWebView);
        Display defaultDisplay = getWindow().getWindowManager().getDefaultDisplay();
        float f = getContext().getResources().getDisplayMetrics().density;
        float[] fArr = defaultDisplay.getWidth() < defaultDisplay.getHeight() ? DIMENSIONS_PORTRAIT : DIMENSIONS_LANDSCAPE;
        addContentView(this.mContent, new FrameLayout.LayoutParams((int) ((fArr[0] * f) + 0.5f), (int) ((fArr[1] * f) + 0.5f)));
    }
}
