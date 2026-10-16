.class final Lcom/openfeint/internal/request/Client$4;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/openfeint/internal/request/Client;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/openfeint/internal/request/Client;

.field final synthetic val$onResponse:Ljava/lang/Runnable;

.field final synthetic val$req:Lcom/openfeint/internal/request/BaseRequest;


# direct methods
.method constructor <init>(Lcom/openfeint/internal/request/Client;Lcom/openfeint/internal/request/BaseRequest;Ljava/lang/Runnable;)V
    .locals 0

    iput-object p1, p0, Lcom/openfeint/internal/request/Client$4;->this$0:Lcom/openfeint/internal/request/Client;

    iput-object p2, p0, Lcom/openfeint/internal/request/Client$4;->val$req:Lcom/openfeint/internal/request/BaseRequest;

    iput-object p3, p0, Lcom/openfeint/internal/request/Client$4;->val$onResponse:Ljava/lang/Runnable;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final run()V
    .locals 2

    iget-object v0, p0, Lcom/openfeint/internal/request/Client$4;->val$req:Lcom/openfeint/internal/request/BaseRequest;

    invoke-virtual {v0}, Lcom/openfeint/internal/request/BaseRequest;->getResponse()Lorg/apache/http/HttpResponse;

    move-result-object v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/openfeint/internal/request/Client$4;->val$req:Lcom/openfeint/internal/request/BaseRequest;

    invoke-virtual {v0}, Lcom/openfeint/internal/request/BaseRequest;->getFuture()Ljava/util/concurrent/Future;

    move-result-object v0

    const/4 v1, 0x1

    invoke-interface {v0, v1}, Ljava/util/concurrent/Future;->cancel(Z)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/openfeint/internal/request/Client$4;->val$req:Lcom/openfeint/internal/request/BaseRequest;

    invoke-virtual {v0}, Lcom/openfeint/internal/request/BaseRequest;->postTimeoutCleanup()V

    iget-object v0, p0, Lcom/openfeint/internal/request/Client$4;->this$0:Lcom/openfeint/internal/request/Client;

    invoke-static {v0}, Lcom/openfeint/internal/request/Client;->access$000(Lcom/openfeint/internal/request/Client;)Landroid/os/Handler;

    move-result-object v0

    iget-object v1, p0, Lcom/openfeint/internal/request/Client$4;->val$onResponse:Ljava/lang/Runnable;

    invoke-virtual {v0, v1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    :cond_0
    return-void
.end method
