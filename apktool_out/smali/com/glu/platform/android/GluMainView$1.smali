.class final Lcom/glu/platform/android/GluMainView$1;
.super Landroid/os/Handler;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/glu/platform/android/GluMainView;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# static fields
.field static final synthetic $assertionsDisabled:Z


# instance fields
.field final synthetic this$0:Lcom/glu/platform/android/GluMainView;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    const-class v0, Lcom/glu/platform/android/GluMainView;

    invoke-virtual {v0}, Ljava/lang/Class;->desiredAssertionStatus()Z

    move-result v0

    if-nez v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    sput-boolean v0, Lcom/glu/platform/android/GluMainView$1;->$assertionsDisabled:Z

    return-void

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method constructor <init>(Lcom/glu/platform/android/GluMainView;)V
    .locals 0

    iput-object p1, p0, Lcom/glu/platform/android/GluMainView$1;->this$0:Lcom/glu/platform/android/GluMainView;

    invoke-direct {p0}, Landroid/os/Handler;-><init>()V

    return-void
.end method


# virtual methods
.method public final handleMessage(Landroid/os/Message;)V
    .locals 8

    const/4 v3, 0x1

    iget v0, p1, Landroid/os/Message;->what:I

    packed-switch v0, :pswitch_data_0

    sget-boolean v0, Lcom/glu/platform/android/GluMainView$1;->$assertionsDisabled:Z

    if-nez v0, :cond_1

    new-instance v0, Ljava/lang/AssertionError;

    invoke-direct {v0}, Ljava/lang/AssertionError;-><init>()V

    throw v0

    :pswitch_0
    iget-object v0, p0, Lcom/glu/platform/android/GluMainView$1;->this$0:Lcom/glu/platform/android/GluMainView;

    invoke-static {v0}, Lcom/glu/platform/android/GluMainView;->access$302$664717f3(Lcom/glu/platform/android/GluMainView;)Z

    iget-object v0, p0, Lcom/glu/platform/android/GluMainView$1;->this$0:Lcom/glu/platform/android/GluMainView;

    invoke-static {v0}, Lcom/glu/platform/android/GluMainView;->access$400(Lcom/glu/platform/android/GluMainView;)Ljava/util/concurrent/ScheduledFuture;

    move-result-object v0

    const/4 v1, 0x0

    invoke-interface {v0, v1}, Ljava/util/concurrent/ScheduledFuture;->cancel(Z)Z

    :try_start_0
    iget-object v0, p0, Lcom/glu/platform/android/GluMainView$1;->this$0:Lcom/glu/platform/android/GluMainView;

    invoke-static {v0}, Lcom/glu/platform/android/GluMainView;->access$400(Lcom/glu/platform/android/GluMainView;)Ljava/util/concurrent/ScheduledFuture;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/concurrent/ScheduledFuture;->get()Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    iget-object v0, p0, Lcom/glu/platform/android/GluMainView$1;->this$0:Lcom/glu/platform/android/GluMainView;

    invoke-static {v0}, Lcom/glu/platform/android/GluMainView;->access$000(Lcom/glu/platform/android/GluMainView;)Lcom/glu/platform/android/GluPlatformActivity;

    move-result-object v0

    invoke-virtual {v0}, Lcom/glu/platform/android/GluPlatformActivity;->GetTickRate()I

    move-result v4

    iget-object v0, p0, Lcom/glu/platform/android/GluMainView$1;->this$0:Lcom/glu/platform/android/GluMainView;

    invoke-static {v0}, Lcom/glu/platform/android/GluMainView;->access$500(Lcom/glu/platform/android/GluMainView;)Ljava/util/concurrent/ScheduledThreadPoolExecutor;

    move-result-object v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/glu/platform/android/GluMainView$1;->this$0:Lcom/glu/platform/android/GluMainView;

    new-instance v1, Ljava/util/concurrent/ScheduledThreadPoolExecutor;

    invoke-direct {v1, v3}, Ljava/util/concurrent/ScheduledThreadPoolExecutor;-><init>(I)V

    invoke-static {v0, v1}, Lcom/glu/platform/android/GluMainView;->access$502(Lcom/glu/platform/android/GluMainView;Ljava/util/concurrent/ScheduledThreadPoolExecutor;)Ljava/util/concurrent/ScheduledThreadPoolExecutor;

    :cond_0
    iget-object v7, p0, Lcom/glu/platform/android/GluMainView$1;->this$0:Lcom/glu/platform/android/GluMainView;

    iget-object v0, p0, Lcom/glu/platform/android/GluMainView$1;->this$0:Lcom/glu/platform/android/GluMainView;

    invoke-static {v0}, Lcom/glu/platform/android/GluMainView;->access$500(Lcom/glu/platform/android/GluMainView;)Ljava/util/concurrent/ScheduledThreadPoolExecutor;

    move-result-object v0

    new-instance v1, Lcom/glu/platform/android/GluMainView$TickTask;

    iget-object v2, p0, Lcom/glu/platform/android/GluMainView$1;->this$0:Lcom/glu/platform/android/GluMainView;

    invoke-direct {v1, v2, v3}, Lcom/glu/platform/android/GluMainView$TickTask;-><init>(Lcom/glu/platform/android/GluMainView;Z)V

    int-to-long v2, v4

    int-to-long v4, v4

    sget-object v6, Ljava/util/concurrent/TimeUnit;->MILLISECONDS:Ljava/util/concurrent/TimeUnit;

    invoke-virtual/range {v0 .. v6}, Ljava/util/concurrent/ScheduledThreadPoolExecutor;->scheduleAtFixedRate(Ljava/lang/Runnable;JJLjava/util/concurrent/TimeUnit;)Ljava/util/concurrent/ScheduledFuture;

    move-result-object v0

    invoke-static {v7, v0}, Lcom/glu/platform/android/GluMainView;->access$402(Lcom/glu/platform/android/GluMainView;Ljava/util/concurrent/ScheduledFuture;)Ljava/util/concurrent/ScheduledFuture;

    :cond_1
    return-void

    :catch_0
    move-exception v0

    goto :goto_0

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_0
    .end packed-switch
.end method
