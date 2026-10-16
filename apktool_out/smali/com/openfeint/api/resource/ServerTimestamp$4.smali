.class final Lcom/openfeint/api/resource/ServerTimestamp$4;
.super Lcom/openfeint/internal/resource/LongResourceProperty;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/openfeint/api/resource/ServerTimestamp;->getResourceClass()Lcom/openfeint/internal/resource/ResourceClass;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = null
.end annotation


# direct methods
.method constructor <init>()V
    .locals 0

    invoke-direct {p0}, Lcom/openfeint/internal/resource/LongResourceProperty;-><init>()V

    return-void
.end method


# virtual methods
.method public final get(Lcom/openfeint/internal/resource/Resource;)J
    .locals 2

    check-cast p1, Lcom/openfeint/api/resource/ServerTimestamp;

    iget-wide v0, p1, Lcom/openfeint/api/resource/ServerTimestamp;->secondsSinceEpoch:J

    return-wide v0
.end method

.method public final set(Lcom/openfeint/internal/resource/Resource;J)V
    .locals 0

    check-cast p1, Lcom/openfeint/api/resource/ServerTimestamp;

    iput-wide p2, p1, Lcom/openfeint/api/resource/ServerTimestamp;->secondsSinceEpoch:J

    return-void
.end method
