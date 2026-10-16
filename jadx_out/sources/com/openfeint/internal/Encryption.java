package com.openfeint.internal;

import com.openfeint.internal.logcat.OFLog;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.security.SecureRandom;
import java.util.Arrays;
import javax.crypto.Cipher;
import javax.crypto.CipherInputStream;
import javax.crypto.CipherOutputStream;
import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.PBEKeySpec;
import javax.crypto.spec.PBEParameterSpec;

/* JADX INFO: loaded from: classes.dex */
public final class Encryption {
    private static SecretKey secretKey;

    public static CipherInputStream decryptionWrap(InputStream inputStream) {
        try {
            byte[] bArr = new byte[10];
            if (inputStream.read(bArr) != 10) {
                throw new Exception("Couldn't read entire salt");
            }
            PBEParameterSpec pBEParameterSpec = new PBEParameterSpec(bArr, 10);
            Cipher cipher = Cipher.getInstance("PBEWithSHA256And256BitAES-CBC-BC");
            cipher.init(2, secretKey, pBEParameterSpec);
            return new CipherInputStream(inputStream, cipher);
        } catch (Exception e) {
            OFLog.e("Encryption", e.getMessage());
            return null;
        }
    }

    public static CipherOutputStream encryptionWrap(OutputStream outputStream) {
        try {
            byte[] bArr = new byte[10];
            new SecureRandom().nextBytes(bArr);
            outputStream.write(bArr);
            PBEParameterSpec pBEParameterSpec = new PBEParameterSpec(bArr, 10);
            Cipher cipher = Cipher.getInstance("PBEWithSHA256And256BitAES-CBC-BC");
            cipher.init(1, secretKey, pBEParameterSpec);
            return new CipherOutputStream(outputStream, cipher);
        } catch (Exception e) {
            OFLog.e("Encryption", e.getMessage());
            return null;
        }
    }

    public static boolean init(String str) {
        try {
            secretKey = SecretKeyFactory.getInstance("PBEWithSHA256And256BitAES-CBC-BC").generateSecret(new PBEKeySpec(str.toCharArray()));
            byte[] bytes = "PBEWithSHA256And256BitAES-CBC-BC".getBytes();
            ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
            CipherOutputStream cipherOutputStreamEncryptionWrap = encryptionWrap(byteArrayOutputStream);
            cipherOutputStreamEncryptionWrap.write(bytes);
            cipherOutputStreamEncryptionWrap.close();
            byte[] byteArray = byteArrayOutputStream.toByteArray();
            if (byteArray.length == 0) {
                throw new Exception();
            }
            if (Arrays.equals(Util.toByteArray(decryptionWrap(new ByteArrayInputStream(byteArray))), bytes)) {
                return true;
            }
            throw new Exception();
        } catch (Exception e) {
            secretKey = null;
            return false;
        }
    }

    public static boolean initialized() {
        return secretKey != null;
    }
}
