package com.openfeint.internal.vendor.org.codehaus.jackson.impl;

import com.openfeint.internal.vendor.org.codehaus.jackson.JsonLocation;
import com.openfeint.internal.vendor.org.codehaus.jackson.JsonParseException;
import com.openfeint.internal.vendor.org.codehaus.jackson.JsonParser;
import com.openfeint.internal.vendor.org.codehaus.jackson.JsonToken;
import com.openfeint.internal.vendor.org.codehaus.jackson.io.IOContext;
import com.openfeint.internal.vendor.org.codehaus.jackson.util.ByteArrayBuilder;
import com.openfeint.internal.vendor.org.codehaus.jackson.util.TextBuffer;
import java.io.IOException;

/* JADX INFO: loaded from: classes.dex */
public abstract class JsonParserBase extends JsonParser {
    protected byte[] _binaryValue;
    protected boolean _closed;
    protected final IOContext _ioContext;
    protected JsonToken _nextToken;
    protected JsonReadContext _parsingContext;
    protected final TextBuffer _textBuffer;
    protected int _inputPtr = 0;
    protected int _inputEnd = 0;
    protected long _currInputProcessed = 0;
    protected int _currInputRow = 1;
    protected int _currInputRowStart = 0;
    protected long _tokenInputTotal = 0;
    protected int _tokenInputRow = 1;
    protected int _tokenInputCol = 0;
    protected boolean _tokenIncomplete = false;
    protected char[] _nameCopyBuffer = null;
    protected boolean _nameCopied = false;
    ByteArrayBuilder _byteArrayBuilder = null;

    protected JsonParserBase(IOContext iOContext, int i) {
        this._ioContext = iOContext;
        this._features = i;
        this._textBuffer = iOContext.constructTextBuffer();
        this._parsingContext = new JsonReadContext(null, 0, this._tokenInputRow, this._tokenInputCol);
    }

    protected static final String _getCharDesc(int i) {
        char c = (char) i;
        if (Character.isISOControl(c)) {
            return "(CTRL-CHAR, code " + i + ")";
        }
        return i > 255 ? "'" + c + "' (code " + i + " / 0x" + Integer.toHexString(i) + ")" : "'" + c + "' (code " + i + ")";
    }

    protected static void _throwInternal() {
        throw new RuntimeException("Internal error: this code path should never get executed");
    }

    protected abstract void _closeInput() throws IOException;

    protected abstract void _finishString() throws IOException;

    protected final void _handleEOF() throws JsonParseException {
        if (this._parsingContext.inRoot()) {
            return;
        }
        _reportInvalidEOF(": expected close marker for " + this._parsingContext.getTypeDesc() + " (from " + this._parsingContext.getStartLocation(this._ioContext.getSourceReference()) + ")");
    }

    protected void _releaseBuffers() throws IOException {
        this._textBuffer.releaseBuffers();
        char[] cArr = this._nameCopyBuffer;
        if (cArr != null) {
            this._nameCopyBuffer = null;
            this._ioContext.releaseNameCopyBuffer(cArr);
        }
    }

    protected final void _reportError(String str) throws JsonParseException {
        throw _constructError(str);
    }

    protected final void _reportInvalidEOF(String str) throws JsonParseException {
        throw _constructError("Unexpected end-of-input" + str);
    }

    protected final void _reportMismatchedEndMarker(int i, char c) throws JsonParseException {
        throw _constructError("Unexpected close marker '" + ((char) i) + "': expected '" + c + "' (for " + this._parsingContext.getTypeDesc() + " starting at " + ("" + this._parsingContext.getStartLocation(this._ioContext.getSourceReference())) + ")");
    }

    protected final void _reportUnexpectedChar(int i, String str) throws JsonParseException {
        String str2 = "Unexpected character (" + _getCharDesc(i) + ")";
        if (str != null) {
            str2 = str2 + ": " + str;
        }
        throw _constructError(str2);
    }

    protected final void _throwInvalidSpace(int i) throws JsonParseException {
        throw _constructError("Illegal character (" + _getCharDesc((char) i) + "): only regular white space (\\r, \\n, \\t) is allowed between tokens");
    }

    protected final void _throwUnquotedSpace(int i, String str) throws JsonParseException {
        if (!isEnabled(JsonParser.Feature.ALLOW_UNQUOTED_CONTROL_CHARS) || i >= 32) {
            throw _constructError("Illegal unquoted character (" + _getCharDesc((char) i) + "): has to be escaped using backslash to be included in " + str);
        }
    }

    @Override // java.io.Closeable, java.lang.AutoCloseable
    public void close() throws IOException {
        this._closed = true;
        try {
            _closeInput();
        } finally {
            _releaseBuffers();
        }
    }

    @Override // com.openfeint.internal.vendor.org.codehaus.jackson.JsonParser
    public final JsonLocation getCurrentLocation() {
        return new JsonLocation(this._ioContext.getSourceReference(), (this._currInputProcessed + ((long) this._inputPtr)) - 1, this._currInputRow, (this._inputPtr - this._currInputRowStart) + 1, (byte) 0);
    }

    @Override // com.openfeint.internal.vendor.org.codehaus.jackson.JsonParser
    public final String getCurrentName() throws IOException {
        return this._parsingContext.getCurrentName();
    }

    @Override // com.openfeint.internal.vendor.org.codehaus.jackson.JsonParser
    public final String getText() throws IOException {
        if (this._currToken == null) {
            return null;
        }
        switch (this._currToken) {
            case FIELD_NAME:
                return this._parsingContext.getCurrentName();
            case VALUE_STRING:
                if (this._tokenIncomplete) {
                    this._tokenIncomplete = false;
                    _finishString();
                }
                break;
            case VALUE_NUMBER_INT:
            case VALUE_NUMBER_FLOAT:
                break;
            default:
                return this._currToken.asString();
        }
        return this._textBuffer.contentsAsString();
    }

    @Override // com.openfeint.internal.vendor.org.codehaus.jackson.JsonParser
    public final JsonLocation getTokenLocation() {
        return new JsonLocation(this._ioContext.getSourceReference(), this._tokenInputTotal, this._tokenInputRow, this._tokenInputCol + 1, (byte) 0);
    }

    protected abstract boolean loadMore() throws IOException;

    protected final void loadMoreGuaranteed() throws IOException {
        if (loadMore()) {
            return;
        }
        _reportInvalidEOF(" in " + this._currToken);
    }

    @Override // com.openfeint.internal.vendor.org.codehaus.jackson.JsonParser
    public abstract JsonToken nextToken() throws IOException;

    @Override // com.openfeint.internal.vendor.org.codehaus.jackson.JsonParser
    public final JsonParser skipChildren() throws IOException {
        if (this._currToken == JsonToken.START_OBJECT || this._currToken == JsonToken.START_ARRAY) {
            int i = 1;
            while (true) {
                JsonToken jsonTokenNextToken = nextToken();
                if (jsonTokenNextToken != null) {
                    switch (jsonTokenNextToken) {
                        case START_OBJECT:
                        case START_ARRAY:
                            i++;
                            break;
                        case END_OBJECT:
                        case END_ARRAY:
                            i--;
                            if (i != 0) {
                            }
                            break;
                    }
                } else {
                    _handleEOF();
                }
            }
        }
        return this;
    }
}
