.class final Lcom/openfeint/internal/notifications/NotificationBase$1;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/openfeint/internal/notifications/NotificationBase;->showToast()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/openfeint/internal/notifications/NotificationBase;


# direct methods
.method constructor <init>(Lcom/openfeint/internal/notifications/NotificationBase;)V
    .locals 0

    iput-object p1, p0, Lcom/openfeint/internal/notifications/NotificationBase$1;->this$0:Lcom/openfeint/internal/notifications/NotificationBase;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final run()V
    .locals 4

    const/4 v3, 0x0

    invoke-static {}, Lcom/openfeint/internal/OpenFeintInternal;->getInstance()Lcom/openfeint/internal/OpenFeintInternal;

    move-result-object v0

    invoke-virtual {v0}, Lcom/openfeint/internal/OpenFeintInternal;->getContext()Landroid/content/Context;

    move-result-object v0

    iget-object v1, p0, Lcom/openfeint/internal/notifications/NotificationBase$1;->this$0:Lcom/openfeint/internal/notifications/NotificationBase;

    new-instance v2, Landroid/widget/Toast;

    invoke-direct {v2, v0}, Landroid/widget/Toast;-><init>(Landroid/content/Context;)V

    iput-object v2, v1, Lcom/openfeint/internal/notifications/NotificationBase;->toast:Landroid/widget/Toast;

    iget-object v0, p0, Lcom/openfeint/internal/notifications/NotificationBase$1;->this$0:Lcom/openfeint/internal/notifications/NotificationBase;

    iget-object v0, v0, Lcom/openfeint/internal/notifications/NotificationBase;->toast:Landroid/widget/Toast;

    const/16 v1, 0x30

    invoke-virtual {v0, v1, v3, v3}, Landroid/widget/Toast;->setGravity(III)V

    iget-object v0, p0, Lcom/openfeint/internal/notifications/NotificationBase$1;->this$0:Lcom/openfeint/internal/notifications/NotificationBase;

    iget-object v0, v0, Lcom/openfeint/internal/notifications/NotificationBase;->toast:Landroid/widget/Toast;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Landroid/widget/Toast;->setDuration(I)V

    iget-object v0, p0, Lcom/openfeint/internal/notifications/NotificationBase$1;->this$0:Lcom/openfeint/internal/notifications/NotificationBase;

    iget-object v0, v0, Lcom/openfeint/internal/notifications/NotificationBase;->toast:Landroid/widget/Toast;

    iget-object v1, p0, Lcom/openfeint/internal/notifications/NotificationBase$1;->this$0:Lcom/openfeint/internal/notifications/NotificationBase;

    iget-object v1, v1, Lcom/openfeint/internal/notifications/NotificationBase;->displayView:Landroid/view/View;

    invoke-virtual {v0, v1}, Landroid/widget/Toast;->setView(Landroid/view/View;)V

    iget-object v0, p0, Lcom/openfeint/internal/notifications/NotificationBase$1;->this$0:Lcom/openfeint/internal/notifications/NotificationBase;

    iget-object v0, v0, Lcom/openfeint/internal/notifications/NotificationBase;->toast:Landroid/widget/Toast;

    invoke-virtual {v0}, Landroid/widget/Toast;->show()V

    return-void
.end method
