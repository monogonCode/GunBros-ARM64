.class public abstract Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8NumericParser;
.super Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/StreamBasedParserBase;


# direct methods
.method public constructor <init>(Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/IOContext;ILjava/io/InputStream;[BIIZ)V
    .locals 0

    invoke-direct/range {p0 .. p7}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/StreamBasedParserBase;-><init>(Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/IOContext;ILjava/io/InputStream;[BIIZ)V

    return-void
.end method


# virtual methods
.method protected final parseNumberText(I)Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;
    .locals 14
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParseException;
        }
    .end annotation

    const/16 v13, 0x39

    const/16 v11, 0x2d

    const/16 v12, 0x30

    const/4 v1, 0x1

    const/4 v2, 0x0

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8NumericParser;->_textBuffer:Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/TextBuffer;

    invoke-virtual {v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/TextBuffer;->emptyAndGetCurrentSegment()[C

    move-result-object v3

    if-ne p1, v11, :cond_d

    move v10, v1

    :goto_0
    if-eqz v10, :cond_19

    aput-char v11, v3, v2

    iget v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8NumericParser;->_inputPtr:I

    iget v4, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8NumericParser;->_inputEnd:I

    if-lt v0, v4, :cond_0

    invoke-virtual {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8NumericParser;->loadMoreGuaranteed()V

    :cond_0
    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8NumericParser;->_inputBuffer:[B

    iget v4, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8NumericParser;->_inputPtr:I

    add-int/lit8 v5, v4, 0x1

    iput v5, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8NumericParser;->_inputPtr:I

    aget-byte v0, v0, v4

    and-int/lit16 p1, v0, 0xff

    move v0, v1

    :goto_1
    move v4, v2

    move v6, p1

    :goto_2
    if-lt v6, v12, :cond_18

    if-gt v6, v13, :cond_18

    add-int/lit8 v4, v4, 0x1

    const/4 v5, 0x2

    if-ne v4, v5, :cond_1

    add-int/lit8 v5, v0, -0x1

    aget-char v5, v3, v5

    if-ne v5, v12, :cond_1

    const-string v5, "Leading zeroes not allowed"

    invoke-virtual {p0, v5}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8NumericParser;->reportInvalidNumber(Ljava/lang/String;)V

    :cond_1
    array-length v5, v3

    if-lt v0, v5, :cond_2

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8NumericParser;->_textBuffer:Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/TextBuffer;

    invoke-virtual {v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/TextBuffer;->finishCurrentSegment()[C

    move-result-object v0

    move-object v3, v0

    move v0, v2

    :cond_2
    add-int/lit8 v5, v0, 0x1

    int-to-char v6, v6

    aput-char v6, v3, v0

    iget v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8NumericParser;->_inputPtr:I

    iget v6, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8NumericParser;->_inputEnd:I

    if-lt v0, v6, :cond_e

    invoke-virtual {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8NumericParser;->loadMore()Z

    move-result v0

    if-nez v0, :cond_e

    move v7, v1

    move v9, v4

    move v4, v2

    :goto_3
    if-nez v9, :cond_3

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "Missing integer part (next char "

    invoke-virtual {v0, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-static {v4}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8NumericParser;->_getCharDesc(I)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v0, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v6, ")"

    invoke-virtual {v0, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8NumericParser;->reportInvalidNumber(Ljava/lang/String;)V

    :cond_3
    const/16 v0, 0x2e

    if-ne v4, v0, :cond_17

    add-int/lit8 v0, v5, 0x1

    int-to-char v6, v4

    aput-char v6, v3, v5

    move v5, v4

    move-object v4, v3

    move v3, v0

    move v0, v2

    :goto_4
    iget v6, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8NumericParser;->_inputPtr:I

    iget v8, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8NumericParser;->_inputEnd:I

    if-lt v6, v8, :cond_f

    invoke-virtual {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8NumericParser;->loadMore()Z

    move-result v6

    if-nez v6, :cond_f

    move v6, v5

    move v5, v1

    :goto_5
    if-nez v0, :cond_4

    const-string v7, "Decimal point not followed by a digit"

    invoke-virtual {p0, v6, v7}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8NumericParser;->reportUnexpectedNumberChar(ILjava/lang/String;)V

    :cond_4
    move v8, v0

    move v0, v3

    move-object v3, v4

    :goto_6
    const/16 v4, 0x65

    if-eq v6, v4, :cond_5

    const/16 v4, 0x45

    if-ne v6, v4, :cond_14

    :cond_5
    array-length v4, v3

    if-lt v0, v4, :cond_6

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8NumericParser;->_textBuffer:Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/TextBuffer;

    invoke-virtual {v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/TextBuffer;->finishCurrentSegment()[C

    move-result-object v0

    move-object v3, v0

    move v0, v2

    :cond_6
    add-int/lit8 v4, v0, 0x1

    int-to-char v6, v6

    aput-char v6, v3, v0

    iget v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8NumericParser;->_inputPtr:I

    iget v6, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8NumericParser;->_inputEnd:I

    if-lt v0, v6, :cond_7

    invoke-virtual {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8NumericParser;->loadMoreGuaranteed()V

    :cond_7
    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8NumericParser;->_inputBuffer:[B

    iget v6, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8NumericParser;->_inputPtr:I

    add-int/lit8 v7, v6, 0x1

    iput v7, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8NumericParser;->_inputPtr:I

    aget-byte v0, v0, v6

    and-int/lit16 v6, v0, 0xff

    if-eq v6, v11, :cond_8

    const/16 v0, 0x2b

    if-ne v6, v0, :cond_13

    :cond_8
    array-length v0, v3

    if-lt v4, v0, :cond_12

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8NumericParser;->_textBuffer:Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/TextBuffer;

    invoke-virtual {v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/TextBuffer;->finishCurrentSegment()[C

    move-result-object v3

    move v0, v2

    :goto_7
    add-int/lit8 v4, v0, 0x1

    int-to-char v6, v6

    aput-char v6, v3, v0

    iget v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8NumericParser;->_inputPtr:I

    iget v6, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8NumericParser;->_inputEnd:I

    if-lt v0, v6, :cond_9

    invoke-virtual {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8NumericParser;->loadMoreGuaranteed()V

    :cond_9
    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8NumericParser;->_inputBuffer:[B

    iget v6, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8NumericParser;->_inputPtr:I

    add-int/lit8 v7, v6, 0x1

    iput v7, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8NumericParser;->_inputPtr:I

    aget-byte v0, v0, v6

    and-int/lit16 v0, v0, 0xff

    move v7, v0

    move v0, v4

    move v4, v2

    :goto_8
    if-gt v7, v13, :cond_11

    if-lt v7, v12, :cond_11

    add-int/lit8 v4, v4, 0x1

    array-length v6, v3

    if-lt v0, v6, :cond_a

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8NumericParser;->_textBuffer:Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/TextBuffer;

    invoke-virtual {v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/TextBuffer;->finishCurrentSegment()[C

    move-result-object v0

    move-object v3, v0

    move v0, v2

    :cond_a
    add-int/lit8 v6, v0, 0x1

    int-to-char v11, v7

    aput-char v11, v3, v0

    iget v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8NumericParser;->_inputPtr:I

    iget v11, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8NumericParser;->_inputEnd:I

    if-lt v0, v11, :cond_10

    invoke-virtual {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8NumericParser;->loadMore()Z

    move-result v0

    if-nez v0, :cond_10

    move v2, v4

    move v0, v1

    move v1, v6

    :goto_9
    if-nez v2, :cond_b

    const-string v3, "Exponent indicator not followed by a digit"

    invoke-virtual {p0, v7, v3}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8NumericParser;->reportUnexpectedNumberChar(ILjava/lang/String;)V

    :cond_b
    :goto_a
    if-nez v0, :cond_c

    iget v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8NumericParser;->_inputPtr:I

    add-int/lit8 v0, v0, -0x1

    iput v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8NumericParser;->_inputPtr:I

    :cond_c
    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8NumericParser;->_textBuffer:Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/TextBuffer;

    invoke-virtual {v0, v1}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/TextBuffer;->setCurrentLength(I)V

    invoke-virtual {p0, v10, v9, v8, v2}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8NumericParser;->reset(ZIII)Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;

    move-result-object v0

    return-object v0

    :cond_d
    move v10, v2

    goto/16 :goto_0

    :cond_e
    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8NumericParser;->_inputBuffer:[B

    iget v6, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8NumericParser;->_inputPtr:I

    add-int/lit8 v7, v6, 0x1

    iput v7, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8NumericParser;->_inputPtr:I

    aget-byte v0, v0, v6

    and-int/lit16 v6, v0, 0xff

    move v0, v5

    goto/16 :goto_2

    :cond_f
    iget-object v5, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8NumericParser;->_inputBuffer:[B

    iget v6, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8NumericParser;->_inputPtr:I

    add-int/lit8 v8, v6, 0x1

    iput v8, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8NumericParser;->_inputPtr:I

    aget-byte v5, v5, v6

    and-int/lit16 v5, v5, 0xff

    if-lt v5, v12, :cond_16

    if-gt v5, v13, :cond_16

    add-int/lit8 v0, v0, 0x1

    array-length v6, v4

    if-lt v3, v6, :cond_15

    iget-object v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8NumericParser;->_textBuffer:Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/TextBuffer;

    invoke-virtual {v3}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/TextBuffer;->finishCurrentSegment()[C

    move-result-object v4

    move v6, v2

    :goto_b
    add-int/lit8 v3, v6, 0x1

    int-to-char v8, v5

    aput-char v8, v4, v6

    goto/16 :goto_4

    :cond_10
    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8NumericParser;->_inputBuffer:[B

    iget v7, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8NumericParser;->_inputPtr:I

    add-int/lit8 v11, v7, 0x1

    iput v11, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8NumericParser;->_inputPtr:I

    aget-byte v0, v0, v7

    and-int/lit16 v0, v0, 0xff

    move v7, v0

    move v0, v6

    goto/16 :goto_8

    :cond_11
    move v2, v4

    move v1, v0

    move v0, v5

    goto :goto_9

    :cond_12
    move v0, v4

    goto/16 :goto_7

    :cond_13
    move v0, v4

    move v7, v6

    move v4, v2

    goto/16 :goto_8

    :cond_14
    move v1, v0

    move v0, v5

    goto :goto_a

    :cond_15
    move v6, v3

    goto :goto_b

    :cond_16
    move v6, v5

    move v5, v7

    goto/16 :goto_5

    :cond_17
    move v8, v2

    move v0, v5

    move v6, v4

    move v5, v7

    goto/16 :goto_6

    :cond_18
    move v7, v2

    move v9, v4

    move v5, v0

    move v4, v6

    goto/16 :goto_3

    :cond_19
    move v0, v2

    goto/16 :goto_1
.end method
