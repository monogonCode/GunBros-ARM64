.class public Lcom/glu/android/iap/IAPJava;
.super Ljava/lang/Object;


# static fields
.field public static final ANDROID_OS_1_0:I = 0x1

.field public static final ANDROID_OS_1_1:I = 0x2

.field public static final ANDROID_OS_1_5:I = 0x3

.field public static final ANDROID_OS_1_6:I = 0x4

.field public static final ANDROID_OS_2_0:I = 0x5

.field public static final ANDROID_OS_2_0_1:I = 0x6

.field public static final ANDROID_OS_2_1:I = 0x7

.field public static final ANDROID_OS_2_2:I = 0x8

.field public static final ANDROID_OS_2_3:I = 0x9

.field public static final ANDROID_OS_2_3_3:I = 0xa

.field public static final ANDROID_OS_3_0:I = 0xb

.field public static final ANDROID_OS_3_1:I = 0xc

.field public static m_activity:Landroid/app/Activity;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static native iapCallbackEvent(II[B)I
.end method

.method public static iapCallbackEventS(IILjava/lang/String;)I
    .locals 5

    const/4 v1, 0x0

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "iapCallbackEvent - "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v2, ", param - "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    invoke-static {}, Lcom/glu/android/iap/Debug;->log$552c4e01()V

    if-eqz p2, :cond_1

    invoke-virtual {p2}, Ljava/lang/String;->toCharArray()[C

    move-result-object v2

    array-length v0, v2

    add-int/lit8 v0, v0, 0x1

    new-array v3, v0, [B

    move v0, v1

    :goto_0
    array-length v4, v2

    if-ge v0, v4, :cond_0

    aget-char v4, v2, v0

    int-to-byte v4, v4

    aput-byte v4, v3, v0

    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_0
    array-length v0, v2

    aput-byte v1, v3, v0

    invoke-static {p0, p1, v3}, Lcom/glu/android/iap/IAPJava;->iapCallbackEvent(II[B)I

    move-result v0

    :goto_1
    return v0

    :cond_1
    const/4 v0, 0x0

    invoke-static {p0, p1, v0}, Lcom/glu/android/iap/IAPJava;->iapCallbackEvent(II[B)I

    move-result v0

    goto :goto_1
.end method

.method public static iapDestroy()V
    .locals 0

    invoke-static {}, Lcom/glu/android/iap/IAP;->destroyIAPInstance()V

    return-void
.end method

.method public static iapEvent(II[B)I
    .locals 8

    const/16 v7, 0x11

    const/4 v6, 0x6

    const/4 v5, 0x4

    const/4 v0, 0x1

    const/4 v1, 0x0

    const/4 v2, 0x0

    if-eqz p2, :cond_0

    new-instance v2, Ljava/lang/String;

    invoke-direct {v2, p2}, Ljava/lang/String;-><init>([B)V

    invoke-virtual {v2}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v2

    :cond_0
    if-eq p0, v6, :cond_1

    if-eq p0, v7, :cond_1

    if-eq p0, v0, :cond_1

    const/16 v3, 0x14

    if-eq p0, v3, :cond_1

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Entering IAPJava.iapEvent("

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-static {p0}, Lcom/glu/android/iap/IAP;->eventToString(I)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, ", "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, ", "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, ") m_activity - "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    sget-object v4, Lcom/glu/android/iap/IAPJava;->m_activity:Landroid/app/Activity;

    invoke-virtual {v4}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    invoke-static {}, Lcom/glu/android/iap/Debug;->log$552c4e01()V

    :cond_1
    if-ne p0, v0, :cond_4

    invoke-static {}, Lcom/glu/android/iap/IAP;->isIAPSupported()Z

    move-result v2

    if-eqz v2, :cond_3

    :cond_2
    :goto_0
    return v0

    :cond_3
    move v0, v1

    goto :goto_0

    :cond_4
    const/16 v3, 0x14

    if-ne p0, v3, :cond_5

    invoke-static {}, Lcom/glu/android/iap/IAP;->isSubscriptionSupported()Z

    move-result v2

    if-nez v2, :cond_2

    move v0, v1

    goto :goto_0

    :cond_5
    const/16 v3, 0x12

    if-eq p0, v3, :cond_8

    sget-object v3, Lcom/glu/android/iap/IAP;->instance:Lcom/glu/android/iap/IAP$IAPObject;

    if-nez v3, :cond_7

    if-ne p0, v5, :cond_6

    invoke-static {}, Lcom/glu/android/iap/IAP;->createIAPInstance()V

    sget-object v0, Lcom/glu/android/iap/IAP;->instance:Lcom/glu/android/iap/IAP$IAPObject;

    invoke-interface {v0}, Lcom/glu/android/iap/IAP$IAPObject;->init()V

    :cond_6
    move v0, v1

    goto :goto_0

    :cond_7
    const/4 v3, 0x2

    if-ne p0, v3, :cond_9

    sget-object v0, Lcom/glu/android/iap/IAP;->instance:Lcom/glu/android/iap/IAP$IAPObject;

    invoke-interface {v0, v2}, Lcom/glu/android/iap/IAP$IAPObject;->buyProduct(Ljava/lang/String;)V

    :cond_8
    :goto_1
    move v0, v1

    goto :goto_0

    :cond_9
    const/4 v3, 0x3

    if-ne p0, v3, :cond_a

    sget-object v0, Lcom/glu/android/iap/IAP;->instance:Lcom/glu/android/iap/IAP$IAPObject;

    invoke-interface {v0}, Lcom/glu/android/iap/IAP$IAPObject;->restoreUnclaimedItems()V

    goto :goto_1

    :cond_a
    if-ne p0, v5, :cond_b

    invoke-static {}, Lcom/glu/android/iap/IAP;->createIAPInstance()V

    sget-object v0, Lcom/glu/android/iap/IAP;->instance:Lcom/glu/android/iap/IAP$IAPObject;

    invoke-interface {v0}, Lcom/glu/android/iap/IAP$IAPObject;->init()V

    goto :goto_1

    :cond_b
    const/4 v3, 0x5

    if-ne p0, v3, :cond_c

    invoke-static {}, Lcom/glu/android/iap/IAP;->getTransactionState()I

    move-result v0

    goto :goto_0

    :cond_c
    if-ne p0, v6, :cond_d

    sget-object v0, Lcom/glu/android/iap/IAP;->instance:Lcom/glu/android/iap/IAP$IAPObject;

    invoke-interface {v0, p1}, Lcom/glu/android/iap/IAP$IAPObject;->tick(I)V

    goto :goto_1

    :cond_d
    const/4 v3, 0x7

    if-ne p0, v3, :cond_e

    sget-object v0, Lcom/glu/android/iap/IAP;->instance:Lcom/glu/android/iap/IAP$IAPObject;

    invoke-interface {v0, v2}, Lcom/glu/android/iap/IAP$IAPObject;->getProductType(Ljava/lang/String;)I

    move-result v0

    goto :goto_0

    :cond_e
    const/16 v3, 0x8

    if-ne p0, v3, :cond_f

    sget-object v3, Lcom/glu/android/iap/IAP;->instance:Lcom/glu/android/iap/IAP$IAPObject;

    invoke-interface {v3, v2}, Lcom/glu/android/iap/IAP$IAPObject;->isProductValid(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_2

    move v0, v1

    goto :goto_0

    :cond_f
    const/16 v3, 0x9

    if-ne p0, v3, :cond_10

    invoke-static {}, Lcom/glu/android/iap/IAP;->doesIAPHaveButton()Z

    move v0, v1

    goto :goto_0

    :cond_10
    const/16 v3, 0xa

    if-ne p0, v3, :cond_11

    sget-object v0, Lcom/glu/android/iap/IAP;->instance:Lcom/glu/android/iap/IAP$IAPObject;

    invoke-interface {v0, p1}, Lcom/glu/android/iap/IAP$IAPObject;->setButtonCenterXY(I)V

    goto :goto_1

    :cond_11
    const/16 v3, 0xb

    if-ne p0, v3, :cond_12

    sget-object v0, Lcom/glu/android/iap/IAP;->instance:Lcom/glu/android/iap/IAP$IAPObject;

    invoke-interface {v0, p1}, Lcom/glu/android/iap/IAP$IAPObject;->setButtonVisible(I)V

    goto :goto_1

    :cond_12
    const/16 v3, 0xc

    if-ne p0, v3, :cond_13

    sget-object v2, Lcom/glu/android/iap/IAP;->instance:Lcom/glu/android/iap/IAP$IAPObject;

    invoke-interface {v2}, Lcom/glu/android/iap/IAP$IAPObject;->isIAPConnected()Z

    move-result v2

    if-nez v2, :cond_2

    move v0, v1

    goto/16 :goto_0

    :cond_13
    const/16 v3, 0xd

    if-ne p0, v3, :cond_14

    sget-object v0, Lcom/glu/android/iap/IAP;->instance:Lcom/glu/android/iap/IAP$IAPObject;

    invoke-interface {v0, v2}, Lcom/glu/android/iap/IAP$IAPObject;->querySingleProduct(Ljava/lang/String;)V

    goto :goto_1

    :cond_14
    const/16 v3, 0xe

    if-ne p0, v3, :cond_15

    invoke-static {v2}, Lcom/glu/android/iap/IAP;->nativeIsItemSupported(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_2

    move v0, v1

    goto/16 :goto_0

    :cond_15
    const/16 v3, 0xf

    if-ne p0, v3, :cond_16

    invoke-static {}, Lcom/glu/android/iap/IAP;->hasInventoryLoaded()Z

    move-result v2

    if-nez v2, :cond_2

    move v0, v1

    goto/16 :goto_0

    :cond_16
    const/16 v3, 0x10

    if-ne p0, v3, :cond_17

    invoke-static {}, Lcom/glu/android/iap/IAP;->isGoogleServiceConnected()Z

    move-result v2

    if-nez v2, :cond_2

    move v0, v1

    goto/16 :goto_0

    :cond_17
    if-ne p0, v7, :cond_18

    sget-object v0, Lcom/glu/android/iap/IAP;->instance:Lcom/glu/android/iap/IAP$IAPObject;

    invoke-interface {v0}, Lcom/glu/android/iap/IAP$IAPObject;->forceAsynchronousPurchaseAward()Z

    goto/16 :goto_1

    :cond_18
    const/16 v0, 0x13

    if-ne p0, v0, :cond_8

    sput-object v2, Lcom/glu/googleiap/Security;->BASE64_ENCODED_PUBLIC_KEY:Ljava/lang/String;

    goto/16 :goto_1
.end method
