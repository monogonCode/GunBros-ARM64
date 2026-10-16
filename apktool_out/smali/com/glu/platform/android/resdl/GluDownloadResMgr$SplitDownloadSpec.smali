.class public final Lcom/glu/platform/android/resdl/GluDownloadResMgr$SplitDownloadSpec;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/glu/platform/android/resdl/GluDownloadResMgr;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "SplitDownloadSpec"
.end annotation


# instance fields
.field public checksum:J

.field public downloadLength:I

.field public downloadOffset:I

.field public fullFilename:Ljava/lang/String;

.field private m_checksumDetermined:Z

.field private m_checksumResult:Z


# direct methods
.method public constructor <init>(Ljava/lang/String;JII)V
    .locals 3

    const/4 v2, 0x0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/glu/platform/android/resdl/GluDownloadResMgr$SplitDownloadSpec;->fullFilename:Ljava/lang/String;

    const-wide/16 v0, 0x0

    iput-wide v0, p0, Lcom/glu/platform/android/resdl/GluDownloadResMgr$SplitDownloadSpec;->checksum:J

    iput v2, p0, Lcom/glu/platform/android/resdl/GluDownloadResMgr$SplitDownloadSpec;->downloadOffset:I

    iput v2, p0, Lcom/glu/platform/android/resdl/GluDownloadResMgr$SplitDownloadSpec;->downloadLength:I

    iput-boolean v2, p0, Lcom/glu/platform/android/resdl/GluDownloadResMgr$SplitDownloadSpec;->m_checksumDetermined:Z

    iput-boolean v2, p0, Lcom/glu/platform/android/resdl/GluDownloadResMgr$SplitDownloadSpec;->m_checksumResult:Z

    iput-object p1, p0, Lcom/glu/platform/android/resdl/GluDownloadResMgr$SplitDownloadSpec;->fullFilename:Ljava/lang/String;

    iput-wide p2, p0, Lcom/glu/platform/android/resdl/GluDownloadResMgr$SplitDownloadSpec;->checksum:J

    iput p4, p0, Lcom/glu/platform/android/resdl/GluDownloadResMgr$SplitDownloadSpec;->downloadOffset:I

    iput p5, p0, Lcom/glu/platform/android/resdl/GluDownloadResMgr$SplitDownloadSpec;->downloadLength:I

    return-void
.end method


# virtual methods
.method public final checksumPassed()Z
    .locals 1

    iget-boolean v0, p0, Lcom/glu/platform/android/resdl/GluDownloadResMgr$SplitDownloadSpec;->m_checksumDetermined:Z

    if-eqz v0, :cond_0

    iget-boolean v0, p0, Lcom/glu/platform/android/resdl/GluDownloadResMgr$SplitDownloadSpec;->m_checksumResult:Z

    :goto_0
    return v0

    :cond_0
    invoke-virtual {p0}, Lcom/glu/platform/android/resdl/GluDownloadResMgr$SplitDownloadSpec;->redoChecksum()Z

    move-result v0

    goto :goto_0
.end method

.method public final redoChecksum()Z
    .locals 7

    const/4 v1, 0x1

    const/4 v0, 0x0

    new-instance v2, Ljava/io/File;

    iget-object v3, p0, Lcom/glu/platform/android/resdl/GluDownloadResMgr$SplitDownloadSpec;->fullFilename:Ljava/lang/String;

    invoke-direct {v2, v3}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2}, Ljava/io/File;->exists()Z

    move-result v3

    if-eqz v3, :cond_1

    iget-wide v3, p0, Lcom/glu/platform/android/resdl/GluDownloadResMgr$SplitDownloadSpec;->checksum:J

    iget v5, p0, Lcom/glu/platform/android/resdl/GluDownloadResMgr$SplitDownloadSpec;->downloadLength:I

    int-to-long v5, v5

    invoke-static {v2, v3, v4, v5, v6}, Lcom/glu/platform/android/resdl/GluUtil;->performChecksum(Ljava/io/File;JJ)Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_0

    invoke-virtual {v2}, Ljava/io/File;->length()J

    move-result-wide v2

    iget v4, p0, Lcom/glu/platform/android/resdl/GluDownloadResMgr$SplitDownloadSpec;->downloadLength:I

    int-to-long v4, v4

    cmp-long v2, v2, v4

    if-nez v2, :cond_0

    move v0, v1

    :cond_0
    iput-boolean v0, p0, Lcom/glu/platform/android/resdl/GluDownloadResMgr$SplitDownloadSpec;->m_checksumResult:Z

    :goto_0
    iput-boolean v1, p0, Lcom/glu/platform/android/resdl/GluDownloadResMgr$SplitDownloadSpec;->m_checksumDetermined:Z

    iget-boolean v0, p0, Lcom/glu/platform/android/resdl/GluDownloadResMgr$SplitDownloadSpec;->m_checksumResult:Z

    return v0

    :cond_1
    iput-boolean v0, p0, Lcom/glu/platform/android/resdl/GluDownloadResMgr$SplitDownloadSpec;->m_checksumResult:Z

    goto :goto_0
.end method
