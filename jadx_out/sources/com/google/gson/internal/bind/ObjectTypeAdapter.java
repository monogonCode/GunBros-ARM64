package com.google.gson.internal.bind;

import com.google.gson.reflect.TypeToken;
import com.google.gson.stream.JsonReader;
import com.google.gson.stream.JsonToken;
import com.google.gson.stream.JsonWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/* JADX INFO: loaded from: classes.dex */
public final class ObjectTypeAdapter extends TypeAdapter<Object> {
    public static final TypeAdapter.Factory FACTORY = new TypeAdapter.Factory() { // from class: com.google.gson.internal.bind.ObjectTypeAdapter.1
        @Override // com.google.gson.internal.bind.TypeAdapter.Factory
        public <T> TypeAdapter<T> create(MiniGson context, TypeToken<T> type) {
            if (type.getRawType() == Object.class) {
                return new ObjectTypeAdapter(context);
            }
            return null;
        }
    };
    private final MiniGson miniGson;

    private ObjectTypeAdapter(MiniGson miniGson) {
        this.miniGson = miniGson;
    }

    @Override // com.google.gson.internal.bind.TypeAdapter
    public Object read(JsonReader reader) throws IOException {
        JsonToken token = reader.peek();
        switch (token) {
            case BEGIN_ARRAY:
                List<Object> list = new ArrayList<>();
                reader.beginArray();
                while (reader.hasNext()) {
                    list.add(read(reader));
                }
                reader.endArray();
                return list;
            case BEGIN_OBJECT:
                Map<String, Object> map = new LinkedHashMap<>();
                reader.beginObject();
                while (reader.hasNext()) {
                    map.put(reader.nextName(), read(reader));
                }
                reader.endObject();
                return map;
            case STRING:
                return reader.nextString();
            case NUMBER:
                return Double.valueOf(reader.nextDouble());
            case BOOLEAN:
                return Boolean.valueOf(reader.nextBoolean());
            case NULL:
                reader.nextNull();
                return null;
            default:
                throw new IllegalStateException();
        }
    }

    @Override // com.google.gson.internal.bind.TypeAdapter
    public void write(JsonWriter writer, Object value) throws IOException {
        if (value == null) {
            writer.nullValue();
            return;
        }
        TypeAdapter<Object> typeAdapter = this.miniGson.getAdapter(value.getClass());
        if (typeAdapter instanceof ObjectTypeAdapter) {
            writer.beginObject();
            writer.endObject();
        } else {
            typeAdapter.write(writer, value);
        }
    }
}
