package com.google.gson.internal.bind;

import com.google.gson.reflect.TypeToken;
import com.google.gson.stream.JsonReader;
import com.google.gson.stream.JsonWriter;
import java.io.IOException;
import java.lang.reflect.Type;

/* JADX INFO: loaded from: classes.dex */
final class TypeAdapterRuntimeTypeWrapper<T> extends TypeAdapter<T> {
    private final MiniGson context;
    private final TypeAdapter<T> delegate;
    private final Type type;

    TypeAdapterRuntimeTypeWrapper(MiniGson context, TypeAdapter<T> delegate, Type type) {
        this.context = context;
        this.delegate = delegate;
        this.type = type;
    }

    @Override // com.google.gson.internal.bind.TypeAdapter
    public T read(JsonReader reader) throws IOException {
        return this.delegate.read(reader);
    }

    @Override // com.google.gson.internal.bind.TypeAdapter
    public void write(JsonWriter writer, T value) throws IOException {
        TypeAdapter<T> typeAdapter = this.delegate;
        Type runtimeType = Reflection.getRuntimeTypeIfMoreSpecific(this.type, value);
        if (runtimeType != this.type) {
            TypeAdapter<T> adapter = this.context.getAdapter(TypeToken.get(runtimeType));
            if ((adapter instanceof ReflectiveTypeAdapterFactory.Adapter) && !(this.delegate instanceof ReflectiveTypeAdapterFactory.Adapter)) {
                typeAdapter = this.delegate;
            } else {
                typeAdapter = adapter;
            }
        }
        typeAdapter.write(writer, value);
    }
}
