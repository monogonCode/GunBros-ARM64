.class final Lcom/openfeint/internal/request/Client$Executor;
.super Ljava/util/concurrent/ThreadPoolExecutor;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/openfeint/internal/request/Client;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x12
    name = "Executor"
.end annotation


# instance fields
.field final synthetic this$0:Lcom/openfeint/internal/request/Client;


# direct methods
.method constructor <init>(Lcom/openfeint/internal/request/Client;)V
    .locals 8

    iput-object p1, p0, Lcom/openfeint/internal/request/Client$Executor;->this$0:Lcom/openfeint/internal/request/Client;

    const/4 v1, 0x2

    const/4 v2, 0x4

    const-wide/16 v3, 0x1e

    sget-object v5, Ljava/util/concurrent/TimeUnit;->SECONDS:Ljava/util/concurrent/TimeUnit;

    new-instance v6, Ljava/util/concurrent/LinkedBlockingQueue;

    invoke-direct {v6}, Ljava/util/concurrent/LinkedBlockingQueue;-><init>()V

    new-instance v7, Lcom/openfeint/internal/request/Client$Executor$1;

    invoke-direct {v7, p1}, Lcom/openfeint/internal/request/Client$Executor$1;-><init>(Lcom/openfeint/internal/request/Client;)V

    move-object v0, p0

    invoke-direct/range {v0 .. v7}, Ljava/util/concurrent/ThreadPoolExecutor;-><init>(IIJLjava/util/concurrent/TimeUnit;Ljava/util/concurrent/BlockingQueue;Ljava/util/concurrent/RejectedExecutionHandler;)V

    return-void
.end method
