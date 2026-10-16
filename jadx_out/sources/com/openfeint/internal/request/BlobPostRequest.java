package com.openfeint.internal.request;

import com.openfeint.internal.request.multipart.FilePart;
import com.openfeint.internal.request.multipart.MultipartHttpEntity;
import com.openfeint.internal.request.multipart.Part;
import com.openfeint.internal.request.multipart.PartSource;
import com.openfeint.internal.request.multipart.StringPart;
import com.openfeint.internal.resource.BlobUploadParameters;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.methods.HttpUriRequest;

/* JADX INFO: loaded from: classes.dex */
public class BlobPostRequest extends BaseRequest {
    String mContentType;
    private IRawRequestDelegate mDelegate;
    BlobUploadParameters mParams;
    protected PartSource mPartSource;

    public BlobPostRequest(BlobUploadParameters blobUploadParameters, PartSource partSource, String str) {
        super(null);
        this.mParams = blobUploadParameters;
        this.mPartSource = partSource;
        this.mContentType = str;
    }

    @Override // com.openfeint.internal.request.BaseRequest
    protected final HttpUriRequest generateRequest() {
        if (this.mPartSource == null) {
            return null;
        }
        HttpPost httpPost = new HttpPost(this.mParams.action);
        httpPost.setEntity(new MultipartHttpEntity(new Part[]{new StringPart("AWSAccessKeyId", this.mParams.AWSAccessKeyId), new StringPart("acl", this.mParams.acl), new StringPart("key", this.mParams.key), new StringPart("policy", this.mParams.policy), new StringPart("signature", this.mParams.signature), new FilePart("file", this.mPartSource, this.mContentType)}));
        addParams(httpPost);
        return httpPost;
    }

    @Override // com.openfeint.internal.request.BaseRequest
    public final String method() {
        return "POST";
    }

    @Override // com.openfeint.internal.request.BaseRequest
    public final void onResponse(int i, byte[] bArr) {
        if (this.mDelegate != null) {
            this.mDelegate.onResponse(i, new String(bArr));
        }
    }

    @Override // com.openfeint.internal.request.BaseRequest
    public final String path() {
        return "";
    }

    public final void setDelegate(IRawRequestDelegate iRawRequestDelegate) {
        this.mDelegate = iRawRequestDelegate;
    }

    @Override // com.openfeint.internal.request.BaseRequest
    public final boolean signed() {
        return false;
    }

    @Override // com.openfeint.internal.request.BaseRequest
    public final String url() {
        return this.mParams.action;
    }
}
