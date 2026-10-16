.class final Lcom/openfeint/internal/ui/WebViewCache$ManifestRequest$1;
.super Lcom/openfeint/internal/request/BaseRequest;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/openfeint/internal/ui/WebViewCache$ManifestRequest;->onResponseOffMainThread(I[B)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lcom/openfeint/internal/ui/WebViewCache$ManifestRequest;


# direct methods
.method constructor <init>(Lcom/openfeint/internal/ui/WebViewCache$ManifestRequest;)V
    .locals 0

    iput-object p1, p0, Lcom/openfeint/internal/ui/WebViewCache$ManifestRequest$1;->this$1:Lcom/openfeint/internal/ui/WebViewCache$ManifestRequest;

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
    .locals 2

    const/16 v0, 0xc8

    if-ne v0, p1, :cond_0

    :try_start_0
    iget-object v0, p0, Lcom/openfeint/internal/ui/WebViewCache$ManifestRequest$1;->this$1:Lcom/openfeint/internal/ui/WebViewCache$ManifestRequest;

    new-instance v1, Lcom/openfeint/internal/ui/WebViewCache$ManifestData;

    invoke-direct {v1, p2}, Lcom/openfeint/internal/ui/WebViewCache$ManifestData;-><init>([B)V

    invoke-static {v0, v1}, Lcom/openfeint/internal/ui/WebViewCache$ManifestRequest;->access$802(Lcom/openfeint/internal/ui/WebViewCache$ManifestRequest;Lcom/openfeint/internal/ui/WebViewCache$ManifestData;)Lcom/openfeint/internal/ui/WebViewCache$ManifestData;

    iget-object v0, p0, Lcom/openfeint/internal/ui/WebViewCache$ManifestRequest$1;->this$1:Lcom/openfeint/internal/ui/WebViewCache$ManifestRequest;

    invoke-static {v0}, Lcom/openfeint/internal/ui/WebViewCache$ManifestRequest;->access$900(Lcom/openfeint/internal/ui/WebViewCache$ManifestRequest;)V

    iget-object v0, p0, Lcom/openfeint/internal/ui/WebViewCache$ManifestRequest$1;->this$1:Lcom/openfeint/internal/ui/WebViewCache$ManifestRequest;

    invoke-virtual {p0}, Lcom/openfeint/internal/ui/WebViewCache$ManifestRequest$1;->getResponse()Lorg/apache/http/HttpResponse;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/openfeint/internal/ui/WebViewCache$ManifestRequest;->access$1000(Lcom/openfeint/internal/ui/WebViewCache$ManifestRequest;Lorg/apache/http/HttpResponse;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return-void

    :cond_0
    iget-object v0, p0, Lcom/openfeint/internal/ui/WebViewCache$ManifestRequest$1;->this$1:Lcom/openfeint/internal/ui/WebViewCache$ManifestRequest;

    iget-object v0, v0, Lcom/openfeint/internal/ui/WebViewCache$ManifestRequest;->this$0:Lcom/openfeint/internal/ui/WebViewCache;

    invoke-static {v0}, Lcom/openfeint/internal/ui/WebViewCache;->access$1100(Lcom/openfeint/internal/ui/WebViewCache;)V

    goto :goto_0

    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method public final path()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/openfeint/internal/ui/WebViewCache$ManifestRequest$1;->this$1:Lcom/openfeint/internal/ui/WebViewCache$ManifestRequest;

    invoke-virtual {v0}, Lcom/openfeint/internal/ui/WebViewCache$ManifestRequest;->path()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
