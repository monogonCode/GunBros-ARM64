.class public Lcom/glu/android/iap/GluGoogleIAP;
.super Landroid/app/Service;

# interfaces
.implements Landroid/content/ServiceConnection;
.implements Lcom/glu/android/iap/IAP$IAPObject;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile;,
        Lcom/glu/android/iap/GluGoogleIAP$GluPurchaseObserver;,
        Lcom/glu/android/iap/GluGoogleIAP$RestoreTransactions;,
        Lcom/glu/android/iap/GluGoogleIAP$GetPurchaseInformation;,
        Lcom/glu/android/iap/GluGoogleIAP$ConfirmNotifications;,
        Lcom/glu/android/iap/GluGoogleIAP$RequestPurchase;,
        Lcom/glu/android/iap/GluGoogleIAP$CheckSubscriptionSupported;,
        Lcom/glu/android/iap/GluGoogleIAP$CheckBillingSupported;,
        Lcom/glu/android/iap/GluGoogleIAP$BillingRequest;
    }
.end annotation


# static fields
.field private static final DB_INITIALIZED:Ljava/lang/String; = "db_initialized"

.field private static final DEFAULT_LANGUAGE:Ljava/lang/String; = "en"

.field private static final GOOGLE_IAP_FAILED_STRING:Ljava/lang/String; = "~"

.field private static final ITEM_MANAGEMENT_LOCK:Ljava/lang/Object;

.field public static instance:Lcom/glu/android/iap/GluGoogleIAP;

.field private static m_asynchronousItemGiveTimer:I

.field private static m_asynchronousItemRemoveTimer:I

.field private static m_billingService:Lcom/android/vending/billing/IMarketBillingService;

.field private static m_billingSupported:Z

.field private static m_billingVerified:Z

.field private static m_buyProductThread:Ljava/lang/Thread;

.field private static m_handler:Landroid/os/Handler;

.field private static m_initRetryTimer:I

.field private static m_initialized:Z

.field private static m_pendingRequests:Ljava/util/LinkedList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/LinkedList",
            "<",
            "Lcom/glu/android/iap/GluGoogleIAP$BillingRequest;",
            ">;"
        }
    .end annotation
.end field

.field private static m_purchaseObserver:Lcom/glu/android/iap/GluGoogleIAP$GluPurchaseObserver;

.field private static m_purchaseTimeoutTimer:I

.field private static m_purchasedItemLog:Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile;

.field private static m_purchasingState:I

.field private static m_refundedItemLog:Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile;

.field private static m_restoreTransactionsInProgress:Z

.field private static m_restoredTransactions:Z

.field private static m_savedProductId:Ljava/lang/String;

.field private static m_sentRequests:Ljava/util/HashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/HashMap",
            "<",
            "Ljava/lang/Long;",
            "Lcom/glu/android/iap/GluGoogleIAP$BillingRequest;",
            ">;"
        }
    .end annotation
.end field

.field private static m_subscriptionSupported:Z


# direct methods
.method static constructor <clinit>()V
    .locals 1

    const/4 v0, 0x0

    sput-object v0, Lcom/glu/android/iap/GluGoogleIAP;->m_handler:Landroid/os/Handler;

    sput-object v0, Lcom/glu/android/iap/GluGoogleIAP;->instance:Lcom/glu/android/iap/GluGoogleIAP;

    new-instance v0, Ljava/lang/Object;

    invoke-direct {v0}, Ljava/lang/Object;-><init>()V

    sput-object v0, Lcom/glu/android/iap/GluGoogleIAP;->ITEM_MANAGEMENT_LOCK:Ljava/lang/Object;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Landroid/app/Service;-><init>()V

    invoke-static {}, Lcom/glu/android/iap/Debug;->log$552c4e01()V

    return-void
.end method

.method public constructor <init>(Lcom/glu/android/iap/IAP;)V
    .locals 1

    invoke-direct {p0}, Landroid/app/Service;-><init>()V

    invoke-direct {p0}, Lcom/glu/android/iap/GluGoogleIAP;->initStatics()V

    invoke-static {}, Lcom/glu/android/iap/Debug;->log$552c4e01()V

    sput-object p0, Lcom/glu/android/iap/IAP;->instance:Lcom/glu/android/iap/IAP$IAPObject;

    sput-object p0, Lcom/glu/android/iap/GluGoogleIAP;->instance:Lcom/glu/android/iap/GluGoogleIAP;

    sget-object v0, Lcom/glu/android/iap/IAPJava;->m_activity:Landroid/app/Activity;

    invoke-virtual {p0, v0}, Lcom/glu/android/iap/GluGoogleIAP;->attachBaseContext(Landroid/content/Context;)V

    return-void
.end method

.method static synthetic access$000()Ljava/lang/String;
    .locals 1

    sget-object v0, Lcom/glu/android/iap/GluGoogleIAP;->m_savedProductId:Ljava/lang/String;

    return-object v0
.end method

