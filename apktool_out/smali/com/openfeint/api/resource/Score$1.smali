.class final Lcom/openfeint/api/resource/Score$1;
.super Lcom/openfeint/internal/request/JSONRequest;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/openfeint/api/resource/Score;->submitToInternal(Lcom/openfeint/api/resource/Leaderboard;Ljava/lang/String;Lcom/openfeint/api/resource/Score$SubmitToCB;Z)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/openfeint/api/resource/Score;

.field final synthetic val$cb:Lcom/openfeint/api/resource/Score$SubmitToCB;

.field final synthetic val$fromOffline:Z

.field final synthetic val$leaderboard:Lcom/openfeint/api/resource/Leaderboard;

.field final synthetic val$path:Ljava/lang/String;

.field final synthetic val$uploadBlob:Z


# direct methods
.method constructor <init>(Lcom/openfeint/api/resource/Score;Lcom/openfeint/internal/request/OrderedArgList;Ljava/lang/String;ZLcom/openfeint/api/resource/Score$SubmitToCB;ZLcom/openfeint/api/resource/Leaderboard;)V
    .locals 0

    iput-object p1, p0, Lcom/openfeint/api/resource/Score$1;->this$0:Lcom/openfeint/api/resource/Score;

    iput-object p3, p0, Lcom/openfeint/api/resource/Score$1;->val$path:Ljava/lang/String;

    iput-boolean p4, p0, Lcom/openfeint/api/resource/Score$1;->val$fromOffline:Z

    iput-object p5, p0, Lcom/openfeint/api/resource/Score$1;->val$cb:Lcom/openfeint/api/resource/Score$SubmitToCB;

    iput-boolean p6, p0, Lcom/openfeint/api/resource/Score$1;->val$uploadBlob:Z

    iput-object p7, p0, Lcom/openfeint/api/resource/Score$1;->val$leaderboard:Lcom/openfeint/api/resource/Leaderboard;

    invoke-direct {p0, p2}, Lcom/openfeint/internal/request/JSONRequest;-><init>(Lcom/openfeint/internal/request/OrderedArgList;)V

    return-void
.end method


# virtual methods
.method public final method()Ljava/lang/String;
    .locals 1

    const-string v0, "POST"

    return-object v0
.end method

