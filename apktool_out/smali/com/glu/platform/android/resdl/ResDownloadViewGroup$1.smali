.class final Lcom/glu/platform/android/resdl/ResDownloadViewGroup$1;
.super Landroid/os/Handler;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/glu/platform/android/resdl/ResDownloadViewGroup;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/glu/platform/android/resdl/ResDownloadViewGroup;


# direct methods
.method constructor <init>(Lcom/glu/platform/android/resdl/ResDownloadViewGroup;)V
    .locals 0

    iput-object p1, p0, Lcom/glu/platform/android/resdl/ResDownloadViewGroup$1;->this$0:Lcom/glu/platform/android/resdl/ResDownloadViewGroup;

    invoke-direct {p0}, Landroid/os/Handler;-><init>()V

    return-void
.end method


# virtual methods
.method public final handleMessage(Landroid/os/Message;)V
    .locals 2

    iget v0, p1, Landroid/os/Message;->what:I

    const/4 v1, 0x1

    if-ne v0, v1, :cond_0

    iget-object v0, p0, Lcom/glu/platform/android/resdl/ResDownloadViewGroup$1;->this$0:Lcom/glu/platform/android/resdl/ResDownloadViewGroup;

    invoke-virtual {v0}, Lcom/glu/platform/android/resdl/ResDownloadViewGroup;->requestLayout()V

    :cond_0
    return-void
.end method
