package com.google.gson.internal.bind;

import com.google.gson.internal.C$Gson$Types;
import com.google.gson.internal.ConstructorConstructor;
import com.google.gson.internal.ObjectConstructor;
import com.google.gson.reflect.TypeToken;
import com.google.gson.stream.JsonReader;
import com.google.gson.stream.JsonToken;
import com.google.gson.stream.JsonWriter;
import java.io.IOException;
import java.lang.reflect.Type;
import java.util.Collection;

/* JADX INFO: loaded from: classes.dex */
public final class CollectionTypeAdapterFactory implements TypeAdapter.Factory {
    private final ConstructorConstructor constructorConstructor;

    public CollectionTypeAdapterFactory(ConstructorConstructor constructorConstructor) {
        this.constructorConstructor = constructorConstructor;
    }

    @Override // com.google.gson.internal.bind.TypeAdapter.Factory
    public <T> TypeAdapter<T> create(MiniGson context, TypeToken<T> typeToken) {
        Type type = typeToken.getType();
        Class<? super T> rawType = typeToken.getRawType();
        if (!Collection.class.isAssignableFrom(rawType)) {
            return null;
        }
        Type elementType = C$Gson$Types.getCollectionElementType(type, rawType);
        TypeAdapter<T> adapter = context.getAdapter(TypeToken.get(elementType));
        ObjectConstructor<T> constructor = this.constructorConstructor.getConstructor(typeToken);
        return new Adapter(context, elementType, adapter, constructor);
    }

    private final class Adapter<E> extends TypeAdapter<Collection<E>> {
        private final ObjectConstructor<? extends Collection<E>> constructor;
        private final TypeAdapter<E> elementTypeAdapter;

        public Adapter(MiniGson context, Type elementType, TypeAdapter<E> elementTypeAdapter, ObjectConstructor<? extends Collection<E>> constructor) {
            this.elementTypeAdapter = new TypeAdapterRuntimeTypeWrapper(context, elementTypeAdapter, elementType);
            this.constructor = constructor;
        }

        @Override // com.google.gson.internal.bind.TypeAdapter
        public Collection<E> read(JsonReader reader) throws IOException {
            if (reader.peek() == JsonToken.NULL) {
                reader.nextNull();
                return null;
            }
            Collection<E> collection = this.constructor.construct();
            reader.beginArray();
            while (reader.hasNext()) {
                E instance = this.elementTypeAdapter.read(reader);
                collection.add(instance);
            }
            reader.endArray();
            return collection;
        }

        @Override // com.google.gson.internal.bind.TypeAdapter
        public void write(JsonWriter writer, Collection<E> collection) throws IOException {
            if (collection == null) {
                writer.nullValue();
                return;
            }
            writer.beginArray();
            for (E element : collection) {
                this.elementTypeAdapter.write(writer, element);
            }
            writer.endArray();
        }
    }
}
