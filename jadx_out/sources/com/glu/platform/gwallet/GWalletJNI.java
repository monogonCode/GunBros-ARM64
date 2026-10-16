package com.glu.platform.gwallet;

import android.content.Context;
import android.util.Base64;
import android.util.Log;
import com.google.gson.Gson;
import com.loopj.android.http.AsyncHttpClient;
import com.loopj.android.http.AsyncHttpResponseHandler;
import java.io.UnsupportedEncodingException;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;
import org.apache.http.entity.StringEntity;

/* JADX INFO: loaded from: classes.dex */
public class GWalletJNI {
    private static AsyncHttpClient client = null;
    private static byte[] iv = {71, 108, 117, 32, 77, 111, 98, 105, 108, 101, 32, 71, 97, 109, 101, 115};
    private Context m_context;

    private static class InstanceHolder {
        public static GWalletJNI instance = new GWalletJNI();

        private InstanceHolder() {
        }
    }

    /* synthetic */ GWalletJNI() {
        this((byte) 0);
    }

    private GWalletJNI(byte b) {
    }

    public static final String Decrypt(String str, byte[] bArr) {
        try {
            byte[] bArrDecode = Base64.decode(str, 0);
            SecretKeySpec secretKeySpec = new SecretKeySpec(bArr, "AES");
            IvParameterSpec ivParameterSpec = new IvParameterSpec(iv);
            Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
            Log.d("GWallet.Decrypt", "cipher: " + cipher.toString());
            cipher.init(2, secretKeySpec, ivParameterSpec);
            byte[] bArrDoFinal = cipher.doFinal(bArrDecode);
            Log.d("GWallet.Decrypt", "decrypted size: " + bArrDoFinal.length);
            return new String(bArrDoFinal);
        } catch (InvalidAlgorithmParameterException e) {
            e.printStackTrace();
            Log.d("GWallet.Decrypt", "Exception: " + e.getMessage(), e);
            return null;
        } catch (InvalidKeyException e2) {
            e2.printStackTrace();
            Log.d("GWallet.Decrypt", "Exception: " + e2.getMessage(), e2);
            return null;
        } catch (NoSuchAlgorithmException e3) {
            e3.printStackTrace();
            Log.d("GWallet.Decrypt", "Exception: " + e3.getMessage(), e3);
            return null;
        } catch (BadPaddingException e4) {
            e4.printStackTrace();
            Log.d("GWallet.Decrypt", "Exception: " + e4.getMessage(), e4);
            return null;
        } catch (IllegalBlockSizeException e5) {
            e5.printStackTrace();
            Log.d("GWallet.Decrypt", "Exception: " + e5.getMessage(), e5);
            return null;
        } catch (NoSuchPaddingException e6) {
            e6.printStackTrace();
            Log.d("GWallet.Decrypt", "Exception: " + e6.getMessage(), e6);
            return null;
        }
    }

    public static final String Encrypt(String str, byte[] bArr) {
        try {
            SecretKeySpec secretKeySpec = new SecretKeySpec(bArr, "AES");
            IvParameterSpec ivParameterSpec = new IvParameterSpec(iv);
            Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
            Log.d("GWallet.Encrypt", "cipher: " + cipher.toString());
            cipher.init(1, secretKeySpec, ivParameterSpec);
            byte[] bArrDoFinal = cipher.doFinal(str.getBytes());
            Log.d("GWallet.Encrypt", "encrypted size: " + bArrDoFinal.length);
            return Base64.encodeToString(bArrDoFinal, 0);
        } catch (InvalidAlgorithmParameterException e) {
            e.printStackTrace();
            Log.d("GWallet.Encrypt", "Exception: " + e.getMessage(), e);
            return null;
        } catch (InvalidKeyException e2) {
            e2.printStackTrace();
            Log.d("GWallet.Encrypt", "Exception: " + e2.getMessage(), e2);
            return null;
        } catch (NoSuchAlgorithmException e3) {
            e3.printStackTrace();
            Log.d("GWallet.Encrypt", "Exception: " + e3.getMessage(), e3);
            return null;
        } catch (BadPaddingException e4) {
            e4.printStackTrace();
            Log.d("GWallet.Encrypt", "Exception: " + e4.getMessage(), e4);
            return null;
        } catch (IllegalBlockSizeException e5) {
            e5.printStackTrace();
            Log.d("GWallet.Encrypt", "Exception: " + e5.getMessage(), e5);
            return null;
        } catch (NoSuchPaddingException e6) {
            e6.printStackTrace();
            Log.d("GWallet.Encrypt", "Exception: " + e6.getMessage(), e6);
            return null;
        }
    }

    public static GWalletJNI getInstance() {
        return InstanceHolder.instance;
    }

    public static native void onHandleResponse(String str, int i);

    public final void GetContent(String str, String str2) {
        StringEntity stringEntity;
        Log.d("GWallet.GetContent", "enter");
        try {
            stringEntity = new StringEntity(str2);
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
            stringEntity = null;
        }
        Log.d("GWallet.GetContent", "URL : " + str);
        Log.d("GWallet.GetContent", "Request : " + str2);
        if (client == null) {
            client = new AsyncHttpClient();
        }
        client.put(getContext(), str, stringEntity, "application/json", new AsyncHttpResponseHandler() { // from class: com.glu.platform.gwallet.GWalletJNI.1
            @Override // com.loopj.android.http.AsyncHttpResponseHandler
            public final void onFailure(Throwable th) {
                Log.d("GWallet.GetContent", "onFailure", th);
                GWalletJNI.onHandleResponse("", 0);
            }

            @Override // com.loopj.android.http.AsyncHttpResponseHandler
            public final void onFinish() {
                Log.d("GWallet.GetContent", "onFinish");
                GWalletJNI.this.enableHTTPTransfers();
            }

            @Override // com.loopj.android.http.AsyncHttpResponseHandler
            public final void onStart() {
                Log.d("GWallet.GetContent", "onStart");
            }

            @Override // com.loopj.android.http.AsyncHttpResponseHandler
            public final void onSuccess(String str3) {
                Log.d("GWallet.GetContent", "onSuccess");
                Log.d("GWallet.GetContent", "response =" + str3);
                GWalletJNI.onHandleResponse(str3, str3.length());
            }
        });
        Log.d("GWallet.GetContent", "exit");
    }

    public String convertObjectToJSON(Object obj) {
        return new Gson().toJson(obj);
    }

    public native void enableHTTPTransfers();

    public Context getContext() {
        return this.m_context;
    }

    public void setContext(Context context) {
        this.m_context = context;
    }
}
