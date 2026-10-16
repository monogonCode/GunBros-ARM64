package com.openfeint.internal.ui;

import android.app.AlertDialog;
import android.app.Dialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.SharedPreferences;
import android.content.pm.ApplicationInfo;
import android.content.res.Configuration;
import android.graphics.Bitmap;
import android.net.Uri;
import android.os.Bundle;
import android.view.KeyEvent;
import android.webkit.JsResult;
import android.webkit.WebChromeClient;
import android.webkit.WebView;
import android.webkit.WebViewClient;
import android.widget.ProgressBar;
import android.widget.Toast;
import com.openfeint.api.resource.CurrentUser;
import com.openfeint.api.resource.Score;
import com.openfeint.api.ui.Dashboard;
import com.openfeint.internal.ImagePicker;
import com.openfeint.internal.JsonResourceParser;
import com.openfeint.internal.OpenFeintInternal;
import com.openfeint.internal.RR;
import com.openfeint.internal.Util;
import com.openfeint.internal.logcat.OFLog;
import com.openfeint.internal.request.IRawRequestDelegate;
import com.openfeint.internal.resource.ScoreBlobDelegate;
import com.openfeint.internal.vendor.org.codehaus.jackson.JsonFactory;
import com.tapjoy.TapjoyConstants;
import java.io.StringReader;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import org.json.JSONArray;
import org.json.JSONObject;

/* JADX INFO: loaded from: classes.dex */
public class WebNav extends NestedWindow {
    ActionHandler mActionHandler;
    Dialog mLaunchLoadingView;
    private WebNavClient mWebViewClient;
    protected int pageStackCount;
    boolean mIsPageLoaded = false;
    boolean mIsFrameworkLoaded = false;
    private boolean mShouldRefreshOnResume = true;
    protected ArrayList<String> mPreloadConsoleOutput = new ArrayList<>();
    private Map<String, String> mNativeBrowserParameters = null;

    /* JADX INFO: Access modifiers changed from: protected */
    public class ActionHandler {
        List<String> mActionList = new ArrayList();
        WebNav mWebNav;

        public ActionHandler(WebNav webNav) {
            this.mWebNav = webNav;
            populateActionList(this.mActionList);
        }

        private Map<String, Object> parseQueryString(Uri uri) {
            return parseQueryString(uri.getEncodedQuery());
        }

        private Map<String, Object> parseQueryString(String str) {
            HashMap map = new HashMap();
            if (str != null) {
                for (String str2 : str.split("&")) {
                    String[] strArrSplit = str2.split("=");
                    if (strArrSplit.length == 2) {
                        map.put(strArrSplit[0], Uri.decode(strArrSplit[1]));
                    } else {
                        map.put(strArrSplit[0], null);
                    }
                }
            }
            return map;
        }

        public void alert(Map<String, String> map) {
            AlertDialog.Builder builder = new AlertDialog.Builder(this.mWebNav);
            builder.setTitle(map.get("title"));
            builder.setMessage(map.get("message"));
            builder.setNegativeButton(OpenFeintInternal.getRString(RR.string("of_ok")), (DialogInterface.OnClickListener) null);
            builder.show();
        }

        public void apiRequest(Map<String, String> map) {
            final String str = map.get("request_id");
            OpenFeintInternal.genericRequest(map.get("path"), map.get("method"), parseQueryString(map.get("params")), parseQueryString(map.get("httpParams")), new IRawRequestDelegate() { // from class: com.openfeint.internal.ui.WebNav.ActionHandler.1
                @Override // com.openfeint.internal.request.IRawRequestDelegate
                public void onResponse(int i, String str2) {
                    String strTrim = str2.trim();
                    if (strTrim.length() == 0) {
                        strTrim = "{}";
                    }
                    ActionHandler.this.mWebNav.executeJavascript(String.format("OF.api.completeRequest(\"%s\", \"%d\", %s)", str, Integer.valueOf(i), strTrim));
                }
            });
        }

