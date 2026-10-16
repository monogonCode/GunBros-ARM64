.class final Lcom/openfeint/internal/request/BaseRequest$1;
.super Ljava/lang/Object;

# interfaces
.implements Lorg/apache/http/client/ResponseHandler;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/openfeint/internal/request/BaseRequest;->exec(Z)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Object;",
        "Lorg/apache/http/client/ResponseHandler",
        "<",
        "Ljava/lang/Object;",
        ">;"
    }
.end annotation


# instance fields
.field final synthetic this$0:Lcom/openfeint/internal/request/BaseRequest;

.field final synthetic val$context:Lorg/apache/http/protocol/HttpContext;


# direct methods
.method constructor <init>(Lcom/openfeint/internal/request/BaseRequest;Lorg/apache/http/protocol/HttpContext;)V
    .locals 0

    iput-object p1, p0, Lcom/openfeint/internal/request/BaseRequest$1;->this$0:Lcom/openfeint/internal/request/BaseRequest;

    iput-object p2, p0, Lcom/openfeint/internal/request/BaseRequest$1;->val$context:Lorg/apache/http/protocol/HttpContext;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final handleResponse(Lorg/apache/http/HttpResponse;)Ljava/lang/Object;
    .locals 6
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/apache/http/client/ClientProtocolException;,
            Ljava/io/IOException;
        }
    .end annotation

    const/4 v5, 0x0

    iget-object v0, p0, Lcom/openfeint/internal/request/BaseRequest$1;->val$context:Lorg/apache/http/protocol/HttpContext;

    const-string v1, "http.request"

    invoke-interface {v0, v1}, Lorg/apache/http/protocol/HttpContext;->getAttribute(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lorg/apache/http/client/methods/HttpUriRequest;

    iget-object v1, p0, Lcom/openfeint/internal/request/BaseRequest$1;->val$context:Lorg/apache/http/protocol/HttpContext;

    const-string v2, "http.target_host"

    invoke-interface {v1, v2}, Lorg/apache/http/protocol/HttpContext;->getAttribute(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lorg/apache/http/HttpHost;

    iget-object v2, p0, Lcom/openfeint/internal/request/BaseRequest$1;->this$0:Lcom/openfeint/internal/request/BaseRequest;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1}, Lorg/apache/http/HttpHost;->toURI()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-interface {v0}, Lorg/apache/http/client/methods/HttpUriRequest;->getURI()Ljava/net/URI;

    move-result-object v0

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v2, v0}, Lcom/openfeint/internal/request/BaseRequest;->access$002(Lcom/openfeint/internal/request/BaseRequest;Ljava/lang/String;)Ljava/lang/String;

    invoke-interface {p1}, Lorg/apache/http/HttpResponse;->getEntity()Lorg/apache/http/HttpEntity;

    move-result-object v0

    iget-object v1, p0, Lcom/openfeint/internal/request/BaseRequest$1;->this$0:Lcom/openfeint/internal/request/BaseRequest;

    new-array v2, v5, [B

    invoke-static {v1, v2}, Lcom/openfeint/internal/request/BaseRequest;->access$102(Lcom/openfeint/internal/request/BaseRequest;[B)[B

    iget-object v1, p0, Lcom/openfeint/internal/request/BaseRequest$1;->this$0:Lcom/openfeint/internal/request/BaseRequest;

    invoke-interface {p1}, Lorg/apache/http/HttpResponse;->getStatusLine()Lorg/apache/http/StatusLine;

    move-result-object v2

    invoke-interface {v2}, Lorg/apache/http/StatusLine;->getStatusCode()I

    move-result v2

    invoke-static {v1, v2}, Lcom/openfeint/internal/request/BaseRequest;->access$202(Lcom/openfeint/internal/request/BaseRequest;I)I

    if-eqz v0, :cond_2

    invoke-interface {v0}, Lorg/apache/http/HttpEntity;->getContentEncoding()Lorg/apache/http/Header;

    move-result-object v1

    if-eqz v1, :cond_0

    iget-object v2, p0, Lcom/openfeint/internal/request/BaseRequest$1;->this$0:Lcom/openfeint/internal/request/BaseRequest;

    invoke-interface {v1}, Lorg/apache/http/Header;->getValue()Ljava/lang/String;

    move-result-object v1

    invoke-static {v2, v1}, Lcom/openfeint/internal/request/BaseRequest;->access$302(Lcom/openfeint/internal/request/BaseRequest;Ljava/lang/String;)Ljava/lang/String;

    :cond_0
    invoke-interface {v0}, Lorg/apache/http/HttpEntity;->getContentType()Lorg/apache/http/Header;

    move-result-object v1

    if-eqz v1, :cond_1

    iget-object v2, p0, Lcom/openfeint/internal/request/BaseRequest$1;->this$0:Lcom/openfeint/internal/request/BaseRequest;

    invoke-interface {v1}, Lorg/apache/http/Header;->getValue()Ljava/lang/String;

    move-result-object v1

    invoke-static {v2, v1}, Lcom/openfeint/internal/request/BaseRequest;->access$402(Lcom/openfeint/internal/request/BaseRequest;Ljava/lang/String;)Ljava/lang/String;

    :cond_1
    iget-object v1, p0, Lcom/openfeint/internal/request/BaseRequest$1;->this$0:Lcom/openfeint/internal/request/BaseRequest;

    invoke-static {v0}, Lorg/apache/http/util/EntityUtils;->toByteArray(Lorg/apache/http/HttpEntity;)[B

    move-result-object v2

    invoke-static {v1, v2}, Lcom/openfeint/internal/request/BaseRequest;->access$102(Lcom/openfeint/internal/request/BaseRequest;[B)[B

    invoke-interface {v0}, Lorg/apache/http/HttpEntity;->getContentLength()J

    move-result-wide v1

    const-wide/16 v3, 0x0

    cmp-long v1, v1, v3

    if-ltz v1, :cond_2

    invoke-interface {v0}, Lorg/apache/http/HttpEntity;->getContentLength()J

    move-result-wide v0

    iget-object v2, p0, Lcom/openfeint/internal/request/BaseRequest$1;->this$0:Lcom/openfeint/internal/request/BaseRequest;

    invoke-static {v2}, Lcom/openfeint/internal/request/BaseRequest;->access$100(Lcom/openfeint/internal/request/BaseRequest;)[B

    move-result-object v2

    array-length v2, v2

    int-to-long v2, v2

    cmp-long v0, v0, v2

    if-eqz v0, :cond_2

    sget-object v0, Lcom/openfeint/internal/request/BaseRequest;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Content-Length mismatch with content - "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/openfeint/internal/request/BaseRequest$1;->this$0:Lcom/openfeint/internal/request/BaseRequest;

    invoke-static {v2}, Lcom/openfeint/internal/request/BaseRequest;->access$500(Lcom/openfeint/internal/request/BaseRequest;)Lorg/apache/http/client/methods/HttpUriRequest;

    move-result-object v2

    invoke-interface {v2}, Lorg/apache/http/client/methods/HttpUriRequest;->getURI()Ljava/net/URI;

    move-result-object v2

    invoke-virtual {v2}, Ljava/net/URI;->toASCIIString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/openfeint/internal/logcat/OFLog;->e(Ljava/lang/String;Ljava/lang/String;)V

    iget-object v0, p0, Lcom/openfeint/internal/request/BaseRequest$1;->this$0:Lcom/openfeint/internal/request/BaseRequest;

    invoke-static {v0, v5}, Lcom/openfeint/internal/request/BaseRequest;->access$202(Lcom/openfeint/internal/request/BaseRequest;I)I

    :cond_2
    iget-object v0, p0, Lcom/openfeint/internal/request/BaseRequest$1;->this$0:Lcom/openfeint/internal/request/BaseRequest;

    invoke-static {v0, p1}, Lcom/openfeint/internal/request/BaseRequest;->access$602(Lcom/openfeint/internal/request/BaseRequest;Lorg/apache/http/HttpResponse;)Lorg/apache/http/HttpResponse;

    const/4 v0, 0x0

    return-object v0
.end method
