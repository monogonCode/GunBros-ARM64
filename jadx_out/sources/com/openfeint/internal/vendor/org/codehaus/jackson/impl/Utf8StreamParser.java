package com.openfeint.internal.vendor.org.codehaus.jackson.impl;

import com.openfeint.internal.vendor.org.codehaus.jackson.JsonParseException;
import com.openfeint.internal.vendor.org.codehaus.jackson.JsonParser;
import com.openfeint.internal.vendor.org.codehaus.jackson.JsonToken;
import com.openfeint.internal.vendor.org.codehaus.jackson.ObjectCodec;
import com.openfeint.internal.vendor.org.codehaus.jackson.io.IOContext;
import com.openfeint.internal.vendor.org.codehaus.jackson.sym.BytesToNameCanonicalizer;
import com.openfeint.internal.vendor.org.codehaus.jackson.sym.Name;
import com.openfeint.internal.vendor.org.codehaus.jackson.util.CharTypes;
import java.io.IOException;
import java.io.InputStream;

/* JADX INFO: loaded from: classes.dex */
public final class Utf8StreamParser extends Utf8NumericParser {
    protected ObjectCodec _objectCodec;
    protected int[] _quadBuffer;
    protected final BytesToNameCanonicalizer _symbols;

    public Utf8StreamParser(IOContext iOContext, int i, InputStream inputStream, ObjectCodec objectCodec, BytesToNameCanonicalizer bytesToNameCanonicalizer, byte[] bArr, int i2, int i3, boolean z) {
        super(iOContext, i, inputStream, bArr, i2, i3, z);
        this._quadBuffer = new int[32];
        this._objectCodec = objectCodec;
        this._symbols = bytesToNameCanonicalizer;
        if (JsonParser.Feature.CANONICALIZE_FIELD_NAMES.enabledIn(i)) {
            return;
        }
        _throwInternal();
    }

    private int _decodeCharForError(int i) throws IOException {
        char c;
        if (i >= 0) {
            return i;
        }
        if ((i & 224) == 192) {
            i &= 31;
            c = 1;
        } else if ((i & 240) == 224) {
            i &= 15;
            c = 2;
        } else if ((i & 248) == 240) {
            i &= 7;
            c = 3;
        } else {
            _reportInvalidInitial(i & 255);
            c = 1;
        }
        int iNextByte = nextByte();
        if ((iNextByte & 192) != 128) {
            _reportInvalidOther(iNextByte & 255);
        }
        int i2 = (i << 6) | (iNextByte & 63);
        if (c <= 1) {
            return i2;
        }
        int iNextByte2 = nextByte();
        if ((iNextByte2 & 192) != 128) {
            _reportInvalidOther(iNextByte2 & 255);
        }
        int i3 = (i2 << 6) | (iNextByte2 & 63);
        if (c <= 2) {
            return i3;
        }
        int iNextByte3 = nextByte();
        if ((iNextByte3 & 192) != 128) {
            _reportInvalidOther(iNextByte3 & 255);
        }
        return (i3 << 6) | (iNextByte3 & 63);
    }

    private char _decodeEscaped() throws IOException {
        if (this._inputPtr >= this._inputEnd && !loadMore()) {
            _reportInvalidEOF(" in character escape sequence");
        }
        byte[] bArr = this._inputBuffer;
        int i = this._inputPtr;
        this._inputPtr = i + 1;
        byte b = bArr[i];
        switch (b) {
            case 34:
            case 47:
            case 92:
                return (char) b;
            case 98:
                return '\b';
            case 102:
                return '\f';
            case 110:
                return '\n';
            case 114:
                return '\r';
            case 116:
                return '\t';
            case 117:
                break;
            default:
                _reportError("Unrecognized character escape (\\ followed by " + _getCharDesc(_decodeCharForError(b)) + ")");
                break;
        }
        int i2 = 0;
        for (int i3 = 0; i3 < 4; i3++) {
            if (this._inputPtr >= this._inputEnd && !loadMore()) {
                _reportInvalidEOF(" in character escape sequence");
            }
            byte[] bArr2 = this._inputBuffer;
            int i4 = this._inputPtr;
            this._inputPtr = i4 + 1;
            byte b2 = bArr2[i4];
            int iCharToHex = CharTypes.charToHex(b2);
            if (iCharToHex < 0) {
                _reportUnexpectedChar(b2, "expected a hex-digit for character escape sequence");
            }
            i2 = (i2 << 4) | iCharToHex;
        }
        return (char) i2;
    }

    private final int _decodeUtf8_2(int i) throws IOException {
        if (this._inputPtr >= this._inputEnd) {
            loadMoreGuaranteed();
        }
        byte[] bArr = this._inputBuffer;
        int i2 = this._inputPtr;
        this._inputPtr = i2 + 1;
        byte b = bArr[i2];
        if ((b & 192) != 128) {
            _reportInvalidOther(b & 255, this._inputPtr);
        }
        return (b & 63) | ((i & 31) << 6);
    }

    private final int _decodeUtf8_3(int i) throws IOException {
        if (this._inputPtr >= this._inputEnd) {
            loadMoreGuaranteed();
        }
        int i2 = i & 15;
        byte[] bArr = this._inputBuffer;
        int i3 = this._inputPtr;
        this._inputPtr = i3 + 1;
        byte b = bArr[i3];
        if ((b & 192) != 128) {
            _reportInvalidOther(b & 255, this._inputPtr);
        }
        int i4 = (i2 << 6) | (b & 63);
        if (this._inputPtr >= this._inputEnd) {
            loadMoreGuaranteed();
        }
        byte[] bArr2 = this._inputBuffer;
        int i5 = this._inputPtr;
        this._inputPtr = i5 + 1;
        byte b2 = bArr2[i5];
        if ((b2 & 192) != 128) {
            _reportInvalidOther(b2 & 255, this._inputPtr);
        }
        return (i4 << 6) | (b2 & 63);
    }

    private final int _decodeUtf8_3fast(int i) throws IOException {
        int i2 = i & 15;
        byte[] bArr = this._inputBuffer;
        int i3 = this._inputPtr;
        this._inputPtr = i3 + 1;
        byte b = bArr[i3];
        if ((b & 192) != 128) {
            _reportInvalidOther(b & 255, this._inputPtr);
        }
        int i4 = (i2 << 6) | (b & 63);
        byte[] bArr2 = this._inputBuffer;
        int i5 = this._inputPtr;
        this._inputPtr = i5 + 1;
        byte b2 = bArr2[i5];
        if ((b2 & 192) != 128) {
            _reportInvalidOther(b2 & 255, this._inputPtr);
        }
        return (i4 << 6) | (b2 & 63);
    }

