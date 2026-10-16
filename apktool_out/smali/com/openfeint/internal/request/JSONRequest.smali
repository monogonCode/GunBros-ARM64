.class public abstract Lcom/openfeint/internal/request/JSONRequest;
.super Lcom/openfeint/internal/request/JSONContentRequest;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Lcom/openfeint/internal/request/JSONContentRequest;-><init>()V

    return-void
.end method

.method public constructor <init>(Lcom/openfeint/internal/request/OrderedArgList;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/openfeint/internal/request/JSONContentRequest;-><init>(Lcom/openfeint/internal/request/OrderedArgList;)V

    return-void
.end method


# virtual methods
.method protected final onFailure(Ljava/lang/Object;)V
    .locals 2

    const-string v0, "of_unknown_server_error"

    invoke-static {v0}, Lcom/openfeint/internal/RR;->string(Ljava/lang/String;)I

    move-result v0

    invoke-static {v0}, Lcom/openfeint/internal/OpenFeintInternal;->getRString(I)Ljava/lang/String;

    move-result-object v0

    if-eqz p1, :cond_0

    instance-of v1, p1, Lcom/openfeint/internal/resource/ServerException;

    if-eqz v1, :cond_0

    check-cast p1, Lcom/openfeint/internal/resource/ServerException;

    iget-object v0, p1, Lcom/openfeint/internal/resource/ServerException;->message:Ljava/lang/String;

    iget-boolean v1, p1, Lcom/openfeint/internal/resource/ServerException;->needsDeveloperAttention:Z

    if-eqz v1, :cond_0

    const-string v1, "ServerException"

    invoke-static {v1, v0}, Lcom/openfeint/internal/logcat/OFLog;->e(Ljava/lang/String;Ljava/lang/String;)V

    invoke-static {}, Lcom/openfeint/internal/OpenFeintInternal;->getInstance()Lcom/openfeint/internal/OpenFeintInternal;

    invoke-static {v0}, Lcom/openfeint/internal/OpenFeintInternal;->displayErrorDialog(Ljava/lang/CharSequence;)V

    :cond_0
    invoke-virtual {p0, v0}, Lcom/openfeint/internal/request/JSONRequest;->onFailure(Ljava/lang/String;)V

    return-void
.end method

.method public onFailure(Ljava/lang/String;)V
    .locals 0

    return-void
.end method

.method protected onResponse(ILjava/lang/Object;)V
    .locals 1

    const/16 v0, 0xc8

    if-gt v0, p1, :cond_1

    const/16 v0, 0x12c

    if-ge p1, v0, :cond_1

    if-eqz p2, :cond_0

    instance-of v0, p2, Lcom/openfeint/internal/resource/ServerException;

    if-nez v0, :cond_1

    :cond_0
    invoke-virtual {p0, p2}, Lcom/openfeint/internal/request/JSONRequest;->onSuccess(Ljava/lang/Object;)V

    :goto_0
    return-void

    :cond_1
    invoke-virtual {p0, p2}, Lcom/openfeint/internal/request/JSONRequest;->onFailure(Ljava/lang/Object;)V

    goto :goto_0
.end method

.method public onResponse(I[B)V
    .locals 2

    array-length v0, p2

    if-eqz v0, :cond_1

    array-length v0, p2

    const/4 v1, 0x1

    if-ne v0, v1, :cond_0

    const/4 v0, 0x0

    aget-byte v0, p2, v0

    const/16 v1, 0x20

    if-eq v0, v1, :cond_1

    :cond_0
    invoke-virtual {p0}, Lcom/openfeint/internal/request/JSONRequest;->isResponseJSON()Z

    move-result v0

    if-eqz v0, :cond_2

    :cond_1
    invoke-static {p2}, Lcom/openfeint/internal/Util;->getObjFromJson([B)Ljava/lang/Object;

    move-result-object v0

    invoke-virtual {p0, p1, v0}, Lcom/openfeint/internal/request/JSONRequest;->onResponse(ILjava/lang/Object;)V

    :goto_0
    return-void

    :cond_2
    invoke-static {p1}, Lcom/openfeint/internal/request/JSONRequest;->notJSONError(I)Lcom/openfeint/internal/resource/ServerException;

    move-result-object v0

    invoke-virtual {p0, p1, v0}, Lcom/openfeint/internal/request/JSONRequest;->onResponse(ILjava/lang/Object;)V

    goto :goto_0
.end method

.method public onSuccess(Ljava/lang/Object;)V
    .locals 0

    return-void
.end method
