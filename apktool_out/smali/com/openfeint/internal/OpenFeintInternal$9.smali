.class final Lcom/openfeint/internal/OpenFeintInternal$9;
.super Lcom/openfeint/internal/request/JSONRequest;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/openfeint/internal/OpenFeintInternal;->uploadFile(Ljava/lang/String;Lcom/openfeint/internal/request/multipart/PartSource;Ljava/lang/String;Lcom/openfeint/internal/OpenFeintInternal$IUploadDelegate;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/openfeint/internal/OpenFeintInternal;

.field final synthetic val$contentType:Ljava/lang/String;

.field final synthetic val$delegate:Lcom/openfeint/internal/OpenFeintInternal$IUploadDelegate;

.field final synthetic val$partSource:Lcom/openfeint/internal/request/multipart/PartSource;

.field final synthetic val$xpApiPath:Ljava/lang/String;


# direct methods
.method constructor <init>(Lcom/openfeint/internal/OpenFeintInternal;Ljava/lang/String;Lcom/openfeint/internal/request/multipart/PartSource;Ljava/lang/String;Lcom/openfeint/internal/OpenFeintInternal$IUploadDelegate;)V
    .locals 0

    iput-object p1, p0, Lcom/openfeint/internal/OpenFeintInternal$9;->this$0:Lcom/openfeint/internal/OpenFeintInternal;

    iput-object p2, p0, Lcom/openfeint/internal/OpenFeintInternal$9;->val$xpApiPath:Ljava/lang/String;

    iput-object p3, p0, Lcom/openfeint/internal/OpenFeintInternal$9;->val$partSource:Lcom/openfeint/internal/request/multipart/PartSource;

    iput-object p4, p0, Lcom/openfeint/internal/OpenFeintInternal$9;->val$contentType:Ljava/lang/String;

    iput-object p5, p0, Lcom/openfeint/internal/OpenFeintInternal$9;->val$delegate:Lcom/openfeint/internal/OpenFeintInternal$IUploadDelegate;

    invoke-direct {p0}, Lcom/openfeint/internal/request/JSONRequest;-><init>()V

    return-void
.end method


# virtual methods
.method public final method()Ljava/lang/String;
    .locals 1

    const-string v0, "POST"

    return-object v0
.end method

.method public final onFailure(Ljava/lang/String;)V
    .locals 3

    iget-object v0, p0, Lcom/openfeint/internal/OpenFeintInternal$9;->val$delegate:Lcom/openfeint/internal/OpenFeintInternal$IUploadDelegate;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/openfeint/internal/OpenFeintInternal$9;->val$delegate:Lcom/openfeint/internal/OpenFeintInternal$IUploadDelegate;

    const-string v1, ""

    const/4 v2, 0x0

    invoke-interface {v0, v1, v2}, Lcom/openfeint/internal/OpenFeintInternal$IUploadDelegate;->fileUploadedTo(Ljava/lang/String;Z)V

    :cond_0
    return-void
.end method

.method public final onSuccess(Ljava/lang/Object;)V
    .locals 3

    check-cast p1, Lcom/openfeint/internal/resource/BlobUploadParameters;

    new-instance v0, Lcom/openfeint/internal/request/BlobPostRequest;

    iget-object v1, p0, Lcom/openfeint/internal/OpenFeintInternal$9;->val$partSource:Lcom/openfeint/internal/request/multipart/PartSource;

    iget-object v2, p0, Lcom/openfeint/internal/OpenFeintInternal$9;->val$contentType:Ljava/lang/String;

    invoke-direct {v0, p1, v1, v2}, Lcom/openfeint/internal/request/BlobPostRequest;-><init>(Lcom/openfeint/internal/resource/BlobUploadParameters;Lcom/openfeint/internal/request/multipart/PartSource;Ljava/lang/String;)V

    iget-object v1, p0, Lcom/openfeint/internal/OpenFeintInternal$9;->val$delegate:Lcom/openfeint/internal/OpenFeintInternal$IUploadDelegate;

    if-eqz v1, :cond_0

    new-instance v1, Lcom/openfeint/internal/OpenFeintInternal$9$1;

    invoke-direct {v1, p0, p1}, Lcom/openfeint/internal/OpenFeintInternal$9$1;-><init>(Lcom/openfeint/internal/OpenFeintInternal$9;Lcom/openfeint/internal/resource/BlobUploadParameters;)V

    invoke-virtual {v0, v1}, Lcom/openfeint/internal/request/BlobPostRequest;->setDelegate(Lcom/openfeint/internal/request/IRawRequestDelegate;)V

    :cond_0
    iget-object v1, p0, Lcom/openfeint/internal/OpenFeintInternal$9;->this$0:Lcom/openfeint/internal/OpenFeintInternal;

    invoke-static {v1, v0}, Lcom/openfeint/internal/OpenFeintInternal;->access$1100(Lcom/openfeint/internal/OpenFeintInternal;Lcom/openfeint/internal/request/BaseRequest;)V

    return-void
.end method

.method public final path()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/openfeint/internal/OpenFeintInternal$9;->val$xpApiPath:Ljava/lang/String;

    return-object v0
.end method

.method public final wantsLogin()Z
    .locals 1

    const/4 v0, 0x1

    return v0
.end method
