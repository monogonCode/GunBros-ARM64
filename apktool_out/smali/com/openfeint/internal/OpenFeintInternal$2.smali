.class final Lcom/openfeint/internal/OpenFeintInternal$2;
.super Lcom/openfeint/internal/request/RawRequest;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/openfeint/internal/OpenFeintInternal;->createDeviceSession()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/openfeint/internal/OpenFeintInternal;


# direct methods
.method constructor <init>(Lcom/openfeint/internal/OpenFeintInternal;Lcom/openfeint/internal/request/OrderedArgList;)V
    .locals 0

    iput-object p1, p0, Lcom/openfeint/internal/OpenFeintInternal$2;->this$0:Lcom/openfeint/internal/OpenFeintInternal;

    invoke-direct {p0, p2}, Lcom/openfeint/internal/request/RawRequest;-><init>(Lcom/openfeint/internal/request/OrderedArgList;)V

    return-void
.end method


# virtual methods
.method public final method()Ljava/lang/String;
    .locals 1

    const-string v0, "POST"

    return-object v0
.end method

.method public final needsDeviceSession()Z
    .locals 1

    const/4 v0, 0x0

    return v0
.end method

.method public final onResponse(ILjava/lang/Object;)V
    .locals 3

    iget-object v0, p0, Lcom/openfeint/internal/OpenFeintInternal$2;->this$0:Lcom/openfeint/internal/OpenFeintInternal;

    invoke-static {v0}, Lcom/openfeint/internal/OpenFeintInternal;->access$202$78278a84(Lcom/openfeint/internal/OpenFeintInternal;)Z

    const/16 v0, 0xc8

    if-gt v0, p1, :cond_3

    const/16 v0, 0x12c

    if-ge p1, v0, :cond_3

    instance-of v0, p2, Lcom/openfeint/internal/resource/Device;

    if-eqz v0, :cond_0

    check-cast p2, Lcom/openfeint/internal/resource/Device;

    iget-object v1, p0, Lcom/openfeint/internal/OpenFeintInternal$2;->this$0:Lcom/openfeint/internal/OpenFeintInternal;

    iget-object v0, p2, Lcom/openfeint/internal/resource/Device;->parental_control:Lcom/openfeint/internal/resource/ParentalControl;

    if-eqz v0, :cond_2

    iget-object v0, p2, Lcom/openfeint/internal/resource/Device;->parental_control:Lcom/openfeint/internal/resource/ParentalControl;

    iget-boolean v0, v0, Lcom/openfeint/internal/resource/ParentalControl;->enabled:Z

    if-eqz v0, :cond_2

    const/4 v0, 0x1

    :goto_0
    invoke-static {v1, v0}, Lcom/openfeint/internal/OpenFeintInternal;->access$302(Lcom/openfeint/internal/OpenFeintInternal;Z)Z

    :cond_0
    iget-object v0, p0, Lcom/openfeint/internal/OpenFeintInternal$2;->this$0:Lcom/openfeint/internal/OpenFeintInternal;

    invoke-static {v0}, Lcom/openfeint/internal/OpenFeintInternal;->access$402$78278a84(Lcom/openfeint/internal/OpenFeintInternal;)Z

    iget-object v0, p0, Lcom/openfeint/internal/OpenFeintInternal$2;->this$0:Lcom/openfeint/internal/OpenFeintInternal;

    invoke-static {v0}, Lcom/openfeint/internal/OpenFeintInternal;->access$500(Lcom/openfeint/internal/OpenFeintInternal;)Ljava/lang/Runnable;

    move-result-object v0

    if-eqz v0, :cond_1

    sget-object v0, Lcom/openfeint/internal/OpenFeintInternal$2;->TAG:Ljava/lang/String;

    const-string v1, "Launching post-device-session runnable now."

    invoke-static {v0, v1}, Lcom/openfeint/internal/logcat/OFLog;->i(Ljava/lang/String;Ljava/lang/String;)V

    iget-object v0, p0, Lcom/openfeint/internal/OpenFeintInternal$2;->this$0:Lcom/openfeint/internal/OpenFeintInternal;

    iget-object v0, v0, Lcom/openfeint/internal/OpenFeintInternal;->mMainThreadHandler:Landroid/os/Handler;

    iget-object v1, p0, Lcom/openfeint/internal/OpenFeintInternal$2;->this$0:Lcom/openfeint/internal/OpenFeintInternal;

    invoke-static {v1}, Lcom/openfeint/internal/OpenFeintInternal;->access$500(Lcom/openfeint/internal/OpenFeintInternal;)Ljava/lang/Runnable;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    :cond_1
    :goto_1
    iget-object v0, p0, Lcom/openfeint/internal/OpenFeintInternal$2;->this$0:Lcom/openfeint/internal/OpenFeintInternal;

    invoke-static {v0}, Lcom/openfeint/internal/OpenFeintInternal;->access$800(Lcom/openfeint/internal/OpenFeintInternal;)Ljava/util/List;

    move-result-object v0

    if-eqz v0, :cond_4

    iget-object v0, p0, Lcom/openfeint/internal/OpenFeintInternal$2;->this$0:Lcom/openfeint/internal/OpenFeintInternal;

    invoke-static {v0}, Lcom/openfeint/internal/OpenFeintInternal;->access$800(Lcom/openfeint/internal/OpenFeintInternal;)Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_2
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_4

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Runnable;

    iget-object v2, p0, Lcom/openfeint/internal/OpenFeintInternal$2;->this$0:Lcom/openfeint/internal/OpenFeintInternal;

    iget-object v2, v2, Lcom/openfeint/internal/OpenFeintInternal;->mMainThreadHandler:Landroid/os/Handler;

    invoke-virtual {v2, v0}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    goto :goto_2

    :cond_2
    const/4 v0, 0x0

    goto :goto_0

    :cond_3
    iget-object v0, p0, Lcom/openfeint/internal/OpenFeintInternal$2;->this$0:Lcom/openfeint/internal/OpenFeintInternal;

    invoke-static {v0}, Lcom/openfeint/internal/OpenFeintInternal;->access$602$5f63a5fa(Lcom/openfeint/internal/OpenFeintInternal;)Ljava/lang/Runnable;

    iget-object v0, p0, Lcom/openfeint/internal/OpenFeintInternal$2;->this$0:Lcom/openfeint/internal/OpenFeintInternal;

    invoke-static {v0, p1, p2}, Lcom/openfeint/internal/OpenFeintInternal;->access$700(Lcom/openfeint/internal/OpenFeintInternal;ILjava/lang/Object;)V

    goto :goto_1

    :cond_4
    iget-object v0, p0, Lcom/openfeint/internal/OpenFeintInternal$2;->this$0:Lcom/openfeint/internal/OpenFeintInternal;

    invoke-static {v0}, Lcom/openfeint/internal/OpenFeintInternal;->access$502$5f63a5fa(Lcom/openfeint/internal/OpenFeintInternal;)Ljava/lang/Runnable;

    iget-object v0, p0, Lcom/openfeint/internal/OpenFeintInternal$2;->this$0:Lcom/openfeint/internal/OpenFeintInternal;

    invoke-static {v0}, Lcom/openfeint/internal/OpenFeintInternal;->access$802$207cf26(Lcom/openfeint/internal/OpenFeintInternal;)Ljava/util/List;

    return-void
.end method

.method public final path()Ljava/lang/String;
    .locals 1

    const-string v0, "/xp/devices"

    return-object v0
.end method
