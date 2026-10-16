.class final Lcom/openfeint/api/resource/User$1;
.super Lcom/openfeint/internal/request/JSONRequest;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/openfeint/api/resource/User;->load$70059c05()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/openfeint/api/resource/User;

.field final synthetic val$cb:Lcom/openfeint/api/resource/User$LoadCB;


# direct methods
.method constructor <init>(Lcom/openfeint/api/resource/User;)V
    .locals 1

    iput-object p1, p0, Lcom/openfeint/api/resource/User$1;->this$0:Lcom/openfeint/api/resource/User;

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/openfeint/api/resource/User$1;->val$cb:Lcom/openfeint/api/resource/User$LoadCB;

    invoke-direct {p0}, Lcom/openfeint/internal/request/JSONRequest;-><init>()V

    return-void
.end method


# virtual methods
.method public final method()Ljava/lang/String;
    .locals 1

    const-string v0, "GET"

    return-object v0
.end method

.method public final onFailure(Ljava/lang/String;)V
    .locals 1

    invoke-super {p0, p1}, Lcom/openfeint/internal/request/JSONRequest;->onFailure(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/openfeint/api/resource/User$1;->val$cb:Lcom/openfeint/api/resource/User$LoadCB;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/openfeint/api/resource/User$1;->val$cb:Lcom/openfeint/api/resource/User$LoadCB;

    invoke-virtual {v0, p1}, Lcom/openfeint/api/resource/User$LoadCB;->onFailure(Ljava/lang/String;)V

    :cond_0
    return-void
.end method

.method public final onSuccess(Ljava/lang/Object;)V
    .locals 1

    iget-object v0, p0, Lcom/openfeint/api/resource/User$1;->this$0:Lcom/openfeint/api/resource/User;

    check-cast p1, Lcom/openfeint/api/resource/User;

    invoke-virtual {v0, p1}, Lcom/openfeint/api/resource/User;->shallowCopyAncestorType(Lcom/openfeint/internal/resource/Resource;)V

    iget-object v0, p0, Lcom/openfeint/api/resource/User$1;->val$cb:Lcom/openfeint/api/resource/User$LoadCB;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/openfeint/api/resource/User$1;->val$cb:Lcom/openfeint/api/resource/User$LoadCB;

    :cond_0
    return-void
.end method

.method public final path()Ljava/lang/String;
    .locals 2

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "/xp/users/"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/openfeint/api/resource/User$1;->this$0:Lcom/openfeint/api/resource/User;

    invoke-virtual {v1}, Lcom/openfeint/api/resource/User;->resourceID()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
