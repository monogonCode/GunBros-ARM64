package com.openfeint.internal.vendor.org.codehaus.jackson.impl;

import com.openfeint.internal.vendor.org.codehaus.jackson.JsonParser;
import com.openfeint.internal.vendor.org.codehaus.jackson.JsonToken;
import com.openfeint.internal.vendor.org.codehaus.jackson.ObjectCodec;
import com.openfeint.internal.vendor.org.codehaus.jackson.io.IOContext;
import com.openfeint.internal.vendor.org.codehaus.jackson.sym.CharsToNameCanonicalizer;
import com.openfeint.internal.vendor.org.codehaus.jackson.util.CharTypes;
import com.openfeint.internal.vendor.org.codehaus.jackson.util.TextBuffer;
import java.io.IOException;
import java.io.Reader;

/* JADX INFO: loaded from: classes.dex */
public final class ReaderBasedParser extends ReaderBasedNumericParser {
    protected ObjectCodec _objectCodec;
    protected final CharsToNameCanonicalizer _symbols;

    public ReaderBasedParser(IOContext iOContext, int i, Reader reader, ObjectCodec objectCodec, CharsToNameCanonicalizer charsToNameCanonicalizer) {
        super(iOContext, i, reader);
        this._objectCodec = objectCodec;
        this._symbols = charsToNameCanonicalizer;
    }

    private char _decodeEscaped() throws IOException {
        int i = 0;
        if (this._inputPtr >= this._inputEnd && !loadMore()) {
            _reportInvalidEOF(" in character escape sequence");
        }
        char[] cArr = this._inputBuffer;
        int i2 = this._inputPtr;
        this._inputPtr = i2 + 1;
        char c = cArr[i2];
        switch (c) {
            case '\"':
            case '/':
            case '\\':
                return c;
            case 'b':
                return '\b';
            case 'f':
                return '\f';
            case 'n':
                return '\n';
            case 'r':
                return '\r';
            case 't':
                return '\t';
            case 'u':
                break;
            default:
                _reportError("Unrecognized character escape " + _getCharDesc(c));
                break;
        }
        for (int i3 = 0; i3 < 4; i3++) {
            if (this._inputPtr >= this._inputEnd && !loadMore()) {
                _reportInvalidEOF(" in character escape sequence");
            }
            char[] cArr2 = this._inputBuffer;
            int i4 = this._inputPtr;
            this._inputPtr = i4 + 1;
            char c2 = cArr2[i4];
            int iCharToHex = CharTypes.charToHex(c2);
            if (iCharToHex < 0) {
                _reportUnexpectedChar(c2, "expected a hex-digit for character escape sequence");
            }
            i = (i << 4) | iCharToHex;
        }
        return (char) i;
    }

    private JsonToken _handleUnexpectedValue(int i) throws IOException {
        if (i != 39 || !isEnabled(JsonParser.Feature.ALLOW_SINGLE_QUOTES)) {
            _reportUnexpectedChar(i, "expected a valid value (number, String, array, object, 'true', 'false' or 'null')");
        }
        char[] cArrEmptyAndGetCurrentSegment = this._textBuffer.emptyAndGetCurrentSegment();
        int currentSegmentSize = this._textBuffer.getCurrentSegmentSize();
        while (true) {
            if (this._inputPtr >= this._inputEnd && !loadMore()) {
                _reportInvalidEOF(": was expecting closing quote for a string value");
            }
            char[] cArr = this._inputBuffer;
            int i2 = this._inputPtr;
            this._inputPtr = i2 + 1;
            char c_decodeEscaped = cArr[i2];
            if (c_decodeEscaped <= '\\') {
                if (c_decodeEscaped == '\\') {
                    c_decodeEscaped = _decodeEscaped();
                } else if (c_decodeEscaped <= '\'') {
                    if (c_decodeEscaped == '\'') {
                        this._textBuffer.setCurrentLength(currentSegmentSize);
                        return JsonToken.VALUE_STRING;
                    }
                    if (c_decodeEscaped < ' ') {
                        _throwUnquotedSpace(c_decodeEscaped, "string value");
                    }
                }
            }
            if (currentSegmentSize >= cArrEmptyAndGetCurrentSegment.length) {
                cArrEmptyAndGetCurrentSegment = this._textBuffer.finishCurrentSegment();
                currentSegmentSize = 0;
            }
            int i3 = currentSegmentSize;
            currentSegmentSize = i3 + 1;
            cArrEmptyAndGetCurrentSegment[i3] = c_decodeEscaped;
        }
    }

