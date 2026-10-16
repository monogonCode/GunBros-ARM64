.class Lcom/urbanairship/restclient/Request$BackgroundRequest;
.super Landroid/os/AsyncTask;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/urbanairship/restclient/Request;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "BackgroundRequest"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Landroid/os/AsyncTask",
        "<",
        "Lcom/urbanairship/restclient/Request;",
        "Ljava/lang/Integer;",
        "Lcom/urbanairship/restclient/Response;",
        ">;"
    }
.end annotation


# instance fields
.field private handler:Lcom/urbanairship/restclient/AsyncHandler;

.field final synthetic this$0:Lcom/urbanairship/restclient/Request;


# direct methods
.method public constructor <init>(Lcom/urbanairship/restclient/Request;Lcom/urbanairship/restclient/AsyncHandler;)V
    .locals 0

    iput-object p1, p0, Lcom/urbanairship/restclient/Request$BackgroundRequest;->this$0:Lcom/urbanairship/restclient/Request;

    invoke-direct {p0}, Landroid/os/AsyncTask;-><init>()V

    iput-object p2, p0, Lcom/urbanairship/restclient/Request$BackgroundRequest;->handler:Lcom/urbanairship/restclient/AsyncHandler;

    return-void
.end method


# virtual methods
.method protected varargs doInBackground([Lcom/urbanairship/restclient/Request;)Lcom/urbanairship/restclient/Response;
    .locals 12

    const/4 v1, 0x0

    const/4 v3, 0x1

    const/4 v2, 0x0

    array-length v0, p1

    if-le v0, v3, :cond_0

    new-instance v0, Ljava/lang/RuntimeException;

    const-string v1, "Background Request only handles executing one Request at a time "

    invoke-direct {v0, v1}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    throw v0

    :cond_0
    array-length v0, p1

    if-ge v2, v0, :cond_4

    aget-object v0, p1, v2

    :try_start_0
    invoke-virtual {v0}, Lcom/urbanairship/restclient/Request;->execute()Lcom/urbanairship/restclient/Response;

    move-result-object v0

    if-eqz v0, :cond_1

    iget-object v3, p0, Lcom/urbanairship/restclient/Request$BackgroundRequest;->this$0:Lcom/urbanairship/restclient/Request;

    iget-object v3, v3, Lcom/urbanairship/restclient/Request;->destination:Ljava/io/File;

    if-eqz v3, :cond_3

    iget-object v3, p0, Lcom/urbanairship/restclient/Request$BackgroundRequest;->this$0:Lcom/urbanairship/restclient/Request;

    iget-object v3, v3, Lcom/urbanairship/restclient/Request;->destination:Ljava/io/File;

    invoke-virtual {v3}, Ljava/io/File;->getParentFile()Ljava/io/File;

    move-result-object v3

    invoke-virtual {v3}, Ljava/io/File;->mkdirs()Z

    invoke-virtual {v0}, Lcom/urbanairship/restclient/Response;->length()J

    move-result-wide v3

    invoke-virtual {v0}, Lcom/urbanairship/restclient/Response;->rawBody()Ljava/io/InputStream;

    move-result-object v5

    new-instance v6, Ljava/io/FileOutputStream;

    iget-object v7, p0, Lcom/urbanairship/restclient/Request$BackgroundRequest;->this$0:Lcom/urbanairship/restclient/Request;

    iget-object v7, v7, Lcom/urbanairship/restclient/Request;->destination:Ljava/io/File;

    invoke-direct {v6, v7}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V

    const/16 v7, 0x2000

    new-array v7, v7, [B

    :goto_0
    invoke-virtual {v5, v7}, Ljava/io/InputStream;->read([B)I

    move-result v8

    const/4 v9, -0x1

    if-eq v8, v9, :cond_2

    add-int/2addr v2, v8

    const/4 v9, 0x0

    invoke-virtual {v6, v7, v9, v8}, Ljava/io/FileOutputStream;->write([BII)V

    const/4 v8, 0x1

    new-array v8, v8, [Ljava/lang/Integer;

    const/4 v9, 0x0

    int-to-float v10, v2

    long-to-float v11, v3

    div-float/2addr v10, v11

    const/high16 v11, 0x42c80000    # 100.0f

    mul-float/2addr v10, v11

    float-to-int v10, v10

    invoke-static {v10}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v10

    aput-object v10, v8, v9

    invoke-virtual {p0, v8}, Lcom/urbanairship/restclient/Request$BackgroundRequest;->publishProgress([Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    invoke-static {v0}, Lcom/urbanairship/Logger;->error(Ljava/lang/Throwable;)V

    move-object v0, v1

    :cond_1
    :goto_1
    return-object v0

    :cond_2
    :try_start_1
    invoke-virtual {v6}, Ljava/io/FileOutputStream;->flush()V

    invoke-virtual {v5}, Ljava/io/InputStream;->close()V

    invoke-virtual {v6}, Ljava/io/FileOutputStream;->close()V

    goto :goto_1

    :cond_3
    invoke-virtual {v0}, Lcom/urbanairship/restclient/Response;->length()J

    move-result-wide v2

    const-wide/32 v4, 0x100000

    cmp-long v2, v2, v4

    if-gez v2, :cond_1

    invoke-virtual {v0}, Lcom/urbanairship/restclient/Response;->body()Ljava/lang/String;
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_1

    :cond_4
    move-object v0, v1

    goto :goto_1
.end method

.method protected bridge synthetic doInBackground([Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1

    check-cast p1, [Lcom/urbanairship/restclient/Request;

    invoke-virtual {p0, p1}, Lcom/urbanairship/restclient/Request$BackgroundRequest;->doInBackground([Lcom/urbanairship/restclient/Request;)Lcom/urbanairship/restclient/Response;

    move-result-object v0

    return-object v0
.end method

.method protected onPostExecute(Lcom/urbanairship/restclient/Response;)V
    .locals 3

    if-eqz p1, :cond_0

    iget-object v0, p0, Lcom/urbanairship/restclient/Request$BackgroundRequest;->handler:Lcom/urbanairship/restclient/AsyncHandler;

    invoke-virtual {v0, p1}, Lcom/urbanairship/restclient/AsyncHandler;->onComplete(Lcom/urbanairship/restclient/Response;)V

    :goto_0
    return-void

    :cond_0
    iget-object v0, p0, Lcom/urbanairship/restclient/Request$BackgroundRequest;->handler:Lcom/urbanairship/restclient/AsyncHandler;

    new-instance v1, Ljava/lang/Exception;

    const-string v2, "Error when executing request."

    invoke-direct {v1, v2}, Ljava/lang/Exception;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, v1}, Lcom/urbanairship/restclient/AsyncHandler;->onError(Ljava/lang/Exception;)V

    goto :goto_0
.end method

.method protected bridge synthetic onPostExecute(Ljava/lang/Object;)V
    .locals 0

    check-cast p1, Lcom/urbanairship/restclient/Response;

    invoke-virtual {p0, p1}, Lcom/urbanairship/restclient/Request$BackgroundRequest;->onPostExecute(Lcom/urbanairship/restclient/Response;)V

    return-void
.end method

.method protected varargs onProgressUpdate([Ljava/lang/Integer;)V
    .locals 2

    const/4 v0, 0x0

    aget-object v0, p1, v0

    iget-object v1, p0, Lcom/urbanairship/restclient/Request$BackgroundRequest;->handler:Lcom/urbanairship/restclient/AsyncHandler;

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    invoke-virtual {v1, v0}, Lcom/urbanairship/restclient/AsyncHandler;->onProgress(I)V

    return-void
.end method

.method protected bridge synthetic onProgressUpdate([Ljava/lang/Object;)V
    .locals 0

    check-cast p1, [Ljava/lang/Integer;

    invoke-virtual {p0, p1}, Lcom/urbanairship/restclient/Request$BackgroundRequest;->onProgressUpdate([Ljava/lang/Integer;)V

    return-void
.end method
