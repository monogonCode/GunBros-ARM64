.class final Lcom/openfeint/internal/offline/OfflineSupport$2;
.super Lcom/openfeint/internal/request/BaseRequest;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/openfeint/internal/offline/OfflineSupport;->updateToServer()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = null
.end annotation


# instance fields
.field final synthetic val$clonedDB:Lcom/openfeint/internal/offline/OfflineSupport$DB;

.field final synthetic val$path:Ljava/lang/String;


# direct methods
.method constructor <init>(Lcom/openfeint/internal/request/OrderedArgList;Ljava/lang/String;Lcom/openfeint/internal/offline/OfflineSupport$DB;)V
    .locals 0

    iput-object p2, p0, Lcom/openfeint/internal/offline/OfflineSupport$2;->val$path:Ljava/lang/String;

    iput-object p3, p0, Lcom/openfeint/internal/offline/OfflineSupport$2;->val$clonedDB:Lcom/openfeint/internal/offline/OfflineSupport$DB;

    invoke-direct {p0, p1}, Lcom/openfeint/internal/request/BaseRequest;-><init>(Lcom/openfeint/internal/request/OrderedArgList;)V

    return-void
.end method


# virtual methods
.method public final method()Ljava/lang/String;
    .locals 1

    const-string v0, "POST"

    return-object v0
.end method

