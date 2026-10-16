.class final Lcom/openfeint/api/resource/Achievement$4;
.super Lcom/openfeint/internal/request/JSONRequest;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/openfeint/api/resource/Achievement;->updateProgression$45f61eed(F)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/openfeint/api/resource/Achievement;

.field final synthetic val$cb:Lcom/openfeint/api/resource/Achievement$UpdateProgressionCB;

.field final synthetic val$clampedPctComplete:F

.field final synthetic val$path:Ljava/lang/String;

.field final synthetic val$resID:Ljava/lang/String;


# direct methods
.method constructor <init>(Lcom/openfeint/api/resource/Achievement;Lcom/openfeint/internal/request/OrderedArgList;Ljava/lang/String;Ljava/lang/String;F)V
    .locals 1

    iput-object p1, p0, Lcom/openfeint/api/resource/Achievement$4;->this$0:Lcom/openfeint/api/resource/Achievement;

    iput-object p3, p0, Lcom/openfeint/api/resource/Achievement$4;->val$path:Ljava/lang/String;

    iput-object p4, p0, Lcom/openfeint/api/resource/Achievement$4;->val$resID:Ljava/lang/String;

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/openfeint/api/resource/Achievement$4;->val$cb:Lcom/openfeint/api/resource/Achievement$UpdateProgressionCB;

    iput p5, p0, Lcom/openfeint/api/resource/Achievement$4;->val$clampedPctComplete:F

    invoke-direct {p0, p2}, Lcom/openfeint/internal/request/JSONRequest;-><init>(Lcom/openfeint/internal/request/OrderedArgList;)V

    return-void
.end method


# virtual methods
.method public final method()Ljava/lang/String;
    .locals 1

    const-string v0, "PUT"

    return-object v0
.end method

.method public final onFailure(Ljava/lang/String;)V
    .locals 1

    invoke-super {p0, p1}, Lcom/openfeint/internal/request/JSONRequest;->onFailure(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/openfeint/api/resource/Achievement$4;->val$cb:Lcom/openfeint/api/resource/Achievement$UpdateProgressionCB;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/openfeint/api/resource/Achievement$4;->val$cb:Lcom/openfeint/api/resource/Achievement$UpdateProgressionCB;

    invoke-virtual {v0, p1}, Lcom/openfeint/api/resource/Achievement$UpdateProgressionCB;->onFailure(Ljava/lang/String;)V

    :cond_0
    return-void
.end method

.method protected final onResponse(ILjava/lang/Object;)V
    .locals 3

    const/16 v0, 0xc8

    if-lt p1, v0, :cond_3

    const/16 v0, 0x12c

    if-ge p1, v0, :cond_3

    check-cast p2, Lcom/openfeint/api/resource/Achievement;

    iget-object v0, p0, Lcom/openfeint/api/resource/Achievement$4;->this$0:Lcom/openfeint/api/resource/Achievement;

    iget v0, v0, Lcom/openfeint/api/resource/Achievement;->percentComplete:F

    iget-object v1, p0, Lcom/openfeint/api/resource/Achievement$4;->this$0:Lcom/openfeint/api/resource/Achievement;

    invoke-virtual {v1, p2}, Lcom/openfeint/api/resource/Achievement;->shallowCopy(Lcom/openfeint/internal/resource/Resource;)V

    iget-object v1, p0, Lcom/openfeint/api/resource/Achievement$4;->this$0:Lcom/openfeint/api/resource/Achievement;

    iget v1, v1, Lcom/openfeint/api/resource/Achievement;->percentComplete:F

    iget-object v2, p0, Lcom/openfeint/api/resource/Achievement$4;->val$resID:Ljava/lang/String;

    invoke-static {v2, v1}, Lcom/openfeint/internal/offline/OfflineSupport;->updateServerCompletionPercentage(Ljava/lang/String;F)V

    const/16 v2, 0xc9

    if-eq v2, p1, :cond_0

    cmpl-float v0, v1, v0

    if-lez v0, :cond_1

    :cond_0
    invoke-static {p2}, Lcom/openfeint/internal/notifications/AchievementNotification;->showStatus(Lcom/openfeint/api/resource/Achievement;)V

    :cond_1
    iget-object v0, p0, Lcom/openfeint/api/resource/Achievement$4;->val$cb:Lcom/openfeint/api/resource/Achievement$UpdateProgressionCB;

    if-eqz v0, :cond_2

    iget-object v0, p0, Lcom/openfeint/api/resource/Achievement$4;->val$cb:Lcom/openfeint/api/resource/Achievement$UpdateProgressionCB;

    :cond_2
    :goto_0
    return-void

    :cond_3
    const/16 v0, 0x190

    if-gt v0, p1, :cond_4

    const/16 v0, 0x1f4

    if-ge p1, v0, :cond_4

    invoke-virtual {p0, p2}, Lcom/openfeint/api/resource/Achievement$4;->onFailure(Ljava/lang/Object;)V

    goto :goto_0

    :cond_4
    const/high16 v0, 0x42c80000    # 100.0f

    iget v1, p0, Lcom/openfeint/api/resource/Achievement$4;->val$clampedPctComplete:F

    cmpl-float v0, v0, v1

    if-nez v0, :cond_5

    iget-object v0, p0, Lcom/openfeint/api/resource/Achievement$4;->this$0:Lcom/openfeint/api/resource/Achievement;

    iget v1, p0, Lcom/openfeint/api/resource/Achievement$4;->val$clampedPctComplete:F

    iput v1, v0, Lcom/openfeint/api/resource/Achievement;->percentComplete:F

    iget-object v0, p0, Lcom/openfeint/api/resource/Achievement$4;->this$0:Lcom/openfeint/api/resource/Achievement;

    const/4 v1, 0x1

    iput-boolean v1, v0, Lcom/openfeint/api/resource/Achievement;->isUnlocked:Z

    iget-object v0, p0, Lcom/openfeint/api/resource/Achievement$4;->this$0:Lcom/openfeint/api/resource/Achievement;

    invoke-static {v0}, Lcom/openfeint/internal/notifications/AchievementNotification;->showStatus(Lcom/openfeint/api/resource/Achievement;)V

    :cond_5
    iget-object v0, p0, Lcom/openfeint/api/resource/Achievement$4;->val$cb:Lcom/openfeint/api/resource/Achievement$UpdateProgressionCB;

    if-eqz v0, :cond_2

    iget-object v0, p0, Lcom/openfeint/api/resource/Achievement$4;->val$cb:Lcom/openfeint/api/resource/Achievement$UpdateProgressionCB;

    goto :goto_0
.end method

.method public final path()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/openfeint/api/resource/Achievement$4;->val$path:Ljava/lang/String;

    return-object v0
.end method
