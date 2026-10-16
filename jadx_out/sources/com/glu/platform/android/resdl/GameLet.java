package com.glu.platform.android.resdl;

import android.app.AlertDialog;
import android.content.DialogInterface;
import android.graphics.drawable.Drawable;
import android.os.Build;
import android.provider.Settings;
import com.glu.platform.android.GluPlatformActivity;
import com.tapjoy.TapjoyConstants;
import java.lang.reflect.Method;
import java.util.Enumeration;
import java.util.Hashtable;
import java.util.Locale;
import java.util.Properties;
import java.util.TimeZone;
import java.util.Vector;

/* JADX INFO: loaded from: classes.dex */
public class GameLet {
    public static boolean m_appPaused = false;
    public static boolean TABLET_BUILD_SCALES_NATURALLY = true;
    public static boolean WVGA_BUILD_SCALES_NATURALLY = true;
    public static int MAX_SMALL_DIMENSION_FOR_WVGA = 600;
    public static String RES_FILE_URL_KEY_TO_USE = "Glu-Res-File-URL";
    public static long RES_FILE_CHECKSUM_TO_USE = -1;
    public static long RES_FILE_SIZE_TO_USE = -1;
    public static final String[] RESOURCE_FILENAME_ARRAY = {null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null};
    public static String RESOURCE_FILENAME = "file.big";
    public static String[] SPECIAL_RES_FILENAME_ARRAY = null;
    public static int[] SPECIAL_RES_FILESIZE_ARRAY = null;
    public static long[] SPECIAL_RES_CHECKSUM_ARRAY = null;
    public static String KEY_SPECIAL_FILE_URL = null;
    public static Hashtable<Integer, Drawable> m_imageStore = new Hashtable<>();
    public static Hashtable<String, String> m_nativeProperties = new Hashtable<>();
    public static int m_buildVariant = -1;
    public static boolean m_supportsATITCCompression = false;
    public static boolean m_supportsDXTCCompression = false;
    public static boolean m_supportsPVRTCCompression = false;
    public static String m_locale = null;
    public static String m_language = null;
    public static String m_countryCode = null;
    public static String m_deviceID = null;
    public static String m_serial = null;
    public static String m_fullVersion = null;
    public static String m_versionMajor = null;
    public static String m_versionMinor = null;
    public static String m_versionMicro = null;
    public static String m_versionNano = null;
    public static String m_platformVersion = null;
    public static String m_platformVersionNice = null;
    public static String m_timezone = null;
    public static String m_deviceModel = null;
    public static String m_packageID = null;
    public static int m_platformVersionI = 0;
    public static AlertDialog m_modalDialog = null;
    public static String m_modalDialogTitle = null;
    public static String m_modalDialogText = null;
    public static String m_buttonOneText = null;
    public static String m_buttonTwoText = null;
    public static Method m_dialogCallback = null;
    public static long m_lastDialogCloseAt = -9223372036854775807L;

    public static class instance extends GameLet {
    }

    public static void finishApp() {
        ResDL.getContext().finish();
    }

    public static void handleModalDialogClosed() {
        m_lastDialogCloseAt = System.currentTimeMillis();
    }

    public static void handlerOpenModalDialog() {
        ResDL.m_viewManipulationHandler.sendEmptyMessage(0);
    }

    public static void handlerSwitchToResView() {
        if (Build.VERSION.SDK_INT < 8) {
            ResDL.sm_dummyView.onPause();
        }
        ResDL.m_viewManipulationHandler.sendEmptyMessage(2);
    }

    public static void onHandledCloseModalDialog() {
        if (m_modalDialog == null || !m_modalDialog.isShowing()) {
            Debug.log("Not closing modal dialog. (nothing to do)");
            return;
        }
        Debug.log("Closing modal dialog.");
        m_lastDialogCloseAt = System.currentTimeMillis();
        m_modalDialog.dismiss();
        m_modalDialog = null;
    }

