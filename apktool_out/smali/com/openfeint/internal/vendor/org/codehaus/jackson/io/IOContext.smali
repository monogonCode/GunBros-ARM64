.class public final Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/IOContext;
.super Ljava/lang/Object;


# instance fields
.field final _bufferRecycler:Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/BufferRecycler;

.field protected _concatCBuffer:[C

.field protected _encoding:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonEncoding;

.field protected final _managedResource:Z

.field protected _nameCopyBuffer:[C

.field protected _readIOBuffer:[B

.field final _sourceRef:Ljava/lang/Object;

.field protected _tokenCBuffer:[C

.field protected _writeEncodingBuffer:[B


# direct methods
.method public constructor <init>(Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/BufferRecycler;Ljava/lang/Object;Z)V
    .locals 1

    const/4 v0, 0x0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/IOContext;->_readIOBuffer:[B

    iput-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/IOContext;->_writeEncodingBuffer:[B

    iput-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/IOContext;->_tokenCBuffer:[C

    iput-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/IOContext;->_concatCBuffer:[C

    iput-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/IOContext;->_nameCopyBuffer:[C

    iput-object p1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/IOContext;->_bufferRecycler:Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/BufferRecycler;

    iput-object p2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/IOContext;->_sourceRef:Ljava/lang/Object;

    iput-boolean p3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/IOContext;->_managedResource:Z

    return-void
.end method


# virtual methods
.method public final allocConcatBuffer()[C
    .locals 2

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/IOContext;->_concatCBuffer:[C

    if-eqz v0, :cond_0

    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v1, "Trying to call allocConcatBuffer() second time"

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0

    :cond_0
    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/IOContext;->_bufferRecycler:Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/BufferRecycler;

    sget-object v1, Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/BufferRecycler$CharBufferType;->CONCAT_BUFFER:Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/BufferRecycler$CharBufferType;

    invoke-virtual {v0, v1}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/BufferRecycler;->allocCharBuffer(Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/BufferRecycler$CharBufferType;)[C

    move-result-object v0

    iput-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/IOContext;->_concatCBuffer:[C

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/IOContext;->_concatCBuffer:[C

    return-object v0
.end method

.method public final allocReadIOBuffer()[B
    .locals 2

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/IOContext;->_readIOBuffer:[B

    if-eqz v0, :cond_0

    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v1, "Trying to call allocReadIOBuffer() second time"

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0

    :cond_0
    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/IOContext;->_bufferRecycler:Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/BufferRecycler;

    sget-object v1, Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/BufferRecycler$ByteBufferType;->READ_IO_BUFFER:Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/BufferRecycler$ByteBufferType;

    invoke-virtual {v0, v1}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/BufferRecycler;->allocByteBuffer(Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/BufferRecycler$ByteBufferType;)[B

    move-result-object v0

    iput-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/IOContext;->_readIOBuffer:[B

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/IOContext;->_readIOBuffer:[B

    return-object v0
.end method

.method public final allocTokenBuffer()[C
    .locals 2

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/IOContext;->_tokenCBuffer:[C

    if-eqz v0, :cond_0

    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v1, "Trying to call allocTokenBuffer() second time"

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0

    :cond_0
    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/IOContext;->_bufferRecycler:Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/BufferRecycler;

    sget-object v1, Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/BufferRecycler$CharBufferType;->TOKEN_BUFFER:Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/BufferRecycler$CharBufferType;

    invoke-virtual {v0, v1}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/BufferRecycler;->allocCharBuffer(Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/BufferRecycler$CharBufferType;)[C

    move-result-object v0

    iput-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/IOContext;->_tokenCBuffer:[C

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/IOContext;->_tokenCBuffer:[C

    return-object v0
.end method

.method public final constructTextBuffer()Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/TextBuffer;
    .locals 2

    new-instance v0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/TextBuffer;

    iget-object v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/IOContext;->_bufferRecycler:Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/BufferRecycler;

    invoke-direct {v0, v1}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/TextBuffer;-><init>(Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/BufferRecycler;)V

    return-object v0
.end method

.method public final getEncoding()Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonEncoding;
    .locals 1

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/IOContext;->_encoding:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonEncoding;

    return-object v0
.end method

.method public final getSourceReference()Ljava/lang/Object;
    .locals 1

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/IOContext;->_sourceRef:Ljava/lang/Object;

    return-object v0
.end method

.method public final isResourceManaged()Z
    .locals 1

    iget-boolean v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/IOContext;->_managedResource:Z

    return v0
.end method

.method public final releaseConcatBuffer([C)V
    .locals 2

    if-eqz p1, :cond_1

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/IOContext;->_concatCBuffer:[C

    if-eq p1, v0, :cond_0

    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "Trying to release buffer not owned by the context"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    :cond_0
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/IOContext;->_concatCBuffer:[C

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/IOContext;->_bufferRecycler:Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/BufferRecycler;

    sget-object v1, Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/BufferRecycler$CharBufferType;->CONCAT_BUFFER:Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/BufferRecycler$CharBufferType;

    invoke-virtual {v0, v1, p1}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/BufferRecycler;->releaseCharBuffer(Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/BufferRecycler$CharBufferType;[C)V

    :cond_1
    return-void
.end method

.method public final releaseNameCopyBuffer([C)V
    .locals 2

    if-eqz p1, :cond_1

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/IOContext;->_nameCopyBuffer:[C

    if-eq p1, v0, :cond_0

    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "Trying to release buffer not owned by the context"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    :cond_0
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/IOContext;->_nameCopyBuffer:[C

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/IOContext;->_bufferRecycler:Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/BufferRecycler;

    sget-object v1, Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/BufferRecycler$CharBufferType;->NAME_COPY_BUFFER:Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/BufferRecycler$CharBufferType;

    invoke-virtual {v0, v1, p1}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/BufferRecycler;->releaseCharBuffer(Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/BufferRecycler$CharBufferType;[C)V

    :cond_1
    return-void
.end method

.method public final releaseReadIOBuffer([B)V
    .locals 2

    if-eqz p1, :cond_1

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/IOContext;->_readIOBuffer:[B

    if-eq p1, v0, :cond_0

    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "Trying to release buffer not owned by the context"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    :cond_0
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/IOContext;->_readIOBuffer:[B

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/IOContext;->_bufferRecycler:Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/BufferRecycler;

    sget-object v1, Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/BufferRecycler$ByteBufferType;->READ_IO_BUFFER:Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/BufferRecycler$ByteBufferType;

    invoke-virtual {v0, v1, p1}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/BufferRecycler;->releaseByteBuffer(Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/BufferRecycler$ByteBufferType;[B)V

    :cond_1
    return-void
.end method

.method public final releaseTokenBuffer([C)V
    .locals 2

    if-eqz p1, :cond_1

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/IOContext;->_tokenCBuffer:[C

    if-eq p1, v0, :cond_0

    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "Trying to release buffer not owned by the context"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    :cond_0
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/IOContext;->_tokenCBuffer:[C

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/IOContext;->_bufferRecycler:Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/BufferRecycler;

    sget-object v1, Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/BufferRecycler$CharBufferType;->TOKEN_BUFFER:Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/BufferRecycler$CharBufferType;

    invoke-virtual {v0, v1, p1}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/BufferRecycler;->releaseCharBuffer(Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/BufferRecycler$CharBufferType;[C)V

    :cond_1
    return-void
.end method

.method public final setEncoding(Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonEncoding;)V
    .locals 0

    iput-object p1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/io/IOContext;->_encoding:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonEncoding;

    return-void
.end method