        public void back(Map<String, String> map) {
            this.mWebNav.fade(false);
            String str = map.get("root");
            if (str != null && !str.equals("false")) {
                this.mWebNav.pageStackCount = 1;
            }
            if (this.mWebNav.pageStackCount > 1) {
                this.mWebNav.pageStackCount--;
            }
        }

        public void contentLoaded(Map<String, String> map) {
            if (map.get("keepLoader") == null || !map.get("keepLoader").equals("true")) {
                hideLoader(null);
                WebNav.this.setTitle(map.get("title"));
            }
            this.mWebNav.fade(true);
            WebNav.this.dismissDialog();
        }

        public void dashboard(Map<String, String> map) {
            Dashboard.openFromSpotlight();
        }

        public void dismiss(Map<String, String> map) {
            WebNav.this.finish();
        }

        public void dispatch(Uri uri) {
            if (!uri.getHost().equals("action")) {
                OFLog.e("WebUI", "UNHANDLED MESSAGE TYPE: " + uri.getHost());
                return;
            }
            Map<String, Object> queryString = parseQueryString(uri);
            String strReplaceFirst = uri.getPath().replaceFirst("/", "");
            if (!strReplaceFirst.equals("log")) {
                HashMap map = new HashMap(queryString);
                String str = (String) queryString.get("params");
                if (str != null && str.contains("password")) {
                    map.put("params", "---FILTERED---");
                }
                OFLog.i("WebUI", "ACTION: " + strReplaceFirst + " " + map.toString());
            }
            if (!this.mActionList.contains(strReplaceFirst)) {
                OFLog.e("WebUI", "UNHANDLED ACTION: " + strReplaceFirst);
                return;
            }
            try {
                getClass().getMethod(strReplaceFirst, Map.class).invoke(this, queryString);
            } catch (NoSuchMethodException e) {
                OFLog.e("WebUI", "mActionList contains this method, but it is not implemented: " + strReplaceFirst);
            } catch (Exception e2) {
                OFLog.e("WebUI", "Unhandled Exception: " + e2.toString() + "   " + e2.getCause());
            }
        }

        public void downloadBlob(Map<String, String> map) {
            String str = map.get("score");
            final String str2 = map.get("onError");
            final String str3 = map.get("onSuccess");
            try {
                Object obj = new JsonResourceParser(new JsonFactory((byte) 0).createJsonParser(new StringReader(str))).parse();
                if (obj == null || !(obj instanceof Score)) {
                    return;
                }
                final Score score = (Score) obj;
                score.downloadBlob(new Score.DownloadBlobCB() { // from class: com.openfeint.internal.ui.WebNav.ActionHandler.3
                    @Override // com.openfeint.internal.APICallback
                    public void onFailure(String str4) {
                        if (str2 != null) {
                            WebNav.this.executeJavascript(String.format("%s(%s)", str2, str4));
                        }
                    }

                    @Override // com.openfeint.api.resource.Score.DownloadBlobCB
                    public void onSuccess() {
                        if (str3 != null) {
                            WebNav.this.executeJavascript(String.format("%s()", str3));
                        }
                        ScoreBlobDelegate.notifyBlobDownloaded(score);
                    }
                });
            } catch (Exception e) {
                if (str2 != null) {
                    WebNav.this.executeJavascript(String.format("%s(%s)", str2, e.getLocalizedMessage()));
                }
            }
        }

        protected List<String> getActionList() {
            return this.mActionList;
        }

        public void hideLoader(Map<String, String> map) {
        }

        public void isApplicationInstalled(Map<String, String> map) {
            List<ApplicationInfo> installedApplications = this.mWebNav.getPackageManager().getInstalledApplications(0);
            String str = map.get("package_name");
            Iterator<ApplicationInfo> it = installedApplications.iterator();
            boolean z = false;
            while (it.hasNext()) {
                z = it.next().packageName.equals(str) ? true : z;
            }
            WebNav webNav = WebNav.this;
            Object[] objArr = new Object[2];
            objArr[0] = map.get("callback");
            objArr[1] = z ? "true" : "false";
            webNav.executeJavascript(String.format("%s(%s)", objArr));
        }

