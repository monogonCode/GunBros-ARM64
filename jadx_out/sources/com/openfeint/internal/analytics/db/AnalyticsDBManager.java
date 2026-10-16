package com.openfeint.internal.analytics.db;

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteException;
import android.database.sqlite.SQLiteOpenHelper;
import com.openfeint.internal.logcat.OFLog;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/* JADX INFO: loaded from: classes.dex */
public final class AnalyticsDBManager {
    private static AnalyticsDBManager instance;
    private SQLiteDatabase db;
    private DBOpenHelper dbHelper;

    private class DBOpenHelper extends SQLiteOpenHelper {
        public DBOpenHelper(Context context, String str) {
            super(context, str, (SQLiteDatabase.CursorFactory) null, 1);
        }

        @Override // android.database.sqlite.SQLiteOpenHelper
        public final void onCreate(SQLiteDatabase sQLiteDatabase) {
            onUpgrade(sQLiteDatabase, 0, 1);
        }

        @Override // android.database.sqlite.SQLiteOpenHelper
        public final void onUpgrade(SQLiteDatabase sQLiteDatabase, int i, int i2) {
            if (i == 0 && i2 == 1) {
                OFLog.i("AnalyticsDBManager", "Migrating DB form V0 to V1..");
                sQLiteDatabase.execSQL("create table eventLogs (log_id integer primary key autoincrement, log_time integer not null, json text not null );");
                i++;
            }
            if (i != i2) {
                OFLog.e("AnalyticsDBManager", String.format("Unable to upgrade DB from %d to %d.", Integer.valueOf(i), Integer.valueOf(i2)));
            } else {
                OFLog.i("AnalyticsDBManager", String.format("Success on upgrade DB from %d to %d.", Integer.valueOf(i), Integer.valueOf(i2)));
            }
        }
    }

    private AnalyticsDBManager(Context context) {
        if (this.dbHelper == null) {
            this.dbHelper = new DBOpenHelper(context, "analytics.db");
        }
    }

    private void close() {
        OFLog.v("AnalyticsDBManager", "close db...");
        if (this.db == null || !this.db.isOpen()) {
            return;
        }
        try {
            this.db.close();
        } catch (Exception e) {
            OFLog.e("AnalyticsDBManager", "db close failed");
        }
    }

    public static AnalyticsDBManager instance(Context context) {
        if (instance == null) {
            instance = new AnalyticsDBManager(context);
        }
        return instance;
    }

    private void openToWR() {
        OFLog.v("AnalyticsDBManager", "open db to WR..");
        if (this.db != null && this.db.isOpen()) {
            OFLog.v("AnalyticsDBManager", "db already open ");
            return;
        }
        try {
            this.db = this.dbHelper.getWritableDatabase();
        } catch (SQLiteException e) {
            OFLog.e("AnalyticsDBManager", "db open failed");
            try {
                this.db.close();
            } catch (Exception e2) {
            }
        }
    }

    public final List<Map<String, Object>> getAllItems() {
        OFLog.v("AnalyticsDBManager", "open db readonly..");
        if (this.db == null || !this.db.isOpen()) {
            try {
                this.db = this.dbHelper.getWritableDatabase();
            } catch (SQLiteException e) {
                OFLog.e("AnalyticsDBManager", "db open failed");
                try {
                    this.db.close();
                } catch (Exception e2) {
                }
            }
        } else {
            OFLog.v("AnalyticsDBManager", "db already open ");
        }
        ArrayList arrayList = new ArrayList();
        try {
            try {
                Cursor cursorQuery = this.db.query("eventLogs", null, null, null, null, null, null);
                try {
                    cursorQuery.moveToFirst();
                    do {
                        HashMap map = new HashMap(3);
                        map.put("log_id", Long.valueOf(cursorQuery.getLong(cursorQuery.getColumnIndex("log_id"))));
                        map.put("log_time", Long.valueOf(cursorQuery.getLong(cursorQuery.getColumnIndex("log_time"))));
                        map.put("json", cursorQuery.getString(cursorQuery.getColumnIndex("json")));
                        arrayList.add(map);
                    } while (cursorQuery.moveToNext());
                } catch (Exception e3) {
                    OFLog.e("AnalyticsDBManager", "Exception in query.");
                } finally {
                    cursorQuery.close();
                }
                close();
            } catch (Exception e4) {
                OFLog.e("AnalyticsDBManager", "Exception creating query.");
                close();
            }
            return arrayList;
        } catch (Throwable th) {
            close();
            throw th;
        }
    }

    public final long insertLog(String str) {
        openToWR();
        ContentValues contentValues = new ContentValues();
        contentValues.put("log_time", Long.valueOf(System.currentTimeMillis()));
        contentValues.put("json", str);
        long jInsert = -1;
        try {
            jInsert = this.db.insert("eventLogs", null, contentValues);
            OFLog.d("AnalyticsDBManager", "insert " + String.valueOf(jInsert));
        } catch (Exception e) {
            OFLog.e("AnalyticsDBManager", "insert failed");
        } finally {
            close();
        }
        return jInsert;
    }

    public final boolean removeLog(long j, long j2) {
        openToWR();
        boolean z = this.db.delete("eventLogs", new StringBuilder().append("log_id>=").append(j).append(" AND ").append("log_id").append("<=").append(j2).toString(), null) > 0;
        if (z) {
            OFLog.d("AnalyticsDBManager", String.format("batch removeLog  success from %d to %d", Long.valueOf(j), Long.valueOf(j2)));
        } else {
            OFLog.w("AnalyticsDBManager", String.format("batch removeLog failed from %d to %d", Long.valueOf(j), Long.valueOf(j2)));
        }
        close();
        return z;
    }
}
