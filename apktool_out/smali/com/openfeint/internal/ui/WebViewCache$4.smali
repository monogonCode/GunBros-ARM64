.class final Lcom/openfeint/internal/ui/WebViewCache$4;
.super Lcom/openfeint/internal/request/BaseRequest;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/openfeint/internal/ui/WebViewCache;->batchFetch(Ljava/lang/String;Ljava/lang/String;ILjava/util/Set;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/openfeint/internal/ui/WebViewCache;

.field final synthetic val$currentUrl:Ljava/lang/String;

.field final synthetic val$originalUrl:Ljava/lang/String;

.field final synthetic val$paths:Ljava/util/Set;

.field final synthetic val$retriesLeft:I


# direct methods
.method constructor <init>(Lcom/openfeint/internal/ui/WebViewCache;Ljava/lang/String;Ljava/lang/String;ILjava/util/Set;)V
    .locals 0

    iput-object p1, p0, Lcom/openfeint/internal/ui/WebViewCache$4;->this$0:Lcom/openfeint/internal/ui/WebViewCache;

    iput-object p2, p0, Lcom/openfeint/internal/ui/WebViewCache$4;->val$originalUrl:Ljava/lang/String;

    iput-object p3, p0, Lcom/openfeint/internal/ui/WebViewCache$4;->val$currentUrl:Ljava/lang/String;

    iput p4, p0, Lcom/openfeint/internal/ui/WebViewCache$4;->val$retriesLeft:I

    iput-object p5, p0, Lcom/openfeint/internal/ui/WebViewCache$4;->val$paths:Ljava/util/Set;

    invoke-direct {p0}, Lcom/openfeint/internal/request/BaseRequest;-><init>()V

    return-void
.end method


# virtual methods
.method public final method()Ljava/lang/String;
    .locals 1

    const-string v0, "GET"

    return-object v0
.end method

.method public final onResponse(I[B)V
    .locals 0

    return-void
.end method

.method public final onResponseOffMainThread(I[B)V
    .locals 7

    iget-object v0, p0, Lcom/openfeint/internal/ui/WebViewCache$4;->this$0:Lcom/openfeint/internal/ui/WebViewCache;

    iget-object v3, p0, Lcom/openfeint/internal/ui/WebViewCache$4;->val$originalUrl:Ljava/lang/String;

    iget-object v4, p0, Lcom/openfeint/internal/ui/WebViewCache$4;->val$currentUrl:Ljava/lang/String;

    iget v5, p0, Lcom/openfeint/internal/ui/WebViewCache$4;->val$retriesLeft:I

    iget-object v6, p0, Lcom/openfeint/internal/ui/WebViewCache$4;->val$paths:Ljava/util/Set;

    move v1, p1

    move-object v2, p2

    invoke-static/range {v0 .. v6}, Lcom/openfeint/internal/ui/WebViewCache;->access$1300(Lcom/openfeint/internal/ui/WebViewCache;I[BLjava/lang/String;Ljava/lang/String;ILjava/util/Set;)V

    return-void
.end method

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

    iget-object v0, p0, Lcom/openfeint/internal/ui/WebViewCache$4;->val$originalUrl:Ljava/lang/String;

    return-object v0
.end method
