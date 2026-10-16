package com.urbanairship.restclient;

import android.os.AsyncTask;
import android.os.Handler;
import android.os.Looper;
import com.urbanairship.Logger;
import com.urbanairship.restclient.ssl.PermissiveSSLSocketFactory;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URI;
import org.apache.http.auth.AuthScope;
import org.apache.http.auth.AuthenticationException;
import org.apache.http.auth.UsernamePasswordCredentials;
import org.apache.http.client.methods.HttpEntityEnclosingRequestBase;
import org.apache.http.conn.scheme.PlainSocketFactory;
import org.apache.http.conn.scheme.Scheme;
import org.apache.http.conn.scheme.SchemeRegistry;
import org.apache.http.impl.auth.BasicScheme;
import org.apache.http.impl.client.BasicCredentialsProvider;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.impl.conn.SingleClientConnManager;
import org.apache.http.params.BasicHttpParams;
import org.apache.http.params.HttpConnectionParams;

/* JADX INFO: loaded from: classes.dex */
public class Request extends HttpEntityEnclosingRequestBase {
    private static final int BUFFER_SIZE = 8192;
    private static final int DEFAULT_SOCKET_BUFFER_SIZE = 16384;
    private static final int DEFAULT_TIMEOUT_MS = 60000;
    private static final long MAX_PREFETCH_BODY_LENGTH = 1048576;
    public static boolean verifySSLHostnames = true;
    File destination;
    DefaultHttpClient httpClient;
    String method;

    private class BackgroundRequest extends AsyncTask<Request, Integer, Response> {
        private AsyncHandler handler;

        public BackgroundRequest(AsyncHandler asyncHandler) {
            this.handler = asyncHandler;
        }

        /* JADX INFO: Access modifiers changed from: protected */
        @Override // android.os.AsyncTask
        public Response doInBackground(Request... requestArr) {
            int i = 0;
            if (requestArr.length > 1) {
                throw new RuntimeException("Background Request only handles executing one Request at a time ");
            }
            if (0 >= requestArr.length) {
                return null;
            }
            try {
                Response responseExecute = requestArr[0].execute();
                if (responseExecute == null) {
                    return responseExecute;
                }
                if (Request.this.destination == null) {
                    if (responseExecute.length() >= Request.MAX_PREFETCH_BODY_LENGTH) {
                        return responseExecute;
                    }
                    responseExecute.body();
                    return responseExecute;
                }
                Request.this.destination.getParentFile().mkdirs();
                long length = responseExecute.length();
                InputStream inputStreamRawBody = responseExecute.rawBody();
                FileOutputStream fileOutputStream = new FileOutputStream(Request.this.destination);
                byte[] bArr = new byte[Request.BUFFER_SIZE];
                while (true) {
                    int i2 = inputStreamRawBody.read(bArr);
                    if (i2 == -1) {
                        fileOutputStream.flush();
                        inputStreamRawBody.close();
                        fileOutputStream.close();
                        return responseExecute;
                    }
                    i += i2;
                    fileOutputStream.write(bArr, 0, i2);
                    publishProgress(Integer.valueOf((int) ((i / length) * 100.0f)));
                }
            } catch (Exception e) {
                Logger.error(e);
                return null;
            }
        }

        /* JADX INFO: Access modifiers changed from: protected */
        @Override // android.os.AsyncTask
        public void onPostExecute(Response response) {
            if (response != null) {
                this.handler.onComplete(response);
            } else {
                this.handler.onError(new Exception("Error when executing request."));
            }
        }

        /* JADX INFO: Access modifiers changed from: protected */
        @Override // android.os.AsyncTask
        public void onProgressUpdate(Integer... numArr) {
            this.handler.onProgress(numArr[0].intValue());
        }
    }

    public Request(String str, String str2) {
        this.method = str;
        setURI(URI.create(str2));
        this.params = new BasicHttpParams();
        if (verifySSLHostnames) {
            this.httpClient = new DefaultHttpClient(this.params);
        } else {
            Logger.error("Verify SSL Cert: false");
            SchemeRegistry schemeRegistry = new SchemeRegistry();
            schemeRegistry.register(new Scheme("http", PlainSocketFactory.getSocketFactory(), 80));
            schemeRegistry.register(new Scheme("https", new PermissiveSSLSocketFactory(), 443));
            this.httpClient = new DefaultHttpClient(new SingleClientConnManager(this.params, schemeRegistry), this.params);
        }
        HttpConnectionParams.setSocketBufferSize(this.params, DEFAULT_SOCKET_BUFFER_SIZE);
        setTimeout(60000);
        Logger.verbose("Set Timeout: " + HttpConnectionParams.getConnectionTimeout(this.httpClient.getParams()));
        Logger.verbose("Set Socket Buffer Size: " + HttpConnectionParams.getSocketBufferSize(this.httpClient.getParams()));
    }

    public Response execute() {
        try {
            return new Response(this.httpClient.execute(this));
        } catch (IOException e) {
            Logger.error("Error when executing request: " + e.getMessage());
            return null;
        }
    }

    public void executeAsync(final AsyncHandler asyncHandler) {
        new Handler(Looper.getMainLooper()).post(new Runnable() { // from class: com.urbanairship.restclient.Request.1
            @Override // java.lang.Runnable
            public void run() {
                Request.this.new BackgroundRequest(asyncHandler).execute(this);
            }
        });
    }

    @Override // org.apache.http.client.methods.HttpRequestBase, org.apache.http.client.methods.HttpUriRequest
    public String getMethod() {
        return this.method;
    }

    public void setAuth(String str, String str2) {
        UsernamePasswordCredentials usernamePasswordCredentials = new UsernamePasswordCredentials(str, str2);
        BasicCredentialsProvider basicCredentialsProvider = new BasicCredentialsProvider();
        basicCredentialsProvider.setCredentials(AuthScope.ANY, usernamePasswordCredentials);
        this.httpClient.setCredentialsProvider(basicCredentialsProvider);
    }

    public void setDestination(File file) {
        this.destination = file;
    }

    public void setPreemptiveAuth(String str, String str2) {
        try {
            addHeader(new BasicScheme().authenticate(new UsernamePasswordCredentials(str, str2), this));
        } catch (AuthenticationException e) {
            Logger.error("Attempted to set invalid or non-applicable request credentials", e);
        }
    }

    public void setSocketBufferSize(int i) {
        HttpConnectionParams.setSocketBufferSize(this.params, i);
    }

    public void setTimeout(int i) {
        HttpConnectionParams.setConnectionTimeout(this.params, i);
    }
}
