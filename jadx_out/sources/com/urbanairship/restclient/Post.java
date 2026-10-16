package com.urbanairship.restclient;

import com.urbanairship.Logger;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.List;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.params.BasicHttpParams;
import org.apache.http.params.HttpConnectionParams;

/* JADX INFO: loaded from: classes.dex */
public class Post extends HttpPost {
    protected DefaultHttpClient httpclient;

    public Post(String str, List<BasicNameValuePair> list) {
        super(str);
        this.httpclient = null;
        BasicHttpParams basicHttpParams = new BasicHttpParams();
        this.httpclient = new DefaultHttpClient(basicHttpParams);
        HttpConnectionParams.setConnectionTimeout(basicHttpParams, 10000);
        try {
            setEntity(new UrlEncodedFormEntity(list, "UTF-8"));
        } catch (UnsupportedEncodingException e) {
            Logger.error("UTF-8 Unsupported.", e);
        }
    }

    public Response execute() throws IOException {
        return new Response(this.httpclient.execute(this));
    }
}
