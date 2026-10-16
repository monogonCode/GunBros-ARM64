.class Lcom/openfeint/internal/ui/NativeBrowser$1;
.super Landroid/webkit/WebViewClient;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/openfeint/internal/ui/NativeBrowser;->onCreate(Landroid/os/Bundle;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/openfeint/internal/ui/NativeBrowser;


# direct methods
.method constructor <init>(Lcom/openfeint/internal/ui/NativeBrowser;)V
    .locals 0

    iput-object p1, p0, Lcom/openfeint/internal/ui/NativeBrowser$1;->this$0:Lcom/openfeint/internal/ui/NativeBrowser;

    invoke-direct {p0}, Landroid/webkit/WebViewClient;-><init>()V

    return-void
.end method

.method private clearTimeout()V
    .locals 3

    const/4 v2, 0x0

    iget-object v0, p0, Lcom/openfeint/internal/ui/NativeBrowser$1;->this$0:Lcom/openfeint/internal/ui/NativeBrowser;

    invoke-static {v0}, Lcom/openfeint/internal/ui/NativeBrowser;->access$100(Lcom/openfeint/internal/ui/NativeBrowser;)Landroid/os/Handler;

    move-result-object v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/openfeint/internal/ui/NativeBrowser$1;->this$0:Lcom/openfeint/internal/ui/NativeBrowser;

    invoke-static {v0}, Lcom/openfeint/internal/ui/NativeBrowser;->access$200(Lcom/openfeint/internal/ui/NativeBrowser;)Ljava/lang/Runnable;

    move-result-object v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/openfeint/internal/ui/NativeBrowser$1;->this$0:Lcom/openfeint/internal/ui/NativeBrowser;

    invoke-static {v0}, Lcom/openfeint/internal/ui/NativeBrowser;->access$100(Lcom/openfeint/internal/ui/NativeBrowser;)Landroid/os/Handler;

    move-result-object v0

    iget-object v1, p0, Lcom/openfeint/internal/ui/NativeBrowser$1;->this$0:Lcom/openfeint/internal/ui/NativeBrowser;

    invoke-static {v1}, Lcom/openfeint/internal/ui/NativeBrowser;->access$200(Lcom/openfeint/internal/ui/NativeBrowser;)Ljava/lang/Runnable;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    iget-object v0, p0, Lcom/openfeint/internal/ui/NativeBrowser$1;->this$0:Lcom/openfeint/internal/ui/NativeBrowser;

    invoke-static {v0, v2}, Lcom/openfeint/internal/ui/NativeBrowser;->access$102(Lcom/openfeint/internal/ui/NativeBrowser;Landroid/os/Handler;)Landroid/os/Handler;

    iget-object v0, p0, Lcom/openfeint/internal/ui/NativeBrowser$1;->this$0:Lcom/openfeint/internal/ui/NativeBrowser;

    invoke-static {v0, v2}, Lcom/openfeint/internal/ui/NativeBrowser;->access$202(Lcom/openfeint/internal/ui/NativeBrowser;Ljava/lang/Runnable;)Ljava/lang/Runnable;

    :cond_0
    return-void
.end method


# virtual methods
.method public onPageFinished(Landroid/webkit/WebView;Ljava/lang/String;)V
    .locals 0

    invoke-direct {p0}, Lcom/openfeint/internal/ui/NativeBrowser$1;->clearTimeout()V

    invoke-super {p0, p1, p2}, Landroid/webkit/WebViewClient;->onPageFinished(Landroid/webkit/WebView;Ljava/lang/String;)V

    return-void
.end method

.method public onReceivedError(Landroid/webkit/WebView;ILjava/lang/String;Ljava/lang/String;)V
    .locals 3

    invoke-direct {p0}, Lcom/openfeint/internal/ui/NativeBrowser$1;->clearTimeout()V

    invoke-super {p0, p1, p2, p3, p4}, Landroid/webkit/WebViewClient;->onReceivedError(Landroid/webkit/WebView;ILjava/lang/String;Ljava/lang/String;)V

    new-instance v0, Landroid/content/Intent;

    invoke-direct {v0}, Landroid/content/Intent;-><init>()V

    const-string v1, "com.openfeint.internal.ui.NativeBrowser.argument.failed"

    const/4 v2, 0x1

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Z)Landroid/content/Intent;

    const-string v1, "com.openfeint.internal.ui.NativeBrowser.argument.failure_code"

    invoke-virtual {v0, v1, p2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    const-string v1, "com.openfeint.internal.ui.NativeBrowser.argument.failure_desc"

    invoke-virtual {v0, v1, p3}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    iget-object v1, p0, Lcom/openfeint/internal/ui/NativeBrowser$1;->this$0:Lcom/openfeint/internal/ui/NativeBrowser;

    const/4 v2, -0x1

    invoke-virtual {v1, v2, v0}, Lcom/openfeint/internal/ui/NativeBrowser;->setResult(ILandroid/content/Intent;)V

    iget-object v0, p0, Lcom/openfeint/internal/ui/NativeBrowser$1;->this$0:Lcom/openfeint/internal/ui/NativeBrowser;

    invoke-virtual {v0}, Lcom/openfeint/internal/ui/NativeBrowser;->finish()V

    return-void
.end method
