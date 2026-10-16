.class final Lcom/openfeint/internal/OpenFeintInternal$1;
.super Lcom/openfeint/internal/request/RawRequest;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/openfeint/internal/OpenFeintInternal;->createUser(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/openfeint/internal/request/IRawRequestDelegate;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/openfeint/internal/OpenFeintInternal;


# direct methods
.method constructor <init>(Lcom/openfeint/internal/OpenFeintInternal;Lcom/openfeint/internal/request/OrderedArgList;)V
    .locals 0

    iput-object p1, p0, Lcom/openfeint/internal/OpenFeintInternal$1;->this$0:Lcom/openfeint/internal/OpenFeintInternal;

    invoke-direct {p0, p2}, Lcom/openfeint/internal/request/RawRequest;-><init>(Lcom/openfeint/internal/request/OrderedArgList;)V

    return-void
.end method


# virtual methods
.method public final method()Ljava/lang/String;
    .locals 1

    const-string v0, "POST"

    return-object v0
.end method

.method protected final onResponse(ILjava/lang/Object;)V
    .locals 3

    const/16 v0, 0xc8

    if-gt v0, p1, :cond_2

    const/16 v0, 0x12c

    if-ge p1, v0, :cond_2

    if-eqz p2, :cond_0

    instance-of v0, p2, Lcom/openfeint/internal/resource/ServerException;

    if-nez v0, :cond_2

    :cond_0
    sget-object v0, Lcom/openfeint/internal/OpenFeintInternal$1;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "new user or enable of: response code:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/openfeint/internal/logcat/OFLog;->e(Ljava/lang/String;Ljava/lang/String;)V

    invoke-static {}, Lcom/openfeint/internal/eventlog/EventLogDispatcher;->getInstance()Lcom/openfeint/internal/eventlog/EventLogDispatcher;

    move-result-object v1

    const/16 v0, 0xc9

    if-ne p1, v0, :cond_1

    const-string v0, "new_user.openfeint.com"

    :goto_0
    invoke-static {}, Lcom/openfeint/internal/OpenFeintInternal;->access$000()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v0, v2}, Lcom/openfeint/internal/eventlog/EventLogDispatcher;->postEvent(Ljava/lang/String;Ljava/lang/Object;)V

    iget-object v0, p0, Lcom/openfeint/internal/OpenFeintInternal$1;->this$0:Lcom/openfeint/internal/OpenFeintInternal;

    check-cast p2, Lcom/openfeint/api/resource/User;

    invoke-static {v0, p2}, Lcom/openfeint/internal/OpenFeintInternal;->access$100(Lcom/openfeint/internal/OpenFeintInternal;Lcom/openfeint/api/resource/User;)V

    :goto_1
    return-void

    :cond_1
    const-string v0, "enabled_of.openfeint.com"

    goto :goto_0

    :cond_2
    invoke-virtual {p0, p2}, Lcom/openfeint/internal/OpenFeintInternal$1;->onFailure(Ljava/lang/Object;)V

    goto :goto_1
.end method

.method public final path()Ljava/lang/String;
    .locals 1

    const-string v0, "/xp/users.json"

    return-object v0
.end method
