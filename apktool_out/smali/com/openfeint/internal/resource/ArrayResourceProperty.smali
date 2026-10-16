.class public abstract Lcom/openfeint/internal/resource/ArrayResourceProperty;
.super Lcom/openfeint/internal/resource/ResourceProperty;


# instance fields
.field private mElementType:Ljava/lang/Class;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/Class",
            "<+",
            "Lcom/openfeint/internal/resource/Resource;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>(Ljava/lang/Class;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Class",
            "<+",
            "Lcom/openfeint/internal/resource/Resource;",
            ">;)V"
        }
    .end annotation

    invoke-direct {p0}, Lcom/openfeint/internal/resource/ResourceProperty;-><init>()V

    iput-object p1, p0, Lcom/openfeint/internal/resource/ArrayResourceProperty;->mElementType:Ljava/lang/Class;

    return-void
.end method


# virtual methods
.method public final elementType()Ljava/lang/Class;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/lang/Class",
            "<+",
            "Lcom/openfeint/internal/resource/Resource;",
            ">;"
        }
    .end annotation

    iget-object v0, p0, Lcom/openfeint/internal/resource/ArrayResourceProperty;->mElementType:Ljava/lang/Class;

    return-object v0
.end method

.method public abstract get(Lcom/openfeint/internal/resource/Resource;)Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/openfeint/internal/resource/Resource;",
            ")",
            "Ljava/util/List",
            "<+",
            "Lcom/openfeint/internal/resource/Resource;",
            ">;"
        }
    .end annotation
.end method

.method public abstract set(Lcom/openfeint/internal/resource/Resource;Ljava/util/List;)V
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/openfeint/internal/resource/Resource;",
            "Ljava/util/List",
            "<*>;)V"
        }
    .end annotation
.end method