.method public final onFailure(Ljava/lang/String;)V
    .locals 1

    invoke-super {p0, p1}, Lcom/openfeint/internal/request/JSONRequest;->onFailure(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/openfeint/api/resource/Score$1;->val$cb:Lcom/openfeint/api/resource/Score$SubmitToCB;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/openfeint/api/resource/Score$1;->val$cb:Lcom/openfeint/api/resource/Score$SubmitToCB;

    invoke-virtual {v0, p1}, Lcom/openfeint/api/resource/Score$SubmitToCB;->onFailure(Ljava/lang/String;)V

    :cond_0
    return-void
.end method

.method protected final onResponse(ILjava/lang/Object;)V
    .locals 6

    const/4 v5, 0x0

    const/16 v0, 0xc9

    if-ne v0, p1, :cond_4

    iget-boolean v0, p0, Lcom/openfeint/api/resource/Score$1;->val$fromOffline:Z

    if-nez v0, :cond_0

    invoke-static {}, Lcom/openfeint/internal/OpenFeintInternal;->getInstance()Lcom/openfeint/internal/OpenFeintInternal;

    move-result-object v0

    invoke-virtual {v0}, Lcom/openfeint/internal/OpenFeintInternal;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    const-string v1, "of_score_submitted_notification"

    invoke-static {v1}, Lcom/openfeint/internal/RR;->string(Ljava/lang/String;)I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object v0

    const-string v1, "@drawable/of_icon_highscore_notification"

    sget-object v2, Lcom/openfeint/api/Notification$Category;->HighScore:Lcom/openfeint/api/Notification$Category;

    sget-object v3, Lcom/openfeint/api/Notification$Type;->Success:Lcom/openfeint/api/Notification$Type;

    invoke-static {v0, v1, v2, v3}, Lcom/openfeint/internal/notifications/SimpleNotification;->show(Ljava/lang/String;Ljava/lang/String;Lcom/openfeint/api/Notification$Category;Lcom/openfeint/api/Notification$Type;)V

    :cond_0
    iget-object v0, p0, Lcom/openfeint/api/resource/Score$1;->val$cb:Lcom/openfeint/api/resource/Score$SubmitToCB;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/openfeint/api/resource/Score$1;->val$cb:Lcom/openfeint/api/resource/Score$SubmitToCB;

    invoke-virtual {v0}, Lcom/openfeint/api/resource/Score$SubmitToCB;->onSuccess$1385ff()V

    :cond_1
    iget-boolean v0, p0, Lcom/openfeint/api/resource/Score$1;->val$uploadBlob:Z

    if-eqz v0, :cond_3

    instance-of v0, p2, Ljava/util/List;

    if-eqz v0, :cond_3

    check-cast p2, Ljava/util/List;

    invoke-interface {p2, v5}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/openfeint/api/resource/Score;

    new-instance v1, Lcom/openfeint/internal/request/CompressedBlobPostRequest;

    invoke-static {v0}, Lcom/openfeint/api/resource/Score;->access$000(Lcom/openfeint/api/resource/Score;)Lcom/openfeint/internal/resource/BlobUploadParameters;

    move-result-object v2

    const-string v3, "blob.%s.bin"

    const/4 v4, 0x1

    new-array v4, v4, [Ljava/lang/Object;

    invoke-virtual {v0}, Lcom/openfeint/api/resource/Score;->resourceID()Ljava/lang/String;

    move-result-object v0

    aput-object v0, v4, v5

    invoke-static {v3, v4}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    iget-object v3, p0, Lcom/openfeint/api/resource/Score$1;->this$0:Lcom/openfeint/api/resource/Score;

    iget-object v3, v3, Lcom/openfeint/api/resource/Score;->blob:[B

    invoke-direct {v1, v2, v0, v3}, Lcom/openfeint/internal/request/CompressedBlobPostRequest;-><init>(Lcom/openfeint/internal/resource/BlobUploadParameters;Ljava/lang/String;[B)V

    iget-object v0, p0, Lcom/openfeint/api/resource/Score$1;->val$cb:Lcom/openfeint/api/resource/Score$SubmitToCB;

    if-eqz v0, :cond_2

    new-instance v0, Lcom/openfeint/api/resource/Score$1$1;

    invoke-direct {v0, p0}, Lcom/openfeint/api/resource/Score$1$1;-><init>(Lcom/openfeint/api/resource/Score$1;)V

    invoke-virtual {v1, v0}, Lcom/openfeint/internal/request/BlobPostRequest;->setDelegate(Lcom/openfeint/internal/request/IRawRequestDelegate;)V

    :cond_2
    invoke-static {v1}, Lcom/openfeint/internal/OpenFeintInternal;->makeRequest(Lcom/openfeint/internal/request/BaseRequest;)V

    :cond_3
    :goto_0
    return-void

    :cond_4
    const/16 v0, 0xc8

    if-gt v0, p1, :cond_5

    const/16 v0, 0x12c

    if-ge p1, v0, :cond_5

    iget-object v0, p0, Lcom/openfeint/api/resource/Score$1;->val$cb:Lcom/openfeint/api/resource/Score$SubmitToCB;

    if-eqz v0, :cond_3

    iget-object v0, p0, Lcom/openfeint/api/resource/Score$1;->val$cb:Lcom/openfeint/api/resource/Score$SubmitToCB;

    invoke-virtual {v0}, Lcom/openfeint/api/resource/Score$SubmitToCB;->onSuccess$1385ff()V

    goto :goto_0

    :cond_5
    if-eqz p1, :cond_6

    const/16 v0, 0x1f4

    if-gt v0, p1, :cond_7

    :cond_6
    iget-boolean v0, p0, Lcom/openfeint/api/resource/Score$1;->val$fromOffline:Z

    if-nez v0, :cond_7

    iget-object v0, p0, Lcom/openfeint/api/resource/Score$1;->this$0:Lcom/openfeint/api/resource/Score;

    iget-object v1, p0, Lcom/openfeint/api/resource/Score$1;->val$leaderboard:Lcom/openfeint/api/resource/Leaderboard;

    invoke-static {v0, v1}, Lcom/openfeint/internal/offline/OfflineSupport;->postOfflineScore(Lcom/openfeint/api/resource/Score;Lcom/openfeint/api/resource/Leaderboard;)V

    iget-object v0, p0, Lcom/openfeint/api/resource/Score$1;->val$cb:Lcom/openfeint/api/resource/Score$SubmitToCB;

    if-eqz v0, :cond_3

    iget-object v0, p0, Lcom/openfeint/api/resource/Score$1;->val$cb:Lcom/openfeint/api/resource/Score$SubmitToCB;

    invoke-virtual {v0}, Lcom/openfeint/api/resource/Score$SubmitToCB;->onSuccess$1385ff()V

    goto :goto_0

    :cond_7
    invoke-virtual {p0, p2}, Lcom/openfeint/api/resource/Score$1;->onFailure(Ljava/lang/Object;)V

    goto :goto_0
.end method

.method public final path()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/openfeint/api/resource/Score$1;->val$path:Ljava/lang/String;

    return-object v0
.end method