.method public final onResponse(I[B)V
    .locals 0

    return-void
.end method

.method public final onResponseOffMainThread(I[B)V
    .locals 12

    const/4 v2, 0x1

    const/4 v3, 0x0

    const/16 v0, 0xc8

    if-gt v0, p1, :cond_7

    const/16 v0, 0x12c

    if-ge p1, v0, :cond_7

    invoke-static {}, Lcom/openfeint/internal/offline/OfflineSupport;->access$300()Lcom/openfeint/internal/offline/OfflineSupport$DB;

    move-result-object v4

    iget-object v5, p0, Lcom/openfeint/internal/offline/OfflineSupport$2;->val$clonedDB:Lcom/openfeint/internal/offline/OfflineSupport$DB;

    iget-object v0, v5, Lcom/openfeint/internal/offline/OfflineSupport$DB;->achievements:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v6

    :goto_0
    invoke-interface {v6}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-interface {v6}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/openfeint/internal/offline/OfflineSupport$OfflineAchievement;

    iget-object v1, v0, Lcom/openfeint/internal/offline/OfflineSupport$OfflineAchievement;->resourceID:Ljava/lang/String;

    invoke-virtual {v4, v1}, Lcom/openfeint/internal/offline/OfflineSupport$DB;->findAchievement(Ljava/lang/String;)Lcom/openfeint/internal/offline/OfflineSupport$OfflineAchievement;

    move-result-object v1

    if-nez v1, :cond_0

    invoke-virtual {v0}, Lcom/openfeint/internal/offline/OfflineSupport$OfflineAchievement;->dup()Lcom/openfeint/internal/offline/OfflineSupport$OfflineAchievement;

    move-result-object v1

    iget-object v7, v4, Lcom/openfeint/internal/offline/OfflineSupport$DB;->achievements:Ljava/util/ArrayList;

    invoke-virtual {v7, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    :cond_0
    iget v7, v1, Lcom/openfeint/internal/offline/OfflineSupport$OfflineAchievement;->serverCompletionPercentage:F

    iget v0, v0, Lcom/openfeint/internal/offline/OfflineSupport$OfflineAchievement;->clientCompletionPercentage:F

    invoke-static {v7, v0}, Ljava/lang/Math;->max(FF)F

    move-result v0

    iput v0, v1, Lcom/openfeint/internal/offline/OfflineSupport$OfflineAchievement;->serverCompletionPercentage:F

    goto :goto_0

    :cond_1
    iget-object v0, v4, Lcom/openfeint/internal/offline/OfflineSupport$DB;->scores:Ljava/util/ArrayList;

    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    iput-object v1, v4, Lcom/openfeint/internal/offline/OfflineSupport$DB;->scores:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v6

    :cond_2
    :goto_1
    invoke-interface {v6}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_6

    invoke-interface {v6}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    move-object v1, v0

    check-cast v1, Lcom/openfeint/internal/offline/OfflineSupport$OfflineScore;

    iget-object v0, v1, Lcom/openfeint/internal/offline/OfflineSupport$OfflineScore;->blobFileName:Ljava/lang/String;

    if-eqz v0, :cond_3

    iget-object v0, v4, Lcom/openfeint/internal/offline/OfflineSupport$DB;->scores:Ljava/util/ArrayList;

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_1

    :cond_3
    iget-object v0, v5, Lcom/openfeint/internal/offline/OfflineSupport$DB;->scores:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v7

    :cond_4
    invoke-interface {v7}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_9

    invoke-interface {v7}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/openfeint/internal/offline/OfflineSupport$OfflineScore;

    iget-object v8, v1, Lcom/openfeint/internal/offline/OfflineSupport$OfflineScore;->leaderboardID:Ljava/lang/String;

    iget-object v9, v0, Lcom/openfeint/internal/offline/OfflineSupport$OfflineScore;->leaderboardID:Ljava/lang/String;

    invoke-static {v8, v9}, Lcom/openfeint/internal/offline/OfflineSupport;->access$000(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v8

    if-eqz v8, :cond_5

    iget-wide v8, v1, Lcom/openfeint/internal/offline/OfflineSupport$OfflineScore;->score:J

    iget-wide v10, v0, Lcom/openfeint/internal/offline/OfflineSupport$OfflineScore;->score:J

    cmp-long v8, v8, v10

    if-nez v8, :cond_5

    iget-object v8, v1, Lcom/openfeint/internal/offline/OfflineSupport$OfflineScore;->displayText:Ljava/lang/String;

    iget-object v9, v0, Lcom/openfeint/internal/offline/OfflineSupport$OfflineScore;->displayText:Ljava/lang/String;

    invoke-static {v8, v9}, Lcom/openfeint/internal/offline/OfflineSupport;->access$000(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v8

    if-eqz v8, :cond_5

    iget-object v8, v1, Lcom/openfeint/internal/offline/OfflineSupport$OfflineScore;->customData:Ljava/lang/String;

    iget-object v9, v0, Lcom/openfeint/internal/offline/OfflineSupport$OfflineScore;->customData:Ljava/lang/String;

    invoke-static {v8, v9}, Lcom/openfeint/internal/offline/OfflineSupport;->access$000(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v8

    if-eqz v8, :cond_5

    iget-object v8, v1, Lcom/openfeint/internal/offline/OfflineSupport$OfflineScore;->blobFileName:Ljava/lang/String;

    iget-object v9, v0, Lcom/openfeint/internal/offline/OfflineSupport$OfflineScore;->blobFileName:Ljava/lang/String;

    invoke-static {v8, v9}, Lcom/openfeint/internal/offline/OfflineSupport;->access$000(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v8

    if-eqz v8, :cond_5

    iget-object v8, v1, Lcom/openfeint/internal/offline/OfflineSupport$OfflineScore;->timestamp:Ljava/lang/String;

    iget-object v0, v0, Lcom/openfeint/internal/offline/OfflineSupport$OfflineScore;->timestamp:Ljava/lang/String;

    invoke-static {v8, v0}, Lcom/openfeint/internal/offline/OfflineSupport;->access$000(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_5

    move v0, v2

    :goto_2
    if-eqz v0, :cond_4

    move v0, v2

    :goto_3
    if-nez v0, :cond_2

    iget-object v0, v4, Lcom/openfeint/internal/offline/OfflineSupport$DB;->scores:Ljava/util/ArrayList;

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_1

    :cond_5
    move v0, v3

    goto :goto_2

    :cond_6
    invoke-static {}, Lcom/openfeint/internal/offline/OfflineSupport;->access$400()V

    invoke-static {}, Lcom/openfeint/internal/offline/OfflineSupport;->access$500()V

    :goto_4
    return-void

    :cond_7
    if-eqz p1, :cond_8

    const/16 v0, 0x1f4

    if-le v0, p1, :cond_8

    invoke-static {}, Lcom/openfeint/internal/offline/OfflineSupport;->access$300()Lcom/openfeint/internal/offline/OfflineSupport$DB;

    move-result-object v0

    invoke-virtual {v0}, Lcom/openfeint/internal/offline/OfflineSupport$DB;->removeReferencedBlobs()V

    invoke-static {}, Lcom/openfeint/internal/offline/OfflineSupport;->access$300()Lcom/openfeint/internal/offline/OfflineSupport$DB;

    move-result-object v0

    iget-object v1, v0, Lcom/openfeint/internal/offline/OfflineSupport$DB;->achievements:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->clear()V

    iget-object v0, v0, Lcom/openfeint/internal/offline/OfflineSupport$DB;->scores:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->clear()V

    invoke-static {}, Lcom/openfeint/internal/offline/OfflineSupport;->access$400()V

    :cond_8
    invoke-static {}, Lcom/openfeint/internal/offline/OfflineSupport;->access$200()Ljava/util/concurrent/atomic/AtomicBoolean;

    move-result-object v0

    invoke-virtual {v0, v3}, Ljava/util/concurrent/atomic/AtomicBoolean;->set(Z)V

    goto :goto_4

    :cond_9
    move v0, v3

    goto :goto_3
.end method

.method public final path()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/openfeint/internal/offline/OfflineSupport$2;->val$path:Ljava/lang/String;

    return-object v0
.end method
