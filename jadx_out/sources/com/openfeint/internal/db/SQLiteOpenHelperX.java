package com.openfeint.internal.db;

import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteException;
import android.database.sqlite.SQLiteOpenHelper;
import android.util.Log;

/* JADX INFO: loaded from: classes.dex */
public abstract class SQLiteOpenHelperX {
    private static final String TAG = SQLiteOpenHelperX.class.getSimpleName();
    private SQLiteDatabase mDatabase;
    private SQLiteOpenHelper mHelper;
    private String mName;
    private int mNewVersion;

    public SQLiteOpenHelperX(SQLiteOpenHelper sQLiteOpenHelper) {
        this.mDatabase = null;
        this.mHelper = sQLiteOpenHelper;
    }

    public SQLiteOpenHelperX(String str) {
        this.mDatabase = null;
        this.mName = str;
        this.mNewVersion = 3;
    }

    public final synchronized void close() {
        if (this.mDatabase != null && this.mDatabase.isOpen()) {
            this.mDatabase.close();
            this.mDatabase = null;
        }
        if (this.mHelper != null) {
            this.mHelper.close();
        }
    }

    public final synchronized SQLiteDatabase getReadableDatabase() {
        SQLiteDatabase writableDatabase;
        SQLiteDatabase sQLiteDatabase = null;
        synchronized (this) {
            if (this.mHelper != null) {
                writableDatabase = this.mHelper.getReadableDatabase();
            } else if (this.mDatabase == null || !this.mDatabase.isOpen()) {
                try {
                    writableDatabase = getWritableDatabase();
                } catch (SQLiteException e) {
                    if (this.mName == null) {
                        throw e;
                    }
                    Log.e(TAG, "Couldn't open " + this.mName + " for writing (will try read-only):", e);
                    try {
                        SQLiteDatabase sQLiteDatabaseOpenDatabase = SQLiteDatabase.openDatabase(this.mName, null, 1);
                        if (sQLiteDatabaseOpenDatabase.getVersion() != this.mNewVersion) {
                            throw new SQLiteException("Can't upgrade read-only database from version " + sQLiteDatabaseOpenDatabase.getVersion() + " to " + this.mNewVersion + ": " + this.mName);
                        }
                        Log.w(TAG, "Opened " + this.mName + " in read-only mode");
                        this.mDatabase = sQLiteDatabaseOpenDatabase;
                        writableDatabase = this.mDatabase;
                        if (sQLiteDatabaseOpenDatabase != null && sQLiteDatabaseOpenDatabase != this.mDatabase) {
                            sQLiteDatabaseOpenDatabase.close();
                        }
                    } catch (Throwable th) {
                        if (0 != 0 && null != this.mDatabase) {
                            sQLiteDatabase.close();
                        }
                        throw th;
                    }
                }
            } else {
                writableDatabase = this.mDatabase;
            }
        }
        return writableDatabase;
    }

    public final synchronized SQLiteDatabase getWritableDatabase() {
        SQLiteDatabase sQLiteDatabaseOpenOrCreateDatabase;
        SQLiteDatabase sQLiteDatabase = null;
        synchronized (this) {
            if (this.mHelper != null) {
                sQLiteDatabaseOpenOrCreateDatabase = this.mHelper.getWritableDatabase();
            } else if (this.mDatabase == null || !this.mDatabase.isOpen() || this.mDatabase.isReadOnly()) {
                try {
                    sQLiteDatabaseOpenOrCreateDatabase = SQLiteDatabase.openOrCreateDatabase(this.mName, (SQLiteDatabase.CursorFactory) null);
                    try {
                        int version = sQLiteDatabaseOpenOrCreateDatabase.getVersion();
                        if (version != this.mNewVersion) {
                            sQLiteDatabaseOpenOrCreateDatabase.beginTransaction();
                            try {
                                if (version == 0) {
                                    onCreate(sQLiteDatabaseOpenOrCreateDatabase);
                                } else {
                                    onUpgrade(sQLiteDatabaseOpenOrCreateDatabase, version, this.mNewVersion);
                                }
                                sQLiteDatabaseOpenOrCreateDatabase.setVersion(this.mNewVersion);
                                sQLiteDatabaseOpenOrCreateDatabase.setTransactionSuccessful();
                                sQLiteDatabaseOpenOrCreateDatabase.endTransaction();
                            } catch (Throwable th) {
                                sQLiteDatabaseOpenOrCreateDatabase.endTransaction();
                                throw th;
                            }
                        }
                        if (this.mDatabase != null) {
                            try {
                                this.mDatabase.close();
                            } catch (Exception e) {
                            }
                        }
                        this.mDatabase = sQLiteDatabaseOpenOrCreateDatabase;
                    } catch (Throwable th2) {
                        sQLiteDatabase = sQLiteDatabaseOpenOrCreateDatabase;
                        th = th2;
                        if (sQLiteDatabase != null) {
                            sQLiteDatabase.close();
                        }
                        throw th;
                    }
                } catch (Throwable th3) {
                    th = th3;
                }
            } else {
                sQLiteDatabaseOpenOrCreateDatabase = this.mDatabase;
            }
        }
        return sQLiteDatabaseOpenOrCreateDatabase;
    }

    public abstract void onCreate(SQLiteDatabase sQLiteDatabase);

    public abstract void onUpgrade(SQLiteDatabase sQLiteDatabase, int i, int i2);
}
