.class public Lcom/glu/platform/android/GluMainView;
.super Landroid/view/SurfaceView;

# interfaces
.implements Landroid/view/SurfaceHolder$Callback;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/glu/platform/android/GluMainView$TickTask;
    }
.end annotation


# instance fields
.field private m_Activity:Lcom/glu/platform/android/GluPlatformActivity;

.field private m_Executor:Ljava/util/concurrent/ScheduledThreadPoolExecutor;

.field private m_JavaSurfaceExists:Z

.field private m_Kicker:Landroid/os/Handler;

.field private m_TickRateChanged:Z

.field private m_TickTaskFuture:Ljava/util/concurrent/ScheduledFuture;

.field private m_Ticking:Z


# direct methods
.method public constructor <init>(Landroid/content/Context;Lcom/glu/platform/android/GluPlatformActivity;)V
    .locals 1

    invoke-direct {p0, p1}, Landroid/view/SurfaceView;-><init>(Landroid/content/Context;)V

    new-instance v0, Lcom/glu/platform/android/GluMainView$1;

    invoke-direct {v0, p0}, Lcom/glu/platform/android/GluMainView$1;-><init>(Lcom/glu/platform/android/GluMainView;)V

    iput-object v0, p0, Lcom/glu/platform/android/GluMainView;->m_Kicker:Landroid/os/Handler;

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/glu/platform/android/GluMainView;->m_TickRateChanged:Z

    invoke-virtual {p0}, Lcom/glu/platform/android/GluMainView;->getHolder()Landroid/view/SurfaceHolder;

    move-result-object v0

    invoke-interface {v0, p0}, Landroid/view/SurfaceHolder;->addCallback(Landroid/view/SurfaceHolder$Callback;)V

    iput-object p2, p0, Lcom/glu/platform/android/GluMainView;->m_Activity:Lcom/glu/platform/android/GluPlatformActivity;

    return-void
.end method

.method static synthetic access$000(Lcom/glu/platform/android/GluMainView;)Lcom/glu/platform/android/GluPlatformActivity;
    .locals 1

    iget-object v0, p0, Lcom/glu/platform/android/GluMainView;->m_Activity:Lcom/glu/platform/android/GluPlatformActivity;

    return-object v0
.end method

.method static synthetic access$100(Lcom/glu/platform/android/GluMainView;)Z
    .locals 1

    iget-boolean v0, p0, Lcom/glu/platform/android/GluMainView;->m_TickRateChanged:Z

    return v0
.end method

.method static synthetic access$102$664717f3(Lcom/glu/platform/android/GluMainView;)Z
    .locals 1

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/glu/platform/android/GluMainView;->m_TickRateChanged:Z

    return v0
.end method

.method static synthetic access$200(Lcom/glu/platform/android/GluMainView;)Landroid/os/Handler;
    .locals 1

    iget-object v0, p0, Lcom/glu/platform/android/GluMainView;->m_Kicker:Landroid/os/Handler;

    return-object v0
.end method

.method static synthetic access$302$664717f3(Lcom/glu/platform/android/GluMainView;)Z
    .locals 1

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/glu/platform/android/GluMainView;->m_Ticking:Z

    return v0
.end method

.method static synthetic access$400(Lcom/glu/platform/android/GluMainView;)Ljava/util/concurrent/ScheduledFuture;
    .locals 1

    iget-object v0, p0, Lcom/glu/platform/android/GluMainView;->m_TickTaskFuture:Ljava/util/concurrent/ScheduledFuture;

    return-object v0
.end method

.method static synthetic access$402(Lcom/glu/platform/android/GluMainView;Ljava/util/concurrent/ScheduledFuture;)Ljava/util/concurrent/ScheduledFuture;
    .locals 0

    iput-object p1, p0, Lcom/glu/platform/android/GluMainView;->m_TickTaskFuture:Ljava/util/concurrent/ScheduledFuture;

    return-object p1
.end method

.method static synthetic access$500(Lcom/glu/platform/android/GluMainView;)Ljava/util/concurrent/ScheduledThreadPoolExecutor;
    .locals 1

    iget-object v0, p0, Lcom/glu/platform/android/GluMainView;->m_Executor:Ljava/util/concurrent/ScheduledThreadPoolExecutor;

    return-object v0
.end method

