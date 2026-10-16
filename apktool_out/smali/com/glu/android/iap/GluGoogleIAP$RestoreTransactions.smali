.class public final Lcom/glu/android/iap/GluGoogleIAP$RestoreTransactions;
.super Lcom/glu/android/iap/GluGoogleIAP$BillingRequest;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/glu/android/iap/GluGoogleIAP;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "RestoreTransactions"
.end annotation


# instance fields
.field m_cryptographicNonce:J


# direct methods
.method public constructor <init>()V
    .locals 1

    const/4 v0, -0x1

    invoke-direct {p0, v0}, Lcom/glu/android/iap/GluGoogleIAP$BillingRequest;-><init>(I)V

    return-void
.end method


# virtual methods
.method protected final onRemoteException(Landroid/os/RemoteException;)V
    .locals 2

    invoke-super {p0, p1}, Lcom/glu/android/iap/GluGoogleIAP$BillingRequest;->onRemoteException(Landroid/os/RemoteException;)V

    iget-wide v0, p0, Lcom/glu/android/iap/GluGoogleIAP$RestoreTransactions;->m_cryptographicNonce:J

    invoke-static {v0, v1}, Lcom/glu/googleiap/Security;->removeNonce(J)V

    return-void
.end method

.method protected final responseCodeReceived(Lcom/glu/googleiap/Consts$ResponseCode;)V
    .locals 1

    sget-object v0, Lcom/glu/android/iap/GluGoogleIAP;->instance:Lcom/glu/android/iap/GluGoogleIAP;

    invoke-static {p1}, Lcom/glu/googleiap/ResponseHandler;->responseCodeReceived$7a897b94$5f3371d6(Lcom/glu/googleiap/Consts$ResponseCode;)V

    return-void
.end method

.method protected final run()J
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    invoke-static {}, Lcom/glu/googleiap/Security;->generateNonce()J

    move-result-wide v0

    iput-wide v0, p0, Lcom/glu/android/iap/GluGoogleIAP$RestoreTransactions;->m_cryptographicNonce:J

    const-string v0, "RESTORE_TRANSACTIONS"

    invoke-static {v0}, Lcom/glu/android/iap/GluGoogleIAP$RestoreTransactions;->makeRequestBundle(Ljava/lang/String;)Landroid/os/Bundle;

    move-result-object v0

    const-string v1, "NONCE"

    iget-wide v2, p0, Lcom/glu/android/iap/GluGoogleIAP$RestoreTransactions;->m_cryptographicNonce:J

    invoke-virtual {v0, v1, v2, v3}, Landroid/os/Bundle;->putLong(Ljava/lang/String;J)V

    sget-object v1, Lcom/glu/android/iap/GluGoogleIAP;->instance:Lcom/glu/android/iap/GluGoogleIAP;

    invoke-static {}, Lcom/glu/android/iap/GluGoogleIAP;->access$500()Lcom/android/vending/billing/IMarketBillingService;

    move-result-object v1

    invoke-interface {v1, v0}, Lcom/android/vending/billing/IMarketBillingService;->sendBillingRequest(Landroid/os/Bundle;)Landroid/os/Bundle;

    move-result-object v0

    const-string v1, "restoreTransactions"

    invoke-static {v1, v0}, Lcom/glu/android/iap/GluGoogleIAP$RestoreTransactions;->logResponseCode(Ljava/lang/String;Landroid/os/Bundle;)V

    const-string v1, "REQUEST_ID"

    sget-wide v2, Lcom/glu/googleiap/Consts;->BILLING_RESPONSE_INVALID_REQUEST_ID:J

    invoke-virtual {v0, v1, v2, v3}, Landroid/os/Bundle;->getLong(Ljava/lang/String;J)J

    move-result-wide v0

    return-wide v0
.end method
