.class public Lcom/openfeint/api/resource/Achievement;
.super Lcom/openfeint/internal/resource/Resource;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/openfeint/api/resource/Achievement$UpdateProgressionCB;
    }
.end annotation


# instance fields
.field public description:Ljava/lang/String;

.field public endVersion:Ljava/lang/String;

.field public gamerscore:I

.field public iconUrl:Ljava/lang/String;

.field public isSecret:Z

.field public isUnlocked:Z

.field public percentComplete:F

.field public position:I

.field public startVersion:Ljava/lang/String;

.field public title:Ljava/lang/String;

.field public unlockDate:Ljava/util/Date;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Lcom/openfeint/internal/resource/Resource;-><init>()V

    return-void
.end method

.method public constructor <init>(Ljava/lang/String;)V
    .locals 0

    invoke-direct {p0}, Lcom/openfeint/internal/resource/Resource;-><init>()V

    invoke-virtual {p0, p1}, Lcom/openfeint/api/resource/Achievement;->setResourceID(Ljava/lang/String;)V

    return-void
.end method

.method public static getResourceClass()Lcom/openfeint/internal/resource/ResourceClass;
    .locals 4

    new-instance v0, Lcom/openfeint/api/resource/Achievement$6;

    const-class v1, Lcom/openfeint/api/resource/Achievement;

    const-string v2, "achievement"

    invoke-direct {v0, v1, v2}, Lcom/openfeint/api/resource/Achievement$6;-><init>(Ljava/lang/Class;Ljava/lang/String;)V

    iget-object v1, v0, Lcom/openfeint/internal/resource/ResourceClass;->mProperties:Ljava/util/HashMap;

    const-string v2, "title"

    new-instance v3, Lcom/openfeint/api/resource/Achievement$7;

    invoke-direct {v3}, Lcom/openfeint/api/resource/Achievement$7;-><init>()V

    invoke-virtual {v1, v2, v3}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v1, v0, Lcom/openfeint/internal/resource/ResourceClass;->mProperties:Ljava/util/HashMap;

    const-string v2, "description"

    new-instance v3, Lcom/openfeint/api/resource/Achievement$8;

    invoke-direct {v3}, Lcom/openfeint/api/resource/Achievement$8;-><init>()V

    invoke-virtual {v1, v2, v3}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v1, v0, Lcom/openfeint/internal/resource/ResourceClass;->mProperties:Ljava/util/HashMap;

    const-string v2, "gamerscore"

    new-instance v3, Lcom/openfeint/api/resource/Achievement$9;

    invoke-direct {v3}, Lcom/openfeint/api/resource/Achievement$9;-><init>()V

    invoke-virtual {v1, v2, v3}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v1, v0, Lcom/openfeint/internal/resource/ResourceClass;->mProperties:Ljava/util/HashMap;

    const-string v2, "icon_url"

    new-instance v3, Lcom/openfeint/api/resource/Achievement$10;

    invoke-direct {v3}, Lcom/openfeint/api/resource/Achievement$10;-><init>()V

    invoke-virtual {v1, v2, v3}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v1, v0, Lcom/openfeint/internal/resource/ResourceClass;->mProperties:Ljava/util/HashMap;

    const-string v2, "is_secret"

    new-instance v3, Lcom/openfeint/api/resource/Achievement$11;

    invoke-direct {v3}, Lcom/openfeint/api/resource/Achievement$11;-><init>()V

    invoke-virtual {v1, v2, v3}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v1, v0, Lcom/openfeint/internal/resource/ResourceClass;->mProperties:Ljava/util/HashMap;

    const-string v2, "is_unlocked"

    new-instance v3, Lcom/openfeint/api/resource/Achievement$12;

    invoke-direct {v3}, Lcom/openfeint/api/resource/Achievement$12;-><init>()V

    invoke-virtual {v1, v2, v3}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v1, v0, Lcom/openfeint/internal/resource/ResourceClass;->mProperties:Ljava/util/HashMap;

    const-string v2, "percent_complete"

    new-instance v3, Lcom/openfeint/api/resource/Achievement$13;

    invoke-direct {v3}, Lcom/openfeint/api/resource/Achievement$13;-><init>()V

    invoke-virtual {v1, v2, v3}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v1, v0, Lcom/openfeint/internal/resource/ResourceClass;->mProperties:Ljava/util/HashMap;

    const-string v2, "unlocked_at"

    new-instance v3, Lcom/openfeint/api/resource/Achievement$14;

    invoke-direct {v3}, Lcom/openfeint/api/resource/Achievement$14;-><init>()V

    invoke-virtual {v1, v2, v3}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v1, v0, Lcom/openfeint/internal/resource/ResourceClass;->mProperties:Ljava/util/HashMap;

    const-string v2, "position"

    new-instance v3, Lcom/openfeint/api/resource/Achievement$15;

    invoke-direct {v3}, Lcom/openfeint/api/resource/Achievement$15;-><init>()V

    invoke-virtual {v1, v2, v3}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v1, v0, Lcom/openfeint/internal/resource/ResourceClass;->mProperties:Ljava/util/HashMap;

    const-string v2, "end_version"

    new-instance v3, Lcom/openfeint/api/resource/Achievement$16;

    invoke-direct {v3}, Lcom/openfeint/api/resource/Achievement$16;-><init>()V

    invoke-virtual {v1, v2, v3}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v1, v0, Lcom/openfeint/internal/resource/ResourceClass;->mProperties:Ljava/util/HashMap;

    const-string v2, "start_version"

    new-instance v3, Lcom/openfeint/api/resource/Achievement$17;

    invoke-direct {v3}, Lcom/openfeint/api/resource/Achievement$17;-><init>()V

    invoke-virtual {v1, v2, v3}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    return-object v0
