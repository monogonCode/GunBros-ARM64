package com.openfeint.internal.request;

import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import com.openfeint.internal.OpenFeintInternal;
import com.openfeint.internal.RR;

/* JADX INFO: loaded from: classes.dex */
public abstract class BitmapRequest extends DownloadRequest {
    public void onSuccess(Bitmap bitmap) {
    }

    @Override // com.openfeint.internal.request.DownloadRequest
    protected final void onSuccess(byte[] bArr) {
        Bitmap bitmapDecodeByteArray = BitmapFactory.decodeByteArray(bArr, 0, bArr.length);
        if (bitmapDecodeByteArray != null) {
            onSuccess(bitmapDecodeByteArray);
        } else {
            onFailure(OpenFeintInternal.getRString(RR.string("of_bitmap_decode_error")));
        }
    }
}
