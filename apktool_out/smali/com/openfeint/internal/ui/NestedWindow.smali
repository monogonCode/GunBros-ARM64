.class public Lcom/openfeint/internal/ui/NestedWindow;
.super Landroid/app/Activity;


# instance fields
.field private mIsVisible:Z

.field protected mLogoImage:Landroid/view/View;

.field protected mWebView:Landroid/webkit/WebView;


# direct methods
.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Landroid/app/Activity;-><init>()V

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/openfeint/internal/ui/NestedWindow;->mIsVisible:Z

    return-void
.end method

.method private isBigScreen()Z
    .locals 5

    const/16 v4, 0x3e8

    const/16 v3, 0x320

    const/4 v0, 0x1

    invoke-virtual {p0}, Lcom/openfeint/internal/ui/NestedWindow;->getWindowManager()Landroid/view/WindowManager;

    move-result-object v1

    invoke-interface {v1}, Landroid/view/WindowManager;->getDefaultDisplay()Landroid/view/Display;

    move-result-object v1

    invoke-virtual {v1}, Landroid/view/Display;->getWidth()I

    move-result v2

    invoke-virtual {v1}, Landroid/view/Display;->getHeight()I

    move-result v1

    if-le v1, v2, :cond_1

    if-lt v2, v3, :cond_1

    if-lt v1, v4, :cond_1

    :cond_0
    :goto_0
    return v0

    :cond_1
    if-lt v2, v4, :cond_2

    if-ge v1, v3, :cond_0

    :cond_2
    const/4 v0, 0x0

    goto :goto_0
.end method


# virtual methods
.method protected beforeSetContentView()V
    .locals 2

    invoke-direct {p0}, Lcom/openfeint/internal/ui/NestedWindow;->isBigScreen()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-virtual {p0}, Lcom/openfeint/internal/ui/NestedWindow;->getWindow()Landroid/view/Window;

    move-result-object v0

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Landroid/view/Window;->requestFeature(I)Z

    :cond_0
    return-void
.end method

.method public fade(Z)V
    .locals 5

    const/4 v4, 0x0

    const/high16 v0, 0x3f800000    # 1.0f

    const/4 v1, 0x0

    iget-object v2, p0, Lcom/openfeint/internal/ui/NestedWindow;->mWebView:Landroid/webkit/WebView;

    if-eqz v2, :cond_0

    iget-boolean v2, p0, Lcom/openfeint/internal/ui/NestedWindow;->mIsVisible:Z

    if-eq v2, p1, :cond_0

    iput-boolean p1, p0, Lcom/openfeint/internal/ui/NestedWindow;->mIsVisible:Z

    new-instance v3, Landroid/view/animation/AlphaAnimation;

    if-eqz p1, :cond_1

    move v2, v1

    :goto_0
    if-eqz p1, :cond_2

    :goto_1
    invoke-direct {v3, v2, v0}, Landroid/view/animation/AlphaAnimation;-><init>(FF)V

    if-eqz p1, :cond_3

    const-wide/16 v0, 0xc8

    :goto_2
    invoke-virtual {v3, v0, v1}, Landroid/view/animation/AlphaAnimation;->setDuration(J)V

    const/4 v0, 0x1

    invoke-virtual {v3, v0}, Landroid/view/animation/AlphaAnimation;->setFillAfter(Z)V

    iget-object v0, p0, Lcom/openfeint/internal/ui/NestedWindow;->mWebView:Landroid/webkit/WebView;

    invoke-virtual {v0, v3}, Landroid/webkit/WebView;->startAnimation(Landroid/view/animation/Animation;)V

    iget-object v0, p0, Lcom/openfeint/internal/ui/NestedWindow;->mWebView:Landroid/webkit/WebView;

    invoke-virtual {v0}, Landroid/webkit/WebView;->getVisibility()I

    move-result v0

    const/4 v1, 0x4

    if-ne v0, v1, :cond_0

    iget-object v0, p0, Lcom/openfeint/internal/ui/NestedWindow;->mWebView:Landroid/webkit/WebView;

    invoke-virtual {v0, v4}, Landroid/webkit/WebView;->setVisibility(I)V

    const-string v0, "frameLayout"

    invoke-static {v0}, Lcom/openfeint/internal/RR;->id(Ljava/lang/String;)I

    move-result v0

    invoke-virtual {p0, v0}, Lcom/openfeint/internal/ui/NestedWindow;->findViewById(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, v4}, Landroid/view/View;->setVisibility(I)V

    :cond_0
    return-void

    :cond_1
    move v2, v0

    goto :goto_0

    :cond_2
    move v0, v1

    goto :goto_1

    :cond_3
    const-wide/16 v0, 0x0

    goto :goto_2
.end method

.method protected layoutResource()I
    .locals 1

    const-string v0, "of_nested_window"

    invoke-static {v0}, Lcom/openfeint/internal/RR;->layout(Ljava/lang/String;)I

    move-result v0

    return v0
.end method

.method public onConfigurationChanged(Landroid/content/res/Configuration;)V
    .locals 0

    invoke-super {p0, p1}, Landroid/app/Activity;->onConfigurationChanged(Landroid/content/res/Configuration;)V

    return-void
.end method

.method public onCreate(Landroid/os/Bundle;)V
    .locals 1

    invoke-super {p0, p1}, Landroid/app/Activity;->onCreate(Landroid/os/Bundle;)V

    invoke-static {p0}, Lcom/openfeint/internal/Util;->setOrientation(Landroid/app/Activity;)V

    invoke-virtual {p0}, Lcom/openfeint/internal/ui/NestedWindow;->beforeSetContentView()V

    invoke-virtual {p0}, Lcom/openfeint/internal/ui/NestedWindow;->layoutResource()I

    move-result v0

    invoke-virtual {p0, v0}, Lcom/openfeint/internal/ui/NestedWindow;->setContentView(I)V

    const-string v0, "web_view"

    invoke-static {v0}, Lcom/openfeint/internal/RR;->id(Ljava/lang/String;)I

    move-result v0

    invoke-virtual {p0, v0}, Lcom/openfeint/internal/ui/NestedWindow;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/webkit/WebView;

    iput-object v0, p0, Lcom/openfeint/internal/ui/NestedWindow;->mWebView:Landroid/webkit/WebView;

    const-string v0, "of_ll_logo_image"

    invoke-static {v0}, Lcom/openfeint/internal/RR;->id(Ljava/lang/String;)I

    move-result v0

    invoke-virtual {p0, v0}, Lcom/openfeint/internal/ui/NestedWindow;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lcom/openfeint/internal/ui/NestedWindow;->mLogoImage:Landroid/view/View;

    return-void
.end method
