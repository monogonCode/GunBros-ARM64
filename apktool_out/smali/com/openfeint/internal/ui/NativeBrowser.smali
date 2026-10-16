.class public Lcom/openfeint/internal/ui/NativeBrowser;
.super Lcom/openfeint/internal/ui/NestedWindow;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/openfeint/internal/ui/NativeBrowser$JSInterface;
    }
.end annotation


# instance fields
.field private mFinished:Ljava/util/concurrent/atomic/AtomicBoolean;

.field private mHandler:Landroid/os/Handler;

.field private mTimeoutWatchdog:Ljava/lang/Runnable;


# direct methods
.method public constructor <init>()V
    .locals 2

    invoke-direct {p0}, Lcom/openfeint/internal/ui/NestedWindow;-><init>()V

    new-instance v0, Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;-><init>(Z)V

    iput-object v0, p0, Lcom/openfeint/internal/ui/NativeBrowser;->mFinished:Ljava/util/concurrent/atomic/AtomicBoolean;

    return-void
.end method

.method static synthetic access$000(Lcom/openfeint/internal/ui/NativeBrowser;)Ljava/util/concurrent/atomic/AtomicBoolean;
    .locals 1

    iget-object v0, p0, Lcom/openfeint/internal/ui/NativeBrowser;->mFinished:Ljava/util/concurrent/atomic/AtomicBoolean;

    return-object v0
.end method

.method static synthetic access$100(Lcom/openfeint/internal/ui/NativeBrowser;)Landroid/os/Handler;
    .locals 1

    iget-object v0, p0, Lcom/openfeint/internal/ui/NativeBrowser;->mHandler:Landroid/os/Handler;

    return-object v0
.end method

.method static synthetic access$102(Lcom/openfeint/internal/ui/NativeBrowser;Landroid/os/Handler;)Landroid/os/Handler;
    .locals 0

    iput-object p1, p0, Lcom/openfeint/internal/ui/NativeBrowser;->mHandler:Landroid/os/Handler;

    return-object p1
.end method

.method static synthetic access$200(Lcom/openfeint/internal/ui/NativeBrowser;)Ljava/lang/Runnable;
    .locals 1

    iget-object v0, p0, Lcom/openfeint/internal/ui/NativeBrowser;->mTimeoutWatchdog:Ljava/lang/Runnable;

    return-object v0
.end method

.method static synthetic access$202(Lcom/openfeint/internal/ui/NativeBrowser;Ljava/lang/Runnable;)Ljava/lang/Runnable;
    .locals 0

    iput-object p1, p0, Lcom/openfeint/internal/ui/NativeBrowser;->mTimeoutWatchdog:Ljava/lang/Runnable;

    return-object p1
.end method


# virtual methods
.method public onCreate(Landroid/os/Bundle;)V
    .locals 6

    const/4 v5, 0x1

    invoke-super {p0, p1}, Lcom/openfeint/internal/ui/NestedWindow;->onCreate(Landroid/os/Bundle;)V

    invoke-virtual {p0}, Lcom/openfeint/internal/ui/NativeBrowser;->getIntent()Landroid/content/Intent;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/Intent;->getExtras()Landroid/os/Bundle;

    move-result-object v0

    const-string v1, "com.openfeint.internal.ui.NativeBrowser.argument.src"

    invoke-virtual {v0, v1}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    const-string v2, "com.openfeint.internal.ui.NativeBrowser.argument.timeout"

    invoke-virtual {v0, v2}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iget-object v2, p0, Lcom/openfeint/internal/ui/NativeBrowser;->mWebView:Landroid/webkit/WebView;

    invoke-virtual {v2}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;

    move-result-object v2

    invoke-virtual {v2, v5}, Landroid/webkit/WebSettings;->setJavaScriptEnabled(Z)V

    iget-object v2, p0, Lcom/openfeint/internal/ui/NativeBrowser;->mWebView:Landroid/webkit/WebView;

    new-instance v3, Lcom/openfeint/internal/ui/NativeBrowser$JSInterface;

    invoke-direct {v3, p0}, Lcom/openfeint/internal/ui/NativeBrowser$JSInterface;-><init>(Lcom/openfeint/internal/ui/NativeBrowser;)V

    const-string v4, "NativeBrowser"

    invoke-virtual {v2, v3, v4}, Landroid/webkit/WebView;->addJavascriptInterface(Ljava/lang/Object;Ljava/lang/String;)V

    iget-object v2, p0, Lcom/openfeint/internal/ui/NativeBrowser;->mWebView:Landroid/webkit/WebView;

    new-instance v3, Lcom/openfeint/internal/ui/NativeBrowser$1;

    invoke-direct {v3, p0}, Lcom/openfeint/internal/ui/NativeBrowser$1;-><init>(Lcom/openfeint/internal/ui/NativeBrowser;)V

    invoke-virtual {v2, v3}, Landroid/webkit/WebView;->setWebViewClient(Landroid/webkit/WebViewClient;)V

    iget-object v2, p0, Lcom/openfeint/internal/ui/NativeBrowser;->mWebView:Landroid/webkit/WebView;

    new-instance v3, Landroid/webkit/WebChromeClient;

    invoke-direct {v3}, Landroid/webkit/WebChromeClient;-><init>()V

    invoke-virtual {v2, v3}, Landroid/webkit/WebView;->setWebChromeClient(Landroid/webkit/WebChromeClient;)V

    iget-object v2, p0, Lcom/openfeint/internal/ui/NativeBrowser;->mWebView:Landroid/webkit/WebView;

    invoke-virtual {v2, v1}, Landroid/webkit/WebView;->loadUrl(Ljava/lang/String;)V

    if-eqz v0, :cond_0

    new-instance v1, Landroid/os/Handler;

    invoke-direct {v1}, Landroid/os/Handler;-><init>()V

    iput-object v1, p0, Lcom/openfeint/internal/ui/NativeBrowser;->mHandler:Landroid/os/Handler;

    new-instance v1, Lcom/openfeint/internal/ui/NativeBrowser$2;

    invoke-direct {v1, p0}, Lcom/openfeint/internal/ui/NativeBrowser$2;-><init>(Lcom/openfeint/internal/ui/NativeBrowser;)V

    iput-object v1, p0, Lcom/openfeint/internal/ui/NativeBrowser;->mTimeoutWatchdog:Ljava/lang/Runnable;

    iget-object v1, p0, Lcom/openfeint/internal/ui/NativeBrowser;->mHandler:Landroid/os/Handler;

    iget-object v2, p0, Lcom/openfeint/internal/ui/NativeBrowser;->mTimeoutWatchdog:Ljava/lang/Runnable;

    invoke-static {v0}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v0

    int-to-long v3, v0

    invoke-virtual {v1, v2, v3, v4}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    :cond_0
    invoke-virtual {p0, v5}, Lcom/openfeint/internal/ui/NativeBrowser;->fade(Z)V

    return-void
.end method
