package com.urbanairship.push.c2dm;

import android.app.PendingIntent;
import android.content.Context;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.os.Build;
import com.tapjoy.TapjoyConstants;
import com.urbanairship.Logger;
import com.urbanairship.UAirship;
import com.urbanairship.push.PushManager;
import com.urbanairship.push.PushPreferences;
import com.urbanairship.push.embedded.BoxOfficeClient;
import com.urbanairship.restclient.AsyncHandler;
import com.urbanairship.restclient.Request;
import com.urbanairship.restclient.Response;
import java.io.UnsupportedEncodingException;
import java.util.UUID;
import org.apache.http.entity.StringEntity;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

/* JADX INFO: loaded from: classes.dex */
public class C2DMPushManager {
    private static final String INTENT_REGISTER = "com.google.android.c2dm.intent.REGISTER";
    private static final String INTENT_UNREGISTER = "com.google.android.c2dm.intent.UNREGISTER";
    private static final long MAX_BACKOFF_TIME = 5120000;
    public static final String PERMISSION_RECEIVE = "com.google.android.c2dm.permission.RECEIVE";
    public static final C2DMPushManager instance = new C2DMPushManager();
    private static long backoffTime = 10000;
    private static PackageManager packageManager = null;

    private C2DMPushManager() {
    }

    public static void init() {
        Logger.info("Initializing C2DM Push ...");
        if (!isPermissionKnown(PERMISSION_RECEIVE)) {
            Logger.error("com.google.android.c2dm.permission.RECEIVE is unknown to PackageManager. Note that an AVD emulator may not support C2DM.");
            Logger.error("If you're running in an emulator, you need to install the appropriate image through the Android SDK and AVM manager. See http://code.google.com/android/c2dm/ for further details.");
        } else {
            if (Build.VERSION.SDK_INT < 8) {
                Logger.debug("C2DM not supported in API level " + Build.VERSION.SDK_INT);
                PushManager.shared().c2dmRegistrationFailed("PHONE_REGISTRATION_ERROR");
                return;
            }
            PushPreferences preferences = PushManager.shared().getPreferences();
            if (preferences.getC2DMId() == null) {
                register();
            } else {
                Logger.info("Using C2DM ID: " + preferences.getC2DMId());
                PushManager.shared().updateApidIfNecessary();
            }
        }
    }

    public static boolean isPermissionKnown(String str) {
        PackageManager packageManager2 = packageManager;
        if (packageManager2 == null) {
            packageManager2 = UAirship.getPackageManager();
        }
        try {
            packageManager2.getPermissionInfo(str, 0);
            return true;
        } catch (PackageManager.NameNotFoundException e) {
            return false;
        }
    }

    public static void register() {
        register(0L);
    }

    public static void register(final long j) {
        new Thread() { // from class: com.urbanairship.push.c2dm.C2DMPushManager.1
            @Override // java.lang.Thread, java.lang.Runnable
            public void run() {
                try {
                    Thread.sleep(j);
                } catch (InterruptedException e) {
                    Logger.error(e);
                }
                Context applicationContext = UAirship.shared().getApplicationContext();
                String str = UAirship.shared().getAirshipConfigOptions().c2dmSender;
                if (str == null) {
                    Logger.error("The C2DM sender email is not set. Unable to register.");
                    return;
                }
                if (PushManager.shared().getPreferences().getPushSecret() == null) {
                    try {
                        new BoxOfficeClient().firstRun();
                    } catch (BoxOfficeClient.FirstRunForbiddenException e2) {
                        Logger.error(e2);
                        PushManager.stopService();
                        return;
                    } catch (BoxOfficeClient.BoxOfficeException e3) {
                        Logger.error("Firstrun failed, will retry. Error: " + e3.getMessage());
                        C2DMPushManager.retryRegistration();
                        return;
                    }
                }
                Intent intent = new Intent(C2DMPushManager.INTENT_REGISTER);
                intent.putExtra("app", PendingIntent.getBroadcast(applicationContext, 0, new Intent(), 0));
                intent.putExtra("sender", str);
                applicationContext.startService(intent);
                Logger.info("Sent C2DM registration, sender: " + str);
            }
        }.start();
    }

    public static void retryRegistration() {
        register(backoffTime);
        backoffTime *= 2;
        if (backoffTime > MAX_BACKOFF_TIME) {
            backoffTime = MAX_BACKOFF_TIME;
        }
    }

    public static void sendTestPush(String str, String str2) {
        Logger.info("Attempting to send a test C2DM push");
        JSONObject jSONObject = new JSONObject();
        JSONObject jSONObject2 = new JSONObject();
        JSONObject jSONObject3 = new JSONObject();
        JSONArray jSONArray = new JSONArray();
        jSONArray.put(PushManager.shared().getPreferences().getPushId());
        final String string = UUID.randomUUID().toString();
        try {
            jSONObject2.put("alert", str2);
            jSONObject3.put("id", string);
            jSONObject2.put("extra", jSONObject3);
            jSONObject.put("apids", jSONArray);
            jSONObject.put(TapjoyConstants.TJC_DEVICE_PLATFORM_TYPE, jSONObject2);
            String string2 = jSONObject.toString(0);
            Request request = new Request("POST", UAirship.shared().getAirshipConfigOptions().hostURL + "api/push/");
            request.setAuth(UAirship.shared().getAirshipConfigOptions().developmentAppKey, str);
            request.addHeader("Content-Type", "application/json");
            try {
                request.setEntity(new StringEntity(string2));
                request.executeAsync(new AsyncHandler() { // from class: com.urbanairship.push.c2dm.C2DMPushManager.2
                    @Override // com.urbanairship.restclient.AsyncHandler
                    public void onComplete(Response response) {
                        if (response.status() == 200) {
                            Logger.info("C2DM Push" + string + " sent");
                        } else {
                            Logger.error("C2DM Push Failed!  Status: " + response.status());
                        }
                    }

                    @Override // com.urbanairship.restclient.AsyncHandler
                    public void onError(Exception exc) {
                        Logger.error("Couldn't create C2DM Push!");
                    }
                });
            } catch (UnsupportedEncodingException e) {
                Logger.error(e);
            }
        } catch (JSONException e2) {
            Logger.error("Couldn't serialize JSON for C2DM push!", e2);
        }
    }

    public static C2DMPushManager shared() {
        return instance;
    }

    public static void unregister() {
        Context applicationContext = UAirship.shared().getApplicationContext();
        Intent intent = new Intent(INTENT_UNREGISTER);
        intent.putExtra("app", PendingIntent.getBroadcast(applicationContext, 0, new Intent(), 0));
        UAirship.shared().getApplicationContext().startService(intent);
    }

    public static void usePackageManager(PackageManager packageManager2) {
        packageManager = packageManager2;
    }
}
