.class public final enum Lcom/glu/googleiap/Consts$PurchaseState;
.super Ljava/lang/Enum;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/glu/googleiap/Consts;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x4019
    name = "PurchaseState"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum",
        "<",
        "Lcom/glu/googleiap/Consts$PurchaseState;",
        ">;"
    }
.end annotation


# static fields
.field private static final synthetic $VALUES:[Lcom/glu/googleiap/Consts$PurchaseState;

.field public static final enum CANCELED:Lcom/glu/googleiap/Consts$PurchaseState;

.field public static final enum PURCHASED:Lcom/glu/googleiap/Consts$PurchaseState;

.field public static final enum REFUNDED:Lcom/glu/googleiap/Consts$PurchaseState;


# direct methods
.method static constructor <clinit>()V
    .locals 5

    const/4 v4, 0x2

    const/4 v3, 0x1

    const/4 v2, 0x0

    new-instance v0, Lcom/glu/googleiap/Consts$PurchaseState;

    const-string v1, "PURCHASED"

    invoke-direct {v0, v1, v2}, Lcom/glu/googleiap/Consts$PurchaseState;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/glu/googleiap/Consts$PurchaseState;->PURCHASED:Lcom/glu/googleiap/Consts$PurchaseState;

    new-instance v0, Lcom/glu/googleiap/Consts$PurchaseState;

    const-string v1, "CANCELED"

    invoke-direct {v0, v1, v3}, Lcom/glu/googleiap/Consts$PurchaseState;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/glu/googleiap/Consts$PurchaseState;->CANCELED:Lcom/glu/googleiap/Consts$PurchaseState;

    new-instance v0, Lcom/glu/googleiap/Consts$PurchaseState;

    const-string v1, "REFUNDED"

    invoke-direct {v0, v1, v4}, Lcom/glu/googleiap/Consts$PurchaseState;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/glu/googleiap/Consts$PurchaseState;->REFUNDED:Lcom/glu/googleiap/Consts$PurchaseState;

    const/4 v0, 0x3

    new-array v0, v0, [Lcom/glu/googleiap/Consts$PurchaseState;

    sget-object v1, Lcom/glu/googleiap/Consts$PurchaseState;->PURCHASED:Lcom/glu/googleiap/Consts$PurchaseState;

    aput-object v1, v0, v2

    sget-object v1, Lcom/glu/googleiap/Consts$PurchaseState;->CANCELED:Lcom/glu/googleiap/Consts$PurchaseState;

    aput-object v1, v0, v3

    sget-object v1, Lcom/glu/googleiap/Consts$PurchaseState;->REFUNDED:Lcom/glu/googleiap/Consts$PurchaseState;

    aput-object v1, v0, v4

    sput-object v0, Lcom/glu/googleiap/Consts$PurchaseState;->$VALUES:[Lcom/glu/googleiap/Consts$PurchaseState;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;I)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    return-void
.end method

.method public static valueOf(I)Lcom/glu/googleiap/Consts$PurchaseState;
    .locals 2

    invoke-static {}, Lcom/glu/googleiap/Consts$PurchaseState;->values()[Lcom/glu/googleiap/Consts$PurchaseState;

    move-result-object v0

    if-ltz p0, :cond_0

    array-length v1, v0

    if-lt p0, v1, :cond_1

    :cond_0
    sget-object v0, Lcom/glu/googleiap/Consts$PurchaseState;->CANCELED:Lcom/glu/googleiap/Consts$PurchaseState;

    :goto_0
    return-object v0

    :cond_1
    aget-object v0, v0, p0

    goto :goto_0
.end method

.method public static valueOf(Ljava/lang/String;)Lcom/glu/googleiap/Consts$PurchaseState;
    .locals 1

    const-class v0, Lcom/glu/googleiap/Consts$PurchaseState;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object v0

    check-cast v0, Lcom/glu/googleiap/Consts$PurchaseState;

    return-object v0
.end method

.method public static values()[Lcom/glu/googleiap/Consts$PurchaseState;
    .locals 1

    sget-object v0, Lcom/glu/googleiap/Consts$PurchaseState;->$VALUES:[Lcom/glu/googleiap/Consts$PurchaseState;

    invoke-virtual {v0}, [Lcom/glu/googleiap/Consts$PurchaseState;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/glu/googleiap/Consts$PurchaseState;

    return-object v0
.end method
