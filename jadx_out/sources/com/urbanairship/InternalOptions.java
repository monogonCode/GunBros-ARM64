package com.urbanairship;

import android.content.Context;
import com.urbanairship.push.embedded.Config;
import com.urbanairship.restclient.Request;

/* JADX INFO: loaded from: classes.dex */
public class InternalOptions extends Options {
    public boolean ignoreSSLHostnames = false;
    public boolean useTestCluster = false;

    public static InternalOptions loadDefaultOptions(Context context) {
        InternalOptions internalOptions = new InternalOptions();
        internalOptions.loadFromProperties(context);
        return internalOptions;
    }

    @Override // com.urbanairship.Options
    public String getDefaultPropertiesFilename() {
        return "internal.properties";
    }

    @Override // com.urbanairship.Options
    public boolean isValid() {
        return true;
    }

    @Override // com.urbanairship.Options
    public void loadFromProperties(Context context) {
        super.loadFromProperties(context);
        if (this.ignoreSSLHostnames) {
            Logger.info("InternalOptions - ignoring SSL Hostnames");
            Request.verifySSLHostnames = false;
        }
        if (this.useTestCluster) {
            Logger.info("InternalOptions - using test cluster");
            UAirship.shared().getAirshipConfigOptions().hostURL = "http://test.urbanairship.com";
            Config.BoxOffice.url = "http://75.101.249.15:8090";
        }
    }
}
