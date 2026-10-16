package com.urbanairship.restclient;

import com.urbanairship.AirshipConfigOptions;
import com.urbanairship.UAirship;

/* JADX INFO: loaded from: classes.dex */
public class AppAuthenticatedRequest extends Request {
    public AppAuthenticatedRequest(String str, String str2) {
        super(str, str2);
        AirshipConfigOptions airshipConfigOptions = UAirship.shared().getAirshipConfigOptions();
        String appKey = airshipConfigOptions.getAppKey();
        String appSecret = airshipConfigOptions.getAppSecret();
        if (appKey != null && appSecret != null) {
            setPreemptiveAuth(appKey, appSecret);
        }
        setTimeout(60000);
    }
}
