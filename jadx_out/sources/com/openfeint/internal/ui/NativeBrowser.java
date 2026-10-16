package com.openfeint.internal.ui;

import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.webkit.WebChromeClient;
import android.webkit.WebView;
import android.webkit.WebViewClient;
import java.util.concurrent.atomic.AtomicBoolean;

/* JADX INFO: loaded from: classes.dex */
public class NativeBrowser extends NestedWindow {
    private AtomicBoolean mFinished = new AtomicBoolean(false);
    private Handler mHandler;
    private Runnable mTimeoutWatchdog;

    public final class JSInterface {
        public JSInterface() {
        }

        public final void returnValue(final String str) {
            NativeBrowser.this.runOnUiThread(new Runnable() { // from class: com.openfeint.internal.ui.NativeBrowser.JSInterface.1
                @Override // java.lang.Runnable
                public void run() {
                    if (NativeBrowser.this.mFinished.compareAndSet(false, true)) {
                        Intent intent = new Intent();
                        if (str != null) {
                            intent.putExtra("com.openfeint.internal.ui.NativeBrowser.argument.result", str);
                        }
                        NativeBrowser.this.setResult(-1, intent);
                        NativeBrowser.this.finish();
                    }
                }
            });
        }
    }

    @Override // com.openfeint.internal.ui.NestedWindow, android.app.Activity
    public void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        Bundle extras = getIntent().getExtras();
        String string = extras.getString("com.openfeint.internal.ui.NativeBrowser.argument.src");
        String string2 = extras.getString("com.openfeint.internal.ui.NativeBrowser.argument.timeout");
        this.mWebView.getSettings().setJavaScriptEnabled(true);
        this.mWebView.addJavascriptInterface(new JSInterface(), "NativeBrowser");
        this.mWebView.setWebViewClient(new WebViewClient() { // from class: com.openfeint.internal.ui.NativeBrowser.1
            private void clearTimeout() {
                if (NativeBrowser.this.mHandler == null || NativeBrowser.this.mTimeoutWatchdog == null) {
                    return;
                }
                NativeBrowser.this.mHandler.removeCallbacks(NativeBrowser.this.mTimeoutWatchdog);
                NativeBrowser.this.mHandler = null;
                NativeBrowser.this.mTimeoutWatchdog = null;
            }

            @Override // android.webkit.WebViewClient
            public void onPageFinished(WebView webView, String str) {
                clearTimeout();
                super.onPageFinished(webView, str);
            }

            @Override // android.webkit.WebViewClient
            public void onReceivedError(WebView webView, int i, String str, String str2) {
                clearTimeout();
                super.onReceivedError(webView, i, str, str2);
                Intent intent = new Intent();
                intent.putExtra("com.openfeint.internal.ui.NativeBrowser.argument.failed", true);
                intent.putExtra("com.openfeint.internal.ui.NativeBrowser.argument.failure_code", i);
                intent.putExtra("com.openfeint.internal.ui.NativeBrowser.argument.failure_desc", str);
                NativeBrowser.this.setResult(-1, intent);
                NativeBrowser.this.finish();
            }
        });
        this.mWebView.setWebChromeClient(new WebChromeClient());
        this.mWebView.loadUrl(string);
        if (string2 != null) {
            this.mHandler = new Handler();
            this.mTimeoutWatchdog = new Runnable() { // from class: com.openfeint.internal.ui.NativeBrowser.2
                @Override // java.lang.Runnable
                public void run() {
                    if (NativeBrowser.this.mFinished.compareAndSet(false, true)) {
                        Intent intent = new Intent();
                        intent.putExtra("com.openfeint.internal.ui.NativeBrowser.argument.failed", true);
                        intent.putExtra("com.openfeint.internal.ui.NativeBrowser.argument.failure_code", 0);
                        intent.putExtra("com.openfeint.internal.ui.NativeBrowser.argument.failure_desc", "Timeout");
                        NativeBrowser.this.setResult(-1, intent);
                        NativeBrowser.this.finish();
                    }
                }
            };
            this.mHandler.postDelayed(this.mTimeoutWatchdog, Integer.parseInt(string2));
        }
        fade(true);
    }
}
