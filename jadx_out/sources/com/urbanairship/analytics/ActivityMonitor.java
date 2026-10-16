package com.urbanairship.analytics;

import android.app.Activity;
import android.os.Handler;
import android.os.Message;

/* JADX INFO: loaded from: classes.dex */
class ActivityMonitor {
    private static final int BACKGROUND_DELAY_MS = 2000;
    private int activities = 0;
    private Delegate delegate;

    public static abstract class Delegate {
        public abstract void onBackground();

        public abstract void onForeground();
    }

    public ActivityMonitor(Delegate delegate) {
        this.delegate = delegate;
    }

    static /* synthetic */ int access$010(ActivityMonitor activityMonitor) {
        int i = activityMonitor.activities;
        activityMonitor.activities = i - 1;
        return i;
    }

    public void addActivity(Activity activity) {
        if (this.activities == 0) {
            this.delegate.onForeground();
        }
        this.activities++;
    }

    public void removeActivity(Activity activity) {
        final Handler handler = new Handler() { // from class: com.urbanairship.analytics.ActivityMonitor.1
            @Override // android.os.Handler
            public void handleMessage(Message message) {
                ActivityMonitor.access$010(ActivityMonitor.this);
                if (ActivityMonitor.this.activities == 0) {
                    ActivityMonitor.this.delegate.onBackground();
                }
            }
        };
        new Thread() { // from class: com.urbanairship.analytics.ActivityMonitor.2
            @Override // java.lang.Thread, java.lang.Runnable
            public void run() {
                try {
                    sleep(2000L);
                } catch (InterruptedException e) {
                }
                handler.sendMessage(handler.obtainMessage());
            }
        }.start();
    }
}
