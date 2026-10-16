package com.tapjoy;

import android.content.Context;
import android.content.SharedPreferences;
import android.content.pm.PackageManager;
import android.net.ConnectivityManager;
import android.net.Uri;
import android.os.Build;
import android.provider.Settings;
import android.telephony.TelephonyManager;
import java.util.Locale;
import java.util.Timer;
import java.util.TimerTask;
import org.w3c.dom.Document;

/* JADX INFO: loaded from: classes.dex */
public class TapjoyConnectCore {
    public static final String TAPJOY_CONNECT = "TapjoyConnect";
    private TapjoyReferralTracker tapjoyReferralTracker;
    private static Context context = null;
    private static TapjoyConnectCore tapjoyConnectCore = null;
    private static TapjoyURLConnection tapjoyURLConnection = null;
    private static String androidID = "";
    private static String deviceID = "";
    private static String deviceModel = "";
    private static String deviceType = "";
    private static String deviceOSVersion = "";
    private static String deviceCountryCode = "";
    private static String deviceLanguage = "";
    private static String appID = "";
    private static String appVersion = "";
    private static String libraryVersion = "";
    private static String deviceScreenDensity = "";
    private static String deviceScreenLayoutSize = "";
    private static String userID = "";
    private static String platformName = "";
    private static String carrierName = "";
    private static String carrierCountryCode = "";
    private static String mobileCountryCode = "";
    private static String connectionType = "";
    private static String secretKey = "";
    private static String clientPackage = "";
    private static String referralURL = "";
    private static String videoIDs = "";
    private static float currencyMultiplier = 1.0f;
    private static String paidAppActionID = null;
    private long elapsed_time = 0;
    private Timer timer = null;

    public class PPAThread implements Runnable {
        private String params;

        public PPAThread(String str) {
            this.params = str;
        }

        @Override // java.lang.Runnable
        public void run() {
            String strConnectToURL = TapjoyConnectCore.tapjoyURLConnection.connectToURL("https://ws.tapjoyads.com/connect?", this.params);
            if (strConnectToURL != null) {
                TapjoyConnectCore.this.handlePayPerActionResponse(strConnectToURL);
            }
        }
    }

    private class PaidAppTimerTask extends TimerTask {
        private PaidAppTimerTask() {
        }

        @Override // java.util.TimerTask, java.lang.Runnable
        public void run() {
            TapjoyConnectCore.access$314(TapjoyConnectCore.this, 10000L);
            TapjoyLog.i("TapjoyConnect", "elapsed_time: " + TapjoyConnectCore.this.elapsed_time + " (" + ((TapjoyConnectCore.this.elapsed_time / 1000) / 60) + "m " + ((TapjoyConnectCore.this.elapsed_time / 1000) % 60) + "s)");
            SharedPreferences.Editor editorEdit = TapjoyConnectCore.context.getSharedPreferences(TapjoyConstants.TJC_PREFERENCE, 0).edit();
            editorEdit.putLong(TapjoyConstants.PREF_ELAPSED_TIME, TapjoyConnectCore.this.elapsed_time);
            editorEdit.commit();
            if (TapjoyConnectCore.this.elapsed_time >= TapjoyConstants.PAID_APP_TIME) {
                TapjoyLog.i("TapjoyConnect", "timer done...");
                if (TapjoyConnectCore.paidAppActionID != null && TapjoyConnectCore.paidAppActionID.length() > 0) {
                    TapjoyLog.i("TapjoyConnect", "Calling PPA actionComplete...");
                    TapjoyConnectCore.this.actionComplete(TapjoyConnectCore.paidAppActionID);
                }
                cancel();
            }
        }
    }

    public TapjoyConnectCore(Context context2) {
        context = context2;
        tapjoyURLConnection = new TapjoyURLConnection();
        init();
        TapjoyLog.i("TapjoyConnect", "URL parameters: " + getURLParams());
        new Thread(new Runnable() { // from class: com.tapjoy.TapjoyConnectCore.1
            @Override // java.lang.Runnable
            public void run() {
                TapjoyLog.i("TapjoyConnect", "starting connect call...");
                String uRLParams = TapjoyConnectCore.getURLParams();
                if (!TapjoyConnectCore.referralURL.equals("")) {
                    uRLParams = uRLParams + "&" + TapjoyConnectCore.referralURL;
                }
                String strConnectToURL = TapjoyConnectCore.tapjoyURLConnection.connectToURL("https://ws.tapjoyads.com/connect?", uRLParams);
                if (strConnectToURL == null || !TapjoyConnectCore.handleConnectResponse(strConnectToURL)) {
                    return;
                }
                TapjoyLog.i("TapjoyConnect", "Successfully connected to tapjoy site.");
            }
        }).start();
    }

