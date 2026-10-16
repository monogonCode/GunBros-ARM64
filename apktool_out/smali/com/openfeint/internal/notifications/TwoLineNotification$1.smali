.class final Lcom/openfeint/internal/notifications/TwoLineNotification$1;
.super Lcom/openfeint/internal/request/BitmapRequest;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/openfeint/internal/notifications/TwoLineNotification;->createView()Z
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/openfeint/internal/notifications/TwoLineNotification;

.field final synthetic val$icon:Landroid/widget/ImageView;


# direct methods
.method constructor <init>(Lcom/openfeint/internal/notifications/TwoLineNotification;Landroid/widget/ImageView;)V
    .locals 0

    iput-object p1, p0, Lcom/openfeint/internal/notifications/TwoLineNotification$1;->this$0:Lcom/openfeint/internal/notifications/TwoLineNotification;

    iput-object p2, p0, Lcom/openfeint/internal/notifications/TwoLineNotification$1;->val$icon:Landroid/widget/ImageView;

    invoke-direct {p0}, Lcom/openfeint/internal/request/BitmapRequest;-><init>()V

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

    iget-object v2, p0, Lcom/openfeint/internal/notifications/TwoLineNotification$1;->this$0:Lcom/openfeint/internal/notifications/TwoLineNotification;

    iget-object v2, v2, Lcom/openfeint/internal/notifications/TwoLineNotification;->imageName:Ljava/lang/String;

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

    iget-object v0, p0, Lcom/openfeint/internal/notifications/TwoLineNotification$1;->val$icon:Landroid/widget/ImageView;

    const/4 v1, 0x4

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setVisibility(I)V

    iget-object v0, p0, Lcom/openfeint/internal/notifications/TwoLineNotification$1;->this$0:Lcom/openfeint/internal/notifications/TwoLineNotification;

    invoke-virtual {v0}, Lcom/openfeint/internal/notifications/TwoLineNotification;->showToast()V

    return-void
.end method

.method public final onSuccess(Landroid/graphics/Bitmap;)V
    .locals 2

    iget-object v0, p0, Lcom/openfeint/internal/notifications/TwoLineNotification$1;->val$icon:Landroid/widget/ImageView;

    new-instance v1, Landroid/graphics/drawable/BitmapDrawable;

    invoke-direct {v1, p1}, Landroid/graphics/drawable/BitmapDrawable;-><init>(Landroid/graphics/Bitmap;)V

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setImageDrawable(Landroid/graphics/drawable/Drawable;)V

    iget-object v0, p0, Lcom/openfeint/internal/notifications/TwoLineNotification$1;->this$0:Lcom/openfeint/internal/notifications/TwoLineNotification;

    invoke-virtual {v0}, Lcom/openfeint/internal/notifications/TwoLineNotification;->showToast()V

    return-void
.end method

.method public final path()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/openfeint/internal/notifications/TwoLineNotification$1;->this$0:Lcom/openfeint/internal/notifications/TwoLineNotification;

    iget-object v0, v0, Lcom/openfeint/internal/notifications/TwoLineNotification;->imageName:Ljava/lang/String;

    return-object v0
.end method
