package com.glu.platform.android.resdl;

import android.app.Activity;
import android.app.Notification;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.content.Intent;
import android.graphics.Canvas;
import android.graphics.ColorFilter;
import android.graphics.LightingColorFilter;
import android.graphics.Paint;
import android.graphics.Rect;
import android.graphics.drawable.Drawable;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;
import android.os.Environment;
import android.view.View;
import android.view.ViewGroup;
import com.glu.android.gunbros_free.GunBros;
import com.glu.android.gunbros_free.R;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.InputStream;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.Vector;

/* JADX INFO: loaded from: classes.dex */
public final class GluUtil {
    public static Paint m_gradientPaint = null;
    public static final LightingColorFilter CF_BUTTON_SELECTED = new LightingColorFilter(16777215, 13861120);
    public static final LightingColorFilter CF_BUTTON_DEFAULT = new LightingColorFilter(16777215, 10526880);
    public static final LightingColorFilter CF_BUTTON_DARK = new LightingColorFilter(16777215, 4605510);
    public static Random randomizer = null;
    public static int sm_notID = 100;
    public static final Class[] DIALOG_CALLBACK_PARAMS = {Integer.TYPE};
    public static final Class[] PARAMS_INT = {Integer.TYPE};
    public static final Class[] PARAMS_BOOLEAN = {Boolean.TYPE};
    public static final String[] FILES_TO_SKIP_BACKUP = {"dlstatus.dat", "properties.dat", "backupnotify.dat", GameLet.RESOURCE_FILENAME, "debug.txt", "messages.txt", "priority.dat", "servers.txt", "session.dat", "crashcheck.dat", "alertbin.dat", "alertstr.txt"};
    private static boolean sm_shouldUseDMAActivity = false;
    private static boolean sm_shouldHideGameView = false;
    private static boolean sm_shouldShrinkGameView = false;
    private static boolean sm_canVideoViewHaveNegativeCoordinates = false;
    private static boolean sm_canVideoViewBeLargerThanScreen = false;
    private static boolean sm_canVideoViewSizeBeSlightlyInaccurate = false;
    public static boolean sm_canPlayVideo = false;

    /* JADX WARN: Code duplicated, block: B:22:0x00da  */
    public static boolean cleanupOldSDDir() {
        boolean z;
        Debug.log("Cleaning up old SD dir. (if applicable)");
        String strFilePathWithEnder = filePathWithEnder("/sdcard/glu/gunbros");
        if (!new File(strFilePathWithEnder).exists()) {
            strFilePathWithEnder = strFilePathWithEnder.substring(0, 8) + "sd/" + strFilePathWithEnder.substring(8);
        }
        if (!new File(strFilePathWithEnder).exists()) {
            return false;
        }
        if (GameLet.RESOURCE_FILENAME_ARRAY[GameLet.instance.m_buildVariant] != null) {
            File file = new File(strFilePathWithEnder + GameLet.RESOURCE_FILENAME_ARRAY[GameLet.instance.m_buildVariant]);
            if (file.exists()) {
                Debug.log("deleting: " + file.getAbsolutePath());
                file.delete();
                z = true;
            } else {
                z = false;
            }
        } else {
            z = false;
        }
        if (GameLet.SPECIAL_RES_FILENAME_ARRAY != null) {
            for (int i = 0; i < GameLet.SPECIAL_RES_FILENAME_ARRAY.length; i++) {
                File file2 = new File(strFilePathWithEnder + GameLet.SPECIAL_RES_FILENAME_ARRAY[i]);
                if (file2.exists()) {
                    Debug.log("deleting: " + file2.getAbsolutePath());
                    file2.delete();
                    z = true;
                }
            }
        }
        return z;
    }

    public static HttpURLConnection createURLConnection(String str, int i) throws Exception {
        return createURLConnection(str, i, -1);
    }

