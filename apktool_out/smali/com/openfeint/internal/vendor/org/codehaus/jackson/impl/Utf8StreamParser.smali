.class public final Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;
.super Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8NumericParser;


# instance fields
.field protected _objectCodec:Lcom/openfeint/internal/vendor/org/codehaus/jackson/ObjectCodec;

.field protected _quadBuffer:[I

.field protected final _symbols:Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;


# direct methods
.method public constructor <init>(Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/IOContext;ILjava/io/InputStream;Lcom/openfeint/internal/vendor/org/codehaus/jackson/ObjectCodec;Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;[BIIZ)V
    .locals 8

    move-object v0, p0

    move-object v1, p1

    move v2, p2

    move-object v3, p3

    move-object v4, p6

    move v5, p7

    move/from16 v6, p8

    move/from16 v7, p9

    invoke-direct/range {v0 .. v7}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8NumericParser;-><init>(Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/IOContext;ILjava/io/InputStream;[BIIZ)V

    const/16 v0, 0x20

    new-array v0, v0, [I

    iput-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_quadBuffer:[I

    iput-object p4, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_objectCodec:Lcom/openfeint/internal/vendor/org/codehaus/jackson/ObjectCodec;

    iput-object p5, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_symbols:Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;

    sget-object v0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser$Feature;->CANONICALIZE_FIELD_NAMES:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser$Feature;

    invoke-virtual {v0, p2}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser$Feature;->enabledIn(I)Z

    move-result v0

    if-nez v0, :cond_0

    invoke-static {}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_throwInternal()V

    :cond_0
    return-void
.end method

.method private _decodeCharForError(I)I
    .locals 6
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParseException;
        }
    .end annotation

    const/4 v2, 0x2

    const/16 v5, 0x80

    const/4 v1, 0x1

    if-gez p1, :cond_3

    and-int/lit16 v0, p1, 0xe0

    const/16 v3, 0xc0

    if-ne v0, v3, :cond_4

    and-int/lit8 p1, p1, 0x1f

    move v0, v1

    :goto_0
    invoke-direct {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->nextByte()I

    move-result v3

    and-int/lit16 v4, v3, 0xc0

    if-eq v4, v5, :cond_0

    and-int/lit16 v4, v3, 0xff

    invoke-direct {p0, v4}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_reportInvalidOther(I)V

    :cond_0
    shl-int/lit8 v4, p1, 0x6

    and-int/lit8 v3, v3, 0x3f

    or-int p1, v4, v3

    if-le v0, v1, :cond_3

    invoke-direct {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->nextByte()I

    move-result v1

    and-int/lit16 v3, v1, 0xc0

    if-eq v3, v5, :cond_1

    and-int/lit16 v3, v1, 0xff

    invoke-direct {p0, v3}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_reportInvalidOther(I)V

    :cond_1
    shl-int/lit8 v3, p1, 0x6

    and-int/lit8 v1, v1, 0x3f

    or-int p1, v3, v1

    if-le v0, v2, :cond_3

    invoke-direct {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->nextByte()I

    move-result v0

    and-int/lit16 v1, v0, 0xc0

    if-eq v1, v5, :cond_2

    and-int/lit16 v1, v0, 0xff

    invoke-direct {p0, v1}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_reportInvalidOther(I)V

    :cond_2
    shl-int/lit8 v1, p1, 0x6

    and-int/lit8 v0, v0, 0x3f

    or-int p1, v1, v0

    :cond_3
    return p1

    :cond_4
    and-int/lit16 v0, p1, 0xf0

    const/16 v3, 0xe0

    if-ne v0, v3, :cond_5

    and-int/lit8 p1, p1, 0xf

    move v0, v2

    goto :goto_0

    :cond_5
    and-int/lit16 v0, p1, 0xf8

    const/16 v3, 0xf0

    if-ne v0, v3, :cond_6

    and-int/lit8 p1, p1, 0x7

    const/4 v0, 0x3

    goto :goto_0

    :cond_6
    and-int/lit16 v0, p1, 0xff

    invoke-direct {p0, v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_reportInvalidInitial(I)V

    move v0, v1

    goto :goto_0
.end method

.method private _decodeEscaped()C
    .locals 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParseException;
        }
    .end annotation

    const/4 v0, 0x0

    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    iget v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputEnd:I

    if-lt v1, v2, :cond_0

    invoke-virtual {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->loadMore()Z

    move-result v1

    if-nez v1, :cond_0

    const-string v1, " in character escape sequence"

    invoke-virtual {p0, v1}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_reportInvalidEOF(Ljava/lang/String;)V

    :cond_0
    iget-object v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputBuffer:[B

    iget v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    add-int/lit8 v3, v2, 0x1

    iput v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    aget-byte v1, v1, v2

    sparse-switch v1, :sswitch_data_0

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Unrecognized character escape (\\ followed by "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-direct {p0, v1}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_decodeCharForError(I)I

    move-result v1

    invoke-static {v1}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_getCharDesc(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ")"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v1}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_reportError(Ljava/lang/String;)V

    :sswitch_0
    move v1, v0

    :goto_0
    const/4 v2, 0x4

    if-ge v0, v2, :cond_3

    iget v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    iget v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputEnd:I

    if-lt v2, v3, :cond_1

    invoke-virtual {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->loadMore()Z

    move-result v2

    if-nez v2, :cond_1

    const-string v2, " in character escape sequence"

    invoke-virtual {p0, v2}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_reportInvalidEOF(Ljava/lang/String;)V

    :cond_1
    iget-object v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputBuffer:[B

    iget v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    add-int/lit8 v4, v3, 0x1

    iput v4, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    aget-byte v2, v2, v3

    invoke-static {v2}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/CharTypes;->charToHex(I)I

    move-result v3

    if-gez v3, :cond_2

    const-string v4, "expected a hex-digit for character escape sequence"

    invoke-virtual {p0, v2, v4}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_reportUnexpectedChar(ILjava/lang/String;)V

    :cond_2
    shl-int/lit8 v1, v1, 0x4

    or-int/2addr v1, v3

    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :sswitch_1
    const/16 v0, 0x8

    :goto_1
    return v0

    :sswitch_2
    const/16 v0, 0x9

    goto :goto_1

    :sswitch_3
    const/16 v0, 0xa

    goto :goto_1

    :sswitch_4
    const/16 v0, 0xc

    goto :goto_1

    :sswitch_5
    const/16 v0, 0xd

    goto :goto_1

    :sswitch_6
    int-to-char v0, v1

    goto :goto_1

    :cond_3
    int-to-char v0, v1

    goto :goto_1

    :sswitch_data_0
    .sparse-switch
        0x22 -> :sswitch_6
        0x2f -> :sswitch_6
        0x5c -> :sswitch_6
        0x62 -> :sswitch_1
        0x66 -> :sswitch_4
        0x6e -> :sswitch_3
        0x72 -> :sswitch_5
        0x74 -> :sswitch_2
        0x75 -> :sswitch_0
    .end sparse-switch
.end method

.method private final _decodeUtf8_2(I)I
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParseException;
        }
    .end annotation

    iget v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputEnd:I

    if-lt v0, v1, :cond_0

    invoke-virtual {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->loadMoreGuaranteed()V

    :cond_0
    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputBuffer:[B

    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    aget-byte v0, v0, v1

    and-int/lit16 v1, v0, 0xc0

    const/16 v2, 0x80

    if-eq v1, v2, :cond_1

    and-int/lit16 v1, v0, 0xff

    iget v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    invoke-direct {p0, v1, v2}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_reportInvalidOther(II)V

    :cond_1
    and-int/lit8 v1, p1, 0x1f

    shl-int/lit8 v1, v1, 0x6

    and-int/lit8 v0, v0, 0x3f

    or-int/2addr v0, v1

    return v0
.end method

.method private final _decodeUtf8_3(I)I
    .locals 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParseException;
        }
    .end annotation

    const/16 v4, 0x80

    iget v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputEnd:I

    if-lt v0, v1, :cond_0

    invoke-virtual {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->loadMoreGuaranteed()V

    :cond_0
    and-int/lit8 v0, p1, 0xf

    iget-object v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputBuffer:[B

    iget v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    add-int/lit8 v3, v2, 0x1

    iput v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    aget-byte v1, v1, v2

    and-int/lit16 v2, v1, 0xc0

    if-eq v2, v4, :cond_1

    and-int/lit16 v2, v1, 0xff

    iget v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    invoke-direct {p0, v2, v3}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_reportInvalidOther(II)V

    :cond_1
    shl-int/lit8 v0, v0, 0x6

    and-int/lit8 v1, v1, 0x3f

    or-int/2addr v0, v1

    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    iget v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputEnd:I

    if-lt v1, v2, :cond_2

    invoke-virtual {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->loadMoreGuaranteed()V

    :cond_2
    iget-object v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputBuffer:[B

    iget v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    add-int/lit8 v3, v2, 0x1

    iput v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    aget-byte v1, v1, v2

    and-int/lit16 v2, v1, 0xc0

    if-eq v2, v4, :cond_3

    and-int/lit16 v2, v1, 0xff

    iget v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    invoke-direct {p0, v2, v3}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_reportInvalidOther(II)V

    :cond_3
    shl-int/lit8 v0, v0, 0x6

    and-int/lit8 v1, v1, 0x3f

    or-int/2addr v0, v1

    return v0
.end method

.method private final _decodeUtf8_3fast(I)I
    .locals 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParseException;
        }
    .end annotation

    const/16 v4, 0x80

    and-int/lit8 v0, p1, 0xf

    iget-object v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputBuffer:[B

    iget v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    add-int/lit8 v3, v2, 0x1

    iput v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    aget-byte v1, v1, v2

    and-int/lit16 v2, v1, 0xc0

    if-eq v2, v4, :cond_0

    and-int/lit16 v2, v1, 0xff

    iget v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    invoke-direct {p0, v2, v3}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_reportInvalidOther(II)V

    :cond_0
    shl-int/lit8 v0, v0, 0x6

    and-int/lit8 v1, v1, 0x3f

    or-int/2addr v0, v1

    iget-object v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputBuffer:[B

    iget v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    add-int/lit8 v3, v2, 0x1

    iput v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    aget-byte v1, v1, v2

    and-int/lit16 v2, v1, 0xc0

    if-eq v2, v4, :cond_1

    and-int/lit16 v2, v1, 0xff

    iget v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    invoke-direct {p0, v2, v3}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_reportInvalidOther(II)V

    :cond_1
    shl-int/lit8 v0, v0, 0x6

    and-int/lit8 v1, v1, 0x3f

    or-int/2addr v0, v1

    return v0
.end method

.method private final _decodeUtf8_4(I)I
    .locals 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParseException;
        }
    .end annotation

    const/16 v4, 0x80

    iget v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputEnd:I

    if-lt v0, v1, :cond_0

    invoke-virtual {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->loadMoreGuaranteed()V

    :cond_0
    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputBuffer:[B

    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    aget-byte v0, v0, v1

    and-int/lit16 v1, v0, 0xc0

    if-eq v1, v4, :cond_1

    and-int/lit16 v1, v0, 0xff

    iget v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    invoke-direct {p0, v1, v2}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_reportInvalidOther(II)V

    :cond_1
    and-int/lit8 v1, p1, 0x7

    shl-int/lit8 v1, v1, 0x6

    and-int/lit8 v0, v0, 0x3f

    or-int/2addr v0, v1

    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    iget v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputEnd:I

    if-lt v1, v2, :cond_2

    invoke-virtual {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->loadMoreGuaranteed()V

    :cond_2
    iget-object v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputBuffer:[B

    iget v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    add-int/lit8 v3, v2, 0x1

    iput v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    aget-byte v1, v1, v2

    and-int/lit16 v2, v1, 0xc0

    if-eq v2, v4, :cond_3

    and-int/lit16 v2, v1, 0xff

    iget v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    invoke-direct {p0, v2, v3}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_reportInvalidOther(II)V

    :cond_3
    shl-int/lit8 v0, v0, 0x6

    and-int/lit8 v1, v1, 0x3f

    or-int/2addr v0, v1

    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    iget v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputEnd:I

    if-lt v1, v2, :cond_4

    invoke-virtual {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->loadMoreGuaranteed()V

    :cond_4
    iget-object v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputBuffer:[B

    iget v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    add-int/lit8 v3, v2, 0x1

    iput v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    aget-byte v1, v1, v2

    and-int/lit16 v2, v1, 0xc0

    if-eq v2, v4, :cond_5

    and-int/lit16 v2, v1, 0xff

    iget v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    invoke-direct {p0, v2, v3}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_reportInvalidOther(II)V

    :cond_5
    shl-int/lit8 v0, v0, 0x6

    and-int/lit8 v1, v1, 0x3f

    or-int/2addr v0, v1

    const/high16 v1, 0x10000

    sub-int/2addr v0, v1

    return v0
.end method

.method private _handleUnexpectedValue(I)Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;
    .locals 10
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParseException;
        }
    .end annotation

    const/16 v9, 0x27

    const/4 v2, 0x0

    if-ne p1, v9, :cond_0

    sget-object v0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser$Feature;->ALLOW_SINGLE_QUOTES:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser$Feature;

    invoke-virtual {p0, v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->isEnabled(Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser$Feature;)Z

    move-result v0

    if-nez v0, :cond_1

    :cond_0
    const-string v0, "expected a valid value (number, String, array, object, \'true\', \'false\' or \'null\')"

    invoke-virtual {p0, p1, v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_reportUnexpectedChar(ILjava/lang/String;)V

    :cond_1
    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_textBuffer:Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/TextBuffer;

    invoke-virtual {v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/TextBuffer;->emptyAndGetCurrentSegment()[C

    move-result-object v0

    invoke-static {}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/CharTypes;->getInputCodeUtf8()[I

    move-result-object v6

    iget-object v7, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputBuffer:[B

    move v1, v2

    :cond_2
    :goto_0
    iget v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    iget v4, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputEnd:I

    if-lt v3, v4, :cond_3

    invoke-virtual {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->loadMoreGuaranteed()V

    :cond_3
    array-length v3, v0

    if-lt v1, v3, :cond_4

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_textBuffer:Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/TextBuffer;

    invoke-virtual {v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/TextBuffer;->finishCurrentSegment()[C

    move-result-object v0

    move v1, v2

    :cond_4
    iget v4, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputEnd:I

    iget v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    array-length v5, v0

    sub-int/2addr v5, v1

    add-int/2addr v3, v5

    if-ge v3, v4, :cond_c

    :goto_1
    iget v4, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    if-ge v4, v3, :cond_2

    iget v4, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    add-int/lit8 v5, v4, 0x1

    iput v5, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    aget-byte v4, v7, v4

    and-int/lit16 v5, v4, 0xff

    if-eq v5, v9, :cond_5

    aget v4, v6, v5

    if-nez v4, :cond_5

    add-int/lit8 v4, v1, 0x1

    int-to-char v5, v5

    aput-char v5, v0, v1

    move v1, v4

    goto :goto_1

    :cond_5
    if-eq v5, v9, :cond_9

    aget v3, v6, v5

    packed-switch v3, :pswitch_data_0

    const/16 v3, 0x20

    if-ge v5, v3, :cond_6

    const-string v3, "string value"

    invoke-virtual {p0, v5, v3}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_throwUnquotedSpace(ILjava/lang/String;)V

    :cond_6
    invoke-direct {p0, v5}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_reportInvalidChar(I)V

    :cond_7
    move v3, v5

    :goto_2
    array-length v4, v0

    if-lt v1, v4, :cond_a

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_textBuffer:Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/TextBuffer;

    invoke-virtual {v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/TextBuffer;->finishCurrentSegment()[C

    move-result-object v0

    move v4, v2

    :goto_3
    add-int/lit8 v1, v4, 0x1

    int-to-char v3, v3

    aput-char v3, v0, v4

    goto :goto_0

    :pswitch_0
    const/16 v3, 0x22

    if-eq v5, v3, :cond_7

    invoke-direct {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_decodeEscaped()C

    move-result v3

    goto :goto_2

    :pswitch_1
    invoke-direct {p0, v5}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_decodeUtf8_2(I)I

    move-result v3

    goto :goto_2

    :pswitch_2
    iget v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputEnd:I

    iget v4, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    sub-int/2addr v3, v4

    const/4 v4, 0x2

    if-lt v3, v4, :cond_8

    invoke-direct {p0, v5}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_decodeUtf8_3fast(I)I

    move-result v3

    goto :goto_2

    :cond_8
    invoke-direct {p0, v5}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_decodeUtf8_3(I)I

    move-result v3

    goto :goto_2

    :pswitch_3
    invoke-direct {p0, v5}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_decodeUtf8_4(I)I

    move-result v4

    add-int/lit8 v3, v1, 0x1

    const v5, 0xd800

    shr-int/lit8 v8, v4, 0xa

    or-int/2addr v5, v8

    int-to-char v5, v5

    aput-char v5, v0, v1

    array-length v1, v0

    if-lt v3, v1, :cond_b

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_textBuffer:Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/TextBuffer;

    invoke-virtual {v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/TextBuffer;->finishCurrentSegment()[C

    move-result-object v0

    move v1, v2

    :goto_4
    const v3, 0xdc00

    and-int/lit16 v4, v4, 0x3ff

    or-int/2addr v3, v4

    goto :goto_2

    :cond_9
    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_textBuffer:Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/TextBuffer;

    invoke-virtual {v0, v1}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/TextBuffer;->setCurrentLength(I)V

    sget-object v0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;->VALUE_STRING:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;

    return-object v0

    :cond_a
    move v4, v1

    goto :goto_3

    :cond_b
    move v1, v3

    goto :goto_4

    :cond_c
    move v3, v4

    goto/16 :goto_1

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_0
        :pswitch_1
        :pswitch_2
        :pswitch_3
    .end packed-switch
.end method

.method private _handleUnusualFieldName(I)Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/Name;
    .locals 13
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParseException;
        }
    .end annotation

    const/4 v5, 0x1

    const/16 v11, 0x27

    const/4 v10, 0x4

    const/4 v1, 0x0

    if-ne p1, v11, :cond_b

    sget-object v0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser$Feature;->ALLOW_SINGLE_QUOTES:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser$Feature;

    invoke-virtual {p0, v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->isEnabled(Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser$Feature;)Z

    move-result v0

    if-eqz v0, :cond_b

    iget v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    iget v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputEnd:I

    if-lt v0, v2, :cond_0

    invoke-virtual {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->loadMore()Z

    move-result v0

    if-nez v0, :cond_0

    const-string v0, ": was expecting closing \'\'\' for name"

    invoke-virtual {p0, v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_reportInvalidEOF(Ljava/lang/String;)V

    :cond_0
    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputBuffer:[B

    iget v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    add-int/lit8 v3, v2, 0x1

    iput v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    aget-byte v0, v0, v2

    and-int/lit16 v6, v0, 0xff

    if-ne v6, v11, :cond_1

    invoke-static {}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->getEmptyName()Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/Name;

    move-result-object v0

    :goto_0
    return-object v0

    :cond_1
    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_quadBuffer:[I

    invoke-static {}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/CharTypes;->getInputCodeLatin1()[I

    move-result-object v7

    move v3, v1

    move v4, v1

    move v2, v1

    :goto_1
    if-eq v6, v11, :cond_9

    const/16 v8, 0x22

    if-eq v6, v8, :cond_19

    aget v8, v7, v6

    if-eqz v8, :cond_19

    const/16 v8, 0x5c

    if-eq v6, v8, :cond_4

    const-string v8, "name"

    invoke-virtual {p0, v6, v8}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_throwUnquotedSpace(ILjava/lang/String;)V

    :goto_2
    const/16 v8, 0x7f

    if-le v6, v8, :cond_19

    if-lt v3, v10, :cond_18

    array-length v3, v0

    if-lt v2, v3, :cond_2

    array-length v3, v0

    invoke-static {v0, v3}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->growArrayBy([II)[I

    move-result-object v0

    iput-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_quadBuffer:[I

    :cond_2
    add-int/lit8 v3, v2, 0x1

    aput v4, v0, v2

    move v2, v1

    move v4, v3

    move v3, v1

    :goto_3
    const/16 v8, 0x800

    if-ge v6, v8, :cond_5

    shl-int/lit8 v3, v3, 0x8

    shr-int/lit8 v8, v6, 0x6

    or-int/lit16 v8, v8, 0xc0

    or-int/2addr v3, v8

    add-int/lit8 v2, v2, 0x1

    move v12, v2

    move v2, v3

    move-object v3, v0

    move v0, v12

    :goto_4
    and-int/lit8 v6, v6, 0x3f

    or-int/lit16 v6, v6, 0x80

    move v12, v0

    move-object v0, v3

    move v3, v6

    move v6, v2

    move v2, v12

    :goto_5
    if-ge v2, v10, :cond_7

    add-int/lit8 v2, v2, 0x1

    shl-int/lit8 v6, v6, 0x8

    or-int/2addr v3, v6

    move v12, v2

    move v2, v3

    move v3, v4

    move-object v4, v0

    move v0, v12

    :goto_6
    iget v6, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    iget v8, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputEnd:I

    if-lt v6, v8, :cond_3

    invoke-virtual {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->loadMore()Z

    move-result v6

    if-nez v6, :cond_3

    const-string v6, " in field name"

    invoke-virtual {p0, v6}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_reportInvalidEOF(Ljava/lang/String;)V

    :cond_3
    iget-object v6, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputBuffer:[B

    iget v8, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    add-int/lit8 v9, v8, 0x1

    iput v9, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    aget-byte v6, v6, v8

    and-int/lit16 v6, v6, 0xff

    move v12, v0

    move-object v0, v4

    move v4, v2

    move v2, v3

    move v3, v12

    goto :goto_1

    :cond_4
    invoke-direct {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_decodeEscaped()C

    move-result v6

    goto :goto_2

    :cond_5
    shl-int/lit8 v3, v3, 0x8

    shr-int/lit8 v8, v6, 0xc

    or-int/lit16 v8, v8, 0xe0

    or-int/2addr v3, v8

    add-int/lit8 v2, v2, 0x1

    if-lt v2, v10, :cond_17

    array-length v2, v0

    if-lt v4, v2, :cond_6

    array-length v2, v0

    invoke-static {v0, v2}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->growArrayBy([II)[I

    move-result-object v0

    iput-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_quadBuffer:[I

    :cond_6
    add-int/lit8 v2, v4, 0x1

    aput v3, v0, v4

    move v3, v2

    move-object v4, v0

    move v0, v1

    move v2, v1

    :goto_7
    shl-int/lit8 v2, v2, 0x8

    shr-int/lit8 v8, v6, 0x6

    and-int/lit8 v8, v8, 0x3f

    or-int/lit16 v8, v8, 0x80

    or-int/2addr v2, v8

    add-int/lit8 v0, v0, 0x1

    move v12, v3

    move-object v3, v4

    move v4, v12

    goto :goto_4

    :cond_7
    array-length v2, v0

    if-lt v4, v2, :cond_8

    array-length v2, v0

    invoke-static {v0, v2}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->growArrayBy([II)[I

    move-result-object v0

    iput-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_quadBuffer:[I

    :cond_8
    add-int/lit8 v2, v4, 0x1

    aput v6, v0, v4

    move-object v4, v0

    move v0, v5

    move v12, v2

    move v2, v3

    move v3, v12

    goto :goto_6

    :cond_9
    if-lez v3, :cond_16

    array-length v1, v0

    if-lt v2, v1, :cond_a

    array-length v1, v0

    invoke-static {v0, v1}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->growArrayBy([II)[I

    move-result-object v0

    iput-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_quadBuffer:[I

    :cond_a
    add-int/lit8 v1, v2, 0x1

    aput v4, v0, v2

    move v12, v1

    move-object v1, v0

    move v0, v12

    :goto_8
    iget-object v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_symbols:Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;

    invoke-virtual {v2, v1, v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->findName([II)Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/Name;

    move-result-object v2

    if-nez v2, :cond_15

    invoke-direct {p0, v1, v0, v3}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->addName([III)Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/Name;

    move-result-object v0

    goto/16 :goto_0

    :cond_b
    sget-object v0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser$Feature;->ALLOW_UNQUOTED_FIELD_NAMES:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser$Feature;

    invoke-virtual {p0, v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->isEnabled(Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser$Feature;)Z

    move-result v0

    if-nez v0, :cond_c

    const-string v0, "was expecting double-quote to start field name"

    invoke-virtual {p0, p1, v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_reportUnexpectedChar(ILjava/lang/String;)V

    :cond_c
    invoke-static {}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/CharTypes;->getInputCodeUtf8JsNames()[I

    move-result-object v6

    aget v0, v6, p1

    if-eqz v0, :cond_d

    const-string v0, "was expecting either valid name character (for unquoted name) or double-quote (for quoted) to start field name"

    invoke-virtual {p0, p1, v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_reportUnexpectedChar(ILjava/lang/String;)V

    :cond_d
    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_quadBuffer:[I

    move v4, v1

    move v3, v1

    move v2, p1

    :goto_9
    if-ge v1, v10, :cond_f

    add-int/lit8 v1, v1, 0x1

    shl-int/lit8 v4, v4, 0x8

    or-int/2addr v2, v4

    move v12, v1

    move v1, v2

    move v2, v3

    move-object v3, v0

    move v0, v12

    :goto_a
    iget v4, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    iget v7, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputEnd:I

    if-lt v4, v7, :cond_e

    invoke-virtual {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->loadMore()Z

    move-result v4

    if-nez v4, :cond_e

    const-string v4, " in field name"

    invoke-virtual {p0, v4}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_reportInvalidEOF(Ljava/lang/String;)V

    :cond_e
    iget-object v4, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputBuffer:[B

    iget v7, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    aget-byte v4, v4, v7

    and-int/lit16 p1, v4, 0xff

    aget v4, v6, p1

    if-nez v4, :cond_11

    iget v4, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    add-int/lit8 v4, v4, 0x1

    iput v4, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    move v4, v1

    move v1, v0

    move-object v0, v3

    move v3, v2

    move v2, p1

    goto :goto_9

    :cond_f
    array-length v1, v0

    if-lt v3, v1, :cond_10

    array-length v1, v0

    invoke-static {v0, v1}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->growArrayBy([II)[I

    move-result-object v0

    iput-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_quadBuffer:[I

    :cond_10
    add-int/lit8 v1, v3, 0x1

    aput v4, v0, v3

    move-object v3, v0

    move v0, v5

    move v12, v1

    move v1, v2

    move v2, v12

    goto :goto_a

    :cond_11
    if-lez v0, :cond_13

    array-length v4, v3

    if-lt v2, v4, :cond_12

    array-length v4, v3

    invoke-static {v3, v4}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->growArrayBy([II)[I

    move-result-object v3

    iput-object v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_quadBuffer:[I

    :cond_12
    add-int/lit8 v4, v2, 0x1

    aput v1, v3, v2

    move v2, v4

    :cond_13
    iget-object v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_symbols:Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;

    invoke-virtual {v1, v3, v2}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->findName([II)Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/Name;

    move-result-object v1

    if-nez v1, :cond_14

    invoke-direct {p0, v3, v2, v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->addName([III)Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/Name;

    move-result-object v0

    goto/16 :goto_0

    :cond_14
    move-object v0, v1

    goto/16 :goto_0

    :cond_15
    move-object v0, v2

    goto/16 :goto_0

    :cond_16
    move-object v1, v0

    move v0, v2

    goto/16 :goto_8

    :cond_17
    move v12, v2

    move v2, v3

    move v3, v4

    move-object v4, v0

    move v0, v12

    goto/16 :goto_7

    :cond_18
    move v12, v3

    move v3, v4

    move v4, v2

    move v2, v12

    goto/16 :goto_3

    :cond_19
    move v12, v3

    move v3, v6

    move v6, v4

    move v4, v2

    move v2, v12

    goto/16 :goto_5
.end method

.method private _matchToken(Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;)V
    .locals 7
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParseException;
        }
    .end annotation

    invoke-virtual {p1}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;->asByteArray()[B

    move-result-object v1

    const/4 v0, 0x1

    array-length v2, v1

    :goto_0
    if-ge v0, v2, :cond_4

    iget v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    iget v4, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputEnd:I

    if-lt v3, v4, :cond_0

    invoke-virtual {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->loadMoreGuaranteed()V

    :cond_0
    aget-byte v3, v1, v0

    iget-object v4, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputBuffer:[B

    iget v5, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    aget-byte v4, v4, v5

    if-eq v3, v4, :cond_3

    invoke-virtual {p1}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;->asString()Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x0

    invoke-virtual {v3, v4, v0}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v3

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    :goto_1
    iget v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    iget v5, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputEnd:I

    if-lt v3, v5, :cond_1

    invoke-virtual {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->loadMore()Z

    move-result v3

    if-eqz v3, :cond_2

    :cond_1
    iget-object v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputBuffer:[B

    iget v5, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    add-int/lit8 v6, v5, 0x1

    iput v6, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    aget-byte v3, v3, v5

    invoke-direct {p0, v3}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_decodeCharForError(I)I

    move-result v3

    int-to-char v3, v3

    invoke-static {v3}, Ljava/lang/Character;->isJavaIdentifierPart(C)Z

    move-result v5

    if-eqz v5, :cond_2

    iget v5, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    add-int/lit8 v5, v5, 0x1

    iput v5, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

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

    invoke-virtual {p0, v3}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_reportError(Ljava/lang/String;)V

    :cond_3
    iget v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    add-int/lit8 v3, v3, 0x1

    iput v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_4
    return-void
.end method

.method private _reportInvalidChar(I)V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParseException;
        }
    .end annotation

    const/16 v0, 0x20

    if-ge p1, v0, :cond_0

    invoke-virtual {p0, p1}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_throwInvalidSpace(I)V

    :cond_0
    invoke-direct {p0, p1}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_reportInvalidInitial(I)V

    return-void
.end method

.method private _reportInvalidInitial(I)V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParseException;
        }
    .end annotation

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Invalid UTF-8 start byte 0x"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-static {p1}, Ljava/lang/Integer;->toHexString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_reportError(Ljava/lang/String;)V

    return-void
.end method

.method private _reportInvalidOther(I)V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParseException;
        }
    .end annotation

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Invalid UTF-8 middle byte 0x"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-static {p1}, Ljava/lang/Integer;->toHexString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_reportError(Ljava/lang/String;)V

    return-void
.end method

.method private _reportInvalidOther(II)V
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParseException;
        }
    .end annotation

    iput p2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    invoke-direct {p0, p1}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_reportInvalidOther(I)V

    return-void
.end method

.method private _skipCR()V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    iget v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputEnd:I

    if-lt v0, v1, :cond_0

    invoke-virtual {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->loadMore()Z

    move-result v0

    if-eqz v0, :cond_1

    :cond_0
    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputBuffer:[B

    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    aget-byte v0, v0, v1

    const/16 v1, 0xa

    if-ne v0, v1, :cond_1

    iget v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    :cond_1
    iget v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_currInputRow:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_currInputRow:I

    iget v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    iput v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_currInputRowStart:I

    return-void
.end method

.method private final _skipComment()V
    .locals 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParseException;
        }
    .end annotation

    const/16 v4, 0x2f

    sget-object v0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser$Feature;->ALLOW_COMMENTS:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser$Feature;

    invoke-virtual {p0, v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->isEnabled(Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser$Feature;)Z

    move-result v0

    if-nez v0, :cond_0

    const-string v0, "maybe a (non-standard) comment? (not recognized as one since Feature \'ALLOW_COMMENTS\' not enabled for parser)"

    invoke-virtual {p0, v4, v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_reportUnexpectedChar(ILjava/lang/String;)V

    :cond_0
    iget v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputEnd:I

    if-lt v0, v1, :cond_1

    invoke-virtual {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->loadMore()Z

    move-result v0

    if-nez v0, :cond_1

    const-string v0, " in a comment"

    invoke-virtual {p0, v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_reportInvalidEOF(Ljava/lang/String;)V

    :cond_1
    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputBuffer:[B

    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    aget-byte v0, v0, v1

    and-int/lit16 v0, v0, 0xff

    if-ne v0, v4, :cond_5

    invoke-static {}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/CharTypes;->getInputCodeComment()[I

    move-result-object v0

    :cond_2
    :goto_0
    :sswitch_0
    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    iget v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputEnd:I

    if-lt v1, v2, :cond_3

    invoke-virtual {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->loadMore()Z

    move-result v1

    if-eqz v1, :cond_4

    :cond_3
    iget-object v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputBuffer:[B

    iget v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    add-int/lit8 v3, v2, 0x1

    iput v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    aget-byte v1, v1, v2

    and-int/lit16 v1, v1, 0xff

    aget v2, v0, v1

    if-eqz v2, :cond_2

    sparse-switch v2, :sswitch_data_0

    invoke-direct {p0, v1}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_reportInvalidChar(I)V

    goto :goto_0

    :sswitch_1
    invoke-direct {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_skipLF()V

    :cond_4
    :goto_1
    return-void

    :sswitch_2
    invoke-direct {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_skipCR()V

    goto :goto_1

    :cond_5
    const/16 v1, 0x2a

    if-ne v0, v1, :cond_9

    invoke-static {}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/CharTypes;->getInputCodeComment()[I

    move-result-object v0

    :cond_6
    :goto_2
    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    iget v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputEnd:I

    if-lt v1, v2, :cond_7

    invoke-virtual {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->loadMore()Z

    move-result v1

    if-eqz v1, :cond_8

    :cond_7
    iget-object v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputBuffer:[B

    iget v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    add-int/lit8 v3, v2, 0x1

    iput v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    aget-byte v1, v1, v2

    and-int/lit16 v1, v1, 0xff

    aget v2, v0, v1

    if-eqz v2, :cond_6

    sparse-switch v2, :sswitch_data_1

    invoke-direct {p0, v1}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_reportInvalidChar(I)V

    goto :goto_2

    :sswitch_3
    iget-object v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputBuffer:[B

    iget v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    aget-byte v1, v1, v2

    if-ne v1, v4, :cond_6

    iget v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    goto :goto_1

    :sswitch_4
    invoke-direct {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_skipLF()V

    goto :goto_2

    :sswitch_5
    invoke-direct {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_skipCR()V

    goto :goto_2

    :cond_8
    const-string v0, " in a comment"

    invoke-virtual {p0, v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_reportInvalidEOF(Ljava/lang/String;)V

    goto :goto_1

    :cond_9
    const-string v1, "was expecting either \'*\' or \'/\' for a comment"

    invoke-virtual {p0, v0, v1}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_reportUnexpectedChar(ILjava/lang/String;)V

    goto :goto_1

    nop

    :sswitch_data_0
    .sparse-switch
        0xa -> :sswitch_1
        0xd -> :sswitch_2
        0x2a -> :sswitch_0
    .end sparse-switch

    :sswitch_data_1
    .sparse-switch
        0xa -> :sswitch_4
        0xd -> :sswitch_5
        0x2a -> :sswitch_3
    .end sparse-switch
.end method

.method private _skipLF()V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    iget v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_currInputRow:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_currInputRow:I

    iget v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    iput v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_currInputRowStart:I

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
    iget v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputEnd:I

    if-lt v0, v1, :cond_1

    invoke-virtual {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->loadMore()Z

    move-result v0

    if-eqz v0, :cond_6

    :cond_1
    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputBuffer:[B

    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    aget-byte v0, v0, v1

    and-int/lit16 v0, v0, 0xff

    if-le v0, v3, :cond_3

    const/16 v1, 0x2f

    if-eq v0, v1, :cond_2

    return v0

    :cond_2
    invoke-direct {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_skipComment()V

    goto :goto_0

    :cond_3
    if-eq v0, v3, :cond_0

    const/16 v1, 0xa

    if-ne v0, v1, :cond_4

    invoke-direct {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_skipLF()V

    goto :goto_0

    :cond_4
    const/16 v1, 0xd

    if-ne v0, v1, :cond_5

    invoke-direct {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_skipCR()V

    goto :goto_0

    :cond_5
    const/16 v1, 0x9

    if-eq v0, v1, :cond_0

    invoke-virtual {p0, v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_throwInvalidSpace(I)V

    goto :goto_0

    :cond_6
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Unexpected end-of-input within/between "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_parsingContext:Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonReadContext;

    invoke-virtual {v1}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonReadContext;->getTypeDesc()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " entries"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_constructError(Ljava/lang/String;)Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParseException;

    move-result-object v0

    throw v0
.end method

.method private final addName([III)Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/Name;
    .locals 11
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParseException;
        }
    .end annotation

    shl-int/lit8 v0, p2, 0x2

    add-int/lit8 v0, v0, -0x4

    add-int v6, v0, p3

    const/4 v0, 0x4

    if-ge p3, v0, :cond_7

    add-int/lit8 v0, p2, -0x1

    aget v0, p1, v0

    add-int/lit8 v1, p2, -0x1

    rsub-int/lit8 v2, p3, 0x4

    shl-int/lit8 v2, v2, 0x3

    shl-int v2, v0, v2

    aput v2, p1, v1

    :goto_0
    iget-object v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_textBuffer:Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/TextBuffer;

    invoke-virtual {v1}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/TextBuffer;->emptyAndGetCurrentSegment()[C

    move-result-object v1

    const/4 v5, 0x0

    const/4 v2, 0x0

    move v3, v2

    :goto_1
    if-ge v3, v6, :cond_b

    shr-int/lit8 v2, v3, 0x2

    aget v2, p1, v2

    and-int/lit8 v4, v3, 0x3

    rsub-int/lit8 v4, v4, 0x3

    shl-int/lit8 v4, v4, 0x3

    shr-int/2addr v2, v4

    and-int/lit16 v2, v2, 0xff

    add-int/lit8 v3, v3, 0x1

    const/16 v4, 0x7f

    if-le v2, v4, :cond_d

    and-int/lit16 v4, v2, 0xe0

    const/16 v7, 0xc0

    if-ne v4, v7, :cond_8

    and-int/lit8 v4, v2, 0x1f

    const/4 v2, 0x1

    move v10, v2

    move v2, v4

    move v4, v10

    :goto_2
    add-int v7, v3, v4

    if-le v7, v6, :cond_0

    const-string v7, " in field name"

    invoke-virtual {p0, v7}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_reportInvalidEOF(Ljava/lang/String;)V

    :cond_0
    shr-int/lit8 v7, v3, 0x2

    aget v7, p1, v7

    and-int/lit8 v8, v3, 0x3

    rsub-int/lit8 v8, v8, 0x3

    shl-int/lit8 v8, v8, 0x3

    shr-int/2addr v7, v8

    add-int/lit8 v3, v3, 0x1

    and-int/lit16 v8, v7, 0xc0

    const/16 v9, 0x80

    if-eq v8, v9, :cond_1

    invoke-direct {p0, v7}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_reportInvalidOther(I)V

    :cond_1
    shl-int/lit8 v2, v2, 0x6

    and-int/lit8 v7, v7, 0x3f

    or-int/2addr v2, v7

    const/4 v7, 0x1

    if-le v4, v7, :cond_4

    shr-int/lit8 v7, v3, 0x2

    aget v7, p1, v7

    and-int/lit8 v8, v3, 0x3

    rsub-int/lit8 v8, v8, 0x3

    shl-int/lit8 v8, v8, 0x3

    shr-int/2addr v7, v8

    add-int/lit8 v3, v3, 0x1

    and-int/lit16 v8, v7, 0xc0

    const/16 v9, 0x80

    if-eq v8, v9, :cond_2

    invoke-direct {p0, v7}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_reportInvalidOther(I)V

    :cond_2
    shl-int/lit8 v2, v2, 0x6

    and-int/lit8 v7, v7, 0x3f

    or-int/2addr v2, v7

    const/4 v7, 0x2

    if-le v4, v7, :cond_4

    shr-int/lit8 v7, v3, 0x2

    aget v7, p1, v7

    and-int/lit8 v8, v3, 0x3

    rsub-int/lit8 v8, v8, 0x3

    shl-int/lit8 v8, v8, 0x3

    shr-int/2addr v7, v8

    add-int/lit8 v3, v3, 0x1

    and-int/lit16 v8, v7, 0xc0

    const/16 v9, 0x80

    if-eq v8, v9, :cond_3

    and-int/lit16 v8, v7, 0xff

    invoke-direct {p0, v8}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_reportInvalidOther(I)V

    :cond_3
    shl-int/lit8 v2, v2, 0x6

    and-int/lit8 v7, v7, 0x3f

    or-int/2addr v2, v7

    :cond_4
    const/4 v7, 0x2

    if-le v4, v7, :cond_d

    const/high16 v4, 0x10000

    sub-int/2addr v2, v4

    array-length v4, v1

    if-lt v5, v4, :cond_5

    iget-object v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_textBuffer:Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/TextBuffer;

    invoke-virtual {v1}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/TextBuffer;->expandCurrentSegment()[C

    move-result-object v1

    :cond_5
    add-int/lit8 v4, v5, 0x1

    const v7, 0xd800

    shr-int/lit8 v8, v2, 0xa

    add-int/2addr v7, v8

    int-to-char v7, v7

    aput-char v7, v1, v5

    const v5, 0xdc00

    and-int/lit16 v2, v2, 0x3ff

    or-int/2addr v2, v5

    move v10, v2

    move v2, v3

    move v3, v4

    move-object v4, v1

    move v1, v10

    :goto_3
    array-length v5, v4

    if-lt v3, v5, :cond_6

    iget-object v4, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_textBuffer:Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/TextBuffer;

    invoke-virtual {v4}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/TextBuffer;->expandCurrentSegment()[C

    move-result-object v4

    :cond_6
    add-int/lit8 v5, v3, 0x1

    int-to-char v1, v1

    aput-char v1, v4, v3

    move v3, v2

    move-object v1, v4

    goto/16 :goto_1

    :cond_7
    const/4 v0, 0x0

    goto/16 :goto_0

    :cond_8
    and-int/lit16 v4, v2, 0xf0

    const/16 v7, 0xe0

    if-ne v4, v7, :cond_9

    and-int/lit8 v4, v2, 0xf

    const/4 v2, 0x2

    move v10, v2

    move v2, v4

    move v4, v10

    goto/16 :goto_2

    :cond_9
    and-int/lit16 v4, v2, 0xf8

    const/16 v7, 0xf0

    if-ne v4, v7, :cond_a

    and-int/lit8 v4, v2, 0x7

    const/4 v2, 0x3

    move v10, v2

    move v2, v4

    move v4, v10

    goto/16 :goto_2

    :cond_a
    invoke-direct {p0, v2}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_reportInvalidInitial(I)V

    const/4 v2, 0x1

    move v4, v2

    goto/16 :goto_2

    :cond_b
    new-instance v2, Ljava/lang/String;

    const/4 v3, 0x0

    invoke-direct {v2, v1, v3, v5}, Ljava/lang/String;-><init>([CII)V

    const/4 v1, 0x4

    if-ge p3, v1, :cond_c

    add-int/lit8 v1, p2, -0x1

    aput v0, p1, v1

    :cond_c
    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_symbols:Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;

    invoke-virtual {v0, v2, p1, p2}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->addName(Ljava/lang/String;[II)Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/Name;

    move-result-object v0

    return-object v0

    :cond_d
    move-object v4, v1

    move v1, v2

    move v2, v3

    move v3, v5

    goto :goto_3
.end method

.method private final findName(II)Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/Name;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParseException;
        }
    .end annotation

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_symbols:Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;

    invoke-virtual {v0, p1}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->findName(I)Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/Name;

    move-result-object v0

    if-eqz v0, :cond_0

    :goto_0
    return-object v0

    :cond_0
    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_quadBuffer:[I

    const/4 v1, 0x0

    aput p1, v0, v1

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_quadBuffer:[I

    const/4 v1, 0x1

    invoke-direct {p0, v0, v1, p2}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->addName([III)Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/Name;

    move-result-object v0

    goto :goto_0
.end method

.method private final findName(III)Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/Name;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParseException;
        }
    .end annotation

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_symbols:Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;

    invoke-virtual {v0, p1, p2}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->findName(II)Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/Name;

    move-result-object v0

    if-eqz v0, :cond_0

    :goto_0
    return-object v0

    :cond_0
    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_quadBuffer:[I

    const/4 v1, 0x0

    aput p1, v0, v1

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_quadBuffer:[I

    const/4 v1, 0x1

    aput p2, v0, v1

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_quadBuffer:[I

    const/4 v1, 0x2

    invoke-direct {p0, v0, v1, p3}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->addName([III)Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/Name;

    move-result-object v0

    goto :goto_0
.end method

.method private final findName([IIII)Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/Name;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParseException;
        }
    .end annotation

    array-length v0, p1

    if-lt p2, v0, :cond_0

    array-length v0, p1

    invoke-static {p1, v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->growArrayBy([II)[I

    move-result-object p1

    iput-object p1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_quadBuffer:[I

    :cond_0
    add-int/lit8 v1, p2, 0x1

    aput p3, p1, p2

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_symbols:Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;

    invoke-virtual {v0, p1, v1}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->findName([II)Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/Name;

    move-result-object v0

    if-nez v0, :cond_1

    invoke-direct {p0, p1, v1, p4}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->addName([III)Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/Name;

    move-result-object v0

    :cond_1
    return-object v0
.end method

.method private static growArrayBy([II)[I
    .locals 3

    const/4 v2, 0x0

    if-nez p0, :cond_0

    new-array v0, p1, [I

    :goto_0
    return-object v0

    :cond_0
    array-length v1, p0

    add-int v0, v1, p1

    new-array v0, v0, [I

    invoke-static {p0, v2, v0, v2, v1}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    goto :goto_0
.end method

.method private nextByte()I
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParseException;
        }
    .end annotation

    iget v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputEnd:I

    if-lt v0, v1, :cond_0

    invoke-virtual {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->loadMoreGuaranteed()V

    :cond_0
    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputBuffer:[B

    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    aget-byte v0, v0, v1

    and-int/lit16 v0, v0, 0xff

    return v0
.end method

.method private parseEscapedFieldName([IIIII)Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/Name;
    .locals 9
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParseException;
        }
    .end annotation

    const/4 v7, 0x4

    const/4 v1, 0x0

    invoke-static {}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/CharTypes;->getInputCodeLatin1()[I

    move-result-object v5

    :goto_0
    aget v0, v5, p4

    if-eqz v0, :cond_d

    const/16 v0, 0x22

    if-eq p4, v0, :cond_7

    const/16 v0, 0x5c

    if-eq p4, v0, :cond_2

    const-string v0, "name"

    invoke-virtual {p0, p4, v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_throwUnquotedSpace(ILjava/lang/String;)V

    :goto_1
    const/16 v0, 0x7f

    if-le p4, v0, :cond_d

    if-lt p5, v7, :cond_c

    array-length v0, p1

    if-lt p2, v0, :cond_0

    array-length v0, p1

    invoke-static {p1, v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->growArrayBy([II)[I

    move-result-object p1

    iput-object p1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_quadBuffer:[I

    :cond_0
    add-int/lit8 v4, p2, 0x1

    aput p3, p1, p2

    move p5, v1

    move p3, v1

    move-object v0, p1

    :goto_2
    const/16 v2, 0x800

    if-ge p4, v2, :cond_3

    shl-int/lit8 v2, p3, 0x8

    shr-int/lit8 v3, p4, 0x6

    or-int/lit16 v3, v3, 0xc0

    or-int/2addr v3, v2

    add-int/lit8 v2, p5, 0x1

    move v8, v2

    move v2, v3

    move-object v3, v0

    move v0, v8

    :goto_3
    and-int/lit8 v6, p4, 0x3f

    or-int/lit16 p3, v6, 0x80

    move p5, v0

    move p2, v4

    move-object v0, v3

    move v3, v2

    :goto_4
    if-ge p5, v7, :cond_5

    add-int/lit8 p5, p5, 0x1

    shl-int/lit8 v2, v3, 0x8

    or-int/2addr p3, v2

    move-object p1, v0

    :goto_5
    iget v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    iget v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputEnd:I

    if-lt v0, v2, :cond_1

    invoke-virtual {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->loadMore()Z

    move-result v0

    if-nez v0, :cond_1

    const-string v0, " in field name"

    invoke-virtual {p0, v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_reportInvalidEOF(Ljava/lang/String;)V

    :cond_1
    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputBuffer:[B

    iget v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    add-int/lit8 v3, v2, 0x1

    iput v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    aget-byte v0, v0, v2

    and-int/lit16 p4, v0, 0xff

    goto :goto_0

    :cond_2
    invoke-direct {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_decodeEscaped()C

    move-result p4

    goto :goto_1

    :cond_3
    shl-int/lit8 v2, p3, 0x8

    shr-int/lit8 v3, p4, 0xc

    or-int/lit16 v3, v3, 0xe0

    or-int/2addr v3, v2

    add-int/lit8 v2, p5, 0x1

    if-lt v2, v7, :cond_b

    array-length v2, v0

    if-lt v4, v2, :cond_4

    array-length v2, v0

    invoke-static {v0, v2}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->growArrayBy([II)[I

    move-result-object v0

    iput-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_quadBuffer:[I

    :cond_4
    add-int/lit8 v2, v4, 0x1

    aput v3, v0, v4

    move v3, v2

    move-object v4, v0

    move v0, v1

    move v2, v1

    :goto_6
    shl-int/lit8 v2, v2, 0x8

    shr-int/lit8 v6, p4, 0x6

    and-int/lit8 v6, v6, 0x3f

    or-int/lit16 v6, v6, 0x80

    or-int/2addr v2, v6

    add-int/lit8 v0, v0, 0x1

    move v8, v3

    move-object v3, v4

    move v4, v8

    goto :goto_3

    :cond_5
    array-length v2, v0

    if-lt p2, v2, :cond_6

    array-length v2, v0

    invoke-static {v0, v2}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->growArrayBy([II)[I

    move-result-object v0

    iput-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_quadBuffer:[I

    :cond_6
    add-int/lit8 v2, p2, 0x1

    aput v3, v0, p2

    const/4 p5, 0x1

    move p2, v2

    move-object p1, v0

    goto :goto_5

    :cond_7
    if-lez p5, :cond_9

    array-length v0, p1

    if-lt p2, v0, :cond_8

    array-length v0, p1

    invoke-static {p1, v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->growArrayBy([II)[I

    move-result-object p1

    iput-object p1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_quadBuffer:[I

    :cond_8
    add-int/lit8 v0, p2, 0x1

    aput p3, p1, p2

    move p2, v0

    :cond_9
    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_symbols:Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;

    invoke-virtual {v0, p1, p2}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->findName([II)Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/Name;

    move-result-object v0

    if-nez v0, :cond_a

    invoke-direct {p0, p1, p2, p5}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->addName([III)Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/Name;

    move-result-object v0

    :cond_a
    return-object v0

    :cond_b
    move v8, v2

    move v2, v3

    move v3, v4

    move-object v4, v0

    move v0, v8

    goto :goto_6

    :cond_c
    move v4, p2

    move-object v0, p1

    goto/16 :goto_2

    :cond_d
    move v3, p3

    move-object v0, p1

    move p3, p4

    goto/16 :goto_4
.end method

.method private final parseFieldName(III)Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/Name;
    .locals 6
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParseException;
        }
    .end annotation

    iget-object v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_quadBuffer:[I

    const/4 v2, 0x0

    move-object v0, p0

    move v3, p1

    move v4, p2

    move v5, p3

    invoke-direct/range {v0 .. v5}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->parseEscapedFieldName([IIIII)Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/Name;

    move-result-object v0

    return-object v0
.end method

.method private final parseFieldName(IIII)Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/Name;
    .locals 6
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParseException;
        }
    .end annotation

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_quadBuffer:[I

    const/4 v1, 0x0

    aput p1, v0, v1

    iget-object v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_quadBuffer:[I

    const/4 v2, 0x1

    move-object v0, p0

    move v3, p2

    move v4, p3

    move v5, p4

    invoke-direct/range {v0 .. v5}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->parseEscapedFieldName([IIIII)Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/Name;

    move-result-object v0

    return-object v0
.end method

.method private parseLongFieldName(I)Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/Name;
    .locals 12
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParseException;
        }
    .end annotation

    const/4 v10, 0x1

    const/4 v3, 0x0

    const/4 v11, 0x4

    const/4 v5, 0x2

    const/16 v8, 0x22

    invoke-static {}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/CharTypes;->getInputCodeLatin1()[I

    move-result-object v1

    move v2, v5

    move v4, p1

    :goto_0
    iget v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputEnd:I

    iget v6, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    sub-int/2addr v0, v6

    if-ge v0, v11, :cond_0

    iget-object v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_quadBuffer:[I

    move-object v0, p0

    move v5, v3

    invoke-direct/range {v0 .. v5}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->parseEscapedFieldName([IIIII)Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/Name;

    move-result-object v0

    :goto_1
    return-object v0

    :cond_0
    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputBuffer:[B

    iget v6, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    add-int/lit8 v7, v6, 0x1

    iput v7, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    aget-byte v0, v0, v6

    and-int/lit16 v9, v0, 0xff

    aget v0, v1, v9

    if-eqz v0, :cond_2

    if-ne v9, v8, :cond_1

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_quadBuffer:[I

    invoke-direct {p0, v0, v2, v4, v10}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->findName([IIII)Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/Name;

    move-result-object v0

    goto :goto_1

    :cond_1
    iget-object v6, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_quadBuffer:[I

    move-object v5, p0

    move v7, v2

    move v8, v4

    invoke-direct/range {v5 .. v10}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->parseEscapedFieldName([IIIII)Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/Name;

    move-result-object v0

    goto :goto_1

    :cond_2
    shl-int/lit8 v0, v4, 0x8

    or-int v6, v0, v9

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputBuffer:[B

    iget v4, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    add-int/lit8 v7, v4, 0x1

    iput v7, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    aget-byte v0, v0, v4

    and-int/lit16 v4, v0, 0xff

    aget v0, v1, v4

    if-eqz v0, :cond_4

    if-ne v4, v8, :cond_3

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_quadBuffer:[I

    invoke-direct {p0, v0, v2, v6, v5}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->findName([IIII)Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/Name;

    move-result-object v0

    goto :goto_1

    :cond_3
    iget-object v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_quadBuffer:[I

    move-object v0, p0

    move v3, v6

    invoke-direct/range {v0 .. v5}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->parseEscapedFieldName([IIIII)Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/Name;

    move-result-object v0

    goto :goto_1

    :cond_4
    shl-int/lit8 v0, v6, 0x8

    or-int v6, v0, v4

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputBuffer:[B

    iget v4, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    add-int/lit8 v7, v4, 0x1

    iput v7, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    aget-byte v0, v0, v4

    and-int/lit16 v4, v0, 0xff

    aget v0, v1, v4

    if-eqz v0, :cond_6

    if-ne v4, v8, :cond_5

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_quadBuffer:[I

    const/4 v1, 0x3

    invoke-direct {p0, v0, v2, v6, v1}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->findName([IIII)Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/Name;

    move-result-object v0

    goto :goto_1

    :cond_5
    iget-object v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_quadBuffer:[I

    const/4 v5, 0x3

    move-object v0, p0

    move v3, v6

    invoke-direct/range {v0 .. v5}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->parseEscapedFieldName([IIIII)Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/Name;

    move-result-object v0

    goto :goto_1

    :cond_6
    shl-int/lit8 v0, v6, 0x8

    or-int v6, v0, v4

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputBuffer:[B

    iget v4, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    add-int/lit8 v7, v4, 0x1

    iput v7, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    aget-byte v0, v0, v4

    and-int/lit16 v4, v0, 0xff

    aget v0, v1, v4

    if-eqz v0, :cond_8

    if-ne v4, v8, :cond_7

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_quadBuffer:[I

    invoke-direct {p0, v0, v2, v6, v11}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->findName([IIII)Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/Name;

    move-result-object v0

    goto/16 :goto_1

    :cond_7
    iget-object v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_quadBuffer:[I

    move-object v0, p0

    move v3, v6

    move v5, v11

    invoke-direct/range {v0 .. v5}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->parseEscapedFieldName([IIIII)Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/Name;

    move-result-object v0

    goto/16 :goto_1

    :cond_8
    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_quadBuffer:[I

    array-length v0, v0

    if-lt v2, v0, :cond_9

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_quadBuffer:[I

    invoke-static {v0, v2}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->growArrayBy([II)[I

    move-result-object v0

    iput-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_quadBuffer:[I

    :cond_9
    iget-object v7, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_quadBuffer:[I

    add-int/lit8 v0, v2, 0x1

    aput v6, v7, v2

    move v2, v0

    goto/16 :goto_0
.end method


# virtual methods
.method protected final _finishString()V
    .locals 9
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParseException;
        }
    .end annotation

    const/4 v2, 0x0

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_textBuffer:Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/TextBuffer;

    invoke-virtual {v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/TextBuffer;->emptyAndGetCurrentSegment()[C

    move-result-object v0

    invoke-static {}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/CharTypes;->getInputCodeUtf8()[I

    move-result-object v7

    iget-object v8, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputBuffer:[B

    move v1, v2

    :goto_0
    iget v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    iget v4, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputEnd:I

    if-lt v3, v4, :cond_0

    invoke-virtual {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->loadMoreGuaranteed()V

    iget v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    :cond_0
    array-length v4, v0

    if-lt v1, v4, :cond_1

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_textBuffer:Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/TextBuffer;

    invoke-virtual {v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/TextBuffer;->finishCurrentSegment()[C

    move-result-object v0

    move v1, v2

    :cond_1
    iget v5, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputEnd:I

    array-length v4, v0

    sub-int/2addr v4, v1

    add-int/2addr v4, v3

    if-ge v4, v5, :cond_9

    :goto_1
    if-ge v3, v4, :cond_3

    add-int/lit8 v5, v3, 0x1

    aget-byte v3, v8, v3

    and-int/lit16 v3, v3, 0xff

    aget v6, v7, v3

    if-eqz v6, :cond_2

    iput v5, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    const/16 v4, 0x22

    if-eq v3, v4, :cond_6

    aget v4, v7, v3

    packed-switch v4, :pswitch_data_0

    const/16 v4, 0x20

    if-ge v3, v4, :cond_5

    const-string v4, "string value"

    invoke-virtual {p0, v3, v4}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_throwUnquotedSpace(ILjava/lang/String;)V

    :goto_2
    array-length v4, v0

    if-lt v1, v4, :cond_7

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_textBuffer:Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/TextBuffer;

    invoke-virtual {v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/TextBuffer;->finishCurrentSegment()[C

    move-result-object v0

    move v4, v2

    :goto_3
    add-int/lit8 v1, v4, 0x1

    int-to-char v3, v3

    aput-char v3, v0, v4

    goto :goto_0

    :cond_2
    add-int/lit8 v6, v1, 0x1

    int-to-char v3, v3

    aput-char v3, v0, v1

    move v3, v5

    move v1, v6

    goto :goto_1

    :cond_3
    iput v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    goto :goto_0

    :pswitch_0
    invoke-direct {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_decodeEscaped()C

    move-result v3

    goto :goto_2

    :pswitch_1
    invoke-direct {p0, v3}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_decodeUtf8_2(I)I

    move-result v3

    goto :goto_2

    :pswitch_2
    iget v4, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputEnd:I

    iget v5, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    sub-int/2addr v4, v5

    const/4 v5, 0x2

    if-lt v4, v5, :cond_4

    invoke-direct {p0, v3}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_decodeUtf8_3fast(I)I

    move-result v3

    goto :goto_2

    :cond_4
    invoke-direct {p0, v3}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_decodeUtf8_3(I)I

    move-result v3

    goto :goto_2

    :pswitch_3
    invoke-direct {p0, v3}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_decodeUtf8_4(I)I

    move-result v4

    add-int/lit8 v3, v1, 0x1

    const v5, 0xd800

    shr-int/lit8 v6, v4, 0xa

    or-int/2addr v5, v6

    int-to-char v5, v5

    aput-char v5, v0, v1

    array-length v1, v0

    if-lt v3, v1, :cond_8

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_textBuffer:Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/TextBuffer;

    invoke-virtual {v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/TextBuffer;->finishCurrentSegment()[C

    move-result-object v0

    move v1, v2

    :goto_4
    const v3, 0xdc00

    and-int/lit16 v4, v4, 0x3ff

    or-int/2addr v3, v4

    goto :goto_2

    :cond_5
    invoke-direct {p0, v3}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_reportInvalidChar(I)V

    goto :goto_2

    :cond_6
    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_textBuffer:Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/TextBuffer;

    invoke-virtual {v0, v1}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/TextBuffer;->setCurrentLength(I)V

    return-void

    :cond_7
    move v4, v1

    goto :goto_3

    :cond_8
    move v1, v3

    goto :goto_4

    :cond_9
    move v4, v5

    goto/16 :goto_1

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_0
        :pswitch_1
        :pswitch_2
        :pswitch_3
    .end packed-switch
.end method

.method public final close()V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    invoke-super {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8NumericParser;->close()V

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_symbols:Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;

    invoke-virtual {v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->release()V

    return-void
.end method

.method public final nextToken()Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;
    .locals 11
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParseException;
        }
    .end annotation

    const/4 v10, 0x2

    const/16 v7, 0x80

    const/4 v9, 0x1

    const/4 v2, 0x0

    const/16 v8, 0x22

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_currToken:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;

    sget-object v1, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;->FIELD_NAME:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;

    if-ne v0, v1, :cond_2

    iput-boolean v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_nameCopied:Z

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_nextToken:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;

    const/4 v1, 0x0

    iput-object v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_nextToken:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;

    sget-object v1, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;->START_ARRAY:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;

    if-ne v0, v1, :cond_1

    iget-object v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_parsingContext:Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonReadContext;

    iget v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_tokenInputRow:I

    iget v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_tokenInputCol:I

    invoke-virtual {v1, v2, v3}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonReadContext;->createChildArrayContext(II)Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonReadContext;

    move-result-object v1

    iput-object v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_parsingContext:Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonReadContext;

    :cond_0
    :goto_0
    iput-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_currToken:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;

    :goto_1
    return-object v0

    :cond_1
    sget-object v1, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;->START_OBJECT:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;

    if-ne v0, v1, :cond_0

    iget-object v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_parsingContext:Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonReadContext;

    iget v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_tokenInputRow:I

    iget v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_tokenInputCol:I

    invoke-virtual {v1, v2, v3}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonReadContext;->createChildObjectContext(II)Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonReadContext;

    move-result-object v1

    iput-object v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_parsingContext:Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonReadContext;

    goto :goto_0

    :cond_2
    iget-boolean v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_tokenIncomplete:Z

    if-eqz v0, :cond_11

    iput-boolean v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_tokenIncomplete:Z

    invoke-static {}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/CharTypes;->getInputCodeUtf8()[I

    move-result-object v4

    iget-object v5, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputBuffer:[B

    :cond_3
    :goto_2
    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    iget v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputEnd:I

    if-lt v1, v0, :cond_4

    invoke-virtual {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->loadMoreGuaranteed()V

    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    iget v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputEnd:I

    :cond_4
    :goto_3
    if-ge v1, v0, :cond_5

    add-int/lit8 v3, v1, 0x1

    aget-byte v1, v5, v1

    and-int/lit16 v1, v1, 0xff

    aget v6, v4, v1

    if-eqz v6, :cond_39

    iput v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    if-eq v1, v8, :cond_11

    aget v0, v4, v1

    packed-switch v0, :pswitch_data_0

    const/16 v0, 0x20

    if-ge v1, v0, :cond_f

    const-string v0, "string value"

    invoke-virtual {p0, v1, v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_throwUnquotedSpace(ILjava/lang/String;)V

    goto :goto_2

    :cond_5
    iput v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    goto :goto_2

    :pswitch_0
    invoke-direct {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_decodeEscaped()C

    goto :goto_2

    :pswitch_1
    iget v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputEnd:I

    if-lt v0, v1, :cond_6

    invoke-virtual {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->loadMoreGuaranteed()V

    :cond_6
    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputBuffer:[B

    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    add-int/lit8 v3, v1, 0x1

    iput v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    aget-byte v0, v0, v1

    and-int/lit16 v1, v0, 0xc0

    if-eq v1, v7, :cond_3

    and-int/lit16 v0, v0, 0xff

    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    invoke-direct {p0, v0, v1}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_reportInvalidOther(II)V

    goto :goto_2

    :pswitch_2
    iget v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputEnd:I

    if-lt v0, v1, :cond_7

    invoke-virtual {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->loadMoreGuaranteed()V

    :cond_7
    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputBuffer:[B

    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    add-int/lit8 v3, v1, 0x1

    iput v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    aget-byte v0, v0, v1

    and-int/lit16 v1, v0, 0xc0

    if-eq v1, v7, :cond_8

    and-int/lit16 v0, v0, 0xff

    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    invoke-direct {p0, v0, v1}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_reportInvalidOther(II)V

    :cond_8
    iget v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputEnd:I

    if-lt v0, v1, :cond_9

    invoke-virtual {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->loadMoreGuaranteed()V

    :cond_9
    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputBuffer:[B

    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    add-int/lit8 v3, v1, 0x1

    iput v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    aget-byte v0, v0, v1

    and-int/lit16 v1, v0, 0xc0

    if-eq v1, v7, :cond_3

    and-int/lit16 v0, v0, 0xff

    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    invoke-direct {p0, v0, v1}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_reportInvalidOther(II)V

    goto/16 :goto_2

    :pswitch_3
    iget v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputEnd:I

    if-lt v0, v1, :cond_a

    invoke-virtual {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->loadMoreGuaranteed()V

    :cond_a
    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputBuffer:[B

    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    add-int/lit8 v3, v1, 0x1

    iput v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    aget-byte v0, v0, v1

    and-int/lit16 v1, v0, 0xc0

    if-eq v1, v7, :cond_b

    and-int/lit16 v1, v0, 0xff

    iget v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    invoke-direct {p0, v1, v3}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_reportInvalidOther(II)V

    :cond_b
    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    iget v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputEnd:I

    if-lt v1, v3, :cond_c

    invoke-virtual {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->loadMoreGuaranteed()V

    :cond_c
    and-int/lit16 v1, v0, 0xc0

    if-eq v1, v7, :cond_d

    and-int/lit16 v0, v0, 0xff

    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    invoke-direct {p0, v0, v1}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_reportInvalidOther(II)V

    :cond_d
    iget v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputEnd:I

    if-lt v0, v1, :cond_e

    invoke-virtual {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->loadMoreGuaranteed()V

    :cond_e
    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputBuffer:[B

    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    add-int/lit8 v3, v1, 0x1

    iput v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    aget-byte v0, v0, v1

    and-int/lit16 v1, v0, 0xc0

    if-eq v1, v7, :cond_3

    and-int/lit16 v0, v0, 0xff

    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    invoke-direct {p0, v0, v1}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_reportInvalidOther(II)V

    goto/16 :goto_2

    :cond_f
    invoke-direct {p0, v1}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_reportInvalidChar(I)V

    goto/16 :goto_2

    :cond_10
    invoke-direct {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_skipComment()V

    :cond_11
    :goto_4
    iget v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputEnd:I

    if-lt v0, v1, :cond_12

    invoke-virtual {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->loadMore()Z

    move-result v0

    if-eqz v0, :cond_16

    :cond_12
    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputBuffer:[B

    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    add-int/lit8 v3, v1, 0x1

    iput v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    aget-byte v0, v0, v1

    and-int/lit16 v0, v0, 0xff

    const/16 v1, 0x20

    if-le v0, v1, :cond_13

    const/16 v1, 0x2f

    if-eq v0, v1, :cond_10

    :goto_5
    if-gez v0, :cond_17

    invoke-virtual {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->close()V

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_currToken:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;

    goto/16 :goto_1

    :cond_13
    const/16 v1, 0x20

    if-eq v0, v1, :cond_11

    const/16 v1, 0xa

    if-ne v0, v1, :cond_14

    invoke-direct {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_skipLF()V

    goto :goto_4

    :cond_14
    const/16 v1, 0xd

    if-ne v0, v1, :cond_15

    invoke-direct {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_skipCR()V

    goto :goto_4

    :cond_15
    const/16 v1, 0x9

    if-eq v0, v1, :cond_11

    invoke-virtual {p0, v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_throwInvalidSpace(I)V

    goto :goto_4

    :cond_16
    invoke-virtual {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_handleEOF()V

    const/4 v0, -0x1

    goto :goto_5

    :cond_17
    iget-wide v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_currInputProcessed:J

    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    int-to-long v5, v1

    add-long/2addr v3, v5

    const-wide/16 v5, 0x1

    sub-long/2addr v3, v5

    iput-wide v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_tokenInputTotal:J

    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_currInputRow:I

    iput v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_tokenInputRow:I

    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    iget v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_currInputRowStart:I

    sub-int/2addr v1, v3

    add-int/lit8 v1, v1, -0x1

    iput v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_tokenInputCol:I

    const/4 v1, 0x0

    iput-object v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_binaryValue:[B

    const/16 v1, 0x5d

    if-ne v0, v1, :cond_19

    iget-object v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_parsingContext:Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonReadContext;

    invoke-virtual {v1}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonReadContext;->inArray()Z

    move-result v1

    if-nez v1, :cond_18

    const/16 v1, 0x7d

    invoke-virtual {p0, v0, v1}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_reportMismatchedEndMarker(IC)V

    :cond_18
    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_parsingContext:Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonReadContext;

    invoke-virtual {v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonReadContext;->getParent()Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonReadContext;

    move-result-object v0

    iput-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_parsingContext:Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonReadContext;

    sget-object v0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;->END_ARRAY:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;

    iput-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_currToken:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;

    goto/16 :goto_1

    :cond_19
    const/16 v1, 0x7d

    if-ne v0, v1, :cond_1b

    iget-object v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_parsingContext:Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonReadContext;

    invoke-virtual {v1}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonReadContext;->inObject()Z

    move-result v1

    if-nez v1, :cond_1a

    const/16 v1, 0x5d

    invoke-virtual {p0, v0, v1}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_reportMismatchedEndMarker(IC)V

    :cond_1a
    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_parsingContext:Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonReadContext;

    invoke-virtual {v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonReadContext;->getParent()Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonReadContext;

    move-result-object v0

    iput-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_parsingContext:Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonReadContext;

    sget-object v0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;->END_OBJECT:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;

    iput-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_currToken:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;

    goto/16 :goto_1

    :cond_1b
    iget-object v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_parsingContext:Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonReadContext;

    invoke-virtual {v1}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonReadContext;->expectComma()Z

    move-result v1

    if-eqz v1, :cond_1d

    const/16 v1, 0x2c

    if-eq v0, v1, :cond_1c

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "was expecting comma to separate "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_parsingContext:Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonReadContext;

    invoke-virtual {v3}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonReadContext;->getTypeDesc()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v3, " entries"

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v0, v1}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_reportUnexpectedChar(ILjava/lang/String;)V

    :cond_1c
    invoke-direct {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_skipWS()I

    move-result v0

    :cond_1d
    iget-object v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_parsingContext:Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonReadContext;

    invoke-virtual {v1}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonReadContext;->inObject()Z

    move-result v6

    if-eqz v6, :cond_1f

    if-eq v0, v8, :cond_20

    invoke-direct {p0, v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_handleUnusualFieldName(I)Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/Name;

    move-result-object v0

    :goto_6
    iget-object v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_parsingContext:Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonReadContext;

    invoke-virtual {v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/Name;->getName()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonReadContext;->setCurrentName(Ljava/lang/String;)V

    sget-object v0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;->FIELD_NAME:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;

    iput-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_currToken:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;

    invoke-direct {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_skipWS()I

    move-result v0

    const/16 v1, 0x3a

    if-eq v0, v1, :cond_1e

    const-string v1, "was expecting a colon to separate field name and value"

    invoke-virtual {p0, v0, v1}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_reportUnexpectedChar(ILjava/lang/String;)V

    :cond_1e
    invoke-direct {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_skipWS()I

    move-result v0

    :cond_1f
    sparse-switch v0, :sswitch_data_0

    invoke-direct {p0, v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_handleUnexpectedValue(I)Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;

    move-result-object v0

    :goto_7
    if-eqz v6, :cond_38

    iput-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_nextToken:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_currToken:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;

    goto/16 :goto_1

    :cond_20
    iget v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputEnd:I

    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    sub-int/2addr v0, v1

    const/16 v1, 0x9

    if-ge v0, v1, :cond_23

    iget v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputEnd:I

    if-lt v0, v1, :cond_21

    invoke-virtual {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->loadMore()Z

    move-result v0

    if-nez v0, :cond_21

    const-string v0, ": was expecting closing \'\"\' for name"

    invoke-virtual {p0, v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_reportInvalidEOF(Ljava/lang/String;)V

    :cond_21
    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputBuffer:[B

    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    add-int/lit8 v3, v1, 0x1

    iput v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    aget-byte v0, v0, v1

    and-int/lit16 v4, v0, 0xff

    if-ne v4, v8, :cond_22

    invoke-static {}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->getEmptyName()Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/Name;

    move-result-object v0

    goto :goto_6

    :cond_22
    iget-object v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_quadBuffer:[I

    move-object v0, p0

    move v3, v2

    move v5, v2

    invoke-direct/range {v0 .. v5}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->parseEscapedFieldName([IIIII)Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/Name;

    move-result-object v0

    goto :goto_6

    :cond_23
    invoke-static {}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/CharTypes;->getInputCodeLatin1()[I

    move-result-object v0

    iget-object v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputBuffer:[B

    iget v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    add-int/lit8 v4, v3, 0x1

    iput v4, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    aget-byte v1, v1, v3

    and-int/lit16 v1, v1, 0xff

    aget v3, v0, v1

    if-eqz v3, :cond_25

    if-ne v1, v8, :cond_24

    invoke-static {}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->getEmptyName()Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/Name;

    move-result-object v0

    goto :goto_6

    :cond_24
    invoke-direct {p0, v2, v1, v2}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->parseFieldName(III)Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/Name;

    move-result-object v0

    goto/16 :goto_6

    :cond_25
    iget-object v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputBuffer:[B

    iget v4, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    add-int/lit8 v5, v4, 0x1

    iput v5, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    aget-byte v3, v3, v4

    and-int/lit16 v3, v3, 0xff

    aget v4, v0, v3

    if-eqz v4, :cond_27

    if-ne v3, v8, :cond_26

    invoke-direct {p0, v1, v9}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->findName(II)Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/Name;

    move-result-object v0

    goto/16 :goto_6

    :cond_26
    invoke-direct {p0, v1, v3, v9}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->parseFieldName(III)Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/Name;

    move-result-object v0

    goto/16 :goto_6

    :cond_27
    shl-int/lit8 v1, v1, 0x8

    or-int/2addr v1, v3

    iget-object v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputBuffer:[B

    iget v4, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    add-int/lit8 v5, v4, 0x1

    iput v5, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    aget-byte v3, v3, v4

    and-int/lit16 v3, v3, 0xff

    aget v4, v0, v3

    if-eqz v4, :cond_29

    if-ne v3, v8, :cond_28

    invoke-direct {p0, v1, v10}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->findName(II)Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/Name;

    move-result-object v0

    goto/16 :goto_6

    :cond_28
    invoke-direct {p0, v1, v3, v10}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->parseFieldName(III)Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/Name;

    move-result-object v0

    goto/16 :goto_6

    :cond_29
    shl-int/lit8 v1, v1, 0x8

    or-int/2addr v1, v3

    iget-object v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputBuffer:[B

    iget v4, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    add-int/lit8 v5, v4, 0x1

    iput v5, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    aget-byte v3, v3, v4

    and-int/lit16 v3, v3, 0xff

    aget v4, v0, v3

    if-eqz v4, :cond_2b

    if-ne v3, v8, :cond_2a

    const/4 v0, 0x3

    invoke-direct {p0, v1, v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->findName(II)Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/Name;

    move-result-object v0

    goto/16 :goto_6

    :cond_2a
    const/4 v0, 0x3

    invoke-direct {p0, v1, v3, v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->parseFieldName(III)Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/Name;

    move-result-object v0

    goto/16 :goto_6

    :cond_2b
    shl-int/lit8 v1, v1, 0x8

    or-int/2addr v1, v3

    iget-object v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputBuffer:[B

    iget v4, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    add-int/lit8 v5, v4, 0x1

    iput v5, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    aget-byte v3, v3, v4

    and-int/lit16 v3, v3, 0xff

    aget v0, v0, v3

    if-eqz v0, :cond_2d

    if-ne v3, v8, :cond_2c

    const/4 v0, 0x4

    invoke-direct {p0, v1, v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->findName(II)Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/Name;

    move-result-object v0

    goto/16 :goto_6

    :cond_2c
    const/4 v0, 0x4

    invoke-direct {p0, v1, v3, v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->parseFieldName(III)Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/Name;

    move-result-object v0

    goto/16 :goto_6

    :cond_2d
    invoke-static {}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/CharTypes;->getInputCodeLatin1()[I

    move-result-object v0

    iget-object v4, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputBuffer:[B

    iget v5, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    add-int/lit8 v7, v5, 0x1

    iput v7, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    aget-byte v4, v4, v5

    and-int/lit16 v4, v4, 0xff

    aget v5, v0, v4

    if-eqz v5, :cond_2f

    if-ne v4, v8, :cond_2e

    invoke-direct {p0, v1, v3, v9}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->findName(III)Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/Name;

    move-result-object v0

    goto/16 :goto_6

    :cond_2e
    invoke-direct {p0, v1, v3, v4, v9}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->parseFieldName(IIII)Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/Name;

    move-result-object v0

    goto/16 :goto_6

    :cond_2f
    shl-int/lit8 v3, v3, 0x8

    or-int/2addr v3, v4

    iget-object v4, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputBuffer:[B

    iget v5, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    add-int/lit8 v7, v5, 0x1

    iput v7, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    aget-byte v4, v4, v5

    and-int/lit16 v4, v4, 0xff

    aget v5, v0, v4

    if-eqz v5, :cond_31

    if-ne v4, v8, :cond_30

    invoke-direct {p0, v1, v3, v10}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->findName(III)Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/Name;

    move-result-object v0

    goto/16 :goto_6

    :cond_30
    invoke-direct {p0, v1, v3, v4, v10}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->parseFieldName(IIII)Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/Name;

    move-result-object v0

    goto/16 :goto_6

    :cond_31
    shl-int/lit8 v3, v3, 0x8

    or-int/2addr v3, v4

    iget-object v4, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputBuffer:[B

    iget v5, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    add-int/lit8 v7, v5, 0x1

    iput v7, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    aget-byte v4, v4, v5

    and-int/lit16 v4, v4, 0xff

    aget v5, v0, v4

    if-eqz v5, :cond_33

    if-ne v4, v8, :cond_32

    const/4 v0, 0x3

    invoke-direct {p0, v1, v3, v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->findName(III)Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/Name;

    move-result-object v0

    goto/16 :goto_6

    :cond_32
    const/4 v0, 0x3

    invoke-direct {p0, v1, v3, v4, v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->parseFieldName(IIII)Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/Name;

    move-result-object v0

    goto/16 :goto_6

    :cond_33
    shl-int/lit8 v3, v3, 0x8

    or-int/2addr v3, v4

    iget-object v4, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputBuffer:[B

    iget v5, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    add-int/lit8 v7, v5, 0x1

    iput v7, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_inputPtr:I

    aget-byte v4, v4, v5

    and-int/lit16 v4, v4, 0xff

    aget v0, v0, v4

    if-eqz v0, :cond_35

    if-ne v4, v8, :cond_34

    const/4 v0, 0x4

    invoke-direct {p0, v1, v3, v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->findName(III)Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/Name;

    move-result-object v0

    goto/16 :goto_6

    :cond_34
    const/4 v0, 0x4

    invoke-direct {p0, v1, v3, v4, v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->parseFieldName(IIII)Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/Name;

    move-result-object v0

    goto/16 :goto_6

    :cond_35
    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_quadBuffer:[I

    aput v1, v0, v2

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_quadBuffer:[I

    aput v3, v0, v9

    invoke-direct {p0, v4}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->parseLongFieldName(I)Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/Name;

    move-result-object v0

    goto/16 :goto_6

    :sswitch_0
    iput-boolean v9, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_tokenIncomplete:Z

    sget-object v0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;->VALUE_STRING:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;

    goto/16 :goto_7

    :sswitch_1
    if-nez v6, :cond_36

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_parsingContext:Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonReadContext;

    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_tokenInputRow:I

    iget v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_tokenInputCol:I

    invoke-virtual {v0, v1, v2}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonReadContext;->createChildArrayContext(II)Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonReadContext;

    move-result-object v0

    iput-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_parsingContext:Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonReadContext;

    :cond_36
    sget-object v0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;->START_ARRAY:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;

    goto/16 :goto_7

    :sswitch_2
    if-nez v6, :cond_37

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_parsingContext:Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonReadContext;

    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_tokenInputRow:I

    iget v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_tokenInputCol:I

    invoke-virtual {v0, v1, v2}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonReadContext;->createChildObjectContext(II)Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonReadContext;

    move-result-object v0

    iput-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_parsingContext:Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonReadContext;

    :cond_37
    sget-object v0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;->START_OBJECT:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;

    goto/16 :goto_7

    :sswitch_3
    const-string v1, "expected a value"

    invoke-virtual {p0, v0, v1}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_reportUnexpectedChar(ILjava/lang/String;)V

    :sswitch_4
    sget-object v0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;->VALUE_TRUE:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;

    invoke-direct {p0, v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_matchToken(Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;)V

    sget-object v0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;->VALUE_TRUE:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;

    goto/16 :goto_7

    :sswitch_5
    sget-object v0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;->VALUE_FALSE:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;

    invoke-direct {p0, v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_matchToken(Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;)V

    sget-object v0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;->VALUE_FALSE:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;

    goto/16 :goto_7

    :sswitch_6
    sget-object v0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;->VALUE_NULL:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;

    invoke-direct {p0, v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_matchToken(Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;)V

    sget-object v0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;->VALUE_NULL:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;

    goto/16 :goto_7

    :sswitch_7
    invoke-virtual {p0, v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->parseNumberText(I)Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;

    move-result-object v0

    goto/16 :goto_7

    :cond_38
    iput-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/Utf8StreamParser;->_currToken:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;

    goto/16 :goto_1

    :cond_39
    move v1, v3

    goto/16 :goto_3

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_0
        :pswitch_1
        :pswitch_2
        :pswitch_3
    .end packed-switch

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
