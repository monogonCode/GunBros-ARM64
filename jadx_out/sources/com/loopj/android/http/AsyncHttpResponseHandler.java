package com.loopj.android.http;

import android.os.Handler;
import android.os.Looper;
import android.os.Message;
import java.io.IOException;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.StatusLine;
import org.apache.http.client.HttpResponseException;
import org.apache.http.entity.BufferedHttpEntity;
import org.apache.http.util.EntityUtils;

/* JADX INFO: loaded from: classes.dex */
public class AsyncHttpResponseHandler {
    private static final int FAILURE_MESSAGE = 1;
    private static final int FINISH_MESSAGE = 3;
    private static final int START_MESSAGE = 2;
    private static final int SUCCESS_MESSAGE = 0;
    private Handler handler;

    public AsyncHttpResponseHandler() {
        if (Looper.myLooper() != null) {
            this.handler = new Handler() { // from class: com.loopj.android.http.AsyncHttpResponseHandler.1
                @Override // android.os.Handler
                public void handleMessage(Message message) {
                    AsyncHttpResponseHandler.this.handleMessage(message);
                }
            };
        }
    }

    protected void handleFailureMessage(Throwable th) {
        onFailure(th);
    }

    protected void handleMessage(Message message) {
        switch (message.what) {
            case 0:
                handleSuccessMessage((String) message.obj);
                break;
            case 1:
                handleFailureMessage((Throwable) message.obj);
                break;
            case 2:
                onStart();
                break;
            case 3:
                onFinish();
                break;
        }
    }

    protected void handleSuccessMessage(String str) {
        onSuccess(str);
    }

    protected Message obtainMessage(int i, Object obj) {
        if (this.handler != null) {
            return this.handler.obtainMessage(i, obj);
        }
        Message message = new Message();
        message.what = i;
        message.obj = obj;
        return message;
    }

    public void onFailure(Throwable th) {
    }

    public void onFinish() {
    }

    public void onStart() {
    }

    public void onSuccess(String str) {
    }

    protected void sendFailureMessage(Throwable th) {
        sendMessage(obtainMessage(1, th));
    }

    protected void sendFinishMessage() {
        sendMessage(obtainMessage(3, null));
    }

    protected void sendMessage(Message message) {
        if (this.handler != null) {
            this.handler.sendMessage(message);
        } else {
            handleMessage(message);
        }
    }

    void sendResponseMessage(HttpResponse httpResponse) {
        StatusLine statusLine = httpResponse.getStatusLine();
        if (statusLine.getStatusCode() >= 300) {
            sendFailureMessage(new HttpResponseException(statusLine.getStatusCode(), statusLine.getReasonPhrase()));
            return;
        }
        try {
            HttpEntity entity = httpResponse.getEntity();
            sendSuccessMessage(EntityUtils.toString(entity != null ? new BufferedHttpEntity(entity) : null));
        } catch (IOException e) {
            sendFailureMessage(e);
        }
    }

    protected void sendStartMessage() {
        sendMessage(obtainMessage(2, null));
    }

    protected void sendSuccessMessage(String str) {
        sendMessage(obtainMessage(0, str));
    }
}
