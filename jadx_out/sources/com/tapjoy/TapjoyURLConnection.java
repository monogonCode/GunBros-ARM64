package com.tapjoy;

import android.net.Uri;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.Hashtable;
import java.util.Map;
import org.apache.http.HttpResponse;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.params.BasicHttpParams;
import org.apache.http.params.HttpConnectionParams;
import org.apache.http.util.EntityUtils;

/* JADX INFO: loaded from: classes.dex */
public class TapjoyURLConnection {
    private static final String TAPJOY_URL_CONNECTION = "TapjoyURLConnection";

    public String connectToURL(String str) {
        return connectToURL(str, "");
    }

    public String connectToURL(String str, String str2) {
        String string;
        Exception e;
        try {
            String strReplaceAll = (str + str2).replaceAll(" ", "%20");
            TapjoyLog.i(TAPJOY_URL_CONNECTION, "baseURL: " + str);
            TapjoyLog.i(TAPJOY_URL_CONNECTION, "requestURL: " + strReplaceAll);
            HttpURLConnection httpURLConnection = (HttpURLConnection) new URL(strReplaceAll).openConnection();
            httpURLConnection.setConnectTimeout(15000);
            httpURLConnection.setReadTimeout(30000);
            String responseMessage = httpURLConnection.getResponseMessage();
            try {
                httpURLConnection.connect();
                BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(httpURLConnection.getInputStream()));
                StringBuilder sb = new StringBuilder();
                try {
                    while (true) {
                        String line = bufferedReader.readLine();
                        if (line == null) {
                            break;
                        }
                        sb.append(line + '\n');
                        TapjoyLog.e(TAPJOY_URL_CONNECTION, "Exception: " + e.toString());
                        return string;
                    }
                    TapjoyLog.i(TAPJOY_URL_CONNECTION, "--------------------");
                    TapjoyLog.i(TAPJOY_URL_CONNECTION, "response size: " + string.length());
                    TapjoyLog.i(TAPJOY_URL_CONNECTION, "response: ");
                    TapjoyLog.i(TAPJOY_URL_CONNECTION, "" + string);
                    TapjoyLog.i(TAPJOY_URL_CONNECTION, "--------------------");
                } catch (Exception e2) {
                    e = e2;
                    TapjoyLog.e(TAPJOY_URL_CONNECTION, "Exception: " + e.toString());
                }
                string = sb.toString();
            } catch (Exception e3) {
                string = responseMessage;
                e = e3;
            }
        } catch (Exception e4) {
            string = null;
            e = e4;
        }
        return string;
    }

    public String connectToURLwithPOST(String str, Hashtable<String, String> hashtable, Hashtable<String, String> hashtable2) {
        Exception e;
        String string;
        try {
            String strReplaceAll = str.replaceAll(" ", "%20");
            TapjoyLog.i(TAPJOY_URL_CONNECTION, "baseURL: " + str);
            TapjoyLog.i(TAPJOY_URL_CONNECTION, "requestURL: " + strReplaceAll);
            HttpPost httpPost = new HttpPost(strReplaceAll);
            ArrayList arrayList = new ArrayList();
            for (Map.Entry<String, String> entry : hashtable.entrySet()) {
                arrayList.add(new BasicNameValuePair(entry.getKey(), entry.getValue()));
                TapjoyLog.i(TAPJOY_URL_CONNECTION, "key: " + entry.getKey() + ", value: " + Uri.encode(entry.getValue()));
            }
            if (hashtable2 != null && hashtable2.size() > 0) {
                for (Map.Entry<String, String> entry2 : hashtable2.entrySet()) {
                    arrayList.add(new BasicNameValuePair("data[" + entry2.getKey() + "]", entry2.getValue()));
                    TapjoyLog.i(TAPJOY_URL_CONNECTION, "key: " + entry2.getKey() + ", value: " + Uri.encode(entry2.getValue()));
                }
            }
            httpPost.setEntity(new UrlEncodedFormEntity(arrayList));
            TapjoyLog.i(TAPJOY_URL_CONNECTION, "HTTP POST: " + httpPost.toString());
            BasicHttpParams basicHttpParams = new BasicHttpParams();
            HttpConnectionParams.setConnectionTimeout(basicHttpParams, 15000);
            HttpConnectionParams.setSoTimeout(basicHttpParams, 30000);
            HttpResponse httpResponseExecute = new DefaultHttpClient(basicHttpParams).execute(httpPost);
            string = EntityUtils.toString(httpResponseExecute.getEntity());
            try {
                TapjoyLog.i(TAPJOY_URL_CONNECTION, "--------------------");
                TapjoyLog.i(TAPJOY_URL_CONNECTION, "response status: " + httpResponseExecute.getStatusLine().getStatusCode());
                TapjoyLog.i(TAPJOY_URL_CONNECTION, "response size: " + string.length());
                TapjoyLog.i(TAPJOY_URL_CONNECTION, "response: ");
                TapjoyLog.i(TAPJOY_URL_CONNECTION, "" + string);
                TapjoyLog.i(TAPJOY_URL_CONNECTION, "--------------------");
            } catch (Exception e2) {
                e = e2;
                TapjoyLog.e(TAPJOY_URL_CONNECTION, "Exception: " + e.toString());
            }
        } catch (Exception e3) {
            e = e3;
            string = null;
        }
        return string;
    }

    public String getContentLength(String str) {
        String headerField;
        try {
            String strReplaceAll = str.replaceAll(" ", "%20");
            TapjoyLog.i(TAPJOY_URL_CONNECTION, "requestURL: " + strReplaceAll);
            HttpURLConnection httpURLConnection = (HttpURLConnection) new URL(strReplaceAll).openConnection();
            httpURLConnection.setConnectTimeout(15000);
            httpURLConnection.setReadTimeout(30000);
            headerField = httpURLConnection.getHeaderField("content-length");
        } catch (Exception e) {
            TapjoyLog.e(TAPJOY_URL_CONNECTION, "Exception: " + e.toString());
            headerField = null;
        }
        TapjoyLog.i(TAPJOY_URL_CONNECTION, "content-length: " + headerField);
        return headerField;
    }
}
