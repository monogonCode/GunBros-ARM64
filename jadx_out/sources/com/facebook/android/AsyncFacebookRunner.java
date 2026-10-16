package com.facebook.android;

import android.os.Bundle;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.net.MalformedURLException;

/* JADX INFO: loaded from: classes.dex */
public final class AsyncFacebookRunner {
    Facebook fb;

    public interface RequestListener {
        void onComplete(String str);

        void onFileNotFoundException(FileNotFoundException fileNotFoundException);

        void onIOException(IOException iOException);

        void onMalformedURLException(MalformedURLException malformedURLException);
    }

    public AsyncFacebookRunner(Facebook facebook) {
        this.fb = facebook;
    }

    /* JADX WARN: Type inference failed for: r0v0, types: [com.facebook.android.AsyncFacebookRunner$2] */
    public final void request(final String str, final RequestListener requestListener) {
        final Bundle bundle = new Bundle();
        final String str2 = "GET";
        new Thread() { // from class: com.facebook.android.AsyncFacebookRunner.2
            @Override // java.lang.Thread, java.lang.Runnable
            public final void run() {
                try {
                    requestListener.onComplete(AsyncFacebookRunner.this.fb.request(str, bundle, str2));
                } catch (FileNotFoundException e) {
                    requestListener.onFileNotFoundException(e);
                } catch (MalformedURLException e2) {
                    requestListener.onMalformedURLException(e2);
                } catch (IOException e3) {
                    requestListener.onIOException(e3);
                }
            }
        }.start();
    }
}
