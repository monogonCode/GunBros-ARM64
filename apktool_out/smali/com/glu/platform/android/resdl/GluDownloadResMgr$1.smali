.class final Lcom/glu/platform/android/resdl/GluDownloadResMgr$1;
.super Ljava/lang/Thread;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/glu/platform/android/resdl/GluDownloadResMgr;->downloadSpecialResFile()V
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

    iput-object p1, p0, Lcom/glu/platform/android/resdl/GluDownloadResMgr$1;->this$0:Lcom/glu/platform/android/resdl/GluDownloadResMgr;

    invoke-direct {p0}, Ljava/lang/Thread;-><init>()V

    return-void
.end method


# virtual methods
.method public final run()V
    .locals 10

    const v9, 0x7f060046

    const/4 v2, 0x0

    const/4 v1, 0x1

    sget-object v4, Lcom/glu/platform/android/resdl/ResFileDownloadView;->instance:Lcom/glu/platform/android/resdl/ResFileDownloadView;

    if-nez v4, :cond_0

    :goto_0
    return-void

    :cond_0
    :try_start_0
    iget-object v0, p0, Lcom/glu/platform/android/resdl/GluDownloadResMgr$1;->this$0:Lcom/glu/platform/android/resdl/GluDownloadResMgr;

    invoke-static {v0}, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->access$000(Lcom/glu/platform/android/resdl/GluDownloadResMgr;)Z

    move-result v0

    if-eqz v0, :cond_5

    iget-object v0, p0, Lcom/glu/platform/android/resdl/GluDownloadResMgr$1;->this$0:Lcom/glu/platform/android/resdl/GluDownloadResMgr;

    invoke-static {v0}, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->access$100(Lcom/glu/platform/android/resdl/GluDownloadResMgr;)Ljava/util/Vector;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/Vector;->size()I

    move-result v0

    if-lez v0, :cond_5

    iget-object v0, p0, Lcom/glu/platform/android/resdl/GluDownloadResMgr$1;->this$0:Lcom/glu/platform/android/resdl/GluDownloadResMgr;

    invoke-static {v0}, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->access$100(Lcom/glu/platform/android/resdl/GluDownloadResMgr;)Ljava/util/Vector;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/Vector;->size()I

    move-result v0

    add-int/lit8 v0, v0, -0x1

    move v3, v0

    :goto_1
    if-ltz v3, :cond_1

    iget-object v0, p0, Lcom/glu/platform/android/resdl/GluDownloadResMgr$1;->this$0:Lcom/glu/platform/android/resdl/GluDownloadResMgr;

    invoke-static {v0}, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->access$100(Lcom/glu/platform/android/resdl/GluDownloadResMgr;)Ljava/util/Vector;

    move-result-object v0

    invoke-virtual {v0, v3}, Ljava/util/Vector;->elementAt(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/glu/platform/android/resdl/GluDownloadResMgr$SplitDownloadSpec;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "Downloading a file in part, offset="

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    iget v6, v0, Lcom/glu/platform/android/resdl/GluDownloadResMgr$SplitDownloadSpec;->downloadOffset:I

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, "   length="

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    iget v6, v0, Lcom/glu/platform/android/resdl/GluDownloadResMgr$SplitDownloadSpec;->downloadLength:I

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v5}, Lcom/glu/platform/android/resdl/Debug;->log(Ljava/lang/String;)V

    iget-object v5, p0, Lcom/glu/platform/android/resdl/GluDownloadResMgr$1;->this$0:Lcom/glu/platform/android/resdl/GluDownloadResMgr;

    iget-object v6, v0, Lcom/glu/platform/android/resdl/GluDownloadResMgr$SplitDownloadSpec;->fullFilename:Ljava/lang/String;

    iget v7, v0, Lcom/glu/platform/android/resdl/GluDownloadResMgr$SplitDownloadSpec;->downloadOffset:I

    iget v8, v0, Lcom/glu/platform/android/resdl/GluDownloadResMgr$SplitDownloadSpec;->downloadLength:I

    invoke-static {v5, v6, v7, v8}, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->access$200$5bdf26ba(Lcom/glu/platform/android/resdl/GluDownloadResMgr;Ljava/lang/String;II)Ljava/lang/String;

    move-result-object v5

    iput-object v5, v4, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_downloadError:Ljava/lang/String;

    iget-object v5, v4, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_downloadError:Ljava/lang/String;

    if-nez v5, :cond_1

    iget-object v5, p0, Lcom/glu/platform/android/resdl/GluDownloadResMgr$1;->this$0:Lcom/glu/platform/android/resdl/GluDownloadResMgr;

    iget v6, v0, Lcom/glu/platform/android/resdl/GluDownloadResMgr$SplitDownloadSpec;->downloadLength:I

    invoke-static {v5, v6}, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->access$312(Lcom/glu/platform/android/resdl/GluDownloadResMgr;I)I

    sget-object v5, Lcom/glu/platform/android/resdl/ResFileDownloadView;->instance:Lcom/glu/platform/android/resdl/ResFileDownloadView;

    const/4 v6, 0x0

    iput v6, v5, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_bytesDownloaded:I

    invoke-virtual {v0}, Lcom/glu/platform/android/resdl/GluDownloadResMgr$SplitDownloadSpec;->redoChecksum()Z

    move-result v0

    if-nez v0, :cond_4

    const v0, 0x7f060046

    invoke-static {v0}, Lcom/glu/platform/android/resdl/GluUtil;->getString(I)Ljava/lang/String;

    move-result-object v0

    iput-object v0, v4, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_downloadError:Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :cond_1
    :goto_2
    iget-object v0, v4, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_downloadError:Ljava/lang/String;

    if-eqz v0, :cond_6

    move v0, v1

    :goto_3
    iput-boolean v0, v4, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_downloadFailed:Z

    iget-boolean v0, v4, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_downloadFailed:Z

    if-nez v0, :cond_2

    iget-object v0, p0, Lcom/glu/platform/android/resdl/GluDownloadResMgr$1;->this$0:Lcom/glu/platform/android/resdl/GluDownloadResMgr;

    invoke-static {v0}, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->access$500(Lcom/glu/platform/android/resdl/GluDownloadResMgr;)V

    :cond_2
    iput-boolean v1, v4, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_downloadDone:Z

    invoke-static {}, Lcom/glu/platform/android/resdl/GluUtil;->isAppPaused()Z

    move-result v0

    if-eqz v0, :cond_3

    iget-boolean v0, v4, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_downloadFailed:Z

    if-eqz v0, :cond_7

    const-string v0, "===============================================================\n= !!!!!!!!!!!!!!!!!!!!! DOWNLOAD FAILED !!!!!!!!!!!!!!!!!!!!! =\n==============================================================="

    invoke-static {v0}, Lcom/glu/platform/android/resdl/Debug;->log(Ljava/lang/String;)V

    const v0, 0x7f060074

    invoke-static {v0}, Lcom/glu/platform/android/resdl/GluUtil;->getString(I)Ljava/lang/String;

    move-result-object v0

    const v1, 0x7f060072

    invoke-static {v1}, Lcom/glu/platform/android/resdl/GluUtil;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/glu/platform/android/resdl/GluUtil;->sendNotification$3b99ba1a(Ljava/lang/String;Ljava/lang/String;)V

    :cond_3
    :goto_4
    iget-object v0, p0, Lcom/glu/platform/android/resdl/GluDownloadResMgr$1;->this$0:Lcom/glu/platform/android/resdl/GluDownloadResMgr;

    const/4 v1, 0x0

    iput-object v1, v0, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->m_downloadThread:Ljava/lang/Thread;

    goto/16 :goto_0

    :cond_4
    :try_start_1
    iget-object v0, p0, Lcom/glu/platform/android/resdl/GluDownloadResMgr$1;->this$0:Lcom/glu/platform/android/resdl/GluDownloadResMgr;

    invoke-static {v0}, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->access$100(Lcom/glu/platform/android/resdl/GluDownloadResMgr;)Ljava/util/Vector;

    move-result-object v0

    invoke-virtual {v0, v3}, Ljava/util/Vector;->removeElementAt(I)V

    add-int/lit8 v0, v3, -0x1

    move v3, v0

    goto/16 :goto_1

    :cond_5
    iget-object v0, p0, Lcom/glu/platform/android/resdl/GluDownloadResMgr$1;->this$0:Lcom/glu/platform/android/resdl/GluDownloadResMgr;

    const/4 v3, 0x1

    invoke-static {v0, v3}, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->access$400$1bc0119a(Lcom/glu/platform/android/resdl/GluDownloadResMgr;B)Ljava/lang/String;

    move-result-object v0

    iput-object v0, v4, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_downloadError:Ljava/lang/String;
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_2

    :catch_0
    move-exception v0

    invoke-static {v9}, Lcom/glu/platform/android/resdl/GluUtil;->getString(I)Ljava/lang/String;

    move-result-object v0

    iput-object v0, v4, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_downloadError:Ljava/lang/String;

    goto :goto_2

    :cond_6
    move v0, v2

    goto :goto_3

    :cond_7
    const-string v0, "***************************************************************\n********************** DOWNLOAD IS DONE ***********************\n***************************************************************"

    invoke-static {v0}, Lcom/glu/platform/android/resdl/Debug;->log(Ljava/lang/String;)V

    const v0, 0x7f060073

    invoke-static {v0}, Lcom/glu/platform/android/resdl/GluUtil;->getString(I)Ljava/lang/String;

    move-result-object v0

    const v1, 0x7f060071

    invoke-static {v1}, Lcom/glu/platform/android/resdl/GluUtil;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/glu/platform/android/resdl/GluUtil;->sendNotification$3b99ba1a(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_4
.end method
