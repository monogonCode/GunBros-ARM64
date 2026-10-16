package com.glu.platform.android.resdl;

import android.content.Context;
import android.os.Handler;
import android.os.Message;
import android.view.KeyEvent;
import android.view.View;
import android.view.ViewGroup;
import java.util.Vector;

/* JADX INFO: loaded from: classes.dex */
public class ResDownloadViewGroup extends ViewGroup {
    public static ResDownloadViewGroup instance = null;
    public boolean m_adVisible;
    private boolean m_layoutPending;
    private Handler m_viewManipulationHandler;
    public Vector<View> m_views;

    public ResDownloadViewGroup(Context context) {
        super(context);
        this.m_views = new Vector<>();
        this.m_adVisible = false;
        this.m_layoutPending = false;
        this.m_viewManipulationHandler = new Handler() { // from class: com.glu.platform.android.resdl.ResDownloadViewGroup.1
            @Override // android.os.Handler
            public final void handleMessage(Message message) {
                if (message.what == 1) {
                    ResDownloadViewGroup.this.requestLayout();
                }
            }
        };
        setId(4342350);
        GluUtil.doStandardViewGroupConfiguration(this);
        instance = this;
    }

    public static void tick$13462e() {
    }

    public final void init() {
        Debug.log("initting RDVG");
        for (int i = 0; i <= 0; i++) {
            Debug.log("view 0");
            ResFileDownloadView resFileDownloadView = new ResFileDownloadView(ResDL.getContext());
            resFileDownloadView.init(GluUtil.getScreenWidth(), GluUtil.getScreenHeight());
            this.m_views.addElement(resFileDownloadView);
            addView(this.m_views.elementAt(this.m_views.size() - 1), 0);
        }
        setVisibility(0);
        setFocusable(true);
        setFocusableInTouchMode(true);
        setClickable(true);
    }

    @Override // android.view.View, android.view.KeyEvent.Callback
    public boolean onKeyDown(int i, KeyEvent keyEvent) {
        return true;
    }

    @Override // android.view.View, android.view.KeyEvent.Callback
    public boolean onKeyUp(int i, KeyEvent keyEvent) {
        if (i == 4) {
            ResFileDownloadView.instance.m_backPressed = true;
        }
        return true;
    }

    @Override // android.view.ViewGroup, android.view.View
    protected void onLayout(boolean z, int i, int i2, int i3, int i4) {
        Debug.log("RDVG layout...");
        int size = this.m_views.size();
        for (int i5 = 0; i5 < size; i5++) {
            View viewElementAt = this.m_views.elementAt(i5);
            if (i5 == 0) {
                viewElementAt.layout(0, 0, GluUtil.getScreenWidth(), GluUtil.getScreenHeight());
            }
        }
        this.m_layoutPending = false;
    }

    @Override // android.view.View
    protected void onMeasure(int i, int i2) {
        int screenHeight = GluUtil.getScreenHeight();
        int screenWidth = GluUtil.getScreenWidth();
        measureChildren(i, i2);
        setMeasuredDimension(resolveSize(screenWidth, i), resolveSize(screenHeight, i2));
    }
}
