package com.openfeint.internal.vendor.org.codehaus.jackson.impl;

import com.openfeint.internal.vendor.org.codehaus.jackson.JsonEncoding;
import com.openfeint.internal.vendor.org.codehaus.jackson.JsonParser;
import com.openfeint.internal.vendor.org.codehaus.jackson.ObjectCodec;
import com.openfeint.internal.vendor.org.codehaus.jackson.io.IOContext;
import com.openfeint.internal.vendor.org.codehaus.jackson.io.MergedStream;
import com.openfeint.internal.vendor.org.codehaus.jackson.io.UTF32Reader;
import com.openfeint.internal.vendor.org.codehaus.jackson.sym.BytesToNameCanonicalizer;
import com.openfeint.internal.vendor.org.codehaus.jackson.sym.CharsToNameCanonicalizer;
import java.io.ByteArrayInputStream;
import java.io.CharConversionException;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.Reader;

/* JADX INFO: loaded from: classes.dex */
public final class ByteSourceBootstrapper {
    boolean _bigEndian;
    private final boolean _bufferRecyclable;
    int _bytesPerChar;
    final IOContext _context;
    final InputStream _in;
    final byte[] _inputBuffer;
    private int _inputEnd;
    protected int _inputProcessed;
    private int _inputPtr;

    public ByteSourceBootstrapper(IOContext iOContext, InputStream inputStream) {
        this._bigEndian = true;
        this._bytesPerChar = 0;
        this._context = iOContext;
        this._in = inputStream;
        this._inputBuffer = iOContext.allocReadIOBuffer();
        this._inputPtr = 0;
        this._inputEnd = 0;
        this._inputProcessed = 0;
        this._bufferRecyclable = true;
    }

    public ByteSourceBootstrapper(IOContext iOContext, byte[] bArr, int i) {
        this._bigEndian = true;
        this._bytesPerChar = 0;
        this._context = iOContext;
        this._in = null;
        this._inputBuffer = bArr;
        this._inputPtr = 0;
        this._inputEnd = i + 0;
        this._inputProcessed = 0;
        this._bufferRecyclable = false;
    }

    private boolean checkUTF16(int i) {
        if ((65280 & i) == 0) {
            this._bigEndian = true;
        } else {
            if ((i & 255) != 0) {
                return false;
            }
            this._bigEndian = false;
        }
        this._bytesPerChar = 2;
        return true;
    }

    private boolean ensureLoaded(int i) throws IOException {
        int i2 = this._inputEnd - this._inputPtr;
        while (i2 < i) {
            int i3 = this._in == null ? -1 : this._in.read(this._inputBuffer, this._inputEnd, this._inputBuffer.length - this._inputEnd);
            if (i3 <= 0) {
                return false;
            }
            this._inputEnd += i3;
            i2 = i3 + i2;
        }
        return true;
    }

    private static void reportWeirdUCS4(String str) throws IOException {
        throw new CharConversionException("Unsupported UCS-4 endianness (" + str + ") detected");
    }

