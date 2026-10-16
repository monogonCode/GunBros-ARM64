.class public final Lcom/urbanairship/iap/IAPManager;
.super Ljava/lang/Object;


# static fields
.field private static final instance:Lcom/urbanairship/iap/IAPManager;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/urbanairship/iap/IAPManager;

    invoke-direct {v0}, Lcom/urbanairship/iap/IAPManager;-><init>()V

    sput-object v0, Lcom/urbanairship/iap/IAPManager;->instance:Lcom/urbanairship/iap/IAPManager;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static init()V
    .locals 0

    return-void
.end method

.method public static shared()Lcom/urbanairship/iap/IAPManager;
    .locals 1

    sget-object v0, Lcom/urbanairship/iap/IAPManager;->instance:Lcom/urbanairship/iap/IAPManager;

    return-object v0
.end method

.method public static tearDown()V
    .locals 0

    return-void
.end method

.method public static validateManifest()V
    .locals 0

    return-void
.end method
