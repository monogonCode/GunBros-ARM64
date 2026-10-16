package com.openfeint.internal.request;

import com.openfeint.internal.OpenFeintInternal;
import com.openfeint.internal.RR;
import com.openfeint.internal.Util;
import com.openfeint.internal.logcat.OFLog;
import com.openfeint.internal.resource.ServerException;

/* JADX INFO: loaded from: classes.dex */
public abstract class JSONRequest extends JSONContentRequest {
    public JSONRequest() {
    }

    public JSONRequest(OrderedArgList orderedArgList) {
        super(orderedArgList);
    }

    protected final void onFailure(Object obj) {
        String rString = OpenFeintInternal.getRString(RR.string("of_unknown_server_error"));
        if (obj != null && (obj instanceof ServerException)) {
            ServerException serverException = (ServerException) obj;
            rString = serverException.message;
            if (serverException.needsDeveloperAttention) {
                OFLog.e("ServerException", rString);
                OpenFeintInternal.getInstance();
                OpenFeintInternal.displayErrorDialog(rString);
            }
        }
        onFailure(rString);
    }

    public void onFailure(String str) {
    }

    protected void onResponse(int i, Object obj) {
        if (200 > i || i >= 300 || (obj != null && (obj instanceof ServerException))) {
            onFailure(obj);
        } else {
            onSuccess(obj);
        }
    }

    @Override // com.openfeint.internal.request.BaseRequest
    public void onResponse(int i, byte[] bArr) {
        if (bArr.length == 0 || ((bArr.length == 1 && bArr[0] == 32) || isResponseJSON())) {
            onResponse(i, Util.getObjFromJson(bArr));
        } else {
            onResponse(i, notJSONError(i));
        }
    }

    public void onSuccess(Object obj) {
    }
}