    private void _matchToken(JsonToken jsonToken) throws IOException {
        String strAsString = jsonToken.asString();
        int length = strAsString.length();
        for (int i = 1; i < length; i++) {
            if (this._inputPtr >= this._inputEnd && !loadMore()) {
                _reportInvalidEOF(" in a value");
            }
            if (this._inputBuffer[this._inputPtr] != strAsString.charAt(i)) {
                StringBuilder sb = new StringBuilder(strAsString.substring(0, i));
                while (true) {
                    if (this._inputPtr >= this._inputEnd && !loadMore()) {
                        break;
                    }
                    char c = this._inputBuffer[this._inputPtr];
                    if (!Character.isJavaIdentifierPart(c)) {
                        break;
                    }
                    this._inputPtr++;
                    sb.append(c);
                }
                _reportError("Unrecognized token '" + sb.toString() + "': was expecting 'null', 'true' or 'false'");
            }
            this._inputPtr++;
        }
    }

    /* JADX WARN: Code duplicated, block: B:89:0x0163 A[SYNTHETIC] */
    /* JADX WARN: Code duplicated, block: B:90:0x0122 A[SYNTHETIC] */
    private String _parseFieldName(int i) throws IOException {
        boolean zIsJavaIdentifierPart;
        int i2;
        int i3;
        int i4;
        int i5 = 0;
        if (i == 34) {
            int i6 = this._inputPtr;
            int i7 = this._inputEnd;
            if (i6 < i7) {
                int[] inputCodeLatin1 = CharTypes.getInputCodeLatin1();
                int length = inputCodeLatin1.length;
                do {
                    char c = this._inputBuffer[i6];
                    if (c < length && inputCodeLatin1[c] != 0) {
                        if (c != '\"') {
                            break;
                        }
                        int i8 = this._inputPtr;
                        this._inputPtr = i6 + 1;
                        return this._symbols.findSymbol(this._inputBuffer, i8, i6 - i8, i5);
                    }
                    i5 = (i5 * 31) + c;
                    i6++;
                } while (i6 < i7);
            }
            int i9 = this._inputPtr;
            this._inputPtr = i6;
            return _parseFieldName2(i9, i5, 34);
        }
        if (i == 39 && isEnabled(JsonParser.Feature.ALLOW_SINGLE_QUOTES)) {
            int i10 = this._inputPtr;
            int i11 = this._inputEnd;
            if (i10 < i11) {
                int[] inputCodeLatin2 = CharTypes.getInputCodeLatin1();
                int length2 = inputCodeLatin2.length;
                do {
                    char c2 = this._inputBuffer[i10];
                    if (c2 != '\'') {
                        if (c2 < length2 && inputCodeLatin2[c2] != 0) {
                            break;
                        }
                        i5 = (i5 * 31) + c2;
                        i10++;
                    } else {
                        int i12 = this._inputPtr;
                        this._inputPtr = i10 + 1;
                        return this._symbols.findSymbol(this._inputBuffer, i12, i10 - i12, i5);
                    }
                } while (i10 < i11);
            }
            int i13 = this._inputPtr;
            this._inputPtr = i10;
            return _parseFieldName2(i13, i5, 39);
        }
        if (!isEnabled(JsonParser.Feature.ALLOW_UNQUOTED_FIELD_NAMES)) {
            _reportUnexpectedChar(i, "was expecting double-quote to start field name");
        }
        int[] inputCodeLatin1JsNames = CharTypes.getInputCodeLatin1JsNames();
        int length3 = inputCodeLatin1JsNames.length;
        if (i < length3) {
            zIsJavaIdentifierPart = inputCodeLatin1JsNames[i] == 0 && (i < 48 || i > 57);
        } else {
            zIsJavaIdentifierPart = Character.isJavaIdentifierPart((char) i);
        }
        if (!zIsJavaIdentifierPart) {
            _reportUnexpectedChar(i, "was expecting either valid name character (for unquoted name) or double-quote (for quoted) to start field name");
        }
        int i14 = this._inputPtr;
        int i15 = this._inputEnd;
        if (i14 < i15) {
            i2 = i14;
            i3 = 0;
            do {
                char c3 = this._inputBuffer[i2];
                if (c3 < length3) {
                    if (inputCodeLatin1JsNames[c3] != 0) {
                        int i16 = this._inputPtr - 1;
                        this._inputPtr = i2;
                        return this._symbols.findSymbol(this._inputBuffer, i16, i2 - i16, i3);
                    }
                } else if (!Character.isJavaIdentifierPart(c3)) {
                    int i17 = this._inputPtr - 1;
                    this._inputPtr = i2;
                    return this._symbols.findSymbol(this._inputBuffer, i17, i2 - i17, i3);
                }
                i3 = (i3 * 31) + c3;
                i2++;
            } while (i2 < i15);
        } else {
            i2 = i14;
            i3 = 0;
        }
        int i18 = this._inputPtr - 1;
        this._inputPtr = i2;
        this._textBuffer.resetWithShared(this._inputBuffer, i18, this._inputPtr - i18);
        char[] currentSegment = this._textBuffer.getCurrentSegment();
        int currentSegmentSize = this._textBuffer.getCurrentSegmentSize();
        int length4 = inputCodeLatin1JsNames.length;
        char[] cArrFinishCurrentSegment = currentSegment;
        int i19 = i3;
        int i20 = currentSegmentSize;
        while (true) {
            if (this._inputPtr >= this._inputEnd && !loadMore()) {
                break;
            }
            char c4 = this._inputBuffer[this._inputPtr];
            if (c4 <= length4) {
                if (inputCodeLatin1JsNames[c4] != 0) {
                    break;
                }
                this._inputPtr++;
                i19 = (i19 * 31) + c4;
                i4 = i20 + 1;
                cArrFinishCurrentSegment[i20] = c4;
                if (i4 >= cArrFinishCurrentSegment.length) {
                    cArrFinishCurrentSegment = this._textBuffer.finishCurrentSegment();
                    i20 = 0;
                } else {
                    i20 = i4;
                }
            } else {
                if (!Character.isJavaIdentifierPart(c4)) {
                    break;
                }
                this._inputPtr++;
                i19 = (i19 * 31) + c4;
                i4 = i20 + 1;
                cArrFinishCurrentSegment[i20] = c4;
                if (i4 >= cArrFinishCurrentSegment.length) {
                    cArrFinishCurrentSegment = this._textBuffer.finishCurrentSegment();
                    i20 = 0;
                } else {
                    i20 = i4;
                }
            }
        }
        this._textBuffer.setCurrentLength(i20);
        TextBuffer textBuffer = this._textBuffer;
        return this._symbols.findSymbol(textBuffer.getTextBuffer(), textBuffer.getTextOffset(), textBuffer.size(), i19);
    }

