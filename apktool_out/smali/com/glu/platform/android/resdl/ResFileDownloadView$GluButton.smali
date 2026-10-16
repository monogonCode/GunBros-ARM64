.class public final Lcom/glu/platform/android/resdl/ResFileDownloadView$GluButton;
.super Lcom/glu/platform/android/resdl/ResFileDownloadView$GluWidget;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/glu/platform/android/resdl/ResFileDownloadView;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "GluButton"
.end annotation


# instance fields
.field public m_label:Ljava/lang/String;

.field public m_paint:Landroid/graphics/Paint;

.field public m_rectBounds:Landroid/graphics/Rect;

.field public m_wrappedLabel:Ljava/util/Vector;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Vector",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>(Ljava/lang/String;I)V
    .locals 1

    sget-object v0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->instance:Lcom/glu/platform/android/resdl/ResFileDownloadView;

    invoke-direct {p0, v0, p2}, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluWidget;-><init>(Lcom/glu/platform/android/resdl/ResFileDownloadView;I)V

    new-instance v0, Landroid/graphics/Rect;

    invoke-direct {v0}, Landroid/graphics/Rect;-><init>()V

    iput-object v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluButton;->m_rectBounds:Landroid/graphics/Rect;

    iput-object p1, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluButton;->m_label:Ljava/lang/String;

    sget-object v0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->instance:Lcom/glu/platform/android/resdl/ResFileDownloadView;

    iget-object v0, v0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_buttonPaint:Landroid/graphics/Paint;

    iput-object v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluButton;->m_paint:Landroid/graphics/Paint;

    return-void
.end method


# virtual methods
.method public final draw(Landroid/graphics/Canvas;)V
    .locals 4

    iget-object v1, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluButton;->m_rectBounds:Landroid/graphics/Rect;

    iget-boolean v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluButton;->pointerActive:Z

    if-eqz v0, :cond_0

    sget-object v0, Lcom/glu/platform/android/resdl/GluUtil;->CF_BUTTON_SELECTED:Landroid/graphics/LightingColorFilter;

    :goto_0
    iget-object v2, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluButton;->m_wrappedLabel:Ljava/util/Vector;

    iget-object v3, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluButton;->m_paint:Landroid/graphics/Paint;

    invoke-static {p1, v1, v0, v2, v3}, Lcom/glu/platform/android/resdl/GluUtil;->paintButton(Landroid/graphics/Canvas;Landroid/graphics/Rect;Landroid/graphics/ColorFilter;Ljava/util/Vector;Landroid/graphics/Paint;)V

    return-void

    :cond_0
    sget-object v0, Lcom/glu/platform/android/resdl/GluUtil;->CF_BUTTON_DEFAULT:Landroid/graphics/LightingColorFilter;

    goto :goto_0
.end method

.method public final setBounds(IIII)V
    .locals 2

    const/16 v0, 0x3d

    invoke-static {v0}, Lcom/glu/platform/android/resdl/GluUtil;->scaleRelativeToG1(I)I

    move-result v0

    invoke-super {p0, p1, p2, p3, v0}, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluWidget;->setBounds(IIII)V

    iget-object v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluButton;->m_rectBounds:Landroid/graphics/Rect;

    iget v1, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluButton;->m_x:I

    iput v1, v0, Landroid/graphics/Rect;->left:I

    iget-object v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluButton;->m_rectBounds:Landroid/graphics/Rect;

    iget v1, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluButton;->m_y:I

    iput v1, v0, Landroid/graphics/Rect;->top:I

    iget-object v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluButton;->m_rectBounds:Landroid/graphics/Rect;

    iget v1, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluButton;->m_dx:I

    iput v1, v0, Landroid/graphics/Rect;->right:I

    iget-object v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluButton;->m_rectBounds:Landroid/graphics/Rect;

    iget v1, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluButton;->m_dy:I

    iput v1, v0, Landroid/graphics/Rect;->bottom:I

    iget-object v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluButton;->m_label:Ljava/lang/String;

    iget-object v1, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluButton;->m_paint:Landroid/graphics/Paint;

    invoke-static {v0, p3, v1}, Lcom/glu/platform/android/resdl/GluUtil;->wrapText(Ljava/lang/String;ILandroid/graphics/Paint;)Ljava/util/Vector;

    move-result-object v0

    iput-object v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluButton;->m_wrappedLabel:Ljava/util/Vector;

    return-void
.end method

.method public final tick(I)V
    .locals 0

    return-void
.end method
