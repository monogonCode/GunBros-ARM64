.class public abstract Lcom/glu/platform/android/resdl/ResFileDownloadView$GluWidget;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/glu/platform/android/resdl/ResFileDownloadView;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x409
    name = "GluWidget"
.end annotation


# instance fields
.field public m_boundsOverreachFactor:F

.field public m_dx:I

.field public m_dy:I

.field public m_parent:Lcom/glu/platform/android/resdl/ResFileDownloadView;

.field public m_widgetID:I

.field public m_x:I

.field public m_y:I

.field public pointerActive:Z

.field public pointerX:I

.field public pointerY:I


# direct methods
.method public constructor <init>(Lcom/glu/platform/android/resdl/ResFileDownloadView;I)V
    .locals 1

    const/4 v0, 0x0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluWidget;->pointerX:I

    iput v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluWidget;->pointerY:I

    iput-boolean v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluWidget;->pointerActive:Z

    iput v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluWidget;->m_x:I

    iput v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluWidget;->m_y:I

    iput v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluWidget;->m_dx:I

    iput v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluWidget;->m_dy:I

    const/high16 v0, 0x3f800000    # 1.0f

    iput v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluWidget;->m_boundsOverreachFactor:F

    iput-object p1, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluWidget;->m_parent:Lcom/glu/platform/android/resdl/ResFileDownloadView;

    iput p2, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluWidget;->m_widgetID:I

    return-void
.end method


# virtual methods
.method public final containsCoords(II)Z
    .locals 5

    const/4 v0, 0x1

    iget v1, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluWidget;->m_boundsOverreachFactor:F

    const/high16 v2, 0x3f800000    # 1.0f

    cmpl-float v1, v1, v2

    if-nez v1, :cond_1

    iget v1, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluWidget;->m_x:I

    if-lt p1, v1, :cond_2

    iget v1, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluWidget;->m_dx:I

    if-gt p1, v1, :cond_2

    iget v1, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluWidget;->m_y:I

    if-lt p2, v1, :cond_2

    iget v1, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluWidget;->m_dy:I

    if-gt p2, v1, :cond_2

    :cond_0
    :goto_0
    return v0

    :cond_1
    iget v1, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluWidget;->m_dx:I

    iget v2, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluWidget;->m_x:I

    sub-int/2addr v1, v2

    int-to-float v1, v1

    iget v2, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluWidget;->m_boundsOverreachFactor:F

    mul-float/2addr v1, v2

    float-to-int v1, v1

    shr-int/lit8 v1, v1, 0x1

    iget v2, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluWidget;->m_dx:I

    iget v3, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluWidget;->m_x:I

    sub-int/2addr v2, v3

    shr-int/lit8 v2, v2, 0x1

    sub-int/2addr v1, v2

    iget v2, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluWidget;->m_dy:I

    iget v3, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluWidget;->m_y:I

    sub-int/2addr v2, v3

    int-to-float v2, v2

    iget v3, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluWidget;->m_boundsOverreachFactor:F

    mul-float/2addr v2, v3

    float-to-int v2, v2

    shr-int/lit8 v2, v2, 0x1

    iget v3, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluWidget;->m_dy:I

    iget v4, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluWidget;->m_y:I

    sub-int/2addr v3, v4

    shr-int/lit8 v3, v3, 0x1

    sub-int/2addr v2, v3

    iget v3, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluWidget;->m_x:I

    sub-int/2addr v3, v1

    if-lt p1, v3, :cond_2

    iget v3, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluWidget;->m_dx:I

    add-int/2addr v1, v3

    if-gt p1, v1, :cond_2

    iget v1, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluWidget;->m_y:I

    sub-int/2addr v1, v2

    if-lt p2, v1, :cond_2

    iget v1, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluWidget;->m_dy:I

    add-int/2addr v1, v2

    if-le p2, v1, :cond_0

    :cond_2
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public abstract draw(Landroid/graphics/Canvas;)V
.end method

.method public setBounds(IIII)V
    .locals 1

    iput p1, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluWidget;->m_x:I

    iput p2, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluWidget;->m_y:I

    add-int v0, p1, p3

    add-int/lit8 v0, v0, -0x1

    iput v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluWidget;->m_dx:I

    add-int v0, p2, p4

    add-int/lit8 v0, v0, -0x1

    iput v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluWidget;->m_dy:I

    return-void
.end method

.method public abstract tick(I)V
.end method
