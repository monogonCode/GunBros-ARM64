package com.openfeint.internal.resource;

import com.openfeint.internal.vendor.org.codehaus.jackson.JsonGenerator;
import com.openfeint.internal.vendor.org.codehaus.jackson.JsonParser;
import com.openfeint.internal.vendor.org.codehaus.jackson.JsonToken;
import java.io.IOException;

/* JADX INFO: loaded from: classes.dex */
public abstract class BooleanResourceProperty extends PrimitiveResourceProperty {
    @Override // com.openfeint.internal.resource.PrimitiveResourceProperty
    public final void copy(Resource resource, Resource resource2) {
        set(resource, get(resource2));
    }

    @Override // com.openfeint.internal.resource.PrimitiveResourceProperty
    public final void generate(Resource resource, JsonGenerator jsonGenerator, String str) throws IOException {
        jsonGenerator.writeFieldName(str);
        jsonGenerator.writeBoolean(get(resource));
    }

    public abstract boolean get(Resource resource);

    @Override // com.openfeint.internal.resource.PrimitiveResourceProperty
    public final void parse(Resource resource, JsonParser jsonParser) throws IOException {
        if (jsonParser.getCurrentToken() == JsonToken.VALUE_TRUE || jsonParser.getText().equalsIgnoreCase("true") || jsonParser.getText().equalsIgnoreCase("1") || jsonParser.getText().equalsIgnoreCase("YES")) {
            set(resource, true);
        } else {
            set(resource, false);
        }
    }

    public abstract void set(Resource resource, boolean z);
}
