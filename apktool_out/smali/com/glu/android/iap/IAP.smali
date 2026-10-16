.class public final Lcom/glu/android/iap/IAP;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/glu/android/iap/IAP$IAPView;,
        Lcom/glu/android/iap/IAP$IAPObject;,
        Lcom/glu/android/iap/IAP$SettingsHash;
    }
.end annotation


# static fields
.field public static final IAP_PROVIDER_MASKS:Ljava/util/Hashtable;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Hashtable",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/Long;",
            ">;"
        }
    .end annotation
.end field

.field private static JSON_PROPERTY_GAME:Ljava/lang/String;

.field private static JSON_PROPERTY_MARKET:Ljava/lang/String;

.field private static JSON_PROPERTY_PRODUCTS:Ljava/lang/String;

.field private static JSON_PROPERTY_PRODUCTS_NAME:Ljava/lang/String;

.field private static JSON_PROPERTY_PRODUCTS_PRICE:Ljava/lang/String;

.field private static JSON_PROPERTY_PRODUCTS_PRODUCT:Ljava/lang/String;

.field public static instance:Lcom/glu/android/iap/IAP$IAPObject;

.field private static m_getDataFromServerThread:Ljava/lang/Thread;

.field public static m_realToNativeProductIdHash:Ljava/util/Hashtable;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Hashtable",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field public static sm_transactionState:I


# direct methods
.method static constructor <clinit>()V
    .locals 2

    const/4 v1, 0x0

    sput-object v1, Lcom/glu/android/iap/IAP;->instance:Lcom/glu/android/iap/IAP$IAPObject;

    new-instance v0, Lcom/glu/android/iap/IAP$SettingsHash;

    invoke-direct {v0}, Lcom/glu/android/iap/IAP$SettingsHash;-><init>()V

    sput-object v0, Lcom/glu/android/iap/IAP;->IAP_PROVIDER_MASKS:Ljava/util/Hashtable;

    const/4 v0, -0x1

    sput v0, Lcom/glu/android/iap/IAP;->sm_transactionState:I

    new-instance v0, Ljava/util/Hashtable;

    invoke-direct {v0}, Ljava/util/Hashtable;-><init>()V

    sput-object v0, Lcom/glu/android/iap/IAP;->m_realToNativeProductIdHash:Ljava/util/Hashtable;

    sput-object v1, Lcom/glu/android/iap/IAP;->m_getDataFromServerThread:Ljava/lang/Thread;

    const-string v0, "game"

    sput-object v0, Lcom/glu/android/iap/IAP;->JSON_PROPERTY_GAME:Ljava/lang/String;

    const-string v0, "market"

    sput-object v0, Lcom/glu/android/iap/IAP;->JSON_PROPERTY_MARKET:Ljava/lang/String;

    const-string v0, "products"

    sput-object v0, Lcom/glu/android/iap/IAP;->JSON_PROPERTY_PRODUCTS:Ljava/lang/String;

    const-string v0, "product"

    sput-object v0, Lcom/glu/android/iap/IAP;->JSON_PROPERTY_PRODUCTS_PRODUCT:Ljava/lang/String;

    const-string v0, "price_us"

    sput-object v0, Lcom/glu/android/iap/IAP;->JSON_PROPERTY_PRODUCTS_PRICE:Ljava/lang/String;

    const-string v0, "name"

    sput-object v0, Lcom/glu/android/iap/IAP;->JSON_PROPERTY_PRODUCTS_NAME:Ljava/lang/String;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static createIAPInstance()V
    .locals 2

    const/4 v1, 0x0

    sput-object v1, Lcom/glu/android/iap/IAP;->instance:Lcom/glu/android/iap/IAP$IAPObject;

    const/4 v0, -0x1

    sput v0, Lcom/glu/android/iap/IAP;->sm_transactionState:I

    invoke-static {}, Lcom/glu/android/iap/Debug;->log$552c4e01()V

    new-instance v0, Lcom/glu/android/iap/GluGoogleIAP;

    invoke-direct {v0, v1}, Lcom/glu/android/iap/GluGoogleIAP;-><init>(Lcom/glu/android/iap/IAP;)V

    sput-object v0, Lcom/glu/android/iap/IAP;->instance:Lcom/glu/android/iap/IAP$IAPObject;

    sget-object v0, Lcom/glu/android/iap/IAP;->IAP_PROVIDER_MASKS:Ljava/util/Hashtable;

    invoke-virtual {v0}, Ljava/util/Hashtable;->keys()Ljava/util/Enumeration;

    move-result-object v1

    :goto_0
    invoke-interface {v1}, Ljava/util/Enumeration;->hasMoreElements()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-interface {v1}, Ljava/util/Enumeration;->nextElement()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    invoke-static {v0}, Lcom/glu/android/iap/IAP;->initSingleProduct(Ljava/lang/String;)V

    goto :goto_0

    :cond_0
    return-void
.end method

