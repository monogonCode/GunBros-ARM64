.class public Lcom/glu/platform/gwallet/GWallet;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/glu/platform/gwallet/GWallet$InstanceHolder;
    }
.end annotation


# direct methods
.method static constructor <clinit>()V
    .locals 1

    :try_start_0
    const-string v0, "gwallet"

    invoke-static {v0}, Ljava/lang/System;->loadLibrary(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/UnsatisfiedLinkError; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return-void

    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method synthetic constructor <init>()V
    .locals 1

    const/4 v0, 0x0

    invoke-direct {p0, v0}, Lcom/glu/platform/gwallet/GWallet;-><init>(B)V

    return-void
.end method

.method private constructor <init>(B)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private native addCurrency(I)I
.end method

.method private native create([BLjava/lang/Object;)I
.end method

.method private native destroy(I)V
.end method

.method private native getBalance()I
.end method

.method public static getInstance()Lcom/glu/platform/gwallet/GWallet;
    .locals 1

    sget-object v0, Lcom/glu/platform/gwallet/GWallet$InstanceHolder;->instance:Lcom/glu/platform/gwallet/GWallet;

    return-object v0
.end method

.method private native handleupdate(Landroid/content/Context;J)V
.end method

.method private native initialise(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
.end method

.method private native pause(I)V
.end method

.method private native restart(I)V
.end method

.method private native resume(I)V
.end method

.method private native start(I)V
.end method

.method private native stop(I)V
.end method

.method private native subscribeWithReceipt(Ljava/lang/String;Ljava/lang/Object;)I
.end method

.method private native subtractCurrency(I)I
.end method

.method private native uninitialise()V
.end method


# virtual methods
.method public doAddCurrency(I)I
    .locals 1

    invoke-direct {p0, p1}, Lcom/glu/platform/gwallet/GWallet;->addCurrency(I)I

    move-result v0

    return v0
.end method

.method public doGetBalance()I
    .locals 1

    invoke-direct {p0}, Lcom/glu/platform/gwallet/GWallet;->getBalance()I

    move-result v0

    return v0
.end method

.method public doSubscribe(Ljava/lang/String;Ljava/lang/Object;)I
    .locals 1

    invoke-direct {p0, p1, p2}, Lcom/glu/platform/gwallet/GWallet;->subscribeWithReceipt(Ljava/lang/String;Ljava/lang/Object;)I

    move-result v0

    return v0
.end method

.method public doSubtractCurrency(I)I
    .locals 1

    invoke-direct {p0, p1}, Lcom/glu/platform/gwallet/GWallet;->subtractCurrency(I)I

    move-result v0

    return v0
.end method

.method public onCreate([BLjava/lang/Object;)I
    .locals 1

    invoke-direct {p0, p1, p2}, Lcom/glu/platform/gwallet/GWallet;->create([BLjava/lang/Object;)I

    move-result v0

    return v0
.end method

.method public onDestroy(I)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/glu/platform/gwallet/GWallet;->destroy(I)V

    return-void
.end method

.method public onHandleUpdate(Landroid/content/Context;J)V
    .locals 0

    invoke-direct {p0, p1, p2, p3}, Lcom/glu/platform/gwallet/GWallet;->handleupdate(Landroid/content/Context;J)V

    return-void
.end method

.method public onInitialise(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 0

    invoke-direct/range {p0 .. p5}, Lcom/glu/platform/gwallet/GWallet;->initialise(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method public onPause(I)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/glu/platform/gwallet/GWallet;->pause(I)V

    return-void
.end method

.method public onResume(I)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/glu/platform/gwallet/GWallet;->resume(I)V

    return-void
.end method

.method public onStart(I)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/glu/platform/gwallet/GWallet;->start(I)V

    return-void
.end method

.method public onStop(I)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/glu/platform/gwallet/GWallet;->stop(I)V

    return-void
.end method

.method public onUninitialise()V
    .locals 0

    invoke-direct {p0}, Lcom/glu/platform/gwallet/GWallet;->uninitialise()V

    return-void
.end method
