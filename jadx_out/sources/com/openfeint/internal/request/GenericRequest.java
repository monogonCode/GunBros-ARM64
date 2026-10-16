package com.openfeint.internal.request;

import java.util.Map;
import org.apache.http.params.HttpConnectionParams;

/* JADX INFO: loaded from: classes.dex */
public final class GenericRequest extends JSONContentRequest {
    private IRawRequestDelegate mDelegate;
    final String mMethod;
    final String mPath;
    private int mRetries;
    private long mTimeout;

    public GenericRequest(String str, String str2, Map<String, Object> map, Map<String, Object> map2, IRawRequestDelegate iRawRequestDelegate) {
        this.mTimeout = super.timeout();
        this.mRetries = super.numRetries();
        if (map2 != null) {
            for (Map.Entry<String, Object> entry : map2.entrySet()) {
                String key = entry.getKey();
                int i = Integer.parseInt(entry.getValue().toString());
                if (key.equals("connectionTimeout")) {
                    HttpConnectionParams.setConnectionTimeout(getHttpParams(), i);
                } else if (key.equals("socketTimeout")) {
                    HttpConnectionParams.setSoTimeout(getHttpParams(), i);
                } else if (key.equals("lingerTimeout")) {
                    HttpConnectionParams.setLinger(getHttpParams(), i);
                } else if (key.equals("timeout")) {
                    this.mTimeout = i;
                } else if (key.equals("retries")) {
                    this.mRetries = i;
                }
            }
        }
        OrderedArgList orderedArgList = new OrderedArgList(map);
        orderedArgList.put("format", "json");
        setArgs(orderedArgList);
        this.mMethod = str2;
        this.mPath = str;
        this.mDelegate = iRawRequestDelegate;
    }

    @Override // com.openfeint.internal.request.BaseRequest
    public final String method() {
        return this.mMethod;
    }

    @Override // com.openfeint.internal.request.BaseRequest
    public final int numRetries() {
        return this.mRetries;
    }

    @Override // com.openfeint.internal.request.BaseRequest
    public final void onResponse(int i, byte[] bArr) {
        String str;
        try {
            if (isResponseJSON()) {
                str = bArr != null ? new String(bArr) : "";
            } else {
                str = notJSONError(i).generate();
            }
            if (this.mDelegate != null) {
                this.mDelegate.onResponse(i, str);
            }
        } catch (IllegalStateException e) {
            e.printStackTrace();
        }
    }

    @Override // com.openfeint.internal.request.BaseRequest
    public final String path() {
        return this.mPath;
    }

    @Override // com.openfeint.internal.request.BaseRequest
    public final long timeout() {
        return this.mTimeout;
    }
}
