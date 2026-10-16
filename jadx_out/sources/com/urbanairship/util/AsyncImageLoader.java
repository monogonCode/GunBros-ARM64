package com.urbanairship.util;

import android.graphics.drawable.Drawable;
import android.os.Handler;
import android.os.Message;
import com.urbanairship.Logger;
import java.io.IOException;
import java.io.InputStream;
import java.net.MalformedURLException;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.DefaultHttpClient;

/* JADX INFO: loaded from: classes.dex */
public class AsyncImageLoader {
    private Delegate delegate;

    public static abstract class Delegate {
        public abstract void imageLoaded(String str, Drawable drawable);
    }

    public AsyncImageLoader(String str, Delegate delegate) {
        this.delegate = delegate;
        fetchDrawableOnThread(str);
    }

    private InputStream fetch(String str) throws IllegalStateException, IOException {
        return new DefaultHttpClient().execute(new HttpGet(str)).getEntity().getContent();
    }

    /* JADX INFO: Access modifiers changed from: private */
    public Drawable fetchDrawable(String str) {
        try {
            return Drawable.createFromStream(fetch(str), "Async Image");
        } catch (MalformedURLException e) {
            Logger.error("fetchDrawable failed", e);
            return null;
        } catch (IOException e2) {
            Logger.error("fetchDrawable failed", e2);
            return null;
        } catch (IllegalStateException e3) {
            Logger.error("fetchDrawable failed", e3);
            return null;
        }
    }

    private void fetchDrawableOnThread(final String str) {
        final Handler handler = new Handler() { // from class: com.urbanairship.util.AsyncImageLoader.1
            @Override // android.os.Handler
            public void handleMessage(Message message) {
                if (((Drawable) message.obj) != null) {
                    AsyncImageLoader.this.delegate.imageLoaded(str, (Drawable) message.obj);
                }
            }
        };
        new Thread() { // from class: com.urbanairship.util.AsyncImageLoader.2
            @Override // java.lang.Thread, java.lang.Runnable
            public void run() {
                handler.sendMessage(handler.obtainMessage(1, AsyncImageLoader.this.fetchDrawable(str)));
            }
        }.start();
    }
}
