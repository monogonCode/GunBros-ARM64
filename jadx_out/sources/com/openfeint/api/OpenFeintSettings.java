package com.openfeint.api;

import com.openfeint.internal.OpenFeintInternal;
import com.openfeint.internal.RR;
import com.openfeint.internal.logcat.OFLog;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

/* JADX INFO: loaded from: classes.dex */
public final class OpenFeintSettings {
    public static String tag = "OpenFeintSettings";
    public String id;
    public String key;
    public String name;
    public String secret;
    public Map<String, Object> settings = new HashMap();

    public OpenFeintSettings(String str, String str2, String str3, String str4) {
        this.name = str;
        this.key = str2;
        this.secret = str3;
        this.id = str4;
    }

    public final void applyOverrides(Properties properties) {
        if (properties == null) {
            return;
        }
        String property = properties.getProperty("app-id");
        if (property != null) {
            this.id = property;
        }
        String property2 = properties.getProperty("game-name");
        if (property2 != null) {
            this.name = property2;
        }
        String property3 = properties.getProperty("app-key");
        if (property3 != null) {
            this.key = property3;
        }
        String property4 = properties.getProperty("app-secret");
        if (property4 != null) {
            this.secret = property4;
        }
    }

    public final void verify() {
        String rString = null;
        if (this.key == null) {
            rString = OpenFeintInternal.getRString(RR.string("of_key_cannot_be_null"));
        } else if (this.secret == null) {
            rString = OpenFeintInternal.getRString(RR.string("of_secret_cannot_be_null"));
        } else if (this.id == null) {
            rString = OpenFeintInternal.getRString(RR.string("of_id_cannot_be_null"));
        } else if (this.name == null) {
            rString = OpenFeintInternal.getRString(RR.string("of_name_cannot_be_null"));
        }
        if (rString != null) {
            OFLog.e(tag, rString);
            OpenFeintInternal.getInstance();
            OpenFeintInternal.displayErrorDialog(rString);
        }
    }
}
