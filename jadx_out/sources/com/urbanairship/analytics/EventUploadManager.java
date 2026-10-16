package com.urbanairship.analytics;

import android.os.Build;
import com.tapjoy.TapjoyConstants;
import com.urbanairship.AirshipConfigOptions;
import com.urbanairship.Logger;
import com.urbanairship.Preferences;
import com.urbanairship.UAirship;
import com.urbanairship.push.PushManager;
import com.urbanairship.restclient.Request;
import com.urbanairship.restclient.Response;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.Collection;
import java.util.Collections;
import java.util.Iterator;
import java.util.Map;
import java.util.zip.GZIPOutputStream;
import org.apache.http.Header;
import org.apache.http.entity.ByteArrayEntity;

/* JADX INFO: loaded from: classes.dex */
class EventUploadManager implements Runnable {
    public static final int DEFAULT_BATCH_SIZE = 102400;
    public static final String LAST_SEND_KEY = "LAST_SEND";
    public static final int MAX_BATCH_SIZE = 512000;
    public static final String MAX_BATCH_SIZE_KEY = "MAX_BATCH_SIZE";
    public static final int MAX_TOTAL_DB_SIZE = 5120000;
    public static final String MAX_TOTAL_DB_SIZE_KEY = "MAX_TOTAL_DB_SIZE";
    public static final String MAX_WAIT_KEY = "MAX_WAIT";
    public static final int MAX_WAIT_MS = 604800000;
    public static final String MIN_BATCH_INTERVAL_KEY = "MIN_BATCH_INTERVAL";
    public static final int MIN_BATCH_INTERVAL_MS = 60000;
    private int batchSize;
    private Thread currentThread;
    private EventDataManager dataManager;
    private long lastSendTime;
    private int maxBatchSize;
    private int maxTotalDBSize;
    private int maxWait;
    private int minBatchInterval;
    private Preferences prefs = new Preferences("com.urbanairship.analytics");
    private volatile boolean running;
    private boolean useGzip;

    public EventUploadManager(EventDataManager eventDataManager) {
        loadPrefs();
        this.batchSize = DEFAULT_BATCH_SIZE;
        this.dataManager = eventDataManager;
        this.useGzip = true;
    }

    private void loadPrefs() {
        this.maxTotalDBSize = this.prefs.getInt(MAX_TOTAL_DB_SIZE_KEY, MAX_TOTAL_DB_SIZE);
        this.maxBatchSize = this.prefs.getInt(MAX_BATCH_SIZE_KEY, MAX_BATCH_SIZE);
        this.maxWait = this.prefs.getInt(MAX_WAIT_KEY, MAX_WAIT_MS);
        this.minBatchInterval = this.prefs.getInt(MIN_BATCH_INTERVAL_KEY, 60000);
        this.lastSendTime = this.prefs.getLong(LAST_SEND_KEY, System.currentTimeMillis());
    }

    private void saveHeaders(Response response) {
        int i = MAX_TOTAL_DB_SIZE;
        Header firstHeader = response.getFirstHeader("X-UA-Max-Total");
        Header firstHeader2 = response.getFirstHeader("X-UA-Max-Batch");
        Header firstHeader3 = response.getFirstHeader("X-UA-Max-Wait");
        Header firstHeader4 = response.getFirstHeader("X-UA-Min-Batch-Interval");
        if (firstHeader != null) {
            int iMin = Math.min(Integer.parseInt(firstHeader.getValue()) * 1024, MAX_TOTAL_DB_SIZE);
            if (iMin > 0) {
                i = iMin;
            }
            this.maxTotalDBSize = i;
        }
        if (firstHeader2 != null) {
            int iMin2 = Math.min(Integer.parseInt(firstHeader2.getValue()) * 1024, MAX_BATCH_SIZE);
            if (iMin2 <= 0) {
                iMin2 = 512000;
            }
            this.maxBatchSize = iMin2;
        }
        if (firstHeader3 != null) {
            int iMin3 = Math.min(Integer.parseInt(firstHeader3.getValue()), MAX_WAIT_MS);
            if (iMin3 <= 0) {
                iMin3 = 604800000;
            }
            this.maxWait = iMin3;
        }
        if (firstHeader4 != null) {
            int iMax = Math.max(Integer.parseInt(firstHeader4.getValue()), 60000);
            if (iMax <= 0) {
                iMax = 60000;
            }
            this.minBatchInterval = iMax;
        }
        savePrefs();
    }

    private void savePrefs() {
        this.prefs.putInt(MAX_TOTAL_DB_SIZE_KEY, this.maxTotalDBSize);
        this.prefs.putInt(MAX_BATCH_SIZE_KEY, this.maxBatchSize);
        this.prefs.putInt(MAX_WAIT_KEY, this.maxWait);
        this.prefs.putInt(MIN_BATCH_INTERVAL_KEY, this.minBatchInterval);
        this.prefs.putLong(LAST_SEND_KEY, this.lastSendTime);
    }

