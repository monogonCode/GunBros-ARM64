package com.openfeint.internal.request;

import com.openfeint.internal.OpenFeintInternal;
import com.openfeint.internal.Util;
import com.openfeint.internal.logcat.OFLog;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.zip.DeflaterOutputStream;
import java.util.zip.InflaterInputStream;

/* JADX INFO: loaded from: classes.dex */
public final class Compression {
    private static String TAG = "Compression";
    private static final byte[] MagicHeader = "OFZLHDR0".getBytes();

    private enum CompressionMethod {
        Default,
        Uncompressed,
        LegacyHeaderless
    }

    private static byte[] _compress(byte[] bArr) throws IOException {
        ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
        DeflaterOutputStream deflaterOutputStream = new DeflaterOutputStream(byteArrayOutputStream);
        deflaterOutputStream.write(bArr);
        deflaterOutputStream.close();
        return byteArrayOutputStream.toByteArray();
    }

    public static byte[] compress(byte[] bArr) {
        try {
            switch (compressionMethod()) {
                case Default:
                    byte[] bArr_compress = _compress(bArr);
                    int length = bArr.length;
                    byte[] bArr2 = {(byte) (length >> 0), (byte) (length >> 8), (byte) (length >> 16), (byte) (length >> 24)};
                    int length2 = bArr2.length + bArr_compress.length + MagicHeader.length;
                    if (length2 >= bArr.length) {
                        OFLog.i(TAG, "Using Default strategy: compression declined");
                    } else {
                        byte[] bArr3 = new byte[length2];
                        System.arraycopy(MagicHeader, 0, bArr3, 0, MagicHeader.length);
                        System.arraycopy(bArr2, 0, bArr3, MagicHeader.length, bArr2.length);
                        System.arraycopy(bArr_compress, 0, bArr3, MagicHeader.length + 4, bArr_compress.length);
                        OFLog.i(TAG, String.format("Using Default strategy: orig %d bytes, compressed %d bytes (%.2f%% of original size)", Integer.valueOf(bArr.length), Integer.valueOf(length2), Float.valueOf((length2 / bArr.length) * 100.0f)));
                        bArr = bArr3;
                    }
                    break;
                case LegacyHeaderless:
                    byte[] bArr_compress2 = _compress(bArr);
                    OFLog.i(TAG, String.format("Using Default strategy: orig %d bytes, compressed %d bytes (%.2f%% of original size)", Integer.valueOf(bArr.length), Integer.valueOf(bArr_compress2.length), Float.valueOf((bArr_compress2.length / bArr.length) * 100.0f)));
                    bArr = bArr_compress2;
                    break;
                default:
                    OFLog.i(TAG, "Using Uncompressed strategy");
                    break;
            }
            return bArr;
        } catch (IOException e) {
            return null;
        }
    }

    private static CompressionMethod compressionMethod() {
        String str = (String) OpenFeintInternal.getInstance().getSettings().get("SettingCloudStorageCompressionStrategy");
        if (str != null) {
            if (str.equals("CloudStorageCompressionStrategyLegacyHeaderlessCompression")) {
                return CompressionMethod.LegacyHeaderless;
            }
            if (str.equals("CloudStorageCompressionStrategyNoCompression")) {
                return CompressionMethod.Uncompressed;
            }
        }
        return CompressionMethod.Default;
    }

    public static byte[] decompress(byte[] bArr) throws IOException {
        switch (compressionMethod()) {
            case Default:
                int i = 0;
                if (MagicHeader.length < bArr.length) {
                    while (i < MagicHeader.length && MagicHeader[i] == bArr[i]) {
                        i++;
                    }
                }
                if (i != MagicHeader.length) {
                    return bArr;
                }
                int length = MagicHeader.length + 4;
                return Util.toByteArray(new InflaterInputStream(new ByteArrayInputStream(bArr, length, bArr.length - length)));
            case LegacyHeaderless:
                return Util.toByteArray(new InflaterInputStream(new ByteArrayInputStream(bArr)));
            default:
                return bArr;
        }
    }
}
