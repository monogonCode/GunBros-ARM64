.class public abstract Lcom/openfeint/internal/notifications/NotificationBase;
.super Lcom/openfeint/api/Notification;


# static fields
.field static drawableCache:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map",
            "<",
            "Ljava/lang/String;",
            "Landroid/graphics/drawable/Drawable;",
            ">;"
        }
    .end annotation
.end field


# instance fields
.field private category:Lcom/openfeint/api/Notification$Category;

.field displayView:Landroid/view/View;

.field protected imageName:Ljava/lang/String;

.field private text:Ljava/lang/String;

.field toast:Landroid/widget/Toast;

.field private type:Lcom/openfeint/api/Notification$Type;

.field private userData:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/Object;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    sput-object v0, Lcom/openfeint/internal/notifications/NotificationBase;->drawableCache:Ljava/util/Map;

    return-void
.end method

.method protected constructor <init>(Ljava/lang/String;Ljava/lang/String;Lcom/openfeint/api/Notification$Category;Lcom/openfeint/api/Notification$Type;Ljava/util/Map;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Lcom/openfeint/api/Notification$Category;",
            "Lcom/openfeint/api/Notification$Type;",
            "Ljava/util/Map",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/Object;",
            ">;)V"
        }
    .end annotation

    invoke-direct {p0}, Lcom/openfeint/api/Notification;-><init>()V

    iput-object p1, p0, Lcom/openfeint/internal/notifications/NotificationBase;->text:Ljava/lang/String;

    iput-object p2, p0, Lcom/openfeint/internal/notifications/NotificationBase;->imageName:Ljava/lang/String;

    iput-object p3, p0, Lcom/openfeint/internal/notifications/NotificationBase;->category:Lcom/openfeint/api/Notification$Category;

    iput-object p4, p0, Lcom/openfeint/internal/notifications/NotificationBase;->type:Lcom/openfeint/api/Notification$Type;

    iput-object p5, p0, Lcom/openfeint/internal/notifications/NotificationBase;->userData:Ljava/util/Map;

    return-void
.end method

.method static getResourceDrawable(Ljava/lang/String;)Landroid/graphics/drawable/Drawable;
    .locals 3

    sget-object v0, Lcom/openfeint/internal/notifications/NotificationBase;->drawableCache:Ljava/util/Map;

    invoke-interface {v0, p0}, Ljava/util/Map;->containsKey(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    invoke-static {}, Lcom/openfeint/internal/OpenFeintInternal;->getInstance()Lcom/openfeint/internal/OpenFeintInternal;

    move-result-object v0

    invoke-virtual {v0, p0}, Lcom/openfeint/internal/OpenFeintInternal;->getResource(Ljava/lang/String;)I

    move-result v1

    if-nez v1, :cond_1

    sget-object v0, Lcom/openfeint/internal/notifications/NotificationBase;->drawableCache:Ljava/util/Map;

    const/4 v1, 0x0

    invoke-interface {v0, p0, v1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    :cond_0
    :goto_0
    sget-object v0, Lcom/openfeint/internal/notifications/NotificationBase;->drawableCache:Ljava/util/Map;

    invoke-interface {v0, p0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/graphics/drawable/Drawable;

    return-object v0

    :cond_1
    invoke-virtual {v0}, Lcom/openfeint/internal/OpenFeintInternal;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    sget-object v2, Lcom/openfeint/internal/notifications/NotificationBase;->drawableCache:Ljava/util/Map;

    invoke-virtual {v0, v1}, Landroid/content/res/Resources;->getDrawable(I)Landroid/graphics/drawable/Drawable;

    move-result-object v0

    invoke-interface {v2, p0, v0}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_0
.end method


# virtual methods
.method protected final checkDelegateAndView()V
    .locals 1

    invoke-static {}, Lcom/openfeint/internal/notifications/NotificationBase;->getDelegate()Lcom/openfeint/api/Notification$Delegate;

    invoke-static {}, Lcom/openfeint/internal/notifications/NotificationBase;->getDelegate()Lcom/openfeint/api/Notification$Delegate;

    invoke-virtual {p0}, Lcom/openfeint/internal/notifications/NotificationBase;->createView()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-virtual {p0}, Lcom/openfeint/internal/notifications/NotificationBase;->showToast()V

    :cond_0
    return-void
.end method

.method protected abstract createView()Z
.end method

.method public final getText()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/openfeint/internal/notifications/NotificationBase;->text:Ljava/lang/String;

    return-object v0
.end method

.method public final getUserData()Ljava/util/Map;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/Map",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/Object;",
            ">;"
        }
    .end annotation

    iget-object v0, p0, Lcom/openfeint/internal/notifications/NotificationBase;->userData:Ljava/util/Map;

    return-object v0
.end method

.method protected final showToast()V
    .locals 2

    invoke-static {}, Lcom/openfeint/internal/OpenFeintInternal;->getInstance()Lcom/openfeint/internal/OpenFeintInternal;

    move-result-object v0

    new-instance v1, Lcom/openfeint/internal/notifications/NotificationBase$1;

    invoke-direct {v1, p0}, Lcom/openfeint/internal/notifications/NotificationBase$1;-><init>(Lcom/openfeint/internal/notifications/NotificationBase;)V

    invoke-virtual {v0, v1}, Lcom/openfeint/internal/OpenFeintInternal;->runOnUiThread(Ljava/lang/Runnable;)V

    return-void
.end method
