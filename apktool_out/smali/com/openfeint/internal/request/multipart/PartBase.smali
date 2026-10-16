.class public abstract Lcom/openfeint/internal/request/multipart/PartBase;
.super Lcom/openfeint/internal/request/multipart/Part;


# instance fields
.field private charSet:Ljava/lang/String;

.field private contentType:Ljava/lang/String;

.field private name:Ljava/lang/String;

.field private transferEncoding:Ljava/lang/String;


# direct methods
.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 2

    invoke-direct {p0}, Lcom/openfeint/internal/request/multipart/Part;-><init>()V

    if-nez p1, :cond_0

    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "Name must not be null"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    :cond_0
    iput-object p1, p0, Lcom/openfeint/internal/request/multipart/PartBase;->name:Ljava/lang/String;

    iput-object p2, p0, Lcom/openfeint/internal/request/multipart/PartBase;->contentType:Ljava/lang/String;

    iput-object p3, p0, Lcom/openfeint/internal/request/multipart/PartBase;->charSet:Ljava/lang/String;

    iput-object p4, p0, Lcom/openfeint/internal/request/multipart/PartBase;->transferEncoding:Ljava/lang/String;

    return-void
.end method


# virtual methods
.method public final getCharSet()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/openfeint/internal/request/multipart/PartBase;->charSet:Ljava/lang/String;

    return-object v0
.end method

.method public final getContentType()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/openfeint/internal/request/multipart/PartBase;->contentType:Ljava/lang/String;

    return-object v0
.end method

.method public final getName()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/openfeint/internal/request/multipart/PartBase;->name:Ljava/lang/String;

    return-object v0
.end method

.method public final getTransferEncoding()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/openfeint/internal/request/multipart/PartBase;->transferEncoding:Ljava/lang/String;

    return-object v0
.end method
