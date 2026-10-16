package com.openfeint.internal.request;

import com.openfeint.internal.Util;

/* JADX INFO: loaded from: classes.dex */
public final class Signer {
    private String mAccessToken;
    private String mKey;
    private String mSecret;
    private String mSigningKey;

    public Signer(String str, String str2) {
        this.mKey = str;
        this.mSecret = str2;
        this.mSigningKey = this.mSecret + "&";
    }

    public final String getKey() {
        return this.mKey;
    }

    public final String sign$32bca35c(String str, String str2, OrderedArgList orderedArgList) {
        if (this.mAccessToken != null) {
            orderedArgList.put("token", this.mAccessToken);
        }
        StringBuilder sb = new StringBuilder();
        sb.append(str);
        sb.append('+');
        sb.append(this.mSecret);
        sb.append('+');
        sb.append(str2);
        sb.append('+');
        String argString = orderedArgList.getArgString();
        if (argString == null) {
            argString = "";
        }
        sb.append(argString);
        return Util.base64HMACSHA1(this.mSigningKey, sb.toString());
    }
}
