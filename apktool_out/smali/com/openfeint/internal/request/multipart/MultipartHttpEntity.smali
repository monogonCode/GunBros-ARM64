.class public final Lcom/openfeint/internal/request/multipart/MultipartHttpEntity;
.super Ljava/lang/Object;

# interfaces
.implements Lorg/apache/http/HttpEntity;


# static fields
.field private static MULTIPART_CHARS:[B


# instance fields
.field private multipartBoundary:[B

.field protected parts:[Lcom/openfeint/internal/request/multipart/Part;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    const-string v0, "-_1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"

    invoke-static {v0}, Lcom/openfeint/internal/request/multipart/EncodingUtil;->getAsciiBytes(Ljava/lang/String;)[B

    move-result-object v0

    sput-object v0, Lcom/openfeint/internal/request/multipart/MultipartHttpEntity;->MULTIPART_CHARS:[B

    return-void
.end method

.method public constructor <init>([Lcom/openfeint/internal/request/multipart/Part;)V
    .locals 2

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    if-nez p1, :cond_0

    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "parts cannot be null"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    :cond_0
    iput-object p1, p0, Lcom/openfeint/internal/request/multipart/MultipartHttpEntity;->parts:[Lcom/openfeint/internal/request/multipart/Part;

    return-void
.end method

.method private getMultipartBoundary()[B
    .locals 5

    iget-object v0, p0, Lcom/openfeint/internal/request/multipart/MultipartHttpEntity;->multipartBoundary:[B

    if-nez v0, :cond_1

    new-instance v1, Ljava/util/Random;

    invoke-direct {v1}, Ljava/util/Random;-><init>()V

    const/16 v0, 0xb

    invoke-virtual {v1, v0}, Ljava/util/Random;->nextInt(I)I

    move-result v0

    add-int/lit8 v0, v0, 0x1e

    new-array v2, v0, [B

    const/4 v0, 0x0

    :goto_0
    array-length v3, v2

    if-ge v0, v3, :cond_0

    sget-object v3, Lcom/openfeint/internal/request/multipart/MultipartHttpEntity;->MULTIPART_CHARS:[B

    sget-object v4, Lcom/openfeint/internal/request/multipart/MultipartHttpEntity;->MULTIPART_CHARS:[B

    array-length v4, v4

    invoke-virtual {v1, v4}, Ljava/util/Random;->nextInt(I)I

    move-result v4

    aget-byte v3, v3, v4

    aput-byte v3, v2, v0

    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_0
    iput-object v2, p0, Lcom/openfeint/internal/request/multipart/MultipartHttpEntity;->multipartBoundary:[B

    :cond_1
    iget-object v0, p0, Lcom/openfeint/internal/request/multipart/MultipartHttpEntity;->multipartBoundary:[B

    return-object v0
.end method


# virtual methods
.method public final consumeContent()V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    new-instance v0, Ljava/lang/UnsupportedOperationException;

    invoke-direct {v0}, Ljava/lang/UnsupportedOperationException;-><init>()V

    throw v0
.end method

.method public final getContent()Ljava/io/InputStream;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljava/lang/IllegalStateException;
        }
    .end annotation

    new-instance v0, Ljava/lang/UnsupportedOperationException;

    invoke-direct {v0}, Ljava/lang/UnsupportedOperationException;-><init>()V

    throw v0
.end method

.method public final getContentEncoding()Lorg/apache/http/Header;
    .locals 3

    new-instance v0, Lorg/apache/http/message/BasicHeader;

    const-string v1, "Content-Encoding"

    const-string v2, "text/html; charset=UTF-8"

    invoke-direct {v0, v1, v2}, Lorg/apache/http/message/BasicHeader;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    return-object v0
.end method

.method public final getContentLength()J
    .locals 2

    :try_start_0
    iget-object v0, p0, Lcom/openfeint/internal/request/multipart/MultipartHttpEntity;->parts:[Lcom/openfeint/internal/request/multipart/Part;

    invoke-direct {p0}, Lcom/openfeint/internal/request/multipart/MultipartHttpEntity;->getMultipartBoundary()[B

    move-result-object v1

    invoke-static {v0, v1}, Lcom/openfeint/internal/request/multipart/Part;->getLengthOfParts([Lcom/openfeint/internal/request/multipart/Part;[B)J
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result-wide v0

    :goto_0
    return-wide v0

    :catch_0
    move-exception v0

    const-string v0, "MultipartRequestEntity"

    const-string v1, "An exception occurred while getting the length of the parts"

    invoke-static {v0, v1}, Lcom/openfeint/internal/logcat/OFLog;->e(Ljava/lang/String;Ljava/lang/String;)V

    const-wide/16 v0, 0x0

    goto :goto_0
.end method

.method public final getContentType()Lorg/apache/http/Header;
    .locals 3

    new-instance v0, Ljava/lang/StringBuffer;

    const-string v1, "multipart/form-data"

    invoke-direct {v0, v1}, Ljava/lang/StringBuffer;-><init>(Ljava/lang/String;)V

    const-string v1, "; boundary="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    invoke-direct {p0}, Lcom/openfeint/internal/request/multipart/MultipartHttpEntity;->getMultipartBoundary()[B

    move-result-object v1

    array-length v2, v1

    invoke-static {v1, v2}, Lcom/openfeint/internal/request/multipart/EncodingUtil;->getAsciiString$55a39fc4([BI)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    new-instance v1, Lorg/apache/http/message/BasicHeader;

    const-string v2, "Content-Type"

    invoke-virtual {v0}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {v1, v2, v0}, Lorg/apache/http/message/BasicHeader;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    return-object v1
.end method

.method public final isChunked()Z
    .locals 4

    invoke-virtual {p0}, Lcom/openfeint/internal/request/multipart/MultipartHttpEntity;->getContentLength()J

    move-result-wide v0

    const-wide/16 v2, 0x0

    cmp-long v0, v0, v2

    if-gez v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public final isRepeatable()Z
    .locals 2

    const/4 v0, 0x0

    :goto_0
    iget-object v1, p0, Lcom/openfeint/internal/request/multipart/MultipartHttpEntity;->parts:[Lcom/openfeint/internal/request/multipart/Part;

    array-length v1, v1

    if-ge v0, v1, :cond_0

    iget-object v1, p0, Lcom/openfeint/internal/request/multipart/MultipartHttpEntity;->parts:[Lcom/openfeint/internal/request/multipart/Part;

    invoke-static {}, Lcom/openfeint/internal/request/multipart/Part;->isRepeatable()Z

    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x1

    return v0
.end method

.method public final isStreaming()Z
    .locals 1

    const/4 v0, 0x0

    return v0
.end method

.method public final writeTo(Ljava/io/OutputStream;)V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    iget-object v0, p0, Lcom/openfeint/internal/request/multipart/MultipartHttpEntity;->parts:[Lcom/openfeint/internal/request/multipart/Part;

    invoke-direct {p0}, Lcom/openfeint/internal/request/multipart/MultipartHttpEntity;->getMultipartBoundary()[B

    move-result-object v1

    invoke-static {p1, v0, v1}, Lcom/openfeint/internal/request/multipart/Part;->sendParts(Ljava/io/OutputStream;[Lcom/openfeint/internal/request/multipart/Part;[B)V

    return-void
.end method
