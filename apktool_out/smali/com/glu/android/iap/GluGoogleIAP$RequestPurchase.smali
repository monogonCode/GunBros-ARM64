.class public final Lcom/glu/android/iap/GluGoogleIAP$RequestPurchase;
.super Lcom/glu/android/iap/GluGoogleIAP$BillingRequest;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/glu/android/iap/GluGoogleIAP;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "RequestPurchase"
.end annotation


# instance fields
.field public final m_developerPayload:Ljava/lang/String;

.field public final m_productId:Ljava/lang/String;


# direct methods
.method public constructor <init>(Ljava/lang/String;)V
    .locals 1

    const/4 v0, 0x0

    invoke-direct {p0, p1, v0}, Lcom/glu/android/iap/GluGoogleIAP$RequestPurchase;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1

    const/4 v0, -0x1

    invoke-direct {p0, v0}, Lcom/glu/android/iap/GluGoogleIAP$BillingRequest;-><init>(I)V

    iput-object p1, p0, Lcom/glu/android/iap/GluGoogleIAP$RequestPurchase;->m_productId:Ljava/lang/String;

    iput-object p2, p0, Lcom/glu/android/iap/GluGoogleIAP$RequestPurchase;->m_developerPayload:Ljava/lang/String;

    return-void
.end method


# virtual methods
.method protected final responseCodeReceived(Lcom/glu/googleiap/Consts$ResponseCode;)V
    .locals 1

    sget-object v0, Lcom/glu/android/iap/GluGoogleIAP;->instance:Lcom/glu/android/iap/GluGoogleIAP;

    invoke-static {p0, p1}, Lcom/glu/googleiap/ResponseHandler;->responseCodeReceived$2193dfa7(Lcom/glu/android/iap/GluGoogleIAP$RequestPurchase;Lcom/glu/googleiap/Consts$ResponseCode;)V

    return-void
.end method

.method protected final run()J
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    const-string v1, "REQUEST_PURCHASE"

    iget-object v0, p0, Lcom/glu/android/iap/GluGoogleIAP$RequestPurchase;->m_productId:Ljava/lang/String;

    const-string v2, "monthly"

    invoke-virtual {v0, v2}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_2

    const/4 v0, 0x2

    :goto_0
    invoke-static {v1, v0}, Lcom/glu/android/iap/GluGoogleIAP$RequestPurchase;->makeRequestBundle(Ljava/lang/String;I)Landroid/os/Bundle;

    move-result-object v0

    iget-object v1, p0, Lcom/glu/android/iap/GluGoogleIAP$RequestPurchase;->m_productId:Ljava/lang/String;

    const-string v2, "monthly"

    invoke-virtual {v1, v2}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_0

    const-string v1, "ITEM_TYPE"

    const-string v2, "subs"

    invoke-virtual {v0, v1, v2}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    :cond_0
    const-string v1, "ITEM_ID"

    iget-object v2, p0, Lcom/glu/android/iap/GluGoogleIAP$RequestPurchase;->m_productId:Ljava/lang/String;

    invoke-virtual {v0, v1, v2}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "run.m_productId - "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/glu/android/iap/GluGoogleIAP$RequestPurchase;->m_productId:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    invoke-static {}, Lcom/glu/android/iap/Debug;->log$552c4e01()V

    iget-object v1, p0, Lcom/glu/android/iap/GluGoogleIAP$RequestPurchase;->m_developerPayload:Ljava/lang/String;

    if-eqz v1, :cond_1

    const-string v1, "DEVELOPER_PAYLOAD"

    iget-object v2, p0, Lcom/glu/android/iap/GluGoogleIAP$RequestPurchase;->m_developerPayload:Ljava/lang/String;

    invoke-virtual {v0, v1, v2}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    iget-object v1, p0, Lcom/glu/android/iap/GluGoogleIAP$RequestPurchase;->m_developerPayload:Ljava/lang/String;

    invoke-static {}, Lcom/glu/android/iap/Debug;->log$16da05f7()V

    :cond_1
    sget-object v1, Lcom/glu/android/iap/GluGoogleIAP;->instance:Lcom/glu/android/iap/GluGoogleIAP;

    invoke-static {}, Lcom/glu/android/iap/GluGoogleIAP;->access$500()Lcom/android/vending/billing/IMarketBillingService;

    move-result-object v1

    invoke-interface {v1, v0}, Lcom/android/vending/billing/IMarketBillingService;->sendBillingRequest(Landroid/os/Bundle;)Landroid/os/Bundle;

    move-result-object v1

    const-string v0, "PURCHASE_INTENT"

    invoke-virtual {v1, v0}, Landroid/os/Bundle;->getParcelable(Ljava/lang/String;)Landroid/os/Parcelable;

    move-result-object v0

    check-cast v0, Landroid/app/PendingIntent;

    if-nez v0, :cond_3

    invoke-static {}, Lcom/glu/android/iap/Debug;->log$552c4e01()V

    sget-object v0, Lcom/glu/android/iap/GluGoogleIAP;->instance:Lcom/glu/android/iap/GluGoogleIAP;

    invoke-static {v0}, Lcom/glu/android/iap/GluGoogleIAP;->access$700(Lcom/glu/android/iap/GluGoogleIAP;)V

    sget-wide v0, Lcom/glu/googleiap/Consts;->BILLING_RESPONSE_INVALID_REQUEST_ID:J

    :goto_1
    return-wide v0

    :cond_2
    const/4 v0, 0x1

    goto :goto_0

    :cond_3
    new-instance v2, Landroid/content/Intent;

    invoke-direct {v2}, Landroid/content/Intent;-><init>()V

    invoke-static {}, Lcom/glu/android/iap/Debug;->log$552c4e01()V

    invoke-static {v0, v2}, Lcom/glu/googleiap/ResponseHandler;->buyPageIntentResponse(Landroid/app/PendingIntent;Landroid/content/Intent;)V

    const-string v0, "REQUEST_ID"

    sget-wide v2, Lcom/glu/googleiap/Consts;->BILLING_RESPONSE_INVALID_REQUEST_ID:J

    invoke-virtual {v1, v0, v2, v3}, Landroid/os/Bundle;->getLong(Ljava/lang/String;J)J

    move-result-wide v0

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Done with RequestPurchase, requestId(this still valid?) = "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0, v1}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    invoke-static {}, Lcom/glu/android/iap/Debug;->log$552c4e01()V

    goto :goto_1
.end method
