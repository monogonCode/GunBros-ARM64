package com.openfeint.internal.request;

import com.openfeint.internal.JsonResourceParser;
import com.openfeint.internal.OpenFeintInternal;
import com.openfeint.internal.RR;
import com.openfeint.internal.logcat.OFLog;
import com.openfeint.internal.resource.ServerException;
import com.openfeint.internal.vendor.org.codehaus.jackson.JsonFactory;
import java.io.IOException;

/* JADX INFO: loaded from: classes.dex */
public abstract class DownloadRequest extends BaseRequest {
    @Override // com.openfeint.internal.request.BaseRequest
    public final String method() {
        return "GET";
    }

    public void onFailure(String str) {
        OFLog.e("ServerException", str);
    }

    @Override // com.openfeint.internal.request.BaseRequest
    public final void onResponse(int i, byte[] bArr) {
        String rString;
        String rString2 = OpenFeintInternal.getRString(RR.string("of_unknown_server_error"));
        if (200 <= i && i < 300 && bArr != null) {
            onSuccess(bArr);
            return;
        }
        if (404 == i) {
            rString = OpenFeintInternal.getRString(RR.string("of_file_not_found"));
        } else {
            try {
                Object obj = new JsonResourceParser(new JsonFactory((byte) 0).createJsonParser(bArr)).parse();
                if (obj == null || !(obj instanceof ServerException)) {
                    rString = rString2;
                } else {
                    ServerException serverException = (ServerException) obj;
                    rString = serverException.exceptionClass + ": " + serverException.message;
                }
            } catch (IOException e) {
                rString = OpenFeintInternal.getRString(RR.string("of_error_parsing_error_message"));
            }
        }
        onFailure(rString);
    }

    protected abstract void onSuccess(byte[] bArr);
}
