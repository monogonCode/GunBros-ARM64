package com.urbanairship.restclient;

import com.urbanairship.Logger;
import java.io.OutputStream;

/* JADX INFO: loaded from: classes.dex */
public abstract class AsyncHandler {
    public abstract void onComplete(Response response);

    public void onData(OutputStream outputStream) {
    }

    public void onError(Exception exc) {
        Logger.error("Request threw exception:", exc);
    }

    public void onProgress(int i) {
    }
}
