package com.openfeint.internal.vendor.org.codehaus.jackson.impl;

import com.openfeint.internal.vendor.org.codehaus.jackson.JsonGenerationException;
import com.openfeint.internal.vendor.org.codehaus.jackson.JsonGenerator;
import com.openfeint.internal.vendor.org.codehaus.jackson.ObjectCodec;
import com.openfeint.internal.vendor.org.codehaus.jackson.PrettyPrinter;
import java.io.IOException;

/* JADX INFO: loaded from: classes.dex */
public abstract class JsonGeneratorBase extends JsonGenerator {
    protected boolean _closed;
    protected int _features;
    protected ObjectCodec _objectCodec;
    protected JsonWriteContext _writeContext = new RootWContext();
    protected boolean _cfgNumbersAsStrings = isEnabled(JsonGenerator.Feature.WRITE_NUMBERS_AS_STRINGS);

    protected JsonGeneratorBase(int i, ObjectCodec objectCodec) {
        this._features = i;
        this._objectCodec = objectCodec;
    }

    protected static void _reportError(String str) throws JsonGenerationException {
        throw new JsonGenerationException(str);
    }

    protected abstract void _verifyValueWrite(String str) throws IOException;

    protected abstract void _writeEndArray() throws IOException;

    protected abstract void _writeEndObject() throws IOException;

    protected abstract void _writeFieldName(String str, boolean z) throws IOException;

    protected abstract void _writeStartArray() throws IOException;

    protected abstract void _writeStartObject() throws IOException;

    @Override // com.openfeint.internal.vendor.org.codehaus.jackson.JsonGenerator, java.io.Closeable, java.lang.AutoCloseable
    public void close() throws IOException {
        this._closed = true;
    }

    public final JsonWriteContext getOutputContext() {
        return this._writeContext;
    }

    public final boolean isEnabled(JsonGenerator.Feature feature) {
        return (this._features & feature.getMask()) != 0;
    }

    @Override // com.openfeint.internal.vendor.org.codehaus.jackson.JsonGenerator
    public final void writeEndArray() throws IOException {
        if (!this._writeContext.inArray()) {
            _reportError("Current context not an ARRAY but " + this._writeContext.getTypeDesc());
        }
        if (this._cfgPrettyPrinter != null) {
            PrettyPrinter prettyPrinter = this._cfgPrettyPrinter;
            this._writeContext.getEntryCount();
        } else {
            _writeEndArray();
        }
        this._writeContext = this._writeContext.getParent();
    }

    @Override // com.openfeint.internal.vendor.org.codehaus.jackson.JsonGenerator
    public final void writeEndObject() throws IOException {
        if (!this._writeContext.inObject()) {
            _reportError("Current context not an object but " + this._writeContext.getTypeDesc());
        }
        this._writeContext = this._writeContext.getParent();
        if (this._cfgPrettyPrinter == null) {
            _writeEndObject();
        } else {
            PrettyPrinter prettyPrinter = this._cfgPrettyPrinter;
            this._writeContext.getEntryCount();
        }
    }

    @Override // com.openfeint.internal.vendor.org.codehaus.jackson.JsonGenerator
    public final void writeFieldName(String str) throws IOException {
        int iWriteFieldName = this._writeContext.writeFieldName(str);
        if (iWriteFieldName == 4) {
            _reportError("Can not write a field name, expecting a value");
        }
        _writeFieldName(str, iWriteFieldName == 1);
    }

    @Override // com.openfeint.internal.vendor.org.codehaus.jackson.JsonGenerator
    public final void writeStartArray() throws IOException {
        _verifyValueWrite("start an array");
        this._writeContext = this._writeContext.createChildArrayContext();
        if (this._cfgPrettyPrinter != null) {
            PrettyPrinter prettyPrinter = this._cfgPrettyPrinter;
        } else {
            _writeStartArray();
        }
    }

    @Override // com.openfeint.internal.vendor.org.codehaus.jackson.JsonGenerator
    public final void writeStartObject() throws IOException {
        _verifyValueWrite("start an object");
        this._writeContext = this._writeContext.createChildObjectContext();
        if (this._cfgPrettyPrinter != null) {
            PrettyPrinter prettyPrinter = this._cfgPrettyPrinter;
        } else {
            _writeStartObject();
        }
    }
}
