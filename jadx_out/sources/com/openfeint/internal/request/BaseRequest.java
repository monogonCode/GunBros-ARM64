package com.openfeint.internal.request;

import com.openfeint.internal.OpenFeintInternal;
import com.openfeint.internal.RR;
import com.openfeint.internal.logcat.OFLog;
import com.openfeint.internal.resource.ServerException;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.concurrent.Future;
import org.apache.http.Header;
import org.apache.http.HttpEntity;
import org.apache.http.HttpHost;
import org.apache.http.HttpResponse;
import org.apache.http.client.ResponseHandler;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpDelete;
import org.apache.http.client.methods.HttpEntityEnclosingRequestBase;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.methods.HttpPut;
import org.apache.http.client.methods.HttpUriRequest;
import org.apache.http.impl.client.AbstractHttpClient;
import org.apache.http.params.BasicHttpParams;
import org.apache.http.params.HttpParams;
import org.apache.http.protocol.BasicHttpContext;
import org.apache.http.util.EntityUtils;

/* JADX INFO: loaded from: classes.dex */
public abstract class BaseRequest {
    private static int DEFAULT_RETRIES = 2;
    private static long DEFAULT_TIMEOUT = 20000;
    protected static String TAG = "Request";
    private static String sBaseServerURL = null;
    protected OrderedArgList mArgs;
    private HttpUriRequest mRequest;
    private byte[] mResponseBody;
    private int mResponseCode;
    private long mSecondsSinceEpoch;
    private HttpResponse response_;
    private boolean mResponded = false;
    private String mResponseEncoding = null;
    private String mResponseType = null;
    private String mSignature = null;
    private String mKey = null;
    private int mRetriesLeft = 0;
    private String mCurrentURL = null;
    private Future<?> mFuture = null;
    private HttpParams mHttpParams = null;

    public BaseRequest() {
    }

    public BaseRequest(OrderedArgList orderedArgList) {
        this.mArgs = orderedArgList;
    }

    private void fakeServerException(ServerException serverException) {
        this.mResponseCode = 0;
        this.mResponseBody = serverException.generate().getBytes();
        this.mResponseType = "application/json;";
    }

    protected final void addParams(HttpUriRequest httpUriRequest) {
        if (this.mHttpParams != null) {
            httpUriRequest.setParams(this.mHttpParams);
        }
    }

    protected final String currentURL() {
        return this.mCurrentURL != null ? this.mCurrentURL : url();
    }