    private final int _decodeUtf8_4(int i) throws IOException {
        if (this._inputPtr >= this._inputEnd) {
            loadMoreGuaranteed();
        }
        byte[] bArr = this._inputBuffer;
        int i2 = this._inputPtr;
        this._inputPtr = i2 + 1;
        byte b = bArr[i2];
        if ((b & 192) != 128) {
            _reportInvalidOther(b & 255, this._inputPtr);
        }
        int i3 = (b & 63) | ((i & 7) << 6);
        if (this._inputPtr >= this._inputEnd) {
            loadMoreGuaranteed();
        }
        byte[] bArr2 = this._inputBuffer;
        int i4 = this._inputPtr;
        this._inputPtr = i4 + 1;
        byte b2 = bArr2[i4];
        if ((b2 & 192) != 128) {
            _reportInvalidOther(b2 & 255, this._inputPtr);
        }
        int i5 = (i3 << 6) | (b2 & 63);
        if (this._inputPtr >= this._inputEnd) {
            loadMoreGuaranteed();
        }
        byte[] bArr3 = this._inputBuffer;
        int i6 = this._inputPtr;
        this._inputPtr = i6 + 1;
        byte b3 = bArr3[i6];
        if ((b3 & 192) != 128) {
            _reportInvalidOther(b3 & 255, this._inputPtr);
        }
        return ((i5 << 6) | (b3 & 63)) - 65536;
    }

    private JsonToken _handleUnexpectedValue(int i) throws IOException {
        int i_decodeUtf8_3;
        int i2;
        if (i != 39 || !isEnabled(JsonParser.Feature.ALLOW_SINGLE_QUOTES)) {
            _reportUnexpectedChar(i, "expected a valid value (number, String, array, object, 'true', 'false' or 'null')");
        }
        char[] cArrEmptyAndGetCurrentSegment = this._textBuffer.emptyAndGetCurrentSegment();
        int[] inputCodeUtf8 = CharTypes.getInputCodeUtf8();
        byte[] bArr = this._inputBuffer;
        int i3 = 0;
        while (true) {
            if (this._inputPtr >= this._inputEnd) {
                loadMoreGuaranteed();
            }
            if (i3 >= cArrEmptyAndGetCurrentSegment.length) {
                cArrEmptyAndGetCurrentSegment = this._textBuffer.finishCurrentSegment();
                i3 = 0;
            }
            int i4 = this._inputEnd;
            int length = this._inputPtr + (cArrEmptyAndGetCurrentSegment.length - i3);
            if (length >= i4) {
                length = i4;
            }
            while (this._inputPtr < length) {
                int i5 = this._inputPtr;
                this._inputPtr = i5 + 1;
                int i6 = bArr[i5] & 255;
                if (i6 == 39 || inputCodeUtf8[i6] != 0) {
                    if (i6 == 39) {
                        this._textBuffer.setCurrentLength(i3);
                        return JsonToken.VALUE_STRING;
                    }
                    switch (inputCodeUtf8[i6]) {
                        case 1:
                            i_decodeUtf8_3 = i6 == 34 ? i6 : _decodeEscaped();
                            break;
                        case 2:
                            i_decodeUtf8_3 = _decodeUtf8_2(i6);
                            break;
                        case 3:
                            i_decodeUtf8_3 = this._inputEnd - this._inputPtr < 2 ? _decodeUtf8_3(i6) : _decodeUtf8_3fast(i6);
                            break;
                        case 4:
                            int i_decodeUtf8_4 = _decodeUtf8_4(i6);
                            int i7 = i3 + 1;
                            cArrEmptyAndGetCurrentSegment[i3] = (char) (55296 | (i_decodeUtf8_4 >> 10));
                            if (i7 >= cArrEmptyAndGetCurrentSegment.length) {
                                cArrEmptyAndGetCurrentSegment = this._textBuffer.finishCurrentSegment();
                                i3 = 0;
                            } else {
                                i3 = i7;
                            }
                            i_decodeUtf8_3 = 56320 | (i_decodeUtf8_4 & 1023);
                            break;
                        default:
                            if (i6 < 32) {
                                _throwUnquotedSpace(i6, "string value");
                            }
                            _reportInvalidChar(i6);
                            break;
                    }
                    if (i3 >= cArrEmptyAndGetCurrentSegment.length) {
                        cArrEmptyAndGetCurrentSegment = this._textBuffer.finishCurrentSegment();
                        i2 = 0;
                    } else {
                        i2 = i3;
                    }
                    i3 = i2 + 1;
                    cArrEmptyAndGetCurrentSegment[i2] = (char) i_decodeUtf8_3;
                    break;
                }
                cArrEmptyAndGetCurrentSegment[i3] = (char) i6;
                i3++;
            }
        }
    }

