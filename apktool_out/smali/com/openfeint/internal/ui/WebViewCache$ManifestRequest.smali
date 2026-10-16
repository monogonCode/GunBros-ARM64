.class final Lcom/openfeint/internal/ui/WebViewCache$ManifestRequest;
.super Lcom/openfeint/internal/request/CacheRequest;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/openfeint/internal/ui/WebViewCache;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "ManifestRequest"
.end annotation


# instance fields
.field private data:Lcom/openfeint/internal/ui/WebViewCache$ManifestData;

.field final synthetic this$0:Lcom/openfeint/internal/ui/WebViewCache;


# direct methods
.method public constructor <init>(Lcom/openfeint/internal/ui/WebViewCache;Ljava/lang/String;)V
    .locals 1

    iput-object p1, p0, Lcom/openfeint/internal/ui/WebViewCache$ManifestRequest;->this$0:Lcom/openfeint/internal/ui/WebViewCache;

    invoke-direct {p0, p2}, Lcom/openfeint/internal/request/CacheRequest;-><init>(Ljava/lang/String;)V

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/openfeint/internal/ui/WebViewCache$ManifestRequest;->data:Lcom/openfeint/internal/ui/WebViewCache$ManifestData;

    return-void
.end method

.method static synthetic access$1000(Lcom/openfeint/internal/ui/WebViewCache$ManifestRequest;Lorg/apache/http/HttpResponse;)V
    .locals 0

    invoke-virtual {p0, p1}, Lcom/openfeint/internal/ui/WebViewCache$ManifestRequest;->updateLastModifiedFromResponse(Lorg/apache/http/HttpResponse;)V

    return-void
.end method

.method static synthetic access$802(Lcom/openfeint/internal/ui/WebViewCache$ManifestRequest;Lcom/openfeint/internal/ui/WebViewCache$ManifestData;)Lcom/openfeint/internal/ui/WebViewCache$ManifestData;
    .locals 0

    iput-object p1, p0, Lcom/openfeint/internal/ui/WebViewCache$ManifestRequest;->data:Lcom/openfeint/internal/ui/WebViewCache$ManifestData;

    return-object p1
.end method

.method static synthetic access$900(Lcom/openfeint/internal/ui/WebViewCache$ManifestRequest;)V
    .locals 0

    invoke-direct {p0}, Lcom/openfeint/internal/ui/WebViewCache$ManifestRequest;->finishManifest()V

    return-void
.end method

