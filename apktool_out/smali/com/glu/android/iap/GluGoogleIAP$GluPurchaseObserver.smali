.class final Lcom/glu/android/iap/GluGoogleIAP$GluPurchaseObserver;
.super Lcom/glu/googleiap/PurchaseObserver;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/glu/android/iap/GluGoogleIAP;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "GluPurchaseObserver"
.end annotation


# direct methods
.method public constructor <init>(Landroid/os/Handler;)V
    .locals 1

    sget-object v0, Lcom/glu/android/iap/IAPJava;->m_activity:Landroid/app/Activity;

    invoke-direct {p0, v0, p1}, Lcom/glu/googleiap/PurchaseObserver;-><init>(Landroid/app/Activity;Landroid/os/Handler;)V

    return-void
.end method


# virtual methods
.method public final onBillingSupported(Z)V
    .locals 2

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "supported: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    invoke-static {}, Lcom/glu/android/iap/Debug;->log$552c4e01()V

    sget-object v0, Lcom/glu/android/iap/GluGoogleIAP;->instance:Lcom/glu/android/iap/GluGoogleIAP;

    invoke-static {p1}, Lcom/glu/android/iap/GluGoogleIAP;->access$802(Z)Z

    sget-object v0, Lcom/glu/android/iap/GluGoogleIAP;->instance:Lcom/glu/android/iap/GluGoogleIAP;

    const/4 v0, 0x1

    invoke-static {v0}, Lcom/glu/android/iap/GluGoogleIAP;->access$902(Z)Z

    return-void
.end method

.method public final onPurchaseStateChange$af83840(Lcom/glu/googleiap/Consts$PurchaseState;Ljava/lang/String;J)V
    .locals 2

    invoke-static {}, Lcom/glu/android/iap/GluGoogleIAP;->access$1100()Ljava/lang/Object;

    move-result-object v1

    monitor-enter v1

    :try_start_0
    sget-object v0, Lcom/glu/googleiap/Consts$PurchaseState;->PURCHASED:Lcom/glu/googleiap/Consts$PurchaseState;

    if-ne p1, v0, :cond_2

    sget-object v0, Lcom/glu/android/iap/GluGoogleIAP;->instance:Lcom/glu/android/iap/GluGoogleIAP;

    invoke-static {v0}, Lcom/glu/android/iap/GluGoogleIAP;->access$1200(Lcom/glu/android/iap/GluGoogleIAP;)Z

    move-result v0

    if-eqz v0, :cond_1

    sget-object v0, Lcom/glu/android/iap/GluGoogleIAP;->instance:Lcom/glu/android/iap/GluGoogleIAP;

    invoke-static {}, Lcom/glu/android/iap/GluGoogleIAP;->access$000()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p2, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    sget-object v0, Lcom/glu/android/iap/GluGoogleIAP;->instance:Lcom/glu/android/iap/GluGoogleIAP;

    const/4 v0, 0x1

    invoke-static {v0}, Lcom/glu/android/iap/GluGoogleIAP;->access$1302(I)I

    :goto_0
    sget-object v0, Lcom/glu/android/iap/GluGoogleIAP;->instance:Lcom/glu/android/iap/GluGoogleIAP;

    invoke-static {v0, p2, p3, p4}, Lcom/glu/android/iap/GluGoogleIAP;->access$1400(Lcom/glu/android/iap/GluGoogleIAP;Ljava/lang/String;J)V

    :cond_0
    :goto_1
    monitor-exit v1

    return-void

    :cond_1
    invoke-static {}, Lcom/glu/android/iap/IAP;->displayAsyncSuccessMessage()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    :catchall_0
    move-exception v0

    monitor-exit v1

    throw v0

    :cond_2
    :try_start_1
    sget-object v0, Lcom/glu/googleiap/Consts$PurchaseState;->REFUNDED:Lcom/glu/googleiap/Consts$PurchaseState;

    if-ne p1, v0, :cond_3

    sget-object v0, Lcom/glu/android/iap/GluGoogleIAP;->instance:Lcom/glu/android/iap/GluGoogleIAP;

    invoke-static {v0, p2, p3, p4}, Lcom/glu/android/iap/GluGoogleIAP;->access$1500(Lcom/glu/android/iap/GluGoogleIAP;Ljava/lang/String;J)V

    goto :goto_1

    :cond_3
    sget-object v0, Lcom/glu/googleiap/Consts$PurchaseState;->CANCELED:Lcom/glu/googleiap/Consts$PurchaseState;

    if-ne p1, v0, :cond_0

    invoke-static {}, Lcom/glu/android/iap/Debug;->log$552c4e01()V

    sget-object v0, Lcom/glu/android/iap/GluGoogleIAP;->instance:Lcom/glu/android/iap/GluGoogleIAP;

    invoke-static {v0}, Lcom/glu/android/iap/GluGoogleIAP;->access$1200(Lcom/glu/android/iap/GluGoogleIAP;)Z

    move-result v0

    if-eqz v0, :cond_4

    sget-object v0, Lcom/glu/android/iap/GluGoogleIAP;->instance:Lcom/glu/android/iap/GluGoogleIAP;

    const/4 v0, 0x2

    invoke-static {v0}, Lcom/glu/android/iap/GluGoogleIAP;->access$1302(I)I

    goto :goto_1

    :cond_4
    invoke-static {}, Lcom/glu/android/iap/IAP;->displayAsyncFailureMessage()V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_1
