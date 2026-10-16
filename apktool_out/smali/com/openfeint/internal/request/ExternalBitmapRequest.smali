.class public Lcom/openfeint/internal/request/ExternalBitmapRequest;
.super Lcom/openfeint/internal/request/BitmapRequest;


# instance fields
.field private mURL:Ljava/lang/String;


# direct methods
.method public constructor <init>(Ljava/lang/String;)V
    .locals 0

    invoke-direct {p0}, Lcom/openfeint/internal/request/BitmapRequest;-><init>()V

    iput-object p1, p0, Lcom/openfeint/internal/request/ExternalBitmapRequest;->mURL:Ljava/lang/String;

    return-void
.end method


# virtual methods
.method public final path()Ljava/lang/String;
    .locals 1

    const-string v0, ""

    return-object v0
.end method

.method public final signed()Z
    .locals 1

    const/4 v0, 0x0

    return v0
.end method

.method public final url()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/openfeint/internal/request/ExternalBitmapRequest;->mURL:Ljava/lang/String;

    return-object v0
.end method
