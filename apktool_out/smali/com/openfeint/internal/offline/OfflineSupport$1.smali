.class final Lcom/openfeint/internal/offline/OfflineSupport$1;
.super Lcom/openfeint/api/resource/Score$SubmitToCB;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/openfeint/internal/offline/OfflineSupport;->uploadScoresWithBlobs()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = null
.end annotation


# instance fields
.field final synthetic val$os:Lcom/openfeint/internal/offline/OfflineSupport$OfflineScore;


# direct methods
.method constructor <init>(Lcom/openfeint/internal/offline/OfflineSupport$OfflineScore;)V
    .locals 0

    iput-object p1, p0, Lcom/openfeint/internal/offline/OfflineSupport$1;->val$os:Lcom/openfeint/internal/offline/OfflineSupport$OfflineScore;

    invoke-direct {p0}, Lcom/openfeint/api/resource/Score$SubmitToCB;-><init>()V

    return-void
.end method


# virtual methods
.method public final onFailure(Ljava/lang/String;)V
    .locals 2

    invoke-static {}, Lcom/openfeint/internal/offline/OfflineSupport;->access$200()Ljava/util/concurrent/atomic/AtomicBoolean;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;->set(Z)V

    return-void
.end method

.method public final onSuccess$1385ff()V
    .locals 1

    iget-object v0, p0, Lcom/openfeint/internal/offline/OfflineSupport$1;->val$os:Lcom/openfeint/internal/offline/OfflineSupport$OfflineScore;

    invoke-static {v0}, Lcom/openfeint/internal/offline/OfflineSupport;->removeAndUploadNext(Lcom/openfeint/internal/offline/OfflineSupport$OfflineScore;)V

    return-void
.end method
