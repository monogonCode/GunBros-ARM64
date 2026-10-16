package com.openfeint.internal.ui;

import android.app.Activity;
import android.content.res.Configuration;
import android.os.Bundle;
import android.view.Display;
import android.view.View;
import android.view.animation.AlphaAnimation;
import android.webkit.WebView;
import com.openfeint.internal.RR;
import com.openfeint.internal.Util;

/* JADX INFO: loaded from: classes.dex */
public class NestedWindow extends Activity {
    private boolean mIsVisible = false;
    protected View mLogoImage;
    protected WebView mWebView;

    private boolean isBigScreen() {
        Display defaultDisplay = getWindowManager().getDefaultDisplay();
        int width = defaultDisplay.getWidth();
        int height = defaultDisplay.getHeight();
        if (height <= width || width < 800 || height < 1000) {
            return width >= 1000 && height >= 800;
        }
        return true;
    }

    protected void beforeSetContentView() {
        if (isBigScreen()) {
            getWindow().requestFeature(1);
        }
    }

    public void fade(boolean z) {
        if (this.mWebView == null || this.mIsVisible == z) {
            return;
        }
        this.mIsVisible = z;
        AlphaAnimation alphaAnimation = new AlphaAnimation(z ? 0.0f : 1.0f, z ? 1.0f : 0.0f);
        alphaAnimation.setDuration(z ? 200L : 0L);
        alphaAnimation.setFillAfter(true);
        this.mWebView.startAnimation(alphaAnimation);
        if (this.mWebView.getVisibility() == 4) {
            this.mWebView.setVisibility(0);
            findViewById(RR.id("frameLayout")).setVisibility(0);
        }
    }

    protected int layoutResource() {
        return RR.layout("of_nested_window");
    }

    @Override // android.app.Activity, android.content.ComponentCallbacks
    public void onConfigurationChanged(Configuration configuration) {
        super.onConfigurationChanged(configuration);
    }

    @Override // android.app.Activity
    public void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        Util.setOrientation(this);
        beforeSetContentView();
        setContentView(layoutResource());
        this.mWebView = (WebView) findViewById(RR.id("web_view"));
        this.mLogoImage = findViewById(RR.id("of_ll_logo_image"));
    }
}
