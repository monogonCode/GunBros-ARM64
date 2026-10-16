package com.openfeint.internal.vendor.org.codehaus.jackson;

import java.io.Closeable;
import java.io.IOException;

/* JADX INFO: loaded from: classes.dex */
public abstract class JsonParser implements Closeable {
    protected JsonToken _currToken;
    protected int _features;

    public enum Feature {
        AUTO_CLOSE_SOURCE(true),
        ALLOW_COMMENTS(false),
        ALLOW_UNQUOTED_FIELD_NAMES(false),
        ALLOW_SINGLE_QUOTES(false),
        ALLOW_UNQUOTED_CONTROL_CHARS(false),
        INTERN_FIELD_NAMES(true),
        CANONICALIZE_FIELD_NAMES(true);

        final boolean _defaultState;

        Feature(boolean z) {
            this._defaultState = z;
        }

        public static int collectDefaults() {
            int iOrdinal = 0;
            for (Feature feature : values()) {
                if (feature._defaultState) {
                    iOrdinal |= 1 << feature.ordinal();
                }
            }
            return iOrdinal;
        }

        public final boolean enabledIn(int i) {
            return ((1 << ordinal()) & i) != 0;
        }

        public final int getMask() {
            return 1 << ordinal();
        }
    }

    protected JsonParser() {
    }

    protected final JsonParseException _constructError(String str) {
        return new JsonParseException(str, getCurrentLocation());
    }

    public abstract JsonLocation getCurrentLocation();

    public abstract String getCurrentName() throws IOException;

    public final JsonToken getCurrentToken() {
        return this._currToken;
    }

    public abstract double getDoubleValue() throws IOException;

    public abstract float getFloatValue() throws IOException;

    public abstract int getIntValue() throws IOException;

    public abstract long getLongValue() throws IOException;

    public abstract String getText() throws IOException;

    public abstract JsonLocation getTokenLocation();

    public final boolean isEnabled(Feature feature) {
        return (this._features & feature.getMask()) != 0;
    }

    public abstract JsonToken nextToken() throws IOException;

    public abstract JsonParser skipChildren() throws IOException;
}