.method private finishManifest()V
    .locals 10

    iget-object v0, p0, Lcom/openfeint/internal/ui/WebViewCache$ManifestRequest;->data:Lcom/openfeint/internal/ui/WebViewCache$ManifestData;

    if-eqz v0, :cond_3

    :try_start_0
    iget-object v4, p0, Lcom/openfeint/internal/ui/WebViewCache$ManifestRequest;->data:Lcom/openfeint/internal/ui/WebViewCache$ManifestData;

    sget-object v0, Lcom/openfeint/internal/db/DB;->storeHelper:Lcom/openfeint/internal/db/DB$DataStorageHelperX;

    invoke-virtual {v0}, Lcom/openfeint/internal/db/DB$DataStorageHelperX;->getWritableDatabase()Landroid/database/sqlite/SQLiteDatabase;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_4

    move-result-object v5

    :try_start_1
    invoke-virtual {v5}, Landroid/database/sqlite/SQLiteDatabase;->beginTransaction()V

    const-string v0, "DELETE FROM server_manifest;"

    invoke-virtual {v5, v0}, Landroid/database/sqlite/SQLiteDatabase;->execSQL(Ljava/lang/String;)V

    const-string v0, "DELETE FROM dependencies;"

    invoke-virtual {v5, v0}, Landroid/database/sqlite/SQLiteDatabase;->execSQL(Ljava/lang/String;)V

    const-string v0, "INSERT INTO server_manifest(path, hash, is_global) VALUES(?, ?, ?)"

    invoke-virtual {v5, v0}, Landroid/database/sqlite/SQLiteDatabase;->compileStatement(Ljava/lang/String;)Landroid/database/sqlite/SQLiteStatement;

    move-result-object v6

    const-string v0, "INSERT INTO dependencies(path, has_dependency) VALUES(?, ?)"

    invoke-virtual {v5, v0}, Landroid/database/sqlite/SQLiteDatabase;->compileStatement(Ljava/lang/String;)Landroid/database/sqlite/SQLiteStatement;

    move-result-object v7

    iget-object v0, v4, Lcom/openfeint/internal/ui/WebViewCache$ManifestData;->objects:Ljava/util/Map;

    invoke-interface {v0}, Ljava/util/Map;->keySet()Ljava/util/Set;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v8

    :cond_0
    invoke-interface {v8}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_2

    invoke-interface {v8}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    iget-object v1, v4, Lcom/openfeint/internal/ui/WebViewCache$ManifestData;->objects:Ljava/util/Map;

    invoke-interface {v1, v0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/openfeint/internal/ui/WebViewCache$ManifestItem;

    const/4 v2, 0x1

    invoke-virtual {v6, v2, v0}, Landroid/database/sqlite/SQLiteStatement;->bindString(ILjava/lang/String;)V

    const/4 v2, 0x2

    iget-object v3, v1, Lcom/openfeint/internal/ui/WebViewCache$ManifestItem;->hash:Ljava/lang/String;

    invoke-virtual {v6, v2, v3}, Landroid/database/sqlite/SQLiteStatement;->bindString(ILjava/lang/String;)V

    const/4 v9, 0x3

    iget-object v2, v4, Lcom/openfeint/internal/ui/WebViewCache$ManifestData;->globals:Ljava/util/Set;

    invoke-interface {v2, v0}, Ljava/util/Set;->contains(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_1

    const-wide/16 v2, 0x1

    :goto_0
    invoke-virtual {v6, v9, v2, v3}, Landroid/database/sqlite/SQLiteStatement;->bindLong(IJ)V

    invoke-virtual {v6}, Landroid/database/sqlite/SQLiteStatement;->execute()V

    const/4 v2, 0x1

    invoke-virtual {v7, v2, v0}, Landroid/database/sqlite/SQLiteStatement;->bindString(ILjava/lang/String;)V

    iget-object v0, v1, Lcom/openfeint/internal/ui/WebViewCache$ManifestItem;->dependentObjects:Ljava/util/Set;

    invoke-interface {v0}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_1
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    const/4 v2, 0x2

    invoke-virtual {v7, v2, v0}, Landroid/database/sqlite/SQLiteStatement;->bindString(ILjava/lang/String;)V

    invoke-virtual {v7}, Landroid/database/sqlite/SQLiteStatement;->execute()V
    :try_end_1
    .catch Landroid/database/sqlite/SQLiteDiskIOException; {:try_start_1 .. :try_end_1} :catch_0
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_2
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_1

    :catch_0
    move-exception v0

    :try_start_2
    invoke-static {}, Lcom/openfeint/internal/ui/WebViewCache;->diskError()V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    :try_start_3
    invoke-virtual {v5}, Landroid/database/sqlite/SQLiteDatabase;->endTransaction()V
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_5

    :goto_2
    iget-object v0, p0, Lcom/openfeint/internal/ui/WebViewCache$ManifestRequest;->this$0:Lcom/openfeint/internal/ui/WebViewCache;

    iget-object v0, v0, Lcom/openfeint/internal/ui/WebViewCache;->mHandler:Landroid/os/Handler;

    const/4 v1, 0x0

    iget-object v2, p0, Lcom/openfeint/internal/ui/WebViewCache$ManifestRequest;->data:Lcom/openfeint/internal/ui/WebViewCache$ManifestData;

    invoke-static {v0, v1, v2}, Landroid/os/Message;->obtain(Landroid/os/Handler;ILjava/lang/Object;)Landroid/os/Message;

    move-result-object v0

    invoke-virtual {v0}, Landroid/os/Message;->sendToTarget()V

    :goto_3
    return-void

    :cond_1
    const-wide/16 v2, 0x0

    goto :goto_0

    :cond_2
    :try_start_4
    invoke-virtual {v5}, Landroid/database/sqlite/SQLiteDatabase;->setTransactionSuccessful()V
    :try_end_4
    .catch Landroid/database/sqlite/SQLiteDiskIOException; {:try_start_4 .. :try_end_4} :catch_0
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_2
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    :try_start_5
    invoke-virtual {v5}, Landroid/database/sqlite/SQLiteDatabase;->endTransaction()V
    :try_end_5
    .catch Ljava/lang/Exception; {:try_start_5 .. :try_end_5} :catch_1

    goto :goto_2

    :catch_1
    move-exception v0

    goto :goto_2

    :catch_2
    move-exception v0

    :try_start_6
    const-string v1, "WebViewCache"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "SQLite exception. "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v0}, Ljava/lang/Exception;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v1, v0}, Lcom/openfeint/internal/logcat/OFLog;->e(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_0

    :try_start_7
    invoke-virtual {v5}, Landroid/database/sqlite/SQLiteDatabase;->endTransaction()V
    :try_end_7
    .catch Ljava/lang/Exception; {:try_start_7 .. :try_end_7} :catch_3

    goto :goto_2

    :catch_3
    move-exception v0

    goto :goto_2

    :catchall_0
    move-exception v0

    :try_start_8
    invoke-virtual {v5}, Landroid/database/sqlite/SQLiteDatabase;->endTransaction()V
    :try_end_8
    .catch Ljava/lang/Exception; {:try_start_8 .. :try_end_8} :catch_6

    :goto_4
    :try_start_9
    throw v0
    :try_end_9
    .catch Ljava/lang/Exception; {:try_start_9 .. :try_end_9} :catch_4

    :catch_4
    move-exception v0

    const-string v1, "WebViewCache"

    invoke-virtual {v0}, Ljava/lang/Exception;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v1, v0}, Lcom/openfeint/internal/logcat/OFLog;->e(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_2

    :cond_3
    iget-object v0, p0, Lcom/openfeint/internal/ui/WebViewCache$ManifestRequest;->this$0:Lcom/openfeint/internal/ui/WebViewCache;

    invoke-static {v0}, Lcom/openfeint/internal/ui/WebViewCache;->access$1100(Lcom/openfeint/internal/ui/WebViewCache;)V

    goto :goto_3

    :catch_5
    move-exception v0

    goto :goto_2

    :catch_6
    move-exception v1

    goto :goto_4
.end method


# virtual methods
.method public final onResponse(I[B)V
    .locals 0

    return-void
.end method

.method public final onResponseOffMainThread(I[B)V
    .locals 2

    const/16 v0, 0xc8

    if-ne p1, v0, :cond_1

    :try_start_0
    new-instance v0, Lcom/openfeint/internal/ui/WebViewCache$ManifestData;

    invoke-direct {v0, p2}, Lcom/openfeint/internal/ui/WebViewCache$ManifestData;-><init>([B)V

    iput-object v0, p0, Lcom/openfeint/internal/ui/WebViewCache$ManifestRequest;->data:Lcom/openfeint/internal/ui/WebViewCache$ManifestData;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    iget-object v0, p0, Lcom/openfeint/internal/ui/WebViewCache$ManifestRequest;->data:Lcom/openfeint/internal/ui/WebViewCache$ManifestData;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/openfeint/internal/ui/WebViewCache$ManifestRequest;->data:Lcom/openfeint/internal/ui/WebViewCache$ManifestData;

    iget-object v0, v0, Lcom/openfeint/internal/ui/WebViewCache$ManifestData;->objects:Ljava/util/Map;

    invoke-interface {v0}, Ljava/util/Map;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_2

    :cond_0
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/openfeint/internal/ui/WebViewCache$ManifestRequest;->data:Lcom/openfeint/internal/ui/WebViewCache$ManifestData;

    new-instance v0, Lcom/openfeint/internal/ui/WebViewCache$ManifestRequest$1;

    invoke-direct {v0, p0}, Lcom/openfeint/internal/ui/WebViewCache$ManifestRequest$1;-><init>(Lcom/openfeint/internal/ui/WebViewCache$ManifestRequest;)V

    invoke-static {v0}, Lcom/openfeint/internal/OpenFeintInternal;->makeRequest(Lcom/openfeint/internal/request/BaseRequest;)V

    :goto_1
    return-void

    :catch_0
    move-exception v0

    const-string v1, "WebViewCache"

    invoke-virtual {v0}, Ljava/lang/Exception;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v1, v0}, Lcom/openfeint/internal/logcat/OFLog;->e(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0

    :cond_1
    :try_start_1
    new-instance v0, Lcom/openfeint/internal/ui/WebViewCache$ManifestData;

    sget-object v1, Lcom/openfeint/internal/db/DB;->storeHelper:Lcom/openfeint/internal/db/DB$DataStorageHelperX;

    invoke-virtual {v1}, Lcom/openfeint/internal/db/DB$DataStorageHelperX;->getReadableDatabase()Landroid/database/sqlite/SQLiteDatabase;

    move-result-object v1

    invoke-direct {v0, v1}, Lcom/openfeint/internal/ui/WebViewCache$ManifestData;-><init>(Landroid/database/sqlite/SQLiteDatabase;)V

    iput-object v0, p0, Lcom/openfeint/internal/ui/WebViewCache$ManifestRequest;->data:Lcom/openfeint/internal/ui/WebViewCache$ManifestData;
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1

    goto :goto_0

    :catch_1
    move-exception v0

    const-string v1, "WebViewCache"

    invoke-virtual {v0}, Ljava/lang/Exception;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v1, v0}, Lcom/openfeint/internal/logcat/OFLog;->e(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0

    :cond_2
    invoke-direct {p0}, Lcom/openfeint/internal/ui/WebViewCache$ManifestRequest;->finishManifest()V

    invoke-virtual {p0}, Lcom/openfeint/internal/ui/WebViewCache$ManifestRequest;->getResponse()Lorg/apache/http/HttpResponse;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/openfeint/internal/ui/WebViewCache$ManifestRequest;->updateLastModifiedFromResponse(Lorg/apache/http/HttpResponse;)V

    goto :goto_1
.end method

.method public final path()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/openfeint/internal/ui/WebViewCache$ManifestRequest;->this$0:Lcom/openfeint/internal/ui/WebViewCache;

    iget-object v0, v0, Lcom/openfeint/internal/ui/WebViewCache;->appContext:Landroid/content/Context;

    invoke-static {v0}, Lcom/openfeint/internal/ui/WebViewCache;->access$700(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public final signed()Z
    .locals 1

    const/4 v0, 0x0

    return v0
.end method
