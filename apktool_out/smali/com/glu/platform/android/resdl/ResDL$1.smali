.class final Lcom/glu/platform/android/resdl/ResDL$1;
.super Landroid/os/Handler;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/glu/platform/android/resdl/ResDL;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = null
.end annotation


# direct methods
.method constructor <init>()V
    .locals 0

    invoke-direct {p0}, Landroid/os/Handler;-><init>()V

    return-void
.end method


# virtual methods
.method public final handleMessage(Landroid/os/Message;)V
    .locals 2

    iget v0, p1, Landroid/os/Message;->what:I

    if-nez v0, :cond_1

    invoke-static {}, Lcom/glu/platform/android/resdl/GameLet$instance;->onHandledOpenModalDialog()V

    :cond_0
    :goto_0
    return-void

    :cond_1
    const/4 v1, 0x1

    if-ne v0, v1, :cond_2

    invoke-static {}, Lcom/glu/platform/android/resdl/GameLet$instance;->onHandledCloseModalDialog()V

    goto :goto_0

    :cond_2
    const/4 v1, 0x2

    if-ne v0, v1, :cond_0

    invoke-static {}, Lcom/glu/platform/android/resdl/ResDL;->onReadyToSwitchToResView()V

    goto :goto_0
.end method