        public void log(Map<String, String> map) {
            if (map.get("message") != null) {
                OFLog.i("WebUI", "WEBLOG: " + map.get("message"));
            }
        }

        public void openBrowser(Map<String, String> map) {
            Intent intent = new Intent(this.mWebNav, (Class<?>) NativeBrowser.class);
            WebNav.this.mNativeBrowserParameters = new HashMap();
            for (String str : new String[]{"src", "callback", "on_cancel", "on_failure", "timeout"}) {
                String str2 = map.get(str);
                if (str2 != null) {
                    WebNav.this.mNativeBrowserParameters.put(str, str2);
                    intent.putExtra("com.openfeint.internal.ui.NativeBrowser.argument." + str, str2);
                }
            }
            WebNav.this.startActivityForResult(intent, 25565);
        }

        public void openMarket(Map<String, String> map) {
            this.mWebNav.startActivity(new Intent("android.intent.action.VIEW", Uri.parse("market://details?id=" + map.get("package_name"))));
        }

        public void openYoutubePlayer(Map<String, String> map) {
            Intent intent = new Intent("android.intent.action.VIEW", Uri.parse("vnd.youtube:" + map.get("video_id")));
            if (WebNav.this.getPackageManager().queryIntentActivities(intent, 65536).size() == 0) {
                Toast.makeText(this.mWebNav, OpenFeintInternal.getRString(RR.string("of_no_video")), 0).show();
            } else {
                this.mWebNav.startActivity(intent);
            }
        }

        protected void populateActionList(List<String> list) {
            list.add("log");
            list.add("apiRequest");
            list.add("contentLoaded");
            list.add("startLoading");
            list.add("back");
            list.add("showLoader");
            list.add("hideLoader");
            list.add("alert");
            list.add("dismiss");
            list.add("openMarket");
            list.add("isApplicationInstalled");
            list.add("openYoutubePlayer");
            list.add("profilePicture");
            list.add("openBrowser");
            list.add("downloadBlob");
            list.add("dashboard");
            list.add("readSetting");
            list.add("writeSetting");
            list.add("setParentalControlsEnabled");
        }

        public final void profilePicture(Map<String, String> map) {
            ImagePicker.show(WebNav.this);
        }

        public void readSetting(Map<String, String> map) {
            String str = map.get("key");
            String str2 = map.get("callback");
            if (str2 != null) {
                String string = OpenFeintInternal.getInstance().getContext().getSharedPreferences("OFWebUI", 0).getString(str != null ? "OFWebUISetting_" + str : null, null);
                OFLog.i("WebUI", String.format("readSetting(%s) => %s", str, string));
                WebNav webNav = WebNav.this;
                Object[] objArr = new Object[2];
                objArr[0] = str2;
                objArr[1] = string != null ? string : "null";
                webNav.executeJavascript(String.format("%s(%s)", objArr));
            }
        }

        public void setParentalControlsEnabled(Map<String, String> map) {
            OpenFeintInternal.getInstance().setParentalControlsEnabled("true".equals(map.get("parentalControlsEnabled")));
        }

        public void showLoader(Map<String, String> map) {
        }

        public void startLoading(Map<String, String> map) {
            this.mWebNav.fade(false);
            showLoader(null);
            WebViewCache.trackPath(map.get("path"), new WebViewCacheCallback() { // from class: com.openfeint.internal.ui.WebNav.ActionHandler.2
                @Override // com.openfeint.internal.ui.WebViewCacheCallback
                public void failLoaded() {
                    WebNav.this.closeForDiskError();
                }

                @Override // com.openfeint.internal.ui.WebViewCacheCallback
                public void onTrackingNeeded() {
                    WebNav.this.showDialog();
                }

                @Override // com.openfeint.internal.ui.WebViewCacheCallback
                public void pathLoaded(String str) {
                    WebNav.this.executeJavascript("OF.navigateToUrlCallback()");
                }
            });
            this.mWebNav.pageStackCount++;
        }

