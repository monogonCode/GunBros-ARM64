.class final Lcom/glu/platform/android/GluNotificationService$1;
.super Landroid/os/Handler;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/glu/platform/android/GluNotificationService;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# static fields
.field static final synthetic $assertionsDisabled:Z


# instance fields
.field final synthetic this$0:Lcom/glu/platform/android/GluNotificationService;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    const-class v0, Lcom/glu/platform/android/GluNotificationService;

    invoke-virtual {v0}, Ljava/lang/Class;->desiredAssertionStatus()Z

    move-result v0

    if-nez v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    sput-boolean v0, Lcom/glu/platform/android/GluNotificationService$1;->$assertionsDisabled:Z

    return-void

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method constructor <init>(Lcom/glu/platform/android/GluNotificationService;)V
    .locals 0

    iput-object p1, p0, Lcom/glu/platform/android/GluNotificationService$1;->this$0:Lcom/glu/platform/android/GluNotificationService;

    invoke-direct {p0}, Landroid/os/Handler;-><init>()V

    return-void
.end method


# virtual methods
.method public final handleMessage(Landroid/os/Message;)V
    .locals 2

    iget v0, p1, Landroid/os/Message;->what:I

    packed-switch v0, :pswitch_data_0

    sget-boolean v0, Lcom/glu/platform/android/GluNotificationService$1;->$assertionsDisabled:Z

    if-nez v0, :cond_0

    new-instance v0, Ljava/lang/AssertionError;

    invoke-direct {v0}, Ljava/lang/AssertionError;-><init>()V

    throw v0

    :pswitch_0
    iget-object v0, p0, Lcom/glu/platform/android/GluNotificationService$1;->this$0:Lcom/glu/platform/android/GluNotificationService;

    iget v1, p1, Landroid/os/Message;->arg1:I

    invoke-static {v0, v1}, Lcom/glu/platform/android/GluNotificationService;->access$100(Lcom/glu/platform/android/GluNotificationService;I)V

    iget-object v0, p0, Lcom/glu/platform/android/GluNotificationService$1;->this$0:Lcom/glu/platform/android/GluNotificationService;

    invoke-static {v0}, Lcom/glu/platform/android/GluNotificationService;->access$200(Lcom/glu/platform/android/GluNotificationService;)Ljava/util/Vector;

    move-result-object v0

    iget v1, p1, Landroid/os/Message;->arg1:I

    invoke-virtual {v0, v1}, Ljava/util/Vector;->remove(I)Ljava/lang/Object;

    iget-object v0, p0, Lcom/glu/platform/android/GluNotificationService$1;->this$0:Lcom/glu/platform/android/GluNotificationService;

    iget-object v1, p0, Lcom/glu/platform/android/GluNotificationService$1;->this$0:Lcom/glu/platform/android/GluNotificationService;

    invoke-virtual {v1}, Lcom/glu/platform/android/GluNotificationService;->getApplicationContext()Landroid/content/Context;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/glu/platform/android/GluNotificationService;->access$300(Lcom/glu/platform/android/GluNotificationService;Landroid/content/Context;)V

    iget-object v0, p0, Lcom/glu/platform/android/GluNotificationService$1;->this$0:Lcom/glu/platform/android/GluNotificationService;

    invoke-static {v0}, Lcom/glu/platform/android/GluNotificationService;->access$400(Lcom/glu/platform/android/GluNotificationService;)V

    iget-object v0, p0, Lcom/glu/platform/android/GluNotificationService$1;->this$0:Lcom/glu/platform/android/GluNotificationService;

    invoke-static {v0}, Lcom/glu/platform/android/GluNotificationService;->access$500(Lcom/glu/platform/android/GluNotificationService;)V

    :cond_0
    return-void

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_0
    .end packed-switch
.end method
