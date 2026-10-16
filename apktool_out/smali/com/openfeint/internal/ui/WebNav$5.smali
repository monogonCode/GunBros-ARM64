.class Lcom/openfeint/internal/ui/WebNav$5;
.super Lcom/openfeint/internal/ui/WebViewCacheCallback;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/openfeint/internal/ui/WebNav;->loadInitialContent()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/openfeint/internal/ui/WebNav;


# direct methods
.method constructor <init>(Lcom/openfeint/internal/ui/WebNav;)V
    .locals 0

    iput-object p1, p0, Lcom/openfeint/internal/ui/WebNav$5;->this$0:Lcom/openfeint/internal/ui/WebNav;

    invoke-direct {p0}, Lcom/openfeint/internal/ui/WebViewCacheCallback;-><init>()V

    return-void
.end method


# virtual methods
.method public failLoaded()V
    .locals 1

    iget-object v0, p0, Lcom/openfeint/internal/ui/WebNav$5;->this$0:Lcom/openfeint/internal/ui/WebNav;

    invoke-static {v0}, Lcom/openfeint/internal/ui/WebNav;->access$100(Lcom/openfeint/internal/ui/WebNav;)V

    return-void
.end method

.method public pathLoaded(Ljava/lang/String;)V
    .locals 3

    iget-object v0, p0, Lcom/openfeint/internal/ui/WebNav$5;->this$0:Lcom/openfeint/internal/ui/WebNav;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "OF.navigateToUrl(\'"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/openfeint/internal/ui/WebNav$5;->this$0:Lcom/openfeint/internal/ui/WebNav;

    invoke-virtual {v2}, Lcom/openfeint/internal/ui/WebNav;->initialContentPath()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "\')"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/openfeint/internal/ui/WebNav;->executeJavascript(Ljava/lang/String;)V

    return-void
.end method
