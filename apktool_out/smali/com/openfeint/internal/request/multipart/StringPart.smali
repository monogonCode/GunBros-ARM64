.class public final Lcom/openfeint/internal/request/multipart/StringPart;
.super Lcom/openfeint/internal/request/multipart/PartBase;


# instance fields
.field private content:[B

.field private value:Ljava/lang/String;


# direct methods
.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1

    const/4 v0, 0x0

    invoke-direct {p0, p1, p2, v0}, Lcom/openfeint/internal/request/multipart/StringPart;-><init>(Ljava/lang/String;Ljava/lang/String;B)V

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;Ljava/lang/String;B)V
    .locals 3

    const-string v0, "text/html"

    const-string v1, "UTF-8"

    const-string v2, "8bit"

    invoke-direct {p0, p1, v0, v1, v2}, Lcom/openfeint/internal/request/multipart/PartBase;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    if-nez p2, :cond_0

    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "Value may not be null"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    :cond_0
    const/4 v0, 0x0

    invoke-virtual {p2, v0}, Ljava/lang/String;->indexOf(I)I

    move-result v0

    const/4 v1, -0x1

    if-eq v0, v1, :cond_1

    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "NULs may not be present in string parts"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    :cond_1
    iput-object p2, p0, Lcom/openfeint/internal/request/multipart/StringPart;->value:Ljava/lang/String;

    return-void
.end method

.method private getContent()[B
    .locals 2

    iget-object v0, p0, Lcom/openfeint/internal/request/multipart/StringPart;->content:[B

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/openfeint/internal/request/multipart/StringPart;->value:Ljava/lang/String;

    invoke-virtual {p0}, Lcom/openfeint/internal/request/multipart/StringPart;->getCharSet()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/openfeint/internal/request/multipart/EncodingUtil;->getBytes(Ljava/lang/String;Ljava/lang/String;)[B

    move-result-object v0

    iput-object v0, p0, Lcom/openfeint/internal/request/multipart/StringPart;->content:[B

    :cond_0
    iget-object v0, p0, Lcom/openfeint/internal/request/multipart/StringPart;->content:[B

    return-object v0
.end method


# virtual methods
.method protected final lengthOfData()J
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    invoke-direct {p0}, Lcom/openfeint/internal/request/multipart/StringPart;->getContent()[B

    move-result-object v0

    array-length v0, v0

    int-to-long v0, v0

    return-wide v0
.end method

.method protected final sendData(Ljava/io/OutputStream;)V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    invoke-direct {p0}, Lcom/openfeint/internal/request/multipart/StringPart;->getContent()[B

    move-result-object v0

    invoke-virtual {p1, v0}, Ljava/io/OutputStream;->write([B)V

    return-void
.end method
