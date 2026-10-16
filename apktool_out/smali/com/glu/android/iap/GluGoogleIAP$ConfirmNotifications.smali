.class public final Lcom/glu/android/iap/GluGoogleIAP$ConfirmNotifications;
.super Lcom/glu/android/iap/GluGoogleIAP$BillingRequest;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/glu/android/iap/GluGoogleIAP;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "ConfirmNotifications"
.end annotation


# instance fields
.field final m_notifyIds:[Ljava/lang/String;


# direct methods
.method public constructor <init>(I[Ljava/lang/String;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/glu/android/iap/GluGoogleIAP$BillingRequest;-><init>(I)V

    iput-object p2, p0, Lcom/glu/android/iap/GluGoogleIAP$ConfirmNotifications;->m_notifyIds:[Ljava/lang/String;

    return-void
.end method


# virtual methods
.method protected final run()J
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    const-string v0, "CONFIRM_NOTIFICATIONS"

    invoke-static {v0}, Lcom/glu/android/iap/GluGoogleIAP$ConfirmNotifications;->makeRequestBundle(Ljava/lang/String;)Landroid/os/Bundle;

    move-result-object v0

    const-string v1, "NOTIFY_IDS"

    iget-object v2, p0, Lcom/glu/android/iap/GluGoogleIAP$ConfirmNotifications;->m_notifyIds:[Ljava/lang/String;

    invoke-virtual {v0, v1, v2}, Landroid/os/Bundle;->putStringArray(Ljava/lang/String;[Ljava/lang/String;)V

    sget-object v1, Lcom/glu/android/iap/GluGoogleIAP;->instance:Lcom/glu/android/iap/GluGoogleIAP;

    invoke-static {}, Lcom/glu/android/iap/GluGoogleIAP;->access$500()Lcom/android/vending/billing/IMarketBillingService;

    move-result-object v1

    invoke-interface {v1, v0}, Lcom/android/vending/billing/IMarketBillingService;->sendBillingRequest(Landroid/os/Bundle;)Landroid/os/Bundle;

    move-result-object v0

    const-string v1, "confirmNotifications"

    invoke-static {v1, v0}, Lcom/glu/android/iap/GluGoogleIAP$ConfirmNotifications;->logResponseCode(Ljava/lang/String;Landroid/os/Bundle;)V

    const-string v1, "REQUEST_ID"

    sget-wide v2, Lcom/glu/googleiap/Consts;->BILLING_RESPONSE_INVALID_REQUEST_ID:J

    invoke-virtual {v0, v1, v2, v3}, Landroid/os/Bundle;->getLong(Ljava/lang/String;J)J

    move-result-wide v0

    return-wide v0
.end method
