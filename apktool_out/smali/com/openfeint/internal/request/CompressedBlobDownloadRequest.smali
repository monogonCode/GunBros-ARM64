.class public abstract Lcom/openfeint/internal/request/CompressedBlobDownloadRequest;
.super Lcom/openfeint/internal/request/DownloadRequest;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Lcom/openfeint/internal/request/DownloadRequest;-><init>()V

    return-void
.end method


# virtual methods
.method protected final onSuccess([B)V
    .locals 1

    :try_start_0
    invoke-static {p1}, Lcom/openfeint/internal/request/Compression;->decompress([B)[B

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/openfeint/internal/request/CompressedBlobDownloadRequest;->onSuccessDecompress([B)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return-void

    :catch_0
    move-exception v0

    const-string v0, "of_io_exception_on_download"

    invoke-static {v0}, Lcom/openfeint/internal/RR;->string(Ljava/lang/String;)I

    move-result v0

    invoke-static {v0}, Lcom/openfeint/internal/OpenFeintInternal;->getRString(I)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/openfeint/internal/request/CompressedBlobDownloadRequest;->onFailure(Ljava/lang/String;)V

    goto :goto_0
.end method

.method protected abstract onSuccessDecompress([B)V
.end method
