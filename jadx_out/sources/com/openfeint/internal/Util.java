package com.openfeint.internal;

import android.app.Activity;
import android.content.Context;
import android.os.Build;
import android.os.Environment;
import android.util.DisplayMetrics;
import android.view.WindowManager;
import com.google.protobuf.CodedOutputStream;
import com.openfeint.internal.logcat.OFLog;
import com.openfeint.internal.vendor.org.apache.commons.codec.binary.Base64;
import com.openfeint.internal.vendor.org.apache.commons.codec.binary.Hex;
import com.openfeint.internal.vendor.org.codehaus.jackson.JsonFactory;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.security.InvalidKeyException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;

/* JADX INFO: loaded from: classes.dex */
public final class Util {
    public static final int VERSION = Integer.valueOf(Build.VERSION.SDK).intValue();

    public static String base64HMACSHA1(String str, String str2) {
        if (str == null || str2 == null) {
            return null;
        }
        try {
            SecretKeySpec secretKeySpec = new SecretKeySpec(str.getBytes("UTF-8"), "HmacSHA1");
            Mac mac = Mac.getInstance("HmacSHA1");
            mac.init(secretKeySpec);
            return new String(Base64.encodeBase64(mac.doFinal(str2.getBytes("UTF-8"))));
        } catch (UnsupportedEncodingException e) {
            return null;
        } catch (InvalidKeyException e2) {
            return null;
        } catch (NoSuchAlgorithmException e3) {
            return null;
        }
    }

    public static void copyDirectory(File file, File file2) throws IOException {
        if (!file.isDirectory()) {
            copyFile(file, file2);
            return;
        }
        if (!file2.exists()) {
            file2.mkdir();
        }
        String[] list = file.list();
        for (int i = 0; i < list.length; i++) {
            copyDirectory(new File(file, list[i]), new File(file2, list[i]));
        }
    }

    public static void copyFile(File file, File file2) throws IOException {
        copyStream(new FileInputStream(file), new FileOutputStream(file2));
    }

    public static void copyStream(InputStream inputStream, OutputStream outputStream) throws IOException {
        copyStreamAndLeaveInputOpen(inputStream, outputStream);
        inputStream.close();
    }

    private static void copyStreamAndLeaveInputOpen(InputStream inputStream, OutputStream outputStream) throws IOException {
        byte[] bArr = new byte[16384];
        while (true) {
            int i = inputStream.read(bArr);
            if (i <= 0) {
                outputStream.close();
                return;
            }
            outputStream.write(bArr, 0, i);
        }
    }

    public static void deleteFiles(File file) {
        if (file.isDirectory()) {
            for (String str : file.list()) {
                deleteFiles(new File(file, str));
            }
        }
        file.delete();
    }

    public static DisplayMetrics getDisplayMetrics() {
        DisplayMetrics displayMetrics = new DisplayMetrics();
        ((WindowManager) OpenFeintInternal.getInstance().getContext().getSystemService("window")).getDefaultDisplay().getMetrics(displayMetrics);
        return displayMetrics;
    }

    public static String getDpiName(Context context) {
        DisplayMetrics displayMetrics = new DisplayMetrics();
        ((WindowManager) context.getSystemService("window")).getDefaultDisplay().getMetrics(displayMetrics);
        if (displayMetrics.density >= 2.0f) {
            return "udpi";
        }
        return ((double) displayMetrics.density) >= 1.5d ? "hdpi" : "mdpi";
    }

    public static Object getObjFromJson(byte[] bArr) {
        try {
            return new JsonResourceParser(new JsonFactory((byte) 0).createJsonParser(bArr)).parse();
        } catch (Exception e) {
            OFLog.e("Util", e.getMessage());
            return null;
        }
    }

    public static String hexSHA1(String str) {
        String str2;
        if (str == null) {
            return null;
        }
        try {
            str2 = new String(Hex.encodeHex(MessageDigest.getInstance("SHA1").digest(str.getBytes("UTF-8"))));
        } catch (UnsupportedEncodingException e) {
            str2 = null;
        } catch (NoSuchAlgorithmException e2) {
            str2 = null;
        }
        return str2;
    }

    private static boolean isSymblic(File file) {
        try {
            return !file.getCanonicalPath().equals(file.getAbsolutePath());
        } catch (IOException e) {
            return false;
        }
    }

    public static void moveWebCache(Context context) {
        if (noPermission("android.permission.WRITE_EXTERNAL_STORAGE", context)) {
            File file = new File(context.getCacheDir(), "webviewCache");
            if (isSymblic(file) || !"mounted".equals(Environment.getExternalStorageState())) {
                return;
            }
            File file2 = new File(Environment.getExternalStorageDirectory(), "openfeint/cache");
            if (!file2.exists()) {
                file2.mkdirs();
            }
            deleteFiles(file);
            String str = "ln -s " + file2.getAbsolutePath() + " " + file.getAbsolutePath();
            try {
                Runtime.getRuntime().exec(str);
                OFLog.i("Util", str);
            } catch (Exception e) {
                OFLog.e("Util", e.getMessage());
            }
        }
    }

    public static boolean noPermission(String str, Context context) {
        return -1 == context.getPackageManager().checkPermission(str, context.getPackageName());
    }

    public static boolean noSdcardPermission() {
        return noPermission("android.permission.WRITE_EXTERNAL_STORAGE", OpenFeintInternal.getInstance().getContext());
    }

    public static byte[] readWholeFile(String str) throws IOException {
        File file = new File(str);
        int length = (int) file.length();
        FileInputStream fileInputStream = new FileInputStream(file);
        byte[] bArr = new byte[length];
        fileInputStream.read(bArr);
        fileInputStream.close();
        return bArr;
    }

    public static void saveFile(byte[] bArr, String str) throws IOException {
        File file = new File(str);
        file.getParentFile().mkdirs();
        FileOutputStream fileOutputStream = new FileOutputStream(file);
        fileOutputStream.write(bArr);
        fileOutputStream.close();
    }

    public static void saveStreamAndLeaveInputOpen(InputStream inputStream, String str) throws IOException {
        File file = new File(str);
        file.getParentFile().mkdirs();
        copyStreamAndLeaveInputOpen(inputStream, new FileOutputStream(file));
    }

    public static boolean sdcardReady(Context context) {
        return noPermission("android.permission.WRITE_EXTERNAL_STORAGE", context) && "mounted".equals(Environment.getExternalStorageState());
    }

    public static void setOrientation(Activity activity) {
        Integer num = (Integer) OpenFeintInternal.getInstance().mSettings.settings.get("RequestedOrientation");
        if (num != null) {
            activity.setRequestedOrientation(num.intValue());
        }
    }

    public static final byte[] toByteArray(InputStream inputStream) throws IOException {
        byte[] bArr = new byte[CodedOutputStream.DEFAULT_BUFFER_SIZE];
        ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
        while (true) {
            int i = inputStream.read(bArr);
            if (i <= 0) {
                byteArrayOutputStream.close();
                return byteArrayOutputStream.toByteArray();
            }
            byteArrayOutputStream.write(bArr, 0, i);
        }
    }
}
