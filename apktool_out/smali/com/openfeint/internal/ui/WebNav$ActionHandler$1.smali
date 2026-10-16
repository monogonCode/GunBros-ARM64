.class Lcom/openfeint/internal/ui/WebNav$ActionHandler$1;
.super Ljava/lang/Object;

# interfaces
.implements Lcom/openfeint/internal/request/IRawRequestDelegate;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/openfeint/internal/ui/WebNav$ActionHandler;->apiRequest(Ljava/util/Map;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lcom/openfeint/internal/ui/WebNav$ActionHandler;

.field final synthetic val$requestID:Ljava/lang/String;


# direct methods
.method constructor <init>(Lcom/openfeint/internal/ui/WebNav$ActionHandler;Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lcom/openfeint/internal/ui/WebNav$ActionHandler$1;->this$1:Lcom/openfeint/internal/ui/WebNav$ActionHandler;

    iput-object p2, p0, Lcom/openfeint/internal/ui/WebNav$ActionHandler$1;->val$requestID:Ljava/lang/String;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onResponse(ILjava/lang/String;)V
    .locals 5

    invoke-virtual {p2}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v1

    if-nez v1, :cond_0

    const-string v0, "{}"

    :cond_0
    const-string v1, "OF.api.completeRequest(\"%s\", \"%d\", %s)"

    const/4 v2, 0x3

    new-array v2, v2, [Ljava/lang/Object;

    const/4 v3, 0x0

    iget-object v4, p0, Lcom/openfeint/internal/ui/WebNav$ActionHandler$1;->val$requestID:Ljava/lang/String;

    aput-object v4, v2, v3

    const/4 v3, 0x1

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    aput-object v4, v2, v3

    const/4 v3, 0x2

    aput-object v0, v2, v3

    invoke-static {v1, v2}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Lcom/openfeint/internal/ui/WebNav$ActionHandler$1;->this$1:Lcom/openfeint/internal/ui/WebNav$ActionHandler;

    iget-object v1, v1, Lcom/openfeint/internal/ui/WebNav$ActionHandler;->mWebNav:Lcom/openfeint/internal/ui/WebNav;

    invoke-virtual {v1, v0}, Lcom/openfeint/internal/ui/WebNav;->executeJavascript(Ljava/lang/String;)V

    return-void
.end method