    static /* synthetic */ long access$314(TapjoyConnectCore tapjoyConnectCore2, long j) {
        long j2 = tapjoyConnectCore2.elapsed_time + j;
        tapjoyConnectCore2.elapsed_time = j2;
        return j2;
    }

    public static String getAppID() {
        return appID;
    }

    public static String getAwardPointsVerifier(long j, int i, String str) {
        try {
            return TapjoyUtil.SHA256(appID + ":" + deviceID + ":" + j + ":" + secretKey + ":" + i + ":" + str);
        } catch (Exception e) {
            TapjoyLog.e("TapjoyConnect", "getAwardPointsVerifier ERROR: " + e.toString());
            return "";
        }
    }

    public static String getCarrierName() {
        return carrierName;
    }

    public static String getClientPackage() {
        return clientPackage;
    }

    public static Context getContext() {
        return context;
    }

    public static String getDeviceID() {
        return deviceID;
    }

    public static String getGenericURLParams() {
        return ("app_id=" + Uri.encode(appID) + "&") + getParamsWithoutAppID();
    }

    public static TapjoyConnectCore getInstance() {
        return tapjoyConnectCore;
    }

    public static int getLocalTapPointsTotal() {
        return context.getSharedPreferences(TapjoyConstants.TJC_PREFERENCE, 0).getInt(TapjoyConstants.PREF_LAST_TAP_POINTS, -9999);
    }

    private static String getParamsWithoutAppID() {
        String str;
        String str2 = (((((((((("android_id=" + androidID + "&") + "udid=" + Uri.encode(deviceID) + "&") + "device_name=" + Uri.encode(deviceModel) + "&") + "device_type=" + Uri.encode(deviceType) + "&") + "os_version=" + Uri.encode(deviceOSVersion) + "&") + "country_code=" + Uri.encode(deviceCountryCode) + "&") + "language_code=" + Uri.encode(deviceLanguage) + "&") + "app_version=" + Uri.encode(appVersion) + "&") + "library_version=" + Uri.encode(libraryVersion) + "&") + "platform=" + Uri.encode(platformName) + "&") + "display_multiplier=" + Uri.encode(Float.toString(currencyMultiplier));
        if (carrierName.length() > 0) {
            str2 = (str2 + "&") + "carrier_name=" + Uri.encode(carrierName);
        }
        if (carrierCountryCode.length() > 0 && mobileCountryCode.length() > 0) {
            str2 = (((str2 + "&") + "carrier_country_code=" + Uri.encode(carrierCountryCode)) + "&") + "mobile_country_code=" + Uri.encode(mobileCountryCode);
        }
        if (deviceScreenDensity.length() <= 0 || deviceScreenLayoutSize.length() <= 0) {
            str = str2;
        } else {
            str = ((str2 + "&") + "screen_density=" + Uri.encode(deviceScreenDensity) + "&") + "screen_layout_size=" + Uri.encode(deviceScreenLayoutSize);
        }
        ConnectivityManager connectivityManager = (ConnectivityManager) context.getSystemService("connectivity");
        if (connectivityManager != null && connectivityManager.getActiveNetworkInfo() != null) {
            switch (connectivityManager.getActiveNetworkInfo().getType()) {
                case 1:
                case 6:
                    connectionType = "wifi";
                    break;
                default:
                    connectionType = "mobile";
                    break;
            }
            TapjoyLog.i("TapjoyConnect", "connectivity: " + connectivityManager.getActiveNetworkInfo().getType());
            TapjoyLog.i("TapjoyConnect", "connection_type: " + connectionType);
        }
        if (connectionType.length() <= 0) {
            return str;
        }
        return (str + "&") + "connection_type=" + Uri.encode(connectionType);
    }

