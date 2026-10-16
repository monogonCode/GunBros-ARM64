package com.openfeint.internal;

import android.content.Context;
import android.content.Intent;
import android.content.pm.ActivityInfo;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.content.res.Resources;
import android.content.res.XmlResourceParser;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;
import android.os.Build;
import android.os.Bundle;
import android.os.Handler;
import android.provider.Settings;
import android.util.DisplayMetrics;
import android.util.Log;
import android.webkit.CookieManager;
import com.openfeint.api.Notification;
import com.openfeint.api.OpenFeintDelegate;
import com.openfeint.api.OpenFeintSettings;
import com.openfeint.api.resource.CurrentUser;
import com.openfeint.api.resource.User;
import com.openfeint.internal.analytics.AnalyticsManager;
import com.openfeint.internal.db.DB;
import com.openfeint.internal.eventlog.EventLogDispatcher;
import com.openfeint.internal.eventlog.SDKEventListener;
import com.openfeint.internal.logcat.OFLog;
import com.openfeint.internal.notifications.SimpleNotification;
import com.openfeint.internal.notifications.TwoLineNotification;
import com.openfeint.internal.offline.OfflineSupport;
import com.openfeint.internal.request.BaseRequest;
import com.openfeint.internal.request.BlobPostRequest;
import com.openfeint.internal.request.Client;
import com.openfeint.internal.request.GenericRequest;
import com.openfeint.internal.request.IRawRequestDelegate;
import com.openfeint.internal.request.JSONRequest;
import com.openfeint.internal.request.OrderedArgList;
import com.openfeint.internal.request.RawRequest;
import com.openfeint.internal.request.multipart.PartSource;
import com.openfeint.internal.resource.BlobUploadParameters;
import com.openfeint.internal.resource.Device;
import com.openfeint.internal.resource.ServerException;
import com.openfeint.internal.ui.IntroFlow;
import com.openfeint.internal.ui.WebViewCache;
import com.openfeint.internal.vendor.org.apache.commons.codec.binary.Hex;
import com.openfeint.internal.vendor.org.codehaus.jackson.JsonFactory;
import com.tapjoy.TapjoyConstants;
import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.Random;
import java.util.UUID;
import org.apache.http.impl.client.AbstractHttpClient;

/* JADX INFO: loaded from: classes.dex */
public final class OpenFeintInternal {
    private static String createUserSource;
    private static OpenFeintInternal sInstance;
    private static String userEnableSource;
    int mAppVersion = -1;
    private boolean mApproved;
    private boolean mBanned;
    Client mClient;
    private Context mContext;
    private boolean mCreatingDeviceSession;
    private CurrentUser mCurrentUser;
    private boolean mCurrentlyLoggingIn;
    private boolean mDeclined;
    OpenFeintDelegate mDelegate;
    private boolean mDeserializedAlready;
    private boolean mDeviceSessionCreated;
    private String mGSDI;
    Properties mInternalProperties;
    private LoginDelegate mLoginDelegate;
    Handler mMainThreadHandler;
    private boolean mParentalControlsEnabled;
    private Runnable mPostDeviceSessionRunnable;
    private Runnable mPostLoginRunnable;
    private SyncedStore mPrefs;
    private List<Runnable> mQueuedPostDeviceSessionRunnables;
    private List<Runnable> mQueuedPostLoginRunnables;
    String mServerUrl;
    private String mSessionID;
    private Date mSessionStartDate;
    OpenFeintSettings mSettings;
    private String mUDID;

    public interface IUploadDelegate {
        void fileUploadedTo(String str, boolean z);
    }

    public interface LoginDelegate {
    }

