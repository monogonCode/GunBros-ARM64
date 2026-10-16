.class public Lcom/openfeint/internal/ui/WebNav;
.super Lcom/openfeint/internal/ui/NestedWindow;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/openfeint/internal/ui/WebNav$ActionHandler;,
        Lcom/openfeint/internal/ui/WebNav$WebNavChromeClient;,
        Lcom/openfeint/internal/ui/WebNav$WebNavClient;
    }
.end annotation


# instance fields
.field mActionHandler:Lcom/openfeint/internal/ui/WebNav$ActionHandler;

.field mIsFrameworkLoaded:Z

.field mIsPageLoaded:Z

.field mLaunchLoadingView:Landroid/app/Dialog;

.field private mNativeBrowserParameters:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field protected mPreloadConsoleOutput:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private mShouldRefreshOnResume:Z

.field private mWebViewClient:Lcom/openfeint/internal/ui/WebNav$WebNavClient;

.field protected pageStackCount:I


# direct methods
.method public constructor <init>()V
    .locals 1

    const/4 v0, 0x0

    invoke-direct {p0}, Lcom/openfeint/internal/ui/NestedWindow;-><init>()V

    iput-boolean v0, p0, Lcom/openfeint/internal/ui/WebNav;->mIsPageLoaded:Z

    iput-boolean v0, p0, Lcom/openfeint/internal/ui/WebNav;->mIsFrameworkLoaded:Z

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/openfeint/internal/ui/WebNav;->mShouldRefreshOnResume:Z

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/openfeint/internal/ui/WebNav;->mPreloadConsoleOutput:Ljava/util/ArrayList;

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/openfeint/internal/ui/WebNav;->mNativeBrowserParameters:Ljava/util/Map;

    return-void
.end method

.method static synthetic access$100(Lcom/openfeint/internal/ui/WebNav;)V
    .locals 0

    invoke-direct {p0}, Lcom/openfeint/internal/ui/WebNav;->closeForDiskError()V

    return-void
.end method

.method static synthetic access$200(Lcom/openfeint/internal/ui/WebNav;)V
    .locals 0

    invoke-direct {p0}, Lcom/openfeint/internal/ui/WebNav;->dismissDialog()V

    return-void
.end method

.method static synthetic access$300(Lcom/openfeint/internal/ui/WebNav;)V
    .locals 0

    invoke-direct {p0}, Lcom/openfeint/internal/ui/WebNav;->showDialog()V

    return-void
.end method

.method static synthetic access$400(Lcom/openfeint/internal/ui/WebNav;)Ljava/util/Map;
    .locals 1

    iget-object v0, p0, Lcom/openfeint/internal/ui/WebNav;->mNativeBrowserParameters:Ljava/util/Map;

    return-object v0
.end method

.method static synthetic access$402(Lcom/openfeint/internal/ui/WebNav;Ljava/util/Map;)Ljava/util/Map;
    .locals 0

    iput-object p1, p0, Lcom/openfeint/internal/ui/WebNav;->mNativeBrowserParameters:Ljava/util/Map;

    return-object p1
.end method

.method private closeForDiskError()V
    .locals 1

    new-instance v0, Lcom/openfeint/internal/ui/WebNav$4;

    invoke-direct {v0, p0}, Lcom/openfeint/internal/ui/WebNav$4;-><init>(Lcom/openfeint/internal/ui/WebNav;)V

    invoke-virtual {p0, v0}, Lcom/openfeint/internal/ui/WebNav;->runOnUiThread(Ljava/lang/Runnable;)V

    return-void
.end method

.method private dismissDialog()V
    .locals 1

    iget-object v0, p0, Lcom/openfeint/internal/ui/WebNav;->mLaunchLoadingView:Landroid/app/Dialog;

    invoke-virtual {v0}, Landroid/app/Dialog;->isShowing()Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/openfeint/internal/ui/WebNav;->mLaunchLoadingView:Landroid/app/Dialog;

    invoke-virtual {v0}, Landroid/app/Dialog;->dismiss()V

    :cond_0
    return-void
.end method

