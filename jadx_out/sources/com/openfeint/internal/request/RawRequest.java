package com.openfeint.internal.request;

/* JADX INFO: loaded from: classes.dex */
public abstract class RawRequest extends JSONRequest {
    private IRawRequestDelegate mDelegate;

    public RawRequest() {
    }

    public RawRequest(OrderedArgList orderedArgList) {
        super(orderedArgList);
    }

    @Override // com.openfeint.internal.request.JSONRequest, com.openfeint.internal.request.BaseRequest
    public final void onResponse(int i, byte[] bArr) {
        try {
            super.onResponse(i, bArr);
            if (this.mDelegate != null) {
                this.mDelegate.onResponse(i, !isResponseJSON() ? notJSONError(i).generate() : new String(bArr));
            }
        } catch (IllegalStateException e) {
            e.printStackTrace();
        }
    }

    public final void setDelegate(IRawRequestDelegate iRawRequestDelegate) {
        this.mDelegate = iRawRequestDelegate;
    }
}
