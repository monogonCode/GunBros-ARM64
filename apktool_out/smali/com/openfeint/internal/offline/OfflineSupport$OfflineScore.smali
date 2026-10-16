.class public final Lcom/openfeint/internal/offline/OfflineSupport$OfflineScore;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/openfeint/internal/offline/OfflineSupport;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "OfflineScore"
.end annotation


# instance fields
.field public blobFileName:Ljava/lang/String;

.field public customData:Ljava/lang/String;

.field public displayText:Ljava/lang/String;

.field public leaderboardID:Ljava/lang/String;

.field public score:J

.field public timestamp:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method
