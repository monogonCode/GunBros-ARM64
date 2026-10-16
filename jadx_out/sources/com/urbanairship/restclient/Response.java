package com.urbanairship.restclient;

import com.urbanairship.Logger;
import java.io.IOException;
import java.io.InputStream;
import org.apache.http.Header;
import org.apache.http.HttpResponse;
import org.apache.http.util.EntityUtils;

/* JADX INFO: loaded from: classes.dex */
public class Response {
    String body;
    HttpResponse resp;

    public Response(HttpResponse httpResponse) {
        this.resp = httpResponse;
    }

    public String body() {
        if (this.body == null) {
            this.body = "";
            if (this.resp.getEntity() != null) {
                try {
                    this.body = EntityUtils.toString(this.resp.getEntity());
                } catch (IOException e) {
                    Logger.error("Error fetching HTTP entity: IO Exception");
                }
            }
        }
        return this.body;
    }

    public String contentType() {
        Header firstHeader = this.resp.getFirstHeader("Content-Type");
        return firstHeader != null ? firstHeader.getValue() : "";
    }

    public Header getFirstHeader(String str) {
        return this.resp.getFirstHeader(str);
    }

    public long length() {
        if (this.resp.getEntity() != null) {
            return this.resp.getEntity().getContentLength();
        }
        return 0L;
    }

    public InputStream rawBody() throws IllegalStateException, IOException {
        if (this.resp.getEntity() != null) {
            return this.resp.getEntity().getContent();
        }
        return null;
    }

    public String reason() {
        return this.resp.getStatusLine() != null ? this.resp.getStatusLine().getReasonPhrase() : "";
    }

    public int status() {
        if (this.resp.getStatusLine() != null) {
            return this.resp.getStatusLine().getStatusCode();
        }
        return -1;
    }
}