    public static HttpURLConnection createURLConnection(String str, int i, int i2) throws Exception {
        HttpURLConnection httpURLConnection = (HttpURLConnection) new URL(str).openConnection();
        httpURLConnection.setIfModifiedSince(0L);
        if (i >= 0 && i2 > 0) {
            Debug.log("Range: bytes=" + i + "-" + ((i + i2) - 1) + "\nresumeAt=" + i + "   length=" + i2);
            httpURLConnection.addRequestProperty("Range", "bytes=" + i + "-" + ((i + i2) - 1));
        } else if (i > 0) {
            Debug.log("Range: bytes=" + i + "-");
            httpURLConnection.addRequestProperty("Range", "bytes=" + i + "-");
        }
        httpURLConnection.setReadTimeout(60000);
        return httpURLConnection;
    }

    public static void determineVideoPlaybackSettings(int i, String str) {
        boolean z = str.indexOf("SCH-I500") != -1;
        str.indexOf("SGH-I897");
        str.indexOf("SCH-I800");
        sm_canVideoViewHaveNegativeCoordinates = true;
        sm_canVideoViewBeLargerThanScreen = false;
        if (z) {
            sm_canVideoViewSizeBeSlightlyInaccurate = false;
        } else {
            sm_canVideoViewSizeBeSlightlyInaccurate = true;
        }
        if (i < 7) {
            sm_shouldUseDMAActivity = true;
        } else {
            sm_shouldUseDMAActivity = false;
        }
        if (i <= 7) {
            sm_shouldHideGameView = false;
            sm_shouldShrinkGameView = true;
        } else if (i >= 8) {
            if (i >= 9) {
                Debug.log("*** WARNING: Video playback behavior not verified on Android 2.3 and above. Defaulting to Android 2.2 behavior. Please test thoroughly.");
            }
            sm_shouldHideGameView = true;
            sm_shouldShrinkGameView = false;
        }
    }

    public static void doStandardViewGroupConfiguration(ViewGroup viewGroup) {
        viewGroup.setFocusable(true);
        viewGroup.setFocusableInTouchMode(true);
        viewGroup.setVisibility(0);
        if (GameLet.instance.m_platformVersionI >= 11) {
            Debug.log("Before system UI view visibility: " + viewVisibilityToString(reflectedViewGetSystemUiVisibility(viewGroup)));
            try {
                getMethod("android.view.View", "setSystemUiVisibility", PARAMS_INT).invoke(viewGroup, new Integer(1));
            } catch (Exception e) {
                Debug.log("Error with reflectedViewSetSystemUiVisibility", e);
            }
            Debug.log("After system UI view visibility: " + viewVisibilityToString(reflectedViewGetSystemUiVisibility(viewGroup)));
        }
    }

    private static void drawImage(Canvas canvas, Drawable drawable, int i, int i2, int i3, int i4) {
        drawable.setBounds(i, i2, i3, i4);
        drawable.draw(canvas);
    }

    private static String filePathNoEnder(String str) {
        if (str == null || str.equals("")) {
            return ".";
        }
        String strSubstring = str.endsWith("/") ? str.substring(0, str.length() - 1) : str;
        return (strSubstring == null || strSubstring.equals("")) ? "." : strSubstring;
    }

    public static final String filePathWithEnder(String str) {
        return filePathNoEnder(str) + "/";
    }

    public static File findResourceFile() {
        File file = new File(getDiskFilename());
        if (file.exists()) {
            return file;
        }
        File file2 = new File(getPrimaryResSDCardFilename());
        if (file2.exists()) {
            return file2;
        }
        return null;
    }

    private static String getBytesStringNice(int i) {
        String str = i + "";
        if (str.length() > 6) {
            return str.substring(0, str.length() - 6) + "," + str.substring(str.length() - 6, str.length() - 3) + "," + str.substring(str.length() - 3);
        }
        return str.length() > 3 ? str.substring(0, str.length() - 3) + "," + str.substring(str.length() - 3) : str;
    }

    public static String getBytesStringNice(long j) {
        return getBytesStringNice((int) j);
    }

    public static int getContentLength(HttpURLConnection httpURLConnection) {
        return getContentLength$7c5bcde9(httpURLConnection);
    }

