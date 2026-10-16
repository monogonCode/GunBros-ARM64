package com.openfeint.internal.request.multipart;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.OutputStream;

/* JADX INFO: loaded from: classes.dex */
public abstract class Part {
    protected static final byte[] BOUNDARY_BYTES;
    protected static final byte[] CHARSET_BYTES;
    protected static final byte[] CONTENT_DISPOSITION_BYTES;
    protected static final byte[] CONTENT_TRANSFER_ENCODING_BYTES;
    protected static final byte[] CONTENT_TYPE_BYTES;
    protected static final byte[] CRLF_BYTES;
    private static final byte[] DEFAULT_BOUNDARY_BYTES;
    protected static final byte[] EXTRA_BYTES;
    protected static final byte[] QUOTE_BYTES;
    private byte[] boundaryBytes;

    static {
        byte[] asciiBytes = EncodingUtil.getAsciiBytes("----------------ULTRASONIC_CUPCAKES___-__-");
        BOUNDARY_BYTES = asciiBytes;
        DEFAULT_BOUNDARY_BYTES = asciiBytes;
        CRLF_BYTES = EncodingUtil.getAsciiBytes("\r\n");
        QUOTE_BYTES = EncodingUtil.getAsciiBytes("\"");
        EXTRA_BYTES = EncodingUtil.getAsciiBytes("--");
        CONTENT_DISPOSITION_BYTES = EncodingUtil.getAsciiBytes("Content-Disposition: form-data; name=");
        CONTENT_TYPE_BYTES = EncodingUtil.getAsciiBytes("Content-Type: ");
        CHARSET_BYTES = EncodingUtil.getAsciiBytes("; charset=");
        CONTENT_TRANSFER_ENCODING_BYTES = EncodingUtil.getAsciiBytes("Content-Transfer-Encoding: ");
    }

    public static long getLengthOfParts(Part[] partArr, byte[] bArr) throws IOException {
        long size;
        if (partArr == null) {
            throw new IllegalArgumentException("Parts may not be null");
        }
        long j = 0;
        for (int i = 0; i < partArr.length; i++) {
            partArr[i].boundaryBytes = bArr;
            Part part = partArr[i];
            if (part.lengthOfData() < 0) {
                size = -1;
            } else {
                ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
                part.sendStart(byteArrayOutputStream);
                part.sendDispositionHeader(byteArrayOutputStream);
                part.sendContentTypeHeader(byteArrayOutputStream);
                part.sendTransferEncodingHeader(byteArrayOutputStream);
                sendEndOfHeader(byteArrayOutputStream);
                byteArrayOutputStream.write(CRLF_BYTES);
                size = ((long) byteArrayOutputStream.size()) + part.lengthOfData();
            }
            if (size < 0) {
                return -1L;
            }
            j += size;
        }
        return j + ((long) EXTRA_BYTES.length) + ((long) bArr.length) + ((long) EXTRA_BYTES.length) + ((long) CRLF_BYTES.length);
    }

    public static boolean isRepeatable() {
        return true;
    }

    private void sendContentTypeHeader(OutputStream outputStream) throws IOException {
        String contentType = getContentType();
        if (contentType != null) {
            outputStream.write(CRLF_BYTES);
            outputStream.write(CONTENT_TYPE_BYTES);
            outputStream.write(EncodingUtil.getAsciiBytes(contentType));
            String charSet = getCharSet();
            if (charSet != null) {
                outputStream.write(CHARSET_BYTES);
                outputStream.write(EncodingUtil.getAsciiBytes(charSet));
            }
        }
    }

    private static void sendEndOfHeader(OutputStream outputStream) throws IOException {
        outputStream.write(CRLF_BYTES);
        outputStream.write(CRLF_BYTES);
    }

    public static void sendParts(OutputStream outputStream, Part[] partArr, byte[] bArr) throws IOException {
        if (partArr == null) {
            throw new IllegalArgumentException("Parts may not be null");
        }
        if (bArr == null || bArr.length == 0) {
            throw new IllegalArgumentException("partBoundary may not be empty");
        }
        for (int i = 0; i < partArr.length; i++) {
            partArr[i].boundaryBytes = bArr;
            Part part = partArr[i];
            part.sendStart(outputStream);
            part.sendDispositionHeader(outputStream);
            part.sendContentTypeHeader(outputStream);
            part.sendTransferEncodingHeader(outputStream);
            sendEndOfHeader(outputStream);
            part.sendData(outputStream);
            outputStream.write(CRLF_BYTES);
        }
        outputStream.write(EXTRA_BYTES);
        outputStream.write(bArr);
        outputStream.write(EXTRA_BYTES);
        outputStream.write(CRLF_BYTES);
    }

    private void sendStart(OutputStream outputStream) throws IOException {
        outputStream.write(EXTRA_BYTES);
        outputStream.write(this.boundaryBytes == null ? DEFAULT_BOUNDARY_BYTES : this.boundaryBytes);
        outputStream.write(CRLF_BYTES);
    }

    private void sendTransferEncodingHeader(OutputStream outputStream) throws IOException {
        String transferEncoding = getTransferEncoding();
        if (transferEncoding != null) {
            outputStream.write(CRLF_BYTES);
            outputStream.write(CONTENT_TRANSFER_ENCODING_BYTES);
            outputStream.write(EncodingUtil.getAsciiBytes(transferEncoding));
        }
    }

    public abstract String getCharSet();

    public abstract String getContentType();

    public abstract String getName();

    public abstract String getTransferEncoding();

    protected abstract long lengthOfData() throws IOException;

    protected abstract void sendData(OutputStream outputStream) throws IOException;

    protected void sendDispositionHeader(OutputStream outputStream) throws IOException {
        outputStream.write(CONTENT_DISPOSITION_BYTES);
        outputStream.write(QUOTE_BYTES);
        outputStream.write(EncodingUtil.getAsciiBytes(getName()));
        outputStream.write(QUOTE_BYTES);
    }

    public String toString() {
        return getName();
    }
}
