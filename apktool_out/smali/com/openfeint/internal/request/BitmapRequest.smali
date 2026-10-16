.class public abstract Lcom/openfeint/internal/request/BitmapRequest;
.super Lcom/openfeint/internal/request/DownloadRequest;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Lcom/openfeint/internal/request/DownloadRequest;-><init>()V

    return-void
.end method


# virtual methods
.method public onSuccess(Landroid/graphics/Bitmap;)V
    .locals 0

    return-void
.end method

.method protected final onSuccess([B)V
    .locals 2

    const/4 v0, 0x0

    array-length v1, p1

    invoke-static {p1, v0, v1}, Landroid/graphics/BitmapFactory;->decodeByteArray([BII)Landroid/graphics/Bitmap;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-virtual {p0, v0}, Lcom/openfeint/internal/request/BitmapRequest;->onSuccess(Landroid/graphics/Bitmap;)V

    :goto_0
    return-void

    :cond_0
    const-string v0, "of_bitmap_decode_error"

    invoke-static {v0}, Lcom/openfeint/internal/RR;->string(Ljava/lang/String;)I

    move-result v0

    invoke-static {v0}, Lcom/openfeint/internal/OpenFeintInternal;->getRString(I)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/openfeint/internal/request/BitmapRequest;->onFailure(Ljava/lang/String;)V

    goto :goto_0
.end method
