package com.glu.platform.android.facebook;

import android.graphics.LightingColorFilter;
import android.graphics.Paint;
import com.glu.platform.android.GluApplication;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.List;
import java.util.Random;

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
    private static boolean sm_shouldUseDMAActivity = false;
    private static boolean sm_shouldHideGameView = false;
    private static boolean sm_shouldShrinkGameView = false;
    private static boolean sm_canVideoViewHaveNegativeCoordinates = false;
    private static boolean sm_canVideoViewBeLargerThanScreen = false;
    private static boolean sm_canVideoViewSizeBeSlightlyInaccurate = false;
    public static boolean sm_canPlayVideo = false;

    public static boolean copyFile(File file, File file2) {
        return copyFile$c0646c4(file, file2);
    }

    private static boolean copyFile$c0646c4(File file, File file2) {
        String str = "Copying " + file.getAbsolutePath() + " to " + file2.getAbsolutePath();
        Debug.log$552c4e01();
        try {
            FileInputStream fileInputStream = new FileInputStream(file);
            FileOutputStream fileOutputStream = new FileOutputStream(file2, false);
            byte[] bArr = new byte[32768];
            while (true) {
                int i = fileInputStream.read(bArr);
                if (i <= 0) {
                    break;
                }
                fileOutputStream.write(bArr, 0, i);
            }
            fileInputStream.close();
            fileOutputStream.close();
            return file2.exists() && file.length() == file2.length();
        } catch (Exception e) {
            StringBuilder sbAppend = new StringBuilder().append("Warning: Cannot copy ");
            String strFilePathNoEnder = filePathNoEnder(file.getAbsolutePath());
            if (strFilePathNoEnder.lastIndexOf(47) != -1) {
                strFilePathNoEnder = strFilePathNoEnder.substring(strFilePathNoEnder.lastIndexOf(47) + 1);
            }
            sbAppend.append(strFilePathNoEnder).append(": ").append(e).toString();
            Debug.log$2d473e19();
            return false;
        }
    }

    public static final String filePathNoEnder(String str) {
        if (str == null || str.equals("")) {
            return ".";
        }
        String strSubstring = str.endsWith("/") ? str.substring(0, str.length() - 1) : str;
        return (strSubstring == null || strSubstring.equals("")) ? "." : strSubstring;
    }

    public static final String filePathWithEnder(String str) {
        return filePathNoEnder(str) + "/";
    }

    public static byte[] getByteArrayContentsFromURL$44c4d6c8(String str) {
        try {
            HttpURLConnection httpURLConnection = (HttpURLConnection) new URL(str).openConnection();
            httpURLConnection.setIfModifiedSince(0L);
            httpURLConnection.setReadTimeout(60000);
            return getByteArrayContentsFromURLConnection$f1df1a7(httpURLConnection);
        } catch (Exception e) {
            return null;
        }
    }

    private static byte[] getByteArrayContentsFromURLConnection$2c39be92(HttpURLConnection httpURLConnection, int i) {
        byte[] bArr = null;
        try {
            if (i == 200) {
                int contentLength$7c5bcde9 = getContentLength$7c5bcde9(httpURLConnection);
                String str = "contentLength=" + contentLength$7c5bcde9;
                Debug.log$552c4e01();
                InputStream inputStream = httpURLConnection.getInputStream();
                if (contentLength$7c5bcde9 > 0) {
                    byte[] bArr2 = new byte[contentLength$7c5bcde9];
                    inputStream.read(bArr2);
                    bArr = bArr2;
                } else {
                    Debug.log$552c4e01();
                    byte[] bArr3 = new byte[8192];
                    byte[] bArr4 = null;
                    while (true) {
                        int i2 = inputStream.read(bArr3);
                        if (i2 == -1) {
                            break;
                        }
                        String str2 = "readCount=" + i2;
                        Debug.log$552c4e01();
                        if (i2 > 0) {
                            if (bArr4 == null) {
                                bArr4 = new byte[i2];
                                System.arraycopy(bArr3, 0, bArr4, 0, i2);
                            } else {
                                byte[] bArr5 = new byte[bArr4.length + i2];
                                System.arraycopy(bArr4, 0, bArr5, 0, bArr4.length);
                                System.arraycopy(bArr3, 0, bArr5, bArr4.length, i2);
                                bArr4 = bArr5;
                            }
                        }
                    }
                    bArr = bArr4;
                }
                try {
                    inputStream.close();
                } catch (Exception e) {
                }
            } else {
                String str3 = "Bad response code: " + i;
                Debug.log$552c4e01();
            }
        } catch (Exception e2) {
        }
        return bArr;
    }

    private static byte[] getByteArrayContentsFromURLConnection$f1df1a7(HttpURLConnection httpURLConnection) {
        try {
            return getByteArrayContentsFromURLConnection$2c39be92(httpURLConnection, httpURLConnection.getResponseCode());
        } catch (Exception e) {
            return null;
        }
    }

    private static int getContentLength$7c5bcde9(HttpURLConnection httpURLConnection) {
        try {
            List<String> list = httpURLConnection.getHeaderFields().get("content-length");
            if (list != null && list.size() > 0) {
                try {
                    return Integer.parseInt(list.get(0));
                } catch (Exception e) {
                    Debug.log$2d473e19();
                }
            }
            return 0;
        } catch (Exception e2) {
            return 0;
        }
    }

    public static String getFacebookSaveDirectory() {
        GluApplication gluApplication = GluApplication.instance;
        GluApplication gluApplication2 = GluApplication.instance;
        return filePathWithEnder(gluApplication.getDir("fb", 0).getAbsolutePath());
    }

    public static String getFourByteHexNice$79bb807(byte[] bArr) {
        return (bArr == null || bArr.length <= 3) ? "invalid" : "0x" + Integer.toHexString((bArr[0] << 24) | (bArr[1] << 16) | (bArr[2] << 8) | bArr[3]);
    }

    public static int getMIMEType(byte[] bArr) {
        if (bArr[0] == -1 && bArr[1] == -40) {
            return 65496;
        }
        if (bArr[0] == -119 && bArr[1] == 80 && bArr[2] == 78 && bArr[3] == 71) {
            return -1991225785;
        }
        if (bArr[0] == 71 && bArr[1] == 73 && bArr[2] == 70 && bArr[3] == 56) {
            return 1195984440;
        }
        return (bArr[0] == 66 && bArr[1] == 77) ? 16973 : -1;
    }

    public static String getSecureSaveDirectory() {
        GluApplication gluApplication = GluApplication.instance;
        GluApplication gluApplication2 = GluApplication.instance;
        return filePathWithEnder(gluApplication.getDir("etc", 0).getAbsolutePath());
    }

    public static final String mimeTypeToExtension(int i) {
        if (i == 65496) {
            return ".jpg";
        }
        if (i == -1991225785) {
            return ".png";
        }
        if (i == 1195984440) {
            return ".gif";
        }
        return i == 16973 ? ".bmp" : "";
    }

    public static void rmrf(File file) {
        String str = "rmrf(" + file.getAbsolutePath() + ")";
        Debug.log$552c4e01();
        if (file.isDirectory()) {
            File[] fileArrListFiles = file.listFiles();
            if (fileArrListFiles == null) {
                Debug.log$552c4e01();
                return;
            }
            for (int i = 0; i < fileArrListFiles.length; i++) {
                boolean zIsDirectory = fileArrListFiles[i].isDirectory();
                if (zIsDirectory) {
                    rmrf(fileArrListFiles[i]);
                }
                if (fileArrListFiles[i].delete()) {
                    String str2 = "Deleted " + (zIsDirectory ? "directory" : "file") + " successfully: " + fileArrListFiles[i].getAbsolutePath();
                    Debug.log$552c4e01();
                } else {
                    String str3 = "!!!CANNOT DELETE " + (zIsDirectory ? "DIRECTORY" : "FILE") + "!!!: " + fileArrListFiles[i].getAbsolutePath();
                    Debug.log$552c4e01();
                }
            }
        }
    }

    public static void sleep$1349ef() {
        try {
            Thread.sleep(5000L);
        } catch (Exception e) {
            String str = "Sleep for 5000ms interrupted...somehow.";
            Debug.log$2d473e19();
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

    public static final char[] stringToNativeCharArray(String str) {
        char[] charArray = str.toCharArray();
        char[] cArr = new char[charArray.length + 1];
        for (int i = 0; i < charArray.length; i++) {
            cArr[i] = charArray[i];
        }
        cArr[charArray.length] = 0;
        return cArr;
    }

    public static void writeByteArray(FileOutputStream fileOutputStream, byte[] bArr) throws Exception {
        fileOutputStream.write(bArr);
    }
}
