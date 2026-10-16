package com.openfeint.internal.vendor.org.codehaus.jackson.impl;

import com.openfeint.internal.vendor.org.codehaus.jackson.JsonLocation;
import com.openfeint.internal.vendor.org.codehaus.jackson.JsonStreamContext;
import com.openfeint.internal.vendor.org.codehaus.jackson.util.CharTypes;

/* JADX INFO: loaded from: classes.dex */
public final class JsonReadContext extends JsonStreamContext {
    JsonReadContext _child;
    protected int _columnNr;
    protected String _currentName;
    protected int _lineNr;
    protected final JsonReadContext _parent;

    public JsonReadContext(JsonReadContext jsonReadContext, int i, int i2, int i3) {
        super(i);
        this._child = null;
        this._parent = jsonReadContext;
        this._lineNr = i2;
        this._columnNr = i3;
    }

    private void reset(int i, int i2, int i3) {
        this._type = i;
        this._index = -1;
        this._lineNr = i2;
        this._columnNr = i3;
        this._currentName = null;
    }

    public final JsonReadContext createChildArrayContext(int i, int i2) {
        JsonReadContext jsonReadContext = this._child;
        if (jsonReadContext != null) {
            jsonReadContext.reset(1, i, i2);
            return jsonReadContext;
        }
        JsonReadContext jsonReadContext2 = new JsonReadContext(this, 1, i, i2);
        this._child = jsonReadContext2;
        return jsonReadContext2;
    }

    public final JsonReadContext createChildObjectContext(int i, int i2) {
        JsonReadContext jsonReadContext = this._child;
        if (jsonReadContext != null) {
            jsonReadContext.reset(2, i, i2);
            return jsonReadContext;
        }
        JsonReadContext jsonReadContext2 = new JsonReadContext(this, 2, i, i2);
        this._child = jsonReadContext2;
        return jsonReadContext2;
    }

    public final boolean expectComma() {
        int i = this._index + 1;
        this._index = i;
        return this._type != 0 && i > 0;
    }

    public final String getCurrentName() {
        return this._currentName;
    }

    public final JsonReadContext getParent() {
        return this._parent;
    }

    public final JsonLocation getStartLocation(Object obj) {
        return new JsonLocation(obj, -1L, this._lineNr, this._columnNr, (byte) 0);
    }

    public final void setCurrentName(String str) {
        this._currentName = str;
    }

    public final String toString() {
        StringBuilder sb = new StringBuilder(64);
        switch (this._type) {
            case 0:
                sb.append("/");
                break;
            case 1:
                sb.append('[');
                sb.append(getCurrentIndex());
                sb.append(']');
                break;
            case 2:
                sb.append('{');
                if (this._currentName != null) {
                    sb.append('\"');
                    CharTypes.appendQuoted(sb, this._currentName);
                    sb.append('\"');
                } else {
                    sb.append('?');
                }
                sb.append(']');
                break;
        }
        return sb.toString();
    }
}
