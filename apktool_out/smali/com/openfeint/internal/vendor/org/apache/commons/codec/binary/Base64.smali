.class public final Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;
.super Ljava/lang/Object;


# static fields
.field static final CHUNK_SEPARATOR:[B

.field private static final DECODE_TABLE:[B

.field private static final STANDARD_ENCODE_TABLE:[B

.field private static final URL_SAFE_ENCODE_TABLE:[B


# instance fields
.field private buffer:[B

.field private currentLinePos:I

.field private final decodeSize:I

.field private final encodeSize:I

.field private final encodeTable:[B

.field private eof:Z

.field private final lineLength:I

.field private final lineSeparator:[B

.field private modulus:I

.field private pos:I

.field private readPos:I

.field private x:I


# direct methods
.method static constructor <clinit>()V
    .locals 2

    const/16 v1, 0x40

    const/4 v0, 0x2

    new-array v0, v0, [B

    fill-array-data v0, :array_0

    sput-object v0, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->CHUNK_SEPARATOR:[B

    new-array v0, v1, [B

    fill-array-data v0, :array_1

    sput-object v0, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->STANDARD_ENCODE_TABLE:[B

    new-array v0, v1, [B

    fill-array-data v0, :array_2

    sput-object v0, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->URL_SAFE_ENCODE_TABLE:[B

    const/16 v0, 0x7b

    new-array v0, v0, [B

    fill-array-data v0, :array_3

    sput-object v0, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->DECODE_TABLE:[B

    return-void

    :array_0
    .array-data 1
        0xdt
        0xat
    .end array-data

    nop

    :array_1
    .array-data 1
        0x41t
        0x42t
        0x43t
        0x44t
        0x45t
        0x46t
        0x47t
        0x48t
        0x49t
        0x4at
        0x4bt
        0x4ct
        0x4dt
        0x4et
        0x4ft
        0x50t
        0x51t
        0x52t
        0x53t
        0x54t
        0x55t
        0x56t
        0x57t
        0x58t
        0x59t
        0x5at
        0x61t
        0x62t
        0x63t
        0x64t
        0x65t
        0x66t
        0x67t
        0x68t
        0x69t
        0x6at
        0x6bt
        0x6ct
        0x6dt
        0x6et
        0x6ft
        0x70t
        0x71t
        0x72t
        0x73t
        0x74t
        0x75t
        0x76t
        0x77t
        0x78t
        0x79t
        0x7at
        0x30t
        0x31t
        0x32t
        0x33t
        0x34t
        0x35t
        0x36t
        0x37t
        0x38t
        0x39t
        0x2bt
        0x2ft
    .end array-data

    :array_2
    .array-data 1
        0x41t
        0x42t
        0x43t
        0x44t
        0x45t
        0x46t
        0x47t
        0x48t
        0x49t
        0x4at
        0x4bt
        0x4ct
        0x4dt
        0x4et
        0x4ft
        0x50t
        0x51t
        0x52t
        0x53t
        0x54t
        0x55t
        0x56t
        0x57t
        0x58t
        0x59t
        0x5at
        0x61t
        0x62t
        0x63t
        0x64t
        0x65t
        0x66t
        0x67t
        0x68t
        0x69t
        0x6at
        0x6bt
        0x6ct
        0x6dt
        0x6et
        0x6ft
        0x70t
        0x71t
        0x72t
        0x73t
        0x74t
        0x75t
        0x76t
        0x77t
        0x78t
        0x79t
        0x7at
        0x30t
        0x31t
        0x32t
        0x33t
        0x34t
        0x35t
        0x36t
        0x37t
        0x38t
        0x39t
        0x2dt
        0x5ft
    .end array-data

    :array_3
    .array-data 1
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        0x3et
        -0x1t
        0x3et
        -0x1t
        0x3ft
        0x34t
        0x35t
        0x36t
        0x37t
        0x38t
        0x39t
        0x3at
        0x3bt
        0x3ct
        0x3dt
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        0x0t
        0x1t
        0x2t
        0x3t
        0x4t
        0x5t
        0x6t
        0x7t
        0x8t
        0x9t
        0xat
        0xbt
        0xct
        0xdt
        0xet
        0xft
        0x10t
        0x11t
        0x12t
        0x13t
        0x14t
        0x15t
        0x16t
        0x17t
        0x18t
        0x19t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        0x3ft
        -0x1t
        0x1at
        0x1bt
        0x1ct
        0x1dt
        0x1et
        0x1ft
        0x20t
        0x21t
        0x22t
        0x23t
        0x24t
        0x25t
        0x26t
        0x27t
        0x28t
        0x29t
        0x2at
        0x2bt
        0x2ct
        0x2dt
        0x2et
        0x2ft
        0x30t
        0x31t
        0x32t
        0x33t
    .end array-data
.end method

.method private constructor <init>()V
    .locals 2

    const/16 v0, 0x4c

    sget-object v1, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->CHUNK_SEPARATOR:[B

    invoke-direct {p0, v0, v1}, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;-><init>(I[B)V

    return-void
.end method

.method private constructor <init>(I[B)V
    .locals 4

    const/4 v1, 0x0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    if-nez p2, :cond_0

    sget-object p2, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->CHUNK_SEPARATOR:[B

    move p1, v1

    :cond_0
    if-lez p1, :cond_1

    div-int/lit8 v0, p1, 0x4

    mul-int/lit8 v0, v0, 0x4

    :goto_0
    iput v0, p0, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->lineLength:I

    array-length v0, p2

    new-array v0, v0, [B

    iput-object v0, p0, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->lineSeparator:[B

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->lineSeparator:[B

    array-length v2, p2

    invoke-static {p2, v1, v0, v1, v2}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    if-lez p1, :cond_2

    array-length v0, p2

    add-int/lit8 v0, v0, 0x4

    iput v0, p0, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->encodeSize:I

    :goto_1
    iget v0, p0, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->encodeSize:I

    add-int/lit8 v0, v0, -0x1

    iput v0, p0, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->decodeSize:I

    invoke-static {p2}, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->containsBase64Byte([B)Z

    move-result v0

    if-eqz v0, :cond_3

    const-string v0, "UTF-8"

    invoke-static {p2, v0}, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/StringUtils;->newString([BLjava/lang/String;)Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/lang/IllegalArgumentException;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "lineSeperator must not contain base64 characters: ["

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v2, "]"

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {v1, v0}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v1

    :cond_1
    move v0, v1

    goto :goto_0

    :cond_2
    const/4 v0, 0x4

    iput v0, p0, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->encodeSize:I

    goto :goto_1

    :cond_3
    sget-object v0, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->STANDARD_ENCODE_TABLE:[B

    iput-object v0, p0, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->encodeTable:[B

    return-void
.end method

.method private static containsBase64Byte([B)Z
    .locals 5

    const/4 v2, 0x1

    const/4 v1, 0x0

    move v0, v1

    :goto_0
    array-length v3, p0

    if-ge v0, v3, :cond_1

    aget-byte v3, p0, v0

    const/16 v4, 0x3d

    if-eq v3, v4, :cond_0

    if-ltz v3, :cond_2

    sget-object v4, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->DECODE_TABLE:[B

    array-length v4, v4

    if-ge v3, v4, :cond_2

    sget-object v4, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->DECODE_TABLE:[B

    aget-byte v3, v4, v3

    const/4 v4, -0x1

    if-eq v3, v4, :cond_2

    :cond_0
    move v3, v2

    :goto_1
    if-eqz v3, :cond_3

    move v1, v2

    :cond_1
    return v1

    :cond_2
    move v3, v1

    goto :goto_1

    :cond_3
    add-int/lit8 v0, v0, 0x1

    goto :goto_0
.end method

.method private encode([BII)V
    .locals 7

    const/16 v5, 0x3d

    const/4 v2, 0x0

    iget-boolean v0, p0, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->eof:Z

    if-eqz v0, :cond_1

    :cond_0
    :goto_0
    return-void

    :cond_1
    if-gez p3, :cond_5

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->eof:Z

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->buffer:[B

    if-eqz v0, :cond_2

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->buffer:[B

    array-length v0, v0

    iget v1, p0, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->pos:I

    sub-int/2addr v0, v1

    iget v1, p0, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->encodeSize:I

    if-ge v0, v1, :cond_3

    :cond_2
    invoke-direct {p0}, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->resizeBuffer()V

    :cond_3
    iget v0, p0, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->modulus:I

    packed-switch v0, :pswitch_data_0

    :cond_4
    :goto_1
    iget v0, p0, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->lineLength:I

    if-lez v0, :cond_0

    iget v0, p0, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->pos:I

    if-lez v0, :cond_0

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->lineSeparator:[B

    iget-object v1, p0, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->buffer:[B

    iget v3, p0, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->pos:I

    iget-object v4, p0, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->lineSeparator:[B

    array-length v4, v4

    invoke-static {v0, v2, v1, v3, v4}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    iget v0, p0, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->pos:I

    iget-object v1, p0, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->lineSeparator:[B

    array-length v1, v1

    add-int/2addr v0, v1

    iput v0, p0, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->pos:I

    goto :goto_0

    :pswitch_0
    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->buffer:[B

    iget v1, p0, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->pos:I

    add-int/lit8 v3, v1, 0x1

    iput v3, p0, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->pos:I

    iget-object v3, p0, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->encodeTable:[B

    iget v4, p0, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->x:I

    shr-int/lit8 v4, v4, 0x2

    and-int/lit8 v4, v4, 0x3f

    aget-byte v3, v3, v4

    aput-byte v3, v0, v1

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->buffer:[B

    iget v1, p0, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->pos:I

    add-int/lit8 v3, v1, 0x1

    iput v3, p0, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->pos:I

    iget-object v3, p0, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->encodeTable:[B

    iget v4, p0, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->x:I

    shl-int/lit8 v4, v4, 0x4

    and-int/lit8 v4, v4, 0x3f

    aget-byte v3, v3, v4

    aput-byte v3, v0, v1

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->encodeTable:[B

    sget-object v1, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->STANDARD_ENCODE_TABLE:[B

    if-ne v0, v1, :cond_4

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->buffer:[B

    iget v1, p0, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->pos:I

    add-int/lit8 v3, v1, 0x1

    iput v3, p0, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->pos:I

    aput-byte v5, v0, v1

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->buffer:[B

    iget v1, p0, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->pos:I

    add-int/lit8 v3, v1, 0x1

    iput v3, p0, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->pos:I

    aput-byte v5, v0, v1

    goto :goto_1

    :pswitch_1
    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->buffer:[B

    iget v1, p0, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->pos:I

    add-int/lit8 v3, v1, 0x1

    iput v3, p0, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->pos:I

    iget-object v3, p0, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->encodeTable:[B

    iget v4, p0, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->x:I

    shr-int/lit8 v4, v4, 0xa

    and-int/lit8 v4, v4, 0x3f

    aget-byte v3, v3, v4

    aput-byte v3, v0, v1

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->buffer:[B

    iget v1, p0, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->pos:I

    add-int/lit8 v3, v1, 0x1

    iput v3, p0, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->pos:I

    iget-object v3, p0, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->encodeTable:[B

    iget v4, p0, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->x:I

    shr-int/lit8 v4, v4, 0x4

    and-int/lit8 v4, v4, 0x3f

    aget-byte v3, v3, v4

    aput-byte v3, v0, v1

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->buffer:[B

    iget v1, p0, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->pos:I

    add-int/lit8 v3, v1, 0x1

    iput v3, p0, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->pos:I

    iget-object v3, p0, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->encodeTable:[B

    iget v4, p0, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->x:I

    shl-int/lit8 v4, v4, 0x2

    and-int/lit8 v4, v4, 0x3f

    aget-byte v3, v3, v4

    aput-byte v3, v0, v1

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->encodeTable:[B

    sget-object v1, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->STANDARD_ENCODE_TABLE:[B

    if-ne v0, v1, :cond_4

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->buffer:[B

    iget v1, p0, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->pos:I

    add-int/lit8 v3, v1, 0x1

    iput v3, p0, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->pos:I

    aput-byte v5, v0, v1

    goto/16 :goto_1

    :cond_5
    move v1, v2

    :goto_2
    if-ge v1, p3, :cond_0

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->buffer:[B

    if-eqz v0, :cond_6

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->buffer:[B

    array-length v0, v0

    iget v3, p0, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->pos:I

    sub-int/2addr v0, v3

    iget v3, p0, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->encodeSize:I

    if-ge v0, v3, :cond_7

    :cond_6
    invoke-direct {p0}, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->resizeBuffer()V

    :cond_7
    iget v0, p0, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->modulus:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->modulus:I

    rem-int/lit8 v0, v0, 0x3

    iput v0, p0, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->modulus:I

    add-int/lit8 v3, p2, 0x1

    aget-byte v0, p1, p2

    if-gez v0, :cond_8

    add-int/lit16 v0, v0, 0x100

    :cond_8
    iget v4, p0, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->x:I

    shl-int/lit8 v4, v4, 0x8

    add-int/2addr v0, v4

    iput v0, p0, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->x:I

    iget v0, p0, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->modulus:I

    if-nez v0, :cond_9

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->buffer:[B

    iget v4, p0, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->pos:I

    add-int/lit8 v5, v4, 0x1

    iput v5, p0, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->pos:I

    iget-object v5, p0, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->encodeTable:[B

    iget v6, p0, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->x:I

    shr-int/lit8 v6, v6, 0x12

    and-int/lit8 v6, v6, 0x3f

    aget-byte v5, v5, v6

    aput-byte v5, v0, v4

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->buffer:[B

    iget v4, p0, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->pos:I

    add-int/lit8 v5, v4, 0x1

    iput v5, p0, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->pos:I

    iget-object v5, p0, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->encodeTable:[B

    iget v6, p0, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->x:I

    shr-int/lit8 v6, v6, 0xc

    and-int/lit8 v6, v6, 0x3f

    aget-byte v5, v5, v6

    aput-byte v5, v0, v4

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->buffer:[B

    iget v4, p0, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->pos:I

    add-int/lit8 v5, v4, 0x1

    iput v5, p0, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->pos:I

    iget-object v5, p0, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->encodeTable:[B

    iget v6, p0, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->x:I

    shr-int/lit8 v6, v6, 0x6

    and-int/lit8 v6, v6, 0x3f

    aget-byte v5, v5, v6

    aput-byte v5, v0, v4

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->buffer:[B

    iget v4, p0, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->pos:I

    add-int/lit8 v5, v4, 0x1

    iput v5, p0, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->pos:I

    iget-object v5, p0, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->encodeTable:[B

    iget v6, p0, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->x:I

    and-int/lit8 v6, v6, 0x3f

    aget-byte v5, v5, v6

    aput-byte v5, v0, v4

    iget v0, p0, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->currentLinePos:I

    add-int/lit8 v0, v0, 0x4

    iput v0, p0, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->currentLinePos:I

    iget v0, p0, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->lineLength:I

    if-lez v0, :cond_9

    iget v0, p0, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->lineLength:I

    iget v4, p0, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->currentLinePos:I

    if-gt v0, v4, :cond_9

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->lineSeparator:[B

    iget-object v4, p0, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->buffer:[B

    iget v5, p0, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->pos:I

    iget-object v6, p0, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->lineSeparator:[B

    array-length v6, v6

    invoke-static {v0, v2, v4, v5, v6}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    iget v0, p0, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->pos:I

    iget-object v4, p0, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->lineSeparator:[B

    array-length v4, v4

    add-int/2addr v0, v4

    iput v0, p0, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->pos:I

    iput v2, p0, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->currentLinePos:I

    :cond_9
    add-int/lit8 v0, v1, 0x1

    move v1, v0

    move p2, v3

    goto/16 :goto_2

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_0
        :pswitch_1
    .end packed-switch
.end method

.method public static encodeBase64([B)[B
    .locals 7

    const/4 v6, 0x0

    const/4 v1, 0x0

    if-eqz p0, :cond_0

    array-length v0, p0

    if-nez v0, :cond_1

    :cond_0
    :goto_0
    return-object p0

    :cond_1
    const/16 v0, 0x4c

    sget-object v2, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->CHUNK_SEPARATOR:[B

    invoke-static {p0, v0, v2}, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->getEncodeLength([BI[B)J

    move-result-wide v2

    const-wide/32 v4, 0x7fffffff

    cmp-long v0, v2, v4

    if-lez v0, :cond_2

    new-instance v0, Ljava/lang/IllegalArgumentException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Input array too big, the output array would be bigger ("

    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2, v3}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ") than the specified maxium size of "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const v2, 0x7fffffff

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    :cond_2
    new-instance v3, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;

    sget-object v0, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->CHUNK_SEPARATOR:[B

    invoke-direct {v3, v1, v0}, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;-><init>(I[B)V

    iput-object v6, v3, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->buffer:[B

    iput v1, v3, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->pos:I

    iput v1, v3, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->readPos:I

    iput v1, v3, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->currentLinePos:I

    iput v1, v3, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->modulus:I

    iput-boolean v1, v3, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->eof:Z

    if-eqz p0, :cond_0

    array-length v0, p0

    if-eqz v0, :cond_0

    iget v0, v3, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->lineLength:I

    iget-object v2, v3, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->lineSeparator:[B

    invoke-static {p0, v0, v2}, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->getEncodeLength([BI[B)J

    move-result-wide v4

    long-to-int v0, v4

    new-array v2, v0, [B

    array-length v0, v2

    array-length v4, v2

    if-ne v4, v0, :cond_3

    iput-object v2, v3, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->buffer:[B

    iput v1, v3, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->pos:I

    iput v1, v3, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->readPos:I

    :cond_3
    array-length v0, p0

    invoke-direct {v3, p0, v1, v0}, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->encode([BII)V

    const/4 v0, -0x1

    invoke-direct {v3, p0, v1, v0}, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->encode([BII)V

    iget-object v0, v3, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->buffer:[B

    if-eq v0, v2, :cond_5

    array-length v4, v2

    iget-object v0, v3, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->buffer:[B

    if-eqz v0, :cond_7

    iget-object v0, v3, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->buffer:[B

    if-eqz v0, :cond_6

    iget v0, v3, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->pos:I

    iget v5, v3, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->readPos:I

    sub-int/2addr v0, v5

    :goto_1
    invoke-static {v0, v4}, Ljava/lang/Math;->min(II)I

    move-result v0

    iget-object v4, v3, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->buffer:[B

    if-eq v4, v2, :cond_4

    iget-object v4, v3, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->buffer:[B

    iget v5, v3, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->readPos:I

    invoke-static {v4, v5, v2, v1, v0}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    iget v4, v3, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->readPos:I

    add-int/2addr v0, v4

    iput v0, v3, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->readPos:I

    iget v0, v3, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->readPos:I

    iget v4, v3, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->pos:I

    if-lt v0, v4, :cond_5

    :cond_4
    iput-object v6, v3, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->buffer:[B

    :cond_5
    :goto_2
    iget-object v0, v3, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->encodeTable:[B

    sget-object v4, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->URL_SAFE_ENCODE_TABLE:[B

    if-ne v0, v4, :cond_8

    const/4 v0, 0x1

    :goto_3
    if-eqz v0, :cond_9

    iget v0, v3, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->pos:I

    array-length v4, v2

    if-ge v0, v4, :cond_9

    iget v0, v3, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->pos:I

    new-array v0, v0, [B

    iget v3, v3, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->pos:I

    invoke-static {v2, v1, v0, v1, v3}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    :goto_4
    move-object p0, v0

    goto/16 :goto_0

    :cond_6
    move v0, v1

    goto :goto_1

    :cond_7
    iget-boolean v0, v3, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->eof:Z

    goto :goto_2

    :cond_8
    move v0, v1

    goto :goto_3

    :cond_9
    move-object v0, v2

    goto :goto_4
.end method

.method private static getEncodeLength([BI[B)J
    .locals 10

    const-wide/16 v8, 0x4

    const-wide/16 v6, 0x0

    div-int/lit8 v0, p1, 0x4

    mul-int/lit8 v3, v0, 0x4

    array-length v0, p0

    mul-int/lit8 v0, v0, 0x4

    div-int/lit8 v0, v0, 0x3

    int-to-long v1, v0

    rem-long v4, v1, v8

    cmp-long v0, v4, v6

    if-eqz v0, :cond_0

    sub-long v4, v8, v4

    add-long/2addr v1, v4

    :cond_0
    if-lez v3, :cond_2

    int-to-long v4, v3

    rem-long v4, v1, v4

    cmp-long v0, v4, v6

    if-nez v0, :cond_1

    const/4 v0, 0x1

    :goto_0
    int-to-long v3, v3

    div-long v3, v1, v3

    array-length v5, p2

    int-to-long v5, v5

    mul-long/2addr v3, v5

    add-long/2addr v1, v3

    if-nez v0, :cond_2

    array-length v0, p2

    int-to-long v3, v0

    add-long v0, v1, v3

    :goto_1
    return-wide v0

    :cond_1
    const/4 v0, 0x0

    goto :goto_0

    :cond_2
    move-wide v0, v1

    goto :goto_1
.end method

.method private resizeBuffer()V
    .locals 4

    const/4 v3, 0x0

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->buffer:[B

    if-nez v0, :cond_0

    const/16 v0, 0x2000

    new-array v0, v0, [B

    iput-object v0, p0, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->buffer:[B

    iput v3, p0, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->pos:I

    iput v3, p0, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->readPos:I

    :goto_0
    return-void

    :cond_0
    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->buffer:[B

    array-length v0, v0

    mul-int/lit8 v0, v0, 0x2

    new-array v0, v0, [B

    iget-object v1, p0, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->buffer:[B

    iget-object v2, p0, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->buffer:[B

    array-length v2, v2

    invoke-static {v1, v3, v0, v3, v2}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    iput-object v0, p0, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Base64;->buffer:[B

    goto :goto_0
.end method
