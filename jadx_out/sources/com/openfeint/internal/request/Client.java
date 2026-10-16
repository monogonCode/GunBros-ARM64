package com.openfeint.internal.request;

import android.os.Bundle;
import android.os.Handler;
import com.openfeint.internal.CookieStore;
import com.openfeint.internal.SyncedStore;
import com.openfeint.internal.logcat.OFLog;
import java.io.IOException;
import java.io.InputStream;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.LinkedBlockingQueue;
import java.util.concurrent.RejectedExecutionHandler;
import java.util.concurrent.ThreadPoolExecutor;
import java.util.concurrent.TimeUnit;
import java.util.zip.GZIPInputStream;
import org.apache.http.Header;
import org.apache.http.HeaderElement;
import org.apache.http.HttpEntity;
import org.apache.http.HttpException;
import org.apache.http.HttpRequest;
import org.apache.http.HttpRequestInterceptor;
import org.apache.http.HttpResponse;
import org.apache.http.HttpResponseInterceptor;
import org.apache.http.conn.scheme.PlainSocketFactory;
import org.apache.http.conn.scheme.Scheme;
import org.apache.http.conn.scheme.SchemeRegistry;
import org.apache.http.conn.ssl.SSLSocketFactory;
import org.apache.http.entity.HttpEntityWrapper;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.impl.conn.tsccm.ThreadSafeClientConnManager;
import org.apache.http.params.BasicHttpParams;
import org.apache.http.protocol.HttpContext;

/* JADX INFO: loaded from: classes.dex */
public final class Client extends DefaultHttpClient {
    private CookieStore mCookieStore;
    final ExecutorService mExecutor;
    private boolean mForceOffline;
    private Handler mMainThreadHandler;
    private Signer mSigner;

    private final class Executor extends ThreadPoolExecutor {
        Executor() {
            super(2, 4, 30L, TimeUnit.SECONDS, new LinkedBlockingQueue(), new RejectedExecutionHandler() { // from class: com.openfeint.internal.request.Client.Executor.1
                @Override // java.util.concurrent.RejectedExecutionHandler
                public final void rejectedExecution(Runnable runnable, ThreadPoolExecutor threadPoolExecutor) {
                    OFLog.e("HTTPClient", "Can't submit runnable " + runnable.toString());
                }
            });
        }
    }

    private static class GzipDecompressingEntity extends HttpEntityWrapper {
        public GzipDecompressingEntity(HttpEntity httpEntity) {
            super(httpEntity);
        }

        @Override // org.apache.http.entity.HttpEntityWrapper, org.apache.http.HttpEntity
        public final InputStream getContent() throws IllegalStateException, IOException {
            return new GZIPInputStream(this.wrappedEntity.getContent());
        }

        @Override // org.apache.http.entity.HttpEntityWrapper, org.apache.http.HttpEntity
        public final long getContentLength() {
            return -1L;
        }
    }

    public Client(String str, String str2, SyncedStore syncedStore) {
        SchemeRegistry schemeRegistry = new SchemeRegistry();
        schemeRegistry.register(new Scheme("http", PlainSocketFactory.getSocketFactory(), 80));
        schemeRegistry.register(new Scheme("https", SSLSocketFactory.getSocketFactory(), 443));
        super(new ThreadSafeClientConnManager(new BasicHttpParams(), schemeRegistry), new BasicHttpParams());
        this.mExecutor = new Executor();
        this.mSigner = new Signer(str, str2);
        this.mMainThreadHandler = new Handler();
        this.mCookieStore = new CookieStore(syncedStore);
        setCookieStore(this.mCookieStore);
        addRequestInterceptor(new HttpRequestInterceptor() { // from class: com.openfeint.internal.request.Client.1
            @Override // org.apache.http.HttpRequestInterceptor
            public final void process(HttpRequest httpRequest, HttpContext httpContext) throws HttpException, IOException {
                if (httpRequest.containsHeader("Accept-Encoding")) {
                    return;
                }
                httpRequest.addHeader("Accept-Encoding", "gzip");
            }
        });
        addResponseInterceptor(new HttpResponseInterceptor() { // from class: com.openfeint.internal.request.Client.2
            @Override // org.apache.http.HttpResponseInterceptor
            public final void process(HttpResponse httpResponse, HttpContext httpContext) throws HttpException, IOException {
                Header contentEncoding;
                HeaderElement[] elements;
                HttpEntity entity = httpResponse.getEntity();
                if (entity == null || (contentEncoding = entity.getContentEncoding()) == null || (elements = contentEncoding.getElements()) == null) {
                    return;
                }
                for (HeaderElement headerElement : elements) {
                    if (headerElement.getName().equalsIgnoreCase("gzip")) {
                        httpResponse.setEntity(new GzipDecompressingEntity(httpResponse.getEntity()));
                        return;
                    }
                }
            }
        });
    }

    public final void makeRequest(final BaseRequest baseRequest) {
        final long jTimeout = baseRequest.timeout();
        final Runnable runnable = new Runnable() { // from class: com.openfeint.internal.request.Client.3
            @Override // java.lang.Runnable
            public final void run() {
                baseRequest.onResponse();
            }
        };
        final Runnable runnable2 = new Runnable() { // from class: com.openfeint.internal.request.Client.4
            @Override // java.lang.Runnable
            public final void run() {
                if (baseRequest.getResponse() == null && baseRequest.getFuture().cancel(true)) {
                    baseRequest.postTimeoutCleanup();
                    Client.this.mMainThreadHandler.post(runnable);
                }
            }
        };
        baseRequest.setFuture(this.mExecutor.submit(new Runnable() { // from class: com.openfeint.internal.request.Client.5
            @Override // java.lang.Runnable
            public final void run() {
                Client.this.mMainThreadHandler.postDelayed(runnable2, jTimeout);
                baseRequest.sign(Client.this.mSigner);
                baseRequest.exec(Client.this.mForceOffline);
                Client.this.mMainThreadHandler.removeCallbacks(runnable2);
                Client.this.mMainThreadHandler.post(runnable);
            }
        }));
    }

    public final void restoreInstanceState(Bundle bundle) {
        this.mCookieStore.restoreInstanceState(bundle);
        this.mForceOffline = bundle.getBoolean("mForceOffline");
    }

    public final void saveInstanceState(Bundle bundle) {
        this.mCookieStore.saveInstanceState(bundle);
        bundle.putBoolean("mForceOffline", this.mForceOffline);
    }
}
