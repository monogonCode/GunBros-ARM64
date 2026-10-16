.class public Lcom/openfeint/internal/resource/BlobUploadParameters;
.super Lcom/openfeint/internal/resource/Resource;


# instance fields
.field public AWSAccessKeyId:Ljava/lang/String;

.field public acl:Ljava/lang/String;

.field public action:Ljava/lang/String;

.field public key:Ljava/lang/String;

.field public policy:Ljava/lang/String;

.field public signature:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Lcom/openfeint/internal/resource/Resource;-><init>()V

    return-void
.end method

.method public static getResourceClass()Lcom/openfeint/internal/resource/ResourceClass;
    .locals 4

    new-instance v0, Lcom/openfeint/internal/resource/BlobUploadParameters$1;

    const-class v1, Lcom/openfeint/internal/resource/BlobUploadParameters;

    const-string v2, "blob_upload_parameters"

    invoke-direct {v0, v1, v2}, Lcom/openfeint/internal/resource/BlobUploadParameters$1;-><init>(Ljava/lang/Class;Ljava/lang/String;)V

    iget-object v1, v0, Lcom/openfeint/internal/resource/ResourceClass;->mProperties:Ljava/util/HashMap;

    const-string v2, "action"

    new-instance v3, Lcom/openfeint/internal/resource/BlobUploadParameters$2;

    invoke-direct {v3}, Lcom/openfeint/internal/resource/BlobUploadParameters$2;-><init>()V

    invoke-virtual {v1, v2, v3}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v1, v0, Lcom/openfeint/internal/resource/ResourceClass;->mProperties:Ljava/util/HashMap;

    const-string v2, "key"

    new-instance v3, Lcom/openfeint/internal/resource/BlobUploadParameters$3;

    invoke-direct {v3}, Lcom/openfeint/internal/resource/BlobUploadParameters$3;-><init>()V

    invoke-virtual {v1, v2, v3}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v1, v0, Lcom/openfeint/internal/resource/ResourceClass;->mProperties:Ljava/util/HashMap;

    const-string v2, "AWSAccessKeyId"

    new-instance v3, Lcom/openfeint/internal/resource/BlobUploadParameters$4;

    invoke-direct {v3}, Lcom/openfeint/internal/resource/BlobUploadParameters$4;-><init>()V

    invoke-virtual {v1, v2, v3}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v1, v0, Lcom/openfeint/internal/resource/ResourceClass;->mProperties:Ljava/util/HashMap;

    const-string v2, "acl"

    new-instance v3, Lcom/openfeint/internal/resource/BlobUploadParameters$5;

    invoke-direct {v3}, Lcom/openfeint/internal/resource/BlobUploadParameters$5;-><init>()V

    invoke-virtual {v1, v2, v3}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v1, v0, Lcom/openfeint/internal/resource/ResourceClass;->mProperties:Ljava/util/HashMap;

    const-string v2, "policy"

    new-instance v3, Lcom/openfeint/internal/resource/BlobUploadParameters$6;

    invoke-direct {v3}, Lcom/openfeint/internal/resource/BlobUploadParameters$6;-><init>()V

    invoke-virtual {v1, v2, v3}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v1, v0, Lcom/openfeint/internal/resource/ResourceClass;->mProperties:Ljava/util/HashMap;

    const-string v2, "signature"

    new-instance v3, Lcom/openfeint/internal/resource/BlobUploadParameters$7;

    invoke-direct {v3}, Lcom/openfeint/internal/resource/BlobUploadParameters$7;-><init>()V

    invoke-virtual {v1, v2, v3}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    return-object v0
.end method
