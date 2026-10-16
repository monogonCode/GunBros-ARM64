.class final Lcom/openfeint/internal/OpenFeintInternal$10$1;
.super Ljava/lang/Object;

# interfaces
.implements Lcom/openfeint/internal/request/IRawRequestDelegate;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/openfeint/internal/OpenFeintInternal$10;->run()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lcom/openfeint/internal/OpenFeintInternal$10;

.field final synthetic val$savedUser:Lcom/openfeint/api/resource/User;


# direct methods
.method constructor <init>(Lcom/openfeint/internal/OpenFeintInternal$10;Lcom/openfeint/api/resource/User;)V
    .locals 0

    iput-object p1, p0, Lcom/openfeint/internal/OpenFeintInternal$10$1;->this$1:Lcom/openfeint/internal/OpenFeintInternal$10;

    iput-object p2, p0, Lcom/openfeint/internal/OpenFeintInternal$10$1;->val$savedUser:Lcom/openfeint/api/resource/User;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final onResponse(ILjava/lang/String;)V
    .locals 3

    const/16 v0, 0xc8

    if-gt v0, p1, :cond_0

    const/16 v0, 0x12c

    if-lt p1, v0, :cond_2

    :cond_0
    const/16 v0, 0x193

    if-ne v0, p1, :cond_1

    iget-object v0, p0, Lcom/openfeint/internal/OpenFeintInternal$10$1;->this$1:Lcom/openfeint/internal/OpenFeintInternal$10;

    iget-object v0, v0, Lcom/openfeint/internal/OpenFeintInternal$10;->this$0:Lcom/openfeint/internal/OpenFeintInternal;

    invoke-static {v0}, Lcom/openfeint/internal/OpenFeintInternal;->access$1502$78278a84(Lcom/openfeint/internal/OpenFeintInternal;)Z

    :goto_0
    return-void

    :cond_1
    iget-object v0, p0, Lcom/openfeint/internal/OpenFeintInternal$10$1;->this$1:Lcom/openfeint/internal/OpenFeintInternal$10;

    iget-object v0, v0, Lcom/openfeint/internal/OpenFeintInternal$10;->this$0:Lcom/openfeint/internal/OpenFeintInternal;

    iget-object v1, p0, Lcom/openfeint/internal/OpenFeintInternal$10$1;->this$1:Lcom/openfeint/internal/OpenFeintInternal$10;

    iget-boolean v1, v1, Lcom/openfeint/internal/OpenFeintInternal$10;->val$spotlight:Z

    invoke-virtual {v0, v1}, Lcom/openfeint/internal/OpenFeintInternal;->launchIntroFlow(Z)V

    goto :goto_0

    :cond_2
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Welcome back "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/openfeint/internal/OpenFeintInternal$10$1;->val$savedUser:Lcom/openfeint/api/resource/User;

    iget-object v1, v1, Lcom/openfeint/api/resource/User;->name:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    sget-object v1, Lcom/openfeint/api/Notification$Category;->Login:Lcom/openfeint/api/Notification$Category;

    sget-object v2, Lcom/openfeint/api/Notification$Type;->Success:Lcom/openfeint/api/Notification$Type;

    invoke-static {v0, v1, v2}, Lcom/openfeint/internal/notifications/SimpleNotification;->show(Ljava/lang/String;Lcom/openfeint/api/Notification$Category;Lcom/openfeint/api/Notification$Type;)V

    goto :goto_0
.end method
