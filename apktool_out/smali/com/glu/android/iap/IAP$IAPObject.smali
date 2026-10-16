.class public interface abstract Lcom/glu/android/iap/IAP$IAPObject;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/glu/android/iap/IAP;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x609
    name = "IAPObject"
.end annotation


# virtual methods
.method public abstract buyProduct(Ljava/lang/String;)V
.end method

.method public abstract forceAsynchronousPurchaseAward()Z
.end method

.method public abstract getIAPId()I
.end method

.method public abstract getProductType(Ljava/lang/String;)I
.end method

.method public abstract getRealProductId(Ljava/lang/String;)Ljava/lang/String;
.end method

.method public abstract hasInventoryLoaded()Z
.end method

.method public abstract init()V
.end method

.method public abstract isGoogleServiceConnected()Z
.end method

.method public abstract isIAPConnected()Z
.end method

.method public abstract isIAPSupported()Z
.end method

.method public abstract isItemAvailable(Ljava/lang/String;)Z
.end method

.method public abstract isProductValid(Ljava/lang/String;)Z
.end method

.method public abstract isSubscriptionSupported()Z
.end method

.method public abstract onIAPDestroy()V
.end method

.method public abstract querySingleProduct(Ljava/lang/String;)V
.end method

.method public abstract restoreUnclaimedItems()V
.end method

.method public abstract setButtonCenterXY(I)V
.end method

.method public abstract setButtonVisible(I)V
.end method

.method public abstract tick(I)V
.end method
