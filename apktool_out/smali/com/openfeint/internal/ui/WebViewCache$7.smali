.class final Lcom/openfeint/internal/ui/WebViewCache$7;
.super Lcom/openfeint/internal/request/BaseRequest;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/openfeint/internal/ui/WebViewCache;->singleRequest(Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/openfeint/internal/ui/WebViewCache;

.field final synthetic val$finalPath:Ljava/lang/String;


# direct methods
.method constructor <init>(Lcom/openfeint/internal/ui/WebViewCache;Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lcom/openfeint/internal/ui/WebViewCache$7;->this$0:Lcom/openfeint/internal/ui/WebViewCache;

    iput-object p2, p0, Lcom/openfeint/internal/ui/WebViewCache$7;->val$finalPath:Ljava/lang/String;

    invoke-direct {p0}, Lcom/openfeint/internal/request/BaseRequest;-><init>()V

    return-void
.end method


# virtual methods
.method public final method()Ljava/lang/String;
    .locals 1

    const-string v0, "GET"

    return-object v0
.end method

.method public final onResponse(I[B)V
    .locals 4

    const/4 v3, 0x1

    const/4 v2, 0x0

    const/16 v0, 0xc8

    if-eq p1, v0, :cond_0

    iget-object v0, p0, Lcom/openfeint/internal/ui/WebViewCache$7;->this$0:Lcom/openfeint/internal/ui/WebViewCache;

    iget-object v0, v0, Lcom/openfeint/internal/ui/WebViewCache;->mHandler:Landroid/os/Handler;

    iget-object v1, p0, Lcom/openfeint/internal/ui/WebViewCache$7;->val$finalPath:Ljava/lang/String;

    invoke-static {v0, v3, v2, v2, v1}, Landroid/os/Message;->obtain(Landroid/os/Handler;IIILjava/lang/Object;)Landroid/os/Message;

    move-result-object v0

    invoke-virtual {v0}, Landroid/os/Message;->sendToTarget()V

    :goto_0
    return-void

    :cond_0
    :try_start_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-static {}, Lcom/openfeint/internal/ui/WebViewCache;->access$1600()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/openfeint/internal/ui/WebViewCache$7;->val$finalPath:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {p2, v0}, Lcom/openfeint/internal/Util;->saveFile([BLjava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    iget-object v0, p0, Lcom/openfeint/internal/ui/WebViewCache$7;->this$0:Lcom/openfeint/internal/ui/WebViewCache;

    iget-object v0, v0, Lcom/openfeint/internal/ui/WebViewCache;->mHandler:Landroid/os/Handler;

    iget-object v1, p0, Lcom/openfeint/internal/ui/WebViewCache$7;->val$finalPath:Ljava/lang/String;

    invoke-static {v0, v3, v3, v2, v1}, Landroid/os/Message;->obtain(Landroid/os/Handler;IIILjava/lang/Object;)Landroid/os/Message;

    move-result-object v0

    invoke-virtual {v0}, Landroid/os/Message;->sendToTarget()V

    goto :goto_0

    :catch_0
    move-exception v0

    iget-object v0, p0, Lcom/openfeint/internal/ui/WebViewCache$7;->this$0:Lcom/openfeint/internal/ui/WebViewCache;

    iget-object v0, v0, Lcom/openfeint/internal/ui/WebViewCache;->mHandler:Landroid/os/Handler;

    iget-object v1, p0, Lcom/openfeint/internal/ui/WebViewCache$7;->val$finalPath:Ljava/lang/String;

    invoke-static {v0, v3, v2, v2, v1}, Landroid/os/Message;->obtain(Landroid/os/Handler;IIILjava/lang/Object;)Landroid/os/Message;

    move-result-object v0

    invoke-virtual {v0}, Landroid/os/Message;->sendToTarget()V

    goto :goto_0
.end method

.method public final path()Ljava/lang/String;
    .locals 2

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "/webui/"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/openfeint/internal/ui/WebViewCache$7;->val$finalPath:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public final signed()Z
    .locals 1

    const/4 v0, 0x0

    return v0
.end method
