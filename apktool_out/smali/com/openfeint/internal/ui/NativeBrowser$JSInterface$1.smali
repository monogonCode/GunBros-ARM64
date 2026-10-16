.class Lcom/openfeint/internal/ui/NativeBrowser$JSInterface$1;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/openfeint/internal/ui/NativeBrowser$JSInterface;->returnValue(Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lcom/openfeint/internal/ui/NativeBrowser$JSInterface;

.field final synthetic val$returnValue:Ljava/lang/String;


# direct methods
.method constructor <init>(Lcom/openfeint/internal/ui/NativeBrowser$JSInterface;Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lcom/openfeint/internal/ui/NativeBrowser$JSInterface$1;->this$1:Lcom/openfeint/internal/ui/NativeBrowser$JSInterface;

    iput-object p2, p0, Lcom/openfeint/internal/ui/NativeBrowser$JSInterface$1;->val$returnValue:Ljava/lang/String;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    iget-object v0, p0, Lcom/openfeint/internal/ui/NativeBrowser$JSInterface$1;->this$1:Lcom/openfeint/internal/ui/NativeBrowser$JSInterface;

    iget-object v0, v0, Lcom/openfeint/internal/ui/NativeBrowser$JSInterface;->this$0:Lcom/openfeint/internal/ui/NativeBrowser;

    invoke-static {v0}, Lcom/openfeint/internal/ui/NativeBrowser;->access$000(Lcom/openfeint/internal/ui/NativeBrowser;)Ljava/util/concurrent/atomic/AtomicBoolean;

    move-result-object v0

    const/4 v1, 0x0

    const/4 v2, 0x1

    invoke-virtual {v0, v1, v2}, Ljava/util/concurrent/atomic/AtomicBoolean;->compareAndSet(ZZ)Z

    move-result v0

    if-eqz v0, :cond_1

    new-instance v0, Landroid/content/Intent;

    invoke-direct {v0}, Landroid/content/Intent;-><init>()V

    iget-object v1, p0, Lcom/openfeint/internal/ui/NativeBrowser$JSInterface$1;->val$returnValue:Ljava/lang/String;

    if-eqz v1, :cond_0

    const-string v1, "com.openfeint.internal.ui.NativeBrowser.argument.result"

    iget-object v2, p0, Lcom/openfeint/internal/ui/NativeBrowser$JSInterface$1;->val$returnValue:Ljava/lang/String;

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    :cond_0
    iget-object v1, p0, Lcom/openfeint/internal/ui/NativeBrowser$JSInterface$1;->this$1:Lcom/openfeint/internal/ui/NativeBrowser$JSInterface;

    iget-object v1, v1, Lcom/openfeint/internal/ui/NativeBrowser$JSInterface;->this$0:Lcom/openfeint/internal/ui/NativeBrowser;

    const/4 v2, -0x1

    invoke-virtual {v1, v2, v0}, Lcom/openfeint/internal/ui/NativeBrowser;->setResult(ILandroid/content/Intent;)V

    iget-object v0, p0, Lcom/openfeint/internal/ui/NativeBrowser$JSInterface$1;->this$1:Lcom/openfeint/internal/ui/NativeBrowser$JSInterface;

    iget-object v0, v0, Lcom/openfeint/internal/ui/NativeBrowser$JSInterface;->this$0:Lcom/openfeint/internal/ui/NativeBrowser;

    invoke-virtual {v0}, Lcom/openfeint/internal/ui/NativeBrowser;->finish()V

    :cond_1
    return-void
.end method