.method public static destroyIAPInstance()V
    .locals 2

    const/4 v1, 0x0

    const/4 v0, -0x1

    sput v0, Lcom/glu/android/iap/IAP;->sm_transactionState:I

    sget-object v0, Lcom/glu/android/iap/IAP;->instance:Lcom/glu/android/iap/IAP$IAPObject;

    if-eqz v0, :cond_0

    sget-object v0, Lcom/glu/android/iap/IAP;->instance:Lcom/glu/android/iap/IAP$IAPObject;

    invoke-interface {v0}, Lcom/glu/android/iap/IAP$IAPObject;->onIAPDestroy()V

    :cond_0
    sput-object v1, Lcom/glu/android/iap/IAP;->instance:Lcom/glu/android/iap/IAP$IAPObject;

    sput-object v1, Lcom/glu/android/iap/GluGoogleIAP;->instance:Lcom/glu/android/iap/GluGoogleIAP;

    sput-object v1, Lcom/glu/android/iap/IAP;->m_getDataFromServerThread:Ljava/lang/Thread;

    return-void
.end method

.method public static displayAsyncFailureMessage()V
    .locals 0

    return-void
.end method

.method public static displayAsyncSuccessMessage()V
    .locals 0

    return-void
.end method

.method public static doesIAPHaveButton()Z
    .locals 1

    const/4 v0, 0x0

    return v0
.end method

.method public static eventToString(I)Ljava/lang/String;
    .locals 2

    sparse-switch p0, :sswitch_data_0

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "UNKNOWN ("

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ")"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    :goto_0
    return-object v0

    :sswitch_0
    const-string v0, "IAP_EVENT_IS_IAP_SUPPORTED"

    goto :goto_0

    :sswitch_1
    const-string v0, "IAP_EVENT_BUY_PRODUCT"

    goto :goto_0

    :sswitch_2
    const-string v0, "IAP_EVENT_RESTORE_UNCLAIMED_ITEMS"

    goto :goto_0

    :sswitch_3
    const-string v0, "IAP_EVENT_INIT"

    goto :goto_0

    :sswitch_4
    const-string v0, "IAP_EVENT_INIT_PUBLIC_KEY"

    goto :goto_0

    :sswitch_5
    const-string v0, "IAP_EVENT_GET_TRANSACTION_STATE"

    goto :goto_0

    :sswitch_6
    const-string v0, "IAP_EVENT_TICK"

    goto :goto_0

    :sswitch_7
    const-string v0, "IAP_EVENT_GET_PRODUCT_TYPE"

    goto :goto_0

    :sswitch_8
    const-string v0, "IAP_EVENT_IS_PRODUCT_VALID"

    goto :goto_0

    :sswitch_9
    const-string v0, "IAP_EVENT_DOES_IAP_HAVE_BUTTON"

    goto :goto_0

    :sswitch_a
    const-string v0, "IAP_EVENT_SET_BUTTON_CENTER_XY"

    goto :goto_0

    :sswitch_b
    const-string v0, "IAP_EVENT_SET_BUTTON_VISIBLE"

    goto :goto_0

    :sswitch_c
    const-string v0, "IAP_EVENT_IS_IAP_CONNECTED"

    goto :goto_0

    :sswitch_d
    const-string v0, "IAP_EVENT_QUERY_SINGLE_PRODUCT"

    goto :goto_0

    :sswitch_e
    const-string v0, "IAP_EVENT_IS_ITEM_SUPPORTED"

    goto :goto_0

    :sswitch_f
    const-string v0, "IAP_EVENT_REQUEST_ITEM_REAL_PRODUCT_ID"

    goto :goto_0

    :sswitch_10
    const-string v0, "IAP_EVENT_REQUEST_ITEM_PRODUCT_NAME"

    goto :goto_0

    :sswitch_11
    const-string v0, "IAP_EVENT_REQUEST_ITEM_PRODUCT_DESCRIPTION"

    goto :goto_0

    :sswitch_12
    const-string v0, "IAP_EVENT_REQUEST_ITEM_PRODUCT_PRICE"

    goto :goto_0

    :sswitch_13
    const-string v0, "IAP_EVENT_REQUEST_ITEM_CURRENCY_SYMBOL"

    goto :goto_0

    :sswitch_14
    const-string v0, "IAP_EVENT_REQUEST_PRODUCT_DATA"

    goto :goto_0

    :sswitch_15
    const-string v0, "IAP_EVENT_IS_SUBS_SUPPORTED"

    goto :goto_0

    nop

    :sswitch_data_0
    .sparse-switch
        0x1 -> :sswitch_0
        0x2 -> :sswitch_1
        0x3 -> :sswitch_2
        0x4 -> :sswitch_3
        0x5 -> :sswitch_5
        0x6 -> :sswitch_6
        0x7 -> :sswitch_7
        0x8 -> :sswitch_8
        0x9 -> :sswitch_9
        0xa -> :sswitch_a
        0xb -> :sswitch_b
        0xc -> :sswitch_c
        0xd -> :sswitch_d
        0xe -> :sswitch_e
        0x12 -> :sswitch_14
        0x13 -> :sswitch_4
        0x14 -> :sswitch_15
        0x65 -> :sswitch_f
        0x66 -> :sswitch_10
        0x67 -> :sswitch_11
        0x68 -> :sswitch_12
        0x69 -> :sswitch_13
    .end sparse-switch
