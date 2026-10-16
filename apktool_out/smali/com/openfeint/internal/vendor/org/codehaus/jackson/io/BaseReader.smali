.class abstract Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/BaseReader;
.super Ljava/io/Reader;


# instance fields
.field protected mBuffer:[B

.field protected final mContext:Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/IOContext;

.field protected mIn:Ljava/io/InputStream;

.field protected mLength:I

.field protected mPtr:I

.field mTmpBuf:[C


# direct methods
.method protected constructor <init>(Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/IOContext;Ljava/io/InputStream;[BII)V
    .locals 1

    invoke-direct {p0}, Ljava/io/Reader;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/BaseReader;->mTmpBuf:[C

    iput-object p1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/BaseReader;->mContext:Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/IOContext;

    iput-object p2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/BaseReader;->mIn:Ljava/io/InputStream;

    iput-object p3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/BaseReader;->mBuffer:[B

    iput p4, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/BaseReader;->mPtr:I

    iput p5, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/BaseReader;->mLength:I

    return-void
.end method

.method protected static reportStrangeStream()V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    new-instance v0, Ljava/io/IOException;

    const-string v1, "Strange I/O stream, returned 0 bytes on read"

    invoke-direct {v0, v1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v0
.end method


# virtual methods
.method public close()V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/BaseReader;->mIn:Ljava/io/InputStream;

    if-eqz v0, :cond_0

    const/4 v1, 0x0

    iput-object v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/BaseReader;->mIn:Ljava/io/InputStream;

    invoke-virtual {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/BaseReader;->freeBuffers()V

    invoke-virtual {v0}, Ljava/io/InputStream;->close()V

    :cond_0
    return-void
.end method

.method public final freeBuffers()V
    .locals 2

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/BaseReader;->mBuffer:[B

    if-eqz v0, :cond_0

    const/4 v1, 0x0

    iput-object v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/BaseReader;->mBuffer:[B

    iget-object v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/BaseReader;->mContext:Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/IOContext;

    invoke-virtual {v1, v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/IOContext;->releaseReadIOBuffer([B)V

    :cond_0
    return-void
.end method

.method public read()I
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    const/4 v2, 0x1

    const/4 v1, 0x0

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/BaseReader;->mTmpBuf:[C

    if-nez v0, :cond_0

    new-array v0, v2, [C

    iput-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/BaseReader;->mTmpBuf:[C

    :cond_0
    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/BaseReader;->mTmpBuf:[C

    invoke-virtual {p0, v0, v1, v2}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/BaseReader;->read([CII)I

    move-result v0

    if-gtz v0, :cond_1

    const/4 v0, -0x1

    :goto_0
    return v0

    :cond_1
    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/BaseReader;->mTmpBuf:[C

    aget-char v0, v0, v1

    goto :goto_0
.end method
