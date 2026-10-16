package com.google.gson.internal.bind;

import com.google.gson.JsonSyntaxException;
import com.google.gson.reflect.TypeToken;
import com.google.gson.stream.JsonReader;
import com.google.gson.stream.JsonToken;
import com.google.gson.stream.JsonWriter;
import java.io.IOException;
import java.sql.Date;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;

/* JADX INFO: loaded from: classes.dex */
public final class SqlDateTypeAdapter extends TypeAdapter<Date> {
    public static final TypeAdapter.Factory FACTORY = new TypeAdapter.Factory() { // from class: com.google.gson.internal.bind.SqlDateTypeAdapter.1
        @Override // com.google.gson.internal.bind.TypeAdapter.Factory
        public <T> TypeAdapter<T> create(MiniGson context, TypeToken<T> typeToken) {
            if (typeToken.getRawType() == Date.class) {
                return new SqlDateTypeAdapter();
            }
            return null;
        }
    };
    private final DateFormat format = new SimpleDateFormat("MMM d, yyyy");

    @Override // com.google.gson.internal.bind.TypeAdapter
    public synchronized Date read(JsonReader reader) throws IOException {
        Date date;
        if (reader.peek() == JsonToken.NULL) {
            reader.nextNull();
            date = null;
        } else {
            try {
                long utilDate = this.format.parse(reader.nextString()).getTime();
                date = new Date(utilDate);
            } catch (ParseException e) {
                throw new JsonSyntaxException(e);
            }
        }
        return date;
    }

    @Override // com.google.gson.internal.bind.TypeAdapter
    public synchronized void write(JsonWriter writer, Date value) throws IOException {
        writer.value(value == null ? null : this.format.format((java.util.Date) value));
    }
}
