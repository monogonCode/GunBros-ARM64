package com.openfeint.internal.db;

import android.content.Context;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteDiskIOException;
import android.database.sqlite.SQLiteOpenHelper;
import android.database.sqlite.SQLiteStatement;
import android.os.Environment;
import com.openfeint.internal.Util;
import com.openfeint.internal.logcat.OFLog;
import com.openfeint.internal.ui.WebViewCache;
import java.io.File;

/* JADX INFO: loaded from: classes.dex */
public final class DB {
    public static DataStorageHelperX storeHelper;

    public static class DataStorageHelper extends SQLiteOpenHelper {
        DataStorageHelper(Context context) {
            super(context, "manifest.db", (SQLiteDatabase.CursorFactory) null, 3);
        }

        @Override // android.database.sqlite.SQLiteOpenHelper
        public final void onCreate(SQLiteDatabase sQLiteDatabase) {
            DB.onUpgrade(sQLiteDatabase, 0, 3);
        }

        @Override // android.database.sqlite.SQLiteOpenHelper
        public final void onUpgrade(SQLiteDatabase sQLiteDatabase, int i, int i2) {
            DB.onUpgrade(sQLiteDatabase, i, i2);
        }
    }

    public static class DataStorageHelperX extends SQLiteOpenHelperX {
        DataStorageHelperX(Context context) {
            super(new DataStorageHelper(context));
        }

        DataStorageHelperX(String str) {
            super(str);
        }

        @Override // com.openfeint.internal.db.SQLiteOpenHelperX
        public final void onCreate(SQLiteDatabase sQLiteDatabase) {
            DB.onUpgrade(sQLiteDatabase, 0, 3);
        }

        @Override // com.openfeint.internal.db.SQLiteOpenHelperX
        public final void onUpgrade(SQLiteDatabase sQLiteDatabase, int i, int i2) {
            DB.onUpgrade(sQLiteDatabase, i, i2);
        }
    }

    public static void createDB(Context context) {
        if (Util.noSdcardPermission()) {
            storeHelper = new DataStorageHelperX(context);
        } else if (!"mounted".equals(Environment.getExternalStorageState())) {
            storeHelper = new DataStorageHelperX(context);
        } else {
            storeHelper = new DataStorageHelperX(Environment.getExternalStorageDirectory().getAbsolutePath() + "/openfeint/webui/manifest.db");
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static void onUpgrade(SQLiteDatabase sQLiteDatabase, int i, int i2) {
        int i3;
        if (i == 0) {
            sQLiteDatabase.execSQL("CREATE TABLE IF NOT EXISTS manifest (path TEXT PRIMARY KEY, hash TEXT);");
            i3 = i + 1;
        } else {
            i3 = i;
        }
        if (i3 == 1) {
            sQLiteDatabase.execSQL("CREATE TABLE IF NOT EXISTS store (ID TEXT PRIMARY KEY, VALUE TEXT);");
            i3++;
        }
        if (i3 == 2) {
            sQLiteDatabase.execSQL("CREATE TABLE IF NOT EXISTS server_manifest (path TEXT PRIMARY KEY NOT NULL, hash TEXT DEFAULT NULL, is_global INTEGER DEFAULT 0);");
            sQLiteDatabase.execSQL("CREATE TABLE IF NOT EXISTS dependencies (path TEXT NOT NULL, has_dependency TEXT NOT NULL);");
            i3++;
        }
        if (i3 != i2) {
            OFLog.e("SQL", String.format("Unable to upgrade DB from %d to %d.", Integer.valueOf(i3), Integer.valueOf(i2)));
        }
    }

    public static boolean recover(Context context) {
        if (storeHelper != null) {
            storeHelper.close();
        }
        boolean zDelete = (Util.noSdcardPermission() || !"mounted".equals(Environment.getExternalStorageState())) ? context.getDatabasePath("manifest.db").delete() : new File(Environment.getExternalStorageDirectory(), "/openfeint/webui/manifest.db").delete();
        if (!zDelete) {
            return zDelete;
        }
        createDB(context);
        return storeHelper != null;
    }

    public static void setClientManifestBatch(String[] strArr, String[] strArr2) throws Throwable {
        SQLiteDatabase sQLiteDatabase;
        Throwable th;
        Exception exc;
        SQLiteDatabase writableDatabase = null;
        if (strArr.length != strArr2.length) {
            return;
        }
        try {
            try {
                try {
                    writableDatabase = storeHelper.getWritableDatabase();
                    try {
                        SQLiteStatement sQLiteStatementCompileStatement = writableDatabase.compileStatement("INSERT OR REPLACE INTO manifest(path, hash) VALUES(?,?)");
                        writableDatabase.beginTransaction();
                        for (int i = 0; i < strArr.length; i++) {
                            sQLiteStatementCompileStatement.bindString(1, strArr[i]);
                            sQLiteStatementCompileStatement.bindString(2, strArr2[i]);
                            sQLiteStatementCompileStatement.execute();
                        }
                        sQLiteStatementCompileStatement.close();
                        writableDatabase.setTransactionSuccessful();
                        try {
                            writableDatabase.endTransaction();
                        } catch (Exception e) {
                        }
                    } catch (Exception e2) {
                        sQLiteDatabase = writableDatabase;
                        exc = e2;
                        try {
                            OFLog.e("SQL", exc.toString());
                            try {
                                sQLiteDatabase.endTransaction();
                            } catch (Exception e3) {
                            }
                        } catch (Throwable th2) {
                            th = th2;
                            try {
                                sQLiteDatabase.endTransaction();
                            } catch (Exception e4) {
                            }
                            throw th;
                        }
                    }
                } catch (SQLiteDiskIOException e5) {
                    WebViewCache.diskError();
                    try {
                        writableDatabase.endTransaction();
                    } catch (Exception e6) {
                    }
                }
            } catch (Throwable th3) {
                sQLiteDatabase = writableDatabase;
                th = th3;
                sQLiteDatabase.endTransaction();
                throw th;
            }
        } catch (Exception e7) {
            sQLiteDatabase = null;
            exc = e7;
        } catch (Throwable th4) {
            sQLiteDatabase = null;
            th = th4;
            sQLiteDatabase.endTransaction();
            throw th;
        }
    }
}
