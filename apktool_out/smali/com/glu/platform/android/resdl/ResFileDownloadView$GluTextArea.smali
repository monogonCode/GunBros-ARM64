.class public final Lcom/glu/platform/android/resdl/ResFileDownloadView$GluTextArea;
.super Lcom/glu/platform/android/resdl/ResFileDownloadView$GluWidget;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/glu/platform/android/resdl/ResFileDownloadView;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "GluTextArea"
.end annotation


# instance fields
.field public m_paint:Landroid/graphics/Paint;

.field public m_text:Ljava/lang/String;

.field public m_wrappedText:Ljava/util/Vector;
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
.method public constructor <init>(Ljava/lang/String;)V
    .locals 2

    sget-object v0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->instance:Lcom/glu/platform/android/resdl/ResFileDownloadView;

    const/4 v1, -0x1

    invoke-direct {p0, v0, v1}, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluWidget;-><init>(Lcom/glu/platform/android/resdl/ResFileDownloadView;I)V

    iput-object p1, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluTextArea;->m_text:Ljava/lang/String;

    sget-object v0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->instance:Lcom/glu/platform/android/resdl/ResFileDownloadView;

    iget-object v0, v0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_textAreaPaint:Landroid/graphics/Paint;

    iput-object v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluTextArea;->m_paint:Landroid/graphics/Paint;

    return-void
.end method


# virtual methods
.method public final draw(Landroid/graphics/Canvas;)V
    .locals 8

    iget-object v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluTextArea;->m_paint:Landroid/graphics/Paint;

    invoke-virtual {v0}, Landroid/graphics/Paint;->getTextSize()F

    move-result v2

    iget-object v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluTextArea;->m_wrappedText:Ljava/util/Vector;

    invoke-virtual {v0}, Ljava/util/Vector;->size()I

    move-result v3

    iget v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluTextArea;->m_y:I

    iget v1, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluTextArea;->m_dy:I

    iget v4, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluTextArea;->m_y:I

    sub-int/2addr v1, v4

    div-int/lit8 v1, v1, 0x2

    add-int/2addr v0, v1

    int-to-float v4, v0

    const/4 v0, 0x0

    move v1, v0

    :goto_0
    if-ge v1, v3, :cond_0

    iget-object v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluTextArea;->m_wrappedText:Ljava/util/Vector;

    invoke-virtual {v0, v1}, Ljava/util/Vector;->elementAt(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    iget v5, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluTextArea;->m_x:I

    iget v6, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluTextArea;->m_dx:I

    iget v7, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluTextArea;->m_x:I

    sub-int/2addr v6, v7

    div-int/lit8 v6, v6, 0x2

    add-int/2addr v5, v6

    int-to-float v5, v5

    int-to-float v6, v1

    mul-float/2addr v6, v2

    add-float/2addr v6, v4

    const/high16 v7, 0x40000000    # 2.0f

    div-float v7, v2, v7

    add-float/2addr v6, v7

    iget-object v7, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluTextArea;->m_paint:Landroid/graphics/Paint;

    invoke-virtual {p1, v0, v5, v6, v7}, Landroid/graphics/Canvas;->drawText(Ljava/lang/String;FFLandroid/graphics/Paint;)V

    add-int/lit8 v0, v1, 0x1

    move v1, v0

    goto :goto_0

    :cond_0
    return-void
.end method

.method public final setBounds(IIII)V
    .locals 2

    invoke-super {p0, p1, p2, p3, p4}, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluWidget;->setBounds(IIII)V

    iget-object v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluTextArea;->m_text:Ljava/lang/String;

    iget-object v1, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluTextArea;->m_paint:Landroid/graphics/Paint;

    invoke-static {v0, p3, v1}, Lcom/glu/platform/android/resdl/GluUtil;->wrapText(Ljava/lang/String;ILandroid/graphics/Paint;)Ljava/util/Vector;

    move-result-object v0

    iput-object v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluTextArea;->m_wrappedText:Ljava/util/Vector;

    return-void
.end method

.method public final tick(I)V
    .locals 0

    return-void
.end method
