package com.google.gson.internal.bind;

import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonIOException;
import com.google.gson.JsonNull;
import com.google.gson.JsonObject;
import com.google.gson.JsonPrimitive;
import com.google.gson.JsonSyntaxException;
import com.google.gson.internal.LazilyParsedNumber;
import com.google.gson.reflect.TypeToken;
import com.google.gson.stream.JsonReader;
import com.google.gson.stream.JsonToken;
import com.google.gson.stream.JsonWriter;
import java.io.IOException;
import java.net.InetAddress;
import java.net.URI;
import java.net.URISyntaxException;
import java.net.URL;
import java.sql.Timestamp;
import java.util.BitSet;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.Iterator;
import java.util.Locale;
import java.util.Map;
import java.util.StringTokenizer;
import java.util.UUID;

/* JADX INFO: loaded from: classes.dex */
public final class TypeAdapters {
    public static final TypeAdapter<BitSet> BIT_SET = new TypeAdapter<BitSet>() { // from class: com.google.gson.internal.bind.TypeAdapters.1
        @Override // com.google.gson.internal.bind.TypeAdapter
        public BitSet read(JsonReader reader) throws IOException {
            boolean set;
            if (reader.peek() == JsonToken.NULL) {
                reader.nextNull();
                return null;
            }
            BitSet bitset = new BitSet();
            reader.beginArray();
            int i = 0;
            JsonToken tokenType = reader.peek();
            while (tokenType != JsonToken.END_ARRAY) {
                switch (AnonymousClass29.$SwitchMap$com$google$gson$stream$JsonToken[tokenType.ordinal()]) {
                    case 1:
                        set = reader.nextInt() != 0;
                        break;
                    case 2:
                        set = reader.nextBoolean();
                        break;
                    case 3:
                        String stringValue = reader.nextString();
                        try {
                            set = Integer.parseInt(stringValue) != 0;
                        } catch (NumberFormatException e) {
                            throw new JsonSyntaxException("Error: Expecting: bitset number value (1, 0), Found: " + stringValue);
                        }
                        break;
                    default:
                        throw new JsonSyntaxException("Invalid bitset value type: " + tokenType);
                }
                if (set) {
                    bitset.set(i);
                }
                i++;
                tokenType = reader.peek();
            }
            reader.endArray();
            return bitset;
        }

        @Override // com.google.gson.internal.bind.TypeAdapter
        public void write(JsonWriter writer, BitSet src) throws IOException {
            if (src == null) {
                writer.nullValue();
                return;
            }
            writer.beginArray();
            for (int i = 0; i < src.length(); i++) {
                int value = src.get(i) ? 1 : 0;
                writer.value(value);
            }
            writer.endArray();
        }
    };
    public static final TypeAdapter.Factory BIT_SET_FACTORY = newFactory(BitSet.class, BIT_SET);
    public static final TypeAdapter<Boolean> BOOLEAN = new TypeAdapter<Boolean>() { // from class: com.google.gson.internal.bind.TypeAdapters.2
        /* JADX WARN: Can't rename method to resolve collision */
        @Override // com.google.gson.internal.bind.TypeAdapter
        public Boolean read(JsonReader reader) throws IOException {
            if (reader.peek() == JsonToken.NULL) {
                reader.nextNull();
                return null;
            }
            if (reader.peek() == JsonToken.STRING) {
                return Boolean.valueOf(Boolean.parseBoolean(reader.nextString()));
            }
            return Boolean.valueOf(reader.nextBoolean());
        }

        @Override // com.google.gson.internal.bind.TypeAdapter
        public void write(JsonWriter writer, Boolean value) throws IOException {
            if (value == null) {
                writer.nullValue();
            } else {
                writer.value(value.booleanValue());
            }
        }
    };
    public static final TypeAdapter<Boolean> BOOLEAN_AS_STRING = new TypeAdapter<Boolean>() { // from class: com.google.gson.internal.bind.TypeAdapters.3
        /* JADX WARN: Can't rename method to resolve collision */
        @Override // com.google.gson.internal.bind.TypeAdapter
        public Boolean read(JsonReader reader) throws IOException {
            if (reader.peek() != JsonToken.NULL) {
                return Boolean.valueOf(reader.nextString());
            }
            reader.nextNull();
            return null;
        }

        @Override // com.google.gson.internal.bind.TypeAdapter
        public void write(JsonWriter writer, Boolean value) throws IOException {
            writer.value(value == null ? "null" : value.toString());
        }
    };
    public static final TypeAdapter.Factory BOOLEAN_FACTORY = newFactory(Boolean.TYPE, Boolean.class, BOOLEAN);
    public static final TypeAdapter<Number> BYTE = new TypeAdapter<Number>() { // from class: com.google.gson.internal.bind.TypeAdapters.4
        /* JADX WARN: Can't rename method to resolve collision */
        @Override // com.google.gson.internal.bind.TypeAdapter
        public Number read(JsonReader reader) throws IOException {
            if (reader.peek() == JsonToken.NULL) {
                reader.nextNull();
                return null;
            }
            try {
                int intValue = reader.nextInt();
                return Byte.valueOf((byte) intValue);
            } catch (NumberFormatException e) {
                throw new JsonSyntaxException(e);
            }
        }

        @Override // com.google.gson.internal.bind.TypeAdapter
        public void write(JsonWriter writer, Number value) throws IOException {
            writer.value(value);
        }
    };
    public static final TypeAdapter.Factory BYTE_FACTORY = newFactory(Byte.TYPE, Byte.class, BYTE);
    public static final TypeAdapter<Number> SHORT = new TypeAdapter<Number>() { // from class: com.google.gson.internal.bind.TypeAdapters.5
        /* JADX WARN: Can't rename method to resolve collision */
        @Override // com.google.gson.internal.bind.TypeAdapter
        public Number read(JsonReader reader) throws IOException {
            if (reader.peek() == JsonToken.NULL) {
                reader.nextNull();
                return null;
            }
            try {
                return Short.valueOf((short) reader.nextInt());
            } catch (NumberFormatException e) {
                throw new JsonSyntaxException(e);
            }
        }

        @Override // com.google.gson.internal.bind.TypeAdapter
        public void write(JsonWriter writer, Number value) throws IOException {
            writer.value(value);
        }
    };
    public static final TypeAdapter.Factory SHORT_FACTORY = newFactory(Short.TYPE, Short.class, SHORT);
    public static final TypeAdapter<Number> INTEGER = new TypeAdapter<Number>() { // from class: com.google.gson.internal.bind.TypeAdapters.6
        /* JADX WARN: Can't rename method to resolve collision */
        @Override // com.google.gson.internal.bind.TypeAdapter
        public Number read(JsonReader reader) throws IOException {
            if (reader.peek() == JsonToken.NULL) {
                reader.nextNull();
                return null;
            }
            try {
                return Integer.valueOf(reader.nextInt());
            } catch (NumberFormatException e) {
                throw new JsonSyntaxException(e);
            }
        }

        @Override // com.google.gson.internal.bind.TypeAdapter
        public void write(JsonWriter writer, Number value) throws IOException {
            writer.value(value);
        }
    };
    public static final TypeAdapter.Factory INTEGER_FACTORY = newFactory(Integer.TYPE, Integer.class, INTEGER);
    public static final TypeAdapter<Number> LONG = new TypeAdapter<Number>() { // from class: com.google.gson.internal.bind.TypeAdapters.7
        /* JADX WARN: Can't rename method to resolve collision */
        @Override // com.google.gson.internal.bind.TypeAdapter
        public Number read(JsonReader reader) throws IOException {
            if (reader.peek() == JsonToken.NULL) {
                reader.nextNull();
                return null;
            }
            try {
                return Long.valueOf(reader.nextLong());
            } catch (NumberFormatException e) {
                throw new JsonSyntaxException(e);
            }
        }

        @Override // com.google.gson.internal.bind.TypeAdapter
        public void write(JsonWriter writer, Number value) throws IOException {
            writer.value(value);
        }
    };
    public static final TypeAdapter.Factory LONG_FACTORY = newFactory(Long.TYPE, Long.class, LONG);
    public static final TypeAdapter<Number> FLOAT = new TypeAdapter<Number>() { // from class: com.google.gson.internal.bind.TypeAdapters.8
        /* JADX WARN: Can't rename method to resolve collision */
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
            writer.value(value);
        }
    };
    public static final TypeAdapter.Factory FLOAT_FACTORY = newFactory(Float.TYPE, Float.class, FLOAT);
    public static final TypeAdapter<Number> DOUBLE = new TypeAdapter<Number>() { // from class: com.google.gson.internal.bind.TypeAdapters.9
        /* JADX WARN: Can't rename method to resolve collision */
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
            writer.value(value);
        }
    };
    public static final TypeAdapter.Factory DOUBLE_FACTORY = newFactory(Double.TYPE, Double.class, DOUBLE);
    public static final TypeAdapter<Number> NUMBER = new TypeAdapter<Number>() { // from class: com.google.gson.internal.bind.TypeAdapters.10
        /* JADX WARN: Can't rename method to resolve collision */
        @Override // com.google.gson.internal.bind.TypeAdapter
        public Number read(JsonReader reader) throws IOException {
            JsonToken jsonToken = reader.peek();
            switch (AnonymousClass29.$SwitchMap$com$google$gson$stream$JsonToken[jsonToken.ordinal()]) {
                case 1:
                    return new LazilyParsedNumber(reader.nextString());
                case 2:
                case 3:
                default:
                    throw new JsonSyntaxException("Expecting number, got: " + jsonToken);
                case 4:
                    reader.nextNull();
                    return null;
            }
        }

        @Override // com.google.gson.internal.bind.TypeAdapter
        public void write(JsonWriter writer, Number value) throws IOException {
            writer.value(value);
        }
    };
    public static final TypeAdapter.Factory NUMBER_FACTORY = newFactory(Number.class, NUMBER);
    public static final TypeAdapter<Character> CHARACTER = new TypeAdapter<Character>() { // from class: com.google.gson.internal.bind.TypeAdapters.11
        /* JADX WARN: Can't rename method to resolve collision */
        @Override // com.google.gson.internal.bind.TypeAdapter
        public Character read(JsonReader reader) throws IOException {
            if (reader.peek() != JsonToken.NULL) {
                return Character.valueOf(reader.nextString().charAt(0));
            }
            reader.nextNull();
            return null;
        }

        @Override // com.google.gson.internal.bind.TypeAdapter
        public void write(JsonWriter writer, Character value) throws IOException {
            writer.value(value == null ? null : String.valueOf(value));
        }
    };
    public static final TypeAdapter.Factory CHARACTER_FACTORY = newFactory(Character.TYPE, Character.class, CHARACTER);
    public static final TypeAdapter<String> STRING = new TypeAdapter<String>() { // from class: com.google.gson.internal.bind.TypeAdapters.12
        @Override // com.google.gson.internal.bind.TypeAdapter
        public String read(JsonReader reader) throws IOException {
            JsonToken peek = reader.peek();
            if (peek == JsonToken.NULL) {
                reader.nextNull();
                return null;
            }
            if (peek == JsonToken.BOOLEAN) {
                return Boolean.toString(reader.nextBoolean());
            }
            return reader.nextString();
        }

        @Override // com.google.gson.internal.bind.TypeAdapter
        public void write(JsonWriter writer, String value) throws IOException {
            writer.value(value);
        }
    };
    public static final TypeAdapter.Factory STRING_FACTORY = newFactory(String.class, STRING);
    public static final TypeAdapter<StringBuilder> STRING_BUILDER = new TypeAdapter<StringBuilder>() { // from class: com.google.gson.internal.bind.TypeAdapters.13
        @Override // com.google.gson.internal.bind.TypeAdapter
        public StringBuilder read(JsonReader reader) throws IOException {
            if (reader.peek() != JsonToken.NULL) {
                return new StringBuilder(reader.nextString());
            }
            reader.nextNull();
            return null;
        }

        @Override // com.google.gson.internal.bind.TypeAdapter
        public void write(JsonWriter writer, StringBuilder value) throws IOException {
            writer.value(value == null ? null : value.toString());
        }
    };
    public static final TypeAdapter.Factory STRING_BUILDER_FACTORY = newFactory(StringBuilder.class, STRING_BUILDER);
    public static final TypeAdapter<StringBuffer> STRING_BUFFER = new TypeAdapter<StringBuffer>() { // from class: com.google.gson.internal.bind.TypeAdapters.14
        @Override // com.google.gson.internal.bind.TypeAdapter
        public StringBuffer read(JsonReader reader) throws IOException {
            if (reader.peek() != JsonToken.NULL) {
                return new StringBuffer(reader.nextString());
            }
            reader.nextNull();
            return null;
        }

        @Override // com.google.gson.internal.bind.TypeAdapter
        public void write(JsonWriter writer, StringBuffer value) throws IOException {
            writer.value(value == null ? null : value.toString());
        }
    };
    public static final TypeAdapter.Factory STRING_BUFFER_FACTORY = newFactory(StringBuffer.class, STRING_BUFFER);
    public static final TypeAdapter<URL> URL = new TypeAdapter<URL>() { // from class: com.google.gson.internal.bind.TypeAdapters.15
        @Override // com.google.gson.internal.bind.TypeAdapter
        public URL read(JsonReader reader) throws IOException {
            if (reader.peek() == JsonToken.NULL) {
                reader.nextNull();
                return null;
            }
            String nextString = reader.nextString();
            if ("null".equals(nextString)) {
                return null;
            }
            return new URL(nextString);
        }

        @Override // com.google.gson.internal.bind.TypeAdapter
        public void write(JsonWriter writer, URL value) throws IOException {
            writer.value(value == null ? null : value.toExternalForm());
        }
    };
    public static final TypeAdapter.Factory URL_FACTORY = newFactory(URL.class, URL);
    public static final TypeAdapter<URI> URI = new TypeAdapter<URI>() { // from class: com.google.gson.internal.bind.TypeAdapters.16
        @Override // com.google.gson.internal.bind.TypeAdapter
        public URI read(JsonReader reader) throws IOException {
            if (reader.peek() == JsonToken.NULL) {
                reader.nextNull();
                return null;
            }
            try {
                String nextString = reader.nextString();
                if ("null".equals(nextString)) {
                    return null;
                }
                return new URI(nextString);
            } catch (URISyntaxException e) {
                throw new JsonIOException(e);
            }
        }

        @Override // com.google.gson.internal.bind.TypeAdapter
        public void write(JsonWriter writer, URI value) throws IOException {
            writer.value(value == null ? null : value.toASCIIString());
        }
    };
    public static final TypeAdapter.Factory URI_FACTORY = newFactory(URI.class, URI);
    public static final TypeAdapter<InetAddress> INET_ADDRESS = new TypeAdapter<InetAddress>() { // from class: com.google.gson.internal.bind.TypeAdapters.17
        @Override // com.google.gson.internal.bind.TypeAdapter
        public InetAddress read(JsonReader reader) throws IOException {
            if (reader.peek() != JsonToken.NULL) {
                return InetAddress.getByName(reader.nextString());
            }
            reader.nextNull();
            return null;
        }

        @Override // com.google.gson.internal.bind.TypeAdapter
        public void write(JsonWriter writer, InetAddress value) throws IOException {
            writer.value(value == null ? null : value.getHostAddress());
        }
    };
    public static final TypeAdapter.Factory INET_ADDRESS_FACTORY = newTypeHierarchyFactory(InetAddress.class, INET_ADDRESS);
    public static final TypeAdapter<UUID> UUID = new TypeAdapter<UUID>() { // from class: com.google.gson.internal.bind.TypeAdapters.18
        @Override // com.google.gson.internal.bind.TypeAdapter
        public UUID read(JsonReader reader) throws IOException {
            if (reader.peek() != JsonToken.NULL) {
                return UUID.fromString(reader.nextString());
            }
            reader.nextNull();
            return null;
        }

        @Override // com.google.gson.internal.bind.TypeAdapter
        public void write(JsonWriter writer, UUID value) throws IOException {
            writer.value(value == null ? null : value.toString());
        }
    };
    public static final TypeAdapter.Factory UUID_FACTORY = newFactory(UUID.class, UUID);
    public static final TypeAdapter.Factory TIMESTAMP_FACTORY = new TypeAdapter.Factory() { // from class: com.google.gson.internal.bind.TypeAdapters.19
        @Override // com.google.gson.internal.bind.TypeAdapter.Factory
        public <T> TypeAdapter<T> create(MiniGson miniGson, TypeToken<T> typeToken) {
            if (typeToken.getRawType() != Timestamp.class) {
                return null;
            }
            final TypeAdapter<T> adapter = miniGson.getAdapter(Date.class);
            return (TypeAdapter<T>) new TypeAdapter<Timestamp>() { // from class: com.google.gson.internal.bind.TypeAdapters.19.1
                @Override // com.google.gson.internal.bind.TypeAdapter
                public Timestamp read(JsonReader reader) throws IOException {
                    Date date = (Date) adapter.read(reader);
                    if (date != null) {
                        return new Timestamp(date.getTime());
                    }
                    return null;
                }

                @Override // com.google.gson.internal.bind.TypeAdapter
                public void write(JsonWriter writer, Timestamp value) throws IOException {
                    adapter.write(writer, value);
                }
            };
        }
    };
    public static final TypeAdapter<Calendar> CALENDAR = new TypeAdapter<Calendar>() { // from class: com.google.gson.internal.bind.TypeAdapters.20
        private static final String DAY_OF_MONTH = "dayOfMonth";
        private static final String HOUR_OF_DAY = "hourOfDay";
        private static final String MINUTE = "minute";
        private static final String MONTH = "month";
        private static final String SECOND = "second";
        private static final String YEAR = "year";

        @Override // com.google.gson.internal.bind.TypeAdapter
        public Calendar read(JsonReader reader) throws IOException {
            if (reader.peek() == JsonToken.NULL) {
                reader.nextNull();
                return null;
            }
            reader.beginObject();
            int year = 0;
            int month = 0;
            int dayOfMonth = 0;
            int hourOfDay = 0;
            int minute = 0;
            int second = 0;
            while (reader.peek() != JsonToken.END_OBJECT) {
                String name = reader.nextName();
                int value = reader.nextInt();
                if (YEAR.equals(name)) {
                    year = value;
                } else if (MONTH.equals(name)) {
                    month = value;
                } else if (DAY_OF_MONTH.equals(name)) {
                    dayOfMonth = value;
                } else if (HOUR_OF_DAY.equals(name)) {
                    hourOfDay = value;
                } else if (MINUTE.equals(name)) {
                    minute = value;
                } else if (SECOND.equals(name)) {
                    second = value;
                }
            }
            reader.endObject();
            return new GregorianCalendar(year, month, dayOfMonth, hourOfDay, minute, second);
        }

        @Override // com.google.gson.internal.bind.TypeAdapter
        public void write(JsonWriter writer, Calendar value) throws IOException {
            if (value == null) {
                writer.nullValue();
                return;
            }
            writer.beginObject();
            writer.name(YEAR);
            writer.value(value.get(1));
            writer.name(MONTH);
            writer.value(value.get(2));
            writer.name(DAY_OF_MONTH);
            writer.value(value.get(5));
            writer.name(HOUR_OF_DAY);
            writer.value(value.get(11));
            writer.name(MINUTE);
            writer.value(value.get(12));
            writer.name(SECOND);
            writer.value(value.get(13));
            writer.endObject();
        }
    };
    public static final TypeAdapter.Factory CALENDAR_FACTORY = newFactoryForMultipleTypes(Calendar.class, GregorianCalendar.class, CALENDAR);
    public static final TypeAdapter<Locale> LOCALE = new TypeAdapter<Locale>() { // from class: com.google.gson.internal.bind.TypeAdapters.21
        @Override // com.google.gson.internal.bind.TypeAdapter
        public Locale read(JsonReader reader) throws IOException {
            if (reader.peek() == JsonToken.NULL) {
                reader.nextNull();
                return null;
            }
            String locale = reader.nextString();
            StringTokenizer tokenizer = new StringTokenizer(locale, "_");
            String language = null;
            String country = null;
            String variant = null;
            if (tokenizer.hasMoreElements()) {
                language = tokenizer.nextToken();
            }
            if (tokenizer.hasMoreElements()) {
                country = tokenizer.nextToken();
            }
            if (tokenizer.hasMoreElements()) {
                variant = tokenizer.nextToken();
            }
            if (country == null && variant == null) {
                return new Locale(language);
            }
            if (variant == null) {
                return new Locale(language, country);
            }
            return new Locale(language, country, variant);
        }

        @Override // com.google.gson.internal.bind.TypeAdapter
        public void write(JsonWriter writer, Locale value) throws IOException {
            writer.value(value == null ? null : value.toString());
        }
    };
    public static final TypeAdapter.Factory LOCALE_FACTORY = newFactory(Locale.class, LOCALE);
    public static final TypeAdapter<JsonElement> JSON_ELEMENT = new TypeAdapter<JsonElement>() { // from class: com.google.gson.internal.bind.TypeAdapters.22
        /* JADX WARN: Can't rename method to resolve collision */
        @Override // com.google.gson.internal.bind.TypeAdapter
        public JsonElement read(JsonReader reader) throws IOException {
            switch (AnonymousClass29.$SwitchMap$com$google$gson$stream$JsonToken[reader.peek().ordinal()]) {
                case 1:
                    String number = reader.nextString();
                    return new JsonPrimitive((Number) new LazilyParsedNumber(number));
                case 2:
                    return new JsonPrimitive(Boolean.valueOf(reader.nextBoolean()));
                case 3:
                    return new JsonPrimitive(reader.nextString());
                case 4:
                    reader.nextNull();
                    return JsonNull.INSTANCE;
                case 5:
                    JsonArray array = new JsonArray();
                    reader.beginArray();
                    while (reader.hasNext()) {
                        array.add(read(reader));
                    }
                    reader.endArray();
                    return array;
                case 6:
                    JsonObject object = new JsonObject();
                    reader.beginObject();
                    while (reader.hasNext()) {
                        object.add(reader.nextName(), read(reader));
                    }
                    reader.endObject();
                    return object;
                default:
                    throw new IllegalArgumentException();
            }
        }

        @Override // com.google.gson.internal.bind.TypeAdapter
        public void write(JsonWriter writer, JsonElement value) throws IOException {
            if (value == null || value.isJsonNull()) {
                writer.nullValue();
                return;
            }
            if (value.isJsonPrimitive()) {
                JsonPrimitive primitive = value.getAsJsonPrimitive();
                if (primitive.isNumber()) {
                    writer.value(primitive.getAsNumber());
                    return;
                } else if (primitive.isBoolean()) {
                    writer.value(primitive.getAsBoolean());
                    return;
                } else {
                    writer.value(primitive.getAsString());
                    return;
                }
            }
            if (value.isJsonArray()) {
                writer.beginArray();
                Iterator<JsonElement> it = value.getAsJsonArray().iterator();
                while (it.hasNext()) {
                    write(writer, it.next());
                }
                writer.endArray();
                return;
            }
            if (value.isJsonObject()) {
                writer.beginObject();
                for (Map.Entry<String, JsonElement> e : value.getAsJsonObject().entrySet()) {
                    writer.name(e.getKey());
                    write(writer, e.getValue());
                }
                writer.endObject();
                return;
            }
            throw new IllegalArgumentException("Couldn't write " + value.getClass());
        }
    };
    public static final TypeAdapter.Factory JSON_ELEMENT_FACTORY = newFactory(JsonElement.class, JSON_ELEMENT);
    public static final TypeAdapter.Factory ENUM_FACTORY = newEnumTypeHierarchyFactory(Enum.class);

    private TypeAdapters() {
    }

    /* JADX INFO: renamed from: com.google.gson.internal.bind.TypeAdapters$29, reason: invalid class name */
    static /* synthetic */ class AnonymousClass29 {
        static final /* synthetic */ int[] $SwitchMap$com$google$gson$stream$JsonToken = new int[JsonToken.values().length];

        static {
            try {
                $SwitchMap$com$google$gson$stream$JsonToken[JsonToken.NUMBER.ordinal()] = 1;
            } catch (NoSuchFieldError e) {
            }
            try {
                $SwitchMap$com$google$gson$stream$JsonToken[JsonToken.BOOLEAN.ordinal()] = 2;
            } catch (NoSuchFieldError e2) {
            }
            try {
                $SwitchMap$com$google$gson$stream$JsonToken[JsonToken.STRING.ordinal()] = 3;
            } catch (NoSuchFieldError e3) {
            }
            try {
                $SwitchMap$com$google$gson$stream$JsonToken[JsonToken.NULL.ordinal()] = 4;
            } catch (NoSuchFieldError e4) {
            }
            try {
                $SwitchMap$com$google$gson$stream$JsonToken[JsonToken.BEGIN_ARRAY.ordinal()] = 5;
            } catch (NoSuchFieldError e5) {
            }
            try {
                $SwitchMap$com$google$gson$stream$JsonToken[JsonToken.BEGIN_OBJECT.ordinal()] = 6;
            } catch (NoSuchFieldError e6) {
            }
            try {
                $SwitchMap$com$google$gson$stream$JsonToken[JsonToken.END_DOCUMENT.ordinal()] = 7;
            } catch (NoSuchFieldError e7) {
            }
            try {
                $SwitchMap$com$google$gson$stream$JsonToken[JsonToken.NAME.ordinal()] = 8;
            } catch (NoSuchFieldError e8) {
            }
            try {
                $SwitchMap$com$google$gson$stream$JsonToken[JsonToken.END_OBJECT.ordinal()] = 9;
            } catch (NoSuchFieldError e9) {
            }
            try {
                $SwitchMap$com$google$gson$stream$JsonToken[JsonToken.END_ARRAY.ordinal()] = 10;
            } catch (NoSuchFieldError e10) {
            }
        }
    }

    private static final class EnumTypeAdapter<T extends Enum<T>> extends TypeAdapter<T> {
        private final Class<T> classOfT;

        public EnumTypeAdapter(Class<T> classOfT) {
            this.classOfT = classOfT;
        }

        @Override // com.google.gson.internal.bind.TypeAdapter
        public T read(JsonReader jsonReader) throws IOException {
            if (jsonReader.peek() != JsonToken.NULL) {
                return (T) Enum.valueOf(this.classOfT, jsonReader.nextString());
            }
            jsonReader.nextNull();
            return null;
        }

        @Override // com.google.gson.internal.bind.TypeAdapter
        public void write(JsonWriter writer, T value) throws IOException {
            writer.value(value == null ? null : value.name());
        }
    }

    public static <TT> TypeAdapter.Factory newEnumTypeHierarchyFactory(final Class<TT> clazz) {
        return new TypeAdapter.Factory() { // from class: com.google.gson.internal.bind.TypeAdapters.23
            @Override // com.google.gson.internal.bind.TypeAdapter.Factory
            public <T> TypeAdapter<T> create(MiniGson context, TypeToken<T> typeToken) {
                Class<? super T> rawType = typeToken.getRawType();
                if (clazz.isAssignableFrom(rawType)) {
                    return new EnumTypeAdapter(rawType);
                }
                return null;
            }
        };
    }

    public static <TT> TypeAdapter.Factory newFactory(final TypeToken<TT> type, final TypeAdapter<TT> typeAdapter) {
        return new TypeAdapter.Factory() { // from class: com.google.gson.internal.bind.TypeAdapters.24
            @Override // com.google.gson.internal.bind.TypeAdapter.Factory
            public <T> TypeAdapter<T> create(MiniGson context, TypeToken<T> typeToken) {
                if (typeToken.equals(type)) {
                    return typeAdapter;
                }
                return null;
            }
        };
    }

    public static <TT> TypeAdapter.Factory newFactory(final Class<TT> type, final TypeAdapter<TT> typeAdapter) {
        return new TypeAdapter.Factory() { // from class: com.google.gson.internal.bind.TypeAdapters.25
            @Override // com.google.gson.internal.bind.TypeAdapter.Factory
            public <T> TypeAdapter<T> create(MiniGson context, TypeToken<T> typeToken) {
                if (typeToken.getRawType() == type) {
                    return typeAdapter;
                }
                return null;
            }

            public String toString() {
                return "Factory[type=" + type.getName() + ",adapter=" + typeAdapter + "]";
            }
        };
    }

    public static <TT> TypeAdapter.Factory newFactory(final Class<TT> unboxed, final Class<TT> boxed, final TypeAdapter<? super TT> typeAdapter) {
        return new TypeAdapter.Factory() { // from class: com.google.gson.internal.bind.TypeAdapters.26
            @Override // com.google.gson.internal.bind.TypeAdapter.Factory
            public <T> TypeAdapter<T> create(MiniGson context, TypeToken<T> typeToken) {
                Class<? super T> rawType = typeToken.getRawType();
                if (rawType == unboxed || rawType == boxed) {
                    return typeAdapter;
                }
                return null;
            }

            public String toString() {
                return "Factory[type=" + boxed.getName() + "+" + unboxed.getName() + ",adapter=" + typeAdapter + "]";
            }
        };
    }

    public static <TT> TypeAdapter.Factory newFactoryForMultipleTypes(final Class<TT> base, final Class<? extends TT> sub, final TypeAdapter<? super TT> typeAdapter) {
        return new TypeAdapter.Factory() { // from class: com.google.gson.internal.bind.TypeAdapters.27
            @Override // com.google.gson.internal.bind.TypeAdapter.Factory
            public <T> TypeAdapter<T> create(MiniGson context, TypeToken<T> typeToken) {
                Class<? super T> rawType = typeToken.getRawType();
                if (rawType == base || rawType == sub) {
                    return typeAdapter;
                }
                return null;
            }

            public String toString() {
                return "Factory[type=" + base.getName() + "+" + sub.getName() + ",adapter=" + typeAdapter + "]";
            }
        };
    }

    public static <TT> TypeAdapter.Factory newTypeHierarchyFactory(final Class<TT> clazz, final TypeAdapter<TT> typeAdapter) {
        return new TypeAdapter.Factory() { // from class: com.google.gson.internal.bind.TypeAdapters.28
            @Override // com.google.gson.internal.bind.TypeAdapter.Factory
            public <T> TypeAdapter<T> create(MiniGson context, TypeToken<T> typeToken) {
                if (clazz.isAssignableFrom(typeToken.getRawType())) {
                    return typeAdapter;
                }
                return null;
            }

            public String toString() {
                return "Factory[typeHierarchy=" + clazz.getName() + ",adapter=" + typeAdapter + "]";
            }
        };
    }
}
