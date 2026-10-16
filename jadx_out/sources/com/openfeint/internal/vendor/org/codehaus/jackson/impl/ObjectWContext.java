package com.openfeint.internal.vendor.org.codehaus.jackson.impl;

/* JADX INFO: loaded from: classes.dex */
final class ObjectWContext extends JsonWriteContext {
    protected String _currentName;
    protected boolean _expectValue;

    public ObjectWContext(JsonWriteContext jsonWriteContext) {
        super(2, jsonWriteContext);
        this._currentName = null;
        this._expectValue = false;
    }

    @Override // com.openfeint.internal.vendor.org.codehaus.jackson.impl.JsonWriteContext
    protected final void appendDesc(StringBuilder sb) {
        sb.append('{');
        if (this._currentName != null) {
            sb.append('\"');
            sb.append(this._currentName);
            sb.append('\"');
        } else {
            sb.append('?');
        }
        sb.append(']');
    }

    @Override // com.openfeint.internal.vendor.org.codehaus.jackson.impl.JsonWriteContext
    public final int writeFieldName(String str) {
        if (this._currentName != null) {
            return 4;
        }
        this._currentName = str;
        return this._index < 0 ? 0 : 1;
    }

    @Override // com.openfeint.internal.vendor.org.codehaus.jackson.impl.JsonWriteContext
    public final int writeValue() {
        if (this._currentName == null) {
            return 5;
        }
        this._currentName = null;
        this._index++;
        return 2;
    }
}
