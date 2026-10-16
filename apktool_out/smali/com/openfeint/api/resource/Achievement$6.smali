.class final Lcom/openfeint/api/resource/Achievement$6;
.super Lcom/openfeint/internal/resource/ResourceClass;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/openfeint/api/resource/Achievement;->getResourceClass()Lcom/openfeint/internal/resource/ResourceClass;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = null
.end annotation


# direct methods
.method constructor <init>(Ljava/lang/Class;Ljava/lang/String;)V
    .locals 0

    invoke-direct {p0, p1, p2}, Lcom/openfeint/internal/resource/ResourceClass;-><init>(Ljava/lang/Class;Ljava/lang/String;)V

    return-void
.end method


# virtual methods
.method public final factory()Lcom/openfeint/internal/resource/Resource;
    .locals 1

    new-instance v0, Lcom/openfeint/api/resource/Achievement;

    invoke-direct {v0}, Lcom/openfeint/api/resource/Achievement;-><init>()V

    return-object v0
.end method