.end method

.method public final onRequestPurchaseResponse(Lcom/glu/android/iap/GluGoogleIAP$RequestPurchase;Lcom/glu/googleiap/Consts$ResponseCode;)V
    .locals 2

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v1, p1, Lcom/glu/android/iap/GluGoogleIAP$RequestPurchase;->m_productId:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ": "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    invoke-static {}, Lcom/glu/android/iap/Debug;->log$552c4e01()V

    sget-object v0, Lcom/glu/googleiap/Consts$ResponseCode;->RESULT_OK:Lcom/glu/googleiap/Consts$ResponseCode;

    if-ne p2, v0, :cond_0

    invoke-static {}, Lcom/glu/android/iap/Debug;->log$552c4e01()V

    :goto_0
    return-void

    :cond_0
    sget-object v0, Lcom/glu/googleiap/Consts$ResponseCode;->RESULT_USER_CANCELED:Lcom/glu/googleiap/Consts$ResponseCode;

    if-ne p2, v0, :cond_1

    invoke-static {}, Lcom/glu/android/iap/Debug;->log$552c4e01()V

    sget-object v0, Lcom/glu/android/iap/GluGoogleIAP;->instance:Lcom/glu/android/iap/GluGoogleIAP;

    const/4 v0, 0x3

    invoke-static {v0}, Lcom/glu/android/iap/GluGoogleIAP;->access$1302(I)I

    goto :goto_0

    :cond_1
    invoke-static {}, Lcom/glu/android/iap/Debug;->log$552c4e01()V

    sget-object v0, Lcom/glu/android/iap/GluGoogleIAP;->instance:Lcom/glu/android/iap/GluGoogleIAP;

    const/4 v0, 0x2

    invoke-static {v0}, Lcom/glu/android/iap/GluGoogleIAP;->access$1302(I)I

    goto :goto_0
.end method

.method public final onRestoreTransactionsResponse$5f3371d6(Lcom/glu/googleiap/Consts$ResponseCode;)V
    .locals 3

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "completed RestoreTransactions request = "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    invoke-static {}, Lcom/glu/android/iap/Debug;->log$552c4e01()V

    sget-object v0, Lcom/glu/googleiap/Consts$ResponseCode;->RESULT_OK:Lcom/glu/googleiap/Consts$ResponseCode;

    if-ne p1, v0, :cond_0

    sget-object v0, Lcom/glu/android/iap/IAPJava;->m_activity:Landroid/app/Activity;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/app/Activity;->getPreferences(I)Landroid/content/SharedPreferences;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v1, "db_initialized"

    const/4 v2, 0x1

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->commit()Z

    :cond_0
    return-void
.end method

.method public final onSubscriptionSupported(Z)V
    .locals 2

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "subs supported: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    invoke-static {}, Lcom/glu/android/iap/Debug;->log$552c4e01()V

    sget-object v0, Lcom/glu/android/iap/GluGoogleIAP;->instance:Lcom/glu/android/iap/GluGoogleIAP;

    invoke-static {p1}, Lcom/glu/android/iap/GluGoogleIAP;->access$1002(Z)Z

    sget-object v0, Lcom/glu/android/iap/GluGoogleIAP;->instance:Lcom/glu/android/iap/GluGoogleIAP;

    const/4 v0, 0x1

    invoke-static {v0}, Lcom/glu/android/iap/GluGoogleIAP;->access$902(Z)Z

    return-void
.end method
