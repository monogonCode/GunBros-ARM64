.class public Lcom/openfeint/api/resource/Leaderboard;
.super Lcom/openfeint/internal/resource/Resource;


# instance fields
.field public allowsWorseScores:Z

.field public descendingSortOrder:Z

.field public highScores:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Lcom/openfeint/api/resource/Score;",
            ">;"
        }
    .end annotation
.end field

.field public localUserScore:Lcom/openfeint/api/resource/Score;

.field public name:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Lcom/openfeint/internal/resource/Resource;-><init>()V

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/openfeint/api/resource/Leaderboard;->descendingSortOrder:Z

    return-void
.end method

.method public constructor <init>(Ljava/lang/String;)V
    .locals 1

    invoke-direct {p0}, Lcom/openfeint/internal/resource/Resource;-><init>()V

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/openfeint/api/resource/Leaderboard;->descendingSortOrder:Z

    invoke-virtual {p0, p1}, Lcom/openfeint/api/resource/Leaderboard;->setResourceID(Ljava/lang/String;)V

    return-void
.end method

.method public static getResourceClass()Lcom/openfeint/internal/resource/ResourceClass;
    .locals 5

    new-instance v0, Lcom/openfeint/api/resource/Leaderboard$4;

    const-class v1, Lcom/openfeint/api/resource/Leaderboard;

    const-string v2, "leaderboard"

    invoke-direct {v0, v1, v2}, Lcom/openfeint/api/resource/Leaderboard$4;-><init>(Ljava/lang/Class;Ljava/lang/String;)V

    iget-object v1, v0, Lcom/openfeint/internal/resource/ResourceClass;->mProperties:Ljava/util/HashMap;

    const-string v2, "name"

    new-instance v3, Lcom/openfeint/api/resource/Leaderboard$5;

    invoke-direct {v3}, Lcom/openfeint/api/resource/Leaderboard$5;-><init>()V

    invoke-virtual {v1, v2, v3}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v1, v0, Lcom/openfeint/internal/resource/ResourceClass;->mProperties:Ljava/util/HashMap;

    const-string v2, "current_user_high_score"

    new-instance v3, Lcom/openfeint/api/resource/Leaderboard$6;

    const-class v4, Lcom/openfeint/api/resource/Score;

    invoke-direct {v3, v4}, Lcom/openfeint/api/resource/Leaderboard$6;-><init>(Ljava/lang/Class;)V

    invoke-virtual {v1, v2, v3}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v1, v0, Lcom/openfeint/internal/resource/ResourceClass;->mProperties:Ljava/util/HashMap;

    const-string v2, "descending_sort_order"

    new-instance v3, Lcom/openfeint/api/resource/Leaderboard$7;

    invoke-direct {v3}, Lcom/openfeint/api/resource/Leaderboard$7;-><init>()V

    invoke-virtual {v1, v2, v3}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v1, v0, Lcom/openfeint/internal/resource/ResourceClass;->mProperties:Ljava/util/HashMap;

    const-string v2, "allow_posting_lower_scores"

    new-instance v3, Lcom/openfeint/api/resource/Leaderboard$8;

    invoke-direct {v3}, Lcom/openfeint/api/resource/Leaderboard$8;-><init>()V

    invoke-virtual {v1, v2, v3}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v1, v0, Lcom/openfeint/internal/resource/ResourceClass;->mProperties:Ljava/util/HashMap;

    const-string v2, "high_scores"

    new-instance v3, Lcom/openfeint/api/resource/Leaderboard$9;

    const-class v4, Lcom/openfeint/api/resource/Score;

    invoke-direct {v3, v4}, Lcom/openfeint/api/resource/Leaderboard$9;-><init>(Ljava/lang/Class;)V

    invoke-virtual {v1, v2, v3}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    return-object v0
.end method
