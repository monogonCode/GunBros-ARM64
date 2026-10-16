.class public Lcom/tapjoy/TapjoyDisplayMetricsUtil;
.super Ljava/lang/Object;


# instance fields
.field private configuration:Landroid/content/res/Configuration;

.field private context:Landroid/content/Context;

.field private metrics:Landroid/util/DisplayMetrics;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 2

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/tapjoy/TapjoyDisplayMetricsUtil;->context:Landroid/content/Context;

    new-instance v0, Landroid/util/DisplayMetrics;

    invoke-direct {v0}, Landroid/util/DisplayMetrics;-><init>()V

    iput-object v0, p0, Lcom/tapjoy/TapjoyDisplayMetricsUtil;->metrics:Landroid/util/DisplayMetrics;

    iget-object v0, p0, Lcom/tapjoy/TapjoyDisplayMetricsUtil;->context:Landroid/content/Context;

    const-string v1, "window"

    invoke-virtual {v0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/view/WindowManager;

    invoke-interface {v0}, Landroid/view/WindowManager;->getDefaultDisplay()Landroid/view/Display;

    move-result-object v0

    iget-object v1, p0, Lcom/tapjoy/TapjoyDisplayMetricsUtil;->metrics:Landroid/util/DisplayMetrics;

    invoke-virtual {v0, v1}, Landroid/view/Display;->getMetrics(Landroid/util/DisplayMetrics;)V

    iget-object v0, p0, Lcom/tapjoy/TapjoyDisplayMetricsUtil;->context:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getConfiguration()Landroid/content/res/Configuration;

    move-result-object v0

    iput-object v0, p0, Lcom/tapjoy/TapjoyDisplayMetricsUtil;->configuration:Landroid/content/res/Configuration;

    return-void
.end method


# virtual methods
.method public getScreenDensity()I
    .locals 1

    iget-object v0, p0, Lcom/tapjoy/TapjoyDisplayMetricsUtil;->metrics:Landroid/util/DisplayMetrics;

    iget v0, v0, Landroid/util/DisplayMetrics;->densityDpi:I

    return v0
.end method

.method public getScreenLayoutSize()I
    .locals 1

    iget-object v0, p0, Lcom/tapjoy/TapjoyDisplayMetricsUtil;->configuration:Landroid/content/res/Configuration;

    iget v0, v0, Landroid/content/res/Configuration;->screenLayout:I

    and-int/lit8 v0, v0, 0xf

    return v0
.end method
