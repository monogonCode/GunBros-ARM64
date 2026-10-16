.class final Lcom/openfeint/api/resource/Achievement$15;
.super Lcom/openfeint/internal/resource/IntResourceProperty;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/openfeint/api/resource/Achievement;->getResourceClass()Lcom/openfeint/internal/resource/ResourceClass;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = null
.end annotation


# direct methods
.method constructor <init>()V
    .locals 0

    invoke-direct {p0}, Lcom/openfeint/internal/resource/IntResourceProperty;-><init>()V

    return-void
.end method


# virtual methods
.method public final get(Lcom/openfeint/internal/resource/Resource;)I
    .locals 1

    check-cast p1, Lcom/openfeint/api/resource/Achievement;

    iget v0, p1, Lcom/openfeint/api/resource/Achievement;->position:I

    return v0
.end method

.method public final set(Lcom/openfeint/internal/resource/Resource;I)V
    .locals 0

    check-cast p1, Lcom/openfeint/api/resource/Achievement;

    iput p2, p1, Lcom/openfeint/api/resource/Achievement;->position:I

    return-void
.end method
