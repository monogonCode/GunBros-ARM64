.class public abstract Lcom/glu/android/iap/GluGoogleIAP$BillingRequest;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/glu/android/iap/GluGoogleIAP;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x409
    name = "BillingRequest"
.end annotation


# instance fields
.field protected m_requestId:J

.field private final m_startId:I


# direct methods
.method public constructor <init>(I)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    invoke-static {}, Lcom/glu/android/iap/Debug;->log$552c4e01()V

    iput p1, p0, Lcom/glu/android/iap/GluGoogleIAP$BillingRequest;->m_startId:I

    return-void
.end method

.method protected static logResponseCode(Ljava/lang/String;Landroid/os/Bundle;)V
    .locals 3

    const-string v0, "RESPONSE_CODE"

    invoke-virtual {p1, v0}, Landroid/os/Bundle;->getInt(Ljava/lang/String;)I

    move-result v0

    invoke-static {v0}, Lcom/glu/googleiap/Consts$ResponseCode;->valueOf(I)Lcom/glu/googleiap/Consts$ResponseCode;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " received "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v0}, Lcom/glu/googleiap/Consts$ResponseCode;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    invoke-static {}, Lcom/glu/android/iap/Debug;->log$552c4e01()V

    return-void
.end method

.method protected static makeRequestBundle(Ljava/lang/String;)Landroid/os/Bundle;
    .locals 1

    const/4 v0, 0x1

    invoke-static {p0, v0}, Lcom/glu/android/iap/GluGoogleIAP$BillingRequest;->makeRequestBundle(Ljava/lang/String;I)Landroid/os/Bundle;

    move-result-object v0

    return-object v0
.end method

.method protected static makeRequestBundle(Ljava/lang/String;I)Landroid/os/Bundle;
    .locals 3

    new-instance v0, Landroid/os/Bundle;

    invoke-direct {v0}, Landroid/os/Bundle;-><init>()V

    const-string v1, "BILLING_REQUEST"

    invoke-virtual {v0, v1, p0}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "makeRequestBundle.method - "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    invoke-static {}, Lcom/glu/android/iap/Debug;->log$552c4e01()V

    const-string v1, "API_VERSION"

    invoke-virtual {v0, v1, p1}, Landroid/os/Bundle;->putInt(Ljava/lang/String;I)V

    const-string v1, "PACKAGE_NAME"

    sget-object v2, Lcom/glu/android/iap/IAPJava;->m_activity:Landroid/app/Activity;

    invoke-virtual {v2}, Landroid/app/Activity;->getPackageName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "makeRequestBundle.package - "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    sget-object v2, Lcom/glu/android/iap/IAPJava;->m_activity:Landroid/app/Activity;

    invoke-virtual {v2}, Landroid/app/Activity;->getPackageName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    invoke-static {}, Lcom/glu/android/iap/Debug;->log$552c4e01()V

    return-object v0
.end method


# virtual methods
.method public final getStartId()I
    .locals 1

    iget v0, p0, Lcom/glu/android/iap/GluGoogleIAP$BillingRequest;->m_startId:I

    return v0
.end method

.method protected onRemoteException(Landroid/os/RemoteException;)V
    .locals 1

    invoke-static {}, Lcom/glu/android/iap/Debug;->log$2d473e19()V

    sget-object v0, Lcom/glu/android/iap/GluGoogleIAP;->instance:Lcom/glu/android/iap/GluGoogleIAP;

    const/4 v0, 0x0

    invoke-static {v0}, Lcom/glu/android/iap/GluGoogleIAP;->access$502(Lcom/android/vending/billing/IMarketBillingService;)Lcom/android/vending/billing/IMarketBillingService;

    return-void
.end method

.method protected responseCodeReceived(Lcom/glu/googleiap/Consts$ResponseCode;)V
    .locals 0

    return-void
.end method

.method protected abstract run()J
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation
.end method

.method public final runIfConnected()Z
    .locals 4

    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    invoke-static {}, Lcom/glu/android/iap/Debug;->log$552c4e01()V

    sget-object v0, Lcom/glu/android/iap/GluGoogleIAP;->instance:Lcom/glu/android/iap/GluGoogleIAP;

    invoke-static {}, Lcom/glu/android/iap/GluGoogleIAP;->access$500()Lcom/android/vending/billing/IMarketBillingService;

    move-result-object v0

    if-eqz v0, :cond_1

    :try_start_0
    invoke-virtual {p0}, Lcom/glu/android/iap/GluGoogleIAP$BillingRequest;->run()J

    move-result-wide v0

    iput-wide v0, p0, Lcom/glu/android/iap/GluGoogleIAP$BillingRequest;->m_requestId:J

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "request id: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-wide v1, p0, Lcom/glu/android/iap/GluGoogleIAP$BillingRequest;->m_requestId:J

    invoke-virtual {v0, v1, v2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    invoke-static {}, Lcom/glu/android/iap/Debug;->log$552c4e01()V

    iget-wide v0, p0, Lcom/glu/android/iap/GluGoogleIAP$BillingRequest;->m_requestId:J

    const-wide/16 v2, 0x0

    cmp-long v0, v0, v2

    if-ltz v0, :cond_0

    sget-object v0, Lcom/glu/android/iap/GluGoogleIAP;->instance:Lcom/glu/android/iap/GluGoogleIAP;

    invoke-static {}, Lcom/glu/android/iap/GluGoogleIAP;->access$600()Ljava/util/HashMap;

    move-result-object v0

    iget-wide v1, p0, Lcom/glu/android/iap/GluGoogleIAP$BillingRequest;->m_requestId:J

    invoke-static {v1, v2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    invoke-virtual {v0, v1, p0}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    :cond_0
    const/4 v0, 0x1

    :goto_0
    return v0

    :catch_0
    move-exception v0

    invoke-virtual {p0, v0}, Lcom/glu/android/iap/GluGoogleIAP$BillingRequest;->onRemoteException(Landroid/os/RemoteException;)V

    :cond_1
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public final runRequest()Z
    .locals 2

    const/4 v0, 0x1

    invoke-virtual {p0}, Lcom/glu/android/iap/GluGoogleIAP$BillingRequest;->runIfConnected()Z

    move-result v1

    if-eqz v1, :cond_0

    :goto_0
    return v0

    :cond_0
    sget-object v1, Lcom/glu/android/iap/GluGoogleIAP;->instance:Lcom/glu/android/iap/GluGoogleIAP;

    invoke-static {v1}, Lcom/glu/android/iap/GluGoogleIAP;->access$300(Lcom/glu/android/iap/GluGoogleIAP;)Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-static {}, Lcom/glu/android/iap/Debug;->log$552c4e01()V

    sget-object v1, Lcom/glu/android/iap/GluGoogleIAP;->instance:Lcom/glu/android/iap/GluGoogleIAP;

    invoke-static {}, Lcom/glu/android/iap/GluGoogleIAP;->access$400()Ljava/util/LinkedList;

    move-result-object v1

    invoke-virtual {v1, p0}, Ljava/util/LinkedList;->add(Ljava/lang/Object;)Z

    goto :goto_0

    :cond_1
    const/4 v0, 0x0

    goto :goto_0
.end method
