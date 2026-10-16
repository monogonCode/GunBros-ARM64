package com.urbanairship.push;

import android.app.AlarmManager;
import android.app.Notification;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.content.BroadcastReceiver;
import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.content.pm.PackageManager;
import com.urbanairship.AirshipConfigOptions;
import com.urbanairship.CoreReceiver;
import com.urbanairship.Logger;
import com.urbanairship.UAirship;
import com.urbanairship.analytics.PushArrivedEvent;
import com.urbanairship.push.c2dm.C2DMPushManager;
import com.urbanairship.push.c2dm.C2DMPushReceiver;
import com.urbanairship.push.embedded.EmbeddedPushManager;
import com.urbanairship.restclient.AppAuthenticatedRequest;
import com.urbanairship.restclient.AsyncHandler;
import com.urbanairship.restclient.RequestQueue;
import com.urbanairship.restclient.Response;
import java.io.UnsupportedEncodingException;
import java.util.Collection;
import java.util.Map;
import java.util.Set;
import java.util.UUID;
import org.apache.http.entity.StringEntity;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

/* JADX INFO: loaded from: classes.dex */
public class PushManager {
    private static final String ACTION_DELETE_APID = "com.urbanairship.push.DELETE_APID";
    public static final String ACTION_NOTIFICATION_OPENED = "com.urbanairship.push.NOTIFICATION_OPENED";
    public static final String ACTION_NOTIFICATION_OPENED_PROXY = "com.urbanairship.push.NOTIFICATION_OPENED_PROXY";
    public static final String ACTION_PUSH_RECEIVED = "com.urbanairship.push.PUSH_RECEIVED";
    public static final String ACTION_REGISTRATION_FINISHED = "com.urbanairship.push.REGISTRATION_FINISHED";
    private static final String ACTION_UPDATE_APID = "com.urbanairship.push.UPDATE_APID";
    public static final String EXTRA_ALERT = "com.urbanairship.push.ALERT";
    public static final String EXTRA_APID = "com.urbanairship.push.APID";
    public static final String EXTRA_C2DM_REGISTRATION_ID = "com.urbanairship.push.C2DM_REGISTRATION_ID";
    public static final String EXTRA_EXPIRATION = "com.urbanairship.push.EXPIRATION";
    public static final String EXTRA_NOTIFICATION_ID = "com.urbanairship.push.NOTIFICATION_ID";
    private static final String EXTRA_PING = "com.urbanairship.push.PING";
    public static final String EXTRA_PUSH_ID = "com.urbanairship.push.PUSH_ID";
    public static final String EXTRA_REGISTRATION_ERROR = "com.urbanairship.push.REGISTRATION_ERROR";
    public static final String EXTRA_REGISTRATION_VALID = "com.urbanairship.push.REGISTRATION_VALID";
    public static final String EXTRA_STRING_EXTRA = "com.urbanairship.push.STRING_EXTRA";
    private static final PushManager instance = new PushManager();
    private DeleteApidReceiver deleteApidReceiver;
    private Class<? extends BroadcastReceiver> intentReceiver;
    private PushNotificationBuilder notificationBuilder;
    private UpdateApidReceiver updateApidReceiver;
    private Boolean reconnecting = false;
    private PushPreferences preferences = new PushPreferences();
    private RequestQueue requestQueue = new RequestQueue();

    private class DeleteApidReceiver extends BroadcastReceiver {
        private DeleteApidReceiver() {
        }

        @Override // android.content.BroadcastReceiver
        public void onReceive(Context context, Intent intent) {
            String stringExtra;
            if (intent == null || (stringExtra = intent.getStringExtra(PushManager.EXTRA_APID)) == null) {
                return;
            }
            PushManager.this.deleteApid(stringExtra);
        }
    }

    private class UpdateApidReceiver extends BroadcastReceiver {
        private UpdateApidReceiver() {
        }

        @Override // android.content.BroadcastReceiver
        public void onReceive(Context context, Intent intent) {
            PushManager.this.updateApid();
        }
    }

