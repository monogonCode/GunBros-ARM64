.class final Lcom/glu/platform/android/GluMainView$TickTask;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/glu/platform/android/GluMainView;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = "TickTask"
.end annotation


# instance fields
.field private m_Ticking:Z

.field final synthetic this$0:Lcom/glu/platform/android/GluMainView;


# direct methods
.method public constructor <init>(Lcom/glu/platform/android/GluMainView;Z)V
    .locals 0

    iput-object p1, p0, Lcom/glu/platform/android/GluMainView$TickTask;->this$0:Lcom/glu/platform/android/GluMainView;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-boolean p2, p0, Lcom/glu/platform/android/GluMainView$TickTask;->m_Ticking:Z

    return-void
.end method


# virtual methods
.method public final run()V
    .locals 4

    invoke-static {}, Landroid/os/SystemClock;->uptimeMillis()J

    move-result-wide v0

    iget-object v2, p0, Lcom/glu/platform/android/GluMainView$TickTask;->this$0:Lcom/glu/platform/android/GluMainView;

    invoke-static {v2}, Lcom/glu/platform/android/GluMainView;->access$000(Lcom/glu/platform/android/GluMainView;)Lcom/glu/platform/android/GluPlatformActivity;

    move-result-object v2

    iget-boolean v3, p0, Lcom/glu/platform/android/GluMainView$TickTask;->m_Ticking:Z

    invoke-virtual {v2, v0, v1, v3}, Lcom/glu/platform/android/GluPlatformActivity;->onDrawFrame(JZ)V

    iget-object v0, p0, Lcom/glu/platform/android/GluMainView$TickTask;->this$0:Lcom/glu/platform/android/GluMainView;

    invoke-static {v0}, Lcom/glu/platform/android/GluMainView;->access$100(Lcom/glu/platform/android/GluMainView;)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/glu/platform/android/GluMainView$TickTask;->this$0:Lcom/glu/platform/android/GluMainView;

    invoke-static {v0}, Lcom/glu/platform/android/GluMainView;->access$102$664717f3(Lcom/glu/platform/android/GluMainView;)Z

    iget-object v0, p0, Lcom/glu/platform/android/GluMainView$TickTask;->this$0:Lcom/glu/platform/android/GluMainView;

    invoke-static {v0}, Lcom/glu/platform/android/GluMainView;->access$200(Lcom/glu/platform/android/GluMainView;)Landroid/os/Handler;

    move-result-object v0

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Landroid/os/Handler;->sendEmptyMessage(I)Z

    :cond_0
    return-void
.end method
