.class public final Lcom/openfeint/internal/request/Compression;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/openfeint/internal/request/Compression$1;,
        Lcom/openfeint/internal/request/Compression$CompressionMethod;
    }
.end annotation


# static fields
.field private static final MagicHeader:[B

.field private static TAG:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    const-string v0, "Compression"

    sput-object v0, Lcom/openfeint/internal/request/Compression;->TAG:Ljava/lang/String;

    const-string v0, "OFZLHDR0"

    invoke-virtual {v0}, Ljava/lang/String;->getBytes()[B

    move-result-object v0

    sput-object v0, Lcom/openfeint/internal/request/Compression;->MagicHeader:[B

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static _compress([B)[B
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    new-instance v0, Ljava/io/ByteArrayOutputStream;

    invoke-direct {v0}, Ljava/io/ByteArrayOutputStream;-><init>()V

    new-instance v1, Ljava/util/zip/DeflaterOutputStream;

    invoke-direct {v1, v0}, Ljava/util/zip/DeflaterOutputStream;-><init>(Ljava/io/OutputStream;)V

    invoke-virtual {v1, p0}, Ljava/util/zip/DeflaterOutputStream;->write([B)V

    invoke-virtual {v1}, Ljava/util/zip/DeflaterOutputStream;->close()V

    invoke-virtual {v0}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v0

    return-object v0
.end method

.method public static compress([B)[B
    .locals 9

    const/high16 v8, 0x42c80000    # 100.0f

    :try_start_0
    sget-object v0, Lcom/openfeint/internal/request/Compression$1;->$SwitchMap$com$openfeint$internal$request$Compression$CompressionMethod:[I

    invoke-static {}, Lcom/openfeint/internal/request/Compression;->compressionMethod()Lcom/openfeint/internal/request/Compression$CompressionMethod;

    move-result-object v1

    invoke-virtual {v1}, Lcom/openfeint/internal/request/Compression$CompressionMethod;->ordinal()I

    move-result v1

    aget v0, v0, v1

    packed-switch v0, :pswitch_data_0

    sget-object v0, Lcom/openfeint/internal/request/Compression;->TAG:Ljava/lang/String;

    const-string v1, "Using Uncompressed strategy"

    invoke-static {v0, v1}, Lcom/openfeint/internal/logcat/OFLog;->i(Ljava/lang/String;Ljava/lang/String;)V

    :goto_0
    return-object p0

    :pswitch_0
    invoke-static {p0}, Lcom/openfeint/internal/request/Compression;->_compress([B)[B

    move-result-object v1

    array-length v0, p0

    const/4 v2, 0x4

    new-array v2, v2, [B

    const/4 v3, 0x0

    shr-int/lit8 v4, v0, 0x0

    int-to-byte v4, v4

    aput-byte v4, v2, v3

    const/4 v3, 0x1

    shr-int/lit8 v4, v0, 0x8

    int-to-byte v4, v4

    aput-byte v4, v2, v3

    const/4 v3, 0x2

    shr-int/lit8 v4, v0, 0x10

    int-to-byte v4, v4

    aput-byte v4, v2, v3

    const/4 v3, 0x3

    shr-int/lit8 v0, v0, 0x18

    int-to-byte v0, v0

    aput-byte v0, v2, v3

    array-length v0, v1

    sget-object v3, Lcom/openfeint/internal/request/Compression;->MagicHeader:[B

    array-length v3, v3

    add-int/2addr v0, v3

    array-length v3, v2

    add-int/2addr v3, v0

    array-length v0, p0

    if-ge v3, v0, :cond_0

    new-array v0, v3, [B

    sget-object v4, Lcom/openfeint/internal/request/Compression;->MagicHeader:[B

    const/4 v5, 0x0

    const/4 v6, 0x0

    sget-object v7, Lcom/openfeint/internal/request/Compression;->MagicHeader:[B

    array-length v7, v7

    invoke-static {v4, v5, v0, v6, v7}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    const/4 v4, 0x0

    sget-object v5, Lcom/openfeint/internal/request/Compression;->MagicHeader:[B

    array-length v5, v5

    array-length v6, v2

    invoke-static {v2, v4, v0, v5, v6}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    const/4 v2, 0x0

    sget-object v4, Lcom/openfeint/internal/request/Compression;->MagicHeader:[B

    array-length v4, v4

    add-int/lit8 v4, v4, 0x4

    array-length v5, v1

    invoke-static {v1, v2, v0, v4, v5}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    sget-object v1, Lcom/openfeint/internal/request/Compression;->TAG:Ljava/lang/String;

    const-string v2, "Using Default strategy: orig %d bytes, compressed %d bytes (%.2f%% of original size)"

    const/4 v4, 0x3

    new-array v4, v4, [Ljava/lang/Object;

    const/4 v5, 0x0

    array-length v6, p0

    invoke-static {v6}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v6

    aput-object v6, v4, v5

    const/4 v5, 0x1

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v6

    aput-object v6, v4, v5

    const/4 v5, 0x2

    int-to-float v3, v3

    array-length v6, p0

    int-to-float v6, v6

    div-float/2addr v3, v6

    mul-float/2addr v3, v8

    invoke-static {v3}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object v3

    aput-object v3, v4, v5

    invoke-static {v2, v4}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/openfeint/internal/logcat/OFLog;->i(Ljava/lang/String;Ljava/lang/String;)V

    move-object p0, v0

    goto :goto_0

    :cond_0
    sget-object v0, Lcom/openfeint/internal/request/Compression;->TAG:Ljava/lang/String;

    const-string v1, "Using Default strategy: compression declined"

    invoke-static {v0, v1}, Lcom/openfeint/internal/logcat/OFLog;->i(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0

    :catch_0
    move-exception v0

    const/4 p0, 0x0

    goto :goto_0

    :pswitch_1
    invoke-static {p0}, Lcom/openfeint/internal/request/Compression;->_compress([B)[B

    move-result-object v0

    sget-object v1, Lcom/openfeint/internal/request/Compression;->TAG:Ljava/lang/String;

    const-string v2, "Using Default strategy: orig %d bytes, compressed %d bytes (%.2f%% of original size)"

    const/4 v3, 0x3

    new-array v3, v3, [Ljava/lang/Object;

    const/4 v4, 0x0

    array-length v5, p0

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    aput-object v5, v3, v4

    const/4 v4, 0x1

    array-length v5, v0

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    aput-object v5, v3, v4

    const/4 v4, 0x2

    array-length v5, v0

    int-to-float v5, v5

    array-length v6, p0

    int-to-float v6, v6

    div-float/2addr v5, v6

    mul-float/2addr v5, v8

    invoke-static {v5}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object v5

    aput-object v5, v3, v4

    invoke-static {v2, v3}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/openfeint/internal/logcat/OFLog;->i(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    move-object p0, v0

    goto/16 :goto_0

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_0
        :pswitch_1
    .end packed-switch
.end method

.method private static compressionMethod()Lcom/openfeint/internal/request/Compression$CompressionMethod;
    .locals 2

    invoke-static {}, Lcom/openfeint/internal/OpenFeintInternal;->getInstance()Lcom/openfeint/internal/OpenFeintInternal;

    move-result-object v0

    invoke-virtual {v0}, Lcom/openfeint/internal/OpenFeintInternal;->getSettings()Ljava/util/Map;

    move-result-object v0

    const-string v1, "SettingCloudStorageCompressionStrategy"

    invoke-interface {v0, v1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    if-eqz v0, :cond_1

    const-string v1, "CloudStorageCompressionStrategyLegacyHeaderlessCompression"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    sget-object v0, Lcom/openfeint/internal/request/Compression$CompressionMethod;->LegacyHeaderless:Lcom/openfeint/internal/request/Compression$CompressionMethod;

    :goto_0
    return-object v0

    :cond_0
    const-string v1, "CloudStorageCompressionStrategyNoCompression"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    sget-object v0, Lcom/openfeint/internal/request/Compression$CompressionMethod;->Uncompressed:Lcom/openfeint/internal/request/Compression$CompressionMethod;

    goto :goto_0

    :cond_1
    sget-object v0, Lcom/openfeint/internal/request/Compression$CompressionMethod;->Default:Lcom/openfeint/internal/request/Compression$CompressionMethod;

    goto :goto_0
.end method

.method public static decompress([B)[B
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    sget-object v0, Lcom/openfeint/internal/request/Compression$1;->$SwitchMap$com$openfeint$internal$request$Compression$CompressionMethod:[I

    invoke-static {}, Lcom/openfeint/internal/request/Compression;->compressionMethod()Lcom/openfeint/internal/request/Compression$CompressionMethod;

    move-result-object v1

    invoke-virtual {v1}, Lcom/openfeint/internal/request/Compression$CompressionMethod;->ordinal()I

    move-result v1

    aget v0, v0, v1

    packed-switch v0, :pswitch_data_0

    :cond_0
    :goto_0
    return-object p0

    :pswitch_0
    const/4 v0, 0x0

    sget-object v1, Lcom/openfeint/internal/request/Compression;->MagicHeader:[B

    array-length v1, v1

    array-length v2, p0

    if-ge v1, v2, :cond_1

    :goto_1
    sget-object v1, Lcom/openfeint/internal/request/Compression;->MagicHeader:[B

    array-length v1, v1

    if-ge v0, v1, :cond_1

    sget-object v1, Lcom/openfeint/internal/request/Compression;->MagicHeader:[B

    aget-byte v1, v1, v0

    aget-byte v2, p0, v0

    if-ne v1, v2, :cond_1

    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    :cond_1
    sget-object v1, Lcom/openfeint/internal/request/Compression;->MagicHeader:[B

    array-length v1, v1

    if-ne v0, v1, :cond_0

    sget-object v0, Lcom/openfeint/internal/request/Compression;->MagicHeader:[B

    array-length v0, v0

    add-int/lit8 v0, v0, 0x4

    new-instance v1, Ljava/io/ByteArrayInputStream;

    array-length v2, p0

    sub-int/2addr v2, v0

    invoke-direct {v1, p0, v0, v2}, Ljava/io/ByteArrayInputStream;-><init>([BII)V

    new-instance v0, Ljava/util/zip/InflaterInputStream;

    invoke-direct {v0, v1}, Ljava/util/zip/InflaterInputStream;-><init>(Ljava/io/InputStream;)V

    invoke-static {v0}, Lcom/openfeint/internal/Util;->toByteArray(Ljava/io/InputStream;)[B

    move-result-object p0

    goto :goto_0

    :pswitch_1
    new-instance v0, Ljava/util/zip/InflaterInputStream;

    new-instance v1, Ljava/io/ByteArrayInputStream;

    invoke-direct {v1, p0}, Ljava/io/ByteArrayInputStream;-><init>([B)V

    invoke-direct {v0, v1}, Ljava/util/zip/InflaterInputStream;-><init>(Ljava/io/InputStream;)V

    invoke-static {v0}, Lcom/openfeint/internal/Util;->toByteArray(Ljava/io/InputStream;)[B

    move-result-object p0

    goto :goto_0

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_0
        :pswitch_1
    .end packed-switch
.end method