.method static synthetic access$502(Lcom/glu/platform/android/GluMainView;Ljava/util/concurrent/ScheduledThreadPoolExecutor;)Ljava/util/concurrent/ScheduledThreadPoolExecutor;
    .locals 0

    iput-object p1, p0, Lcom/glu/platform/android/GluMainView;->m_Executor:Ljava/util/concurrent/ScheduledThreadPoolExecutor;

    return-object p1
.end method

.method private kick()V
    .locals 2

    iget-object v0, p0, Lcom/glu/platform/android/GluMainView;->m_Executor:Ljava/util/concurrent/ScheduledThreadPoolExecutor;

    if-nez v0, :cond_0

    new-instance v0, Ljava/util/concurrent/ScheduledThreadPoolExecutor;

    const/4 v1, 0x1

    invoke-direct {v0, v1}, Ljava/util/concurrent/ScheduledThreadPoolExecutor;-><init>(I)V

    iput-object v0, p0, Lcom/glu/platform/android/GluMainView;->m_Executor:Ljava/util/concurrent/ScheduledThreadPoolExecutor;

    :cond_0
    const/4 v0, 0x0

    invoke-direct {p0, v0}, Lcom/glu/platform/android/GluMainView;->stopTimer(Z)V

    return-void
.end method

.method private startTimer()V
    .locals 7

    const/4 v2, 0x1

    iget-object v0, p0, Lcom/glu/platform/android/GluMainView;->m_Executor:Ljava/util/concurrent/ScheduledThreadPoolExecutor;

    if-nez v0, :cond_0

    new-instance v0, Ljava/util/concurrent/ScheduledThreadPoolExecutor;

    invoke-direct {v0, v2}, Ljava/util/concurrent/ScheduledThreadPoolExecutor;-><init>(I)V

    iput-object v0, p0, Lcom/glu/platform/android/GluMainView;->m_Executor:Ljava/util/concurrent/ScheduledThreadPoolExecutor;

    :cond_0
    iget-object v0, p0, Lcom/glu/platform/android/GluMainView;->m_Executor:Ljava/util/concurrent/ScheduledThreadPoolExecutor;

    if-eqz v0, :cond_1

    iget-boolean v0, p0, Lcom/glu/platform/android/GluMainView;->m_Ticking:Z

    if-nez v0, :cond_1

    iget-boolean v0, p0, Lcom/glu/platform/android/GluMainView;->m_JavaSurfaceExists:Z

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/glu/platform/android/GluMainView;->m_Activity:Lcom/glu/platform/android/GluPlatformActivity;

    invoke-virtual {v0}, Lcom/glu/platform/android/GluPlatformActivity;->GetTickRate()I

    move-result v4

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "tickrate: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    const/4 v0, -0x1

    if-eq v0, v4, :cond_2

    iput-boolean v2, p0, Lcom/glu/platform/android/GluMainView;->m_Ticking:Z

    iget-object v0, p0, Lcom/glu/platform/android/GluMainView;->m_Executor:Ljava/util/concurrent/ScheduledThreadPoolExecutor;

    new-instance v1, Lcom/glu/platform/android/GluMainView$TickTask;

    invoke-direct {v1, p0, v2}, Lcom/glu/platform/android/GluMainView$TickTask;-><init>(Lcom/glu/platform/android/GluMainView;Z)V

    int-to-long v2, v4

    int-to-long v4, v4

    sget-object v6, Ljava/util/concurrent/TimeUnit;->MILLISECONDS:Ljava/util/concurrent/TimeUnit;

    invoke-virtual/range {v0 .. v6}, Ljava/util/concurrent/ScheduledThreadPoolExecutor;->scheduleAtFixedRate(Ljava/lang/Runnable;JJLjava/util/concurrent/TimeUnit;)Ljava/util/concurrent/ScheduledFuture;

    move-result-object v0

    iput-object v0, p0, Lcom/glu/platform/android/GluMainView;->m_TickTaskFuture:Ljava/util/concurrent/ScheduledFuture;

    :cond_1
    :goto_0
    return-void

    :cond_2
    iget-object v0, p0, Lcom/glu/platform/android/GluMainView;->m_Executor:Ljava/util/concurrent/ScheduledThreadPoolExecutor;

    new-instance v1, Lcom/glu/platform/android/GluMainView$TickTask;

    invoke-direct {v1, p0, v2}, Lcom/glu/platform/android/GluMainView$TickTask;-><init>(Lcom/glu/platform/android/GluMainView;Z)V

    invoke-virtual {v0, v1}, Ljava/util/concurrent/ScheduledThreadPoolExecutor;->execute(Ljava/lang/Runnable;)V

    goto :goto_0
