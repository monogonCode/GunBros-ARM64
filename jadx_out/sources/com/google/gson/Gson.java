package com.google.gson;

import com.google.gson.internal.ConstructorConstructor;
import com.google.gson.internal.ParameterizedTypeHandlerMap;
import com.google.gson.internal.Primitives;
import com.google.gson.internal.Streams;
import com.google.gson.internal.bind.ArrayTypeAdapter;
import com.google.gson.internal.bind.BigDecimalTypeAdapter;
import com.google.gson.internal.bind.BigIntegerTypeAdapter;
import com.google.gson.internal.bind.CollectionTypeAdapterFactory;
import com.google.gson.internal.bind.DateTypeAdapter;
import com.google.gson.internal.bind.ExcludedTypeAdapterFactory;
import com.google.gson.internal.bind.JsonElementReader;
import com.google.gson.internal.bind.JsonElementWriter;
import com.google.gson.internal.bind.MapTypeAdapterFactory;
import com.google.gson.internal.bind.MiniGson;
import com.google.gson.internal.bind.ObjectTypeAdapter;
import com.google.gson.internal.bind.ReflectiveTypeAdapterFactory;
import com.google.gson.internal.bind.SqlDateTypeAdapter;
import com.google.gson.internal.bind.TimeTypeAdapter;
import com.google.gson.internal.bind.TypeAdapter;
import com.google.gson.internal.bind.TypeAdapters;
import com.google.gson.reflect.TypeToken;
import com.google.gson.stream.JsonReader;
import com.google.gson.stream.JsonToken;
import com.google.gson.stream.JsonWriter;
import com.google.gson.stream.MalformedJsonException;
import java.io.EOFException;
import java.io.IOException;
import java.io.Reader;
import java.io.StringReader;
import java.io.StringWriter;
import java.io.Writer;
import java.lang.reflect.Field;
import java.lang.reflect.Type;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.util.Collections;
import java.util.LinkedList;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public final class Gson {
    static final boolean DEFAULT_JSON_NON_EXECUTABLE = false;
    private static final String JSON_NON_EXECUTABLE_PREFIX = ")]}'\n";
    private final ConstructorConstructor constructorConstructor;
    private final ExclusionStrategy deserializationExclusionStrategy;
    private final ParameterizedTypeHandlerMap<JsonDeserializer<?>> deserializers;
    private final boolean generateNonExecutableJson;
    private final boolean htmlSafe;
    private final MiniGson miniGson;
    private final boolean prettyPrinting;
    private final ExclusionStrategy serializationExclusionStrategy;
    private final boolean serializeNulls;
    private final ParameterizedTypeHandlerMap<JsonSerializer<?>> serializers;
    static final ParameterizedTypeHandlerMap EMPTY_MAP = new ParameterizedTypeHandlerMap().makeUnmodifiable();
    static final AnonymousAndLocalClassExclusionStrategy DEFAULT_ANON_LOCAL_CLASS_EXCLUSION_STRATEGY = new AnonymousAndLocalClassExclusionStrategy();
    static final SyntheticFieldExclusionStrategy DEFAULT_SYNTHETIC_FIELD_EXCLUSION_STRATEGY = new SyntheticFieldExclusionStrategy(true);
    static final ModifierBasedExclusionStrategy DEFAULT_MODIFIER_BASED_EXCLUSION_STRATEGY = new ModifierBasedExclusionStrategy(128, 8);
    static final FieldNamingStrategy2 DEFAULT_NAMING_POLICY = new SerializedNameAnnotationInterceptingNamingPolicy(new JavaFieldNamingPolicy());
    private static final ExclusionStrategy DEFAULT_EXCLUSION_STRATEGY = createExclusionStrategy();

    public Gson() {
        this(DEFAULT_EXCLUSION_STRATEGY, DEFAULT_EXCLUSION_STRATEGY, DEFAULT_NAMING_POLICY, EMPTY_MAP, DEFAULT_JSON_NON_EXECUTABLE, EMPTY_MAP, EMPTY_MAP, DEFAULT_JSON_NON_EXECUTABLE, DEFAULT_JSON_NON_EXECUTABLE, true, DEFAULT_JSON_NON_EXECUTABLE, DEFAULT_JSON_NON_EXECUTABLE, LongSerializationPolicy.DEFAULT, Collections.emptyList());
    }

    Gson(ExclusionStrategy deserializationExclusionStrategy, ExclusionStrategy serializationExclusionStrategy, final FieldNamingStrategy2 fieldNamingPolicy, ParameterizedTypeHandlerMap<InstanceCreator<?>> instanceCreators, boolean serializeNulls, ParameterizedTypeHandlerMap<JsonSerializer<?>> serializers, ParameterizedTypeHandlerMap<JsonDeserializer<?>> deserializers, boolean complexMapKeySerialization, boolean generateNonExecutableGson, boolean htmlSafe, boolean prettyPrinting, boolean serializeSpecialFloatingPointValues, LongSerializationPolicy longSerializationPolicy, List<TypeAdapter.Factory> typeAdapterFactories) {
        this.deserializationExclusionStrategy = deserializationExclusionStrategy;
        this.serializationExclusionStrategy = serializationExclusionStrategy;
        this.constructorConstructor = new ConstructorConstructor(instanceCreators);
        this.serializeNulls = serializeNulls;
        this.serializers = serializers;
        this.deserializers = deserializers;
        this.generateNonExecutableJson = generateNonExecutableGson;
        this.htmlSafe = htmlSafe;
        this.prettyPrinting = prettyPrinting;
        TypeAdapter.Factory reflectiveTypeAdapterFactory = new ReflectiveTypeAdapterFactory(this.constructorConstructor) { // from class: com.google.gson.Gson.1
            @Override // com.google.gson.internal.bind.ReflectiveTypeAdapterFactory
            public String getFieldName(Class<?> declaringClazz, Field f, Type declaredType) {
                return fieldNamingPolicy.translateName(new FieldAttributes(declaringClazz, f));
            }

            @Override // com.google.gson.internal.bind.ReflectiveTypeAdapterFactory
            public boolean serializeField(Class<?> declaringClazz, Field f, Type declaredType) {
                ExclusionStrategy strategy = Gson.this.serializationExclusionStrategy;
                if (strategy.shouldSkipClass(f.getType()) || strategy.shouldSkipField(new FieldAttributes(declaringClazz, f))) {
                    return Gson.DEFAULT_JSON_NON_EXECUTABLE;
                }
                return true;
            }

            @Override // com.google.gson.internal.bind.ReflectiveTypeAdapterFactory
            public boolean deserializeField(Class<?> declaringClazz, Field f, Type declaredType) {
                ExclusionStrategy strategy = Gson.this.deserializationExclusionStrategy;
                if (strategy.shouldSkipClass(f.getType()) || strategy.shouldSkipField(new FieldAttributes(declaringClazz, f))) {
                    return Gson.DEFAULT_JSON_NON_EXECUTABLE;
                }
                return true;
            }
        };
        MiniGson.Builder builder = new MiniGson.Builder().withoutDefaultFactories().factory(TypeAdapters.STRING_FACTORY).factory(TypeAdapters.INTEGER_FACTORY).factory(TypeAdapters.BOOLEAN_FACTORY).factory(TypeAdapters.BYTE_FACTORY).factory(TypeAdapters.SHORT_FACTORY).factory(TypeAdapters.newFactory(Long.TYPE, Long.class, longAdapter(longSerializationPolicy))).factory(TypeAdapters.newFactory(Double.TYPE, Double.class, doubleAdapter(serializeSpecialFloatingPointValues))).factory(TypeAdapters.newFactory(Float.TYPE, Float.class, floatAdapter(serializeSpecialFloatingPointValues))).factory(new ExcludedTypeAdapterFactory(serializationExclusionStrategy, deserializationExclusionStrategy)).factory(TypeAdapters.NUMBER_FACTORY).factory(TypeAdapters.CHARACTER_FACTORY).factory(TypeAdapters.STRING_BUILDER_FACTORY).factory(TypeAdapters.STRING_BUFFER_FACTORY).typeAdapter(BigDecimal.class, new BigDecimalTypeAdapter()).typeAdapter(BigInteger.class, new BigIntegerTypeAdapter()).factory(TypeAdapters.JSON_ELEMENT_FACTORY).factory(ObjectTypeAdapter.FACTORY);
        for (TypeAdapter.Factory factory : typeAdapterFactories) {
            builder.factory(factory);
        }
        builder.factory(new GsonToMiniGsonTypeAdapterFactory(this, serializers, deserializers)).factory(new CollectionTypeAdapterFactory(this.constructorConstructor)).factory(TypeAdapters.URL_FACTORY).factory(TypeAdapters.URI_FACTORY).factory(TypeAdapters.UUID_FACTORY).factory(TypeAdapters.LOCALE_FACTORY).factory(TypeAdapters.INET_ADDRESS_FACTORY).factory(TypeAdapters.BIT_SET_FACTORY).factory(DateTypeAdapter.FACTORY).factory(TypeAdapters.CALENDAR_FACTORY).factory(TimeTypeAdapter.FACTORY).factory(SqlDateTypeAdapter.FACTORY).factory(TypeAdapters.TIMESTAMP_FACTORY).factory(new MapTypeAdapterFactory(this.constructorConstructor, complexMapKeySerialization)).factory(ArrayTypeAdapter.FACTORY).factory(TypeAdapters.ENUM_FACTORY).factory(reflectiveTypeAdapterFactory);
        this.miniGson = builder.build();
    }

    private TypeAdapter<Number> doubleAdapter(boolean serializeSpecialFloatingPointValues) {
        return serializeSpecialFloatingPointValues ? TypeAdapters.DOUBLE : new TypeAdapter<Number>() { // from class: com.google.gson.Gson.2
            @Override // com.google.gson.internal.bind.TypeAdapter
            public Number read(JsonReader reader) throws IOException {
                if (reader.peek() != JsonToken.NULL) {
                    return Double.valueOf(reader.nextDouble());
                }
                reader.nextNull();
                return null;
            }

            @Override // com.google.gson.internal.bind.TypeAdapter
            public void write(JsonWriter writer, Number value) throws IOException {
                if (value == null) {
                    writer.nullValue();
                    return;
                }
                double doubleValue = value.doubleValue();
                Gson.this.checkValidFloatingPoint(doubleValue);
                writer.value(value);
            }
        };
    }

    private TypeAdapter<Number> floatAdapter(boolean serializeSpecialFloatingPointValues) {
        return serializeSpecialFloatingPointValues ? TypeAdapters.FLOAT : new TypeAdapter<Number>() { // from class: com.google.gson.Gson.3
            @Override // com.google.gson.internal.bind.TypeAdapter
            public Number read(JsonReader reader) throws IOException {
                if (reader.peek() != JsonToken.NULL) {
                    return Float.valueOf((float) reader.nextDouble());
                }
                reader.nextNull();
                return null;
            }

            @Override // com.google.gson.internal.bind.TypeAdapter
            public void write(JsonWriter writer, Number value) throws IOException {
                if (value == null) {
                    writer.nullValue();
                    return;
                }
                float floatValue = value.floatValue();
                Gson.this.checkValidFloatingPoint(floatValue);
                writer.value(value);
            }
        };
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void checkValidFloatingPoint(double value) {
        if (Double.isNaN(value) || Double.isInfinite(value)) {
            throw new IllegalArgumentException(value + " is not a valid double value as per JSON specification. To override this behavior, use GsonBuilder.serializeSpecialDoubleValues() method.");
        }
    }

    private TypeAdapter<Number> longAdapter(LongSerializationPolicy longSerializationPolicy) {
        return longSerializationPolicy == LongSerializationPolicy.DEFAULT ? TypeAdapters.LONG : new TypeAdapter<Number>() { // from class: com.google.gson.Gson.4
            /* JADX WARN: Can't rename method to resolve collision */
            @Override // com.google.gson.internal.bind.TypeAdapter
            public Number read(JsonReader reader) throws IOException {
                if (reader.peek() != JsonToken.NULL) {
                    return Long.valueOf(reader.nextLong());
                }
                reader.nextNull();
                return null;
            }

            @Override // com.google.gson.internal.bind.TypeAdapter
            public void write(JsonWriter writer, Number value) throws IOException {
                if (value == null) {
                    writer.nullValue();
                } else {
                    writer.value(value.toString());
                }
            }
        };
    }

    private static ExclusionStrategy createExclusionStrategy() {
        List<ExclusionStrategy> strategies = new LinkedList<>();
        strategies.add(DEFAULT_ANON_LOCAL_CLASS_EXCLUSION_STRATEGY);
        strategies.add(DEFAULT_SYNTHETIC_FIELD_EXCLUSION_STRATEGY);
        strategies.add(DEFAULT_MODIFIER_BASED_EXCLUSION_STRATEGY);
        return new DisjunctionExclusionStrategy(strategies);
    }

    public JsonElement toJsonTree(Object src) {
        return src == null ? JsonNull.INSTANCE : toJsonTree(src, src.getClass());
    }

    public JsonElement toJsonTree(Object src, Type typeOfSrc) {
        JsonElementWriter writer = new JsonElementWriter();
        toJson(src, typeOfSrc, writer);
        return writer.get();
    }

    public String toJson(Object src) {
        return src == null ? toJson((JsonElement) JsonNull.INSTANCE) : toJson(src, src.getClass());
    }

    public String toJson(Object src, Type typeOfSrc) {
        StringWriter writer = new StringWriter();
        toJson(src, typeOfSrc, writer);
        return writer.toString();
    }

    public void toJson(Object src, Appendable writer) throws JsonIOException {
        if (src != null) {
            toJson(src, src.getClass(), writer);
        } else {
            toJson((JsonElement) JsonNull.INSTANCE, writer);
        }
    }

    public void toJson(Object src, Type typeOfSrc, Appendable writer) throws JsonIOException {
        try {
            JsonWriter jsonWriter = newJsonWriter(Streams.writerForAppendable(writer));
            toJson(src, typeOfSrc, jsonWriter);
        } catch (IOException e) {
            throw new JsonIOException(e);
        }
    }

    public void toJson(Object src, Type typeOfSrc, JsonWriter writer) throws JsonIOException {
        TypeAdapter<?> adapter = this.miniGson.getAdapter(TypeToken.get(typeOfSrc));
        boolean oldLenient = writer.isLenient();
        writer.setLenient(true);
        boolean oldHtmlSafe = writer.isHtmlSafe();
        writer.setHtmlSafe(this.htmlSafe);
        boolean oldSerializeNulls = writer.getSerializeNulls();
        writer.setSerializeNulls(this.serializeNulls);
        try {
            try {
                adapter.write(writer, src);
                writer.setLenient(oldLenient);
                writer.setHtmlSafe(oldHtmlSafe);
                writer.setSerializeNulls(oldSerializeNulls);
            } catch (IOException e) {
                throw new JsonIOException(e);
            }
        } catch (Throwable th) {
            writer.setLenient(oldLenient);
            writer.setHtmlSafe(oldHtmlSafe);
            writer.setSerializeNulls(oldSerializeNulls);
            throw th;
        }
    }

    public String toJson(JsonElement jsonElement) {
        StringWriter writer = new StringWriter();
        toJson(jsonElement, (Appendable) writer);
        return writer.toString();
    }

    public void toJson(JsonElement jsonElement, Appendable writer) throws JsonIOException {
        try {
            JsonWriter jsonWriter = newJsonWriter(Streams.writerForAppendable(writer));
            toJson(jsonElement, jsonWriter);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    private JsonWriter newJsonWriter(Writer writer) throws IOException {
        if (this.generateNonExecutableJson) {
            writer.write(JSON_NON_EXECUTABLE_PREFIX);
        }
        JsonWriter jsonWriter = new JsonWriter(writer);
        if (this.prettyPrinting) {
            jsonWriter.setIndent("  ");
        }
        jsonWriter.setSerializeNulls(this.serializeNulls);
        return jsonWriter;
    }

    public void toJson(JsonElement jsonElement, JsonWriter writer) throws JsonIOException {
        boolean oldLenient = writer.isLenient();
        writer.setLenient(true);
        boolean oldHtmlSafe = writer.isHtmlSafe();
        writer.setHtmlSafe(this.htmlSafe);
        boolean oldSerializeNulls = writer.getSerializeNulls();
        writer.setSerializeNulls(this.serializeNulls);
        try {
            try {
                Streams.write(jsonElement, writer);
                writer.setLenient(oldLenient);
                writer.setHtmlSafe(oldHtmlSafe);
                writer.setSerializeNulls(oldSerializeNulls);
            } catch (IOException e) {
                throw new JsonIOException(e);
            }
        } catch (Throwable th) {
            writer.setLenient(oldLenient);
            writer.setHtmlSafe(oldHtmlSafe);
            writer.setSerializeNulls(oldSerializeNulls);
            throw th;
        }
    }

    public <T> T fromJson(String str, Class<T> cls) throws JsonSyntaxException {
        return (T) Primitives.wrap(cls).cast(fromJson(str, (Type) cls));
    }

    public <T> T fromJson(String str, Type type) throws JsonSyntaxException {
        if (str == null) {
            return null;
        }
        return (T) fromJson(new StringReader(str), type);
    }

    public <T> T fromJson(Reader reader, Class<T> cls) throws JsonSyntaxException, JsonIOException {
        JsonReader jsonReader = new JsonReader(reader);
        Object objFromJson = fromJson(jsonReader, cls);
        assertFullConsumption(objFromJson, jsonReader);
        return (T) Primitives.wrap(cls).cast(objFromJson);
    }

    public <T> T fromJson(Reader reader, Type type) throws JsonSyntaxException, JsonIOException {
        JsonReader jsonReader = new JsonReader(reader);
        T t = (T) fromJson(jsonReader, type);
        assertFullConsumption(t, jsonReader);
        return t;
    }

    private static void assertFullConsumption(Object obj, JsonReader reader) {
        if (obj != null) {
            try {
                if (reader.peek() != JsonToken.END_DOCUMENT) {
                    throw new JsonIOException("JSON document was not fully consumed.");
                }
            } catch (MalformedJsonException e) {
                throw new JsonSyntaxException(e);
            } catch (IOException e2) {
                throw new JsonIOException(e2);
            }
        }
    }

    public <T> T fromJson(JsonReader reader, Type typeOfT) throws JsonSyntaxException, JsonIOException {
        boolean isEmpty = true;
        boolean oldLenient = reader.isLenient();
        reader.setLenient(true);
        try {
            try {
                reader.peek();
                isEmpty = DEFAULT_JSON_NON_EXECUTABLE;
                TypeAdapter<T> typeAdapter = this.miniGson.getAdapter(TypeToken.get(typeOfT));
                T t = typeAdapter.read(reader);
                reader.setLenient(oldLenient);
                return t;
            } catch (EOFException e) {
                if (!isEmpty) {
                    throw new JsonSyntaxException(e);
                }
                reader.setLenient(oldLenient);
                return null;
            } catch (IOException e2) {
                throw new JsonSyntaxException(e2);
            } catch (IllegalStateException e3) {
                throw new JsonSyntaxException(e3);
            }
        } catch (Throwable th) {
            reader.setLenient(oldLenient);
            throw th;
        }
    }

    public <T> T fromJson(JsonElement jsonElement, Class<T> cls) throws JsonSyntaxException {
        return (T) Primitives.wrap(cls).cast(fromJson(jsonElement, (Type) cls));
    }

    public <T> T fromJson(JsonElement jsonElement, Type type) throws JsonSyntaxException {
        if (jsonElement == null) {
            return null;
        }
        return (T) fromJson(new JsonElementReader(jsonElement), type);
    }

    public String toString() {
        StringBuilder sb = new StringBuilder("{").append("serializeNulls:").append(this.serializeNulls).append(",serializers:").append(this.serializers).append(",deserializers:").append(this.deserializers).append(",instanceCreators:").append(this.constructorConstructor).append("}");
        return sb.toString();
    }
}