    private boolean send(Collection<String> collection) {
        ByteArrayEntity byteArrayEntity;
        if (collection == null) {
            Logger.error("Send failed. No events.");
            return false;
        }
        Logger.info("Sending " + collection.size() + " events.");
        ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
        try {
            byteArrayOutputStream.write("[".getBytes());
            Iterator<String> it = collection.iterator();
            while (it.hasNext()) {
                byteArrayOutputStream.write(it.next().getBytes());
                if (it.hasNext()) {
                    byteArrayOutputStream.write(",".getBytes());
                }
            }
            byteArrayOutputStream.write("]".getBytes());
            byte[] byteArray = byteArrayOutputStream.toByteArray();
            Request request = new Request("POST", UAirship.shared().getAirshipConfigOptions().analyticsServer + "warp9/");
            if (this.useGzip) {
                try {
                    int length = byteArray.length / 4;
                    ByteArrayOutputStream byteArrayOutputStream2 = new ByteArrayOutputStream(length);
                    GZIPOutputStream gZIPOutputStream = new GZIPOutputStream(byteArrayOutputStream2);
                    gZIPOutputStream.write(byteArray);
                    gZIPOutputStream.close();
                    byte[] byteArray2 = byteArrayOutputStream2.toByteArray();
                    Logger.verbose("GZIP'd: " + byteArray.length + " into " + byteArray2.length + " (expected " + length + ")");
                    byteArrayEntity = new ByteArrayEntity(byteArray2);
                    try {
                        byteArrayEntity.setContentEncoding("gzip");
                    } catch (IOException e) {
                        Logger.error("GZIP of analytics payload failed.");
                    }
                } catch (IOException e2) {
                    byteArrayEntity = null;
                }
            } else {
                byteArrayEntity = null;
            }
            if (byteArrayEntity == null) {
                byteArrayEntity = new ByteArrayEntity(byteArray);
                request.setEntity(byteArrayEntity);
            }
            byteArrayEntity.setContentType("application/json");
            request.setEntity(byteArrayEntity);
            setHeaders(request);
            Logger.debug("Sending Analytics to: " + request.getURI().toASCIIString());
            Response responseExecute = request.execute();
            if (responseExecute == null) {
                return false;
            }
            Logger.debug("Warp 9 response: " + responseExecute.status());
            saveHeaders(responseExecute);
            return responseExecute.status() == 200;
        } catch (IOException e3) {
            Logger.error("Unable to create raw JSON payload.");
            return false;
        }
    }

    private void setHeaders(Request request) {
        request.setHeader("X-UA-Device-Family", TapjoyConstants.TJC_DEVICE_PLATFORM_TYPE);
        request.setHeader("X-UA-Sent-At", Double.toString(System.currentTimeMillis() / 1000.0d));
        request.setHeader("X-UA-Package-Name", UAirship.getPackageName());
        request.setHeader("X-UA-Package-Version", UAirship.getPackageInfo().versionName);
        String hashedDeviceId = Analytics.getHashedDeviceId();
        if (hashedDeviceId.length() > 0) {
            request.setHeader("X-UA-Device-ID", hashedDeviceId);
        }
        AirshipConfigOptions airshipConfigOptions = UAirship.shared().getAirshipConfigOptions();
        request.setHeader("X-UA-App-Key", airshipConfigOptions.getAppKey());
        request.setHeader("X-UA-In-Production", Boolean.toString(airshipConfigOptions.inProduction));
        request.setHeader("X-UA-Device-Model", Build.MODEL);
        request.setHeader("X-UA-OS-Version", Build.VERSION.RELEASE);
        String pushId = PushManager.shared().getPreferences().getPushId();
        if (pushId == null || pushId.length() <= 0) {
            return;
        }
        request.setHeader("X-UA-Apid", pushId);
    }

    public int getMaxTotalDBSize() {
        return this.maxTotalDBSize;
    }

    @Override // java.lang.Runnable
    public void run() {
        this.running = true;
        while (this.running) {
            long jMax = Math.max(0L, (this.lastSendTime + ((long) this.minBatchInterval)) - System.currentTimeMillis());
            if (jMax > 0) {
                try {
                    Thread.sleep(jMax);
                } catch (InterruptedException e) {
                    Logger.info("InterruptedException in EventUploadManager. Bailing!");
                    this.running = false;
                    return;
                }
            }
            if (!this.running) {
                return;
            }
            this.lastSendTime = System.currentTimeMillis();
            this.prefs.putLong(LAST_SEND_KEY, this.lastSendTime);
            int eventCount = this.dataManager.getEventCount();
            if (eventCount <= 0) {
                this.running = false;
                Logger.info("Exiting analytics upload thread.");
                return;
            } else {
                Map<Long, String> oldestEvents = this.dataManager.getOldestEvents(this.batchSize / (this.dataManager.getDatabaseSize() / eventCount));
                if (send(oldestEvents.values())) {
                    this.dataManager.deleteEventsOlderThan(((Long) Collections.max(oldestEvents.keySet())).longValue());
                }
            }
        }
    }

    public void startUploadingIfNecessary() {
        if (this.running) {
            return;
        }
        Logger.verbose("EventUploadManager - starting upload thread");
        this.currentThread = new Thread(this);
        this.currentThread.start();
    }

    public void stopUpload() {
        this.running = false;
    }
}
