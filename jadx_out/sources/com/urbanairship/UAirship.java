package com.urbanairship;

import android.app.Application;
import android.content.ComponentName;
import android.content.Context;
import android.content.pm.ApplicationInfo;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import com.urbanairship.analytics.Analytics;
import com.urbanairship.iap.IAPManager;
import com.urbanairship.push.PushManager;

/* JADX INFO: loaded from: classes.dex */
public class UAirship {
    private static final UAirship sharedAirship = new UAirship();
    private static final String version = "1.0.7";
    private AirshipConfigOptions airshipConfigOptions;
    private Analytics analytics;
    private Context applicationContext;
    private boolean flying = false;

    private UAirship() {
    }

    private void checkManifest() {
        PackageManager packageManager = this.applicationContext.getPackageManager();
        checkRequiredPermission("android.permission.INTERNET");
        checkRequiredPermission("android.permission.ACCESS_NETWORK_STATE");
        try {
            packageManager.getReceiverInfo(new ComponentName(getPackageName(), CoreReceiver.class.getCanonicalName()), 128);
        } catch (PackageManager.NameNotFoundException e) {
            Logger.error("AndroidManifest.xml missing required receiver: " + CoreReceiver.class.getCanonicalName());
        }
        if (this.airshipConfigOptions.pushServiceEnabled) {
            PushManager.validateManifest();
        }
        if (this.airshipConfigOptions.iapEnabled) {
            if (hasIAPClasses()) {
                Logger.verbose("Found com.android.vending.billing.IMarketBillingService. IAP enabled.");
                IAPManager.validateManifest();
            } else {
                Logger.error("In-App Purchase is enabled, but missing com.android.vending.billing.IMarketBillingService. Disabling...");
                Logger.error("If using Proguard, add the following lines to your proguard.cfg:");
                Logger.error("\t-keep class com.android.vending.billing.**");
            }
        }
    }

    private static void checkRequiredPermission(String str) {
        if (-1 == getPackageManager().checkPermission(str, getPackageName())) {
            Logger.error("AndroidManifest.xml missing required permission: " + str);
        }
    }

    public static int getAppIcon() {
        return getAppInfo().icon;
    }

    public static ApplicationInfo getAppInfo() {
        try {
            return getPackageManager().getApplicationInfo(getPackageName(), 0);
        } catch (PackageManager.NameNotFoundException e) {
            Logger.info("NameNotFound for: " + getPackageName() + ". Disabling.");
            return null;
        }
    }

    public static String getAppName() {
        if (getAppInfo() != null) {
            return getPackageManager().getApplicationLabel(getAppInfo()).toString();
        }
        return null;
    }

    public static PackageInfo getPackageInfo() {
        try {
            return getPackageManager().getPackageInfo(getPackageName(), 0);
        } catch (PackageManager.NameNotFoundException e) {
            Logger.info("NameNotFound for: " + getPackageName() + ". Disabling.");
            return null;
        }
    }

    public static PackageManager getPackageManager() {
        return sharedAirship.applicationContext.getPackageManager();
    }

    public static String getPackageName() {
        return sharedAirship.applicationContext.getPackageName();
    }

    public static String getVersion() {
        return version;
    }

    private static boolean hasIAPClasses() {
        try {
            Class.forName("com.android.vending.billing.IMarketBillingService");
            return true;
        } catch (ClassNotFoundException e) {
            return false;
        }
    }

    public static void land() {
        sharedAirship.flying = false;
        if (sharedAirship.airshipConfigOptions.iapEnabled) {
            IAPManager.tearDown();
        }
    }

    public static UAirship shared() {
        return sharedAirship;
    }

    public static void takeOff(Application application) {
        takeOff(application, null);
    }

    public static void takeOff(Application application, AirshipConfigOptions airshipConfigOptions) {
        if (application == null) {
            throw new IllegalArgumentException("Application argument must not be null");
        }
        if (sharedAirship.flying) {
            Logger.error("You can only call UAirship.takeOff once.");
            return;
        }
        UAirship uAirship = sharedAirship;
        Context applicationContext = application.getApplicationContext();
        uAirship.applicationContext = applicationContext;
        if (airshipConfigOptions == null) {
            airshipConfigOptions = AirshipConfigOptions.loadDefaultOptions(applicationContext);
        }
        sharedAirship.airshipConfigOptions = airshipConfigOptions;
        if (airshipConfigOptions.inProduction) {
            Logger.logLevel = 6;
        } else {
            Logger.logLevel = 3;
        }
        Logger.TAG = getAppName() + " - UALib";
        Logger.debug("Airship Take Off! Lib Version: 1.0.7 / App key = " + airshipConfigOptions.getAppKey() + " / secret = " + airshipConfigOptions.getAppSecret());
        Logger.debug("In Production? " + airshipConfigOptions.inProduction);
        if (!airshipConfigOptions.isValid()) {
            Logger.error("AirshipConfigOptions are not valid. Unable to take off! Check your airshipconfig.properties file for the errors listed above.");
            throw new IllegalArgumentException("Application configuration is invalid.");
        }
        sharedAirship.checkManifest();
        InternalOptions.loadDefaultOptions(applicationContext);
        sharedAirship.flying = true;
        if (airshipConfigOptions.pushServiceEnabled) {
            Logger.debug("Initializing Push.");
            PushManager.init();
        }
        if (airshipConfigOptions.iapEnabled && hasIAPClasses()) {
            Logger.debug("Initializing IAP.");
            IAPManager.init();
        }
        Logger.debug("Initializing Analytics.");
        sharedAirship.analytics = new Analytics();
    }

    public AirshipConfigOptions getAirshipConfigOptions() {
        return this.airshipConfigOptions;
    }

    public Analytics getAnalytics() {
        return this.analytics;
    }

    public Context getApplicationContext() {
        return this.applicationContext;
    }

    public boolean isFlying() {
        return this.flying;
    }
}