    private static int getContentLength$7c5bcde9(HttpURLConnection httpURLConnection) {
        try {
            Map<String, List<String>> headerFields = httpURLConnection.getHeaderFields();
            Debug.printMapListStringProperties("Header fields", headerFields);
            List<String> list = headerFields.get("content-length");
            if (list != null && list.size() > 0) {
                try {
                    return Integer.parseInt(list.get(0));
                } catch (Exception e) {
                    Debug.log("Couldn't get content-length, but the property exists.", e);
                }
            }
            return 0;
        } catch (Exception e2) {
            return 0;
        }
    }

    public static String getDiskFilename() {
        return getLocalSaveDirectory() + GameLet.RESOURCE_FILENAME;
    }

    public static Drawable getDrawable(int i) {
        Integer num = new Integer(i);
        Drawable drawable = GameLet.instance.m_imageStore.get(num);
        if (drawable != null) {
            return drawable;
        }
        Drawable drawable2 = ResDL.getContext().getResources().getDrawable(i);
        GameLet.instance.m_imageStore.put(num, drawable2);
        return drawable2;
    }

    public static Field getField(String str, String str2) {
        try {
            return Class.forName((str.indexOf(".") == -1 ? "com.glu.android." : "") + str).getField(str2);
        } catch (ClassNotFoundException e) {
            Debug.log("Error getting field (class): " + str + "." + str2 + "()", e);
            return null;
        } catch (NoSuchFieldException e2) {
            Debug.log("Error getting field (field): " + str + "." + str2 + "()", e2);
            return null;
        } catch (SecurityException e3) {
            Debug.log("Error getting field (security): " + str + "." + str2 + "()", e3);
            return null;
        }
    }

    public static String getFileDirectoryWithEnder(String str) {
        String strFilePathNoEnder = filePathNoEnder(str);
        return strFilePathNoEnder.lastIndexOf(47) == -1 ? "/" : strFilePathNoEnder.substring(0, strFilePathNoEnder.lastIndexOf(47) + 1);
    }

    private static String getIntHexNice$47921032() {
        String hexString = Integer.toHexString(R.raw.properties);
        while (hexString.length() < 8) {
            hexString = "0" + hexString;
        }
        return "0x" + hexString;
    }

    public static String getKilobyteString(int i) {
        return getBytesStringNice(i >> 10) + "KB";
    }

    public static String getLocalSaveDirectory() {
        Activity context = ResDL.getContext();
        ResDL.getContext();
        return filePathWithEnder(context.getDir("save", 0).getAbsolutePath());
    }

    public static Method getMethod(String str, String str2, Class[] clsArr) {
        try {
            return Class.forName((str.indexOf(".") == -1 ? "com.glu.android." : "") + str).getMethod(str2, clsArr);
        } catch (ClassNotFoundException e) {
            Debug.log("Error getting method (class): " + str + "." + str2 + "()", e);
            return null;
        } catch (NoSuchMethodException e2) {
            Debug.log("Error getting method (method): " + str + "." + str2 + "()", e2);
            return null;
        }
    }

    private static File getNativeFilePointer(String str) {
        return new File(getLocalSaveDirectory() + str);
    }

