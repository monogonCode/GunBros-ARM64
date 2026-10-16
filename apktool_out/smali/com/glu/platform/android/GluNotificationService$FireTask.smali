.class final Lcom/glu/platform/android/GluNotificationService$FireTask;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/glu/platform/android/GluNotificationService;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "FireTask"
.end annotation


# instance fields
.field private m_index:I

.field final synthetic this$0:Lcom/glu/platform/android/GluNotificationService;


# direct methods
.method public constructor <init>(Lcom/glu/platform/android/GluNotificationService;I)V
    .locals 0

    iput-object p1, p0, Lcom/glu/platform/android/GluNotificationService$FireTask;->this$0:Lcom/glu/platform/android/GluNotificationService;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput p2, p0, Lcom/glu/platform/android/GluNotificationService$FireTask;->m_index:I

    return-void
.end method


# virtual methods
.method public final run()V
    .locals 4

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Triggered - index: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/glu/platform/android/GluNotificationService$FireTask;->m_index:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    iget-object v0, p0, Lcom/glu/platform/android/GluNotificationService$FireTask;->this$0:Lcom/glu/platform/android/GluNotificationService;

    invoke-static {v0}, Lcom/glu/platform/android/GluNotificationService;->access$000(Lcom/glu/platform/android/GluNotificationService;)Landroid/os/Handler;

    move-result-object v0

    const/4 v1, 0x1

    iget v2, p0, Lcom/glu/platform/android/GluNotificationService$FireTask;->m_index:I

    const/4 v3, 0x0

    invoke-virtual {v0, v1, v2, v3}, Landroid/os/Handler;->obtainMessage(III)Landroid/os/Message;

    move-result-object v0

    iget-object v1, p0, Lcom/glu/platform/android/GluNotificationService$FireTask;->this$0:Lcom/glu/platform/android/GluNotificationService;

    invoke-static {v1}, Lcom/glu/platform/android/GluNotificationService;->access$000(Lcom/glu/platform/android/GluNotificationService;)Landroid/os/Handler;

    move-result-object v1

    invoke-virtual {v1, v0}, Landroid/os/Handler;->sendMessage(Landroid/os/Message;)Z

    return-void
.end method