    public static void onHandledOpenModalDialog() {
        Debug.log("Opening modal dialog.");
        Debug.log("Title=" + GluUtil.safeString(m_modalDialogTitle));
        Debug.log("Text=" + GluUtil.safeString(m_modalDialogText));
        Debug.log("B1=" + GluUtil.safeString(m_buttonOneText));
        Debug.log("B2=" + GluUtil.safeString(m_buttonTwoText));
        if (m_modalDialog == null || !m_modalDialog.isShowing()) {
            int iCurrentTimeMillis = (int) (System.currentTimeMillis() - m_lastDialogCloseAt);
            if (iCurrentTimeMillis < 1000) {
                GluUtil.sleep(1000 - iCurrentTimeMillis);
            }
            AlertDialog.Builder builder = new AlertDialog.Builder(ResDL.getContext());
            DialogInterface.OnClickListener onClickListener = new DialogInterface.OnClickListener() { // from class: com.glu.platform.android.resdl.GameLet.1
                @Override // android.content.DialogInterface.OnClickListener
                public final void onClick(DialogInterface dialogInterface, int i) {
                    boolean z = false;
                    if (GameLet.m_dialogCallback != null) {
                        try {
                            GameLet.m_dialogCallback.invoke(null, Integer.valueOf(i));
                        } catch (Exception e) {
                            Debug.log("Error: Exception with the modal dialog callback.", e);
                            z = true;
                        }
                    } else {
                        z = true;
                    }
                    if (z) {
                        Debug.log("No callback provided (or usable) for this dialog. This onClick action will close the dialog.");
                        GameLet.handleModalDialogClosed();
                        GameLet.m_modalDialog.dismiss();
                    }
                }
            };
            builder.setCancelable(true);
            builder.setOnCancelListener(new DialogInterface.OnCancelListener() { // from class: com.glu.platform.android.resdl.GameLet.2
                @Override // android.content.DialogInterface.OnCancelListener
                public final void onCancel(DialogInterface dialogInterface) {
                    GameLet.handleModalDialogClosed();
                }
            });
            AlertDialog alertDialogCreate = builder.create();
            m_modalDialog = alertDialogCreate;
            alertDialogCreate.setTitle(m_modalDialogTitle);
            m_modalDialog.setMessage(m_modalDialogText);
            if (m_buttonTwoText == null) {
                m_modalDialog.setButton(-3, m_buttonOneText, onClickListener);
            } else {
                m_modalDialog.setButton(-1, m_buttonOneText, onClickListener);
                m_modalDialog.setButton(-2, m_buttonTwoText, onClickListener);
            }
            m_modalDialog.show();
        }
    }

