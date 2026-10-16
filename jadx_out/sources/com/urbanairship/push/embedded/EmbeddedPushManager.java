package com.urbanairship.push.embedded;

import android.app.AlarmManager;
import android.app.PendingIntent;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.SystemClock;
import com.tapjoy.TapjoyConstants;
import com.urbanairship.Logger;
import com.urbanairship.UAirship;
import com.urbanairship.push.PushManager;
import com.urbanairship.push.PushPreferences;
import com.urbanairship.push.PushService;
import com.urbanairship.push.proto.Messages;
import java.util.HashMap;

/* JADX INFO: loaded from: classes.dex */
public class EmbeddedPushManager {
    private static BroadcastReceiver connectivityChanged = null;
    static final String holdingPatternWarning = "This application is in a holding pattern, most likely because your account does not have Helium access. To sign up for a free trial, visit https://go.urbanairship.com/apps/free-trial/.  Once granted permission, youshould fully uninstall the app before testing again, in order to clear this flag.";
    public static final EmbeddedPushManager instance = new EmbeddedPushManager();
    public static final String version = "3.0.7";
    private String ipAddress = null;
    private HeliumConnection connection = null;
    private volatile boolean extraApidRegistrationsDisabled = false;
    private BoxOfficeClient boxOfficeClient = new BoxOfficeClient();

    private EmbeddedPushManager() {
    }

    public static void deliverPush(Messages.PushNotification pushNotification) {
        Logger.debug("Received Helium Push.");
        String message = pushNotification.getMessage();
        String payload = pushNotification.getPayload();
        HashMap map = new HashMap();
        if (pushNotification.getMapCount() > 0) {
            for (Messages.KeyValue keyValue : pushNotification.getMapList()) {
                map.put(keyValue.getKey(), keyValue.getValue());
            }
        } else if (payload != null && payload.length() > 0) {
            map.put(PushManager.EXTRA_STRING_EXTRA, payload);
        }
        PushManager.deliverPush(message, pushNotification.getMessageId(), map);
    }

    public static void init(Context context, String str) {
        Logger.info("Embedded Push Initializing...");
        Intent intent = new Intent(context, (Class<?>) PushService.class);
        intent.setAction(PushService.ACTION_HEARTBEAT);
        ((AlarmManager) context.getSystemService("alarm")).setInexactRepeating(3, SystemClock.elapsedRealtime() + TapjoyConstants.PAID_APP_TIME, TapjoyConstants.PAID_APP_TIME, PendingIntent.getService(context, 0, intent, 0));
        if (shared().isInHoldingPattern()) {
            Logger.debug("In holding pattern. Will retry after " + PushManager.shared().getPreferences().getRetryAfter());
            Logger.error(holdingPatternWarning);
            PushManager.stopService();
            return;
        }
        shared().clearConnection();
        if (connectivityChanged == null) {
            connectivityChanged = new BroadcastReceiver() { // from class: com.urbanairship.push.embedded.EmbeddedPushManager.1
                @Override // android.content.BroadcastReceiver
                public void onReceive(Context context2, Intent intent2) {
                    String str2 = "Connectivity changed: connected=" + Network.isConnected();
                    if (Network.isConnected()) {
                        str2 = str2 + ", network type=" + Network.typeName();
                    }
                    Logger.info(str2);
                    if (!Network.isConnected()) {
                        Logger.info("Connectivity lost, shutting down helium connection");
                        EmbeddedPushManager.shared().clearConnection();
                        return;
                    }
                    if (intent2 != null && intent2.getBooleanExtra("isFailover", false)) {
                        Logger.verbose("Network failover.");
                    }
                    if (EmbeddedPushManager.shared().connection == null || EmbeddedPushManager.shared().ipChanged()) {
                        EmbeddedPushManager.shared().setIPAddress(Network.getActiveIPAddress());
                        EmbeddedPushManager.shared().reconnect();
                    }
                }
            };
            context.registerReceiver(connectivityChanged, new IntentFilter("android.net.conn.CONNECTIVITY_CHANGE"));
        }
        Logger.verbose("Embedded Push initialization complete.");
    }