.end method


# virtual methods
.method public final unlock$26d5f281()V
    .locals 1

    const/high16 v0, 0x42c80000    # 100.0f

    invoke-virtual {p0, v0}, Lcom/openfeint/api/resource/Achievement;->updateProgression$45f61eed(F)V

    return-void
.end method

.method public final updateProgression$45f61eed(F)V
    .locals 6

    const/4 v5, 0x0

    const/high16 v0, 0x42c80000    # 100.0f

    cmpg-float v1, p1, v5

    if-gez v1, :cond_1

    :goto_0
    invoke-virtual {p0}, Lcom/openfeint/api/resource/Achievement;->resourceID()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_3

    :cond_0
    :goto_1
    return-void

    :cond_1
    cmpl-float v1, p1, v0

    if-lez v1, :cond_2

    move v5, v0

    goto :goto_0

    :cond_2
    move v5, p1

    goto :goto_0

    :cond_3
    invoke-static {v4}, Lcom/openfeint/internal/offline/OfflineSupport;->getClientCompletionPercentage(Ljava/lang/String;)F

    move-result v1

    cmpg-float v1, v5, v1

    if-lez v1, :cond_0

    invoke-static {v4, v5}, Lcom/openfeint/internal/offline/OfflineSupport;->updateClientCompletionPercentage(Ljava/lang/String;F)V

    invoke-static {}, Lcom/openfeint/internal/OpenFeintInternal;->getInstance()Lcom/openfeint/internal/OpenFeintInternal;

    move-result-object v1

    invoke-virtual {v1}, Lcom/openfeint/internal/OpenFeintInternal;->getUserID()Ljava/lang/String;

    move-result-object v1

    if-nez v1, :cond_5

    invoke-static {v4}, Lcom/openfeint/internal/offline/OfflineSupport;->getClientCompletionPercentage(Ljava/lang/String;)F

    move-result v1

    iput v1, p0, Lcom/openfeint/api/resource/Achievement;->percentComplete:F

    iget v1, p0, Lcom/openfeint/api/resource/Achievement;->percentComplete:F

    cmpl-float v0, v1, v0

    if-nez v0, :cond_4

    const/4 v0, 0x1

    :goto_2
    iput-boolean v0, p0, Lcom/openfeint/api/resource/Achievement;->isUnlocked:Z

    goto :goto_1

    :cond_4
    const/4 v0, 0x0

    goto :goto_2

    :cond_5
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

    const-string v1, "/achievements/"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "/unlock"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    new-instance v2, Lcom/openfeint/internal/request/OrderedArgList;

    invoke-direct {v2}, Lcom/openfeint/internal/request/OrderedArgList;-><init>()V

    const-string v0, "percent_complete"

    new-instance v1, Ljava/lang/Float;

    invoke-direct {v1, v5}, Ljava/lang/Float;-><init>(F)V

    invoke-virtual {v1}, Ljava/lang/Float;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v2, v0, v1}, Lcom/openfeint/internal/request/OrderedArgList;->put(Ljava/lang/String;Ljava/lang/String;)V

    new-instance v0, Lcom/openfeint/api/resource/Achievement$4;

    move-object v1, p0

    invoke-direct/range {v0 .. v5}, Lcom/openfeint/api/resource/Achievement$4;-><init>(Lcom/openfeint/api/resource/Achievement;Lcom/openfeint/internal/request/OrderedArgList;Ljava/lang/String;Ljava/lang/String;F)V

    invoke-virtual {v0}, Lcom/openfeint/internal/request/JSONRequest;->launch()V

    goto :goto_1
.end method
