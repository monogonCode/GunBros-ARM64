package com.facebook.android;

import com.glu.platform.android.facebook.Debug;
import com.urbanairship.analytics.EventDataManager;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.net.MalformedURLException;
import org.json.JSONException;
import org.json.JSONObject;

/* JADX INFO: loaded from: classes.dex */
public abstract class AsyncRequestListener implements AsyncFacebookRunner.RequestListener {
    @Override // com.facebook.android.AsyncFacebookRunner.RequestListener
    public final void onComplete(String str) {
        String str2 = "Unparsed JSON for Facebook response:\n" + str;
        Debug.log$552c4e01();
        try {
            String str3 = "parsing JSON response: " + str;
            Debug.log$552c4e01();
            if (str.equals("false")) {
                throw new FacebookError("request failed");
            }
            if (str.equals("true")) {
                str = "{value : true}";
            }
            JSONObject jSONObject = new JSONObject(str);
            if (jSONObject.has("error")) {
                JSONObject jSONObject2 = jSONObject.getJSONObject("error");
                throw new FacebookError(jSONObject2.getString("message"), jSONObject2.getString(EventDataManager.Events.COLUMN_NAME_TYPE), 0);
            }
            if (jSONObject.has("error_code") && jSONObject.has("error_msg")) {
                throw new FacebookError(jSONObject.getString("error_msg"), "", Integer.parseInt(jSONObject.getString("error_code")));
            }
            if (jSONObject.has("error_code")) {
                throw new FacebookError("request failed", "", Integer.parseInt(jSONObject.getString("error_code")));
            }
            if (jSONObject.has("error_msg")) {
                throw new FacebookError(jSONObject.getString("error_msg"));
            }
            if (jSONObject.has("error_reason")) {
                throw new FacebookError(jSONObject.getString("error_reason"));
            }
            onComplete(jSONObject);
        } catch (FacebookError e) {
            String str4 = "Facebook Error:" + e.getMessage();
            Debug.log$16da05f7();
            wrapUp(false);
        } catch (JSONException e2) {
            e2.printStackTrace();
            String str5 = "JSON Error:" + e2.getMessage();
            Debug.log$16da05f7();
            wrapUp(false);
        }
    }

    public abstract void onComplete(JSONObject jSONObject);

    @Override // com.facebook.android.AsyncFacebookRunner.RequestListener
    public final void onFileNotFoundException(FileNotFoundException fileNotFoundException) {
        String str = "Resource not found:" + fileNotFoundException.getMessage();
        Debug.log$16da05f7();
        wrapUp(false);
    }

    @Override // com.facebook.android.AsyncFacebookRunner.RequestListener
    public final void onIOException(IOException iOException) {
        String str = "Network Error:" + iOException.getMessage();
        Debug.log$16da05f7();
        wrapUp(false);
    }

    @Override // com.facebook.android.AsyncFacebookRunner.RequestListener
    public final void onMalformedURLException(MalformedURLException malformedURLException) {
        String str = "Invalid URL:" + malformedURLException.getMessage();
        Debug.log$16da05f7();
        wrapUp(false);
    }

    public abstract void wrapUp(boolean z);
}
