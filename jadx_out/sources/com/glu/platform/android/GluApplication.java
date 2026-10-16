package com.glu.platform.android;

import android.app.Application;
import com.urbanairship.AirshipConfigOptions;
import com.urbanairship.Logger;
import com.urbanairship.UAirship;
import com.urbanairship.push.PushManager;
import com.urbanairship.push.PushPreferences;

/* JADX INFO: loaded from: classes.dex */
public abstract class GluApplication extends Application {
    public static GluApplication instance = null;

    protected abstract Class getMainActivityClass();

    protected abstract String getUADevelopmentAppKey();

    protected abstract String getUADevelopmentAppSecret();

    protected abstract String getUAProductionAppKey();

    protected abstract String getUAProductionAppSecret();

    @Override // android.app.Application
    public void onCreate() {
        String str = "UrbanAirship instance: " + (UAirship.shared() != null ? "Live" : "Dead");
        if (UAirship.shared() != null) {
            String str2 = "UrbanAirship before takeoff isFlying: " + (UAirship.shared().isFlying() ? "Airbourne" : "Grounded");
        }
        AirshipConfigOptions airshipConfigOptionsLoadDefaultOptions = AirshipConfigOptions.loadDefaultOptions(this);
        airshipConfigOptionsLoadDefaultOptions.developmentAppKey = getUADevelopmentAppKey();
        airshipConfigOptionsLoadDefaultOptions.developmentAppSecret = getUADevelopmentAppSecret();
        airshipConfigOptionsLoadDefaultOptions.productionAppKey = getUAProductionAppKey();
        airshipConfigOptionsLoadDefaultOptions.productionAppSecret = getUAProductionAppSecret();
        airshipConfigOptionsLoadDefaultOptions.inProduction = true;
        airshipConfigOptionsLoadDefaultOptions.analyticsEnabled = false;
        airshipConfigOptionsLoadDefaultOptions.iapEnabled = false;
        airshipConfigOptionsLoadDefaultOptions.c2dmSender = "glunotification@gmail.com";
        airshipConfigOptionsLoadDefaultOptions.transport = "helium";
        UAirship.takeOff(this, airshipConfigOptionsLoadDefaultOptions);
        Logger.logLevel = 6;
        PushManager.shared().setIntentReceiver(GluPushHandler.class);
        if (UAirship.shared() != null) {
            String str3 = "UrbanAirship after takeoff isFlying: " + (UAirship.shared().isFlying() ? "Airbourne" : "Grounded");
        }
        PushPreferences preferences = PushManager.shared().getPreferences();
        String str4 = "App APID: " + preferences.getPushId();
        String str5 = "isPushEnabled: " + preferences.isPushEnabled();
        instance = this;
    }

    @Override // android.app.Application
    public void onTerminate() {
        UAirship.land();
    }
}
