.class public final Lcom/openfeint/internal/request/GenericRequest;
.super Lcom/openfeint/internal/request/JSONContentRequest;


# instance fields
.field private mDelegate:Lcom/openfeint/internal/request/IRawRequestDelegate;

.field final mMethod:Ljava/lang/String;

.field final mPath:Ljava/lang/String;

.field private mRetries:I

.field private mTimeout:J


# direct methods
.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;Ljava/util/Map;Ljava/util/Map;Lcom/openfeint/internal/request/IRawRequestDelegate;)V
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/util/Map",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/Object;",
            ">;",
            "Ljava/util/Map",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/Object;",
            ">;",
            "Lcom/openfeint/internal/request/IRawRequestDelegate;",
            ")V"
        }
    .end annotation

    invoke-direct {p0}, Lcom/openfeint/internal/request/JSONContentRequest;-><init>()V

    invoke-super {p0}, Lcom/openfeint/internal/request/JSONContentRequest;->timeout()J

    move-result-wide v0

    iput-wide v0, p0, Lcom/openfeint/internal/request/GenericRequest;->mTimeout:J

    invoke-super {p0}, Lcom/openfeint/internal/request/JSONContentRequest;->numRetries()I

    move-result v0

    iput v0, p0, Lcom/openfeint/internal/request/GenericRequest;->mRetries:I

    if-eqz p4, :cond_5

    invoke-interface {p4}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :cond_0
    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_5

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/Map$Entry;

    invoke-interface {v0}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    invoke-interface {v0}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v0

    const-string v3, "connectionTimeout"

    invoke-virtual {v1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_1

    invoke-virtual {p0}, Lcom/openfeint/internal/request/GenericRequest;->getHttpParams()Lorg/apache/http/params/HttpParams;

    move-result-object v1

    invoke-static {v1, v0}, Lorg/apache/http/params/HttpConnectionParams;->setConnectionTimeout(Lorg/apache/http/params/HttpParams;I)V

    goto :goto_0

    :cond_1
    const-string v3, "socketTimeout"

    invoke-virtual {v1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_2

    invoke-virtual {p0}, Lcom/openfeint/internal/request/GenericRequest;->getHttpParams()Lorg/apache/http/params/HttpParams;

    move-result-object v1

    invoke-static {v1, v0}, Lorg/apache/http/params/HttpConnectionParams;->setSoTimeout(Lorg/apache/http/params/HttpParams;I)V

    goto :goto_0

    :cond_2
    const-string v3, "lingerTimeout"

    invoke-virtual {v1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_3

    invoke-virtual {p0}, Lcom/openfeint/internal/request/GenericRequest;->getHttpParams()Lorg/apache/http/params/HttpParams;

    move-result-object v1

    invoke-static {v1, v0}, Lorg/apache/http/params/HttpConnectionParams;->setLinger(Lorg/apache/http/params/HttpParams;I)V

    goto :goto_0

    :cond_3
    const-string v3, "timeout"

    invoke-virtual {v1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_4

    int-to-long v0, v0

    iput-wide v0, p0, Lcom/openfeint/internal/request/GenericRequest;->mTimeout:J

    goto :goto_0

    :cond_4
    const-string v3, "retries"

    invoke-virtual {v1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    iput v0, p0, Lcom/openfeint/internal/request/GenericRequest;->mRetries:I

    goto :goto_0

    :cond_5
    new-instance v0, Lcom/openfeint/internal/request/OrderedArgList;

    invoke-direct {v0, p3}, Lcom/openfeint/internal/request/OrderedArgList;-><init>(Ljava/util/Map;)V

    const-string v1, "format"

    const-string v2, "json"

    invoke-virtual {v0, v1, v2}, Lcom/openfeint/internal/request/OrderedArgList;->put(Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {p0, v0}, Lcom/openfeint/internal/request/GenericRequest;->setArgs(Lcom/openfeint/internal/request/OrderedArgList;)V

    iput-object p2, p0, Lcom/openfeint/internal/request/GenericRequest;->mMethod:Ljava/lang/String;

    iput-object p1, p0, Lcom/openfeint/internal/request/GenericRequest;->mPath:Ljava/lang/String;

    iput-object p5, p0, Lcom/openfeint/internal/request/GenericRequest;->mDelegate:Lcom/openfeint/internal/request/IRawRequestDelegate;

    return-void
.end method


# virtual methods
.method public final method()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/openfeint/internal/request/GenericRequest;->mMethod:Ljava/lang/String;

    return-object v0
.end method

.method public final numRetries()I
    .locals 1

    iget v0, p0, Lcom/openfeint/internal/request/GenericRequest;->mRetries:I

    return v0
.end method

.method public final onResponse(I[B)V
    .locals 2

    :try_start_0
    invoke-virtual {p0}, Lcom/openfeint/internal/request/GenericRequest;->isResponseJSON()Z

    move-result v0

    if-nez v0, :cond_1

    invoke-static {p1}, Lcom/openfeint/internal/request/GenericRequest;->notJSONError(I)Lcom/openfeint/internal/resource/ServerException;

    move-result-object v0

    invoke-virtual {v0}, Lcom/openfeint/internal/resource/ServerException;->generate()Ljava/lang/String;

    move-result-object v0

    :goto_0
    iget-object v1, p0, Lcom/openfeint/internal/request/GenericRequest;->mDelegate:Lcom/openfeint/internal/request/IRawRequestDelegate;

    if-eqz v1, :cond_0

    iget-object v1, p0, Lcom/openfeint/internal/request/GenericRequest;->mDelegate:Lcom/openfeint/internal/request/IRawRequestDelegate;

    invoke-interface {v1, p1, v0}, Lcom/openfeint/internal/request/IRawRequestDelegate;->onResponse(ILjava/lang/String;)V

    :cond_0
    :goto_1
    return-void

    :cond_1
    if-eqz p2, :cond_2

    new-instance v0, Ljava/lang/String;

    invoke-direct {v0, p2}, Ljava/lang/String;-><init>([B)V
    :try_end_0
    .catch Ljava/lang/IllegalStateException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/IllegalStateException;->printStackTrace()V

    goto :goto_1

    :cond_2
    :try_start_1
    const-string v0, ""
    :try_end_1
    .catch Ljava/lang/IllegalStateException; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_0
.end method

.method public final path()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/openfeint/internal/request/GenericRequest;->mPath:Ljava/lang/String;

    return-object v0
.end method

.method public final timeout()J
    .locals 2

    iget-wide v0, p0, Lcom/openfeint/internal/request/GenericRequest;->mTimeout:J

    return-wide v0
.end method
