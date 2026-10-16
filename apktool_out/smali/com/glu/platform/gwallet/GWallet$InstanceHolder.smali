.class final Lcom/glu/platform/gwallet/GWallet$InstanceHolder;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/glu/platform/gwallet/GWallet;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "InstanceHolder"
.end annotation


# static fields
.field public static instance:Lcom/glu/platform/gwallet/GWallet;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/glu/platform/gwallet/GWallet;

    invoke-direct {v0}, Lcom/glu/platform/gwallet/GWallet;-><init>()V

    sput-object v0, Lcom/glu/platform/gwallet/GWallet$InstanceHolder;->instance:Lcom/glu/platform/gwallet/GWallet;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method
