.class public abstract Lcom/openfeint/internal/request/multipart/Part;
.super Ljava/lang/Object;


# static fields
.field protected static final BOUNDARY_BYTES:[B

.field protected static final CHARSET_BYTES:[B

.field protected static final CONTENT_DISPOSITION_BYTES:[B

.field protected static final CONTENT_TRANSFER_ENCODING_BYTES:[B

.field protected static final CONTENT_TYPE_BYTES:[B

.field protected static final CRLF_BYTES:[B

.field private static final DEFAULT_BOUNDARY_BYTES:[B

.field protected static final EXTRA_BYTES:[B

.field protected static final QUOTE_BYTES:[B


# instance fields
.field private boundaryBytes:[B


# direct methods
.method static constructor <clinit>()V
    .locals 1

    const-string v0, "----------------ULTRASONIC_CUPCAKES___-__-"

    invoke-static {v0}, Lcom/openfeint/internal/request/multipart/EncodingUtil;->getAsciiBytes(Ljava/lang/String;)[B

    move-result-object v0

    sput-object v0, Lcom/openfeint/internal/request/multipart/Part;->BOUNDARY_BYTES:[B

    sput-object v0, Lcom/openfeint/internal/request/multipart/Part;->DEFAULT_BOUNDARY_BYTES:[B

    const-string v0, "\r\n"

    invoke-static {v0}, Lcom/openfeint/internal/request/multipart/EncodingUtil;->getAsciiBytes(Ljava/lang/String;)[B

    move-result-object v0

    sput-object v0, Lcom/openfeint/internal/request/multipart/Part;->CRLF_BYTES:[B

    const-string v0, "\""

    invoke-static {v0}, Lcom/openfeint/internal/request/multipart/EncodingUtil;->getAsciiBytes(Ljava/lang/String;)[B

    move-result-object v0

    sput-object v0, Lcom/openfeint/internal/request/multipart/Part;->QUOTE_BYTES:[B

    const-string v0, "--"

    invoke-static {v0}, Lcom/openfeint/internal/request/multipart/EncodingUtil;->getAsciiBytes(Ljava/lang/String;)[B

    move-result-object v0

    sput-object v0, Lcom/openfeint/internal/request/multipart/Part;->EXTRA_BYTES:[B

    const-string v0, "Content-Disposition: form-data; name="

    invoke-static {v0}, Lcom/openfeint/internal/request/multipart/EncodingUtil;->getAsciiBytes(Ljava/lang/String;)[B

    move-result-object v0

    sput-object v0, Lcom/openfeint/internal/request/multipart/Part;->CONTENT_DISPOSITION_BYTES:[B

    const-string v0, "Content-Type: "

    invoke-static {v0}, Lcom/openfeint/internal/request/multipart/EncodingUtil;->getAsciiBytes(Ljava/lang/String;)[B

    move-result-object v0

    sput-object v0, Lcom/openfeint/internal/request/multipart/Part;->CONTENT_TYPE_BYTES:[B

    const-string v0, "; charset="

    invoke-static {v0}, Lcom/openfeint/internal/request/multipart/EncodingUtil;->getAsciiBytes(Ljava/lang/String;)[B

    move-result-object v0

    sput-object v0, Lcom/openfeint/internal/request/multipart/Part;->CHARSET_BYTES:[B

    const-string v0, "Content-Transfer-Encoding: "

    invoke-static {v0}, Lcom/openfeint/internal/request/multipart/EncodingUtil;->getAsciiBytes(Ljava/lang/String;)[B

    move-result-object v0

    sput-object v0, Lcom/openfeint/internal/request/multipart/Part;->CONTENT_TRANSFER_ENCODING_BYTES:[B

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static getLengthOfParts([Lcom/openfeint/internal/request/multipart/Part;[B)J
    .locals 12
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    const-wide/16 v5, -0x1

    const-wide/16 v3, 0x0

    if-nez p0, :cond_0

    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "Parts may not be null"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    :cond_0
    const/4 v0, 0x0

    move-wide v1, v3

    :goto_0
    array-length v7, p0

    if-ge v0, v7, :cond_3

    aget-object v7, p0, v0

    iput-object p1, v7, Lcom/openfeint/internal/request/multipart/Part;->boundaryBytes:[B

    aget-object v7, p0, v0

    invoke-virtual {v7}, Lcom/openfeint/internal/request/multipart/Part;->lengthOfData()J

    move-result-wide v8

    cmp-long v8, v8, v3

    if-gez v8, :cond_1

    move-wide v7, v5

    :goto_1
    cmp-long v9, v7, v3

    if-gez v9, :cond_2

    move-wide v0, v5

    :goto_2
    return-wide v0

    :cond_1
    new-instance v8, Ljava/io/ByteArrayOutputStream;

    invoke-direct {v8}, Ljava/io/ByteArrayOutputStream;-><init>()V

    invoke-direct {v7, v8}, Lcom/openfeint/internal/request/multipart/Part;->sendStart(Ljava/io/OutputStream;)V

    invoke-virtual {v7, v8}, Lcom/openfeint/internal/request/multipart/Part;->sendDispositionHeader(Ljava/io/OutputStream;)V

    invoke-direct {v7, v8}, Lcom/openfeint/internal/request/multipart/Part;->sendContentTypeHeader(Ljava/io/OutputStream;)V

    invoke-direct {v7, v8}, Lcom/openfeint/internal/request/multipart/Part;->sendTransferEncodingHeader(Ljava/io/OutputStream;)V

    invoke-static {v8}, Lcom/openfeint/internal/request/multipart/Part;->sendEndOfHeader(Ljava/io/OutputStream;)V

    sget-object v9, Lcom/openfeint/internal/request/multipart/Part;->CRLF_BYTES:[B

    invoke-virtual {v8, v9}, Ljava/io/OutputStream;->write([B)V

    invoke-virtual {v8}, Ljava/io/ByteArrayOutputStream;->size()I

    move-result v8

    int-to-long v8, v8

    invoke-virtual {v7}, Lcom/openfeint/internal/request/multipart/Part;->lengthOfData()J

    move-result-wide v10

    add-long v7, v8, v10

    goto :goto_1

    :cond_2
    add-long/2addr v1, v7

    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_3
    sget-object v0, Lcom/openfeint/internal/request/multipart/Part;->EXTRA_BYTES:[B

    array-length v0, v0

    int-to-long v3, v0

    add-long v0, v1, v3

    array-length v2, p1

    int-to-long v2, v2

    add-long/2addr v0, v2

    sget-object v2, Lcom/openfeint/internal/request/multipart/Part;->EXTRA_BYTES:[B

    array-length v2, v2

    int-to-long v2, v2

    add-long/2addr v0, v2

    sget-object v2, Lcom/openfeint/internal/request/multipart/Part;->CRLF_BYTES:[B

    array-length v2, v2

    int-to-long v2, v2

    add-long/2addr v0, v2

    goto :goto_2
.end method

.method public static isRepeatable()Z
    .locals 1

    const/4 v0, 0x1

    return v0
.end method

.method private sendContentTypeHeader(Ljava/io/OutputStream;)V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    invoke-virtual {p0}, Lcom/openfeint/internal/request/multipart/Part;->getContentType()Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_0

    sget-object v1, Lcom/openfeint/internal/request/multipart/Part;->CRLF_BYTES:[B

    invoke-virtual {p1, v1}, Ljava/io/OutputStream;->write([B)V

    sget-object v1, Lcom/openfeint/internal/request/multipart/Part;->CONTENT_TYPE_BYTES:[B

    invoke-virtual {p1, v1}, Ljava/io/OutputStream;->write([B)V

    invoke-static {v0}, Lcom/openfeint/internal/request/multipart/EncodingUtil;->getAsciiBytes(Ljava/lang/String;)[B

    move-result-object v0

    invoke-virtual {p1, v0}, Ljava/io/OutputStream;->write([B)V

    invoke-virtual {p0}, Lcom/openfeint/internal/request/multipart/Part;->getCharSet()Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_0

    sget-object v1, Lcom/openfeint/internal/request/multipart/Part;->CHARSET_BYTES:[B

    invoke-virtual {p1, v1}, Ljava/io/OutputStream;->write([B)V

    invoke-static {v0}, Lcom/openfeint/internal/request/multipart/EncodingUtil;->getAsciiBytes(Ljava/lang/String;)[B

    move-result-object v0

    invoke-virtual {p1, v0}, Ljava/io/OutputStream;->write([B)V

    :cond_0
    return-void
.end method

.method private static sendEndOfHeader(Ljava/io/OutputStream;)V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    sget-object v0, Lcom/openfeint/internal/request/multipart/Part;->CRLF_BYTES:[B

    invoke-virtual {p0, v0}, Ljava/io/OutputStream;->write([B)V

    sget-object v0, Lcom/openfeint/internal/request/multipart/Part;->CRLF_BYTES:[B

    invoke-virtual {p0, v0}, Ljava/io/OutputStream;->write([B)V

    return-void
.end method

.method public static sendParts(Ljava/io/OutputStream;[Lcom/openfeint/internal/request/multipart/Part;[B)V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    if-nez p1, :cond_0

    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "Parts may not be null"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    :cond_0
    if-eqz p2, :cond_1

    array-length v0, p2

    if-nez v0, :cond_2

    :cond_1
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "partBoundary may not be empty"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    :cond_2
    const/4 v0, 0x0

    :goto_0
    array-length v1, p1

    if-ge v0, v1, :cond_3

    aget-object v1, p1, v0

    iput-object p2, v1, Lcom/openfeint/internal/request/multipart/Part;->boundaryBytes:[B

    aget-object v1, p1, v0

    invoke-direct {v1, p0}, Lcom/openfeint/internal/request/multipart/Part;->sendStart(Ljava/io/OutputStream;)V

    invoke-virtual {v1, p0}, Lcom/openfeint/internal/request/multipart/Part;->sendDispositionHeader(Ljava/io/OutputStream;)V

    invoke-direct {v1, p0}, Lcom/openfeint/internal/request/multipart/Part;->sendContentTypeHeader(Ljava/io/OutputStream;)V

    invoke-direct {v1, p0}, Lcom/openfeint/internal/request/multipart/Part;->sendTransferEncodingHeader(Ljava/io/OutputStream;)V

    invoke-static {p0}, Lcom/openfeint/internal/request/multipart/Part;->sendEndOfHeader(Ljava/io/OutputStream;)V

    invoke-virtual {v1, p0}, Lcom/openfeint/internal/request/multipart/Part;->sendData(Ljava/io/OutputStream;)V

    sget-object v1, Lcom/openfeint/internal/request/multipart/Part;->CRLF_BYTES:[B

    invoke-virtual {p0, v1}, Ljava/io/OutputStream;->write([B)V

    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_3
    sget-object v0, Lcom/openfeint/internal/request/multipart/Part;->EXTRA_BYTES:[B

    invoke-virtual {p0, v0}, Ljava/io/OutputStream;->write([B)V

    invoke-virtual {p0, p2}, Ljava/io/OutputStream;->write([B)V

    sget-object v0, Lcom/openfeint/internal/request/multipart/Part;->EXTRA_BYTES:[B

    invoke-virtual {p0, v0}, Ljava/io/OutputStream;->write([B)V

    sget-object v0, Lcom/openfeint/internal/request/multipart/Part;->CRLF_BYTES:[B

    invoke-virtual {p0, v0}, Ljava/io/OutputStream;->write([B)V

    return-void
.end method

.method private sendStart(Ljava/io/OutputStream;)V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    sget-object v0, Lcom/openfeint/internal/request/multipart/Part;->EXTRA_BYTES:[B

    invoke-virtual {p1, v0}, Ljava/io/OutputStream;->write([B)V

    iget-object v0, p0, Lcom/openfeint/internal/request/multipart/Part;->boundaryBytes:[B

    if-nez v0, :cond_0

    sget-object v0, Lcom/openfeint/internal/request/multipart/Part;->DEFAULT_BOUNDARY_BYTES:[B

    :goto_0
    invoke-virtual {p1, v0}, Ljava/io/OutputStream;->write([B)V

    sget-object v0, Lcom/openfeint/internal/request/multipart/Part;->CRLF_BYTES:[B

    invoke-virtual {p1, v0}, Ljava/io/OutputStream;->write([B)V

    return-void

    :cond_0
    iget-object v0, p0, Lcom/openfeint/internal/request/multipart/Part;->boundaryBytes:[B

    goto :goto_0
.end method

.method private sendTransferEncodingHeader(Ljava/io/OutputStream;)V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    invoke-virtual {p0}, Lcom/openfeint/internal/request/multipart/Part;->getTransferEncoding()Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_0

    sget-object v1, Lcom/openfeint/internal/request/multipart/Part;->CRLF_BYTES:[B

    invoke-virtual {p1, v1}, Ljava/io/OutputStream;->write([B)V

    sget-object v1, Lcom/openfeint/internal/request/multipart/Part;->CONTENT_TRANSFER_ENCODING_BYTES:[B

    invoke-virtual {p1, v1}, Ljava/io/OutputStream;->write([B)V

    invoke-static {v0}, Lcom/openfeint/internal/request/multipart/EncodingUtil;->getAsciiBytes(Ljava/lang/String;)[B

    move-result-object v0

    invoke-virtual {p1, v0}, Ljava/io/OutputStream;->write([B)V

    :cond_0
    return-void
.end method


# virtual methods
.method public abstract getCharSet()Ljava/lang/String;
.end method

.method public abstract getContentType()Ljava/lang/String;
.end method

.method public abstract getName()Ljava/lang/String;
.end method

.method public abstract getTransferEncoding()Ljava/lang/String;
.end method

.method protected abstract lengthOfData()J
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation
.end method

.method protected abstract sendData(Ljava/io/OutputStream;)V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation
.end method

.method protected sendDispositionHeader(Ljava/io/OutputStream;)V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    sget-object v0, Lcom/openfeint/internal/request/multipart/Part;->CONTENT_DISPOSITION_BYTES:[B

    invoke-virtual {p1, v0}, Ljava/io/OutputStream;->write([B)V

    sget-object v0, Lcom/openfeint/internal/request/multipart/Part;->QUOTE_BYTES:[B

    invoke-virtual {p1, v0}, Ljava/io/OutputStream;->write([B)V

    invoke-virtual {p0}, Lcom/openfeint/internal/request/multipart/Part;->getName()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/openfeint/internal/request/multipart/EncodingUtil;->getAsciiBytes(Ljava/lang/String;)[B

    move-result-object v0

    invoke-virtual {p1, v0}, Ljava/io/OutputStream;->write([B)V

    sget-object v0, Lcom/openfeint/internal/request/multipart/Part;->QUOTE_BYTES:[B

    invoke-virtual {p1, v0}, Ljava/io/OutputStream;->write([B)V

    return-void
.end method

.method public toString()Ljava/lang/String;
    .locals 1

    invoke-virtual {p0}, Lcom/openfeint/internal/request/multipart/Part;->getName()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
