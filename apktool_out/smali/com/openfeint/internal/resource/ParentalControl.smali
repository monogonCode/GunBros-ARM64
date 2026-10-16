.class public Lcom/openfeint/internal/resource/ParentalControl;
.super Lcom/openfeint/internal/resource/Resource;


# instance fields
.field public enabled:Z


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Lcom/openfeint/internal/resource/Resource;-><init>()V

    return-void
.end method

.method public static getResourceClass()Lcom/openfeint/internal/resource/ResourceClass;
    .locals 4

    new-instance v0, Lcom/openfeint/internal/resource/ParentalControl$1;

    const-class v1, Lcom/openfeint/internal/resource/ParentalControl;

    const-string v2, "parental_control"

    invoke-direct {v0, v1, v2}, Lcom/openfeint/internal/resource/ParentalControl$1;-><init>(Ljava/lang/Class;Ljava/lang/String;)V

    iget-object v1, v0, Lcom/openfeint/internal/resource/ResourceClass;->mProperties:Ljava/util/HashMap;

    const-string v2, "enabled"

    new-instance v3, Lcom/openfeint/internal/resource/ParentalControl$2;

    invoke-direct {v3}, Lcom/openfeint/internal/resource/ParentalControl$2;-><init>()V

    invoke-virtual {v1, v2, v3}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    return-object v0
.end method
