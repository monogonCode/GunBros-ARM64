package com.openfeint.internal.ui;

import android.content.Context;
import android.util.AttributeSet;
import android.util.Log;
import android.widget.ImageView;

/* JADX INFO: loaded from: classes.dex */
public class PadLogoImageView extends ImageView {
    private final String tag;

    public PadLogoImageView(Context context) {
        super(context);
        this.tag = "ImageView2";
    }

    public PadLogoImageView(Context context, AttributeSet attributeSet) {
        super(context, attributeSet);
        this.tag = "ImageView2";
    }

    public PadLogoImageView(Context context, AttributeSet attributeSet, int i) {
        super(context, attributeSet, i);
        this.tag = "ImageView2";
    }

    @Override // android.view.View
    protected void onLayout(boolean z, int i, int i2, int i3, int i4) {
        super.onLayout(z, i, i2, i3, i4);
        Log.e("ImageView2", String.valueOf(z));
        Log.e("ImageView2", String.valueOf(i2));
        if (z) {
            if (i2 < 350) {
                setVisibility(4);
            } else {
                setVisibility(0);
            }
        }
    }
}
