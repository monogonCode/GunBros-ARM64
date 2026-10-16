.class Lcom/openfeint/internal/ui/WebNav$2$1;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/openfeint/internal/ui/WebNav$2;->action(Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lcom/openfeint/internal/ui/WebNav$2;

.field final synthetic val$actionUri:Ljava/lang/String;


# direct methods
.method constructor <init>(Lcom/openfeint/internal/ui/WebNav$2;Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lcom/openfeint/internal/ui/WebNav$2$1;->this$1:Lcom/openfeint/internal/ui/WebNav$2;

    iput-object p2, p0, Lcom/openfeint/internal/ui/WebNav$2$1;->val$actionUri:Ljava/lang/String;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    iget-object v0, p0, Lcom/openfeint/internal/ui/WebNav$2$1;->this$1:Lcom/openfeint/internal/ui/WebNav$2;

    iget-object v0, v0, Lcom/openfeint/internal/ui/WebNav$2;->this$0:Lcom/openfeint/internal/ui/WebNav;

    invoke-virtual {v0}, Lcom/openfeint/internal/ui/WebNav;->getActionHandler()Lcom/openfeint/internal/ui/WebNav$ActionHandler;

    move-result-object v0

    iget-object v1, p0, Lcom/openfeint/internal/ui/WebNav$2$1;->val$actionUri:Ljava/lang/String;

    invoke-static {v1}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/openfeint/internal/ui/WebNav$ActionHandler;->dispatch(Landroid/net/Uri;)V

    return-void
.end method
