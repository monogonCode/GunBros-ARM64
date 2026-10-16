.class final Lcom/glu/platform/android/resdl/GluDownloadResMgr$3;
.super Ljava/lang/Thread;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/glu/platform/android/resdl/GluDownloadResMgr;->performSpecialChecksumAsync()Z
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/glu/platform/android/resdl/GluDownloadResMgr;


# direct methods
.method constructor <init>(Lcom/glu/platform/android/resdl/GluDownloadResMgr;)V
    .locals 0

    iput-object p1, p0, Lcom/glu/platform/android/resdl/GluDownloadResMgr$3;->this$0:Lcom/glu/platform/android/resdl/GluDownloadResMgr;

    invoke-direct {p0}, Ljava/lang/Thread;-><init>()V

    return-void
.end method


# virtual methods
.method public final run()V
    .locals 1

    iget-object v0, p0, Lcom/glu/platform/android/resdl/GluDownloadResMgr$3;->this$0:Lcom/glu/platform/android/resdl/GluDownloadResMgr;

    invoke-static {v0}, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->access$600(Lcom/glu/platform/android/resdl/GluDownloadResMgr;)V

    return-void
.end method
