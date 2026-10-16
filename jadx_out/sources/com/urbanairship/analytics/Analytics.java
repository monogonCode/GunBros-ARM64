package com.urbanairship.analytics;

import android.app.Activity;
import android.content.Intent;
import android.os.AsyncTask;
import android.os.Handler;
import android.os.Looper;
import android.provider.Settings;
import com.tapjoy.TapjoyConstants;
import com.urbanairship.CoreReceiver;
import com.urbanairship.Logger;
import com.urbanairship.UAirship;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.UUID;

/* JADX INFO: loaded from: classes.dex */
public class Analytics {
    public static final String ACTION_ANALYTICS_START = "com.urbanairship.analytics.START";
    private String conversionPushId;
    private final String server = UAirship.shared().getAirshipConfigOptions().analyticsServer;
    private Session session = new Session();
    private boolean fromBackground = false;
    private ActivityMonitor activityMonitor = new ActivityMonitor(new ActivityMonitor.Delegate() { // from class: com.urbanairship.analytics.Analytics.1
        @Override // com.urbanairship.analytics.ActivityMonitor.Delegate
        public void onBackground() {
            Analytics.this.fromBackground = true;
            Analytics.this.addEvent(new AppBackgroundEvent());
            Analytics.this.conversionPushId = null;
        }

        @Override // com.urbanairship.analytics.ActivityMonitor.Delegate
        public void onForeground() {
            if (Analytics.this.fromBackground) {
                Analytics.this.session = Analytics.this.new Session();
                Analytics.this.fromBackground = false;
            }
            Analytics.this.addEvent(new AppForegroundEvent());
        }
    });
    private EventDataManager dataManager = new EventDataManager();
    private EventUploadManager uploadManager = new EventUploadManager(this.dataManager);

    class AddEventTask extends AsyncTask<Event, Void, Void> {
        AddEventTask() {
        }

        /* JADX INFO: Access modifiers changed from: protected */
        /* JADX WARN: Code duplicated, block: B:18:0x0078 A[Catch: all -> 0x00c2, TryCatch #0 {, blocks: (B:6:0x000a, B:8:0x0020, B:10:0x0031, B:15:0x0047, B:12:0x003d, B:13:0x0042, B:14:0x0043, B:16:0x006c, B:18:0x0078, B:20:0x0089, B:22:0x008f, B:23:0x0098, B:24:0x00c0), top: B:31:0x000a }] */
        @Override // android.os.AsyncTask
        public Void doInBackground(Event... eventArr) {
            String oldestSessionId;
            for (Event event : eventArr) {
                synchronized (EventDataManager.class) {
                    int databaseSize = Analytics.this.dataManager.getDatabaseSize();
                    if (databaseSize > Analytics.this.uploadManager.getMaxTotalDBSize()) {
                        Logger.info("DB size exceeded. Deleting non-critical events.");
                        if ("activity_started".equals(event.getType()) || "activity_stopped".equals(event.getType())) {
                            Logger.info("Database full. Not logging activity start/stop events");
                        } else {
                            Logger.info("Deleting activity start/stop events.");
                            Analytics.this.dataManager.deleteEventType("activity_started");
                            Analytics.this.dataManager.deleteEventType("activity_stopped");
                            databaseSize = Analytics.this.dataManager.getDatabaseSize();
                            if (databaseSize > Analytics.this.uploadManager.getMaxTotalDBSize()) {
                                Logger.info("Deleting oldest session.");
                                oldestSessionId = Analytics.this.dataManager.getOldestSessionId();
                                if (oldestSessionId != null && oldestSessionId.length() > 0) {
                                    Analytics.this.dataManager.deleteSession(oldestSessionId);
                                }
                            }
                            Analytics.this.dataManager.insertEvent(event);
                            Intent intent = new Intent(Analytics.ACTION_ANALYTICS_START);
                            intent.setClass(UAirship.shared().getApplicationContext(), CoreReceiver.class);
                            UAirship.shared().getApplicationContext().sendBroadcast(intent);
                        }
                    } else {
                        if (databaseSize > Analytics.this.uploadManager.getMaxTotalDBSize()) {
                            Logger.info("Deleting oldest session.");
                            oldestSessionId = Analytics.this.dataManager.getOldestSessionId();
                            if (oldestSessionId != null) {
                                Analytics.this.dataManager.deleteSession(oldestSessionId);
                            }
                        }
                        Analytics.this.dataManager.insertEvent(event);
                        Intent intent2 = new Intent(Analytics.ACTION_ANALYTICS_START);
                        intent2.setClass(UAirship.shared().getApplicationContext(), CoreReceiver.class);
                        UAirship.shared().getApplicationContext().sendBroadcast(intent2);
                    }
                }
            }
            return null;
        }
    }

    class Session {
        private String id = UUID.randomUUID().toString();

        public Session() {
            Logger.verbose("New session: " + this.id);
        }

        public String getId() {
            return this.id;
        }

        public void log() {
            Logger.verbose("Analytics Session - id: " + this.id);
        }
    }

    static String getHashedDeviceId() {
        String string = Settings.Secure.getString(UAirship.shared().getApplicationContext().getContentResolver(), TapjoyConstants.TJC_ANDROID_ID);
        if (string == null) {
            return "unavailable";
        }
        byte[] bytes = string.getBytes();
        try {
            MessageDigest messageDigest = MessageDigest.getInstance("SHA-1");
            messageDigest.update(bytes, 0, bytes.length);
            byte[] bArrDigest = messageDigest.digest();
            StringBuilder sb = new StringBuilder();
            for (byte b : bArrDigest) {
                sb.append(String.format("%02x", Byte.valueOf(b)));
            }
            return sb.toString();
        } catch (NoSuchAlgorithmException e) {
            Logger.error("Unable to hash the device ID: SHA1 digester not present");
            return "unavailable";
        }
    }

    public void activityStarted(Activity activity) {
        this.activityMonitor.addActivity(activity);
        addEvent(new ActivityStartedEvent(activity));
    }

    public void activityStopped(Activity activity) {
        addEvent(new ActivityStoppedEvent(activity));
        this.activityMonitor.removeActivity(activity);
    }

    public void addEvent(final Event event) {
        String str = UAirship.shared().getAirshipConfigOptions().analyticsServer;
        if (str == null || str.length() == 0 || !UAirship.shared().getAirshipConfigOptions().analyticsEnabled) {
            return;
        }
        event.log();
        new Handler(Looper.getMainLooper()).post(new Runnable() { // from class: com.urbanairship.analytics.Analytics.2
            @Override // java.lang.Runnable
            public void run() {
                Analytics.this.new AddEventTask().execute(event);
            }
        });
    }

    public String getConversionPushId() {
        return this.conversionPushId;
    }

    String getServer() {
        return this.server;
    }

    Session getSession() {
        return this.session;
    }

    public void setConversionPushId(String str) {
        this.conversionPushId = str;
    }

    public void startUploadingIfNecessary() {
        this.uploadManager.startUploadingIfNecessary();
    }
}
