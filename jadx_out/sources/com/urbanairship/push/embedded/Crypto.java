package com.urbanairship.push.embedded;

import java.security.NoSuchAlgorithmException;
import java.util.UUID;
import javax.crypto.Cipher;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;

/* JADX INFO: loaded from: classes.dex */
public class Crypto {
    private static final String algo = "AES/CBC/PKCS5Padding";
    private static final byte[] ivBytes = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
    private static final IvParameterSpec ivs = new IvParameterSpec(ivBytes);
    private Cipher cipher;
    private SecretKeySpec keySpec;

    public class NullUUID extends Exception {
        private static final long serialVersionUID = -2805631869260469310L;

        public NullUUID() {
        }
    }

    public Crypto(UUID uuid) throws NullUUID {
        if (uuid == null) {
            throw new NullUUID();
        }
        try {
            this.cipher = Cipher.getInstance(algo);
            this.keySpec = new SecretKeySpec(uuid.toString().replace("-", "").getBytes(), "AES");
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        } catch (NoSuchPaddingException e2) {
            e2.printStackTrace();
        }
    }

    public byte[] decrypt(byte[] bArr) {
        try {
            this.cipher.init(2, this.keySpec, ivs);
            return this.cipher.doFinal(bArr);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public byte[] encrypt(byte[] bArr) {
        try {
            this.cipher.init(1, this.keySpec, ivs);
            return this.cipher.doFinal(bArr);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}
