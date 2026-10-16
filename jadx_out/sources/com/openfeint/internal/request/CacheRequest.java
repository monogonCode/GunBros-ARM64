package com.openfeint.internal.request;

import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteDiskIOException;
import com.openfeint.internal.db.DB;
import com.openfeint.internal.logcat.OFLog;
import com.openfeint.internal.ui.WebViewCache;
import org.apache.http.Header;
import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpUriRequest;

/* JADX INFO: loaded from: classes.dex */
public abstract class CacheRequest extends BaseRequest {
    private String key_;

    public CacheRequest(String str) {
        this.key_ = str;
    }

    private String getLastModified() {
        Cursor cursor;
        Exception exc;
        String str;
        Cursor cursorRawQuery;
        String string = null;
        try {
            SQLiteDatabase readableDatabase = DB.storeHelper.getReadableDatabase();
            cursorRawQuery = readableDatabase.rawQuery("SELECT VALUE FROM store where id=?", new String[]{this.key_});
            try {
                try {
                    if (cursorRawQuery.getCount() > 0) {
                        cursorRawQuery.moveToFirst();
                        string = cursorRawQuery.getString(0);
                    }
                    try {
                        readableDatabase.close();
                    } catch (Exception e) {
                        cursor = cursorRawQuery;
                        str = string;
                        exc = e;
                        OFLog.e("CacheRequest", exc.getMessage());
                        string = str;
                        cursorRawQuery = cursor;
                    }
                } catch (SQLiteDiskIOException e2) {
                    WebViewCache.diskError();
                }
            } catch (Exception e3) {
                cursor = cursorRawQuery;
                str = null;
                exc = e3;
            }
        } catch (SQLiteDiskIOException e4) {
            cursorRawQuery = null;
        } catch (Exception e5) {
            cursor = null;
            exc = e5;
            str = null;
        }
        if (cursorRawQuery != null) {
            cursorRawQuery.close();
        }
        return string;
    }

    @Override // com.openfeint.internal.request.BaseRequest
    protected final HttpUriRequest generateRequest() {
        HttpUriRequest httpUriRequestGenerateRequest = super.generateRequest();
        String lastModified = getLastModified();
        if (lastModified != null) {
            httpUriRequestGenerateRequest.addHeader("If-Modified-Since", lastModified);
        }
        return httpUriRequestGenerateRequest;
    }

    @Override // com.openfeint.internal.request.BaseRequest
    public final String method() {
        return "GET";
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public final void updateLastModifiedFromResponse(HttpResponse httpResponse) {
        String value;
        Header firstHeader = httpResponse != null ? httpResponse.getFirstHeader("Last-Modified") : null;
        if (firstHeader == null || (value = firstHeader.getValue()) == null) {
            return;
        }
        String[] strArr = {this.key_, value};
        try {
            SQLiteDatabase writableDatabase = DB.storeHelper.getWritableDatabase();
            writableDatabase.execSQL("INSERT OR REPLACE INTO store VALUES(?, ?)", strArr);
            writableDatabase.close();
        } catch (SQLiteDiskIOException e) {
            WebViewCache.diskError();
        } catch (Exception e2) {
            OFLog.e("CacheRequest", e2.getMessage());
        }
    }
}
