.class final Lcom/glu/platform/android/resdl/GluDownloadResMgr$2;
.super Ljava/lang/Thread;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/glu/platform/android/resdl/GluDownloadResMgr;->downloadResFile()V
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

    iput-object p1, p0, Lcom/glu/platform/android/resdl/GluDownloadResMgr$2;->this$0:Lcom/glu/platform/android/resdl/GluDownloadResMgr;

    invoke-direct {p0}, Ljava/lang/Thread;-><init>()V

    return-void
.end method


# virtual methods
.method public final run()V
    .locals 6

    const/4 v2, 0x0

    const/4 v1, 0x1

    iget-object v0, p0, Lcom/glu/platform/android/resdl/GluDownloadResMgr$2;->this$0:Lcom/glu/platform/android/resdl/GluDownloadResMgr;

    invoke-static {}, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->areThereSpecialFiles()Z

    move-result v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/glu/platform/android/resdl/GluDownloadResMgr$2;->this$0:Lcom/glu/platform/android/resdl/GluDownloadResMgr;

    invoke-virtual {v0}, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->verifySpecialFileIntegrity()Z

    move-result v0

    if-nez v0, :cond_1

    move v0, v1

    :goto_0
    sget-object v3, Lcom/glu/platform/android/resdl/ResFileDownloadView;->instance:Lcom/glu/platform/android/resdl/ResFileDownloadView;

    if-nez v3, :cond_2

    :cond_0
    :goto_1
    return-void

    :cond_1
    move v0, v2

    goto :goto_0

    :cond_2
    :try_start_0
    iget-object v4, p0, Lcom/glu/platform/android/resdl/GluDownloadResMgr$2;->this$0:Lcom/glu/platform/android/resdl/GluDownloadResMgr;

    const/4 v5, 0x0

    invoke-static {v4, v5}, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->access$400$1bc0119a(Lcom/glu/platform/android/resdl/GluDownloadResMgr;B)Ljava/lang/String;

    move-result-object v4

    iput-object v4, v3, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_downloadError:Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :goto_2
    iget-object v4, v3, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_downloadError:Ljava/lang/String;

    if-eqz v4, :cond_3

    move v2, v1

    :cond_3
    iput-boolean v2, v3, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_downloadFailed:Z

    iput-boolean v1, v3, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_downloadDone:Z

    invoke-static {}, Lcom/glu/platform/android/resdl/GluUtil;->isAppPaused()Z

    move-result v2

    if-eqz v2, :cond_5

    if-eqz v0, :cond_4

    iget-boolean v2, v3, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_downloadFailed:Z

    if-eqz v2, :cond_5

    :cond_4
    iget-boolean v2, v3, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_downloadFailed:Z

    if-eqz v2, :cond_6

    const-string v2, "===============================================================\n= !!!!!!!!!!!!!!!!!!!!! DOWNLOAD FAILED !!!!!!!!!!!!!!!!!!!!! =\n==============================================================="

    invoke-static {v2}, Lcom/glu/platform/android/resdl/Debug;->log(Ljava/lang/String;)V

    const v2, 0x7f060074

    invoke-static {v2}, Lcom/glu/platform/android/resdl/GluUtil;->getString(I)Ljava/lang/String;

    move-result-object v2

    const v4, 0x7f060072

    invoke-static {v4}, Lcom/glu/platform/android/resdl/GluUtil;->getString(I)Ljava/lang/String;

    move-result-object v4

    invoke-static {v2, v4}, Lcom/glu/platform/android/resdl/GluUtil;->sendNotification$3b99ba1a(Ljava/lang/String;Ljava/lang/String;)V

    :cond_5
    :goto_3
    iget-object v2, p0, Lcom/glu/platform/android/resdl/GluDownloadResMgr$2;->this$0:Lcom/glu/platform/android/resdl/GluDownloadResMgr;

    const/4 v4, 0x0

    iput-object v4, v2, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->m_downloadThread:Ljava/lang/Thread;

    iget-boolean v2, v3, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_downloadFailed:Z

    if-nez v2, :cond_0

    if-eqz v0, :cond_7

    const/4 v0, 0x5

    invoke-virtual {v3, v0}, Lcom/glu/platform/android/resdl/ResFileDownloadView;->newState(I)V

    goto :goto_1

    :catch_0
    move-exception v4

    const v4, 0x7f060046

    invoke-static {v4}, Lcom/glu/platform/android/resdl/GluUtil;->getString(I)Ljava/lang/String;

    move-result-object v4

    iput-object v4, v3, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_downloadError:Ljava/lang/String;

    goto :goto_2

    :cond_6
    const-string v2, "***************************************************************\n********************** DOWNLOAD IS DONE ***********************\n***************************************************************"

    invoke-static {v2}, Lcom/glu/platform/android/resdl/Debug;->log(Ljava/lang/String;)V

    const v2, 0x7f060073

    invoke-static {v2}, Lcom/glu/platform/android/resdl/GluUtil;->getString(I)Ljava/lang/String;

    move-result-object v2

    const v4, 0x7f060071

    invoke-static {v4}, Lcom/glu/platform/android/resdl/GluUtil;->getString(I)Ljava/lang/String;

    move-result-object v4

    invoke-static {v2, v4}, Lcom/glu/platform/android/resdl/GluUtil;->sendNotification$3b99ba1a(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_3

    :cond_7
    sget-object v0, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->instance:Lcom/glu/platform/android/resdl/GluDownloadResMgr;

    invoke-static {}, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->areThereSpecialFiles()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-virtual {v3, v1}, Lcom/glu/platform/android/resdl/ResFileDownloadView;->newState(I)V

    goto :goto_1
.end method
