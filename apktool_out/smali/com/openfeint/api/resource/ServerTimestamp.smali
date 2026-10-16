.class public Lcom/openfeint/api/resource/ServerTimestamp;
.super Lcom/openfeint/internal/resource/Resource;


# instance fields
.field public secondsSinceEpoch:J

.field public timestamp:Ljava/util/Date;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Lcom/openfeint/internal/resource/Resource;-><init>()V

    return-void
.end method

.method public static getResourceClass()Lcom/openfeint/internal/resource/ResourceClass;
    .locals 4

    new-instance v0, Lcom/openfeint/api/resource/ServerTimestamp$2;

    const-class v1, Lcom/openfeint/api/resource/ServerTimestamp;

    const-string v2, "server_timestamp"

    invoke-direct {v0, v1, v2}, Lcom/openfeint/api/resource/ServerTimestamp$2;-><init>(Ljava/lang/Class;Ljava/lang/String;)V

    iget-object v1, v0, Lcom/openfeint/internal/resource/ResourceClass;->mProperties:Ljava/util/HashMap;

    const-string v2, "timestamp"

    new-instance v3, Lcom/openfeint/api/resource/ServerTimestamp$3;

    invoke-direct {v3}, Lcom/openfeint/api/resource/ServerTimestamp$3;-><init>()V

    invoke-virtual {v1, v2, v3}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v1, v0, Lcom/openfeint/internal/resource/ResourceClass;->mProperties:Ljava/util/HashMap;

    const-string v2, "seconds_since_epoch"

    new-instance v3, Lcom/openfeint/api/resource/ServerTimestamp$4;

    invoke-direct {v3}, Lcom/openfeint/api/resource/ServerTimestamp$4;-><init>()V

    invoke-virtual {v1, v2, v3}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    return-object v0
.end method