    private OpenFeintInternal(OpenFeintSettings openFeintSettings, Context context) {
        sInstance = this;
        this.mContext = context;
        this.mSettings = openFeintSettings;
        this.mSessionStartDate = new Date();
        this.mSessionID = UUID.randomUUID().toString();
        SyncedStore.Reader reader = getPrefs().read();
        try {
            this.mDeclined = reader.getString(new StringBuilder().append(this.mContext.getPackageName()).append(".of_declined").toString(), null) != null;
            reader.complete();
            this.mMainThreadHandler = new Handler();
            this.mInternalProperties = new Properties();
            this.mInternalProperties.put("server-url", "https://api.openfeint.com");
            this.mInternalProperties.put("ad-server-url", "http://ads.openfeint.com");
            this.mInternalProperties.put("of-version", "1.10.2");
            loadPropertiesFromXMLResource(this.mInternalProperties, getResource("@xml/openfeint_internal_settings"));
            Log.i("OpenFeintInternal", "Using OpenFeint version " + this.mInternalProperties.get("of-version") + " (" + this.mInternalProperties.get("server-url") + ")");
            Properties properties = new Properties();
            loadPropertiesFromXMLResource(properties, getResource("@xml/openfeint_app_settings"));
            this.mSettings.applyOverrides(properties);
            this.mSettings.verify();
            if (!Encryption.initialized()) {
                Encryption.init(this.mSettings.secret);
            }
            this.mClient = new Client(this.mSettings.key, this.mSettings.secret, getPrefs());
            Util.moveWebCache(context);
            WebViewCache.initialize(context);
            DB.createDB(context);
            WebViewCache.start();
            OFLog.w("OpenFeintInternal", "init EventDispacherSystem");
            SDKEventListener sDKEventListener = new SDKEventListener();
            EventLogDispatcher.getInstance().subscribe("prompt_enable_of.openfeint.com", sDKEventListener);
            EventLogDispatcher.getInstance().subscribe("accepted_of.openfeint.com", sDKEventListener);
            EventLogDispatcher.getInstance().subscribe("declined_of.openfeint.com", sDKEventListener);
            EventLogDispatcher.getInstance().subscribe("enabled_of.openfeint.com", sDKEventListener);
            EventLogDispatcher.getInstance().subscribe("new_user.openfeint.com", sDKEventListener);
            EventLogDispatcher.getInstance().subscribe("dashboard_start.openfeint.com", sDKEventListener);
            EventLogDispatcher.getInstance().subscribe("dashboard_end.openfeint.com", sDKEventListener);
            EventLogDispatcher.getInstance().subscribe("game_start.openfeint.com", sDKEventListener);
            EventLogDispatcher.getInstance().subscribe("game_background.openfeint.com", sDKEventListener);
            EventLogDispatcher.getInstance().subscribe("game_foreground.openfeint.com", sDKEventListener);
            EventLogDispatcher.getInstance().subscribe("game_exit.openfeint.com", sDKEventListener);
            AnalyticsManager.instance(this.mContext);
        } catch (Throwable th) {
            reader.complete();
            throw th;
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public final void _makeRequest(final BaseRequest baseRequest) {
        if (!isUserLoggedIn() && baseRequest.wantsLogin() && lastLoggedInUser() != null && isFeintServerReachable()) {
            login(false);
            if (this.mQueuedPostLoginRunnables == null) {
                this.mQueuedPostLoginRunnables = new ArrayList();
            }
            this.mQueuedPostLoginRunnables.add(new Runnable() { // from class: com.openfeint.internal.OpenFeintInternal.7
                @Override // java.lang.Runnable
                public final void run() {
                    OpenFeintInternal.this.mClient.makeRequest(baseRequest);
                }
            });
            return;
        }
        if (this.mDeviceSessionCreated || !baseRequest.needsDeviceSession()) {
            this.mClient.makeRequest(baseRequest);
            return;
        }
        createDeviceSession();
        if (this.mQueuedPostDeviceSessionRunnables == null) {
            this.mQueuedPostDeviceSessionRunnables = new ArrayList();
        }
        this.mQueuedPostDeviceSessionRunnables.add(new Runnable() { // from class: com.openfeint.internal.OpenFeintInternal.8
            @Override // java.lang.Runnable
            public final void run() {
                OpenFeintInternal.this.mClient.makeRequest(baseRequest);
            }
        });
    }

    static /* synthetic */ void access$100(OpenFeintInternal openFeintInternal, User user) throws Throwable {
        openFeintInternal.mCurrentUser = new CurrentUser();
        openFeintInternal.mCurrentUser.shallowCopyAncestorType(user);
        EventLogDispatcher.getInstance().postEvent("login_success.openfeint.com", null);
        User userLastLoggedInUser = openFeintInternal.lastLoggedInUser();
        if (userLastLoggedInUser == null || !userLastLoggedInUser.resourceID().equals(user.resourceID())) {
            CookieManager.getInstance().removeAllCookie();
        }
        SyncedStore.Editor editorEdit = openFeintInternal.getPrefs().edit();
        try {
            editorEdit.putString("last_logged_in_server", openFeintInternal.getServerUrl());
            editorEdit.remove(openFeintInternal.mContext.getPackageName() + ".of_declined");
            editorEdit.putString("last_logged_in_user", user.generate());
            editorEdit.commit();
            if (openFeintInternal.mDelegate != null) {
                OpenFeintDelegate openFeintDelegate = openFeintInternal.mDelegate;
                CurrentUser currentUser = openFeintInternal.mCurrentUser;
            }
            if (openFeintInternal.mLoginDelegate != null) {
                LoginDelegate loginDelegate = openFeintInternal.mLoginDelegate;
                CurrentUser currentUser2 = openFeintInternal.mCurrentUser;
            }
            if (openFeintInternal.mPostLoginRunnable != null) {
                openFeintInternal.mMainThreadHandler.post(openFeintInternal.mPostLoginRunnable);
                openFeintInternal.mPostLoginRunnable = null;
            }
            OfflineSupport.setUserID(user.resourceID());
        } catch (Throwable th) {
            editorEdit.commit();
            throw th;
        }
    }

    static /* synthetic */ List access$1002$207cf26(OpenFeintInternal openFeintInternal) {
        openFeintInternal.mQueuedPostLoginRunnables = null;
        return null;
    }

    static /* synthetic */ boolean access$1302$78278a84(OpenFeintInternal openFeintInternal) {
        openFeintInternal.mDeserializedAlready = true;
        return true;
    }

    static /* synthetic */ boolean access$1502$78278a84(OpenFeintInternal openFeintInternal) {
        openFeintInternal.mBanned = true;
        return true;
    }

    static /* synthetic */ boolean access$202$78278a84(OpenFeintInternal openFeintInternal) {
        openFeintInternal.mCreatingDeviceSession = false;
        return false;
    }

    static /* synthetic */ boolean access$402$78278a84(OpenFeintInternal openFeintInternal) {
        openFeintInternal.mDeviceSessionCreated = true;
        return true;
    }

    static /* synthetic */ Runnable access$502$5f63a5fa(OpenFeintInternal openFeintInternal) {
        openFeintInternal.mPostDeviceSessionRunnable = null;
        return null;
    }

    static /* synthetic */ Runnable access$602$5f63a5fa(OpenFeintInternal openFeintInternal) {
        openFeintInternal.mPostLoginRunnable = null;
        return null;
    }

    static /* synthetic */ List access$802$207cf26(OpenFeintInternal openFeintInternal) {
        openFeintInternal.mQueuedPostDeviceSessionRunnables = null;
        return null;
    }

    static /* synthetic */ boolean access$902$78278a84(OpenFeintInternal openFeintInternal) {
        openFeintInternal.mCurrentlyLoggingIn = false;
        return false;
    }

    private static List<String> cat(String str) {
        ArrayList arrayList = new ArrayList();
        try {
            BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(new FileInputStream(str)), 8192);
            while (true) {
                String line = bufferedReader.readLine();
                if (line == null) {
                    break;
                }
                arrayList.add(line);
            }
            bufferedReader.close();
        } catch (Exception e) {
        }
        return arrayList;
    }

    private boolean checkBan() {
        if (!this.mBanned) {
            return false;
        }
        displayErrorDialog(this.mContext.getText(RR.string("of_banned_dialog")));
        return true;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void clearPrefs() throws Throwable {
        SyncedStore.Editor editorEdit = getPrefs().edit();
        try {
            editorEdit.remove("last_logged_in_server");
            editorEdit.remove("last_logged_in_user_name");
            editorEdit.remove("last_logged_in_user");
        } finally {
            editorEdit.commit();
        }
    }

    private void createDeviceSession() {
        if (this.mCreatingDeviceSession || this.mDeviceSessionCreated) {
            return;
        }
        HashMap map = new HashMap();
        map.put(TapjoyConstants.TJC_PLATFORM, TapjoyConstants.TJC_DEVICE_PLATFORM_TYPE);
        map.put("device", getDeviceParams());
        map.put("of-version", getOFVersion());
        map.put("game_version", Integer.toString(getAppVersion()));
        map.put("protocol_version", "1.0");
        map.put("gsdi", getGSDI());
        OrderedArgList orderedArgList = new OrderedArgList(map);
        this.mCreatingDeviceSession = true;
        _makeRequest(new RawRequest(orderedArgList) { // from class: com.openfeint.internal.OpenFeintInternal.2
            @Override // com.openfeint.internal.request.BaseRequest
            public final String method() {
                return "POST";
            }

            @Override // com.openfeint.internal.request.BaseRequest
            public final boolean needsDeviceSession() {
                return false;
            }

            @Override // com.openfeint.internal.request.JSONRequest
            public final void onResponse(int i, Object obj) {
                OpenFeintInternal.access$202$78278a84(OpenFeintInternal.this);
                if (200 > i || i >= 300) {
                    OpenFeintInternal.access$602$5f63a5fa(OpenFeintInternal.this);
                    OpenFeintInternal.this.showOfflineNotification(i, obj);
                } else {
                    if (obj instanceof Device) {
                        Device device = (Device) obj;
                        OpenFeintInternal.this.mParentalControlsEnabled = device.parental_control != null && device.parental_control.enabled;
                    }
                    OpenFeintInternal.access$402$78278a84(OpenFeintInternal.this);
                    if (OpenFeintInternal.this.mPostDeviceSessionRunnable != null) {
                        OFLog.i(TAG, "Launching post-device-session runnable now.");
                        OpenFeintInternal.this.mMainThreadHandler.post(OpenFeintInternal.this.mPostDeviceSessionRunnable);
                    }
                }
                if (OpenFeintInternal.this.mQueuedPostDeviceSessionRunnables != null) {
                    Iterator it = OpenFeintInternal.this.mQueuedPostDeviceSessionRunnables.iterator();
                    while (it.hasNext()) {
                        OpenFeintInternal.this.mMainThreadHandler.post((Runnable) it.next());
                    }
                }
                OpenFeintInternal.access$502$5f63a5fa(OpenFeintInternal.this);
                OpenFeintInternal.access$802$207cf26(OpenFeintInternal.this);
            }

            @Override // com.openfeint.internal.request.BaseRequest
            public final String path() {
                return "/xp/devices";
            }
        });
    }

    public static void displayErrorDialog(CharSequence charSequence) {
        SimpleNotification.show(charSequence.toString(), Notification.Category.Foreground, Notification.Type.Error);
    }

    private String findUDID() throws Throwable {
        String string = Settings.Secure.getString(this.mContext.getContentResolver(), TapjoyConstants.TJC_ANDROID_ID);
        if (string != null && !string.equals("9774d56d682e549c")) {
            return "android-id-" + string;
        }
        SyncedStore.Reader reader = getPrefs().read();
        try {
            String string2 = reader.getString(TapjoyConstants.TJC_DEVICE_ID_NAME, null);
            reader.complete();
            if (string2 != null) {
                return string2;
            }
            byte[] bArr = new byte[16];
            new Random().nextBytes(bArr);
            String str = "android-emu-" + new String(Hex.encodeHex(bArr)).replace("\r\n", "");
            SyncedStore.Editor editorEdit = getPrefs().edit();
            try {
                editorEdit.putString(TapjoyConstants.TJC_DEVICE_ID_NAME, str);
                return str;
            } finally {
                editorEdit.commit();
            }
        } catch (Throwable th) {
            reader.complete();
            throw th;
        }
    }

    public static void genericRequest(String str, String str2, Map<String, Object> map, Map<String, Object> map2, IRawRequestDelegate iRawRequestDelegate) {
        makeRequest(new GenericRequest(str, str2, map, map2, iRawRequestDelegate));
    }

    public static OpenFeintInternal getInstance() {
        return sInstance;
    }

    public static String getModelString() {
        return "p(" + Build.PRODUCT + ")/m(" + Build.MODEL + ")";
    }

    public static String getOSVersionString() {
        return "v" + Build.VERSION.RELEASE + " (" + Build.VERSION.INCREMENTAL + ")";
    }

    private SyncedStore getPrefs() {
        if (this.mPrefs == null) {
            this.mPrefs = new SyncedStore(this.mContext);
        }
        return this.mPrefs;
    }

    private static String getProcessorInfo() {
        String strTrim;
        try {
            for (String str : cat("/proc/cpuinfo")) {
                if (str.startsWith("Processor\t")) {
                    strTrim = str.split(":")[1].trim();
                    return String.format("family(%s) min(%s) max(%s)", strTrim, cat("/sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_min_freq").get(0), cat("/sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_max_freq").get(0));
                }
            }
            strTrim = "unknown";
            return String.format("family(%s) min(%s) max(%s)", strTrim, cat("/sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_min_freq").get(0), cat("/sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_max_freq").get(0));
        } catch (Exception e) {
            return "family(unknown) min(unknown) max(unknown)";
        }
    }

    public static String getRString(int i) {
        return sInstance.mContext.getResources().getString(i);
    }

    private String getUDID() {
        if (this.mUDID == null) {
            this.mUDID = findUDID();
        }
        return this.mUDID;
    }

    public static void initializeWithoutLoggingIn(Context context, OpenFeintSettings openFeintSettings, OpenFeintDelegate openFeintDelegate) {
        validateManifest(context);
        if (sInstance == null) {
            sInstance = new OpenFeintInternal(openFeintSettings, context);
        }
        sInstance.mDelegate = openFeintDelegate;
        if (sInstance.mDeclined) {
            OfflineSupport.setUserDeclined();
        } else {
            String userID = sInstance.getUserID();
            if (userID == null) {
                OfflineSupport.setUserTemporary();
            } else {
                OfflineSupport.setUserID(userID);
            }
            sInstance.createDeviceSession();
        }
        EventLogDispatcher.getInstance().postEvent("game_start.openfeint.com", null);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public final User lastLoggedInUser() {
        User userLoadUser = loadUser();
        SyncedStore.Reader reader = getPrefs().read();
        try {
            URL url = new URL(getServerUrl());
            URL url2 = new URL(reader.getString("last_logged_in_server", ""));
            if (userLoadUser == null || !url.equals(url2)) {
                return null;
            }
            reader.complete();
            return userLoadUser;
        } catch (MalformedURLException e) {
        } finally {
            reader.complete();
        }
    }

    private void loadPropertiesFromXMLResource(Properties properties, int i) {
        XmlResourceParser xml;
        String name = null;
        try {
            xml = this.mContext.getResources().getXml(i);
        } catch (Exception e) {
            xml = null;
        }
        if (xml != null) {
            try {
                int eventType = xml.getEventType();
                while (xml.getEventType() != 1) {
                    if (eventType == 2) {
                        name = xml.getName();
                    } else if (xml.getEventType() == 4) {
                        properties.setProperty(name, xml.getText());
                    }
                    xml.next();
                    eventType = xml.getEventType();
                }
                xml.close();
            } catch (Exception e2) {
                throw new RuntimeException(e2);
            }
        }
    }

    private User loadUser() {
        SyncedStore.Reader reader = getPrefs().read();
        try {
            return userFromString(reader.getString("last_logged_in_user", null));
        } finally {
            reader.complete();
        }
    }

    public static void makeRequest(BaseRequest baseRequest) {
        OpenFeintInternal openFeintInternal = sInstance;
        if (openFeintInternal != null) {
            openFeintInternal._makeRequest(baseRequest);
            return;
        }
        ServerException serverException = new ServerException();
        serverException.exceptionClass = "NoFeint";
        serverException.message = "OpenFeint has not been initialized.";
        baseRequest.onResponse(0, serverException.generate().getBytes());
    }

    public static void restoreInstanceState(Bundle bundle) {
        OpenFeintInternal openFeintInternal = sInstance;
        if (openFeintInternal.mDeserializedAlready || bundle == null) {
            return;
        }
        openFeintInternal.mCurrentUser = (CurrentUser) userFromString(bundle.getString("mCurrentUser"));
        if (openFeintInternal.mClient != null) {
            openFeintInternal.mClient.restoreInstanceState(bundle);
        }
        openFeintInternal.mCurrentlyLoggingIn = bundle.getBoolean("mCurrentlyLoggingIn");
        openFeintInternal.mCreatingDeviceSession = bundle.getBoolean("mCreatingDeviceSession");
        openFeintInternal.mDeviceSessionCreated = bundle.getBoolean("mDeviceSessionCreated");
        openFeintInternal.mBanned = bundle.getBoolean("mBanned");
        openFeintInternal.mParentalControlsEnabled = bundle.getBoolean("mParentalControlsEnabled");
        openFeintInternal.mApproved = bundle.getBoolean("mApproved");
        openFeintInternal.mDeclined = bundle.getBoolean("mDeclined");
        openFeintInternal.mDeserializedAlready = true;
    }

    public static void saveInstanceState(Bundle bundle) {
        OpenFeintInternal openFeintInternal = sInstance;
        if (openFeintInternal.mCurrentUser != null) {
            bundle.putString("mCurrentUser", openFeintInternal.mCurrentUser.generate());
        }
        if (openFeintInternal.mClient != null) {
            openFeintInternal.mClient.saveInstanceState(bundle);
        }
        bundle.putBoolean("mCurrentlyLoggingIn", openFeintInternal.mCurrentlyLoggingIn);
        bundle.putBoolean("mCreatingDeviceSession", openFeintInternal.mCreatingDeviceSession);
        bundle.putBoolean("mDeviceSessionCreated", openFeintInternal.mDeviceSessionCreated);
        bundle.putBoolean("mBanned", openFeintInternal.mBanned);
        bundle.putBoolean("mParentalControlsEnabled", openFeintInternal.mParentalControlsEnabled);
        bundle.putBoolean("mApproved", openFeintInternal.mApproved);
        bundle.putBoolean("mDeclined", openFeintInternal.mDeclined);
    }

    public static void setUserEnableSource(String str) {
        userEnableSource = str;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void showOfflineNotification(int i, Object obj) {
        Resources resources = this.mContext.getResources();
        String string = resources.getString(RR.string("of_offline_notification_line2"));
        if (i != 0) {
            if (403 == i) {
                this.mBanned = true;
            }
            if (obj instanceof ServerException) {
                string = ((ServerException) obj).message;
            }
        }
        TwoLineNotification.show(resources.getString(RR.string("of_offline_notification")), string, Notification.Category.Foreground, Notification.Type.NetworkOffline);
        OFLog.e("Reachability", "Unable to launch IntroFlow because: " + string);
    }

    private static User userFromString(String str) {
        if (str == null) {
            return null;
        }
        try {
            Object obj = new JsonResourceParser(new JsonFactory((byte) 0).createJsonParser(new ByteArrayInputStream(str.getBytes()))).parse();
            if (obj != null && (obj instanceof User)) {
                return (User) obj;
            }
        } catch (IOException e) {
        }
        return null;
    }

    /* JADX WARN: Multi-variable type inference failed */
    /* JADX WARN: Type inference failed for: r0v0 */
    /* JADX WARN: Type inference failed for: r0v1 */
    /* JADX WARN: Type inference failed for: r0v2, types: [boolean] */
    /* JADX WARN: Type inference failed for: r0v3 */
    /* JADX WARN: Type inference failed for: r0v4 */
    /* JADX WARN: Type inference failed for: r0v5 */
    /* JADX WARN: Type inference failed for: r0v6 */
    /* JADX WARN: Type inference failed for: r0v7 */
    /* JADX WARN: Type inference failed for: r2v15 */
    /* JADX WARN: Type inference failed for: r2v16 */
    /* JADX WARN: Type inference failed for: r2v22 */
    private static boolean validateManifest(Context context) {
        ?? r2;
        ?? r0 = 0;
        r0 = 0;
        r0 = 0;
        r0 = 0;
        try {
            PackageInfo packageInfo = context.getPackageManager().getPackageInfo(context.getPackageName(), 1);
            for (String str : new String[]{"com.openfeint.api.ui.Dashboard", "com.openfeint.internal.ui.IntroFlow", "com.openfeint.internal.ui.Settings", "com.openfeint.internal.ui.NativeBrowser"}) {
                ActivityInfo[] activityInfoArr = packageInfo.activities;
                int length = activityInfoArr.length;
                int i = 0;
                while (true) {
                    if (i >= length) {
                        r2 = false;
                        break;
                    }
                    ActivityInfo activityInfo = activityInfoArr[i];
                    if (activityInfo.name.equals(str)) {
                        if ((activityInfo.configChanges & 128) != 0) {
                            r2 = true;
                            break;
                        }
                        Log.v("OpenFeintInternal", String.format("ActivityInfo for %s has the wrong configChanges.\nPlease consult README.txt for the correct configuration.", str));
                        return r0;
                    }
                    i++;
                }
                if (r2 != true) {
                    Log.v("OpenFeintInternal", String.format("Couldn't find ActivityInfo for %s.\nPlease consult README.txt for the correct configuration.", str));
                    return r0;
                }
            }
            for (String str2 : new String[]{"android.permission.INTERNET"}) {
                int i2 = Util.noPermission(str2, context) ? 0 : i2 + 1;
                return r0;
            }
            r0 = 1;
        } catch (PackageManager.NameNotFoundException e) {
            Object[] objArr = new Object[1];
            objArr[r0] = context.getPackageName();
            Log.v("OpenFeintInternal", String.format("Couldn't find PackageInfo for %s.\nPlease initialize OF with an Activity that lives in your root package.", objArr));
        }
        return r0;
    }

    public final void createUser(String str, String str2, String str3, String str4, IRawRequestDelegate iRawRequestDelegate) {
        OrderedArgList orderedArgList = new OrderedArgList();
        orderedArgList.put("user[name]", str);
        orderedArgList.put("user[http_basic_credential_attributes][email]", str2);
        orderedArgList.put("user[http_basic_credential_attributes][password]", str3);
        orderedArgList.put("user[http_basic_credential_attributes][password_confirmation]", str4);
        RawRequest rawRequest = new RawRequest(orderedArgList) { // from class: com.openfeint.internal.OpenFeintInternal.1
            @Override // com.openfeint.internal.request.BaseRequest
            public final String method() {
                return "POST";
            }

            @Override // com.openfeint.internal.request.JSONRequest
            protected final void onResponse(int i, Object obj) throws Throwable {
                if (200 > i || i >= 300 || (obj != null && (obj instanceof ServerException))) {
                    onFailure(obj);
                    return;
                }
                OFLog.e(TAG, "new user or enable of: response code:" + i);
                EventLogDispatcher.getInstance().postEvent(i == 201 ? "new_user.openfeint.com" : "enabled_of.openfeint.com", OpenFeintInternal.createUserSource);
                OpenFeintInternal.access$100(OpenFeintInternal.this, (User) obj);
            }

            @Override // com.openfeint.internal.request.BaseRequest
            public final String path() {
                return "/xp/users.json";
            }
        };
        rawRequest.setDelegate(iRawRequestDelegate);
        _makeRequest(rawRequest);
    }

    public final String getAppID() {
        return this.mSettings.id;
    }

    public final String getAppName() {
        return this.mSettings.name;
    }

    public final int getAppVersion() {
        if (this.mAppVersion == -1) {
            Context context = this.mContext;
            try {
                this.mAppVersion = context.getPackageManager().getPackageInfo(context.getPackageName(), 0).versionCode;
            } catch (Exception e) {
                this.mAppVersion = 0;
            }
        }
        return this.mAppVersion;
    }

    public final AbstractHttpClient getClient() {
        return this.mClient;
    }

    public final Context getContext() {
        return this.mContext;
    }

    public final String getCountryString() {
        return this.mContext.getResources().getConfiguration().locale.getCountry();
    }

    public final CurrentUser getCurrentUser() {
        return this.mCurrentUser;
    }

    public final OpenFeintDelegate getDelegate() {
        return this.mDelegate;
    }

    public final Map<String, Object> getDeviceParams() {
        HashMap map = new HashMap();
        map.put("identifier", getUDID());
        map.put("hardware", getModelString());
        map.put("os", getOSVersionString());
        DisplayMetrics displayMetrics = Util.getDisplayMetrics();
        map.put("screen_resolution", String.format("%dx%d (%f dpi)", Integer.valueOf(displayMetrics.widthPixels), Integer.valueOf(displayMetrics.heightPixels), Float.valueOf(displayMetrics.density)));
        map.put("processor", getProcessorInfo());
        return map;
    }

    public final String getGSDI() {
        if (this.mGSDI == null) {
            this.mGSDI = Util.hexSHA1(String.format("OFGSDI.%s.%s", getUDID(), this.mSettings.id));
        }
        return this.mGSDI;
    }

    public final String getLocaleString() {
        return this.mContext.getResources().getConfiguration().locale.toString();
    }

    public final String getOFVersion() {
        return this.mInternalProperties.getProperty("of-version");
    }

    public final int getResource(String str) {
        return this.mContext.getResources().getIdentifier(str, null, this.mContext.getPackageName());
    }

    public final String getServerUrl() {
        if (this.mServerUrl == null) {
            String strTrim = this.mInternalProperties.getProperty("server-url").toLowerCase().trim();
            if (strTrim.endsWith("/")) {
                strTrim = strTrim.substring(0, strTrim.length() - 1);
            }
            this.mServerUrl = strTrim;
        }
        return this.mServerUrl;
    }

    public final String getSessionID() {
        return this.mSessionID;
    }

    public final Date getSessionStartDate() {
        return this.mSessionStartDate;
    }

    public final Map<String, Object> getSettings() {
        return this.mSettings.settings;
    }

    public final String getUserID() {
        CurrentUser currentUser = this.mCurrentUser;
        if (currentUser != null) {
            return currentUser.userID();
        }
        User userLastLoggedInUser = lastLoggedInUser();
        if (userLastLoggedInUser != null) {
            return userLastLoggedInUser.userID();
        }
        return null;
    }

    public final boolean isFeintServerReachable() {
        if (Util.noPermission("android.permission.ACCESS_NETWORK_STATE", this.mContext)) {
            return true;
        }
        NetworkInfo activeNetworkInfo = ((ConnectivityManager) this.mContext.getSystemService("connectivity")).getActiveNetworkInfo();
        return activeNetworkInfo != null && activeNetworkInfo.isConnected();
    }

    public final boolean isUserLoggedIn() {
        return this.mCurrentUser != null;
    }

    public final void launchIntroFlow(final boolean z) {
        if (checkBan()) {
            return;
        }
        if (!isFeintServerReachable()) {
            showOfflineNotification(0, "");
            return;
        }
        OpenFeintDelegate openFeintDelegate = this.mDelegate;
        if (!this.mApproved && openFeintDelegate != null) {
            Context context = this.mContext;
        }
        Runnable runnable = new Runnable() { // from class: com.openfeint.internal.OpenFeintInternal.11
            @Override // java.lang.Runnable
            public final void run() {
                Intent intent = new Intent(OpenFeintInternal.this.getContext(), (Class<?>) IntroFlow.class);
                if (OpenFeintInternal.this.mApproved && z) {
                    intent.putExtra("content_name", "index?preapproved=true&spotlight=true");
                } else if (z) {
                    intent.putExtra("content_name", "index?spotlight=true");
                } else if (OpenFeintInternal.this.mApproved) {
                    intent.putExtra("content_name", "index?preapproved=true");
                }
                intent.addFlags(268435456);
                OFLog.w("OpenFeintInternal", "show prompt_enable_of");
                EventLogDispatcher.getInstance().postEvent("prompt_enable_of.openfeint.com", null);
                OpenFeintInternal.this.getContext().startActivity(intent);
            }
        };
        if (!this.mCreatingDeviceSession && this.mDeviceSessionCreated) {
            runnable.run();
            return;
        }
        if (!this.mCreatingDeviceSession) {
            createDeviceSession();
        }
        this.mPostDeviceSessionRunnable = runnable;
    }

    public final void login(final boolean z) {
        this.mMainThreadHandler.post(new Runnable() { // from class: com.openfeint.internal.OpenFeintInternal.10
            @Override // java.lang.Runnable
            public final void run() throws Throwable {
                if (OpenFeintInternal.this.mDeclined || OpenFeintInternal.this.mCurrentlyLoggingIn || OpenFeintInternal.this.isUserLoggedIn()) {
                    return;
                }
                OpenFeintInternal.access$1302$78278a84(OpenFeintInternal.this);
                final User userLastLoggedInUser = OpenFeintInternal.this.lastLoggedInUser();
                if (userLastLoggedInUser != null) {
                    OFLog.i("OpenFeintInternal", "Logging in last known user: " + userLastLoggedInUser.name);
                    OpenFeintInternal.this.loginUser(null, null, null, new IRawRequestDelegate() { // from class: com.openfeint.internal.OpenFeintInternal.10.1
                        @Override // com.openfeint.internal.request.IRawRequestDelegate
                        public final void onResponse(int i, String str) {
                            if (200 <= i && i < 300) {
                                SimpleNotification.show("Welcome back " + userLastLoggedInUser.name, Notification.Category.Login, Notification.Type.Success);
                            } else if (403 == i) {
                                OpenFeintInternal.access$1502$78278a84(OpenFeintInternal.this);
                            } else {
                                OpenFeintInternal.this.launchIntroFlow(z);
                            }
                        }
                    });
                } else {
                    OFLog.i("OpenFeintInternal", "No last user, launch intro flow");
                    OpenFeintInternal.this.clearPrefs();
                    OpenFeintInternal.this.launchIntroFlow(z);
                }
            }
        });
    }

    public final void loginUser(final String str, final String str2, final String str3, final IRawRequestDelegate iRawRequestDelegate) {
        boolean z;
        final boolean z2 = false;
        if (checkBan()) {
            return;
        }
        if (this.mCreatingDeviceSession || !this.mDeviceSessionCreated) {
            if (!this.mCreatingDeviceSession) {
                createDeviceSession();
            }
            OFLog.i("OpenFeintInternal", "No device session yet - queueing login.");
            this.mPostDeviceSessionRunnable = new Runnable() { // from class: com.openfeint.internal.OpenFeintInternal.3
                @Override // java.lang.Runnable
                public final void run() {
                    OpenFeintInternal.this.loginUser(str, str2, str3, iRawRequestDelegate);
                }
            };
            return;
        }
        OrderedArgList orderedArgList = new OrderedArgList();
        if (str == null || str2 == null) {
            z = true;
        } else {
            orderedArgList.put("login", str);
            orderedArgList.put("password", str2);
            z = false;
        }
        if (str3 == null || str2 == null) {
            z2 = z;
        } else {
            orderedArgList.put("user_id", str3);
            orderedArgList.put("password", str2);
        }
        this.mCurrentlyLoggingIn = true;
        RawRequest rawRequest = new RawRequest(orderedArgList) { // from class: com.openfeint.internal.OpenFeintInternal.4
            @Override // com.openfeint.internal.request.BaseRequest
            public final String method() {
                return "POST";
            }

            @Override // com.openfeint.internal.request.JSONRequest
            public final void onResponse(int i, Object obj) throws Throwable {
                OpenFeintInternal.access$902$78278a84(OpenFeintInternal.this);
                if (200 <= i && i < 300) {
                    OpenFeintInternal.access$100(OpenFeintInternal.this, (User) obj);
                    if (OpenFeintInternal.this.mPostLoginRunnable != null) {
                        OFLog.i(TAG, "Launching post-login runnable now.");
                        OpenFeintInternal.this.mMainThreadHandler.post(OpenFeintInternal.this.mPostLoginRunnable);
                    }
                } else if (z2) {
                    OpenFeintInternal.this.showOfflineNotification(i, obj);
                }
                if (OpenFeintInternal.this.mQueuedPostLoginRunnables != null) {
                    Iterator it = OpenFeintInternal.this.mQueuedPostLoginRunnables.iterator();
                    while (it.hasNext()) {
                        OpenFeintInternal.this.mMainThreadHandler.post((Runnable) it.next());
                    }
                }
                OpenFeintInternal.access$602$5f63a5fa(OpenFeintInternal.this);
                OpenFeintInternal.access$1002$207cf26(OpenFeintInternal.this);
            }

            @Override // com.openfeint.internal.request.BaseRequest
            public final String path() {
                return "/xp/sessions.json";
            }
        };
        rawRequest.setDelegate(iRawRequestDelegate);
        _makeRequest(rawRequest);
    }

    public final void logoutUser(IRawRequestDelegate iRawRequestDelegate) throws Throwable {
        OrderedArgList orderedArgList = new OrderedArgList();
        orderedArgList.put(TapjoyConstants.TJC_PLATFORM, TapjoyConstants.TJC_DEVICE_PLATFORM_TYPE);
        RawRequest rawRequest = new RawRequest(orderedArgList) { // from class: com.openfeint.internal.OpenFeintInternal.6
            @Override // com.openfeint.internal.request.BaseRequest
            public final String method() {
                return "DELETE";
            }

            @Override // com.openfeint.internal.request.BaseRequest
            public final String path() {
                return "/xp/sessions.json";
            }
        };
        rawRequest.setDelegate(iRawRequestDelegate);
        _makeRequest(rawRequest);
        CurrentUser currentUser = this.mCurrentUser;
        this.mCurrentUser = null;
        this.mDeviceSessionCreated = false;
        clearPrefs();
        if (this.mDelegate != null) {
            OpenFeintDelegate openFeintDelegate = this.mDelegate;
        }
        OfflineSupport.setUserDeclined();
    }

    public final boolean parentalControlsEnabled() {
        return this.mParentalControlsEnabled;
    }

    public final void runOnUiThread(Runnable runnable) {
        this.mMainThreadHandler.post(runnable);
    }

    public final void setParentalControlsEnabled(boolean z) {
        this.mParentalControlsEnabled = z;
    }

    public final void submitIntent(final Intent intent, boolean z) {
        this.mDeclined = false;
        Runnable runnable = new Runnable() { // from class: com.openfeint.internal.OpenFeintInternal.5
            @Override // java.lang.Runnable
            public final void run() {
                intent.addFlags(268435456);
                OpenFeintInternal.this.getContext().startActivity(intent);
            }
        };
        if (isUserLoggedIn()) {
            this.mMainThreadHandler.post(runnable);
            return;
        }
        OFLog.i("OpenFeintInternal", "Not logged in yet - queueing intent " + intent.toString() + " for now.");
        this.mPostLoginRunnable = runnable;
        if (this.mCurrentlyLoggingIn || this.mCreatingDeviceSession) {
            return;
        }
        login(z);
    }

    public final void uploadFile(final String str, final PartSource partSource, final String str2, final IUploadDelegate iUploadDelegate) {
        _makeRequest(new JSONRequest() { // from class: com.openfeint.internal.OpenFeintInternal.9
            @Override // com.openfeint.internal.request.BaseRequest
            public final String method() {
                return "POST";
            }

            @Override // com.openfeint.internal.request.JSONRequest
            public final void onFailure(String str3) {
                if (iUploadDelegate != null) {
                    iUploadDelegate.fileUploadedTo("", false);
                }
            }

            @Override // com.openfeint.internal.request.JSONRequest
            public final void onSuccess(Object obj) {
                final BlobUploadParameters blobUploadParameters = (BlobUploadParameters) obj;
                BlobPostRequest blobPostRequest = new BlobPostRequest(blobUploadParameters, partSource, str2);
                if (iUploadDelegate != null) {
                    blobPostRequest.setDelegate(new IRawRequestDelegate() { // from class: com.openfeint.internal.OpenFeintInternal.9.1
                        @Override // com.openfeint.internal.request.IRawRequestDelegate
                        public final void onResponse(int i, String str3) {
                            iUploadDelegate.fileUploadedTo(blobUploadParameters.action + blobUploadParameters.key, 200 <= i && i < 300);
                        }
                    });
                }
                OpenFeintInternal.this._makeRequest(blobPostRequest);
            }

            @Override // com.openfeint.internal.request.BaseRequest
            public final String path() {
                return str;
            }

            @Override // com.openfeint.internal.request.BaseRequest
            public final boolean wantsLogin() {
                return true;
            }
        });
    }

    public final void userDeclinedFeint() throws Throwable {
        this.mApproved = false;
        this.mDeclined = true;
        EventLogDispatcher.getInstance().postEvent("declined_of.openfeint.com", null);
        SyncedStore.Editor editorEdit = getPrefs().edit();
        try {
            editorEdit.putString(this.mContext.getPackageName() + ".of_declined", "sadly");
            editorEdit.commit();
            OfflineSupport.setUserDeclined();
        } catch (Throwable th) {
            editorEdit.commit();
            throw th;
        }
    }
}
