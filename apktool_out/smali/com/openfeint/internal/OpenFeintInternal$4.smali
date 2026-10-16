.class final Lcom/openfeint/internal/OpenFeintInternal$4;
.super Lcom/openfeint/internal/request/RawRequest;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/openfeint/internal/OpenFeintInternal;->loginUser(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/openfeint/internal/request/IRawRequestDelegate;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/openfeint/internal/OpenFeintInternal;

.field final synthetic val$finalToast:Z


# direct methods
.method constructor <init>(Lcom/openfeint/internal/OpenFeintInternal;Lcom/openfeint/internal/request/OrderedArgList;Z)V
    .locals 0

    iput-object p1, p0, Lcom/openfeint/internal/OpenFeintInternal$4;->this$0:Lcom/openfeint/internal/OpenFeintInternal;

    iput-boolean p3, p0, Lcom/openfeint/internal/OpenFeintInternal$4;->val$finalToast:Z

    invoke-direct {p0, p2}, Lcom/openfeint/internal/request/RawRequest;-><init>(Lcom/openfeint/internal/request/OrderedArgList;)V

    return-void
.end method


# virtual methods
.method public final method()Ljava/lang/String;
    .locals 1

    const-string v0, "POST"

    return-object v0
.end method

.method public final onResponse(ILjava/lang/Object;)V
    .locals 3

    iget-object v0, p0, Lcom/openfeint/internal/OpenFeintInternal$4;->this$0:Lcom/openfeint/internal/OpenFeintInternal;

    invoke-static {v0}, Lcom/openfeint/internal/OpenFeintInternal;->access$902$78278a84(Lcom/openfeint/internal/OpenFeintInternal;)Z

    const/16 v0, 0xc8

    if-gt v0, p1, :cond_1

    const/16 v0, 0x12c

    if-ge p1, v0, :cond_1

    iget-object v0, p0, Lcom/openfeint/internal/OpenFeintInternal$4;->this$0:Lcom/openfeint/internal/OpenFeintInternal;

    check-cast p2, Lcom/openfeint/api/resource/User;

    invoke-static {v0, p2}, Lcom/openfeint/internal/OpenFeintInternal;->access$100(Lcom/openfeint/internal/OpenFeintInternal;Lcom/openfeint/api/resource/User;)V

    iget-object v0, p0, Lcom/openfeint/internal/OpenFeintInternal$4;->this$0:Lcom/openfeint/internal/OpenFeintInternal;

    invoke-static {v0}, Lcom/openfeint/internal/OpenFeintInternal;->access$600(Lcom/openfeint/internal/OpenFeintInternal;)Ljava/lang/Runnable;

    move-result-object v0

    if-eqz v0, :cond_0

    sget-object v0, Lcom/openfeint/internal/OpenFeintInternal$4;->TAG:Ljava/lang/String;

    const-string v1, "Launching post-login runnable now."

    invoke-static {v0, v1}, Lcom/openfeint/internal/logcat/OFLog;->i(Ljava/lang/String;Ljava/lang/String;)V

    iget-object v0, p0, Lcom/openfeint/internal/OpenFeintInternal$4;->this$0:Lcom/openfeint/internal/OpenFeintInternal;

    iget-object v0, v0, Lcom/openfeint/internal/OpenFeintInternal;->mMainThreadHandler:Landroid/os/Handler;

    iget-object v1, p0, Lcom/openfeint/internal/OpenFeintInternal$4;->this$0:Lcom/openfeint/internal/OpenFeintInternal;

    invoke-static {v1}, Lcom/openfeint/internal/OpenFeintInternal;->access$600(Lcom/openfeint/internal/OpenFeintInternal;)Ljava/lang/Runnable;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    :cond_0
    :goto_0
    iget-object v0, p0, Lcom/openfeint/internal/OpenFeintInternal$4;->this$0:Lcom/openfeint/internal/OpenFeintInternal;

    invoke-static {v0}, Lcom/openfeint/internal/OpenFeintInternal;->access$1000(Lcom/openfeint/internal/OpenFeintInternal;)Ljava/util/List;

    move-result-object v0

    if-eqz v0, :cond_2

    iget-object v0, p0, Lcom/openfeint/internal/OpenFeintInternal$4;->this$0:Lcom/openfeint/internal/OpenFeintInternal;

    invoke-static {v0}, Lcom/openfeint/internal/OpenFeintInternal;->access$1000(Lcom/openfeint/internal/OpenFeintInternal;)Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_1
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_2

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Runnable;

    iget-object v2, p0, Lcom/openfeint/internal/OpenFeintInternal$4;->this$0:Lcom/openfeint/internal/OpenFeintInternal;

    iget-object v2, v2, Lcom/openfeint/internal/OpenFeintInternal;->mMainThreadHandler:Landroid/os/Handler;

    invoke-virtual {v2, v0}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    goto :goto_1

    :cond_1
    iget-boolean v0, p0, Lcom/openfeint/internal/OpenFeintInternal$4;->val$finalToast:Z

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/openfeint/internal/OpenFeintInternal$4;->this$0:Lcom/openfeint/internal/OpenFeintInternal;

    invoke-static {v0, p1, p2}, Lcom/openfeint/internal/OpenFeintInternal;->access$700(Lcom/openfeint/internal/OpenFeintInternal;ILjava/lang/Object;)V

    goto :goto_0

    :cond_2
    iget-object v0, p0, Lcom/openfeint/internal/OpenFeintInternal$4;->this$0:Lcom/openfeint/internal/OpenFeintInternal;

    invoke-static {v0}, Lcom/openfeint/internal/OpenFeintInternal;->access$602$5f63a5fa(Lcom/openfeint/internal/OpenFeintInternal;)Ljava/lang/Runnable;

    iget-object v0, p0, Lcom/openfeint/internal/OpenFeintInternal$4;->this$0:Lcom/openfeint/internal/OpenFeintInternal;

    invoke-static {v0}, Lcom/openfeint/internal/OpenFeintInternal;->access$1002$207cf26(Lcom/openfeint/internal/OpenFeintInternal;)Ljava/util/List;

    return-void
.end method

.method public final path()Ljava/lang/String;
    .locals 1

    const-string v0, "/xp/sessions.json"

    return-object v0
.end method
