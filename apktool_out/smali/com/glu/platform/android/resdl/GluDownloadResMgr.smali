.class public final Lcom/glu/platform/android/resdl/GluDownloadResMgr;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/glu/platform/android/resdl/GluDownloadResMgr$SplitDownloadSpec;
    }
.end annotation


# static fields
.field public static instance:Lcom/glu/platform/android/resdl/GluDownloadResMgr;


# instance fields
.field public m_downloadThread:Ljava/lang/Thread;

.field public m_mainResFileInterrupted:Z

.field public m_prevVerifiedVersion:[B

.field public m_reserved:[B

.field public m_secondaryFilesPassedOnce:Z

.field private m_specialChecksumThread:Ljava/lang/Thread;

.field public m_specialCurrentFilename:Ljava/lang/String;

.field private m_specialFilePartCompletedSoFar:I

.field private m_specialFilePartTotal:I

.field private m_specialFilesBeingChecksummed:Z

.field private m_specialFilesChecksummed:Z

.field private m_splitSpecialDownloads:Ljava/util/Vector;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Vector",
            "<",
            "Lcom/glu/platform/android/resdl/GluDownloadResMgr$SplitDownloadSpec;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 1

    const/4 v0, 0x0

    sput-object v0, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->instance:Lcom/glu/platform/android/resdl/GluDownloadResMgr;

    return-void
.end method

.method public constructor <init>()V
    .locals 6

    const/4 v3, 0x0

    const/4 v1, 0x1

    const/4 v0, 0x0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-boolean v0, p0, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->m_mainResFileInterrupted:Z

    iput-boolean v0, p0, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->m_secondaryFilesPassedOnce:Z

    const/4 v2, 0x4

    new-array v2, v2, [B

    iput-object v2, p0, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->m_prevVerifiedVersion:[B

    const/16 v2, 0xfb

    new-array v2, v2, [B

    iput-object v2, p0, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->m_reserved:[B

    iput-object v3, p0, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->m_downloadThread:Ljava/lang/Thread;

    iput-object v3, p0, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->m_specialCurrentFilename:Ljava/lang/String;

    new-instance v2, Ljava/util/Vector;

    invoke-direct {v2}, Ljava/util/Vector;-><init>()V

    iput-object v2, p0, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->m_splitSpecialDownloads:Ljava/util/Vector;

    iput-boolean v0, p0, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->m_specialFilesChecksummed:Z

    iput-boolean v0, p0, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->m_specialFilesBeingChecksummed:Z

    iput v0, p0, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->m_specialFilePartCompletedSoFar:I

    iput v0, p0, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->m_specialFilePartTotal:I

    iput-object v3, p0, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->m_specialChecksumThread:Ljava/lang/Thread;

    sput-object p0, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->instance:Lcom/glu/platform/android/resdl/GluDownloadResMgr;

    invoke-static {}, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->getDataFile()Ljava/io/File;

    move-result-object v2

    invoke-virtual {v2}, Ljava/io/File;->exists()Z

    move-result v2

    if-eqz v2, :cond_4

    :try_start_0
    invoke-static {}, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->getDataFile()Ljava/io/File;

    move-result-object v2

    invoke-virtual {v2}, Ljava/io/File;->exists()Z

    move-result v3

    if-eqz v3, :cond_5

    invoke-virtual {v2}, Ljava/io/File;->length()J

    move-result-wide v2

    const-wide/16 v4, 0x1

    cmp-long v2, v2, v4

    if-nez v2, :cond_5

    move v3, v1

    :goto_0
    const/4 v2, 0x0

    invoke-direct {p0, v2}, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->initialize(Z)V

    new-instance v4, Ljava/io/FileInputStream;

    invoke-static {}, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->getDataFile()Ljava/io/File;

    move-result-object v2

    invoke-direct {v4, v2}, Ljava/io/FileInputStream;-><init>(Ljava/io/File;)V

    invoke-virtual {v4}, Ljava/io/FileInputStream;->read()I

    move-result v2

    if-ne v2, v1, :cond_3

    move v2, v1

    :goto_1
    iput-boolean v2, p0, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->m_mainResFileInterrupted:Z

    invoke-virtual {v4}, Ljava/io/FileInputStream;->read()I

    move-result v2

    if-ne v2, v1, :cond_0

    move v0, v1

    :cond_0
    iput-boolean v0, p0, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->m_secondaryFilesPassedOnce:Z

    if-nez v3, :cond_1

    iget-object v0, p0, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->m_prevVerifiedVersion:[B

    invoke-virtual {v4, v0}, Ljava/io/FileInputStream;->read([B)I

    iget-object v0, p0, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->m_reserved:[B

    invoke-virtual {v4, v0}, Ljava/io/FileInputStream;->read([B)I

    :cond_1
    invoke-virtual {v4}, Ljava/io/FileInputStream;->close()V

    const-string v0, "Read resource download data file."

    invoke-static {v0}, Lcom/glu/platform/android/resdl/Debug;->log(Ljava/lang/String;)V

    if-eqz v3, :cond_2

    const-string v0, "Updating old template dlstatus.dat"

    invoke-static {v0}, Lcom/glu/platform/android/resdl/Debug;->log(Ljava/lang/String;)V

    invoke-virtual {p0}, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->saveFile()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :cond_2
    :goto_2
    return-void

    :cond_3
    move v2, v0

    goto :goto_1

    :catch_0
    move-exception v0

    const-string v2, "Error reading resource download data file. Will initialize."

    invoke-static {v2, v0}, Lcom/glu/platform/android/resdl/Debug;->log(Ljava/lang/String;Ljava/lang/Throwable;)V

    invoke-direct {p0, v1}, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->initialize(Z)V

    goto :goto_2

    :cond_4
    invoke-direct {p0, v1}, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->initialize(Z)V

    goto :goto_2

    :cond_5
    move v3, v0

    goto :goto_0
.end method

.method static synthetic access$000(Lcom/glu/platform/android/resdl/GluDownloadResMgr;)Z
    .locals 1

    iget-boolean v0, p0, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->m_specialFilesChecksummed:Z

    return v0
.end method

.method static synthetic access$100(Lcom/glu/platform/android/resdl/GluDownloadResMgr;)Ljava/util/Vector;
    .locals 1

    iget-object v0, p0, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->m_splitSpecialDownloads:Ljava/util/Vector;

    return-object v0
.end method

.method static synthetic access$200$5bdf26ba(Lcom/glu/platform/android/resdl/GluDownloadResMgr;Ljava/lang/String;II)Ljava/lang/String;
    .locals 1

    const/4 v0, 0x2

    invoke-direct {p0, v0, p1, p2, p3}, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->downloadFile$5e52f91b(BLjava/lang/String;II)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method static synthetic access$312(Lcom/glu/platform/android/resdl/GluDownloadResMgr;I)I
    .locals 1

    iget v0, p0, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->m_specialFilePartCompletedSoFar:I

    add-int/2addr v0, p1

    iput v0, p0, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->m_specialFilePartCompletedSoFar:I

    return v0
.end method

.method static synthetic access$400$1bc0119a(Lcom/glu/platform/android/resdl/GluDownloadResMgr;B)Ljava/lang/String;
    .locals 2

    const/4 v1, -0x1

    const/4 v0, 0x0

    invoke-direct {p0, p1, v0, v1, v1}, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->downloadFile$5e52f91b(BLjava/lang/String;II)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method static synthetic access$500(Lcom/glu/platform/android/resdl/GluDownloadResMgr;)V
    .locals 2

    const/4 v1, 0x0

    iget-object v0, p0, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->m_splitSpecialDownloads:Ljava/util/Vector;

    invoke-virtual {v0}, Ljava/util/Vector;->removeAllElements()V

    iput-boolean v1, p0, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->m_specialFilesChecksummed:Z

    iput-boolean v1, p0, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->m_specialFilesBeingChecksummed:Z

    iput v1, p0, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->m_specialFilePartTotal:I

    iput v1, p0, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->m_specialFilePartCompletedSoFar:I

    return-void
.end method

.method static synthetic access$600(Lcom/glu/platform/android/resdl/GluDownloadResMgr;)V
    .locals 9

    const/4 v7, 0x0

    invoke-static {}, Lcom/glu/platform/android/resdl/GluUtil;->findResourceFile()Ljava/io/File;

    move-result-object v0

    if-eqz v0, :cond_3

    invoke-virtual {v0}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/glu/platform/android/resdl/GluUtil;->getFileDirectoryWithEnder(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v8

    move v6, v7

    move v4, v7

    :goto_0
    sget-object v0, Lcom/glu/platform/android/resdl/GameLet;->SPECIAL_RES_FILENAME_ARRAY:[Ljava/lang/String;

    array-length v0, v0

    if-ge v6, v0, :cond_0

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-object v1, Lcom/glu/platform/android/resdl/GameLet;->SPECIAL_RES_FILENAME_ARRAY:[Ljava/lang/String;

    aget-object v1, v1, v6

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    new-instance v0, Lcom/glu/platform/android/resdl/GluDownloadResMgr$SplitDownloadSpec;

    sget-object v2, Lcom/glu/platform/android/resdl/GameLet;->SPECIAL_RES_CHECKSUM_ARRAY:[J

    aget-wide v2, v2, v6

    sget-object v5, Lcom/glu/platform/android/resdl/GameLet;->SPECIAL_RES_FILESIZE_ARRAY:[I

    aget v5, v5, v6

    invoke-direct/range {v0 .. v5}, Lcom/glu/platform/android/resdl/GluDownloadResMgr$SplitDownloadSpec;-><init>(Ljava/lang/String;JII)V

    iget-object v1, p0, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->m_splitSpecialDownloads:Ljava/util/Vector;

    invoke-virtual {v1, v0}, Ljava/util/Vector;->addElement(Ljava/lang/Object;)V

    sget-object v0, Lcom/glu/platform/android/resdl/GameLet;->SPECIAL_RES_FILESIZE_ARRAY:[I

    aget v0, v0, v6

    add-int/2addr v4, v0

    add-int/lit8 v0, v6, 0x1

    move v6, v0

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->m_splitSpecialDownloads:Ljava/util/Vector;

    invoke-virtual {v0}, Ljava/util/Vector;->size()I

    move-result v0

    add-int/lit8 v0, v0, -0x1

    move v1, v0

    :goto_1
    if-ltz v1, :cond_4

    iget-object v0, p0, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->m_splitSpecialDownloads:Ljava/util/Vector;

    invoke-virtual {v0, v1}, Ljava/util/Vector;->elementAt(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/glu/platform/android/resdl/GluDownloadResMgr$SplitDownloadSpec;

    invoke-virtual {v0}, Lcom/glu/platform/android/resdl/GluDownloadResMgr$SplitDownloadSpec;->checksumPassed()Z

    move-result v0

    if-nez v0, :cond_2

    new-instance v2, Ljava/io/File;

    iget-object v0, p0, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->m_splitSpecialDownloads:Ljava/util/Vector;

    invoke-virtual {v0, v1}, Ljava/util/Vector;->elementAt(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/glu/platform/android/resdl/GluDownloadResMgr$SplitDownloadSpec;

    iget-object v0, v0, Lcom/glu/platform/android/resdl/GluDownloadResMgr$SplitDownloadSpec;->fullFilename:Ljava/lang/String;

    invoke-direct {v2, v0}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2}, Ljava/io/File;->exists()Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-virtual {v2}, Ljava/io/File;->delete()Z

    :cond_1
    iget v2, p0, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->m_specialFilePartTotal:I

    iget-object v0, p0, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->m_splitSpecialDownloads:Ljava/util/Vector;

    invoke-virtual {v0, v1}, Ljava/util/Vector;->elementAt(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/glu/platform/android/resdl/GluDownloadResMgr$SplitDownloadSpec;

    iget v0, v0, Lcom/glu/platform/android/resdl/GluDownloadResMgr$SplitDownloadSpec;->downloadLength:I

    add-int/2addr v0, v2

    iput v0, p0, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->m_specialFilePartTotal:I

    :goto_2
    add-int/lit8 v0, v1, -0x1

    move v1, v0

    goto :goto_1

    :cond_2
    iget-object v0, p0, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->m_splitSpecialDownloads:Ljava/util/Vector;

    invoke-virtual {v0, v1}, Ljava/util/Vector;->removeElementAt(I)V

    goto :goto_2

    :cond_3
    const-string v0, "Res file can\'t be null at this point. Fix it."

    invoke-static {v0}, Lcom/glu/platform/android/resdl/Debug;->devDie(Ljava/lang/String;)V

    :cond_4
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->m_specialFilesChecksummed:Z

    iput-boolean v7, p0, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->m_specialFilesBeingChecksummed:Z

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->m_specialChecksumThread:Ljava/lang/Thread;

    return-void
.end method

.method public static areSpecialFilesSequential()Z
    .locals 9

    const/4 v3, 0x1

    const/4 v1, 0x0

    sget-object v0, Lcom/glu/platform/android/resdl/GameLet;->SPECIAL_RES_FILENAME_ARRAY:[Ljava/lang/String;

    if-nez v0, :cond_1

    :cond_0
    :goto_0
    return v1

    :cond_1
    invoke-static {}, Lcom/glu/platform/android/resdl/GluUtil;->findResourceFile()Ljava/io/File;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/glu/platform/android/resdl/GluUtil;->getFileDirectoryWithEnder(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    move v0, v1

    move v2, v3

    :goto_1
    sget-object v5, Lcom/glu/platform/android/resdl/GameLet;->SPECIAL_RES_FILENAME_ARRAY:[Ljava/lang/String;

    array-length v5, v5

    if-ge v0, v5, :cond_4

    new-instance v5, Ljava/io/File;

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v6, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    sget-object v7, Lcom/glu/platform/android/resdl/GameLet;->SPECIAL_RES_FILENAME_ARRAY:[Ljava/lang/String;

    aget-object v7, v7, v0

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-direct {v5, v6}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v5}, Ljava/io/File;->exists()Z

    move-result v6

    if-eqz v6, :cond_2

    if-eqz v2, :cond_0

    invoke-virtual {v5}, Ljava/io/File;->length()J

    move-result-wide v5

    sget-object v7, Lcom/glu/platform/android/resdl/GameLet;->SPECIAL_RES_FILESIZE_ARRAY:[I

    aget v7, v7, v0

    int-to-long v7, v7

    cmp-long v5, v5, v7

    if-eqz v5, :cond_3

    :cond_2
    move v2, v1

    :cond_3
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    :cond_4
    move v1, v3

    goto :goto_0
.end method

.method public static areThereSpecialFiles()Z
    .locals 1

    sget-object v0, Lcom/glu/platform/android/resdl/GameLet;->SPECIAL_RES_FILENAME_ARRAY:[Ljava/lang/String;

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public static createDummyPrimaryResource(Ljava/lang/String;)V
    .locals 3

    :try_start_0
    new-instance v0, Ljava/io/File;

    invoke-direct {v0, p0}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    new-instance v1, Ljava/io/FileOutputStream;

    const/4 v2, 0x0

    invoke-direct {v1, v0, v2}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;Z)V

    const/4 v0, 0x0

    invoke-virtual {v1, v0}, Ljava/io/FileOutputStream;->write(I)V

    invoke-virtual {v1}, Ljava/io/FileOutputStream;->close()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return-void

    :catch_0
    move-exception v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Cannot create a 1 byte file. That\'s not good. Filename="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1, v0}, Lcom/glu/platform/android/resdl/Debug;->log(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto :goto_0
.end method

.method public static deleteSpecialFiles()V
    .locals 5

    sget-object v0, Lcom/glu/platform/android/resdl/GameLet;->SPECIAL_RES_FILENAME_ARRAY:[Ljava/lang/String;

    if-nez v0, :cond_1

    :cond_0
    return-void

    :cond_1
    invoke-static {}, Lcom/glu/platform/android/resdl/GluUtil;->findResourceFile()Ljava/io/File;

    move-result-object v1

    if-eqz v1, :cond_0

    :try_start_0
    new-instance v0, Ljava/lang/Exception;

    invoke-direct {v0}, Ljava/lang/Exception;-><init>()V

    throw v0
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    move-exception v0

    const-string v2, "Deleting special resource files."

    invoke-static {v2, v0}, Lcom/glu/platform/android/resdl/Debug;->log(Ljava/lang/String;Ljava/lang/Throwable;)V

    invoke-virtual {v1}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/glu/platform/android/resdl/GluUtil;->getFileDirectoryWithEnder(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    const/4 v0, 0x0

    :goto_0
    sget-object v2, Lcom/glu/platform/android/resdl/GameLet;->SPECIAL_RES_FILENAME_ARRAY:[Ljava/lang/String;

    array-length v2, v2

    if-ge v0, v2, :cond_0

    new-instance v2, Ljava/io/File;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    sget-object v4, Lcom/glu/platform/android/resdl/GameLet;->SPECIAL_RES_FILENAME_ARRAY:[Ljava/lang/String;

    aget-object v4, v4, v0

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-direct {v2, v3}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2}, Ljava/io/File;->exists()Z

    move-result v3

    if-eqz v3, :cond_2

    invoke-virtual {v2}, Ljava/io/File;->delete()Z

    :cond_2
    add-int/lit8 v0, v0, 0x1

    goto :goto_0
.end method

.method private downloadFile$5e52f91b(BLjava/lang/String;II)Ljava/lang/String;
    .locals 26

    if-nez p1, :cond_0

    const/4 v2, 0x1

    move v3, v2

    :goto_0
    const/4 v4, 0x0

    sget-object v20, Lcom/glu/platform/android/resdl/ResFileDownloadView;->instance:Lcom/glu/platform/android/resdl/ResFileDownloadView;

    if-nez v20, :cond_1

    const-string v2, "app done"

    :goto_1
    return-object v2

    :cond_0
    const/4 v2, 0x0

    move v3, v2

    goto :goto_0

    :cond_1
    const/4 v2, 0x1

    move/from16 v0, p1

    if-ne v0, v2, :cond_b

    const/4 v2, 0x3

    new-array v6, v2, [I

    invoke-static {v6}, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->getSpecialStartPosition([I)V

    const/4 v2, 0x0

    aget v2, v6, v2

    move-object/from16 v0, v20

    iput v2, v0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_bytesDownloaded:I

    sget-object v2, Lcom/glu/platform/android/resdl/GameLet$instance;->m_nativeProperties:Ljava/util/Hashtable;

    sget-object v4, Lcom/glu/platform/android/resdl/GameLet;->KEY_SPECIAL_FILE_URL:Ljava/lang/String;

    invoke-virtual {v2, v4}, Ljava/util/Hashtable;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    move-object/from16 v0, v20

    iget v7, v0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_bytesDownloaded:I

    const/4 v5, 0x0

    const/4 v4, 0x0

    :goto_2
    sget-object v8, Lcom/glu/platform/android/resdl/GameLet;->SPECIAL_RES_FILENAME_ARRAY:[Ljava/lang/String;

    array-length v8, v8

    if-ge v4, v8, :cond_a

    sget-object v8, Lcom/glu/platform/android/resdl/GameLet;->SPECIAL_RES_FILESIZE_ARRAY:[I

    aget v8, v8, v4

    add-int/2addr v5, v8

    if-le v5, v7, :cond_9

    sget-object v5, Lcom/glu/platform/android/resdl/GameLet;->SPECIAL_RES_FILENAME_ARRAY:[Ljava/lang/String;

    aget-object v4, v5, v4

    :goto_3
    invoke-static {v4}, Lcom/glu/platform/android/resdl/GluUtil;->getRelativeFilename(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    move-object/from16 v0, p0

    iput-object v5, v0, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->m_specialCurrentFilename:Ljava/lang/String;

    invoke-static {v4}, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->getSecondaryFile(Ljava/lang/String;)Ljava/io/File;

    move-result-object v4

    move-object v5, v2

    move-object v2, v6

    :goto_4
    new-instance v21, Ljava/io/File;

    move-object/from16 v0, v20

    iget-object v6, v0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_tempFilename:Ljava/lang/String;

    move-object/from16 v0, v21

    invoke-direct {v0, v6}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "Downloading "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    if-nez p1, :cond_d

    const-string v6, "main"

    :goto_5
    invoke-virtual {v7, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, " file from URL: "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v6}, Lcom/glu/platform/android/resdl/Debug;->log(Ljava/lang/String;)V

    const/4 v7, 0x0

    const/4 v10, 0x0

    const/4 v9, 0x0

    const/4 v8, -0x1

    const/4 v12, 0x0

    const/4 v11, 0x0

    move-object/from16 v0, v20

    iget v6, v0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_bytesDownloaded:I

    if-nez v6, :cond_11

    const/4 v6, 0x0

    :goto_6
    move-object/from16 v0, v20

    iget v13, v0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_bytesDownloaded:I

    const/4 v14, 0x1

    move/from16 v0, p1

    if-ne v0, v14, :cond_13

    invoke-virtual {v4}, Ljava/io/File;->exists()Z

    move-result v6

    if-eqz v6, :cond_12

    invoke-virtual {v4}, Ljava/io/File;->length()J

    move-result-wide v14

    const-wide/16 v16, 0x0

    cmp-long v6, v14, v16

    if-lez v6, :cond_12

    const/4 v6, 0x1

    :goto_7
    move/from16 v19, v6

    :goto_8
    :try_start_0
    invoke-virtual {v4}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v6

    invoke-static {v6}, Lcom/glu/platform/android/resdl/Debug;->log(Ljava/lang/String;)V

    new-instance v15, Landroid/os/StatFs;

    invoke-virtual {v4}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v6

    const-string v14, "/sdcard/"

    invoke-virtual {v6, v14}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v6

    const/4 v14, -0x1

    if-ne v6, v14, :cond_14

    invoke-static {}, Landroid/os/Environment;->getDataDirectory()Ljava/io/File;

    move-result-object v6

    invoke-virtual {v6}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v6

    :goto_9
    invoke-direct {v15, v6}, Landroid/os/StatFs;-><init>(Ljava/lang/String;)V

    const-string v6, "root FS"

    new-instance v14, Landroid/os/StatFs;

    invoke-static {}, Landroid/os/Environment;->getDataDirectory()Ljava/io/File;

    move-result-object v16

    invoke-virtual/range {v16 .. v16}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v16

    move-object/from16 v0, v16

    invoke-direct {v14, v0}, Landroid/os/StatFs;-><init>(Ljava/lang/String;)V

    invoke-static {v6, v14}, Lcom/glu/platform/android/resdl/Debug;->printStatFs(Ljava/lang/String;Landroid/os/StatFs;)V

    const-string v6, "sdcard FS"

    new-instance v14, Landroid/os/StatFs;

    const-string v16, "/sdcard/"

    move-object/from16 v0, v16

    invoke-direct {v14, v0}, Landroid/os/StatFs;-><init>(Ljava/lang/String;)V

    invoke-static {v6, v14}, Lcom/glu/platform/android/resdl/Debug;->printStatFs(Ljava/lang/String;Landroid/os/StatFs;)V

    const-string v6, "target FS"

    invoke-static {v6, v15}, Lcom/glu/platform/android/resdl/Debug;->printStatFs(Ljava/lang/String;Landroid/os/StatFs;)V

    const/16 v6, 0xffc

    new-array v0, v6, [B

    move-object/from16 v22, v0

    const/4 v14, 0x0

    invoke-virtual {v15}, Landroid/os/StatFs;->getBlockCount()I

    move-result v6

    if-nez v6, :cond_15

    const-wide/16 v15, -0x1

    move-wide/from16 v17, v15

    :goto_a
    sget-wide v15, Lcom/glu/platform/android/resdl/GameLet;->RES_FILE_SIZE_TO_USE:J

    int-to-long v0, v13

    move-wide/from16 v23, v0

    sub-long v15, v15, v23

    const/4 v6, 0x1

    move/from16 v0, p1

    if-ne v0, v6, :cond_16

    invoke-static {}, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->getSpecialFileSize()I

    move-result v6

    sub-int/2addr v6, v13

    int-to-long v15, v6

    :cond_2
    :goto_b
    const-wide/16 v23, -0x1

    cmp-long v6, v17, v23

    if-eqz v6, :cond_17

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v14, "Space available: "

    invoke-virtual {v6, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    move-wide/from16 v0, v17

    invoke-virtual {v6, v0, v1}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v6}, Lcom/glu/platform/android/resdl/Debug;->log(Ljava/lang/String;)V

    cmp-long v6, v15, v17

    if-lez v6, :cond_1b

    const-string v2, "Insufficient storage. bailing..."

    invoke-static {v2}, Lcom/glu/platform/android/resdl/Debug;->log(Ljava/lang/String;)V

    const v2, 0x7f06004b

    invoke-static {v2}, Lcom/glu/platform/android/resdl/GluUtil;->getString(I)Ljava/lang/String;

    move-result-object v2

    const/4 v3, 0x2

    new-array v3, v3, [Ljava/lang/Object;

    const/4 v5, 0x0

    invoke-static/range {v15 .. v16}, Lcom/glu/platform/android/resdl/GluUtil;->getBytesStringNice(J)Ljava/lang/String;

    move-result-object v6

    aput-object v6, v3, v5

    const/4 v5, 0x1

    invoke-static/range {v17 .. v18}, Lcom/glu/platform/android/resdl/GluUtil;->getBytesStringNice(J)Ljava/lang/String;

    move-result-object v6

    aput-object v6, v3, v5

    invoke-static {v2, v3}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;
    :try_end_0
    .catch Ljava/net/ProtocolException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_11
    .catch Ljava/lang/ArrayIndexOutOfBoundsException; {:try_start_0 .. :try_end_0} :catch_a
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_b
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result-object v10

    :try_start_1
    new-instance v2, Ljava/lang/Exception;

    invoke-direct {v2}, Ljava/lang/Exception;-><init>()V

    throw v2
    :try_end_1
    .catch Ljava/net/ProtocolException; {:try_start_1 .. :try_end_1} :catch_0
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_11
    .catch Ljava/lang/ArrayIndexOutOfBoundsException; {:try_start_1 .. :try_end_1} :catch_2a
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_b
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    :catch_0
    move-exception v2

    move-object v5, v11

    move-object v3, v4

    move-object v4, v12

    :goto_c
    :try_start_2
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "Connection failed, error: "

    invoke-virtual {v6, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v8}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v8, "  "

    invoke-virtual {v6, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v6, v2}, Lcom/glu/platform/android/resdl/Debug;->log(Ljava/lang/String;Ljava/lang/Throwable;)V

    const v2, 0x7f060048

    invoke-static {v2}, Lcom/glu/platform/android/resdl/GluUtil;->getString(I)Ljava/lang/String;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_7

    move-result-object v2

    if-eqz v5, :cond_3

    :try_start_3
    invoke-virtual {v5}, Ljava/io/FileOutputStream;->close()V
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_16

    :cond_3
    :goto_d
    if-eqz v4, :cond_4

    :try_start_4
    invoke-virtual {v4}, Ljava/io/InputStream;->close()V
    :try_end_4
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_17

    :cond_4
    :goto_e
    if-eqz v9, :cond_5

    :try_start_5
    invoke-virtual {v9}, Ljava/net/HttpURLConnection;->disconnect()V
    :try_end_5
    .catch Ljava/lang/Exception; {:try_start_5 .. :try_end_5} :catch_18

    :cond_5
    :goto_f
    invoke-virtual {v3}, Ljava/io/File;->exists()Z

    move-result v4

    if-eqz v4, :cond_45

    invoke-virtual {v3}, Ljava/io/File;->length()J

    move-result-wide v4

    const-wide/16 v8, 0x0

    cmp-long v4, v4, v8

    if-nez v4, :cond_3f

    invoke-virtual {v3}, Ljava/io/File;->delete()Z

    move v4, v7

    :goto_10
    move-object/from16 v0, v20

    iget v5, v0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_bytesDownloaded:I

    if-nez v5, :cond_7

    if-eqz p1, :cond_6

    const/4 v5, 0x1

    move/from16 v0, p1

    if-eq v0, v5, :cond_6

    const/4 v5, 0x2

    move/from16 v0, p1

    if-ne v0, v5, :cond_7

    :cond_6
    const/4 v4, 0x0

    invoke-virtual {v3}, Ljava/io/File;->exists()Z

    move-result v5

    if-eqz v5, :cond_7

    invoke-virtual {v3}, Ljava/io/File;->delete()Z

    :cond_7
    invoke-virtual {v3}, Ljava/io/File;->exists()Z

    move-result v3

    if-nez v3, :cond_44

    if-nez v2, :cond_44

    const-string v2, "unknown download error... file doesn\'t exist"

    invoke-static {v2}, Lcom/glu/platform/android/resdl/Debug;->log(Ljava/lang/String;)V

    const v2, 0x7f06004e

    invoke-static {v2}, Lcom/glu/platform/android/resdl/GluUtil;->getString(I)Ljava/lang/String;

    move-result-object v2

    move-object v5, v2

    :goto_11
    if-nez v5, :cond_41

    if-nez p1, :cond_40

    move-object/from16 v2, p0

    :goto_12
    const/4 v3, 0x0

    move/from16 v25, v3

    move-object v3, v2

    move/from16 v2, v25

    :goto_13
    iput-boolean v2, v3, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->m_mainResFileInterrupted:Z

    invoke-virtual/range {p0 .. p0}, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->saveFile()V

    :cond_8
    move-object v2, v5

    goto/16 :goto_1

    :cond_9
    add-int/lit8 v4, v4, 0x1

    goto/16 :goto_2

    :cond_a
    sget-object v4, Lcom/glu/platform/android/resdl/GameLet;->SPECIAL_RES_FILENAME_ARRAY:[Ljava/lang/String;

    sget-object v5, Lcom/glu/platform/android/resdl/GameLet;->SPECIAL_RES_FILENAME_ARRAY:[Ljava/lang/String;

    array-length v5, v5

    add-int/lit8 v5, v5, -0x1

    aget-object v4, v4, v5

    goto/16 :goto_3

    :cond_b
    const/4 v2, 0x2

    move/from16 v0, p1

    if-ne v0, v2, :cond_c

    sget-object v2, Lcom/glu/platform/android/resdl/GameLet$instance;->m_nativeProperties:Ljava/util/Hashtable;

    sget-object v5, Lcom/glu/platform/android/resdl/GameLet;->KEY_SPECIAL_FILE_URL:Ljava/lang/String;

    invoke-virtual {v2, v5}, Ljava/util/Hashtable;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    invoke-static/range {p2 .. p2}, Lcom/glu/platform/android/resdl/GluUtil;->getRelativeFilename(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    move-object/from16 v0, p0

    iput-object v5, v0, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->m_specialCurrentFilename:Ljava/lang/String;

    new-instance v5, Ljava/io/File;

    move-object/from16 v0, p2

    invoke-direct {v5, v0}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    sget-object v6, Lcom/glu/platform/android/resdl/ResFileDownloadView;->instance:Lcom/glu/platform/android/resdl/ResFileDownloadView;

    const/4 v7, 0x0

    iput v7, v6, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_bytesDownloaded:I

    move-object/from16 v25, v4

    move-object v4, v5

    move-object v5, v2

    move-object/from16 v2, v25

    goto/16 :goto_4

    :cond_c
    sget-object v2, Lcom/glu/platform/android/resdl/GameLet$instance;->m_nativeProperties:Ljava/util/Hashtable;

    sget-object v5, Lcom/glu/platform/android/resdl/GameLet;->RES_FILE_URL_KEY_TO_USE:Ljava/lang/String;

    invoke-virtual {v2, v5}, Ljava/util/Hashtable;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    move-object/from16 v0, v20

    iget-object v6, v0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_downloadFilename:Ljava/lang/String;

    new-instance v5, Ljava/io/File;

    invoke-direct {v5, v6}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    move-object/from16 v25, v4

    move-object v4, v5

    move-object v5, v2

    move-object/from16 v2, v25

    goto/16 :goto_4

    :cond_d
    const/4 v6, 0x1

    move/from16 v0, p1

    if-ne v0, v6, :cond_e

    const-string v6, "special"

    goto/16 :goto_5

    :cond_e
    const/4 v6, 0x2

    move/from16 v0, p1

    if-ne v0, v6, :cond_f

    const-string v6, "special_part"

    goto/16 :goto_5

    :cond_f
    const/4 v6, 0x3

    move/from16 v0, p1

    if-ne v0, v6, :cond_10

    const-string v6, "DLC"

    goto/16 :goto_5

    :cond_10
    const-string v6, "unknown"

    goto/16 :goto_5

    :cond_11
    const/4 v6, 0x1

    goto/16 :goto_6

    :cond_12
    const/4 v6, 0x0

    goto/16 :goto_7

    :cond_13
    const/4 v14, 0x2

    move/from16 v0, p1

    if-ne v0, v14, :cond_49

    const/4 v6, 0x0

    move/from16 v19, v6

    goto/16 :goto_8

    :cond_14
    :try_start_6
    const-string v6, "/sdcard/"

    goto/16 :goto_9

    :cond_15
    invoke-virtual {v15}, Landroid/os/StatFs;->getBlockSize()I

    move-result v6

    int-to-long v0, v6

    move-wide/from16 v16, v0

    invoke-virtual {v15}, Landroid/os/StatFs;->getAvailableBlocks()I

    move-result v6

    int-to-long v0, v6

    move-wide/from16 v23, v0

    mul-long v15, v16, v23

    move-wide/from16 v17, v15

    goto/16 :goto_a

    :cond_16
    const/4 v6, 0x2

    move/from16 v0, p1

    if-ne v0, v6, :cond_2

    move/from16 v0, p4

    int-to-long v15, v0

    goto/16 :goto_b

    :cond_17
    const-string v6, "Could not determine space available. Doing it the old fashioned way."

    invoke-static {v6}, Lcom/glu/platform/android/resdl/Debug;->log(Ljava/lang/String;)V

    new-instance v6, Ljava/io/FileOutputStream;

    const/16 v17, 0x0

    move-object/from16 v0, v21

    move/from16 v1, v17

    invoke-direct {v6, v0, v1}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;Z)V
    :try_end_6
    .catch Ljava/net/ProtocolException; {:try_start_6 .. :try_end_6} :catch_0
    .catch Ljava/io/IOException; {:try_start_6 .. :try_end_6} :catch_11
    .catch Ljava/lang/ArrayIndexOutOfBoundsException; {:try_start_6 .. :try_end_6} :catch_a
    .catch Ljava/lang/Exception; {:try_start_6 .. :try_end_6} :catch_b
    .catchall {:try_start_6 .. :try_end_6} :catchall_0

    :try_start_7
    invoke-virtual/range {v21 .. v21}, Ljava/io/File;->delete()Z

    invoke-virtual/range {v21 .. v21}, Ljava/io/File;->createNewFile()Z

    move v11, v14

    :goto_14
    int-to-long v0, v11

    move-wide/from16 v17, v0

    cmp-long v14, v17, v15

    if-gez v14, :cond_19

    move-object/from16 v0, v20

    iget-boolean v14, v0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_downloadCancelled:Z
    :try_end_7
    .catch Ljava/net/ProtocolException; {:try_start_7 .. :try_end_7} :catch_3b
    .catch Ljava/io/IOException; {:try_start_7 .. :try_end_7} :catch_35
    .catch Ljava/lang/ArrayIndexOutOfBoundsException; {:try_start_7 .. :try_end_7} :catch_2b
    .catch Ljava/lang/Exception; {:try_start_7 .. :try_end_7} :catch_22
    .catchall {:try_start_7 .. :try_end_7} :catchall_1

    if-nez v14, :cond_19

    const/4 v14, 0x0

    const/16 v17, 0xffc

    :try_start_8
    move-object/from16 v0, v22

    move/from16 v1, v17

    invoke-virtual {v6, v0, v14, v1}, Ljava/io/FileOutputStream;->write([BII)V
    :try_end_8
    .catch Ljava/io/IOException; {:try_start_8 .. :try_end_8} :catch_1
    .catch Ljava/net/ProtocolException; {:try_start_8 .. :try_end_8} :catch_3b
    .catch Ljava/lang/ArrayIndexOutOfBoundsException; {:try_start_8 .. :try_end_8} :catch_2b
    .catch Ljava/lang/Exception; {:try_start_8 .. :try_end_8} :catch_22
    .catchall {:try_start_8 .. :try_end_8} :catchall_1

    add-int/lit16 v11, v11, 0xffc

    goto :goto_14

    :catch_1
    move-exception v2

    :try_start_9
    const-string v2, "Could not create temp file. Insufficient storage. bailing..."

    invoke-static {v2}, Lcom/glu/platform/android/resdl/Debug;->log(Ljava/lang/String;)V

    const v2, 0x7f06004a

    invoke-static {v2}, Lcom/glu/platform/android/resdl/GluUtil;->getString(I)Ljava/lang/String;

    move-result-object v2

    const/4 v3, 0x1

    new-array v3, v3, [Ljava/lang/Object;

    const/4 v5, 0x0

    invoke-static/range {v15 .. v16}, Lcom/glu/platform/android/resdl/GluUtil;->getBytesStringNice(J)Ljava/lang/String;

    move-result-object v11

    aput-object v11, v3, v5

    invoke-static {v2, v3}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;
    :try_end_9
    .catch Ljava/net/ProtocolException; {:try_start_9 .. :try_end_9} :catch_3b
    .catch Ljava/io/IOException; {:try_start_9 .. :try_end_9} :catch_35
    .catch Ljava/lang/ArrayIndexOutOfBoundsException; {:try_start_9 .. :try_end_9} :catch_2b
    .catch Ljava/lang/Exception; {:try_start_9 .. :try_end_9} :catch_22
    .catchall {:try_start_9 .. :try_end_9} :catchall_1

    move-result-object v10

    :try_start_a
    invoke-virtual {v6}, Ljava/io/FileOutputStream;->close()V
    :try_end_a
    .catch Ljava/lang/Exception; {:try_start_a .. :try_end_a} :catch_3
    .catch Ljava/net/ProtocolException; {:try_start_a .. :try_end_a} :catch_3b
    .catch Ljava/io/IOException; {:try_start_a .. :try_end_a} :catch_35
    .catch Ljava/lang/ArrayIndexOutOfBoundsException; {:try_start_a .. :try_end_a} :catch_2c
    .catchall {:try_start_a .. :try_end_a} :catchall_1

    const/4 v5, 0x0

    :goto_15
    :try_start_b
    invoke-virtual/range {v21 .. v21}, Ljava/io/File;->exists()Z

    move-result v2

    if-eqz v2, :cond_18

    invoke-virtual/range {v21 .. v21}, Ljava/io/File;->delete()Z
    :try_end_b
    .catch Ljava/lang/Exception; {:try_start_b .. :try_end_b} :catch_42
    .catch Ljava/net/ProtocolException; {:try_start_b .. :try_end_b} :catch_2
    .catch Ljava/io/IOException; {:try_start_b .. :try_end_b} :catch_36
    .catch Ljava/lang/ArrayIndexOutOfBoundsException; {:try_start_b .. :try_end_b} :catch_2d
    .catchall {:try_start_b .. :try_end_b} :catchall_2

    :cond_18
    :goto_16
    :try_start_c
    new-instance v2, Ljava/lang/Exception;

    invoke-direct {v2}, Ljava/lang/Exception;-><init>()V

    throw v2
    :try_end_c
    .catch Ljava/net/ProtocolException; {:try_start_c .. :try_end_c} :catch_2
    .catch Ljava/io/IOException; {:try_start_c .. :try_end_c} :catch_36
    .catch Ljava/lang/ArrayIndexOutOfBoundsException; {:try_start_c .. :try_end_c} :catch_2d
    .catch Ljava/lang/Exception; {:try_start_c .. :try_end_c} :catch_23
    .catchall {:try_start_c .. :try_end_c} :catchall_2

    :catch_2
    move-exception v2

    move-object v3, v4

    move-object v4, v12

    goto/16 :goto_c

    :catch_3
    move-exception v2

    move-object v5, v6

    goto :goto_15

    :cond_19
    :try_start_d
    invoke-virtual {v6}, Ljava/io/FileOutputStream;->close()V
    :try_end_d
    .catch Ljava/lang/Exception; {:try_start_d .. :try_end_d} :catch_14
    .catch Ljava/net/ProtocolException; {:try_start_d .. :try_end_d} :catch_3b
    .catch Ljava/io/IOException; {:try_start_d .. :try_end_d} :catch_35
    .catch Ljava/lang/ArrayIndexOutOfBoundsException; {:try_start_d .. :try_end_d} :catch_2b
    .catchall {:try_start_d .. :try_end_d} :catchall_1

    const/4 v6, 0x0

    :goto_17
    :try_start_e
    invoke-virtual/range {v21 .. v21}, Ljava/io/File;->exists()Z

    move-result v11

    if-eqz v11, :cond_1a

    invoke-virtual/range {v21 .. v21}, Ljava/io/File;->delete()Z
    :try_end_e
    .catch Ljava/lang/Exception; {:try_start_e .. :try_end_e} :catch_6
    .catch Ljava/net/ProtocolException; {:try_start_e .. :try_end_e} :catch_3b
    .catch Ljava/io/IOException; {:try_start_e .. :try_end_e} :catch_35
    .catch Ljava/lang/ArrayIndexOutOfBoundsException; {:try_start_e .. :try_end_e} :catch_2b
    .catchall {:try_start_e .. :try_end_e} :catchall_1

    :cond_1a
    move-object v11, v6

    :cond_1b
    :goto_18
    if-ltz p3, :cond_1d

    if-lez p4, :cond_1d

    :try_start_f
    move/from16 v0, p3

    move/from16 v1, p4

    invoke-static {v5, v0, v1}, Lcom/glu/platform/android/resdl/GluUtil;->createURLConnection(Ljava/lang/String;II)Ljava/net/HttpURLConnection;
    :try_end_f
    .catch Ljava/net/UnknownHostException; {:try_start_f .. :try_end_f} :catch_41
    .catch Ljava/io/IOException; {:try_start_f .. :try_end_f} :catch_8
    .catch Ljava/net/ProtocolException; {:try_start_f .. :try_end_f} :catch_9
    .catch Ljava/lang/ArrayIndexOutOfBoundsException; {:try_start_f .. :try_end_f} :catch_a
    .catch Ljava/lang/Exception; {:try_start_f .. :try_end_f} :catch_b
    .catchall {:try_start_f .. :try_end_f} :catchall_0

    move-result-object v9

    :goto_19
    :try_start_10
    invoke-virtual {v9}, Ljava/net/HttpURLConnection;->getResponseCode()I

    move-result v8

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "Response message: "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v9}, Ljava/net/HttpURLConnection;->getResponseMessage()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v5}, Lcom/glu/platform/android/resdl/Debug;->log(Ljava/lang/String;)V

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "Response method: "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v9}, Ljava/net/HttpURLConnection;->getRequestMethod()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v5}, Lcom/glu/platform/android/resdl/Debug;->log(Ljava/lang/String;)V

    invoke-static {v9}, Lcom/glu/platform/android/resdl/GluUtil;->getContentLength(Ljava/net/HttpURLConnection;)I

    move-result v6

    if-nez v6, :cond_1e

    const-string v5, "Will not do file size check."

    invoke-static {v5}, Lcom/glu/platform/android/resdl/Debug;->log(Ljava/lang/String;)V

    :goto_1a
    const/4 v5, 0x1

    const/4 v14, 0x1

    move/from16 v0, p1

    if-ne v0, v14, :cond_21

    const/16 v5, 0xce

    if-ne v8, v5, :cond_1f

    move v5, v13

    :goto_1b
    add-int/2addr v5, v6

    invoke-static {}, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->getSpecialFileSize()I

    move-result v6

    if-ne v5, v6, :cond_20

    const/4 v5, 0x1

    :cond_1c
    :goto_1c
    if-nez v5, :cond_25

    const v2, 0x7f060047

    invoke-static {v2}, Lcom/glu/platform/android/resdl/GluUtil;->getString(I)Ljava/lang/String;

    move-result-object v2

    const/4 v3, 0x2

    new-array v3, v3, [Ljava/lang/Object;

    const/4 v5, 0x0

    const v6, 0x7f06002c

    invoke-static {v6}, Lcom/glu/platform/android/resdl/GluUtil;->getString(I)Ljava/lang/String;

    move-result-object v6

    aput-object v6, v3, v5

    const/4 v5, 0x1

    sget-object v6, Lcom/glu/platform/android/resdl/GameLet$instance;->m_fullVersion:Ljava/lang/String;

    aput-object v6, v3, v5

    invoke-static {v2, v3}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;
    :try_end_10
    .catch Ljava/net/UnknownHostException; {:try_start_10 .. :try_end_10} :catch_7
    .catch Ljava/io/IOException; {:try_start_10 .. :try_end_10} :catch_8
    .catch Ljava/net/ProtocolException; {:try_start_10 .. :try_end_10} :catch_9
    .catch Ljava/lang/ArrayIndexOutOfBoundsException; {:try_start_10 .. :try_end_10} :catch_a
    .catch Ljava/lang/Exception; {:try_start_10 .. :try_end_10} :catch_b
    .catchall {:try_start_10 .. :try_end_10} :catchall_0

    move-result-object v3

    :try_start_11
    new-instance v2, Ljava/lang/Exception;

    invoke-direct {v2}, Ljava/lang/Exception;-><init>()V

    throw v2
    :try_end_11
    .catch Ljava/net/UnknownHostException; {:try_start_11 .. :try_end_11} :catch_4
    .catch Ljava/io/IOException; {:try_start_11 .. :try_end_11} :catch_40
    .catch Ljava/net/ProtocolException; {:try_start_11 .. :try_end_11} :catch_9
    .catch Ljava/lang/ArrayIndexOutOfBoundsException; {:try_start_11 .. :try_end_11} :catch_2e
    .catch Ljava/lang/Exception; {:try_start_11 .. :try_end_11} :catch_24
    .catchall {:try_start_11 .. :try_end_11} :catchall_0

    :catch_4
    move-exception v2

    move-object v5, v9

    move-object v6, v3

    move v3, v8

    :goto_1d
    :try_start_12
    invoke-virtual {v2}, Ljava/net/UnknownHostException;->getMessage()Ljava/lang/String;

    move-result-object v8

    invoke-static {v8, v2}, Lcom/glu/platform/android/resdl/Debug;->log(Ljava/lang/String;Ljava/lang/Throwable;)V

    new-instance v8, Ljava/net/ProtocolException;

    invoke-virtual {v2}, Ljava/net/UnknownHostException;->getMessage()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v8, v2}, Ljava/net/ProtocolException;-><init>(Ljava/lang/String;)V

    throw v8
    :try_end_12
    .catch Ljava/net/ProtocolException; {:try_start_12 .. :try_end_12} :catch_5
    .catch Ljava/io/IOException; {:try_start_12 .. :try_end_12} :catch_37
    .catch Ljava/lang/ArrayIndexOutOfBoundsException; {:try_start_12 .. :try_end_12} :catch_2f
    .catch Ljava/lang/Exception; {:try_start_12 .. :try_end_12} :catch_25
    .catchall {:try_start_12 .. :try_end_12} :catchall_3

    :catch_5
    move-exception v2

    move v8, v3

    move-object v9, v5

    move-object v5, v11

    move-object v3, v4

    move-object v4, v12

    goto/16 :goto_c

    :catch_6
    move-exception v11

    move-object v11, v6

    goto/16 :goto_18

    :cond_1d
    :try_start_13
    invoke-static {v5, v13}, Lcom/glu/platform/android/resdl/GluUtil;->createURLConnection(Ljava/lang/String;I)Ljava/net/HttpURLConnection;
    :try_end_13
    .catch Ljava/net/UnknownHostException; {:try_start_13 .. :try_end_13} :catch_41
    .catch Ljava/io/IOException; {:try_start_13 .. :try_end_13} :catch_8
    .catch Ljava/net/ProtocolException; {:try_start_13 .. :try_end_13} :catch_9
    .catch Ljava/lang/ArrayIndexOutOfBoundsException; {:try_start_13 .. :try_end_13} :catch_a
    .catch Ljava/lang/Exception; {:try_start_13 .. :try_end_13} :catch_b
    .catchall {:try_start_13 .. :try_end_13} :catchall_0

    move-result-object v9

    goto/16 :goto_19

    :cond_1e
    :try_start_14
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v14, "Will do file size check, content-length="

    invoke-virtual {v5, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v5}, Lcom/glu/platform/android/resdl/Debug;->log(Ljava/lang/String;)V

    goto :goto_1a

    :catch_7
    move-exception v2

    move v3, v8

    move-object v5, v9

    move-object v6, v10

    goto :goto_1d

    :cond_1f
    const/4 v5, 0x0

    goto :goto_1b

    :cond_20
    const/4 v5, 0x0

    goto :goto_1c

    :cond_21
    if-nez p1, :cond_24

    const/16 v5, 0xce

    if-ne v8, v5, :cond_22

    move v5, v13

    :goto_1e
    add-int/2addr v5, v6

    int-to-long v5, v5

    sget-wide v14, Lcom/glu/platform/android/resdl/GameLet;->RES_FILE_SIZE_TO_USE:J

    cmp-long v5, v5, v14

    if-nez v5, :cond_23

    const/4 v5, 0x1

    goto :goto_1c

    :cond_22
    const/4 v5, 0x0

    goto :goto_1e

    :cond_23
    const/4 v5, 0x0

    goto :goto_1c

    :cond_24
    const/4 v6, 0x2

    move/from16 v0, p1

    if-ne v0, v6, :cond_1c

    const/4 v5, 0x1

    goto/16 :goto_1c

    :cond_25
    const/16 v5, 0xce

    if-ne v8, v5, :cond_28

    const-string v5, "Resume successful."

    invoke-static {v5}, Lcom/glu/platform/android/resdl/Debug;->log(Ljava/lang/String;)V

    :cond_26
    :goto_1f
    invoke-virtual {v9}, Ljava/net/HttpURLConnection;->getInputStream()Ljava/io/InputStream;
    :try_end_14
    .catch Ljava/net/UnknownHostException; {:try_start_14 .. :try_end_14} :catch_7
    .catch Ljava/io/IOException; {:try_start_14 .. :try_end_14} :catch_8
    .catch Ljava/net/ProtocolException; {:try_start_14 .. :try_end_14} :catch_9
    .catch Ljava/lang/ArrayIndexOutOfBoundsException; {:try_start_14 .. :try_end_14} :catch_a
    .catch Ljava/lang/Exception; {:try_start_14 .. :try_end_14} :catch_b
    .catchall {:try_start_14 .. :try_end_14} :catchall_0

    move-result-object v12

    :try_start_15
    new-instance v5, Ljava/io/FileOutputStream;

    move/from16 v0, v19

    invoke-direct {v5, v4, v0}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;Z)V
    :try_end_15
    .catch Ljava/net/ProtocolException; {:try_start_15 .. :try_end_15} :catch_3c
    .catch Ljava/io/IOException; {:try_start_15 .. :try_end_15} :catch_11
    .catch Ljava/lang/ArrayIndexOutOfBoundsException; {:try_start_15 .. :try_end_15} :catch_a
    .catch Ljava/lang/Exception; {:try_start_15 .. :try_end_15} :catch_b
    .catchall {:try_start_15 .. :try_end_15} :catchall_0

    :try_start_16
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "Download: Starting to grab from buffer. bufferSize="

    invoke-virtual {v6, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    move-object/from16 v0, v22

    array-length v11, v0

    invoke-virtual {v6, v11}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v11, " File="

    invoke-virtual {v6, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v4}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v11

    invoke-virtual {v6, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v6}, Lcom/glu/platform/android/resdl/Debug;->log(Ljava/lang/String;)V
    :try_end_16
    .catch Ljava/net/ProtocolException; {:try_start_16 .. :try_end_16} :catch_e
    .catch Ljava/io/IOException; {:try_start_16 .. :try_end_16} :catch_38
    .catch Ljava/lang/ArrayIndexOutOfBoundsException; {:try_start_16 .. :try_end_16} :catch_30
    .catch Ljava/lang/Exception; {:try_start_16 .. :try_end_16} :catch_26
    .catchall {:try_start_16 .. :try_end_16} :catchall_4

    :cond_27
    :goto_20
    :try_start_17
    move-object/from16 v0, v22

    invoke-virtual {v12, v0}, Ljava/io/InputStream;->read([B)I

    move-result v6

    const/4 v11, -0x1

    if-eq v6, v11, :cond_37

    sget-object v11, Lcom/glu/platform/android/resdl/ResFileDownloadView;->instance:Lcom/glu/platform/android/resdl/ResFileDownloadView;

    iget-boolean v11, v11, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_downloadCancelled:Z
    :try_end_17
    .catch Ljava/net/ProtocolException; {:try_start_17 .. :try_end_17} :catch_e
    .catch Ljava/io/IOException; {:try_start_17 .. :try_end_17} :catch_39
    .catch Ljava/lang/ArrayIndexOutOfBoundsException; {:try_start_17 .. :try_end_17} :catch_f
    .catch Ljava/lang/Exception; {:try_start_17 .. :try_end_17} :catch_27
    .catchall {:try_start_17 .. :try_end_17} :catchall_5

    if-nez v11, :cond_37

    const/4 v11, 0x1

    move/from16 v0, p1

    if-ne v0, v11, :cond_35

    const/4 v11, 0x0

    :goto_21
    if-lez v6, :cond_33

    :try_start_18
    sget-object v13, Lcom/glu/platform/android/resdl/GameLet;->SPECIAL_RES_FILESIZE_ARRAY:[I

    const/4 v14, 0x1

    aget v14, v2, v14

    aget v13, v13, v14

    const/4 v14, 0x2

    aget v14, v2, v14

    sub-int/2addr v13, v14

    if-ne v13, v6, :cond_31

    move-object/from16 v0, v22

    invoke-virtual {v5, v0, v11, v6}, Ljava/io/FileOutputStream;->write([BII)V

    const/4 v13, 0x1

    aget v14, v2, v13

    add-int/lit8 v14, v14, 0x1

    aput v14, v2, v13

    const/4 v13, 0x2

    const/4 v14, 0x0

    aput v14, v2, v13

    const/4 v13, 0x0

    aget v14, v2, v13

    add-int/2addr v6, v14

    aput v6, v2, v13

    const/4 v6, 0x0

    move v13, v11

    move v11, v6

    :goto_22
    const/4 v6, 0x2

    aget v6, v2, v6

    if-nez v6, :cond_48

    const/4 v6, 0x1

    aget v6, v2, v6

    sget-object v14, Lcom/glu/platform/android/resdl/GameLet;->SPECIAL_RES_FILESIZE_ARRAY:[I

    array-length v14, v14

    if-ge v6, v14, :cond_48

    invoke-virtual {v5}, Ljava/io/FileOutputStream;->close()V

    sget-object v6, Lcom/glu/platform/android/resdl/GameLet;->SPECIAL_RES_FILENAME_ARRAY:[Ljava/lang/String;

    const/4 v14, 0x1

    aget v14, v2, v14

    aget-object v6, v6, v14

    invoke-static {v6}, Lcom/glu/platform/android/resdl/GluUtil;->getRelativeFilename(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v14

    move-object/from16 v0, p0

    iput-object v14, v0, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->m_specialCurrentFilename:Ljava/lang/String;

    invoke-static {v6}, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->getSecondaryFile(Ljava/lang/String;)Ljava/io/File;
    :try_end_18
    .catch Ljava/io/IOException; {:try_start_18 .. :try_end_18} :catch_d
    .catch Ljava/net/ProtocolException; {:try_start_18 .. :try_end_18} :catch_e
    .catch Ljava/lang/ArrayIndexOutOfBoundsException; {:try_start_18 .. :try_end_18} :catch_f
    .catch Ljava/lang/Exception; {:try_start_18 .. :try_end_18} :catch_27
    .catchall {:try_start_18 .. :try_end_18} :catchall_5

    move-result-object v6

    :try_start_19
    new-instance v4, Ljava/io/FileOutputStream;

    const/4 v14, 0x0

    invoke-direct {v4, v6, v14}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;Z)V
    :try_end_19
    .catch Ljava/io/IOException; {:try_start_19 .. :try_end_19} :catch_3f
    .catch Ljava/net/ProtocolException; {:try_start_19 .. :try_end_19} :catch_3d
    .catch Ljava/lang/ArrayIndexOutOfBoundsException; {:try_start_19 .. :try_end_19} :catch_31
    .catch Ljava/lang/Exception; {:try_start_19 .. :try_end_19} :catch_28
    .catchall {:try_start_19 .. :try_end_19} :catchall_5

    move-object v5, v6

    :goto_23
    move v6, v11

    move v11, v13

    move-object/from16 v25, v5

    move-object v5, v4

    move-object/from16 v4, v25

    goto :goto_21

    :cond_28
    const/16 v5, 0xc8

    if-ne v8, v5, :cond_29

    if-eqz v13, :cond_26

    :try_start_1a
    const-string v5, "Resume not supported."

    invoke-static {v5}, Lcom/glu/platform/android/resdl/Debug;->log(Ljava/lang/String;)V

    if-eqz v3, :cond_26

    sget-object v5, Lcom/glu/platform/android/resdl/ResFileDownloadView;->instance:Lcom/glu/platform/android/resdl/ResFileDownloadView;

    const/4 v6, 0x0

    iput v6, v5, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_bytesDownloaded:I
    :try_end_1a
    .catch Ljava/net/UnknownHostException; {:try_start_1a .. :try_end_1a} :catch_7
    .catch Ljava/io/IOException; {:try_start_1a .. :try_end_1a} :catch_8
    .catch Ljava/net/ProtocolException; {:try_start_1a .. :try_end_1a} :catch_9
    .catch Ljava/lang/ArrayIndexOutOfBoundsException; {:try_start_1a .. :try_end_1a} :catch_a
    .catch Ljava/lang/Exception; {:try_start_1a .. :try_end_1a} :catch_b
    .catchall {:try_start_1a .. :try_end_1a} :catchall_0

    goto/16 :goto_1f

    :catch_8
    move-exception v2

    :goto_24
    :try_start_1b
    invoke-virtual {v2}, Ljava/io/IOException;->getMessage()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3, v2}, Lcom/glu/platform/android/resdl/Debug;->log(Ljava/lang/String;Ljava/lang/Throwable;)V

    new-instance v3, Ljava/net/ProtocolException;

    invoke-virtual {v2}, Ljava/io/IOException;->getMessage()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v3, v2}, Ljava/net/ProtocolException;-><init>(Ljava/lang/String;)V

    throw v3
    :try_end_1b
    .catch Ljava/net/ProtocolException; {:try_start_1b .. :try_end_1b} :catch_9
    .catch Ljava/io/IOException; {:try_start_1b .. :try_end_1b} :catch_11
    .catch Ljava/lang/ArrayIndexOutOfBoundsException; {:try_start_1b .. :try_end_1b} :catch_2a
    .catch Ljava/lang/Exception; {:try_start_1b .. :try_end_1b} :catch_b
    .catchall {:try_start_1b .. :try_end_1b} :catchall_0

    :catch_9
    move-exception v2

    move-object v5, v11

    move-object v3, v4

    move-object v4, v12

    goto/16 :goto_c

    :cond_29
    const/16 v2, 0x1a0

    if-ne v8, v2, :cond_2e

    :try_start_1c
    const-string v2, "416: Requested range not satisfiable. The optional resource file is probably fine."

    invoke-static {v2}, Lcom/glu/platform/android/resdl/Debug;->log(Ljava/lang/String;)V

    new-instance v2, Ljava/net/ProtocolException;

    const-string v3, "Everything\'s fine."

    invoke-direct {v2, v3}, Ljava/net/ProtocolException;-><init>(Ljava/lang/String;)V

    throw v2
    :try_end_1c
    .catch Ljava/net/UnknownHostException; {:try_start_1c .. :try_end_1c} :catch_7
    .catch Ljava/io/IOException; {:try_start_1c .. :try_end_1c} :catch_8
    .catch Ljava/net/ProtocolException; {:try_start_1c .. :try_end_1c} :catch_9
    .catch Ljava/lang/ArrayIndexOutOfBoundsException; {:try_start_1c .. :try_end_1c} :catch_a
    .catch Ljava/lang/Exception; {:try_start_1c .. :try_end_1c} :catch_b
    .catchall {:try_start_1c .. :try_end_1c} :catchall_0

    :catch_a
    move-exception v2

    move-object v3, v4

    move-object v4, v2

    move-object v2, v10

    :goto_25
    :try_start_1d
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "Logic error: "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v5, v4}, Lcom/glu/platform/android/resdl/Debug;->log(Ljava/lang/String;Ljava/lang/Throwable;)V

    const/4 v4, 0x1

    move/from16 v0, p1

    if-eq v0, v4, :cond_2a

    const/4 v4, 0x2

    move/from16 v0, p1

    if-ne v0, v4, :cond_3c

    :cond_2a
    new-instance v2, Ljava/lang/RuntimeException;

    const-string v3, "Your special *.gpk resource pack is the wrong URL. (filesize larger than expected) Fix it in the properties file."

    invoke-direct {v2, v3}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    throw v2
    :try_end_1d
    .catchall {:try_start_1d .. :try_end_1d} :catchall_0

    :catchall_0
    move-exception v2

    :goto_26
    if-eqz v11, :cond_2b

    :try_start_1e
    invoke-virtual {v11}, Ljava/io/FileOutputStream;->close()V
    :try_end_1e
    .catch Ljava/lang/Exception; {:try_start_1e .. :try_end_1e} :catch_1f

    :cond_2b
    :goto_27
    if-eqz v12, :cond_2c

    :try_start_1f
    invoke-virtual {v12}, Ljava/io/InputStream;->close()V
    :try_end_1f
    .catch Ljava/lang/Exception; {:try_start_1f .. :try_end_1f} :catch_20

    :cond_2c
    :goto_28
    if-eqz v9, :cond_2d

    :try_start_20
    invoke-virtual {v9}, Ljava/net/HttpURLConnection;->disconnect()V
    :try_end_20
    .catch Ljava/lang/Exception; {:try_start_20 .. :try_end_20} :catch_21

    :cond_2d
    :goto_29
    throw v2

    :cond_2e
    :try_start_21
    new-instance v2, Ljava/io/IOException;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "Response code: "

    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v8}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-direct {v2, v3}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v2
    :try_end_21
    .catch Ljava/net/UnknownHostException; {:try_start_21 .. :try_end_21} :catch_7
    .catch Ljava/io/IOException; {:try_start_21 .. :try_end_21} :catch_8
    .catch Ljava/net/ProtocolException; {:try_start_21 .. :try_end_21} :catch_9
    .catch Ljava/lang/ArrayIndexOutOfBoundsException; {:try_start_21 .. :try_end_21} :catch_a
    .catch Ljava/lang/Exception; {:try_start_21 .. :try_end_21} :catch_b
    .catchall {:try_start_21 .. :try_end_21} :catchall_0

    :catch_b
    move-exception v2

    move-object v3, v4

    :goto_2a
    if-nez v10, :cond_46

    :try_start_22
    const-string v4, "Unknown download error."

    invoke-static {v4, v2}, Lcom/glu/platform/android/resdl/Debug;->log(Ljava/lang/String;Ljava/lang/Throwable;)V

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const v5, 0x7f06004c

    invoke-static {v5}, Lcom/glu/platform/android/resdl/GluUtil;->getString(I)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, " ("

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v2}, Ljava/lang/Exception;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v4, ")"

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    :try_end_22
    .catchall {:try_start_22 .. :try_end_22} :catchall_0

    move-result-object v2

    :goto_2b
    if-eqz v11, :cond_2f

    :try_start_23
    invoke-virtual {v11}, Ljava/io/FileOutputStream;->close()V
    :try_end_23
    .catch Ljava/lang/Exception; {:try_start_23 .. :try_end_23} :catch_1d

    :cond_2f
    :goto_2c
    if-eqz v12, :cond_30

    :try_start_24
    invoke-virtual {v12}, Ljava/io/InputStream;->close()V
    :try_end_24
    .catch Ljava/lang/Exception; {:try_start_24 .. :try_end_24} :catch_1e

    :cond_30
    :goto_2d
    if-eqz v9, :cond_5

    :try_start_25
    invoke-virtual {v9}, Ljava/net/HttpURLConnection;->disconnect()V
    :try_end_25
    .catch Ljava/lang/Exception; {:try_start_25 .. :try_end_25} :catch_c

    goto/16 :goto_f

    :catch_c
    move-exception v4

    goto/16 :goto_f

    :cond_31
    if-le v13, v6, :cond_32

    :try_start_26
    move-object/from16 v0, v22

    invoke-virtual {v5, v0, v11, v6}, Ljava/io/FileOutputStream;->write([BII)V

    const/4 v13, 0x2

    aget v14, v2, v13

    add-int/2addr v14, v6

    aput v14, v2, v13

    const/4 v13, 0x0

    aget v14, v2, v13

    add-int/2addr v6, v14

    aput v6, v2, v13

    const/4 v6, 0x0

    move v13, v11

    move v11, v6

    goto/16 :goto_22

    :cond_32
    move-object/from16 v0, v22

    invoke-virtual {v5, v0, v11, v13}, Ljava/io/FileOutputStream;->write([BII)V

    const/4 v14, 0x1

    aget v15, v2, v14

    add-int/lit8 v15, v15, 0x1

    aput v15, v2, v14

    const/4 v14, 0x2

    const/4 v15, 0x0

    aput v15, v2, v14

    const/4 v14, 0x0

    aget v15, v2, v14

    add-int/2addr v15, v13

    aput v15, v2, v14

    sub-int/2addr v6, v13

    add-int/2addr v11, v13

    move v13, v11

    move v11, v6

    goto/16 :goto_22

    :cond_33
    const/4 v6, 0x0

    aget v6, v2, v6

    move-object/from16 v0, v20

    iput v6, v0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_bytesDownloaded:I
    :try_end_26
    .catch Ljava/io/IOException; {:try_start_26 .. :try_end_26} :catch_d
    .catch Ljava/net/ProtocolException; {:try_start_26 .. :try_end_26} :catch_e
    .catch Ljava/lang/ArrayIndexOutOfBoundsException; {:try_start_26 .. :try_end_26} :catch_f
    .catch Ljava/lang/Exception; {:try_start_26 .. :try_end_26} :catch_27
    .catchall {:try_start_26 .. :try_end_26} :catchall_5

    goto/16 :goto_20

    :catch_d
    move-exception v2

    :goto_2e
    :try_start_27
    const-string v6, "Download failed."

    invoke-static {v6, v2}, Lcom/glu/platform/android/resdl/Debug;->log(Ljava/lang/String;Ljava/lang/Throwable;)V

    const v2, 0x7f06004a

    invoke-static {v2}, Lcom/glu/platform/android/resdl/GluUtil;->getString(I)Ljava/lang/String;

    move-result-object v2

    const/4 v6, 0x1

    new-array v6, v6, [Ljava/lang/Object;

    const/4 v11, 0x0

    sget-wide v13, Lcom/glu/platform/android/resdl/GameLet;->RES_FILE_SIZE_TO_USE:J

    invoke-static {v13, v14}, Lcom/glu/platform/android/resdl/GluUtil;->getBytesStringNice(J)Ljava/lang/String;

    move-result-object v13

    aput-object v13, v6, v11

    invoke-static {v2, v6}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;
    :try_end_27
    .catch Ljava/net/ProtocolException; {:try_start_27 .. :try_end_27} :catch_e
    .catch Ljava/io/IOException; {:try_start_27 .. :try_end_27} :catch_39
    .catch Ljava/lang/ArrayIndexOutOfBoundsException; {:try_start_27 .. :try_end_27} :catch_f
    .catch Ljava/lang/Exception; {:try_start_27 .. :try_end_27} :catch_27
    .catchall {:try_start_27 .. :try_end_27} :catchall_5

    move-result-object v10

    :try_start_28
    invoke-virtual {v5}, Ljava/io/FileOutputStream;->close()V
    :try_end_28
    .catch Ljava/lang/Exception; {:try_start_28 .. :try_end_28} :catch_3e
    .catch Ljava/net/ProtocolException; {:try_start_28 .. :try_end_28} :catch_e
    .catch Ljava/io/IOException; {:try_start_28 .. :try_end_28} :catch_39
    .catch Ljava/lang/ArrayIndexOutOfBoundsException; {:try_start_28 .. :try_end_28} :catch_32
    .catchall {:try_start_28 .. :try_end_28} :catchall_5

    const/4 v5, 0x0

    :try_start_29
    invoke-virtual {v4}, Ljava/io/File;->exists()Z

    move-result v2

    if-eqz v2, :cond_34

    if-eqz v3, :cond_34

    sget-object v2, Lcom/glu/platform/android/resdl/ResFileDownloadView;->instance:Lcom/glu/platform/android/resdl/ResFileDownloadView;

    invoke-virtual {v4}, Ljava/io/File;->length()J

    move-result-wide v13

    long-to-int v3, v13

    iput v3, v2, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_bytesDownloaded:I
    :try_end_29
    .catch Ljava/lang/Exception; {:try_start_29 .. :try_end_29} :catch_3e
    .catch Ljava/net/ProtocolException; {:try_start_29 .. :try_end_29} :catch_e
    .catch Ljava/io/IOException; {:try_start_29 .. :try_end_29} :catch_3a
    .catch Ljava/lang/ArrayIndexOutOfBoundsException; {:try_start_29 .. :try_end_29} :catch_33
    .catchall {:try_start_29 .. :try_end_29} :catchall_6

    :cond_34
    :goto_2f
    :try_start_2a
    new-instance v2, Ljava/lang/Exception;

    invoke-direct {v2}, Ljava/lang/Exception;-><init>()V

    throw v2
    :try_end_2a
    .catch Ljava/net/ProtocolException; {:try_start_2a .. :try_end_2a} :catch_e
    .catch Ljava/io/IOException; {:try_start_2a .. :try_end_2a} :catch_39
    .catch Ljava/lang/ArrayIndexOutOfBoundsException; {:try_start_2a .. :try_end_2a} :catch_32
    .catch Ljava/lang/Exception; {:try_start_2a .. :try_end_2a} :catch_27
    .catchall {:try_start_2a .. :try_end_2a} :catchall_5

    :catch_e
    move-exception v2

    move-object v3, v4

    move-object v4, v12

    goto/16 :goto_c

    :cond_35
    const/4 v11, 0x0

    :try_start_2b
    move-object/from16 v0, v22

    invoke-virtual {v5, v0, v11, v6}, Ljava/io/FileOutputStream;->write([BII)V

    if-nez v3, :cond_36

    const/4 v11, 0x2

    move/from16 v0, p1

    if-ne v0, v11, :cond_27

    :cond_36
    sget-object v11, Lcom/glu/platform/android/resdl/ResFileDownloadView;->instance:Lcom/glu/platform/android/resdl/ResFileDownloadView;

    iget v13, v11, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_bytesDownloaded:I

    add-int/2addr v6, v13

    iput v6, v11, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_bytesDownloaded:I
    :try_end_2b
    .catch Ljava/io/IOException; {:try_start_2b .. :try_end_2b} :catch_d
    .catch Ljava/net/ProtocolException; {:try_start_2b .. :try_end_2b} :catch_e
    .catch Ljava/lang/ArrayIndexOutOfBoundsException; {:try_start_2b .. :try_end_2b} :catch_f
    .catch Ljava/lang/Exception; {:try_start_2b .. :try_end_2b} :catch_27
    .catchall {:try_start_2b .. :try_end_2b} :catchall_5

    goto/16 :goto_20

    :catch_f
    move-exception v2

    move-object v11, v5

    move-object v3, v4

    move-object v4, v2

    move-object v2, v10

    goto/16 :goto_25

    :cond_37
    :try_start_2c
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Download: Finished grabbing from server.   count="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/glu/platform/android/resdl/Debug;->log(Ljava/lang/String;)V

    invoke-virtual {v5}, Ljava/io/FileOutputStream;->close()V
    :try_end_2c
    .catch Ljava/net/ProtocolException; {:try_start_2c .. :try_end_2c} :catch_e
    .catch Ljava/io/IOException; {:try_start_2c .. :try_end_2c} :catch_39
    .catch Ljava/lang/ArrayIndexOutOfBoundsException; {:try_start_2c .. :try_end_2c} :catch_f
    .catch Ljava/lang/Exception; {:try_start_2c .. :try_end_2c} :catch_27
    .catchall {:try_start_2c .. :try_end_2c} :catchall_5

    const/4 v5, 0x0

    :try_start_2d
    sget-object v2, Lcom/glu/platform/android/resdl/ResFileDownloadView;->instance:Lcom/glu/platform/android/resdl/ResFileDownloadView;

    iget-boolean v2, v2, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_downloadCancelled:Z

    if-eqz v2, :cond_47

    const v2, 0x7f060045

    invoke-static {v2}, Lcom/glu/platform/android/resdl/GluUtil;->getString(I)Ljava/lang/String;
    :try_end_2d
    .catch Ljava/net/ProtocolException; {:try_start_2d .. :try_end_2d} :catch_e
    .catch Ljava/io/IOException; {:try_start_2d .. :try_end_2d} :catch_3a
    .catch Ljava/lang/ArrayIndexOutOfBoundsException; {:try_start_2d .. :try_end_2d} :catch_34
    .catch Ljava/lang/Exception; {:try_start_2d .. :try_end_2d} :catch_29
    .catchall {:try_start_2d .. :try_end_2d} :catchall_6

    move-result-object v2

    :goto_30
    if-eqz v12, :cond_38

    :try_start_2e
    invoke-virtual {v12}, Ljava/io/InputStream;->close()V
    :try_end_2e
    .catch Ljava/lang/Exception; {:try_start_2e .. :try_end_2e} :catch_15

    :cond_38
    :goto_31
    if-eqz v9, :cond_39

    :try_start_2f
    invoke-virtual {v9}, Ljava/net/HttpURLConnection;->disconnect()V
    :try_end_2f
    .catch Ljava/lang/Exception; {:try_start_2f .. :try_end_2f} :catch_10

    :cond_39
    move-object v3, v4

    goto/16 :goto_f

    :catch_10
    move-exception v3

    move-object v3, v4

    goto/16 :goto_f

    :catch_11
    move-exception v2

    move-object v3, v4

    :goto_32
    :try_start_30
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "Filename: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v3}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v4, v2}, Lcom/glu/platform/android/resdl/Debug;->log(Ljava/lang/String;Ljava/lang/Throwable;)V

    const v2, 0x7f060049

    invoke-static {v2}, Lcom/glu/platform/android/resdl/GluUtil;->getString(I)Ljava/lang/String;
    :try_end_30
    .catchall {:try_start_30 .. :try_end_30} :catchall_0

    move-result-object v2

    if-eqz v11, :cond_3a

    :try_start_31
    invoke-virtual {v11}, Ljava/io/FileOutputStream;->close()V
    :try_end_31
    .catch Ljava/lang/Exception; {:try_start_31 .. :try_end_31} :catch_19

    :cond_3a
    :goto_33
    if-eqz v12, :cond_3b

    :try_start_32
    invoke-virtual {v12}, Ljava/io/InputStream;->close()V
    :try_end_32
    .catch Ljava/lang/Exception; {:try_start_32 .. :try_end_32} :catch_1a

    :cond_3b
    :goto_34
    if-eqz v9, :cond_5

    :try_start_33
    invoke-virtual {v9}, Ljava/net/HttpURLConnection;->disconnect()V
    :try_end_33
    .catch Ljava/lang/Exception; {:try_start_33 .. :try_end_33} :catch_12

    goto/16 :goto_f

    :catch_12
    move-exception v4

    goto/16 :goto_f

    :cond_3c
    if-eqz v11, :cond_3d

    :try_start_34
    invoke-virtual {v11}, Ljava/io/FileOutputStream;->close()V
    :try_end_34
    .catch Ljava/lang/Exception; {:try_start_34 .. :try_end_34} :catch_1b

    :cond_3d
    :goto_35
    if-eqz v12, :cond_3e

    :try_start_35
    invoke-virtual {v12}, Ljava/io/InputStream;->close()V
    :try_end_35
    .catch Ljava/lang/Exception; {:try_start_35 .. :try_end_35} :catch_1c

    :cond_3e
    :goto_36
    if-eqz v9, :cond_5

    :try_start_36
    invoke-virtual {v9}, Ljava/net/HttpURLConnection;->disconnect()V
    :try_end_36
    .catch Ljava/lang/Exception; {:try_start_36 .. :try_end_36} :catch_13

    goto/16 :goto_f

    :catch_13
    move-exception v4

    goto/16 :goto_f

    :cond_3f
    const/4 v4, 0x1

    goto/16 :goto_10

    :cond_40
    const/4 v2, 0x1

    move/from16 v0, p1

    if-eq v0, v2, :cond_8

    const/4 v2, 0x2

    move/from16 v0, p1

    if-eq v0, v2, :cond_8

    const/4 v2, 0x3

    move/from16 v0, p1

    if-ne v0, v2, :cond_8

    new-instance v2, Ljava/lang/RuntimeException;

    const-string v3, "implement me!!!"

    invoke-direct {v2, v3}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    throw v2

    :cond_41
    if-nez p1, :cond_8

    move-object/from16 v0, p0

    iget-boolean v2, v0, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->m_mainResFileInterrupted:Z

    if-nez v2, :cond_42

    if-eqz v4, :cond_43

    :cond_42
    const/4 v2, 0x1

    move-object/from16 v3, p0

    goto/16 :goto_13

    :catch_14
    move-exception v11

    goto/16 :goto_17

    :catch_15
    move-exception v3

    goto/16 :goto_31

    :catch_16
    move-exception v5

    goto/16 :goto_d

    :catch_17
    move-exception v4

    goto/16 :goto_e

    :catch_18
    move-exception v4

    goto/16 :goto_f

    :catch_19
    move-exception v4

    goto :goto_33

    :catch_1a
    move-exception v4

    goto :goto_34

    :catch_1b
    move-exception v4

    goto :goto_35

    :catch_1c
    move-exception v4

    goto :goto_36

    :catch_1d
    move-exception v4

    goto/16 :goto_2c

    :catch_1e
    move-exception v4

    goto/16 :goto_2d

    :catch_1f
    move-exception v3

    goto/16 :goto_27

    :catch_20
    move-exception v3

    goto/16 :goto_28

    :catch_21
    move-exception v3

    goto/16 :goto_29

    :catchall_1
    move-exception v2

    move-object v11, v6

    goto/16 :goto_26

    :catchall_2
    move-exception v2

    move-object v11, v5

    goto/16 :goto_26

    :catchall_3
    move-exception v2

    move-object v9, v5

    goto/16 :goto_26

    :catchall_4
    move-exception v2

    move-object v11, v5

    goto/16 :goto_26

    :catchall_5
    move-exception v2

    move-object v11, v5

    goto/16 :goto_26

    :catchall_6
    move-exception v2

    move-object v11, v5

    goto/16 :goto_26

    :catchall_7
    move-exception v2

    move-object v11, v5

    move-object v12, v4

    goto/16 :goto_26

    :catch_22
    move-exception v2

    move-object v11, v6

    move-object v3, v4

    goto/16 :goto_2a

    :catch_23
    move-exception v2

    move-object v11, v5

    move-object v3, v4

    goto/16 :goto_2a

    :catch_24
    move-exception v2

    move-object v10, v3

    move-object v3, v4

    goto/16 :goto_2a

    :catch_25
    move-exception v2

    move-object v9, v5

    move-object v10, v6

    move-object v3, v4

    goto/16 :goto_2a

    :catch_26
    move-exception v2

    move-object v11, v5

    move-object v3, v4

    goto/16 :goto_2a

    :catch_27
    move-exception v2

    move-object v11, v5

    move-object v3, v4

    goto/16 :goto_2a

    :catch_28
    move-exception v2

    move-object v11, v5

    move-object v3, v6

    goto/16 :goto_2a

    :catch_29
    move-exception v2

    move-object v11, v5

    move-object v3, v4

    goto/16 :goto_2a

    :catch_2a
    move-exception v2

    move-object v3, v4

    move-object v4, v2

    move-object v2, v10

    goto/16 :goto_25

    :catch_2b
    move-exception v2

    move-object v11, v6

    move-object v3, v4

    move-object v4, v2

    move-object v2, v10

    goto/16 :goto_25

    :catch_2c
    move-exception v2

    move-object v11, v6

    move-object v3, v4

    move-object v4, v2

    move-object v2, v10

    goto/16 :goto_25

    :catch_2d
    move-exception v2

    move-object v11, v5

    move-object v3, v4

    move-object v4, v2

    move-object v2, v10

    goto/16 :goto_25

    :catch_2e
    move-exception v2

    move-object/from16 v25, v2

    move-object v2, v3

    move-object v3, v4

    move-object/from16 v4, v25

    goto/16 :goto_25

    :catch_2f
    move-exception v2

    move-object v9, v5

    move-object v3, v4

    move-object v4, v2

    move-object v2, v6

    goto/16 :goto_25

    :catch_30
    move-exception v2

    move-object v11, v5

    move-object v3, v4

    move-object v4, v2

    move-object v2, v10

    goto/16 :goto_25

    :catch_31
    move-exception v2

    move-object v4, v2

    move-object v11, v5

    move-object v3, v6

    move-object v2, v10

    goto/16 :goto_25

    :catch_32
    move-exception v2

    move-object v11, v5

    move-object v3, v4

    move-object v4, v2

    move-object v2, v10

    goto/16 :goto_25

    :catch_33
    move-exception v2

    move-object v11, v5

    move-object v3, v4

    move-object v4, v2

    move-object v2, v10

    goto/16 :goto_25

    :catch_34
    move-exception v2

    move-object v11, v5

    move-object v3, v4

    move-object v4, v2

    move-object v2, v10

    goto/16 :goto_25

    :catch_35
    move-exception v2

    move-object v11, v6

    move-object v3, v4

    goto/16 :goto_32

    :catch_36
    move-exception v2

    move-object v11, v5

    move-object v3, v4

    goto/16 :goto_32

    :catch_37
    move-exception v2

    move-object v9, v5

    move-object v3, v4

    goto/16 :goto_32

    :catch_38
    move-exception v2

    move-object v11, v5

    move-object v3, v4

    goto/16 :goto_32

    :catch_39
    move-exception v2

    move-object v11, v5

    move-object v3, v4

    goto/16 :goto_32

    :catch_3a
    move-exception v2

    move-object v11, v5

    move-object v3, v4

    goto/16 :goto_32

    :catch_3b
    move-exception v2

    move-object v5, v6

    move-object v3, v4

    move-object v4, v12

    goto/16 :goto_c

    :catch_3c
    move-exception v2

    move-object v5, v11

    move-object v3, v4

    move-object v4, v12

    goto/16 :goto_c

    :catch_3d
    move-exception v2

    move-object v4, v12

    move-object v3, v6

    goto/16 :goto_c

    :catch_3e
    move-exception v2

    goto/16 :goto_2f

    :catch_3f
    move-exception v2

    move-object v4, v6

    goto/16 :goto_2e

    :catch_40
    move-exception v2

    move-object v10, v3

    goto/16 :goto_24

    :catch_41
    move-exception v2

    move v3, v8

    move-object v5, v9

    move-object v6, v10

    goto/16 :goto_1d

    :catch_42
    move-exception v2

    goto/16 :goto_16

    :cond_43
    move-object/from16 v2, p0

    goto/16 :goto_12

    :cond_44
    move-object v5, v2

    goto/16 :goto_11

    :cond_45
    move v4, v7

    goto/16 :goto_10

    :cond_46
    move-object v2, v10

    goto/16 :goto_2b

    :cond_47
    move-object v2, v10

    goto/16 :goto_30

    :cond_48
    move-object/from16 v25, v5

    move-object v5, v4

    move-object/from16 v4, v25

    goto/16 :goto_23

    :cond_49
    move/from16 v19, v6

    goto/16 :goto_8
.end method

.method private static getDataFile()Ljava/io/File;
    .locals 3

    new-instance v0, Ljava/io/File;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-static {}, Lcom/glu/platform/android/resdl/GluUtil;->getLocalSaveDirectory()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "dlstatus.dat"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    return-object v0
.end method

.method private static getSecondaryFile(Ljava/lang/String;)Ljava/io/File;
    .locals 5

    const/4 v0, 0x0

    invoke-static {}, Lcom/glu/platform/android/resdl/GluUtil;->findResourceFile()Ljava/io/File;

    move-result-object v1

    if-nez v1, :cond_1

    :cond_0
    :goto_0
    return-object v0

    :cond_1
    invoke-virtual {v1}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v1

    const-string v2, "/"

    invoke-virtual {v1, v2}, Ljava/lang/String;->lastIndexOf(Ljava/lang/String;)I

    move-result v2

    const/4 v3, -0x1

    if-eq v2, v3, :cond_0

    new-instance v0, Ljava/io/File;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const/4 v3, 0x0

    const-string v4, "/"

    invoke-virtual {v1, v4}, Ljava/lang/String;->lastIndexOf(Ljava/lang/String;)I

    move-result v4

    add-int/lit8 v4, v4, 0x1

    invoke-virtual {v1, v3, v4}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    goto :goto_0
.end method

.method public static getSpecialFileSize()I
    .locals 1

    invoke-static {}, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->areThereSpecialFiles()Z

    move-result v0

    if-nez v0, :cond_0

    const/4 v0, 0x0

    :goto_0
    return v0

    :cond_0
    sget-object v0, Lcom/glu/platform/android/resdl/GameLet;->SPECIAL_RES_FILESIZE_ARRAY:[I

    invoke-static {v0}, Lcom/glu/platform/android/resdl/GluUtil;->sumIntArray([I)I

    move-result v0

    goto :goto_0
.end method

.method public static getSpecialStartPosition([I)V
    .locals 9

    const/4 v1, 0x0

    invoke-static {}, Lcom/glu/platform/android/resdl/GluUtil;->findResourceFile()Ljava/io/File;

    move-result-object v0

    if-eqz v0, :cond_1

    invoke-virtual {v0}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/glu/platform/android/resdl/GluUtil;->getFileDirectoryWithEnder(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    move v0, v1

    move v2, v1

    move v3, v1

    move v4, v1

    :goto_0
    sget-object v5, Lcom/glu/platform/android/resdl/GameLet;->SPECIAL_RES_FILENAME_ARRAY:[Ljava/lang/String;

    array-length v5, v5

    if-ge v0, v5, :cond_2

    new-instance v5, Ljava/io/File;

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v7, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    sget-object v8, Lcom/glu/platform/android/resdl/GameLet;->SPECIAL_RES_FILENAME_ARRAY:[Ljava/lang/String;

    aget-object v8, v8, v0

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-direct {v5, v7}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v5}, Ljava/io/File;->exists()Z

    move-result v7

    if-eqz v7, :cond_2

    invoke-virtual {v5}, Ljava/io/File;->length()J

    move-result-wide v7

    long-to-int v5, v7

    sget-object v7, Lcom/glu/platform/android/resdl/GameLet;->SPECIAL_RES_FILESIZE_ARRAY:[I

    aget v7, v7, v0

    if-eq v5, v7, :cond_0

    add-int/lit8 v4, v4, -0x1

    move v2, v5

    :cond_0
    add-int/lit8 v4, v4, 0x1

    add-int/2addr v3, v5

    if-nez v2, :cond_2

    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_1
    move v2, v1

    move v3, v1

    move v4, v1

    :cond_2
    aput v3, p0, v1

    const/4 v0, 0x1

    aput v4, p0, v0

    const/4 v0, 0x2

    aput v2, p0, v0

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "stats[SPECIAL_STAT_BYTE_START] = "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/glu/platform/android/resdl/Debug;->log(Ljava/lang/String;)V

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "stats[SPECIAL_STAT_NTH_FILE_START] = "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/glu/platform/android/resdl/Debug;->log(Ljava/lang/String;)V

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "stats[SPECIAL_STAT_SINGLE_FILE_BYTE_START] = "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/glu/platform/android/resdl/Debug;->log(Ljava/lang/String;)V

    return-void
.end method

.method private initialize(Z)V
    .locals 1

    iget-object v0, p0, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->m_prevVerifiedVersion:[B

    invoke-static {v0}, Lcom/glu/platform/android/resdl/GluUtil;->zero([B)V

    iget-object v0, p0, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->m_reserved:[B

    invoke-static {v0}, Lcom/glu/platform/android/resdl/GluUtil;->zero([B)V

    if-eqz p1, :cond_0

    invoke-virtual {p0}, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->saveFile()V

    :cond_0
    return-void
.end method


# virtual methods
.method public final downloadResFile()V
    .locals 1

    new-instance v0, Lcom/glu/platform/android/resdl/GluDownloadResMgr$2;

    invoke-direct {v0, p0}, Lcom/glu/platform/android/resdl/GluDownloadResMgr$2;-><init>(Lcom/glu/platform/android/resdl/GluDownloadResMgr;)V

    iput-object v0, p0, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->m_downloadThread:Ljava/lang/Thread;

    iget-object v0, p0, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->m_downloadThread:Ljava/lang/Thread;

    invoke-virtual {v0}, Ljava/lang/Thread;->start()V

    return-void
.end method

.method public final downloadSpecialResFile()V
    .locals 1

    new-instance v0, Lcom/glu/platform/android/resdl/GluDownloadResMgr$1;

    invoke-direct {v0, p0}, Lcom/glu/platform/android/resdl/GluDownloadResMgr$1;-><init>(Lcom/glu/platform/android/resdl/GluDownloadResMgr;)V

    iput-object v0, p0, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->m_downloadThread:Ljava/lang/Thread;

    iget-object v0, p0, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->m_downloadThread:Ljava/lang/Thread;

    invoke-virtual {v0}, Ljava/lang/Thread;->start()V

    return-void
.end method

.method public final getSpecialFilePartDownloaded()I
    .locals 2

    iget v0, p0, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->m_specialFilePartCompletedSoFar:I

    sget-object v1, Lcom/glu/platform/android/resdl/ResFileDownloadView;->instance:Lcom/glu/platform/android/resdl/ResFileDownloadView;

    iget v1, v1, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_bytesDownloaded:I

    add-int/2addr v0, v1

    return v0
.end method

.method public final getSpecialFilePartTotal()I
    .locals 1

    iget v0, p0, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->m_specialFilePartTotal:I

    return v0
.end method

.method public final initialize()V
    .locals 1

    const/4 v0, 0x1

    invoke-direct {p0, v0}, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->initialize(Z)V

    return-void
.end method

.method public final performSpecialChecksumAsync()Z
    .locals 4

    const/4 v1, 0x0

    const/4 v0, 0x1

    iget-object v2, p0, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->m_prevVerifiedVersion:[B

    aget-byte v2, v2, v1

    sget-object v3, Lcom/glu/platform/android/resdl/GameLet$instance;->m_versionMajor:Ljava/lang/String;

    invoke-static {v3}, Lcom/glu/platform/android/resdl/GluUtil;->safeStringToInt(Ljava/lang/String;)I

    move-result v3

    int-to-byte v3, v3

    if-ne v2, v3, :cond_1

    iget-object v2, p0, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->m_prevVerifiedVersion:[B

    aget-byte v2, v2, v0

    sget-object v3, Lcom/glu/platform/android/resdl/GameLet$instance;->m_versionMinor:Ljava/lang/String;

    invoke-static {v3}, Lcom/glu/platform/android/resdl/GluUtil;->safeStringToInt(Ljava/lang/String;)I

    move-result v3

    int-to-byte v3, v3

    if-ne v2, v3, :cond_1

    iget-object v2, p0, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->m_prevVerifiedVersion:[B

    const/4 v3, 0x2

    aget-byte v2, v2, v3

    sget-object v3, Lcom/glu/platform/android/resdl/GameLet$instance;->m_versionMicro:Ljava/lang/String;

    invoke-static {v3}, Lcom/glu/platform/android/resdl/GluUtil;->safeStringToInt(Ljava/lang/String;)I

    move-result v3

    int-to-byte v3, v3

    if-ne v2, v3, :cond_1

    iget-object v2, p0, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->m_prevVerifiedVersion:[B

    const/4 v3, 0x3

    aget-byte v2, v2, v3

    sget-object v3, Lcom/glu/platform/android/resdl/GameLet$instance;->m_versionNano:Ljava/lang/String;

    invoke-static {v3}, Lcom/glu/platform/android/resdl/GluUtil;->safeStringToInt(Ljava/lang/String;)I

    move-result v3

    int-to-byte v3, v3

    if-ne v2, v3, :cond_1

    move v2, v0

    :goto_0
    if-eqz v2, :cond_2

    const-string v1, "Verified version is current, so no checksumming special resources."

    invoke-static {v1}, Lcom/glu/platform/android/resdl/Debug;->log(Ljava/lang/String;)V

    :cond_0
    :goto_1
    return v0

    :cond_1
    move v2, v1

    goto :goto_0

    :cond_2
    sget-object v2, Lcom/glu/platform/android/resdl/GameLet;->SPECIAL_RES_FILENAME_ARRAY:[Ljava/lang/String;

    if-nez v2, :cond_3

    const-string v1, "No special resources to checksum."

    invoke-static {v1}, Lcom/glu/platform/android/resdl/Debug;->log(Ljava/lang/String;)V

    goto :goto_1

    :cond_3
    iget-boolean v2, p0, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->m_specialFilesChecksummed:Z

    if-eqz v2, :cond_4

    const-string v1, "Special files already checksummed, but not fully downloaded. Not checksumming again."

    invoke-static {v1}, Lcom/glu/platform/android/resdl/Debug;->log(Ljava/lang/String;)V

    goto :goto_1

    :cond_4
    invoke-static {}, Lcom/glu/platform/android/resdl/GluUtil;->findResourceFile()Ljava/io/File;

    move-result-object v2

    if-eqz v2, :cond_0

    iget-object v2, p0, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->m_splitSpecialDownloads:Ljava/util/Vector;

    invoke-virtual {v2}, Ljava/util/Vector;->size()I

    move-result v2

    if-lez v2, :cond_5

    const-string v2, "Reset m_splitSpecialDownloads before refilling it."

    invoke-static {v2}, Lcom/glu/platform/android/resdl/Debug;->devDie(Ljava/lang/String;)V

    iget-object v2, p0, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->m_splitSpecialDownloads:Ljava/util/Vector;

    invoke-virtual {v2}, Ljava/util/Vector;->removeAllElements()V

    :cond_5
    iput-boolean v0, p0, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->m_specialFilesBeingChecksummed:Z

    new-instance v0, Lcom/glu/platform/android/resdl/GluDownloadResMgr$3;

    invoke-direct {v0, p0}, Lcom/glu/platform/android/resdl/GluDownloadResMgr$3;-><init>(Lcom/glu/platform/android/resdl/GluDownloadResMgr;)V

    iput-object v0, p0, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->m_specialChecksumThread:Ljava/lang/Thread;

    invoke-virtual {v0}, Ljava/lang/Thread;->start()V

    move v0, v1

    goto :goto_1
.end method

.method public final saveFile()V
    .locals 5

    const/4 v0, 0x1

    const/4 v1, 0x0

    :try_start_0
    new-instance v3, Ljava/io/FileOutputStream;

    invoke-static {}, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->getDataFile()Ljava/io/File;

    move-result-object v2

    const/4 v4, 0x0

    invoke-direct {v3, v2, v4}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;Z)V

    iget-boolean v2, p0, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->m_mainResFileInterrupted:Z

    if-eqz v2, :cond_0

    move v2, v0

    :goto_0
    invoke-virtual {v3, v2}, Ljava/io/FileOutputStream;->write(I)V

    iget-boolean v2, p0, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->m_secondaryFilesPassedOnce:Z

    if-eqz v2, :cond_1

    :goto_1
    invoke-virtual {v3, v0}, Ljava/io/FileOutputStream;->write(I)V

    iget-object v0, p0, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->m_prevVerifiedVersion:[B

    invoke-virtual {v3, v0}, Ljava/io/FileOutputStream;->write([B)V

    iget-object v0, p0, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->m_reserved:[B

    invoke-virtual {v3, v0}, Ljava/io/FileOutputStream;->write([B)V

    invoke-virtual {v3}, Ljava/io/FileOutputStream;->close()V

    const-string v0, "Wrote resource download data file."

    invoke-static {v0}, Lcom/glu/platform/android/resdl/Debug;->log(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :goto_2
    return-void

    :cond_0
    move v2, v1

    goto :goto_0

    :cond_1
    move v0, v1

    goto :goto_1

    :catch_0
    move-exception v0

    const-string v1, "Error writing resource download data file."

    invoke-static {v1, v0}, Lcom/glu/platform/android/resdl/Debug;->log(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto :goto_2
.end method

.method public final setSecondaryFilesPassed(Z)V
    .locals 3

    iput-boolean p1, p0, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->m_secondaryFilesPassedOnce:Z

    if-eqz p1, :cond_0

    iget-object v0, p0, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->m_prevVerifiedVersion:[B

    const/4 v1, 0x0

    sget-object v2, Lcom/glu/platform/android/resdl/GameLet$instance;->m_versionMajor:Ljava/lang/String;

    invoke-static {v2}, Lcom/glu/platform/android/resdl/GluUtil;->safeStringToInt(Ljava/lang/String;)I

    move-result v2

    int-to-byte v2, v2

    aput-byte v2, v0, v1

    iget-object v0, p0, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->m_prevVerifiedVersion:[B

    const/4 v1, 0x1

    sget-object v2, Lcom/glu/platform/android/resdl/GameLet$instance;->m_versionMinor:Ljava/lang/String;

    invoke-static {v2}, Lcom/glu/platform/android/resdl/GluUtil;->safeStringToInt(Ljava/lang/String;)I

    move-result v2

    int-to-byte v2, v2

    aput-byte v2, v0, v1

    iget-object v0, p0, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->m_prevVerifiedVersion:[B

    const/4 v1, 0x2

    sget-object v2, Lcom/glu/platform/android/resdl/GameLet$instance;->m_versionMicro:Ljava/lang/String;

    invoke-static {v2}, Lcom/glu/platform/android/resdl/GluUtil;->safeStringToInt(Ljava/lang/String;)I

    move-result v2

    int-to-byte v2, v2

    aput-byte v2, v0, v1

    iget-object v0, p0, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->m_prevVerifiedVersion:[B

    const/4 v1, 0x3

    sget-object v2, Lcom/glu/platform/android/resdl/GameLet$instance;->m_versionNano:Ljava/lang/String;

    invoke-static {v2}, Lcom/glu/platform/android/resdl/GluUtil;->safeStringToInt(Ljava/lang/String;)I

    move-result v2

    int-to-byte v2, v2

    aput-byte v2, v0, v1

    :cond_0
    invoke-virtual {p0}, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->saveFile()V

    return-void
.end method

.method public final specialChecksumPassed()Z
    .locals 1

    iget-object v0, p0, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->m_splitSpecialDownloads:Ljava/util/Vector;

    invoke-virtual {v0}, Ljava/util/Vector;->size()I

    move-result v0

    if-nez v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public final specialFilesChecksumInProgress()Z
    .locals 1

    iget-boolean v0, p0, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->m_specialFilesBeingChecksummed:Z

    return v0
.end method

.method public final verifySpecialFileIntegrity()Z
    .locals 9

    const/4 v0, 0x1

    const/4 v1, 0x0

    sget-object v2, Lcom/glu/platform/android/resdl/GameLet;->SPECIAL_RES_FILENAME_ARRAY:[Ljava/lang/String;

    if-nez v2, :cond_1

    move v1, v0

    :cond_0
    :goto_0
    return v1

    :cond_1
    iget-boolean v2, p0, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->m_specialFilesChecksummed:Z

    if-eqz v2, :cond_2

    invoke-virtual {p0}, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->specialChecksumPassed()Z

    move-result v1

    goto :goto_0

    :cond_2
    invoke-static {}, Lcom/glu/platform/android/resdl/GluUtil;->findResourceFile()Ljava/io/File;

    move-result-object v2

    if-nez v2, :cond_3

    const-string v0, "Special files integrity assumed failed. Not even the resource is file downloaded yet."

    invoke-static {v0}, Lcom/glu/platform/android/resdl/Debug;->log(Ljava/lang/String;)V

    goto :goto_0

    :cond_3
    invoke-virtual {v2}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/glu/platform/android/resdl/GluUtil;->getFileDirectoryWithEnder(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    move v2, v0

    move v0, v1

    :goto_1
    sget-object v4, Lcom/glu/platform/android/resdl/GameLet;->SPECIAL_RES_FILENAME_ARRAY:[Ljava/lang/String;

    array-length v4, v4

    if-ge v0, v4, :cond_7

    new-instance v4, Ljava/io/File;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v5, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    sget-object v6, Lcom/glu/platform/android/resdl/GameLet;->SPECIAL_RES_FILENAME_ARRAY:[Ljava/lang/String;

    aget-object v6, v6, v0

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-direct {v4, v5}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v4}, Ljava/io/File;->exists()Z

    move-result v5

    if-eqz v5, :cond_4

    invoke-virtual {v4}, Ljava/io/File;->length()J

    move-result-wide v5

    sget-object v7, Lcom/glu/platform/android/resdl/GameLet;->SPECIAL_RES_FILESIZE_ARRAY:[I

    aget v7, v7, v0

    int-to-long v7, v7

    cmp-long v5, v5, v7

    if-eqz v5, :cond_6

    :cond_4
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "File "

    invoke-virtual {v2, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    sget-object v5, Lcom/glu/platform/android/resdl/GameLet;->SPECIAL_RES_FILENAME_ARRAY:[Ljava/lang/String;

    aget-object v5, v5, v0

    invoke-virtual {v2, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v5, " failed. f.exists()="

    invoke-virtual {v2, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v4}, Ljava/io/File;->exists()Z

    move-result v5

    invoke-virtual {v2, v5}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/glu/platform/android/resdl/Debug;->log(Ljava/lang/String;)V

    invoke-virtual {v4}, Ljava/io/File;->exists()Z

    move-result v2

    if-eqz v2, :cond_0

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "length="

    invoke-virtual {v2, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v4}, Ljava/io/File;->length()J

    move-result-wide v5

    invoke-virtual {v2, v5, v6}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v5, "  expected="

    invoke-virtual {v2, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    sget-object v5, Lcom/glu/platform/android/resdl/GameLet;->SPECIAL_RES_FILESIZE_ARRAY:[I

    aget v5, v5, v0

    invoke-virtual {v2, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/glu/platform/android/resdl/Debug;->log(Ljava/lang/String;)V

    invoke-virtual {v4}, Ljava/io/File;->length()J

    move-result-wide v5

    sget-object v2, Lcom/glu/platform/android/resdl/GameLet;->SPECIAL_RES_FILESIZE_ARRAY:[I

    aget v2, v2, v0

    int-to-long v7, v2

    cmp-long v2, v5, v7

    if-lez v2, :cond_5

    invoke-virtual {v4}, Ljava/io/File;->delete()Z

    :cond_5
    move v2, v1

    :cond_6
    add-int/lit8 v0, v0, 0x1

    goto/16 :goto_1

    :cond_7
    move v1, v2

    goto/16 :goto_0
.end method

.method public final wereSpecialFilesChecksummed()Z
    .locals 1

    iget-boolean v0, p0, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->m_specialFilesChecksummed:Z

    return v0
.end method
