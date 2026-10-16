.class final Lcom/openfeint/internal/resource/BlobUploadParameters$2;
.super Lcom/openfeint/internal/resource/StringResourceProperty;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/openfeint/internal/resource/BlobUploadParameters;->getResourceClass()Lcom/openfeint/internal/resource/ResourceClass;
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

    check-cast p1, Lcom/openfeint/internal/resource/BlobUploadParameters;

    iget-object v0, p1, Lcom/openfeint/internal/resource/BlobUploadParameters;->action:Ljava/lang/String;

    return-object v0
.end method

.method public final set(Lcom/openfeint/internal/resource/Resource;Ljava/lang/String;)V
    .locals 0

    check-cast p1, Lcom/openfeint/internal/resource/BlobUploadParameters;

    iput-object p2, p1, Lcom/openfeint/internal/resource/BlobUploadParameters;->action:Ljava/lang/String;

    return-void
.end method
