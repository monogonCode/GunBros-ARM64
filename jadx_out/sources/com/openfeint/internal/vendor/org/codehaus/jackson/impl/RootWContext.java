package com.openfeint.internal.vendor.org.codehaus.jackson.impl;

/* JADX INFO: loaded from: classes.dex */
final class RootWContext extends JsonWriteContext {
    public RootWContext() {
        super(0, null);
    }

    @Override // com.openfeint.internal.vendor.org.codehaus.jackson.impl.JsonWriteContext
    protected final void appendDesc(StringBuilder sb) {
        sb.append("/");
    }

    @Override // com.openfeint.internal.vendor.org.codehaus.jackson.impl.JsonWriteContext
    public final int writeFieldName(String str) {
        return 4;
    }

    @Override // com.openfeint.internal.vendor.org.codehaus.jackson.impl.JsonWriteContext
    public final int writeValue() {
        this._index++;
        return this._index == 0 ? 0 : 3;
    }
}
