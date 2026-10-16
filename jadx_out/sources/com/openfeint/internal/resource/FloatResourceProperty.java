package com.openfeint.internal.resource;

import com.openfeint.internal.vendor.org.codehaus.jackson.JsonGenerator;
import com.openfeint.internal.vendor.org.codehaus.jackson.JsonParseException;
import com.openfeint.internal.vendor.org.codehaus.jackson.JsonParser;
import java.io.IOException;

/* JADX INFO: loaded from: classes.dex */
public abstract class FloatResourceProperty extends PrimitiveResourceProperty {
    @Override // com.openfeint.internal.resource.PrimitiveResourceProperty
    public final void copy(Resource resource, Resource resource2) {
        set(resource, get(resource2));
    }

    @Override // com.openfeint.internal.resource.PrimitiveResourceProperty
    public final void generate(Resource resource, JsonGenerator jsonGenerator, String str) throws IOException {
        jsonGenerator.writeFieldName(str);
        jsonGenerator.writeNumber(get(resource));
    }

    public abstract float get(Resource resource);

    @Override // com.openfeint.internal.resource.PrimitiveResourceProperty
    public final void parse(Resource resource, JsonParser jsonParser) throws IOException {
        try {
            set(resource, jsonParser.getFloatValue());
        } catch (JsonParseException e) {
        }
    }

    public abstract void set(Resource resource, float f);
}
