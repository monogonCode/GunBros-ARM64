package com.google.gson.internal.bind;

import com.google.gson.internal.ConstructorConstructor;
import com.google.gson.reflect.TypeToken;
import com.google.gson.stream.JsonReader;
import com.google.gson.stream.JsonWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/* JADX INFO: loaded from: classes.dex */
public final class MiniGson {
    private final ThreadLocal<Map<TypeToken<?>, FutureTypeAdapter<?>>> calls;
    private final List<TypeAdapter.Factory> factories;

    private MiniGson(Builder builder) {
        this.calls = new ThreadLocal<Map<TypeToken<?>, FutureTypeAdapter<?>>>() { // from class: com.google.gson.internal.bind.MiniGson.1
            /* JADX INFO: Access modifiers changed from: protected */
            @Override // java.lang.ThreadLocal
            public Map<TypeToken<?>, FutureTypeAdapter<?>> initialValue() {
                return new HashMap();
            }
        };
        ConstructorConstructor constructorConstructor = new ConstructorConstructor();
        List<TypeAdapter.Factory> factories = new ArrayList<>();
        if (builder.addDefaultFactories) {
            factories.add(TypeAdapters.BOOLEAN_FACTORY);
            factories.add(TypeAdapters.INTEGER_FACTORY);
            factories.add(TypeAdapters.DOUBLE_FACTORY);
            factories.add(TypeAdapters.FLOAT_FACTORY);
            factories.add(TypeAdapters.LONG_FACTORY);
            factories.add(TypeAdapters.STRING_FACTORY);
        }
        factories.addAll(builder.factories);
        if (builder.addDefaultFactories) {
            factories.add(new CollectionTypeAdapterFactory(constructorConstructor));
            factories.add(new StringToValueMapTypeAdapterFactory(constructorConstructor));
            factories.add(ArrayTypeAdapter.FACTORY);
            factories.add(ObjectTypeAdapter.FACTORY);
            factories.add(new ReflectiveTypeAdapterFactory(constructorConstructor));
        }
        this.factories = Collections.unmodifiableList(factories);
    }

    public <T> TypeAdapter<T> getAdapter(TypeToken<T> type) {
        Map<TypeToken<?>, FutureTypeAdapter<?>> threadCalls = this.calls.get();
        FutureTypeAdapter<?> futureTypeAdapter = threadCalls.get(type);
        if (futureTypeAdapter == null) {
            FutureTypeAdapter<?> futureTypeAdapter2 = new FutureTypeAdapter<>();
            threadCalls.put(type, futureTypeAdapter2);
            try {
                for (TypeAdapter.Factory factory : this.factories) {
                    TypeAdapter<T> candidate = factory.create(this, type);
                    if (candidate != null) {
                        futureTypeAdapter2.setDelegate(candidate);
                        threadCalls.remove(type);
                        return candidate;
                    }
                }
                throw new IllegalArgumentException("This MiniGSON cannot handle " + type);
            } catch (Throwable th) {
                threadCalls.remove(type);
                throw th;
            }
        }
        return futureTypeAdapter;
    }

    public <T> TypeAdapter<T> getNextAdapter(TypeAdapter.Factory skipPast, TypeToken<T> type) {
        boolean skipPastFound = false;
        for (TypeAdapter.Factory factory : this.factories) {
            if (!skipPastFound) {
                if (factory == skipPast) {
                    skipPastFound = true;
                }
            } else {
                TypeAdapter<T> candidate = factory.create(this, type);
                if (candidate != null) {
                    return candidate;
                }
            }
        }
        throw new IllegalArgumentException("This MiniGSON cannot serialize " + type);
    }

    static class FutureTypeAdapter<T> extends TypeAdapter<T> {
        private TypeAdapter<T> delegate;

        FutureTypeAdapter() {
        }

        public void setDelegate(TypeAdapter<T> typeAdapter) {
            if (this.delegate != null) {
                throw new AssertionError();
            }
            this.delegate = typeAdapter;
        }

        @Override // com.google.gson.internal.bind.TypeAdapter
        public T read(JsonReader reader) throws IOException {
            if (this.delegate == null) {
                throw new IllegalStateException();
            }
            return this.delegate.read(reader);
        }

        @Override // com.google.gson.internal.bind.TypeAdapter
        public void write(JsonWriter writer, T value) throws IOException {
            if (this.delegate == null) {
                throw new IllegalStateException();
            }
            this.delegate.write(writer, value);
        }
    }

    public <T> TypeAdapter<T> getAdapter(Class<T> type) {
        return getAdapter(TypeToken.get((Class) type));
    }

    public List<TypeAdapter.Factory> getFactories() {
        return this.factories;
    }

    public static final class Builder {
        private final List<TypeAdapter.Factory> factories = new ArrayList();
        boolean addDefaultFactories = true;

        public Builder factory(TypeAdapter.Factory factory) {
            this.factories.add(factory);
            return this;
        }

        public Builder withoutDefaultFactories() {
            this.addDefaultFactories = false;
            return this;
        }

        public <T> Builder typeAdapter(Class<T> type, TypeAdapter<T> typeAdapter) {
            this.factories.add(TypeAdapters.newFactory(type, typeAdapter));
            return this;
        }

        public <T> Builder typeAdapter(TypeToken<T> type, TypeAdapter<T> typeAdapter) {
            this.factories.add(TypeAdapters.newFactory(type, typeAdapter));
            return this;
        }

        public <T> Builder typeHierarchyAdapter(Class<T> type, TypeAdapter<T> typeAdapter) {
            this.factories.add(TypeAdapters.newTypeHierarchyFactory(type, typeAdapter));
            return this;
        }

        public MiniGson build() {
            return new MiniGson(this);
        }
    }
}
