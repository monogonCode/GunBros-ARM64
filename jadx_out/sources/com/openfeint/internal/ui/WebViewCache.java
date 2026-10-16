package com.openfeint.internal.ui;

import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteDiskIOException;
import android.database.sqlite.SQLiteStatement;
import android.os.Environment;
import android.os.Handler;
import android.os.Message;
import com.openfeint.internal.OpenFeintInternal;
import com.openfeint.internal.Util;
import com.openfeint.internal.db.DB;
import com.openfeint.internal.logcat.OFLog;
import com.openfeint.internal.request.BaseRequest;
import com.openfeint.internal.request.CacheRequest;
import com.openfeint.internal.request.OrderedArgList;
import com.tapjoy.TapjoyConstants;
import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.URI;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;
import java.util.zip.ZipEntry;
import java.util.zip.ZipInputStream;
import javax.xml.parsers.SAXParserFactory;
import org.xml.sax.Attributes;
import org.xml.sax.InputSource;
import org.xml.sax.XMLReader;
import org.xml.sax.helpers.DefaultHandler;

/* JADX INFO: loaded from: classes.dex */
public final class WebViewCache {
    private static boolean diskError = false;
    public static String manifestProductOverride;
    private static String rootPath;
    private static String rootUri;
    static WebViewCache sInstance;
    public static URI serverOverride;
    Context appContext;
    Map<String, String> clientManifest;
    ManifestData serverManifest;
    boolean loadingFinished = false;
    boolean globalsFinished = false;
    boolean batchesAreBroken = false;
    boolean finishWhenClientManifestDone = false;
    final URI serverURI = getServerURI();
    Set<PathAndCallback> trackedPaths = new HashSet();
    Map<String, ItemAndCallback> trackedItems = new HashMap();
    Set<String> pathsToLoad = new HashSet();
    Set<String> prioritizedPaths = new HashSet();
    Handler mDelayHandler = new Handler();
    Handler mHandler = new Handler() { // from class: com.openfeint.internal.ui.WebViewCache.3
        @Override // android.os.Handler
        public final void dispatchMessage(Message message) throws Throwable {
            switch (message.what) {
                case 0:
                    OFLog.i("WebViewCache", "kServerManifestReady");
                    WebViewCache.this.serverManifest = (ManifestData) message.obj;
                    WebViewCache.access$300(WebViewCache.this);
                    break;
                case 1:
                    WebViewCache.access$400(WebViewCache.this, (String) message.obj, message.arg1 > 0);
                    break;
                case 2:
                    WebViewCache.this.finishItems((Set) message.obj, message.arg1 > 0, false);
                    break;
                case 3:
                    WebViewCache.this.clientManifest = (Map) message.obj;
                    WebViewCache.access$300(WebViewCache.this);
                    break;
                case 4:
                    if (WebViewCache.this.clientManifest == null) {
                        WebViewCache.this.finishWhenClientManifestDone = true;
                    } else {
                        WebViewCache.this.finishWithoutLoading();
                    }
                    break;
            }
        }
    };

    private static class ItemAndCallback {
        public final WebViewCacheCallback callback;
        public final ManifestItem item;

        public ItemAndCallback(ManifestItem manifestItem, WebViewCacheCallback webViewCacheCallback) {
            this.item = manifestItem;
            this.callback = webViewCacheCallback;
        }
    }

    private static class ManifestData {
        Set<String> globals;
        Map<String, ManifestItem> objects;

        /* JADX WARN: Multi-variable type inference failed */
        /* JADX WARN: Type inference failed for: r1v1, types: [java.util.HashMap, java.util.Map<java.lang.String, com.openfeint.internal.ui.WebViewCache$ManifestItem>] */
        /* JADX WARN: Type inference failed for: r1v10 */
        /* JADX WARN: Type inference failed for: r1v3 */
        /* JADX WARN: Type inference failed for: r1v7, types: [android.database.Cursor] */
        ManifestData(SQLiteDatabase sQLiteDatabase) throws Throwable {
            Throwable th;
            Cursor cursorRawQuery;
            Exception e;
            ManifestItem manifestItem;
            Cursor cursorRawQuery2 = null;
            this.globals = new HashSet();
            ?? map = new HashMap();
            this.objects = map;
            try {
                try {
                    try {
                        cursorRawQuery2 = sQLiteDatabase.rawQuery("SELECT path, hash, is_global FROM server_manifest", null);
                        try {
                            try {
                                if (cursorRawQuery2.getCount() > 0) {
                                    cursorRawQuery2.moveToFirst();
                                    do {
                                        String string = cursorRawQuery2.getString(0);
                                        String string2 = cursorRawQuery2.getString(1);
                                        boolean z = cursorRawQuery2.getInt(2) != 0;
                                        this.objects.put(string, new ManifestItem(string, string2));
                                        if (z) {
                                            this.globals.add(string);
                                        }
                                    } while (cursorRawQuery2.moveToNext());
                                }
                                cursorRawQuery2.close();
                                cursorRawQuery = cursorRawQuery2;
                                for (String str : this.objects.keySet()) {
                                    try {
                                        cursorRawQuery = sQLiteDatabase.rawQuery("SELECT has_dependency FROM dependencies WHERE path = ?", new String[]{str});
                                        if (cursorRawQuery.getCount() > 0 && (manifestItem = this.objects.get(str)) != null) {
                                            Set<String> set = manifestItem.dependentObjects;
                                            cursorRawQuery.moveToFirst();
                                            do {
                                                set.add(cursorRawQuery.getString(0));
                                            } while (cursorRawQuery.moveToNext());
                                        }
                                        cursorRawQuery.close();
                                    } catch (SQLiteDiskIOException e2) {
                                        cursorRawQuery2 = cursorRawQuery;
                                        WebViewCache.diskError();
                                        try {
                                            cursorRawQuery2.close();
                                            return;
                                        } catch (Exception e3) {
                                            return;
                                        }
                                    } catch (Exception e4) {
                                        e = e4;
                                        OFLog.e("WebViewCache", "SQLite exception. " + e.toString());
                                        try {
                                            cursorRawQuery.close();
                                            return;
                                        } catch (Exception e5) {
                                            return;
                                        }
                                    }
                                }
                                try {
                                    cursorRawQuery.close();
                                } catch (Exception e6) {
                                }
                            } catch (Exception e7) {
                                cursorRawQuery = cursorRawQuery2;
                                e = e7;
                            }
                        } catch (Throwable th2) {
                            map = cursorRawQuery2;
                            th = th2;
                            try {
                                map.close();
                            } catch (Exception e8) {
                            }
                            throw th;
                        }
                    } catch (Throwable th3) {
                        th = th3;
                        map.close();
                        throw th;
                    }
                } catch (SQLiteDiskIOException e9) {
                }
            } catch (Exception e10) {
                cursorRawQuery = null;
                e = e10;
            } catch (Throwable th4) {
                map = 0;
                th = th4;
                map.close();
                throw th;
            }
        }

