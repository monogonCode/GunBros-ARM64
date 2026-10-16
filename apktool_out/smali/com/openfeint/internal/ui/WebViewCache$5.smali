.class final Lcom/openfeint/internal/ui/WebViewCache$5;
.super Lcom/openfeint/internal/request/BaseRequest;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/openfeint/internal/ui/WebViewCache;->batchRequest(Ljava/util/Set;I)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/openfeint/internal/ui/WebViewCache;

.field final synthetic val$numRetries:I

.field final synthetic val$paths:Ljava/util/Set;


# direct methods
.method constructor <init>(Lcom/openfeint/internal/ui/WebViewCache;Lcom/openfeint/internal/request/OrderedArgList;ILjava/util/Set;)V
    .locals 0

    iput-object p1, p0, Lcom/openfeint/internal/ui/WebViewCache$5;->this$0:Lcom/openfeint/internal/ui/WebViewCache;

    iput p3, p0, Lcom/openfeint/internal/ui/WebViewCache$5;->val$numRetries:I

    iput-object p4, p0, Lcom/openfeint/internal/ui/WebViewCache$5;->val$paths:Ljava/util/Set;

    invoke-direct {p0, p2}, Lcom/openfeint/internal/request/BaseRequest;-><init>(Lcom/openfeint/internal/request/OrderedArgList;)V

    return-void
.end method


# virtual methods
.method public final method()Ljava/lang/String;
    .locals 1

    const-string v0, "POST"

    return-object v0
.end method

.method public final onResponse(I[B)V
    .locals 0

    return-void
.end method

.method protected final onResponseOffMainThread(I[B)V
    .locals 7

    iget-object v0, p0, Lcom/openfeint/internal/ui/WebViewCache$5;->this$0:Lcom/openfeint/internal/ui/WebViewCache;

    invoke-virtual {p0}, Lcom/openfeint/internal/ui/WebViewCache$5;->url()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/openfeint/internal/ui/WebViewCache$5;->currentURL()Ljava/lang/String;

    move-result-object v4

    iget v5, p0, Lcom/openfeint/internal/ui/WebViewCache$5;->val$numRetries:I

    iget-object v6, p0, Lcom/openfeint/internal/ui/WebViewCache$5;->val$paths:Ljava/util/Set;

    move v1, p1

    move-object v2, p2

    invoke-static/range {v0 .. v6}, Lcom/openfeint/internal/ui/WebViewCache;->access$1300(Lcom/openfeint/internal/ui/WebViewCache;I[BLjava/lang/String;Ljava/lang/String;ILjava/util/Set;)V

    return-void
.end method

.method public final path()Ljava/lang/String;
    .locals 1

    const-string v0, "/webui/assets"

    return-object v0
.end method

.method public final signed()Z
    .locals 1

    const/4 v0, 0x0

    return v0
.end method
