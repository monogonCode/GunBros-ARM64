package com.openfeint.internal.request.multipart;

import com.openfeint.internal.logcat.OFLog;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Random;
import org.apache.http.Header;
import org.apache.http.HttpEntity;
import org.apache.http.message.BasicHeader;

/* JADX INFO: loaded from: classes.dex */
public final class MultipartHttpEntity implements HttpEntity {
    private static byte[] MULTIPART_CHARS = EncodingUtil.getAsciiBytes("-_1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ");
    private byte[] multipartBoundary;
    protected Part[] parts;

    public MultipartHttpEntity(Part[] partArr) {
        if (partArr == null) {
            throw new IllegalArgumentException("parts cannot be null");
        }
        this.parts = partArr;
    }

    private byte[] getMultipartBoundary() {
        if (this.multipartBoundary == null) {
            Random random = new Random();
            byte[] bArr = new byte[random.nextInt(11) + 30];
            for (int i = 0; i < bArr.length; i++) {
                bArr[i] = MULTIPART_CHARS[random.nextInt(MULTIPART_CHARS.length)];
            }
            this.multipartBoundary = bArr;
        }
        return this.multipartBoundary;
    }

    @Override // org.apache.http.HttpEntity
    public final void consumeContent() throws IOException {
        throw new UnsupportedOperationException();
    }

    @Override // org.apache.http.HttpEntity
    public final InputStream getContent() throws IllegalStateException, IOException {
        throw new UnsupportedOperationException();
    }

    @Override // org.apache.http.HttpEntity
    public final Header getContentEncoding() {
        return new BasicHeader("Content-Encoding", "text/html; charset=UTF-8");
    }

    @Override // org.apache.http.HttpEntity
    public final long getContentLength() {
        try {
            return Part.getLengthOfParts(this.parts, getMultipartBoundary());
        } catch (Exception e) {
            OFLog.e("MultipartRequestEntity", "An exception occurred while getting the length of the parts");
            return 0L;
        }
    }

    @Override // org.apache.http.HttpEntity
    public final Header getContentType() {
        StringBuffer stringBuffer = new StringBuffer("multipart/form-data");
        stringBuffer.append("; boundary=");
        byte[] multipartBoundary = getMultipartBoundary();
        stringBuffer.append(EncodingUtil.getAsciiString$55a39fc4(multipartBoundary, multipartBoundary.length));
        return new BasicHeader("Content-Type", stringBuffer.toString());
    }

    @Override // org.apache.http.HttpEntity
    public final boolean isChunked() {
        return getContentLength() < 0;
    }

    @Override // org.apache.http.HttpEntity
    public final boolean isRepeatable() {
        for (int i = 0; i < this.parts.length; i++) {
            Part[] partArr = this.parts;
            Part.isRepeatable();
        }
        return true;
    }

    @Override // org.apache.http.HttpEntity
    public final boolean isStreaming() {
        return false;
    }

    @Override // org.apache.http.HttpEntity
    public final void writeTo(OutputStream outputStream) throws IOException {
        Part.sendParts(outputStream, this.parts, getMultipartBoundary());
    }
}
