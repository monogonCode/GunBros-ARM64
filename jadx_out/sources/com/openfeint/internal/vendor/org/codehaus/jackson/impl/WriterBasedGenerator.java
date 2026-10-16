package com.openfeint.internal.vendor.org.codehaus.jackson.impl;

import com.openfeint.internal.vendor.org.codehaus.jackson.JsonGenerator;
import com.openfeint.internal.vendor.org.codehaus.jackson.ObjectCodec;
import com.openfeint.internal.vendor.org.codehaus.jackson.PrettyPrinter;
import com.openfeint.internal.vendor.org.codehaus.jackson.io.IOContext;
import com.openfeint.internal.vendor.org.codehaus.jackson.io.NumberOutput;
import com.openfeint.internal.vendor.org.codehaus.jackson.util.CharTypes;
import java.io.IOException;
import java.io.Writer;

/* JADX INFO: loaded from: classes.dex */
public final class WriterBasedGenerator extends JsonGeneratorBase {
    static final char[] HEX_CHARS = "0123456789ABCDEF".toCharArray();
    protected char[] _entityBuffer;
    protected final IOContext _ioContext;
    protected char[] _outputBuffer;
    protected int _outputEnd;
    protected int _outputHead;
    protected int _outputTail;
    protected final Writer _writer;

    public WriterBasedGenerator(IOContext iOContext, int i, ObjectCodec objectCodec, Writer writer) {
        super(i, objectCodec);
        this._outputHead = 0;
        this._outputTail = 0;
        this._ioContext = iOContext;
        this._writer = writer;
        this._outputBuffer = iOContext.allocConcatBuffer();
        this._outputEnd = this._outputBuffer.length;
    }

    private static void _appendSingleEscape(int i, char[] cArr, int i2) {
        if (i >= 0) {
            cArr[i2] = '\\';
            cArr[i2 + 1] = (char) i;
            return;
        }
        int i3 = -(i + 1);
        cArr[i2] = '\\';
        int i4 = i2 + 1;
        cArr[i4] = 'u';
        int i5 = i4 + 1;
        cArr[i5] = '0';
        int i6 = i5 + 1;
        cArr[i6] = '0';
        int i7 = i6 + 1;
        cArr[i7] = HEX_CHARS[i3 >> 4];
        cArr[i7 + 1] = HEX_CHARS[i3 & 15];
    }

    private void _flushBuffer() throws IOException {
        int i = this._outputTail - this._outputHead;
        if (i > 0) {
            int i2 = this._outputHead;
            this._outputHead = 0;
            this._outputTail = 0;
            this._writer.write(this._outputBuffer, i2, i);
        }
    }

    private final void _writeNull() throws IOException {
        if (this._outputTail + 4 >= this._outputEnd) {
            _flushBuffer();
        }
        int i = this._outputTail;
        char[] cArr = this._outputBuffer;
        cArr[i] = 'n';
        int i2 = i + 1;
        cArr[i2] = 'u';
        int i3 = i2 + 1;
        cArr[i3] = 'l';
        int i4 = i3 + 1;
        cArr[i4] = 'l';
        this._outputTail = i4 + 1;
    }

    private void _writeSingleEscape(int i) throws IOException {
        char[] cArr = this._entityBuffer;
        if (cArr == null) {
            cArr = new char[]{'\\', 0, '0', '0', 0, 0};
        }
        if (i >= 0) {
            cArr[1] = (char) i;
            this._writer.write(cArr, 0, 2);
            return;
        }
        int i2 = -(i + 1);
        cArr[1] = 'u';
        cArr[4] = HEX_CHARS[i2 >> 4];
        cArr[5] = HEX_CHARS[i2 & 15];
        this._writer.write(cArr, 0, 6);
    }

