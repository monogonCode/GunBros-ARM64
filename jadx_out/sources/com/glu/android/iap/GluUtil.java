package com.glu.android.iap;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.util.zip.CRC32;

/* JADX INFO: loaded from: classes.dex */
public final class GluUtil {
    private static byte[] getFileContentsAsByteArray(File file, int i) throws Exception {
        if (file.length() - ((long) i) > 8192) {
            Debug.log$552c4e01();
        }
        FileInputStream fileInputStream = new FileInputStream(file);
        byte[] bArr = new byte[((int) file.length()) - i];
        if (i != 0) {
            fileInputStream.skip(i);
        }
        fileInputStream.read(bArr);
        fileInputStream.close();
        return bArr;
    }

    public static String getSecureSaveDirectory() {
        String absolutePath = IAPJava.m_activity.getDir("etc", 0).getAbsolutePath();
        StringBuilder sb = new StringBuilder();
        if (absolutePath == null || absolutePath.equals("")) {
            absolutePath = ".";
        } else {
            if (absolutePath.endsWith("/")) {
                absolutePath = absolutePath.substring(0, absolutePath.length() - 1);
            }
            if (absolutePath == null || absolutePath.equals("")) {
                absolutePath = ".";
            }
        }
        return sb.append(absolutePath).append("/").toString();
    }

    public static File getTmpSecureFile() {
        return new File(getSecureSaveDirectory() + "tmp");
    }

    public static long readLong(FileInputStream fileInputStream) throws Exception {
        return (((long) fileInputStream.read()) << 56) | (((long) fileInputStream.read()) << 48) | (((long) fileInputStream.read()) << 40) | (((long) fileInputStream.read()) << 32) | (((long) fileInputStream.read()) << 24) | (((long) fileInputStream.read()) << 16) | (((long) fileInputStream.read()) << 8) | ((long) fileInputStream.read());
    }

    public static String readString(FileInputStream fileInputStream) throws Exception {
        int i;
        char[] cArr = new char[100];
        String str = "";
        int i2 = 0;
        while (true) {
            int i3 = fileInputStream.read();
            if (i3 != -1 && (i = fileInputStream.read()) != -1) {
                cArr[i2] = (char) (i3 | (i << 8));
                if (cArr[i2] == 0) {
                    break;
                }
                i2++;
                if (i2 == cArr.length) {
                    str = str + new String(cArr);
                    i2 = 0;
                }
            } else {
                break;
            }
        }
        if (i2 != 0) {
            str = str + new String(cArr, 0, i2);
        }
        if (str.equals("")) {
            return null;
        }
        return str;
    }

    public static boolean saveSecureFile(File file) {
        File tmpSecureFile = getTmpSecureFile();
        if (!tmpSecureFile.exists()) {
            Debug.log$552c4e01();
            return false;
        }
        try {
            byte[] fileContentsAsByteArray = getFileContentsAsByteArray(tmpSecureFile, 0);
            CRC32 crc32 = new CRC32();
            crc32.update(fileContentsAsByteArray);
            long value = crc32.getValue();
            FileOutputStream fileOutputStream = new FileOutputStream(file, false);
            writeLong(fileOutputStream, value);
            fileOutputStream.write(fileContentsAsByteArray);
            fileOutputStream.close();
            tmpSecureFile.delete();
            return true;
        } catch (Exception e) {
            Debug.log$2d473e19();
            return false;
        }
    }

    public static boolean verifySecureFile(File file) {
        if (!file.exists()) {
            Debug.log$552c4e01();
            return false;
        }
        try {
            byte[] fileContentsAsByteArray = getFileContentsAsByteArray(file, 8);
            CRC32 crc32 = new CRC32();
            crc32.update(fileContentsAsByteArray);
            long value = crc32.getValue();
            FileInputStream fileInputStream = new FileInputStream(file);
            long j = readLong(fileInputStream);
            fileInputStream.close();
            return value == j;
        } catch (Exception e) {
            Debug.log$2d473e19();
            return false;
        }
    }

    public static void writeLong(FileOutputStream fileOutputStream, long j) throws Exception {
        fileOutputStream.write((int) ((j >> 56) & 255));
        fileOutputStream.write((int) ((j >> 48) & 255));
        fileOutputStream.write((int) ((j >> 40) & 255));
        fileOutputStream.write((int) ((j >> 32) & 255));
        fileOutputStream.write((int) ((j >> 24) & 255));
        fileOutputStream.write((int) ((j >> 16) & 255));
        fileOutputStream.write((int) ((j >> 8) & 255));
        fileOutputStream.write((int) (j & 255));
    }

    public static void writeString(FileOutputStream fileOutputStream, String str) throws Exception {
        if (str != null) {
            char[] charArray = str.toCharArray();
            byte[] bArr = new byte[charArray.length << 1];
            for (int i = 0; i < charArray.length; i++) {
                bArr[i << 1] = (byte) (charArray[i] & 255);
                bArr[(i << 1) | 1] = (byte) (charArray[i] >> '\b');
            }
            fileOutputStream.write(bArr);
        }
        fileOutputStream.write(0);
        fileOutputStream.write(0);
    }
}