    private String _parseFieldName2(int i, int i2, int i3) throws IOException {
        char c_decodeEscaped;
        this._textBuffer.resetWithShared(this._inputBuffer, i, this._inputPtr - i);
        char[] currentSegment = this._textBuffer.getCurrentSegment();
        int currentSegmentSize = this._textBuffer.getCurrentSegmentSize();
        while (true) {
            if (this._inputPtr >= this._inputEnd && !loadMore()) {
                _reportInvalidEOF(": was expecting closing '" + ((char) i3) + "' for name");
            }
            char[] cArr = this._inputBuffer;
            int i4 = this._inputPtr;
            this._inputPtr = i4 + 1;
            char c = cArr[i4];
            if (c > '\\') {
                c_decodeEscaped = c;
            } else if (c == '\\') {
                c_decodeEscaped = _decodeEscaped();
            } else {
                if (c <= i3) {
                    if (c == i3) {
                        this._textBuffer.setCurrentLength(currentSegmentSize);
                        TextBuffer textBuffer = this._textBuffer;
                        return this._symbols.findSymbol(textBuffer.getTextBuffer(), textBuffer.getTextOffset(), textBuffer.size(), i2);
                    }
                    if (c < ' ') {
                        _throwUnquotedSpace(c, "name");
                    }
                }
                c_decodeEscaped = c;
            }
            i2 = (i2 * 31) + c;
            int i5 = currentSegmentSize + 1;
            currentSegment[currentSegmentSize] = c_decodeEscaped;
            if (i5 >= currentSegment.length) {
                currentSegment = this._textBuffer.finishCurrentSegment();
                currentSegmentSize = 0;
            } else {
                currentSegmentSize = i5;
            }
        }
    }

