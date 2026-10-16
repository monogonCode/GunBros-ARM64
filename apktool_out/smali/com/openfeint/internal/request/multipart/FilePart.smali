.class public final Lcom/openfeint/internal/request/multipart/FilePart;
.super Lcom/openfeint/internal/request/multipart/PartBase;


# static fields
.field private static final FILE_NAME_BYTES:[B


# instance fields
.field private source:Lcom/openfeint/internal/request/multipart/PartSource;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    const-string v0, "; filename="

    invoke-static {v0}, Lcom/openfeint/internal/request/multipart/EncodingUtil;->getAsciiBytes(Ljava/lang/String;)[B

    move-result-object v0

    sput-object v0, Lcom/openfeint/internal/request/multipart/FilePart;->FILE_NAME_BYTES:[B

    return-void
.end method

.method public constructor <init>(Ljava/lang/String;Lcom/openfeint/internal/request/multipart/PartSource;Ljava/lang/String;)V
    .locals 2

    if-nez p3, :cond_0

    const-string p3, "application/octet-stream"

    :cond_0
    const-string v0, "ISO-8859-1"

    const-string v1, "binary"

    invoke-direct {p0, p1, p3, v0, v1}, Lcom/openfeint/internal/request/multipart/PartBase;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    if-nez p2, :cond_1

    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "Source may not be null"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    :cond_1
    iput-object p2, p0, Lcom/openfeint/internal/request/multipart/FilePart;->source:Lcom/openfeint/internal/request/multipart/PartSource;

    return-void
.end method


# virtual methods
.method protected final lengthOfData()J
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    iget-object v0, p0, Lcom/openfeint/internal/request/multipart/FilePart;->source:Lcom/openfeint/internal/request/multipart/PartSource;

    invoke-interface {v0}, Lcom/openfeint/internal/request/multipart/PartSource;->getLength()J

    move-result-wide v0

    return-wide v0
.end method

.method protected final sendData(Ljava/io/OutputStream;)V
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    invoke-virtual {p0}, Lcom/openfeint/internal/request/multipart/FilePart;->lengthOfData()J

    move-result-wide v0

    const-wide/16 v2, 0x0

    cmp-long v0, v0, v2

    if-nez v0, :cond_0

    :goto_0
    return-void

    :cond_0
    const/16 v0, 0x1000

    new-array v0, v0, [B

    iget-object v1, p0, Lcom/openfeint/internal/request/multipart/FilePart;->source:Lcom/openfeint/internal/request/multipart/PartSource;

    invoke-interface {v1}, Lcom/openfeint/internal/request/multipart/PartSource;->createInputStream()Ljava/io/InputStream;

    move-result-object v1

    :goto_1
    :try_start_0
    invoke-virtual {v1, v0}, Ljava/io/InputStream;->read([B)I

    move-result v2

    if-ltz v2, :cond_1

    const/4 v3, 0x0

    invoke-virtual {p1, v0, v3, v2}, Ljava/io/OutputStream;->write([BII)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_1

    :catchall_0
    move-exception v0

    invoke-virtual {v1}, Ljava/io/InputStream;->close()V

    throw v0

    :cond_1
    invoke-virtual {v1}, Ljava/io/InputStream;->close()V

    goto :goto_0
.end method

.method protected final sendDispositionHeader(Ljava/io/OutputStream;)V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    invoke-super {p0, p1}, Lcom/openfeint/internal/request/multipart/PartBase;->sendDispositionHeader(Ljava/io/OutputStream;)V

    iget-object v0, p0, Lcom/openfeint/internal/request/multipart/FilePart;->source:Lcom/openfeint/internal/request/multipart/PartSource;

    invoke-interface {v0}, Lcom/openfeint/internal/request/multipart/PartSource;->getFileName()Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_0

    sget-object v1, Lcom/openfeint/internal/request/multipart/FilePart;->FILE_NAME_BYTES:[B

    invoke-virtual {p1, v1}, Ljava/io/OutputStream;->write([B)V

    sget-object v1, Lcom/openfeint/internal/request/multipart/FilePart;->QUOTE_BYTES:[B

    invoke-virtual {p1, v1}, Ljava/io/OutputStream;->write([B)V

    invoke-static {v0}, Lcom/openfeint/internal/request/multipart/EncodingUtil;->getAsciiBytes(Ljava/lang/String;)[B

    move-result-object v0

    invoke-virtual {p1, v0}, Ljava/io/OutputStream;->write([B)V

    sget-object v0, Lcom/openfeint/internal/request/multipart/FilePart;->QUOTE_BYTES:[B

    invoke-virtual {p1, v0}, Ljava/io/OutputStream;->write([B)V

    :cond_0
    return-void
.end method