        public void writeSetting(Map<String, String> map) {
            String str = map.get("key");
            String str2 = map.get("value");
            if (str == null || str2 == null) {
                return;
            }
            SharedPreferences.Editor editorEdit = OpenFeintInternal.getInstance().getContext().getSharedPreferences("OFWebUI", 0).edit();
            editorEdit.putString("OFWebUISetting_" + str, str2);
            editorEdit.commit();
        }
    }

    private class WebNavChromeClient extends WebChromeClient {
        private WebNavChromeClient() {
        }

        @Override // android.webkit.WebChromeClient
        public void onConsoleMessage(String str, int i, String str2) {
            if (WebNav.this.mIsFrameworkLoaded) {
                return;
            }
            WebNav.this.mPreloadConsoleOutput.add(String.format("%s at %s:%d)", str, str2, Integer.valueOf(i)));
        }

        @Override // android.webkit.WebChromeClient
        public boolean onJsAlert(WebView webView, String str, String str2, final JsResult jsResult) {
            new AlertDialog.Builder(webView.getContext()).setMessage(str2).setNegativeButton(OpenFeintInternal.getRString(RR.string("of_ok")), new DialogInterface.OnClickListener() { // from class: com.openfeint.internal.ui.WebNav.WebNavChromeClient.2
                @Override // android.content.DialogInterface.OnClickListener
                public void onClick(DialogInterface dialogInterface, int i) {
                    jsResult.cancel();
                }
            }).setOnCancelListener(new DialogInterface.OnCancelListener() { // from class: com.openfeint.internal.ui.WebNav.WebNavChromeClient.1
                @Override // android.content.DialogInterface.OnCancelListener
                public void onCancel(DialogInterface dialogInterface) {
                    jsResult.cancel();
                }
            }).show();
            return true;
        }

        @Override // android.webkit.WebChromeClient
        public boolean onJsConfirm(WebView webView, String str, String str2, final JsResult jsResult) {
            new AlertDialog.Builder(webView.getContext()).setMessage(str2).setPositiveButton(OpenFeintInternal.getRString(RR.string("of_ok")), new DialogInterface.OnClickListener() { // from class: com.openfeint.internal.ui.WebNav.WebNavChromeClient.5
                @Override // android.content.DialogInterface.OnClickListener
                public void onClick(DialogInterface dialogInterface, int i) {
                    jsResult.confirm();
                }
            }).setNegativeButton(OpenFeintInternal.getRString(RR.string("of_cancel")), new DialogInterface.OnClickListener() { // from class: com.openfeint.internal.ui.WebNav.WebNavChromeClient.4
                @Override // android.content.DialogInterface.OnClickListener
                public void onClick(DialogInterface dialogInterface, int i) {
                    jsResult.cancel();
                }
            }).setOnCancelListener(new DialogInterface.OnCancelListener() { // from class: com.openfeint.internal.ui.WebNav.WebNavChromeClient.3
                @Override // android.content.DialogInterface.OnCancelListener
                public void onCancel(DialogInterface dialogInterface) {
                    jsResult.cancel();
                }
            }).show();
            return true;
        }
    }

    protected class WebNavClient extends WebViewClient {
        ActionHandler mActionHandler;

        public WebNavClient(ActionHandler actionHandler) {
            this.mActionHandler = actionHandler;
        }