.method private static final jsQuotedStringLiteral(Ljava/lang/String;)Ljava/lang/String;
    .locals 4

    if-nez p0, :cond_0

    const-string v0, "\'\'"

    :goto_0
    return-object v0

    :cond_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "\'"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\\"

    const-string v2, "\\\\"

    invoke-virtual {p0, v1, v2}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v1

    const-string v2, "\'"

    const-string v3, "\\\'"

    invoke-virtual {v1, v2, v3}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\'"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_0
.end method

.method private showDialog()V
    .locals 1

    iget-object v0, p0, Lcom/openfeint/internal/ui/WebNav;->mLaunchLoadingView:Landroid/app/Dialog;

    invoke-virtual {v0}, Landroid/app/Dialog;->isShowing()Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/openfeint/internal/ui/WebNav;->mLaunchLoadingView:Landroid/app/Dialog;

    invoke-virtual {v0}, Landroid/app/Dialog;->show()V

    :cond_0
    return-void
.end method


# virtual methods
.method protected createActionHandler(Lcom/openfeint/internal/ui/WebNav;)Lcom/openfeint/internal/ui/WebNav$ActionHandler;
    .locals 1

    new-instance v0, Lcom/openfeint/internal/ui/WebNav$ActionHandler;

    invoke-direct {v0, p0, p1}, Lcom/openfeint/internal/ui/WebNav$ActionHandler;-><init>(Lcom/openfeint/internal/ui/WebNav;Lcom/openfeint/internal/ui/WebNav;)V

    return-object v0
.end method

.method protected createWebNavClient(Lcom/openfeint/internal/ui/WebNav$ActionHandler;)Lcom/openfeint/internal/ui/WebNav$WebNavClient;
    .locals 1

    new-instance v0, Lcom/openfeint/internal/ui/WebNav$WebNavClient;

    invoke-direct {v0, p0, p1}, Lcom/openfeint/internal/ui/WebNav$WebNavClient;-><init>(Lcom/openfeint/internal/ui/WebNav;Lcom/openfeint/internal/ui/WebNav$ActionHandler;)V

    return-object v0
.end method

.method public executeJavascript(Ljava/lang/String;)V
    .locals 3

    iget-object v0, p0, Lcom/openfeint/internal/ui/WebNav;->mWebView:Landroid/webkit/WebView;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/openfeint/internal/ui/WebNav;->mWebView:Landroid/webkit/WebView;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "javascript:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/webkit/WebView;->loadUrl(Ljava/lang/String;)V

    :cond_0
    return-void
.end method

.method public getActionHandler()Lcom/openfeint/internal/ui/WebNav$ActionHandler;
    .locals 1

    iget-object v0, p0, Lcom/openfeint/internal/ui/WebNav;->mActionHandler:Lcom/openfeint/internal/ui/WebNav$ActionHandler;

    return-object v0
.end method

.method public getLaunchLoadingView()Landroid/app/Dialog;
    .locals 1

    iget-object v0, p0, Lcom/openfeint/internal/ui/WebNav;->mLaunchLoadingView:Landroid/app/Dialog;

    return-object v0
.end method

.method protected initialContentPath()Ljava/lang/String;
    .locals 2

    invoke-virtual {p0}, Lcom/openfeint/internal/ui/WebNav;->getIntent()Landroid/content/Intent;

    move-result-object v0

    const-string v1, "content_path"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    if-nez v0, :cond_0

    new-instance v0, Ljava/lang/RuntimeException;

    const-string v1, "WebNav intent requires extra value \'content_path\'"

    invoke-direct {v0, v1}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    throw v0

    :cond_0
    return-object v0
.end method

.method protected load(Z)V
    .locals 2

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/openfeint/internal/ui/WebNav;->mIsPageLoaded:Z

    invoke-virtual {p0}, Lcom/openfeint/internal/ui/WebNav;->rootPage()Ljava/lang/String;

    move-result-object v0

    new-instance v1, Lcom/openfeint/internal/ui/WebNav$3;

    invoke-direct {v1, p0, p1}, Lcom/openfeint/internal/ui/WebNav$3;-><init>(Lcom/openfeint/internal/ui/WebNav;Z)V

    invoke-static {v0, v1}, Lcom/openfeint/internal/ui/WebViewCache;->trackPath(Ljava/lang/String;Lcom/openfeint/internal/ui/WebViewCacheCallback;)Z

    return-void
