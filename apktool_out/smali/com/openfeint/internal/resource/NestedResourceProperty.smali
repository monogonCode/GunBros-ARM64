.class public abstract Lcom/openfeint/internal/resource/NestedResourceProperty;
.super Lcom/openfeint/internal/resource/ResourceProperty;


# instance fields
.field private mType:Ljava/lang/Class;
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

    iput-object p1, p0, Lcom/openfeint/internal/resource/NestedResourceProperty;->mType:Ljava/lang/Class;

    return-void
.end method


# virtual methods
.method public abstract get(Lcom/openfeint/internal/resource/Resource;)Lcom/openfeint/internal/resource/Resource;
.end method

.method public final getType()Ljava/lang/Class;
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

    iget-object v0, p0, Lcom/openfeint/internal/resource/NestedResourceProperty;->mType:Ljava/lang/Class;

    return-object v0
.end method

.method public abstract set(Lcom/openfeint/internal/resource/Resource;Lcom/openfeint/internal/resource/Resource;)V
.end method
