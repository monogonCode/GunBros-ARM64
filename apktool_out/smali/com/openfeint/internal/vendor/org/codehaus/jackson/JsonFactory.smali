.class public final Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonFactory;
.super Ljava/lang/Object;


# static fields
.field static final DEFAULT_GENERATOR_FEATURE_FLAGS:I

.field static final DEFAULT_PARSER_FEATURE_FLAGS:I

.field static final _recyclerRef:Ljava/lang/ThreadLocal;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/ThreadLocal",
            "<",
            "Ljava/lang/ref/SoftReference",
            "<",
            "Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/BufferRecycler;",
            ">;>;"
        }
    .end annotation
.end field


# instance fields
.field protected _generatorFeatures:I

.field protected _objectCodec:Lcom/openfeint/internal/vendor/org/codehaus/jackson/ObjectCodec;

.field protected _parserFeatures:I

.field protected _rootByteSymbols:Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;

.field protected _rootCharSymbols:Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/CharsToNameCanonicalizer;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    invoke-static {}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser$Feature;->collectDefaults()I

    move-result v0

    sput v0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonFactory;->DEFAULT_PARSER_FEATURE_FLAGS:I

    invoke-static {}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonGenerator$Feature;->collectDefaults()I

    move-result v0

    sput v0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonFactory;->DEFAULT_GENERATOR_FEATURE_FLAGS:I

    new-instance v0, Ljava/lang/ThreadLocal;

    invoke-direct {v0}, Ljava/lang/ThreadLocal;-><init>()V

    sput-object v0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonFactory;->_recyclerRef:Ljava/lang/ThreadLocal;

    return-void
.end method

.method private constructor <init>()V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    invoke-static {}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/CharsToNameCanonicalizer;->createRoot()Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/CharsToNameCanonicalizer;

    move-result-object v0

    iput-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonFactory;->_rootCharSymbols:Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/CharsToNameCanonicalizer;

    invoke-static {}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->createRoot()Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;

    move-result-object v0

    iput-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonFactory;->_rootByteSymbols:Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;

    sget v0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonFactory;->DEFAULT_PARSER_FEATURE_FLAGS:I

    iput v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonFactory;->_parserFeatures:I

    sget v0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonFactory;->DEFAULT_GENERATOR_FEATURE_FLAGS:I

    iput v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonFactory;->_generatorFeatures:I

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonFactory;->_objectCodec:Lcom/openfeint/internal/vendor/org/codehaus/jackson/ObjectCodec;

    return-void
.end method

.method public constructor <init>(B)V
    .locals 0

    invoke-direct {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonFactory;-><init>()V

    return-void
.end method

.method private static _createContext(Ljava/lang/Object;Z)Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/IOContext;
    .locals 4

    new-instance v2, Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/IOContext;

    sget-object v0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonFactory;->_recyclerRef:Ljava/lang/ThreadLocal;

    invoke-virtual {v0}, Ljava/lang/ThreadLocal;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/ref/SoftReference;

    if-nez v0, :cond_1

    const/4 v1, 0x0

    :goto_0
    if-nez v1, :cond_2

    new-instance v1, Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/BufferRecycler;

    invoke-direct {v1}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/BufferRecycler;-><init>()V

    if-nez v0, :cond_0

    sget-object v0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonFactory;->_recyclerRef:Ljava/lang/ThreadLocal;

    new-instance v3, Ljava/lang/ref/SoftReference;

    invoke-direct {v3, v1}, Ljava/lang/ref/SoftReference;-><init>(Ljava/lang/Object;)V

    invoke-virtual {v0, v3}, Ljava/lang/ThreadLocal;->set(Ljava/lang/Object;)V

    :cond_0
    move-object v0, v1

    :goto_1
    invoke-direct {v2, v0, p0, p1}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/IOContext;-><init>(Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/BufferRecycler;Ljava/lang/Object;Z)V

    return-object v2

    :cond_1
    invoke-virtual {v0}, Ljava/lang/ref/SoftReference;->get()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/BufferRecycler;

    goto :goto_0

    :cond_2
    move-object v0, v1

    goto :goto_1
.end method

.method private _createJsonParser(Ljava/io/Reader;Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/IOContext;)Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser;
    .locals 6
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParseException;
        }
    .end annotation

    new-instance v0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;

    iget v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonFactory;->_parserFeatures:I

    iget-object v4, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonFactory;->_objectCodec:Lcom/openfeint/internal/vendor/org/codehaus/jackson/ObjectCodec;

    iget-object v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonFactory;->_rootCharSymbols:Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/CharsToNameCanonicalizer;

    sget-object v3, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser$Feature;->CANONICALIZE_FIELD_NAMES:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser$Feature;

    invoke-direct {p0, v3}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonFactory;->isEnabled(Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser$Feature;)Z

    move-result v3

    sget-object v5, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser$Feature;->INTERN_FIELD_NAMES:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser$Feature;

    invoke-direct {p0, v5}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonFactory;->isEnabled(Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser$Feature;)Z

    move-result v5

    invoke-virtual {v1, v3, v5}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/CharsToNameCanonicalizer;->makeChild(ZZ)Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/CharsToNameCanonicalizer;

    move-result-object v5

    move-object v1, p2

    move-object v3, p1

    invoke-direct/range {v0 .. v5}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;-><init>(Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/IOContext;ILjava/io/Reader;Lcom/openfeint/internal/vendor/org/codehaus/jackson/ObjectCodec;Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/CharsToNameCanonicalizer;)V

    return-object v0
