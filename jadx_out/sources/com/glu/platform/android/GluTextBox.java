package com.glu.platform.android;

import android.text.method.PasswordTransformationMethod;
import android.text.method.SingleLineTransformationMethod;
import android.view.ViewGroup;
import android.view.inputmethod.InputMethodManager;
import android.widget.EditText;
import android.widget.LinearLayout;

/* JADX INFO: loaded from: classes.dex */
public class GluTextBox {
    private static final String TAG = "GluTextBox";
    private GluPlatformActivity m_activity;
    private int screenHeight;
    private int screenWidth;
    private EditText textView;
    private LinearLayout m_linearLayout = null;
    private boolean isMasked = false;
    private boolean isVisible = false;

    public GluTextBox() {
        this.m_activity = null;
        String str = "GluTextBox[" + this + "].GluTextBox()";
        this.m_activity = GluPlatformActivity.instance;
        this.m_activity.getHandler().post(new Runnable() { // from class: com.glu.platform.android.GluTextBox.1
            @Override // java.lang.Runnable
            public final void run() {
                String str2 = "run GluTextBox[" + this + "].GluTextBox()";
                GluTextBox.this.textView = new EditText(GluTextBox.this.m_activity);
            }
        });
    }

    public String GetText() {
        String str = "GluTextBox[" + this + "].GetText()";
        return this.textView.getText().toString().trim();
    }

    public void RemoveTextView() {
        String str = "GluTextBox[" + this + "].RemoveTextView()";
        this.m_activity.getHandler().post(new Runnable() { // from class: com.glu.platform.android.GluTextBox.7
            @Override // java.lang.Runnable
            public final void run() {
                GluTextBox.this.textView.setVisibility(4);
                GluTextBox.this.m_linearLayout.setVisibility(4);
            }
        });
    }

    public void SetBounds(final int i, final int i2, final int i3, int i4) {
        final int i5 = i4 >= 43 ? i4 : 43;
        String str = "GluTextBox[" + this + "].SetBounds(" + i + "," + i2 + "," + i3 + "," + i4 + ")";
        this.m_activity.getHandler().post(new Runnable() { // from class: com.glu.platform.android.GluTextBox.2
            @Override // java.lang.Runnable
            public final void run() {
                GluTextBox.this.createTextView(i, i2, i3, i5);
            }
        });
    }

    public void SetPasswordMask(final boolean z) {
        String str = "GluTextBox[" + this + "].SetPasswordMask(" + z + ")";
        this.isMasked = z;
        this.m_activity.getHandler().post(new Runnable() { // from class: com.glu.platform.android.GluTextBox.4
            @Override // java.lang.Runnable
            public final void run() {
                String str2 = "run GluTextBox[" + this + "].SetPasswordMask(" + z + ")";
                if (z) {
                    GluTextBox.this.textView.setTransformationMethod(new PasswordTransformationMethod());
                    GluTextBox.this.textView.setInputType(524417);
                } else {
                    GluTextBox.this.textView.setInputType(524288);
                    GluTextBox.this.textView.setTransformationMethod(new SingleLineTransformationMethod());
                }
            }
        });
    }

    public void SetText(final String str, final String str2) {
        String str3 = "GluTextBox[" + this + "].SetText(" + str + ")";
        this.m_activity.getHandler().post(new Runnable() { // from class: com.glu.platform.android.GluTextBox.6
            @Override // java.lang.Runnable
            public final void run() {
                GluTextBox.this.textView.setText(str);
                GluTextBox.this.textView.setHint(str2);
            }
        });
    }

    public void SetVisible(final boolean z) {
        String str = "GluTextBox[" + this + "].SetVisible(" + z + ")";
        this.isVisible = z;
        this.m_activity.getHandler().post(new Runnable() { // from class: com.glu.platform.android.GluTextBox.5
            @Override // java.lang.Runnable
            public final void run() {
                if (z) {
                    GluTextBox.this.textView.setVisibility(0);
                } else {
                    GluTextBox.this.textView.setVisibility(4);
                    ((InputMethodManager) GluTextBox.this.m_activity.getSystemService("input_method")).hideSoftInputFromWindow(GluTextBox.this.textView.getWindowToken(), 0);
                }
            }
        });
    }

    public void createTextView(final int i, final int i2, final int i3, final int i4) {
        this.m_activity.getHandler().post(new Runnable() { // from class: com.glu.platform.android.GluTextBox.3
            @Override // java.lang.Runnable
            public final void run() {
                String str = "running GluTextBox[" + this + "].createTextView()";
                GluTextBox.this.m_activity.getSystemService("window");
                GluTextBox.this.textView.setLayoutParams(new ViewGroup.LayoutParams(i3, i4));
                GluTextBox.this.textView.setSingleLine();
                GluTextBox.this.textView.setTextSize(10.0f);
                GluTextBox.this.textView.setPadding(10, 10, 10, 13);
                if (GluTextBox.this.isMasked) {
                    GluTextBox.this.textView.setTransformationMethod(new PasswordTransformationMethod());
                    GluTextBox.this.textView.setInputType(524417);
                } else {
                    GluTextBox.this.textView.setInputType(524289);
                }
                if (GluTextBox.this.isVisible) {
                    GluTextBox.this.textView.setVisibility(0);
                } else {
                    GluTextBox.this.textView.setVisibility(4);
                }
                GluTextBox.this.m_linearLayout = new LinearLayout(GluTextBox.this.m_activity);
                GluTextBox.this.m_linearLayout.setLayoutParams(new ViewGroup.LayoutParams(i3, i4));
                GluTextBox.this.m_linearLayout.setGravity(48);
                GluTextBox.this.m_linearLayout.setPadding(i, i2 - 10, 0, 0);
                GluTextBox.this.m_linearLayout.addView(GluTextBox.this.textView);
                GluTextBox.this.m_activity.getWindow().addContentView(GluTextBox.this.m_linearLayout, new ViewGroup.LayoutParams(-1, -1));
                GluTextBox.this.m_linearLayout.setVisibility(0);
            }
        });
    }
}
