.class public Lcom/openfeint/internal/request/BlobPostRequest;
.super Lcom/openfeint/internal/request/BaseRequest;


# instance fields
.field mContentType:Ljava/lang/String;

.field private mDelegate:Lcom/openfeint/internal/request/IRawRequestDelegate;

.field mParams:Lcom/openfeint/internal/resource/BlobUploadParameters;

.field protected mPartSource:Lcom/openfeint/internal/request/multipart/PartSource;


# direct methods
.method public constructor <init>(Lcom/openfeint/internal/resource/BlobUploadParameters;Lcom/openfeint/internal/request/multipart/PartSource;Ljava/lang/String;)V
    .locals 1

    const/4 v0, 0x0

    invoke-direct {p0, v0}, Lcom/openfeint/internal/request/BaseRequest;-><init>(Lcom/openfeint/internal/request/OrderedArgList;)V

    iput-object p1, p0, Lcom/openfeint/internal/request/BlobPostRequest;->mParams:Lcom/openfeint/internal/resource/BlobUploadParameters;

    iput-object p2, p0, Lcom/openfeint/internal/request/BlobPostRequest;->mPartSource:Lcom/openfeint/internal/request/multipart/PartSource;

    iput-object p3, p0, Lcom/openfeint/internal/request/BlobPostRequest;->mContentType:Ljava/lang/String;

    return-void
.end method