        protected void attemptRecovery(WebView webView, String str) {
            if (WebViewCache.recover()) {
                WebNav.this.load(true);
                new AlertDialog.Builder(webView.getContext()).setMessage(OpenFeintInternal.getRString(RR.string("of_crash_report_query"))).setNegativeButton(OpenFeintInternal.getRString(RR.string("of_no")), new DialogInterface.OnClickListener() { // from class: com.openfeint.internal.ui.WebNav.WebNavClient.2
                    @Override // android.content.DialogInterface.OnClickListener
                    public void onClick(DialogInterface dialogInterface, int i) {
                        WebNav.this.finish();
                    }
                }).setPositiveButton(OpenFeintInternal.getRString(RR.string("of_yes")), new DialogInterface.OnClickListener() { // from class: com.openfeint.internal.ui.WebNav.WebNavClient.1
                    @Override // android.content.DialogInterface.OnClickListener
                    public void onClick(DialogInterface dialogInterface, int i) {
                        WebNavClient.this.submitCrashReport();
                    }
                }).show();
            } else {
                if (WebViewCache.isDiskError()) {
                    return;
                }
                WebNav.this.finish();
            }
        }

        public void loadInitialContent() {
            OpenFeintInternal openFeintInternal = OpenFeintInternal.getInstance();
            CurrentUser currentUser = openFeintInternal.getCurrentUser();
            int i = WebNav.this.getResources().getConfiguration().orientation;
            HashMap map = new HashMap();
            if (currentUser != null) {
                map.put("id", currentUser.resourceID());
                map.put("name", currentUser.name);
            }
            HashMap map2 = new HashMap();
            map2.put("id", openFeintInternal.getAppID());
            map2.put("name", openFeintInternal.getAppName());
            map2.put("version", Integer.toString(openFeintInternal.getAppVersion()));
            Map<String, Object> deviceParams = OpenFeintInternal.getInstance().getDeviceParams();
            deviceParams.put("parentalControls", Boolean.valueOf(OpenFeintInternal.getInstance().parentalControlsEnabled()));
            HashMap map3 = new HashMap();
            map3.put(TapjoyConstants.TJC_PLATFORM, TapjoyConstants.TJC_DEVICE_PLATFORM_TYPE);
            map3.put("clientVersion", openFeintInternal.getOFVersion());
            map3.put("hasNativeInterface", true);
            map3.put("dpi", Util.getDpiName(WebNav.this));
            map3.put("locale", WebNav.this.getResources().getConfiguration().locale.toString());
            map3.put("user", new JSONObject(map));
            map3.put("game", new JSONObject(map2));
            map3.put("device", new JSONObject(deviceParams));
            map3.put("actions", new JSONArray((Collection) WebNav.this.getActionHandler().getActionList()));
            map3.put("orientation", i == 2 ? "landscape" : "portrait");
            map3.put("serverUrl", openFeintInternal.getServerUrl());
            WebNav.this.executeJavascript(String.format("OF.init.clientBoot(%s)", new JSONObject(map3).toString()));
            this.mActionHandler.mWebNav.loadInitialContent();
        }

        @Override // android.webkit.WebViewClient
        public void onPageFinished(WebView webView, String str) {
            if (WebNav.this.mIsPageLoaded) {
                return;
            }
            WebNav.this.mIsPageLoaded = true;
            if (WebNav.this.mIsFrameworkLoaded) {
                loadInitialContent();
            } else {
                attemptRecovery(webView, str);
            }
        }

        @Override // android.webkit.WebViewClient
        public void onReceivedError(WebView webView, int i, String str, String str2) {
            this.mActionHandler.hideLoader(null);
        }

        @Override // android.webkit.WebViewClient
        public boolean shouldOverrideUrlLoading(WebView webView, String str) {
            Uri uri = Uri.parse(str);
            if (uri.getScheme().equals("http") || uri.getScheme().equals("https")) {
                webView.loadUrl(str);
                return true;
            }
            if (uri.getScheme().equals("openfeint")) {
                this.mActionHandler.dispatch(uri);
                return true;
            }
            OFLog.e("WebUI", "UNHANDLED PROTOCOL: " + uri.getScheme());
            return true;
        }