    private void _writeString(String str) throws IOException {
        int i;
        int length = str.length();
        if (length <= this._outputEnd) {
            if (this._outputTail + length > this._outputEnd) {
                _flushBuffer();
            }
            str.getChars(0, length, this._outputBuffer, this._outputTail);
            int i2 = this._outputTail + length;
            int[] outputEscapes = CharTypes.getOutputEscapes();
            int length2 = outputEscapes.length;
            while (this._outputTail < i2) {
                do {
                    char c = this._outputBuffer[this._outputTail];
                    if (c >= length2 || outputEscapes[c] == 0) {
                        i = this._outputTail + 1;
                        this._outputTail = i;
                    } else {
                        int i3 = this._outputTail - this._outputHead;
                        if (i3 > 0) {
                            this._writer.write(this._outputBuffer, this._outputHead, i3);
                        }
                        int i4 = outputEscapes[this._outputBuffer[this._outputTail]];
                        this._outputTail++;
                        int i5 = i4 < 0 ? 6 : 2;
                        if (i5 > this._outputTail) {
                            this._outputHead = this._outputTail;
                            _writeSingleEscape(i4);
                        } else {
                            int i6 = this._outputTail - i5;
                            this._outputHead = i6;
                            _appendSingleEscape(i4, this._outputBuffer, i6);
                        }
                    }
                } while (i < i2);
                return;
            }
            return;
        }
        _flushBuffer();
        int length3 = str.length();
        int i7 = 0;
        do {
            int i8 = this._outputEnd;
            if (i7 + i8 > length3) {
                i8 = length3 - i7;
            }
            str.getChars(i7, i7 + i8, this._outputBuffer, 0);
            int[] outputEscapes2 = CharTypes.getOutputEscapes();
            int length4 = outputEscapes2.length;
            int i9 = 0;
            while (i9 < i8) {
                int i10 = i9;
                do {
                    char c2 = this._outputBuffer[i10];
                    if (c2 < length4 && outputEscapes2[c2] != 0) {
                        break;
                    } else {
                        i10++;
                    }
                } while (i10 < i8);
                int i11 = i10 - i9;
                if (i11 > 0) {
                    this._writer.write(this._outputBuffer, i9, i11);
                    if (i10 >= i8) {
                        break;
                    }
                }
                int i12 = outputEscapes2[this._outputBuffer[i10]];
                i9 = i10 + 1;
                int i13 = i12 < 0 ? 6 : 2;
                if (i13 > this._outputTail) {
                    _writeSingleEscape(i12);
                } else {
                    i9 -= i13;
                    _appendSingleEscape(i12, this._outputBuffer, i9);
                }
            }
            i7 += i8;
        } while (i7 < length3);
    }

    private void writeRaw(String str) throws IOException {
        int length = str.length();
        int i = this._outputEnd - this._outputTail;
        if (i == 0) {
            _flushBuffer();
            i = this._outputEnd - this._outputTail;
        }
        if (i >= length) {
            str.getChars(0, length, this._outputBuffer, this._outputTail);
            this._outputTail += length;
            return;
        }
        int i2 = this._outputEnd - this._outputTail;
        str.getChars(0, i2, this._outputBuffer, this._outputTail);
        this._outputTail += i2;
        _flushBuffer();
        int length2 = str.length() - i2;
        while (length2 > this._outputEnd) {
            int i3 = this._outputEnd;
            str.getChars(i2, i2 + i3, this._outputBuffer, 0);
            this._outputHead = 0;
            this._outputTail = i3;
            _flushBuffer();
            i2 += i3;
            length2 -= i3;
        }
        str.getChars(i2, i2 + length2, this._outputBuffer, 0);
        this._outputHead = 0;
        this._outputTail = length2;
    }

    @Override // com.openfeint.internal.vendor.org.codehaus.jackson.impl.JsonGeneratorBase
    protected final void _verifyValueWrite(String str) throws IOException {
        char c;
        int iWriteValue = this._writeContext.writeValue();
        if (iWriteValue == 5) {
            _reportError("Can not " + str + ", expecting field name");
        }
        if (this._cfgPrettyPrinter == null) {
            switch (iWriteValue) {
                case 1:
                    c = ',';
                    break;
                case 2:
                    c = ':';
                    break;
                case 3:
                    c = ' ';
                    break;
                default:
                    return;
            }
            if (this._outputTail >= this._outputEnd) {
                _flushBuffer();
            }
            this._outputBuffer[this._outputTail] = c;
            this._outputTail++;
            return;
        }
        switch (iWriteValue) {
            case 0:
                if (this._writeContext.inArray()) {
                    PrettyPrinter prettyPrinter = this._cfgPrettyPrinter;
                    return;
                } else {
                    if (this._writeContext.inObject()) {
                        PrettyPrinter prettyPrinter2 = this._cfgPrettyPrinter;
                        return;
                    }
                    return;
                }
            case 1:
                PrettyPrinter prettyPrinter3 = this._cfgPrettyPrinter;
                return;
            case 2:
                PrettyPrinter prettyPrinter4 = this._cfgPrettyPrinter;
                return;
            case 3:
                PrettyPrinter prettyPrinter5 = this._cfgPrettyPrinter;
                return;
            default:
                throw new RuntimeException("Internal error: should never end up through this code path");
        }
    }

    @Override // com.openfeint.internal.vendor.org.codehaus.jackson.impl.JsonGeneratorBase
    protected final void _writeEndArray() throws IOException {
        if (this._outputTail >= this._outputEnd) {
            _flushBuffer();
        }
        char[] cArr = this._outputBuffer;
        int i = this._outputTail;
        this._outputTail = i + 1;
        cArr[i] = ']';
    }

