.class final Lcom/openfeint/internal/OpenFeintInternal$9$1;
.super Ljava/lang/Object;

# interfaces
.implements Lcom/openfeint/internal/request/IRawRequestDelegate;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/openfeint/internal/OpenFeintInternal$9;->onSuccess(Ljava/lang/Object;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lcom/openfeint/internal/OpenFeintInternal$9;

.field final synthetic val$params:Lcom/openfeint/internal/resource/BlobUploadParameters;


# direct methods
.method constructor <init>(Lcom/openfeint/internal/OpenFeintInternal$9;Lcom/openfeint/internal/resource/BlobUploadParameters;)V
    .locals 0

    iput-object p1, p0, Lcom/openfeint/internal/OpenFeintInternal$9$1;->this$1:Lcom/openfeint/internal/OpenFeintInternal$9;

    iput-object p2, p0, Lcom/openfeint/internal/OpenFeintInternal$9$1;->val$params:Lcom/openfeint/internal/resource/BlobUploadParameters;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final onResponse(ILjava/lang/String;)V
    .locals 3

    iget-object v0, p0, Lcom/openfeint/internal/OpenFeintInternal$9$1;->this$1:Lcom/openfeint/internal/OpenFeintInternal$9;

    iget-object v1, v0, Lcom/openfeint/internal/OpenFeintInternal$9;->val$delegate:Lcom/openfeint/internal/OpenFeintInternal$IUploadDelegate;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v2, p0, Lcom/openfeint/internal/OpenFeintInternal$9$1;->val$params:Lcom/openfeint/internal/resource/BlobUploadParameters;

    iget-object v2, v2, Lcom/openfeint/internal/resource/BlobUploadParameters;->action:Ljava/lang/String;

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v2, p0, Lcom/openfeint/internal/OpenFeintInternal$9$1;->val$params:Lcom/openfeint/internal/resource/BlobUploadParameters;

    iget-object v2, v2, Lcom/openfeint/internal/resource/BlobUploadParameters;->key:Ljava/lang/String;

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    const/16 v0, 0xc8

    if-gt v0, p1, :cond_0

    const/16 v0, 0x12c

    if-ge p1, v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    invoke-interface {v1, v2, v0}, Lcom/openfeint/internal/OpenFeintInternal$IUploadDelegate;->fileUploadedTo(Ljava/lang/String;Z)V

    return-void

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method
