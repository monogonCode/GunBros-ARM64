.class public final Lcom/glu/android/iap/GluGoogleIAP$CheckSubscriptionSupported;
.super Lcom/glu/android/iap/GluGoogleIAP$BillingRequest;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/glu/android/iap/GluGoogleIAP;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "CheckSubscriptionSupported"
.end annotation


# direct methods
.method public constructor <init>()V
    .locals 1

    const/4 v0, -0x1

    invoke-direct {p0, v0}, Lcom/glu/android/iap/GluGoogleIAP$BillingRequest;-><init>(I)V

    invoke-static {}, Lcom/glu/android/iap/Debug;->log$552c4e01()V

    return-void
.end method


# virtual methods
.method protected final run()J
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    const-string v0, "CHECK_BILLING_SUPPORTED"

    const/4 v1, 0x2

    invoke-static {v0, v1}, Lcom/glu/android/iap/GluGoogleIAP$CheckSubscriptionSupported;->makeRequestBundle(Ljava/lang/String;I)Landroid/os/Bundle;

    move-result-object v0

    const-string v1, "ITEM_TYPE"

    const-string v2, "subs"

    invoke-virtual {v0, v1, v2}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    sget-object v1, Lcom/glu/android/iap/GluGoogleIAP;->instance:Lcom/glu/android/iap/GluGoogleIAP;

    invoke-static {}, Lcom/glu/android/iap/GluGoogleIAP;->access$500()Lcom/android/vending/billing/IMarketBillingService;

    move-result-object v1

    invoke-interface {v1, v0}, Lcom/android/vending/billing/IMarketBillingService;->sendBillingRequest(Landroid/os/Bundle;)Landroid/os/Bundle;

    move-result-object v0

    const-string v1, "RESPONSE_CODE"

    invoke-virtual {v0, v1}, Landroid/os/Bundle;->getInt(Ljava/lang/String;)I

    move-result v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "CheckSubSupported response code: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-static {v0}, Lcom/glu/googleiap/Consts$ResponseCode;->valueOf(I)Lcom/glu/googleiap/Consts$ResponseCode;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "  packageID="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    sget-object v2, Lcom/glu/android/iap/IAPJava;->m_activity:Landroid/app/Activity;

    invoke-virtual {v2}, Landroid/app/Activity;->getPackageName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    invoke-static {}, Lcom/glu/android/iap/Debug;->log$552c4e01()V

    sget-object v1, Lcom/glu/googleiap/Consts$ResponseCode;->RESULT_OK:Lcom/glu/googleiap/Consts$ResponseCode;

    invoke-virtual {v1}, Lcom/glu/googleiap/Consts$ResponseCode;->ordinal()I

    move-result v1

    if-ne v0, v1, :cond_0

    const/4 v0, 0x1

    :goto_0
    invoke-static {v0}, Lcom/glu/googleiap/ResponseHandler;->checkSubscriptionSupportedResponse(Z)V

    sget-wide v0, Lcom/glu/googleiap/Consts;->BILLING_RESPONSE_INVALID_REQUEST_ID:J

    return-wide v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method
