.class final Lcom/openfeint/internal/resource/ParentalControl$2;
.super Lcom/openfeint/internal/resource/BooleanResourceProperty;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/openfeint/internal/resource/ParentalControl;->getResourceClass()Lcom/openfeint/internal/resource/ResourceClass;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = null
.end annotation


# direct methods
.method constructor <init>()V
    .locals 0

    invoke-direct {p0}, Lcom/openfeint/internal/resource/BooleanResourceProperty;-><init>()V

    return-void
.end method


# virtual methods
.method public final get(Lcom/openfeint/internal/resource/Resource;)Z
    .locals 1

    check-cast p1, Lcom/openfeint/internal/resource/ParentalControl;

    iget-boolean v0, p1, Lcom/openfeint/internal/resource/ParentalControl;->enabled:Z

    return v0
.end method

.method public final set(Lcom/openfeint/internal/resource/Resource;Z)V
    .locals 0

    check-cast p1, Lcom/openfeint/internal/resource/ParentalControl;

    iput-boolean p2, p1, Lcom/openfeint/internal/resource/ParentalControl;->enabled:Z

    return-void
.end method
