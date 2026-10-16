.class public abstract Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParserBase;
.super Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;


# instance fields
.field protected _inputBuffer:[C

.field protected _reader:Ljava/io/Reader;


# direct methods
.method protected constructor <init>(Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/IOContext;ILjava/io/Reader;)V
    .locals 1

    invoke-direct {p0, p1, p2}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;-><init>(Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/IOContext;I)V

    iput-object p3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParserBase;->_reader:Ljava/io/Reader;

    invoke-virtual {p1}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/IOContext;->allocTokenBuffer()[C

    move-result-object v0

    iput-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParserBase;->_inputBuffer:[C

    return-void
.end method


# virtual methods
.method protected final _closeInput()V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParserBase;->_reader:Ljava/io/Reader;

    if-eqz v0, :cond_2

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParserBase;->_ioContext:Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/IOContext;

    invoke-virtual {v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/IOContext;->isResourceManaged()Z

    move-result v0

    if-nez v0, :cond_0

    sget-object v0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser$Feature;->AUTO_CLOSE_SOURCE:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser$Feature;

    invoke-virtual {p0, v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParserBase;->isEnabled(Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser$Feature;)Z

    move-result v0

    if-eqz v0, :cond_1

    :cond_0
    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParserBase;->_reader:Ljava/io/Reader;

    invoke-virtual {v0}, Ljava/io/Reader;->close()V

    :cond_1
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParserBase;->_reader:Ljava/io/Reader;

    :cond_2
    return-void
.end method

.method protected final _releaseBuffers()V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    invoke-super {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->_releaseBuffers()V

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParserBase;->_inputBuffer:[C

    if-eqz v0, :cond_0

    const/4 v1, 0x0

    iput-object v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParserBase;->_inputBuffer:[C

    iget-object v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParserBase;->_ioContext:Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/IOContext;

    invoke-virtual {v1, v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/IOContext;->releaseTokenBuffer([C)V

    :cond_0
    return-void
.end method

.method protected final getNextChar(Ljava/lang/String;)C
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParseException;
        }
    .end annotation

    iget v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParserBase;->_inputPtr:I

    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParserBase;->_inputEnd:I

    if-lt v0, v1, :cond_0

    invoke-virtual {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParserBase;->loadMore()Z

    move-result v0

    if-nez v0, :cond_0

    invoke-virtual {p0, p1}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParserBase;->_reportInvalidEOF(Ljava/lang/String;)V

    :cond_0
    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParserBase;->_inputBuffer:[C

    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParserBase;->_inputPtr:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParserBase;->_inputPtr:I

    aget-char v0, v0, v1

    return v0
.end method

.method protected final loadMore()Z
    .locals 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    const/4 v0, 0x0

    iget-wide v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParserBase;->_currInputProcessed:J

    iget v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParserBase;->_inputEnd:I

    int-to-long v3, v3

    add-long/2addr v1, v3

    iput-wide v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParserBase;->_currInputProcessed:J

    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParserBase;->_currInputRowStart:I

    iget v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParserBase;->_inputEnd:I

    sub-int/2addr v1, v2

    iput v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParserBase;->_currInputRowStart:I

    iget-object v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParserBase;->_reader:Ljava/io/Reader;

    if-eqz v1, :cond_0

    iget-object v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParserBase;->_reader:Ljava/io/Reader;

    iget-object v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParserBase;->_inputBuffer:[C

    iget-object v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParserBase;->_inputBuffer:[C

    array-length v3, v3

    invoke-virtual {v1, v2, v0, v3}, Ljava/io/Reader;->read([CII)I

    move-result v1

    if-lez v1, :cond_1

    iput v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParserBase;->_inputPtr:I

    iput v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParserBase;->_inputEnd:I

    const/4 v0, 0x1

    :cond_0
    return v0

    :cond_1
    invoke-virtual {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParserBase;->_closeInput()V

    if-nez v1, :cond_0

    new-instance v0, Ljava/io/IOException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Reader returned 0 characters when trying to read "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParserBase;->_inputEnd:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v0
.end method
