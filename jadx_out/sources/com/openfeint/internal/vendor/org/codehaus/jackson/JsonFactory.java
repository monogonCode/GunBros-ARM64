package com.openfeint.internal.vendor.org.codehaus.jackson;

import com.openfeint.internal.vendor.org.codehaus.jackson.impl.ByteSourceBootstrapper;
import com.openfeint.internal.vendor.org.codehaus.jackson.impl.ReaderBasedParser;
import com.openfeint.internal.vendor.org.codehaus.jackson.impl.WriterBasedGenerator;
import com.openfeint.internal.vendor.org.codehaus.jackson.io.IOContext;
import com.openfeint.internal.vendor.org.codehaus.jackson.sym.BytesToNameCanonicalizer;
import com.openfeint.internal.vendor.org.codehaus.jackson.sym.CharsToNameCanonicalizer;
import com.openfeint.internal.vendor.org.codehaus.jackson.util.BufferRecycler;
import java.io.IOException;
import java.io.InputStream;
import java.io.Reader;
import java.io.StringReader;
import java.io.Writer;
import java.lang.ref.SoftReference;

/* JADX INFO: loaded from: classes.dex */
public final class JsonFactory {
    protected int _generatorFeatures;
    protected ObjectCodec _objectCodec;
    protected int _parserFeatures;
    protected BytesToNameCanonicalizer _rootByteSymbols;
    protected CharsToNameCanonicalizer _rootCharSymbols;
    static final int DEFAULT_PARSER_FEATURE_FLAGS = JsonParser.Feature.collectDefaults();
    static final int DEFAULT_GENERATOR_FEATURE_FLAGS = JsonGenerator.Feature.collectDefaults();
    static final ThreadLocal<SoftReference<BufferRecycler>> _recyclerRef = new ThreadLocal<>();

    private JsonFactory() {
        this._rootCharSymbols = CharsToNameCanonicalizer.createRoot();
        this._rootByteSymbols = BytesToNameCanonicalizer.createRoot();
        this._parserFeatures = DEFAULT_PARSER_FEATURE_FLAGS;
        this._generatorFeatures = DEFAULT_GENERATOR_FEATURE_FLAGS;
        this._objectCodec = null;
    }

    public JsonFactory(byte b) {
        this();
    }

    private static IOContext _createContext(Object obj, boolean z) {
        BufferRecycler bufferRecycler;
        SoftReference<BufferRecycler> softReference = _recyclerRef.get();
        BufferRecycler bufferRecycler2 = softReference == null ? null : softReference.get();
        if (bufferRecycler2 == null) {
            BufferRecycler bufferRecycler3 = new BufferRecycler();
            if (softReference == null) {
                _recyclerRef.set(new SoftReference<>(bufferRecycler3));
            }
            bufferRecycler = bufferRecycler3;
        } else {
            bufferRecycler = bufferRecycler2;
        }
        return new IOContext(bufferRecycler, obj, z);
    }

    private JsonParser _createJsonParser(Reader reader, IOContext iOContext) throws IOException {
        return new ReaderBasedParser(iOContext, this._parserFeatures, reader, this._objectCodec, this._rootCharSymbols.makeChild(isEnabled(JsonParser.Feature.CANONICALIZE_FIELD_NAMES), isEnabled(JsonParser.Feature.INTERN_FIELD_NAMES)));
    }

    private boolean isEnabled(JsonParser.Feature feature) {
        return (this._parserFeatures & feature.getMask()) != 0;
    }

    public final JsonGenerator createJsonGenerator(Writer writer) throws IOException {
        return new WriterBasedGenerator(_createContext(writer, false), this._generatorFeatures, this._objectCodec, writer);
    }

    public final JsonParser createJsonParser(InputStream inputStream) throws IOException {
        return new ByteSourceBootstrapper(_createContext(inputStream, false), inputStream).constructParser(this._parserFeatures, this._objectCodec, this._rootByteSymbols, this._rootCharSymbols);
    }

    public final JsonParser createJsonParser(Reader reader) throws IOException {
        return _createJsonParser(reader, _createContext(reader, false));
    }

    public final JsonParser createJsonParser(String str) throws IOException {
        StringReader stringReader = new StringReader(str);
        return _createJsonParser(stringReader, _createContext(stringReader, true));
    }

    public final JsonParser createJsonParser(byte[] bArr) throws IOException {
        return new ByteSourceBootstrapper(_createContext(bArr, true), bArr, bArr.length).constructParser(this._parserFeatures, this._objectCodec, this._rootByteSymbols, this._rootCharSymbols);
    }
}