.method static synthetic access$100(Lcom/glu/android/iap/GluGoogleIAP;Ljava/lang/String;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/glu/android/iap/GluGoogleIAP;->doBuyProduct(Ljava/lang/String;)V

    return-void
.end method

.method static synthetic access$1002(Z)Z
    .locals 0

    sput-boolean p0, Lcom/glu/android/iap/GluGoogleIAP;->m_subscriptionSupported:Z

    return p0
.end method

.method static synthetic access$1100()Ljava/lang/Object;
    .locals 1

    sget-object v0, Lcom/glu/android/iap/GluGoogleIAP;->ITEM_MANAGEMENT_LOCK:Ljava/lang/Object;

    return-object v0
.end method

.method static synthetic access$1200(Lcom/glu/android/iap/GluGoogleIAP;)Z
    .locals 1

    invoke-direct {p0}, Lcom/glu/android/iap/GluGoogleIAP;->transactionInProgress()Z

    move-result v0

    return v0
.end method

.method static synthetic access$1302(I)I
    .locals 0

    sput p0, Lcom/glu/android/iap/GluGoogleIAP;->m_purchasingState:I

    return p0
.end method

.method static synthetic access$1400(Lcom/glu/android/iap/GluGoogleIAP;Ljava/lang/String;J)V
    .locals 0

    invoke-direct {p0, p1, p2, p3}, Lcom/glu/android/iap/GluGoogleIAP;->storeItemToAdd(Ljava/lang/String;J)V

    return-void
.end method

.method static synthetic access$1500(Lcom/glu/android/iap/GluGoogleIAP;Ljava/lang/String;J)V
    .locals 0

    invoke-direct {p0, p1, p2, p3}, Lcom/glu/android/iap/GluGoogleIAP;->storeItemToRemove(Ljava/lang/String;J)V

    return-void
.end method

.method static synthetic access$1900(Lcom/glu/android/iap/GluGoogleIAP;Ljava/lang/String;Z)Z
    .locals 1

    invoke-direct {p0, p1, p2}, Lcom/glu/android/iap/GluGoogleIAP;->asynchronousGiveUserItem(Ljava/lang/String;Z)Z

    move-result v0

    return v0
.end method

.method static synthetic access$2000(Lcom/glu/android/iap/GluGoogleIAP;Ljava/lang/String;)Z
    .locals 1

    invoke-direct {p0, p1}, Lcom/glu/android/iap/GluGoogleIAP;->asynchronousRemoveUserItem(Ljava/lang/String;)Z

    move-result v0

    return v0
.end method

.method static synthetic access$202(Ljava/lang/Thread;)Ljava/lang/Thread;
    .locals 0

    sput-object p0, Lcom/glu/android/iap/GluGoogleIAP;->m_buyProductThread:Ljava/lang/Thread;

    return-object p0
.end method

.method static synthetic access$300(Lcom/glu/android/iap/GluGoogleIAP;)Z
    .locals 1

    invoke-direct {p0}, Lcom/glu/android/iap/GluGoogleIAP;->bindToMarketBillingService()Z

    move-result v0

    return v0
.end method

.method static synthetic access$400()Ljava/util/LinkedList;
    .locals 1

    sget-object v0, Lcom/glu/android/iap/GluGoogleIAP;->m_pendingRequests:Ljava/util/LinkedList;

    return-object v0
.end method

.method static synthetic access$500()Lcom/android/vending/billing/IMarketBillingService;
    .locals 1

    sget-object v0, Lcom/glu/android/iap/GluGoogleIAP;->m_billingService:Lcom/android/vending/billing/IMarketBillingService;

    return-object v0
.end method

.method static synthetic access$502(Lcom/android/vending/billing/IMarketBillingService;)Lcom/android/vending/billing/IMarketBillingService;
    .locals 0

    sput-object p0, Lcom/glu/android/iap/GluGoogleIAP;->m_billingService:Lcom/android/vending/billing/IMarketBillingService;

    return-object p0
.end method

.method static synthetic access$600()Ljava/util/HashMap;
    .locals 1

    sget-object v0, Lcom/glu/android/iap/GluGoogleIAP;->m_sentRequests:Ljava/util/HashMap;

    return-object v0
.end method

.method static synthetic access$700(Lcom/glu/android/iap/GluGoogleIAP;)V
    .locals 0

    invoke-direct {p0}, Lcom/glu/android/iap/GluGoogleIAP;->currentItemFailed()V

    return-void
.end method

.method static synthetic access$802(Z)Z
    .locals 0

    sput-boolean p0, Lcom/glu/android/iap/GluGoogleIAP;->m_billingSupported:Z

    return p0
.end method

.method static synthetic access$902(Z)Z
    .locals 0

    sput-boolean p0, Lcom/glu/android/iap/GluGoogleIAP;->m_billingVerified:Z

    return p0
.end method

.method private asynchronousGiveUserItem(Ljava/lang/String;Z)Z
    .locals 4

    const/4 v1, 0x1

    const/4 v2, 0x0

    const/4 v3, 0x5

    if-eqz p2, :cond_0

    move v0, v1

    :goto_0
    invoke-static {v3, v0, p1}, Lcom/glu/android/iap/IAPJava;->iapCallbackEventS(IILjava/lang/String;)I

    move-result v0

    if-eqz v0, :cond_1

    :goto_1
    return v1

    :cond_0
    move v0, v2

    goto :goto_0

    :cond_1
    move v1, v2

    goto :goto_1
.end method

.method private asynchronousRemoveUserItem(Ljava/lang/String;)Z
    .locals 3

    const/4 v1, 0x0

    const/4 v2, 0x6

    sget-object v0, Lcom/glu/android/iap/IAP;->m_realToNativeProductIdHash:Ljava/util/Hashtable;

    invoke-virtual {v0, p1}, Ljava/util/Hashtable;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    invoke-static {v2, v1, v0}, Lcom/glu/android/iap/IAPJava;->iapCallbackEventS(IILjava/lang/String;)I

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    move v0, v1

    goto :goto_0
.end method

.method private bindToMarketBillingService()Z
    .locals 4

    const/4 v1, 0x1

    const/4 v0, 0x0

    sget-object v2, Lcom/glu/android/iap/IAPJava;->m_activity:Landroid/app/Activity;

    if-nez v2, :cond_0

    invoke-static {}, Lcom/glu/android/iap/Debug;->log$552c4e01()V

    :goto_0
    return v0

    :cond_0
    :try_start_0
    invoke-static {}, Lcom/glu/android/iap/Debug;->log$552c4e01()V

    new-instance v2, Landroid/content/Intent;

    const-string v3, "com.android.vending.billing.MarketBillingService.BIND"

    invoke-direct {v2, v3}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    const/4 v3, 0x1

    invoke-virtual {p0, v2, p0, v3}, Lcom/glu/android/iap/GluGoogleIAP;->bindService(Landroid/content/Intent;Landroid/content/ServiceConnection;I)Z

    move-result v2

    if-eqz v2, :cond_1

    move v0, v1

    goto :goto_0

    :cond_1
    invoke-static {}, Lcom/glu/android/iap/Debug;->log$552c4e01()V
    :try_end_0
    .catch Ljava/lang/SecurityException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Security exception: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    invoke-static {}, Lcom/glu/android/iap/Debug;->log$552c4e01()V

    goto :goto_0
.end method

.method private cancelCurrentItem()V
    .locals 4

    const/4 v3, 0x0

    const/4 v1, 0x1

    sget-object v0, Lcom/glu/android/iap/IAP;->m_realToNativeProductIdHash:Ljava/util/Hashtable;

    sget-object v2, Lcom/glu/android/iap/GluGoogleIAP;->m_savedProductId:Ljava/lang/String;

    invoke-virtual {v0, v2}, Ljava/util/Hashtable;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    invoke-static {v1, v3, v0}, Lcom/glu/android/iap/IAPJava;->iapCallbackEventS(IILjava/lang/String;)I

    const/4 v0, 0x0

    sput-object v0, Lcom/glu/android/iap/GluGoogleIAP;->m_savedProductId:Ljava/lang/String;

    const v0, 0xfacade

    sput v0, Lcom/glu/android/iap/GluGoogleIAP;->m_purchaseTimeoutTimer:I

    sput v3, Lcom/glu/android/iap/GluGoogleIAP;->m_purchasingState:I

    return-void
.end method

.method private checkBillingSupported()Z
    .locals 1

    invoke-static {}, Lcom/glu/android/iap/Debug;->log$552c4e01()V

    new-instance v0, Lcom/glu/android/iap/GluGoogleIAP$CheckBillingSupported;

    invoke-direct {v0}, Lcom/glu/android/iap/GluGoogleIAP$CheckBillingSupported;-><init>()V

    invoke-virtual {v0}, Lcom/glu/android/iap/GluGoogleIAP$CheckBillingSupported;->runRequest()Z

    move-result v0

    return v0
.end method

.method private checkResponseCode(JLcom/glu/googleiap/Consts$ResponseCode;)V
    .locals 3

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "received response for request "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1, p2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ": "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    invoke-static {}, Lcom/glu/android/iap/Debug;->log$552c4e01()V

    sget-object v0, Lcom/glu/android/iap/GluGoogleIAP;->m_sentRequests:Ljava/util/HashMap;

    invoke-static {p1, p2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/glu/android/iap/GluGoogleIAP$BillingRequest;

    if-nez v0, :cond_0

    :goto_0
    return-void

    :cond_0
    sget-object v1, Lcom/glu/android/iap/GluGoogleIAP;->ITEM_MANAGEMENT_LOCK:Ljava/lang/Object;

    monitor-enter v1

    :try_start_0
    instance-of v2, v0, Lcom/glu/android/iap/GluGoogleIAP$RequestPurchase;

    if-eqz v2, :cond_1

    sget-object v2, Lcom/glu/googleiap/Consts$ResponseCode;->RESULT_OK:Lcom/glu/googleiap/Consts$ResponseCode;

    if-eq p3, v2, :cond_1

    sget-object v2, Lcom/glu/googleiap/Consts$ResponseCode;->RESULT_USER_CANCELED:Lcom/glu/googleiap/Consts$ResponseCode;

    if-ne p3, v2, :cond_2

    const/4 v2, 0x3

    sput v2, Lcom/glu/android/iap/GluGoogleIAP;->m_purchasingState:I

    :cond_1
    :goto_1
    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    invoke-virtual {v0, p3}, Lcom/glu/android/iap/GluGoogleIAP$BillingRequest;->responseCodeReceived(Lcom/glu/googleiap/Consts$ResponseCode;)V

    sget-object v0, Lcom/glu/android/iap/GluGoogleIAP;->m_sentRequests:Ljava/util/HashMap;

    invoke-static {p1, p2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/util/HashMap;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_0

    :cond_2
    const/4 v2, 0x2

    :try_start_1
    sput v2, Lcom/glu/android/iap/GluGoogleIAP;->m_purchasingState:I
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_1

    :catchall_0
    move-exception v0

    monitor-exit v1

    throw v0
.end method

.method private checkSubscriptionSupported()Z
    .locals 1

    invoke-static {}, Lcom/glu/android/iap/Debug;->log$552c4e01()V

    new-instance v0, Lcom/glu/android/iap/GluGoogleIAP$CheckSubscriptionSupported;

    invoke-direct {v0}, Lcom/glu/android/iap/GluGoogleIAP$CheckSubscriptionSupported;-><init>()V

    invoke-virtual {v0}, Lcom/glu/android/iap/GluGoogleIAP$CheckSubscriptionSupported;->runRequest()Z

    move-result v0

    return v0
.end method

.method private confirmNotifications(I[Ljava/lang/String;)Z
    .locals 1

    new-instance v0, Lcom/glu/android/iap/GluGoogleIAP$ConfirmNotifications;

    invoke-direct {v0, p1, p2}, Lcom/glu/android/iap/GluGoogleIAP$ConfirmNotifications;-><init>(I[Ljava/lang/String;)V

    invoke-virtual {v0}, Lcom/glu/android/iap/GluGoogleIAP$ConfirmNotifications;->runRequest()Z

    move-result v0

    return v0
.end method

.method private currentItemFailed()V
    .locals 4

    const/4 v3, 0x0

    const/4 v1, 0x4

    sget-object v0, Lcom/glu/android/iap/IAP;->m_realToNativeProductIdHash:Ljava/util/Hashtable;

    sget-object v2, Lcom/glu/android/iap/GluGoogleIAP;->m_savedProductId:Ljava/lang/String;

    invoke-virtual {v0, v2}, Ljava/util/Hashtable;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    invoke-static {v1, v3, v0}, Lcom/glu/android/iap/IAPJava;->iapCallbackEventS(IILjava/lang/String;)I

    const/4 v0, 0x0

    sput-object v0, Lcom/glu/android/iap/GluGoogleIAP;->m_savedProductId:Ljava/lang/String;

    const v0, 0xfacade

    sput v0, Lcom/glu/android/iap/GluGoogleIAP;->m_purchaseTimeoutTimer:I

    sput v3, Lcom/glu/android/iap/GluGoogleIAP;->m_purchasingState:I

    return-void
.end method

.method private currentItemTimeout()V
    .locals 4

    const/4 v3, 0x0

    const/16 v1, 0x8

    sget-object v0, Lcom/glu/android/iap/IAP;->m_realToNativeProductIdHash:Ljava/util/Hashtable;

    sget-object v2, Lcom/glu/android/iap/GluGoogleIAP;->m_savedProductId:Ljava/lang/String;

    invoke-virtual {v0, v2}, Ljava/util/Hashtable;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    invoke-static {v1, v3, v0}, Lcom/glu/android/iap/IAPJava;->iapCallbackEventS(IILjava/lang/String;)I

    const/4 v0, 0x0

    sput-object v0, Lcom/glu/android/iap/GluGoogleIAP;->m_savedProductId:Ljava/lang/String;

    const v0, 0xfacade

    sput v0, Lcom/glu/android/iap/GluGoogleIAP;->m_purchaseTimeoutTimer:I

    sput v3, Lcom/glu/android/iap/GluGoogleIAP;->m_purchasingState:I

    return-void
.end method

.method private doBuyProduct(Ljava/lang/String;)V
    .locals 2

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Requesting purchase for "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    invoke-static {}, Lcom/glu/android/iap/Debug;->log$552c4e01()V

    invoke-direct {p0, p1}, Lcom/glu/android/iap/GluGoogleIAP;->requestPurchase(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    invoke-static {}, Lcom/glu/android/iap/Debug;->log$552c4e01()V

    const/4 v0, 0x2

    sput v0, Lcom/glu/android/iap/GluGoogleIAP;->m_purchasingState:I

    :cond_0
    return-void
.end method

.method private getPurchaseInformation(ILjava/lang/String;)Z
    .locals 3

    new-instance v0, Lcom/glu/android/iap/GluGoogleIAP$GetPurchaseInformation;

    const/4 v1, 0x1

    new-array v1, v1, [Ljava/lang/String;

    const/4 v2, 0x0

    aput-object p2, v1, v2

    invoke-direct {v0, p1, v1}, Lcom/glu/android/iap/GluGoogleIAP$GetPurchaseInformation;-><init>(I[Ljava/lang/String;)V

    invoke-virtual {v0}, Lcom/glu/android/iap/GluGoogleIAP$GetPurchaseInformation;->runRequest()Z

    move-result v0

    return v0
.end method

.method private giveUserCurrentItem()V
    .locals 2

    sget-object v0, Lcom/glu/android/iap/GluGoogleIAP;->m_purchasedItemLog:Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile;

    sget-object v1, Lcom/glu/android/iap/GluGoogleIAP;->m_savedProductId:Ljava/lang/String;

    invoke-virtual {v0, v1}, Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile;->immediatelyGiveSpecificItem(Ljava/lang/String;)Z

    const/4 v0, 0x0

    sput-object v0, Lcom/glu/android/iap/GluGoogleIAP;->m_savedProductId:Ljava/lang/String;

    const v0, 0xfacade

    sput v0, Lcom/glu/android/iap/GluGoogleIAP;->m_purchaseTimeoutTimer:I

    const/4 v0, 0x0

    sput v0, Lcom/glu/android/iap/GluGoogleIAP;->m_purchasingState:I

    return-void
.end method

.method private handleCommand(Landroid/content/Intent;I)V
    .locals 4

    if-nez p1, :cond_1

    sget-object v0, Lcom/glu/android/iap/IAPJava;->m_activity:Landroid/app/Activity;

    if-eqz v0, :cond_0

    invoke-static {}, Lcom/glu/android/iap/Debug;->log$552c4e01()V

    :cond_0
    :goto_0
    return-void

    :cond_1
    invoke-virtual {p1}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "handleCommand() action: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    invoke-static {}, Lcom/glu/android/iap/Debug;->log$552c4e01()V

    const-string v1, "com.glu.googleiap.CONFIRM_NOTIFICATION"

    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_2

    const-string v0, "notification_id"

    invoke-virtual {p1, v0}, Landroid/content/Intent;->getStringArrayExtra(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, p2, v0}, Lcom/glu/android/iap/GluGoogleIAP;->confirmNotifications(I[Ljava/lang/String;)Z

    goto :goto_0

    :cond_2
    const-string v1, "com.glu.googleiap.GET_PURCHASE_INFORMATION"

    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_3

    const-string v0, "notification_id"

    invoke-virtual {p1, v0}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, p2, v0}, Lcom/glu/android/iap/GluGoogleIAP;->getPurchaseInformation(ILjava/lang/String;)Z

    goto :goto_0

    :cond_3
    const-string v1, "com.android.vending.billing.PURCHASE_STATE_CHANGED"

    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_4

    const-string v0, "inapp_signed_data"

    invoke-virtual {p1, v0}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "inapp_signature"

    invoke-virtual {p1, v1}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, p2, v0, v1}, Lcom/glu/android/iap/GluGoogleIAP;->purchaseStateChanged(ILjava/lang/String;Ljava/lang/String;)V

    goto :goto_0

    :cond_4
    const-string v1, "com.android.vending.billing.RESPONSE_CODE"

    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    const-string v0, "request_id"

    const-wide/16 v1, -0x1

    invoke-virtual {p1, v0, v1, v2}, Landroid/content/Intent;->getLongExtra(Ljava/lang/String;J)J

    move-result-wide v0

    const-string v2, "response_code"

    sget-object v3, Lcom/glu/googleiap/Consts$ResponseCode;->RESULT_ERROR:Lcom/glu/googleiap/Consts$ResponseCode;

    invoke-virtual {v3}, Lcom/glu/googleiap/Consts$ResponseCode;->ordinal()I

    move-result v3

    invoke-virtual {p1, v2, v3}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I

    move-result v2

    invoke-static {v2}, Lcom/glu/googleiap/Consts$ResponseCode;->valueOf(I)Lcom/glu/googleiap/Consts$ResponseCode;

    move-result-object v2

    invoke-direct {p0, v0, v1, v2}, Lcom/glu/android/iap/GluGoogleIAP;->checkResponseCode(JLcom/glu/googleiap/Consts$ResponseCode;)V

    goto :goto_0
.end method

.method private initStatics()V
    .locals 5

    const/4 v4, 0x1

    const v3, 0xfacade

    const/4 v2, 0x0

    const/4 v1, 0x0

    invoke-static {}, Lcom/glu/android/iap/Debug;->log$552c4e01()V

    sput-object v2, Lcom/glu/android/iap/GluGoogleIAP;->m_billingService:Lcom/android/vending/billing/IMarketBillingService;

    new-instance v0, Ljava/util/LinkedList;

    invoke-direct {v0}, Ljava/util/LinkedList;-><init>()V

    sput-object v0, Lcom/glu/android/iap/GluGoogleIAP;->m_pendingRequests:Ljava/util/LinkedList;

    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    sput-object v0, Lcom/glu/android/iap/GluGoogleIAP;->m_sentRequests:Ljava/util/HashMap;

    sput-object v2, Lcom/glu/android/iap/GluGoogleIAP;->m_handler:Landroid/os/Handler;

    sput-object v2, Lcom/glu/android/iap/GluGoogleIAP;->m_purchaseObserver:Lcom/glu/android/iap/GluGoogleIAP$GluPurchaseObserver;

    sput-boolean v1, Lcom/glu/android/iap/GluGoogleIAP;->m_billingVerified:Z

    sput-boolean v4, Lcom/glu/android/iap/GluGoogleIAP;->m_billingSupported:Z

    sput-boolean v4, Lcom/glu/android/iap/GluGoogleIAP;->m_subscriptionSupported:Z

    sput v3, Lcom/glu/android/iap/GluGoogleIAP;->m_initRetryTimer:I

    sput v3, Lcom/glu/android/iap/GluGoogleIAP;->m_purchaseTimeoutTimer:I

    const v0, 0xea60

    sput v0, Lcom/glu/android/iap/GluGoogleIAP;->m_asynchronousItemGiveTimer:I

    sput v3, Lcom/glu/android/iap/GluGoogleIAP;->m_asynchronousItemRemoveTimer:I

    sput v1, Lcom/glu/android/iap/GluGoogleIAP;->m_purchasingState:I

    sput-boolean v1, Lcom/glu/android/iap/GluGoogleIAP;->m_restoredTransactions:Z

    sput-boolean v1, Lcom/glu/android/iap/GluGoogleIAP;->m_restoreTransactionsInProgress:Z

    sput-object v2, Lcom/glu/android/iap/GluGoogleIAP;->m_savedProductId:Ljava/lang/String;

    sput-boolean v1, Lcom/glu/android/iap/GluGoogleIAP;->m_initialized:Z

    sput-object v2, Lcom/glu/android/iap/GluGoogleIAP;->m_buyProductThread:Ljava/lang/Thread;

    new-instance v0, Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile;

    const-string v1, "giapa.dat"

    invoke-direct {v0, v1}, Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile;-><init>(Ljava/lang/String;)V

    sput-object v0, Lcom/glu/android/iap/GluGoogleIAP;->m_purchasedItemLog:Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile;

    new-instance v0, Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile;

    const-string v1, "giapr.dat"

    invoke-direct {v0, v1}, Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile;-><init>(Ljava/lang/String;)V

    sput-object v0, Lcom/glu/android/iap/GluGoogleIAP;->m_refundedItemLog:Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile;

    return-void
.end method

.method private managedCallRestoreTransactions()V
    .locals 4

    const/4 v3, 0x1

    const/4 v2, 0x0

    sget-boolean v0, Lcom/glu/android/iap/GluGoogleIAP;->m_restoreTransactionsInProgress:Z

    if-eqz v0, :cond_0

    :goto_0
    return-void

    :cond_0
    invoke-static {}, Lcom/glu/android/iap/Debug;->log$552c4e01()V

    sput-boolean v3, Lcom/glu/android/iap/GluGoogleIAP;->m_restoreTransactionsInProgress:Z

    sget-object v0, Lcom/glu/android/iap/IAPJava;->m_activity:Landroid/app/Activity;

    invoke-virtual {v0, v2}, Landroid/app/Activity;->getPreferences(I)Landroid/content/SharedPreferences;

    move-result-object v0

    const-string v1, "db_initialized"

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    const-string v1, "db_initialized"

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v0

    if-nez v0, :cond_1

    invoke-direct {p0}, Lcom/glu/android/iap/GluGoogleIAP;->restoreTransactions()Z

    move-result v0

    sput-boolean v0, Lcom/glu/android/iap/GluGoogleIAP;->m_restoredTransactions:Z

    goto :goto_0

    :cond_1
    sput-boolean v3, Lcom/glu/android/iap/GluGoogleIAP;->m_restoredTransactions:Z

    sput-boolean v2, Lcom/glu/android/iap/GluGoogleIAP;->m_restoreTransactionsInProgress:Z

    goto :goto_0
.end method

.method private purchaseStateChanged(ILjava/lang/String;Ljava/lang/String;)V
    .locals 7

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "purchaseStateChanged("

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ")"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    invoke-static {}, Lcom/glu/android/iap/Debug;->log$552c4e01()V

    invoke-static {p2, p3}, Lcom/glu/googleiap/Security;->verifyPurchase(Ljava/lang/String;Ljava/lang/String;)Ljava/util/ArrayList;

    move-result-object v0

    if-nez v0, :cond_1

    :cond_0
    :goto_0
    return-void

    :cond_1
    invoke-static {}, Lcom/glu/android/iap/Debug;->log$552c4e01()V

    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_1
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_3

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/glu/googleiap/Security$VerifiedPurchase;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "purchaseStateChanged.purchases "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget-object v4, v0, Lcom/glu/googleiap/Security$VerifiedPurchase;->productId:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    invoke-static {}, Lcom/glu/android/iap/Debug;->log$552c4e01()V

    iget-object v3, v0, Lcom/glu/googleiap/Security$VerifiedPurchase;->notificationId:Ljava/lang/String;

    if-eqz v3, :cond_2

    iget-object v3, v0, Lcom/glu/googleiap/Security$VerifiedPurchase;->notificationId:Ljava/lang/String;

    invoke-virtual {v1, v3}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    :cond_2
    iget-object v3, v0, Lcom/glu/googleiap/Security$VerifiedPurchase;->purchaseState:Lcom/glu/googleiap/Consts$PurchaseState;

    iget-object v4, v0, Lcom/glu/googleiap/Security$VerifiedPurchase;->productId:Ljava/lang/String;

    iget-object v5, v0, Lcom/glu/googleiap/Security$VerifiedPurchase;->orderId:Ljava/lang/String;

    iget-wide v5, v0, Lcom/glu/googleiap/Security$VerifiedPurchase;->purchaseTime:J

    iget-object v0, v0, Lcom/glu/googleiap/Security$VerifiedPurchase;->developerPayload:Ljava/lang/String;

    invoke-static {v3, v4, v5, v6}, Lcom/glu/googleiap/ResponseHandler;->purchaseResponse$20db4f51$63f6ffa7(Lcom/glu/googleiap/Consts$PurchaseState;Ljava/lang/String;J)V

    goto :goto_1

    :cond_3
    invoke-virtual {v1}, Ljava/util/ArrayList;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_0

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v0

    new-array v0, v0, [Ljava/lang/String;

    invoke-virtual {v1, v0}, Ljava/util/ArrayList;->toArray([Ljava/lang/Object;)[Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Ljava/lang/String;

    sget-object v1, Lcom/glu/android/iap/GluGoogleIAP;->m_purchasedItemLog:Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile;

    invoke-virtual {v1}, Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile;->isValid()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-direct {p0, p1, v0}, Lcom/glu/android/iap/GluGoogleIAP;->confirmNotifications(I[Ljava/lang/String;)Z

    goto :goto_0
.end method

.method private requestPurchase(Ljava/lang/String;)Z
    .locals 1

    new-instance v0, Lcom/glu/android/iap/GluGoogleIAP$RequestPurchase;

    invoke-direct {v0, p1}, Lcom/glu/android/iap/GluGoogleIAP$RequestPurchase;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0}, Lcom/glu/android/iap/GluGoogleIAP$RequestPurchase;->runRequest()Z

    move-result v0

    return v0
.end method

.method private requestPurchase(Ljava/lang/String;Ljava/lang/String;)Z
    .locals 1

    new-instance v0, Lcom/glu/android/iap/GluGoogleIAP$RequestPurchase;

    invoke-direct {v0, p1, p2}, Lcom/glu/android/iap/GluGoogleIAP$RequestPurchase;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {v0}, Lcom/glu/android/iap/GluGoogleIAP$RequestPurchase;->runRequest()Z

    move-result v0

    return v0
.end method

.method private restoreTransactions()Z
    .locals 1

    new-instance v0, Lcom/glu/android/iap/GluGoogleIAP$RestoreTransactions;

    invoke-direct {v0}, Lcom/glu/android/iap/GluGoogleIAP$RestoreTransactions;-><init>()V

    invoke-virtual {v0}, Lcom/glu/android/iap/GluGoogleIAP$RestoreTransactions;->runRequest()Z

    move-result v0

    return v0
.end method

.method private runPendingRequests()V
    .locals 3

    invoke-static {}, Lcom/glu/android/iap/Debug;->log$552c4e01()V

    const/4 v0, -0x1

    move v1, v0

    :cond_0
    :goto_0
    sget-object v0, Lcom/glu/android/iap/GluGoogleIAP;->m_pendingRequests:Ljava/util/LinkedList;

    invoke-virtual {v0}, Ljava/util/LinkedList;->peek()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/glu/android/iap/GluGoogleIAP$BillingRequest;

    if-eqz v0, :cond_2

    invoke-virtual {v0}, Lcom/glu/android/iap/GluGoogleIAP$BillingRequest;->runIfConnected()Z

    move-result v2

    if-eqz v2, :cond_1

    sget-object v2, Lcom/glu/android/iap/GluGoogleIAP;->m_pendingRequests:Ljava/util/LinkedList;

    invoke-virtual {v2}, Ljava/util/LinkedList;->remove()Ljava/lang/Object;

    invoke-virtual {v0}, Lcom/glu/android/iap/GluGoogleIAP$BillingRequest;->getStartId()I

    move-result v2

    if-ge v1, v2, :cond_0

    invoke-virtual {v0}, Lcom/glu/android/iap/GluGoogleIAP$BillingRequest;->getStartId()I

    move-result v0

    move v1, v0

    goto :goto_0

    :cond_1
    invoke-static {}, Lcom/glu/android/iap/Debug;->log$552c4e01()V

    invoke-direct {p0}, Lcom/glu/android/iap/GluGoogleIAP;->bindToMarketBillingService()Z

    :goto_1
    return-void

    :cond_2
    if-ltz v1, :cond_3

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "stopping service, startId: "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    invoke-static {}, Lcom/glu/android/iap/Debug;->log$552c4e01()V

    invoke-virtual {p0, v1}, Lcom/glu/android/iap/GluGoogleIAP;->stopSelf(I)V

    :cond_3
    invoke-static {}, Lcom/glu/android/iap/Debug;->log$552c4e01()V

    goto :goto_1
.end method

.method private storeItemToAdd(Ljava/lang/String;J)V
    .locals 1

    sget-object v0, Lcom/glu/android/iap/GluGoogleIAP;->m_purchasedItemLog:Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile;

    invoke-virtual {v0, p1, p2, p3}, Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile;->addItem(Ljava/lang/String;J)V

    return-void
.end method

.method private storeItemToRemove(Ljava/lang/String;J)V
    .locals 1

    sget-object v0, Lcom/glu/android/iap/GluGoogleIAP;->m_refundedItemLog:Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile;

    invoke-virtual {v0, p1, p2, p3}, Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile;->addItem(Ljava/lang/String;J)V

    return-void
.end method

.method private transactionInProgress()Z
    .locals 2

    sget v0, Lcom/glu/android/iap/GluGoogleIAP;->m_purchaseTimeoutTimer:I

    const v1, 0xfacade

    if-eq v0, v1, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method


# virtual methods
.method public buyProduct(Ljava/lang/String;)V
    .locals 3

    const/4 v2, 0x0

    invoke-virtual {p0, p1}, Lcom/glu/android/iap/GluGoogleIAP;->getRealProductId(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-static {p1}, Lcom/glu/android/iap/IAP;->initSingleProduct(Ljava/lang/String;)V

    sget-object v1, Lcom/glu/android/iap/GluGoogleIAP;->m_buyProductThread:Ljava/lang/Thread;

    if-eqz v1, :cond_1

    invoke-static {}, Lcom/glu/android/iap/Debug;->log$552c4e01()V

    :cond_0
    :goto_0
    return-void

    :cond_1
    sget-boolean v1, Lcom/glu/android/iap/GluGoogleIAP;->m_billingSupported:Z

    if-nez v1, :cond_2

    const/4 v0, 0x4

    invoke-static {v0, v2, p1}, Lcom/glu/android/iap/IAPJava;->iapCallbackEventS(IILjava/lang/String;)I

    goto :goto_0

    :cond_2
    invoke-virtual {p0}, Lcom/glu/android/iap/GluGoogleIAP;->forceAsynchronousPurchaseAward()Z

    move-result v1

    if-nez v1, :cond_0

    sput-object v0, Lcom/glu/android/iap/GluGoogleIAP;->m_savedProductId:Ljava/lang/String;

    const v0, 0xea60

    sput v0, Lcom/glu/android/iap/GluGoogleIAP;->m_purchaseTimeoutTimer:I

    sput v2, Lcom/glu/android/iap/GluGoogleIAP;->m_purchasingState:I

    new-instance v0, Lcom/glu/android/iap/GluGoogleIAP$1;

    invoke-direct {v0, p0}, Lcom/glu/android/iap/GluGoogleIAP$1;-><init>(Lcom/glu/android/iap/GluGoogleIAP;)V

    sput-object v0, Lcom/glu/android/iap/GluGoogleIAP;->m_buyProductThread:Ljava/lang/Thread;

    invoke-virtual {v0}, Ljava/lang/Thread;->start()V

    goto :goto_0
.end method

.method public final forceAsynchronousPurchaseAward()Z
    .locals 4

    const/4 v2, 0x1

    const/4 v1, 0x0

    move v0, v1

    :goto_0
    sget-object v3, Lcom/glu/android/iap/GluGoogleIAP;->m_purchasedItemLog:Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile;

    invoke-virtual {v3}, Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile;->hasUnhandledItems()Z

    move-result v3

    if-eqz v3, :cond_0

    sget-object v0, Lcom/glu/android/iap/GluGoogleIAP;->m_purchasedItemLog:Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile;

    invoke-virtual {v0, v2}, Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile;->tryGivingOneItem(Z)Z

    move-result v0

    if-nez v0, :cond_2

    new-instance v0, Ljava/lang/RuntimeException;

    const-string v1, "this MUST succeed. fix your native code."

    invoke-direct {v0, v1}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    throw v0

    :cond_0
    if-eqz v0, :cond_1

    const/16 v0, 0x9

    const/4 v3, 0x0

    invoke-static {v0, v1, v3}, Lcom/glu/android/iap/IAPJava;->iapCallbackEvent(II[B)I

    :goto_1
    return v2

    :cond_1
    move v2, v1

    goto :goto_1

    :cond_2
    move v0, v2

    goto :goto_0
.end method

.method public getAttribute(ILjava/lang/String;)Ljava/lang/String;
    .locals 1

    const-string v0, "~"

    return-object v0
.end method

.method public getCurrencySymbol()Ljava/lang/String;
    .locals 1

    invoke-static {}, Lcom/glu/android/iap/IAP;->getCurrencySymbol$7157d249()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public final getIAPId()I
    .locals 1

    const/4 v0, 0x1

    return v0
.end method

.method public getProductType(Ljava/lang/String;)I
    .locals 1

    invoke-virtual {p0, p1}, Lcom/glu/android/iap/GluGoogleIAP;->getRealProductId(Ljava/lang/String;)Ljava/lang/String;

    invoke-static {}, Lcom/glu/android/iap/Debug;->log$552c4e01()V

    const/4 v0, 0x1

    return v0
.end method

.method public getRealProductId(Ljava/lang/String;)Ljava/lang/String;
    .locals 1

    invoke-virtual {p1}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public final hasInventoryLoaded()Z
    .locals 1

    const/4 v0, 0x1

    return v0
.end method

.method public init()V
    .locals 5

    const v4, 0xea60

    const/16 v3, 0x2710

    const/4 v2, 0x0

    invoke-static {}, Lcom/glu/android/iap/Debug;->log$552c4e01()V

    sget-boolean v0, Lcom/glu/android/iap/GluGoogleIAP;->m_initialized:Z

    if-nez v0, :cond_1

    new-instance v0, Lcom/glu/android/iap/GluGoogleIAP$GluPurchaseObserver;

    sget-object v1, Lcom/glu/android/iap/GluGoogleIAP;->m_handler:Landroid/os/Handler;

    invoke-direct {v0, v1}, Lcom/glu/android/iap/GluGoogleIAP$GluPurchaseObserver;-><init>(Landroid/os/Handler;)V

    sput-object v0, Lcom/glu/android/iap/GluGoogleIAP;->m_purchaseObserver:Lcom/glu/android/iap/GluGoogleIAP$GluPurchaseObserver;

    invoke-static {v0}, Lcom/glu/googleiap/ResponseHandler;->register(Lcom/glu/googleiap/PurchaseObserver;)V

    sget-object v0, Lcom/glu/android/iap/GluGoogleIAP;->m_purchasedItemLog:Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile;

    invoke-virtual {v0}, Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile;->hasUnhandledItems()Z

    move-result v0

    if-eqz v0, :cond_0

    sput v4, Lcom/glu/android/iap/GluGoogleIAP;->m_asynchronousItemGiveTimer:I

    :cond_0
    sget-object v0, Lcom/glu/android/iap/GluGoogleIAP;->m_refundedItemLog:Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile;

    invoke-virtual {v0}, Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile;->hasUnhandledItems()Z

    move-result v0

    if-eqz v0, :cond_1

    sput v4, Lcom/glu/android/iap/GluGoogleIAP;->m_asynchronousItemRemoveTimer:I

    :cond_1
    invoke-direct {p0}, Lcom/glu/android/iap/GluGoogleIAP;->checkBillingSupported()Z

    move-result v0

    if-nez v0, :cond_2

    sput-boolean v2, Lcom/glu/android/iap/GluGoogleIAP;->m_billingSupported:Z

    sput v3, Lcom/glu/android/iap/GluGoogleIAP;->m_initRetryTimer:I

    :cond_2
    invoke-direct {p0}, Lcom/glu/android/iap/GluGoogleIAP;->checkSubscriptionSupported()Z

    move-result v0

    if-nez v0, :cond_3

    sput-boolean v2, Lcom/glu/android/iap/GluGoogleIAP;->m_subscriptionSupported:Z

    sput v3, Lcom/glu/android/iap/GluGoogleIAP;->m_initRetryTimer:I

    :cond_3
    const/4 v0, 0x1

    sput-boolean v0, Lcom/glu/android/iap/GluGoogleIAP;->m_initialized:Z

    return-void
.end method

.method public isGoogleServiceConnected()Z
    .locals 1

    sget-boolean v0, Lcom/glu/android/iap/GluGoogleIAP;->m_billingSupported:Z

    return v0
.end method

.method public isIAPConnected()Z
    .locals 1

    const/4 v0, 0x1

    return v0
.end method

.method public isIAPSupported()Z
    .locals 2

    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/4 v1, 0x4

    if-ge v0, v1, :cond_0

    const/4 v0, 0x0

    :goto_0
    return v0

    :cond_0
    sget-boolean v0, Lcom/glu/android/iap/GluGoogleIAP;->m_billingSupported:Z

    goto :goto_0
.end method

.method public final isItemAvailable(Ljava/lang/String;)Z
    .locals 1

    const/4 v0, 0x1

    return v0
.end method

.method public isProductValid(Ljava/lang/String;)Z
    .locals 1

    invoke-virtual {p0, p1}, Lcom/glu/android/iap/GluGoogleIAP;->getRealProductId(Ljava/lang/String;)Ljava/lang/String;

    invoke-static {}, Lcom/glu/android/iap/Debug;->log$552c4e01()V

    const/4 v0, 0x1

    return v0
.end method

.method public isSubscriptionSupported()Z
    .locals 2

    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/4 v1, 0x4

    if-ge v0, v1, :cond_0

    const/4 v0, 0x0

    :goto_0
    return v0

    :cond_0
    sget-boolean v0, Lcom/glu/android/iap/GluGoogleIAP;->m_subscriptionSupported:Z

    goto :goto_0
.end method

.method public onAppStart()V
    .locals 1

    sget-boolean v0, Lcom/glu/android/iap/GluGoogleIAP;->m_initialized:Z

    if-eqz v0, :cond_0

    sget-object v0, Lcom/glu/android/iap/GluGoogleIAP;->m_purchaseObserver:Lcom/glu/android/iap/GluGoogleIAP$GluPurchaseObserver;

    invoke-static {v0}, Lcom/glu/googleiap/ResponseHandler;->register(Lcom/glu/googleiap/PurchaseObserver;)V

    :cond_0
    return-void
.end method

.method public onAppStop()V
    .locals 1

    sget-boolean v0, Lcom/glu/android/iap/GluGoogleIAP;->m_initialized:Z

    if-eqz v0, :cond_0

    sget-object v0, Lcom/glu/android/iap/GluGoogleIAP;->m_purchaseObserver:Lcom/glu/android/iap/GluGoogleIAP$GluPurchaseObserver;

    invoke-static {}, Lcom/glu/googleiap/ResponseHandler;->unregister$4b5e3270()V

    :cond_0
    return-void
.end method

.method public onBind(Landroid/content/Intent;)Landroid/os/IBinder;
    .locals 1

    invoke-static {}, Lcom/glu/android/iap/Debug;->log$552c4e01()V

    const/4 v0, 0x0

    return-object v0
.end method

.method public onIAPDestroy()V
    .locals 0

    invoke-static {}, Lcom/glu/googleiap/ResponseHandler;->unregister$4b5e3270()V

    invoke-virtual {p0}, Lcom/glu/android/iap/GluGoogleIAP;->unbind()V

    return-void
.end method

.method public final onInventoryFailure()V
    .locals 0

    return-void
.end method

.method public final onInventoryReceived(Ljava/util/Hashtable;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Hashtable",
            "<",
            "Ljava/lang/String;",
            "Lcom/glu/android/iap/IAP$Inventory;",
            ">;)V"
        }
    .end annotation

    return-void
.end method

.method public onServiceConnected(Landroid/content/ComponentName;Landroid/os/IBinder;)V
    .locals 1

    invoke-static {}, Lcom/glu/android/iap/Debug;->log$552c4e01()V

    invoke-static {p2}, Lcom/android/vending/billing/IMarketBillingService$Stub;->asInterface(Landroid/os/IBinder;)Lcom/android/vending/billing/IMarketBillingService;

    move-result-object v0

    sput-object v0, Lcom/glu/android/iap/GluGoogleIAP;->m_billingService:Lcom/android/vending/billing/IMarketBillingService;

    return-void
.end method

.method public onServiceDisconnected(Landroid/content/ComponentName;)V
    .locals 1

    invoke-static {}, Lcom/glu/android/iap/Debug;->log$552c4e01()V

    const/4 v0, 0x0

    sput-object v0, Lcom/glu/android/iap/GluGoogleIAP;->m_billingService:Lcom/android/vending/billing/IMarketBillingService;

    return-void
.end method

.method public onStart(Landroid/content/Intent;I)V
    .locals 1

    invoke-static {}, Lcom/glu/android/iap/Debug;->log$552c4e01()V

    sget-object v0, Lcom/glu/android/iap/GluGoogleIAP;->instance:Lcom/glu/android/iap/GluGoogleIAP;

    if-eqz v0, :cond_0

    sget-object v0, Lcom/glu/android/iap/IAPJava;->m_activity:Landroid/app/Activity;

    if-nez v0, :cond_2

    :cond_0
    sget-object v0, Lcom/glu/android/iap/IAPJava;->m_activity:Landroid/app/Activity;

    if-eqz v0, :cond_1

    invoke-static {}, Lcom/glu/android/iap/Debug;->log$552c4e01()V

    :cond_1
    :goto_0
    return-void

    :cond_2
    invoke-direct {p0, p1, p2}, Lcom/glu/android/iap/GluGoogleIAP;->handleCommand(Landroid/content/Intent;I)V

    goto :goto_0
.end method

.method public querySingleProduct(Ljava/lang/String;)V
    .locals 0

    invoke-virtual {p0, p1}, Lcom/glu/android/iap/GluGoogleIAP;->getRealProductId(Ljava/lang/String;)Ljava/lang/String;

    invoke-virtual {p0, p1}, Lcom/glu/android/iap/GluGoogleIAP;->buyProduct(Ljava/lang/String;)V

    return-void
.end method

.method public restoreUnclaimedItems()V
    .locals 0

    return-void
.end method

.method public setButtonCenterXY(I)V
    .locals 0

    return-void
.end method

.method public setButtonVisible(I)V
    .locals 0

    return-void
.end method

.method public tick(I)V
    .locals 6

    const/4 v1, 0x1

    const/4 v0, 0x0

    const v5, 0xfacade

    sget-object v2, Lcom/glu/android/iap/GluGoogleIAP;->m_pendingRequests:Ljava/util/LinkedList;

    invoke-virtual {v2}, Ljava/util/LinkedList;->peek()Ljava/lang/Object;

    move-result-object v2

    if-eqz v2, :cond_2

    invoke-direct {p0}, Lcom/glu/android/iap/GluGoogleIAP;->runPendingRequests()V

    :cond_0
    :goto_0
    sget-object v2, Lcom/glu/android/iap/GluGoogleIAP;->ITEM_MANAGEMENT_LOCK:Ljava/lang/Object;

    monitor-enter v2

    :try_start_0
    sget v3, Lcom/glu/android/iap/GluGoogleIAP;->m_purchaseTimeoutTimer:I

    if-eq v3, v5, :cond_1

    sget v3, Lcom/glu/android/iap/GluGoogleIAP;->m_purchaseTimeoutTimer:I

    sub-int/2addr v3, p1

    sput v3, Lcom/glu/android/iap/GluGoogleIAP;->m_purchaseTimeoutTimer:I

    sget v3, Lcom/glu/android/iap/GluGoogleIAP;->m_purchasingState:I

    if-ne v3, v1, :cond_3

    invoke-direct {p0}, Lcom/glu/android/iap/GluGoogleIAP;->giveUserCurrentItem()V

    :cond_1
    :goto_1
    sget v3, Lcom/glu/android/iap/GluGoogleIAP;->m_asynchronousItemGiveTimer:I

    if-eq v3, v5, :cond_7

    sget v3, Lcom/glu/android/iap/GluGoogleIAP;->m_asynchronousItemGiveTimer:I

    sub-int/2addr v3, p1

    sput v3, Lcom/glu/android/iap/GluGoogleIAP;->m_asynchronousItemGiveTimer:I

    if-gtz v3, :cond_7

    :goto_2
    sget-object v3, Lcom/glu/android/iap/GluGoogleIAP;->m_purchasedItemLog:Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile;

    invoke-virtual {v3}, Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile;->hasUnhandledItems()Z

    move-result v3

    if-eqz v3, :cond_6

    sget-object v3, Lcom/glu/android/iap/GluGoogleIAP;->m_purchasedItemLog:Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile;

    const/4 v4, 0x0

    invoke-virtual {v3, v4}, Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile;->tryGivingOneItem(Z)Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result v3

    if-eqz v3, :cond_6

    move v0, v1

    goto :goto_2

    :cond_2
    sget-boolean v2, Lcom/glu/android/iap/GluGoogleIAP;->m_restoredTransactions:Z

    if-nez v2, :cond_0

    sget-boolean v2, Lcom/glu/android/iap/GluGoogleIAP;->m_billingSupported:Z

    if-eqz v2, :cond_0

    sget-boolean v2, Lcom/glu/android/iap/GluGoogleIAP;->m_billingVerified:Z

    if-eqz v2, :cond_0

    invoke-direct {p0}, Lcom/glu/android/iap/GluGoogleIAP;->managedCallRestoreTransactions()V

    goto :goto_0

    :cond_3
    :try_start_1
    sget v3, Lcom/glu/android/iap/GluGoogleIAP;->m_purchasingState:I

    const/4 v4, 0x2

    if-ne v3, v4, :cond_4

    invoke-direct {p0}, Lcom/glu/android/iap/GluGoogleIAP;->currentItemFailed()V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_1

    :catchall_0
    move-exception v0

    monitor-exit v2

    throw v0

    :cond_4
    :try_start_2
    sget v3, Lcom/glu/android/iap/GluGoogleIAP;->m_purchasingState:I

    const/4 v4, 0x3

    if-ne v3, v4, :cond_5

    invoke-direct {p0}, Lcom/glu/android/iap/GluGoogleIAP;->cancelCurrentItem()V

    goto :goto_1

    :cond_5
    sget v3, Lcom/glu/android/iap/GluGoogleIAP;->m_purchaseTimeoutTimer:I

    if-gtz v3, :cond_1

    invoke-direct {p0}, Lcom/glu/android/iap/GluGoogleIAP;->currentItemTimeout()V

    goto :goto_1

    :cond_6
    const v1, 0xea60

    sput v1, Lcom/glu/android/iap/GluGoogleIAP;->m_asynchronousItemGiveTimer:I

    if-eqz v0, :cond_7

    const/16 v0, 0x9

    const/4 v1, 0x0

    const/4 v3, 0x0

    invoke-static {v0, v1, v3}, Lcom/glu/android/iap/IAPJava;->iapCallbackEvent(II[B)I

    :cond_7
    sget v0, Lcom/glu/android/iap/GluGoogleIAP;->m_asynchronousItemRemoveTimer:I

    if-eq v0, v5, :cond_a

    sget v0, Lcom/glu/android/iap/GluGoogleIAP;->m_asynchronousItemRemoveTimer:I

    sub-int/2addr v0, p1

    sput v0, Lcom/glu/android/iap/GluGoogleIAP;->m_asynchronousItemRemoveTimer:I

    if-gtz v0, :cond_9

    :cond_8
    sget-object v0, Lcom/glu/android/iap/GluGoogleIAP;->m_refundedItemLog:Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile;

    invoke-virtual {v0}, Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile;->hasUnhandledItems()Z

    move-result v0

    if-eqz v0, :cond_9

    sget-object v0, Lcom/glu/android/iap/GluGoogleIAP;->m_refundedItemLog:Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile;

    invoke-virtual {v0}, Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile;->tryRefundingOneItem()Z

    move-result v0

    if-nez v0, :cond_8

    const v0, 0xea60

    sput v0, Lcom/glu/android/iap/GluGoogleIAP;->m_asynchronousItemRemoveTimer:I

    :cond_9
    sget v0, Lcom/glu/android/iap/GluGoogleIAP;->m_asynchronousItemRemoveTimer:I

    if-gtz v0, :cond_a

    const v0, 0xfacade

    sput v0, Lcom/glu/android/iap/GluGoogleIAP;->m_asynchronousItemRemoveTimer:I

    :cond_a
    monitor-exit v2
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    return-void
.end method

.method public unbind()V
    .locals 1

    :try_start_0
    invoke-virtual {p0, p0}, Lcom/glu/android/iap/GluGoogleIAP;->unbindService(Landroid/content/ServiceConnection;)V
    :try_end_0
    .catch Ljava/lang/IllegalArgumentException; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return-void

    :catch_0
    move-exception v0

    goto :goto_0
.end method
