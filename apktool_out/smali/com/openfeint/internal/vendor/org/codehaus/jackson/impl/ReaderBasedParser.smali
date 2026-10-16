.class public final Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;
.super Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedNumericParser;


# instance fields
.field protected _objectCodec:Lcom/openfeint/internal/vendor/org/codehaus/jackson/ObjectCodec;

.field protected final _symbols:Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/CharsToNameCanonicalizer;


# direct methods
.method public constructor <init>(Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/IOContext;ILjava/io/Reader;Lcom/openfeint/internal/vendor/org/codehaus/jackson/ObjectCodec;Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/CharsToNameCanonicalizer;)V
    .locals 0

    invoke-direct {p0, p1, p2, p3}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedNumericParser;-><init>(Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/IOContext;ILjava/io/Reader;)V

    iput-object p4, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_objectCodec:Lcom/openfeint/internal/vendor/org/codehaus/jackson/ObjectCodec;

    iput-object p5, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_symbols:Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/CharsToNameCanonicalizer;

    return-void
.end method

.method private _decodeEscaped()C
    .locals 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParseException;
        }
    .end annotation

    const/4 v1, 0x0

    iget v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputPtr:I

    iget v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputEnd:I

    if-lt v0, v2, :cond_0

    invoke-virtual {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->loadMore()Z

    move-result v0

    if-nez v0, :cond_0

    const-string v0, " in character escape sequence"

    invoke-virtual {p0, v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_reportInvalidEOF(Ljava/lang/String;)V

    :cond_0
    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputBuffer:[C

    iget v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputPtr:I

    add-int/lit8 v3, v2, 0x1

    iput v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputPtr:I

    aget-char v0, v0, v2

    sparse-switch v0, :sswitch_data_0

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Unrecognized character escape "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-static {v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_getCharDesc(I)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_reportError(Ljava/lang/String;)V

    :sswitch_0
    move v0, v1

    :goto_0
    const/4 v2, 0x4

    if-ge v0, v2, :cond_3

    iget v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputPtr:I

    iget v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputEnd:I

    if-lt v2, v3, :cond_1

    invoke-virtual {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->loadMore()Z

    move-result v2

    if-nez v2, :cond_1

    const-string v2, " in character escape sequence"

    invoke-virtual {p0, v2}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_reportInvalidEOF(Ljava/lang/String;)V

    :cond_1
    iget-object v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputBuffer:[C

    iget v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputPtr:I

    add-int/lit8 v4, v3, 0x1

    iput v4, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputPtr:I

    aget-char v2, v2, v3

    invoke-static {v2}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/CharTypes;->charToHex(I)I

    move-result v3

    if-gez v3, :cond_2

    const-string v4, "expected a hex-digit for character escape sequence"

    invoke-virtual {p0, v2, v4}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_reportUnexpectedChar(ILjava/lang/String;)V

    :cond_2
    shl-int/lit8 v1, v1, 0x4

    or-int/2addr v1, v3

    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :sswitch_1
    const/16 v0, 0x8

    :goto_1
    :sswitch_2
    return v0

    :sswitch_3
    const/16 v0, 0x9

    goto :goto_1

    :sswitch_4
    const/16 v0, 0xa

    goto :goto_1

    :sswitch_5
    const/16 v0, 0xc

    goto :goto_1

    :sswitch_6
    const/16 v0, 0xd

    goto :goto_1

    :cond_3
    int-to-char v0, v1

    goto :goto_1

    :sswitch_data_0
    .sparse-switch
        0x22 -> :sswitch_2
        0x2f -> :sswitch_2
        0x5c -> :sswitch_2
        0x62 -> :sswitch_1
        0x66 -> :sswitch_5
        0x6e -> :sswitch_4
        0x72 -> :sswitch_6
        0x74 -> :sswitch_3
        0x75 -> :sswitch_0
    .end sparse-switch
.end method

.method private _handleUnexpectedValue(I)Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;
    .locals 7
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParseException;
        }
    .end annotation

    const/16 v6, 0x5c

    const/16 v5, 0x27

    if-ne p1, v5, :cond_0

    sget-object v0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser$Feature;->ALLOW_SINGLE_QUOTES:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser$Feature;

    invoke-virtual {p0, v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->isEnabled(Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser$Feature;)Z

    move-result v0

    if-nez v0, :cond_1

    :cond_0
    const-string v0, "expected a valid value (number, String, array, object, \'true\', \'false\' or \'null\')"

    invoke-virtual {p0, p1, v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_reportUnexpectedChar(ILjava/lang/String;)V

    :cond_1
    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_textBuffer:Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/TextBuffer;

    invoke-virtual {v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/TextBuffer;->emptyAndGetCurrentSegment()[C

    move-result-object v1

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_textBuffer:Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/TextBuffer;

    invoke-virtual {v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/TextBuffer;->getCurrentSegmentSize()I

    move-result v0

    :goto_0
    iget v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputPtr:I

    iget v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputEnd:I

    if-lt v2, v3, :cond_2

    invoke-virtual {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->loadMore()Z

    move-result v2

    if-nez v2, :cond_2

    const-string v2, ": was expecting closing quote for a string value"

    invoke-virtual {p0, v2}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_reportInvalidEOF(Ljava/lang/String;)V

    :cond_2
    iget-object v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputBuffer:[C

    iget v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputPtr:I

    add-int/lit8 v4, v3, 0x1

    iput v4, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputPtr:I

    aget-char v2, v2, v3

    if-gt v2, v6, :cond_3

    if-ne v2, v6, :cond_4

    invoke-direct {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_decodeEscaped()C

    move-result v2

    :cond_3
    :goto_1
    array-length v3, v1

    if-lt v0, v3, :cond_6

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_textBuffer:Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/TextBuffer;

    invoke-virtual {v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/TextBuffer;->finishCurrentSegment()[C

    move-result-object v1

    const/4 v0, 0x0

    move v3, v0

    :goto_2
    add-int/lit8 v0, v3, 0x1

    aput-char v2, v1, v3

    goto :goto_0

    :cond_4
    if-gt v2, v5, :cond_3

    if-eq v2, v5, :cond_5

    const/16 v3, 0x20

    if-ge v2, v3, :cond_3

    const-string v3, "string value"

    invoke-virtual {p0, v2, v3}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_throwUnquotedSpace(ILjava/lang/String;)V

    goto :goto_1

    :cond_5
    iget-object v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_textBuffer:Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/TextBuffer;

    invoke-virtual {v1, v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/TextBuffer;->setCurrentLength(I)V

    sget-object v0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;->VALUE_STRING:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;

    return-object v0

    :cond_6
    move v3, v0

    goto :goto_2
.end method

.method private _matchToken(Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;)V
    .locals 6
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParseException;
        }
    .end annotation

    invoke-virtual {p1}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;->asString()Ljava/lang/String;

    move-result-object v1

    const/4 v0, 0x1

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v2

    :goto_0
    if-ge v0, v2, :cond_4

    iget v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputPtr:I

    iget v4, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputEnd:I

    if-lt v3, v4, :cond_0

    invoke-virtual {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->loadMore()Z

    move-result v3

    if-nez v3, :cond_0

    const-string v3, " in a value"

    invoke-virtual {p0, v3}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_reportInvalidEOF(Ljava/lang/String;)V

    :cond_0
    iget-object v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputBuffer:[C

    iget v4, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputPtr:I

    aget-char v3, v3, v4

    invoke-virtual {v1, v0}, Ljava/lang/String;->charAt(I)C

    move-result v4

    if-eq v3, v4, :cond_3

    const/4 v3, 0x0

    invoke-virtual {v1, v3, v0}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v3

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    :goto_1
    iget v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputPtr:I

    iget v5, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputEnd:I

    if-lt v3, v5, :cond_1

    invoke-virtual {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->loadMore()Z

    move-result v3

    if-eqz v3, :cond_2

    :cond_1
    iget-object v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputBuffer:[C

    iget v5, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputPtr:I

    aget-char v3, v3, v5

    invoke-static {v3}, Ljava/lang/Character;->isJavaIdentifierPart(C)Z

    move-result v5

    if-eqz v5, :cond_2

    iget v5, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputPtr:I

    add-int/lit8 v5, v5, 0x1

    iput v5, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputPtr:I

    invoke-virtual {v4, v3}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    goto :goto_1

    :cond_2
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "Unrecognized token \'"

    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "\': was expecting \'null\', \'true\' or \'false\'"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0, v3}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_reportError(Ljava/lang/String;)V

    :cond_3
    iget v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputPtr:I

    add-int/lit8 v3, v3, 0x1

    iput v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputPtr:I

    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_4
    return-void
.end method

.method private _parseFieldName(I)Ljava/lang/String;
    .locals 10
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParseException;
        }
    .end annotation

    const/16 v8, 0x27

    const/16 v7, 0x22

    const/4 v0, 0x0

    if-eq p1, v7, :cond_11

    if-ne p1, v8, :cond_4

    sget-object v1, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser$Feature;->ALLOW_SINGLE_QUOTES:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser$Feature;

    invoke-virtual {p0, v1}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->isEnabled(Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser$Feature;)Z

    move-result v1

    if-eqz v1, :cond_4

    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputPtr:I

    iget v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputEnd:I

    if-ge v1, v2, :cond_3

    invoke-static {}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/CharTypes;->getInputCodeLatin1()[I

    move-result-object v3

    array-length v4, v3

    :cond_0
    iget-object v5, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputBuffer:[C

    aget-char v5, v5, v1

    if-ne v5, v8, :cond_1

    iget v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputPtr:I

    add-int/lit8 v3, v1, 0x1

    iput v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputPtr:I

    iget-object v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_symbols:Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/CharsToNameCanonicalizer;

    iget-object v4, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputBuffer:[C

    sub-int/2addr v1, v2

    invoke-virtual {v3, v4, v2, v1, v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/CharsToNameCanonicalizer;->findSymbol([CIII)Ljava/lang/String;

    move-result-object v0

    :goto_0
    return-object v0

    :cond_1
    if-ge v5, v4, :cond_2

    aget v6, v3, v5

    if-nez v6, :cond_3

    :cond_2
    mul-int/lit8 v0, v0, 0x1f

    add-int/2addr v0, v5

    add-int/lit8 v1, v1, 0x1

    if-lt v1, v2, :cond_0

    :cond_3
    iget v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputPtr:I

    iput v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputPtr:I

    invoke-direct {p0, v2, v0, v8}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_parseFieldName2(III)Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    :cond_4
    sget-object v1, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser$Feature;->ALLOW_UNQUOTED_FIELD_NAMES:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser$Feature;

    invoke-virtual {p0, v1}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->isEnabled(Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser$Feature;)Z

    move-result v1

    if-nez v1, :cond_5

    const-string v1, "was expecting double-quote to start field name"

    invoke-virtual {p0, p1, v1}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_reportUnexpectedChar(ILjava/lang/String;)V

    :cond_5
    invoke-static {}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/CharTypes;->getInputCodeLatin1JsNames()[I

    move-result-object v5

    array-length v3, v5

    if-ge p1, v3, :cond_a

    aget v1, v5, p1

    if-nez v1, :cond_9

    const/16 v1, 0x30

    if-lt p1, v1, :cond_6

    const/16 v1, 0x39

    if-le p1, v1, :cond_9

    :cond_6
    const/4 v1, 0x1

    :goto_1
    if-nez v1, :cond_7

    const-string v1, "was expecting either valid name character (for unquoted name) or double-quote (for quoted) to start field name"

    invoke-virtual {p0, p1, v1}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_reportUnexpectedChar(ILjava/lang/String;)V

    :cond_7
    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputPtr:I

    iget v4, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputEnd:I

    if-ge v1, v4, :cond_16

    move v2, v1

    move v1, v0

    :cond_8
    iget-object v6, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputBuffer:[C

    aget-char v6, v6, v2

    if-ge v6, v3, :cond_b

    aget v7, v5, v6

    if-eqz v7, :cond_c

    iget v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputPtr:I

    add-int/lit8 v0, v0, -0x1

    iput v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputPtr:I

    iget-object v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_symbols:Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/CharsToNameCanonicalizer;

    iget-object v4, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputBuffer:[C

    sub-int/2addr v2, v0

    invoke-virtual {v3, v4, v0, v2, v1}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/CharsToNameCanonicalizer;->findSymbol([CIII)Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    :cond_9
    move v1, v0

    goto :goto_1

    :cond_a
    int-to-char v1, p1

    invoke-static {v1}, Ljava/lang/Character;->isJavaIdentifierPart(C)Z

    move-result v1

    goto :goto_1

    :cond_b
    int-to-char v7, v6

    invoke-static {v7}, Ljava/lang/Character;->isJavaIdentifierPart(C)Z

    move-result v7

    if-nez v7, :cond_c

    iget v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputPtr:I

    add-int/lit8 v0, v0, -0x1

    iput v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputPtr:I

    iget-object v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_symbols:Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/CharsToNameCanonicalizer;

    iget-object v4, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputBuffer:[C

    sub-int/2addr v2, v0

    invoke-virtual {v3, v4, v0, v2, v1}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/CharsToNameCanonicalizer;->findSymbol([CIII)Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    :cond_c
    mul-int/lit8 v1, v1, 0x1f

    add-int/2addr v1, v6

    add-int/lit8 v2, v2, 0x1

    if-lt v2, v4, :cond_8

    :goto_2
    iget v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputPtr:I

    add-int/lit8 v3, v3, -0x1

    iput v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputPtr:I

    iget-object v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_textBuffer:Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/TextBuffer;

    iget-object v4, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputBuffer:[C

    iget v6, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputPtr:I

    sub-int/2addr v6, v3

    invoke-virtual {v2, v4, v3, v6}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/TextBuffer;->resetWithShared([CII)V

    iget-object v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_textBuffer:Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/TextBuffer;

    invoke-virtual {v2}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/TextBuffer;->getCurrentSegment()[C

    move-result-object v3

    iget-object v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_textBuffer:Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/TextBuffer;

    invoke-virtual {v2}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/TextBuffer;->getCurrentSegmentSize()I

    move-result v2

    array-length v6, v5

    move v9, v2

    move-object v2, v3

    move v3, v1

    move v1, v9

    :goto_3
    iget v4, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputPtr:I

    iget v7, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputEnd:I

    if-lt v4, v7, :cond_d

    invoke-virtual {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->loadMore()Z

    move-result v4

    if-eqz v4, :cond_e

    :cond_d
    iget-object v4, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputBuffer:[C

    iget v7, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputPtr:I

    aget-char v7, v4, v7

    if-gt v7, v6, :cond_f

    aget v4, v5, v7

    if-eqz v4, :cond_10

    :cond_e
    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_textBuffer:Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/TextBuffer;

    invoke-virtual {v0, v1}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/TextBuffer;->setCurrentLength(I)V

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_textBuffer:Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/TextBuffer;

    invoke-virtual {v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/TextBuffer;->getTextBuffer()[C

    move-result-object v1

    invoke-virtual {v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/TextBuffer;->getTextOffset()I

    move-result v2

    invoke-virtual {v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/TextBuffer;->size()I

    move-result v0

    iget-object v4, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_symbols:Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/CharsToNameCanonicalizer;

    invoke-virtual {v4, v1, v2, v0, v3}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/CharsToNameCanonicalizer;->findSymbol([CIII)Ljava/lang/String;

    move-result-object v0

    goto/16 :goto_0

    :cond_f
    invoke-static {v7}, Ljava/lang/Character;->isJavaIdentifierPart(C)Z

    move-result v4

    if-eqz v4, :cond_e

    :cond_10
    iget v4, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputPtr:I

    add-int/lit8 v4, v4, 0x1

    iput v4, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputPtr:I

    mul-int/lit8 v3, v3, 0x1f

    add-int/2addr v3, v7

    add-int/lit8 v4, v1, 0x1

    aput-char v7, v2, v1

    array-length v1, v2

    if-lt v4, v1, :cond_15

    iget-object v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_textBuffer:Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/TextBuffer;

    invoke-virtual {v1}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/TextBuffer;->finishCurrentSegment()[C

    move-result-object v2

    move v1, v0

    goto :goto_3

    :cond_11
    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputPtr:I

    iget v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputEnd:I

    if-ge v1, v2, :cond_14

    invoke-static {}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/CharTypes;->getInputCodeLatin1()[I

    move-result-object v3

    array-length v4, v3

    :cond_12
    iget-object v5, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputBuffer:[C

    aget-char v5, v5, v1

    if-ge v5, v4, :cond_13

    aget v6, v3, v5

    if-eqz v6, :cond_13

    if-ne v5, v7, :cond_14

    iget v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputPtr:I

    add-int/lit8 v3, v1, 0x1

    iput v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputPtr:I

    iget-object v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_symbols:Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/CharsToNameCanonicalizer;

    iget-object v4, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputBuffer:[C

    sub-int/2addr v1, v2

    invoke-virtual {v3, v4, v2, v1, v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/CharsToNameCanonicalizer;->findSymbol([CIII)Ljava/lang/String;

    move-result-object v0

    goto/16 :goto_0

    :cond_13
    mul-int/lit8 v0, v0, 0x1f

    add-int/2addr v0, v5

    add-int/lit8 v1, v1, 0x1

    if-lt v1, v2, :cond_12

    :cond_14
    iget v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputPtr:I

    iput v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputPtr:I

    invoke-direct {p0, v2, v0, v7}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_parseFieldName2(III)Ljava/lang/String;

    move-result-object v0

    goto/16 :goto_0

    :cond_15
    move v1, v4

    goto/16 :goto_3

    :cond_16
    move v2, v1

    move v1, v0

    goto/16 :goto_2
.end method

.method private _parseFieldName2(III)Ljava/lang/String;
    .locals 6
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParseException;
        }
    .end annotation

    const/16 v5, 0x5c

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_textBuffer:Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/TextBuffer;

    iget-object v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputBuffer:[C

    iget v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputPtr:I

    sub-int/2addr v2, p1

    invoke-virtual {v0, v1, p1, v2}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/TextBuffer;->resetWithShared([CII)V

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_textBuffer:Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/TextBuffer;

    invoke-virtual {v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/TextBuffer;->getCurrentSegment()[C

    move-result-object v1

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_textBuffer:Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/TextBuffer;

    invoke-virtual {v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/TextBuffer;->getCurrentSegmentSize()I

    move-result v0

    :goto_0
    iget v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputPtr:I

    iget v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputEnd:I

    if-lt v2, v3, :cond_0

    invoke-virtual {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->loadMore()Z

    move-result v2

    if-nez v2, :cond_0

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, ": was expecting closing \'"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    int-to-char v3, p3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "\' for name"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p0, v2}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_reportInvalidEOF(Ljava/lang/String;)V

    :cond_0
    iget-object v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputBuffer:[C

    iget v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputPtr:I

    add-int/lit8 v4, v3, 0x1

    iput v4, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputPtr:I

    aget-char v3, v2, v3

    if-gt v3, v5, :cond_2

    if-ne v3, v5, :cond_1

    invoke-direct {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_decodeEscaped()C

    move-result v2

    :goto_1
    mul-int/lit8 v4, p2, 0x1f

    add-int p2, v4, v3

    add-int/lit8 v3, v0, 0x1

    aput-char v2, v1, v0

    array-length v0, v1

    if-lt v3, v0, :cond_4

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_textBuffer:Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/TextBuffer;

    invoke-virtual {v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/TextBuffer;->finishCurrentSegment()[C

    move-result-object v1

    const/4 v0, 0x0

    goto :goto_0

    :cond_1
    if-gt v3, p3, :cond_2

    if-eq v3, p3, :cond_3

    const/16 v2, 0x20

    if-ge v3, v2, :cond_2

    const-string v2, "name"

    invoke-virtual {p0, v3, v2}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_throwUnquotedSpace(ILjava/lang/String;)V

    :cond_2
    move v2, v3

    goto :goto_1

    :cond_3
    iget-object v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_textBuffer:Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/TextBuffer;

    invoke-virtual {v1, v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/TextBuffer;->setCurrentLength(I)V

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_textBuffer:Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/TextBuffer;

    invoke-virtual {v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/TextBuffer;->getTextBuffer()[C

    move-result-object v1

    invoke-virtual {v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/TextBuffer;->getTextOffset()I

    move-result v2

    invoke-virtual {v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/TextBuffer;->size()I

    move-result v0

    iget-object v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_symbols:Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/CharsToNameCanonicalizer;

    invoke-virtual {v3, v1, v2, v0, p2}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/CharsToNameCanonicalizer;->findSymbol([CIII)Ljava/lang/String;

    move-result-object v0

    return-object v0

    :cond_4
    move v0, v3

    goto :goto_0
.end method

.method private _skipCR()V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    iget v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputPtr:I

    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputEnd:I

    if-lt v0, v1, :cond_0

    invoke-virtual {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->loadMore()Z

    move-result v0

    if-eqz v0, :cond_1

    :cond_0
    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputBuffer:[C

    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputPtr:I

    aget-char v0, v0, v1

    const/16 v1, 0xa

    if-ne v0, v1, :cond_1

    iget v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputPtr:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputPtr:I

    :cond_1
    iget v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_currInputRow:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_currInputRow:I

    iget v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputPtr:I

    iput v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_currInputRowStart:I

    return-void
.end method

.method private final _skipComment()V
    .locals 8
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParseException;
        }
    .end annotation

    const/16 v7, 0xd

    const/16 v6, 0xa

    const/16 v5, 0x9

    const/16 v4, 0x2f

    const/16 v3, 0x2a

    sget-object v0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser$Feature;->ALLOW_COMMENTS:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser$Feature;

    invoke-virtual {p0, v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->isEnabled(Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser$Feature;)Z

    move-result v0

    if-nez v0, :cond_0

    const-string v0, "maybe a (non-standard) comment? (not recognized as one since Feature \'ALLOW_COMMENTS\' not enabled for parser)"

    invoke-virtual {p0, v4, v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_reportUnexpectedChar(ILjava/lang/String;)V

    :cond_0
    iget v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputPtr:I

    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputEnd:I

    if-lt v0, v1, :cond_1

    invoke-virtual {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->loadMore()Z

    move-result v0

    if-nez v0, :cond_1

    const-string v0, " in a comment"

    invoke-virtual {p0, v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_reportInvalidEOF(Ljava/lang/String;)V

    :cond_1
    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputBuffer:[C

    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputPtr:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputPtr:I

    aget-char v0, v0, v1

    if-ne v0, v4, :cond_7

    :cond_2
    :goto_0
    iget v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputPtr:I

    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputEnd:I

    if-lt v0, v1, :cond_3

    invoke-virtual {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->loadMore()Z

    move-result v0

    if-eqz v0, :cond_4

    :cond_3
    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputBuffer:[C

    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputPtr:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputPtr:I

    aget-char v0, v0, v1

    const/16 v1, 0x20

    if-ge v0, v1, :cond_2

    if-ne v0, v6, :cond_5

    invoke-direct {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_skipLF()V

    :cond_4
    :goto_1
    return-void

    :cond_5
    if-ne v0, v7, :cond_6

    invoke-direct {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_skipCR()V

    goto :goto_1

    :cond_6
    if-eq v0, v5, :cond_2

    invoke-virtual {p0, v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_throwInvalidSpace(I)V

    goto :goto_0

    :cond_7
    if-ne v0, v3, :cond_f

    :cond_8
    :goto_2
    iget v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputPtr:I

    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputEnd:I

    if-lt v0, v1, :cond_9

    invoke-virtual {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->loadMore()Z

    move-result v0

    if-eqz v0, :cond_e

    :cond_9
    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputBuffer:[C

    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputPtr:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputPtr:I

    aget-char v0, v0, v1

    if-gt v0, v3, :cond_8

    if-ne v0, v3, :cond_b

    iget v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputPtr:I

    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputEnd:I

    if-lt v0, v1, :cond_a

    invoke-virtual {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->loadMore()Z

    move-result v0

    if-eqz v0, :cond_e

    :cond_a
    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputBuffer:[C

    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputPtr:I

    aget-char v0, v0, v1

    if-ne v0, v4, :cond_8

    iget v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputPtr:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputPtr:I

    goto :goto_1

    :cond_b
    const/16 v1, 0x20

    if-ge v0, v1, :cond_8

    if-ne v0, v6, :cond_c

    invoke-direct {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_skipLF()V

    goto :goto_2

    :cond_c
    if-ne v0, v7, :cond_d

    invoke-direct {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_skipCR()V

    goto :goto_2

    :cond_d
    if-eq v0, v5, :cond_8

    invoke-virtual {p0, v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_throwInvalidSpace(I)V

    goto :goto_2

    :cond_e
    const-string v0, " in a comment"

    invoke-virtual {p0, v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_reportInvalidEOF(Ljava/lang/String;)V

    goto :goto_1

    :cond_f
    const-string v1, "was expecting either \'*\' or \'/\' for a comment"

    invoke-virtual {p0, v0, v1}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_reportUnexpectedChar(ILjava/lang/String;)V

    goto :goto_1
.end method

.method private _skipLF()V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    iget v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_currInputRow:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_currInputRow:I

    iget v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputPtr:I

    iput v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_currInputRowStart:I

    return-void
.end method

.method private final _skipWS()I
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParseException;
        }
    .end annotation

    const/16 v3, 0x20

    :cond_0
    :goto_0
    iget v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputPtr:I

    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputEnd:I

    if-lt v0, v1, :cond_1

    invoke-virtual {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->loadMore()Z

    move-result v0

    if-eqz v0, :cond_6

    :cond_1
    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputBuffer:[C

    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputPtr:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputPtr:I

    aget-char v0, v0, v1

    if-le v0, v3, :cond_3

    const/16 v1, 0x2f

    if-eq v0, v1, :cond_2

    return v0

    :cond_2
    invoke-direct {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_skipComment()V

    goto :goto_0

    :cond_3
    if-eq v0, v3, :cond_0

    const/16 v1, 0xa

    if-ne v0, v1, :cond_4

    invoke-direct {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_skipLF()V

    goto :goto_0

    :cond_4
    const/16 v1, 0xd

    if-ne v0, v1, :cond_5

    invoke-direct {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_skipCR()V

    goto :goto_0

    :cond_5
    const/16 v1, 0x9

    if-eq v0, v1, :cond_0

    invoke-virtual {p0, v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_throwInvalidSpace(I)V

    goto :goto_0

    :cond_6
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Unexpected end-of-input within/between "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_parsingContext:Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonReadContext;

    invoke-virtual {v1}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonReadContext;->getTypeDesc()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " entries"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_constructError(Ljava/lang/String;)Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParseException;

    move-result-object v0

    throw v0
.end method


# virtual methods
.method protected final _finishString()V
    .locals 8
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParseException;
        }
    .end annotation

    const/16 v7, 0x5c

    const/16 v6, 0x22

    iget v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputPtr:I

    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputEnd:I

    if-ge v0, v1, :cond_2

    invoke-static {}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/CharTypes;->getInputCodeLatin1()[I

    move-result-object v2

    array-length v3, v2

    :cond_0
    iget-object v4, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputBuffer:[C

    aget-char v4, v4, v0

    if-ge v4, v3, :cond_1

    aget v5, v2, v4

    if-eqz v5, :cond_1

    if-ne v4, v6, :cond_2

    iget-object v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_textBuffer:Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/TextBuffer;

    iget-object v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputBuffer:[C

    iget v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputPtr:I

    iget v4, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputPtr:I

    sub-int v4, v0, v4

    invoke-virtual {v1, v2, v3, v4}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/TextBuffer;->resetWithShared([CII)V

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputPtr:I

    :goto_0
    return-void

    :cond_1
    add-int/lit8 v0, v0, 0x1

    if-lt v0, v1, :cond_0

    :cond_2
    iget-object v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_textBuffer:Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/TextBuffer;

    iget-object v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputBuffer:[C

    iget v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputPtr:I

    iget v4, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputPtr:I

    sub-int v4, v0, v4

    invoke-virtual {v1, v2, v3, v4}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/TextBuffer;->resetWithCopy([CII)V

    iput v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputPtr:I

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_textBuffer:Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/TextBuffer;

    invoke-virtual {v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/TextBuffer;->getCurrentSegment()[C

    move-result-object v1

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_textBuffer:Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/TextBuffer;

    invoke-virtual {v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/TextBuffer;->getCurrentSegmentSize()I

    move-result v0

    :goto_1
    iget v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputPtr:I

    iget v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputEnd:I

    if-lt v2, v3, :cond_3

    invoke-virtual {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->loadMore()Z

    move-result v2

    if-nez v2, :cond_3

    const-string v2, ": was expecting closing quote for a string value"

    invoke-virtual {p0, v2}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_reportInvalidEOF(Ljava/lang/String;)V

    :cond_3
    iget-object v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputBuffer:[C

    iget v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputPtr:I

    add-int/lit8 v4, v3, 0x1

    iput v4, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputPtr:I

    aget-char v2, v2, v3

    if-gt v2, v7, :cond_4

    if-ne v2, v7, :cond_5

    invoke-direct {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_decodeEscaped()C

    move-result v2

    :cond_4
    :goto_2
    array-length v3, v1

    if-lt v0, v3, :cond_7

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_textBuffer:Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/TextBuffer;

    invoke-virtual {v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/TextBuffer;->finishCurrentSegment()[C

    move-result-object v1

    const/4 v0, 0x0

    move v3, v0

    :goto_3
    add-int/lit8 v0, v3, 0x1

    aput-char v2, v1, v3

    goto :goto_1

    :cond_5
    if-gt v2, v6, :cond_4

    if-eq v2, v6, :cond_6

    const/16 v3, 0x20

    if-ge v2, v3, :cond_4

    const-string v3, "string value"

    invoke-virtual {p0, v2, v3}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_throwUnquotedSpace(ILjava/lang/String;)V

    goto :goto_2

    :cond_6
    iget-object v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_textBuffer:Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/TextBuffer;

    invoke-virtual {v1, v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/TextBuffer;->setCurrentLength(I)V

    goto :goto_0

    :cond_7
    move v3, v0

    goto :goto_3
.end method

.method public final close()V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    invoke-super {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedNumericParser;->close()V

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_symbols:Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/CharsToNameCanonicalizer;

    invoke-virtual {v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/CharsToNameCanonicalizer;->release()V

    return-void
.end method

.method public final nextToken()Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;
    .locals 9
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParseException;
        }
    .end annotation

    const/16 v8, 0x5c

    const/16 v7, 0x22

    const/4 v3, 0x0

    const/4 v2, 0x0

    const/16 v6, 0x20

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_currToken:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;

    sget-object v1, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;->FIELD_NAME:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;

    if-ne v0, v1, :cond_2

    iput-boolean v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_nameCopied:Z

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_nextToken:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;

    iput-object v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_nextToken:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;

    sget-object v1, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;->START_ARRAY:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;

    if-ne v0, v1, :cond_1

    iget-object v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_parsingContext:Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonReadContext;

    iget v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_tokenInputRow:I

    iget v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_tokenInputCol:I

    invoke-virtual {v1, v2, v3}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonReadContext;->createChildArrayContext(II)Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonReadContext;

    move-result-object v1

    iput-object v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_parsingContext:Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonReadContext;

    :cond_0
    :goto_0
    iput-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_currToken:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;

    :goto_1
    return-object v0

    :cond_1
    sget-object v1, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;->START_OBJECT:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;

    if-ne v0, v1, :cond_0

    iget-object v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_parsingContext:Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonReadContext;

    iget v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_tokenInputRow:I

    iget v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_tokenInputCol:I

    invoke-virtual {v1, v2, v3}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonReadContext;->createChildObjectContext(II)Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonReadContext;

    move-result-object v1

    iput-object v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_parsingContext:Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonReadContext;

    goto :goto_0

    :cond_2
    iget-boolean v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_tokenIncomplete:Z

    if-eqz v0, :cond_6

    iput-boolean v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_tokenIncomplete:Z

    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputPtr:I

    iget v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputEnd:I

    iget-object v4, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputBuffer:[C

    :goto_2
    if-lt v1, v0, :cond_4

    iput v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputPtr:I

    invoke-virtual {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->loadMore()Z

    move-result v0

    if-nez v0, :cond_3

    const-string v0, ": was expecting closing quote for a string value"

    invoke-virtual {p0, v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_reportInvalidEOF(Ljava/lang/String;)V

    :cond_3
    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputPtr:I

    iget v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputEnd:I

    :cond_4
    add-int/lit8 v3, v1, 0x1

    aget-char v1, v4, v1

    if-gt v1, v8, :cond_9

    if-ne v1, v8, :cond_5

    iput v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputPtr:I

    invoke-direct {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_decodeEscaped()C

    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputPtr:I

    iget v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputEnd:I

    goto :goto_2

    :cond_5
    if-gt v1, v7, :cond_9

    if-ne v1, v7, :cond_8

    iput v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputPtr:I

    :cond_6
    :goto_3
    iget v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputPtr:I

    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputEnd:I

    if-lt v0, v1, :cond_7

    invoke-virtual {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->loadMore()Z

    move-result v0

    if-eqz v0, :cond_e

    :cond_7
    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputBuffer:[C

    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputPtr:I

    add-int/lit8 v3, v1, 0x1

    iput v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputPtr:I

    aget-char v0, v0, v1

    if-le v0, v6, :cond_b

    const/16 v1, 0x2f

    if-eq v0, v1, :cond_a

    :goto_4
    if-gez v0, :cond_f

    invoke-virtual {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->close()V

    iput-object v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_currToken:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;

    move-object v0, v2

    goto :goto_1

    :cond_8
    if-ge v1, v6, :cond_9

    iput v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputPtr:I

    const-string v5, "string value"

    invoke-virtual {p0, v1, v5}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_throwUnquotedSpace(ILjava/lang/String;)V

    :cond_9
    move v1, v3

    goto :goto_2

    :cond_a
    invoke-direct {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_skipComment()V

    goto :goto_3

    :cond_b
    if-eq v0, v6, :cond_6

    const/16 v1, 0xa

    if-ne v0, v1, :cond_c

    invoke-direct {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_skipLF()V

    goto :goto_3

    :cond_c
    const/16 v1, 0xd

    if-ne v0, v1, :cond_d

    invoke-direct {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_skipCR()V

    goto :goto_3

    :cond_d
    const/16 v1, 0x9

    if-eq v0, v1, :cond_6

    invoke-virtual {p0, v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_throwInvalidSpace(I)V

    goto :goto_3

    :cond_e
    invoke-virtual {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_handleEOF()V

    const/4 v0, -0x1

    goto :goto_4

    :cond_f
    iget-wide v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_currInputProcessed:J

    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputPtr:I

    int-to-long v5, v1

    add-long/2addr v3, v5

    const-wide/16 v5, 0x1

    sub-long/2addr v3, v5

    iput-wide v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_tokenInputTotal:J

    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_currInputRow:I

    iput v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_tokenInputRow:I

    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_inputPtr:I

    iget v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_currInputRowStart:I

    sub-int/2addr v1, v3

    add-int/lit8 v1, v1, -0x1

    iput v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_tokenInputCol:I

    iput-object v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_binaryValue:[B

    const/16 v1, 0x5d

    if-ne v0, v1, :cond_11

    iget-object v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_parsingContext:Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonReadContext;

    invoke-virtual {v1}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonReadContext;->inArray()Z

    move-result v1

    if-nez v1, :cond_10

    const/16 v1, 0x7d

    invoke-virtual {p0, v0, v1}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_reportMismatchedEndMarker(IC)V

    :cond_10
    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_parsingContext:Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonReadContext;

    invoke-virtual {v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonReadContext;->getParent()Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonReadContext;

    move-result-object v0

    iput-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_parsingContext:Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonReadContext;

    sget-object v0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;->END_ARRAY:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;

    iput-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_currToken:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;

    goto/16 :goto_1

    :cond_11
    const/16 v1, 0x7d

    if-ne v0, v1, :cond_13

    iget-object v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_parsingContext:Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonReadContext;

    invoke-virtual {v1}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonReadContext;->inObject()Z

    move-result v1

    if-nez v1, :cond_12

    const/16 v1, 0x5d

    invoke-virtual {p0, v0, v1}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_reportMismatchedEndMarker(IC)V

    :cond_12
    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_parsingContext:Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonReadContext;

    invoke-virtual {v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonReadContext;->getParent()Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonReadContext;

    move-result-object v0

    iput-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_parsingContext:Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonReadContext;

    sget-object v0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;->END_OBJECT:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;

    iput-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_currToken:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;

    goto/16 :goto_1

    :cond_13
    iget-object v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_parsingContext:Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonReadContext;

    invoke-virtual {v1}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonReadContext;->expectComma()Z

    move-result v1

    if-eqz v1, :cond_15

    const/16 v1, 0x2c

    if-eq v0, v1, :cond_14

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "was expecting comma to separate "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_parsingContext:Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonReadContext;

    invoke-virtual {v2}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonReadContext;->getTypeDesc()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " entries"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v0, v1}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_reportUnexpectedChar(ILjava/lang/String;)V

    :cond_14
    invoke-direct {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_skipWS()I

    move-result v0

    :cond_15
    iget-object v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_parsingContext:Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonReadContext;

    invoke-virtual {v1}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonReadContext;->inObject()Z

    move-result v1

    if-eqz v1, :cond_17

    invoke-direct {p0, v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_parseFieldName(I)Ljava/lang/String;

    move-result-object v0

    iget-object v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_parsingContext:Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonReadContext;

    invoke-virtual {v2, v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonReadContext;->setCurrentName(Ljava/lang/String;)V

    sget-object v0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;->FIELD_NAME:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;

    iput-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_currToken:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;

    invoke-direct {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_skipWS()I

    move-result v0

    const/16 v2, 0x3a

    if-eq v0, v2, :cond_16

    const-string v2, "was expecting a colon to separate field name and value"

    invoke-virtual {p0, v0, v2}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_reportUnexpectedChar(ILjava/lang/String;)V

    :cond_16
    invoke-direct {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_skipWS()I

    move-result v0

    :cond_17
    sparse-switch v0, :sswitch_data_0

    invoke-direct {p0, v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_handleUnexpectedValue(I)Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;

    move-result-object v0

    :goto_5
    if-eqz v1, :cond_1a

    iput-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_nextToken:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_currToken:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;

    goto/16 :goto_1

    :sswitch_0
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_tokenIncomplete:Z

    sget-object v0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;->VALUE_STRING:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;

    goto :goto_5

    :sswitch_1
    if-nez v1, :cond_18

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_parsingContext:Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonReadContext;

    iget v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_tokenInputRow:I

    iget v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_tokenInputCol:I

    invoke-virtual {v0, v2, v3}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonReadContext;->createChildArrayContext(II)Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonReadContext;

    move-result-object v0

    iput-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_parsingContext:Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonReadContext;

    :cond_18
    sget-object v0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;->START_ARRAY:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;

    goto :goto_5

    :sswitch_2
    if-nez v1, :cond_19

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_parsingContext:Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonReadContext;

    iget v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_tokenInputRow:I

    iget v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_tokenInputCol:I

    invoke-virtual {v0, v2, v3}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonReadContext;->createChildObjectContext(II)Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonReadContext;

    move-result-object v0

    iput-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_parsingContext:Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonReadContext;

    :cond_19
    sget-object v0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;->START_OBJECT:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;

    goto :goto_5

    :sswitch_3
    const-string v2, "expected a value"

    invoke-virtual {p0, v0, v2}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_reportUnexpectedChar(ILjava/lang/String;)V

    :sswitch_4
    sget-object v0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;->VALUE_TRUE:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;

    invoke-direct {p0, v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_matchToken(Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;)V

    sget-object v0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;->VALUE_TRUE:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;

    goto :goto_5

    :sswitch_5
    sget-object v0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;->VALUE_FALSE:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;

    invoke-direct {p0, v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_matchToken(Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;)V

    sget-object v0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;->VALUE_FALSE:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;

    goto :goto_5

    :sswitch_6
    sget-object v0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;->VALUE_NULL:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;

    invoke-direct {p0, v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_matchToken(Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;)V

    sget-object v0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;->VALUE_NULL:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;

    goto :goto_5

    :sswitch_7
    invoke-virtual {p0, v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->parseNumberText(I)Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;

    move-result-object v0

    goto :goto_5

    :cond_1a
    iput-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ReaderBasedParser;->_currToken:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;

    goto/16 :goto_1

    nop

    :sswitch_data_0
    .sparse-switch
        0x22 -> :sswitch_0
        0x2d -> :sswitch_7
        0x30 -> :sswitch_7
        0x31 -> :sswitch_7
        0x32 -> :sswitch_7
        0x33 -> :sswitch_7
        0x34 -> :sswitch_7
        0x35 -> :sswitch_7
        0x36 -> :sswitch_7
        0x37 -> :sswitch_7
        0x38 -> :sswitch_7
        0x39 -> :sswitch_7
        0x5b -> :sswitch_1
        0x5d -> :sswitch_3
        0x66 -> :sswitch_5
        0x6e -> :sswitch_6
        0x74 -> :sswitch_4
        0x7b -> :sswitch_2
        0x7d -> :sswitch_3
    .end sparse-switch
.end method