    public static void populate() {
        m_lastDialogCloseAt = System.currentTimeMillis();
        m_nativeProperties = GluUtil.getNativeProperties();
        GluPlatformActivity.SPECIAL_URL_MORE_GAMES = instance.m_nativeProperties.get("Glu-Upsell-URL");
        GluPlatformActivity.SPECIAL_URL_FORCE_UPGRADE = instance.m_nativeProperties.get("Glu-Forced-Upgrade-URL");
        GluPlatformActivity.SPECIAL_URL_RATE_ME = instance.m_nativeProperties.get("Glu-Rate-Me-URL");
        String lowerCase = Locale.getDefault().getLanguage().toLowerCase();
        if (lowerCase.equals("pt") && Locale.getDefault().getCountry().toLowerCase().equals("br")) {
            lowerCase = "ptbr";
        }
        Debug.log("Locale found: " + lowerCase + "   country=" + Locale.getDefault().getCountry());
        m_locale = lowerCase;
        m_language = Locale.getDefault().getDisplayLanguage(Locale.ENGLISH);
        m_countryCode = Locale.getDefault().getCountry();
        String string = Settings.Secure.getString(ResDL.getContext().getContentResolver(), TapjoyConstants.TJC_ANDROID_ID);
        m_deviceID = string;
        if (string == null) {
            m_deviceID = "unknown";
        }
        Debug.log("UDID: " + m_deviceID);
        try {
            m_serial = (String) GluUtil.getField("android.os.Build", "SERIAL").get(null);
            Debug.log("Serial found: " + m_serial);
        } catch (Throwable th) {
            m_serial = null;
            Debug.log("Could not get serial.", th);
        }
        m_versionMajor = "1";
        m_versionMinor = "0";
        m_versionMicro = "0";
        m_versionNano = "0";
        try {
            m_fullVersion = GluUtil.grabVersionString();
            Debug.log("Filtered version string: " + m_fullVersion);
            Vector<String> vectorSimpleTokenizer = GluUtil.simpleTokenizer(m_fullVersion, ".");
            m_versionMajor = vectorSimpleTokenizer.elementAt(0);
            m_versionMinor = vectorSimpleTokenizer.elementAt(1);
            m_versionMicro = vectorSimpleTokenizer.elementAt(2);
            if (vectorSimpleTokenizer.size() > 3) {
                m_versionNano = vectorSimpleTokenizer.elementAt(3);
                Debug.log("Version is: " + m_versionMajor + "." + m_versionMinor + "." + m_versionMicro + "." + m_versionNano);
            } else {
                Debug.log("Version is: " + m_versionMajor + "." + m_versionMinor + "." + m_versionMicro);
            }
        } catch (Exception e) {
            Debug.log("Warning: Version string unexpected format. Version is: " + m_versionMajor + "." + m_versionMinor + "." + m_versionMicro);
        }
        Debug.log("NOW is: " + System.currentTimeMillis());
        Debug.log("Platform version codename: " + Build.VERSION.CODENAME);
        Debug.log("Platform version incremental: " + Build.VERSION.INCREMENTAL);
        Debug.log("Platform version release: " + Build.VERSION.RELEASE);
        Debug.log("Platform version SDK: " + Build.VERSION.SDK);
        Debug.log("Platform version SDK (int): " + Build.VERSION.SDK_INT);
        Debug.log("Device model: " + Build.MODEL);
        Debug.log("Device manufacturer: " + Build.MANUFACTURER);
        Debug.log("Device \"name of industrial design\": " + Build.DEVICE);
        Debug.log("Device product name: " + Build.PRODUCT);
        Debug.log("Device fingerprint: " + Build.FINGERPRINT);
        Debug.log("Device CPU: " + Build.CPU_ABI);
        Debug.log("Device Brand/Carrier: " + Build.BRAND);
        Debug.log("Device Board: " + Build.BOARD);
        Debug.log("Build Host: " + Build.HOST);
        Debug.log("Build Identifier: " + Build.ID);
        Debug.log("Build Tags: " + Build.TAGS);
        Debug.log("Build Time: " + Build.TIME);
        Debug.log("Build Type: " + Build.TYPE);
        Debug.log("Build User: " + Build.USER);
        m_platformVersion = Build.VERSION.SDK_INT + "";
        m_platformVersionI = Build.VERSION.SDK_INT;
        m_platformVersionNice = GluUtil.safeStringTruncate(Build.VERSION.RELEASE, 19);
        m_timezone = GluUtil.safeStringTruncate(TimeZone.getDefault().getID(), 99);
        Debug.log("Time zone is: " + m_timezone);
        m_deviceModel = GluUtil.safeStringTruncate(Build.MODEL, 49);
        Debug.log("Passing as device model: " + m_deviceModel);
        m_packageID = ResDL.getContext().getPackageName();
        GluUtil.determineVideoPlaybackSettings(m_platformVersionI, m_deviceModel);
        Debug.log("Printing out system properties, k=v pairs...");
        Properties properties = System.getProperties();
        Enumeration<?> enumerationPropertyNames = properties.propertyNames();
        Vector vector = new Vector();
        while (enumerationPropertyNames.hasMoreElements()) {
            vector.addElement((String) enumerationPropertyNames.nextElement());
        }
        for (int i = 0; i < vector.size(); i++) {
            Debug.log(((String) vector.elementAt(i)) + "=" + properties.getProperty((String) vector.elementAt(i), "null"));
        }
    }

    public static void setBuildVariant() {
        if (Math.min(GluUtil.getScreenWidth(), GluUtil.getScreenHeight()) > MAX_SMALL_DIMENSION_FOR_WVGA) {
            m_buildVariant = 1;
        } else {
            m_buildVariant = 0;
        }
        KEY_SPECIAL_FILE_URL = GenSettings.SPECIAL_FILE_URL_KEYS[m_buildVariant];
        Debug.log("Special file URL for this device: " + KEY_SPECIAL_FILE_URL);
        SPECIAL_RES_FILENAME_ARRAY = GenSettings.SPECIAL_RES_FILENAME_ARRAY[m_buildVariant];
        SPECIAL_RES_FILESIZE_ARRAY = GenSettings.SPECIAL_RES_FILESIZE_ARRAY[m_buildVariant];
        SPECIAL_RES_CHECKSUM_ARRAY = GenSettings.SPECIAL_RES_CHECKSUM_ARRAY[m_buildVariant];
    }

    public static void startGame() {
        ResDL.onReadyToLaunchGame();
    }
}
