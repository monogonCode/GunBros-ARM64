package com.urbanairship.restclient;

import java.io.IOException;
import java.io.InputStream;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.InputStreamEntity;
import org.apache.http.impl.client.DefaultHttpClient;

/* JADX INFO: loaded from: classes.dex */
public class PostInputStream extends HttpPost {
    protected DefaultHttpClient httpclient;

    public PostInputStream(String str, InputStream inputStream, Long l) {
        super(str);
        this.httpclient = new DefaultHttpClient();
        setEntity(new InputStreamEntity(inputStream, l.longValue()));
    }

    public Response execute() throws IOException {
        return new Response(this.httpclient.execute(this));
    }
}
