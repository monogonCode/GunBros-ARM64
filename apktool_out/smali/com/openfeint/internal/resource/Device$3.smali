.class final Lcom/openfeint/internal/resource/Device$3;
.super Lcom/openfeint/internal/resource/NestedResourceProperty;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/openfeint/internal/resource/Device;->getResourceClass()Lcom/openfeint/internal/resource/ResourceClass;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = null
.end annotation


# direct methods
.method constructor <init>(Ljava/lang/Class;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/openfeint/internal/resource/NestedResourceProperty;-><init>(Ljava/lang/Class;)V

    return-void
.end method


# virtual methods
.method public final get(Lcom/openfeint/internal/resource/Resource;)Lcom/openfeint/internal/resource/Resource;
    .locals 1

    check-cast p1, Lcom/openfeint/internal/resource/Device;

    iget-object v0, p1, Lcom/openfeint/internal/resource/Device;->parental_control:Lcom/openfeint/internal/resource/ParentalControl;

    return-object v0
.end method

.method public final set(Lcom/openfeint/internal/resource/Resource;Lcom/openfeint/internal/resource/Resource;)V
    .locals 0

    check-cast p1, Lcom/openfeint/internal/resource/Device;

    check-cast p2, Lcom/openfeint/internal/resource/ParentalControl;

    iput-object p2, p1, Lcom/openfeint/internal/resource/Device;->parental_control:Lcom/openfeint/internal/resource/ParentalControl;

    return-void
.end method
