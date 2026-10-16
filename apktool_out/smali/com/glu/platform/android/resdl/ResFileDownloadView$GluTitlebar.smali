.class public final Lcom/glu/platform/android/resdl/ResFileDownloadView$GluTitlebar;
.super Lcom/glu/platform/android/resdl/ResFileDownloadView$GluWidget;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/glu/platform/android/resdl/ResFileDownloadView;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "GluTitlebar"
.end annotation


# instance fields
.field public m_label:Ljava/lang/String;

.field public m_paint:Landroid/graphics/Paint;


# direct methods
.method public constructor <init>(Ljava/lang/String;)V
    .locals 2

    sget-object v0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->instance:Lcom/glu/platform/android/resdl/ResFileDownloadView;

    const/4 v1, -0x1

    invoke-direct {p0, v0, v1}, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluWidget;-><init>(Lcom/glu/platform/android/resdl/ResFileDownloadView;I)V

    iput-object p1, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluTitlebar;->m_label:Ljava/lang/String;

    sget-object v0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->instance:Lcom/glu/platform/android/resdl/ResFileDownloadView;

    iget-object v0, v0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_titlebarPaint:Landroid/graphics/Paint;

    iput-object v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluTitlebar;->m_paint:Landroid/graphics/Paint;

    return-void
.end method


# virtual methods
.method public final draw(Landroid/graphics/Canvas;)V
    .locals 7

    const v0, 0x7f020024

    invoke-static {v0}, Lcom/glu/platform/android/resdl/GluUtil;->getDrawable(I)Landroid/graphics/drawable/Drawable;

    move-result-object v1

    const/16 v0, 0x26

    invoke-static {v0}, Lcom/glu/platform/android/resdl/GluUtil;->scaleRelativeToG1(I)I

    move-result v2

    const/16 v0, 0x20

    invoke-static {v0}, Lcom/glu/platform/android/resdl/GluUtil;->scaleRelativeToG1(I)I

    move-result v3

    iget v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluTitlebar;->m_x:I

    :goto_0
    iget v4, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluTitlebar;->m_dx:I

    if-ge v0, v4, :cond_0

    iget v4, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluTitlebar;->m_y:I

    add-int v5, v0, v3

    iget v6, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluTitlebar;->m_y:I

    add-int/2addr v6, v2

    invoke-virtual {v1, v0, v4, v5, v6}, Landroid/graphics/drawable/Drawable;->setBounds(IIII)V

    add-int/2addr v0, v3

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluTitlebar;->m_label:Ljava/lang/String;

    iget v1, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluTitlebar;->m_x:I

    add-int/lit8 v1, v1, 0xa

    int-to-float v1, v1

    iget v2, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluTitlebar;->m_y:I

    iget v3, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluTitlebar;->m_dy:I

    iget v4, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluTitlebar;->m_y:I

    sub-int/2addr v3, v4

    div-int/lit8 v3, v3, 0x2

    add-int/2addr v2, v3

    int-to-float v2, v2

    iget-object v3, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluTitlebar;->m_paint:Landroid/graphics/Paint;

    invoke-virtual {v3}, Landroid/graphics/Paint;->getTextSize()F

    move-result v3

    const/high16 v4, 0x40000000    # 2.0f

    div-float/2addr v3, v4

    add-float/2addr v2, v3

    iget-object v3, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluTitlebar;->m_paint:Landroid/graphics/Paint;

    invoke-virtual {p1, v0, v1, v2, v3}, Landroid/graphics/Canvas;->drawText(Ljava/lang/String;FFLandroid/graphics/Paint;)V

    return-void
.end method

.method public final setBounds(IIII)V
    .locals 1

    const/16 v0, 0x26

    invoke-static {v0}, Lcom/glu/platform/android/resdl/GluUtil;->scaleRelativeToG1(I)I

    move-result v0

    invoke-super {p0, p1, p2, p3, v0}, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluWidget;->setBounds(IIII)V

    return-void
.end method

.method public final tick(I)V
    .locals 0

    return-void
.end method