    /* JADX WARN: Code duplicated, block: B:97:0x01b3 A[PHI: r6
      0x01b3: PHI (r6v3 int) = (r6v2 int), (r6v2 int), (r6v14 int) binds: [B:18:0x0040, B:20:0x0044, B:25:0x0051] A[DONT_GENERATE, DONT_INLINE]] */
    private Name _handleUnusualFieldName(int i) throws IOException {
        int[] iArrGrowArrayBy;
        int i2;
        int i3;
        int i4;
        int[] iArr;
        int i5;
        int i6;
        int i7;
        int i8;
        int i9;
        int[] iArr2;
        int i10;
        int i11;
        int i12;
        int i13;
        int i14;
        int i15;
        int i16;
        int[] iArr3;
        int i17;
        int i18;
        int i19;
        int[] iArr4;
        int i20 = 0;
        if (i != 39 || !isEnabled(JsonParser.Feature.ALLOW_SINGLE_QUOTES)) {
            if (!isEnabled(JsonParser.Feature.ALLOW_UNQUOTED_FIELD_NAMES)) {
                _reportUnexpectedChar(i, "was expecting double-quote to start field name");
            }
            int[] inputCodeUtf8JsNames = CharTypes.getInputCodeUtf8JsNames();
            if (inputCodeUtf8JsNames[i] != 0) {
                _reportUnexpectedChar(i, "was expecting either valid name character (for unquoted name) or double-quote (for quoted) to start field name");
            }
            int[] iArrGrowArrayBy2 = this._quadBuffer;
            int i21 = 0;
            int i22 = 0;
            int i23 = i;
            while (true) {
                if (i20 < 4) {
                    int i24 = i20 + 1;
                    i3 = i23 | (i21 << 8);
                    i4 = i22;
                    iArrGrowArrayBy = iArrGrowArrayBy2;
                    i2 = i24;
                } else {
                    if (i22 >= iArrGrowArrayBy2.length) {
                        iArrGrowArrayBy2 = growArrayBy(iArrGrowArrayBy2, iArrGrowArrayBy2.length);
                        this._quadBuffer = iArrGrowArrayBy2;
                    }
                    int i25 = i22 + 1;
                    iArrGrowArrayBy2[i22] = i21;
                    iArrGrowArrayBy = iArrGrowArrayBy2;
                    i2 = 1;
                    i3 = i23;
                    i4 = i25;
                }
                if (this._inputPtr >= this._inputEnd && !loadMore()) {
                    _reportInvalidEOF(" in field name");
                }
                int i26 = this._inputBuffer[this._inputPtr] & 255;
                if (inputCodeUtf8JsNames[i26] != 0) {
                    break;
                }
                this._inputPtr++;
                i21 = i3;
                i20 = i2;
                iArrGrowArrayBy2 = iArrGrowArrayBy;
                i22 = i4;
                i23 = i26;
            }
            if (i2 > 0) {
                if (i4 >= iArrGrowArrayBy.length) {
                    iArrGrowArrayBy = growArrayBy(iArrGrowArrayBy, iArrGrowArrayBy.length);
                    this._quadBuffer = iArrGrowArrayBy;
                }
                iArrGrowArrayBy[i4] = i3;
                i4++;
            }
            Name nameFindName = this._symbols.findName(iArrGrowArrayBy, i4);
            return nameFindName == null ? addName(iArrGrowArrayBy, i4, i2) : nameFindName;
        }
        if (this._inputPtr >= this._inputEnd && !loadMore()) {
            _reportInvalidEOF(": was expecting closing ''' for name");
        }
        byte[] bArr = this._inputBuffer;
        int i27 = this._inputPtr;
        this._inputPtr = i27 + 1;
        int i_decodeEscaped = bArr[i27] & 255;
        if (i_decodeEscaped == 39) {
            return BytesToNameCanonicalizer.getEmptyName();
        }
        int[] iArrGrowArrayBy3 = this._quadBuffer;
        int[] inputCodeLatin1 = CharTypes.getInputCodeLatin1();
        int i28 = 0;
        int i29 = 0;
        int i30 = 0;
        while (i_decodeEscaped != 39) {
            if (i_decodeEscaped == 34 || inputCodeLatin1[i_decodeEscaped] == 0) {
                int i31 = i28;
                i6 = i_decodeEscaped;
                i7 = i29;
                i8 = i30;
                i9 = i31;
            } else {
                if (i_decodeEscaped != 92) {
                    _throwUnquotedSpace(i_decodeEscaped, "name");
                } else {
                    i_decodeEscaped = _decodeEscaped();
                }
                if (i_decodeEscaped > 127) {
                    if (i28 >= 4) {
                        if (i30 >= iArrGrowArrayBy3.length) {
                            iArrGrowArrayBy3 = growArrayBy(iArrGrowArrayBy3, iArrGrowArrayBy3.length);
                            this._quadBuffer = iArrGrowArrayBy3;
                        }
                        int i32 = i30 + 1;
                        iArrGrowArrayBy3[i30] = i29;
                        i14 = 0;
                        i8 = i32;
                        i13 = 0;
                    } else {
                        int i33 = i28;
                        i13 = i29;
                        i8 = i30;
                        i14 = i33;
                    }
                    if (i_decodeEscaped < 2048) {
                        int i34 = i14 + 1;
                        i18 = (i13 << 8) | (i_decodeEscaped >> 6) | 192;
                        iArr4 = iArrGrowArrayBy3;
                        i19 = i34;
                    } else {
                        int i35 = (i13 << 8) | (i_decodeEscaped >> 12) | 224;
                        int i36 = i14 + 1;
                        if (i36 >= 4) {
                            if (i8 >= iArrGrowArrayBy3.length) {
                                iArrGrowArrayBy3 = growArrayBy(iArrGrowArrayBy3, iArrGrowArrayBy3.length);
                                this._quadBuffer = iArrGrowArrayBy3;
                            }
                            iArrGrowArrayBy3[i8] = i35;
                            i16 = i8 + 1;
                            iArr3 = iArrGrowArrayBy3;
                            i17 = 0;
                            i15 = 0;
                        } else {
                            i15 = i35;
                            i16 = i8;
                            iArr3 = iArrGrowArrayBy3;
                            i17 = i36;
                        }
                        i18 = (i15 << 8) | ((i_decodeEscaped >> 6) & 63) | 128;
                        i19 = i17 + 1;
                        int i37 = i16;
                        iArr4 = iArr3;
                        i8 = i37;
                    }
                    int i38 = i19;
                    iArrGrowArrayBy3 = iArr4;
                    i6 = (i_decodeEscaped & 63) | 128;
                    i7 = i18;
                    i9 = i38;
                } else {
                    int i39 = i28;
                    i6 = i_decodeEscaped;
                    i7 = i29;
                    i8 = i30;
                    i9 = i39;
                }
            }
            if (i9 < 4) {
                int i40 = i9 + 1;
                i11 = i6 | (i7 << 8);
                i12 = i8;
                iArr2 = iArrGrowArrayBy3;
                i10 = i40;
            } else {
                if (i8 >= iArrGrowArrayBy3.length) {
                    iArrGrowArrayBy3 = growArrayBy(iArrGrowArrayBy3, iArrGrowArrayBy3.length);
                    this._quadBuffer = iArrGrowArrayBy3;
                }
                int i41 = i8 + 1;
                iArrGrowArrayBy3[i8] = i7;
                iArr2 = iArrGrowArrayBy3;
                i10 = 1;
                i11 = i6;
                i12 = i41;
            }
            if (this._inputPtr >= this._inputEnd && !loadMore()) {
                _reportInvalidEOF(" in field name");
            }
            byte[] bArr2 = this._inputBuffer;
            int i42 = this._inputPtr;
            this._inputPtr = i42 + 1;
            i_decodeEscaped = bArr2[i42] & 255;
            int i43 = i10;
            iArrGrowArrayBy3 = iArr2;
            i29 = i11;
            i30 = i12;
            i28 = i43;
        }
        if (i28 > 0) {
            if (i30 >= iArrGrowArrayBy3.length) {
                iArrGrowArrayBy3 = growArrayBy(iArrGrowArrayBy3, iArrGrowArrayBy3.length);
                this._quadBuffer = iArrGrowArrayBy3;
            }
            iArrGrowArrayBy3[i30] = i29;
            iArr = iArrGrowArrayBy3;
            i5 = i30 + 1;
        } else {
            iArr = iArrGrowArrayBy3;
            i5 = i30;
        }
        Name nameFindName2 = this._symbols.findName(iArr, i5);
        return nameFindName2 == null ? addName(iArr, i5, i28) : nameFindName2;
    }

    private void _matchToken(JsonToken jsonToken) throws IOException {
        byte[] bArrAsByteArray = jsonToken.asByteArray();
        int length = bArrAsByteArray.length;
        for (int i = 1; i < length; i++) {
            if (this._inputPtr >= this._inputEnd) {
                loadMoreGuaranteed();
            }
            if (bArrAsByteArray[i] != this._inputBuffer[this._inputPtr]) {
                StringBuilder sb = new StringBuilder(jsonToken.asString().substring(0, i));
                while (true) {
                    if (this._inputPtr >= this._inputEnd && !loadMore()) {
                        break;
                    }
                    byte[] bArr = this._inputBuffer;
                    int i2 = this._inputPtr;
                    this._inputPtr = i2 + 1;
                    char c_decodeCharForError = (char) _decodeCharForError(bArr[i2]);
                    if (!Character.isJavaIdentifierPart(c_decodeCharForError)) {
                        break;
                    }
                    this._inputPtr++;
                    sb.append(c_decodeCharForError);
                }
                _reportError("Unrecognized token '" + sb.toString() + "': was expecting 'null', 'true' or 'false'");
            }
            this._inputPtr++;
        }
    }

