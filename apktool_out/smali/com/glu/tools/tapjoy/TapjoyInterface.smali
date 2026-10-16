.class public final Lcom/glu/tools/tapjoy/TapjoyInterface;
.super Ljava/lang/Object;

# interfaces
.implements Lcom/tapjoy/TapjoyDisplayAdNotifier;
.implements Lcom/tapjoy/TapjoyFeaturedAppNotifier;
.implements Lcom/tapjoy/TapjoyNotifier;
.implements Lcom/tapjoy/TapjoySpendPointsNotifier;


# static fields
.field private static POINTS_EXCHANGE_RATE:I = 0x0

.field private static final TAPJOY_INTERFACE:Ljava/lang/String; = "TapjoyInterface"

.field private static THIS:Lcom/glu/tools/tapjoy/TapjoyInterface;

.field private static adCount:I

.field private static adCount2:I

.field private static bannerLayout:Landroid/widget/LinearLayout;

.field private static bannerPos:I

.field private static bannerView:Landroid/view/View;

.field private static bannerX:I

.field private static bannerY:I

.field private static featuredAppInfo:Lcom/tapjoy/TapjoyFeaturedAppObject;

.field private static featuredAppQueryInProgress:Z

.field private static isBannerBeingShown:Z

.field private static isBannerRequested:Z

.field private static isRemainingTapjoyPointsBeingGot:Z

.field private static lastTapjoyPointTotal:I

.field private static previousConsumedThisSession:I

.field private static remainingPointTotal:I

.field private static retrySeveralTimes:I

.field private static showFeaturedAppView:Z

.field private static usedActivity:Lcom/glu/platform/android/GluPlatformActivity;


