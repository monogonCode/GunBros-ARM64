.class Lcom/openfeint/internal/ui/WebNav$ActionHandler$3;
.super Lcom/openfeint/api/resource/Score$DownloadBlobCB;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/openfeint/internal/ui/WebNav$ActionHandler;->downloadBlob(Ljava/util/Map;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lcom/openfeint/internal/ui/WebNav$ActionHandler;

.field final synthetic val$onError:Ljava/lang/String;

.field final synthetic val$onSuccess:Ljava/lang/String;

.field final synthetic val$score:Lcom/openfeint/api/resource/Score;


# direct methods
.method constructor <init>(Lcom/openfeint/internal/ui/WebNav$ActionHandler;Ljava/lang/String;Lcom/openfeint/api/resource/Score;Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lcom/openfeint/internal/ui/WebNav$ActionHandler$3;->this$1:Lcom/openfeint/internal/ui/WebNav$ActionHandler;

    iput-object p2, p0, Lcom/openfeint/internal/ui/WebNav$ActionHandler$3;->val$onSuccess:Ljava/lang/String;

    iput-object p3, p0, Lcom/openfeint/internal/ui/WebNav$ActionHandler$3;->val$score:Lcom/openfeint/api/resource/Score;

    iput-object p4, p0, Lcom/openfeint/internal/ui/WebNav$ActionHandler$3;->val$onError:Ljava/lang/String;

    invoke-direct {p0}, Lcom/openfeint/api/resource/Score$DownloadBlobCB;-><init>()V

    return-void
.end method


# virtual methods
.method public onFailure(Ljava/lang/String;)V
    .locals 5

    iget-object v0, p0, Lcom/openfeint/internal/ui/WebNav$ActionHandler$3;->val$onError:Ljava/lang/String;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/openfeint/internal/ui/WebNav$ActionHandler$3;->this$1:Lcom/openfeint/internal/ui/WebNav$ActionHandler;

    iget-object v0, v0, Lcom/openfeint/internal/ui/WebNav$ActionHandler;->this$0:Lcom/openfeint/internal/ui/WebNav;

    const-string v1, "%s(%s)"

    const/4 v2, 0x2

    new-array v2, v2, [Ljava/lang/Object;

    const/4 v3, 0x0

    iget-object v4, p0, Lcom/openfeint/internal/ui/WebNav$ActionHandler$3;->val$onError:Ljava/lang/String;

    aput-object v4, v2, v3

    const/4 v3, 0x1

    aput-object p1, v2, v3

    invoke-static {v1, v2}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/openfeint/internal/ui/WebNav;->executeJavascript(Ljava/lang/String;)V

    :cond_0
    return-void
.end method

.method public onSuccess()V
    .locals 5

    iget-object v0, p0, Lcom/openfeint/internal/ui/WebNav$ActionHandler$3;->val$onSuccess:Ljava/lang/String;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/openfeint/internal/ui/WebNav$ActionHandler$3;->this$1:Lcom/openfeint/internal/ui/WebNav$ActionHandler;

    iget-object v0, v0, Lcom/openfeint/internal/ui/WebNav$ActionHandler;->this$0:Lcom/openfeint/internal/ui/WebNav;

    const-string v1, "%s()"

    const/4 v2, 0x1

    new-array v2, v2, [Ljava/lang/Object;

    const/4 v3, 0x0

    iget-object v4, p0, Lcom/openfeint/internal/ui/WebNav$ActionHandler$3;->val$onSuccess:Ljava/lang/String;

    aput-object v4, v2, v3

    invoke-static {v1, v2}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/openfeint/internal/ui/WebNav;->executeJavascript(Ljava/lang/String;)V

    :cond_0
    iget-object v0, p0, Lcom/openfeint/internal/ui/WebNav$ActionHandler$3;->val$score:Lcom/openfeint/api/resource/Score;

    invoke-static {v0}, Lcom/openfeint/internal/resource/ScoreBlobDelegate;->notifyBlobDownloaded(Lcom/openfeint/api/resource/Score;)V

    return-void
.end method
