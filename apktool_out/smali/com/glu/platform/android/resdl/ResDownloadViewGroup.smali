.class public Lcom/glu/platform/android/resdl/ResDownloadViewGroup;
.super Landroid/view/ViewGroup;


# static fields
.field public static instance:Lcom/glu/platform/android/resdl/ResDownloadViewGroup;


# instance fields
.field public m_adVisible:Z

.field private m_layoutPending:Z

.field private m_viewManipulationHandler:Landroid/os/Handler;

.field public m_views:Ljava/util/Vector;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Vector",
            "<",
            "Landroid/view/View;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 1

    const/4 v0, 0x0

    sput-object v0, Lcom/glu/platform/android/resdl/ResDownloadViewGroup;->instance:Lcom/glu/platform/android/resdl/ResDownloadViewGroup;

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;)V
    .locals 2

    const/4 v1, 0x0

    invoke-direct {p0, p1}, Landroid/view/ViewGroup;-><init>(Landroid/content/Context;)V

    new-instance v0, Ljava/util/Vector;

    invoke-direct {v0}, Ljava/util/Vector;-><init>()V

    iput-object v0, p0, Lcom/glu/platform/android/resdl/ResDownloadViewGroup;->m_views:Ljava/util/Vector;

    iput-boolean v1, p0, Lcom/glu/platform/android/resdl/ResDownloadViewGroup;->m_adVisible:Z

    iput-boolean v1, p0, Lcom/glu/platform/android/resdl/ResDownloadViewGroup;->m_layoutPending:Z

    new-instance v0, Lcom/glu/platform/android/resdl/ResDownloadViewGroup$1;

    invoke-direct {v0, p0}, Lcom/glu/platform/android/resdl/ResDownloadViewGroup$1;-><init>(Lcom/glu/platform/android/resdl/ResDownloadViewGroup;)V

    iput-object v0, p0, Lcom/glu/platform/android/resdl/ResDownloadViewGroup;->m_viewManipulationHandler:Landroid/os/Handler;

    const v0, 0x42424e

    invoke-virtual {p0, v0}, Lcom/glu/platform/android/resdl/ResDownloadViewGroup;->setId(I)V

    invoke-static {p0}, Lcom/glu/platform/android/resdl/GluUtil;->doStandardViewGroupConfiguration(Landroid/view/ViewGroup;)V

    sput-object p0, Lcom/glu/platform/android/resdl/ResDownloadViewGroup;->instance:Lcom/glu/platform/android/resdl/ResDownloadViewGroup;

    return-void
.end method

.method public static tick$13462e()V
    .locals 0

    return-void
.end method


