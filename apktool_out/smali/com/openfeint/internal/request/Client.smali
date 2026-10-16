.class public final Lcom/openfeint/internal/request/Client;
.super Lorg/apache/http/impl/client/DefaultHttpClient;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/openfeint/internal/request/Client$Executor;,
        Lcom/openfeint/internal/request/Client$GzipDecompressingEntity;
    }
.end annotation


# instance fields
.field private mCookieStore:Lcom/openfeint/internal/CookieStore;

.field final mExecutor:Ljava/util/concurrent/ExecutorService;

.field private mForceOffline:Z

.field private mMainThreadHandler:Landroid/os/Handler;

.field private mSigner:Lcom/openfeint/internal/request/Signer;


# direct methods
.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;Lcom/openfeint/internal/SyncedStore;)V
    .locals 5

    new-instance v0, Lorg/apache/http/conn/scheme/SchemeRegistry;

    invoke-direct {v0}, Lorg/apache/http/conn/scheme/SchemeRegistry;-><init>()V

    new-instance v1, Lorg/apache/http/conn/scheme/Scheme;

    const-string v2, "http"

    invoke-static {}, Lorg/apache/http/conn/scheme/PlainSocketFactory;->getSocketFactory()Lorg/apache/http/conn/scheme/PlainSocketFactory;

    move-result-object v3

    const/16 v4, 0x50

    invoke-direct {v1, v2, v3, v4}, Lorg/apache/http/conn/scheme/Scheme;-><init>(Ljava/lang/String;Lorg/apache/http/conn/scheme/SocketFactory;I)V

    invoke-virtual {v0, v1}, Lorg/apache/http/conn/scheme/SchemeRegistry;->register(Lorg/apache/http/conn/scheme/Scheme;)Lorg/apache/http/conn/scheme/Scheme;

    new-instance v1, Lorg/apache/http/conn/scheme/Scheme;

    const-string v2, "https"

    invoke-static {}, Lorg/apache/http/conn/ssl/SSLSocketFactory;->getSocketFactory()Lorg/apache/http/conn/ssl/SSLSocketFactory;

    move-result-object v3

    const/16 v4, 0x1bb

    invoke-direct {v1, v2, v3, v4}, Lorg/apache/http/conn/scheme/Scheme;-><init>(Ljava/lang/String;Lorg/apache/http/conn/scheme/SocketFactory;I)V

    invoke-virtual {v0, v1}, Lorg/apache/http/conn/scheme/SchemeRegistry;->register(Lorg/apache/http/conn/scheme/Scheme;)Lorg/apache/http/conn/scheme/Scheme;

    new-instance v1, Lorg/apache/http/impl/conn/tsccm/ThreadSafeClientConnManager;

    new-instance v2, Lorg/apache/http/params/BasicHttpParams;

    invoke-direct {v2}, Lorg/apache/http/params/BasicHttpParams;-><init>()V

    invoke-direct {v1, v2, v0}, Lorg/apache/http/impl/conn/tsccm/ThreadSafeClientConnManager;-><init>(Lorg/apache/http/params/HttpParams;Lorg/apache/http/conn/scheme/SchemeRegistry;)V

    new-instance v0, Lorg/apache/http/params/BasicHttpParams;

    invoke-direct {v0}, Lorg/apache/http/params/BasicHttpParams;-><init>()V

    invoke-direct {p0, v1, v0}, Lorg/apache/http/impl/client/DefaultHttpClient;-><init>(Lorg/apache/http/conn/ClientConnectionManager;Lorg/apache/http/params/HttpParams;)V

    new-instance v0, Lcom/openfeint/internal/request/Client$Executor;

    invoke-direct {v0, p0}, Lcom/openfeint/internal/request/Client$Executor;-><init>(Lcom/openfeint/internal/request/Client;)V

    iput-object v0, p0, Lcom/openfeint/internal/request/Client;->mExecutor:Ljava/util/concurrent/ExecutorService;

    new-instance v0, Lcom/openfeint/internal/request/Signer;

    invoke-direct {v0, p1, p2}, Lcom/openfeint/internal/request/Signer;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    iput-object v0, p0, Lcom/openfeint/internal/request/Client;->mSigner:Lcom/openfeint/internal/request/Signer;

    new-instance v0, Landroid/os/Handler;

    invoke-direct {v0}, Landroid/os/Handler;-><init>()V

    iput-object v0, p0, Lcom/openfeint/internal/request/Client;->mMainThreadHandler:Landroid/os/Handler;

    new-instance v0, Lcom/openfeint/internal/CookieStore;

    invoke-direct {v0, p3}, Lcom/openfeint/internal/CookieStore;-><init>(Lcom/openfeint/internal/SyncedStore;)V

    iput-object v0, p0, Lcom/openfeint/internal/request/Client;->mCookieStore:Lcom/openfeint/internal/CookieStore;

    iget-object v0, p0, Lcom/openfeint/internal/request/Client;->mCookieStore:Lcom/openfeint/internal/CookieStore;

    invoke-virtual {p0, v0}, Lcom/openfeint/internal/request/Client;->setCookieStore(Lorg/apache/http/client/CookieStore;)V

    new-instance v0, Lcom/openfeint/internal/request/Client$1;

    invoke-direct {v0, p0}, Lcom/openfeint/internal/request/Client$1;-><init>(Lcom/openfeint/internal/request/Client;)V

    invoke-virtual {p0, v0}, Lcom/openfeint/internal/request/Client;->addRequestInterceptor(Lorg/apache/http/HttpRequestInterceptor;)V

    new-instance v0, Lcom/openfeint/internal/request/Client$2;

    invoke-direct {v0, p0}, Lcom/openfeint/internal/request/Client$2;-><init>(Lcom/openfeint/internal/request/Client;)V

    invoke-virtual {p0, v0}, Lcom/openfeint/internal/request/Client;->addResponseInterceptor(Lorg/apache/http/HttpResponseInterceptor;)V

    return-void
