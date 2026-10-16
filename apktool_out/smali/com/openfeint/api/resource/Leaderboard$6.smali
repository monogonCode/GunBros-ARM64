.class final Lcom/openfeint/api/resource/Leaderboard$6;
.super Lcom/openfeint/internal/resource/NestedResourceProperty;


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

    invoke-direct {p0, p1}, Lcom/openfeint/internal/resource/NestedResourceProperty;-><init>(Ljava/lang/Class;)V

    return-void
.end method


# virtual methods
.method public final get(Lcom/openfeint/internal/resource/Resource;)Lcom/openfeint/internal/resource/Resource;
    .locals 1

    check-cast p1, Lcom/openfeint/api/resource/Leaderboard;

    iget-object v0, p1, Lcom/openfeint/api/resource/Leaderboard;->localUserScore:Lcom/openfeint/api/resource/Score;

    return-object v0
.end method

.method public final set(Lcom/openfeint/internal/resource/Resource;Lcom/openfeint/internal/resource/Resource;)V
    .locals 0

    check-cast p1, Lcom/openfeint/api/resource/Leaderboard;

    check-cast p2, Lcom/openfeint/api/resource/Score;

    iput-object p2, p1, Lcom/openfeint/api/resource/Leaderboard;->localUserScore:Lcom/openfeint/api/resource/Score;

    return-void
.end method
