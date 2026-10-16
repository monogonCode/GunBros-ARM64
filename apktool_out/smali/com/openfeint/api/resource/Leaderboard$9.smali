.class final Lcom/openfeint/api/resource/Leaderboard$9;
.super Lcom/openfeint/internal/resource/ArrayResourceProperty;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/openfeint/api/resource/Leaderboard;->getResourceClass()Lcom/openfeint/internal/resource/ResourceClass;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = null
.end annotation


# direct methods
.method constructor <init>(Ljava/lang/Class;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/openfeint/internal/resource/ArrayResourceProperty;-><init>(Ljava/lang/Class;)V

    return-void
.end method


# virtual methods
.method public final get(Lcom/openfeint/internal/resource/Resource;)Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/openfeint/internal/resource/Resource;",
            ")",
            "Ljava/util/List",
            "<+",
            "Lcom/openfeint/internal/resource/Resource;",
            ">;"
        }
    .end annotation

    check-cast p1, Lcom/openfeint/api/resource/Leaderboard;

    iget-object v0, p1, Lcom/openfeint/api/resource/Leaderboard;->highScores:Ljava/util/List;

    return-object v0
.end method

.method public final set(Lcom/openfeint/internal/resource/Resource;Ljava/util/List;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/openfeint/internal/resource/Resource;",
            "Ljava/util/List",
            "<*>;)V"
        }
    .end annotation

    check-cast p1, Lcom/openfeint/api/resource/Leaderboard;

    iput-object p2, p1, Lcom/openfeint/api/resource/Leaderboard;->highScores:Ljava/util/List;

    return-void
.end method
