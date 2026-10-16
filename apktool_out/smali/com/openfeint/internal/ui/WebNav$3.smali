.class Lcom/openfeint/internal/ui/WebNav$3;
.super Lcom/openfeint/internal/ui/WebViewCacheCallback;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/openfeint/internal/ui/WebNav;->load(Z)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/openfeint/internal/ui/WebNav;

.field final synthetic val$reload:Z


# direct methods
.method constructor <init>(Lcom/openfeint/internal/ui/WebNav;Z)V
    .locals 0

    iput-object p1, p0, Lcom/openfeint/internal/ui/WebNav$3;->this$0:Lcom/openfeint/internal/ui/WebNav;

    iput-boolean p2, p0, Lcom/openfeint/internal/ui/WebNav$3;->val$reload:Z

    invoke-direct {p0}, Lcom/openfeint/internal/ui/WebViewCacheCallback;-><init>()V

    return-void
.end method


# virtual methods
.method public failLoaded()V
    .locals 1

    iget-object v0, p0, Lcom/openfeint/internal/ui/WebNav$3;->this$0:Lcom/openfeint/internal/ui/WebNav;

    invoke-static {v0}, Lcom/openfeint/internal/ui/WebNav;->access$100(Lcom/openfeint/internal/ui/WebNav;)V

    return-void
.end method

.method public pathLoaded(Ljava/lang/String;)V
    .locals 4

    iget-object v0, p0, Lcom/openfeint/internal/ui/WebNav$3;->this$0:Lcom/openfeint/internal/ui/WebNav;

    iget-object v0, v0, Lcom/openfeint/internal/ui/WebNav;->mWebView:Landroid/webkit/WebView;

    if-eqz v0, :cond_0

    invoke-static {p1}, Lcom/openfeint/internal/ui/WebViewCache;->getItemUri(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "WebUI"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Loading URL: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/openfeint/internal/logcat/OFLog;->i(Ljava/lang/String;Ljava/lang/String;)V

    iget-boolean v1, p0, Lcom/openfeint/internal/ui/WebNav$3;->val$reload:Z

    if-eqz v1, :cond_1

    iget-object v0, p0, Lcom/openfeint/internal/ui/WebNav$3;->this$0:Lcom/openfeint/internal/ui/WebNav;

    iget-object v0, v0, Lcom/openfeint/internal/ui/WebNav;->mWebView:Landroid/webkit/WebView;

    invoke-virtual {v0}, Landroid/webkit/WebView;->reload()V

    :cond_0
    :goto_0
    return-void

    :cond_1
    iget-object v1, p0, Lcom/openfeint/internal/ui/WebNav$3;->this$0:Lcom/openfeint/internal/ui/WebNav;

    iget-object v1, v1, Lcom/openfeint/internal/ui/WebNav;->mWebView:Landroid/webkit/WebView;

    invoke-virtual {v1, v0}, Landroid/webkit/WebView;->loadUrl(Ljava/lang/String;)V

    goto :goto_0
.end method