    /* JADX INFO: Access modifiers changed from: private */
    public boolean ipChanged() {
        boolean z = true;
        String activeIPAddress = Network.getActiveIPAddress();
        Logger.verbose("Current IP: " + activeIPAddress + ". Previous IP: " + this.ipAddress);
        if ((this.ipAddress != null || activeIPAddress == null) && (this.ipAddress == null || activeIPAddress == null || this.ipAddress.equals(activeIPAddress))) {
            z = false;
        }
        Logger.verbose("IP Changed: " + z);
        return z;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void reconnect() {
        if (this.connection != null) {
            Logger.info("Reconnecting to Helium");
            long retryInterval = this.connection.getRetryInterval();
            this.connection.abort();
            this.connection = new HeliumConnection(this, this.boxOfficeClient);
            this.connection.setRetryInterval(retryInterval);
        } else {
            Logger.info("Starting new Helium connection");
            this.connection = new HeliumConnection(this, this.boxOfficeClient);
        }
        this.connection.start();
    }

    protected static void sendRegistrationResponse(boolean z) {
        Logger.debug("sending valid: " + UAirship.getPackageName() + ", " + z);
        PushManager.shared().heliumRegistrationResponseReceived(z);
    }

    public static EmbeddedPushManager shared() {
        return instance;
    }

    public static void stop() {
        PushManager.stopService();
    }

    public void clearConnection() {
        setIPAddress(null);
        if (this.connection != null) {
            this.connection.abort();
            this.connection = null;
        }
    }

    public synchronized boolean getExtraApidRegistrationsDisabled() {
        return this.extraApidRegistrationsDisabled;
    }

    public boolean isInHoldingPattern() {
        PushPreferences preferences = PushManager.shared().getPreferences();
        long jCurrentTimeMillis = System.currentTimeMillis() / 1000;
        long retryAfter = preferences.getRetryAfter();
        if (retryAfter - jCurrentTimeMillis > Config.BoxOffice.MAX_HOLDING_PATTERN) {
            retryAfter = 0;
            preferences.setRetryAfter(0L);
        }
        return retryAfter > jCurrentTimeMillis;
    }

    public synchronized void setExtraApidRegistrationsDisabled(boolean z) {
        if (UAirship.shared().isFlying()) {
            Logger.error("** EmbeddedPushManager.setExtraApidRegistrationsDisabled should be called prior to takeOff! **");
        }
        this.extraApidRegistrationsDisabled = z;
    }

    public boolean setHoldingPattern(long j) {
        long jCurrentTimeMillis = System.currentTimeMillis() / 1000;
        if (jCurrentTimeMillis >= j) {
            Logger.debug("BoxOffice retry_after response is in the past. Ignoring.");
            return false;
        }
        if (j - jCurrentTimeMillis > Config.BoxOffice.MAX_HOLDING_PATTERN) {
            Logger.debug("BoxOffice retry_after response of " + j + " exceeds our maximum retry delay. Setting to max delay.");
            j = jCurrentTimeMillis + Config.BoxOffice.MAX_HOLDING_PATTERN;
        }
        Logger.debug("Received BoxOffice response to reconnect after: " + j + ". Currently: " + jCurrentTimeMillis + ". Shutting downfor " + (j - jCurrentTimeMillis) + " seconds.");
        return PushManager.shared().getPreferences().setRetryAfter(j);
    }

    public synchronized void setIPAddress(String str) {
        this.ipAddress = str;
    }

    public void stopHeartBeat() {
        Context applicationContext = UAirship.shared().getApplicationContext();
        Logger.debug("stopping heart beat");
        Intent intent = new Intent(applicationContext, (Class<?>) PushService.class);
        intent.setAction(PushService.ACTION_HEARTBEAT);
        PendingIntent service = PendingIntent.getService(applicationContext, 0, intent, 536870912);
        if (service != null) {
            ((AlarmManager) applicationContext.getSystemService("alarm")).cancel(service);
        }
    }

    public void teardown() {
        Logger.verbose("Embedded Push teardown!");
        Context applicationContext = UAirship.shared().getApplicationContext();
        if (connectivityChanged != null) {
            applicationContext.unregisterReceiver(connectivityChanged);
            connectivityChanged = null;
        }
        clearConnection();
    }
}
