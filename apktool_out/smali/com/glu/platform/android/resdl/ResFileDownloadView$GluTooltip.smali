.class public final Lcom/glu/platform/android/resdl/ResFileDownloadView$GluTooltip;
.super Lcom/glu/platform/android/resdl/ResFileDownloadView$GluWidget;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/glu/platform/android/resdl/ResFileDownloadView;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "GluTooltip"
.end annotation


# instance fields
.field public m_elapsedTime:I

.field public m_popupText:Ljava/lang/String;

.field public m_popupTitle:Ljava/lang/String;

.field public m_scaleFactor:F


# direct methods
.method public constructor <init>(Ljava/lang/String;)V
    .locals 2

    sget-object v0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->instance:Lcom/glu/platform/android/resdl/ResFileDownloadView;

    const/16 v1, 0xc

    invoke-direct {p0, v0, v1}, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluWidget;-><init>(Lcom/glu/platform/android/resdl/ResFileDownloadView;I)V

    const/4 v0, 0x0

    iput v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluTooltip;->m_elapsedTime:I

    const/high16 v0, 0x3f800000    # 1.0f

    iput v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluTooltip;->m_scaleFactor:F

    const v0, 0x7f060066

    invoke-static {v0}, Lcom/glu/platform/android/resdl/GluUtil;->getString(I)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluTooltip;->m_popupTitle:Ljava/lang/String;

    iput-object p1, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluTooltip;->m_popupText:Ljava/lang/String;

    const/high16 v0, 0x40000000    # 2.0f

    iput v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluTooltip;->m_boundsOverreachFactor:F

    return-void
.end method


# virtual methods
.method public final draw(Landroid/graphics/Canvas;)V
    .locals 7

    sget-object v0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->instance:Lcom/glu/platform/android/resdl/ResFileDownloadView;

    iget-object v0, v0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_tooltipImg:Landroid/graphics/drawable/Drawable;

    sget-object v1, Lcom/glu/platform/android/resdl/ResFileDownloadView;->instance:Lcom/glu/platform/android/resdl/ResFileDownloadView;

    iget-object v1, v1, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_tooltipColorFilter:Landroid/graphics/LightingColorFilter;

    invoke-virtual {v0, v1}, Landroid/graphics/drawable/Drawable;->setColorFilter(Landroid/graphics/ColorFilter;)V

    const/16 v1, 0x1a

    invoke-static {v1}, Lcom/glu/platform/android/resdl/GluUtil;->scaleRelativeToG1(I)I

    move-result v1

    int-to-float v2, v1

    iget v3, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluTooltip;->m_scaleFactor:F

    mul-float/2addr v2, v3

    float-to-int v2, v2

    shr-int/lit8 v2, v2, 0x1

    shr-int/lit8 v3, v1, 0x1

    sub-int/2addr v2, v3

    int-to-float v3, v1

    iget v4, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluTooltip;->m_scaleFactor:F

    mul-float/2addr v3, v4

    float-to-int v3, v3

    shr-int/lit8 v3, v3, 0x1

    shr-int/lit8 v4, v1, 0x1

    sub-int/2addr v3, v4

    iget v4, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluTooltip;->m_x:I

    sub-int/2addr v4, v2

    iget v5, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluTooltip;->m_y:I

    sub-int/2addr v5, v3

    iget v6, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluTooltip;->m_x:I

    add-int/2addr v6, v1

    add-int/lit8 v6, v6, -0x1

    add-int/2addr v2, v6

    iget v6, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluTooltip;->m_y:I

    add-int/2addr v1, v6

    add-int/lit8 v1, v1, -0x1

    add-int/2addr v1, v3

    invoke-virtual {v0, v4, v5, v2, v1}, Landroid/graphics/drawable/Drawable;->setBounds(IIII)V

    invoke-virtual {v0, p1}, Landroid/graphics/drawable/Drawable;->draw(Landroid/graphics/Canvas;)V

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/graphics/drawable/Drawable;->setColorFilter(Landroid/graphics/ColorFilter;)V

    return-void
.end method

.method public final tick(I)V
    .locals 5

    const/16 v4, 0xfa

    const/high16 v3, 0x44fa0000    # 2000.0f

    const/high16 v2, 0x3f800000    # 1.0f

    iget v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluTooltip;->m_elapsedTime:I

    add-int/2addr v0, p1

    iput v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluTooltip;->m_elapsedTime:I

    iget v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluTooltip;->m_elapsedTime:I

    rem-int/lit16 v0, v0, 0x3e8

    iput v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluTooltip;->m_elapsedTime:I

    const/16 v1, 0x1f4

    if-ge v0, v1, :cond_1

    if-le v0, v4, :cond_0

    rsub-int v0, v0, 0x1f4

    :cond_0
    int-to-float v0, v0

    div-float/2addr v0, v3

    add-float/2addr v0, v2

    iput v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluTooltip;->m_scaleFactor:F

    :goto_0
    return-void

    :cond_1
    add-int/lit16 v0, v0, -0x1f4

    if-le v0, v4, :cond_2

    rsub-int v0, v0, 0x1f4

    :cond_2
    int-to-float v0, v0

    div-float/2addr v0, v3

    sub-float v0, v2, v0

    iput v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluTooltip;->m_scaleFactor:F

    goto :goto_0
.end method