    private void _skipCR() throws IOException {
        if ((this._inputPtr < this._inputEnd || loadMore()) && this._inputBuffer[this._inputPtr] == '\n') {
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
        char[] cArr = this._inputBuffer;
        int i = this._inputPtr;
        this._inputPtr = i + 1;
        char c = cArr[i];
        if (c != '/') {
            if (c != '*') {
                _reportUnexpectedChar(c, "was expecting either '*' or '/' for a comment");
                return;
            }
            while (true) {
                if (this._inputPtr >= this._inputEnd && !loadMore()) {
                    break;
                }
                char[] cArr2 = this._inputBuffer;
                int i2 = this._inputPtr;
                this._inputPtr = i2 + 1;
                char c2 = cArr2[i2];
                if (c2 <= '*') {
                    if (c2 == '*') {
                        if (this._inputPtr >= this._inputEnd && !loadMore()) {
                            break;
                        } else if (this._inputBuffer[this._inputPtr] == '/') {
                            this._inputPtr++;
                            return;
                        }
                    } else if (c2 < ' ') {
                        if (c2 == '\n') {
                            _skipLF();
                        } else if (c2 == '\r') {
                            _skipCR();
                        } else if (c2 != '\t') {
                            _throwInvalidSpace(c2);
                        }
                    }
                }
            }
            _reportInvalidEOF(" in a comment");
            return;
        }
        while (true) {
            if (this._inputPtr >= this._inputEnd && !loadMore()) {
                return;
            }
            char[] cArr3 = this._inputBuffer;
            int i3 = this._inputPtr;
            this._inputPtr = i3 + 1;
            char c3 = cArr3[i3];
            if (c3 < ' ') {
                if (c3 == '\n') {
                    _skipLF();
                    return;
                } else if (c3 == '\r') {
                    _skipCR();
                    return;
                } else if (c3 != '\t') {
                    _throwInvalidSpace(c3);
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
            char[] cArr = this._inputBuffer;
            int i = this._inputPtr;
            this._inputPtr = i + 1;
            char c = cArr[i];
            if (c > ' ') {
                if (c != '/') {
                    return c;
                }
                _skipComment();
            } else if (c != ' ') {
                if (c == '\n') {
                    _skipLF();
                } else if (c == '\r') {
                    _skipCR();
                } else if (c != '\t') {
                    _throwInvalidSpace(c);
                }
            }
        }
    }

    @Override // com.openfeint.internal.vendor.org.codehaus.jackson.impl.JsonParserBase
    protected final void _finishString() throws IOException {
        int i = this._inputPtr;
        int i2 = this._inputEnd;
        if (i < i2) {
            int[] inputCodeLatin1 = CharTypes.getInputCodeLatin1();
            int length = inputCodeLatin1.length;
            do {
                char c = this._inputBuffer[i];
                if (c < length && inputCodeLatin1[c] != 0) {
                    if (c != '\"') {
                        break;
                    }
                    this._textBuffer.resetWithShared(this._inputBuffer, this._inputPtr, i - this._inputPtr);
                    this._inputPtr = i + 1;
                    return;
                }
                i++;
            } while (i < i2);
        }
        this._textBuffer.resetWithCopy(this._inputBuffer, this._inputPtr, i - this._inputPtr);
        this._inputPtr = i;
        char[] currentSegment = this._textBuffer.getCurrentSegment();
        int currentSegmentSize = this._textBuffer.getCurrentSegmentSize();
        while (true) {
            if (this._inputPtr >= this._inputEnd && !loadMore()) {
                _reportInvalidEOF(": was expecting closing quote for a string value");
            }
            char[] cArr = this._inputBuffer;
            int i3 = this._inputPtr;
            this._inputPtr = i3 + 1;
            char c_decodeEscaped = cArr[i3];
            if (c_decodeEscaped <= '\\') {
                if (c_decodeEscaped == '\\') {
                    c_decodeEscaped = _decodeEscaped();
                } else if (c_decodeEscaped <= '\"') {
                    if (c_decodeEscaped == '\"') {
                        this._textBuffer.setCurrentLength(currentSegmentSize);
                        return;
                    } else if (c_decodeEscaped < ' ') {
                        _throwUnquotedSpace(c_decodeEscaped, "string value");
                    }
                }
            }
            if (currentSegmentSize >= currentSegment.length) {
                currentSegment = this._textBuffer.finishCurrentSegment();
                currentSegmentSize = 0;
            }
            int i4 = currentSegmentSize;
            currentSegmentSize = i4 + 1;
            currentSegment[i4] = c_decodeEscaped;
        }
    }

    @Override // com.openfeint.internal.vendor.org.codehaus.jackson.impl.JsonParserBase, java.io.Closeable, java.lang.AutoCloseable
    public final void close() throws IOException {
        super.close();
        this._symbols.release();
    }

    /* JADX WARN: Can't fix incorrect switch cases order, some code will duplicate */
    /* JADX WARN: Multi-variable type inference failed */
    /* JADX WARN: Type inference failed for: r0v39 */
    /* JADX WARN: Type inference failed for: r0v4, types: [char, int] */
    /* JADX WARN: Type inference failed for: r0v49 */
    /* JADX WARN: Type inference failed for: r0v5, types: [int] */
    /* JADX WARN: Type inference failed for: r0v50 */
    /* JADX WARN: Type inference failed for: r0v51 */
    /* JADX WARN: Type inference failed for: r0v52 */
    /* JADX WARN: Type inference failed for: r0v6, types: [int] */
    /* JADX WARN: Type inference failed for: r0v7, types: [int] */
    /* JADX WARN: Type inference failed for: r9v0, types: [com.openfeint.internal.vendor.org.codehaus.jackson.impl.ReaderBasedParser] */
    @Override // com.openfeint.internal.vendor.org.codehaus.jackson.impl.JsonParserBase, com.openfeint.internal.vendor.org.codehaus.jackson.JsonParser
    public final JsonToken nextToken() throws IOException {
        char c;
        ?? _skipWS;
        JsonToken numberText;
        int i;
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
            int i2 = this._inputPtr;
            int i3 = this._inputEnd;
            char[] cArr = this._inputBuffer;
            while (true) {
                if (i2 >= i3) {
                    this._inputPtr = i2;
                    if (!loadMore()) {
                        _reportInvalidEOF(": was expecting closing quote for a string value");
                    }
                    i2 = this._inputPtr;
                    i3 = this._inputEnd;
                }
                i = i2 + 1;
                char c2 = cArr[i2];
                if (c2 <= '\\') {
                    if (c2 == '\\') {
                        this._inputPtr = i;
                        _decodeEscaped();
                        i2 = this._inputPtr;
                        i3 = this._inputEnd;
                    } else if (c2 <= '\"') {
                        if (c2 == '\"') {
                            break;
                        }
                        if (c2 < ' ') {
                            this._inputPtr = i;
                            _throwUnquotedSpace(c2, "string value");
                        }
                    }
                }
                i2 = i;
            }
            this._inputPtr = i;
        }
        while (true) {
            if (this._inputPtr >= this._inputEnd && !loadMore()) {
                _handleEOF();
                c = -1;
                break;
            }
            char[] cArr2 = this._inputBuffer;
            int i4 = this._inputPtr;
            this._inputPtr = i4 + 1;
            c = cArr2[i4];
            if (c > 32) {
                if (c != 47) {
                    break;
                }
                _skipComment();
            } else if (c != 32) {
                if (c == 10) {
                    _skipLF();
                } else if (c == 13) {
                    _skipCR();
                } else if (c != 9) {
                    _throwInvalidSpace(c);
                }
            }
        }
        if (c < 0) {
            close();
            this._currToken = null;
            return null;
        }
        this._tokenInputTotal = (this._currInputProcessed + ((long) this._inputPtr)) - 1;
        this._tokenInputRow = this._currInputRow;
        this._tokenInputCol = (this._inputPtr - this._currInputRowStart) - 1;
        this._binaryValue = null;
        if (c == 93) {
            if (!this._parsingContext.inArray()) {
                _reportMismatchedEndMarker(c, '}');
            }
            this._parsingContext = this._parsingContext.getParent();
            JsonToken jsonToken2 = JsonToken.END_ARRAY;
            this._currToken = jsonToken2;
            return jsonToken2;
        }
        if (c == 125) {
            if (!this._parsingContext.inObject()) {
                _reportMismatchedEndMarker(c, ']');
            }
            this._parsingContext = this._parsingContext.getParent();
            JsonToken jsonToken3 = JsonToken.END_OBJECT;
            this._currToken = jsonToken3;
            return jsonToken3;
        }
        if (this._parsingContext.expectComma()) {
            if (c != 44) {
                _skipWS = c;
                _reportUnexpectedChar(c, "was expecting comma to separate " + this._parsingContext.getTypeDesc() + " entries");
            }
            _skipWS = c;
            _skipWS = _skipWS();
        }
        _skipWS = c;
        boolean zInObject = this._parsingContext.inObject();
        ?? _skipWS2 = _skipWS;
        if (zInObject) {
            this._parsingContext.setCurrentName(_parseFieldName(_skipWS));
            this._currToken = JsonToken.FIELD_NAME;
            int i_skipWS = _skipWS();
            if (i_skipWS != 58) {
                _reportUnexpectedChar(i_skipWS, "was expecting a colon to separate field name and value");
            }
            _skipWS2 = _skipWS();
        }
        switch (_skipWS2) {
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
                numberText = parseNumberText(_skipWS2);
                break;
            case 91:
                if (!zInObject) {
                    this._parsingContext = this._parsingContext.createChildArrayContext(this._tokenInputRow, this._tokenInputCol);
                }
                numberText = JsonToken.START_ARRAY;
                break;
            case 93:
            case 125:
                _reportUnexpectedChar(_skipWS2, "expected a value");
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
                numberText = _handleUnexpectedValue(_skipWS2);
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