    @Override // com.openfeint.internal.vendor.org.codehaus.jackson.impl.JsonGeneratorBase
    protected final void _writeEndObject() throws IOException {
        if (this._outputTail >= this._outputEnd) {
            _flushBuffer();
        }
        char[] cArr = this._outputBuffer;
        int i = this._outputTail;
        this._outputTail = i + 1;
        cArr[i] = '}';
    }

    @Override // com.openfeint.internal.vendor.org.codehaus.jackson.impl.JsonGeneratorBase
    protected final void _writeFieldName(String str, boolean z) throws IOException {
        if (this._cfgPrettyPrinter != null) {
            if (z) {
                PrettyPrinter prettyPrinter = this._cfgPrettyPrinter;
            } else {
                PrettyPrinter prettyPrinter2 = this._cfgPrettyPrinter;
            }
            if (!isEnabled(JsonGenerator.Feature.QUOTE_FIELD_NAMES)) {
                _writeString(str);
                return;
            }
            if (this._outputTail >= this._outputEnd) {
                _flushBuffer();
            }
            char[] cArr = this._outputBuffer;
            int i = this._outputTail;
            this._outputTail = i + 1;
            cArr[i] = '\"';
            _writeString(str);
            if (this._outputTail >= this._outputEnd) {
                _flushBuffer();
            }
            char[] cArr2 = this._outputBuffer;
            int i2 = this._outputTail;
            this._outputTail = i2 + 1;
            cArr2[i2] = '\"';
            return;
        }
        if (this._outputTail + 1 >= this._outputEnd) {
            _flushBuffer();
        }
        if (z) {
            char[] cArr3 = this._outputBuffer;
            int i3 = this._outputTail;
            this._outputTail = i3 + 1;
            cArr3[i3] = ',';
        }
        if (!isEnabled(JsonGenerator.Feature.QUOTE_FIELD_NAMES)) {
            _writeString(str);
            return;
        }
        char[] cArr4 = this._outputBuffer;
        int i4 = this._outputTail;
        this._outputTail = i4 + 1;
        cArr4[i4] = '\"';
        _writeString(str);
        if (this._outputTail >= this._outputEnd) {
            _flushBuffer();
        }
        char[] cArr5 = this._outputBuffer;
        int i5 = this._outputTail;
        this._outputTail = i5 + 1;
        cArr5[i5] = '\"';
    }

    @Override // com.openfeint.internal.vendor.org.codehaus.jackson.impl.JsonGeneratorBase
    protected final void _writeStartArray() throws IOException {
        if (this._outputTail >= this._outputEnd) {
            _flushBuffer();
        }
        char[] cArr = this._outputBuffer;
        int i = this._outputTail;
        this._outputTail = i + 1;
        cArr[i] = '[';
    }

    @Override // com.openfeint.internal.vendor.org.codehaus.jackson.impl.JsonGeneratorBase
    protected final void _writeStartObject() throws IOException {
        if (this._outputTail >= this._outputEnd) {
            _flushBuffer();
        }
        char[] cArr = this._outputBuffer;
        int i = this._outputTail;
        this._outputTail = i + 1;
        cArr[i] = '{';
    }

    @Override // com.openfeint.internal.vendor.org.codehaus.jackson.impl.JsonGeneratorBase, com.openfeint.internal.vendor.org.codehaus.jackson.JsonGenerator, java.io.Closeable, java.lang.AutoCloseable
    public final void close() throws IOException {
        super.close();
        if (this._outputBuffer != null && isEnabled(JsonGenerator.Feature.AUTO_CLOSE_JSON_CONTENT)) {
            while (true) {
                JsonWriteContext outputContext = getOutputContext();
                if (!outputContext.inArray()) {
                    if (!outputContext.inObject()) {
                        break;
                    } else {
                        writeEndObject();
                    }
                } else {
                    writeEndArray();
                }
            }
        }
        _flushBuffer();
        if (this._ioContext.isResourceManaged() || isEnabled(JsonGenerator.Feature.AUTO_CLOSE_TARGET)) {
            this._writer.close();
        } else {
            this._writer.flush();
        }
        char[] cArr = this._outputBuffer;
        if (cArr != null) {
            this._outputBuffer = null;
            this._ioContext.releaseConcatBuffer(cArr);
        }
    }

