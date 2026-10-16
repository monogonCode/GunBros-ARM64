.class final Lcom/openfeint/internal/notifications/AchievementNotification$1;
.super Lcom/openfeint/internal/request/ExternalBitmapRequest;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/openfeint/internal/notifications/AchievementNotification;->createView()Z
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/openfeint/internal/notifications/AchievementNotification;

.field final synthetic val$achievement:Lcom/openfeint/api/resource/Achievement;


# direct methods
.method constructor <init>(Lcom/openfeint/internal/notifications/AchievementNotification;Ljava/lang/String;Lcom/openfeint/api/resource/Achievement;)V
    .locals 0

    iput-object p1, p0, Lcom/openfeint/internal/notifications/AchievementNotification$1;->this$0:Lcom/openfeint/internal/notifications/AchievementNotification;

    iput-object p3, p0, Lcom/openfeint/internal/notifications/AchievementNotification$1;->val$achievement:Lcom/openfeint/api/resource/Achievement;

    invoke-direct {p0, p2}, Lcom/openfeint/internal/request/ExternalBitmapRequest;-><init>(Ljava/lang/String;)V

    return-void
.end method


# virtual methods
.method public final onFailure(Ljava/lang/String;)V
    .locals 3

    const-string v0, "NotificationImage"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Failed to load image "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/openfeint/internal/notifications/AchievementNotification$1;->val$achievement:Lcom/openfeint/api/resource/Achievement;

    iget-object v2, v2, Lcom/openfeint/api/resource/Achievement;->iconUrl:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ":"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/openfeint/internal/logcat/OFLog;->e(Ljava/lang/String;Ljava/lang/String;)V

    iget-object v0, p0, Lcom/openfeint/internal/notifications/AchievementNotification$1;->this$0:Lcom/openfeint/internal/notifications/AchievementNotification;

    invoke-virtual {v0}, Lcom/openfeint/internal/notifications/AchievementNotification;->showToast()V

    return-void
.end method

.method public final onSuccess(Landroid/graphics/Bitmap;)V
    .locals 2

    iget-object v0, p0, Lcom/openfeint/internal/notifications/AchievementNotification$1;->this$0:Lcom/openfeint/internal/notifications/AchievementNotification;

    iget-object v0, v0, Lcom/openfeint/internal/notifications/AchievementNotification;->displayView:Landroid/view/View;

    const-string v1, "of_achievement_icon"

    invoke-static {v1}, Lcom/openfeint/internal/RR;->id(Ljava/lang/String;)I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageView;

    new-instance v1, Landroid/graphics/drawable/BitmapDrawable;

    invoke-direct {v1, p1}, Landroid/graphics/drawable/BitmapDrawable;-><init>(Landroid/graphics/Bitmap;)V

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setImageDrawable(Landroid/graphics/drawable/Drawable;)V

    iget-object v0, p0, Lcom/openfeint/internal/notifications/AchievementNotification$1;->this$0:Lcom/openfeint/internal/notifications/AchievementNotification;

    invoke-virtual {v0}, Lcom/openfeint/internal/notifications/AchievementNotification;->showToast()V

    return-void
.end method
