package com.openfeint.internal.vendor.org.codehaus.jackson.impl;

import com.openfeint.internal.vendor.org.codehaus.jackson.JsonStreamContext;

/* JADX INFO: loaded from: classes.dex */
public abstract class JsonWriteContext extends JsonStreamContext {
    JsonWriteContext _childArray;
    JsonWriteContext _childObject;
    protected final JsonWriteContext _parent;

    protected JsonWriteContext(int i, JsonWriteContext jsonWriteContext) {
        super(i);
        this._childArray = null;
        this._childObject = null;
        this._parent = jsonWriteContext;
    }

    protected abstract void appendDesc(StringBuilder sb);

    public final JsonWriteContext createChildArrayContext() {
        JsonWriteContext jsonWriteContext = this._childArray;
        if (jsonWriteContext != null) {
            jsonWriteContext._index = -1;
            return jsonWriteContext;
        }
        ArrayWContext arrayWContext = new ArrayWContext(this);
        this._childArray = arrayWContext;
        return arrayWContext;
    }

    public final JsonWriteContext createChildObjectContext() {
        JsonWriteContext jsonWriteContext = this._childObject;
        if (jsonWriteContext != null) {
            jsonWriteContext._index = -1;
            return jsonWriteContext;
        }
        ObjectWContext objectWContext = new ObjectWContext(this);
        this._childObject = objectWContext;
        return objectWContext;
    }

    public final JsonWriteContext getParent() {
        return this._parent;
    }

    public final String toString() {
        StringBuilder sb = new StringBuilder(64);
        appendDesc(sb);
        return sb.toString();
    }

    public abstract int writeFieldName(String str);

    public abstract int writeValue();
}
