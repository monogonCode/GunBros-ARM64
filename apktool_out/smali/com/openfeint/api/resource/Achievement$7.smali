.class final Lcom/openfeint/api/resource/Achievement$7;
.super Lcom/openfeint/internal/resource/StringResourceProperty;


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

    invoke-direct {p0}, Lcom/openfeint/internal/resource/StringResourceProperty;-><init>()V

    return-void
.end method


# virtual methods
.method public final get(Lcom/openfeint/internal/resource/Resource;)Ljava/lang/String;
    .locals 1

    check-cast p1, Lcom/openfeint/api/resource/Achievement;

    iget-object v0, p1, Lcom/openfeint/api/resource/Achievement;->title:Ljava/lang/String;

    return-object v0
.end method

.method public final set(Lcom/openfeint/internal/resource/Resource;Ljava/lang/String;)V
    .locals 0

    check-cast p1, Lcom/openfeint/api/resource/Achievement;

    iput-object p2, p1, Lcom/openfeint/api/resource/Achievement;->title:Ljava/lang/String;

    return-void
.end method