    /* JADX WARN: Code duplicated, block: B:56:0x0103 A[EXC_TOP_SPLITTER, SYNTHETIC] */
    public static CaseInsensitiveHash<String, String> getNativeProperties() throws Throwable {
        FileReader fileReader;
        FileReader fileReader2;
        int iIndexOf;
        try {
            Debug.log("Copying raw resource: " + getIntHexNice$47921032() + "   to tmpprop");
            byte[] bArr = new byte[8192];
            InputStream inputStreamOpenRawResource = ResDL.getContext().getResources().openRawResource(R.raw.properties);
            FileOutputStream fileOutputStream = new FileOutputStream(getNativeFilePointer("tmpprop"), false);
            while (true) {
                int i = inputStreamOpenRawResource.read(bArr);
                if (i == -1) {
                    break;
                }
                if (i > 0) {
                    fileOutputStream.write(bArr, 0, i);
                }
            }
            fileOutputStream.close();
            inputStreamOpenRawResource.close();
        } catch (Exception e) {
            Debug.log("Error: Could not copy file: tmpprop", e);
        }
        CaseInsensitiveHash<String, String> caseInsensitiveHash = new CaseInsensitiveHash<>();
        String absolutePath = getNativeFilePointer("tmpprop").getAbsolutePath();
        File file = new File(absolutePath);
        Debug.log("file=" + absolutePath + "    exists=" + file.exists());
        try {
            fileReader = new FileReader(file);
            while (true) {
                try {
                    String line = readLine(fileReader);
                    if (line == null) {
                        try {
                            break;
                        } catch (Exception e2) {
                        }
                    } else if (!line.startsWith("#") && (iIndexOf = line.indexOf("=")) != -1) {
                        caseInsensitiveHash.put(line.substring(0, iIndexOf).trim(), line.substring(iIndexOf + "=".length()).trim());
                    }
                } catch (Exception e3) {
                    fileReader2 = fileReader;
                    try {
                        Debug.log("Failed to get properties file.");
                        if (fileReader2 != null) {
                            try {
                                fileReader2.close();
                            } catch (Exception e4) {
                                caseInsensitiveHash = null;
                            }
                        }
                        caseInsensitiveHash = null;
                    } catch (Throwable th) {
                        fileReader = fileReader2;
                        th = th;
                        if (fileReader != null) {
                            try {
                                fileReader.close();
                            } catch (Exception e5) {
                            }
                        }
                        throw th;
                    }
                } catch (Throwable th2) {
                    th = th2;
                    if (fileReader != null) {
                        fileReader.close();
                    }
                    throw th;
                }
            }
            fileReader.close();
        } catch (Exception e6) {
            fileReader2 = null;
        } catch (Throwable th3) {
            th = th3;
            fileReader = null;
        }
        if (file.exists()) {
            file.delete();
        }
        return caseInsensitiveHash;
    }

    public static String getPrimaryResSDCardFilename() {
        return filePathWithEnder(getResourceSDDirFilename()) + GameLet.RESOURCE_FILENAME;
    }

    public static String getRelativeFilename(String str) {
        String strFilePathNoEnder = filePathNoEnder(str);
        return strFilePathNoEnder.lastIndexOf(47) == -1 ? strFilePathNoEnder : strFilePathNoEnder.substring(strFilePathNoEnder.lastIndexOf(47) + 1);
    }

    public static File getResourceSDDir() {
        String str = filePathNoEnder(Environment.getExternalStorageDirectory().getAbsolutePath()) + "/Android/";
        if (!testMKDIR(str)) {
            return null;
        }
        String str2 = str + "data/";
        if (!testMKDIR(str2)) {
            return null;
        }
        String str3 = str2 + GameLet.instance.m_packageID + "/";
        if (!testMKDIR(str3)) {
            return null;
        }
        String str4 = str3 + "files/";
        if (testMKDIR(str4)) {
            return new File(str4);
        }
        return null;
    }

    private static String getResourceSDDirFilename() {
        return filePathNoEnder(Environment.getExternalStorageDirectory().getAbsolutePath()) + "/Android/data/" + GameLet.instance.m_packageID + "/files/";
    }

    public static final int getScreenHeight() {
        return ResDL.sm_actualHeight;
    }

    public static final int getScreenWidth() {
        return ResDL.sm_actualWidth;
    }

    public static String getString(int i) {
        Activity context = ResDL.getContext();
        return context == null ? "null" : context.getResources().getString(i);
    }

    public static String getTempDiskFilename() {
        return getLocalSaveDirectory() + "gunbros_temp";
    }

    public static String getTempSDCardFilename() {
        return filePathWithEnder(getResourceSDDirFilename()) + "gunbros_temp";
    }

    public static String grabVersionString() throws Exception {
        String str = ResDL.getContext().getPackageManager().getPackageInfo(ResDL.getContext().getPackageName(), -1).versionName;
        Debug.log("Base version string: " + str);
        if (str.length() == 0) {
            return "";
        }
        char[] charArray = str.toCharArray();
        int i = 0;
        while (i < charArray.length && (charArray[i] == '.' || (charArray[i] >= '0' && charArray[i] <= '9'))) {
            i++;
        }
        return i == 0 ? "" : str.substring(0, i);
    }