        protected void submitCrashReport() {
            HashMap map = new HashMap();
            map.put("console", new JSONArray((Collection) WebNav.this.mPreloadConsoleOutput));
            JSONObject jSONObject = new JSONObject(map);
            HashMap map2 = new HashMap();
            map2.put("crash_report", jSONObject.toString());
            OpenFeintInternal.genericRequest("/webui/crash_report", "POST", map2, null, null);
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void closeForDiskError() {
        runOnUiThread(new Runnable() { // from class: com.openfeint.internal.ui.WebNav.4
            @Override // java.lang.Runnable
            public void run() {
                WebNav.this.dismissDialog();
                new AlertDialog.Builder(WebNav.this).setMessage(String.format(OpenFeintInternal.getRString(RR.string("of_nodisk")), Util.sdcardReady(WebNav.this) ? OpenFeintInternal.getRString(RR.string("of_sdcard")) : OpenFeintInternal.getRString(RR.string("of_device")))).setPositiveButton(OpenFeintInternal.getRString(RR.string("of_no")), new DialogInterface.OnClickListener() { // from class: com.openfeint.internal.ui.WebNav.4.1
                    @Override // android.content.DialogInterface.OnClickListener
                    public void onClick(DialogInterface dialogInterface, int i) {
                        WebNav.this.finish();
                    }
                }).show();
            }
        });
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void dismissDialog() {
        if (this.mLaunchLoadingView.isShowing()) {
            this.mLaunchLoadingView.dismiss();
        }
    }

    private static final String jsQuotedStringLiteral(String str) {
        return str == null ? "''" : "'" + str.replace("\\", "\\\\").replace("'", "\\'") + "'";
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void showDialog() {
        if (this.mLaunchLoadingView.isShowing()) {
            return;
        }
        this.mLaunchLoadingView.show();
    }

    protected ActionHandler createActionHandler(WebNav webNav) {
        return new ActionHandler(webNav);
    }

    protected WebNavClient createWebNavClient(ActionHandler actionHandler) {
        return new WebNavClient(actionHandler);
    }

    public void executeJavascript(String str) {
        if (this.mWebView != null) {
            this.mWebView.loadUrl("javascript:" + str);
        }
    }

    public ActionHandler getActionHandler() {
        return this.mActionHandler;
    }

    public Dialog getLaunchLoadingView() {
        return this.mLaunchLoadingView;
    }

    protected String initialContentPath() {
        String stringExtra = getIntent().getStringExtra("content_path");
        if (stringExtra == null) {
            throw new RuntimeException("WebNav intent requires extra value 'content_path'");
        }
        return stringExtra;
    }

    protected void load(final boolean z) {
        this.mIsPageLoaded = false;
        WebViewCache.trackPath(rootPage(), new WebViewCacheCallback() { // from class: com.openfeint.internal.ui.WebNav.3
            @Override // com.openfeint.internal.ui.WebViewCacheCallback
            public void failLoaded() {
                WebNav.this.closeForDiskError();
            }

            @Override // com.openfeint.internal.ui.WebViewCacheCallback
            public void pathLoaded(String str) {
                if (WebNav.this.mWebView != null) {
                    String itemUri = WebViewCache.getItemUri(str);
                    OFLog.i("WebUI", "Loading URL: " + itemUri);
                    if (z) {
                        WebNav.this.mWebView.reload();
                    } else {
                        WebNav.this.mWebView.loadUrl(itemUri);
                    }
                }
            }
        });
    }

    public void loadInitialContent() {
        String strInitialContentPath = initialContentPath();
        if (strInitialContentPath.contains("?")) {
            strInitialContentPath = strInitialContentPath.split("\\?")[0];
        }
        if (!strInitialContentPath.endsWith(".json")) {
            strInitialContentPath = strInitialContentPath + ".json";
        }
        WebViewCache.trackPath(strInitialContentPath, new WebViewCacheCallback() { // from class: com.openfeint.internal.ui.WebNav.5
            @Override // com.openfeint.internal.ui.WebViewCacheCallback
            public void failLoaded() {
                WebNav.this.closeForDiskError();
            }

            @Override // com.openfeint.internal.ui.WebViewCacheCallback
            public void pathLoaded(String str) {
                WebNav.this.executeJavascript("OF.navigateToUrl('" + WebNav.this.initialContentPath() + "')");
            }
        });
    }

    @Override // android.app.Activity
    protected void onActivityResult(int i, int i2, Intent intent) {
        Bitmap bitmapOnImagePickerActivityResult$1de9c2be;
        super.onActivityResult(i, i2, intent);
        if (this.mNativeBrowserParameters == null || i != 25565) {
            if (!ImagePicker.isImagePickerActivityResult(i) || (bitmapOnImagePickerActivityResult$1de9c2be = ImagePicker.onImagePickerActivityResult$1de9c2be(this, i2, intent)) == null) {
                return;
            }
            ImagePicker.compressAndUpload(bitmapOnImagePickerActivityResult$1de9c2be, "/xp/users/" + OpenFeintInternal.getInstance().getCurrentUser().resourceID() + "/profile_picture", new OpenFeintInternal.IUploadDelegate() { // from class: com.openfeint.internal.ui.WebNav.6
                @Override // com.openfeint.internal.OpenFeintInternal.IUploadDelegate
                public void fileUploadedTo(String str, boolean z) {
                    if (z) {
                        WebNav.this.executeJavascript("try { OF.page.onProfilePictureChanged('" + str + "'); } catch (e) {}");
                    }
                }
            });
            return;
        }
        if (i2 != 0) {
            this.mShouldRefreshOnResume = false;
            if (intent.getBooleanExtra("com.openfeint.internal.ui.NativeBrowser.argument.failed", false)) {
                String str = this.mNativeBrowserParameters.get("on_failure");
                if (str != null) {
                    executeJavascript(String.format("%s(%d, %s)", str, Integer.valueOf(intent.getIntExtra("com.openfeint.internal.ui.NativeBrowser.argument.failure_code", 0)), jsQuotedStringLiteral(intent.getStringExtra("com.openfeint.internal.ui.NativeBrowser.argument.failure_desc"))));
                }
            } else {
                String str2 = this.mNativeBrowserParameters.get("callback");
                if (str2 != null) {
                    String stringExtra = intent.getStringExtra("com.openfeint.internal.ui.NativeBrowser.argument.result");
                    Object[] objArr = new Object[2];
                    objArr[0] = str2;
                    objArr[1] = stringExtra != null ? stringExtra : "";
                    executeJavascript(String.format("%s(%s)", objArr));
                }
            }
        } else {
            String str3 = this.mNativeBrowserParameters.get("on_cancel");
            if (str3 != null) {
                executeJavascript(String.format("%s()", str3));
            }
        }
        this.mNativeBrowserParameters = null;
    }

    @Override // com.openfeint.internal.ui.NestedWindow, android.app.Activity, android.content.ComponentCallbacks
    public void onConfigurationChanged(Configuration configuration) {
        super.onConfigurationChanged(configuration);
        executeJavascript(String.format("OF.setOrientation('%s');", configuration.orientation == 2 ? "landscape" : "portrait"));
    }

    @Override // com.openfeint.internal.ui.NestedWindow, android.app.Activity
    public void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        OFLog.i("WebUI", "--- WebUI Bootup ---");
        this.pageStackCount = 0;
        this.mWebView.getSettings().setJavaScriptEnabled(true);
        this.mWebView.getSettings().setPluginsEnabled(false);
        this.mWebView.setScrollBarStyle(33554432);
        this.mWebView.getSettings().setCacheMode(2);
        this.mLaunchLoadingView = new Dialog(this, RR.style("OFLoading"));
        this.mLaunchLoadingView.setOnCancelListener(new DialogInterface.OnCancelListener() { // from class: com.openfeint.internal.ui.WebNav.1
            @Override // android.content.DialogInterface.OnCancelListener
            public void onCancel(DialogInterface dialogInterface) {
                WebNav.this.finish();
            }
        });
        this.mLaunchLoadingView.setCancelable(true);
        this.mLaunchLoadingView.setContentView(RR.layout("of_native_loader"));
        ProgressBar progressBar = (ProgressBar) this.mLaunchLoadingView.findViewById(RR.id("progress"));
        progressBar.setIndeterminate(true);
        progressBar.setIndeterminateDrawable(OpenFeintInternal.getInstance().getContext().getResources().getDrawable(RR.drawable("of_native_loader_progress")));
        this.mActionHandler = createActionHandler(this);
        this.mWebViewClient = createWebNavClient(this.mActionHandler);
        this.mWebView.setWebViewClient(this.mWebViewClient);
        this.mWebView.setWebChromeClient(new WebNavChromeClient());
        this.mWebView.addJavascriptInterface(new Object() { // from class: com.openfeint.internal.ui.WebNav.2
            public void action(final String str) {
                WebNav.this.runOnUiThread(new Runnable() { // from class: com.openfeint.internal.ui.WebNav.2.1
                    @Override // java.lang.Runnable
                    public void run() {
                        WebNav.this.getActionHandler().dispatch(Uri.parse(str));
                    }
                });
            }

            public void frameworkLoaded() {
                WebNav.this.setFrameworkLoaded(true);
            }
        }, "NativeInterface");
        String strInitialContentPath = initialContentPath();
        if (strInitialContentPath.contains("?")) {
            strInitialContentPath = strInitialContentPath.split("\\?")[0];
        }
        if (!strInitialContentPath.endsWith(".json")) {
            strInitialContentPath = strInitialContentPath + ".json";
        }
        WebViewCache.prioritize(strInitialContentPath);
        load(false);
        this.mLaunchLoadingView.show();
    }

    @Override // android.app.Activity
    public void onDestroy() {
        this.mWebView.destroy();
        this.mWebView = null;
        super.onDestroy();
    }

    @Override // android.app.Activity, android.view.KeyEvent.Callback
    public boolean onKeyDown(int i, KeyEvent keyEvent) {
        if (i == 84) {
            executeJavascript(String.format("OF.menu('%s')", "search"));
            return true;
        }
        if (i != 4 || this.pageStackCount <= 1) {
            return super.onKeyDown(i, keyEvent);
        }
        executeJavascript("OF.goBack()");
        return true;
    }

    @Override // android.app.Activity
    protected void onRestoreInstanceState(Bundle bundle) {
        OpenFeintInternal.restoreInstanceState(bundle);
    }

    @Override // android.app.Activity
    public void onResume() {
        super.onResume();
        CurrentUser currentUser = OpenFeintInternal.getInstance().getCurrentUser();
        if (currentUser != null && this.mIsFrameworkLoaded) {
            executeJavascript(String.format("if (OF.user) { OF.user.name = %s; OF.user.id = '%s'; }", jsQuotedStringLiteral(currentUser.name), currentUser.resourceID()));
            if (this.mShouldRefreshOnResume) {
                executeJavascript("if (OF.page) OF.refresh();");
            }
        }
        this.mShouldRefreshOnResume = true;
    }

    @Override // android.app.Activity
    protected void onSaveInstanceState(Bundle bundle) {
        OpenFeintInternal.saveInstanceState(bundle);
    }

    @Override // android.app.Activity
    public void onStop() {
        super.onStop();
        dismissDialog();
    }

    @Override // android.app.Activity, android.view.Window.Callback
    public void onWindowFocusChanged(boolean z) {
        super.onWindowFocusChanged(z);
        OpenFeintInternal.getInstance().getDelegate();
    }

    protected String rootPage() {
        return "index.html";
    }

    protected void setFrameworkLoaded(boolean z) {
        this.mIsFrameworkLoaded = z;
    }
}
