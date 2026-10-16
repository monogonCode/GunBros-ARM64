.class Lcom/openfeint/internal/ui/WebNav$ActionHandler$2;
.super Lcom/openfeint/internal/ui/WebViewCacheCallback;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/openfeint/internal/ui/WebNav$ActionHandler;->startLoading(Ljava/util/Map;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lcom/openfeint/internal/ui/WebNav$ActionHandler;


# direct methods
.method constructor <init>(Lcom/openfeint/internal/ui/WebNav$ActionHandler;)V
    .locals 0

    iput-object p1, p0, Lcom/openfeint/internal/ui/WebNav$ActionHandler$2;->this$1:Lcom/openfeint/internal/ui/WebNav$ActionHandler;

    invoke-direct {p0}, Lcom/openfeint/internal/ui/WebViewCacheCallback;-><init>()V

    return-void
.end method


# virtual methods
.method public failLoaded()V
    .locals 1

    iget-object v0, p0, Lcom/openfeint/internal/ui/WebNav$ActionHandler$2;->this$1:Lcom/openfeint/internal/ui/WebNav$ActionHandler;

    iget-object v0, v0, Lcom/openfeint/internal/ui/WebNav$ActionHandler;->this$0:Lcom/openfeint/internal/ui/WebNav;

    invoke-static {v0}, Lcom/openfeint/internal/ui/WebNav;->access$100(Lcom/openfeint/internal/ui/WebNav;)V

    return-void
.end method

.method public onTrackingNeeded()V
    .locals 1

    iget-object v0, p0, Lcom/openfeint/internal/ui/WebNav$ActionHandler$2;->this$1:Lcom/openfeint/internal/ui/WebNav$ActionHandler;

    iget-object v0, v0, Lcom/openfeint/internal/ui/WebNav$ActionHandler;->this$0:Lcom/openfeint/internal/ui/WebNav;

    invoke-static {v0}, Lcom/openfeint/internal/ui/WebNav;->access$300(Lcom/openfeint/internal/ui/WebNav;)V

    return-void
.end method

.method public pathLoaded(Ljava/lang/String;)V
    .locals 2

    iget-object v0, p0, Lcom/openfeint/internal/ui/WebNav$ActionHandler$2;->this$1:Lcom/openfeint/internal/ui/WebNav$ActionHandler;

    iget-object v0, v0, Lcom/openfeint/internal/ui/WebNav$ActionHandler;->this$0:Lcom/openfeint/internal/ui/WebNav;

    const-string v1, "OF.navigateToUrlCallback()"

    invoke-virtual {v0, v1}, Lcom/openfeint/internal/ui/WebNav;->executeJavascript(Ljava/lang/String;)V

    return-void
.end method