    @Override // com.openfeint.internal.vendor.org.codehaus.jackson.JsonGenerator
    public final void writeBoolean(boolean z) throws IOException {
        int i;
        _verifyValueWrite("write boolean value");
        if (this._outputTail + 5 >= this._outputEnd) {
            _flushBuffer();
        }
        int i2 = this._outputTail;
        char[] cArr = this._outputBuffer;
        if (z) {
            cArr[i2] = 't';
            int i3 = i2 + 1;
            cArr[i3] = 'r';
            int i4 = i3 + 1;
            cArr[i4] = 'u';
            i = i4 + 1;
            cArr[i] = 'e';
        } else {
            cArr[i2] = 'f';
            int i5 = i2 + 1;
            cArr[i5] = 'a';
            int i6 = i5 + 1;
            cArr[i6] = 'l';
            int i7 = i6 + 1;
            cArr[i7] = 's';
            i = i7 + 1;
            cArr[i] = 'e';
        }
        this._outputTail = i + 1;
    }

    @Override // com.openfeint.internal.vendor.org.codehaus.jackson.JsonGenerator
    public final void writeNull() throws IOException {
        _verifyValueWrite("write null value");
        _writeNull();
    }

    @Override // com.openfeint.internal.vendor.org.codehaus.jackson.JsonGenerator
    public final void writeNumber(double d) throws IOException {
        if (this._cfgNumbersAsStrings || ((Double.isNaN(d) || Double.isInfinite(d)) && isEnabled(JsonGenerator.Feature.QUOTE_NON_NUMERIC_NUMBERS))) {
            writeString(String.valueOf(d));
        } else {
            _verifyValueWrite("write number");
            writeRaw(String.valueOf(d));
        }
    }

    @Override // com.openfeint.internal.vendor.org.codehaus.jackson.JsonGenerator
    public final void writeNumber(float f) throws IOException {
        if (this._cfgNumbersAsStrings || ((Float.isNaN(f) || Float.isInfinite(f)) && isEnabled(JsonGenerator.Feature.QUOTE_NON_NUMERIC_NUMBERS))) {
            writeString(String.valueOf(f));
        } else {
            _verifyValueWrite("write number");
            writeRaw(String.valueOf(f));
        }
    }

    @Override // com.openfeint.internal.vendor.org.codehaus.jackson.JsonGenerator
    public final void writeNumber(int i) throws IOException {
        _verifyValueWrite("write number");
        if (this._outputTail + 11 >= this._outputEnd) {
            _flushBuffer();
        }
        if (!this._cfgNumbersAsStrings) {
            this._outputTail = NumberOutput.outputInt(i, this._outputBuffer, this._outputTail);
            return;
        }
        if (this._outputTail + 13 >= this._outputEnd) {
            _flushBuffer();
        }
        char[] cArr = this._outputBuffer;
        int i2 = this._outputTail;
        this._outputTail = i2 + 1;
        cArr[i2] = '\"';
        this._outputTail = NumberOutput.outputInt(i, this._outputBuffer, this._outputTail);
        char[] cArr2 = this._outputBuffer;
        int i3 = this._outputTail;
        this._outputTail = i3 + 1;
        cArr2[i3] = '\"';
    }

    @Override // com.openfeint.internal.vendor.org.codehaus.jackson.JsonGenerator
    public final void writeNumber(long j) throws IOException {
        _verifyValueWrite("write number");
        if (!this._cfgNumbersAsStrings) {
            if (this._outputTail + 21 >= this._outputEnd) {
                _flushBuffer();
            }
            this._outputTail = NumberOutput.outputLong(j, this._outputBuffer, this._outputTail);
            return;
        }
        if (this._outputTail + 23 >= this._outputEnd) {
            _flushBuffer();
        }
        char[] cArr = this._outputBuffer;
        int i = this._outputTail;
        this._outputTail = i + 1;
        cArr[i] = '\"';
        this._outputTail = NumberOutput.outputLong(j, this._outputBuffer, this._outputTail);
        char[] cArr2 = this._outputBuffer;
        int i2 = this._outputTail;
        this._outputTail = i2 + 1;
        cArr2[i2] = '\"';
    }

    @Override // com.openfeint.internal.vendor.org.codehaus.jackson.JsonGenerator
    public final void writeString(String str) throws IOException {
        _verifyValueWrite("write text value");
        if (str == null) {
            _writeNull();
            return;
        }
        if (this._outputTail >= this._outputEnd) {
            _flushBuffer();
        }
        char[] cArr = this._outputBuffer;
        int i = this._outputTail;
        this._outputTail = i + 1;
        cArr[i] = '\"';
        _writeString(str);
        if (this._outputTail >= this._outputEnd) {
            _flushBuffer();
        }
        char[] cArr2 = this._outputBuffer;
        int i2 = this._outputTail;
        this._outputTail = i2 + 1;
        cArr2[i2] = '\"';
    }
}
