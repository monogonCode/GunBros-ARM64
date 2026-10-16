.class public final Lcom/openfeint/internal/request/CompressedBlobPostRequest;
.super Lcom/openfeint/internal/request/BlobPostRequest;


# direct methods
.method public constructor <init>(Lcom/openfeint/internal/resource/BlobUploadParameters;Ljava/lang/String;[B)V
    .locals 2

    new-instance v0, Lcom/openfeint/internal/request/multipart/ByteArrayPartSource;

    invoke-static {p3}, Lcom/openfeint/internal/request/Compression;->compress([B)[B

    move-result-object v1

    invoke-direct {v0, p2, v1}, Lcom/openfeint/internal/request/multipart/ByteArrayPartSource;-><init>(Ljava/lang/String;[B)V

    const-string v1, "application/octet-stream"

    invoke-direct {p0, p1, v0, v1}, Lcom/openfeint/internal/request/BlobPostRequest;-><init>(Lcom/openfeint/internal/resource/BlobUploadParameters;Lcom/openfeint/internal/request/multipart/PartSource;Ljava/lang/String;)V

    return-void
.end method
