.class final Lcom/openfeint/internal/request/Client$3;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/openfeint/internal/request/Client;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/openfeint/internal/request/Client;

.field final synthetic val$req:Lcom/openfeint/internal/request/BaseRequest;


# direct methods
.method constructor <init>(Lcom/openfeint/internal/request/Client;Lcom/openfeint/internal/request/BaseRequest;)V
    .locals 0

    iput-object p1, p0, Lcom/openfeint/internal/request/Client$3;->this$0:Lcom/openfeint/internal/request/Client;

    iput-object p2, p0, Lcom/openfeint/internal/request/Client$3;->val$req:Lcom/openfeint/internal/request/BaseRequest;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final run()V
    .locals 1

    iget-object v0, p0, Lcom/openfeint/internal/request/Client$3;->val$req:Lcom/openfeint/internal/request/BaseRequest;

    invoke-virtual {v0}, Lcom/openfeint/internal/request/BaseRequest;->onResponse()V

    return-void
.end method