    /* JADX WARN: Can't fix incorrect switch cases order, some code will duplicate */
    /* JADX WARN: Code duplicated, block: B:21:0x00a4  */
    /* JADX WARN: Code duplicated, block: B:23:0x00a9  */
    /* JADX WARN: Code duplicated, block: B:24:0x00b5  */
    /* JADX WARN: Code duplicated, block: B:26:0x00bc  */
    /* JADX WARN: Code duplicated, block: B:27:0x00c8  */
    /* JADX WARN: Code duplicated, block: B:35:0x00dd  */
    /* JADX WARN: Code duplicated, block: B:8:0x0041  */
    public final JsonParser constructParser(int i, ObjectCodec objectCodec, BytesToNameCanonicalizer bytesToNameCanonicalizer, CharsToNameCanonicalizer charsToNameCanonicalizer) throws IOException {
        JsonEncoding jsonEncoding;
        Reader inputStreamReader;
        boolean z;
        boolean z2;
        int i2;
        boolean z3 = true;
        if (ensureLoaded(4)) {
            int i3 = (this._inputBuffer[this._inputPtr + 3] & 255) | (this._inputBuffer[this._inputPtr] << 24) | ((this._inputBuffer[this._inputPtr + 1] & 255) << 16) | ((this._inputBuffer[this._inputPtr + 2] & 255) << 8);
            switch (i3) {
                case -16842752:
                    reportWeirdUCS4("3412");
                    i2 = i3 >>> 16;
                    if (i2 == 65279) {
                        this._inputPtr += 2;
                        this._bytesPerChar = 2;
                        this._bigEndian = true;
                        z = true;
                    } else if (i2 == 65534) {
                        this._inputPtr += 2;
                        this._bytesPerChar = 2;
                        this._bigEndian = false;
                        z = true;
                    } else if ((i3 >>> 8) != 15711167) {
                        z = false;
                    } else {
                        this._inputPtr += 3;
                        this._bytesPerChar = 1;
                        this._bigEndian = true;
                        z = true;
                    }
                    break;
                case -131072:
                    this._inputPtr += 4;
                    this._bytesPerChar = 4;
                    this._bigEndian = false;
                    z = true;
                    break;
                case 65279:
                    this._bigEndian = true;
                    this._inputPtr += 4;
                    this._bytesPerChar = 4;
                    z = true;
                    break;
                case 65534:
                    reportWeirdUCS4("2143");
                    reportWeirdUCS4("3412");
                    i2 = i3 >>> 16;
                    if (i2 == 65279) {
                        this._inputPtr += 2;
                        this._bytesPerChar = 2;
                        this._bigEndian = true;
                        z = true;
                    } else if (i2 == 65534) {
                        this._inputPtr += 2;
                        this._bytesPerChar = 2;
                        this._bigEndian = false;
                        z = true;
                    } else if ((i3 >>> 8) != 15711167) {
                        z = false;
                    } else {
                        this._inputPtr += 3;
                        this._bytesPerChar = 1;
                        this._bigEndian = true;
                        z = true;
                    }
                    break;
                default:
                    i2 = i3 >>> 16;
                    if (i2 == 65279) {
                        this._inputPtr += 2;
                        this._bytesPerChar = 2;
                        this._bigEndian = true;
                        z = true;
                    } else if (i2 == 65534) {
                        this._inputPtr += 2;
                        this._bytesPerChar = 2;
                        this._bigEndian = false;
                        z = true;
                    } else if ((i3 >>> 8) != 15711167) {
                        z = false;
                    } else {
                        this._inputPtr += 3;
                        this._bytesPerChar = 1;
                        this._bigEndian = true;
                        z = true;
                    }
                    break;
            }
            if (!z) {
                if ((i3 >> 8) == 0) {
                    this._bigEndian = true;
                } else if ((16777215 & i3) == 0) {
                    this._bigEndian = false;
                } else if (((-16711681) & i3) == 0) {
                    reportWeirdUCS4("3412");
                } else {
                    if (((-65281) & i3) == 0) {
                        reportWeirdUCS4("2143");
                    } else {
                        z2 = false;
                    }
                    if (!z2 && !checkUTF16(i3 >>> 16)) {
                        z3 = false;
                    }
                }
                this._bytesPerChar = 4;
                z2 = true;
                if (!z2) {
                    z3 = false;
                }
            }
        } else if (!ensureLoaded(2) || !checkUTF16(((this._inputBuffer[this._inputPtr] & 255) << 8) | (this._inputBuffer[this._inputPtr + 1] & 255))) {
            z3 = false;
        }
        if (!z3) {
            jsonEncoding = JsonEncoding.UTF8;
        } else if (this._bytesPerChar == 2) {
            jsonEncoding = this._bigEndian ? JsonEncoding.UTF16_BE : JsonEncoding.UTF16_LE;
        } else {
            if (this._bytesPerChar != 4) {
                throw new RuntimeException("Internal error");
            }
            jsonEncoding = this._bigEndian ? JsonEncoding.UTF32_BE : JsonEncoding.UTF32_LE;
        }
        this._context.setEncoding(jsonEncoding);
        boolean zEnabledIn = JsonParser.Feature.CANONICALIZE_FIELD_NAMES.enabledIn(i);
        boolean zEnabledIn2 = JsonParser.Feature.INTERN_FIELD_NAMES.enabledIn(i);
        if (jsonEncoding == JsonEncoding.UTF8 && zEnabledIn) {
            return new Utf8StreamParser(this._context, i, this._in, objectCodec, bytesToNameCanonicalizer.makeChild$5e0e244d(zEnabledIn2), this._inputBuffer, this._inputPtr, this._inputEnd, this._bufferRecyclable);
        }
        IOContext iOContext = this._context;
        JsonEncoding encoding = this._context.getEncoding();
        switch (encoding) {
            case UTF32_BE:
            case UTF32_LE:
                inputStreamReader = new UTF32Reader(this._context, this._in, this._inputBuffer, this._inputPtr, this._inputEnd, this._context.getEncoding().isBigEndian());
                break;
            case UTF16_BE:
            case UTF16_LE:
            case UTF8:
                InputStream inputStream = this._in;
                inputStreamReader = new InputStreamReader(inputStream == null ? new ByteArrayInputStream(this._inputBuffer, this._inputPtr, this._inputEnd) : this._inputPtr < this._inputEnd ? new MergedStream(this._context, inputStream, this._inputBuffer, this._inputPtr, this._inputEnd) : inputStream, encoding.getJavaName());
                break;
            default:
                throw new RuntimeException("Internal error");
        }
        return new ReaderBasedParser(iOContext, i, inputStreamReader, objectCodec, charsToNameCanonicalizer.makeChild(zEnabledIn, zEnabledIn2));
    }
}
