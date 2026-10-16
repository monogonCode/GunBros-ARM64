package com.google.gson.internal.bind;

import com.google.gson.ExclusionStrategy;
import com.google.gson.reflect.TypeToken;
import com.google.gson.stream.JsonReader;
import com.google.gson.stream.JsonWriter;
import java.io.IOException;

/* JADX INFO: loaded from: classes.dex */
public final class ExcludedTypeAdapterFactory implements TypeAdapter.Factory {
    private final ExclusionStrategy deserializationExclusionStrategy;
    private final ExclusionStrategy serializationExclusionStrategy;

    public ExcludedTypeAdapterFactory(ExclusionStrategy serializationExclusionStrategy, ExclusionStrategy deserializationExclusionStrategy) {
        this.serializationExclusionStrategy = serializationExclusionStrategy;
        this.deserializationExclusionStrategy = deserializationExclusionStrategy;
    }

    @Override // com.google.gson.internal.bind.TypeAdapter.Factory
    public <T> TypeAdapter<T> create(final MiniGson context, final TypeToken<T> type) {
        Class<?> rawType = type.getRawType();
        final boolean skipSerialize = this.serializationExclusionStrategy.shouldSkipClass(rawType);
        final boolean skipDeserialize = this.deserializationExclusionStrategy.shouldSkipClass(rawType);
        if (skipSerialize || skipDeserialize) {
            return new TypeAdapter<T>() { // from class: com.google.gson.internal.bind.ExcludedTypeAdapterFactory.1
                private TypeAdapter<T> delegate;

                @Override // com.google.gson.internal.bind.TypeAdapter
                public T read(JsonReader reader) throws IOException {
                    if (!skipDeserialize) {
                        return delegate().read(reader);
                    }
                    reader.skipValue();
                    return null;
                }

                @Override // com.google.gson.internal.bind.TypeAdapter
                public void write(JsonWriter writer, T value) throws IOException {
                    if (skipSerialize) {
                        writer.nullValue();
                    } else {
                        delegate().write(writer, value);
                    }
                }

                private TypeAdapter<T> delegate() {
                    TypeAdapter<T> d = this.delegate;
                    if (d != null) {
                        return d;
                    }
                    TypeAdapter<T> d2 = context.getNextAdapter(ExcludedTypeAdapterFactory.this, type);
                    this.delegate = d2;
                    return d2;
                }
            };
        }
        return null;
    }
}
