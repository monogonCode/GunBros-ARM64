package com.openfeint.internal.resource;

import com.openfeint.internal.vendor.org.codehaus.jackson.JsonGenerator;
import com.openfeint.internal.vendor.org.codehaus.jackson.JsonParser;
import java.io.IOException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.TimeZone;

/* JADX INFO: loaded from: classes.dex */
public abstract class DateResourceProperty extends PrimitiveResourceProperty {
    public static DateFormat sDateParser;

    static {
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        simpleDateFormat.setTimeZone(TimeZone.getTimeZone("UTC"));
        sDateParser = simpleDateFormat;
    }

    @Override // com.openfeint.internal.resource.PrimitiveResourceProperty
    public final void copy(Resource resource, Resource resource2) {
        set(resource, get(resource2));
    }

    @Override // com.openfeint.internal.resource.PrimitiveResourceProperty
    public final void generate(Resource resource, JsonGenerator jsonGenerator, String str) throws IOException {
        Date date = get(resource);
        if (date != null) {
            jsonGenerator.writeFieldName(str);
            jsonGenerator.writeString(sDateParser.format(date));
        }
    }

    public abstract Date get(Resource resource);

    @Override // com.openfeint.internal.resource.PrimitiveResourceProperty
    public final void parse(Resource resource, JsonParser jsonParser) throws IOException {
        String text = jsonParser.getText();
        if (text.equals("null")) {
            set(resource, null);
            return;
        }
        try {
            set(resource, sDateParser.parse(text));
        } catch (ParseException e) {
            set(resource, null);
        }
    }

    public abstract void set(Resource resource, Date date);
}
