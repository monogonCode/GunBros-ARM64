package com.google.gson.internal.bind;

import com.google.gson.JsonSyntaxException;
import com.google.gson.reflect.TypeToken;
import com.google.gson.stream.JsonReader;
import com.google.gson.stream.JsonToken;
import com.google.gson.stream.JsonWriter;
import java.io.IOException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;
import java.util.TimeZone;

/* JADX INFO: loaded from: classes.dex */
public final class DateTypeAdapter extends TypeAdapter<Date> {
    public static final TypeAdapter.Factory FACTORY = new TypeAdapter.Factory() { // from class: com.google.gson.internal.bind.DateTypeAdapter.1
        @Override // com.google.gson.internal.bind.TypeAdapter.Factory
        public <T> TypeAdapter<T> create(MiniGson context, TypeToken<T> typeToken) {
            if (typeToken.getRawType() == Date.class) {
                return new DateTypeAdapter();
            }
            return null;
        }
    };
    private final DateFormat enUsFormat = DateFormat.getDateTimeInstance(2, 2, Locale.US);
    private final DateFormat localFormat = DateFormat.getDateTimeInstance(2, 2);
    private final DateFormat iso8601Format = buildIso8601Format();

    private static DateFormat buildIso8601Format() {
        DateFormat iso8601Format = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'", Locale.US);
        iso8601Format.setTimeZone(TimeZone.getTimeZone("UTC"));
        return iso8601Format;
    }

    @Override // com.google.gson.internal.bind.TypeAdapter
    public Date read(JsonReader reader) throws IOException {
        if (reader.peek() != JsonToken.NULL) {
            return deserializeToDate(reader.nextString());
        }
        reader.nextNull();
        return null;
    }

    private synchronized Date deserializeToDate(String json) {
        Date date;
        try {
            date = this.localFormat.parse(json);
        } catch (ParseException e) {
            try {
                date = this.enUsFormat.parse(json);
            } catch (ParseException e2) {
                try {
                    date = this.iso8601Format.parse(json);
                } catch (ParseException e3) {
                    throw new JsonSyntaxException(json, e3);
                }
            }
        }
        return date;
    }

    @Override // com.google.gson.internal.bind.TypeAdapter
    public synchronized void write(JsonWriter writer, Date value) throws IOException {
        try {
            if (value == null) {
                writer.nullValue();
            } else {
                String dateFormatAsString = this.enUsFormat.format(value);
                writer.value(dateFormatAsString);
            }
        } catch (Throwable th) {
            throw th;
        }
    }
}
