package com.loopj.android.http;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.json.JSONTokener;

/* JADX INFO: loaded from: classes.dex */
public class JsonHttpResponseHandler extends AsyncHttpResponseHandler {
    @Override // com.loopj.android.http.AsyncHttpResponseHandler
    protected void handleSuccessMessage(String str) {
        super.handleSuccessMessage(str);
        try {
            Object response = parseResponse(str);
            if (response instanceof JSONObject) {
                onSuccess((JSONObject) response);
            } else if (response instanceof JSONArray) {
                onSuccess((JSONArray) response);
            }
        } catch (JSONException e) {
            onFailure(e);
        }
    }

    public void onSuccess(JSONArray jSONArray) {
    }

    public void onSuccess(JSONObject jSONObject) {
    }

    protected Object parseResponse(String str) throws JSONException {
        return new JSONTokener(str).nextValue();
    }
}
