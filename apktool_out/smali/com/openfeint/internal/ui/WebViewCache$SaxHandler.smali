.class final Lcom/openfeint/internal/ui/WebViewCache$SaxHandler;
.super Lorg/xml/sax/helpers/DefaultHandler;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/openfeint/internal/ui/WebViewCache;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "SaxHandler"
.end annotation


# instance fields
.field key:Ljava/lang/String;

.field loadingString:Ljava/lang/String;

.field outputMap:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field final synthetic this$0:Lcom/openfeint/internal/ui/WebViewCache;


# direct methods
.method synthetic constructor <init>(Lcom/openfeint/internal/ui/WebViewCache;)V
    .locals 1

    const/4 v0, 0x0

    invoke-direct {p0, p1, v0}, Lcom/openfeint/internal/ui/WebViewCache$SaxHandler;-><init>(Lcom/openfeint/internal/ui/WebViewCache;B)V

    return-void
.end method

.method private constructor <init>(Lcom/openfeint/internal/ui/WebViewCache;B)V
    .locals 1

    iput-object p1, p0, Lcom/openfeint/internal/ui/WebViewCache$SaxHandler;->this$0:Lcom/openfeint/internal/ui/WebViewCache;

    invoke-direct {p0}, Lorg/xml/sax/helpers/DefaultHandler;-><init>()V

    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lcom/openfeint/internal/ui/WebViewCache$SaxHandler;->outputMap:Ljava/util/Map;

    return-void
.end method


# virtual methods
.method public final characters([CII)V
    .locals 2

    new-instance v0, Ljava/lang/String;

    invoke-direct {v0, p1}, Ljava/lang/String;-><init>([C)V

    add-int v1, p2, p3

    invoke-virtual {v0, p2, v1}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/openfeint/internal/ui/WebViewCache$SaxHandler;->loadingString:Ljava/lang/String;

    return-void
.end method

.method public final endElement(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 6

    invoke-virtual {p2}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0

    const-string v1, "key"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_1

    iget-object v0, p0, Lcom/openfeint/internal/ui/WebViewCache$SaxHandler;->loadingString:Ljava/lang/String;

    iput-object v0, p0, Lcom/openfeint/internal/ui/WebViewCache$SaxHandler;->key:Ljava/lang/String;

    :cond_0
    :goto_0
    return-void

    :cond_1
    const-string v1, "string"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/openfeint/internal/ui/WebViewCache$SaxHandler;->outputMap:Ljava/util/Map;

    iget-object v1, p0, Lcom/openfeint/internal/ui/WebViewCache$SaxHandler;->key:Ljava/lang/String;

    iget-object v2, p0, Lcom/openfeint/internal/ui/WebViewCache$SaxHandler;->loadingString:Ljava/lang/String;

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Lcom/openfeint/internal/ui/WebViewCache$SaxHandler;->key:Ljava/lang/String;

    iget-object v1, p0, Lcom/openfeint/internal/ui/WebViewCache$SaxHandler;->loadingString:Ljava/lang/String;

    :try_start_0
    sget-object v2, Lcom/openfeint/internal/db/DB;->storeHelper:Lcom/openfeint/internal/db/DB$DataStorageHelperX;

    invoke-virtual {v2}, Lcom/openfeint/internal/db/DB$DataStorageHelperX;->getWritableDatabase()Landroid/database/sqlite/SQLiteDatabase;

    move-result-object v2

    const-string v3, "INSERT OR REPLACE INTO manifest(path, hash) VALUES(?,?)"

    const/4 v4, 0x2

    new-array v4, v4, [Ljava/lang/String;

    const/4 v5, 0x0

    aput-object v0, v4, v5

    const/4 v0, 0x1

    aput-object v1, v4, v0

    invoke-virtual {v2, v3, v4}, Landroid/database/sqlite/SQLiteDatabase;->execSQL(Ljava/lang/String;[Ljava/lang/Object;)V
    :try_end_0
    .catch Landroid/database/sqlite/SQLiteDiskIOException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_1

    goto :goto_0

    :catch_0
    move-exception v0

    invoke-static {}, Lcom/openfeint/internal/ui/WebViewCache;->diskError()V

    goto :goto_0

    :catch_1
    move-exception v0

    const-string v1, "SQL"

    invoke-virtual {v0}, Ljava/lang/Exception;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v1, v0}, Lcom/openfeint/internal/logcat/OFLog;->e(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0
.end method

.method public final getOutputMap()Ljava/util/Map;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/Map",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    iget-object v0, p0, Lcom/openfeint/internal/ui/WebViewCache$SaxHandler;->outputMap:Ljava/util/Map;

    return-object v0
.end method

.method public final startElement(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lorg/xml/sax/Attributes;)V
    .locals 1

    const-string v0, ""

    iput-object v0, p0, Lcom/openfeint/internal/ui/WebViewCache$SaxHandler;->loadingString:Ljava/lang/String;

    return-void
.end method
