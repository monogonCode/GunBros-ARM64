.class public final Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;
.super Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonGeneratorBase;


# static fields
.field static final HEX_CHARS:[C


# instance fields
.field protected _entityBuffer:[C

.field protected final _ioContext:Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/IOContext;

.field protected _outputBuffer:[C

.field protected _outputEnd:I

.field protected _outputHead:I

.field protected _outputTail:I

.field protected final _writer:Ljava/io/Writer;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    const-string v0, "0123456789ABCDEF"

    invoke-virtual {v0}, Ljava/lang/String;->toCharArray()[C

    move-result-object v0

    sput-object v0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->HEX_CHARS:[C

    return-void
.end method

.method public constructor <init>(Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/IOContext;ILcom/openfeint/internal/vendor/org/codehaus/jackson/ObjectCodec;Ljava/io/Writer;)V
    .locals 1

    const/4 v0, 0x0

    invoke-direct {p0, p2, p3}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonGeneratorBase;-><init>(ILcom/openfeint/internal/vendor/org/codehaus/jackson/ObjectCodec;)V

    iput v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputHead:I

    iput v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputTail:I

    iput-object p1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_ioContext:Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/IOContext;

    iput-object p4, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_writer:Ljava/io/Writer;

    invoke-virtual {p1}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/IOContext;->allocConcatBuffer()[C

    move-result-object v0

    iput-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputBuffer:[C

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputBuffer:[C

    array-length v0, v0

    iput v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputEnd:I

    return-void
.end method

.method private static _appendSingleEscape(I[CI)V
    .locals 4

    const/16 v1, 0x5c

    const/16 v3, 0x30

    if-gez p0, :cond_0

    add-int/lit8 v0, p0, 0x1

    neg-int v0, v0

    aput-char v1, p1, p2

    add-int/lit8 v1, p2, 0x1

    const/16 v2, 0x75

    aput-char v2, p1, v1

    add-int/lit8 v1, v1, 0x1

    aput-char v3, p1, v1

    add-int/lit8 v1, v1, 0x1

    aput-char v3, p1, v1

    add-int/lit8 v1, v1, 0x1

    sget-object v2, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->HEX_CHARS:[C

    shr-int/lit8 v3, v0, 0x4

    aget-char v2, v2, v3

    aput-char v2, p1, v1

    add-int/lit8 v1, v1, 0x1

    sget-object v2, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->HEX_CHARS:[C

    and-int/lit8 v0, v0, 0xf

    aget-char v0, v2, v0

    aput-char v0, p1, v1

    :goto_0
    return-void

    :cond_0
    aput-char v1, p1, p2

    add-int/lit8 v0, p2, 0x1

    int-to-char v1, p0

    aput-char v1, p1, v0

    goto :goto_0
.end method

.method private _flushBuffer()V
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    iget v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputTail:I

    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputHead:I

    sub-int/2addr v0, v1

    if-lez v0, :cond_0

    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputHead:I

    const/4 v2, 0x0

    iput v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputHead:I

    iput v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputTail:I

    iget-object v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_writer:Ljava/io/Writer;

    iget-object v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputBuffer:[C

    invoke-virtual {v2, v3, v1, v0}, Ljava/io/Writer;->write([CII)V

    :cond_0
    return-void
.end method

.method private final _writeNull()V
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    const/16 v3, 0x6c

    iget v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputTail:I

    add-int/lit8 v0, v0, 0x4

    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputEnd:I

    if-lt v0, v1, :cond_0

    invoke-direct {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_flushBuffer()V

    :cond_0
    iget v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputTail:I

    iget-object v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputBuffer:[C

    const/16 v2, 0x6e

    aput-char v2, v1, v0

    add-int/lit8 v0, v0, 0x1

    const/16 v2, 0x75

    aput-char v2, v1, v0

    add-int/lit8 v0, v0, 0x1

    aput-char v3, v1, v0

    add-int/lit8 v0, v0, 0x1

    aput-char v3, v1, v0

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputTail:I

    return-void
.end method

.method private _writeSingleEscape(I)V
    .locals 7
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    const/16 v4, 0x30

    const/4 v6, 0x6

    const/4 v2, 0x2

    const/4 v3, 0x1

    const/4 v5, 0x0

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_entityBuffer:[C

    if-nez v0, :cond_0

    new-array v0, v6, [C

    const/16 v1, 0x5c

    aput-char v1, v0, v5

    aput-char v4, v0, v2

    const/4 v1, 0x3

    aput-char v4, v0, v1

    :cond_0
    if-gez p1, :cond_1

    add-int/lit8 v1, p1, 0x1

    neg-int v1, v1

    const/16 v2, 0x75

    aput-char v2, v0, v3

    const/4 v2, 0x4

    sget-object v3, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->HEX_CHARS:[C

    shr-int/lit8 v4, v1, 0x4

    aget-char v3, v3, v4

    aput-char v3, v0, v2

    const/4 v2, 0x5

    sget-object v3, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->HEX_CHARS:[C

    and-int/lit8 v1, v1, 0xf

    aget-char v1, v3, v1

    aput-char v1, v0, v2

    iget-object v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_writer:Ljava/io/Writer;

    invoke-virtual {v1, v0, v5, v6}, Ljava/io/Writer;->write([CII)V

    :goto_0
    return-void

    :cond_1
    int-to-char v1, p1

    aput-char v1, v0, v3

    iget-object v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_writer:Ljava/io/Writer;

    invoke-virtual {v1, v0, v5, v2}, Ljava/io/Writer;->write([CII)V

    goto :goto_0
.end method

.method private _writeString(Ljava/lang/String;)V
    .locals 13
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonGenerationException;
        }
    .end annotation

    const/4 v5, 0x6

    const/4 v6, 0x2

    const/4 v1, 0x0

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    iget v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputEnd:I

    if-le v0, v2, :cond_a

    invoke-direct {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_flushBuffer()V

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v7

    move v0, v1

    :cond_0
    iget v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputEnd:I

    add-int v3, v0, v2

    if-le v3, v7, :cond_1

    sub-int v2, v7, v0

    :cond_1
    add-int v3, v0, v2

    iget-object v4, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputBuffer:[C

    invoke-virtual {p1, v0, v3, v4, v1}, Ljava/lang/String;->getChars(II[CI)V

    invoke-static {}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/CharTypes;->getOutputEscapes()[I

    move-result-object v8

    array-length v9, v8

    move v4, v1

    :goto_0
    if-ge v4, v2, :cond_8

    move v3, v4

    :cond_2
    iget-object v10, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputBuffer:[C

    aget-char v10, v10, v3

    if-ge v10, v9, :cond_3

    aget v10, v8, v10

    if-nez v10, :cond_4

    :cond_3
    add-int/lit8 v3, v3, 0x1

    if-lt v3, v2, :cond_2

    :cond_4
    sub-int v10, v3, v4

    if-lez v10, :cond_5

    iget-object v11, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_writer:Ljava/io/Writer;

    iget-object v12, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputBuffer:[C

    invoke-virtual {v11, v12, v4, v10}, Ljava/io/Writer;->write([CII)V

    if-ge v3, v2, :cond_8

    :cond_5
    iget-object v4, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputBuffer:[C

    aget-char v4, v4, v3

    aget v10, v8, v4

    add-int/lit8 v4, v3, 0x1

    if-gez v10, :cond_6

    move v3, v5

    :goto_1
    iget v11, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputTail:I

    if-le v3, v11, :cond_7

    invoke-direct {p0, v10}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_writeSingleEscape(I)V

    goto :goto_0

    :cond_6
    move v3, v6

    goto :goto_1

    :cond_7
    sub-int/2addr v4, v3

    iget-object v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputBuffer:[C

    invoke-static {v10, v3, v4}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_appendSingleEscape(I[CI)V

    goto :goto_0

    :cond_8
    add-int/2addr v0, v2

    if-lt v0, v7, :cond_0

    :cond_9
    return-void

    :cond_a
    iget v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputTail:I

    add-int/2addr v2, v0

    iget v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputEnd:I

    if-le v2, v3, :cond_b

    invoke-direct {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_flushBuffer()V

    :cond_b
    iget-object v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputBuffer:[C

    iget v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputTail:I

    invoke-virtual {p1, v1, v0, v2, v3}, Ljava/lang/String;->getChars(II[CI)V

    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputTail:I

    add-int/2addr v1, v0

    invoke-static {}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/CharTypes;->getOutputEscapes()[I

    move-result-object v2

    array-length v3, v2

    :goto_2
    iget v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputTail:I

    if-ge v0, v1, :cond_9

    :goto_3
    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputBuffer:[C

    iget v4, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputTail:I

    aget-char v0, v0, v4

    if-ge v0, v3, :cond_c

    aget v0, v2, v0

    if-nez v0, :cond_d

    :cond_c
    iget v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputTail:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputTail:I

    if-ge v0, v1, :cond_9

    goto :goto_3

    :cond_d
    iget v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputTail:I

    iget v4, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputHead:I

    sub-int/2addr v0, v4

    if-lez v0, :cond_e

    iget-object v4, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_writer:Ljava/io/Writer;

    iget-object v7, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputBuffer:[C

    iget v8, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputHead:I

    invoke-virtual {v4, v7, v8, v0}, Ljava/io/Writer;->write([CII)V

    :cond_e
    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputBuffer:[C

    iget v4, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputTail:I

    aget-char v0, v0, v4

    aget v4, v2, v0

    iget v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputTail:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputTail:I

    if-gez v4, :cond_f

    move v0, v5

    :goto_4
    iget v7, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputTail:I

    if-le v0, v7, :cond_10

    iget v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputTail:I

    iput v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputHead:I

    invoke-direct {p0, v4}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_writeSingleEscape(I)V

    goto :goto_2

    :cond_f
    move v0, v6

    goto :goto_4

    :cond_10
    iget v7, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputTail:I

    sub-int v0, v7, v0

    iput v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputHead:I

    iget-object v7, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputBuffer:[C

    invoke-static {v4, v7, v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_appendSingleEscape(I[CI)V

    goto :goto_2
.end method

.method private writeRaw(Ljava/lang/String;)V
    .locals 6
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonGenerationException;
        }
    .end annotation

    const/4 v5, 0x0

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v1

    iget v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputEnd:I

    iget v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputTail:I

    sub-int/2addr v0, v2

    if-nez v0, :cond_0

    invoke-direct {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_flushBuffer()V

    iget v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputEnd:I

    iget v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputTail:I

    sub-int/2addr v0, v2

    :cond_0
    if-lt v0, v1, :cond_1

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputBuffer:[C

    iget v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputTail:I

    invoke-virtual {p1, v5, v1, v0, v2}, Ljava/lang/String;->getChars(II[CI)V

    iget v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputTail:I

    add-int/2addr v0, v1

    iput v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputTail:I

    :goto_0
    return-void

    :cond_1
    iget v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputEnd:I

    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputTail:I

    sub-int/2addr v0, v1

    iget-object v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputBuffer:[C

    iget v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputTail:I

    invoke-virtual {p1, v5, v0, v1, v2}, Ljava/lang/String;->getChars(II[CI)V

    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputTail:I

    add-int/2addr v1, v0

    iput v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputTail:I

    invoke-direct {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_flushBuffer()V

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v1

    sub-int/2addr v1, v0

    :goto_1
    iget v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputEnd:I

    if-le v1, v2, :cond_2

    iget v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputEnd:I

    add-int v3, v0, v2

    iget-object v4, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputBuffer:[C

    invoke-virtual {p1, v0, v3, v4, v5}, Ljava/lang/String;->getChars(II[CI)V

    iput v5, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputHead:I

    iput v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputTail:I

    invoke-direct {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_flushBuffer()V

    add-int/2addr v0, v2

    sub-int/2addr v1, v2

    goto :goto_1

    :cond_2
    add-int v2, v0, v1

    iget-object v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputBuffer:[C

    invoke-virtual {p1, v0, v2, v3, v5}, Ljava/lang/String;->getChars(II[CI)V

    iput v5, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputHead:I

    iput v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputTail:I

    goto :goto_0
.end method


# virtual methods
.method protected final _verifyValueWrite(Ljava/lang/String;)V
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonGenerationException;
        }
    .end annotation

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_writeContext:Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonWriteContext;

    invoke-virtual {v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonWriteContext;->writeValue()I

    move-result v0

    const/4 v1, 0x5

    if-ne v0, v1, :cond_0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Can not "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", expecting field name"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_reportError(Ljava/lang/String;)V

    :cond_0
    iget-object v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_cfgPrettyPrinter:Lcom/openfeint/internal/vendor/org/codehaus/jackson/PrettyPrinter;

    if-nez v1, :cond_3

    packed-switch v0, :pswitch_data_0

    :cond_1
    :goto_0
    return-void

    :pswitch_0
    const/16 v0, 0x2c

    :goto_1
    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputTail:I

    iget v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputEnd:I

    if-lt v1, v2, :cond_2

    invoke-direct {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_flushBuffer()V

    :cond_2
    iget-object v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputBuffer:[C

    iget v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputTail:I

    aput-char v0, v1, v2

    iget v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputTail:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputTail:I

    goto :goto_0

    :pswitch_1
    const/16 v0, 0x3a

    goto :goto_1

    :pswitch_2
    const/16 v0, 0x20

    goto :goto_1

    :cond_3
    packed-switch v0, :pswitch_data_1

    new-instance v0, Ljava/lang/RuntimeException;

    const-string v1, "Internal error: should never end up through this code path"

    invoke-direct {v0, v1}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    throw v0

    :pswitch_3
    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_cfgPrettyPrinter:Lcom/openfeint/internal/vendor/org/codehaus/jackson/PrettyPrinter;

    goto :goto_0

    :pswitch_4
    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_cfgPrettyPrinter:Lcom/openfeint/internal/vendor/org/codehaus/jackson/PrettyPrinter;

    goto :goto_0

    :pswitch_5
    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_cfgPrettyPrinter:Lcom/openfeint/internal/vendor/org/codehaus/jackson/PrettyPrinter;

    goto :goto_0

    :pswitch_6
    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_writeContext:Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonWriteContext;

    invoke-virtual {v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonWriteContext;->inArray()Z

    move-result v0

    if-eqz v0, :cond_4

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_cfgPrettyPrinter:Lcom/openfeint/internal/vendor/org/codehaus/jackson/PrettyPrinter;

    goto :goto_0

    :cond_4
    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_writeContext:Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonWriteContext;

    invoke-virtual {v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonWriteContext;->inObject()Z

    move-result v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_cfgPrettyPrinter:Lcom/openfeint/internal/vendor/org/codehaus/jackson/PrettyPrinter;

    goto :goto_0

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_0
        :pswitch_1
        :pswitch_2
    .end packed-switch

    :pswitch_data_1
    .packed-switch 0x0
        :pswitch_6
        :pswitch_3
        :pswitch_4
        :pswitch_5
    .end packed-switch
.end method

.method protected final _writeEndArray()V
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonGenerationException;
        }
    .end annotation

    iget v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputTail:I

    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputEnd:I

    if-lt v0, v1, :cond_0

    invoke-direct {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_flushBuffer()V

    :cond_0
    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputBuffer:[C

    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputTail:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputTail:I

    const/16 v2, 0x5d

    aput-char v2, v0, v1

    return-void
.end method

.method protected final _writeEndObject()V
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonGenerationException;
        }
    .end annotation

    iget v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputTail:I

    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputEnd:I

    if-lt v0, v1, :cond_0

    invoke-direct {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_flushBuffer()V

    :cond_0
    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputBuffer:[C

    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputTail:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputTail:I

    const/16 v2, 0x7d

    aput-char v2, v0, v1

    return-void
.end method

.method protected final _writeFieldName(Ljava/lang/String;Z)V
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonGenerationException;
        }
    .end annotation

    const/16 v3, 0x22

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_cfgPrettyPrinter:Lcom/openfeint/internal/vendor/org/codehaus/jackson/PrettyPrinter;

    if-eqz v0, :cond_4

    if-eqz p2, :cond_2

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_cfgPrettyPrinter:Lcom/openfeint/internal/vendor/org/codehaus/jackson/PrettyPrinter;

    :goto_0
    sget-object v0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonGenerator$Feature;->QUOTE_FIELD_NAMES:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonGenerator$Feature;

    invoke-virtual {p0, v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->isEnabled(Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonGenerator$Feature;)Z

    move-result v0

    if-eqz v0, :cond_3

    iget v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputTail:I

    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputEnd:I

    if-lt v0, v1, :cond_0

    invoke-direct {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_flushBuffer()V

    :cond_0
    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputBuffer:[C

    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputTail:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputTail:I

    aput-char v3, v0, v1

    invoke-direct {p0, p1}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_writeString(Ljava/lang/String;)V

    iget v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputTail:I

    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputEnd:I

    if-lt v0, v1, :cond_1

    invoke-direct {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_flushBuffer()V

    :cond_1
    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputBuffer:[C

    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputTail:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputTail:I

    aput-char v3, v0, v1

    :goto_1
    return-void

    :cond_2
    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_cfgPrettyPrinter:Lcom/openfeint/internal/vendor/org/codehaus/jackson/PrettyPrinter;

    goto :goto_0

    :cond_3
    invoke-direct {p0, p1}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_writeString(Ljava/lang/String;)V

    goto :goto_1

    :cond_4
    iget v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputTail:I

    add-int/lit8 v0, v0, 0x1

    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputEnd:I

    if-lt v0, v1, :cond_5

    invoke-direct {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_flushBuffer()V

    :cond_5
    if-eqz p2, :cond_6

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputBuffer:[C

    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputTail:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputTail:I

    const/16 v2, 0x2c

    aput-char v2, v0, v1

    :cond_6
    sget-object v0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonGenerator$Feature;->QUOTE_FIELD_NAMES:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonGenerator$Feature;

    invoke-virtual {p0, v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->isEnabled(Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonGenerator$Feature;)Z

    move-result v0

    if-nez v0, :cond_7

    invoke-direct {p0, p1}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_writeString(Ljava/lang/String;)V

    goto :goto_1

    :cond_7
    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputBuffer:[C

    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputTail:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputTail:I

    aput-char v3, v0, v1

    invoke-direct {p0, p1}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_writeString(Ljava/lang/String;)V

    iget v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputTail:I

    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputEnd:I

    if-lt v0, v1, :cond_8

    invoke-direct {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_flushBuffer()V

    :cond_8
    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputBuffer:[C

    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputTail:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputTail:I

    aput-char v3, v0, v1

    goto :goto_1
.end method

.method protected final _writeStartArray()V
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonGenerationException;
        }
    .end annotation

    iget v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputTail:I

    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputEnd:I

    if-lt v0, v1, :cond_0

    invoke-direct {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_flushBuffer()V

    :cond_0
    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputBuffer:[C

    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputTail:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputTail:I

    const/16 v2, 0x5b

    aput-char v2, v0, v1

    return-void
.end method

.method protected final _writeStartObject()V
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonGenerationException;
        }
    .end annotation

    iget v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputTail:I

    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputEnd:I

    if-lt v0, v1, :cond_0

    invoke-direct {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_flushBuffer()V

    :cond_0
    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputBuffer:[C

    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputTail:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputTail:I

    const/16 v2, 0x7b

    aput-char v2, v0, v1

    return-void
.end method

.method public final close()V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    invoke-super {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonGeneratorBase;->close()V

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputBuffer:[C

    if-eqz v0, :cond_1

    sget-object v0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonGenerator$Feature;->AUTO_CLOSE_JSON_CONTENT:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonGenerator$Feature;

    invoke-virtual {p0, v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->isEnabled(Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonGenerator$Feature;)Z

    move-result v0

    if-eqz v0, :cond_1

    :goto_0
    invoke-virtual {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->getOutputContext()Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonWriteContext;

    move-result-object v0

    invoke-virtual {v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonStreamContext;->inArray()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-virtual {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->writeEndArray()V

    goto :goto_0

    :cond_0
    invoke-virtual {v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonStreamContext;->inObject()Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-virtual {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->writeEndObject()V

    goto :goto_0

    :cond_1
    invoke-direct {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_flushBuffer()V

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_ioContext:Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/IOContext;

    invoke-virtual {v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/IOContext;->isResourceManaged()Z

    move-result v0

    if-nez v0, :cond_2

    sget-object v0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonGenerator$Feature;->AUTO_CLOSE_TARGET:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonGenerator$Feature;

    invoke-virtual {p0, v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->isEnabled(Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonGenerator$Feature;)Z

    move-result v0

    if-eqz v0, :cond_4

    :cond_2
    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_writer:Ljava/io/Writer;

    invoke-virtual {v0}, Ljava/io/Writer;->close()V

    :goto_1
    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputBuffer:[C

    if-eqz v0, :cond_3

    const/4 v1, 0x0

    iput-object v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputBuffer:[C

    iget-object v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_ioContext:Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/IOContext;

    invoke-virtual {v1, v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/IOContext;->releaseConcatBuffer([C)V

    :cond_3
    return-void

    :cond_4
    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_writer:Ljava/io/Writer;

    invoke-virtual {v0}, Ljava/io/Writer;->flush()V

    goto :goto_1
.end method

.method public final writeBoolean(Z)V
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonGenerationException;
        }
    .end annotation

    const/16 v3, 0x65

    const-string v0, "write boolean value"

    invoke-virtual {p0, v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_verifyValueWrite(Ljava/lang/String;)V

    iget v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputTail:I

    add-int/lit8 v0, v0, 0x5

    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputEnd:I

    if-lt v0, v1, :cond_0

    invoke-direct {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_flushBuffer()V

    :cond_0
    iget v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputTail:I

    iget-object v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputBuffer:[C

    if-eqz p1, :cond_1

    const/16 v2, 0x74

    aput-char v2, v1, v0

    add-int/lit8 v0, v0, 0x1

    const/16 v2, 0x72

    aput-char v2, v1, v0

    add-int/lit8 v0, v0, 0x1

    const/16 v2, 0x75

    aput-char v2, v1, v0

    add-int/lit8 v0, v0, 0x1

    aput-char v3, v1, v0

    :goto_0
    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputTail:I

    return-void

    :cond_1
    const/16 v2, 0x66

    aput-char v2, v1, v0

    add-int/lit8 v0, v0, 0x1

    const/16 v2, 0x61

    aput-char v2, v1, v0

    add-int/lit8 v0, v0, 0x1

    const/16 v2, 0x6c

    aput-char v2, v1, v0

    add-int/lit8 v0, v0, 0x1

    const/16 v2, 0x73

    aput-char v2, v1, v0

    add-int/lit8 v0, v0, 0x1

    aput-char v3, v1, v0

    goto :goto_0
.end method

.method public final writeNull()V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonGenerationException;
        }
    .end annotation

    const-string v0, "write null value"

    invoke-virtual {p0, v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_verifyValueWrite(Ljava/lang/String;)V

    invoke-direct {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_writeNull()V

    return-void
.end method

.method public final writeNumber(D)V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonGenerationException;
        }
    .end annotation

    iget-boolean v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_cfgNumbersAsStrings:Z

    if-nez v0, :cond_1

    invoke-static {p1, p2}, Ljava/lang/Double;->isNaN(D)Z

    move-result v0

    if-nez v0, :cond_0

    invoke-static {p1, p2}, Ljava/lang/Double;->isInfinite(D)Z

    move-result v0

    if-eqz v0, :cond_2

    :cond_0
    sget-object v0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonGenerator$Feature;->QUOTE_NON_NUMERIC_NUMBERS:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonGenerator$Feature;

    invoke-virtual {p0, v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->isEnabled(Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonGenerator$Feature;)Z

    move-result v0

    if-eqz v0, :cond_2

    :cond_1
    invoke-static {p1, p2}, Ljava/lang/String;->valueOf(D)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->writeString(Ljava/lang/String;)V

    :goto_0
    return-void

    :cond_2
    const-string v0, "write number"

    invoke-virtual {p0, v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_verifyValueWrite(Ljava/lang/String;)V

    invoke-static {p1, p2}, Ljava/lang/String;->valueOf(D)Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->writeRaw(Ljava/lang/String;)V

    goto :goto_0
.end method

.method public final writeNumber(F)V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonGenerationException;
        }
    .end annotation

    iget-boolean v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_cfgNumbersAsStrings:Z

    if-nez v0, :cond_1

    invoke-static {p1}, Ljava/lang/Float;->isNaN(F)Z

    move-result v0

    if-nez v0, :cond_0

    invoke-static {p1}, Ljava/lang/Float;->isInfinite(F)Z

    move-result v0

    if-eqz v0, :cond_2

    :cond_0
    sget-object v0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonGenerator$Feature;->QUOTE_NON_NUMERIC_NUMBERS:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonGenerator$Feature;

    invoke-virtual {p0, v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->isEnabled(Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonGenerator$Feature;)Z

    move-result v0

    if-eqz v0, :cond_2

    :cond_1
    invoke-static {p1}, Ljava/lang/String;->valueOf(F)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->writeString(Ljava/lang/String;)V

    :goto_0
    return-void

    :cond_2
    const-string v0, "write number"

    invoke-virtual {p0, v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_verifyValueWrite(Ljava/lang/String;)V

    invoke-static {p1}, Ljava/lang/String;->valueOf(F)Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->writeRaw(Ljava/lang/String;)V

    goto :goto_0
.end method

.method public final writeNumber(I)V
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonGenerationException;
        }
    .end annotation

    const/16 v3, 0x22

    const-string v0, "write number"

    invoke-virtual {p0, v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_verifyValueWrite(Ljava/lang/String;)V

    iget v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputTail:I

    add-int/lit8 v0, v0, 0xb

    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputEnd:I

    if-lt v0, v1, :cond_0

    invoke-direct {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_flushBuffer()V

    :cond_0
    iget-boolean v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_cfgNumbersAsStrings:Z

    if-eqz v0, :cond_2

    iget v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputTail:I

    add-int/lit8 v0, v0, 0xd

    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputEnd:I

    if-lt v0, v1, :cond_1

    invoke-direct {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_flushBuffer()V

    :cond_1
    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputBuffer:[C

    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputTail:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputTail:I

    aput-char v3, v0, v1

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputBuffer:[C

    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputTail:I

    invoke-static {p1, v0, v1}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/NumberOutput;->outputInt(I[CI)I

    move-result v0

    iput v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputTail:I

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputBuffer:[C

    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputTail:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputTail:I

    aput-char v3, v0, v1

    :goto_0
    return-void

    :cond_2
    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputBuffer:[C

    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputTail:I

    invoke-static {p1, v0, v1}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/NumberOutput;->outputInt(I[CI)I

    move-result v0

    iput v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputTail:I

    goto :goto_0
.end method

.method public final writeNumber(J)V
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonGenerationException;
        }
    .end annotation

    const/16 v3, 0x22

    const-string v0, "write number"

    invoke-virtual {p0, v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_verifyValueWrite(Ljava/lang/String;)V

    iget-boolean v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_cfgNumbersAsStrings:Z

    if-eqz v0, :cond_1

    iget v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputTail:I

    add-int/lit8 v0, v0, 0x17

    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputEnd:I

    if-lt v0, v1, :cond_0

    invoke-direct {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_flushBuffer()V

    :cond_0
    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputBuffer:[C

    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputTail:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputTail:I

    aput-char v3, v0, v1

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputBuffer:[C

    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputTail:I

    invoke-static {p1, p2, v0, v1}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/NumberOutput;->outputLong(J[CI)I

    move-result v0

    iput v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputTail:I

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputBuffer:[C

    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputTail:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputTail:I

    aput-char v3, v0, v1

    :goto_0
    return-void

    :cond_1
    iget v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputTail:I

    add-int/lit8 v0, v0, 0x15

    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputEnd:I

    if-lt v0, v1, :cond_2

    invoke-direct {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_flushBuffer()V

    :cond_2
    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputBuffer:[C

    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputTail:I

    invoke-static {p1, p2, v0, v1}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/NumberOutput;->outputLong(J[CI)I

    move-result v0

    iput v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputTail:I

    goto :goto_0
.end method

.method public final writeString(Ljava/lang/String;)V
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonGenerationException;
        }
    .end annotation

    const/16 v3, 0x22

    const-string v0, "write text value"

    invoke-virtual {p0, v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_verifyValueWrite(Ljava/lang/String;)V

    if-nez p1, :cond_0

    invoke-direct {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_writeNull()V

    :goto_0
    return-void

    :cond_0
    iget v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputTail:I

    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputEnd:I

    if-lt v0, v1, :cond_1

    invoke-direct {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_flushBuffer()V

    :cond_1
    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputBuffer:[C

    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputTail:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputTail:I

    aput-char v3, v0, v1

    invoke-direct {p0, p1}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_writeString(Ljava/lang/String;)V

    iget v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputTail:I

    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputEnd:I

    if-lt v0, v1, :cond_2

    invoke-direct {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_flushBuffer()V

    :cond_2
    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputBuffer:[C

    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputTail:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/WriterBasedGenerator;->_outputTail:I

    aput-char v3, v0, v1

    goto :goto_0
.end method
