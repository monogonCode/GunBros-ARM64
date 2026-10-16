.class final Lcom/openfeint/api/resource/ServerTimestamp$3;
.super Lcom/openfeint/internal/resource/DateResourceProperty;


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

    invoke-direct {p0}, Lcom/openfeint/internal/resource/DateResourceProperty;-><init>()V

    return-void
.end method


# virtual methods
.method public final get(Lcom/openfeint/internal/resource/Resource;)Ljava/util/Date;
    .locals 1

    check-cast p1, Lcom/openfeint/api/resource/ServerTimestamp;

    iget-object v0, p1, Lcom/openfeint/api/resource/ServerTimestamp;->timestamp:Ljava/util/Date;

    return-object v0
.end method

.method public final set(Lcom/openfeint/internal/resource/Resource;Ljava/util/Date;)V
    .locals 0

    check-cast p1, Lcom/openfeint/api/resource/ServerTimestamp;

    iput-object p2, p1, Lcom/openfeint/api/resource/ServerTimestamp;->timestamp:Ljava/util/Date;

    return-void
.end method
