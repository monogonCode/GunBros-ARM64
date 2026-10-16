package com.openfeint.internal.resource;

import com.openfeint.internal.vendor.org.codehaus.jackson.JsonGenerator;
import com.openfeint.internal.vendor.org.codehaus.jackson.JsonParser;
import java.io.IOException;

/* JADX INFO: loaded from: classes.dex */
public abstract class PrimitiveResourceProperty extends ResourceProperty {
    public abstract void copy(Resource resource, Resource resource2);

    public abstract void generate(Resource resource, JsonGenerator jsonGenerator, String str) throws IOException;

    public abstract void parse(Resource resource, JsonParser jsonParser) throws IOException;
}
