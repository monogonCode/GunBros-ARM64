.class public Lcom/openfeint/internal/ui/IntroFlow;
.super Lcom/openfeint/internal/ui/WebNav;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/openfeint/internal/ui/IntroFlow$IntroFlowActionHandler;
    }
.end annotation


# instance fields
.field cachedImage:Landroid/graphics/Bitmap;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Lcom/openfeint/internal/ui/WebNav;-><init>()V

    return-void
.end method


# virtual methods
.method protected createActionHandler(Lcom/openfeint/internal/ui/WebNav;)Lcom/openfeint/internal/ui/WebNav$ActionHandler;
    .locals 1

    new-instance v0, Lcom/openfeint/internal/ui/IntroFlow$IntroFlowActionHandler;

    invoke-direct {v0, p0, p1}, Lcom/openfeint/internal/ui/IntroFlow$IntroFlowActionHandler;-><init>(Lcom/openfeint/internal/ui/IntroFlow;Lcom/openfeint/internal/ui/WebNav;)V

    return-object v0
.end method

.method protected initialContentPath()Ljava/lang/String;
    .locals 3

    invoke-virtual {p0}, Lcom/openfeint/internal/ui/IntroFlow;->getIntent()Landroid/content/Intent;

    move-result-object v0

    const-string v1, "content_name"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "intro/"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    :goto_0
    return-object v0

    :cond_0
    const-string v0, "intro/index"

    goto :goto_0
.end method

.method public onActivityResult(IILandroid/content/Intent;)V
    .locals 1

    invoke-static {p1}, Lcom/openfeint/internal/ImagePicker;->isImagePickerActivityResult(I)Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-static {p0, p2, p3}, Lcom/openfeint/internal/ImagePicker;->onImagePickerActivityResult$1de9c2be(Landroid/app/Activity;ILandroid/content/Intent;)Landroid/graphics/Bitmap;

    move-result-object v0

    iput-object v0, p0, Lcom/openfeint/internal/ui/IntroFlow;->cachedImage:Landroid/graphics/Bitmap;

    :cond_0
    return-void
.end method