# virtual methods
.method protected final generateRequest()Lorg/apache/http/client/methods/HttpUriRequest;
    .locals 7

    iget-object v0, p0, Lcom/openfeint/internal/request/BlobPostRequest;->mPartSource:Lcom/openfeint/internal/request/multipart/PartSource;

    if-nez v0, :cond_0

    const/4 v0, 0x0

    :goto_0
    return-object v0

    :cond_0
    new-instance v0, Lorg/apache/http/client/methods/HttpPost;

    iget-object v1, p0, Lcom/openfeint/internal/request/BlobPostRequest;->mParams:Lcom/openfeint/internal/resource/BlobUploadParameters;

    iget-object v1, v1, Lcom/openfeint/internal/resource/BlobUploadParameters;->action:Ljava/lang/String;

    invoke-direct {v0, v1}, Lorg/apache/http/client/methods/HttpPost;-><init>(Ljava/lang/String;)V

    const/4 v1, 0x6

    new-array v1, v1, [Lcom/openfeint/internal/request/multipart/Part;

    const/4 v2, 0x0

    new-instance v3, Lcom/openfeint/internal/request/multipart/StringPart;

    const-string v4, "AWSAccessKeyId"

    iget-object v5, p0, Lcom/openfeint/internal/request/BlobPostRequest;->mParams:Lcom/openfeint/internal/resource/BlobUploadParameters;

    iget-object v5, v5, Lcom/openfeint/internal/resource/BlobUploadParameters;->AWSAccessKeyId:Ljava/lang/String;

    invoke-direct {v3, v4, v5}, Lcom/openfeint/internal/request/multipart/StringPart;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    aput-object v3, v1, v2

    const/4 v2, 0x1

    new-instance v3, Lcom/openfeint/internal/request/multipart/StringPart;

    const-string v4, "acl"

    iget-object v5, p0, Lcom/openfeint/internal/request/BlobPostRequest;->mParams:Lcom/openfeint/internal/resource/BlobUploadParameters;

    iget-object v5, v5, Lcom/openfeint/internal/resource/BlobUploadParameters;->acl:Ljava/lang/String;

    invoke-direct {v3, v4, v5}, Lcom/openfeint/internal/request/multipart/StringPart;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    aput-object v3, v1, v2

    const/4 v2, 0x2

    new-instance v3, Lcom/openfeint/internal/request/multipart/StringPart;

    const-string v4, "key"

    iget-object v5, p0, Lcom/openfeint/internal/request/BlobPostRequest;->mParams:Lcom/openfeint/internal/resource/BlobUploadParameters;

    iget-object v5, v5, Lcom/openfeint/internal/resource/BlobUploadParameters;->key:Ljava/lang/String;

    invoke-direct {v3, v4, v5}, Lcom/openfeint/internal/request/multipart/StringPart;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    aput-object v3, v1, v2

    const/4 v2, 0x3

    new-instance v3, Lcom/openfeint/internal/request/multipart/StringPart;

    const-string v4, "policy"

    iget-object v5, p0, Lcom/openfeint/internal/request/BlobPostRequest;->mParams:Lcom/openfeint/internal/resource/BlobUploadParameters;

    iget-object v5, v5, Lcom/openfeint/internal/resource/BlobUploadParameters;->policy:Ljava/lang/String;

    invoke-direct {v3, v4, v5}, Lcom/openfeint/internal/request/multipart/StringPart;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    aput-object v3, v1, v2

    const/4 v2, 0x4

    new-instance v3, Lcom/openfeint/internal/request/multipart/StringPart;

    const-string v4, "signature"

    iget-object v5, p0, Lcom/openfeint/internal/request/BlobPostRequest;->mParams:Lcom/openfeint/internal/resource/BlobUploadParameters;

    iget-object v5, v5, Lcom/openfeint/internal/resource/BlobUploadParameters;->signature:Ljava/lang/String;

    invoke-direct {v3, v4, v5}, Lcom/openfeint/internal/request/multipart/StringPart;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    aput-object v3, v1, v2

    const/4 v2, 0x5

    new-instance v3, Lcom/openfeint/internal/request/multipart/FilePart;

    const-string v4, "file"

    iget-object v5, p0, Lcom/openfeint/internal/request/BlobPostRequest;->mPartSource:Lcom/openfeint/internal/request/multipart/PartSource;

    iget-object v6, p0, Lcom/openfeint/internal/request/BlobPostRequest;->mContentType:Ljava/lang/String;

    invoke-direct {v3, v4, v5, v6}, Lcom/openfeint/internal/request/multipart/FilePart;-><init>(Ljava/lang/String;Lcom/openfeint/internal/request/multipart/PartSource;Ljava/lang/String;)V

    aput-object v3, v1, v2

    new-instance v2, Lcom/openfeint/internal/request/multipart/MultipartHttpEntity;

    invoke-direct {v2, v1}, Lcom/openfeint/internal/request/multipart/MultipartHttpEntity;-><init>([Lcom/openfeint/internal/request/multipart/Part;)V

    invoke-virtual {v0, v2}, Lorg/apache/http/client/methods/HttpPost;->setEntity(Lorg/apache/http/HttpEntity;)V

    invoke-virtual {p0, v0}, Lcom/openfeint/internal/request/BlobPostRequest;->addParams(Lorg/apache/http/client/methods/HttpUriRequest;)V

    goto :goto_0
.end method

.method public final method()Ljava/lang/String;
    .locals 1

    const-string v0, "POST"

    return-object v0
.end method

.method public final onResponse(I[B)V
    .locals 2

    iget-object v0, p0, Lcom/openfeint/internal/request/BlobPostRequest;->mDelegate:Lcom/openfeint/internal/request/IRawRequestDelegate;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/openfeint/internal/request/BlobPostRequest;->mDelegate:Lcom/openfeint/internal/request/IRawRequestDelegate;

    new-instance v1, Ljava/lang/String;

    invoke-direct {v1, p2}, Ljava/lang/String;-><init>([B)V

    invoke-interface {v0, p1, v1}, Lcom/openfeint/internal/request/IRawRequestDelegate;->onResponse(ILjava/lang/String;)V

    :cond_0
    return-void
.end method

.method public final path()Ljava/lang/String;
    .locals 1

    const-string v0, ""

    return-object v0
.end method

.method public final setDelegate(Lcom/openfeint/internal/request/IRawRequestDelegate;)V
    .locals 0

    iput-object p1, p0, Lcom/openfeint/internal/request/BlobPostRequest;->mDelegate:Lcom/openfeint/internal/request/IRawRequestDelegate;

    return-void
.end method

.method public final signed()Z
    .locals 1

    const/4 v0, 0x0

    return v0
.end method

.method public final url()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/openfeint/internal/request/BlobPostRequest;->mParams:Lcom/openfeint/internal/resource/BlobUploadParameters;

    iget-object v0, v0, Lcom/openfeint/internal/resource/BlobUploadParameters;->action:Ljava/lang/String;

    return-object v0
.end method
