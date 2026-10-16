.class public abstract Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;
.super Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonParserBase;


# static fields
.field static final BD_MAX_INT:Ljava/math/BigDecimal;

.field static final BD_MAX_LONG:Ljava/math/BigDecimal;

.field static final BD_MIN_INT:Ljava/math/BigDecimal;

.field static final BD_MIN_LONG:Ljava/math/BigDecimal;


# instance fields
.field protected _numTypesValid:I

.field protected _numberBigDecimal:Ljava/math/BigDecimal;

.field protected _numberBigInt:Ljava/math/BigInteger;

.field protected _numberDouble:D

.field protected _numberInt:I

.field protected _numberLong:J

.field protected _numberNegative:Z

.field protected mExpLength:I

.field protected mFractLength:I

.field protected mIntLength:I


# direct methods
.method static constructor <clinit>()V
    .locals 5

    const-wide v3, 0x7fffffffffffffffL

    const-wide/high16 v1, -0x8000000000000000L

    new-instance v0, Ljava/math/BigDecimal;

    invoke-direct {v0, v1, v2}, Ljava/math/BigDecimal;-><init>(J)V

    sput-object v0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->BD_MIN_LONG:Ljava/math/BigDecimal;

    new-instance v0, Ljava/math/BigDecimal;

    invoke-direct {v0, v3, v4}, Ljava/math/BigDecimal;-><init>(J)V

    sput-object v0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->BD_MAX_LONG:Ljava/math/BigDecimal;

    new-instance v0, Ljava/math/BigDecimal;

    invoke-direct {v0, v1, v2}, Ljava/math/BigDecimal;-><init>(J)V

    sput-object v0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->BD_MIN_INT:Ljava/math/BigDecimal;

    new-instance v0, Ljava/math/BigDecimal;

    invoke-direct {v0, v3, v4}, Ljava/math/BigDecimal;-><init>(J)V

    sput-object v0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->BD_MAX_INT:Ljava/math/BigDecimal;

    return-void
.end method

.method protected constructor <init>(Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/IOContext;I)V
    .locals 1

    invoke-direct {p0, p1, p2}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonParserBase;-><init>(Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/IOContext;I)V

    const/4 v0, 0x0

    iput v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->_numTypesValid:I

    return-void
.end method

