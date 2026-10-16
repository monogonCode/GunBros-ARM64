.class public final Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/ByteArrayBuilder;
.super Ljava/io/OutputStream;


# static fields
.field private static final NO_BYTES:[B


# instance fields
.field private final _bufferRecycler:Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/BufferRecycler;

.field private _currBlock:[B

.field private _currBlockPtr:I

.field private final _pastBlocks:Ljava/util/LinkedList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/LinkedList",
            "<[B>;"
        }
    .end annotation
.end field

.field private _pastLen:I


# direct methods
.method static constructor <clinit>()V
    .locals 1

    const/4 v0, 0x0

    new-array v0, v0, [B

    sput-object v0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/ByteArrayBuilder;->NO_BYTES:[B

    return-void
.end method

.method private constructor <init>()V
    .locals 1

    invoke-direct {p0}, Ljava/io/OutputStream;-><init>()V

    new-instance v0, Ljava/util/LinkedList;

    invoke-direct {v0}, Ljava/util/LinkedList;-><init>()V

    iput-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/ByteArrayBuilder;->_pastBlocks:Ljava/util/LinkedList;

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/ByteArrayBuilder;->_bufferRecycler:Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/BufferRecycler;

    const/16 v0, 0x1f4

    new-array v0, v0, [B

    iput-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/ByteArrayBuilder;->_currBlock:[B

    return-void
.end method

.method private _allocMore()V
    .locals 3

    const/high16 v0, 0x40000

    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/ByteArrayBuilder;->_pastLen:I

    iget-object v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/ByteArrayBuilder;->_currBlock:[B

    array-length v2, v2

    add-int/2addr v1, v2

    iput v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/ByteArrayBuilder;->_pastLen:I

    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/ByteArrayBuilder;->_pastLen:I

    shr-int/lit8 v1, v1, 0x1

    const/16 v2, 0x3e8

    invoke-static {v1, v2}, Ljava/lang/Math;->max(II)I

    move-result v1

    if-le v1, v0, :cond_0

    :goto_0
    iget-object v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/ByteArrayBuilder;->_pastBlocks:Ljava/util/LinkedList;

    iget-object v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/ByteArrayBuilder;->_currBlock:[B

    invoke-virtual {v1, v2}, Ljava/util/LinkedList;->add(Ljava/lang/Object;)Z

    new-array v0, v0, [B

    iput-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/ByteArrayBuilder;->_currBlock:[B

    const/4 v0, 0x0

    iput v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/ByteArrayBuilder;->_currBlockPtr:I

    return-void

    :cond_0
    move v0, v1

    goto :goto_0
.end method


# virtual methods
.method public final close()V
    .locals 0

    return-void
.end method

.method public final flush()V
    .locals 0

    return-void
.end method

.method public final write(I)V
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    int-to-byte v0, p1

    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/ByteArrayBuilder;->_currBlockPtr:I

    iget-object v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/ByteArrayBuilder;->_currBlock:[B

    array-length v2, v2

    if-lt v1, v2, :cond_0

    invoke-direct {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/ByteArrayBuilder;->_allocMore()V

    :cond_0
    iget-object v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/ByteArrayBuilder;->_currBlock:[B

    iget v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/ByteArrayBuilder;->_currBlockPtr:I

    add-int/lit8 v3, v2, 0x1

    iput v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/ByteArrayBuilder;->_currBlockPtr:I

    aput-byte v0, v1, v2

    return-void
.end method

.method public final write([B)V
    .locals 2

    const/4 v0, 0x0

    array-length v1, p1

    invoke-virtual {p0, p1, v0, v1}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/ByteArrayBuilder;->write([BII)V

    return-void
.end method

.method public final write([BII)V
    .locals 3

    :goto_0
    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/ByteArrayBuilder;->_currBlock:[B

    array-length v0, v0

    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/ByteArrayBuilder;->_currBlockPtr:I

    sub-int/2addr v0, v1

    invoke-static {v0, p3}, Ljava/lang/Math;->min(II)I

    move-result v0

    if-lez v0, :cond_0

    iget-object v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/ByteArrayBuilder;->_currBlock:[B

    iget v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/ByteArrayBuilder;->_currBlockPtr:I

    invoke-static {p1, p2, v1, v2, v0}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    add-int/2addr p2, v0

    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/ByteArrayBuilder;->_currBlockPtr:I

    add-int/2addr v1, v0

    iput v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/ByteArrayBuilder;->_currBlockPtr:I

    sub-int/2addr p3, v0

    :cond_0
    if-lez p3, :cond_1

    invoke-direct {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/ByteArrayBuilder;->_allocMore()V

    goto :goto_0

    :cond_1
    return-void
.end method
