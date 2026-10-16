.class final Lcom/openfeint/internal/request/BaseRequest$2;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/openfeint/internal/request/BaseRequest;->postTimeoutCleanup()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/openfeint/internal/request/BaseRequest;

.field final synthetic val$req:Lorg/apache/http/client/methods/HttpUriRequest;


# direct methods
.method constructor <init>(Lcom/openfeint/internal/request/BaseRequest;Lorg/apache/http/client/methods/HttpUriRequest;)V
    .locals 0

    iput-object p1, p0, Lcom/openfeint/internal/request/BaseRequest$2;->this$0:Lcom/openfeint/internal/request/BaseRequest;

    iput-object p2, p0, Lcom/openfeint/internal/request/BaseRequest$2;->val$req:Lorg/apache/http/client/methods/HttpUriRequest;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final run()V
    .locals 1

    :try_start_0
    iget-object v0, p0, Lcom/openfeint/internal/request/BaseRequest$2;->val$req:Lorg/apache/http/client/methods/HttpUriRequest;

    invoke-interface {v0}, Lorg/apache/http/client/methods/HttpUriRequest;->abort()V
    :try_end_0
    .catch Ljava/lang/UnsupportedOperationException; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return-void

    :catch_0
    move-exception v0

    goto :goto_0
.end method