.method private parseNumericValue(I)V
    .locals 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParseException;
        }
    .end annotation

    const/16 v2, 0x10

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->_currToken:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->_currToken:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;

    invoke-virtual {v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;->isNumeric()Z

    move-result v0

    if-nez v0, :cond_1

    :cond_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Current token ("

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->_currToken:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ") not numeric, can not use numeric value accessors"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->_reportError(Ljava/lang/String;)V

    :cond_1
    :try_start_0
    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->_currToken:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;

    sget-object v1, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;->VALUE_NUMBER_INT:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;

    if-ne v0, v1, :cond_a

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->_textBuffer:Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/TextBuffer;

    invoke-virtual {v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/TextBuffer;->getTextBuffer()[C

    move-result-object v1

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->_textBuffer:Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/TextBuffer;

    invoke-virtual {v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/TextBuffer;->getTextOffset()I

    move-result v0

    iget v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->mIntLength:I

    iget-boolean v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->_numberNegative:Z

    if-eqz v3, :cond_2

    add-int/lit8 v0, v0, 0x1

    :cond_2
    const/16 v3, 0x9

    if-gt v2, v3, :cond_4

    invoke-static {v1, v0, v2}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/NumberInput;->parseInt([CII)I

    move-result v0

    iget-boolean v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->_numberNegative:Z

    if-eqz v1, :cond_3

    neg-int v0, v0

    :cond_3
    iput v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->_numberInt:I

    const/4 v0, 0x1

    iput v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->_numTypesValid:I

    :goto_0
    return-void

    :cond_4
    const/16 v3, 0x12

    if-gt v2, v3, :cond_8

    invoke-static {v1, v0, v2}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/NumberInput;->parseLong([CII)J

    move-result-wide v0

    iget-boolean v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->_numberNegative:Z

    if-eqz v3, :cond_5

    neg-long v0, v0

    :cond_5
    const/16 v3, 0xa

    if-ne v2, v3, :cond_7

    iget-boolean v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->_numberNegative:Z

    if-eqz v2, :cond_6

    const-wide/32 v2, -0x80000000

    cmp-long v2, v0, v2

    if-ltz v2, :cond_7

    long-to-int v0, v0

    iput v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->_numberInt:I

    const/4 v0, 0x1

    iput v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->_numTypesValid:I
    :try_end_0
    .catch Ljava/lang/NumberFormatException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Malformed numeric value \'"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->_textBuffer:Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/TextBuffer;

    invoke-virtual {v2}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/TextBuffer;->contentsAsString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "\'"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    new-instance v2, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParseException;

    invoke-virtual {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonParserBase;->getCurrentLocation()Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonLocation;

    move-result-object v3

    invoke-direct {v2, v1, v3, v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParseException;-><init>(Ljava/lang/String;Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonLocation;Ljava/lang/Throwable;)V

    throw v2

    :cond_6
    const-wide/32 v2, 0x7fffffff

    cmp-long v2, v0, v2

    if-gtz v2, :cond_7

    long-to-int v0, v0

    :try_start_1
    iput v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->_numberInt:I

    const/4 v0, 0x1

    iput v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->_numTypesValid:I

    goto :goto_0

    :cond_7
    iput-wide v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->_numberLong:J

    const/4 v0, 0x2

    iput v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->_numTypesValid:I

    goto :goto_0

    :cond_8
    iget-object v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->_textBuffer:Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/TextBuffer;

    invoke-virtual {v3}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/TextBuffer;->contentsAsString()Ljava/lang/String;

    move-result-object v3

    iget-boolean v4, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->_numberNegative:Z

    invoke-static {v1, v0, v2, v4}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/NumberInput;->inLongRange([CIIZ)Z

    move-result v0

    if-eqz v0, :cond_9

    invoke-static {v3}, Ljava/lang/Long;->parseLong(Ljava/lang/String;)J

    move-result-wide v0

    iput-wide v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->_numberLong:J

    const/4 v0, 0x2

    iput v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->_numTypesValid:I

    goto :goto_0

    :cond_9
    new-instance v0, Ljava/math/BigInteger;

    invoke-direct {v0, v3}, Ljava/math/BigInteger;-><init>(Ljava/lang/String;)V

    iput-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->_numberBigInt:Ljava/math/BigInteger;

    const/4 v0, 0x4

    iput v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->_numTypesValid:I

    goto/16 :goto_0

    :cond_a
    if-ne p1, v2, :cond_b

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->_textBuffer:Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/TextBuffer;

    invoke-virtual {v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/TextBuffer;->contentsAsDecimal()Ljava/math/BigDecimal;

    move-result-object v0

    iput-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->_numberBigDecimal:Ljava/math/BigDecimal;

    const/16 v0, 0x10

    iput v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->_numTypesValid:I

    goto/16 :goto_0

    :cond_b
    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->_textBuffer:Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/TextBuffer;

    invoke-virtual {v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/TextBuffer;->contentsAsDouble()D

    move-result-wide v0

    iput-wide v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->_numberDouble:D

    const/16 v0, 0x8

    iput v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->_numTypesValid:I
    :try_end_1
    .catch Ljava/lang/NumberFormatException; {:try_start_1 .. :try_end_1} :catch_0

    goto/16 :goto_0
.end method

.method private reportOverflowInt()V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParseException;
        }
    .end annotation

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Numeric value ("

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->getText()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ") out of range of int ("

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const/high16 v1, -0x80000000

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " - "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const v1, 0x7fffffff

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ")"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->_reportError(Ljava/lang/String;)V

    return-void
.end method

.method private reportOverflowLong()V
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParseException;
        }
    .end annotation

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Numeric value ("

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->getText()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ") out of range of long ("

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-wide/high16 v1, -0x8000000000000000L

    invoke-virtual {v0, v1, v2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " - "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-wide v1, 0x7fffffffffffffffL

    invoke-virtual {v0, v1, v2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ")"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->_reportError(Ljava/lang/String;)V

    return-void
.end method


# virtual methods
.method public final getDoubleValue()D
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParseException;
        }
    .end annotation

    iget v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->_numTypesValid:I

    and-int/lit8 v0, v0, 0x8

    if-nez v0, :cond_1

    iget v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->_numTypesValid:I

    if-nez v0, :cond_0

    const/16 v0, 0x8

    invoke-direct {p0, v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->parseNumericValue(I)V

    :cond_0
    iget v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->_numTypesValid:I

    and-int/lit8 v0, v0, 0x8

    if-nez v0, :cond_1

    iget v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->_numTypesValid:I

    and-int/lit8 v0, v0, 0x10

    if-eqz v0, :cond_2

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->_numberBigDecimal:Ljava/math/BigDecimal;

    invoke-virtual {v0}, Ljava/math/BigDecimal;->doubleValue()D

    move-result-wide v0

    iput-wide v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->_numberDouble:D

    :goto_0
    iget v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->_numTypesValid:I

    or-int/lit8 v0, v0, 0x8

    iput v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->_numTypesValid:I

    :cond_1
    iget-wide v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->_numberDouble:D

    return-wide v0

    :cond_2
    iget v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->_numTypesValid:I

    and-int/lit8 v0, v0, 0x4

    if-eqz v0, :cond_3

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->_numberBigInt:Ljava/math/BigInteger;

    invoke-virtual {v0}, Ljava/math/BigInteger;->doubleValue()D

    move-result-wide v0

    iput-wide v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->_numberDouble:D

    goto :goto_0

    :cond_3
    iget v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->_numTypesValid:I

    and-int/lit8 v0, v0, 0x2

    if-eqz v0, :cond_4

    iget-wide v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->_numberLong:J

    long-to-double v0, v0

    iput-wide v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->_numberDouble:D

    goto :goto_0

    :cond_4
    iget v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->_numTypesValid:I

    and-int/lit8 v0, v0, 0x1

    if-eqz v0, :cond_5

    iget v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->_numberInt:I

    int-to-double v0, v0

    iput-wide v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->_numberDouble:D

    goto :goto_0

    :cond_5
    invoke-static {}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->_throwInternal()V

    goto :goto_0
.end method

.method public final getFloatValue()F
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParseException;
        }
    .end annotation

    invoke-virtual {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->getDoubleValue()D

    move-result-wide v0

    double-to-float v0, v0

    return v0
.end method

.method public final getIntValue()I
    .locals 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParseException;
        }
    .end annotation

    iget v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->_numTypesValid:I

    and-int/lit8 v0, v0, 0x1

    if-nez v0, :cond_2

    iget v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->_numTypesValid:I

    if-nez v0, :cond_0

    const/4 v0, 0x1

    invoke-direct {p0, v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->parseNumericValue(I)V

    :cond_0
    iget v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->_numTypesValid:I

    and-int/lit8 v0, v0, 0x1

    if-nez v0, :cond_2

    iget v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->_numTypesValid:I

    and-int/lit8 v0, v0, 0x2

    if-eqz v0, :cond_3

    iget-wide v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->_numberLong:J

    long-to-int v0, v0

    int-to-long v1, v0

    iget-wide v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->_numberLong:J

    cmp-long v1, v1, v3

    if-eqz v1, :cond_1

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Numeric value ("

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->getText()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ") out of range of int"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v1}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->_reportError(Ljava/lang/String;)V

    :cond_1
    iput v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->_numberInt:I

    :goto_0
    iget v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->_numTypesValid:I

    or-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->_numTypesValid:I

    :cond_2
    iget v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->_numberInt:I

    return v0

    :cond_3
    iget v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->_numTypesValid:I

    and-int/lit8 v0, v0, 0x4

    if-eqz v0, :cond_4

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->_numberBigInt:Ljava/math/BigInteger;

    invoke-virtual {v0}, Ljava/math/BigInteger;->intValue()I

    move-result v0

    iput v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->_numberInt:I

    goto :goto_0

    :cond_4
    iget v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->_numTypesValid:I

    and-int/lit8 v0, v0, 0x8

    if-eqz v0, :cond_7

    iget-wide v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->_numberDouble:D

    const-wide/high16 v2, -0x3e20000000000000L    # -2.147483648E9

    cmpg-double v0, v0, v2

    if-ltz v0, :cond_5

    iget-wide v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->_numberDouble:D

    const-wide v2, 0x41dfffffffc00000L    # 2.147483647E9

    cmpl-double v0, v0, v2

    if-lez v0, :cond_6

    :cond_5
    invoke-direct {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->reportOverflowInt()V

    :cond_6
    iget-wide v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->_numberDouble:D

    double-to-int v0, v0

    iput v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->_numberInt:I

    goto :goto_0

    :cond_7
    iget v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->_numTypesValid:I

    and-int/lit8 v0, v0, 0x10

    if-eqz v0, :cond_a

    sget-object v0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->BD_MIN_INT:Ljava/math/BigDecimal;

    iget-object v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->_numberBigDecimal:Ljava/math/BigDecimal;

    invoke-virtual {v0, v1}, Ljava/math/BigDecimal;->compareTo(Ljava/math/BigDecimal;)I

    move-result v0

    if-gtz v0, :cond_8

    sget-object v0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->BD_MAX_INT:Ljava/math/BigDecimal;

    iget-object v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->_numberBigDecimal:Ljava/math/BigDecimal;

    invoke-virtual {v0, v1}, Ljava/math/BigDecimal;->compareTo(Ljava/math/BigDecimal;)I

    move-result v0

    if-gez v0, :cond_9

    :cond_8
    invoke-direct {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->reportOverflowInt()V

    :cond_9
    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->_numberBigDecimal:Ljava/math/BigDecimal;

    invoke-virtual {v0}, Ljava/math/BigDecimal;->intValue()I

    move-result v0

    iput v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->_numberInt:I

    goto :goto_0

    :cond_a
    invoke-static {}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->_throwInternal()V

    goto :goto_0
.end method

.method public final getLongValue()J
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParseException;
        }
    .end annotation

    iget v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->_numTypesValid:I

    and-int/lit8 v0, v0, 0x2

    if-nez v0, :cond_1

    iget v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->_numTypesValid:I

    if-nez v0, :cond_0

    const/4 v0, 0x2

    invoke-direct {p0, v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->parseNumericValue(I)V

    :cond_0
    iget v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->_numTypesValid:I

    and-int/lit8 v0, v0, 0x2

    if-nez v0, :cond_1

    iget v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->_numTypesValid:I

    and-int/lit8 v0, v0, 0x1

    if-eqz v0, :cond_2

    iget v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->_numberInt:I

    int-to-long v0, v0

    iput-wide v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->_numberLong:J

    :goto_0
    iget v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->_numTypesValid:I

    or-int/lit8 v0, v0, 0x2

    iput v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->_numTypesValid:I

    :cond_1
    iget-wide v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->_numberLong:J

    return-wide v0

    :cond_2
    iget v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->_numTypesValid:I

    and-int/lit8 v0, v0, 0x4

    if-eqz v0, :cond_3

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->_numberBigInt:Ljava/math/BigInteger;

    invoke-virtual {v0}, Ljava/math/BigInteger;->longValue()J

    move-result-wide v0

    iput-wide v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->_numberLong:J

    goto :goto_0

    :cond_3
    iget v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->_numTypesValid:I

    and-int/lit8 v0, v0, 0x8

    if-eqz v0, :cond_6

    iget-wide v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->_numberDouble:D

    const-wide/high16 v2, -0x3c20000000000000L    # -9.223372036854776E18

    cmpg-double v0, v0, v2

    if-ltz v0, :cond_4

    iget-wide v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->_numberDouble:D

    const-wide/high16 v2, 0x43e0000000000000L    # 9.223372036854776E18

    cmpl-double v0, v0, v2

    if-lez v0, :cond_5

    :cond_4
    invoke-direct {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->reportOverflowLong()V

    :cond_5
    iget-wide v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->_numberDouble:D

    double-to-long v0, v0

    iput-wide v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->_numberLong:J

    goto :goto_0

    :cond_6
    iget v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->_numTypesValid:I

    and-int/lit8 v0, v0, 0x10

    if-eqz v0, :cond_9

    sget-object v0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->BD_MIN_LONG:Ljava/math/BigDecimal;

    iget-object v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->_numberBigDecimal:Ljava/math/BigDecimal;

    invoke-virtual {v0, v1}, Ljava/math/BigDecimal;->compareTo(Ljava/math/BigDecimal;)I

    move-result v0

    if-gtz v0, :cond_7

    sget-object v0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->BD_MAX_LONG:Ljava/math/BigDecimal;

    iget-object v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->_numberBigDecimal:Ljava/math/BigDecimal;

    invoke-virtual {v0, v1}, Ljava/math/BigDecimal;->compareTo(Ljava/math/BigDecimal;)I

    move-result v0

    if-gez v0, :cond_8

    :cond_7
    invoke-direct {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->reportOverflowLong()V

    :cond_8
    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->_numberBigDecimal:Ljava/math/BigDecimal;

    invoke-virtual {v0}, Ljava/math/BigDecimal;->longValue()J

    move-result-wide v0

    iput-wide v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->_numberLong:J

    goto :goto_0

    :cond_9
    invoke-static {}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->_throwInternal()V

    goto :goto_0
.end method

.method protected final reportInvalidNumber(Ljava/lang/String;)V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParseException;
        }
    .end annotation

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Invalid numeric value: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->_reportError(Ljava/lang/String;)V

    return-void
.end method

.method protected final reportUnexpectedNumberChar(ILjava/lang/String;)V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParseException;
        }
    .end annotation

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Unexpected character ("

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-static {p1}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->_getCharDesc(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ") in numeric value"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    if-eqz p2, :cond_0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ": "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    :cond_0
    invoke-virtual {p0, v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->_reportError(Ljava/lang/String;)V

    return-void
.end method

.method protected final reset(ZIII)Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;
    .locals 1

    iput-boolean p1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->_numberNegative:Z

    iput p2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->mIntLength:I

    iput p3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->mFractLength:I

    iput p4, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->mExpLength:I

    const/4 v0, 0x0

    iput v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonNumericParserBase;->_numTypesValid:I

    if-gtz p3, :cond_0

    if-gtz p4, :cond_0

    sget-object v0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;->VALUE_NUMBER_INT:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;

    :goto_0
    return-object v0

    :cond_0
    sget-object v0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;->VALUE_NUMBER_FLOAT:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;

    goto :goto_0
.end method
