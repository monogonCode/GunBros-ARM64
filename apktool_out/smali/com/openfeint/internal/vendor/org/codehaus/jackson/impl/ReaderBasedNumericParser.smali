.class public abstract Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedNumericParser;
.super Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParserBase;


# direct methods
.method public constructor <init>(Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/IOContext;ILjava/io/Reader;)V
    .locals 0

    invoke-direct {p0, p1, p2, p3}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParserBase;-><init>(Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/IOContext;ILjava/io/Reader;)V

    return-void
.end method


# virtual methods
.method protected final parseNumberText(I)Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;
    .locals 11
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParseException;
        }
    .end annotation

    const/16 v0, 0x2d

    if-ne p1, v0, :cond_2

    const/4 v0, 0x1

    :goto_0
    iget v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedNumericParser;->_inputPtr:I

    add-int/lit8 v4, v2, -0x1

    iget v7, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedNumericParser;->_inputEnd:I

    if-eqz v0, :cond_26

    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedNumericParser;->_inputEnd:I

    if-ge v2, v1, :cond_a

    iget-object v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedNumericParser;->_inputBuffer:[C

    add-int/lit8 v1, v2, 0x1

    aget-char v2, v3, v2

    const/16 v3, 0x39

    if-gt v2, v3, :cond_0

    const/16 v3, 0x30

    if-ge v2, v3, :cond_1

    :cond_0
    const-string v3, "expected digit (0-9) to follow minus sign, for valid numeric value"

    invoke-virtual {p0, v2, v3}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedNumericParser;->reportUnexpectedNumberChar(ILjava/lang/String;)V

    :cond_1
    :goto_1
    const/4 v2, 0x1

    move v10, v2

    move v2, v1

    move v1, v10

    :goto_2
    iget v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedNumericParser;->_inputEnd:I

    if-ge v2, v3, :cond_a

    iget-object v5, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedNumericParser;->_inputBuffer:[C

    add-int/lit8 v3, v2, 0x1

    aget-char v5, v5, v2

    const/16 v2, 0x30

    if-lt v5, v2, :cond_3

    const/16 v2, 0x39

    if-gt v5, v2, :cond_3

    add-int/lit8 v1, v1, 0x1

    const/4 v2, 0x2

    if-ne v1, v2, :cond_25

    iget-object v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedNumericParser;->_inputBuffer:[C

    add-int/lit8 v5, v3, -0x2

    aget-char v2, v2, v5

    const/16 v5, 0x30

    if-ne v2, v5, :cond_25

    const-string v2, "Leading zeroes not allowed"

    invoke-virtual {p0, v2}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedNumericParser;->reportInvalidNumber(Ljava/lang/String;)V

    move v2, v3

    goto :goto_2

    :cond_2
    const/4 v0, 0x0

    goto :goto_0

    :cond_3
    const/4 v2, 0x0

    const/16 v6, 0x2e

    if-ne v5, v6, :cond_5

    move v5, v3

    :goto_3
    if-ge v5, v7, :cond_a

    iget-object v6, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedNumericParser;->_inputBuffer:[C

    add-int/lit8 v3, v5, 0x1

    aget-char v5, v6, v5

    const/16 v6, 0x30

    if-lt v5, v6, :cond_4

    const/16 v6, 0x39

    if-gt v5, v6, :cond_4

    add-int/lit8 v2, v2, 0x1

    move v5, v3

    goto :goto_3

    :cond_4
    if-nez v2, :cond_5

    const-string v6, "Decimal point not followed by a digit"

    invoke-virtual {p0, v5, v6}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedNumericParser;->reportUnexpectedNumberChar(ILjava/lang/String;)V

    :cond_5
    move v6, v2

    const/4 v2, 0x0

    const/16 v8, 0x65

    if-eq v5, v8, :cond_6

    const/16 v8, 0x45

    if-ne v5, v8, :cond_9

    :cond_6
    if-ge v3, v7, :cond_a

    iget-object v8, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedNumericParser;->_inputBuffer:[C

    add-int/lit8 v5, v3, 0x1

    aget-char v3, v8, v3

    const/16 v8, 0x2d

    if-eq v3, v8, :cond_7

    const/16 v8, 0x2b

    if-ne v3, v8, :cond_24

    :cond_7
    if-ge v5, v7, :cond_a

    iget-object v8, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedNumericParser;->_inputBuffer:[C

    add-int/lit8 v3, v5, 0x1

    aget-char v5, v8, v5

    :goto_4
    const/16 v8, 0x39

    if-gt v5, v8, :cond_8

    const/16 v8, 0x30

    if-lt v5, v8, :cond_8

    add-int/lit8 v2, v2, 0x1

    if-ge v3, v7, :cond_a

    iget-object v8, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedNumericParser;->_inputBuffer:[C

    add-int/lit8 v5, v3, 0x1

    aget-char v3, v8, v3

    move v10, v5

    move v5, v3

    move v3, v10

    goto :goto_4

    :cond_8
    if-nez v2, :cond_9

    const-string v7, "Exponent indicator not followed by a digit"

    invoke-virtual {p0, v5, v7}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedNumericParser;->reportUnexpectedNumberChar(ILjava/lang/String;)V

    :cond_9
    add-int/lit8 v3, v3, -0x1

    iput v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedNumericParser;->_inputPtr:I

    sub-int/2addr v3, v4

    iget-object v5, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedNumericParser;->_textBuffer:Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/TextBuffer;

    iget-object v7, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedNumericParser;->_inputBuffer:[C

    invoke-virtual {v5, v7, v4, v3}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/TextBuffer;->resetWithShared([CII)V

    invoke-virtual {p0, v0, v1, v6, v2}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedNumericParser;->reset(ZIII)Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;

    move-result-object v0

    :goto_5
    return-object v0

    :cond_a
    if-eqz v0, :cond_15

    add-int/lit8 v1, v4, 0x1

    :goto_6
    iput v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedNumericParser;->_inputPtr:I

    iget-object v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedNumericParser;->_textBuffer:Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/TextBuffer;

    invoke-virtual {v1}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/TextBuffer;->emptyAndGetCurrentSegment()[C

    move-result-object v3

    const/4 v1, 0x0

    if-eqz v0, :cond_b

    const/4 v2, 0x0

    const/4 v1, 0x1

    const/16 v4, 0x2d

    aput-char v4, v3, v2

    :cond_b
    const/4 v2, 0x0

    const/4 v7, 0x0

    move v10, v2

    move v2, v1

    move v1, v10

    :goto_7
    iget v4, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedNumericParser;->_inputPtr:I

    iget v5, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedNumericParser;->_inputEnd:I

    if-lt v4, v5, :cond_16

    invoke-virtual {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedNumericParser;->loadMore()Z

    move-result v4

    if-nez v4, :cond_16

    const/4 v5, 0x0

    const/4 v7, 0x1

    :cond_c
    if-nez v1, :cond_d

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "Missing integer part (next char "

    invoke-virtual {v4, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-static {v5}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedNumericParser;->_getCharDesc(I)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v4, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v6, ")"

    invoke-virtual {v4, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {p0, v4}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedNumericParser;->reportInvalidNumber(Ljava/lang/String;)V

    :cond_d
    const/4 v4, 0x0

    const/16 v6, 0x2e

    if-ne v5, v6, :cond_22

    add-int/lit8 v6, v2, 0x1

    aput-char v5, v3, v2

    move v2, v4

    move v4, v6

    move v10, v5

    move-object v5, v3

    move v3, v10

    :goto_8
    iget v6, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedNumericParser;->_inputPtr:I

    iget v8, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedNumericParser;->_inputEnd:I

    if-lt v6, v8, :cond_18

    invoke-virtual {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedNumericParser;->loadMore()Z

    move-result v6

    if-nez v6, :cond_18

    const/4 v7, 0x1

    move v6, v7

    :goto_9
    if-nez v2, :cond_e

    const-string v7, "Decimal point not followed by a digit"

    invoke-virtual {p0, v3, v7}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedNumericParser;->reportUnexpectedNumberChar(ILjava/lang/String;)V

    :cond_e
    move v8, v2

    move v7, v3

    move v2, v4

    move-object v3, v5

    :goto_a
    const/4 v5, 0x0

    const/16 v4, 0x65

    if-eq v7, v4, :cond_f

    const/16 v4, 0x45

    if-ne v7, v4, :cond_1f

    :cond_f
    array-length v4, v3

    if-lt v2, v4, :cond_10

    iget-object v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedNumericParser;->_textBuffer:Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/TextBuffer;

    invoke-virtual {v2}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/TextBuffer;->finishCurrentSegment()[C

    move-result-object v3

    const/4 v2, 0x0

    :cond_10
    add-int/lit8 v4, v2, 0x1

    aput-char v7, v3, v2

    iget v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedNumericParser;->_inputPtr:I

    iget v7, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedNumericParser;->_inputEnd:I

    if-ge v2, v7, :cond_19

    iget-object v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedNumericParser;->_inputBuffer:[C

    iget v7, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedNumericParser;->_inputPtr:I

    add-int/lit8 v9, v7, 0x1

    iput v9, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedNumericParser;->_inputPtr:I

    aget-char v7, v2, v7

    :goto_b
    const/16 v2, 0x2d

    if-eq v7, v2, :cond_11

    const/16 v2, 0x2b

    if-ne v7, v2, :cond_1e

    :cond_11
    array-length v2, v3

    if-lt v4, v2, :cond_1d

    iget-object v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedNumericParser;->_textBuffer:Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/TextBuffer;

    invoke-virtual {v2}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/TextBuffer;->finishCurrentSegment()[C

    move-result-object v3

    const/4 v2, 0x0

    :goto_c
    add-int/lit8 v4, v2, 0x1

    aput-char v7, v3, v2

    iget v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedNumericParser;->_inputPtr:I

    iget v7, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedNumericParser;->_inputEnd:I

    if-ge v2, v7, :cond_1a

    iget-object v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedNumericParser;->_inputBuffer:[C

    iget v7, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedNumericParser;->_inputPtr:I

    add-int/lit8 v9, v7, 0x1

    iput v9, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedNumericParser;->_inputPtr:I

    aget-char v2, v2, v7

    move v10, v5

    move-object v5, v3

    move v3, v10

    :goto_d
    move v7, v2

    move v2, v4

    :goto_e
    const/16 v4, 0x39

    if-gt v7, v4, :cond_1c

    const/16 v4, 0x30

    if-lt v7, v4, :cond_1c

    add-int/lit8 v3, v3, 0x1

    array-length v4, v5

    if-lt v2, v4, :cond_12

    iget-object v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedNumericParser;->_textBuffer:Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/TextBuffer;

    invoke-virtual {v2}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/TextBuffer;->finishCurrentSegment()[C

    move-result-object v5

    const/4 v2, 0x0

    :cond_12
    add-int/lit8 v4, v2, 0x1

    aput-char v7, v5, v2

    iget v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedNumericParser;->_inputPtr:I

    iget v9, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedNumericParser;->_inputEnd:I

    if-lt v2, v9, :cond_1b

    invoke-virtual {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedNumericParser;->loadMore()Z

    move-result v2

    if-nez v2, :cond_1b

    const/4 v6, 0x1

    move v5, v3

    move v2, v6

    move v3, v4

    :goto_f
    if-nez v5, :cond_13

    const-string v4, "Exponent indicator not followed by a digit"

    invoke-virtual {p0, v7, v4}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedNumericParser;->reportUnexpectedNumberChar(ILjava/lang/String;)V

    :cond_13
    :goto_10
    if-nez v2, :cond_14

    iget v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedNumericParser;->_inputPtr:I

    add-int/lit8 v2, v2, -0x1

    iput v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedNumericParser;->_inputPtr:I

    :cond_14
    iget-object v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedNumericParser;->_textBuffer:Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/TextBuffer;

    invoke-virtual {v2, v3}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/TextBuffer;->setCurrentLength(I)V

    invoke-virtual {p0, v0, v1, v8, v5}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedNumericParser;->reset(ZIII)Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;

    move-result-object v0

    goto/16 :goto_5

    :cond_15
    move v1, v4

    goto/16 :goto_6

    :cond_16
    iget-object v4, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedNumericParser;->_inputBuffer:[C

    iget v5, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedNumericParser;->_inputPtr:I

    add-int/lit8 v6, v5, 0x1

    iput v6, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedNumericParser;->_inputPtr:I

    aget-char v5, v4, v5

    const/16 v4, 0x30

    if-lt v5, v4, :cond_c

    const/16 v4, 0x39

    if-gt v5, v4, :cond_c

    add-int/lit8 v1, v1, 0x1

    const/4 v4, 0x2

    if-ne v1, v4, :cond_17

    add-int/lit8 v4, v2, -0x1

    aget-char v4, v3, v4

    const/16 v6, 0x30

    if-ne v4, v6, :cond_17

    const-string v4, "Leading zeroes not allowed"

    invoke-virtual {p0, v4}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedNumericParser;->reportInvalidNumber(Ljava/lang/String;)V

    :cond_17
    array-length v4, v3

    if-lt v2, v4, :cond_23

    iget-object v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedNumericParser;->_textBuffer:Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/TextBuffer;

    invoke-virtual {v2}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/TextBuffer;->finishCurrentSegment()[C

    move-result-object v3

    const/4 v2, 0x0

    move v4, v2

    :goto_11
    add-int/lit8 v2, v4, 0x1

    aput-char v5, v3, v4

    goto/16 :goto_7

    :cond_18
    iget-object v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedNumericParser;->_inputBuffer:[C

    iget v6, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedNumericParser;->_inputPtr:I

    add-int/lit8 v8, v6, 0x1

    iput v8, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedNumericParser;->_inputPtr:I

    aget-char v3, v3, v6

    const/16 v6, 0x30

    if-lt v3, v6, :cond_21

    const/16 v6, 0x39

    if-gt v3, v6, :cond_21

    add-int/lit8 v2, v2, 0x1

    array-length v6, v5

    if-lt v4, v6, :cond_20

    iget-object v4, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedNumericParser;->_textBuffer:Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/TextBuffer;

    invoke-virtual {v4}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/TextBuffer;->finishCurrentSegment()[C

    move-result-object v5

    const/4 v4, 0x0

    move v6, v4

    :goto_12
    add-int/lit8 v4, v6, 0x1

    aput-char v3, v5, v6

    goto/16 :goto_8

    :cond_19
    const-string v2, "expected a digit for number exponent"

    invoke-virtual {p0, v2}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedNumericParser;->getNextChar(Ljava/lang/String;)C

    move-result v7

    goto/16 :goto_b

    :cond_1a
    const-string v2, "expected a digit for number exponent"

    invoke-virtual {p0, v2}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedNumericParser;->getNextChar(Ljava/lang/String;)C

    move-result v2

    move v10, v5

    move-object v5, v3

    move v3, v10

    goto/16 :goto_d

    :cond_1b
    iget-object v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedNumericParser;->_inputBuffer:[C

    iget v7, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedNumericParser;->_inputPtr:I

    add-int/lit8 v9, v7, 0x1

    iput v9, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedNumericParser;->_inputPtr:I

    aget-char v2, v2, v7

    goto/16 :goto_d

    :cond_1c
    move v5, v3

    move v3, v2

    move v2, v6

    goto/16 :goto_f

    :cond_1d
    move v2, v4

    goto/16 :goto_c

    :cond_1e
    move v2, v4

    move v10, v5

    move-object v5, v3

    move v3, v10

    goto/16 :goto_e

    :cond_1f
    move v3, v2

    move v2, v6

    goto/16 :goto_10

    :cond_20
    move v6, v4

    goto :goto_12

    :cond_21
    move v6, v7

    goto/16 :goto_9

    :cond_22
    move v8, v4

    move v6, v7

    move v7, v5

    goto/16 :goto_a

    :cond_23
    move v4, v2

    goto :goto_11

    :cond_24
    move v10, v5

    move v5, v3

    move v3, v10

    goto/16 :goto_4

    :cond_25
    move v2, v3

    goto/16 :goto_2

    :cond_26
    move v1, v2

    goto/16 :goto_1
.end method
