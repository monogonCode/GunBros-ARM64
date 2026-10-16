package com.loopj.android.http;

import java.io.IOException;
import java.net.ConnectException;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpRequestRetryHandler;
import org.apache.http.client.methods.HttpUriRequest;
import org.apache.http.impl.client.AbstractHttpClient;
import org.apache.http.protocol.HttpContext;

/* JADX INFO: loaded from: classes.dex */
class AsyncHttpRequest implements Runnable {
    private AbstractHttpClient client;
    private HttpContext context;
    private int executionCount;
    private HttpUriRequest request;
    private AsyncHttpResponseHandler responseHandler;

    public AsyncHttpRequest(AbstractHttpClient abstractHttpClient, HttpContext httpContext, HttpUriRequest httpUriRequest, AsyncHttpResponseHandler asyncHttpResponseHandler) {
        this.client = abstractHttpClient;
        this.context = httpContext;
        this.request = httpUriRequest;
        this.responseHandler = asyncHttpResponseHandler;
    }

    private void makeRequest() throws IOException {
        HttpResponse httpResponseExecute = this.client.execute(this.request, this.context);
        if (this.responseHandler != null) {
            this.responseHandler.sendResponseMessage(httpResponseExecute);
        }
    }

    private void makeRequestWithRetries() throws ConnectException {
        boolean zRetryRequest = true;
        IOException e = null;
        HttpRequestRetryHandler httpRequestRetryHandler = this.client.getHttpRequestRetryHandler();
        while (zRetryRequest) {
            try {
                makeRequest();
                return;
            } catch (IOException e2) {
                e = e2;
                int i = this.executionCount + 1;
                this.executionCount = i;
                zRetryRequest = httpRequestRetryHandler.retryRequest(e, i, this.context);
            } catch (NullPointerException e3) {
                e = new IOException("NPE in HttpClient" + e3.getMessage());
                int i2 = this.executionCount + 1;
                this.executionCount = i2;
                zRetryRequest = httpRequestRetryHandler.retryRequest(e, i2, this.context);
            }
        }
        ConnectException connectException = new ConnectException();
        connectException.initCause(e);
        throw connectException;
    }

    @Override // java.lang.Runnable
    public void run() {
        try {
            if (this.responseHandler != null) {
                this.responseHandler.sendStartMessage();
            }
            makeRequestWithRetries();
            if (this.responseHandler != null) {
                this.responseHandler.sendFinishMessage();
            }
        } catch (IOException e) {
            if (this.responseHandler != null) {
                this.responseHandler.sendFinishMessage();
                this.responseHandler.sendFailureMessage(e);
            }
        }
    }
}
