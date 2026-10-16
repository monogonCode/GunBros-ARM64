.class public final Lcom/openfeint/internal/offline/OfflineSupport$OfflineAchievement;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/openfeint/internal/offline/OfflineSupport;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "OfflineAchievement"
.end annotation


# instance fields
.field public clientCompletionPercentage:F

.field public resourceID:Ljava/lang/String;

.field public serverCompletionPercentage:F

.field public timestamp:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final dup()Lcom/openfeint/internal/offline/OfflineSupport$OfflineAchievement;
    .locals 2

    new-instance v0, Lcom/openfeint/internal/offline/OfflineSupport$OfflineAchievement;

    invoke-direct {v0}, Lcom/openfeint/internal/offline/OfflineSupport$OfflineAchievement;-><init>()V

    iget-object v1, p0, Lcom/openfeint/internal/offline/OfflineSupport$OfflineAchievement;->resourceID:Ljava/lang/String;

    iput-object v1, v0, Lcom/openfeint/internal/offline/OfflineSupport$OfflineAchievement;->resourceID:Ljava/lang/String;

    iget v1, p0, Lcom/openfeint/internal/offline/OfflineSupport$OfflineAchievement;->clientCompletionPercentage:F

    iput v1, v0, Lcom/openfeint/internal/offline/OfflineSupport$OfflineAchievement;->clientCompletionPercentage:F

    iget v1, p0, Lcom/openfeint/internal/offline/OfflineSupport$OfflineAchievement;->serverCompletionPercentage:F

    iput v1, v0, Lcom/openfeint/internal/offline/OfflineSupport$OfflineAchievement;->serverCompletionPercentage:F

    iget-object v1, p0, Lcom/openfeint/internal/offline/OfflineSupport$OfflineAchievement;->timestamp:Ljava/lang/String;

    iput-object v1, v0, Lcom/openfeint/internal/offline/OfflineSupport$OfflineAchievement;->timestamp:Ljava/lang/String;

    return-object v0
.end method
