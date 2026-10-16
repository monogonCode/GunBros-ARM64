package com.google.gson.internal.bind;

import com.google.gson.JsonElement;
import com.google.gson.JsonPrimitive;
import com.google.gson.JsonSyntaxException;
import com.google.gson.internal.C$Gson$Types;
import com.google.gson.internal.ConstructorConstructor;
import com.google.gson.internal.ObjectConstructor;
import com.google.gson.internal.Streams;
import com.google.gson.reflect.TypeToken;
import com.google.gson.stream.JsonReader;
import com.google.gson.stream.JsonToken;
import com.google.gson.stream.JsonWriter;
import java.io.IOException;
import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.Map;

/* JADX INFO: loaded from: classes.dex */
public final class MapTypeAdapterFactory implements TypeAdapter.Factory {
    private final boolean complexMapKeySerialization;
    private final ConstructorConstructor constructorConstructor;

    public MapTypeAdapterFactory(ConstructorConstructor constructorConstructor, boolean complexMapKeySerialization) {
        this.constructorConstructor = constructorConstructor;
        this.complexMapKeySerialization = complexMapKeySerialization;
    }

    @Override // com.google.gson.internal.bind.TypeAdapter.Factory
    public <T> TypeAdapter<T> create(MiniGson context, TypeToken<T> typeToken) {
        Type type = typeToken.getType();
        Class<? super T> rawType = typeToken.getRawType();
        if (!Map.class.isAssignableFrom(rawType)) {
            return null;
        }
        Class<?> rawTypeOfSrc = C$Gson$Types.getRawType(type);
        Type[] keyAndValueTypes = C$Gson$Types.getMapKeyAndValueTypes(type, rawTypeOfSrc);
        TypeAdapter<?> keyAdapter = getKeyAdapter(context, keyAndValueTypes[0]);
        TypeAdapter<T> adapter = context.getAdapter(TypeToken.get(keyAndValueTypes[1]));
        ObjectConstructor<T> constructor = this.constructorConstructor.getConstructor(typeToken);
        return new Adapter(context, keyAndValueTypes[0], keyAdapter, keyAndValueTypes[1], adapter, constructor);
    }

    private TypeAdapter<?> getKeyAdapter(MiniGson context, Type keyType) {
        return (keyType == Boolean.TYPE || keyType == Boolean.class) ? TypeAdapters.BOOLEAN_AS_STRING : context.getAdapter(TypeToken.get(keyType));
    }

    private final class Adapter<K, V> extends TypeAdapter<Map<K, V>> {
        private final ObjectConstructor<? extends Map<K, V>> constructor;
        private final TypeAdapter<K> keyTypeAdapter;
        private final TypeAdapter<V> valueTypeAdapter;

        public Adapter(MiniGson context, Type keyType, TypeAdapter<K> keyTypeAdapter, Type valueType, TypeAdapter<V> valueTypeAdapter, ObjectConstructor<? extends Map<K, V>> constructor) {
            this.keyTypeAdapter = new TypeAdapterRuntimeTypeWrapper(context, keyTypeAdapter, keyType);
            this.valueTypeAdapter = new TypeAdapterRuntimeTypeWrapper(context, valueTypeAdapter, valueType);
            this.constructor = constructor;
        }

        @Override // com.google.gson.internal.bind.TypeAdapter
        public Map<K, V> read(JsonReader reader) throws IOException {
            JsonToken peek = reader.peek();
            if (peek == JsonToken.NULL) {
                reader.nextNull();
                return null;
            }
            Map<K, V> map = this.constructor.construct();
            if (peek == JsonToken.BEGIN_ARRAY) {
                reader.beginArray();
                while (reader.hasNext()) {
                    reader.beginArray();
                    K key = this.keyTypeAdapter.read(reader);
                    V value = this.valueTypeAdapter.read(reader);
                    V replaced = map.put(key, value);
                    if (replaced != null) {
                        throw new JsonSyntaxException("duplicate key: " + key);
                    }
                    reader.endArray();
                }
                reader.endArray();
                return map;
            }
            reader.beginObject();
            while (reader.hasNext()) {
                String keyString = reader.nextName();
                K key2 = this.keyTypeAdapter.fromJsonElement(new JsonPrimitive(keyString));
                V value2 = this.valueTypeAdapter.read(reader);
                V replaced2 = map.put(key2, value2);
                if (replaced2 != null) {
                    throw new JsonSyntaxException("duplicate key: " + key2);
                }
            }
            reader.endObject();
            return map;
        }

        @Override // com.google.gson.internal.bind.TypeAdapter
        public void write(JsonWriter jsonWriter, Map<K, V> map) throws IOException {
            if (map != null) {
                if (!MapTypeAdapterFactory.this.complexMapKeySerialization) {
                    jsonWriter.beginObject();
                    for (Map.Entry<K, V> entry : map.entrySet()) {
                        jsonWriter.name(String.valueOf(entry.getKey()));
                        this.valueTypeAdapter.write(jsonWriter, entry.getValue());
                    }
                    jsonWriter.endObject();
                    return;
                }
                boolean z = false;
                ArrayList arrayList = new ArrayList(map.size());
                ArrayList arrayList2 = new ArrayList(map.size());
                for (Map.Entry<K, V> entry2 : map.entrySet()) {
                    JsonElement jsonElement = this.keyTypeAdapter.toJsonElement(entry2.getKey());
                    arrayList.add(jsonElement);
                    arrayList2.add(entry2.getValue());
                    z |= jsonElement.isJsonArray() || jsonElement.isJsonObject();
                }
                if (z) {
                    jsonWriter.beginArray();
                    for (int i = 0; i < arrayList.size(); i++) {
                        jsonWriter.beginArray();
                        Streams.write((JsonElement) arrayList.get(i), jsonWriter);
                        this.valueTypeAdapter.write(jsonWriter, arrayList2.get(i));
                        jsonWriter.endArray();
                    }
                    jsonWriter.endArray();
                    return;
                }
                jsonWriter.beginObject();
                for (int i2 = 0; i2 < arrayList.size(); i2++) {
                    jsonWriter.name(keyToString((JsonElement) arrayList.get(i2)));
                    this.valueTypeAdapter.write(jsonWriter, arrayList2.get(i2));
                }
                jsonWriter.endObject();
                return;
            }
            jsonWriter.nullValue();
        }

        private String keyToString(JsonElement keyElement) {
            if (keyElement.isJsonPrimitive()) {
                JsonPrimitive primitive = keyElement.getAsJsonPrimitive();
                if (primitive.isNumber()) {
                    return String.valueOf(primitive.getAsNumber());
                }
                if (primitive.isBoolean()) {
                    return Boolean.toString(primitive.getAsBoolean());
                }
                if (primitive.isString()) {
                    return primitive.getAsString();
                }
                throw new AssertionError();
            }
            if (keyElement.isJsonNull()) {
                return "null";
            }
            throw new AssertionError();
        }
    }
}
