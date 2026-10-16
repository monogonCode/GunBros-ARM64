package com.urbanairship.analytics;

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteException;
import android.database.sqlite.SQLiteOpenHelper;
import android.provider.BaseColumns;
import com.urbanairship.Logger;
import com.urbanairship.UAirship;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;

/* JADX INFO: loaded from: classes.dex */
class EventDataManager {
    private static final String DATABASE_NAME = "ua_analytics.db";
    private static final int DATABASE_VERSION = 1;
    private SQLiteDatabase db;

    static class DatabaseHelper extends SQLiteOpenHelper {
        DatabaseHelper(Context context) {
            super(context, EventDataManager.DATABASE_NAME, (SQLiteDatabase.CursorFactory) null, 1);
        }

        @Override // android.database.sqlite.SQLiteOpenHelper
        public void onCreate(SQLiteDatabase sQLiteDatabase) {
            sQLiteDatabase.execSQL("CREATE TABLE IF NOT EXISTS events (_id INTEGER PRIMARY KEY AUTOINCREMENT,type TEXT,event_id TEXT,time INTEGER,data TEXT,session_id TEXT,event_size INTEGER);");
        }

        @Override // android.database.sqlite.SQLiteOpenHelper
        public void onUpgrade(SQLiteDatabase sQLiteDatabase, int i, int i2) {
            Logger.info("Upgrading anlytics database from version " + i + " to " + i2 + ", which will destroy all old data");
            sQLiteDatabase.execSQL("DROP TABLE IF EXISTS events");
            onCreate(sQLiteDatabase);
        }
    }

    public static final class Events implements BaseColumns {
        public static final String COLUMN_NAME_DATA = "data";
        public static final String COLUMN_NAME_EVENT_ID = "event_id";
        public static final String COLUMN_NAME_EVENT_SIZE = "event_size";
        public static final String COLUMN_NAME_SESSION_ID = "session_id";
        public static final String COLUMN_NAME_TIME = "time";
        public static final String COLUMN_NAME_TYPE = "type";
        public static final String DEFAULT_SORT_ORDER = "_id ASC";
        public static final String TABLE_NAME = "events";

        private Events() {
        }
    }

    public EventDataManager() {
        try {
            this.db = new DatabaseHelper(UAirship.shared().getApplicationContext()).getWritableDatabase();
            if (this.db == null) {
                Logger.error("Unable to create or open the analytics database.");
            }
        } catch (SQLiteException e) {
            Logger.error("Unable to open Analytics Event DB");
        }
    }

    public void close() {
        if (this.db == null || !this.db.isOpen()) {
            return;
        }
        this.db.close();
    }

    public void deleteEvent(String str) {
        if (this.db == null) {
            Logger.error("Unable to delete event. Database not open.");
        } else {
            this.db.delete(Events.TABLE_NAME, "event_id = ?", new String[]{str});
        }
    }

    public void deleteEventType(String str) {
        if (this.db == null) {
            Logger.error("Unable to delete events. Database not open.");
        } else {
            Logger.info("Deleted " + this.db.delete(Events.TABLE_NAME, "type = ?", new String[]{str}) + " rows with event type = " + str);
        }
    }

    public void deleteEvents(Set<String> set) {
        if (this.db == null) {
            Logger.error("Unable to delete events. Database not open.");
            return;
        }
        this.db.beginTransaction();
        Iterator<String> it = set.iterator();
        while (it.hasNext()) {
            this.db.delete(Events.TABLE_NAME, "event_id = ?", new String[]{it.next()});
        }
        this.db.endTransaction();
    }

    public void deleteEventsOlderThan(long j) {
        Logger.info("Deleting old events");
        if (this.db == null) {
            Logger.error("Unable to delete events. Database not open.");
        } else {
            this.db.delete(Events.TABLE_NAME, "_id <= ?", new String[]{Long.toString(j)});
        }
    }

    public void deleteSession(String str) {
        if (this.db == null) {
            Logger.error("Unable to delete session. Database not open.");
        } else {
            Logger.info("Deleted " + this.db.delete(Events.TABLE_NAME, "session_id = ?", new String[]{str}) + " rows with session id " + str);
        }
    }