.end method

.method static synthetic access$000(Lcom/openfeint/internal/request/Client;)Landroid/os/Handler;
    .locals 1

    iget-object v0, p0, Lcom/openfeint/internal/request/Client;->mMainThreadHandler:Landroid/os/Handler;

    return-object v0
.end method

.method static synthetic access$100(Lcom/openfeint/internal/request/Client;)Lcom/openfeint/internal/request/Signer;
    .locals 1

    iget-object v0, p0, Lcom/openfeint/internal/request/Client;->mSigner:Lcom/openfeint/internal/request/Signer;

    return-object v0
.end method

.method static synthetic access$200(Lcom/openfeint/internal/request/Client;)Z
    .locals 1

    iget-boolean v0, p0, Lcom/openfeint/internal/request/Client;->mForceOffline:Z

    return v0
.end method


# virtual methods
.method public final makeRequest(Lcom/openfeint/internal/request/BaseRequest;)V
    .locals 7

    invoke-virtual {p1}, Lcom/openfeint/internal/request/BaseRequest;->timeout()J

    move-result-wide v3

    new-instance v6, Lcom/openfeint/internal/request/Client$3;

    invoke-direct {v6, p0, p1}, Lcom/openfeint/internal/request/Client$3;-><init>(Lcom/openfeint/internal/request/Client;Lcom/openfeint/internal/request/BaseRequest;)V

    new-instance v2, Lcom/openfeint/internal/request/Client$4;

    invoke-direct {v2, p0, p1, v6}, Lcom/openfeint/internal/request/Client$4;-><init>(Lcom/openfeint/internal/request/Client;Lcom/openfeint/internal/request/BaseRequest;Ljava/lang/Runnable;)V

    new-instance v0, Lcom/openfeint/internal/request/Client$5;

    move-object v1, p0

    move-object v5, p1

    invoke-direct/range {v0 .. v6}, Lcom/openfeint/internal/request/Client$5;-><init>(Lcom/openfeint/internal/request/Client;Ljava/lang/Runnable;JLcom/openfeint/internal/request/BaseRequest;Ljava/lang/Runnable;)V

    iget-object v1, p0, Lcom/openfeint/internal/request/Client;->mExecutor:Ljava/util/concurrent/ExecutorService;

    invoke-interface {v1, v0}, Ljava/util/concurrent/ExecutorService;->submit(Ljava/lang/Runnable;)Ljava/util/concurrent/Future;

    move-result-object v0

    invoke-virtual {p1, v0}, Lcom/openfeint/internal/request/BaseRequest;->setFuture(Ljava/util/concurrent/Future;)V

    return-void
.end method

.method public final restoreInstanceState(Landroid/os/Bundle;)V
    .locals 1

    iget-object v0, p0, Lcom/openfeint/internal/request/Client;->mCookieStore:Lcom/openfeint/internal/CookieStore;

    invoke-virtual {v0, p1}, Lcom/openfeint/internal/CookieStore;->restoreInstanceState(Landroid/os/Bundle;)V

    const-string v0, "mForceOffline"

    invoke-virtual {p1, v0}, Landroid/os/Bundle;->getBoolean(Ljava/lang/String;)Z

    move-result v0

    iput-boolean v0, p0, Lcom/openfeint/internal/request/Client;->mForceOffline:Z

    return-void
.end method

.method public final saveInstanceState(Landroid/os/Bundle;)V
    .locals 2

    iget-object v0, p0, Lcom/openfeint/internal/request/Client;->mCookieStore:Lcom/openfeint/internal/CookieStore;

    invoke-virtual {v0, p1}, Lcom/openfeint/internal/CookieStore;->saveInstanceState(Landroid/os/Bundle;)V

    const-string v0, "mForceOffline"

    iget-boolean v1, p0, Lcom/openfeint/internal/request/Client;->mForceOffline:Z

    invoke-virtual {p1, v0, v1}, Landroid/os/Bundle;->putBoolean(Ljava/lang/String;Z)V

    return-void
.end method