    private PushManager() {
        this.updateApidReceiver = new UpdateApidReceiver();
        this.deleteApidReceiver = new DeleteApidReceiver();
        this.requestQueue.setMaxConcurrentRequests(1);
        Context applicationContext = UAirship.shared().getApplicationContext();
        applicationContext.registerReceiver(this.updateApidReceiver, new IntentFilter(ACTION_UPDATE_APID));
        applicationContext.registerReceiver(this.deleteApidReceiver, new IntentFilter(ACTION_DELETE_APID));
        this.notificationBuilder = new BasicPushNotificationBuilder();
    }

    private static void checkRequiredPermission(String str) {
        PackageManager packageManager = UAirship.getPackageManager();
        if (!isPermissionKnown(str)) {
            Logger.error("Required permission " + str + " is unknown to PackageManager.");
        } else if (-1 == packageManager.checkPermission(str, UAirship.getPackageName())) {
            Logger.error("AndroidManifest.xml missing required push permission: " + str);
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void deleteApid(final String str) {
        Logger.debug("Deleting APID: " + str);
        if (str == null || str.length() == 0) {
            Logger.error("No APID. Cannot delete.");
            return;
        }
        String str2 = UAirship.shared().getAirshipConfigOptions().hostURL + "api/apids/" + str;
        Logger.verbose("URL: " + str2);
        this.requestQueue.addRequest(new AppAuthenticatedRequest("DELETE", str2), new AsyncHandler() { // from class: com.urbanairship.push.PushManager.2
            @Override // com.urbanairship.restclient.AsyncHandler
            public void onComplete(Response response) {
                Logger.info("Delete APID status code: " + response.status());
                if (response.status() == 204) {
                    Logger.info("Delete request succeeded.");
                } else {
                    Logger.info("Delete request failed. Response status: " + response.status());
                }
            }

            @Override // com.urbanairship.restclient.AsyncHandler
            public void onError(Exception exc) {
                Logger.error("Error deleting APID", exc);
                PushManager.this.scheduleAction(PushManager.ACTION_DELETE_APID, str);
            }
        });
    }

    public static void deliverPush(String str, String str2, Map<String, String> map) {
        Notification notificationBuildNotification;
        if (!shared().getPreferences().isPushEnabled()) {
            Logger.info("Received a push when push is disabled! Ignoring.");
            return;
        }
        String strRemove = map.remove(EXTRA_APID);
        if (strRemove != null && !strRemove.equalsIgnoreCase(shared().getPreferences().getPushId())) {
            Logger.info("Received a push addressed to a different APID: " + strRemove);
            instance.deleteApid(strRemove);
            return;
        }
        if (str2 == null) {
            str2 = UUID.randomUUID().toString();
        }
        UAirship.shared().getAnalytics().addEvent(new PushArrivedEvent(str2));
        if (map.containsKey(EXTRA_PING)) {
            Logger.verbose("Received UA Ping.");
            return;
        }
        if (map.containsKey(EXTRA_EXPIRATION)) {
            String str3 = map.get(EXTRA_EXPIRATION);
            Logger.debug("Notification expiration time is \"" + str3 + "\"");
            try {
                if (Long.parseLong(str3) * 1000 < System.currentTimeMillis()) {
                    Logger.debug("Notification expired, ignoring.");
                    return;
                }
            } catch (NumberFormatException e) {
                Logger.debug("Ignoring malformed expiration time: " + e.getMessage());
            }
            Logger.debug("Notification current, delivering.");
            map.remove(EXTRA_EXPIRATION);
        }
        Context applicationContext = UAirship.shared().getApplicationContext();
        Intent intent = new Intent(ACTION_PUSH_RECEIVED);
        PushNotificationBuilder notificationBuilder = shared().getNotificationBuilder();
        if (notificationBuilder != null && (notificationBuildNotification = notificationBuilder.buildNotification(str, map)) != null) {
            int nextId = notificationBuilder.getNextId(str, map);
            intent.putExtra(EXTRA_NOTIFICATION_ID, nextId);
            if (notificationBuildNotification.contentIntent == null) {
                Intent intent2 = new Intent("com.urbanairship.push.NOTIFICATION_OPENED_PROXY." + UUID.randomUUID().toString());
                intent2.setClass(UAirship.shared().getApplicationContext(), CoreReceiver.class);
                for (String str4 : map.keySet()) {
                    intent2.putExtra(str4, map.get(str4));
                }
                intent2.putExtra(EXTRA_ALERT, str);
                intent2.putExtra(EXTRA_PUSH_ID, str2);
                notificationBuildNotification.contentIntent = PendingIntent.getBroadcast(UAirship.shared().getApplicationContext(), 0, intent2, 0);
            }
            ((NotificationManager) applicationContext.getSystemService("notification")).notify(nextId, notificationBuildNotification);
        }
        Class<?> intentReceiver = shared().getIntentReceiver();
        if (intentReceiver != null) {
            intent.setClass(UAirship.shared().getApplicationContext(), intentReceiver);
            for (String str5 : map.keySet()) {
                intent.putExtra(str5, map.get(str5));
            }
            intent.putExtra(EXTRA_ALERT, str);
            intent.putExtra(EXTRA_PUSH_ID, str2);
            applicationContext.sendBroadcast(intent);
        }
    }

    public static void disablePush() {
        if (instance.preferences.isPushEnabled()) {
            instance.preferences.setPushEnabled(false);
            if (instance.preferences.getC2DMId() != null) {
                instance.setC2DMId(null);
                C2DMPushManager.unregister();
            }
            instance.deleteApid(instance.preferences.getPushId());
            EmbeddedPushManager.shared().stopHeartBeat();
            stopService();
        }
    }

    public static void enablePush() {
        if (instance.preferences.isPushEnabled()) {
            return;
        }
        instance.preferences.setPushEnabled(true);
        startService();
    }

    public static void init() {
        if (!UAirship.shared().isFlying()) {
            throw new IllegalStateException("UAirship.takeOff must be called before PushManager.init!");
        }
        Logger.verbose("PushManager init");
        startService();
    }

    private static boolean isPermissionKnown(String str) {
        try {
            UAirship.getPackageManager().getPermissionInfo(str, 0);
            return true;
        } catch (PackageManager.NameNotFoundException e) {
            return false;
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void scheduleAction(String str, String str2) {
        AlarmManager alarmManager = (AlarmManager) UAirship.shared().getApplicationContext().getSystemService("alarm");
        Intent intent = new Intent();
        intent.setClass(UAirship.shared().getApplicationContext(), PushManager.class);
        intent.setAction(str);
        intent.putExtra(EXTRA_APID, str2);
        PendingIntent service = PendingIntent.getService(UAirship.shared().getApplicationContext(), 0, intent, 0);
        long jCurrentTimeMillis = System.currentTimeMillis() + 600000;
        Logger.info("Scheduling action " + str + " in 10 minutes");
        alarmManager.set(1, jCurrentTimeMillis, service);
    }

    public static PushManager shared() {
        return instance;
    }

    public static void startService() {
        Logger.verbose("PushManager startService");
        Context applicationContext = UAirship.shared().getApplicationContext();
        Intent intent = new Intent(applicationContext, (Class<?>) PushService.class);
        intent.setAction(PushService.ACTION_START);
        applicationContext.startService(intent);
    }

    public static void stopService() {
        Logger.verbose("PushManager stopService");
        Context applicationContext = UAirship.shared().getApplicationContext();
        Intent intent = new Intent(applicationContext, (Class<?>) PushService.class);
        intent.setAction(PushService.ACTION_STOP);
        applicationContext.stopService(intent);
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* JADX WARN: Type inference fix 'apply assigned field type' failed
    java.lang.UnsupportedOperationException: ArgType.getObject(), call class: class jadx.core.dex.instructions.args.ArgType$UnknownArg
    	at jadx.core.dex.instructions.args.ArgType.getObject(ArgType.java:596)
    	at jadx.core.dex.attributes.nodes.ClassTypeVarsAttr.getTypeVarsMapFor(ClassTypeVarsAttr.java:35)
    	at jadx.core.dex.nodes.utils.TypeUtils.replaceClassGenerics(TypeUtils.java:177)
    	at jadx.core.dex.visitors.typeinference.FixTypesVisitor.insertExplicitUseCast(FixTypesVisitor.java:397)
    	at jadx.core.dex.visitors.typeinference.FixTypesVisitor.tryFieldTypeWithNewCasts(FixTypesVisitor.java:359)
    	at jadx.core.dex.visitors.typeinference.FixTypesVisitor.applyFieldType(FixTypesVisitor.java:309)
    	at jadx.core.dex.visitors.typeinference.FixTypesVisitor.visit(FixTypesVisitor.java:94)
     */
    public void updateApid() {
        this.preferences.setApidUpdateNeeded(true);
        final String pushId = this.preferences.getPushId();
        Logger.debug("Updating APID: " + pushId);
        if (pushId == null || pushId.length() == 0) {
            Logger.error("No APID. Cannot update.");
            return;
        }
        String str = UAirship.shared().getAirshipConfigOptions().hostURL + "api/apids/" + pushId;
        String c2DMId = getC2DMId();
        JSONObject jSONObject = new JSONObject();
        try {
            jSONObject.put("alias", getAlias());
            jSONObject.put("tags", new JSONArray((Collection) getTags()));
            jSONObject.put("c2dm_registration_id", c2DMId);
            Logger.verbose("URL: " + str);
            AppAuthenticatedRequest appAuthenticatedRequest = new AppAuthenticatedRequest("PUT", str);
            try {
                StringEntity stringEntity = new StringEntity(jSONObject.toString());
                stringEntity.setContentType("application/json");
                appAuthenticatedRequest.setEntity(stringEntity);
                Logger.verbose("Body: " + jSONObject.toString());
            } catch (UnsupportedEncodingException e) {
                Logger.error("Error setting registrationRequest entity.");
            }
            this.requestQueue.addRequest(appAuthenticatedRequest, new AsyncHandler() { // from class: com.urbanairship.push.PushManager.1
                @Override // com.urbanairship.restclient.AsyncHandler
                public void onComplete(Response response) {
                    String strBody = response.body();
                    Logger.info("Registration status code: " + response.status());
                    Logger.verbose("Registration result " + strBody);
                    if (response.status() != 200) {
                        Logger.info("Registration request response status: " + response.status());
                        return;
                    }
                    Logger.info("Registration request succeeded.");
                    PushManager.this.preferences.setApidUpdateNeeded(false);
                    PushManager.this.sendRegistrationFinishedBroadcast(true);
                }

                @Override // com.urbanairship.restclient.AsyncHandler
                public void onError(Exception exc) {
                    Logger.error("Error registering APID");
                    PushManager.this.scheduleAction(PushManager.ACTION_UPDATE_APID, pushId);
                }
            });
        } catch (JSONException e2) {
            Logger.error("Error creating JSON Registration body.");
        }
    }

    public static void validateManifest() {
        PackageManager packageManager = UAirship.getPackageManager();
        String packageName = UAirship.getPackageName();
        AirshipConfigOptions airshipConfigOptions = UAirship.shared().getAirshipConfigOptions();
        try {
            packageManager.getServiceInfo(new ComponentName(packageName, PushService.class.getCanonicalName()), 128);
        } catch (PackageManager.NameNotFoundException e) {
            Logger.error("AndroidManifest.xml missing required service: " + PushService.class.getCanonicalName());
        }
        if (AirshipConfigOptions.TransportType.C2DM == airshipConfigOptions.getTransport() || AirshipConfigOptions.TransportType.HYBRID == airshipConfigOptions.getTransport()) {
            checkRequiredPermission(C2DMPushManager.PERMISSION_RECEIVE);
            checkRequiredPermission(packageName + ".permission.C2D_MESSAGE");
            try {
                packageManager.getReceiverInfo(new ComponentName(packageName, C2DMPushReceiver.class.getCanonicalName()), 128);
                Intent intent = new Intent(C2DMPushReceiver.INTENT_RECEIVE);
                intent.addCategory(packageName);
                if (packageManager.queryBroadcastReceivers(intent, 0).isEmpty()) {
                    Logger.error("AndroidManifest.xml's " + C2DMPushReceiver.class.getCanonicalName() + " declaration missing required " + intent.getAction() + " filter with category=" + packageName);
                }
                Intent intent2 = new Intent(C2DMPushReceiver.INTENT_REGISTRATION);
                intent2.addCategory(packageName);
                if (packageManager.queryBroadcastReceivers(intent, 0).isEmpty()) {
                    Logger.error("AndroidManifest.xml's " + C2DMPushReceiver.class.getCanonicalName() + " declaration missing required " + intent2.getAction() + " filter with category=" + packageName);
                }
            } catch (PackageManager.NameNotFoundException e2) {
                Logger.error("AndroidManifest.xml missing required receiver: " + C2DMPushReceiver.class.getCanonicalName());
            }
        }
        if (AirshipConfigOptions.TransportType.HELIUM == airshipConfigOptions.getTransport() || AirshipConfigOptions.TransportType.HYBRID == airshipConfigOptions.getTransport()) {
            checkRequiredPermission("android.permission.RECEIVE_BOOT_COMPLETED");
        }
    }

    public void c2dmRegistrationFailed(String str) {
        boolean z = true;
        Logger.error("C2DM Failure: " + str);
        if ("SERVICE_NOT_AVAILABLE".equals(str)) {
            C2DMPushManager.retryRegistration();
            z = false;
        } else if (!"ACCOUNT_MISSING".equals(str) && !"AUTHENTICATION_FAILED".equals(str) && !"TOO_MANY_REGISTRATIONS".equals(str)) {
            if ("INVALID_SENDER".equals(str)) {
                Logger.error("Your C2DM sender ID is invalid. Please check your AirshipConfig.");
            } else if (!"PHONE_REGISTRATION_ERROR".equals(str)) {
                z = false;
            }
        }
        if (z) {
            setC2DMId(null);
            if (UAirship.shared().getAirshipConfigOptions().getTransport() == AirshipConfigOptions.TransportType.HYBRID) {
                EmbeddedPushManager.init(UAirship.shared().getApplicationContext(), UAirship.shared().getAirshipConfigOptions().getAppKey());
            }
        }
        Context applicationContext = UAirship.shared().getApplicationContext();
        Class<?> intentReceiver = shared().getIntentReceiver();
        if (intentReceiver != null) {
            Intent intent = new Intent(ACTION_REGISTRATION_FINISHED);
            intent.setClass(UAirship.shared().getApplicationContext(), intentReceiver);
            intent.putExtra(EXTRA_APID, this.preferences.getPushId());
            intent.putExtra(EXTRA_REGISTRATION_VALID, false);
            intent.putExtra(EXTRA_REGISTRATION_ERROR, str);
            applicationContext.sendBroadcast(intent);
        }
    }

    public void c2dmRegistrationResponseReceived(String str) {
        setC2DMId(str);
    }

    public String getAPID() {
        if (this.preferences.isAPIDReady()) {
            return this.preferences.getPushId();
        }
        return null;
    }

    public String getAlias() {
        return getPreferences().getAlias();
    }

    public String getC2DMId() {
        return getPreferences().getC2DMId();
    }

    public Class<?> getIntentReceiver() {
        return this.intentReceiver;
    }

    public PushNotificationBuilder getNotificationBuilder() {
        return this.notificationBuilder;
    }

    public PushPreferences getPreferences() {
        return this.preferences;
    }

    public Set<String> getTags() {
        return getPreferences().getTags();
    }

    public void heliumRegistrationResponseReceived(boolean z) {
        boolean extraApidRegistrationsDisabled = EmbeddedPushManager.shared().getExtraApidRegistrationsDisabled();
        if (!extraApidRegistrationsDisabled && this.preferences.isApidUpdateNeeded()) {
            updateApid();
        } else {
            if (!extraApidRegistrationsDisabled || this.reconnecting.booleanValue()) {
                return;
            }
            sendRegistrationFinishedBroadcast(z);
        }
    }

    public void sendRegistrationFinishedBroadcast(boolean z) {
        this.preferences.setAPIDReady(z);
        Context applicationContext = UAirship.shared().getApplicationContext();
        Class<?> intentReceiver = shared().getIntentReceiver();
        if (intentReceiver != null) {
            Intent intent = new Intent(ACTION_REGISTRATION_FINISHED);
            intent.setClass(applicationContext, intentReceiver);
            intent.putExtra(EXTRA_APID, this.preferences.getPushId());
            intent.putExtra(EXTRA_REGISTRATION_VALID, z);
            this.reconnecting = Boolean.valueOf(z);
            if (this.preferences.getC2DMId() != null) {
                intent.putExtra(EXTRA_C2DM_REGISTRATION_ID, this.preferences.getC2DMId());
            }
            applicationContext.sendBroadcast(intent);
        }
    }

    public void setAlias(String str) {
        PushPreferences preferences = getPreferences();
        String alias = preferences.getAlias();
        if (str == null && alias == null) {
            return;
        }
        if (str == null || !str.equals(alias)) {
            preferences.setAlias(str);
            updateApid();
        }
    }

    public void setAliasAndTags(String str, Set<String> set) {
        boolean z;
        boolean z2 = true;
        boolean z3 = false;
        if (set == null) {
            throw new IllegalArgumentException("Tags must be non-null.");
        }
        PushPreferences preferences = getPreferences();
        String alias = preferences.getAlias();
        if (str == null && alias == null) {
            z = false;
        } else {
            z = str == null || !str.equals(alias);
        }
        if (z) {
            preferences.setAlias(str);
            z3 = true;
        }
        if (set.equals(preferences.getTags())) {
            z2 = z3;
        } else {
            preferences.setTags(set);
        }
        if (z2) {
            updateApid();
        }
    }

    public void setC2DMId(String str) {
        PushPreferences preferences = getPreferences();
        String c2DMId = preferences.getC2DMId();
        if (c2DMId != null) {
            if (c2DMId.equals(str)) {
                return;
            }
        } else if (str == null) {
            return;
        }
        preferences.setC2DMId(str);
        updateApid();
    }

    public void setIntentReceiver(Class<? extends BroadcastReceiver> cls) {
        try {
            UAirship.getPackageManager().getReceiverInfo(new ComponentName(UAirship.getPackageName(), cls.getCanonicalName()), 128);
            this.intentReceiver = cls;
        } catch (PackageManager.NameNotFoundException e) {
            Logger.error("The receiver class passed to PushManager.setIntentReceiver() is not declared in the manifest.");
            Logger.error("AndroidManifest.xml missing required receiver: " + cls.getCanonicalName());
        }
    }

    public void setNotificationBuilder(PushNotificationBuilder pushNotificationBuilder) {
        this.notificationBuilder = pushNotificationBuilder;
    }

    public void setTags(Set<String> set) {
        if (set == null) {
            throw new IllegalArgumentException("Tags must be non-null.");
        }
        PushPreferences preferences = getPreferences();
        if (set.equals(preferences.getTags())) {
            return;
        }
        preferences.setTags(set);
        updateApid();
    }

    public void updateApidIfNecessary() {
        if (this.preferences.isApidUpdateNeeded()) {
            updateApid();
        }
    }
}
