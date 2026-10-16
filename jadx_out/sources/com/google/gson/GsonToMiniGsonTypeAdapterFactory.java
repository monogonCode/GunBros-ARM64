package com.google.gson;

import com.google.gson.internal.ParameterizedTypeHandlerMap;
import com.google.gson.internal.Streams;
import com.google.gson.internal.bind.MiniGson;
import com.google.gson.internal.bind.TypeAdapter;
import com.google.gson.reflect.TypeToken;
import com.google.gson.stream.JsonReader;
import com.google.gson.stream.JsonWriter;
import java.io.IOException;
import java.lang.reflect.Type;

/* JADX INFO: loaded from: classes.dex */
final class GsonToMiniGsonTypeAdapterFactory implements TypeAdapter.Factory {
    private final JsonDeserializationContext deserializationContext;
    private final ParameterizedTypeHandlerMap<JsonDeserializer<?>> deserializers;
    private final JsonSerializationContext serializationContext;
    private final ParameterizedTypeHandlerMap<JsonSerializer<?>> serializers;

    public GsonToMiniGsonTypeAdapterFactory(final Gson gson, ParameterizedTypeHandlerMap<JsonSerializer<?>> serializers, ParameterizedTypeHandlerMap<JsonDeserializer<?>> deserializers) {
        this.serializers = serializers;
        this.deserializers = deserializers;
        this.deserializationContext = new JsonDeserializationContext() { // from class: com.google.gson.GsonToMiniGsonTypeAdapterFactory.1
            @Override // com.google.gson.JsonDeserializationContext
            public <T> T deserialize(JsonElement jsonElement, Type type) throws JsonParseException {
                return (T) gson.fromJson(jsonElement, type);
            }
        };
        this.serializationContext = new JsonSerializationContext() { // from class: com.google.gson.GsonToMiniGsonTypeAdapterFactory.2
            @Override // com.google.gson.JsonSerializationContext
            public JsonElement serialize(Object src) {
                return gson.toJsonTree(src);
            }

            @Override // com.google.gson.JsonSerializationContext
            public JsonElement serialize(Object src, Type typeOfSrc) {
                return gson.toJsonTree(src, typeOfSrc);
            }
        };
    }

    @Override // com.google.gson.internal.bind.TypeAdapter.Factory
    public <T> TypeAdapter<T> create(final MiniGson context, final TypeToken<T> typeToken) {
        final Type type = typeToken.getType();
        final JsonSerializer<?> handlerFor = this.serializers.getHandlerFor(type, false);
        final JsonDeserializer<?> handlerFor2 = this.deserializers.getHandlerFor(type, false);
        if (handlerFor == null && handlerFor2 == null) {
            return null;
        }
        return new TypeAdapter<T>() { // from class: com.google.gson.GsonToMiniGsonTypeAdapterFactory.3
            private TypeAdapter<T> delegate;

            @Override // com.google.gson.internal.bind.TypeAdapter
            public T read(JsonReader jsonReader) throws IOException {
                if (handlerFor2 == null) {
                    return delegate().read(jsonReader);
                }
                JsonElement jsonElement = Streams.parse(jsonReader);
                if (!jsonElement.isJsonNull()) {
                    return (T) handlerFor2.deserialize(jsonElement, type, GsonToMiniGsonTypeAdapterFactory.this.deserializationContext);
                }
                return null;
            }

            @Override // com.google.gson.internal.bind.TypeAdapter
            public void write(JsonWriter writer, T value) throws IOException {
                if (handlerFor == null) {
                    delegate().write(writer, value);
                } else if (value != null) {
                    JsonElement element = handlerFor.serialize(value, type, GsonToMiniGsonTypeAdapterFactory.this.serializationContext);
                    Streams.write(element, writer);
                } else {
                    writer.nullValue();
                }
            }

            private TypeAdapter<T> delegate() {
                TypeAdapter<T> d = this.delegate;
                if (d != null) {
                    return d;
                }
                TypeAdapter<T> d2 = context.getNextAdapter(GsonToMiniGsonTypeAdapterFactory.this, typeToken);
                this.delegate = d2;
                return d2;
            }
        };
    }
}
