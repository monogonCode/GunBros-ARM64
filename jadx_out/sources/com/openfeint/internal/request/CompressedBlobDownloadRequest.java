package com.openfeint.internal.request;

import com.openfeint.internal.OpenFeintInternal;
import com.openfeint.internal.RR;
import java.io.IOException;

/* JADX INFO: loaded from: classes.dex */
public abstract class CompressedBlobDownloadRequest extends DownloadRequest {
    @Override // com.openfeint.internal.request.DownloadRequest
    protected final void onSuccess(byte[] bArr) {
        try {
            onSuccessDecompress(Compression.decompress(bArr));
        } catch (IOException e) {
            onFailure(OpenFeintInternal.getRString(RR.string("of_io_exception_on_download")));
        }
    }

    protected abstract void onSuccessDecompress(byte[] bArr);
}
