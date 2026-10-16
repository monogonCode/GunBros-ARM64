package com.openfeint.internal.request;

import com.openfeint.internal.OpenFeintInternal;
import com.openfeint.internal.RR;
import com.openfeint.internal.resource.ServerException;
import org.apache.http.client.methods.HttpUriRequest;

/* JADX INFO: loaded from: classes.dex */
public abstract class JSONContentRequest extends BaseRequest {
    public JSONContentRequest() {
    }

    public JSONContentRequest(OrderedArgList orderedArgList) {
        super(orderedArgList);
    }

    protected static ServerException notJSONError(int i) {
        return new ServerException("ServerError", String.format(OpenFeintInternal.getRString(RR.string("of_server_error_code_format")), Integer.valueOf(i)));
    }

    @Override // com.openfeint.internal.request.BaseRequest
    protected final HttpUriRequest generateRequest() {
        HttpUriRequest httpUriRequestGenerateRequest = super.generateRequest();
        httpUriRequestGenerateRequest.addHeader("Accept", "application/json");
        return httpUriRequestGenerateRequest;
    }

    protected final boolean isResponseJSON() {
        String responseType = getResponseType();
        return responseType != null && responseType.startsWith("application/json;");
    }
}
