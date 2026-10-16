.class public abstract Lcom/openfeint/internal/request/RawRequest;
.super Lcom/openfeint/internal/request/JSONRequest;


# instance fields
.field private mDelegate:Lcom/openfeint/internal/request/IRawRequestDelegate;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Lcom/openfeint/internal/request/JSONRequest;-><init>()V

    return-void
.end method

.method public constructor <init>(Lcom/openfeint/internal/request/OrderedArgList;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/openfeint/internal/request/JSONRequest;-><init>(Lcom/openfeint/internal/request/OrderedArgList;)V

    return-void
.end method


# virtual methods
.method public final onResponse(I[B)V
    .locals 2

    :try_start_0
    invoke-super {p0, p1, p2}, Lcom/openfeint/internal/request/JSONRequest;->onResponse(I[B)V

    iget-object v0, p0, Lcom/openfeint/internal/request/RawRequest;->mDelegate:Lcom/openfeint/internal/request/IRawRequestDelegate;

    if-eqz v0, :cond_0

    invoke-virtual {p0}, Lcom/openfeint/internal/request/RawRequest;->isResponseJSON()Z

    move-result v0

    if-nez v0, :cond_1

    invoke-static {p1}, Lcom/openfeint/internal/request/RawRequest;->notJSONError(I)Lcom/openfeint/internal/resource/ServerException;

    move-result-object v0

    invoke-virtual {v0}, Lcom/openfeint/internal/resource/ServerException;->generate()Ljava/lang/String;

    move-result-object v0

    :goto_0
    iget-object v1, p0, Lcom/openfeint/internal/request/RawRequest;->mDelegate:Lcom/openfeint/internal/request/IRawRequestDelegate;

    invoke-interface {v1, p1, v0}, Lcom/openfeint/internal/request/IRawRequestDelegate;->onResponse(ILjava/lang/String;)V

    :cond_0
    :goto_1
    return-void

    :cond_1
    new-instance v0, Ljava/lang/String;

    invoke-direct {v0, p2}, Ljava/lang/String;-><init>([B)V
    :try_end_0
    .catch Ljava/lang/IllegalStateException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/IllegalStateException;->printStackTrace()V

    goto :goto_1
.end method

.method public final setDelegate(Lcom/openfeint/internal/request/IRawRequestDelegate;)V
    .locals 0

    iput-object p1, p0, Lcom/openfeint/internal/request/RawRequest;->mDelegate:Lcom/openfeint/internal/request/IRawRequestDelegate;

    return-void
.end method
