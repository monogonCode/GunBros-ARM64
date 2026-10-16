.class public final Lcom/glu/googleiap/Security$VerifiedPurchase;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/glu/googleiap/Security;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "VerifiedPurchase"
.end annotation


# instance fields
.field public developerPayload:Ljava/lang/String;

.field public notificationId:Ljava/lang/String;

.field public orderId:Ljava/lang/String;

.field public productId:Ljava/lang/String;

.field public purchaseState:Lcom/glu/googleiap/Consts$PurchaseState;

.field public purchaseTime:J


# direct methods
.method public constructor <init>(Lcom/glu/googleiap/Consts$PurchaseState;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;JLjava/lang/String;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/glu/googleiap/Security$VerifiedPurchase;->purchaseState:Lcom/glu/googleiap/Consts$PurchaseState;

    iput-object p2, p0, Lcom/glu/googleiap/Security$VerifiedPurchase;->notificationId:Ljava/lang/String;

    iput-object p3, p0, Lcom/glu/googleiap/Security$VerifiedPurchase;->productId:Ljava/lang/String;

    iput-object p4, p0, Lcom/glu/googleiap/Security$VerifiedPurchase;->orderId:Ljava/lang/String;

    iput-wide p5, p0, Lcom/glu/googleiap/Security$VerifiedPurchase;->purchaseTime:J

    iput-object p7, p0, Lcom/glu/googleiap/Security$VerifiedPurchase;->developerPayload:Ljava/lang/String;

    return-void
.end method
