.class public Lcom/openfeint/internal/resource/Device;
.super Lcom/openfeint/internal/resource/Resource;


# instance fields
.field public parental_control:Lcom/openfeint/internal/resource/ParentalControl;

.field public users:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Lcom/openfeint/api/resource/User;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Lcom/openfeint/internal/resource/Resource;-><init>()V

    return-void
.end method

.method public static getResourceClass()Lcom/openfeint/internal/resource/ResourceClass;
    .locals 5

    new-instance v0, Lcom/openfeint/internal/resource/Device$1;

    const-class v1, Lcom/openfeint/internal/resource/Device;

    const-string v2, "device"

    invoke-direct {v0, v1, v2}, Lcom/openfeint/internal/resource/Device$1;-><init>(Ljava/lang/Class;Ljava/lang/String;)V

    iget-object v1, v0, Lcom/openfeint/internal/resource/ResourceClass;->mProperties:Ljava/util/HashMap;

    const-string v2, "users"

    new-instance v3, Lcom/openfeint/internal/resource/Device$2;

    const-class v4, Lcom/openfeint/api/resource/User;

    invoke-direct {v3, v4}, Lcom/openfeint/internal/resource/Device$2;-><init>(Ljava/lang/Class;)V

    invoke-virtual {v1, v2, v3}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v1, v0, Lcom/openfeint/internal/resource/ResourceClass;->mProperties:Ljava/util/HashMap;

    const-string v2, "parental_control"

    new-instance v3, Lcom/openfeint/internal/resource/Device$3;

    const-class v4, Lcom/openfeint/internal/resource/ParentalControl;

    invoke-direct {v3, v4}, Lcom/openfeint/internal/resource/Device$3;-><init>(Ljava/lang/Class;)V

    invoke-virtual {v1, v2, v3}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    return-object v0
.end method
