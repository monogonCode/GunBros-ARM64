package com.openfeint.internal.analytics;

import android.content.Context;
import com.openfeint.internal.JsonCoder;
import com.openfeint.internal.OpenFeintInternal;
import com.openfeint.internal.analytics.db.AnalyticsDBManager;
import com.openfeint.internal.analytics.internal.AnalyticsRequest;
import com.openfeint.internal.logcat.OFLog;
import com.openfeint.internal.request.OrderedArgList;
import com.tapjoy.TapjoyConstants;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

/* JADX INFO: loaded from: classes.dex */
public final class AnalyticsManager {
    private static int batch_num_trigger;
    private static AnalyticsManager instance;
    private String client_application_id;
    private String country;
    private String hardware;
    private Map<String, Object> info;
    private String locale;
    private Context mContext;
    private String of_version;
    private String os_version;
    private String platform;
    private String version;
    private boolean waiting;
    private String tag = "AnalyticsManager";
    private int count = 0;

    private AnalyticsManager(Context context) {
        this.mContext = context;
        if (batch_num_trigger == 0) {
            batch_num_trigger = 10;
        }
        this.waiting = false;
        initInfo();
    }

    private Map<String, Object> getInfo() {
        if (this.info == null || this.info.isEmpty()) {
            initInfo();
        }
        return this.info;
    }

    private void initInfo() {
        this.info = new HashMap();
        this.hardware = OpenFeintInternal.getModelString();
        this.client_application_id = OpenFeintInternal.getInstance().getAppID();
        this.version = String.valueOf(OpenFeintInternal.getInstance().getAppVersion());
        this.of_version = OpenFeintInternal.getInstance().getOFVersion();
        this.os_version = OpenFeintInternal.getOSVersionString();
        this.platform = "Android";
        this.locale = OpenFeintInternal.getInstance().getLocaleString();
        this.country = OpenFeintInternal.getInstance().getCountryString();
        OFLog.d(this.tag, "hardware:" + this.hardware);
        OFLog.d(this.tag, "client_application_id:" + this.client_application_id);
        OFLog.d(this.tag, "version:" + this.version);
        OFLog.d(this.tag, "of_version:" + this.of_version);
        OFLog.d(this.tag, "os_version:" + this.os_version);
        OFLog.d(this.tag, "platform:" + this.platform);
        OFLog.d(this.tag, "locale:" + this.locale);
        OFLog.d(this.tag, "country:" + this.country);
        this.info.put("hardware", this.hardware);
        this.info.put("client_application_id", this.client_application_id);
        this.info.put("version", this.version);
        this.info.put("of_version", this.of_version);
        this.info.put(TapjoyConstants.TJC_DEVICE_OS_VERSION_NAME, this.os_version);
        this.info.put(TapjoyConstants.TJC_PLATFORM, this.platform);
        this.info.put("locale", this.locale);
        this.info.put("country", this.country);
    }

    public static AnalyticsManager instance() {
        return instance;
    }

    public static AnalyticsManager instance(Context context) {
        if (instance == null) {
            instance = new AnalyticsManager(context);
        }
        return instance;
    }

    private void upload() {
        ArrayList arrayList;
        int i;
        if (this.waiting) {
            OFLog.d(this.tag, "Waiting for response,skip upload this time");
            return;
        }
        this.waiting = true;
        List<Map<String, Object>> allItems = AnalyticsDBManager.instance(this.mContext).getAllItems();
        int size = allItems.size();
        ArrayList arrayList2 = new ArrayList(100);
        int i2 = 0;
        Long l = null;
        for (Map<String, Object> map : allItems) {
            String str = (String) map.get("json");
            OFLog.v(this.tag, str);
            OFLog.v(this.tag, "--------");
            double dLongValue = Long.valueOf(System.currentTimeMillis() - ((Long) map.get("log_time")).longValue()).longValue() / 1000.0f;
            Map map2 = (Map) JsonCoder.parse(str);
            Iterator it = map2.keySet().iterator();
            while (it.hasNext()) {
                Map map3 = (Map) ((Map) map2.get((String) it.next())).get("event");
                if (map3 != null) {
                    map3.put("time_delta", Double.valueOf(dLongValue));
                }
            }
            arrayList2.add(map2);
            int i3 = i2 + 1;
            Long l2 = i3 == 1 ? (Long) map.get("log_id") : l;
            if (i3 == 100) {
                Long l3 = (Long) map.get("log_id");
                OrderedArgList orderedArgList = new OrderedArgList();
                orderedArgList.put("event", JsonCoder.generateJson(arrayList2));
                orderedArgList.put("info", JsonCoder.generateJson(getInfo()));
                if (OFLog.willLog$134632()) {
                    OFLog.d(this.tag, String.format("try upload from %d to %d :", l2, l3));
                    OFLog.d(this.tag, JsonCoder.generateJson(getInfo()));
                    OFLog.d(this.tag, JsonCoder.generateJson(arrayList2));
                }
                new AnalyticsRequest(l2, l3, orderedArgList).launch();
                arrayList = new ArrayList(100);
                i = 0;
            } else {
                arrayList = arrayList2;
                i = i3;
            }
            arrayList2 = arrayList;
            l = l2;
            i2 = i;
        }
        if (size > 0) {
            Long l4 = (Long) allItems.get(size - 1).get("log_id");
            OrderedArgList orderedArgList2 = new OrderedArgList();
            orderedArgList2.put("event", JsonCoder.generateJson(arrayList2));
            orderedArgList2.put("info", JsonCoder.generateJson(getInfo()));
            OFLog.d(this.tag, String.format("try upload from %d to %d :", l, l4));
            OFLog.d(this.tag, JsonCoder.generateJson(getInfo()));
            OFLog.d(this.tag, JsonCoder.generateJson(arrayList2));
            new AnalyticsRequest(l, l4, orderedArgList2).launch();
        }
    }

    public final void deleteLog(Long l, Long l2) {
        AnalyticsDBManager.instance(this.mContext).removeLog(l.longValue(), l2.longValue());
    }

    public final void makelog(IAnalyticsLogger iAnalyticsLogger, String str) {
        try {
            StringBuilder sbAppend = new StringBuilder().append("Log:\n");
            String strGenerateJson = JsonCoder.generateJson(iAnalyticsLogger.getMap());
            if (strGenerateJson != null) {
                AnalyticsDBManager.instance(this.mContext).insertLog(strGenerateJson);
            }
            this.count++;
            if (this.count >= batch_num_trigger) {
                OFLog.d(this.tag, "log batch upload triggered");
                upload();
                this.count = 0;
            }
            OFLog.d(str, sbAppend.append(strGenerateJson).toString());
        } catch (Exception e) {
            OFLog.e(str, "log save failed" + e.getLocalizedMessage());
        }
    }

    public final void unlock() {
        this.waiting = false;
    }
}