.end method

.method private stopTimer(Z)V
    .locals 4

    iget-object v0, p0, Lcom/glu/platform/android/GluMainView;->m_Executor:Ljava/util/concurrent/ScheduledThreadPoolExecutor;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/glu/platform/android/GluMainView;->m_Executor:Ljava/util/concurrent/ScheduledThreadPoolExecutor;

    new-instance v1, Lcom/glu/platform/android/GluMainView$TickTask;

    invoke-direct {v1, p0, p1}, Lcom/glu/platform/android/GluMainView$TickTask;-><init>(Lcom/glu/platform/android/GluMainView;Z)V

    invoke-virtual {v0, v1}, Ljava/util/concurrent/ScheduledThreadPoolExecutor;->execute(Ljava/lang/Runnable;)V

    iget-object v0, p0, Lcom/glu/platform/android/GluMainView;->m_Executor:Ljava/util/concurrent/ScheduledThreadPoolExecutor;

    invoke-virtual {v0}, Ljava/util/concurrent/ScheduledThreadPoolExecutor;->shutdown()V

    :try_start_0
    iget-object v0, p0, Lcom/glu/platform/android/GluMainView;->m_Executor:Ljava/util/concurrent/ScheduledThreadPoolExecutor;

    const-wide/16 v1, 0x3c

    sget-object v3, Ljava/util/concurrent/TimeUnit;->SECONDS:Ljava/util/concurrent/TimeUnit;

    invoke-virtual {v0, v1, v2, v3}, Ljava/util/concurrent/ScheduledThreadPoolExecutor;->awaitTermination(JLjava/util/concurrent/TimeUnit;)Z
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/glu/platform/android/GluMainView;->m_Executor:Ljava/util/concurrent/ScheduledThreadPoolExecutor;

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/glu/platform/android/GluMainView;->m_Ticking:Z

    :cond_0
    return-void

    :catch_0
    move-exception v0

    iget-object v0, p0, Lcom/glu/platform/android/GluMainView;->m_Executor:Ljava/util/concurrent/ScheduledThreadPoolExecutor;

    invoke-virtual {v0}, Ljava/util/concurrent/ScheduledThreadPoolExecutor;->shutdownNow()Ljava/util/List;

    goto :goto_0
.end method


# virtual methods
.method public final TickRateChanged()V
    .locals 1

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/glu/platform/android/GluMainView;->m_TickRateChanged:Z

    return-void
.end method

.method public final onDestroy()V
    .locals 0

    invoke-direct {p0}, Lcom/glu/platform/android/GluMainView;->kick()V

    return-void
.end method

.method public final onPause()V
    .locals 1

    const/4 v0, 0x1

    invoke-direct {p0, v0}, Lcom/glu/platform/android/GluMainView;->stopTimer(Z)V

    return-void
.end method

.method public final onResume()V
    .locals 0

    invoke-direct {p0}, Lcom/glu/platform/android/GluMainView;->startTimer()V

    return-void
.end method

.method public final onStop()V
    .locals 0

    invoke-direct {p0}, Lcom/glu/platform/android/GluMainView;->kick()V

    return-void
.end method

.method public onWindowFocusChanged(Z)V
    .locals 1

    if-eqz p1, :cond_0

    iget-object v0, p0, Lcom/glu/platform/android/GluMainView;->m_Activity:Lcom/glu/platform/android/GluPlatformActivity;

    invoke-virtual {v0}, Lcom/glu/platform/android/GluPlatformActivity;->resumeAfterGainedWindowFocus()V

    :cond_0
    invoke-super {p0, p1}, Landroid/view/SurfaceView;->onWindowFocusChanged(Z)V

    return-void
.end method

.method public surfaceChanged(Landroid/view/SurfaceHolder;III)V
    .locals 0

    return-void
.end method

.method public surfaceCreated(Landroid/view/SurfaceHolder;)V
    .locals 1

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/glu/platform/android/GluMainView;->m_JavaSurfaceExists:Z

    invoke-direct {p0}, Lcom/glu/platform/android/GluMainView;->startTimer()V

    return-void
.end method

.method public surfaceDestroyed(Landroid/view/SurfaceHolder;)V
    .locals 1

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/glu/platform/android/GluMainView;->m_JavaSurfaceExists:Z

    return-void
.end method
