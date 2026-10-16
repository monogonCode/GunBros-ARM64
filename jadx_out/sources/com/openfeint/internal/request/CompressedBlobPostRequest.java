package com.openfeint.internal.request;

import com.openfeint.internal.request.multipart.ByteArrayPartSource;
import com.openfeint.internal.resource.BlobUploadParameters;

/* JADX INFO: loaded from: classes.dex */
public final class CompressedBlobPostRequest extends BlobPostRequest {
    public CompressedBlobPostRequest(BlobUploadParameters blobUploadParameters, String str, byte[] bArr) {
        super(blobUploadParameters, new ByteArrayPartSource(str, Compression.compress(bArr)), "application/octet-stream");
    }
}
