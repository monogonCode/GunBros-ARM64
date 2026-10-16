.class public Lcom/openfeint/api/resource/Score;
.super Lcom/openfeint/internal/resource/Resource;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/openfeint/api/resource/Score$BlobDownloadedDelegate;,
        Lcom/openfeint/api/resource/Score$DownloadBlobCB;,
        Lcom/openfeint/api/resource/Score$SubmitToCB;
    }
.end annotation


# instance fields
.field public blob:[B

.field private blobUploadParameters:Lcom/openfeint/internal/resource/BlobUploadParameters;

.field private blobUrl:Ljava/lang/String;

.field public customData:Ljava/lang/String;

.field public displayText:Ljava/lang/String;

.field public latitude:D

.field public leaderboardId:I

.field public longitude:D

.field public rank:I

.field public score:J

.field public user:Lcom/openfeint/api/resource/User;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Lcom/openfeint/internal/resource/Resource;-><init>()V

    return-void
.end method

.method public constructor <init>(J)V
    .locals 0

    invoke-direct {p0}, Lcom/openfeint/internal/resource/Resource;-><init>()V

    iput-wide p1, p0, Lcom/openfeint/api/resource/Score;->score:J

    return-void
.end method

.method static synthetic access$000(Lcom/openfeint/api/resource/Score;)Lcom/openfeint/internal/resource/BlobUploadParameters;
    .locals 1

    iget-object v0, p0, Lcom/openfeint/api/resource/Score;->blobUploadParameters:Lcom/openfeint/internal/resource/BlobUploadParameters;

    return-object v0
.end method

.method static synthetic access$002(Lcom/openfeint/api/resource/Score;Lcom/openfeint/internal/resource/BlobUploadParameters;)Lcom/openfeint/internal/resource/BlobUploadParameters;
    .locals 0

    iput-object p1, p0, Lcom/openfeint/api/resource/Score;->blobUploadParameters:Lcom/openfeint/internal/resource/BlobUploadParameters;

    return-object p1
.end method

.method static synthetic access$100(Lcom/openfeint/api/resource/Score;)Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/openfeint/api/resource/Score;->blobUrl:Ljava/lang/String;

    return-object v0
.end method

.method static synthetic access$102(Lcom/openfeint/api/resource/Score;Ljava/lang/String;)Ljava/lang/String;
    .locals 0

    iput-object p1, p0, Lcom/openfeint/api/resource/Score;->blobUrl:Ljava/lang/String;

    return-object p1
.end method

.method public static getResourceClass()Lcom/openfeint/internal/resource/ResourceClass;
    .locals 5

    new-instance v0, Lcom/openfeint/api/resource/Score$3;

    const-class v1, Lcom/openfeint/api/resource/Score;

    const-string v2, "high_score"

    invoke-direct {v0, v1, v2}, Lcom/openfeint/api/resource/Score$3;-><init>(Ljava/lang/Class;Ljava/lang/String;)V

    iget-object v1, v0, Lcom/openfeint/internal/resource/ResourceClass;->mProperties:Ljava/util/HashMap;

    const-string v2, "score"

    new-instance v3, Lcom/openfeint/api/resource/Score$4;

    invoke-direct {v3}, Lcom/openfeint/api/resource/Score$4;-><init>()V

    invoke-virtual {v1, v2, v3}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v1, v0, Lcom/openfeint/internal/resource/ResourceClass;->mProperties:Ljava/util/HashMap;

    const-string v2, "rank"

    new-instance v3, Lcom/openfeint/api/resource/Score$5;

    invoke-direct {v3}, Lcom/openfeint/api/resource/Score$5;-><init>()V

    invoke-virtual {v1, v2, v3}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v1, v0, Lcom/openfeint/internal/resource/ResourceClass;->mProperties:Ljava/util/HashMap;

    const-string v2, "leaderboard_id"

    new-instance v3, Lcom/openfeint/api/resource/Score$6;

    invoke-direct {v3}, Lcom/openfeint/api/resource/Score$6;-><init>()V

    invoke-virtual {v1, v2, v3}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v1, v0, Lcom/openfeint/internal/resource/ResourceClass;->mProperties:Ljava/util/HashMap;

    const-string v2, "display_text"

    new-instance v3, Lcom/openfeint/api/resource/Score$7;

    invoke-direct {v3}, Lcom/openfeint/api/resource/Score$7;-><init>()V

    invoke-virtual {v1, v2, v3}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v1, v0, Lcom/openfeint/internal/resource/ResourceClass;->mProperties:Ljava/util/HashMap;

    const-string v2, "custom_data"

    new-instance v3, Lcom/openfeint/api/resource/Score$8;

    invoke-direct {v3}, Lcom/openfeint/api/resource/Score$8;-><init>()V

    invoke-virtual {v1, v2, v3}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v1, v0, Lcom/openfeint/internal/resource/ResourceClass;->mProperties:Ljava/util/HashMap;

    const-string v2, "lat"

    new-instance v3, Lcom/openfeint/api/resource/Score$9;

    invoke-direct {v3}, Lcom/openfeint/api/resource/Score$9;-><init>()V

    invoke-virtual {v1, v2, v3}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v1, v0, Lcom/openfeint/internal/resource/ResourceClass;->mProperties:Ljava/util/HashMap;

    const-string v2, "lng"

    new-instance v3, Lcom/openfeint/api/resource/Score$10;

    invoke-direct {v3}, Lcom/openfeint/api/resource/Score$10;-><init>()V

    invoke-virtual {v1, v2, v3}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v1, v0, Lcom/openfeint/internal/resource/ResourceClass;->mProperties:Ljava/util/HashMap;

    const-string v2, "user"

    new-instance v3, Lcom/openfeint/api/resource/Score$11;

    const-class v4, Lcom/openfeint/api/resource/User;

    invoke-direct {v3, v4}, Lcom/openfeint/api/resource/Score$11;-><init>(Ljava/lang/Class;)V

    invoke-virtual {v1, v2, v3}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v1, v0, Lcom/openfeint/internal/resource/ResourceClass;->mProperties:Ljava/util/HashMap;

    const-string v2, "blob_url"

    new-instance v3, Lcom/openfeint/api/resource/Score$12;

    invoke-direct {v3}, Lcom/openfeint/api/resource/Score$12;-><init>()V

    invoke-virtual {v1, v2, v3}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v1, v0, Lcom/openfeint/internal/resource/ResourceClass;->mProperties:Ljava/util/HashMap;

    const-string v2, "blob_upload_parameters"

    new-instance v3, Lcom/openfeint/api/resource/Score$13;

    const-class v4, Lcom/openfeint/internal/resource/BlobUploadParameters;

    invoke-direct {v3, v4}, Lcom/openfeint/api/resource/Score$13;-><init>(Ljava/lang/Class;)V

    invoke-virtual {v1, v2, v3}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    return-object v0
.end method

.method private submitToInternal(Lcom/openfeint/api/resource/Leaderboard;Ljava/lang/String;Lcom/openfeint/api/resource/Score$SubmitToCB;Z)V
    .locals 8

    if-eqz p1, :cond_0

    invoke-virtual {p1}, Lcom/openfeint/api/resource/Leaderboard;->resourceID()Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-virtual {p1}, Lcom/openfeint/api/resource/Leaderboard;->resourceID()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v0

    if-nez v0, :cond_2

    :cond_0
    if-eqz p3, :cond_1

    const-string v0, "No leaderboard ID provided.  Please provide a leaderboard ID from the Dev Dashboard."

    invoke-virtual {p3, v0}, Lcom/openfeint/api/resource/Score$SubmitToCB;->onFailure(Ljava/lang/String;)V

    :cond_1
    :goto_0
    return-void

    :cond_2
    invoke-static {}, Lcom/openfeint/internal/OpenFeintInternal;->getInstance()Lcom/openfeint/internal/OpenFeintInternal;

    move-result-object v0

    invoke-virtual {v0}, Lcom/openfeint/internal/OpenFeintInternal;->isUserLoggedIn()Z

    move-result v0

    if-nez v0, :cond_3

    invoke-static {p0, p1}, Lcom/openfeint/internal/offline/OfflineSupport;->postOfflineScore(Lcom/openfeint/api/resource/Score;Lcom/openfeint/api/resource/Leaderboard;)V

    if-eqz p3, :cond_1

    invoke-virtual {p3}, Lcom/openfeint/api/resource/Score$SubmitToCB;->onSuccess$1385ff()V

    goto :goto_0

    :cond_3
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

    const-string v1, "/leaderboards/"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {p1}, Lcom/openfeint/api/resource/Leaderboard;->resourceID()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "/high_scores"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    new-instance v2, Lcom/openfeint/internal/request/OrderedArgList;

    invoke-direct {v2}, Lcom/openfeint/internal/request/OrderedArgList;-><init>()V

    const-string v0, "high_score[score]"

    new-instance v1, Ljava/lang/Long;

    iget-wide v4, p0, Lcom/openfeint/api/resource/Score;->score:J

    invoke-direct {v1, v4, v5}, Ljava/lang/Long;-><init>(J)V

    invoke-virtual {v1}, Ljava/lang/Long;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v2, v0, v1}, Lcom/openfeint/internal/request/OrderedArgList;->put(Ljava/lang/String;Ljava/lang/String;)V

    iget-object v0, p0, Lcom/openfeint/api/resource/Score;->displayText:Ljava/lang/String;

    if-eqz v0, :cond_4

    const-string v0, "high_score[display_text]"

    iget-object v1, p0, Lcom/openfeint/api/resource/Score;->displayText:Ljava/lang/String;

    invoke-virtual {v2, v0, v1}, Lcom/openfeint/internal/request/OrderedArgList;->put(Ljava/lang/String;Ljava/lang/String;)V

    :cond_4
    iget-object v0, p0, Lcom/openfeint/api/resource/Score;->blob:[B

    if-eqz v0, :cond_6

    const/4 v6, 0x1

    :goto_1
    const-string v1, "high_score[has_blob]"

    if-eqz v6, :cond_7

    const-string v0, "1"

    :goto_2
    invoke-virtual {v2, v1, v0}, Lcom/openfeint/internal/request/OrderedArgList;->put(Ljava/lang/String;Ljava/lang/String;)V

    if-eqz p2, :cond_5

    const-string v0, "high_score[timestamp]"

    invoke-virtual {v2, v0, p2}, Lcom/openfeint/internal/request/OrderedArgList;->put(Ljava/lang/String;Ljava/lang/String;)V

    :cond_5
    new-instance v0, Lcom/openfeint/api/resource/Score$1;

    move-object v1, p0

    move v4, p4

    move-object v5, p3

    move-object v7, p1

    invoke-direct/range {v0 .. v7}, Lcom/openfeint/api/resource/Score$1;-><init>(Lcom/openfeint/api/resource/Score;Lcom/openfeint/internal/request/OrderedArgList;Ljava/lang/String;ZLcom/openfeint/api/resource/Score$SubmitToCB;ZLcom/openfeint/api/resource/Leaderboard;)V

    invoke-virtual {v0}, Lcom/openfeint/internal/request/JSONRequest;->launch()V

    goto/16 :goto_0

    :cond_6
    const/4 v6, 0x0

    goto :goto_1

    :cond_7
    const-string v0, "0"

    goto :goto_2
.end method


# virtual methods
.method public final downloadBlob(Lcom/openfeint/api/resource/Score$DownloadBlobCB;)V
    .locals 1

    iget-object v0, p0, Lcom/openfeint/api/resource/Score;->blobUrl:Ljava/lang/String;

    if-eqz v0, :cond_1

    const/4 v0, 0x1

    :goto_0
    if-eqz v0, :cond_2

    new-instance v0, Lcom/openfeint/api/resource/Score$2;

    invoke-direct {v0, p0, p1}, Lcom/openfeint/api/resource/Score$2;-><init>(Lcom/openfeint/api/resource/Score;Lcom/openfeint/api/resource/Score$DownloadBlobCB;)V

    invoke-virtual {v0}, Lcom/openfeint/internal/request/DownloadRequest;->launch()V

    :cond_0
    :goto_1
    return-void

    :cond_1
    const/4 v0, 0x0

    goto :goto_0

    :cond_2
    if-eqz p1, :cond_0

    const-string v0, "of_no_blob"

    invoke-static {v0}, Lcom/openfeint/internal/RR;->string(Ljava/lang/String;)I

    move-result v0

    invoke-static {v0}, Lcom/openfeint/internal/OpenFeintInternal;->getRString(I)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Lcom/openfeint/api/resource/Score$DownloadBlobCB;->onFailure(Ljava/lang/String;)V

    goto :goto_1
.end method

.method public final submitTo$487f3c2c(Lcom/openfeint/api/resource/Leaderboard;)V
    .locals 2

    const/4 v1, 0x0

    const/4 v0, 0x0

    invoke-direct {p0, p1, v1, v1, v0}, Lcom/openfeint/api/resource/Score;->submitToInternal(Lcom/openfeint/api/resource/Leaderboard;Ljava/lang/String;Lcom/openfeint/api/resource/Score$SubmitToCB;Z)V

    return-void
.end method

.method public final submitToFromOffline(Lcom/openfeint/api/resource/Leaderboard;Ljava/lang/String;Lcom/openfeint/api/resource/Score$SubmitToCB;)V
    .locals 1

    const/4 v0, 0x1

    invoke-direct {p0, p1, p2, p3, v0}, Lcom/openfeint/api/resource/Score;->submitToInternal(Lcom/openfeint/api/resource/Leaderboard;Ljava/lang/String;Lcom/openfeint/api/resource/Score$SubmitToCB;Z)V

    return-void
.end method