    /* JADX WARN: Code duplicated, block: B:19:0x00c3  */
    /* JADX WARN: Code duplicated, block: B:23:0x00aa A[SYNTHETIC] */
    /* JADX WARN: Code duplicated, block: B:29:0x0063 A[SYNTHETIC] */
    public final void exec(boolean z) {
        int i;
        ServerException serverException;
        this.mRequest = generateRequest();
        this.mRetriesLeft = numRetries();
        this.mResponseBody = null;
        this.mResponseCode = 0;
        this.response_ = null;
        if (this.mRequest.getURI().getPath().contains("//")) {
            ServerException serverException2 = new ServerException();
            serverException2.exceptionClass = "RequestError";
            serverException2.message = OpenFeintInternal.getRString(RR.string("of_malformed_request_error"));
            serverException2.needsDeveloperAttention = true;
            fakeServerException(serverException2);
        } else {
            while (this.mResponseBody == null) {
                if (z) {
                    this.mRetriesLeft = 0;
                    throw new Exception("Forced failure");
                }
                try {
                    AbstractHttpClient client = OpenFeintInternal.getInstance().getClient();
                    final BasicHttpContext basicHttpContext = new BasicHttpContext();
                    client.execute(this.mRequest, new ResponseHandler<Object>() { // from class: com.openfeint.internal.request.BaseRequest.1
                        @Override // org.apache.http.client.ResponseHandler
                        public final Object handleResponse(HttpResponse httpResponse) throws IOException {
                            HttpUriRequest httpUriRequest = (HttpUriRequest) basicHttpContext.getAttribute("http.request");
                            BaseRequest.this.mCurrentURL = ((HttpHost) basicHttpContext.getAttribute("http.target_host")).toURI() + httpUriRequest.getURI();
                            HttpEntity entity = httpResponse.getEntity();
                            BaseRequest.this.mResponseBody = new byte[0];
                            BaseRequest.this.mResponseCode = httpResponse.getStatusLine().getStatusCode();
                            if (entity != null) {
                                Header contentEncoding = entity.getContentEncoding();
                                if (contentEncoding != null) {
                                    BaseRequest.this.mResponseEncoding = contentEncoding.getValue();
                                }
                                Header contentType = entity.getContentType();
                                if (contentType != null) {
                                    BaseRequest.this.mResponseType = contentType.getValue();
                                }
                                BaseRequest.this.mResponseBody = EntityUtils.toByteArray(entity);
                                if (entity.getContentLength() >= 0 && entity.getContentLength() != BaseRequest.this.mResponseBody.length) {
                                    OFLog.e(BaseRequest.TAG, "Content-Length mismatch with content - " + BaseRequest.this.mRequest.getURI().toASCIIString());
                                    BaseRequest.this.mResponseCode = 0;
                                }
                            }
                            BaseRequest.this.response_ = httpResponse;
                            return null;
                        }
                    }, basicHttpContext);
                    this.mRequest = null;
                } catch (Exception e) {
                    OFLog.e(TAG, "Error executing request '" + path() + "'.");
                    e.printStackTrace(System.err);
                    this.mResponseBody = null;
                    this.mResponseCode = 0;
                    this.response_ = null;
                    i = this.mRetriesLeft - 1;
                    this.mRetriesLeft = i;
                    if (i < 0) {
                        serverException = new ServerException();
                        serverException.exceptionClass = e.getClass().getName();
                        serverException.message = e.getMessage();
                        if (serverException.message == null) {
                            serverException.message = OpenFeintInternal.getRString(RR.string("of_unknown_server_error"));
                        }
                        fakeServerException(serverException);
                        onResponseOffMainThread(this.mResponseCode, this.mResponseBody);
                    }
                }
                OFLog.e(TAG, "Error executing request '" + path() + "'.");
                e.printStackTrace(System.err);
                this.mResponseBody = null;
                this.mResponseCode = 0;
                this.response_ = null;
                i = this.mRetriesLeft - 1;
                this.mRetriesLeft = i;
                if (i < 0) {
                    serverException = new ServerException();
                    serverException.exceptionClass = e.getClass().getName();
                    serverException.message = e.getMessage();
                    if (serverException.message == null) {
                        serverException.message = OpenFeintInternal.getRString(RR.string("of_unknown_server_error"));
                    }
                    fakeServerException(serverException);
                    break;
                }
            }
        }
        onResponseOffMainThread(this.mResponseCode, this.mResponseBody);
    }

    protected HttpUriRequest generateRequest() {
        HttpUriRequest httpDelete;
        HttpEntityEnclosingRequestBase httpPut;
        String strMethod = method();
        if (strMethod.equals("GET") || strMethod.equals("DELETE")) {
            String strUrl = url();
            String argString = this.mArgs.getArgString();
            if (argString != null) {
                strUrl = strUrl + "?" + argString;
            }
            if (strMethod.equals("GET")) {
                httpDelete = new HttpGet(strUrl);
            } else {
                httpDelete = strMethod.equals("DELETE") ? new HttpDelete(strUrl) : null;
            }
        } else {
            if (strMethod.equals("POST")) {
                httpPut = new HttpPost(url());
            } else {
                if (!strMethod.equals("PUT")) {
                    throw new RuntimeException("Unsupported HTTP method: " + strMethod);
                }
                httpPut = new HttpPut(url());
            }
            try {
                UrlEncodedFormEntity urlEncodedFormEntity = new UrlEncodedFormEntity(this.mArgs.mArgs, "UTF-8");
                urlEncodedFormEntity.setContentType("application/x-www-form-urlencoded; charset=UTF-8");
                httpPut.setEntity(urlEncodedFormEntity);
                httpDelete = httpPut;
            } catch (UnsupportedEncodingException e) {
                OFLog.e(TAG, "Unable to encode request.");
                e.printStackTrace(System.err);
                httpDelete = httpPut;
            }
        }
        if (signed() && this.mSignature != null && this.mKey != null) {
            httpDelete.addHeader("X-OF-Signature", this.mSignature);
            httpDelete.addHeader("X-OF-Key", this.mKey);
        }
        addParams(httpDelete);
        return httpDelete;
    }

