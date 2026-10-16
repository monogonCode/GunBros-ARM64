.class public final Lcom/openfeint/internal/offline/OfflineSupport;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/openfeint/internal/offline/OfflineSupport$DB;,
        Lcom/openfeint/internal/offline/OfflineSupport$OfflineScore;,
        Lcom/openfeint/internal/offline/OfflineSupport$OfflineAchievement;
    }
.end annotation


# static fields
.field private static db:Lcom/openfeint/internal/offline/OfflineSupport$DB;

.field private static updateInProgress:Ljava/util/concurrent/atomic/AtomicBoolean;

.field private static userID:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    const/4 v0, 0x0

    sput-object v0, Lcom/openfeint/internal/offline/OfflineSupport;->db:Lcom/openfeint/internal/offline/OfflineSupport$DB;

    sput-object v0, Lcom/openfeint/internal/offline/OfflineSupport;->userID:Ljava/lang/String;

    new-instance v0, Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;-><init>(Z)V

    sput-object v0, Lcom/openfeint/internal/offline/OfflineSupport;->updateInProgress:Ljava/util/concurrent/atomic/AtomicBoolean;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic access$000(Ljava/lang/String;Ljava/lang/String;)Z
    .locals 1

    if-nez p0, :cond_1

    if-nez p1, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0

    :cond_1
    invoke-virtual {p0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    goto :goto_0
.end method

.method static synthetic access$100(Ljava/lang/String;)V
    .locals 0

    invoke-static {p0}, Lcom/openfeint/internal/offline/OfflineSupport;->deleteDataFile(Ljava/lang/String;)V

    return-void
.end method

.method static synthetic access$200()Ljava/util/concurrent/atomic/AtomicBoolean;
    .locals 1

    sget-object v0, Lcom/openfeint/internal/offline/OfflineSupport;->updateInProgress:Ljava/util/concurrent/atomic/AtomicBoolean;

    return-object v0
.end method

.method static synthetic access$300()Lcom/openfeint/internal/offline/OfflineSupport$DB;
    .locals 1

    sget-object v0, Lcom/openfeint/internal/offline/OfflineSupport;->db:Lcom/openfeint/internal/offline/OfflineSupport$DB;

    return-object v0
.end method

.method static synthetic access$400()V
    .locals 0

    invoke-static {}, Lcom/openfeint/internal/offline/OfflineSupport;->save()V

    return-void
.end method

.method static synthetic access$500()V
    .locals 0

    invoke-static {}, Lcom/openfeint/internal/offline/OfflineSupport;->uploadScoresWithBlobs()V

    return-void
.end method

.method private static deleteDataFile(Ljava/lang/String;)V
    .locals 2

    :try_start_0
    invoke-static {}, Lcom/openfeint/internal/OpenFeintInternal;->getInstance()Lcom/openfeint/internal/OpenFeintInternal;

    move-result-object v0

    invoke-virtual {v0}, Lcom/openfeint/internal/OpenFeintInternal;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroid/content/Context;->getFileStreamPath(Ljava/lang/String;)Ljava/io/File;

    move-result-object v1

    invoke-virtual {v1}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/content/Context;->deleteFile(Ljava/lang/String;)Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return-void

    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method private static filename(Ljava/lang/String;)Ljava/lang/String;
    .locals 3

    const/4 v0, 0x0

    if-nez p0, :cond_1

    :cond_0
    :goto_0
    return-object v0

    :cond_1
    invoke-static {}, Lcom/openfeint/internal/OpenFeintInternal;->getInstance()Lcom/openfeint/internal/OpenFeintInternal;

    move-result-object v1

    invoke-virtual {v1}, Lcom/openfeint/internal/OpenFeintInternal;->getAppID()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_0

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "of.offline."

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v2, "."

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_0
.end method

.method private static fullPath(Ljava/lang/String;)Ljava/lang/String;
    .locals 1

    invoke-static {}, Lcom/openfeint/internal/OpenFeintInternal;->getInstance()Lcom/openfeint/internal/OpenFeintInternal;

    move-result-object v0

    invoke-virtual {v0}, Lcom/openfeint/internal/OpenFeintInternal;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroid/content/Context;->getFileStreamPath(Ljava/lang/String;)Ljava/io/File;

    move-result-object v0

    invoke-virtual {v0}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static getClientCompletionPercentage(Ljava/lang/String;)F
    .locals 1

    sget-object v0, Lcom/openfeint/internal/offline/OfflineSupport;->db:Lcom/openfeint/internal/offline/OfflineSupport$DB;

    invoke-virtual {v0, p0}, Lcom/openfeint/internal/offline/OfflineSupport$DB;->findAchievement(Ljava/lang/String;)Lcom/openfeint/internal/offline/OfflineSupport$OfflineAchievement;

    move-result-object v0

    if-nez v0, :cond_0

    const/4 v0, 0x0

    :goto_0
    return v0

    :cond_0
    iget v0, v0, Lcom/openfeint/internal/offline/OfflineSupport$OfflineAchievement;->clientCompletionPercentage:F

    goto :goto_0
.end method

.method private static isUserTemporary()Z
    .locals 2

    const-string v0, "0"

    sget-object v1, Lcom/openfeint/internal/offline/OfflineSupport;->userID:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    return v0
.end method

.method private static now()Ljava/lang/String;
    .locals 2

    sget-object v0, Lcom/openfeint/internal/resource/DateResourceProperty;->sDateParser:Ljava/text/DateFormat;

    new-instance v1, Ljava/util/Date;

    invoke-direct {v1}, Ljava/util/Date;-><init>()V

    invoke-virtual {v0, v1}, Ljava/text/DateFormat;->format(Ljava/util/Date;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static postOfflineScore(Lcom/openfeint/api/resource/Score;Lcom/openfeint/api/resource/Leaderboard;)V
    .locals 7

    sget-object v0, Lcom/openfeint/internal/offline/OfflineSupport;->userID:Ljava/lang/String;

    if-nez v0, :cond_1

    :cond_0
    :goto_0
    return-void

    :cond_1
    new-instance v2, Lcom/openfeint/internal/offline/OfflineSupport$OfflineScore;

    invoke-direct {v2}, Lcom/openfeint/internal/offline/OfflineSupport$OfflineScore;-><init>()V

    invoke-virtual {p1}, Lcom/openfeint/api/resource/Leaderboard;->resourceID()Ljava/lang/String;

    move-result-object v0

    iput-object v0, v2, Lcom/openfeint/internal/offline/OfflineSupport$OfflineScore;->leaderboardID:Ljava/lang/String;

    iget-wide v0, p0, Lcom/openfeint/api/resource/Score;->score:J

    iput-wide v0, v2, Lcom/openfeint/internal/offline/OfflineSupport$OfflineScore;->score:J

    iget-object v0, p0, Lcom/openfeint/api/resource/Score;->displayText:Ljava/lang/String;

    iput-object v0, v2, Lcom/openfeint/internal/offline/OfflineSupport$OfflineScore;->displayText:Ljava/lang/String;

    iget-object v0, p0, Lcom/openfeint/api/resource/Score;->customData:Ljava/lang/String;

    iput-object v0, v2, Lcom/openfeint/internal/offline/OfflineSupport$OfflineScore;->customData:Ljava/lang/String;

    invoke-static {}, Lcom/openfeint/internal/offline/OfflineSupport;->now()Ljava/lang/String;

    move-result-object v0

    iput-object v0, v2, Lcom/openfeint/internal/offline/OfflineSupport$OfflineScore;->timestamp:Ljava/lang/String;

    iget-object v0, p0, Lcom/openfeint/api/resource/Score;->blob:[B

    if-eqz v0, :cond_6

    const/4 v1, 0x0

    sget-object v0, Lcom/openfeint/internal/offline/OfflineSupport;->db:Lcom/openfeint/internal/offline/OfflineSupport$DB;

    iget-object v0, v0, Lcom/openfeint/internal/offline/OfflineSupport$DB;->scores:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :cond_2
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_7

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/openfeint/internal/offline/OfflineSupport$OfflineScore;

    iget-object v4, v2, Lcom/openfeint/internal/offline/OfflineSupport$OfflineScore;->leaderboardID:Ljava/lang/String;

    iget-object v5, v0, Lcom/openfeint/internal/offline/OfflineSupport$OfflineScore;->leaderboardID:Ljava/lang/String;

    invoke-virtual {v4, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_2

    :goto_1
    if-eqz v0, :cond_5

    iget-boolean v1, p1, Lcom/openfeint/api/resource/Leaderboard;->allowsWorseScores:Z

    if-nez v1, :cond_4

    iget-boolean v1, p1, Lcom/openfeint/api/resource/Leaderboard;->descendingSortOrder:Z

    if-eqz v1, :cond_3

    iget-wide v3, v0, Lcom/openfeint/internal/offline/OfflineSupport$OfflineScore;->score:J

    iget-wide v5, p0, Lcom/openfeint/api/resource/Score;->score:J

    cmp-long v1, v3, v5

    if-ltz v1, :cond_4

    :cond_3
    iget-boolean v1, p1, Lcom/openfeint/api/resource/Leaderboard;->descendingSortOrder:Z

    if-nez v1, :cond_0

    iget-wide v3, v0, Lcom/openfeint/internal/offline/OfflineSupport$OfflineScore;->score:J

    iget-wide v5, p0, Lcom/openfeint/api/resource/Score;->score:J

    cmp-long v1, v3, v5

    if-lez v1, :cond_0

    :cond_4
    iget-object v1, v0, Lcom/openfeint/internal/offline/OfflineSupport$OfflineScore;->blobFileName:Ljava/lang/String;

    invoke-static {v1}, Lcom/openfeint/internal/offline/OfflineSupport;->deleteDataFile(Ljava/lang/String;)V

    sget-object v1, Lcom/openfeint/internal/offline/OfflineSupport;->db:Lcom/openfeint/internal/offline/OfflineSupport$DB;

    iget-object v1, v1, Lcom/openfeint/internal/offline/OfflineSupport$DB;->scores:Ljava/util/ArrayList;

    invoke-virtual {v1, v0}, Ljava/util/ArrayList;->remove(Ljava/lang/Object;)Z

    :cond_5
    const-string v0, "unknown.blob"

    :try_start_0
    const-string v1, "SHA1"

    invoke-static {v1}, Ljava/security/MessageDigest;->getInstance(Ljava/lang/String;)Ljava/security/MessageDigest;

    move-result-object v1

    iget-object v3, p0, Lcom/openfeint/api/resource/Score;->blob:[B

    invoke-virtual {v1, v3}, Ljava/security/MessageDigest;->update([B)V

    const-string v3, "%s.blob"

    const/4 v4, 0x1

    new-array v4, v4, [Ljava/lang/Object;

    const/4 v5, 0x0

    new-instance v6, Ljava/lang/String;

    invoke-virtual {v1}, Ljava/security/MessageDigest;->digest()[B

    move-result-object v1

    invoke-static {v1}, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Hex;->encodeHex([B)[C

    move-result-object v1

    invoke-direct {v6, v1}, Ljava/lang/String;-><init>([C)V

    aput-object v6, v4, v5

    invoke-static {v3, v4}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;
    :try_end_0
    .catch Ljava/security/NoSuchAlgorithmException; {:try_start_0 .. :try_end_0} :catch_1

    move-result-object v0

    :goto_2
    :try_start_1
    iget-object v1, p0, Lcom/openfeint/api/resource/Score;->blob:[B

    invoke-static {v0}, Lcom/openfeint/internal/offline/OfflineSupport;->fullPath(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-static {v1, v3}, Lcom/openfeint/internal/Util;->saveFile([BLjava/lang/String;)V
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_0

    iput-object v0, v2, Lcom/openfeint/internal/offline/OfflineSupport$OfflineScore;->blobFileName:Ljava/lang/String;

    :cond_6
    sget-object v0, Lcom/openfeint/internal/offline/OfflineSupport;->db:Lcom/openfeint/internal/offline/OfflineSupport$DB;

    iget-object v0, v0, Lcom/openfeint/internal/offline/OfflineSupport$DB;->scores:Ljava/util/ArrayList;

    invoke-virtual {v0, v2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    invoke-static {}, Lcom/openfeint/internal/offline/OfflineSupport;->save()V

    invoke-static {}, Lcom/openfeint/internal/offline/OfflineSupport;->isUserTemporary()Z

    move-result v0

    if-nez v0, :cond_0

    const-string v0, "of_score_submitted_notification"

    invoke-static {v0}, Lcom/openfeint/internal/RR;->string(Ljava/lang/String;)I

    move-result v0

    invoke-static {v0}, Lcom/openfeint/internal/OpenFeintInternal;->getRString(I)Ljava/lang/String;

    move-result-object v0

    const-string v1, "@drawable/of_icon_highscore_notification"

    sget-object v2, Lcom/openfeint/api/Notification$Category;->HighScore:Lcom/openfeint/api/Notification$Category;

    sget-object v3, Lcom/openfeint/api/Notification$Type;->Success:Lcom/openfeint/api/Notification$Type;

    invoke-static {v0, v1, v2, v3}, Lcom/openfeint/internal/notifications/SimpleNotification;->show(Ljava/lang/String;Ljava/lang/String;Lcom/openfeint/api/Notification$Category;Lcom/openfeint/api/Notification$Type;)V

    goto/16 :goto_0

    :catch_0
    move-exception v0

    goto/16 :goto_0

    :catch_1
    move-exception v1

    goto :goto_2

    :cond_7
    move-object v0, v1

    goto/16 :goto_1
.end method

.method static final removeAndUploadNext(Lcom/openfeint/internal/offline/OfflineSupport$OfflineScore;)V
    .locals 1

    sget-object v0, Lcom/openfeint/internal/offline/OfflineSupport;->db:Lcom/openfeint/internal/offline/OfflineSupport$DB;

    iget-object v0, v0, Lcom/openfeint/internal/offline/OfflineSupport$DB;->scores:Ljava/util/ArrayList;

    invoke-virtual {v0, p0}, Ljava/util/ArrayList;->remove(Ljava/lang/Object;)Z

    invoke-static {}, Lcom/openfeint/internal/offline/OfflineSupport;->save()V

    invoke-static {}, Lcom/openfeint/internal/offline/OfflineSupport;->uploadScoresWithBlobs()V

    return-void
.end method

.method private static save()V
    .locals 7

    const/4 v0, 0x0

    sget-object v1, Lcom/openfeint/internal/offline/OfflineSupport;->userID:Ljava/lang/String;

    invoke-static {v1}, Lcom/openfeint/internal/offline/OfflineSupport;->filename(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_1

    sget-object v3, Lcom/openfeint/internal/offline/OfflineSupport;->db:Lcom/openfeint/internal/offline/OfflineSupport$DB;

    :try_start_0
    invoke-static {}, Lcom/openfeint/internal/OpenFeintInternal;->getInstance()Lcom/openfeint/internal/OpenFeintInternal;

    move-result-object v2

    invoke-virtual {v2}, Lcom/openfeint/internal/OpenFeintInternal;->getContext()Landroid/content/Context;

    move-result-object v2

    const/4 v4, 0x0

    invoke-virtual {v2, v1, v4}, Landroid/content/Context;->openFileOutput(Ljava/lang/String;I)Ljava/io/FileOutputStream;

    move-result-object v1

    invoke-static {v1}, Lcom/openfeint/internal/Encryption;->encryptionWrap(Ljava/io/OutputStream;)Ljavax/crypto/CipherOutputStream;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_7
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    move-result-object v1

    :try_start_1
    new-instance v2, Ljava/io/ObjectOutputStream;

    invoke-direct {v2, v1}, Ljava/io/ObjectOutputStream;-><init>(Ljava/io/OutputStream;)V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_8
    .catchall {:try_start_1 .. :try_end_1} :catchall_2

    const/4 v0, 0x0

    :try_start_2
    invoke-virtual {v2, v0}, Ljava/io/ObjectOutputStream;->writeInt(I)V

    iget-object v0, v3, Lcom/openfeint/internal/offline/OfflineSupport$DB;->achievements:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    invoke-virtual {v2, v0}, Ljava/io/ObjectOutputStream;->writeInt(I)V

    iget-object v0, v3, Lcom/openfeint/internal/offline/OfflineSupport$DB;->achievements:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v4

    :goto_0
    invoke-interface {v4}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_2

    invoke-interface {v4}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/openfeint/internal/offline/OfflineSupport$OfflineAchievement;

    iget-object v5, v0, Lcom/openfeint/internal/offline/OfflineSupport$OfflineAchievement;->resourceID:Ljava/lang/String;

    invoke-virtual {v2, v5}, Ljava/io/ObjectOutputStream;->writeObject(Ljava/lang/Object;)V

    iget v5, v0, Lcom/openfeint/internal/offline/OfflineSupport$OfflineAchievement;->clientCompletionPercentage:F

    invoke-virtual {v2, v5}, Ljava/io/ObjectOutputStream;->writeFloat(F)V

    iget v5, v0, Lcom/openfeint/internal/offline/OfflineSupport$OfflineAchievement;->serverCompletionPercentage:F

    invoke-virtual {v2, v5}, Ljava/io/ObjectOutputStream;->writeFloat(F)V

    iget-object v0, v0, Lcom/openfeint/internal/offline/OfflineSupport$OfflineAchievement;->timestamp:Ljava/lang/String;

    invoke-virtual {v2, v0}, Ljava/io/ObjectOutputStream;->writeObject(Ljava/lang/Object;)V
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_0
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    goto :goto_0

    :catch_0
    move-exception v0

    move-object v0, v1

    move-object v1, v2

    :goto_1
    if-eqz v1, :cond_0

    :try_start_3
    invoke-virtual {v1}, Ljava/io/ObjectOutputStream;->close()V
    :try_end_3
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_3

    :cond_0
    :goto_2
    if-eqz v0, :cond_1

    :try_start_4
    invoke-virtual {v0}, Ljava/io/OutputStream;->close()V
    :try_end_4
    .catch Ljava/io/IOException; {:try_start_4 .. :try_end_4} :catch_4

    :cond_1
    :goto_3
    return-void

    :cond_2
    :try_start_5
    iget-object v0, v3, Lcom/openfeint/internal/offline/OfflineSupport$DB;->scores:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    invoke-virtual {v2, v0}, Ljava/io/ObjectOutputStream;->writeInt(I)V

    iget-object v0, v3, Lcom/openfeint/internal/offline/OfflineSupport$DB;->scores:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :goto_4
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_5

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/openfeint/internal/offline/OfflineSupport$OfflineScore;

    iget-object v4, v0, Lcom/openfeint/internal/offline/OfflineSupport$OfflineScore;->leaderboardID:Ljava/lang/String;

    invoke-virtual {v2, v4}, Ljava/io/ObjectOutputStream;->writeObject(Ljava/lang/Object;)V

    iget-wide v4, v0, Lcom/openfeint/internal/offline/OfflineSupport$OfflineScore;->score:J

    invoke-virtual {v2, v4, v5}, Ljava/io/ObjectOutputStream;->writeLong(J)V

    iget-object v4, v0, Lcom/openfeint/internal/offline/OfflineSupport$OfflineScore;->displayText:Ljava/lang/String;

    invoke-virtual {v2, v4}, Ljava/io/ObjectOutputStream;->writeObject(Ljava/lang/Object;)V

    iget-object v4, v0, Lcom/openfeint/internal/offline/OfflineSupport$OfflineScore;->customData:Ljava/lang/String;

    invoke-virtual {v2, v4}, Ljava/io/ObjectOutputStream;->writeObject(Ljava/lang/Object;)V

    iget-object v4, v0, Lcom/openfeint/internal/offline/OfflineSupport$OfflineScore;->blobFileName:Ljava/lang/String;

    invoke-virtual {v2, v4}, Ljava/io/ObjectOutputStream;->writeObject(Ljava/lang/Object;)V

    iget-object v0, v0, Lcom/openfeint/internal/offline/OfflineSupport$OfflineScore;->timestamp:Ljava/lang/String;

    invoke-virtual {v2, v0}, Ljava/io/ObjectOutputStream;->writeObject(Ljava/lang/Object;)V
    :try_end_5
    .catch Ljava/lang/Exception; {:try_start_5 .. :try_end_5} :catch_0
    .catchall {:try_start_5 .. :try_end_5} :catchall_0

    goto :goto_4

    :catchall_0
    move-exception v0

    :goto_5
    if-eqz v2, :cond_3

    :try_start_6
    invoke-virtual {v2}, Ljava/io/ObjectOutputStream;->close()V
    :try_end_6
    .catch Ljava/io/IOException; {:try_start_6 .. :try_end_6} :catch_5

    :cond_3
    :goto_6
    if-eqz v1, :cond_4

    :try_start_7
    invoke-virtual {v1}, Ljava/io/OutputStream;->close()V
    :try_end_7
    .catch Ljava/io/IOException; {:try_start_7 .. :try_end_7} :catch_6

    :cond_4
    :goto_7
    throw v0

    :cond_5
    :try_start_8
    invoke-virtual {v2}, Ljava/io/ObjectOutputStream;->close()V
    :try_end_8
    .catch Ljava/lang/Exception; {:try_start_8 .. :try_end_8} :catch_0
    .catchall {:try_start_8 .. :try_end_8} :catchall_0

    :try_start_9
    invoke-virtual {v2}, Ljava/io/ObjectOutputStream;->close()V
    :try_end_9
    .catch Ljava/io/IOException; {:try_start_9 .. :try_end_9} :catch_2

    :goto_8
    if-eqz v1, :cond_1

    :try_start_a
    invoke-virtual {v1}, Ljava/io/OutputStream;->close()V
    :try_end_a
    .catch Ljava/io/IOException; {:try_start_a .. :try_end_a} :catch_1

    goto :goto_3

    :catch_1
    move-exception v0

    goto :goto_3

    :catch_2
    move-exception v0

    goto :goto_8

    :catch_3
    move-exception v1

    goto :goto_2

    :catch_4
    move-exception v0

    goto :goto_3

    :catch_5
    move-exception v2

    goto :goto_6

    :catch_6
    move-exception v1

    goto :goto_7

    :catchall_1
    move-exception v1

    move-object v2, v0

    move-object v6, v0

    move-object v0, v1

    move-object v1, v6

    goto :goto_5

    :catchall_2
    move-exception v2

    move-object v6, v2

    move-object v2, v0

    move-object v0, v6

    goto :goto_5

    :catch_7
    move-exception v1

    move-object v1, v0

    goto :goto_1

    :catch_8
    move-exception v2

    move-object v6, v1

    move-object v1, v0

    move-object v0, v6

    goto :goto_1
.end method

.method public static setUserDeclined()V
    .locals 1

    const/4 v0, 0x0

    invoke-static {v0}, Lcom/openfeint/internal/offline/OfflineSupport;->setUserID(Ljava/lang/String;)V

    return-void
.end method

.method public static setUserID(Ljava/lang/String;)V
    .locals 7

    if-eqz p0, :cond_0

    sget-object v0, Lcom/openfeint/internal/offline/OfflineSupport;->userID:Ljava/lang/String;

    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    :goto_0
    return-void

    :cond_0
    invoke-static {p0}, Lcom/openfeint/internal/offline/OfflineSupport;->filename(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/openfeint/internal/offline/OfflineSupport$DB;->load(Ljava/lang/String;)Lcom/openfeint/internal/offline/OfflineSupport$DB;

    move-result-object v1

    invoke-static {}, Lcom/openfeint/internal/offline/OfflineSupport;->isUserTemporary()Z

    move-result v0

    if-eqz v0, :cond_4

    sget-object v2, Lcom/openfeint/internal/offline/OfflineSupport;->db:Lcom/openfeint/internal/offline/OfflineSupport$DB;

    iget-object v0, v1, Lcom/openfeint/internal/offline/OfflineSupport$DB;->achievements:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :goto_1
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_3

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/openfeint/internal/offline/OfflineSupport$OfflineAchievement;

    iget-object v4, v0, Lcom/openfeint/internal/offline/OfflineSupport$OfflineAchievement;->resourceID:Ljava/lang/String;

    invoke-virtual {v2, v4}, Lcom/openfeint/internal/offline/OfflineSupport$DB;->findAchievement(Ljava/lang/String;)Lcom/openfeint/internal/offline/OfflineSupport$OfflineAchievement;

    move-result-object v4

    if-nez v4, :cond_1

    iget-object v4, v2, Lcom/openfeint/internal/offline/OfflineSupport$DB;->achievements:Ljava/util/ArrayList;

    invoke-virtual {v0}, Lcom/openfeint/internal/offline/OfflineSupport$OfflineAchievement;->dup()Lcom/openfeint/internal/offline/OfflineSupport$OfflineAchievement;

    move-result-object v0

    invoke-virtual {v4, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_1

    :cond_1
    iget v5, v4, Lcom/openfeint/internal/offline/OfflineSupport$OfflineAchievement;->clientCompletionPercentage:F

    iget v6, v0, Lcom/openfeint/internal/offline/OfflineSupport$OfflineAchievement;->clientCompletionPercentage:F

    cmpg-float v5, v5, v6

    if-gez v5, :cond_2

    iget v5, v0, Lcom/openfeint/internal/offline/OfflineSupport$OfflineAchievement;->clientCompletionPercentage:F

    iput v5, v4, Lcom/openfeint/internal/offline/OfflineSupport$OfflineAchievement;->clientCompletionPercentage:F

    iget-object v5, v0, Lcom/openfeint/internal/offline/OfflineSupport$OfflineAchievement;->timestamp:Ljava/lang/String;

    iput-object v5, v4, Lcom/openfeint/internal/offline/OfflineSupport$OfflineAchievement;->timestamp:Ljava/lang/String;

    :cond_2
    iget v5, v4, Lcom/openfeint/internal/offline/OfflineSupport$OfflineAchievement;->serverCompletionPercentage:F

    iget v0, v0, Lcom/openfeint/internal/offline/OfflineSupport$OfflineAchievement;->serverCompletionPercentage:F

    invoke-static {v5, v0}, Ljava/lang/Math;->max(FF)F

    move-result v0

    iput v0, v4, Lcom/openfeint/internal/offline/OfflineSupport$OfflineAchievement;->serverCompletionPercentage:F

    goto :goto_1

    :cond_3
    iget-object v0, v2, Lcom/openfeint/internal/offline/OfflineSupport$DB;->scores:Ljava/util/ArrayList;

    iget-object v1, v1, Lcom/openfeint/internal/offline/OfflineSupport$DB;->scores:Ljava/util/ArrayList;

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->addAll(Ljava/util/Collection;)Z

    const-string v0, "0"

    invoke-static {v0}, Lcom/openfeint/internal/offline/OfflineSupport;->filename(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/openfeint/internal/offline/OfflineSupport;->deleteDataFile(Ljava/lang/String;)V

    :goto_2
    sput-object p0, Lcom/openfeint/internal/offline/OfflineSupport;->userID:Ljava/lang/String;

    invoke-static {}, Lcom/openfeint/internal/offline/OfflineSupport;->trySubmitOfflineData()V

    goto :goto_0

    :cond_4
    sput-object v1, Lcom/openfeint/internal/offline/OfflineSupport;->db:Lcom/openfeint/internal/offline/OfflineSupport$DB;

    goto :goto_2
.end method

.method public static setUserTemporary()V
    .locals 1

    const-string v0, "0"

    invoke-static {v0}, Lcom/openfeint/internal/offline/OfflineSupport;->setUserID(Ljava/lang/String;)V

    return-void
.end method

.method public static trySubmitOfflineData()V
    .locals 2

    sget-object v0, Lcom/openfeint/internal/offline/OfflineSupport;->userID:Ljava/lang/String;

    if-eqz v0, :cond_0

    sget-object v0, Lcom/openfeint/internal/offline/OfflineSupport;->userID:Ljava/lang/String;

    const-string v1, "0"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    invoke-static {}, Lcom/openfeint/internal/OpenFeintInternal;->getInstance()Lcom/openfeint/internal/OpenFeintInternal;

    move-result-object v0

    invoke-virtual {v0}, Lcom/openfeint/internal/OpenFeintInternal;->isUserLoggedIn()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-static {}, Lcom/openfeint/internal/offline/OfflineSupport;->updateToServer()V

    :cond_0
    return-void
.end method

.method public static updateClientCompletionPercentage(Ljava/lang/String;F)V
    .locals 2

    sget-object v0, Lcom/openfeint/internal/offline/OfflineSupport;->userID:Ljava/lang/String;

    if-nez v0, :cond_1

    :cond_0
    :goto_0
    return-void

    :cond_1
    sget-object v0, Lcom/openfeint/internal/offline/OfflineSupport;->db:Lcom/openfeint/internal/offline/OfflineSupport$DB;

    invoke-virtual {v0, p0}, Lcom/openfeint/internal/offline/OfflineSupport$DB;->findAchievement(Ljava/lang/String;)Lcom/openfeint/internal/offline/OfflineSupport$OfflineAchievement;

    move-result-object v0

    if-nez v0, :cond_2

    new-instance v0, Lcom/openfeint/internal/offline/OfflineSupport$OfflineAchievement;

    invoke-direct {v0}, Lcom/openfeint/internal/offline/OfflineSupport$OfflineAchievement;-><init>()V

    iput-object p0, v0, Lcom/openfeint/internal/offline/OfflineSupport$OfflineAchievement;->resourceID:Ljava/lang/String;

    const/4 v1, 0x0

    iput v1, v0, Lcom/openfeint/internal/offline/OfflineSupport$OfflineAchievement;->serverCompletionPercentage:F

    iput p1, v0, Lcom/openfeint/internal/offline/OfflineSupport$OfflineAchievement;->clientCompletionPercentage:F

    invoke-static {}, Lcom/openfeint/internal/offline/OfflineSupport;->now()Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/openfeint/internal/offline/OfflineSupport$OfflineAchievement;->timestamp:Ljava/lang/String;

    sget-object v1, Lcom/openfeint/internal/offline/OfflineSupport;->db:Lcom/openfeint/internal/offline/OfflineSupport$DB;

    iget-object v1, v1, Lcom/openfeint/internal/offline/OfflineSupport$DB;->achievements:Ljava/util/ArrayList;

    invoke-virtual {v1, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    invoke-static {}, Lcom/openfeint/internal/offline/OfflineSupport;->save()V

    goto :goto_0

    :cond_2
    iget v1, v0, Lcom/openfeint/internal/offline/OfflineSupport$OfflineAchievement;->clientCompletionPercentage:F

    cmpg-float v1, v1, p1

    if-gez v1, :cond_0

    iput p1, v0, Lcom/openfeint/internal/offline/OfflineSupport$OfflineAchievement;->clientCompletionPercentage:F

    invoke-static {}, Lcom/openfeint/internal/offline/OfflineSupport;->now()Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/openfeint/internal/offline/OfflineSupport$OfflineAchievement;->timestamp:Ljava/lang/String;

    invoke-static {}, Lcom/openfeint/internal/offline/OfflineSupport;->save()V

    goto :goto_0
.end method

.method public static updateServerCompletionPercentage(Ljava/lang/String;F)V
    .locals 2

    sget-object v0, Lcom/openfeint/internal/offline/OfflineSupport;->userID:Ljava/lang/String;

    if-nez v0, :cond_0

    :goto_0
    return-void

    :cond_0
    sget-object v0, Lcom/openfeint/internal/offline/OfflineSupport;->db:Lcom/openfeint/internal/offline/OfflineSupport$DB;

    invoke-virtual {v0, p0}, Lcom/openfeint/internal/offline/OfflineSupport$DB;->findAchievement(Ljava/lang/String;)Lcom/openfeint/internal/offline/OfflineSupport$OfflineAchievement;

    move-result-object v0

    if-nez v0, :cond_1

    new-instance v0, Lcom/openfeint/internal/offline/OfflineSupport$OfflineAchievement;

    invoke-direct {v0}, Lcom/openfeint/internal/offline/OfflineSupport$OfflineAchievement;-><init>()V

    iput-object p0, v0, Lcom/openfeint/internal/offline/OfflineSupport$OfflineAchievement;->resourceID:Ljava/lang/String;

    iput p1, v0, Lcom/openfeint/internal/offline/OfflineSupport$OfflineAchievement;->clientCompletionPercentage:F

    sget-object v1, Lcom/openfeint/internal/offline/OfflineSupport;->db:Lcom/openfeint/internal/offline/OfflineSupport$DB;

    iget-object v1, v1, Lcom/openfeint/internal/offline/OfflineSupport$DB;->achievements:Ljava/util/ArrayList;

    invoke-virtual {v1, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    :cond_1
    iput p1, v0, Lcom/openfeint/internal/offline/OfflineSupport$OfflineAchievement;->serverCompletionPercentage:F

    invoke-static {}, Lcom/openfeint/internal/offline/OfflineSupport;->now()Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/openfeint/internal/offline/OfflineSupport$OfflineAchievement;->timestamp:Ljava/lang/String;

    invoke-static {}, Lcom/openfeint/internal/offline/OfflineSupport;->save()V

    goto :goto_0
.end method

.method private static declared-synchronized updateToServer()V
    .locals 13

    const/4 v2, 0x0

    const-class v3, Lcom/openfeint/internal/offline/OfflineSupport;

    monitor-enter v3

    :try_start_0
    sget-object v0, Lcom/openfeint/internal/offline/OfflineSupport;->updateInProgress:Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v1, 0x0

    const/4 v4, 0x1

    invoke-virtual {v0, v1, v4}, Ljava/util/concurrent/atomic/AtomicBoolean;->compareAndSet(ZZ)Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result v0

    if-nez v0, :cond_0

    :goto_0
    monitor-exit v3

    return-void

    :cond_0
    :try_start_1
    sget-object v1, Lcom/openfeint/internal/offline/OfflineSupport;->db:Lcom/openfeint/internal/offline/OfflineSupport$DB;

    new-instance v4, Lcom/openfeint/internal/offline/OfflineSupport$DB;

    invoke-direct {v4}, Lcom/openfeint/internal/offline/OfflineSupport$DB;-><init>()V

    iget-object v0, v1, Lcom/openfeint/internal/offline/OfflineSupport$DB;->scores:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v5

    :goto_1
    invoke-interface {v5}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-interface {v5}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/openfeint/internal/offline/OfflineSupport$OfflineScore;

    iget-object v6, v4, Lcom/openfeint/internal/offline/OfflineSupport$DB;->scores:Ljava/util/ArrayList;

    new-instance v7, Lcom/openfeint/internal/offline/OfflineSupport$OfflineScore;

    invoke-direct {v7}, Lcom/openfeint/internal/offline/OfflineSupport$OfflineScore;-><init>()V

    iget-object v8, v0, Lcom/openfeint/internal/offline/OfflineSupport$OfflineScore;->leaderboardID:Ljava/lang/String;

    iput-object v8, v7, Lcom/openfeint/internal/offline/OfflineSupport$OfflineScore;->leaderboardID:Ljava/lang/String;

    iget-wide v8, v0, Lcom/openfeint/internal/offline/OfflineSupport$OfflineScore;->score:J

    iput-wide v8, v7, Lcom/openfeint/internal/offline/OfflineSupport$OfflineScore;->score:J

    iget-object v8, v0, Lcom/openfeint/internal/offline/OfflineSupport$OfflineScore;->displayText:Ljava/lang/String;

    iput-object v8, v7, Lcom/openfeint/internal/offline/OfflineSupport$OfflineScore;->displayText:Ljava/lang/String;

    iget-object v8, v0, Lcom/openfeint/internal/offline/OfflineSupport$OfflineScore;->customData:Ljava/lang/String;

    iput-object v8, v7, Lcom/openfeint/internal/offline/OfflineSupport$OfflineScore;->customData:Ljava/lang/String;

    iget-object v8, v0, Lcom/openfeint/internal/offline/OfflineSupport$OfflineScore;->blobFileName:Ljava/lang/String;

    iput-object v8, v7, Lcom/openfeint/internal/offline/OfflineSupport$OfflineScore;->blobFileName:Ljava/lang/String;

    iget-object v0, v0, Lcom/openfeint/internal/offline/OfflineSupport$OfflineScore;->timestamp:Ljava/lang/String;

    iput-object v0, v7, Lcom/openfeint/internal/offline/OfflineSupport$OfflineScore;->timestamp:Ljava/lang/String;

    invoke-virtual {v6, v7}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_1

    :catchall_0
    move-exception v0

    monitor-exit v3

    throw v0

    :cond_1
    :try_start_2
    iget-object v0, v1, Lcom/openfeint/internal/offline/OfflineSupport$DB;->achievements:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_2
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_2

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/openfeint/internal/offline/OfflineSupport$OfflineAchievement;

    iget-object v5, v4, Lcom/openfeint/internal/offline/OfflineSupport$DB;->achievements:Ljava/util/ArrayList;

    invoke-virtual {v0}, Lcom/openfeint/internal/offline/OfflineSupport$OfflineAchievement;->dup()Lcom/openfeint/internal/offline/OfflineSupport$OfflineAchievement;

    move-result-object v0

    invoke-virtual {v5, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_2

    :cond_2
    new-instance v5, Lcom/openfeint/internal/request/OrderedArgList;

    invoke-direct {v5}, Lcom/openfeint/internal/request/OrderedArgList;-><init>()V

    iget-object v0, v4, Lcom/openfeint/internal/offline/OfflineSupport$DB;->achievements:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v6

    move v1, v2

    :goto_3
    invoke-interface {v6}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_3

    invoke-interface {v6}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/openfeint/internal/offline/OfflineSupport$OfflineAchievement;

    iget v7, v0, Lcom/openfeint/internal/offline/OfflineSupport$OfflineAchievement;->clientCompletionPercentage:F

    iget v8, v0, Lcom/openfeint/internal/offline/OfflineSupport$OfflineAchievement;->serverCompletionPercentage:F

    cmpl-float v7, v7, v8

    if-eqz v7, :cond_9

    const-string v7, "OfflineSupport"

    const-string v8, "Updating achievement %s from known %f to %f completion"

    const/4 v9, 0x3

    new-array v9, v9, [Ljava/lang/Object;

    const/4 v10, 0x0

    iget-object v11, v0, Lcom/openfeint/internal/offline/OfflineSupport$OfflineAchievement;->resourceID:Ljava/lang/String;

    aput-object v11, v9, v10

    const/4 v10, 0x1

    iget v11, v0, Lcom/openfeint/internal/offline/OfflineSupport$OfflineAchievement;->serverCompletionPercentage:F

    invoke-static {v11}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object v11

    aput-object v11, v9, v10

    const/4 v10, 0x2

    iget v11, v0, Lcom/openfeint/internal/offline/OfflineSupport$OfflineAchievement;->clientCompletionPercentage:F

    invoke-static {v11}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object v11

    aput-object v11, v9, v10

    invoke-static {v8, v9}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v8

    invoke-static {v7, v8}, Lcom/openfeint/internal/logcat/OFLog;->d(Ljava/lang/String;Ljava/lang/String;)V

    const-string v7, "achievements[%d][id]"

    const/4 v8, 0x1

    new-array v8, v8, [Ljava/lang/Object;

    const/4 v9, 0x0

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v10

    aput-object v10, v8, v9

    invoke-static {v7, v8}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v7

    iget-object v8, v0, Lcom/openfeint/internal/offline/OfflineSupport$OfflineAchievement;->resourceID:Ljava/lang/String;

    invoke-virtual {v5, v7, v8}, Lcom/openfeint/internal/request/OrderedArgList;->put(Ljava/lang/String;Ljava/lang/String;)V

    const-string v7, "achievements[%d][percent_complete]"

    const/4 v8, 0x1

    new-array v8, v8, [Ljava/lang/Object;

    const/4 v9, 0x0

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v10

    aput-object v10, v8, v9

    invoke-static {v7, v8}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v7

    iget v8, v0, Lcom/openfeint/internal/offline/OfflineSupport$OfflineAchievement;->clientCompletionPercentage:F

    invoke-static {v8}, Ljava/lang/Float;->toString(F)Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v5, v7, v8}, Lcom/openfeint/internal/request/OrderedArgList;->put(Ljava/lang/String;Ljava/lang/String;)V

    const-string v7, "achievements[%d][timestamp]"

    const/4 v8, 0x1

    new-array v8, v8, [Ljava/lang/Object;

    const/4 v9, 0x0

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v10

    aput-object v10, v8, v9

    invoke-static {v7, v8}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v7

    iget-object v0, v0, Lcom/openfeint/internal/offline/OfflineSupport$OfflineAchievement;->timestamp:Ljava/lang/String;

    invoke-virtual {v5, v7, v0}, Lcom/openfeint/internal/request/OrderedArgList;->put(Ljava/lang/String;Ljava/lang/String;)V

    add-int/lit8 v0, v1, 0x1

    :goto_4
    move v1, v0

    goto :goto_3

    :cond_3
    iget-object v0, v4, Lcom/openfeint/internal/offline/OfflineSupport$DB;->scores:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v6

    :goto_5
    invoke-interface {v6}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_6

    invoke-interface {v6}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/openfeint/internal/offline/OfflineSupport$OfflineScore;

    iget-object v7, v0, Lcom/openfeint/internal/offline/OfflineSupport$OfflineScore;->blobFileName:Ljava/lang/String;

    if-nez v7, :cond_8

    const-string v7, "OfflineSupport"

    const-string v8, "Posting score %d to leaderboard %s"

    const/4 v9, 0x2

    new-array v9, v9, [Ljava/lang/Object;

    const/4 v10, 0x0

    iget-wide v11, v0, Lcom/openfeint/internal/offline/OfflineSupport$OfflineScore;->score:J

    invoke-static {v11, v12}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v11

    aput-object v11, v9, v10

    const/4 v10, 0x1

    iget-object v11, v0, Lcom/openfeint/internal/offline/OfflineSupport$OfflineScore;->leaderboardID:Ljava/lang/String;

    aput-object v11, v9, v10

    invoke-static {v8, v9}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v8

    invoke-static {v7, v8}, Lcom/openfeint/internal/logcat/OFLog;->d(Ljava/lang/String;Ljava/lang/String;)V

    const-string v7, "high_scores[%d][leaderboard_id]"

    const/4 v8, 0x1

    new-array v8, v8, [Ljava/lang/Object;

    const/4 v9, 0x0

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v10

    aput-object v10, v8, v9

    invoke-static {v7, v8}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v7

    iget-object v8, v0, Lcom/openfeint/internal/offline/OfflineSupport$OfflineScore;->leaderboardID:Ljava/lang/String;

    invoke-virtual {v5, v7, v8}, Lcom/openfeint/internal/request/OrderedArgList;->put(Ljava/lang/String;Ljava/lang/String;)V

    const-string v7, "high_scores[%d][score]"

    const/4 v8, 0x1

    new-array v8, v8, [Ljava/lang/Object;

    const/4 v9, 0x0

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v10

    aput-object v10, v8, v9

    invoke-static {v7, v8}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v7

    iget-wide v8, v0, Lcom/openfeint/internal/offline/OfflineSupport$OfflineScore;->score:J

    invoke-static {v8, v9}, Ljava/lang/Long;->toString(J)Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v5, v7, v8}, Lcom/openfeint/internal/request/OrderedArgList;->put(Ljava/lang/String;Ljava/lang/String;)V

    iget-object v7, v0, Lcom/openfeint/internal/offline/OfflineSupport$OfflineScore;->displayText:Ljava/lang/String;

    if-eqz v7, :cond_4

    const-string v7, "high_scores[%d][display_text]"

    const/4 v8, 0x1

    new-array v8, v8, [Ljava/lang/Object;

    const/4 v9, 0x0

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v10

    aput-object v10, v8, v9

    invoke-static {v7, v8}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v7

    iget-object v8, v0, Lcom/openfeint/internal/offline/OfflineSupport$OfflineScore;->displayText:Ljava/lang/String;

    invoke-virtual {v5, v7, v8}, Lcom/openfeint/internal/request/OrderedArgList;->put(Ljava/lang/String;Ljava/lang/String;)V

    :cond_4
    iget-object v7, v0, Lcom/openfeint/internal/offline/OfflineSupport$OfflineScore;->customData:Ljava/lang/String;

    if-eqz v7, :cond_5

    const-string v7, "high_scores[%d][custom_data]"

    const/4 v8, 0x1

    new-array v8, v8, [Ljava/lang/Object;

    const/4 v9, 0x0

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v10

    aput-object v10, v8, v9

    invoke-static {v7, v8}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v7

    iget-object v8, v0, Lcom/openfeint/internal/offline/OfflineSupport$OfflineScore;->customData:Ljava/lang/String;

    invoke-virtual {v5, v7, v8}, Lcom/openfeint/internal/request/OrderedArgList;->put(Ljava/lang/String;Ljava/lang/String;)V

    :cond_5
    const-string v7, "high_scores[%d][timestamp]"

    const/4 v8, 0x1

    new-array v8, v8, [Ljava/lang/Object;

    const/4 v9, 0x0

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v10

    aput-object v10, v8, v9

    invoke-static {v7, v8}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v7

    iget-object v0, v0, Lcom/openfeint/internal/offline/OfflineSupport$OfflineScore;->timestamp:Ljava/lang/String;

    invoke-virtual {v5, v7, v0}, Lcom/openfeint/internal/request/OrderedArgList;->put(Ljava/lang/String;Ljava/lang/String;)V

    add-int/lit8 v0, v2, 0x1

    :goto_6
    move v2, v0

    goto/16 :goto_5

    :cond_6
    if-nez v1, :cond_7

    if-nez v2, :cond_7

    invoke-static {}, Lcom/openfeint/internal/offline/OfflineSupport;->uploadScoresWithBlobs()V

    goto/16 :goto_0

    :cond_7
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "/xp/games/"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-static {}, Lcom/openfeint/internal/OpenFeintInternal;->getInstance()Lcom/openfeint/internal/OpenFeintInternal;

    move-result-object v1

    invoke-virtual {v1}, Lcom/openfeint/internal/OpenFeintInternal;->getAppID()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "/offline_syncs"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    new-instance v1, Lcom/openfeint/internal/offline/OfflineSupport$2;

    invoke-direct {v1, v5, v0, v4}, Lcom/openfeint/internal/offline/OfflineSupport$2;-><init>(Lcom/openfeint/internal/request/OrderedArgList;Ljava/lang/String;Lcom/openfeint/internal/offline/OfflineSupport$DB;)V

    invoke-virtual {v1}, Lcom/openfeint/internal/offline/OfflineSupport$2;->launch()V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    goto/16 :goto_0

    :cond_8
    move v0, v2

    goto :goto_6

    :cond_9
    move v0, v1

    goto/16 :goto_4
.end method

.method private static uploadScoresWithBlobs()V
    .locals 5

    sget-object v0, Lcom/openfeint/internal/offline/OfflineSupport;->db:Lcom/openfeint/internal/offline/OfflineSupport$DB;

    iget-object v0, v0, Lcom/openfeint/internal/offline/OfflineSupport$DB;->scores:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :cond_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_2

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/openfeint/internal/offline/OfflineSupport$OfflineScore;

    iget-object v2, v0, Lcom/openfeint/internal/offline/OfflineSupport$OfflineScore;->blobFileName:Ljava/lang/String;

    if-eqz v2, :cond_0

    new-instance v1, Lcom/openfeint/api/resource/Score;

    iget-wide v2, v0, Lcom/openfeint/internal/offline/OfflineSupport$OfflineScore;->score:J

    invoke-direct {v1, v2, v3}, Lcom/openfeint/api/resource/Score;-><init>(J)V

    iget-object v2, v0, Lcom/openfeint/internal/offline/OfflineSupport$OfflineScore;->customData:Ljava/lang/String;

    iput-object v2, v1, Lcom/openfeint/api/resource/Score;->customData:Ljava/lang/String;

    iget-object v2, v0, Lcom/openfeint/internal/offline/OfflineSupport$OfflineScore;->displayText:Ljava/lang/String;

    iput-object v2, v1, Lcom/openfeint/api/resource/Score;->displayText:Ljava/lang/String;

    :try_start_0
    iget-object v2, v0, Lcom/openfeint/internal/offline/OfflineSupport$OfflineScore;->blobFileName:Ljava/lang/String;

    invoke-static {v2}, Lcom/openfeint/internal/offline/OfflineSupport;->fullPath(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/openfeint/internal/Util;->readWholeFile(Ljava/lang/String;)[B

    move-result-object v2

    iput-object v2, v1, Lcom/openfeint/api/resource/Score;->blob:[B
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    iget-object v2, v1, Lcom/openfeint/api/resource/Score;->blob:[B

    if-nez v2, :cond_1

    invoke-static {v0}, Lcom/openfeint/internal/offline/OfflineSupport;->removeAndUploadNext(Lcom/openfeint/internal/offline/OfflineSupport$OfflineScore;)V

    :goto_1
    return-void

    :cond_1
    new-instance v2, Lcom/openfeint/api/resource/Leaderboard;

    iget-object v3, v0, Lcom/openfeint/internal/offline/OfflineSupport$OfflineScore;->leaderboardID:Ljava/lang/String;

    invoke-direct {v2, v3}, Lcom/openfeint/api/resource/Leaderboard;-><init>(Ljava/lang/String;)V

    iget-object v3, v0, Lcom/openfeint/internal/offline/OfflineSupport$OfflineScore;->timestamp:Ljava/lang/String;

    new-instance v4, Lcom/openfeint/internal/offline/OfflineSupport$1;

    invoke-direct {v4, v0}, Lcom/openfeint/internal/offline/OfflineSupport$1;-><init>(Lcom/openfeint/internal/offline/OfflineSupport$OfflineScore;)V

    invoke-virtual {v1, v2, v3, v4}, Lcom/openfeint/api/resource/Score;->submitToFromOffline(Lcom/openfeint/api/resource/Leaderboard;Ljava/lang/String;Lcom/openfeint/api/resource/Score$SubmitToCB;)V

    goto :goto_1

    :cond_2
    sget-object v0, Lcom/openfeint/internal/offline/OfflineSupport;->updateInProgress:Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;->set(Z)V

    goto :goto_1

    :catch_0
    move-exception v2

    goto :goto_0
.end method