    private void _reportInvalidChar(int i) throws JsonParseException {
        if (i < 32) {
            _throwInvalidSpace(i);
        }
        _reportInvalidInitial(i);
    }

    private void _reportInvalidInitial(int i) throws JsonParseException {
        _reportError("Invalid UTF-8 start byte 0x" + Integer.toHexString(i));
    }

    private void _reportInvalidOther(int i) throws JsonParseException {
        _reportError("Invalid UTF-8 middle byte 0x" + Integer.toHexString(i));
    }

    private void _reportInvalidOther(int i, int i2) throws JsonParseException {
        this._inputPtr = i2;
        _reportInvalidOther(i);
    }

    private void _skipCR() throws IOException {
        if ((this._inputPtr < this._inputEnd || loadMore()) && this._inputBuffer[this._inputPtr] == 10) {
            this._inputPtr++;
        }
        this._currInputRow++;
        this._currInputRowStart = this._inputPtr;
    }

    private final void _skipComment() throws IOException {
        if (!isEnabled(JsonParser.Feature.ALLOW_COMMENTS)) {
            _reportUnexpectedChar(47, "maybe a (non-standard) comment? (not recognized as one since Feature 'ALLOW_COMMENTS' not enabled for parser)");
        }
        if (this._inputPtr >= this._inputEnd && !loadMore()) {
            _reportInvalidEOF(" in a comment");
        }
        byte[] bArr = this._inputBuffer;
        int i = this._inputPtr;
        this._inputPtr = i + 1;
        int i2 = bArr[i] & 255;
        if (i2 == 47) {
            int[] inputCodeComment = CharTypes.getInputCodeComment();
            while (true) {
                if (this._inputPtr >= this._inputEnd && !loadMore()) {
                    return;
                }
                byte[] bArr2 = this._inputBuffer;
                int i3 = this._inputPtr;
                this._inputPtr = i3 + 1;
                int i4 = bArr2[i3] & 255;
                int i5 = inputCodeComment[i4];
                if (i5 != 0) {
                    switch (i5) {
                        case 10:
                            _skipLF();
                            return;
                        case 13:
                            _skipCR();
                            return;
                        case 42:
                            break;
                        default:
                            _reportInvalidChar(i4);
                            break;
                    }
                }
            }
        } else {
            if (i2 != 42) {
                _reportUnexpectedChar(i2, "was expecting either '*' or '/' for a comment");
                return;
            }
            int[] inputCodeComment2 = CharTypes.getInputCodeComment();
            while (true) {
                if (this._inputPtr >= this._inputEnd && !loadMore()) {
                    _reportInvalidEOF(" in a comment");
                    return;
                }
                byte[] bArr3 = this._inputBuffer;
                int i6 = this._inputPtr;
                this._inputPtr = i6 + 1;
                int i7 = bArr3[i6] & 255;
                int i8 = inputCodeComment2[i7];
                if (i8 != 0) {
                    switch (i8) {
                        case 10:
                            _skipLF();
                            break;
                        case 13:
                            _skipCR();
                            break;
                        case 42:
                            if (this._inputBuffer[this._inputPtr] == 47) {
                                this._inputPtr++;
                                return;
                            }
                            break;
                        default:
                            _reportInvalidChar(i7);
                            break;
                    }
                }
            }
        }
    }

    private void _skipLF() throws IOException {
        this._currInputRow++;
        this._currInputRowStart = this._inputPtr;
    }

    private final int _skipWS() throws IOException {
        while (true) {
            if (this._inputPtr >= this._inputEnd && !loadMore()) {
                throw _constructError("Unexpected end-of-input within/between " + this._parsingContext.getTypeDesc() + " entries");
            }
            byte[] bArr = this._inputBuffer;
            int i = this._inputPtr;
            this._inputPtr = i + 1;
            int i2 = bArr[i] & 255;
            if (i2 > 32) {
                if (i2 != 47) {
                    return i2;
                }
                _skipComment();
            } else if (i2 != 32) {
                if (i2 == 10) {
                    _skipLF();
                } else if (i2 == 13) {
                    _skipCR();
                } else if (i2 != 9) {
                    _throwInvalidSpace(i2);
                }
            }
        }
    }

    /* JADX WARN: Code duplicated, block: B:52:0x0114 A[PHI: r2 r3
      0x0114: PHI (r2v6 int) = (r2v5 int), (r2v17 int) binds: [B:8:0x0033, B:30:0x00a4] A[DONT_GENERATE, DONT_INLINE]
      0x0114: PHI (r3v4 int) = (r3v3 int), (r3v9 int) binds: [B:8:0x0033, B:30:0x00a4] A[DONT_GENERATE, DONT_INLINE]] */
    private final Name addName(int[] iArr, int i, int i2) throws JsonParseException {
        int i3;
        char[] cArrExpandCurrentSegment;
        int i4;
        int i5;
        int i6;
        int i7;
        int i8;
        int i9 = ((i << 2) - 4) + i2;
        if (i2 < 4) {
            i3 = iArr[i - 1];
            iArr[i - 1] = i3 << ((4 - i2) << 3);
        } else {
            i3 = 0;
        }
        char[] cArrEmptyAndGetCurrentSegment = this._textBuffer.emptyAndGetCurrentSegment();
        int i10 = 0;
        int i11 = 0;
        while (i11 < i9) {
            int i12 = (iArr[i11 >> 2] >> ((3 - (i11 & 3)) << 3)) & 255;
            int i13 = i11 + 1;
            if (i12 <= 127) {
                cArrExpandCurrentSegment = cArrEmptyAndGetCurrentSegment;
                i4 = i12;
                i5 = i13;
                i6 = i10;
            } else {
                if ((i12 & 224) == 192) {
                    i7 = i12 & 31;
                    i8 = 1;
                } else if ((i12 & 240) == 224) {
                    i7 = i12 & 15;
                    i8 = 2;
                } else if ((i12 & 248) == 240) {
                    i7 = i12 & 7;
                    i8 = 3;
                } else {
                    _reportInvalidInitial(i12);
                    i7 = 1;
                    i8 = 1;
                }
                if (i13 + i8 > i9) {
                    _reportInvalidEOF(" in field name");
                }
                int i14 = iArr[i13 >> 2] >> ((3 - (i13 & 3)) << 3);
                i13++;
                if ((i14 & 192) != 128) {
                    _reportInvalidOther(i14);
                }
                i12 = (i7 << 6) | (i14 & 63);
                if (i8 > 1) {
                    int i15 = iArr[i13 >> 2] >> ((3 - (i13 & 3)) << 3);
                    i13++;
                    if ((i15 & 192) != 128) {
                        _reportInvalidOther(i15);
                    }
                    i12 = (i12 << 6) | (i15 & 63);
                    if (i8 > 2) {
                        int i16 = iArr[i13 >> 2] >> ((3 - (i13 & 3)) << 3);
                        i13++;
                        if ((i16 & 192) != 128) {
                            _reportInvalidOther(i16 & 255);
                        }
                        i12 = (i12 << 6) | (i16 & 63);
                    }
                }
                if (i8 > 2) {
                    int i17 = i12 - 65536;
                    if (i10 >= cArrEmptyAndGetCurrentSegment.length) {
                        cArrEmptyAndGetCurrentSegment = this._textBuffer.expandCurrentSegment();
                    }
                    cArrEmptyAndGetCurrentSegment[i10] = (char) (55296 + (i17 >> 10));
                    int i18 = (i17 & 1023) | 56320;
                    i5 = i13;
                    i6 = i10 + 1;
                    cArrExpandCurrentSegment = cArrEmptyAndGetCurrentSegment;
                    i4 = i18;
                } else {
                    cArrExpandCurrentSegment = cArrEmptyAndGetCurrentSegment;
                    i4 = i12;
                    i5 = i13;
                    i6 = i10;
                }
            }
            if (i6 >= cArrExpandCurrentSegment.length) {
                cArrExpandCurrentSegment = this._textBuffer.expandCurrentSegment();
            }
            i10 = i6 + 1;
            cArrExpandCurrentSegment[i6] = (char) i4;
            i11 = i5;
            cArrEmptyAndGetCurrentSegment = cArrExpandCurrentSegment;
        }
        String str = new String(cArrEmptyAndGetCurrentSegment, 0, i10);
        if (i2 < 4) {
            iArr[i - 1] = i3;
        }
        return this._symbols.addName(str, iArr, i);
    }