    public final Future<?> getFuture() {
        return this.mFuture;
    }

    protected final HttpParams getHttpParams() {
        if (this.mHttpParams == null) {
            this.mHttpParams = new BasicHttpParams();
        }
        return this.mHttpParams;
    }

    public final HttpResponse getResponse() {
        return this.response_;
    }

    protected final String getResponseType() {
        return this.mResponseType;
    }

    public final void launch() {
        OpenFeintInternal.makeRequest(this);
    }

    public abstract String method();

    public boolean needsDeviceSession() {
        return signed();
    }

    public int numRetries() {
        return DEFAULT_RETRIES;
    }

    public final void onResponse() {
        if (this.mResponded) {
            return;
        }
        this.mResponded = true;
        if (this.mResponseBody == null) {
            this.mResponseCode = 0;
            ServerException serverException = new ServerException();
            serverException.exceptionClass = "Unknown";
            serverException.message = OpenFeintInternal.getRString(RR.string("of_unknown_server_error"));
            fakeServerException(serverException);
        }
        onResponse(this.mResponseCode, this.mResponseBody);
        this.response_ = null;
    }

    public abstract void onResponse(int i, byte[] bArr);

    protected void onResponseOffMainThread(int i, byte[] bArr) {
    }

    public abstract String path();

    public final void postTimeoutCleanup() {
        final HttpUriRequest httpUriRequest = this.mRequest;
        this.mRequest = null;
        if (httpUriRequest != null) {
            new Thread(new Runnable() { // from class: com.openfeint.internal.request.BaseRequest.2
                @Override // java.lang.Runnable
                public final void run() {
                    try {
                        httpUriRequest.abort();
                    } catch (UnsupportedOperationException e) {
                    }
                }
            }).start();
        }
        ServerException serverException = new ServerException();
        serverException.exceptionClass = "Timeout";
        serverException.message = OpenFeintInternal.getRString(RR.string("of_timeout"));
        fakeServerException(serverException);
    }

    public final void setArgs(OrderedArgList orderedArgList) {
        this.mArgs = orderedArgList;
    }

    public final void setFuture(Future<?> future) {
        this.mFuture = future;
    }

    public final void sign(Signer signer) {
        if (this.mArgs == null) {
            this.mArgs = new OrderedArgList();
        }
        if (signed()) {
            this.mSecondsSinceEpoch = System.currentTimeMillis() / 1000;
            String strPath = path();
            String strMethod = method();
            long j = this.mSecondsSinceEpoch;
            this.mSignature = signer.sign$32bca35c(strPath, strMethod, this.mArgs);
            this.mKey = signer.getKey();
        }
    }

    public boolean signed() {
        return true;
    }

    public long timeout() {
        return DEFAULT_TIMEOUT;
    }

    public String url() {
        StringBuilder sb = new StringBuilder();
        if (sBaseServerURL == null) {
            sBaseServerURL = OpenFeintInternal.getInstance().getServerUrl();
        }
        return sb.append(sBaseServerURL).append(path()).toString();
    }

    public boolean wantsLogin() {
        return false;
    }
}
