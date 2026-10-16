package com.openfeint.internal.vendor.org.codehaus.jackson.impl;

/* JADX INFO: loaded from: classes.dex */
final class ArrayWContext extends JsonWriteContext {
    public ArrayWContext(JsonWriteContext jsonWriteContext) {
        super(1, jsonWriteContext);
    }

    @Override // com.openfeint.internal.vendor.org.codehaus.jackson.impl.JsonWriteContext
    protected final void appendDesc(StringBuilder sb) {
        sb.append('[');
        sb.append(getCurrentIndex());
        sb.append(']');
    }

    @Override // com.openfeint.internal.vendor.org.codehaus.jackson.impl.JsonWriteContext
    public final int writeFieldName(String str) {
        return 4;
    }

    @Override // com.openfeint.internal.vendor.org.codehaus.jackson.impl.JsonWriteContext
    public final int writeValue() {
        int i = this._index;
        this._index++;
        return i < 0 ? 0 : 1;
    }
}
