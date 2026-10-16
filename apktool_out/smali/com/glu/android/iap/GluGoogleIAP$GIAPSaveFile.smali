.class final Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/glu/android/iap/GluGoogleIAP;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "GIAPSaveFile"
.end annotation

.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile$GIAPSingleItem;
    }
.end annotation


# instance fields
.field private m_exceptionOnSave:Z

.field private m_filename:Ljava/lang/String;

.field private m_items:Ljava/util/Vector;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Vector",
            "<",
            "Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile$GIAPSingleItem;",
            ">;"
        }
    .end annotation
.end field

.field private m_loaded:Z


# direct methods
.method public constructor <init>(Ljava/lang/String;)V
    .locals 2

    const/4 v1, 0x0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile;->m_filename:Ljava/lang/String;

    new-instance v0, Ljava/util/Vector;

    invoke-direct {v0}, Ljava/util/Vector;-><init>()V

    iput-object v0, p0, Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile;->m_items:Ljava/util/Vector;

    iput-boolean v1, p0, Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile;->m_loaded:Z

    iput-boolean v1, p0, Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile;->m_exceptionOnSave:Z

    iput-object p1, p0, Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile;->m_filename:Ljava/lang/String;

    return-void
.end method

.method private getTopItem()Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile$GIAPSingleItem;
    .locals 2

    const/4 v0, 0x0

    move v1, v0

    :goto_0
    iget-object v0, p0, Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile;->m_items:Ljava/util/Vector;

    invoke-virtual {v0}, Ljava/util/Vector;->size()I

    move-result v0

    if-ge v1, v0, :cond_1

    iget-object v0, p0, Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile;->m_items:Ljava/util/Vector;

    invoke-virtual {v0, v1}, Ljava/util/Vector;->elementAt(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile$GIAPSingleItem;

    invoke-static {v0}, Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile$GIAPSingleItem;->access$1800(Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile$GIAPSingleItem;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile;->m_items:Ljava/util/Vector;

    invoke-virtual {v0, v1}, Ljava/util/Vector;->elementAt(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile$GIAPSingleItem;

    :goto_1
    return-object v0

    :cond_0
    add-int/lit8 v0, v1, 0x1

    move v1, v0

    goto :goto_0

    :cond_1
    invoke-static {}, Lcom/glu/android/iap/Debug;->log$552c4e01()V

    const/4 v0, 0x0

    goto :goto_1
.end method

.method private loadFile()V
    .locals 8

    const/4 v2, 0x0

    const/4 v1, 0x1

    iget-boolean v0, p0, Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile;->m_loaded:Z

    if-eqz v0, :cond_1

    :cond_0
    :goto_0
    return-void

    :cond_1
    iput-boolean v1, p0, Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile;->m_loaded:Z

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Loading "

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v3, p0, Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile;->m_filename:Ljava/lang/String;

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    invoke-static {}, Lcom/glu/android/iap/Debug;->log$552c4e01()V

    :try_start_0
    new-instance v3, Ljava/io/File;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-static {}, Lcom/glu/android/iap/GluUtil;->getSecureSaveDirectory()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v4, p0, Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile;->m_filename:Ljava/lang/String;

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {v3, v0}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v3}, Ljava/io/File;->exists()Z

    move-result v0

    if-eqz v0, :cond_0

    new-instance v4, Ljava/io/FileInputStream;

    invoke-direct {v4, v3}, Ljava/io/FileInputStream;-><init>(Ljava/io/File;)V

    const-wide/16 v5, 0x8

    invoke-virtual {v4, v5, v6}, Ljava/io/FileInputStream;->skip(J)J

    move v0, v2

    :goto_1
    invoke-virtual {v4}, Ljava/io/FileInputStream;->available()I

    move-result v5

    if-lez v5, :cond_3

    new-instance v5, Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile$GIAPSingleItem;

    invoke-direct {v5, p0}, Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile$GIAPSingleItem;-><init>(Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile;)V

    invoke-static {v4}, Lcom/glu/android/iap/GluUtil;->readString(Ljava/io/FileInputStream;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v5, v0}, Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile$GIAPSingleItem;->access$1702(Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile$GIAPSingleItem;Ljava/lang/String;)Ljava/lang/String;

    invoke-static {v4}, Lcom/glu/android/iap/GluUtil;->readLong(Ljava/io/FileInputStream;)J

    move-result-wide v6

    invoke-static {v5, v6, v7}, Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile$GIAPSingleItem;->access$1602(Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile$GIAPSingleItem;J)J

    invoke-virtual {v4}, Ljava/io/FileInputStream;->read()I

    move-result v0

    if-ne v0, v1, :cond_2

    move v0, v1

    :goto_2
    invoke-static {v5, v0}, Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile$GIAPSingleItem;->access$1802(Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile$GIAPSingleItem;Z)Z

    invoke-static {v5}, Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile$GIAPSingleItem;->access$2100(Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile$GIAPSingleItem;)[B

    move-result-object v0

    invoke-virtual {v4, v0}, Ljava/io/FileInputStream;->read([B)I

    iget-object v0, p0, Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile;->m_items:Ljava/util/Vector;

    invoke-virtual {v0, v5}, Ljava/util/Vector;->add(Ljava/lang/Object;)Z

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "Loading "

    invoke-virtual {v0, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-static {v5}, Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile$GIAPSingleItem;->access$1700(Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile$GIAPSingleItem;)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v0, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v6, " "

    invoke-virtual {v0, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-static {v5}, Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile$GIAPSingleItem;->access$1600(Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile$GIAPSingleItem;)J

    move-result-wide v6

    invoke-virtual {v0, v6, v7}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v6, " "

    invoke-virtual {v0, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-static {v5}, Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile$GIAPSingleItem;->access$1800(Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile$GIAPSingleItem;)Z

    move-result v5

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    invoke-static {}, Lcom/glu/android/iap/Debug;->log$552c4e01()V

    move v0, v1

    goto :goto_1

    :cond_2
    move v0, v2

    goto :goto_2

    :cond_3
    invoke-virtual {v4}, Ljava/io/FileInputStream;->close()V

    if-eqz v0, :cond_0

    invoke-static {v3}, Lcom/glu/android/iap/GluUtil;->verifySecureFile(Ljava/io/File;)Z

    move-result v0

    if-nez v0, :cond_0

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "File "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile;->m_filename:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " integrity failed."

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    invoke-static {}, Lcom/glu/android/iap/Debug;->log$552c4e01()V

    invoke-virtual {v3}, Ljava/io/File;->delete()Z

    iget-object v0, p0, Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile;->m_items:Ljava/util/Vector;

    invoke-virtual {v0}, Ljava/util/Vector;->removeAllElements()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto/16 :goto_0

    :catch_0
    move-exception v0

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Exception loading file "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile;->m_filename:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ". Come on, you can be cleaner than that."

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    invoke-static {}, Lcom/glu/android/iap/Debug;->log$2d473e19()V

    goto/16 :goto_0
.end method

.method private removeTopItem()V
    .locals 2

    invoke-direct {p0}, Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile;->getTopItem()Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile$GIAPSingleItem;

    move-result-object v0

    const/4 v1, 0x1

    invoke-static {v0, v1}, Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile$GIAPSingleItem;->access$1802(Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile$GIAPSingleItem;Z)Z

    invoke-direct {p0}, Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile;->saveFile()V

    return-void
.end method

.method private saveFile()V
    .locals 9

    const/4 v1, 0x1

    const/4 v2, 0x0

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Saving "

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v3, p0, Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile;->m_filename:Ljava/lang/String;

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    invoke-static {}, Lcom/glu/android/iap/Debug;->log$552c4e01()V

    :try_start_0
    new-instance v4, Ljava/io/File;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-static {}, Lcom/glu/android/iap/GluUtil;->getSecureSaveDirectory()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v3, p0, Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile;->m_filename:Ljava/lang/String;

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {v4, v0}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-static {}, Lcom/glu/android/iap/GluUtil;->getTmpSecureFile()Ljava/io/File;

    move-result-object v0

    new-instance v5, Ljava/io/FileOutputStream;

    const/4 v3, 0x0

    invoke-direct {v5, v0, v3}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;Z)V

    move v3, v2

    :goto_0
    iget-object v0, p0, Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile;->m_items:Ljava/util/Vector;

    invoke-virtual {v0}, Ljava/util/Vector;->size()I

    move-result v0

    if-ge v3, v0, :cond_1

    iget-object v0, p0, Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile;->m_items:Ljava/util/Vector;

    invoke-virtual {v0, v3}, Ljava/util/Vector;->elementAt(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile$GIAPSingleItem;

    invoke-static {v0}, Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile$GIAPSingleItem;->access$1700(Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile$GIAPSingleItem;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v5, v0}, Lcom/glu/android/iap/GluUtil;->writeString(Ljava/io/FileOutputStream;Ljava/lang/String;)V

    iget-object v0, p0, Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile;->m_items:Ljava/util/Vector;

    invoke-virtual {v0, v3}, Ljava/util/Vector;->elementAt(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile$GIAPSingleItem;

    invoke-static {v0}, Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile$GIAPSingleItem;->access$1600(Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile$GIAPSingleItem;)J

    move-result-wide v6

    invoke-static {v5, v6, v7}, Lcom/glu/android/iap/GluUtil;->writeLong(Ljava/io/FileOutputStream;J)V

    iget-object v0, p0, Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile;->m_items:Ljava/util/Vector;

    invoke-virtual {v0, v3}, Ljava/util/Vector;->elementAt(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile$GIAPSingleItem;

    invoke-static {v0}, Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile$GIAPSingleItem;->access$1800(Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile$GIAPSingleItem;)Z

    move-result v0

    if-eqz v0, :cond_0

    move v0, v1

    :goto_1
    invoke-virtual {v5, v0}, Ljava/io/FileOutputStream;->write(I)V

    iget-object v0, p0, Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile;->m_items:Ljava/util/Vector;

    invoke-virtual {v0, v3}, Ljava/util/Vector;->elementAt(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile$GIAPSingleItem;

    invoke-static {v0}, Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile$GIAPSingleItem;->access$2100(Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile$GIAPSingleItem;)[B

    move-result-object v0

    invoke-virtual {v5, v0}, Ljava/io/FileOutputStream;->write([B)V

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "Saving "

    invoke-virtual {v0, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    iget-object v0, p0, Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile;->m_items:Ljava/util/Vector;

    invoke-virtual {v0, v3}, Ljava/util/Vector;->elementAt(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile$GIAPSingleItem;

    invoke-static {v0}, Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile$GIAPSingleItem;->access$1700(Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile$GIAPSingleItem;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v6, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v6, " "

    invoke-virtual {v0, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    iget-object v0, p0, Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile;->m_items:Ljava/util/Vector;

    invoke-virtual {v0, v3}, Ljava/util/Vector;->elementAt(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile$GIAPSingleItem;

    invoke-static {v0}, Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile$GIAPSingleItem;->access$1600(Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile$GIAPSingleItem;)J

    move-result-wide v7

    invoke-virtual {v6, v7, v8}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v6, " "

    invoke-virtual {v0, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    iget-object v0, p0, Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile;->m_items:Ljava/util/Vector;

    invoke-virtual {v0, v3}, Ljava/util/Vector;->elementAt(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile$GIAPSingleItem;

    invoke-static {v0}, Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile$GIAPSingleItem;->access$1800(Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile$GIAPSingleItem;)Z

    move-result v0

    invoke-virtual {v6, v0}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    invoke-static {}, Lcom/glu/android/iap/Debug;->log$552c4e01()V

    add-int/lit8 v0, v3, 0x1

    move v3, v0

    goto/16 :goto_0

    :cond_0
    move v0, v2

    goto :goto_1

    :cond_1
    invoke-virtual {v5}, Ljava/io/FileOutputStream;->close()V

    invoke-static {v4}, Lcom/glu/android/iap/GluUtil;->saveSecureFile(Ljava/io/File;)Z

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile;->m_exceptionOnSave:Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :goto_2
    return-void

    :catch_0
    move-exception v0

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Exception saving file "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v2, p0, Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile;->m_filename:Ljava/lang/String;

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v2, ". Come on, you can be cleaner than that."

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    invoke-static {}, Lcom/glu/android/iap/Debug;->log$2d473e19()V

    iput-boolean v1, p0, Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile;->m_exceptionOnSave:Z

    goto :goto_2
.end method


# virtual methods
.method public final addItem(Ljava/lang/String;J)V
    .locals 5

    const/4 v2, 0x0

    invoke-direct {p0}, Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile;->loadFile()V

    move v1, v2

    :goto_0
    iget-object v0, p0, Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile;->m_items:Ljava/util/Vector;

    invoke-virtual {v0}, Ljava/util/Vector;->size()I

    move-result v0

    if-ge v1, v0, :cond_1

    iget-object v0, p0, Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile;->m_items:Ljava/util/Vector;

    invoke-virtual {v0, v1}, Ljava/util/Vector;->elementAt(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile$GIAPSingleItem;

    invoke-static {v0}, Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile$GIAPSingleItem;->access$1600(Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile$GIAPSingleItem;)J

    move-result-wide v3

    cmp-long v0, v3, p2

    if-nez v0, :cond_0

    :goto_1
    return-void

    :cond_0
    add-int/lit8 v0, v1, 0x1

    move v1, v0

    goto :goto_0

    :cond_1
    new-instance v0, Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile$GIAPSingleItem;

    invoke-direct {v0, p0}, Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile$GIAPSingleItem;-><init>(Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile;)V

    invoke-static {v0, p1}, Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile$GIAPSingleItem;->access$1702(Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile$GIAPSingleItem;Ljava/lang/String;)Ljava/lang/String;

    invoke-static {v0, p2, p3}, Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile$GIAPSingleItem;->access$1602(Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile$GIAPSingleItem;J)J

    invoke-static {v0, v2}, Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile$GIAPSingleItem;->access$1802(Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile$GIAPSingleItem;Z)Z

    iget-object v1, p0, Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile;->m_items:Ljava/util/Vector;

    invoke-virtual {v1, v0}, Ljava/util/Vector;->add(Ljava/lang/Object;)Z

    invoke-direct {p0}, Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile;->saveFile()V

    goto :goto_1
.end method

.method public final hasUnhandledItems()Z
    .locals 3

    const/4 v0, 0x0

    invoke-direct {p0}, Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile;->loadFile()V

    move v1, v0

    move v2, v0

    :goto_0
    iget-object v0, p0, Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile;->m_items:Ljava/util/Vector;

    invoke-virtual {v0}, Ljava/util/Vector;->size()I

    move-result v0

    if-ge v1, v0, :cond_1

    iget-object v0, p0, Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile;->m_items:Ljava/util/Vector;

    invoke-virtual {v0, v1}, Ljava/util/Vector;->elementAt(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile$GIAPSingleItem;

    invoke-static {v0}, Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile$GIAPSingleItem;->access$1800(Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile$GIAPSingleItem;)Z

    move-result v0

    if-nez v0, :cond_0

    const/4 v2, 0x1

    :cond_0
    add-int/lit8 v0, v1, 0x1

    move v1, v0

    goto :goto_0

    :cond_1
    return v2
.end method

.method public final immediatelyGiveSpecificItem(Ljava/lang/String;)Z
    .locals 6

    const/4 v3, 0x1

    const/4 v2, 0x0

    invoke-virtual {p0}, Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile;->hasUnhandledItems()Z

    move-result v0

    if-nez v0, :cond_0

    invoke-static {}, Lcom/glu/android/iap/Debug;->log$552c4e01()V

    :goto_0
    return v2

    :cond_0
    move v1, v2

    :goto_1
    iget-object v0, p0, Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile;->m_items:Ljava/util/Vector;

    invoke-virtual {v0}, Ljava/util/Vector;->size()I

    move-result v0

    if-ge v1, v0, :cond_2

    iget-object v0, p0, Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile;->m_items:Ljava/util/Vector;

    invoke-virtual {v0, v1}, Ljava/util/Vector;->elementAt(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile$GIAPSingleItem;

    invoke-static {v0}, Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile$GIAPSingleItem;->access$1700(Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile$GIAPSingleItem;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile;->m_items:Ljava/util/Vector;

    invoke-virtual {v0, v1}, Ljava/util/Vector;->elementAt(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile$GIAPSingleItem;

    invoke-static {v0}, Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile$GIAPSingleItem;->access$1800(Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile$GIAPSingleItem;)Z

    move-result v0

    if-nez v0, :cond_1

    iget-object v0, p0, Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile;->m_items:Ljava/util/Vector;

    invoke-virtual {v0, v1}, Ljava/util/Vector;->elementAt(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile$GIAPSingleItem;

    move-object v1, v0

    :goto_2
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "immediatelyGiveSpecificItem "

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    invoke-static {}, Lcom/glu/android/iap/Debug;->log$552c4e01()V

    const/4 v4, 0x2

    sget-object v0, Lcom/glu/android/iap/IAP;->m_realToNativeProductIdHash:Ljava/util/Hashtable;

    invoke-static {v1}, Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile$GIAPSingleItem;->access$1700(Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile$GIAPSingleItem;)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v0, v5}, Ljava/util/Hashtable;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    invoke-static {v4, v2, v0}, Lcom/glu/android/iap/IAPJava;->iapCallbackEventS(IILjava/lang/String;)I

    invoke-static {v1, v3}, Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile$GIAPSingleItem;->access$1802(Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile$GIAPSingleItem;Z)Z

    invoke-direct {p0}, Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile;->saveFile()V

    move v2, v3

    goto :goto_0

    :cond_1
    add-int/lit8 v0, v1, 0x1

    move v1, v0

    goto :goto_1

    :cond_2
    invoke-static {}, Lcom/glu/android/iap/Debug;->log$552c4e01()V

    const/4 v0, 0x0

    move-object v1, v0

    goto :goto_2
.end method

.method public final isValid()Z
    .locals 1

    iget-boolean v0, p0, Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile;->m_exceptionOnSave:Z

    if-nez v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public final tryGivingOneItem(Z)Z
    .locals 3

    const/4 v0, 0x0

    invoke-virtual {p0}, Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile;->hasUnhandledItems()Z

    move-result v1

    if-nez v1, :cond_1

    invoke-static {}, Lcom/glu/android/iap/Debug;->log$552c4e01()V

    :cond_0
    :goto_0
    return v0

    :cond_1
    sget-object v1, Lcom/glu/android/iap/GluGoogleIAP;->instance:Lcom/glu/android/iap/GluGoogleIAP;

    invoke-direct {p0}, Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile;->getTopItem()Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile$GIAPSingleItem;

    move-result-object v2

    invoke-static {v2}, Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile$GIAPSingleItem;->access$1700(Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile$GIAPSingleItem;)Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2, p1}, Lcom/glu/android/iap/GluGoogleIAP;->access$1900(Lcom/glu/android/iap/GluGoogleIAP;Ljava/lang/String;Z)Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-direct {p0}, Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile;->removeTopItem()V

    const/4 v0, 0x1

    goto :goto_0
.end method

.method public final tryRefundingOneItem()Z
    .locals 3

    const/4 v0, 0x0

    invoke-virtual {p0}, Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile;->hasUnhandledItems()Z

    move-result v1

    if-nez v1, :cond_1

    invoke-static {}, Lcom/glu/android/iap/Debug;->log$552c4e01()V

    :cond_0
    :goto_0
    return v0

    :cond_1
    sget-object v1, Lcom/glu/android/iap/GluGoogleIAP;->instance:Lcom/glu/android/iap/GluGoogleIAP;

    invoke-direct {p0}, Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile;->getTopItem()Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile$GIAPSingleItem;

    move-result-object v2

    invoke-static {v2}, Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile$GIAPSingleItem;->access$1700(Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile$GIAPSingleItem;)Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/glu/android/iap/GluGoogleIAP;->access$2000(Lcom/glu/android/iap/GluGoogleIAP;Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-direct {p0}, Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile;->removeTopItem()V

    const/4 v0, 0x1

    goto :goto_0
.end method