    public static final boolean isAppPaused() {
        if (ResDL.getContext() == null) {
            return true;
        }
        return ResDL.getContext() != null && GameLet.instance.m_appPaused;
    }

    public static boolean isResourceFile(String str) {
        String relativeFilename = getRelativeFilename(str);
        if (relativeFilename.endsWith(".big")) {
            return true;
        }
        if (GameLet.SPECIAL_RES_FILENAME_ARRAY == null) {
            return false;
        }
        for (int i = 0; i < GameLet.SPECIAL_RES_FILENAME_ARRAY.length; i++) {
            if (GameLet.SPECIAL_RES_FILENAME_ARRAY[i].equals(relativeFilename)) {
                return true;
            }
        }
        return false;
    }

    public static boolean isUserOnWiFi() {
        NetworkInfo activeNetworkInfo = ((ConnectivityManager) ResDL.getContext().getSystemService("connectivity")).getActiveNetworkInfo();
        if (activeNetworkInfo != null && activeNetworkInfo.getType() == 1) {
            return true;
        }
        return false;
    }

    public static void openModalDialog(String str, String str2, String str3) {
        if (str == null) {
            str = getString(R.string.app_name);
        }
        GameLet.instance.m_modalDialogTitle = str;
        GameLet.instance.m_modalDialogText = safeString(str2);
        GameLet.instance.m_buttonOneText = str3;
        GameLet.instance.m_buttonTwoText = null;
        GameLet.instance.m_dialogCallback = null;
        GameLet.instance.handlerOpenModalDialog();
    }

    public static void paintButton(Canvas canvas, Rect rect, ColorFilter colorFilter, Vector<String> vector, Paint paint) {
        Drawable drawable = getDrawable(R.drawable.buttonl);
        Drawable drawable2 = getDrawable(R.drawable.buttonc);
        Drawable drawable3 = getDrawable(R.drawable.buttonr);
        if (colorFilter == null) {
            colorFilter = CF_BUTTON_DEFAULT;
        }
        drawable.setColorFilter(colorFilter);
        drawable2.setColorFilter(colorFilter);
        drawable3.setColorFilter(colorFilter);
        int intrinsicHeight = (int) (((rect.bottom - rect.top) / drawable.getIntrinsicHeight()) * drawable.getIntrinsicWidth());
        drawable.getIntrinsicHeight();
        int i = intrinsicHeight - (intrinsicHeight >> 2);
        int i2 = intrinsicHeight - i;
        drawImage(canvas, drawable, rect.left, rect.top, rect.left + intrinsicHeight, rect.bottom);
        for (int i3 = rect.left + intrinsicHeight; i3 + intrinsicHeight + i2 < rect.right; i3 += i) {
            drawImage(canvas, drawable2, i3, rect.top, i3 + intrinsicHeight, rect.bottom);
        }
        drawImage(canvas, drawable3, rect.right - intrinsicHeight, rect.top, rect.right, rect.bottom);
        float textSize = paint.getTextSize();
        int size = vector.size();
        float f = rect.top + ((rect.bottom - rect.top) / 2);
        for (int i4 = 0; i4 < size; i4++) {
            canvas.drawText(vector.elementAt(i4), rect.left + ((rect.right - rect.left) / 2), (i4 * textSize) + f + (textSize / 2.0f), paint);
        }
    }

    public static String performChecksum(File file) {
        return performChecksum(file, GameLet.RES_FILE_CHECKSUM_TO_USE, GameLet.RES_FILE_SIZE_TO_USE);
    }