# direct methods
.method static constructor <clinit>()V
    .locals 3

    const/4 v2, 0x0

    const/4 v1, 0x0

    new-instance v0, Lcom/glu/tools/tapjoy/TapjoyInterface;

    invoke-direct {v0}, Lcom/glu/tools/tapjoy/TapjoyInterface;-><init>()V

    sput-object v0, Lcom/glu/tools/tapjoy/TapjoyInterface;->THIS:Lcom/glu/tools/tapjoy/TapjoyInterface;

    sput-object v2, Lcom/glu/tools/tapjoy/TapjoyInterface;->usedActivity:Lcom/glu/platform/android/GluPlatformActivity;

    sput-boolean v1, Lcom/glu/tools/tapjoy/TapjoyInterface;->featuredAppQueryInProgress:Z

    sput-object v2, Lcom/glu/tools/tapjoy/TapjoyInterface;->featuredAppInfo:Lcom/tapjoy/TapjoyFeaturedAppObject;

    sput-boolean v1, Lcom/glu/tools/tapjoy/TapjoyInterface;->showFeaturedAppView:Z

    const/4 v0, 0x1

    sput v0, Lcom/glu/tools/tapjoy/TapjoyInterface;->POINTS_EXCHANGE_RATE:I

    sput v1, Lcom/glu/tools/tapjoy/TapjoyInterface;->remainingPointTotal:I

    sput v1, Lcom/glu/tools/tapjoy/TapjoyInterface;->lastTapjoyPointTotal:I

    sput v1, Lcom/glu/tools/tapjoy/TapjoyInterface;->previousConsumedThisSession:I

    sput-boolean v1, Lcom/glu/tools/tapjoy/TapjoyInterface;->isRemainingTapjoyPointsBeingGot:Z

    sput-boolean v1, Lcom/glu/tools/tapjoy/TapjoyInterface;->isBannerRequested:Z

    sput-boolean v1, Lcom/glu/tools/tapjoy/TapjoyInterface;->isBannerBeingShown:Z

    sput v1, Lcom/glu/tools/tapjoy/TapjoyInterface;->retrySeveralTimes:I

    sput v1, Lcom/glu/tools/tapjoy/TapjoyInterface;->bannerPos:I

    sput v1, Lcom/glu/tools/tapjoy/TapjoyInterface;->bannerX:I

    sput v1, Lcom/glu/tools/tapjoy/TapjoyInterface;->bannerY:I

    sput-object v2, Lcom/glu/tools/tapjoy/TapjoyInterface;->bannerView:Landroid/view/View;

    sput-object v2, Lcom/glu/tools/tapjoy/TapjoyInterface;->bannerLayout:Landroid/widget/LinearLayout;

    sput v1, Lcom/glu/tools/tapjoy/TapjoyInterface;->adCount:I

    sput v1, Lcom/glu/tools/tapjoy/TapjoyInterface;->adCount2:I

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static declared-synchronized TryToHideBanner()V
    .locals 3

    const-class v1, Lcom/glu/tools/tapjoy/TapjoyInterface;

    monitor-enter v1

    :try_start_0
    sget-object v0, Lcom/glu/tools/tapjoy/TapjoyInterface;->bannerLayout:Landroid/widget/LinearLayout;

    if-eqz v0, :cond_0

    sget-object v0, Lcom/glu/tools/tapjoy/TapjoyInterface;->bannerLayout:Landroid/widget/LinearLayout;

    const/4 v2, 0x4

    invoke-virtual {v0, v2}, Landroid/widget/LinearLayout;->setVisibility(I)V

    const-string v0, "TapjoyInterface"

    const-string v2, "Banner has been hidden"

    invoke-static {v0, v2}, Lcom/tapjoy/TapjoyLog;->d(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :cond_0
    monitor-exit v1

    return-void

    :catchall_0
    move-exception v0

    monitor-exit v1

    throw v0
.end method

.method private static declared-synchronized TryToRestoreShownBanner()V
    .locals 3

    const-class v1, Lcom/glu/tools/tapjoy/TapjoyInterface;

    monitor-enter v1

    :try_start_0
    sget-boolean v0, Lcom/glu/tools/tapjoy/TapjoyInterface;->isBannerRequested:Z

    if-eqz v0, :cond_0

    sget-object v0, Lcom/glu/tools/tapjoy/TapjoyInterface;->bannerLayout:Landroid/widget/LinearLayout;

    if-eqz v0, :cond_0

    sget-boolean v0, Lcom/glu/tools/tapjoy/TapjoyInterface;->isBannerBeingShown:Z

    if-nez v0, :cond_0

    sget-object v0, Lcom/glu/tools/tapjoy/TapjoyInterface;->bannerLayout:Landroid/widget/LinearLayout;

    const/4 v2, 0x0

    invoke-virtual {v0, v2}, Landroid/widget/LinearLayout;->setVisibility(I)V

    const/4 v0, 0x1

    sput-boolean v0, Lcom/glu/tools/tapjoy/TapjoyInterface;->isBannerBeingShown:Z

    const-string v0, "TapjoyInterface"

    const-string v2, "Banner has been shown (or rather, restored)"

    invoke-static {v0, v2}, Lcom/tapjoy/TapjoyLog;->d(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :cond_0
    monitor-exit v1

    return-void

    :catchall_0
    move-exception v0

    monitor-exit v1

    throw v0
.end method

.method private static declared-synchronized TryToShowBanner()V
    .locals 15

    const/4 v2, 0x1

    const/4 v1, 0x0

    const-class v13, Lcom/glu/tools/tapjoy/TapjoyInterface;

    monitor-enter v13

    :try_start_0
    sget-boolean v0, Lcom/glu/tools/tapjoy/TapjoyInterface;->isBannerBeingShown:Z

    if-eqz v0, :cond_7

    sget-object v0, Lcom/glu/tools/tapjoy/TapjoyInterface;->bannerView:Landroid/view/View;

    if-eqz v0, :cond_7

    const-string v0, "TapjoyInterface"

    const-string v3, "Display banner"

    invoke-static {v0, v3}, Lcom/tapjoy/TapjoyLog;->d(Ljava/lang/String;Ljava/lang/String;)V

    sget-object v0, Lcom/glu/tools/tapjoy/TapjoyInterface;->bannerView:Landroid/view/View;

    invoke-virtual {v0}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v0

    iget v4, v0, Landroid/view/ViewGroup$LayoutParams;->width:I

    sget-object v0, Lcom/glu/tools/tapjoy/TapjoyInterface;->bannerView:Landroid/view/View;

    invoke-virtual {v0}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v0

    iget v3, v0, Landroid/view/ViewGroup$LayoutParams;->height:I

    const-string v0, "TapjoyInterface"

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "Banner dimensions: "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, " x "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v0, v5}, Lcom/tapjoy/TapjoyLog;->d(Ljava/lang/String;Ljava/lang/String;)V

    sget-object v0, Lcom/glu/tools/tapjoy/TapjoyInterface;->usedActivity:Lcom/glu/platform/android/GluPlatformActivity;

    const-string v5, "window"

    invoke-virtual {v0, v5}, Lcom/glu/platform/android/GluPlatformActivity;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/view/WindowManager;

    invoke-interface {v0}, Landroid/view/WindowManager;->getDefaultDisplay()Landroid/view/Display;

    move-result-object v5

    invoke-virtual {v5}, Landroid/view/Display;->getWidth()I

    move-result v12

    invoke-interface {v0}, Landroid/view/WindowManager;->getDefaultDisplay()Landroid/view/Display;

    move-result-object v0

    invoke-virtual {v0}, Landroid/view/Display;->getHeight()I

    move-result v10

    const-string v0, "TapjoyInterface"

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "Screen dimensions: "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v12}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, " x "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v10}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v0, v5}, Lcom/tapjoy/TapjoyLog;->d(Ljava/lang/String;Ljava/lang/String;)V

    if-le v4, v12, :cond_10

    mul-int v0, v12, v3

    div-int/2addr v0, v4

    move v3, v12

    :goto_0
    if-le v0, v10, :cond_f

    mul-int/2addr v3, v10

    div-int v0, v3, v0

    move v9, v10

    move v11, v0

    :goto_1
    new-instance v0, Landroid/view/ViewGroup$LayoutParams;

    invoke-direct {v0, v11, v9}, Landroid/view/ViewGroup$LayoutParams;-><init>(II)V

    sget-object v3, Lcom/glu/tools/tapjoy/TapjoyInterface;->bannerView:Landroid/view/View;

    invoke-virtual {v3, v0}, Landroid/view/View;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    new-instance v14, Landroid/widget/LinearLayout;

    sget-object v0, Lcom/glu/tools/tapjoy/TapjoyInterface;->usedActivity:Lcom/glu/platform/android/GluPlatformActivity;

    invoke-direct {v14, v0}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    new-instance v0, Landroid/view/ViewGroup$LayoutParams;

    invoke-direct {v0, v12, v10}, Landroid/view/ViewGroup$LayoutParams;-><init>(II)V

    invoke-virtual {v14, v0}, Landroid/widget/LinearLayout;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    const-string v0, "TapjoyInterface"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "bannerPos: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    sget v4, Lcom/glu/tools/tapjoy/TapjoyInterface;->bannerPos:I

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v0, v3}, Lcom/tapjoy/TapjoyLog;->d(Ljava/lang/String;Ljava/lang/String;)V

    sget v0, Lcom/glu/tools/tapjoy/TapjoyInterface;->bannerPos:I

    if-nez v0, :cond_8

    move v8, v2

    :goto_2
    sget v0, Lcom/glu/tools/tapjoy/TapjoyInterface;->bannerPos:I

    and-int/lit8 v0, v0, 0x1

    if-lez v0, :cond_9

    sget v0, Lcom/glu/tools/tapjoy/TapjoyInterface;->bannerPos:I

    and-int/lit8 v0, v0, 0x2

    if-nez v0, :cond_9

    move v7, v2

    :goto_3
    sget v0, Lcom/glu/tools/tapjoy/TapjoyInterface;->bannerPos:I

    and-int/lit8 v0, v0, 0x1

    if-lez v0, :cond_a

    sget v0, Lcom/glu/tools/tapjoy/TapjoyInterface;->bannerPos:I

    and-int/lit8 v0, v0, 0x2

    if-lez v0, :cond_a

    move v6, v2

    :goto_4
    sget v0, Lcom/glu/tools/tapjoy/TapjoyInterface;->bannerPos:I

    and-int/lit8 v0, v0, 0x8

    if-lez v0, :cond_b

    sget v0, Lcom/glu/tools/tapjoy/TapjoyInterface;->bannerPos:I

    and-int/lit8 v0, v0, 0x4

    if-nez v0, :cond_b

    move v5, v2

    :goto_5
    sget v0, Lcom/glu/tools/tapjoy/TapjoyInterface;->bannerPos:I

    and-int/lit8 v0, v0, 0x8

    if-lez v0, :cond_c

    sget v0, Lcom/glu/tools/tapjoy/TapjoyInterface;->bannerPos:I

    and-int/lit8 v0, v0, 0x4

    if-lez v0, :cond_c

    move v4, v2

    :goto_6
    sget v0, Lcom/glu/tools/tapjoy/TapjoyInterface;->bannerPos:I

    and-int/lit8 v0, v0, 0x10

    if-lez v0, :cond_d

    sget v0, Lcom/glu/tools/tapjoy/TapjoyInterface;->bannerPos:I

    and-int/lit8 v0, v0, 0xf

    if-nez v0, :cond_d

    move v3, v2

    :goto_7
    sget v2, Lcom/glu/tools/tapjoy/TapjoyInterface;->bannerX:I

    sget v0, Lcom/glu/tools/tapjoy/TapjoyInterface;->bannerY:I

    if-nez v8, :cond_0

    if-nez v7, :cond_0

    if-nez v6, :cond_0

    if-nez v5, :cond_0

    if-eqz v4, :cond_1

    :cond_0
    sub-int v0, v12, v11

    div-int/lit8 v2, v0, 0x2

    sub-int v0, v10, v9

    div-int/lit8 v0, v0, 0x2

    :cond_1
    if-eqz v7, :cond_2

    if-nez v6, :cond_2

    move v0, v1

    :cond_2
    if-eqz v6, :cond_3

    if-nez v7, :cond_3

    sub-int v0, v10, v9

    move v2, v1

    :cond_3
    if-eqz v5, :cond_4

    if-nez v4, :cond_4

    sub-int v2, v12, v11

    :cond_4
    if-eqz v4, :cond_5

    if-nez v5, :cond_5

    move v2, v1

    :cond_5
    if-eqz v3, :cond_e

    move v0, v1

    :goto_8
    const/4 v2, 0x0

    const/4 v3, 0x0

    invoke-virtual {v14, v1, v0, v2, v3}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    sget-object v0, Lcom/glu/tools/tapjoy/TapjoyInterface;->bannerView:Landroid/view/View;

    invoke-virtual {v14, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    sget-object v0, Lcom/glu/tools/tapjoy/TapjoyInterface;->bannerLayout:Landroid/widget/LinearLayout;

    if-eqz v0, :cond_6

    sget-object v0, Lcom/glu/tools/tapjoy/TapjoyInterface;->bannerLayout:Landroid/widget/LinearLayout;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setVisibility(I)V

    const/4 v0, 0x0

    sput-object v0, Lcom/glu/tools/tapjoy/TapjoyInterface;->bannerLayout:Landroid/widget/LinearLayout;

    :cond_6
    sput-object v14, Lcom/glu/tools/tapjoy/TapjoyInterface;->bannerLayout:Landroid/widget/LinearLayout;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    :try_start_1
    sget-object v0, Lcom/glu/tools/tapjoy/TapjoyInterface;->usedActivity:Lcom/glu/platform/android/GluPlatformActivity;

    invoke-virtual {v0}, Lcom/glu/platform/android/GluPlatformActivity;->getWindow()Landroid/view/Window;

    move-result-object v0

    sget-object v1, Lcom/glu/tools/tapjoy/TapjoyInterface;->bannerLayout:Landroid/widget/LinearLayout;

    new-instance v2, Landroid/view/ViewGroup$LayoutParams;

    invoke-direct {v2, v12, v10}, Landroid/view/ViewGroup$LayoutParams;-><init>(II)V

    invoke-virtual {v0, v1, v2}, Landroid/view/Window;->addContentView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    :goto_9
    :try_start_2
    sget-object v0, Lcom/glu/tools/tapjoy/TapjoyInterface;->bannerLayout:Landroid/widget/LinearLayout;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setVisibility(I)V

    const-string v0, "TapjoyInterface"

    const-string v1, "Banner has been shown"

    invoke-static {v0, v1}, Lcom/tapjoy/TapjoyLog;->d(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    :cond_7
    monitor-exit v13

    return-void

    :cond_8
    move v8, v1

    goto/16 :goto_2

    :cond_9
    move v7, v1

    goto/16 :goto_3

    :cond_a
    move v6, v1

    goto/16 :goto_4

    :cond_b
    move v5, v1

    goto/16 :goto_5

    :cond_c
    move v4, v1

    goto/16 :goto_6

    :cond_d
    move v3, v1

    goto :goto_7

    :catch_0
    move-exception v0

    :try_start_3
    const-string v1, "TapjoyInterface"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Cannot display banner, error: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v1, v0}, Lcom/tapjoy/TapjoyLog;->d(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    goto :goto_9

    :catchall_0
    move-exception v0

    :try_start_4
    throw v0
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_1

    :catchall_1
    move-exception v0

    monitor-exit v13

    throw v0

    :cond_e
    move v1, v2

    goto :goto_8

    :cond_f
    move v9, v0

    move v11, v3

    goto/16 :goto_1

    :cond_10
    move v0, v3

    move v3, v4

    goto/16 :goto_0
.end method

.method static synthetic access$000()V
    .locals 0

    invoke-static {}, Lcom/glu/tools/tapjoy/TapjoyInterface;->TryToRestoreShownBanner()V

    return-void
.end method

.method static synthetic access$100()V
    .locals 0

    invoke-static {}, Lcom/glu/tools/tapjoy/TapjoyInterface;->TryToHideBanner()V

    return-void
.end method

.method static synthetic access$200()V
    .locals 0

    invoke-static {}, Lcom/glu/tools/tapjoy/TapjoyInterface;->TryToShowBanner()V

    return-void
.end method

.method public static declared-synchronized canDisplayInterface()Z
    .locals 2

    const-class v1, Lcom/glu/tools/tapjoy/TapjoyInterface;

    monitor-enter v1

    :try_start_0
    invoke-static {}, Lcom/tapjoy/TapjoyConnect;->getTapjoyConnectInstance()Lcom/tapjoy/TapjoyConnect;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result-object v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    monitor-exit v1

    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0

    :catchall_0
    move-exception v0

    monitor-exit v1

    throw v0
.end method

.method public static declared-synchronized clearGetPointsData()V
    .locals 2

    const-class v0, Lcom/glu/tools/tapjoy/TapjoyInterface;

    monitor-enter v0

    const/4 v1, 0x0

    :try_start_0
    sput v1, Lcom/glu/tools/tapjoy/TapjoyInterface;->lastTapjoyPointTotal:I
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit v0

    return-void

    :catchall_0
    move-exception v1

    monitor-exit v0

    throw v1
.end method

.method public static declared-synchronized closeTapjoyInterface()V
    .locals 1

    const-class v0, Lcom/glu/tools/tapjoy/TapjoyInterface;

    monitor-enter v0

    monitor-exit v0

    return-void
.end method

.method public static declared-synchronized consumeTapjoyPoints(I)Z
    .locals 3

    const-class v1, Lcom/glu/tools/tapjoy/TapjoyInterface;

    monitor-enter v1

    :try_start_0
    invoke-static {}, Lcom/tapjoy/TapjoyConnect;->getTapjoyConnectInstance()Lcom/tapjoy/TapjoyConnect;

    move-result-object v0

    if-eqz v0, :cond_0

    if-ltz p0, :cond_0

    sget v2, Lcom/glu/tools/tapjoy/TapjoyInterface;->remainingPointTotal:I

    if-lt v2, p0, :cond_0

    sget-object v2, Lcom/glu/tools/tapjoy/TapjoyInterface;->THIS:Lcom/glu/tools/tapjoy/TapjoyInterface;

    invoke-virtual {v0, p0, v2}, Lcom/tapjoy/TapjoyConnect;->spendTapPoints(ILcom/tapjoy/TapjoySpendPointsNotifier;)V

    sput p0, Lcom/glu/tools/tapjoy/TapjoyInterface;->previousConsumedThisSession:I
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    const/4 v0, 0x1

    :goto_0
    monitor-exit v1

    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0

    :catchall_0
    move-exception v0

    monitor-exit v1

    throw v0
.end method

.method public static declared-synchronized convertPointsToGameCurrency(I)I
    .locals 2

    const-class v0, Lcom/glu/tools/tapjoy/TapjoyInterface;

    monitor-enter v0

    :try_start_0
    sget v1, Lcom/glu/tools/tapjoy/TapjoyInterface;->POINTS_EXCHANGE_RATE:I
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    mul-int/2addr v1, p0

    monitor-exit v0

    return v1

    :catchall_0
    move-exception v1

    monitor-exit v0

    throw v1
.end method

.method public static declared-synchronized debugGivePoints(I)V
    .locals 2

    const-class v1, Lcom/glu/tools/tapjoy/TapjoyInterface;

    monitor-enter v1

    :try_start_0
    sget v0, Lcom/glu/tools/tapjoy/TapjoyInterface;->remainingPointTotal:I

    add-int/2addr v0, p0

    sput v0, Lcom/glu/tools/tapjoy/TapjoyInterface;->remainingPointTotal:I
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit v1

    return-void

    :catchall_0
    move-exception v0

    monitor-exit v1

    throw v0
.end method

.method public static declared-synchronized destroy()V
    .locals 1

    const-class v0, Lcom/glu/tools/tapjoy/TapjoyInterface;

    monitor-enter v0

    monitor-exit v0

    return-void
.end method

.method public static declared-synchronized getExchangeRate()I
    .locals 2

    const-class v0, Lcom/glu/tools/tapjoy/TapjoyInterface;

    monitor-enter v0

    :try_start_0
    sget v1, Lcom/glu/tools/tapjoy/TapjoyInterface;->POINTS_EXCHANGE_RATE:I
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit v0

    return v1

    :catchall_0
    move-exception v1

    monitor-exit v0

    throw v1
.end method

.method public static declared-synchronized getFeaturedApp()Lcom/tapjoy/TapjoyFeaturedAppObject;
    .locals 2

    const-class v0, Lcom/glu/tools/tapjoy/TapjoyInterface;

    monitor-enter v0

    :try_start_0
    sget-object v1, Lcom/glu/tools/tapjoy/TapjoyInterface;->featuredAppInfo:Lcom/tapjoy/TapjoyFeaturedAppObject;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit v0

    return-object v1

    :catchall_0
    move-exception v1

    monitor-exit v0

    throw v1
.end method

.method public static declared-synchronized getFeaturedAppQueryState()Z
    .locals 2

    const-class v0, Lcom/glu/tools/tapjoy/TapjoyInterface;

    monitor-enter v0

    :try_start_0
    sget-boolean v1, Lcom/glu/tools/tapjoy/TapjoyInterface;->featuredAppQueryInProgress:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit v0

    return v1

    :catchall_0
    move-exception v1

    monitor-exit v0

    throw v1
.end method

.method public static declared-synchronized getLastTapjoyPointTotal()I
    .locals 3

    const-class v1, Lcom/glu/tools/tapjoy/TapjoyInterface;

    monitor-enter v1

    :try_start_0
    invoke-static {}, Lcom/tapjoy/TapjoyConnect;->getTapjoyConnectInstance()Lcom/tapjoy/TapjoyConnect;

    move-result-object v0

    if-eqz v0, :cond_0

    sget-object v2, Lcom/glu/tools/tapjoy/TapjoyInterface;->THIS:Lcom/glu/tools/tapjoy/TapjoyInterface;

    invoke-virtual {v0, v2}, Lcom/tapjoy/TapjoyConnect;->getTapPoints(Lcom/tapjoy/TapjoyNotifier;)V

    :cond_0
    sget v0, Lcom/glu/tools/tapjoy/TapjoyInterface;->lastTapjoyPointTotal:I
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit v1

    return v0

    :catchall_0
    move-exception v0

    monitor-exit v1

    throw v0
.end method

.method public static declared-synchronized getPreviousConsumedThisSession()I
    .locals 2

    const-class v0, Lcom/glu/tools/tapjoy/TapjoyInterface;

    monitor-enter v0

    :try_start_0
    sget v1, Lcom/glu/tools/tapjoy/TapjoyInterface;->previousConsumedThisSession:I
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit v0

    return v1

    :catchall_0
    move-exception v1

    monitor-exit v0

    throw v1
.end method

.method public static declared-synchronized getRemainingTapjoyPoints()I
    .locals 3

    const-class v1, Lcom/glu/tools/tapjoy/TapjoyInterface;

    monitor-enter v1

    :try_start_0
    sget-boolean v0, Lcom/glu/tools/tapjoy/TapjoyInterface;->isRemainingTapjoyPointsBeingGot:Z

    if-nez v0, :cond_0

    invoke-static {}, Lcom/tapjoy/TapjoyConnect;->getTapjoyConnectInstance()Lcom/tapjoy/TapjoyConnect;

    move-result-object v0

    if-eqz v0, :cond_0

    sget-object v2, Lcom/glu/tools/tapjoy/TapjoyInterface;->THIS:Lcom/glu/tools/tapjoy/TapjoyInterface;

    invoke-virtual {v0, v2}, Lcom/tapjoy/TapjoyConnect;->getTapPoints(Lcom/tapjoy/TapjoyNotifier;)V

    const/4 v0, 0x1

    sput-boolean v0, Lcom/glu/tools/tapjoy/TapjoyInterface;->isRemainingTapjoyPointsBeingGot:Z

    :cond_0
    sget v0, Lcom/glu/tools/tapjoy/TapjoyInterface;->remainingPointTotal:I
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit v1

    return v0

    :catchall_0
    move-exception v0

    monitor-exit v1

    throw v0
.end method

.method public static declared-synchronized hideAd()V
    .locals 3

    const-class v1, Lcom/glu/tools/tapjoy/TapjoyInterface;

    monitor-enter v1

    const/4 v0, 0x0

    :try_start_0
    sput-boolean v0, Lcom/glu/tools/tapjoy/TapjoyInterface;->isBannerRequested:Z

    sget-boolean v0, Lcom/glu/tools/tapjoy/TapjoyInterface;->isBannerBeingShown:Z

    if-eqz v0, :cond_0

    const/4 v0, 0x0

    sput-boolean v0, Lcom/glu/tools/tapjoy/TapjoyInterface;->isBannerBeingShown:Z

    const/4 v0, 0x0

    sput-object v0, Lcom/glu/tools/tapjoy/TapjoyInterface;->bannerView:Landroid/view/View;

    sget-object v0, Lcom/glu/tools/tapjoy/TapjoyInterface;->usedActivity:Lcom/glu/platform/android/GluPlatformActivity;

    invoke-virtual {v0}, Lcom/glu/platform/android/GluPlatformActivity;->getHandler()Landroid/os/Handler;

    move-result-object v0

    new-instance v2, Lcom/glu/tools/tapjoy/TapjoyInterface$2;

    invoke-direct {v2}, Lcom/glu/tools/tapjoy/TapjoyInterface$2;-><init>()V

    invoke-virtual {v0, v2}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :cond_0
    monitor-exit v1

    return-void

    :catchall_0
    move-exception v0

    monitor-exit v1

    throw v0
.end method

.method public static declared-synchronized initialize(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)V
    .locals 3

    const-class v2, Lcom/glu/tools/tapjoy/TapjoyInterface;

    monitor-enter v2

    :try_start_0
    move-object v0, p0

    check-cast v0, Lcom/glu/platform/android/GluPlatformActivity;

    move-object v1, v0

    sput-object v1, Lcom/glu/tools/tapjoy/TapjoyInterface;->usedActivity:Lcom/glu/platform/android/GluPlatformActivity;

    invoke-static {p0, p1, p2}, Lcom/tapjoy/TapjoyConnect;->requestTapjoyConnect(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit v2

    return-void

    :catchall_0
    move-exception v1

    monitor-exit v2

    throw v1
.end method

.method public static declared-synchronized interfaceIsOpen()Z
    .locals 2

    const-class v0, Lcom/glu/tools/tapjoy/TapjoyInterface;

    monitor-enter v0

    const/4 v1, 0x0

    monitor-exit v0

    return v1
.end method

.method public static declared-synchronized isVisible()Z
    .locals 2

    const-class v0, Lcom/glu/tools/tapjoy/TapjoyInterface;

    monitor-enter v0

    :try_start_0
    sget-boolean v1, Lcom/glu/tools/tapjoy/TapjoyInterface;->isBannerBeingShown:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit v0

    return v1

    :catchall_0
    move-exception v1

    monitor-exit v0

    throw v1
.end method

.method public static declared-synchronized onresume()V
    .locals 3

    const-class v1, Lcom/glu/tools/tapjoy/TapjoyInterface;

    monitor-enter v1

    :try_start_0
    invoke-static {}, Lcom/tapjoy/TapjoyConnect;->getTapjoyConnectInstance()Lcom/tapjoy/TapjoyConnect;

    move-result-object v0

    if-eqz v0, :cond_0

    sget-object v2, Lcom/glu/tools/tapjoy/TapjoyInterface;->THIS:Lcom/glu/tools/tapjoy/TapjoyInterface;

    invoke-virtual {v0, v2}, Lcom/tapjoy/TapjoyConnect;->getTapPoints(Lcom/tapjoy/TapjoyNotifier;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :cond_0
    monitor-exit v1

    return-void

    :catchall_0
    move-exception v0

    monitor-exit v1

    throw v0
.end method

.method public static declared-synchronized openTapjoyInterface()V
    .locals 2

    const-class v1, Lcom/glu/tools/tapjoy/TapjoyInterface;

    monitor-enter v1

    :try_start_0
    invoke-static {}, Lcom/tapjoy/TapjoyConnect;->getTapjoyConnectInstance()Lcom/tapjoy/TapjoyConnect;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Lcom/tapjoy/TapjoyConnect;->showOffers()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :cond_0
    monitor-exit v1

    return-void

    :catchall_0
    move-exception v0

    monitor-exit v1

    throw v0
.end method

.method public static declared-synchronized queryFeaturedApp()V
    .locals 3

    const-class v1, Lcom/glu/tools/tapjoy/TapjoyInterface;

    monitor-enter v1

    :try_start_0
    invoke-static {}, Lcom/tapjoy/TapjoyConnect;->getTapjoyConnectInstance()Lcom/tapjoy/TapjoyConnect;

    move-result-object v0

    if-eqz v0, :cond_0

    sget-object v2, Lcom/glu/tools/tapjoy/TapjoyInterface;->THIS:Lcom/glu/tools/tapjoy/TapjoyInterface;

    invoke-virtual {v0, v2}, Lcom/tapjoy/TapjoyConnect;->getFeaturedApp(Lcom/tapjoy/TapjoyFeaturedAppNotifier;)V

    const/4 v0, 0x1

    sput-boolean v0, Lcom/glu/tools/tapjoy/TapjoyInterface;->featuredAppQueryInProgress:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :cond_0
    monitor-exit v1

    return-void

    :catchall_0
    move-exception v0

    monitor-exit v1

    throw v0
.end method

.method public static declared-synchronized resetFeaturedApp()V
    .locals 2

    const-class v1, Lcom/glu/tools/tapjoy/TapjoyInterface;

    monitor-enter v1

    const/4 v0, 0x0

    :try_start_0
    sput-object v0, Lcom/glu/tools/tapjoy/TapjoyInterface;->featuredAppInfo:Lcom/tapjoy/TapjoyFeaturedAppObject;

    const/4 v0, 0x0

    sput-boolean v0, Lcom/glu/tools/tapjoy/TapjoyInterface;->featuredAppQueryInProgress:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit v1

    return-void

    :catchall_0
    move-exception v0

    monitor-exit v1

    throw v0
.end method

.method public static declared-synchronized sendSubscribeComplete()I
    .locals 3

    const-class v1, Lcom/glu/tools/tapjoy/TapjoyInterface;

    monitor-enter v1

    :try_start_0
    const-string v0, "TapjoyInterface"

    const-string v2, "sendSubscribeComplete(): 4f9ddcd4-ad1a-499c-8042-749f99347f5f"

    invoke-static {v0, v2}, Lcom/tapjoy/TapjoyLog;->d(Ljava/lang/String;Ljava/lang/String;)V

    invoke-static {}, Lcom/tapjoy/TapjoyConnect;->getTapjoyConnectInstance()Lcom/tapjoy/TapjoyConnect;

    move-result-object v0

    const-string v2, "4f9ddcd4-ad1a-499c-8042-749f99347f5f"

    invoke-virtual {v0, v2}, Lcom/tapjoy/TapjoyConnect;->actionComplete(Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    const/4 v0, 0x1

    monitor-exit v1

    return v0

    :catchall_0
    move-exception v0

    monitor-exit v1

    throw v0
.end method

.method public static declared-synchronized showAd(III)V
    .locals 3

    const-class v1, Lcom/glu/tools/tapjoy/TapjoyInterface;

    monitor-enter v1

    :try_start_0
    invoke-static {}, Lcom/tapjoy/TapjoyConnect;->getTapjoyConnectInstance()Lcom/tapjoy/TapjoyConnect;

    move-result-object v0

    if-eqz v0, :cond_0

    sput p0, Lcom/glu/tools/tapjoy/TapjoyInterface;->bannerPos:I

    sput p1, Lcom/glu/tools/tapjoy/TapjoyInterface;->bannerX:I

    sput p2, Lcom/glu/tools/tapjoy/TapjoyInterface;->bannerY:I

    const/4 v2, 0x1

    sput v2, Lcom/glu/tools/tapjoy/TapjoyInterface;->retrySeveralTimes:I

    sget-boolean v2, Lcom/glu/tools/tapjoy/TapjoyInterface;->isBannerRequested:Z

    if-nez v2, :cond_0

    const/4 v2, 0x1

    sput-boolean v2, Lcom/glu/tools/tapjoy/TapjoyInterface;->isBannerRequested:Z

    sget-object v2, Lcom/glu/tools/tapjoy/TapjoyInterface;->THIS:Lcom/glu/tools/tapjoy/TapjoyInterface;

    invoke-virtual {v0, v2}, Lcom/tapjoy/TapjoyConnect;->getDisplayAd(Lcom/tapjoy/TapjoyDisplayAdNotifier;)V

    const-string v0, "TapjoyInterface"

    const-string v2, "showAd requested to display ad"

    invoke-static {v0, v2}, Lcom/tapjoy/TapjoyLog;->d(Ljava/lang/String;Ljava/lang/String;)V

    sget-boolean v0, Lcom/glu/tools/tapjoy/TapjoyInterface;->isBannerBeingShown:Z

    if-nez v0, :cond_0

    sget-object v0, Lcom/glu/tools/tapjoy/TapjoyInterface;->usedActivity:Lcom/glu/platform/android/GluPlatformActivity;

    invoke-virtual {v0}, Lcom/glu/platform/android/GluPlatformActivity;->getHandler()Landroid/os/Handler;

    move-result-object v0

    new-instance v2, Lcom/glu/tools/tapjoy/TapjoyInterface$1;

    invoke-direct {v2}, Lcom/glu/tools/tapjoy/TapjoyInterface$1;-><init>()V

    invoke-virtual {v0, v2}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :cond_0
    monitor-exit v1

    return-void

    :catchall_0
    move-exception v0

    monitor-exit v1

    throw v0
.end method

.method public static declared-synchronized tick(I)V
    .locals 1

    const-class v0, Lcom/glu/tools/tapjoy/TapjoyInterface;

    monitor-enter v0

    monitor-exit v0

    return-void
.end method


# virtual methods
.method public final declared-synchronized getDisplayAdResponse(Landroid/view/View;)V
    .locals 2

    monitor-enter p0

    :try_start_0
    const-string v0, "TapjoyInterface"

    const-string v1, "getDisplayAd succeeded"

    invoke-static {v0, v1}, Lcom/tapjoy/TapjoyLog;->d(Ljava/lang/String;Ljava/lang/String;)V

    sget-boolean v0, Lcom/glu/tools/tapjoy/TapjoyInterface;->isBannerRequested:Z

    if-eqz v0, :cond_0

    sput-object p1, Lcom/glu/tools/tapjoy/TapjoyInterface;->bannerView:Landroid/view/View;

    const/4 v0, 0x1

    sput-boolean v0, Lcom/glu/tools/tapjoy/TapjoyInterface;->isBannerBeingShown:Z

    sget-object v0, Lcom/glu/tools/tapjoy/TapjoyInterface;->usedActivity:Lcom/glu/platform/android/GluPlatformActivity;

    invoke-virtual {v0}, Lcom/glu/platform/android/GluPlatformActivity;->getHandler()Landroid/os/Handler;

    move-result-object v0

    new-instance v1, Lcom/glu/tools/tapjoy/TapjoyInterface$3;

    invoke-direct {v1, p0}, Lcom/glu/tools/tapjoy/TapjoyInterface$3;-><init>(Lcom/glu/tools/tapjoy/TapjoyInterface;)V

    invoke-virtual {v0, v1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :cond_0
    monitor-exit p0

    return-void

    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public final declared-synchronized getDisplayAdResponseFailed(Ljava/lang/String;)V
    .locals 3

    monitor-enter p0

    :try_start_0
    const-string v0, "TapjoyInterface"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "getDisplayAd failed, error: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/tapjoy/TapjoyLog;->d(Ljava/lang/String;Ljava/lang/String;)V

    sget-boolean v0, Lcom/glu/tools/tapjoy/TapjoyInterface;->isBannerRequested:Z

    if-eqz v0, :cond_0

    sget v0, Lcom/glu/tools/tapjoy/TapjoyInterface;->retrySeveralTimes:I

    if-lez v0, :cond_1

    const-string v0, "TapjoyInterface"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "getDisplayAd will be retried up to "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    sget v2, Lcom/glu/tools/tapjoy/TapjoyInterface;->retrySeveralTimes:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " times."

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/tapjoy/TapjoyLog;->d(Ljava/lang/String;Ljava/lang/String;)V

    sget v0, Lcom/glu/tools/tapjoy/TapjoyInterface;->retrySeveralTimes:I

    add-int/lit8 v0, v0, -0x1

    sput v0, Lcom/glu/tools/tapjoy/TapjoyInterface;->retrySeveralTimes:I

    invoke-static {}, Lcom/tapjoy/TapjoyConnect;->getTapjoyConnectInstance()Lcom/tapjoy/TapjoyConnect;

    move-result-object v0

    invoke-virtual {v0, p0}, Lcom/tapjoy/TapjoyConnect;->getDisplayAd(Lcom/tapjoy/TapjoyDisplayAdNotifier;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :cond_0
    :goto_0
    monitor-exit p0

    return-void

    :cond_1
    const/4 v0, 0x0

    :try_start_1
    sput-boolean v0, Lcom/glu/tools/tapjoy/TapjoyInterface;->isBannerRequested:Z
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public final declared-synchronized getFeaturedAppResponse(Lcom/tapjoy/TapjoyFeaturedAppObject;)V
    .locals 2

    monitor-enter p0

    :try_start_0
    const-string v0, "TapjoyInterface"

    const-string v1, "getFeaturedAppResponse succeeded"

    invoke-static {v0, v1}, Lcom/tapjoy/TapjoyLog;->d(Ljava/lang/String;Ljava/lang/String;)V

    sput-object p1, Lcom/glu/tools/tapjoy/TapjoyInterface;->featuredAppInfo:Lcom/tapjoy/TapjoyFeaturedAppObject;

    const/4 v0, 0x0

    sput-boolean v0, Lcom/glu/tools/tapjoy/TapjoyInterface;->featuredAppQueryInProgress:Z

    const/4 v0, 0x1

    sput-boolean v0, Lcom/glu/tools/tapjoy/TapjoyInterface;->showFeaturedAppView:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return-void

    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public final declared-synchronized getFeaturedAppResponseFailed(Ljava/lang/String;)V
    .locals 3

    monitor-enter p0

    :try_start_0
    const-string v0, "TapjoyInterface"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "getFeaturedAppResponse failed, error "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/tapjoy/TapjoyLog;->d(Ljava/lang/String;Ljava/lang/String;)V

    const/4 v0, 0x0

    sput-object v0, Lcom/glu/tools/tapjoy/TapjoyInterface;->featuredAppInfo:Lcom/tapjoy/TapjoyFeaturedAppObject;

    const/4 v0, 0x0

    sput-boolean v0, Lcom/glu/tools/tapjoy/TapjoyInterface;->featuredAppQueryInProgress:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return-void

    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public final declared-synchronized getSpendPointsResponse(Ljava/lang/String;I)V
    .locals 3

    monitor-enter p0

    :try_start_0
    const-string v0, "TapjoyInterface"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "spendTapPoints succeeded, currencyName: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", pointTotal: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/tapjoy/TapjoyLog;->d(Ljava/lang/String;Ljava/lang/String;)V

    sget v0, Lcom/glu/tools/tapjoy/TapjoyInterface;->lastTapjoyPointTotal:I

    if-le v0, p2, :cond_1

    sget v0, Lcom/glu/tools/tapjoy/TapjoyInterface;->remainingPointTotal:I

    sget v1, Lcom/glu/tools/tapjoy/TapjoyInterface;->lastTapjoyPointTotal:I

    sub-int/2addr v1, p2

    sub-int/2addr v0, v1

    sput v0, Lcom/glu/tools/tapjoy/TapjoyInterface;->remainingPointTotal:I

    if-gez v0, :cond_0

    const/4 v0, 0x0

    sput v0, Lcom/glu/tools/tapjoy/TapjoyInterface;->remainingPointTotal:I

    :cond_0
    sput p2, Lcom/glu/tools/tapjoy/TapjoyInterface;->lastTapjoyPointTotal:I
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :cond_1
    monitor-exit p0

    return-void

    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public final declared-synchronized getSpendPointsResponseFailed(Ljava/lang/String;)V
    .locals 3

    monitor-enter p0

    :try_start_0
    const-string v0, "TapjoyInterface"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "spendTapPoints failed, error: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/tapjoy/TapjoyLog;->d(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return-void

    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public final declared-synchronized getUpdatePoints(Ljava/lang/String;I)V
    .locals 3

    monitor-enter p0

    :try_start_0
    const-string v0, "TapjoyInterface"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "getTapPoints succeeded, currencyName: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", pointTotal: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/tapjoy/TapjoyLog;->d(Ljava/lang/String;Ljava/lang/String;)V

    sget v0, Lcom/glu/tools/tapjoy/TapjoyInterface;->lastTapjoyPointTotal:I

    if-le p2, v0, :cond_0

    sget v0, Lcom/glu/tools/tapjoy/TapjoyInterface;->remainingPointTotal:I

    sget v1, Lcom/glu/tools/tapjoy/TapjoyInterface;->lastTapjoyPointTotal:I

    sub-int v1, p2, v1

    add-int/2addr v0, v1

    sput v0, Lcom/glu/tools/tapjoy/TapjoyInterface;->remainingPointTotal:I

    sput p2, Lcom/glu/tools/tapjoy/TapjoyInterface;->lastTapjoyPointTotal:I

    :cond_0
    const/4 v0, 0x0

    sput-boolean v0, Lcom/glu/tools/tapjoy/TapjoyInterface;->isRemainingTapjoyPointsBeingGot:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return-void

    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public final declared-synchronized getUpdatePointsFailed(Ljava/lang/String;)V
    .locals 3

    monitor-enter p0

    :try_start_0
    const-string v0, "TapjoyInterface"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "getTapPoints failed, error: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/tapjoy/TapjoyLog;->d(Ljava/lang/String;Ljava/lang/String;)V

    const/4 v0, 0x0

    sput-boolean v0, Lcom/glu/tools/tapjoy/TapjoyInterface;->isRemainingTapjoyPointsBeingGot:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return-void

    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method
