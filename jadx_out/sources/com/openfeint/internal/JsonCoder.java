package com.openfeint.internal;

import com.openfeint.internal.logcat.OFLog;
import com.openfeint.internal.vendor.org.codehaus.jackson.JsonFactory;
import com.openfeint.internal.vendor.org.codehaus.jackson.JsonGenerationException;
import com.openfeint.internal.vendor.org.codehaus.jackson.JsonGenerator;
import com.openfeint.internal.vendor.org.codehaus.jackson.JsonParseException;
import com.openfeint.internal.vendor.org.codehaus.jackson.JsonParser;
import com.openfeint.internal.vendor.org.codehaus.jackson.JsonToken;
import java.io.IOException;
import java.io.StringWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.TimeZone;

/* JADX INFO: loaded from: classes.dex */
public final class JsonCoder {
    private static void generate(Object obj, JsonGenerator jsonGenerator) throws IOException, ClassCastException {
        if (obj == null) {
            jsonGenerator.writeNull();
            return;
        }
        if (obj instanceof Date) {
            SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'");
            simpleDateFormat.setTimeZone(TimeZone.getTimeZone("Zulu"));
            jsonGenerator.writeString(simpleDateFormat.format(obj));
            return;
        }
        if (obj instanceof String) {
            jsonGenerator.writeString((String) obj);
            return;
        }
        if (obj instanceof Map) {
            jsonGenerator.writeStartObject();
            Map map = (Map) obj;
            for (String str : map.keySet()) {
                jsonGenerator.writeFieldName(str);
                generate(map.get(str), jsonGenerator);
            }
            jsonGenerator.writeEndObject();
            return;
        }
        if (obj instanceof List) {
            jsonGenerator.writeStartArray();
            Iterator it = ((List) obj).iterator();
            while (it.hasNext()) {
                generate(it.next(), jsonGenerator);
            }
            jsonGenerator.writeEndArray();
            return;
        }
        if (obj instanceof Object[]) {
            jsonGenerator.writeStartArray();
            for (Object obj2 : (Object[]) obj) {
                generate(obj2, jsonGenerator);
            }
            jsonGenerator.writeEndArray();
            return;
        }
        if (!(obj instanceof Number)) {
            if (!(obj instanceof Boolean)) {
                throw new JsonGenerationException("Can't generate JSON for object of class " + obj.getClass().getCanonicalName());
            }
            jsonGenerator.writeBoolean(((Boolean) obj).booleanValue());
            return;
        }
        Number number = (Number) obj;
        if (number instanceof Double) {
            jsonGenerator.writeNumber(number.doubleValue());
            return;
        }
        if (number instanceof Float) {
            jsonGenerator.writeNumber(number.floatValue());
            return;
        }
        if (number instanceof Integer) {
            jsonGenerator.writeNumber(number.intValue());
            return;
        }
        if (number instanceof Long) {
            jsonGenerator.writeNumber(number.longValue());
        } else if (number instanceof Byte) {
            jsonGenerator.writeNumber(number.longValue());
        } else {
            if (!(number instanceof Short)) {
                throw new JsonGenerationException("Unhandled number type " + number.getClass().getCanonicalName());
            }
            jsonGenerator.writeNumber(number.longValue());
        }
    }

    public static String generateJson(Object obj) {
        StringWriter stringWriter = new StringWriter();
        try {
            JsonGenerator jsonGeneratorCreateJsonGenerator = new JsonFactory((byte) 0).createJsonGenerator(stringWriter);
            generate(obj, jsonGeneratorCreateJsonGenerator);
            jsonGeneratorCreateJsonGenerator.close();
            return stringWriter.toString();
        } catch (Exception e) {
            OFLog.e("JsonCoder", e.getMessage());
            return null;
        }
    }

    private static Object parse(JsonParser jsonParser) throws IOException {
        JsonToken currentToken = jsonParser.getCurrentToken();
        if (JsonToken.START_ARRAY == currentToken) {
            ArrayList arrayList = new ArrayList();
            while (jsonParser.nextToken() != JsonToken.END_ARRAY) {
                arrayList.add(parse(jsonParser));
            }
            return arrayList;
        }
        if (JsonToken.START_OBJECT == currentToken) {
            HashMap map = new HashMap();
            while (jsonParser.nextToken() == JsonToken.FIELD_NAME) {
                String currentName = jsonParser.getCurrentName();
                jsonParser.nextToken();
                map.put(currentName, parse(jsonParser));
            }
            if (jsonParser.getCurrentToken() != JsonToken.END_OBJECT) {
                throw new JsonParseException("Garbage in object", jsonParser.getCurrentLocation());
            }
            return map;
        }
        if (JsonToken.VALUE_FALSE == currentToken) {
            return new Boolean(false);
        }
        if (JsonToken.VALUE_TRUE == currentToken) {
            return new Boolean(true);
        }
        if (JsonToken.VALUE_NULL == currentToken) {
            return null;
        }
        if (JsonToken.VALUE_NUMBER_FLOAT == currentToken) {
            return new Double(jsonParser.getDoubleValue());
        }
        if (JsonToken.VALUE_NUMBER_INT == currentToken) {
            return new Long(jsonParser.getLongValue());
        }
        if (JsonToken.VALUE_STRING == currentToken) {
            return jsonParser.getText();
        }
        OFLog.e("JsonCoder", " no idea dude " + jsonParser.getText());
        return null;
    }

    public static Object parse(String str) {
        try {
            JsonParser jsonParserCreateJsonParser = new JsonFactory((byte) 0).createJsonParser(str);
            jsonParserCreateJsonParser.nextToken();
            return parse(jsonParserCreateJsonParser);
        } catch (IOException e) {
            OFLog.e("JsonCoder", e.getMessage());
            return null;
        }
    }
}