.end method

.method private isEnabled(Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser$Feature;)Z
    .locals 2

    iget v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonFactory;->_parserFeatures:I

    invoke-virtual {p1}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser$Feature;->getMask()I

    move-result v1

    and-int/2addr v0, v1

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method


# virtual methods
.method public final createJsonGenerator(Ljava/io/Writer;)Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonGenerator;
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    const/4 v0, 0x0

    invoke-static {p1, v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonFactory;->_createContext(Ljava/lang/Object;Z)Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/IOContext;

    move-result-object v0

    new-instance v1, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;

    iget v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonFactory;->_generatorFeatures:I

    iget-object v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonFactory;->_objectCodec:Lcom/openfeint/internal/vendor/org/codehaus/jackson/ObjectCodec;

    invoke-direct {v1, v0, v2, v3, p1}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;-><init>(Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/IOContext;ILcom/openfeint/internal/vendor/org/codehaus/jackson/ObjectCodec;Ljava/io/Writer;)V

    return-object v1
.end method

.method public final createJsonParser(Ljava/io/InputStream;)Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser;
    .locals 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParseException;
        }
    .end annotation

    const/4 v0, 0x0

    invoke-static {p1, v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonFactory;->_createContext(Ljava/lang/Object;Z)Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/IOContext;

    move-result-object v0

    new-instance v1, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ByteSourceBootstrapper;

    invoke-direct {v1, v0, p1}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ByteSourceBootstrapper;-><init>(Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/IOContext;Ljava/io/InputStream;)V

    iget v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonFactory;->_parserFeatures:I

    iget-object v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonFactory;->_objectCodec:Lcom/openfeint/internal/vendor/org/codehaus/jackson/ObjectCodec;

    iget-object v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonFactory;->_rootByteSymbols:Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;

    iget-object v4, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonFactory;->_rootCharSymbols:Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/CharsToNameCanonicalizer;

    invoke-virtual {v1, v0, v2, v3, v4}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ByteSourceBootstrapper;->constructParser(ILcom/openfeint/internal/vendor/org/codehaus/jackson/ObjectCodec;Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/CharsToNameCanonicalizer;)Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser;

    move-result-object v0

    return-object v0
.end method

.method public final createJsonParser(Ljava/io/Reader;)Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParseException;
        }
    .end annotation

    const/4 v0, 0x0

    invoke-static {p1, v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonFactory;->_createContext(Ljava/lang/Object;Z)Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/IOContext;

    move-result-object v0

    invoke-direct {p0, p1, v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonFactory;->_createJsonParser(Ljava/io/Reader;Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/IOContext;)Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser;

    move-result-object v0

    return-object v0
.end method

.method public final createJsonParser(Ljava/lang/String;)Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParseException;
        }
    .end annotation

    new-instance v0, Ljava/io/StringReader;

    invoke-direct {v0, p1}, Ljava/io/StringReader;-><init>(Ljava/lang/String;)V

    const/4 v1, 0x1

    invoke-static {v0, v1}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonFactory;->_createContext(Ljava/lang/Object;Z)Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/IOContext;

    move-result-object v1

    invoke-direct {p0, v0, v1}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonFactory;->_createJsonParser(Ljava/io/Reader;Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/IOContext;)Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser;

    move-result-object v0

    return-object v0
.end method

.method public final createJsonParser([B)Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser;
    .locals 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParseException;
        }
    .end annotation

    array-length v0, p1

    const/4 v1, 0x1

    invoke-static {p1, v1}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonFactory;->_createContext(Ljava/lang/Object;Z)Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/IOContext;

    move-result-object v1

    new-instance v2, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ByteSourceBootstrapper;

    invoke-direct {v2, v1, p1, v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ByteSourceBootstrapper;-><init>(Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/IOContext;[BI)V

    iget v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonFactory;->_parserFeatures:I

    iget-object v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonFactory;->_objectCodec:Lcom/openfeint/internal/vendor/org/codehaus/jackson/ObjectCodec;

    iget-object v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonFactory;->_rootByteSymbols:Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;

    iget-object v4, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonFactory;->_rootCharSymbols:Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/CharsToNameCanonicalizer;

    invoke-virtual {v2, v0, v1, v3, v4}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ByteSourceBootstrapper;->constructParser(ILcom/openfeint/internal/vendor/org/codehaus/jackson/ObjectCodec;Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/CharsToNameCanonicalizer;)Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser;

    move-result-object v0

    return-object v0
.end method