        ManifestData(byte[] bArr) throws Exception {
            String strSubstring;
            this.globals = new HashSet();
            this.objects = new HashMap();
            ManifestItem manifestItem = null;
            try {
                BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(new ByteArrayInputStream(bArr)), 8192);
                while (true) {
                    String line = bufferedReader.readLine();
                    if (line == null) {
                        return;
                    }
                    String strTrim = line.trim();
                    if (strTrim.length() != 0) {
                        switch (strTrim.charAt(0)) {
                            case '#':
                                continue;
                            case '-':
                                if (manifestItem == null) {
                                    throw new Exception("Manifest Syntax Error: Dependency without an item");
                                }
                                manifestItem.dependentObjects.add(strTrim.substring(1).trim());
                                break;
                                break;
                            default:
                                String[] strArrSplit = strTrim.split(" ");
                                if (strArrSplit.length < 2) {
                                    throw new Exception("Manifest Syntax Error: Extra items in line");
                                }
                                if (strArrSplit[0].charAt(0) == '@') {
                                    strSubstring = strArrSplit[0].substring(1);
                                    this.globals.add(strSubstring);
                                } else {
                                    strSubstring = strArrSplit[0];
                                }
                                ManifestItem manifestItem2 = new ManifestItem(strSubstring, strArrSplit[1]);
                                this.objects.put(strSubstring, manifestItem2);
                                manifestItem = manifestItem2;
                                break;
                                break;
                        }
                    }
                }
            } catch (Exception e) {
                throw new Exception(e);
            }
        }
    }

    private static class ManifestItem {
        public Set<String> dependentObjects;
        public String hash;
        public String path;

        ManifestItem(ManifestItem manifestItem) {
            this.path = manifestItem.path;
            this.dependentObjects = new HashSet(manifestItem.dependentObjects);
        }

        ManifestItem(String str, String str2) {
            this.path = str;
            this.hash = str2;
            this.dependentObjects = new HashSet();
        }
    }

    private class ManifestRequest extends CacheRequest {
        private ManifestData data;

        public ManifestRequest(String str) {
            super(str);
            this.data = null;
        }

        /* JADX INFO: Access modifiers changed from: private */
        public void finishManifest() {
            if (this.data == null) {
                WebViewCache.access$1100(WebViewCache.this);
                return;
            }
            try {
                ManifestData manifestData = this.data;
                SQLiteDatabase writableDatabase = DB.storeHelper.getWritableDatabase();
                try {
                    try {
                        try {
                            writableDatabase.beginTransaction();
                            writableDatabase.execSQL("DELETE FROM server_manifest;");
                            writableDatabase.execSQL("DELETE FROM dependencies;");
                            SQLiteStatement sQLiteStatementCompileStatement = writableDatabase.compileStatement("INSERT INTO server_manifest(path, hash, is_global) VALUES(?, ?, ?)");
                            SQLiteStatement sQLiteStatementCompileStatement2 = writableDatabase.compileStatement("INSERT INTO dependencies(path, has_dependency) VALUES(?, ?)");
                            for (String str : manifestData.objects.keySet()) {
                                ManifestItem manifestItem = manifestData.objects.get(str);
                                sQLiteStatementCompileStatement.bindString(1, str);
                                sQLiteStatementCompileStatement.bindString(2, manifestItem.hash);
                                sQLiteStatementCompileStatement.bindLong(3, manifestData.globals.contains(str) ? 1L : 0L);
                                sQLiteStatementCompileStatement.execute();
                                sQLiteStatementCompileStatement2.bindString(1, str);
                                Iterator<String> it = manifestItem.dependentObjects.iterator();
                                while (it.hasNext()) {
                                    sQLiteStatementCompileStatement2.bindString(2, it.next());
                                    sQLiteStatementCompileStatement2.execute();
                                }
                            }
                            writableDatabase.setTransactionSuccessful();
                            try {
                                writableDatabase.endTransaction();
                            } catch (Exception e) {
                            }
                        } catch (Exception e2) {
                            OFLog.e("WebViewCache", "SQLite exception. " + e2.toString());
                            try {
                                writableDatabase.endTransaction();
                            } catch (Exception e3) {
                            }
                        }
                    } catch (Throwable th) {
                        try {
                            writableDatabase.endTransaction();
                        } catch (Exception e4) {
                        }
                        throw th;
                    }
                } catch (SQLiteDiskIOException e5) {
                    WebViewCache.diskError();
                    try {
                        writableDatabase.endTransaction();
                    } catch (Exception e6) {
                    }
                }
            } catch (Exception e7) {
                OFLog.e("WebViewCache", e7.toString());
            }
            Message.obtain(WebViewCache.this.mHandler, 0, this.data).sendToTarget();
        }

        @Override // com.openfeint.internal.request.BaseRequest
        public final void onResponse(int i, byte[] bArr) {
        }

        @Override // com.openfeint.internal.request.BaseRequest
        public final void onResponseOffMainThread(int i, byte[] bArr) {
            if (i == 200) {
                try {
                    this.data = new ManifestData(bArr);
                } catch (Exception e) {
                    OFLog.e("WebViewCache", e.toString());
                }
            } else {
                try {
                    this.data = new ManifestData(DB.storeHelper.getReadableDatabase());
                } catch (Exception e2) {
                    OFLog.e("WebViewCache", e2.toString());
                }
            }
            if (this.data == null || this.data.objects.isEmpty()) {
                this.data = null;
                OpenFeintInternal.makeRequest(new BaseRequest() { // from class: com.openfeint.internal.ui.WebViewCache.ManifestRequest.1
                    @Override // com.openfeint.internal.request.BaseRequest
                    public final String method() {
                        return "GET";
                    }

                    @Override // com.openfeint.internal.request.BaseRequest
                    public final void onResponse(int i2, byte[] bArr2) {
                    }

                    @Override // com.openfeint.internal.request.BaseRequest
                    public final void onResponseOffMainThread(int i2, byte[] bArr2) {
                        if (200 != i2) {
                            WebViewCache.access$1100(WebViewCache.this);
                            return;
                        }
                        try {
                            ManifestRequest.this.data = new ManifestData(bArr2);
                            ManifestRequest.this.finishManifest();
                            ManifestRequest.this.updateLastModifiedFromResponse(getResponse());
                        } catch (Exception e3) {
                        }
                    }

                    @Override // com.openfeint.internal.request.BaseRequest
                    public final String path() {
                        return ManifestRequest.this.path();
                    }
                });
            } else {
                finishManifest();
                updateLastModifiedFromResponse(getResponse());
            }
        }

        @Override // com.openfeint.internal.request.BaseRequest
        public final String path() {
            return WebViewCache.access$700(WebViewCache.this.appContext);
        }

        @Override // com.openfeint.internal.request.BaseRequest
        public final boolean signed() {
            return false;
        }
    }

    private static class PathAndCallback {
        public final WebViewCacheCallback callback;
        public final String path;

        public PathAndCallback(String str, WebViewCacheCallback webViewCacheCallback) {
            this.path = str;
            this.callback = webViewCacheCallback;
        }
    }

    private class SaxHandler extends DefaultHandler {
        String key;
        String loadingString;
        Map<String, String> outputMap;

        /* synthetic */ SaxHandler(WebViewCache webViewCache) {
            this((byte) 0);
        }

        private SaxHandler(byte b) {
            this.outputMap = new HashMap();
        }

        @Override // org.xml.sax.helpers.DefaultHandler, org.xml.sax.ContentHandler
        public final void characters(char[] cArr, int i, int i2) {
            this.loadingString = new String(cArr).substring(i, i + i2);
        }

        @Override // org.xml.sax.helpers.DefaultHandler, org.xml.sax.ContentHandler
        public final void endElement(String str, String str2, String str3) {
            String strTrim = str2.trim();
            if (strTrim.equals("key")) {
                this.key = this.loadingString;
                return;
            }
            if (strTrim.equals("string")) {
                this.outputMap.put(this.key, this.loadingString);
                try {
                    DB.storeHelper.getWritableDatabase().execSQL("INSERT OR REPLACE INTO manifest(path, hash) VALUES(?,?)", new String[]{this.key, this.loadingString});
                } catch (SQLiteDiskIOException e) {
                    WebViewCache.diskError();
                } catch (Exception e2) {
                    OFLog.e("SQL", e2.toString());
                }
            }
        }

        public final Map<String, String> getOutputMap() {
            return this.outputMap;
        }

        @Override // org.xml.sax.helpers.DefaultHandler, org.xml.sax.ContentHandler
        public final void startElement(String str, String str2, String str3, Attributes attributes) {
            this.loadingString = "";
        }
    }

    private WebViewCache(Context context) {
        this.appContext = context;
    }

    static /* synthetic */ void access$1100(WebViewCache webViewCache) {
        Message.obtain(webViewCache.mHandler, 4, null).sendToTarget();
    }

    static /* synthetic */ void access$1300(WebViewCache webViewCache, int i, byte[] bArr, final String str, final String str2, final int i2, final Set set) {
        if (200 > i || i >= 300) {
            if (302 == i || 303 == i) {
                webViewCache.batchFetch(str, str2, i2, set);
                return;
            }
            if (i != 0 && (400 > i || i >= 500)) {
                Message.obtain(webViewCache.mHandler, 2, 0, 0, set).sendToTarget();
                return;
            } else if (i2 > 0) {
                webViewCache.mDelayHandler.postDelayed(new Runnable() { // from class: com.openfeint.internal.ui.WebViewCache.6
                    @Override // java.lang.Runnable
                    public final void run() {
                        if (str.equals(str2)) {
                            WebViewCache.this.batchRequest(set, i2 - 1);
                        } else {
                            WebViewCache.this.batchFetch(str, str2, i2 - 1, set);
                        }
                    }
                }, 5000L);
                return;
            } else {
                Message.obtain(webViewCache.mHandler, 2, 0, 0, set).sendToTarget();
                return;
            }
        }
        HashSet hashSet = new HashSet();
        ZipInputStream zipInputStream = new ZipInputStream(new ByteArrayInputStream(bArr));
        while (true) {
            try {
                ZipEntry nextEntry = zipInputStream.getNextEntry();
                if (nextEntry == null) {
                    break;
                }
                if (!nextEntry.isDirectory()) {
                    String name = nextEntry.getName();
                    Util.saveStreamAndLeaveInputOpen(zipInputStream, rootPath + name);
                    hashSet.add(name);
                }
            } catch (Exception e) {
                OFLog.e("WebViewCache", e.getMessage());
            }
        }
        if (hashSet.isEmpty()) {
            Message.obtain(webViewCache.mHandler, 2, 0, 0, set).sendToTarget();
        } else {
            Message.obtain(webViewCache.mHandler, 2, 1, 0, hashSet).sendToTarget();
        }
    }

    static /* synthetic */ void access$200(WebViewCache webViewCache, File file) throws Throwable {
        HashSet hashSet = new HashSet();
        webViewCache.gatherDefaultItems("webui", hashSet);
        Set<String> setStripUnused = webViewCache.stripUnused(hashSet);
        webViewCache.copySpecific(file, "webui/manifest.plist", setStripUnused);
        webViewCache.copyDirectory(file, "webui/javascripts/", setStripUnused);
        webViewCache.copyDirectory(file, "webui/stylesheets/", setStripUnused);
        webViewCache.copyDirectory(file, "webui/intro/", setStripUnused);
        if (Util.getDpiName(webViewCache.appContext).equals("mdpi")) {
            webViewCache.copySpecific(file, "webui/images/space.grid.mdpi.png", setStripUnused);
            webViewCache.copySpecific(file, "webui/images/button.gray.mdpi.png", setStripUnused);
            webViewCache.copySpecific(file, "webui/images/button.gray.hit.mdpi.png", setStripUnused);
            webViewCache.copySpecific(file, "webui/images/button.green.mdpi.png", setStripUnused);
            webViewCache.copySpecific(file, "webui/images/button.green.hit.mdpi.png", setStripUnused);
            webViewCache.copySpecific(file, "webui/images/logo.small.mdpi.png", setStripUnused);
            webViewCache.copySpecific(file, "webui/images/header_bg.mdpi.png", setStripUnused);
            webViewCache.copySpecific(file, "webui/images/loading.spinner.mdpi.png", setStripUnused);
            webViewCache.copySpecific(file, "webui/images/input.text.mdpi.png", setStripUnused);
            webViewCache.copySpecific(file, "webui/images/frame.small.mdpi.png", setStripUnused);
            webViewCache.copySpecific(file, "webui/images/icon.leaf.gray.mdpi.png", setStripUnused);
            webViewCache.copySpecific(file, "webui/images/tab.divider.mdpi.png", setStripUnused);
            webViewCache.copySpecific(file, "webui/images/tab.active_indicator.mdpi.png", setStripUnused);
            webViewCache.copySpecific(file, "webui/images/logo.mdpi.png", setStripUnused);
            webViewCache.copySpecific(file, "webui/images/header_bg.mdpi.png", setStripUnused);
            webViewCache.copySpecific(file, "webui/images/loading.spinner.mdpi.png", setStripUnused);
            webViewCache.copySpecific(file, "webui/images/icon.user.male.mdpi.png", setStripUnused);
            webViewCache.copySpecific(file, "webui/images/intro.leaderboards.mdpi.png", setStripUnused);
            webViewCache.copySpecific(file, "webui/images/intro.friends.mdpi.png", setStripUnused);
            webViewCache.copySpecific(file, "webui/images/intro.achievements.mdpi.png", setStripUnused);
            webViewCache.copySpecific(file, "webui/images/intro.games.mdpi.png", setStripUnused);
        } else {
            webViewCache.copySpecific(file, "webui/images/space.grid.hdpi.png", setStripUnused);
            webViewCache.copySpecific(file, "webui/images/button.gray.hdpi.png", setStripUnused);
            webViewCache.copySpecific(file, "webui/images/button.gray.hit.hdpi.png", setStripUnused);
            webViewCache.copySpecific(file, "webui/images/button.green.hdpi.png", setStripUnused);
            webViewCache.copySpecific(file, "webui/images/button.green.hit.hdpi.png", setStripUnused);
            webViewCache.copySpecific(file, "webui/images/logo.small.hdpi.png", setStripUnused);
            webViewCache.copySpecific(file, "webui/images/header_bg.hdpi.png", setStripUnused);
            webViewCache.copySpecific(file, "webui/images/loading.spinner.hdpi.png", setStripUnused);
            webViewCache.copySpecific(file, "webui/images/input.text.hdpi.png", setStripUnused);
            webViewCache.copySpecific(file, "webui/images/frame.small.hdpi.png", setStripUnused);
            webViewCache.copySpecific(file, "webui/images/icon.leaf.gray.hdpi.png", setStripUnused);
            webViewCache.copySpecific(file, "webui/images/tab.divider.hdpi.png", setStripUnused);
            webViewCache.copySpecific(file, "webui/images/tab.active_indicator.hdpi.png", setStripUnused);
            webViewCache.copySpecific(file, "webui/images/logo.hdpi.png", setStripUnused);
            webViewCache.copySpecific(file, "webui/images/header_bg.hdpi.png", setStripUnused);
            webViewCache.copySpecific(file, "webui/images/loading.spinner.hdpi.png", setStripUnused);
            webViewCache.copySpecific(file, "webui/images/icon.user.male.hdpi.png", setStripUnused);
            webViewCache.copySpecific(file, "webui/images/intro.leaderboards.hdpi.png", setStripUnused);
            webViewCache.copySpecific(file, "webui/images/intro.friends.hdpi.png", setStripUnused);
            webViewCache.copySpecific(file, "webui/images/intro.achievements.hdpi.png", setStripUnused);
            webViewCache.copySpecific(file, "webui/images/intro.games.hdpi.png", setStripUnused);
        }
        if (OpenFeintInternal.getInstance().getSettings().get("com.openfeint.internal.InternalSettings.WebUIDelayUntilCopyFinished") != null) {
            Iterator<String> it = setStripUnused.iterator();
            while (it.hasNext()) {
                webViewCache.copySingleItem(file, it.next());
            }
            webViewCache.clientManifestReady();
            return;
        }
        webViewCache.clientManifestReady();
        Iterator<String> it2 = setStripUnused.iterator();
        while (it2.hasNext()) {
            webViewCache.copySingleItem(file, it2.next());
        }
    }

    static /* synthetic */ void access$300(WebViewCache webViewCache) {
        OFLog.i("WebViewCache", "loadedManifest");
        if (webViewCache.serverManifest == null || webViewCache.clientManifest == null) {
            if (webViewCache.clientManifest == null || !webViewCache.finishWhenClientManifestDone) {
                return;
            }
            webViewCache.finishWithoutLoading();
            return;
        }
        for (ManifestItem manifestItem : webViewCache.serverManifest.objects.values()) {
            if (!manifestItem.hash.equals(webViewCache.clientManifest.get(manifestItem.path))) {
                webViewCache.pathsToLoad.add(manifestItem.path);
            }
        }
        webViewCache.loadNextItem();
    }

    static /* synthetic */ void access$400(WebViewCache webViewCache, String str, boolean z) throws Throwable {
        HashSet hashSet = new HashSet(1);
        hashSet.add(str);
        webViewCache.finishItems(hashSet, z, true);
    }

    static /* synthetic */ String access$700(Context context) {
        return String.format("/webui/manifest/%s.%s.%s", TapjoyConstants.TJC_DEVICE_PLATFORM_TYPE, manifestProductOverride != null ? manifestProductOverride : "embed", Util.getDpiName(context));
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void batchFetch(final String str, final String str2, final int i, final Set<String> set) {
        new BaseRequest() { // from class: com.openfeint.internal.ui.WebViewCache.4
            @Override // com.openfeint.internal.request.BaseRequest
            public final String method() {
                return "GET";
            }

            @Override // com.openfeint.internal.request.BaseRequest
            public final void onResponse(int i2, byte[] bArr) {
            }

            @Override // com.openfeint.internal.request.BaseRequest
            public final void onResponseOffMainThread(int i2, byte[] bArr) {
                WebViewCache.access$1300(WebViewCache.this, i2, bArr, str, str2, i, set);
            }

            @Override // com.openfeint.internal.request.BaseRequest
            public final String path() {
                return "";
            }

            @Override // com.openfeint.internal.request.BaseRequest
            public final boolean signed() {
                return false;
            }

            @Override // com.openfeint.internal.request.BaseRequest
            public final String url() {
                return str;
            }
        }.launch();
    }

    private void batchRequest(Set<String> set) {
        batchRequest(set, 3);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void batchRequest(final Set<String> set, final int i) {
        OFLog.i("WebViewCache", String.format("Syncing %d items", Integer.valueOf(set.size())));
        OrderedArgList orderedArgList = new OrderedArgList();
        Iterator<String> it = set.iterator();
        while (it.hasNext()) {
            ManifestItem manifestItem = this.serverManifest.objects.get(it.next());
            orderedArgList.put("files[][path]", manifestItem.path);
            orderedArgList.put("files[][hash]", manifestItem.hash);
        }
        new BaseRequest(orderedArgList) { // from class: com.openfeint.internal.ui.WebViewCache.5
            @Override // com.openfeint.internal.request.BaseRequest
            public final String method() {
                return "POST";
            }

            @Override // com.openfeint.internal.request.BaseRequest
            public final void onResponse(int i2, byte[] bArr) {
            }

            @Override // com.openfeint.internal.request.BaseRequest
            protected final void onResponseOffMainThread(int i2, byte[] bArr) {
                WebViewCache.access$1300(WebViewCache.this, i2, bArr, url(), currentURL(), i, set);
            }

            @Override // com.openfeint.internal.request.BaseRequest
            public final String path() {
                return "/webui/assets";
            }

            @Override // com.openfeint.internal.request.BaseRequest
            public final boolean signed() {
                return false;
            }
        }.launch();
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void clientManifestReady() throws Throwable {
        Map<String, String> defaultClientManifest = getDefaultClientManifest();
        Message messageObtain = Message.obtain(this.mHandler, 3);
        messageObtain.obj = defaultClientManifest;
        messageObtain.sendToTarget();
    }

    private void copyDirectory(File file, String str, Set<String> set) {
        HashSet hashSet = new HashSet();
        for (String str2 : set) {
            if (str2.startsWith(str)) {
                hashSet.add(str2);
            }
        }
        Iterator it = hashSet.iterator();
        while (it.hasNext()) {
            copySpecific(file, (String) it.next(), set);
        }
    }

    private void copySingleItem(File file, String str) {
        try {
            File file2 = new File(file, str);
            DataInputStream dataInputStream = new DataInputStream(this.appContext.getAssets().open(str));
            file2.getParentFile().mkdirs();
            Util.copyStream(dataInputStream, new DataOutputStream(new FileOutputStream(file2)));
        } catch (Exception e) {
            OFLog.e("WebViewCache", e.toString());
        }
    }

    private void copySpecific(File file, String str, Set<String> set) {
        if (set.contains(str)) {
            copySingleItem(file, str);
            set.remove(str);
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void deleteAll() {
        Util.deleteFiles(new File(this.appContext.getFilesDir(), "webui"));
        this.appContext.getDatabasePath("manifest.db").delete();
    }

    public static void diskError() {
        diskError = true;
        Iterator<PathAndCallback> it = sInstance.trackedPaths.iterator();
        while (it.hasNext()) {
            it.next().callback.failLoaded();
        }
        sInstance.trackedPaths.clear();
        sInstance.finishWithoutLoading();
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void finishItems(Set<String> set, boolean z, boolean z2) throws Throwable {
        if (this.serverManifest == null) {
            return;
        }
        if (z || z2) {
            Iterator<ItemAndCallback> it = this.trackedItems.values().iterator();
            while (it.hasNext()) {
                it.next().item.dependentObjects.removeAll(set);
            }
            this.pathsToLoad.removeAll(set);
            this.serverManifest.globals.removeAll(set);
            this.prioritizedPaths.removeAll(set);
            if (this.globalsFinished) {
                HashSet hashSet = new HashSet();
                for (ItemAndCallback itemAndCallback : this.trackedItems.values()) {
                    if (!this.pathsToLoad.contains(itemAndCallback.item.path) && itemAndCallback.item.dependentObjects.size() == 0) {
                        hashSet.add(itemAndCallback.item.path);
                        itemAndCallback.callback.pathLoaded(itemAndCallback.item.path);
                    }
                }
                Iterator it2 = hashSet.iterator();
                while (it2.hasNext()) {
                    this.trackedItems.remove((String) it2.next());
                }
            }
            String[] strArr = new String[set.size()];
            String[] strArr2 = new String[strArr.length];
            int i = 0;
            for (String str : set) {
                String str2 = z ? this.serverManifest.objects.get(str).hash : "INVALID";
                strArr[i] = str;
                strArr2[i] = str2;
                this.clientManifest.put(str, str2);
                i++;
            }
            DB.setClientManifestBatch(strArr, strArr2);
        } else {
            this.batchesAreBroken = true;
        }
        loadNextItem();
    }

    private void finishLoading() {
        DB.storeHelper.close();
        this.loadingFinished = true;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void finishWithoutLoading() {
        OFLog.i("WebViewCache", "finishWithoutLoading");
        finishLoading();
        for (PathAndCallback pathAndCallback : this.trackedPaths) {
            pathAndCallback.callback.pathLoaded(pathAndCallback.path);
        }
        this.trackedPaths.clear();
        this.prioritizedPaths.clear();
        if (this.serverManifest == null) {
            try {
                this.serverManifest = new ManifestData(new byte[0]);
            } catch (Exception e) {
            }
        }
        this.serverManifest.globals.clear();
        this.pathsToLoad.clear();
    }

    private void gatherDefaultItems(String str, Set<String> set) {
        try {
            for (String str2 : this.appContext.getAssets().list(str)) {
                String str3 = str + "/" + str2;
                try {
                    InputStream inputStreamOpen = this.appContext.getAssets().open(str3);
                    set.add(str3);
                    inputStreamOpen.close();
                } catch (IOException e) {
                    gatherDefaultItems(str3, set);
                }
            }
        } catch (IOException e2) {
            OFLog.e("WebViewCache", e2.toString());
        }
    }

    private Map<String, String> getDefaultClientManifest() throws Throwable {
        Cursor cursor;
        Throwable th;
        Cursor cursorRawQuery;
        Exception e;
        Cursor cursor2 = null;
        try {
            try {
                cursorRawQuery = DB.storeHelper.getReadableDatabase().rawQuery("SELECT * FROM manifest", null);
                try {
                    if (cursorRawQuery.getCount() > 0) {
                        HashMap map = new HashMap();
                        cursorRawQuery.moveToFirst();
                        do {
                            map.put(cursorRawQuery.getString(0), cursorRawQuery.getString(1));
                        } while (cursorRawQuery.moveToNext());
                        cursorRawQuery.close();
                        OFLog.i("WebViewCache", "create client Manifest from db");
                        try {
                            cursorRawQuery.close();
                            return map;
                        } catch (Exception e2) {
                            return map;
                        }
                    }
                    try {
                        cursorRawQuery.close();
                    } catch (Exception e3) {
                    }
                } catch (SQLiteDiskIOException e4) {
                    cursor2 = cursorRawQuery;
                    try {
                        diskError();
                        try {
                            cursor2.close();
                        } catch (Exception e5) {
                        }
                    } catch (Throwable th2) {
                        cursor = cursor2;
                        th = th2;
                        try {
                            cursor.close();
                        } catch (Exception e6) {
                        }
                        throw th;
                    }
                } catch (Exception e7) {
                    e = e7;
                    OFLog.e("WebViewCache", "SQLite exception. " + e.toString());
                    try {
                        cursorRawQuery.close();
                    } catch (Exception e8) {
                    }
                }
            } catch (Throwable th3) {
                th = th3;
                cursor.close();
                throw th;
            }
        } catch (SQLiteDiskIOException e9) {
        } catch (Exception e10) {
            cursorRawQuery = null;
            e = e10;
        } catch (Throwable th4) {
            cursor = null;
            th = th4;
            cursor.close();
            throw th;
        }
        return getDefaultClientManifestFromAsset();
    }

    private Map<String, String> getDefaultClientManifestFromAsset() {
        File file = new File(rootPath, "manifest.plist");
        if (file.isFile()) {
            try {
                XMLReader xMLReader = SAXParserFactory.newInstance().newSAXParser().getXMLReader();
                SaxHandler saxHandler = new SaxHandler(this);
                xMLReader.setContentHandler(saxHandler);
                xMLReader.parse(new InputSource(new FileInputStream(file.getPath())));
                return saxHandler.getOutputMap();
            } catch (Exception e) {
                OFLog.e("WebViewCache", e.toString());
            }
        }
        return new HashMap();
    }

    public static final String getItemUri(String str) {
        return rootUri + str;
    }

    private static final URI getServerURI() {
        try {
            return serverOverride != null ? serverOverride : new URI(OpenFeintInternal.getInstance().getServerUrl());
        } catch (Exception e) {
            return null;
        }
    }

    public static WebViewCache initialize(Context context) {
        if (sInstance != null) {
            sInstance.finishWithoutLoading();
        }
        WebViewCache webViewCache = new WebViewCache(context);
        sInstance = webViewCache;
        return webViewCache;
    }

    public static boolean isDiskError() {
        return diskError;
    }

    private void loadNextItem() {
        ManifestItem manifestItem;
        OFLog.i("WebViewCache", "loadNextItem");
        this.serverManifest.globals.retainAll(this.pathsToLoad);
        if (!this.globalsFinished && this.serverManifest.globals.isEmpty()) {
            for (PathAndCallback pathAndCallback : this.trackedPaths) {
                if (this.pathsToLoad.contains(pathAndCallback.path)) {
                    ManifestItem manifestItem2 = new ManifestItem(this.serverManifest.objects.get(pathAndCallback.path));
                    manifestItem2.dependentObjects.retainAll(this.pathsToLoad);
                    this.trackedItems.put(pathAndCallback.path, new ItemAndCallback(manifestItem2, pathAndCallback.callback));
                } else {
                    pathAndCallback.callback.pathLoaded(pathAndCallback.path);
                }
            }
            this.trackedPaths.clear();
            HashSet hashSet = new HashSet();
            for (String str : this.prioritizedPaths) {
                if (this.pathsToLoad.contains(str) && (manifestItem = this.serverManifest.objects.get(str)) != null) {
                    hashSet.addAll(manifestItem.dependentObjects);
                }
            }
            hashSet.retainAll(this.pathsToLoad);
            this.prioritizedPaths.addAll(hashSet);
            this.globalsFinished = true;
        }
        this.prioritizedPaths.retainAll(this.pathsToLoad);
        int size = this.serverManifest.globals.size() + this.prioritizedPaths.size();
        if (!this.batchesAreBroken && size > 1) {
            HashSet hashSet2 = new HashSet();
            hashSet2.addAll(this.serverManifest.globals);
            hashSet2.addAll(this.prioritizedPaths);
            batchRequest(hashSet2);
            return;
        }
        if (this.serverManifest.globals.size() > 0) {
            singleRequest(this.serverManifest.globals.iterator().next());
            return;
        }
        if (this.prioritizedPaths.size() > 0) {
            singleRequest(this.prioritizedPaths.iterator().next());
            return;
        }
        if (!this.batchesAreBroken && this.pathsToLoad.size() > 1) {
            batchRequest(this.pathsToLoad);
        } else if (this.pathsToLoad.size() > 0) {
            singleRequest(this.pathsToLoad.iterator().next());
        } else {
            finishLoading();
        }
    }

    public static void prioritize(String str) {
        ManifestItem manifestItem;
        WebViewCache webViewCache = sInstance;
        if (webViewCache.loadingFinished) {
            return;
        }
        webViewCache.prioritizedPaths.add(str);
        if (webViewCache.serverManifest == null || (manifestItem = webViewCache.serverManifest.objects.get(str)) == null) {
            return;
        }
        HashSet hashSet = new HashSet(manifestItem.dependentObjects);
        hashSet.retainAll(webViewCache.pathsToLoad);
        webViewCache.prioritizedPaths.addAll(hashSet);
        OFLog.i("WebViewCache", "Prioritizing " + str + " deps:" + hashSet.toString());
    }

    public static boolean recover() {
        if (diskError) {
            return false;
        }
        WebViewCache webViewCache = sInstance;
        boolean zRecover = DB.recover(webViewCache.appContext);
        webViewCache.serverManifest = null;
        if (zRecover) {
            webViewCache.clientManifest = webViewCache.getDefaultClientManifestFromAsset();
            zRecover = !webViewCache.clientManifest.isEmpty();
        }
        webViewCache.loadingFinished = false;
        webViewCache.globalsFinished = false;
        webViewCache.finishWhenClientManifestDone = false;
        webViewCache.sync();
        return zRecover;
    }

    private final void singleRequest(final String str) {
        OFLog.i("WebViewCache", "Syncing item: " + str);
        new BaseRequest() { // from class: com.openfeint.internal.ui.WebViewCache.7
            @Override // com.openfeint.internal.request.BaseRequest
            public final String method() {
                return "GET";
            }

            @Override // com.openfeint.internal.request.BaseRequest
            public final void onResponse(int i, byte[] bArr) {
                if (i != 200) {
                    Message.obtain(WebViewCache.this.mHandler, 1, 0, 0, str).sendToTarget();
                    return;
                }
                try {
                    Util.saveFile(bArr, WebViewCache.rootPath + str);
                    Message.obtain(WebViewCache.this.mHandler, 1, 1, 0, str).sendToTarget();
                } catch (Exception e) {
                    Message.obtain(WebViewCache.this.mHandler, 1, 0, 0, str).sendToTarget();
                }
            }

            @Override // com.openfeint.internal.request.BaseRequest
            public final String path() {
                return "/webui/" + str;
            }

            @Override // com.openfeint.internal.request.BaseRequest
            public final boolean signed() {
                return false;
            }
        }.launch();
    }

    /* JADX WARN: Code duplicated, block: B:19:0x0055  */
    /* JADX WARN: Code duplicated, block: B:21:0x0087  */
    /* JADX WARN: Code duplicated, block: B:25:0x00bb  */
    /* JADX WARN: Code duplicated, block: B:31:0x009a A[EXC_TOP_SPLITTER, SYNTHETIC] */
    public static void start() {
        final File file;
        WebViewCache webViewCache = sInstance;
        if (Util.noSdcardPermission()) {
            OFLog.e("WebViewCache", "no sdcard permission");
            webViewCache.setRootUriInternal();
        } else {
            String externalStorageState = Environment.getExternalStorageState();
            if ("mounted".equals(externalStorageState)) {
                File file2 = new File(Environment.getExternalStorageDirectory(), "openfeint");
                final File file3 = new File(file2, "webui");
                boolean z = !file3.exists();
                if (z) {
                    try {
                        new File(file2, ".nomedia").createNewFile();
                    } catch (IOException e) {
                    }
                    if (file3.mkdirs()) {
                        rootPath = file3.getAbsolutePath() + "/";
                        rootUri = "file://" + rootPath;
                        if (z) {
                            final File filesDir = webViewCache.appContext.getFilesDir();
                            file = new File(filesDir, "webui");
                            if (file.isDirectory()) {
                                try {
                                    Util.copyFile(webViewCache.appContext.getDatabasePath("manifest.db"), new File(file3, "manifest.db"));
                                } catch (IOException e2) {
                                }
                            }
                            new Thread(new Runnable() { // from class: com.openfeint.internal.ui.WebViewCache.1
                                @Override // java.lang.Runnable
                                public final void run() throws Throwable {
                                    try {
                                        if (file.isDirectory()) {
                                            Util.copyDirectory(file, file3);
                                            WebViewCache.this.deleteAll();
                                            OFLog.i("WebViewCache", "copy in phone data finish");
                                            WebViewCache.this.clientManifestReady();
                                        } else {
                                            OFLog.i("WebViewCache", "copy from asset");
                                            WebViewCache.access$200(WebViewCache.this, filesDir);
                                        }
                                    } catch (IOException e3) {
                                        OFLog.e("WebViewCache", e3.getMessage());
                                        WebViewCache.this.setRootUriInternal();
                                    }
                                }
                            }).start();
                        } else {
                            webViewCache.clientManifestReady();
                            webViewCache.deleteAll();
                        }
                    } else {
                        webViewCache.setRootUriInternal();
                    }
                } else {
                    rootPath = file3.getAbsolutePath() + "/";
                    rootUri = "file://" + rootPath;
                    if (z) {
                        final File filesDir2 = webViewCache.appContext.getFilesDir();
                        file = new File(filesDir2, "webui");
                        if (file.isDirectory()) {
                            Util.copyFile(webViewCache.appContext.getDatabasePath("manifest.db"), new File(file3, "manifest.db"));
                        }
                        new Thread(new Runnable() { // from class: com.openfeint.internal.ui.WebViewCache.1
                            @Override // java.lang.Runnable
                            public final void run() throws Throwable {
                                try {
                                    if (file.isDirectory()) {
                                        Util.copyDirectory(file, file3);
                                        WebViewCache.this.deleteAll();
                                        OFLog.i("WebViewCache", "copy in phone data finish");
                                        WebViewCache.this.clientManifestReady();
                                    } else {
                                        OFLog.i("WebViewCache", "copy from asset");
                                        WebViewCache.access$200(WebViewCache.this, filesDir2);
                                    }
                                } catch (IOException e3) {
                                    OFLog.e("WebViewCache", e3.getMessage());
                                    WebViewCache.this.setRootUriInternal();
                                }
                            }
                        }).start();
                    } else {
                        webViewCache.clientManifestReady();
                        webViewCache.deleteAll();
                    }
                }
            } else {
                OFLog.i("WebViewCache", externalStorageState);
                webViewCache.setRootUriInternal();
            }
        }
        sInstance.sync();
    }

    private Set<String> stripUnused(Set<String> set) {
        CharSequence charSequence = Util.getDpiName(this.appContext).equals("mdpi") ? ".hdpi." : ".mdpi.";
        HashSet hashSet = new HashSet();
        for (String str : set) {
            if (!str.contains(charSequence)) {
                hashSet.add(str);
            }
        }
        return hashSet;
    }

    private void sync() {
        OFLog.i("WebViewCache", "--- WebViewCache Sync ---");
        new ManifestRequest("manifest").launch();
    }

    public static boolean trackPath(String str, WebViewCacheCallback webViewCacheCallback) {
        WebViewCache webViewCache = sInstance;
        if (!webViewCache.loadingFinished) {
            if (webViewCache.serverManifest == null) {
                webViewCacheCallback.onTrackingNeeded();
                webViewCache.trackedPaths.add(new PathAndCallback(str, webViewCacheCallback));
                return true;
            }
            ManifestItem manifestItem = webViewCache.serverManifest.objects.get(str);
            if (manifestItem != null) {
                webViewCacheCallback.onTrackingNeeded();
                ManifestItem manifestItem2 = new ManifestItem(manifestItem);
                manifestItem2.dependentObjects.retainAll(webViewCache.pathsToLoad);
                webViewCache.trackedItems.put(str, new ItemAndCallback(manifestItem2, webViewCacheCallback));
                return true;
            }
        }
        webViewCacheCallback.pathLoaded(str);
        return false;
    }

    public final void setRootUriInternal() throws Throwable {
        OFLog.e("WebViewCache", "can't use sdcard");
        final File filesDir = this.appContext.getFilesDir();
        rootPath = new File(filesDir, "webui").getAbsolutePath() + "/";
        rootUri = "file://" + rootPath;
        if (new File(filesDir, "webui").isDirectory()) {
            clientManifestReady();
        } else {
            new Thread(new Runnable() { // from class: com.openfeint.internal.ui.WebViewCache.2
                @Override // java.lang.Runnable
                public final void run() throws Throwable {
                    WebViewCache.access$200(WebViewCache.this, filesDir);
                }
            }).start();
        }
    }
}
