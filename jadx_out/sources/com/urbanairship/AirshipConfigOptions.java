package com.urbanairship;

import android.content.Context;

/* JADX INFO: loaded from: classes.dex */
public class AirshipConfigOptions extends Options {
    public String c2dmSender;
    public String developmentAppKey;
    public String developmentAppSecret;
    public String productionAppKey;
    public String productionAppSecret;
    public String transport;
    public String hostURL = "https://go.urbanairship.com/";
    public String analyticsServer = "https://combine.urbanairship.com/";
    public boolean inProduction = false;
    public boolean pushServiceEnabled = true;
    public boolean iapEnabled = true;
    public boolean analyticsEnabled = true;

    public enum TransportType {
        HELIUM,
        C2DM,
        HYBRID
    }

    public static AirshipConfigOptions loadDefaultOptions(Context context) {
        AirshipConfigOptions airshipConfigOptions = new AirshipConfigOptions();
        airshipConfigOptions.loadFromProperties(context);
        return airshipConfigOptions;
    }

    public String getAppKey() {
        return this.inProduction ? this.productionAppKey : this.developmentAppKey;
    }

    public String getAppSecret() {
        return this.inProduction ? this.productionAppSecret : this.developmentAppSecret;
    }

    @Override // com.urbanairship.Options
    public String getDefaultPropertiesFilename() {
        return "airshipconfig.properties";
    }

    public TransportType getTransport() {
        if (TransportType.C2DM.toString().equalsIgnoreCase(this.transport)) {
            return TransportType.C2DM;
        }
        if (TransportType.HELIUM.toString().equalsIgnoreCase(this.transport)) {
            return TransportType.HELIUM;
        }
        if (TransportType.HYBRID.toString().equalsIgnoreCase(this.transport)) {
            return TransportType.HYBRID;
        }
        return (this.c2dmSender == null || this.c2dmSender.length() <= 0) ? TransportType.HELIUM : TransportType.C2DM;
    }

    @Override // com.urbanairship.Options
    public boolean isValid() {
        boolean z = true;
        String str = this.inProduction ? "production" : "development";
        if (getAppKey() == null || getAppKey().length() == 0 || getAppKey().indexOf(32) > 0) {
            Logger.error("AirshipConfigOptions does not contain a valid " + str + " app key");
            z = false;
        }
        if (getAppSecret() == null || getAppSecret().length() == 0 || getAppSecret().indexOf(32) > 0) {
            Logger.error("AirshipConfigOptions does not contain a valid " + str + " app secret");
            z = false;
        }
        if (!z) {
            try {
                if (AirshipConfigOptions.class.getField("productionAppKey") != null) {
                    Logger.verbose("Invalid config, but AirshipConfigOptions does not appear to be obfuscated.");
                }
            } catch (NoSuchFieldException e) {
                Logger.error("AirshipConfigOptions appears to be obfuscated. If using Proguard, add the following to your proguard.cfg:");
                Logger.error("\t-keepclasseswithmembernames public class * extends com.urbanairship.Options {");
                Logger.error("\t\tpublic *;");
                Logger.error("\t}");
            } catch (SecurityException e2) {
            }
        }
        return z;
    }
}
