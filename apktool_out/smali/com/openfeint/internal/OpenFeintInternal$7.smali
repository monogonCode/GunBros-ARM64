.class final Lcom/openfeint/internal/OpenFeintInternal$7;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/openfeint/internal/OpenFeintInternal;->_makeRequest(Lcom/openfeint/internal/request/BaseRequest;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/openfeint/internal/OpenFeintInternal;

.field final synthetic val$req:Lcom/openfeint/internal/request/BaseRequest;


# direct methods
.method constructor <init>(Lcom/openfeint/internal/OpenFeintInternal;Lcom/openfeint/internal/request/BaseRequest;)V
    .locals 0

    iput-object p1, p0, Lcom/openfeint/internal/OpenFeintInternal$7;->this$0:Lcom/openfeint/internal/OpenFeintInternal;

    iput-object p2, p0, Lcom/openfeint/internal/OpenFeintInternal$7;->val$req:Lcom/openfeint/internal/request/BaseRequest;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final run()V
    .locals 2

    iget-object v0, p0, Lcom/openfeint/internal/OpenFeintInternal$7;->this$0:Lcom/openfeint/internal/OpenFeintInternal;

    iget-object v0, v0, Lcom/openfeint/internal/OpenFeintInternal;->mClient:Lcom/openfeint/internal/request/Client;

    iget-object v1, p0, Lcom/openfeint/internal/OpenFeintInternal$7;->val$req:Lcom/openfeint/internal/request/BaseRequest;

    invoke-virtual {v0, v1}, Lcom/openfeint/internal/request/Client;->makeRequest(Lcom/openfeint/internal/request/BaseRequest;)V

    return-void
.end method