    public static String performChecksum(File file, long j, long j2) {
        long j3 = 0;
        int i = 0;
        if (!file.exists() || file.isDirectory()) {
            Debug.devDie("performChecksum() to engineer: Stop passing me bad files!!\n" + file.getAbsolutePath());
        }
        try {
            FileInputStream fileInputStream = new FileInputStream(file);
            long length = file.length();
            if (length != j2) {
                Debug.log("File size check failed. Is " + length + ", expected " + j2);
                return String.format(getString(R.string.IDS_CHECKSUM_FAILED_SIZE), Long.valueOf(length), Long.valueOf(j2));
            }
            byte[] bArr = new byte[1024];
            while (i < length) {
                if ((i & 1024) != 0) {
                    fileInputStream.skip(130048L);
                    i += 130048;
                } else {
                    int i2 = fileInputStream.read(bArr);
                    int i3 = i;
                    long j4 = j3;
                    int i4 = i3;
                    for (int i5 = 0; i5 < i2; i5++) {
                        int i6 = bArr[i5];
                        if (i6 < 0) {
                            i6 += 256;
                        }
                        i4++;
                        j4 += (long) (i6 << (i4 & 15));
                    }
                    i = i4;
                    j3 = j4;
                }
            }
            Debug.log("Checksum result: " + j3 + "   expected: " + j + "   file: " + file.getAbsolutePath());
            if (j3 != j) {
                return String.format(getString(R.string.IDS_CHECKSUM_FAILED_CHECKSUM), Long.valueOf(j3));
            }
            Debug.log("Checksum passed.");
            return null;
        } catch (Exception e) {
            Debug.log("Checksum failed: " + e);
            return getString(R.string.IDS_DOWNLOAD_FAILED_GENERIC) + e.toString();
        }
    }

    private static String readLine(FileReader fileReader) throws Exception {
        StringBuffer stringBuffer = new StringBuffer("");
        while (true) {
            int i = fileReader.read();
            if (i == -1) {
                if (stringBuffer.toString().equals("")) {
                    return null;
                }
                return stringBuffer.toString().trim();
            }
            char c = (char) i;
            if (c == '\n') {
                return stringBuffer.toString().trim();
            }
            stringBuffer.append(c);
        }
    }

    private static int reflectedViewGetSystemUiVisibility(View view) {
        if (GameLet.instance.m_platformVersionI < 11) {
            return 8;
        }
        try {
            return ((Integer) getMethod("android.view.View", "getSystemUiVisibility", null).invoke(view, new Object[0])).intValue();
        } catch (Exception e) {
            Debug.log("Error with reflectedViewGetSystemUiVisibility", e);
            return 8;
        }
    }

    public static String safeString(String str) {
        return str == null ? "null" : str;
    }

    public static int safeStringToInt(String str) {
        if (str == null) {
            return 0;
        }
        try {
            return Integer.parseInt(str);
        } catch (Exception e) {
            return 0;
        }
    }

    public static String safeStringTruncate(String str, int i) {
        return str.length() <= i ? str : str.substring(0, i + 1);
    }

    public static int scaleRelativeToDroid(int i) {
        return (Math.min(ResDL.sm_actualWidth, ResDL.sm_actualHeight) * i) / 480;
    }

    public static int scaleRelativeToG1(int i) {
        return (Math.min(ResDL.sm_actualWidth, ResDL.sm_actualHeight) * i) / 320;
    }

    public static void sendNotification$3b99ba1a(String str, String str2) {
        Debug.log("Sending user notification id#1: " + str);
        Debug.log("Ticker: " + str);
        if (str.equals(str2)) {
            str = getString(R.string.app_name);
        }
        Activity context = ResDL.getContext();
        if (context == null) {
            return;
        }
        Notification notification = new Notification(R.drawable.icon, str2, System.currentTimeMillis() + 500);
        notification.setLatestEventInfo(context, str, str2, PendingIntent.getActivity(context, 0, new Intent(context, (Class<?>) GunBros.class), 0));
        notification.flags = 16;
        ResDL.getContext();
        ((NotificationManager) context.getSystemService("notification")).notify(1, notification);
    }

    public static Vector<String> simpleTokenizer(String str, String str2) {
        return simpleTokenizer(str, str2, null);
    }

    private static Vector<String> simpleTokenizer(String str, String str2, Vector<String> vector) {
        if (vector == null) {
            vector = new Vector<>();
        }
        int iIndexOf = -str2.length();
        int length = 0;
        while (true) {
            iIndexOf = str.indexOf(str2, iIndexOf + str2.length());
            if (iIndexOf == -1) {
                vector.addElement(str.substring(length));
                return vector;
            }
            vector.addElement(str.substring(length, iIndexOf));
            length = str2.length() + iIndexOf;
        }
    }