    private final Name findName(int i, int i2) throws JsonParseException {
        Name nameFindName = this._symbols.findName(i);
        if (nameFindName != null) {
            return nameFindName;
        }
        this._quadBuffer[0] = i;
        return addName(this._quadBuffer, 1, i2);
    }

    private final Name findName(int i, int i2, int i3) throws JsonParseException {
        Name nameFindName = this._symbols.findName(i, i2);
        if (nameFindName != null) {
            return nameFindName;
        }
        this._quadBuffer[0] = i;
        this._quadBuffer[1] = i2;
        return addName(this._quadBuffer, 2, i3);
    }

    private final Name findName(int[] iArr, int i, int i2, int i3) throws JsonParseException {
        if (i >= iArr.length) {
            iArr = growArrayBy(iArr, iArr.length);
            this._quadBuffer = iArr;
        }
        int i4 = i + 1;
        iArr[i] = i2;
        Name nameFindName = this._symbols.findName(iArr, i4);
        return nameFindName == null ? addName(iArr, i4, i3) : nameFindName;
    }

    private static int[] growArrayBy(int[] iArr, int i) {
        if (iArr == null) {
            return new int[i];
        }
        int length = iArr.length;
        int[] iArr2 = new int[length + i];
        System.arraycopy(iArr, 0, iArr2, 0, length);
        return iArr2;
    }

    private int nextByte() throws IOException {
        if (this._inputPtr >= this._inputEnd) {
            loadMoreGuaranteed();
        }
        byte[] bArr = this._inputBuffer;
        int i = this._inputPtr;
        this._inputPtr = i + 1;
        return bArr[i] & 255;
    }

    /* JADX WARN: Code duplicated, block: B:52:0x00d8 A[PHI: r13
      0x00d8: PHI (r13v2 int) = (r13v1 int), (r13v5 int) binds: [B:4:0x0008, B:11:0x0019] A[DONT_GENERATE, DONT_INLINE]] */
    private Name parseEscapedFieldName(int[] iArr, int i, int i2, int i3, int i4) throws IOException {
        int i5;
        int[] iArrGrowArrayBy;
        int i6;
        int[] iArrGrowArrayBy2;
        int i7;
        int i8;
        int[] iArr2;
        int i9;
        int i10;
        int i11;
        int[] iArr3;
        int[] inputCodeLatin1 = CharTypes.getInputCodeLatin1();
        while (true) {
            if (inputCodeLatin1[i3] != 0) {
                if (i3 == 34) {
                    break;
                }
                if (i3 != 92) {
                    _throwUnquotedSpace(i3, "name");
                } else {
                    i3 = _decodeEscaped();
                }
                if (i3 > 127) {
                    if (i4 >= 4) {
                        if (i >= iArr.length) {
                            iArr = growArrayBy(iArr, iArr.length);
                            this._quadBuffer = iArr;
                        }
                        i6 = i + 1;
                        iArr[i] = i2;
                        i4 = 0;
                        i2 = 0;
                        iArrGrowArrayBy2 = iArr;
                    } else {
                        i6 = i;
                        iArrGrowArrayBy2 = iArr;
                    }
                    if (i3 < 2048) {
                        i10 = (i3 >> 6) | 192 | (i2 << 8);
                        iArr3 = iArrGrowArrayBy2;
                        i11 = i4 + 1;
                    } else {
                        int i12 = (i3 >> 12) | 224 | (i2 << 8);
                        int i13 = i4 + 1;
                        if (i13 >= 4) {
                            if (i6 >= iArrGrowArrayBy2.length) {
                                iArrGrowArrayBy2 = growArrayBy(iArrGrowArrayBy2, iArrGrowArrayBy2.length);
                                this._quadBuffer = iArrGrowArrayBy2;
                            }
                            iArrGrowArrayBy2[i6] = i12;
                            i8 = i6 + 1;
                            iArr2 = iArrGrowArrayBy2;
                            i9 = 0;
                            i7 = 0;
                        } else {
                            i7 = i12;
                            i8 = i6;
                            iArr2 = iArrGrowArrayBy2;
                            i9 = i13;
                        }
                        i10 = (i7 << 8) | ((i3 >> 6) & 63) | 128;
                        i11 = i9 + 1;
                        int i14 = i8;
                        iArr3 = iArr2;
                        i6 = i14;
                    }
                    i2 = (i3 & 63) | 128;
                    i4 = i11;
                    i = i6;
                    iArrGrowArrayBy = iArr3;
                    i5 = i10;
                } else {
                    i5 = i2;
                    iArrGrowArrayBy = iArr;
                    i2 = i3;
                }
            } else {
                i5 = i2;
                iArrGrowArrayBy = iArr;
                i2 = i3;
            }
            if (i4 < 4) {
                i4++;
                i2 |= i5 << 8;
                iArr = iArrGrowArrayBy;
            } else {
                if (i >= iArrGrowArrayBy.length) {
                    iArrGrowArrayBy = growArrayBy(iArrGrowArrayBy, iArrGrowArrayBy.length);
                    this._quadBuffer = iArrGrowArrayBy;
                }
                iArrGrowArrayBy[i] = i5;
                i4 = 1;
                i++;
                iArr = iArrGrowArrayBy;
            }
            if (this._inputPtr >= this._inputEnd && !loadMore()) {
                _reportInvalidEOF(" in field name");
            }
            byte[] bArr = this._inputBuffer;
            int i15 = this._inputPtr;
            this._inputPtr = i15 + 1;
            i3 = bArr[i15] & 255;
        }
        if (i4 > 0) {
            if (i >= iArr.length) {
                iArr = growArrayBy(iArr, iArr.length);
                this._quadBuffer = iArr;
            }
            iArr[i] = i2;
            i++;
        }
        Name nameFindName = this._symbols.findName(iArr, i);
        return nameFindName == null ? addName(iArr, i, i4) : nameFindName;
    }

