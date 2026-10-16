package com.urbanairship.analytics;

import android.app.Activity;
import com.urbanairship.UAirship;

/* JADX INFO: loaded from: classes.dex */
public class InstrumentedActivity extends Activity {
    @Override // android.app.Activity
    public void onStart() {
        super.onStart();
        UAirship.shared().getAnalytics().activityStarted(this);
    }

    @Override // android.app.Activity
    public void onStop() {
        super.onStop();
        UAirship.shared().getAnalytics().activityStopped(this);
    }
}
