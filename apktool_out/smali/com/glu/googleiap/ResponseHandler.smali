.class public Lcom/glu/googleiap/ResponseHandler;
.super Ljava/lang/Object;


# static fields
.field private static sPurchaseObserver:Lcom/glu/googleiap/PurchaseObserver;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static buyPageIntentResponse(Landroid/app/PendingIntent;Landroid/content/Intent;)V
    .locals 1

    sget-object v0, Lcom/glu/googleiap/ResponseHandler;->sPurchaseObserver:Lcom/glu/googleiap/PurchaseObserver;

    if-nez v0, :cond_0

    :goto_0
    return-void

    :cond_0
    sget-object v0, Lcom/glu/googleiap/ResponseHandler;->sPurchaseObserver:Lcom/glu/googleiap/PurchaseObserver;

    invoke-virtual {v0, p0, p1}, Lcom/glu/googleiap/PurchaseObserver;->startBuyPageActivity(Landroid/app/PendingIntent;Landroid/content/Intent;)V

    goto :goto_0
.end method

.method public static checkBillingSupportedResponse(Z)V
    .locals 1

    sget-object v0, Lcom/glu/googleiap/ResponseHandler;->sPurchaseObserver:Lcom/glu/googleiap/PurchaseObserver;

    if-eqz v0, :cond_0

    sget-object v0, Lcom/glu/googleiap/ResponseHandler;->sPurchaseObserver:Lcom/glu/googleiap/PurchaseObserver;

    invoke-virtual {v0, p0}, Lcom/glu/googleiap/PurchaseObserver;->onBillingSupported(Z)V

    :cond_0
    return-void
.end method

.method public static checkSubscriptionSupportedResponse(Z)V
    .locals 1

    sget-object v0, Lcom/glu/googleiap/ResponseHandler;->sPurchaseObserver:Lcom/glu/googleiap/PurchaseObserver;

    if-eqz v0, :cond_0

    sget-object v0, Lcom/glu/googleiap/ResponseHandler;->sPurchaseObserver:Lcom/glu/googleiap/PurchaseObserver;

    invoke-virtual {v0, p0}, Lcom/glu/googleiap/PurchaseObserver;->onSubscriptionSupported(Z)V

    :cond_0
    return-void
.end method

.method public static purchaseResponse$20db4f51$63f6ffa7(Lcom/glu/googleiap/Consts$PurchaseState;Ljava/lang/String;J)V
    .locals 2

    const-class v1, Lcom/glu/googleiap/ResponseHandler;

    monitor-enter v1

    :try_start_0
    sget-object v0, Lcom/glu/googleiap/ResponseHandler;->sPurchaseObserver:Lcom/glu/googleiap/PurchaseObserver;

    if-eqz v0, :cond_0

    sget-object v0, Lcom/glu/googleiap/ResponseHandler;->sPurchaseObserver:Lcom/glu/googleiap/PurchaseObserver;

    invoke-virtual {v0, p0, p1, p2, p3}, Lcom/glu/googleiap/PurchaseObserver;->postPurchaseStateChange$af83840(Lcom/glu/googleiap/Consts$PurchaseState;Ljava/lang/String;J)V

    :cond_0
    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    return-void

    :catchall_0
    move-exception v0

    monitor-exit v1

    throw v0
.end method

.method public static declared-synchronized register(Lcom/glu/googleiap/PurchaseObserver;)V
    .locals 2

    const-class v0, Lcom/glu/googleiap/ResponseHandler;

    monitor-enter v0

    :try_start_0
    sput-object p0, Lcom/glu/googleiap/ResponseHandler;->sPurchaseObserver:Lcom/glu/googleiap/PurchaseObserver;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit v0

    return-void

    :catchall_0
    move-exception v1

    monitor-exit v0

    throw v1
.end method

.method public static responseCodeReceived$2193dfa7(Lcom/glu/android/iap/GluGoogleIAP$RequestPurchase;Lcom/glu/googleiap/Consts$ResponseCode;)V
    .locals 1

    sget-object v0, Lcom/glu/googleiap/ResponseHandler;->sPurchaseObserver:Lcom/glu/googleiap/PurchaseObserver;

    if-eqz v0, :cond_0

    sget-object v0, Lcom/glu/googleiap/ResponseHandler;->sPurchaseObserver:Lcom/glu/googleiap/PurchaseObserver;

    invoke-virtual {v0, p0, p1}, Lcom/glu/googleiap/PurchaseObserver;->onRequestPurchaseResponse(Lcom/glu/android/iap/GluGoogleIAP$RequestPurchase;Lcom/glu/googleiap/Consts$ResponseCode;)V

    :cond_0
    return-void
.end method

.method public static responseCodeReceived$7a897b94$5f3371d6(Lcom/glu/googleiap/Consts$ResponseCode;)V
    .locals 1

    sget-object v0, Lcom/glu/googleiap/ResponseHandler;->sPurchaseObserver:Lcom/glu/googleiap/PurchaseObserver;

    if-eqz v0, :cond_0

    sget-object v0, Lcom/glu/googleiap/ResponseHandler;->sPurchaseObserver:Lcom/glu/googleiap/PurchaseObserver;

    invoke-virtual {v0, p0}, Lcom/glu/googleiap/PurchaseObserver;->onRestoreTransactionsResponse$5f3371d6(Lcom/glu/googleiap/Consts$ResponseCode;)V

    :cond_0
    return-void
.end method

.method public static declared-synchronized unregister$4b5e3270()V
    .locals 2

    const-class v0, Lcom/glu/googleiap/ResponseHandler;

    monitor-enter v0

    const/4 v1, 0x0

    :try_start_0
    sput-object v1, Lcom/glu/googleiap/ResponseHandler;->sPurchaseObserver:Lcom/glu/googleiap/PurchaseObserver;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit v0

    return-void

    :catchall_0
    move-exception v1

    monitor-exit v0

    throw v1
.end method
