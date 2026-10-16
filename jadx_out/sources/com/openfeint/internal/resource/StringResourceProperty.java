package com.openfeint.internal.resource;

import com.openfeint.internal.vendor.org.codehaus.jackson.JsonGenerator;
import com.openfeint.internal.vendor.org.codehaus.jackson.JsonParser;
import com.openfeint.internal.vendor.org.codehaus.jackson.JsonToken;
import java.io.IOException;

/* JADX INFO: loaded from: classes.dex */
public abstract class StringResourceProperty extends PrimitiveResourceProperty {
    @Override // com.openfeint.internal.resource.PrimitiveResourceProperty
    public final void copy(Resource resource, Resource resource2) {
        set(resource, get(resource2));
    }

    @Override // com.openfeint.internal.resource.PrimitiveResourceProperty
    public final void generate(Resource resource, JsonGenerator jsonGenerator, String str) throws IOException {
        String str2 = get(resource);
        if (str2 != null) {
            jsonGenerator.writeFieldName(str);
            jsonGenerator.writeString(str2);
        }
    }

    public abstract String get(Resource resource);

    @Override // com.openfeint.internal.resource.PrimitiveResourceProperty
    public final void parse(Resource resource, JsonParser jsonParser) throws IOException {
        if (jsonParser.getCurrentToken() == JsonToken.VALUE_NULL) {
            set(resource, null);
        } else {
            set(resource, jsonParser.getText());
        }
    }

    public abstract void set(Resource resource, String str);
}
