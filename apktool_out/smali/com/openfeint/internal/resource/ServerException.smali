.class public Lcom/openfeint/internal/resource/ServerException;
.super Lcom/openfeint/internal/resource/Resource;


# instance fields
.field public exceptionClass:Ljava/lang/String;

.field public message:Ljava/lang/String;

.field public needsDeveloperAttention:Z


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Lcom/openfeint/internal/resource/Resource;-><init>()V

    return-void
.end method

.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;)V
    .locals 0

    invoke-direct {p0}, Lcom/openfeint/internal/resource/Resource;-><init>()V

    iput-object p1, p0, Lcom/openfeint/internal/resource/ServerException;->exceptionClass:Ljava/lang/String;

    iput-object p2, p0, Lcom/openfeint/internal/resource/ServerException;->message:Ljava/lang/String;

    return-void
.end method

.method public static getResourceClass()Lcom/openfeint/internal/resource/ResourceClass;
    .locals 4

    new-instance v0, Lcom/openfeint/internal/resource/ServerException$1;

    const-class v1, Lcom/openfeint/internal/resource/ServerException;

    const-string v2, "exception"

    invoke-direct {v0, v1, v2}, Lcom/openfeint/internal/resource/ServerException$1;-><init>(Ljava/lang/Class;Ljava/lang/String;)V

    iget-object v1, v0, Lcom/openfeint/internal/resource/ResourceClass;->mProperties:Ljava/util/HashMap;

    const-string v2, "class"

    new-instance v3, Lcom/openfeint/internal/resource/ServerException$2;

    invoke-direct {v3}, Lcom/openfeint/internal/resource/ServerException$2;-><init>()V

    invoke-virtual {v1, v2, v3}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v1, v0, Lcom/openfeint/internal/resource/ResourceClass;->mProperties:Ljava/util/HashMap;

    const-string v2, "message"

    new-instance v3, Lcom/openfeint/internal/resource/ServerException$3;

    invoke-direct {v3}, Lcom/openfeint/internal/resource/ServerException$3;-><init>()V

    invoke-virtual {v1, v2, v3}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v1, v0, Lcom/openfeint/internal/resource/ResourceClass;->mProperties:Ljava/util/HashMap;

    const-string v2, "needs_developer_attention"

    new-instance v3, Lcom/openfeint/internal/resource/ServerException$4;

    invoke-direct {v3}, Lcom/openfeint/internal/resource/ServerException$4;-><init>()V

    invoke-virtual {v1, v2, v3}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    return-object v0
.end method
