.class final Lcom/glu/platform/gwallet/GWalletJNI$1;
.super Lcom/loopj/android/http/AsyncHttpResponseHandler;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/glu/platform/gwallet/GWalletJNI;->GetContent(Ljava/lang/String;Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/glu/platform/gwallet/GWalletJNI;


# direct methods
.method constructor <init>(Lcom/glu/platform/gwallet/GWalletJNI;)V
    .locals 0

    iput-object p1, p0, Lcom/glu/platform/gwallet/GWalletJNI$1;->this$0:Lcom/glu/platform/gwallet/GWalletJNI;

    invoke-direct {p0}, Lcom/loopj/android/http/AsyncHttpResponseHandler;-><init>()V

    return-void
.end method


# virtual methods
.method public final onFailure(Ljava/lang/Throwable;)V
    .locals 2

    const-string v0, "GWallet.GetContent"

    const-string v1, "onFailure"

    invoke-static {v0, v1, p1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    const-string v0, ""

    const/4 v1, 0x0

    invoke-static {v0, v1}, Lcom/glu/platform/gwallet/GWalletJNI;->onHandleResponse(Ljava/lang/String;I)V

    return-void
.end method

.method public final onFinish()V
    .locals 2

    const-string v0, "GWallet.GetContent"

    const-string v1, "onFinish"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v0, p0, Lcom/glu/platform/gwallet/GWalletJNI$1;->this$0:Lcom/glu/platform/gwallet/GWalletJNI;

    invoke-virtual {v0}, Lcom/glu/platform/gwallet/GWalletJNI;->enableHTTPTransfers()V

    return-void
.end method

.method public final onStart()V
    .locals 2

    const-string v0, "GWallet.GetContent"

    const-string v1, "onStart"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    return-void
.end method

.method public final onSuccess(Ljava/lang/String;)V
    .locals 3

    const-string v0, "GWallet.GetContent"

    const-string v1, "onSuccess"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v0, "GWallet.GetContent"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "response ="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    invoke-static {p1, v0}, Lcom/glu/platform/gwallet/GWalletJNI;->onHandleResponse(Ljava/lang/String;I)V

    return-void
.end method
