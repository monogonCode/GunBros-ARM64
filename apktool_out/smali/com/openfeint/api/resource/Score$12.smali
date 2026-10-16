.class final Lcom/openfeint/api/resource/Score$12;
.super Lcom/openfeint/internal/resource/StringResourceProperty;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/openfeint/api/resource/Score;->getResourceClass()Lcom/openfeint/internal/resource/ResourceClass;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = null
.end annotation


# direct methods
.method constructor <init>()V
    .locals 0

    invoke-direct {p0}, Lcom/openfeint/internal/resource/StringResourceProperty;-><init>()V

    return-void
.end method


# virtual methods
.method public final get(Lcom/openfeint/internal/resource/Resource;)Ljava/lang/String;
    .locals 1

    check-cast p1, Lcom/openfeint/api/resource/Score;

    invoke-static {p1}, Lcom/openfeint/api/resource/Score;->access$100(Lcom/openfeint/api/resource/Score;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public final set(Lcom/openfeint/internal/resource/Resource;Ljava/lang/String;)V
    .locals 0

    check-cast p1, Lcom/openfeint/api/resource/Score;

    invoke-static {p1, p2}, Lcom/openfeint/api/resource/Score;->access$102(Lcom/openfeint/api/resource/Score;Ljava/lang/String;)Ljava/lang/String;

    return-void
.end method