    private final Name parseFieldName(int i, int i2, int i3) throws IOException {
        return parseEscapedFieldName(this._quadBuffer, 0, i, i2, i3);
    }

    private final Name parseFieldName(int i, int i2, int i3, int i4) throws IOException {
        this._quadBuffer[0] = i;
        return parseEscapedFieldName(this._quadBuffer, 1, i2, i3, i4);
    }

    private Name parseLongFieldName(int i) throws IOException {
        int[] inputCodeLatin1 = CharTypes.getInputCodeLatin1();
        int i2 = 2;
        int i3 = i;
        while (this._inputEnd - this._inputPtr >= 4) {
            byte[] bArr = this._inputBuffer;
            int i4 = this._inputPtr;
            this._inputPtr = i4 + 1;
            int i5 = bArr[i4] & 255;
            if (inputCodeLatin1[i5] != 0) {
                return i5 == 34 ? findName(this._quadBuffer, i2, i3, 1) : parseEscapedFieldName(this._quadBuffer, i2, i3, i5, 1);
            }
            int i6 = (i3 << 8) | i5;
            byte[] bArr2 = this._inputBuffer;
            int i7 = this._inputPtr;
            this._inputPtr = i7 + 1;
            int i8 = bArr2[i7] & 255;
            if (inputCodeLatin1[i8] != 0) {
                return i8 == 34 ? findName(this._quadBuffer, i2, i6, 2) : parseEscapedFieldName(this._quadBuffer, i2, i6, i8, 2);
            }
            int i9 = (i6 << 8) | i8;
            byte[] bArr3 = this._inputBuffer;
            int i10 = this._inputPtr;
            this._inputPtr = i10 + 1;
            int i11 = bArr3[i10] & 255;
            if (inputCodeLatin1[i11] != 0) {
                return i11 == 34 ? findName(this._quadBuffer, i2, i9, 3) : parseEscapedFieldName(this._quadBuffer, i2, i9, i11, 3);
            }
            int i12 = (i9 << 8) | i11;
            byte[] bArr4 = this._inputBuffer;
            int i13 = this._inputPtr;
            this._inputPtr = i13 + 1;
            i3 = bArr4[i13] & 255;
            if (inputCodeLatin1[i3] != 0) {
                return i3 == 34 ? findName(this._quadBuffer, i2, i12, 4) : parseEscapedFieldName(this._quadBuffer, i2, i12, i3, 4);
            }
            if (i2 >= this._quadBuffer.length) {
                this._quadBuffer = growArrayBy(this._quadBuffer, i2);
            }
            this._quadBuffer[i2] = i12;
            i2++;
        }
        return parseEscapedFieldName(this._quadBuffer, i2, 0, i3, 0);
    }

    @Override // com.openfeint.internal.vendor.org.codehaus.jackson.impl.JsonParserBase
    protected final void _finishString() throws IOException {
        int i;
        char[] cArrEmptyAndGetCurrentSegment = this._textBuffer.emptyAndGetCurrentSegment();
        int[] inputCodeUtf8 = CharTypes.getInputCodeUtf8();
        byte[] bArr = this._inputBuffer;
        int i2 = 0;
        while (true) {
            int i3 = this._inputPtr;
            if (i3 >= this._inputEnd) {
                loadMoreGuaranteed();
                i3 = this._inputPtr;
            }
            if (i2 >= cArrEmptyAndGetCurrentSegment.length) {
                cArrEmptyAndGetCurrentSegment = this._textBuffer.finishCurrentSegment();
                i2 = 0;
            }
            int i4 = this._inputEnd;
            int length = (cArrEmptyAndGetCurrentSegment.length - i2) + i3;
            if (length >= i4) {
                length = i4;
            }
            while (true) {
                if (i3 >= length) {
                    this._inputPtr = i3;
                    break;
                }
                int i5 = i3 + 1;
                int i_decodeUtf8_3 = bArr[i3] & 255;
                if (inputCodeUtf8[i_decodeUtf8_3] != 0) {
                    this._inputPtr = i5;
                    if (i_decodeUtf8_3 == 34) {
                        this._textBuffer.setCurrentLength(i2);
                        return;
                    }
                    switch (inputCodeUtf8[i_decodeUtf8_3]) {
                        case 1:
                            i_decodeUtf8_3 = _decodeEscaped();
                            break;
                        case 2:
                            i_decodeUtf8_3 = _decodeUtf8_2(i_decodeUtf8_3);
                            break;
                        case 3:
                            i_decodeUtf8_3 = this._inputEnd - this._inputPtr < 2 ? _decodeUtf8_3(i_decodeUtf8_3) : _decodeUtf8_3fast(i_decodeUtf8_3);
                            break;
                        case 4:
                            int i_decodeUtf8_4 = _decodeUtf8_4(i_decodeUtf8_3);
                            int i6 = i2 + 1;
                            cArrEmptyAndGetCurrentSegment[i2] = (char) (55296 | (i_decodeUtf8_4 >> 10));
                            if (i6 >= cArrEmptyAndGetCurrentSegment.length) {
                                cArrEmptyAndGetCurrentSegment = this._textBuffer.finishCurrentSegment();
                                i2 = 0;
                            } else {
                                i2 = i6;
                            }
                            i_decodeUtf8_3 = 56320 | (i_decodeUtf8_4 & 1023);
                            break;
                        default:
                            if (i_decodeUtf8_3 >= 32) {
                                _reportInvalidChar(i_decodeUtf8_3);
                            } else {
                                _throwUnquotedSpace(i_decodeUtf8_3, "string value");
                            }
                            break;
                    }
                    if (i2 >= cArrEmptyAndGetCurrentSegment.length) {
                        cArrEmptyAndGetCurrentSegment = this._textBuffer.finishCurrentSegment();
                        i = 0;
                    } else {
                        i = i2;
                    }
                    i2 = i + 1;
                    cArrEmptyAndGetCurrentSegment[i] = (char) i_decodeUtf8_3;
                    break;
                }
                cArrEmptyAndGetCurrentSegment[i2] = (char) i_decodeUtf8_3;
                i3 = i5;
                i2++;
            }
        }
    }