.end method

.method public loadInitialContent()V
    .locals 2

    invoke-virtual {p0}, Lcom/openfeint/internal/ui/WebNav;->initialContentPath()Ljava/lang/String;

    move-result-object v0

    const-string v1, "?"

    invoke-virtual {v0, v1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_0

    const-string v1, "\\?"

    invoke-virtual {v0, v1}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x0

    aget-object v0, v0, v1

    :cond_0
    const-string v1, ".json"

    invoke-virtual {v0, v1}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_1

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ".json"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    :cond_1
    new-instance v1, Lcom/openfeint/internal/ui/WebNav$5;

    invoke-direct {v1, p0}, Lcom/openfeint/internal/ui/WebNav$5;-><init>(Lcom/openfeint/internal/ui/WebNav;)V

    invoke-static {v0, v1}, Lcom/openfeint/internal/ui/WebViewCache;->trackPath(Ljava/lang/String;Lcom/openfeint/internal/ui/WebViewCacheCallback;)Z

    return-void
.end method

.method protected onActivityResult(IILandroid/content/Intent;)V
    .locals 8

    const/4 v7, 0x2

    const/4 v6, 0x1

    const/4 v5, 0x0

    invoke-super {p0, p1, p2, p3}, Lcom/openfeint/internal/ui/NestedWindow;->onActivityResult(IILandroid/content/Intent;)V

    iget-object v0, p0, Lcom/openfeint/internal/ui/WebNav;->mNativeBrowserParameters:Ljava/util/Map;

    if-eqz v0, :cond_5

    const/16 v0, 0x63dd

    if-ne p1, v0, :cond_5

    if-eqz p2, :cond_4

    iput-boolean v5, p0, Lcom/openfeint/internal/ui/WebNav;->mShouldRefreshOnResume:Z

    const-string v0, "com.openfeint.internal.ui.NativeBrowser.argument.failed"

    invoke-virtual {p3, v0, v5}, Landroid/content/Intent;->getBooleanExtra(Ljava/lang/String;Z)Z

    move-result v0

    if-eqz v0, :cond_2

    iget-object v0, p0, Lcom/openfeint/internal/ui/WebNav;->mNativeBrowserParameters:Ljava/util/Map;

    const-string v1, "on_failure"

    invoke-interface {v0, v1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    if-eqz v0, :cond_0

    const-string v1, "com.openfeint.internal.ui.NativeBrowser.argument.failure_code"

    invoke-virtual {p3, v1, v5}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I

    move-result v1

    const-string v2, "com.openfeint.internal.ui.NativeBrowser.argument.failure_desc"

    invoke-virtual {p3, v2}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    const-string v3, "%s(%d, %s)"

    const/4 v4, 0x3

    new-array v4, v4, [Ljava/lang/Object;

    aput-object v0, v4, v5

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    aput-object v0, v4, v6

    invoke-static {v2}, Lcom/openfeint/internal/ui/WebNav;->jsQuotedStringLiteral(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    aput-object v0, v4, v7

    invoke-static {v3, v4}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/openfeint/internal/ui/WebNav;->executeJavascript(Ljava/lang/String;)V

    :cond_0
    :goto_0
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/openfeint/internal/ui/WebNav;->mNativeBrowserParameters:Ljava/util/Map;

    :cond_1
    :goto_1
    return-void

    :cond_2
    iget-object v0, p0, Lcom/openfeint/internal/ui/WebNav;->mNativeBrowserParameters:Ljava/util/Map;

    const-string v1, "callback"

    invoke-interface {v0, v1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    if-eqz v0, :cond_0

    const-string v1, "com.openfeint.internal.ui.NativeBrowser.argument.result"

    invoke-virtual {p3, v1}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    const-string v2, "%s(%s)"

    new-array v3, v7, [Ljava/lang/Object;

    aput-object v0, v3, v5

    if-eqz v1, :cond_3

    move-object v0, v1

    :goto_2
    aput-object v0, v3, v6

    invoke-static {v2, v3}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/openfeint/internal/ui/WebNav;->executeJavascript(Ljava/lang/String;)V

    goto :goto_0

    :cond_3
    const-string v0, ""

    goto :goto_2

    :cond_4
    iget-object v0, p0, Lcom/openfeint/internal/ui/WebNav;->mNativeBrowserParameters:Ljava/util/Map;

    const-string v1, "on_cancel"

    invoke-interface {v0, v1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    if-eqz v0, :cond_0

    const-string v1, "%s()"

    new-array v2, v6, [Ljava/lang/Object;

    aput-object v0, v2, v5

    invoke-static {v1, v2}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/openfeint/internal/ui/WebNav;->executeJavascript(Ljava/lang/String;)V

    goto :goto_0

    :cond_5
    invoke-static {p1}, Lcom/openfeint/internal/ImagePicker;->isImagePickerActivityResult(I)Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-static {p0, p2, p3}, Lcom/openfeint/internal/ImagePicker;->onImagePickerActivityResult$1de9c2be(Landroid/app/Activity;ILandroid/content/Intent;)Landroid/graphics/Bitmap;

    move-result-object v0

    if-eqz v0, :cond_1

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "/xp/users/"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-static {}, Lcom/openfeint/internal/OpenFeintInternal;->getInstance()Lcom/openfeint/internal/OpenFeintInternal;

    move-result-object v2

    invoke-virtual {v2}, Lcom/openfeint/internal/OpenFeintInternal;->getCurrentUser()Lcom/openfeint/api/resource/CurrentUser;

    move-result-object v2

    invoke-virtual {v2}, Lcom/openfeint/api/resource/CurrentUser;->resourceID()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "/profile_picture"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    new-instance v2, Lcom/openfeint/internal/ui/WebNav$6;

    invoke-direct {v2, p0}, Lcom/openfeint/internal/ui/WebNav$6;-><init>(Lcom/openfeint/internal/ui/WebNav;)V

    invoke-static {v0, v1, v2}, Lcom/openfeint/internal/ImagePicker;->compressAndUpload(Landroid/graphics/Bitmap;Ljava/lang/String;Lcom/openfeint/internal/OpenFeintInternal$IUploadDelegate;)V

    goto :goto_1
.end method

.method public onConfigurationChanged(Landroid/content/res/Configuration;)V
    .locals 4

    invoke-super {p0, p1}, Lcom/openfeint/internal/ui/NestedWindow;->onConfigurationChanged(Landroid/content/res/Configuration;)V

    iget v0, p1, Landroid/content/res/Configuration;->orientation:I

    const/4 v1, 0x2

    if-ne v0, v1, :cond_0

    const-string v0, "landscape"

    :goto_0
    const-string v1, "OF.setOrientation(\'%s\');"

    const/4 v2, 0x1

    new-array v2, v2, [Ljava/lang/Object;

    const/4 v3, 0x0

    aput-object v0, v2, v3

    invoke-static {v1, v2}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/openfeint/internal/ui/WebNav;->executeJavascript(Ljava/lang/String;)V

    return-void

    :cond_0
    const-string v0, "portrait"

    goto :goto_0
.end method

.method public onCreate(Landroid/os/Bundle;)V
    .locals 4

    const/4 v2, 0x1

    const/4 v3, 0x0

    invoke-super {p0, p1}, Lcom/openfeint/internal/ui/NestedWindow;->onCreate(Landroid/os/Bundle;)V

    const-string v0, "WebUI"

    const-string v1, "--- WebUI Bootup ---"

    invoke-static {v0, v1}, Lcom/openfeint/internal/logcat/OFLog;->i(Ljava/lang/String;Ljava/lang/String;)V

    iput v3, p0, Lcom/openfeint/internal/ui/WebNav;->pageStackCount:I

    iget-object v0, p0, Lcom/openfeint/internal/ui/WebNav;->mWebView:Landroid/webkit/WebView;

    invoke-virtual {v0}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;

    move-result-object v0

    invoke-virtual {v0, v2}, Landroid/webkit/WebSettings;->setJavaScriptEnabled(Z)V

    iget-object v0, p0, Lcom/openfeint/internal/ui/WebNav;->mWebView:Landroid/webkit/WebView;

    invoke-virtual {v0}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;

    move-result-object v0

    invoke-virtual {v0, v3}, Landroid/webkit/WebSettings;->setPluginsEnabled(Z)V

    iget-object v0, p0, Lcom/openfeint/internal/ui/WebNav;->mWebView:Landroid/webkit/WebView;

    const/high16 v1, 0x2000000

    invoke-virtual {v0, v1}, Landroid/webkit/WebView;->setScrollBarStyle(I)V

    iget-object v0, p0, Lcom/openfeint/internal/ui/WebNav;->mWebView:Landroid/webkit/WebView;

    invoke-virtual {v0}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;

    move-result-object v0

    const/4 v1, 0x2

    invoke-virtual {v0, v1}, Landroid/webkit/WebSettings;->setCacheMode(I)V

    new-instance v0, Landroid/app/Dialog;

    const-string v1, "OFLoading"

    invoke-static {v1}, Lcom/openfeint/internal/RR;->style(Ljava/lang/String;)I

    move-result v1

    invoke-direct {v0, p0, v1}, Landroid/app/Dialog;-><init>(Landroid/content/Context;I)V

    iput-object v0, p0, Lcom/openfeint/internal/ui/WebNav;->mLaunchLoadingView:Landroid/app/Dialog;

    iget-object v0, p0, Lcom/openfeint/internal/ui/WebNav;->mLaunchLoadingView:Landroid/app/Dialog;

    new-instance v1, Lcom/openfeint/internal/ui/WebNav$1;

    invoke-direct {v1, p0}, Lcom/openfeint/internal/ui/WebNav$1;-><init>(Lcom/openfeint/internal/ui/WebNav;)V

    invoke-virtual {v0, v1}, Landroid/app/Dialog;->setOnCancelListener(Landroid/content/DialogInterface$OnCancelListener;)V

    iget-object v0, p0, Lcom/openfeint/internal/ui/WebNav;->mLaunchLoadingView:Landroid/app/Dialog;

    invoke-virtual {v0, v2}, Landroid/app/Dialog;->setCancelable(Z)V

    iget-object v0, p0, Lcom/openfeint/internal/ui/WebNav;->mLaunchLoadingView:Landroid/app/Dialog;

    const-string v1, "of_native_loader"

    invoke-static {v1}, Lcom/openfeint/internal/RR;->layout(Ljava/lang/String;)I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/app/Dialog;->setContentView(I)V

    iget-object v0, p0, Lcom/openfeint/internal/ui/WebNav;->mLaunchLoadingView:Landroid/app/Dialog;

    const-string v1, "progress"

    invoke-static {v1}, Lcom/openfeint/internal/RR;->id(Ljava/lang/String;)I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/app/Dialog;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ProgressBar;

    invoke-virtual {v0, v2}, Landroid/widget/ProgressBar;->setIndeterminate(Z)V

    invoke-static {}, Lcom/openfeint/internal/OpenFeintInternal;->getInstance()Lcom/openfeint/internal/OpenFeintInternal;

    move-result-object v1

    invoke-virtual {v1}, Lcom/openfeint/internal/OpenFeintInternal;->getContext()Landroid/content/Context;

    move-result-object v1

    invoke-virtual {v1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    const-string v2, "of_native_loader_progress"

    invoke-static {v2}, Lcom/openfeint/internal/RR;->drawable(Ljava/lang/String;)I

    move-result v2

    invoke-virtual {v1, v2}, Landroid/content/res/Resources;->getDrawable(I)Landroid/graphics/drawable/Drawable;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/ProgressBar;->setIndeterminateDrawable(Landroid/graphics/drawable/Drawable;)V

    invoke-virtual {p0, p0}, Lcom/openfeint/internal/ui/WebNav;->createActionHandler(Lcom/openfeint/internal/ui/WebNav;)Lcom/openfeint/internal/ui/WebNav$ActionHandler;

    move-result-object v0

    iput-object v0, p0, Lcom/openfeint/internal/ui/WebNav;->mActionHandler:Lcom/openfeint/internal/ui/WebNav$ActionHandler;

    iget-object v0, p0, Lcom/openfeint/internal/ui/WebNav;->mActionHandler:Lcom/openfeint/internal/ui/WebNav$ActionHandler;

    invoke-virtual {p0, v0}, Lcom/openfeint/internal/ui/WebNav;->createWebNavClient(Lcom/openfeint/internal/ui/WebNav$ActionHandler;)Lcom/openfeint/internal/ui/WebNav$WebNavClient;

    move-result-object v0

    iput-object v0, p0, Lcom/openfeint/internal/ui/WebNav;->mWebViewClient:Lcom/openfeint/internal/ui/WebNav$WebNavClient;

    iget-object v0, p0, Lcom/openfeint/internal/ui/WebNav;->mWebView:Landroid/webkit/WebView;

    iget-object v1, p0, Lcom/openfeint/internal/ui/WebNav;->mWebViewClient:Lcom/openfeint/internal/ui/WebNav$WebNavClient;

    invoke-virtual {v0, v1}, Landroid/webkit/WebView;->setWebViewClient(Landroid/webkit/WebViewClient;)V

    iget-object v0, p0, Lcom/openfeint/internal/ui/WebNav;->mWebView:Landroid/webkit/WebView;

    new-instance v1, Lcom/openfeint/internal/ui/WebNav$WebNavChromeClient;

    const/4 v2, 0x0

    invoke-direct {v1, p0, v2}, Lcom/openfeint/internal/ui/WebNav$WebNavChromeClient;-><init>(Lcom/openfeint/internal/ui/WebNav;Lcom/openfeint/internal/ui/WebNav$1;)V

    invoke-virtual {v0, v1}, Landroid/webkit/WebView;->setWebChromeClient(Landroid/webkit/WebChromeClient;)V

    iget-object v0, p0, Lcom/openfeint/internal/ui/WebNav;->mWebView:Landroid/webkit/WebView;

    new-instance v1, Lcom/openfeint/internal/ui/WebNav$2;

    invoke-direct {v1, p0}, Lcom/openfeint/internal/ui/WebNav$2;-><init>(Lcom/openfeint/internal/ui/WebNav;)V

    const-string v2, "NativeInterface"

    invoke-virtual {v0, v1, v2}, Landroid/webkit/WebView;->addJavascriptInterface(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-virtual {p0}, Lcom/openfeint/internal/ui/WebNav;->initialContentPath()Ljava/lang/String;

    move-result-object v0

    const-string v1, "?"

    invoke-virtual {v0, v1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_0

    const-string v1, "\\?"

    invoke-virtual {v0, v1}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v0

    aget-object v0, v0, v3

    :cond_0
    const-string v1, ".json"

    invoke-virtual {v0, v1}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_1

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ".json"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    :cond_1
    invoke-static {v0}, Lcom/openfeint/internal/ui/WebViewCache;->prioritize(Ljava/lang/String;)V

    invoke-virtual {p0, v3}, Lcom/openfeint/internal/ui/WebNav;->load(Z)V

    iget-object v0, p0, Lcom/openfeint/internal/ui/WebNav;->mLaunchLoadingView:Landroid/app/Dialog;

    invoke-virtual {v0}, Landroid/app/Dialog;->show()V

    return-void
.end method

.method public onDestroy()V
    .locals 1

    iget-object v0, p0, Lcom/openfeint/internal/ui/WebNav;->mWebView:Landroid/webkit/WebView;

    invoke-virtual {v0}, Landroid/webkit/WebView;->destroy()V

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/openfeint/internal/ui/WebNav;->mWebView:Landroid/webkit/WebView;

    invoke-super {p0}, Lcom/openfeint/internal/ui/NestedWindow;->onDestroy()V

    return-void
.end method

.method public onKeyDown(ILandroid/view/KeyEvent;)Z
    .locals 5

    const/4 v0, 0x1

    const/16 v1, 0x54

    if-ne p1, v1, :cond_0

    const-string v1, "OF.menu(\'%s\')"

    new-array v2, v0, [Ljava/lang/Object;

    const/4 v3, 0x0

    const-string v4, "search"

    aput-object v4, v2, v3

    invoke-static {v1, v2}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v1}, Lcom/openfeint/internal/ui/WebNav;->executeJavascript(Ljava/lang/String;)V

    :goto_0
    return v0

    :cond_0
    const/4 v1, 0x4

    if-ne p1, v1, :cond_1

    iget v1, p0, Lcom/openfeint/internal/ui/WebNav;->pageStackCount:I

    if-le v1, v0, :cond_1

    const-string v1, "OF.goBack()"

    invoke-virtual {p0, v1}, Lcom/openfeint/internal/ui/WebNav;->executeJavascript(Ljava/lang/String;)V

    goto :goto_0

    :cond_1
    invoke-super {p0, p1, p2}, Lcom/openfeint/internal/ui/NestedWindow;->onKeyDown(ILandroid/view/KeyEvent;)Z

    move-result v0

    goto :goto_0
.end method

.method protected onRestoreInstanceState(Landroid/os/Bundle;)V
    .locals 0

    invoke-static {p1}, Lcom/openfeint/internal/OpenFeintInternal;->restoreInstanceState(Landroid/os/Bundle;)V

    return-void
.end method

.method public onResume()V
    .locals 6

    const/4 v5, 0x1

    invoke-super {p0}, Lcom/openfeint/internal/ui/NestedWindow;->onResume()V

    invoke-static {}, Lcom/openfeint/internal/OpenFeintInternal;->getInstance()Lcom/openfeint/internal/OpenFeintInternal;

    move-result-object v0

    invoke-virtual {v0}, Lcom/openfeint/internal/OpenFeintInternal;->getCurrentUser()Lcom/openfeint/api/resource/CurrentUser;

    move-result-object v0

    if-eqz v0, :cond_0

    iget-boolean v1, p0, Lcom/openfeint/internal/ui/WebNav;->mIsFrameworkLoaded:Z

    if-eqz v1, :cond_0

    const-string v1, "if (OF.user) { OF.user.name = %s; OF.user.id = \'%s\'; }"

    const/4 v2, 0x2

    new-array v2, v2, [Ljava/lang/Object;

    const/4 v3, 0x0

    iget-object v4, v0, Lcom/openfeint/api/resource/User;->name:Ljava/lang/String;

    invoke-static {v4}, Lcom/openfeint/internal/ui/WebNav;->jsQuotedStringLiteral(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    aput-object v4, v2, v3

    invoke-virtual {v0}, Lcom/openfeint/api/resource/User;->resourceID()Ljava/lang/String;

    move-result-object v0

    aput-object v0, v2, v5

    invoke-static {v1, v2}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/openfeint/internal/ui/WebNav;->executeJavascript(Ljava/lang/String;)V

    iget-boolean v0, p0, Lcom/openfeint/internal/ui/WebNav;->mShouldRefreshOnResume:Z

    if-eqz v0, :cond_0

    const-string v0, "if (OF.page) OF.refresh();"

    invoke-virtual {p0, v0}, Lcom/openfeint/internal/ui/WebNav;->executeJavascript(Ljava/lang/String;)V

    :cond_0
    iput-boolean v5, p0, Lcom/openfeint/internal/ui/WebNav;->mShouldRefreshOnResume:Z

    return-void
.end method

.method protected onSaveInstanceState(Landroid/os/Bundle;)V
    .locals 0

    invoke-static {p1}, Lcom/openfeint/internal/OpenFeintInternal;->saveInstanceState(Landroid/os/Bundle;)V

    return-void
.end method

.method public onStop()V
    .locals 0

    invoke-super {p0}, Lcom/openfeint/internal/ui/NestedWindow;->onStop()V

    invoke-direct {p0}, Lcom/openfeint/internal/ui/WebNav;->dismissDialog()V

    return-void
.end method

.method public onWindowFocusChanged(Z)V
    .locals 1

    invoke-super {p0, p1}, Lcom/openfeint/internal/ui/NestedWindow;->onWindowFocusChanged(Z)V

    invoke-static {}, Lcom/openfeint/internal/OpenFeintInternal;->getInstance()Lcom/openfeint/internal/OpenFeintInternal;

    move-result-object v0

    invoke-virtual {v0}, Lcom/openfeint/internal/OpenFeintInternal;->getDelegate()Lcom/openfeint/api/OpenFeintDelegate;

    return-void
.end method

.method protected rootPage()Ljava/lang/String;
    .locals 1

    const-string v0, "index.html"

    return-object v0
.end method

.method protected setFrameworkLoaded(Z)V
    .locals 0

    iput-boolean p1, p0, Lcom/openfeint/internal/ui/WebNav;->mIsFrameworkLoaded:Z

    return-void
.end method
