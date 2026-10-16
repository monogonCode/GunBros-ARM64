package com.openfeint.internal.request;

import com.openfeint.internal.vendor.com.google.api.client.escape.PercentEscaper;
import java.util.ArrayList;
import java.util.Map;
import org.apache.http.NameValuePair;
import org.apache.http.message.BasicNameValuePair;

/* JADX INFO: loaded from: classes.dex */
public final class OrderedArgList {
    ArrayList<NameValuePair> mArgs = new ArrayList<>();

    public OrderedArgList() {
    }

    public OrderedArgList(Map<String, Object> map) {
        accumulate(map, null);
    }

    private void accumulate(Map<String, Object> map, String str) {
        for (Map.Entry<String, Object> entry : map.entrySet()) {
            String key = entry.getKey();
            Object value = entry.getValue();
            if (str != null) {
                key = str + "[" + key + "]";
            }
            if (value instanceof Map) {
                accumulate((Map) value, key);
            } else {
                put(key, value.toString());
            }
        }
    }

    public final String getArgString() {
        ArrayList<NameValuePair> arrayList = this.mArgs;
        PercentEscaper percentEscaper = new PercentEscaper("-_.*");
        StringBuilder sb = null;
        for (NameValuePair nameValuePair : arrayList) {
            if (sb == null) {
                sb = new StringBuilder();
            } else {
                sb.append('&');
            }
            sb.append(percentEscaper.escape(nameValuePair.getName()));
            sb.append('=');
            if (nameValuePair.getValue() != null) {
                sb.append(percentEscaper.escape(nameValuePair.getValue()));
            }
        }
        if (sb == null) {
            return null;
        }
        return sb.toString();
    }

    public final void put(String str, String str2) {
        this.mArgs.add(new BasicNameValuePair(str, str2));
    }
}