    @Override // com.openfeint.internal.vendor.org.codehaus.jackson.impl.JsonParserBase, java.io.Closeable, java.lang.AutoCloseable
    public final void close() throws IOException {
        super.close();
        this._symbols.release();
    }

    /* JADX WARN: Can't fix incorrect switch cases order, some code will duplicate */
    @Override // com.openfeint.internal.vendor.org.codehaus.jackson.impl.JsonParserBase, com.openfeint.internal.vendor.org.codehaus.jackson.JsonParser
    public final JsonToken nextToken() throws IOException {
        int i_skipWS;
        JsonToken numberText;
        Name longFieldName;
        if (this._currToken == JsonToken.FIELD_NAME) {
            this._nameCopied = false;
            JsonToken jsonToken = this._nextToken;
            this._nextToken = null;
            if (jsonToken == JsonToken.START_ARRAY) {
                this._parsingContext = this._parsingContext.createChildArrayContext(this._tokenInputRow, this._tokenInputCol);
            } else if (jsonToken == JsonToken.START_OBJECT) {
                this._parsingContext = this._parsingContext.createChildObjectContext(this._tokenInputRow, this._tokenInputCol);
            }
            this._currToken = jsonToken;
            return jsonToken;
        }
        if (this._tokenIncomplete) {
            this._tokenIncomplete = false;
            int[] inputCodeUtf8 = CharTypes.getInputCodeUtf8();
            byte[] bArr = this._inputBuffer;
            while (true) {
                int i = this._inputPtr;
                int i2 = this._inputEnd;
                if (i >= i2) {
                    loadMoreGuaranteed();
                    i = this._inputPtr;
                    i2 = this._inputEnd;
                }
                while (true) {
                    if (i < i2) {
                        int i3 = i + 1;
                        int i4 = bArr[i] & 255;
                        if (inputCodeUtf8[i4] != 0) {
                            this._inputPtr = i3;
                            if (i4 != 34) {
                                switch (inputCodeUtf8[i4]) {
                                    case 1:
                                        _decodeEscaped();
                                        break;
                                    case 2:
                                        if (this._inputPtr >= this._inputEnd) {
                                            loadMoreGuaranteed();
                                        }
                                        byte[] bArr2 = this._inputBuffer;
                                        int i5 = this._inputPtr;
                                        this._inputPtr = i5 + 1;
                                        byte b = bArr2[i5];
                                        if ((b & 192) != 128) {
                                            _reportInvalidOther(b & 255, this._inputPtr);
                                        }
                                        break;
                                    case 3:
                                        if (this._inputPtr >= this._inputEnd) {
                                            loadMoreGuaranteed();
                                        }
                                        byte[] bArr3 = this._inputBuffer;
                                        int i6 = this._inputPtr;
                                        this._inputPtr = i6 + 1;
                                        byte b2 = bArr3[i6];
                                        if ((b2 & 192) != 128) {
                                            _reportInvalidOther(b2 & 255, this._inputPtr);
                                        }
                                        if (this._inputPtr >= this._inputEnd) {
                                            loadMoreGuaranteed();
                                        }
                                        byte[] bArr4 = this._inputBuffer;
                                        int i7 = this._inputPtr;
                                        this._inputPtr = i7 + 1;
                                        byte b3 = bArr4[i7];
                                        if ((b3 & 192) != 128) {
                                            _reportInvalidOther(b3 & 255, this._inputPtr);
                                        }
                                        break;
                                    case 4:
                                        if (this._inputPtr >= this._inputEnd) {
                                            loadMoreGuaranteed();
                                        }
                                        byte[] bArr5 = this._inputBuffer;
                                        int i8 = this._inputPtr;
                                        this._inputPtr = i8 + 1;
                                        byte b4 = bArr5[i8];
                                        if ((b4 & 192) != 128) {
                                            _reportInvalidOther(b4 & 255, this._inputPtr);
                                        }
                                        if (this._inputPtr >= this._inputEnd) {
                                            loadMoreGuaranteed();
                                        }
                                        if ((b4 & 192) != 128) {
                                            _reportInvalidOther(b4 & 255, this._inputPtr);
                                        }
                                        if (this._inputPtr >= this._inputEnd) {
                                            loadMoreGuaranteed();
                                        }
                                        byte[] bArr6 = this._inputBuffer;
                                        int i9 = this._inputPtr;
                                        this._inputPtr = i9 + 1;
                                        byte b5 = bArr6[i9];
                                        if ((b5 & 192) != 128) {
                                            _reportInvalidOther(b5 & 255, this._inputPtr);
                                        }
                                        break;
                                    default:
                                        if (i4 >= 32) {
                                            _reportInvalidChar(i4);
                                        } else {
                                            _throwUnquotedSpace(i4, "string value");
                                        }
                                        break;
                                }
                            }
                        } else {
                            i = i3;
                        }
                    } else {
                        this._inputPtr = i;
                    }
                }
            }
        }
        while (true) {
            if (this._inputPtr < this._inputEnd || loadMore()) {
                byte[] bArr7 = this._inputBuffer;
                int i10 = this._inputPtr;
                this._inputPtr = i10 + 1;
                i_skipWS = bArr7[i10] & 255;
                if (i_skipWS > 32) {
                    if (i_skipWS == 47) {
                        _skipComment();
                    }
                } else if (i_skipWS != 32) {
                    if (i_skipWS == 10) {
                        _skipLF();
                    } else if (i_skipWS == 13) {
                        _skipCR();
                    } else if (i_skipWS != 9) {
                        _throwInvalidSpace(i_skipWS);
                    }
                }
            } else {
                _handleEOF();
                i_skipWS = -1;
            }
        }
        if (i_skipWS < 0) {
            close();
            this._currToken = null;
            return null;
        }
        this._tokenInputTotal = (this._currInputProcessed + ((long) this._inputPtr)) - 1;
        this._tokenInputRow = this._currInputRow;
        this._tokenInputCol = (this._inputPtr - this._currInputRowStart) - 1;
        this._binaryValue = null;
        if (i_skipWS == 93) {
            if (!this._parsingContext.inArray()) {
                _reportMismatchedEndMarker(i_skipWS, '}');
            }
            this._parsingContext = this._parsingContext.getParent();
            JsonToken jsonToken2 = JsonToken.END_ARRAY;
            this._currToken = jsonToken2;
            return jsonToken2;
        }
        if (i_skipWS == 125) {
            if (!this._parsingContext.inObject()) {
                _reportMismatchedEndMarker(i_skipWS, ']');
            }
            this._parsingContext = this._parsingContext.getParent();
            JsonToken jsonToken3 = JsonToken.END_OBJECT;
            this._currToken = jsonToken3;
            return jsonToken3;
        }
        if (this._parsingContext.expectComma()) {
            if (i_skipWS != 44) {
                _reportUnexpectedChar(i_skipWS, "was expecting comma to separate " + this._parsingContext.getTypeDesc() + " entries");
            }
            i_skipWS = _skipWS();
        }
        boolean zInObject = this._parsingContext.inObject();
        if (zInObject) {
            if (i_skipWS != 34) {
                longFieldName = _handleUnusualFieldName(i_skipWS);
            } else if (this._inputEnd - this._inputPtr < 9) {
                if (this._inputPtr >= this._inputEnd && !loadMore()) {
                    _reportInvalidEOF(": was expecting closing '\"' for name");
                }
                byte[] bArr8 = this._inputBuffer;
                int i11 = this._inputPtr;
                this._inputPtr = i11 + 1;
                int i12 = bArr8[i11] & 255;
                longFieldName = i12 == 34 ? BytesToNameCanonicalizer.getEmptyName() : parseEscapedFieldName(this._quadBuffer, 0, 0, i12, 0);
            } else {
                int[] inputCodeLatin1 = CharTypes.getInputCodeLatin1();
                byte[] bArr9 = this._inputBuffer;
                int i13 = this._inputPtr;
                this._inputPtr = i13 + 1;
                int i14 = bArr9[i13] & 255;
                if (inputCodeLatin1[i14] != 0) {
                    longFieldName = i14 == 34 ? BytesToNameCanonicalizer.getEmptyName() : parseFieldName(0, i14, 0);
                } else {
                    byte[] bArr10 = this._inputBuffer;
                    int i15 = this._inputPtr;
                    this._inputPtr = i15 + 1;
                    int i16 = bArr10[i15] & 255;
                    if (inputCodeLatin1[i16] != 0) {
                        longFieldName = i16 == 34 ? findName(i14, 1) : parseFieldName(i14, i16, 1);
                    } else {
                        int i17 = (i14 << 8) | i16;
                        byte[] bArr11 = this._inputBuffer;
                        int i18 = this._inputPtr;
                        this._inputPtr = i18 + 1;
                        int i19 = bArr11[i18] & 255;
                        if (inputCodeLatin1[i19] != 0) {
                            longFieldName = i19 == 34 ? findName(i17, 2) : parseFieldName(i17, i19, 2);
                        } else {
                            int i20 = (i17 << 8) | i19;
                            byte[] bArr12 = this._inputBuffer;
                            int i21 = this._inputPtr;
                            this._inputPtr = i21 + 1;
                            int i22 = bArr12[i21] & 255;
                            if (inputCodeLatin1[i22] != 0) {
                                longFieldName = i22 == 34 ? findName(i20, 3) : parseFieldName(i20, i22, 3);
                            } else {
                                int i23 = (i20 << 8) | i22;
                                byte[] bArr13 = this._inputBuffer;
                                int i24 = this._inputPtr;
                                this._inputPtr = i24 + 1;
                                int i25 = bArr13[i24] & 255;
                                if (inputCodeLatin1[i25] != 0) {
                                    longFieldName = i25 == 34 ? findName(i23, 4) : parseFieldName(i23, i25, 4);
                                } else {
                                    int[] inputCodeLatin2 = CharTypes.getInputCodeLatin1();
                                    byte[] bArr14 = this._inputBuffer;
                                    int i26 = this._inputPtr;
                                    this._inputPtr = i26 + 1;
                                    int i27 = bArr14[i26] & 255;
                                    if (inputCodeLatin2[i27] != 0) {
                                        longFieldName = i27 == 34 ? findName(i23, i25, 1) : parseFieldName(i23, i25, i27, 1);
                                    } else {
                                        int i28 = (i25 << 8) | i27;
                                        byte[] bArr15 = this._inputBuffer;
                                        int i29 = this._inputPtr;
                                        this._inputPtr = i29 + 1;
                                        int i30 = bArr15[i29] & 255;
                                        if (inputCodeLatin2[i30] != 0) {
                                            longFieldName = i30 == 34 ? findName(i23, i28, 2) : parseFieldName(i23, i28, i30, 2);
                                        } else {
                                            int i31 = (i28 << 8) | i30;
                                            byte[] bArr16 = this._inputBuffer;
                                            int i32 = this._inputPtr;
                                            this._inputPtr = i32 + 1;
                                            int i33 = bArr16[i32] & 255;
                                            if (inputCodeLatin2[i33] != 0) {
                                                longFieldName = i33 == 34 ? findName(i23, i31, 3) : parseFieldName(i23, i31, i33, 3);
                                            } else {
                                                int i34 = (i31 << 8) | i33;
                                                byte[] bArr17 = this._inputBuffer;
                                                int i35 = this._inputPtr;
                                                this._inputPtr = i35 + 1;
                                                int i36 = bArr17[i35] & 255;
                                                if (inputCodeLatin2[i36] != 0) {
                                                    longFieldName = i36 == 34 ? findName(i23, i34, 4) : parseFieldName(i23, i34, i36, 4);
                                                } else {
                                                    this._quadBuffer[0] = i23;
                                                    this._quadBuffer[1] = i34;
                                                    longFieldName = parseLongFieldName(i36);
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            this._parsingContext.setCurrentName(longFieldName.getName());
            this._currToken = JsonToken.FIELD_NAME;
            int i_skipWS2 = _skipWS();
            if (i_skipWS2 != 58) {
                _reportUnexpectedChar(i_skipWS2, "was expecting a colon to separate field name and value");
            }
            i_skipWS = _skipWS();
        }
        switch (i_skipWS) {
            case 34:
                this._tokenIncomplete = true;
                numberText = JsonToken.VALUE_STRING;
                break;
            case 45:
            case 48:
            case 49:
            case 50:
            case 51:
            case 52:
            case 53:
            case 54:
            case 55:
            case 56:
            case 57:
                numberText = parseNumberText(i_skipWS);
                break;
            case 91:
                if (!zInObject) {
                    this._parsingContext = this._parsingContext.createChildArrayContext(this._tokenInputRow, this._tokenInputCol);
                }
                numberText = JsonToken.START_ARRAY;
                break;
            case 93:
            case 125:
                _reportUnexpectedChar(i_skipWS, "expected a value");
                _matchToken(JsonToken.VALUE_TRUE);
                numberText = JsonToken.VALUE_TRUE;
                break;
            case 102:
                _matchToken(JsonToken.VALUE_FALSE);
                numberText = JsonToken.VALUE_FALSE;
                break;
            case 110:
                _matchToken(JsonToken.VALUE_NULL);
                numberText = JsonToken.VALUE_NULL;
                break;
            case 116:
                _matchToken(JsonToken.VALUE_TRUE);
                numberText = JsonToken.VALUE_TRUE;
                break;
            case 123:
                if (!zInObject) {
                    this._parsingContext = this._parsingContext.createChildObjectContext(this._tokenInputRow, this._tokenInputCol);
                }
                numberText = JsonToken.START_OBJECT;
                break;
            default:
                numberText = _handleUnexpectedValue(i_skipWS);
                break;
        }
        if (zInObject) {
            this._nextToken = numberText;
            return this._currToken;
        }
        this._currToken = numberText;
        return numberText;
    }
}
