.class final Lcom/openfeint/internal/OpenFeintInternal$10;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/openfeint/internal/OpenFeintInternal;->login(Z)V
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

    iput-object p1, p0, Lcom/openfeint/internal/OpenFeintInternal$10;->this$0:Lcom/openfeint/internal/OpenFeintInternal;

    iput-boolean p2, p0, Lcom/openfeint/internal/OpenFeintInternal$10;->val$spotlight:Z

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final run()V
    .locals 5

    const/4 v4, 0x0

    iget-object v0, p0, Lcom/openfeint/internal/OpenFeintInternal$10;->this$0:Lcom/openfeint/internal/OpenFeintInternal;

    invoke-static {v0}, Lcom/openfeint/internal/OpenFeintInternal;->access$1200(Lcom/openfeint/internal/OpenFeintInternal;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/openfeint/internal/OpenFeintInternal$10;->this$0:Lcom/openfeint/internal/OpenFeintInternal;

    invoke-static {v0}, Lcom/openfeint/internal/OpenFeintInternal;->access$900(Lcom/openfeint/internal/OpenFeintInternal;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/openfeint/internal/OpenFeintInternal$10;->this$0:Lcom/openfeint/internal/OpenFeintInternal;

    invoke-virtual {v0}, Lcom/openfeint/internal/OpenFeintInternal;->isUserLoggedIn()Z

    move-result v0

    if-eqz v0, :cond_1

    :cond_0
    :goto_0
    return-void

    :cond_1
    iget-object v0, p0, Lcom/openfeint/internal/OpenFeintInternal$10;->this$0:Lcom/openfeint/internal/OpenFeintInternal;

    invoke-static {v0}, Lcom/openfeint/internal/OpenFeintInternal;->access$1302$78278a84(Lcom/openfeint/internal/OpenFeintInternal;)Z

    iget-object v0, p0, Lcom/openfeint/internal/OpenFeintInternal$10;->this$0:Lcom/openfeint/internal/OpenFeintInternal;

    invoke-static {v0}, Lcom/openfeint/internal/OpenFeintInternal;->access$1400(Lcom/openfeint/internal/OpenFeintInternal;)Lcom/openfeint/api/resource/User;

    move-result-object v0

    if-eqz v0, :cond_2

    const-string v1, "OpenFeintInternal"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Logging in last known user: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, v0, Lcom/openfeint/api/resource/User;->name:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/openfeint/internal/logcat/OFLog;->i(Ljava/lang/String;Ljava/lang/String;)V

    iget-object v1, p0, Lcom/openfeint/internal/OpenFeintInternal$10;->this$0:Lcom/openfeint/internal/OpenFeintInternal;

    new-instance v2, Lcom/openfeint/internal/OpenFeintInternal$10$1;

    invoke-direct {v2, p0, v0}, Lcom/openfeint/internal/OpenFeintInternal$10$1;-><init>(Lcom/openfeint/internal/OpenFeintInternal$10;Lcom/openfeint/api/resource/User;)V

    invoke-virtual {v1, v4, v4, v4, v2}, Lcom/openfeint/internal/OpenFeintInternal;->loginUser(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/openfeint/internal/request/IRawRequestDelegate;)V

    goto :goto_0

    :cond_2
    const-string v0, "OpenFeintInternal"

    const-string v1, "No last user, launch intro flow"

    invoke-static {v0, v1}, Lcom/openfeint/internal/logcat/OFLog;->i(Ljava/lang/String;Ljava/lang/String;)V

    iget-object v0, p0, Lcom/openfeint/internal/OpenFeintInternal$10;->this$0:Lcom/openfeint/internal/OpenFeintInternal;

    invoke-static {v0}, Lcom/openfeint/internal/OpenFeintInternal;->access$1600(Lcom/openfeint/internal/OpenFeintInternal;)V

    iget-object v0, p0, Lcom/openfeint/internal/OpenFeintInternal$10;->this$0:Lcom/openfeint/internal/OpenFeintInternal;

    iget-boolean v1, p0, Lcom/openfeint/internal/OpenFeintInternal$10;->val$spotlight:Z

    invoke-virtual {v0, v1}, Lcom/openfeint/internal/OpenFeintInternal;->launchIntroFlow(Z)V

    goto :goto_0
.end method
