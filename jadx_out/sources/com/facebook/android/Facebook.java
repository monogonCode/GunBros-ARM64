package com.facebook.android;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.Context;
import android.os.Bundle;
import android.text.TextUtils;
import android.webkit.CookieManager;
import android.webkit.CookieSyncManager;
import com.glu.platform.android.facebook.Debug;
import com.tapjoy.TapjoyConstants;
import com.urbanairship.analytics.EventDataManager;
import java.io.IOException;

/* JADX INFO: loaded from: classes.dex */
public final class Facebook {
    protected static String DIALOG_BASE_URL = "https://m.facebook.com/dialog/";
    protected static String GRAPH_BASE_URL = "https://graph.facebook.com/";
    protected static String RESTSERVER_URL = "https://api.facebook.com/restserver.php";
    private String mAppId;
    private DialogListener mAuthDialogListener;
    private String mAccessToken = null;
    private long mAccessExpires = 0;

    public interface DialogListener {
        void onCancel();

        void onComplete(Bundle bundle);

        void onError(DialogError dialogError);

        void onFacebookError(FacebookError facebookError);
    }

    public Facebook(String str) {
        if (str == null) {
            throw new IllegalArgumentException("You must specify your application ID when instantiating a Facebook object. See README for details.");
        }
        this.mAppId = str;
    }

    public final void authorize(Activity activity, DialogListener dialogListener) {
        String[] strArr = new String[0];
        this.mAuthDialogListener = dialogListener;
        Bundle bundle = new Bundle();
        if (strArr.length > 0) {
            bundle.putString("scope", TextUtils.join(",", strArr));
        }
        CookieSyncManager.createInstance(activity);
        DialogListener dialogListener2 = new DialogListener() { // from class: com.facebook.android.Facebook.1
            @Override // com.facebook.android.Facebook.DialogListener
            public final void onCancel() {
                Debug.log$16da05f7();
                Facebook.this.mAuthDialogListener.onCancel();
            }

            @Override // com.facebook.android.Facebook.DialogListener
            public final void onComplete(Bundle bundle2) {
                CookieSyncManager.getInstance().sync();
                Facebook.this.setAccessToken(bundle2.getString("access_token"));
                Facebook.this.setAccessExpiresIn(bundle2.getString("expires_in"));
                if (!Facebook.this.isSessionValid()) {
                    Facebook.this.mAuthDialogListener.onFacebookError(new FacebookError("Failed to receive access token."));
                    return;
                }
                String str = "Login Success! access_token=" + Facebook.this.getAccessToken() + " expires=" + Facebook.this.getAccessExpires();
                Debug.log$16da05f7();
                Facebook.this.mAuthDialogListener.onComplete(bundle2);
            }

            @Override // com.facebook.android.Facebook.DialogListener
            public final void onError(DialogError dialogError) {
                String str = "Login failed: " + dialogError;
                Debug.log$16da05f7();
                Facebook.this.mAuthDialogListener.onError(dialogError);
            }

            @Override // com.facebook.android.Facebook.DialogListener
            public final void onFacebookError(FacebookError facebookError) {
                String str = "Login failed: " + facebookError;
                Debug.log$16da05f7();
                Facebook.this.mAuthDialogListener.onFacebookError(facebookError);
            }
        };
        String str = DIALOG_BASE_URL + "oauth";
        bundle.putString("display", "touch");
        bundle.putString("redirect_uri", "fbconnect://success");
        if ("oauth".equals("oauth")) {
            bundle.putString(EventDataManager.Events.COLUMN_NAME_TYPE, "user_agent");
            bundle.putString("client_id", this.mAppId);
        } else {
            bundle.putString(TapjoyConstants.TJC_APP_ID_NAME, this.mAppId);
        }
        if (isSessionValid()) {
            bundle.putString("access_token", this.mAccessToken);
        }
        String str2 = str + "?" + Util.encodeUrl(bundle);
        if (activity.checkCallingOrSelfPermission("android.permission.INTERNET") == 0) {
            new FbDialog(activity, str2, dialogListener2).show();
            return;
        }
        AlertDialog.Builder builder = new AlertDialog.Builder(activity);
        builder.setTitle("Error");
        builder.setMessage("Application requires permission to access the Internet");
        builder.create().show();
    }

    public final long getAccessExpires() {
        return this.mAccessExpires;
    }

    public final String getAccessToken() {
        return this.mAccessToken;
    }

    public final boolean isSessionValid() {
        return this.mAccessToken != null && (this.mAccessExpires == 0 || System.currentTimeMillis() < this.mAccessExpires);
    }

    public final String logout(Context context) throws IOException {
        CookieSyncManager.createInstance(context);
        CookieManager.getInstance().removeAllCookie();
        Bundle bundle = new Bundle();
        bundle.putString("method", "auth.expireSession");
        if (!bundle.containsKey("method")) {
            throw new IllegalArgumentException("API method must be specified. (parameters must contain key \"method\" and value). See http://developers.facebook.com/docs/reference/rest/");
        }
        String strRequest = request(null, bundle, "GET");
        this.mAccessToken = null;
        this.mAccessExpires = 0L;
        return strRequest;
    }

    public final String request(String str, Bundle bundle, String str2) throws IOException {
        bundle.putString("format", "json");
        if (isSessionValid()) {
            bundle.putString("access_token", this.mAccessToken);
        }
        return Util.openUrl(str != null ? GRAPH_BASE_URL + str : RESTSERVER_URL, str2, bundle);
    }

    public final void setAccessExpiresIn(String str) {
        if (str == null || str.equals("0")) {
            return;
        }
        this.mAccessExpires = System.currentTimeMillis() + ((long) (Integer.parseInt(str) * 1000));
    }

    public final void setAccessToken(String str) {
        this.mAccessToken = str;
    }
}
