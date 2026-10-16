.class Lcom/openfeint/internal/ui/WebNav$2;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/openfeint/internal/ui/WebNav;->onCreate(Landroid/os/Bundle;)V
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

    iput-object p1, p0, Lcom/openfeint/internal/ui/WebNav$2;->this$0:Lcom/openfeint/internal/ui/WebNav;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public action(Ljava/lang/String;)V
    .locals 2

    iget-object v0, p0, Lcom/openfeint/internal/ui/WebNav$2;->this$0:Lcom/openfeint/internal/ui/WebNav;

    new-instance v1, Lcom/openfeint/internal/ui/WebNav$2$1;

    invoke-direct {v1, p0, p1}, Lcom/openfeint/internal/ui/WebNav$2$1;-><init>(Lcom/openfeint/internal/ui/WebNav$2;Ljava/lang/String;)V

    invoke-virtual {v0, v1}, Lcom/openfeint/internal/ui/WebNav;->runOnUiThread(Ljava/lang/Runnable;)V

    return-void
.end method

.method public frameworkLoaded()V
    .locals 2

    iget-object v0, p0, Lcom/openfeint/internal/ui/WebNav$2;->this$0:Lcom/openfeint/internal/ui/WebNav;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Lcom/openfeint/internal/ui/WebNav;->setFrameworkLoaded(Z)V

    return-void
.end method
