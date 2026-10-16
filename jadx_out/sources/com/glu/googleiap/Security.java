package com.glu.googleiap;

import android.text.TextUtils;
import android.util.Log;
import com.glu.android.iap.Debug;
import com.glu.platform.gwallet.GWallet;
import java.security.InvalidKeyException;
import java.security.KeyFactory;
import java.security.NoSuchAlgorithmException;
import java.security.PublicKey;
import java.security.SecureRandom;
import java.security.Signature;
import java.security.SignatureException;
import java.security.spec.InvalidKeySpecException;
import java.security.spec.X509EncodedKeySpec;
import java.util.ArrayList;
import java.util.HashSet;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

/* JADX INFO: loaded from: classes.dex */
public final class Security {
    private static final SecureRandom RANDOM = new SecureRandom();
    public static String BASE64_ENCODED_PUBLIC_KEY = "MIIBIjANBgkqhkiG9w0-AQEFAAOCAQ8AMIIBCgKCAQEAgG4fY9m-0TnsxN+MdTxRoI02vluVL7x3u78rXbJ+aG+5RKQjZHlE4qGHLqSe7T+vZt4FfE+VaHr0tQtE/B+jZhkez1PNjlFeNrVhVGC/fPVtKefWPwDAz+AawrsVQmj3h0C-fyo-m09dCg2wWDnfq42Bz6CFZFyXybu130yKMh+lPnOkeksEKRt4+xFwFlG0jaJHQO3k86juuN9OO7tWlaOrmOo2+06Zutfkc9U6hun3nVO8nEpOBW3PnSMVPE4gLdIFBfb0epojPu5EIxoS5m10QvHllq1jVIlQ5LAYusmAgJjWeM0bDUp/TEey3SaIpFbni6JeNvjkJwFO5krN0wIDAQAB";
    private static HashSet<Long> sKnownNonces = new HashSet<>();

    public static class VerifiedPurchase {
        public String developerPayload;
        public String notificationId;
        public String orderId;
        public String productId;
        public Consts.PurchaseState purchaseState;
        public long purchaseTime;

        public VerifiedPurchase(Consts.PurchaseState purchaseState, String str, String str2, String str3, long j, String str4) {
            this.purchaseState = purchaseState;
            this.notificationId = str;
            this.productId = str2;
            this.orderId = str3;
            this.purchaseTime = j;
            this.developerPayload = str4;
        }
    }

    public static long generateNonce() {
        long jNextLong = RANDOM.nextLong();
        sKnownNonces.add(Long.valueOf(jNextLong));
        return jNextLong;
    }

    private static PublicKey generatePublicKey(String str) {
        try {
            return KeyFactory.getInstance("RSA").generatePublic(new X509EncodedKeySpec(Base64.decode(str)));
        } catch (Base64DecoderException e) {
            Debug.log$552c4e01();
            throw new IllegalArgumentException(e);
        } catch (NoSuchAlgorithmException e2) {
            throw new RuntimeException(e2);
        } catch (InvalidKeySpecException e3) {
            Debug.log$552c4e01();
            throw new IllegalArgumentException(e3);
        }
    }

    public static void removeNonce(long j) {
        sKnownNonces.remove(Long.valueOf(j));
    }

    private static boolean verify(PublicKey publicKey, String str, String str2) {
        try {
            Signature signature = Signature.getInstance("SHA1withRSA");
            signature.initVerify(publicKey);
            signature.update(str.getBytes());
            if (signature.verify(Base64.decode(str2))) {
                return true;
            }
            Debug.log$552c4e01();
            return false;
        } catch (Base64DecoderException e) {
            Debug.log$552c4e01();
            return false;
        } catch (InvalidKeyException e2) {
            Debug.log$552c4e01();
            return false;
        } catch (NoSuchAlgorithmException e3) {
            Debug.log$552c4e01();
            return false;
        } catch (SignatureException e4) {
            Debug.log$552c4e01();
            return false;
        }
    }

    public static ArrayList<VerifiedPurchase> verifyPurchase(String str, String str2) {
        if (str == null) {
            Debug.log$552c4e01();
            return null;
        }
        if (!TextUtils.isEmpty(str2)) {
            char[] charArray = BASE64_ENCODED_PUBLIC_KEY.toCharArray();
            for (int i = 0; i < charArray.length; i++) {
                if (charArray[i] == '-') {
                    charArray[i] = 'B';
                }
            }
            if (!verify(generatePublicKey(new String(charArray)), str, str2)) {
                Debug.log$552c4e01();
                return null;
            }
        }
        Debug.log$552c4e01();
        try {
            JSONObject jSONObject = new JSONObject(str);
            long jOptLong = jSONObject.optLong("nonce");
            JSONArray jSONArrayOptJSONArray = jSONObject.optJSONArray("orders");
            int length = jSONArrayOptJSONArray != null ? jSONArrayOptJSONArray.length() : 0;
            if (!sKnownNonces.contains(Long.valueOf(jOptLong))) {
                String str3 = "Nonce not found: " + jOptLong;
                Debug.log$552c4e01();
                return null;
            }
            ArrayList<VerifiedPurchase> arrayList = new ArrayList<>();
            for (int i2 = 0; i2 < length; i2++) {
                try {
                    String str4 = "Security.VerifyPurchase numTransactions - " + length;
                    Debug.log$552c4e01();
                    JSONObject jSONObject2 = jSONArrayOptJSONArray.getJSONObject(i2);
                    Consts.PurchaseState purchaseStateValueOf = Consts.PurchaseState.valueOf(jSONObject2.getInt("purchaseState"));
                    String string = jSONObject2.getString("productId");
                    jSONObject2.getString("packageName");
                    long j = jSONObject2.getLong("purchaseTime");
                    String strOptString = jSONObject2.optString("orderId", "");
                    String string2 = jSONObject2.has("notificationId") ? jSONObject2.getString("notificationId") : null;
                    String strOptString2 = jSONObject2.optString("developerPayload", null);
                    Log.e("GluGame", "product ID is " + string);
                    if (string.endsWith("monthly")) {
                        Log.e("GluGame", "XXX Sending to GWallet: " + str);
                        GWallet.getInstance().doSubscribe(null, str);
                    }
                    arrayList.add(new VerifiedPurchase(purchaseStateValueOf, string2, string, strOptString, j, strOptString2));
                } catch (JSONException e) {
                    Debug.log$2d473e19();
                    return null;
                }
            }
            removeNonce(jOptLong);
            return arrayList;
        } catch (JSONException e2) {
            Debug.log$552c4e01();
            return null;
        }
    }
}