    public SQLiteDatabase getDatabase() {
        return this.db;
    }

    public int getDatabaseSize() {
        if (this.db == null) {
            Logger.error("Unable to get DB size. Database not open.");
            return -1;
        }
        Cursor cursorQuery = this.db.query(Events.TABLE_NAME, new String[]{"SUM(event_size) as _size"}, null, null, null, null, null);
        Integer numValueOf = cursorQuery.moveToFirst() ? Integer.valueOf(cursorQuery.getInt(0)) : null;
        cursorQuery.close();
        if (numValueOf != null) {
            return numValueOf.intValue();
        }
        return -1;
    }

    public int getEventCount() {
        if (this.db == null) {
            Logger.error("Unable to get event count. Database not open.");
            return -1;
        }
        Cursor cursorQuery = this.db.query(Events.TABLE_NAME, new String[]{"COUNT(*) as _cnt"}, null, null, null, null, null);
        Integer numValueOf = cursorQuery.moveToFirst() ? Integer.valueOf(cursorQuery.getInt(0)) : null;
        cursorQuery.close();
        if (numValueOf != null) {
            return numValueOf.intValue();
        }
        return -1;
    }

    public Map<String, String> getEvents(int i) {
        HashMap map = null;
        if (this.db == null) {
            Logger.error("Unable to get events. Database not open.");
        } else {
            Cursor cursorQuery = this.db.query(Events.TABLE_NAME, new String[]{Events.COLUMN_NAME_EVENT_ID, Events.COLUMN_NAME_DATA}, null, null, null, null, Events.DEFAULT_SORT_ORDER, "0, " + i);
            map = new HashMap(i);
            cursorQuery.moveToFirst();
            while (!cursorQuery.isAfterLast()) {
                map.put(cursorQuery.getString(0), cursorQuery.getString(1));
                cursorQuery.moveToNext();
            }
            cursorQuery.close();
        }
        return map;
    }

    public Map<Long, String> getOldestEvents(int i) {
        HashMap map = null;
        if (this.db == null) {
            Logger.error("Unable to get events. Database not open.");
        } else {
            Cursor cursorQuery = this.db.query(Events.TABLE_NAME, new String[]{"_id", Events.COLUMN_NAME_DATA}, null, null, null, null, Events.DEFAULT_SORT_ORDER, "0, " + i);
            map = new HashMap(i);
            cursorQuery.moveToFirst();
            while (!cursorQuery.isAfterLast()) {
                map.put(Long.valueOf(cursorQuery.getLong(0)), cursorQuery.getString(1));
                cursorQuery.moveToNext();
            }
            cursorQuery.close();
        }
        return map;
    }

    public String getOldestSessionId() {
        String string = null;
        if (this.db == null) {
            Logger.error("Unable to get session ID. Database not open.");
        } else {
            Cursor cursorQuery = this.db.query(Events.TABLE_NAME, new String[]{Events.COLUMN_NAME_SESSION_ID}, null, null, null, null, Events.DEFAULT_SORT_ORDER, "0, 1");
            string = cursorQuery.moveToFirst() ? cursorQuery.getString(0) : null;
            cursorQuery.close();
        }
        return string;
    }

    public int insertEvent(Event event) {
        if (this.db == null) {
            Logger.error("Unable to insert event. Database not open.");
            return -1;
        }
        ContentValues contentValues = new ContentValues();
        int length = event.jsonRepresentation().toString().length();
        contentValues.put(Events.COLUMN_NAME_TYPE, event.getType());
        contentValues.put(Events.COLUMN_NAME_EVENT_ID, event.getEventId());
        contentValues.put(Events.COLUMN_NAME_DATA, event.jsonRepresentation().toString());
        contentValues.put(Events.COLUMN_NAME_TIME, event.getTime());
        contentValues.put(Events.COLUMN_NAME_SESSION_ID, event.getSessionId());
        contentValues.put(Events.COLUMN_NAME_EVENT_SIZE, Integer.valueOf(length));
        if (this.db.insert(Events.TABLE_NAME, null, contentValues) >= 0) {
            return length;
        }
        Logger.error("Error inserting event into Analytics DB.");
        return -1;
    }
}
