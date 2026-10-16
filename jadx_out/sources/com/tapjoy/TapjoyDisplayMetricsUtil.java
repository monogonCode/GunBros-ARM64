package com.tapjoy;

import android.content.Context;
import android.content.res.Configuration;
import android.util.DisplayMetrics;
import android.view.WindowManager;

/* JADX INFO: loaded from: classes.dex */
public class TapjoyDisplayMetricsUtil {
    private Configuration configuration;
    private Context context;
    private DisplayMetrics metrics = new DisplayMetrics();

    public TapjoyDisplayMetricsUtil(Context context) {
        this.context = context;
        ((WindowManager) this.context.getSystemService("window")).getDefaultDisplay().getMetrics(this.metrics);
        this.configuration = this.context.getResources().getConfiguration();
    }

    public int getScreenDensity() {
        return this.metrics.densityDpi;
    }

    public int getScreenLayoutSize() {
        return this.configuration.screenLayout & 15;
    }
}