    public static void sleep(long j) {
        try {
            Thread.sleep(j);
        } catch (Exception e) {
            Debug.log("Sleep for " + j + "ms interrupted...somehow.", e);
        }
    }

    public static final byte[] stringToNativeByteArray(String str) {
        char[] charArray = str.toCharArray();
        byte[] bArr = new byte[charArray.length + 1];
        for (int i = 0; i < charArray.length; i++) {
            bArr[i] = (byte) charArray[i];
        }
        bArr[charArray.length] = 0;
        return bArr;
    }

    public static int sumIntArray(int[] iArr) {
        int i = 0;
        for (int i2 : iArr) {
            i += i2;
        }
        return i;
    }

    private static boolean testMKDIR(String str) {
        File file = new File(str);
        if (file.exists() && file.isDirectory()) {
            return true;
        }
        if (file.exists() && !file.isDirectory()) {
            return false;
        }
        file.mkdir();
        return file.exists() && file.isDirectory();
    }

    private static String viewVisibilityToString(int i) {
        if (i == 0) {
            return "VISIBLE";
        }
        if (i == 4) {
            return "INVISIBLE";
        }
        return i == 8 ? "GONE" : "UNKNOWN (" + i + ")";
    }

    public static Vector<String> wrapText(String str, int i, Paint paint) {
        Vector<String> vector = null;
        while (true) {
            Vector<String> vectorSimpleTokenizer = simpleTokenizer(str, "\n", null);
            Vector vector2 = new Vector();
            int i2 = 0;
            while (true) {
                int i3 = i2;
                if (i3 >= vectorSimpleTokenizer.size()) {
                    break;
                }
                simpleTokenizer(vectorSimpleTokenizer.elementAt(i3), " ", vector2);
                if (i3 + 1 != vectorSimpleTokenizer.size()) {
                    vector2.addElement("\n");
                }
                i2 = i3 + 1;
            }
            vector = vector == null ? new Vector<>() : vector;
            float f = i * 1.0f;
            int i4 = 0;
            while (i4 < vector2.size()) {
                int i5 = 0;
                int i6 = i4;
                String str2 = "";
                float f2 = 0.0f;
                while (true) {
                    int i7 = i5;
                    if (i6 < vector2.size()) {
                        if (!((String) vector2.elementAt(i6)).equals("\n")) {
                            float fMeasureText = paint.measureText(((String) vector2.elementAt(i6)) + (i7 == 0 ? "" : " "));
                            if (f2 + fMeasureText > f && i7 > 0) {
                                break;
                            }
                            if (fMeasureText > f) {
                                String str3 = (String) vector2.elementAt(i6);
                                int length = (int) (str3.length() * (f / fMeasureText));
                                if (length <= 0) {
                                    length = 1;
                                }
                                while (length != 1 && paint.measureText(str3.substring(0, length)) > f) {
                                    length--;
                                }
                                vector2.insertElementAt(str3.substring(0, length), i6);
                                vector2.setElementAt(str3.substring(length), i6 + 1);
                            }
                            f2 += fMeasureText;
                            str2 = str2 + (i7 == 0 ? "" : " ") + ((String) vector2.elementAt(i6));
                            i5 = i7 + 1;
                            i6++;
                        } else {
                            i6++;
                            break;
                        }
                    } else {
                        break;
                    }
                }
                vector.addElement(str2);
                i4 = i6;
            }
            if (vector.size() * paint.getTextSize() <= 1.0E8f) {
                break;
            }
            if (paint.getTextSize() <= 6.0f) {
                Debug.log("Warning: Cannot scale down wrapped text -- already down to size 6 or below. Your text will not fit.");
                Debug.log(str);
                break;
            }
            if (paint.getTextSize() > 12.0f) {
                paint.setTextSize(paint.getTextSize() - 2.0f);
            } else {
                paint.setTextSize(paint.getTextSize() - 1.0f);
            }
        }
        return vector;
    }

    public static void zero(byte[] bArr) {
        for (int i = 0; i < bArr.length; i++) {
            bArr[i] = 0;
        }
    }
}
