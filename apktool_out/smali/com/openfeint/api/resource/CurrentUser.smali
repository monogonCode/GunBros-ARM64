.class public Lcom/openfeint/api/resource/CurrentUser;
.super Lcom/openfeint/api/resource/User;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Lcom/openfeint/api/resource/User;-><init>()V

    return-void
.end method

.method public static getResourceClass()Lcom/openfeint/internal/resource/ResourceClass;
    .locals 3

    new-instance v0, Lcom/openfeint/api/resource/CurrentUser$2;

    const-class v1, Lcom/openfeint/api/resource/CurrentUser;

    const-string v2, "current_user"

    invoke-direct {v0, v1, v2}, Lcom/openfeint/api/resource/CurrentUser$2;-><init>(Ljava/lang/Class;Ljava/lang/String;)V

    return-object v0
.end method
