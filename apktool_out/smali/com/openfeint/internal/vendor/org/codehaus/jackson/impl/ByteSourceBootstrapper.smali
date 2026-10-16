.class public final Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ByteSourceBootstrapper;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ByteSourceBootstrapper$1;
    }
.end annotation


# instance fields
.field _bigEndian:Z

.field private final _bufferRecyclable:Z

.field _bytesPerChar:I

.field final _context:Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/IOContext;

.field final _in:Ljava/io/InputStream;

.field final _inputBuffer:[B

.field private _inputEnd:I

.field protected _inputProcessed:I

.field private _inputPtr:I


# direct methods
.method public constructor <init>(Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/IOContext;Ljava/io/InputStream;)V
    .locals 3

    const/4 v2, 0x1

    const/4 v1, 0x0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-boolean v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ByteSourceBootstrapper;->_bigEndian:Z

    iput v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ByteSourceBootstrapper;->_bytesPerChar:I

    iput-object p1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ByteSourceBootstrapper;->_context:Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/IOContext;

    iput-object p2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ByteSourceBootstrapper;->_in:Ljava/io/InputStream;

    invoke-virtual {p1}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/IOContext;->allocReadIOBuffer()[B

    move-result-object v0

    iput-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ByteSourceBootstrapper;->_inputBuffer:[B

    iput v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ByteSourceBootstrapper;->_inputPtr:I

    iput v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ByteSourceBootstrapper;->_inputEnd:I

    iput v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ByteSourceBootstrapper;->_inputProcessed:I

    iput-boolean v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ByteSourceBootstrapper;->_bufferRecyclable:Z

    return-void
.end method

.method public constructor <init>(Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/IOContext;[BI)V
    .locals 2

    const/4 v1, 0x0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ByteSourceBootstrapper;->_bigEndian:Z

    iput v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ByteSourceBootstrapper;->_bytesPerChar:I

    iput-object p1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ByteSourceBootstrapper;->_context:Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/IOContext;

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ByteSourceBootstrapper;->_in:Ljava/io/InputStream;

    iput-object p2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ByteSourceBootstrapper;->_inputBuffer:[B

    iput v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ByteSourceBootstrapper;->_inputPtr:I

    add-int/lit8 v0, p3, 0x0

    iput v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ByteSourceBootstrapper;->_inputEnd:I

    iput v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ByteSourceBootstrapper;->_inputProcessed:I

    iput-boolean v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ByteSourceBootstrapper;->_bufferRecyclable:Z

    return-void
.end method

.method private checkUTF16(I)Z
    .locals 3

    const/4 v1, 0x1

    const/4 v0, 0x0

    const v2, 0xff00

    and-int/2addr v2, p1

    if-nez v2, :cond_1

    iput-boolean v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ByteSourceBootstrapper;->_bigEndian:Z

    :goto_0
    const/4 v0, 0x2

    iput v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ByteSourceBootstrapper;->_bytesPerChar:I

    move v0, v1

    :cond_0
    return v0

    :cond_1
    and-int/lit16 v2, p1, 0xff

    if-nez v2, :cond_0

    iput-boolean v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ByteSourceBootstrapper;->_bigEndian:Z

    goto :goto_0
.end method

.method private ensureLoaded(I)Z
    .locals 6
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    iget v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ByteSourceBootstrapper;->_inputEnd:I

    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ByteSourceBootstrapper;->_inputPtr:I

    sub-int/2addr v0, v1

    move v1, v0

    :goto_0
    if-ge v1, p1, :cond_2

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ByteSourceBootstrapper;->_in:Ljava/io/InputStream;

    if-nez v0, :cond_0

    const/4 v0, -0x1

    :goto_1
    if-gtz v0, :cond_1

    const/4 v0, 0x0

    :goto_2
    return v0

    :cond_0
    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ByteSourceBootstrapper;->_in:Ljava/io/InputStream;

    iget-object v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ByteSourceBootstrapper;->_inputBuffer:[B

    iget v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ByteSourceBootstrapper;->_inputEnd:I

    iget-object v4, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ByteSourceBootstrapper;->_inputBuffer:[B

    array-length v4, v4

    iget v5, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ByteSourceBootstrapper;->_inputEnd:I

    sub-int/2addr v4, v5

    invoke-virtual {v0, v2, v3, v4}, Ljava/io/InputStream;->read([BII)I

    move-result v0

    goto :goto_1

    :cond_1
    iget v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ByteSourceBootstrapper;->_inputEnd:I

    add-int/2addr v2, v0

    iput v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ByteSourceBootstrapper;->_inputEnd:I

    add-int/2addr v0, v1

    move v1, v0

    goto :goto_0

    :cond_2
    const/4 v0, 0x1

    goto :goto_2
.end method

.method private static reportWeirdUCS4(Ljava/lang/String;)V
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    new-instance v0, Ljava/io/CharConversionException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Unsupported UCS-4 endianness ("

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ") detected"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/io/CharConversionException;-><init>(Ljava/lang/String;)V

    throw v0
.end method


# virtual methods
.method public final constructParser(ILcom/openfeint/internal/vendor/org/codehaus/jackson/ObjectCodec;Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/CharsToNameCanonicalizer;)Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser;
    .locals 11
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParseException;
        }
    .end annotation

    const/4 v6, 0x2

    const/4 v5, 0x4

    const/4 v1, 0x0

    const/4 v0, 0x1

    invoke-direct {p0, v5}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ByteSourceBootstrapper;->ensureLoaded(I)Z

    move-result v2

    if-eqz v2, :cond_a

    iget-object v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ByteSourceBootstrapper;->_inputBuffer:[B

    iget v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ByteSourceBootstrapper;->_inputPtr:I

    aget-byte v2, v2, v3

    shl-int/lit8 v2, v2, 0x18

    iget-object v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ByteSourceBootstrapper;->_inputBuffer:[B

    iget v4, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ByteSourceBootstrapper;->_inputPtr:I

    add-int/lit8 v4, v4, 0x1

    aget-byte v3, v3, v4

    and-int/lit16 v3, v3, 0xff

    shl-int/lit8 v3, v3, 0x10

    or-int/2addr v2, v3

    iget-object v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ByteSourceBootstrapper;->_inputBuffer:[B

    iget v4, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ByteSourceBootstrapper;->_inputPtr:I

    add-int/lit8 v4, v4, 0x2

    aget-byte v3, v3, v4

    and-int/lit16 v3, v3, 0xff

    shl-int/lit8 v3, v3, 0x8

    or-int/2addr v2, v3

    iget-object v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ByteSourceBootstrapper;->_inputBuffer:[B

    iget v4, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ByteSourceBootstrapper;->_inputPtr:I

    add-int/lit8 v4, v4, 0x3

    aget-byte v3, v3, v4

    and-int/lit16 v3, v3, 0xff

    or-int/2addr v3, v2

    sparse-switch v3, :sswitch_data_0

    :goto_0
    ushr-int/lit8 v2, v3, 0x10

    const v4, 0xfeff

    if-ne v2, v4, :cond_1

    iget v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ByteSourceBootstrapper;->_inputPtr:I

    add-int/lit8 v2, v2, 0x2

    iput v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ByteSourceBootstrapper;->_inputPtr:I

    iput v6, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ByteSourceBootstrapper;->_bytesPerChar:I

    iput-boolean v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ByteSourceBootstrapper;->_bigEndian:Z

    move v2, v0

    :goto_1
    if-eqz v2, :cond_4

    :cond_0
    :goto_2
    if-nez v0, :cond_b

    sget-object v0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonEncoding;->UTF8:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonEncoding;

    :goto_3
    iget-object v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ByteSourceBootstrapper;->_context:Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/IOContext;

    invoke-virtual {v1, v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/IOContext;->setEncoding(Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonEncoding;)V

    sget-object v1, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser$Feature;->CANONICALIZE_FIELD_NAMES:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser$Feature;

    invoke-virtual {v1, p1}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser$Feature;->enabledIn(I)Z

    move-result v8

    sget-object v1, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser$Feature;->INTERN_FIELD_NAMES:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser$Feature;

    invoke-virtual {v1, p1}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser$Feature;->enabledIn(I)Z

    move-result v9

    sget-object v1, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonEncoding;->UTF8:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonEncoding;

    if-ne v0, v1, :cond_10

    if-eqz v8, :cond_10

    invoke-virtual {p3, v9}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->makeChild$5e0e244d(Z)Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;

    move-result-object v5

    new-instance v0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;

    iget-object v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ByteSourceBootstrapper;->_context:Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/IOContext;

    iget-object v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ByteSourceBootstrapper;->_in:Ljava/io/InputStream;

    iget-object v6, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ByteSourceBootstrapper;->_inputBuffer:[B

    iget v7, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ByteSourceBootstrapper;->_inputPtr:I

    iget v8, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ByteSourceBootstrapper;->_inputEnd:I

    iget-boolean v9, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ByteSourceBootstrapper;->_bufferRecyclable:Z

    move v2, p1

    move-object v4, p2

    invoke-direct/range {v0 .. v9}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;-><init>(Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/IOContext;ILjava/io/InputStream;Lcom/openfeint/internal/vendor/org/codehaus/jackson/ObjectCodec;Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;[BIIZ)V

    :goto_4
    return-object v0

    :sswitch_0
    iput-boolean v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ByteSourceBootstrapper;->_bigEndian:Z

    iget v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ByteSourceBootstrapper;->_inputPtr:I

    add-int/lit8 v2, v2, 0x4

    iput v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ByteSourceBootstrapper;->_inputPtr:I

    iput v5, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ByteSourceBootstrapper;->_bytesPerChar:I

    move v2, v0

    goto :goto_1

    :sswitch_1
    iget v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ByteSourceBootstrapper;->_inputPtr:I

    add-int/lit8 v2, v2, 0x4

    iput v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ByteSourceBootstrapper;->_inputPtr:I

    iput v5, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ByteSourceBootstrapper;->_bytesPerChar:I

    iput-boolean v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ByteSourceBootstrapper;->_bigEndian:Z

    move v2, v0

    goto :goto_1

    :sswitch_2
    const-string v2, "2143"

    invoke-static {v2}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ByteSourceBootstrapper;->reportWeirdUCS4(Ljava/lang/String;)V

    :sswitch_3
    const-string v2, "3412"

    invoke-static {v2}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ByteSourceBootstrapper;->reportWeirdUCS4(Ljava/lang/String;)V

    goto :goto_0

    :cond_1
    const v4, 0xfffe

    if-ne v2, v4, :cond_2

    iget v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ByteSourceBootstrapper;->_inputPtr:I

    add-int/lit8 v2, v2, 0x2

    iput v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ByteSourceBootstrapper;->_inputPtr:I

    iput v6, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ByteSourceBootstrapper;->_bytesPerChar:I

    iput-boolean v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ByteSourceBootstrapper;->_bigEndian:Z

    move v2, v0

    goto :goto_1

    :cond_2
    ushr-int/lit8 v2, v3, 0x8

    const v4, 0xefbbbf

    if-ne v2, v4, :cond_3

    iget v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ByteSourceBootstrapper;->_inputPtr:I

    add-int/lit8 v2, v2, 0x3

    iput v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ByteSourceBootstrapper;->_inputPtr:I

    iput v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ByteSourceBootstrapper;->_bytesPerChar:I

    iput-boolean v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ByteSourceBootstrapper;->_bigEndian:Z

    move v2, v0

    goto :goto_1

    :cond_3
    move v2, v1

    goto :goto_1

    :cond_4
    shr-int/lit8 v2, v3, 0x8

    if-nez v2, :cond_6

    iput-boolean v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ByteSourceBootstrapper;->_bigEndian:Z

    :goto_5
    iput v5, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ByteSourceBootstrapper;->_bytesPerChar:I

    move v2, v0

    :goto_6
    if-nez v2, :cond_0

    ushr-int/lit8 v2, v3, 0x10

    invoke-direct {p0, v2}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ByteSourceBootstrapper;->checkUTF16(I)Z

    move-result v2

    if-nez v2, :cond_0

    :cond_5
    move v0, v1

    goto/16 :goto_2

    :cond_6
    const v2, 0xffffff

    and-int/2addr v2, v3

    if-nez v2, :cond_7

    iput-boolean v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ByteSourceBootstrapper;->_bigEndian:Z

    goto :goto_5

    :cond_7
    const v2, -0xff0001

    and-int/2addr v2, v3

    if-nez v2, :cond_8

    const-string v2, "3412"

    invoke-static {v2}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ByteSourceBootstrapper;->reportWeirdUCS4(Ljava/lang/String;)V

    goto :goto_5

    :cond_8
    const v2, -0xff01

    and-int/2addr v2, v3

    if-nez v2, :cond_9

    const-string v2, "2143"

    invoke-static {v2}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ByteSourceBootstrapper;->reportWeirdUCS4(Ljava/lang/String;)V

    goto :goto_5

    :cond_9
    move v2, v1

    goto :goto_6

    :cond_a
    invoke-direct {p0, v6}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ByteSourceBootstrapper;->ensureLoaded(I)Z

    move-result v2

    if-eqz v2, :cond_5

    iget-object v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ByteSourceBootstrapper;->_inputBuffer:[B

    iget v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ByteSourceBootstrapper;->_inputPtr:I

    aget-byte v2, v2, v3

    and-int/lit16 v2, v2, 0xff

    shl-int/lit8 v2, v2, 0x8

    iget-object v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ByteSourceBootstrapper;->_inputBuffer:[B

    iget v4, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ByteSourceBootstrapper;->_inputPtr:I

    add-int/lit8 v4, v4, 0x1

    aget-byte v3, v3, v4

    and-int/lit16 v3, v3, 0xff

    or-int/2addr v2, v3

    invoke-direct {p0, v2}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ByteSourceBootstrapper;->checkUTF16(I)Z

    move-result v2

    if-eqz v2, :cond_5

    goto/16 :goto_2

    :cond_b
    iget v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ByteSourceBootstrapper;->_bytesPerChar:I

    if-ne v0, v6, :cond_d

    iget-boolean v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ByteSourceBootstrapper;->_bigEndian:Z

    if-eqz v0, :cond_c

    sget-object v0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonEncoding;->UTF16_BE:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonEncoding;

    goto/16 :goto_3

    :cond_c
    sget-object v0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonEncoding;->UTF16_LE:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonEncoding;

    goto/16 :goto_3

    :cond_d
    iget v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ByteSourceBootstrapper;->_bytesPerChar:I

    if-ne v0, v5, :cond_f

    iget-boolean v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ByteSourceBootstrapper;->_bigEndian:Z

    if-eqz v0, :cond_e

    sget-object v0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonEncoding;->UTF32_BE:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonEncoding;

    goto/16 :goto_3

    :cond_e
    sget-object v0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonEncoding;->UTF32_LE:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonEncoding;

    goto/16 :goto_3

    :cond_f
    new-instance v0, Ljava/lang/RuntimeException;

    const-string v1, "Internal error"

    invoke-direct {v0, v1}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    throw v0

    :cond_10
    new-instance v7, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;

    iget-object v10, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ByteSourceBootstrapper;->_context:Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/IOContext;

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ByteSourceBootstrapper;->_context:Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/IOContext;

    invoke-virtual {v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/IOContext;->getEncoding()Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonEncoding;

    move-result-object v6

    sget-object v0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ByteSourceBootstrapper$1;->$SwitchMap$com$openfeint$internal$vendor$org$codehaus$jackson$JsonEncoding:[I

    invoke-virtual {v6}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonEncoding;->ordinal()I

    move-result v1

    aget v0, v0, v1

    packed-switch v0, :pswitch_data_0

    new-instance v0, Ljava/lang/RuntimeException;

    const-string v1, "Internal error"

    invoke-direct {v0, v1}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    throw v0

    :pswitch_0
    new-instance v0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/UTF32Reader;

    iget-object v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ByteSourceBootstrapper;->_context:Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/IOContext;

    iget-object v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ByteSourceBootstrapper;->_in:Ljava/io/InputStream;

    iget-object v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ByteSourceBootstrapper;->_inputBuffer:[B

    iget v4, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ByteSourceBootstrapper;->_inputPtr:I

    iget v5, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ByteSourceBootstrapper;->_inputEnd:I

    iget-object v6, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ByteSourceBootstrapper;->_context:Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/IOContext;

    invoke-virtual {v6}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/IOContext;->getEncoding()Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonEncoding;

    move-result-object v6

    invoke-virtual {v6}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonEncoding;->isBigEndian()Z

    move-result v6

    invoke-direct/range {v0 .. v6}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/UTF32Reader;-><init>(Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/IOContext;Ljava/io/InputStream;[BIIZ)V

    move-object v3, v0

    :goto_7
    invoke-virtual {p4, v8, v9}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/CharsToNameCanonicalizer;->makeChild(ZZ)Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/CharsToNameCanonicalizer;

    move-result-object v5

    move-object v0, v7

    move-object v1, v10

    move v2, p1

    move-object v4, p2

    invoke-direct/range {v0 .. v5}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;-><init>(Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/IOContext;ILjava/io/Reader;Lcom/openfeint/internal/vendor/org/codehaus/jackson/ObjectCodec;Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/CharsToNameCanonicalizer;)V

    move-object v0, v7

    goto/16 :goto_4

    :pswitch_1
    iget-object v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ByteSourceBootstrapper;->_in:Ljava/io/InputStream;

    if-nez v2, :cond_11

    new-instance v0, Ljava/io/ByteArrayInputStream;

    iget-object v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ByteSourceBootstrapper;->_inputBuffer:[B

    iget v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ByteSourceBootstrapper;->_inputPtr:I

    iget v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ByteSourceBootstrapper;->_inputEnd:I

    invoke-direct {v0, v1, v2, v3}, Ljava/io/ByteArrayInputStream;-><init>([BII)V

    :goto_8
    new-instance v3, Ljava/io/InputStreamReader;

    invoke-virtual {v6}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonEncoding;->getJavaName()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v3, v0, v1}, Ljava/io/InputStreamReader;-><init>(Ljava/io/InputStream;Ljava/lang/String;)V

    goto :goto_7

    :cond_11
    iget v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ByteSourceBootstrapper;->_inputPtr:I

    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ByteSourceBootstrapper;->_inputEnd:I

    if-ge v0, v1, :cond_12

    new-instance v0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/MergedStream;

    iget-object v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ByteSourceBootstrapper;->_context:Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/IOContext;

    iget-object v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ByteSourceBootstrapper;->_inputBuffer:[B

    iget v4, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ByteSourceBootstrapper;->_inputPtr:I

    iget v5, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ByteSourceBootstrapper;->_inputEnd:I

    invoke-direct/range {v0 .. v5}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/MergedStream;-><init>(Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/IOContext;Ljava/io/InputStream;[BII)V

    goto :goto_8

    :cond_12
    move-object v0, v2

    goto :goto_8

    :sswitch_data_0
    .sparse-switch
        -0x1010000 -> :sswitch_3
        -0x20000 -> :sswitch_1
        0xfeff -> :sswitch_0
        0xfffe -> :sswitch_2
    .end sparse-switch

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_0
        :pswitch_0
        :pswitch_1
        :pswitch_1
        :pswitch_1
    .end packed-switch
.end method
