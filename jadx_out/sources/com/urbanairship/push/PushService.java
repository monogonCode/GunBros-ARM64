package com.urbanairship.push;

import android.app.Service;
import android.content.Context;
import android.content.Intent;
import android.os.IBinder;
import com.urbanairship.AirshipConfigOptions;
import com.urbanairship.Logger;
import com.urbanairship.UAirship;
import com.urbanairship.analytics.PushServiceStartedEvent;
import com.urbanairship.push.c2dm.C2DMPushManager;
import com.urbanairship.push.embedded.EmbeddedPushManager;

/* JADX INFO: loaded from: classes.dex */
public class PushService extends Service {
    public static final String ACTION_HEARTBEAT = "com.urbanairship.push.HEARTBEAT";
    public static final String ACTION_START = "com.urbanairship.push.START";
    public static final String ACTION_STOP = "com.urbanairship.push.STOP";
    public boolean started = false;

    private PushPreferences prefs() {
        return PushManager.shared().getPreferences();
    }

    private synchronized void setupService() {
        if (!this.started) {
            if (prefs().getPushId() != null) {
                UAirship.shared().getAnalytics().addEvent(new PushServiceStartedEvent());
            }
            if (prefs().isPushEnabled()) {
                this.started = true;
                Context applicationContext = UAirship.shared().getApplicationContext();
                AirshipConfigOptions airshipConfigOptions = UAirship.shared().getAirshipConfigOptions();
                String appKey = airshipConfigOptions.getAppKey();
                PushManager.shared().getPreferences().setApidUpdateNeeded(true);
                AirshipConfigOptions.TransportType transport = airshipConfigOptions.getTransport();
                if (transport == AirshipConfigOptions.TransportType.HELIUM) {
                    Logger.debug("Starting Helium");
                    if (prefs().getC2DMId() != null) {
                        PushManager.shared().setC2DMId(null);
                        C2DMPushManager.unregister();
                    }
                    EmbeddedPushManager.init(applicationContext, appKey);
                    Logger.debug("Extra APID registrations disabled: " + EmbeddedPushManager.shared().getExtraApidRegistrationsDisabled());
                } else if (transport == AirshipConfigOptions.TransportType.C2DM) {
                    Logger.debug("Starting C2DM");
                    C2DMPushManager.init();
                } else {
                    Logger.debug("Starting C2DM");
                    C2DMPushManager.init();
                }
            } else {
                Logger.verbose("Push is disabled.  Not starting Push Service.");
                stopSelf();
            }
        }
    }

    private void teardownService() {
        AirshipConfigOptions.TransportType transport = UAirship.shared().getAirshipConfigOptions().getTransport();
        if (transport == AirshipConfigOptions.TransportType.HELIUM || transport == AirshipConfigOptions.TransportType.HYBRID) {
            EmbeddedPushManager.shared().teardown();
        }
        this.started = false;
    }

    @Override // android.app.Service
    public IBinder onBind(Intent intent) {
        return null;
    }

    @Override // android.app.Service
    public void onDestroy() {
        Logger.verbose("Push Service destroyed");
        teardownService();
    }

    @Override // android.app.Service
    public void onStart(Intent intent, int i) {
        Logger.debug("Push Service started with intent=" + intent);
        if (!UAirship.shared().isFlying()) {
            Logger.error("PushService started prior to a UAirship.takeOff() call.");
            throw new IllegalStateException("UAirship.takeOff() must be called every time Application.onCreate() is invoked.");
        }
        super.onStart(intent, i);
        if (intent == null || intent.getAction() == null) {
            Logger.warn("Attempted to start service with null intent or action.");
            return;
        }
        String action = intent.getAction();
        if (action.equals(ACTION_STOP)) {
            if (this.started) {
                stopSelf();
            }
        } else {
            if (action.equals(ACTION_START)) {
                setupService();
                return;
            }
            if (!action.equals(ACTION_HEARTBEAT)) {
                Logger.warn("Unknown action: " + intent.getAction());
                return;
            }
            Logger.debug("** Heartbeat **");
            if (this.started) {
                return;
            }
            setupService();
        }
    }
}
