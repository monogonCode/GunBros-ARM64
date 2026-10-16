.class final Lcom/openfeint/internal/OpenFeintInternal$11;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/openfeint/internal/OpenFeintInternal;->launchIntroFlow(Z)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/openfeint/internal/OpenFeintInternal;

.field final synthetic val$spotlight:Z


# direct methods
.method constructor <init>(Lcom/openfeint/internal/OpenFeintInternal;Z)V
    .locals 0

    iput-object p1, p0, Lcom/openfeint/internal/OpenFeintInternal$11;->this$0:Lcom/openfeint/internal/OpenFeintInternal;

    iput-boolean p2, p0, Lcom/openfeint/internal/OpenFeintInternal$11;->val$spotlight:Z

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final run()V
    .locals 4

    new-instance v0, Landroid/content/Intent;

    iget-object v1, p0, Lcom/openfeint/internal/OpenFeintInternal$11;->this$0:Lcom/openfeint/internal/OpenFeintInternal;

    invoke-virtual {v1}, Lcom/openfeint/internal/OpenFeintInternal;->getContext()Landroid/content/Context;

    move-result-object v1

    const-class v2, Lcom/openfeint/internal/ui/IntroFlow;

    invoke-direct {v0, v1, v2}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    iget-object v1, p0, Lcom/openfeint/internal/OpenFeintInternal$11;->this$0:Lcom/openfeint/internal/OpenFeintInternal;

    invoke-static {v1}, Lcom/openfeint/internal/OpenFeintInternal;->access$1700(Lcom/openfeint/internal/OpenFeintInternal;)Z

    move-result v1

    if-eqz v1, :cond_1

    iget-boolean v1, p0, Lcom/openfeint/internal/OpenFeintInternal$11;->val$spotlight:Z

    if-eqz v1, :cond_1

    const-string v1, "content_name"

    const-string v2, "index?preapproved=true&spotlight=true"

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    :cond_0
    :goto_0
    const/high16 v1, 0x10000000

    invoke-virtual {v0, v1}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    const-string v1, "OpenFeintInternal"

    const-string v2, "show prompt_enable_of"

    invoke-static {v1, v2}, Lcom/openfeint/internal/logcat/OFLog;->w(Ljava/lang/String;Ljava/lang/String;)V

    invoke-static {}, Lcom/openfeint/internal/eventlog/EventLogDispatcher;->getInstance()Lcom/openfeint/internal/eventlog/EventLogDispatcher;

    move-result-object v1

    const-string v2, "prompt_enable_of.openfeint.com"

    const/4 v3, 0x0

    invoke-virtual {v1, v2, v3}, Lcom/openfeint/internal/eventlog/EventLogDispatcher;->postEvent(Ljava/lang/String;Ljava/lang/Object;)V

    iget-object v1, p0, Lcom/openfeint/internal/OpenFeintInternal$11;->this$0:Lcom/openfeint/internal/OpenFeintInternal;

    invoke-virtual {v1}, Lcom/openfeint/internal/OpenFeintInternal;->getContext()Landroid/content/Context;

    move-result-object v1

    invoke-virtual {v1, v0}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V

    return-void

    :cond_1
    iget-boolean v1, p0, Lcom/openfeint/internal/OpenFeintInternal$11;->val$spotlight:Z

    if-eqz v1, :cond_2

    const-string v1, "content_name"

    const-string v2, "index?spotlight=true"

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    goto :goto_0

    :cond_2
    iget-object v1, p0, Lcom/openfeint/internal/OpenFeintInternal$11;->this$0:Lcom/openfeint/internal/OpenFeintInternal;

    invoke-static {v1}, Lcom/openfeint/internal/OpenFeintInternal;->access$1700(Lcom/openfeint/internal/OpenFeintInternal;)Z

    move-result v1

    if-eqz v1, :cond_0

    const-string v1, "content_name"

    const-string v2, "index?preapproved=true"

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    goto :goto_0
.end method