.end method

.method public static final getCurrencySymbol$7157d249()Ljava/lang/String;
    .locals 1

    const-string v0, "$"

    return-object v0
.end method

.method public static getTransactionState()I
    .locals 1

    sget v0, Lcom/glu/android/iap/IAP;->sm_transactionState:I

    return v0
.end method

.method public static hasInventoryLoaded()Z
    .locals 1

    sget-object v0, Lcom/glu/android/iap/IAP;->instance:Lcom/glu/android/iap/IAP$IAPObject;

    if-nez v0, :cond_0

    const/4 v0, 0x0

    :goto_0
    return v0

    :cond_0
    sget-object v0, Lcom/glu/android/iap/IAP;->instance:Lcom/glu/android/iap/IAP$IAPObject;

    invoke-interface {v0}, Lcom/glu/android/iap/IAP$IAPObject;->hasInventoryLoaded()Z

    move-result v0

    goto :goto_0
.end method

.method public static initSingleProduct(Ljava/lang/String;)V
    .locals 3

    sget-object v0, Lcom/glu/android/iap/IAP;->instance:Lcom/glu/android/iap/IAP$IAPObject;

    invoke-interface {v0, p0}, Lcom/glu/android/iap/IAP$IAPObject;->getRealProductId(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    sget-object v1, Lcom/glu/android/iap/IAP;->m_realToNativeProductIdHash:Ljava/util/Hashtable;

    invoke-virtual {v1, v0, p0}, Ljava/util/Hashtable;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "added... "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " / "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    sget-object v2, Lcom/glu/android/iap/IAP;->m_realToNativeProductIdHash:Ljava/util/Hashtable;

    invoke-virtual {v2, v0}, Ljava/util/Hashtable;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " ...to hash"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    invoke-static {}, Lcom/glu/android/iap/Debug;->log$552c4e01()V

    return-void
.end method

.method public static isGoogleServiceConnected()Z
    .locals 1

    sget-object v0, Lcom/glu/android/iap/IAP;->instance:Lcom/glu/android/iap/IAP$IAPObject;

    if-eqz v0, :cond_0

    sget-object v0, Lcom/glu/android/iap/IAP;->instance:Lcom/glu/android/iap/IAP$IAPObject;

    invoke-interface {v0}, Lcom/glu/android/iap/IAP$IAPObject;->isGoogleServiceConnected()Z

    move-result v0

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public static isIAPSupported()Z
    .locals 1

    sget-object v0, Lcom/glu/android/iap/IAP;->instance:Lcom/glu/android/iap/IAP$IAPObject;

    if-nez v0, :cond_0

    const/4 v0, 0x0

    :goto_0
    return v0

    :cond_0
    sget-object v0, Lcom/glu/android/iap/IAP;->instance:Lcom/glu/android/iap/IAP$IAPObject;

    invoke-interface {v0}, Lcom/glu/android/iap/IAP$IAPObject;->isIAPSupported()Z

    move-result v0

    goto :goto_0
.end method

.method public static isSubscriptionSupported()Z
    .locals 1

    sget-object v0, Lcom/glu/android/iap/IAP;->instance:Lcom/glu/android/iap/IAP$IAPObject;

    if-nez v0, :cond_0

    const/4 v0, 0x0

    :goto_0
    return v0

    :cond_0
    sget-object v0, Lcom/glu/android/iap/IAP;->instance:Lcom/glu/android/iap/IAP$IAPObject;

    invoke-interface {v0}, Lcom/glu/android/iap/IAP$IAPObject;->isSubscriptionSupported()Z

    move-result v0

    goto :goto_0
.end method

.method public static nativeIsItemSupported(Ljava/lang/String;)Z
    .locals 7

    const/4 v1, 0x0

    sget-object v2, Lcom/glu/android/iap/IAP;->instance:Lcom/glu/android/iap/IAP$IAPObject;

    if-nez p0, :cond_1

    move v0, v1

    :cond_0
    :goto_0
    return v0

    :cond_1
    sget-object v0, Lcom/glu/android/iap/IAP;->IAP_PROVIDER_MASKS:Ljava/util/Hashtable;

    invoke-virtual {v0, p0}, Ljava/util/Hashtable;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Long;

    if-eqz v0, :cond_2

    if-nez v2, :cond_3

    :cond_2
    move v0, v1

    goto :goto_0

    :cond_3
    invoke-interface {v2}, Lcom/glu/android/iap/IAP$IAPObject;->getIAPId()I

    move-result v3

    int-to-long v3, v3

    invoke-virtual {v0}, Ljava/lang/Long;->longValue()J

    move-result-wide v5

    and-long/2addr v3, v5

    const-wide/16 v5, 0x0

    cmp-long v0, v3, v5

    if-eqz v0, :cond_4

    const/4 v0, 0x1

    :goto_1
    if-eqz v0, :cond_0

    invoke-interface {v2, p0}, Lcom/glu/android/iap/IAP$IAPObject;->isItemAvailable(Ljava/lang/String;)Z

    move-result v0

    goto :goto_0

    :cond_4
    move v0, v1

    goto :goto_1
.end method