# virtual methods
.method public final init()V
    .locals 6

    const/4 v5, 0x1

    const/4 v2, 0x0

    const-string v0, "initting RDVG"

    invoke-static {v0}, Lcom/glu/platform/android/resdl/Debug;->log(Ljava/lang/String;)V

    move v1, v2

    :goto_0
    if-gtz v1, :cond_0

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "view "

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/glu/platform/android/resdl/Debug;->log(Ljava/lang/String;)V

    new-instance v0, Lcom/glu/platform/android/resdl/ResFileDownloadView;

    invoke-static {}, Lcom/glu/platform/android/resdl/ResDL;->getContext()Landroid/app/Activity;

    move-result-object v3

    invoke-direct {v0, v3}, Lcom/glu/platform/android/resdl/ResFileDownloadView;-><init>(Landroid/content/Context;)V

    invoke-static {}, Lcom/glu/platform/android/resdl/GluUtil;->getScreenWidth()I

    move-result v3

    invoke-static {}, Lcom/glu/platform/android/resdl/GluUtil;->getScreenHeight()I

    move-result v4

    invoke-virtual {v0, v3, v4}, Lcom/glu/platform/android/resdl/ResFileDownloadView;->init(II)V

    iget-object v3, p0, Lcom/glu/platform/android/resdl/ResDownloadViewGroup;->m_views:Ljava/util/Vector;

    invoke-virtual {v3, v0}, Ljava/util/Vector;->addElement(Ljava/lang/Object;)V

    iget-object v0, p0, Lcom/glu/platform/android/resdl/ResDownloadViewGroup;->m_views:Ljava/util/Vector;

    iget-object v3, p0, Lcom/glu/platform/android/resdl/ResDownloadViewGroup;->m_views:Ljava/util/Vector;

    invoke-virtual {v3}, Ljava/util/Vector;->size()I

    move-result v3

    add-int/lit8 v3, v3, -0x1

    invoke-virtual {v0, v3}, Ljava/util/Vector;->elementAt(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/view/View;

    invoke-virtual {p0, v0, v2}, Lcom/glu/platform/android/resdl/ResDownloadViewGroup;->addView(Landroid/view/View;I)V

    add-int/lit8 v0, v1, 0x1

    move v1, v0

    goto :goto_0

    :cond_0
    invoke-virtual {p0, v2}, Lcom/glu/platform/android/resdl/ResDownloadViewGroup;->setVisibility(I)V

    invoke-virtual {p0, v5}, Lcom/glu/platform/android/resdl/ResDownloadViewGroup;->setFocusable(Z)V

    invoke-virtual {p0, v5}, Lcom/glu/platform/android/resdl/ResDownloadViewGroup;->setFocusableInTouchMode(Z)V

    invoke-virtual {p0, v5}, Lcom/glu/platform/android/resdl/ResDownloadViewGroup;->setClickable(Z)V

    return-void
.end method

.method public onKeyDown(ILandroid/view/KeyEvent;)Z
    .locals 1

    const/4 v0, 0x1

    return v0
.end method

.method public onKeyUp(ILandroid/view/KeyEvent;)Z
    .locals 2

    const/4 v1, 0x1

    const/4 v0, 0x4

    if-ne p1, v0, :cond_0

    sget-object v0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->instance:Lcom/glu/platform/android/resdl/ResFileDownloadView;

    iput-boolean v1, v0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_backPressed:Z

    :cond_0
    return v1
.end method

.method protected onLayout(ZIIII)V
    .locals 6

    const/4 v2, 0x0

    const-string v0, "RDVG layout..."

    invoke-static {v0}, Lcom/glu/platform/android/resdl/Debug;->log(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/glu/platform/android/resdl/ResDownloadViewGroup;->m_views:Ljava/util/Vector;

    invoke-virtual {v0}, Ljava/util/Vector;->size()I

    move-result v3

    move v1, v2

    :goto_0
    if-ge v1, v3, :cond_1

    iget-object v0, p0, Lcom/glu/platform/android/resdl/ResDownloadViewGroup;->m_views:Ljava/util/Vector;

    invoke-virtual {v0, v1}, Ljava/util/Vector;->elementAt(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/view/View;

    if-nez v1, :cond_0

    invoke-static {}, Lcom/glu/platform/android/resdl/GluUtil;->getScreenWidth()I

    move-result v4

    invoke-static {}, Lcom/glu/platform/android/resdl/GluUtil;->getScreenHeight()I

    move-result v5

    invoke-virtual {v0, v2, v2, v4, v5}, Landroid/view/View;->layout(IIII)V

    :cond_0
    add-int/lit8 v0, v1, 0x1

    move v1, v0

    goto :goto_0

    :cond_1
    iput-boolean v2, p0, Lcom/glu/platform/android/resdl/ResDownloadViewGroup;->m_layoutPending:Z

    return-void
.end method

.method protected onMeasure(II)V
    .locals 2

    invoke-static {}, Lcom/glu/platform/android/resdl/GluUtil;->getScreenHeight()I

    move-result v0

    invoke-static {}, Lcom/glu/platform/android/resdl/GluUtil;->getScreenWidth()I

    move-result v1

    invoke-virtual {p0, p1, p2}, Lcom/glu/platform/android/resdl/ResDownloadViewGroup;->measureChildren(II)V

    invoke-static {v1, p1}, Lcom/glu/platform/android/resdl/ResDownloadViewGroup;->resolveSize(II)I

    move-result v1

    invoke-static {v0, p2}, Lcom/glu/platform/android/resdl/ResDownloadViewGroup;->resolveSize(II)I

    move-result v0

    invoke-virtual {p0, v1, v0}, Lcom/glu/platform/android/resdl/ResDownloadViewGroup;->setMeasuredDimension(II)V

    return-void
.end method
