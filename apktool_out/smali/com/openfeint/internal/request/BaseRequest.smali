.class public abstract Lcom/openfeint/internal/request/BaseRequest;
.super Ljava/lang/Object;


# static fields
.field private static DEFAULT_RETRIES:I

.field private static DEFAULT_TIMEOUT:J

.field protected static TAG:Ljava/lang/String;

.field private static sBaseServerURL:Ljava/lang/String;


# instance fields
.field protected mArgs:Lcom/openfeint/internal/request/OrderedArgList;

.field private mCurrentURL:Ljava/lang/String;

.field private mFuture:Ljava/util/concurrent/Future;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/concurrent/Future",
            "<*>;"
        }
    .end annotation
.end field

.field private mHttpParams:Lorg/apache/http/params/HttpParams;

.field private mKey:Ljava/lang/String;

.field private mRequest:Lorg/apache/http/client/methods/HttpUriRequest;

.field private mResponded:Z

.field private mResponseBody:[B

.field private mResponseCode:I

.field private mResponseEncoding:Ljava/lang/String;

.field private mResponseType:Ljava/lang/String;

.field private mRetriesLeft:I

.field private mSecondsSinceEpoch:J

.field private mSignature:Ljava/lang/String;

.field private response_:Lorg/apache/http/HttpResponse;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    const/4 v0, 0x2

    sput v0, Lcom/openfeint/internal/request/BaseRequest;->DEFAULT_RETRIES:I

    const-wide/16 v0, 0x4e20

    sput-wide v0, Lcom/openfeint/internal/request/BaseRequest;->DEFAULT_TIMEOUT:J

    const-string v0, "Request"

    sput-object v0, Lcom/openfeint/internal/request/BaseRequest;->TAG:Ljava/lang/String;

    const/4 v0, 0x0

    sput-object v0, Lcom/openfeint/internal/request/BaseRequest;->sBaseServerURL:Ljava/lang/String;

    return-void
.end method

.method public constructor <init>()V
    .locals 2

    const/4 v1, 0x0

    const/4 v0, 0x0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-boolean v1, p0, Lcom/openfeint/internal/request/BaseRequest;->mResponded:Z

    iput-object v0, p0, Lcom/openfeint/internal/request/BaseRequest;->mResponseEncoding:Ljava/lang/String;

    iput-object v0, p0, Lcom/openfeint/internal/request/BaseRequest;->mResponseType:Ljava/lang/String;

    iput-object v0, p0, Lcom/openfeint/internal/request/BaseRequest;->mSignature:Ljava/lang/String;

    iput-object v0, p0, Lcom/openfeint/internal/request/BaseRequest;->mKey:Ljava/lang/String;

    iput v1, p0, Lcom/openfeint/internal/request/BaseRequest;->mRetriesLeft:I

    iput-object v0, p0, Lcom/openfeint/internal/request/BaseRequest;->mCurrentURL:Ljava/lang/String;

    iput-object v0, p0, Lcom/openfeint/internal/request/BaseRequest;->mFuture:Ljava/util/concurrent/Future;

    iput-object v0, p0, Lcom/openfeint/internal/request/BaseRequest;->mHttpParams:Lorg/apache/http/params/HttpParams;

    return-void
.end method

.method public constructor <init>(Lcom/openfeint/internal/request/OrderedArgList;)V
    .locals 2

    const/4 v1, 0x0

    const/4 v0, 0x0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-boolean v1, p0, Lcom/openfeint/internal/request/BaseRequest;->mResponded:Z

    iput-object v0, p0, Lcom/openfeint/internal/request/BaseRequest;->mResponseEncoding:Ljava/lang/String;

    iput-object v0, p0, Lcom/openfeint/internal/request/BaseRequest;->mResponseType:Ljava/lang/String;

    iput-object v0, p0, Lcom/openfeint/internal/request/BaseRequest;->mSignature:Ljava/lang/String;

    iput-object v0, p0, Lcom/openfeint/internal/request/BaseRequest;->mKey:Ljava/lang/String;

    iput v1, p0, Lcom/openfeint/internal/request/BaseRequest;->mRetriesLeft:I

    iput-object v0, p0, Lcom/openfeint/internal/request/BaseRequest;->mCurrentURL:Ljava/lang/String;

    iput-object v0, p0, Lcom/openfeint/internal/request/BaseRequest;->mFuture:Ljava/util/concurrent/Future;

    iput-object v0, p0, Lcom/openfeint/internal/request/BaseRequest;->mHttpParams:Lorg/apache/http/params/HttpParams;

    iput-object p1, p0, Lcom/openfeint/internal/request/BaseRequest;->mArgs:Lcom/openfeint/internal/request/OrderedArgList;

    return-void
.end method

.method static synthetic access$002(Lcom/openfeint/internal/request/BaseRequest;Ljava/lang/String;)Ljava/lang/String;
    .locals 0

    iput-object p1, p0, Lcom/openfeint/internal/request/BaseRequest;->mCurrentURL:Ljava/lang/String;

    return-object p1
.end method

.method static synthetic access$100(Lcom/openfeint/internal/request/BaseRequest;)[B
    .locals 1

    iget-object v0, p0, Lcom/openfeint/internal/request/BaseRequest;->mResponseBody:[B

    return-object v0
.end method

.method static synthetic access$102(Lcom/openfeint/internal/request/BaseRequest;[B)[B
    .locals 0

    iput-object p1, p0, Lcom/openfeint/internal/request/BaseRequest;->mResponseBody:[B

    return-object p1
.end method

.method static synthetic access$202(Lcom/openfeint/internal/request/BaseRequest;I)I
    .locals 0

    iput p1, p0, Lcom/openfeint/internal/request/BaseRequest;->mResponseCode:I

    return p1
.end method

.method static synthetic access$302(Lcom/openfeint/internal/request/BaseRequest;Ljava/lang/String;)Ljava/lang/String;
    .locals 0

    iput-object p1, p0, Lcom/openfeint/internal/request/BaseRequest;->mResponseEncoding:Ljava/lang/String;

    return-object p1
.end method

.method static synthetic access$402(Lcom/openfeint/internal/request/BaseRequest;Ljava/lang/String;)Ljava/lang/String;
    .locals 0

    iput-object p1, p0, Lcom/openfeint/internal/request/BaseRequest;->mResponseType:Ljava/lang/String;

    return-object p1
.end method

.method static synthetic access$500(Lcom/openfeint/internal/request/BaseRequest;)Lorg/apache/http/client/methods/HttpUriRequest;
    .locals 1

    iget-object v0, p0, Lcom/openfeint/internal/request/BaseRequest;->mRequest:Lorg/apache/http/client/methods/HttpUriRequest;

    return-object v0
.end method

.method static synthetic access$602(Lcom/openfeint/internal/request/BaseRequest;Lorg/apache/http/HttpResponse;)Lorg/apache/http/HttpResponse;
    .locals 0

    iput-object p1, p0, Lcom/openfeint/internal/request/BaseRequest;->response_:Lorg/apache/http/HttpResponse;

    return-object p1
.end method

.method private fakeServerException(Lcom/openfeint/internal/resource/ServerException;)V
    .locals 1

    const/4 v0, 0x0

    iput v0, p0, Lcom/openfeint/internal/request/BaseRequest;->mResponseCode:I

    invoke-virtual {p1}, Lcom/openfeint/internal/resource/ServerException;->generate()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->getBytes()[B

    move-result-object v0

    iput-object v0, p0, Lcom/openfeint/internal/request/BaseRequest;->mResponseBody:[B

    const-string v0, "application/json;"

    iput-object v0, p0, Lcom/openfeint/internal/request/BaseRequest;->mResponseType:Ljava/lang/String;

    return-void
.end method


# virtual methods
.method protected final addParams(Lorg/apache/http/client/methods/HttpUriRequest;)V
    .locals 1

    iget-object v0, p0, Lcom/openfeint/internal/request/BaseRequest;->mHttpParams:Lorg/apache/http/params/HttpParams;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/openfeint/internal/request/BaseRequest;->mHttpParams:Lorg/apache/http/params/HttpParams;

    invoke-interface {p1, v0}, Lorg/apache/http/client/methods/HttpUriRequest;->setParams(Lorg/apache/http/params/HttpParams;)V

    :cond_0
    return-void
.end method

.method protected final currentURL()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/openfeint/internal/request/BaseRequest;->mCurrentURL:Ljava/lang/String;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/openfeint/internal/request/BaseRequest;->mCurrentURL:Ljava/lang/String;

    :goto_0
    return-object v0

    :cond_0
    invoke-virtual {p0}, Lcom/openfeint/internal/request/BaseRequest;->url()Ljava/lang/String;

    move-result-object v0

    goto :goto_0
.end method

.method public final exec(Z)V
    .locals 6

    const/4 v5, 0x0

    const/4 v4, 0x0

    invoke-virtual {p0}, Lcom/openfeint/internal/request/BaseRequest;->generateRequest()Lorg/apache/http/client/methods/HttpUriRequest;

    move-result-object v0

    iput-object v0, p0, Lcom/openfeint/internal/request/BaseRequest;->mRequest:Lorg/apache/http/client/methods/HttpUriRequest;

    invoke-virtual {p0}, Lcom/openfeint/internal/request/BaseRequest;->numRetries()I

    move-result v0

    iput v0, p0, Lcom/openfeint/internal/request/BaseRequest;->mRetriesLeft:I

    iput-object v4, p0, Lcom/openfeint/internal/request/BaseRequest;->mResponseBody:[B

    iput v5, p0, Lcom/openfeint/internal/request/BaseRequest;->mResponseCode:I

    iput-object v4, p0, Lcom/openfeint/internal/request/BaseRequest;->response_:Lorg/apache/http/HttpResponse;

    iget-object v0, p0, Lcom/openfeint/internal/request/BaseRequest;->mRequest:Lorg/apache/http/client/methods/HttpUriRequest;

    invoke-interface {v0}, Lorg/apache/http/client/methods/HttpUriRequest;->getURI()Ljava/net/URI;

    move-result-object v0

    invoke-virtual {v0}, Ljava/net/URI;->getPath()Ljava/lang/String;

    move-result-object v0

    const-string v1, "//"

    invoke-virtual {v0, v1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_2

    new-instance v0, Lcom/openfeint/internal/resource/ServerException;

    invoke-direct {v0}, Lcom/openfeint/internal/resource/ServerException;-><init>()V

    const-string v1, "RequestError"

    iput-object v1, v0, Lcom/openfeint/internal/resource/ServerException;->exceptionClass:Ljava/lang/String;

    const-string v1, "of_malformed_request_error"

    invoke-static {v1}, Lcom/openfeint/internal/RR;->string(Ljava/lang/String;)I

    move-result v1

    invoke-static {v1}, Lcom/openfeint/internal/OpenFeintInternal;->getRString(I)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/openfeint/internal/resource/ServerException;->message:Ljava/lang/String;

    const/4 v1, 0x1

    iput-boolean v1, v0, Lcom/openfeint/internal/resource/ServerException;->needsDeveloperAttention:Z

    invoke-direct {p0, v0}, Lcom/openfeint/internal/request/BaseRequest;->fakeServerException(Lcom/openfeint/internal/resource/ServerException;)V

    :cond_0
    :goto_0
    iget v0, p0, Lcom/openfeint/internal/request/BaseRequest;->mResponseCode:I

    iget-object v1, p0, Lcom/openfeint/internal/request/BaseRequest;->mResponseBody:[B

    invoke-virtual {p0, v0, v1}, Lcom/openfeint/internal/request/BaseRequest;->onResponseOffMainThread(I[B)V

    return-void

    :cond_1
    :try_start_0
    invoke-static {}, Lcom/openfeint/internal/OpenFeintInternal;->getInstance()Lcom/openfeint/internal/OpenFeintInternal;

    move-result-object v0

    invoke-virtual {v0}, Lcom/openfeint/internal/OpenFeintInternal;->getClient()Lorg/apache/http/impl/client/AbstractHttpClient;

    move-result-object v0

    new-instance v1, Lorg/apache/http/protocol/BasicHttpContext;

    invoke-direct {v1}, Lorg/apache/http/protocol/BasicHttpContext;-><init>()V

    new-instance v2, Lcom/openfeint/internal/request/BaseRequest$1;

    invoke-direct {v2, p0, v1}, Lcom/openfeint/internal/request/BaseRequest$1;-><init>(Lcom/openfeint/internal/request/BaseRequest;Lorg/apache/http/protocol/HttpContext;)V

    iget-object v3, p0, Lcom/openfeint/internal/request/BaseRequest;->mRequest:Lorg/apache/http/client/methods/HttpUriRequest;

    invoke-virtual {v0, v3, v2, v1}, Lorg/apache/http/impl/client/AbstractHttpClient;->execute(Lorg/apache/http/client/methods/HttpUriRequest;Lorg/apache/http/client/ResponseHandler;Lorg/apache/http/protocol/HttpContext;)Ljava/lang/Object;

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/openfeint/internal/request/BaseRequest;->mRequest:Lorg/apache/http/client/methods/HttpUriRequest;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :cond_2
    iget-object v0, p0, Lcom/openfeint/internal/request/BaseRequest;->mResponseBody:[B

    if-nez v0, :cond_0

    if-eqz p1, :cond_1

    const/4 v0, 0x0

    :try_start_1
    iput v0, p0, Lcom/openfeint/internal/request/BaseRequest;->mRetriesLeft:I

    new-instance v0, Ljava/lang/Exception;

    const-string v1, "Forced failure"

    invoke-direct {v0, v1}, Ljava/lang/Exception;-><init>(Ljava/lang/String;)V

    throw v0
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    :catch_0
    move-exception v0

    sget-object v1, Lcom/openfeint/internal/request/BaseRequest;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Error executing request \'"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {p0}, Lcom/openfeint/internal/request/BaseRequest;->path()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "\'."

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/openfeint/internal/logcat/OFLog;->e(Ljava/lang/String;Ljava/lang/String;)V

    sget-object v1, Ljava/lang/System;->err:Ljava/io/PrintStream;

    invoke-virtual {v0, v1}, Ljava/lang/Exception;->printStackTrace(Ljava/io/PrintStream;)V

    iput-object v4, p0, Lcom/openfeint/internal/request/BaseRequest;->mResponseBody:[B

    iput v5, p0, Lcom/openfeint/internal/request/BaseRequest;->mResponseCode:I

    iput-object v4, p0, Lcom/openfeint/internal/request/BaseRequest;->response_:Lorg/apache/http/HttpResponse;

    iget v1, p0, Lcom/openfeint/internal/request/BaseRequest;->mRetriesLeft:I

    add-int/lit8 v1, v1, -0x1

    iput v1, p0, Lcom/openfeint/internal/request/BaseRequest;->mRetriesLeft:I

    if-gez v1, :cond_2

    new-instance v1, Lcom/openfeint/internal/resource/ServerException;

    invoke-direct {v1}, Lcom/openfeint/internal/resource/ServerException;-><init>()V

    invoke-virtual {v0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v2

    iput-object v2, v1, Lcom/openfeint/internal/resource/ServerException;->exceptionClass:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v0

    iput-object v0, v1, Lcom/openfeint/internal/resource/ServerException;->message:Ljava/lang/String;

    iget-object v0, v1, Lcom/openfeint/internal/resource/ServerException;->message:Ljava/lang/String;

    if-nez v0, :cond_3

    const-string v0, "of_unknown_server_error"

    invoke-static {v0}, Lcom/openfeint/internal/RR;->string(Ljava/lang/String;)I

    move-result v0

    invoke-static {v0}, Lcom/openfeint/internal/OpenFeintInternal;->getRString(I)Ljava/lang/String;

    move-result-object v0

    iput-object v0, v1, Lcom/openfeint/internal/resource/ServerException;->message:Ljava/lang/String;

    :cond_3
    invoke-direct {p0, v1}, Lcom/openfeint/internal/request/BaseRequest;->fakeServerException(Lcom/openfeint/internal/resource/ServerException;)V

    goto/16 :goto_0
.end method

.method protected generateRequest()Lorg/apache/http/client/methods/HttpUriRequest;
    .locals 5

    const/4 v1, 0x0

    invoke-virtual {p0}, Lcom/openfeint/internal/request/BaseRequest;->method()Ljava/lang/String;

    move-result-object v2

    const-string v0, "GET"

    invoke-virtual {v2, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    const-string v0, "DELETE"

    invoke-virtual {v2, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_4

    :cond_0
    invoke-virtual {p0}, Lcom/openfeint/internal/request/BaseRequest;->url()Ljava/lang/String;

    move-result-object v0

    iget-object v3, p0, Lcom/openfeint/internal/request/BaseRequest;->mArgs:Lcom/openfeint/internal/request/OrderedArgList;

    invoke-virtual {v3}, Lcom/openfeint/internal/request/OrderedArgList;->getArgString()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_1

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v4, "?"

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    :cond_1
    const-string v3, "GET"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_3

    new-instance v1, Lorg/apache/http/client/methods/HttpGet;

    invoke-direct {v1, v0}, Lorg/apache/http/client/methods/HttpGet;-><init>(Ljava/lang/String;)V

    move-object v0, v1

    :goto_0
    invoke-virtual {p0}, Lcom/openfeint/internal/request/BaseRequest;->signed()Z

    move-result v1

    if-eqz v1, :cond_2

    iget-object v1, p0, Lcom/openfeint/internal/request/BaseRequest;->mSignature:Ljava/lang/String;

    if-eqz v1, :cond_2

    iget-object v1, p0, Lcom/openfeint/internal/request/BaseRequest;->mKey:Ljava/lang/String;

    if-eqz v1, :cond_2

    const-string v1, "X-OF-Signature"

    iget-object v2, p0, Lcom/openfeint/internal/request/BaseRequest;->mSignature:Ljava/lang/String;

    invoke-interface {v0, v1, v2}, Lorg/apache/http/client/methods/HttpUriRequest;->addHeader(Ljava/lang/String;Ljava/lang/String;)V

    const-string v1, "X-OF-Key"

    iget-object v2, p0, Lcom/openfeint/internal/request/BaseRequest;->mKey:Ljava/lang/String;

    invoke-interface {v0, v1, v2}, Lorg/apache/http/client/methods/HttpUriRequest;->addHeader(Ljava/lang/String;Ljava/lang/String;)V

    :cond_2
    invoke-virtual {p0, v0}, Lcom/openfeint/internal/request/BaseRequest;->addParams(Lorg/apache/http/client/methods/HttpUriRequest;)V

    return-object v0

    :cond_3
    const-string v3, "DELETE"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_7

    new-instance v1, Lorg/apache/http/client/methods/HttpDelete;

    invoke-direct {v1, v0}, Lorg/apache/http/client/methods/HttpDelete;-><init>(Ljava/lang/String;)V

    move-object v0, v1

    goto :goto_0

    :cond_4
    const-string v0, "POST"

    invoke-virtual {v2, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_5

    new-instance v0, Lorg/apache/http/client/methods/HttpPost;

    invoke-virtual {p0}, Lcom/openfeint/internal/request/BaseRequest;->url()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Lorg/apache/http/client/methods/HttpPost;-><init>(Ljava/lang/String;)V

    :goto_1
    :try_start_0
    const-string v1, "UTF-8"

    new-instance v2, Lorg/apache/http/client/entity/UrlEncodedFormEntity;

    iget-object v3, p0, Lcom/openfeint/internal/request/BaseRequest;->mArgs:Lcom/openfeint/internal/request/OrderedArgList;

    iget-object v3, v3, Lcom/openfeint/internal/request/OrderedArgList;->mArgs:Ljava/util/ArrayList;

    invoke-direct {v2, v3, v1}, Lorg/apache/http/client/entity/UrlEncodedFormEntity;-><init>(Ljava/util/List;Ljava/lang/String;)V

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "application/x-www-form-urlencoded; charset="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v2, v1}, Lorg/apache/http/client/entity/UrlEncodedFormEntity;->setContentType(Ljava/lang/String;)V

    invoke-virtual {v0, v2}, Lorg/apache/http/client/methods/HttpEntityEnclosingRequestBase;->setEntity(Lorg/apache/http/HttpEntity;)V
    :try_end_0
    .catch Ljava/io/UnsupportedEncodingException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v1

    sget-object v2, Lcom/openfeint/internal/request/BaseRequest;->TAG:Ljava/lang/String;

    const-string v3, "Unable to encode request."

    invoke-static {v2, v3}, Lcom/openfeint/internal/logcat/OFLog;->e(Ljava/lang/String;Ljava/lang/String;)V

    sget-object v2, Ljava/lang/System;->err:Ljava/io/PrintStream;

    invoke-virtual {v1, v2}, Ljava/io/UnsupportedEncodingException;->printStackTrace(Ljava/io/PrintStream;)V

    goto :goto_0

    :cond_5
    const-string v0, "PUT"

    invoke-virtual {v2, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_6

    new-instance v0, Lorg/apache/http/client/methods/HttpPut;

    invoke-virtual {p0}, Lcom/openfeint/internal/request/BaseRequest;->url()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Lorg/apache/http/client/methods/HttpPut;-><init>(Ljava/lang/String;)V

    goto :goto_1

    :cond_6
    new-instance v0, Ljava/lang/RuntimeException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Unsupported HTTP method: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    throw v0

    :cond_7
    move-object v0, v1

    goto/16 :goto_0
.end method

.method public final getFuture()Ljava/util/concurrent/Future;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/concurrent/Future",
            "<*>;"
        }
    .end annotation

    iget-object v0, p0, Lcom/openfeint/internal/request/BaseRequest;->mFuture:Ljava/util/concurrent/Future;

    return-object v0
.end method

.method protected final getHttpParams()Lorg/apache/http/params/HttpParams;
    .locals 1

    iget-object v0, p0, Lcom/openfeint/internal/request/BaseRequest;->mHttpParams:Lorg/apache/http/params/HttpParams;

    if-nez v0, :cond_0

    new-instance v0, Lorg/apache/http/params/BasicHttpParams;

    invoke-direct {v0}, Lorg/apache/http/params/BasicHttpParams;-><init>()V

    iput-object v0, p0, Lcom/openfeint/internal/request/BaseRequest;->mHttpParams:Lorg/apache/http/params/HttpParams;

    :cond_0
    iget-object v0, p0, Lcom/openfeint/internal/request/BaseRequest;->mHttpParams:Lorg/apache/http/params/HttpParams;

    return-object v0
.end method

.method public final getResponse()Lorg/apache/http/HttpResponse;
    .locals 1

    iget-object v0, p0, Lcom/openfeint/internal/request/BaseRequest;->response_:Lorg/apache/http/HttpResponse;

    return-object v0
.end method

.method protected final getResponseType()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/openfeint/internal/request/BaseRequest;->mResponseType:Ljava/lang/String;

    return-object v0
.end method

.method public final launch()V
    .locals 0

    invoke-static {p0}, Lcom/openfeint/internal/OpenFeintInternal;->makeRequest(Lcom/openfeint/internal/request/BaseRequest;)V

    return-void
.end method

.method public abstract method()Ljava/lang/String;
.end method

.method public needsDeviceSession()Z
    .locals 1

    invoke-virtual {p0}, Lcom/openfeint/internal/request/BaseRequest;->signed()Z

    move-result v0

    return v0
.end method

.method public numRetries()I
    .locals 1

    sget v0, Lcom/openfeint/internal/request/BaseRequest;->DEFAULT_RETRIES:I

    return v0
.end method

.method public final onResponse()V
    .locals 2

    iget-boolean v0, p0, Lcom/openfeint/internal/request/BaseRequest;->mResponded:Z

    if-nez v0, :cond_1

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/openfeint/internal/request/BaseRequest;->mResponded:Z

    iget-object v0, p0, Lcom/openfeint/internal/request/BaseRequest;->mResponseBody:[B

    if-nez v0, :cond_0

    const/4 v0, 0x0

    iput v0, p0, Lcom/openfeint/internal/request/BaseRequest;->mResponseCode:I

    new-instance v0, Lcom/openfeint/internal/resource/ServerException;

    invoke-direct {v0}, Lcom/openfeint/internal/resource/ServerException;-><init>()V

    const-string v1, "Unknown"

    iput-object v1, v0, Lcom/openfeint/internal/resource/ServerException;->exceptionClass:Ljava/lang/String;

    const-string v1, "of_unknown_server_error"

    invoke-static {v1}, Lcom/openfeint/internal/RR;->string(Ljava/lang/String;)I

    move-result v1

    invoke-static {v1}, Lcom/openfeint/internal/OpenFeintInternal;->getRString(I)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/openfeint/internal/resource/ServerException;->message:Ljava/lang/String;

    invoke-direct {p0, v0}, Lcom/openfeint/internal/request/BaseRequest;->fakeServerException(Lcom/openfeint/internal/resource/ServerException;)V

    :cond_0
    iget v0, p0, Lcom/openfeint/internal/request/BaseRequest;->mResponseCode:I

    iget-object v1, p0, Lcom/openfeint/internal/request/BaseRequest;->mResponseBody:[B

    invoke-virtual {p0, v0, v1}, Lcom/openfeint/internal/request/BaseRequest;->onResponse(I[B)V

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/openfeint/internal/request/BaseRequest;->response_:Lorg/apache/http/HttpResponse;

    :cond_1
    return-void
.end method

.method public abstract onResponse(I[B)V
.end method

.method protected onResponseOffMainThread(I[B)V
    .locals 0

    return-void
.end method

.method public abstract path()Ljava/lang/String;
.end method

.method public final postTimeoutCleanup()V
    .locals 3

    iget-object v0, p0, Lcom/openfeint/internal/request/BaseRequest;->mRequest:Lorg/apache/http/client/methods/HttpUriRequest;

    const/4 v1, 0x0

    iput-object v1, p0, Lcom/openfeint/internal/request/BaseRequest;->mRequest:Lorg/apache/http/client/methods/HttpUriRequest;

    if-eqz v0, :cond_0

    new-instance v1, Ljava/lang/Thread;

    new-instance v2, Lcom/openfeint/internal/request/BaseRequest$2;

    invoke-direct {v2, p0, v0}, Lcom/openfeint/internal/request/BaseRequest$2;-><init>(Lcom/openfeint/internal/request/BaseRequest;Lorg/apache/http/client/methods/HttpUriRequest;)V

    invoke-direct {v1, v2}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    invoke-virtual {v1}, Ljava/lang/Thread;->start()V

    :cond_0
    new-instance v0, Lcom/openfeint/internal/resource/ServerException;

    invoke-direct {v0}, Lcom/openfeint/internal/resource/ServerException;-><init>()V

    const-string v1, "Timeout"

    iput-object v1, v0, Lcom/openfeint/internal/resource/ServerException;->exceptionClass:Ljava/lang/String;

    const-string v1, "of_timeout"

    invoke-static {v1}, Lcom/openfeint/internal/RR;->string(Ljava/lang/String;)I

    move-result v1

    invoke-static {v1}, Lcom/openfeint/internal/OpenFeintInternal;->getRString(I)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/openfeint/internal/resource/ServerException;->message:Ljava/lang/String;

    invoke-direct {p0, v0}, Lcom/openfeint/internal/request/BaseRequest;->fakeServerException(Lcom/openfeint/internal/resource/ServerException;)V

    return-void
.end method

.method public final setArgs(Lcom/openfeint/internal/request/OrderedArgList;)V
    .locals 0

    iput-object p1, p0, Lcom/openfeint/internal/request/BaseRequest;->mArgs:Lcom/openfeint/internal/request/OrderedArgList;

    return-void
.end method

.method public final setFuture(Ljava/util/concurrent/Future;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/concurrent/Future",
            "<*>;)V"
        }
    .end annotation

    iput-object p1, p0, Lcom/openfeint/internal/request/BaseRequest;->mFuture:Ljava/util/concurrent/Future;

    return-void
.end method

.method public final sign(Lcom/openfeint/internal/request/Signer;)V
    .locals 4

    iget-object v0, p0, Lcom/openfeint/internal/request/BaseRequest;->mArgs:Lcom/openfeint/internal/request/OrderedArgList;

    if-nez v0, :cond_0

    new-instance v0, Lcom/openfeint/internal/request/OrderedArgList;

    invoke-direct {v0}, Lcom/openfeint/internal/request/OrderedArgList;-><init>()V

    iput-object v0, p0, Lcom/openfeint/internal/request/BaseRequest;->mArgs:Lcom/openfeint/internal/request/OrderedArgList;

    :cond_0
    invoke-virtual {p0}, Lcom/openfeint/internal/request/BaseRequest;->signed()Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    const-wide/16 v2, 0x3e8

    div-long/2addr v0, v2

    iput-wide v0, p0, Lcom/openfeint/internal/request/BaseRequest;->mSecondsSinceEpoch:J

    invoke-virtual {p0}, Lcom/openfeint/internal/request/BaseRequest;->path()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0}, Lcom/openfeint/internal/request/BaseRequest;->method()Ljava/lang/String;

    move-result-object v1

    iget-wide v2, p0, Lcom/openfeint/internal/request/BaseRequest;->mSecondsSinceEpoch:J

    iget-object v2, p0, Lcom/openfeint/internal/request/BaseRequest;->mArgs:Lcom/openfeint/internal/request/OrderedArgList;

    invoke-virtual {p1, v0, v1, v2}, Lcom/openfeint/internal/request/Signer;->sign$32bca35c(Ljava/lang/String;Ljava/lang/String;Lcom/openfeint/internal/request/OrderedArgList;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/openfeint/internal/request/BaseRequest;->mSignature:Ljava/lang/String;

    invoke-virtual {p1}, Lcom/openfeint/internal/request/Signer;->getKey()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/openfeint/internal/request/BaseRequest;->mKey:Ljava/lang/String;

    :cond_1
    return-void
.end method

.method public signed()Z
    .locals 1

    const/4 v0, 0x1

    return v0
.end method

.method public timeout()J
    .locals 2

    sget-wide v0, Lcom/openfeint/internal/request/BaseRequest;->DEFAULT_TIMEOUT:J

    return-wide v0
.end method

.method public url()Ljava/lang/String;
    .locals 2

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v1, Lcom/openfeint/internal/request/BaseRequest;->sBaseServerURL:Ljava/lang/String;

    if-nez v1, :cond_0

    invoke-static {}, Lcom/openfeint/internal/OpenFeintInternal;->getInstance()Lcom/openfeint/internal/OpenFeintInternal;

    move-result-object v1

    invoke-virtual {v1}, Lcom/openfeint/internal/OpenFeintInternal;->getServerUrl()Ljava/lang/String;

    move-result-object v1

    sput-object v1, Lcom/openfeint/internal/request/BaseRequest;->sBaseServerURL:Ljava/lang/String;

    :cond_0
    sget-object v1, Lcom/openfeint/internal/request/BaseRequest;->sBaseServerURL:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {p0}, Lcom/openfeint/internal/request/BaseRequest;->path()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public wantsLogin()Z
    .locals 1

    const/4 v0, 0x0

    return v0
.end method