    public static String getURLParams() {
        String str = getGenericURLParams() + "&";
        long jCurrentTimeMillis = System.currentTimeMillis() / 1000;
        return (str + "timestamp=" + jCurrentTimeMillis + "&") + "verifier=" + getVerifier(jCurrentTimeMillis);
    }

    public static String getUserID() {
        return userID;
    }

    public static String getVerifier(long j) {
        try {
            return TapjoyUtil.SHA256(appID + ":" + deviceID + ":" + j + ":" + secretKey);
        } catch (Exception e) {
            TapjoyLog.e("TapjoyConnect", "getVerifier ERROR: " + e.toString());
            return "";
        }
    }

    public static String getVideoIDs() {
        return videoIDs;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static boolean handleConnectResponse(String str) {
        String nodeTrimValue;
        Document documentBuildDocument = TapjoyUtil.buildDocument(str);
        return (documentBuildDocument == null || (nodeTrimValue = TapjoyUtil.getNodeTrimValue(documentBuildDocument.getElementsByTagName("Success"))) == null || !nodeTrimValue.equals("true")) ? false : true;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public boolean handlePayPerActionResponse(String str) {
        Document documentBuildDocument = TapjoyUtil.buildDocument(str);
        if (documentBuildDocument != null) {
            String nodeTrimValue = TapjoyUtil.getNodeTrimValue(documentBuildDocument.getElementsByTagName("Success"));
            if (nodeTrimValue != null && nodeTrimValue.equals("true")) {
                TapjoyLog.i("TapjoyConnect", "Successfully sent completed Pay-Per-Action to Tapjoy server.");
                return true;
            }
            TapjoyLog.e("TapjoyConnect", "Completed Pay-Per-Action call failed.");
        }
        return false;
    }

    private void init() {
        boolean z;
        PackageManager packageManager = context.getPackageManager();
        try {
            androidID = Settings.Secure.getString(context.getContentResolver(), TapjoyConstants.TJC_ANDROID_ID);
            appVersion = packageManager.getPackageInfo(context.getPackageName(), 0).versionName;
            deviceType = TapjoyConstants.TJC_DEVICE_PLATFORM_TYPE;
            platformName = TapjoyConstants.TJC_DEVICE_PLATFORM_TYPE;
            deviceModel = Build.MODEL;
            deviceOSVersion = Build.VERSION.RELEASE;
            deviceCountryCode = Locale.getDefault().getCountry();
            deviceLanguage = Locale.getDefault().getLanguage();
            libraryVersion = TapjoyConstants.TJC_LIBRARY_VERSION_NUMBER;
            SharedPreferences sharedPreferences = context.getSharedPreferences(TapjoyConstants.TJC_PREFERENCE, 0);
            try {
                TelephonyManager telephonyManager = (TelephonyManager) context.getSystemService("phone");
                if (telephonyManager != null) {
                    deviceID = telephonyManager.getDeviceId();
                    carrierName = telephonyManager.getNetworkOperatorName();
                    carrierCountryCode = telephonyManager.getNetworkCountryIso();
                    mobileCountryCode = telephonyManager.getNetworkOperator();
                }
                TapjoyLog.i("TapjoyConnect", "deviceID: " + deviceID);
                if (deviceID == null) {
                    TapjoyLog.e("TapjoyConnect", "Device id is null.");
                    z = true;
                } else if (deviceID.length() == 0 || deviceID.equals("000000000000000") || deviceID.equals("0")) {
                    TapjoyLog.e("TapjoyConnect", "Device id is empty or an emulator.");
                    z = true;
                } else {
                    deviceID = deviceID.toLowerCase();
                    z = false;
                }
                TapjoyLog.i("TapjoyConnect", "ANDROID SDK VERSION: " + Build.VERSION.SDK);
                if (z && Integer.parseInt(Build.VERSION.SDK) >= 9) {
                    TapjoyLog.i("TapjoyConnect", "TRYING TO GET SERIAL OF 2.3+ DEVICE...");
                    new TapjoyHardwareUtil();
                    deviceID = Build.SERIAL;
                    TapjoyLog.i("TapjoyConnect", "====================");
                    TapjoyLog.i("TapjoyConnect", "SERIAL: deviceID: [" + deviceID + "]");
                    TapjoyLog.i("TapjoyConnect", "====================");
                    if (deviceID == null) {
                        TapjoyLog.e("TapjoyConnect", "SERIAL: Device id is null.");
                        z = true;
                    } else if (deviceID.length() == 0 || deviceID.equals("000000000000000") || deviceID.equals("0") || deviceID.equals("unknown")) {
                        TapjoyLog.e("TapjoyConnect", "SERIAL: Device id is empty or an emulator.");
                        z = true;
                    } else {
                        deviceID = deviceID.toLowerCase();
                        z = false;
                    }
                }
                if (z) {
                    StringBuffer stringBuffer = new StringBuffer();
                    stringBuffer.append("EMULATOR");
                    String string = sharedPreferences.getString(TapjoyConstants.PREF_EMULATOR_DEVICE_ID, null);
                    if (string == null || string.equals("")) {
                        for (int i = 0; i < 32; i++) {
                            stringBuffer.append("1234567890abcdefghijklmnopqrstuvw".charAt(((int) (Math.random() * 100.0d)) % 30));
                        }
                        deviceID = stringBuffer.toString().toLowerCase();
                        SharedPreferences.Editor editorEdit = sharedPreferences.edit();
                        editorEdit.putString(TapjoyConstants.PREF_EMULATOR_DEVICE_ID, deviceID);
                        editorEdit.commit();
                    } else {
                        deviceID = string;
                    }
                }
            } catch (Exception e) {
                TapjoyLog.e("TapjoyConnect", "Error getting deviceID. e: " + e.toString());
                deviceID = null;
            }
            if (userID.length() == 0) {
                userID = deviceID;
            }
            try {
                if (Integer.parseInt(Build.VERSION.SDK) > 3) {
                    TapjoyDisplayMetricsUtil tapjoyDisplayMetricsUtil = new TapjoyDisplayMetricsUtil(context);
                    deviceScreenDensity = "" + tapjoyDisplayMetricsUtil.getScreenDensity();
                    deviceScreenLayoutSize = "" + tapjoyDisplayMetricsUtil.getScreenLayoutSize();
                }
            } catch (Exception e2) {
                TapjoyLog.e("TapjoyConnect", "Error getting screen density/dimensions/layout: " + e2.toString());
            }
            String string2 = sharedPreferences.getString(TapjoyConstants.PREF_REFERRAL_URL, null);
            if (string2 != null && !string2.equals("")) {
                referralURL = string2;
            }
            clientPackage = context.getPackageName();
            TapjoyLog.i("TapjoyConnect", "Metadata successfully loaded");
            TapjoyLog.i("TapjoyConnect", "APP_ID = [" + appID + "]");
            TapjoyLog.i("TapjoyConnect", "ANDROID_ID: [" + androidID + "]");
            TapjoyLog.i("TapjoyConnect", "CLIENT_PACKAGE = [" + clientPackage + "]");
            TapjoyLog.i("TapjoyConnect", "deviceID: [" + deviceID + "]");
            TapjoyLog.i("TapjoyConnect", "deviceName: [" + deviceModel + "]");
            TapjoyLog.i("TapjoyConnect", "deviceType: [" + deviceType + "]");
            TapjoyLog.i("TapjoyConnect", "libraryVersion: [" + libraryVersion + "]");
            TapjoyLog.i("TapjoyConnect", "deviceOSVersion: [" + deviceOSVersion + "]");
            TapjoyLog.i("TapjoyConnect", "COUNTRY_CODE: [" + deviceCountryCode + "]");
            TapjoyLog.i("TapjoyConnect", "LANGUAGE_CODE: [" + deviceLanguage + "]");
            TapjoyLog.i("TapjoyConnect", "density: [" + deviceScreenDensity + "]");
            TapjoyLog.i("TapjoyConnect", "screen_layout: [" + deviceScreenLayoutSize + "]");
            TapjoyLog.i("TapjoyConnect", "carrier_name: [" + carrierName + "]");
            TapjoyLog.i("TapjoyConnect", "carrier_country_code: [" + carrierCountryCode + "]");
            TapjoyLog.i("TapjoyConnect", "mobile_country_code: [" + mobileCountryCode + "]");
            TapjoyLog.i("TapjoyConnect", "referralURL: [" + referralURL + "]");
        } catch (Exception e3) {
            TapjoyLog.e("TapjoyConnect", "Error initializing Tapjoy parameters.");
        }
    }

    public static void requestTapjoyConnect(Context context2, String str, String str2) {
        appID = str;
        secretKey = str2;
        tapjoyConnectCore = new TapjoyConnectCore(context2);
    }

    public static void saveTapPointsTotal(int i) {
        SharedPreferences.Editor editorEdit = context.getSharedPreferences(TapjoyConstants.TJC_PREFERENCE, 0).edit();
        editorEdit.putInt(TapjoyConstants.PREF_LAST_TAP_POINTS, i);
        editorEdit.commit();
    }

    public static void setDebugDeviceID(String str) {
        deviceID = str;
        SharedPreferences.Editor editorEdit = context.getSharedPreferences(TapjoyConstants.TJC_PREFERENCE, 0).edit();
        editorEdit.putString(TapjoyConstants.PREF_EMULATOR_DEVICE_ID, deviceID);
        editorEdit.commit();
    }

    public static void setUserID(String str) {
        userID = str;
        TapjoyLog.i("TapjoyConnect", "URL parameters: " + getURLParams());
        new Thread(new Runnable() { // from class: com.tapjoy.TapjoyConnectCore.2
            @Override // java.lang.Runnable
            public final void run() {
                TapjoyLog.i("TapjoyConnect", "setUserID...");
                String str2 = TapjoyConnectCore.getURLParams() + "&publisher_user_id=" + TapjoyConnectCore.getUserID();
                if (!TapjoyConnectCore.referralURL.equals("")) {
                    str2 = str2 + "&" + TapjoyConnectCore.referralURL;
                }
                String strConnectToURL = TapjoyConnectCore.tapjoyURLConnection.connectToURL("https://ws.tapjoyads.com/set_publisher_user_id?", str2);
                if (strConnectToURL != null) {
                    TapjoyConnectCore.handleConnectResponse(strConnectToURL);
                    TapjoyLog.i("TapjoyConnect", "setUserID successful...");
                }
            }
        }).start();
    }

    public static void setVideoIDs(String str) {
        videoIDs = str;
    }

    public void actionComplete(String str) {
        TapjoyLog.i("TapjoyConnect", "actionComplete: " + str);
        String str2 = (("app_id=" + str + "&") + getParamsWithoutAppID()) + "&";
        long jCurrentTimeMillis = System.currentTimeMillis() / 1000;
        String str3 = (str2 + "timestamp=" + jCurrentTimeMillis + "&") + "verifier=" + getVerifier(jCurrentTimeMillis);
        TapjoyLog.i("TapjoyConnect", "PPA URL parameters: " + str3);
        new Thread(new PPAThread(str3)).start();
    }

    public void enablePaidAppWithActionID(String str) {
        TapjoyLog.i("TapjoyConnect", "enablePaidAppWithActionID: " + str);
        paidAppActionID = str;
        this.elapsed_time = context.getSharedPreferences(TapjoyConstants.TJC_PREFERENCE, 0).getLong(TapjoyConstants.PREF_ELAPSED_TIME, 0L);
        TapjoyLog.i("TapjoyConnect", "paidApp elapsed: " + this.elapsed_time);
        if (this.elapsed_time < TapjoyConstants.PAID_APP_TIME) {
            if (this.timer == null) {
                this.timer = new Timer();
                this.timer.schedule(new PaidAppTimerTask(), 10000L, 10000L);
                return;
            }
            return;
        }
        if (paidAppActionID == null || paidAppActionID.length() <= 0) {
            return;
        }
        TapjoyLog.i("TapjoyConnect", "Calling PPA actionComplete...");
        actionComplete(paidAppActionID);
    }

    public float getCurrencyMultiplier() {
        return currencyMultiplier;
    }

    public void release() {
        tapjoyConnectCore = null;
        tapjoyURLConnection = null;
        TapjoyLog.i("TapjoyConnect", "Releasing core static instance.");
    }

    public void setCurrencyMultiplier(float f) {
        TapjoyLog.i("TapjoyConnect", "setVirtualCurrencyMultiplier: " + f);
        currencyMultiplier = f;
    }
}
