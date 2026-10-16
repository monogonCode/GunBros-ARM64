.class Lcom/urbanairship/push/PushManager$2;
.super Lcom/urbanairship/restclient/AsyncHandler;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/urbanairship/push/PushManager;->deleteApid(Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/urbanairship/push/PushManager;

.field final synthetic val$apid:Ljava/lang/String;


# direct methods
.method constructor <init>(Lcom/urbanairship/push/PushManager;Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lcom/urbanairship/push/PushManager$2;->this$0:Lcom/urbanairship/push/PushManager;

    iput-object p2, p0, Lcom/urbanairship/push/PushManager$2;->val$apid:Ljava/lang/String;

    invoke-direct {p0}, Lcom/urbanairship/restclient/AsyncHandler;-><init>()V

    return-void
.end method


# virtual methods
.method public onComplete(Lcom/urbanairship/restclient/Response;)V
    .locals 2

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Delete APID status code: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {p1}, Lcom/urbanairship/restclient/Response;->status()I

    move-result v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/urbanairship/Logger;->info(Ljava/lang/String;)V

    invoke-virtual {p1}, Lcom/urbanairship/restclient/Response;->status()I

    move-result v0

    const/16 v1, 0xcc

    if-ne v0, v1, :cond_0

    const-string v0, "Delete request succeeded."

    invoke-static {v0}, Lcom/urbanairship/Logger;->info(Ljava/lang/String;)V

    :goto_0
    return-void

    :cond_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Delete request failed. Response status: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {p1}, Lcom/urbanairship/restclient/Response;->status()I

    move-result v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/urbanairship/Logger;->info(Ljava/lang/String;)V

    goto :goto_0
.end method

.method public onError(Ljava/lang/Exception;)V
    .locals 3

    const-string v0, "Error deleting APID"

    invoke-static {v0, p1}, Lcom/urbanairship/Logger;->error(Ljava/lang/String;Ljava/lang/Throwable;)V

    iget-object v0, p0, Lcom/urbanairship/push/PushManager$2;->this$0:Lcom/urbanairship/push/PushManager;

    const-string v1, "com.urbanairship.push.DELETE_APID"

    iget-object v2, p0, Lcom/urbanairship/push/PushManager$2;->val$apid:Ljava/lang/String;

    invoke-static {v0, v1, v2}, Lcom/urbanairship/push/PushManager;->access$300(Lcom/urbanairship/push/PushManager;Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method
