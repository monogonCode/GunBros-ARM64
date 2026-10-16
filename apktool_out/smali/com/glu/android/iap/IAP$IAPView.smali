.class public Lcom/glu/android/iap/IAP$IAPView;
.super Landroid/view/View;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/glu/android/iap/IAP;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "IAPView"
.end annotation


# instance fields
.field private BUTTON_BOTTOM_MARGIN:I

.field private BUTTON_CENTER_MARGIN:I

.field private BUTTON_HEIGHT:I

.field private BUTTON_WIDTH:I

.field private DIALOG_HEIGHT:I

.field private DIALOG_WIDTH:I

.field private FONT_SIZE:I

.field private ROUND_RECT_STROKE_WIDTH:I

.field private m_buttonNegativeRectBounds:Landroid/graphics/Rect;

.field private m_buttonNeutralRectBounds:Landroid/graphics/Rect;

.field private m_buttonPositiveRectBounds:Landroid/graphics/Rect;

.field private m_dialogTimer:I

.field private m_dialogType:I

.field private m_innerRectBounds:Landroid/graphics/RectF;

.field private m_lastTickTime:J

.field private m_outerRectBounds:Landroid/graphics/RectF;

.field private m_roundRectInnerPaint:Landroid/graphics/Paint;

.field private m_roundRectOuterPaint:Landroid/graphics/Paint;

.field private m_subviewMask:I

.field private m_subviewRects:[Landroid/graphics/Rect;

.field private m_textPaint:Landroid/graphics/Paint;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 5

    const/4 v2, 0x0

    const/4 v0, 0x0

    const/4 v4, -0x1

    const/4 v3, 0x1

    invoke-direct {p0, p1}, Landroid/view/View;-><init>(Landroid/content/Context;)V

    const/16 v1, 0x12

    iput v1, p0, Lcom/glu/android/iap/IAP$IAPView;->FONT_SIZE:I

    const/4 v1, 0x6

    iput v1, p0, Lcom/glu/android/iap/IAP$IAPView;->ROUND_RECT_STROKE_WIDTH:I

    const/16 v1, 0x118

    iput v1, p0, Lcom/glu/android/iap/IAP$IAPView;->DIALOG_WIDTH:I

    const/16 v1, 0x96

    iput v1, p0, Lcom/glu/android/iap/IAP$IAPView;->DIALOG_HEIGHT:I

    const/16 v1, 0x3c

    iput v1, p0, Lcom/glu/android/iap/IAP$IAPView;->BUTTON_WIDTH:I

    const/16 v1, 0x28

    iput v1, p0, Lcom/glu/android/iap/IAP$IAPView;->BUTTON_HEIGHT:I

    const/16 v1, 0xc

    iput v1, p0, Lcom/glu/android/iap/IAP$IAPView;->BUTTON_BOTTOM_MARGIN:I

    const/16 v1, 0x18

    iput v1, p0, Lcom/glu/android/iap/IAP$IAPView;->BUTTON_CENTER_MARGIN:I

    iput-object v2, p0, Lcom/glu/android/iap/IAP$IAPView;->m_textPaint:Landroid/graphics/Paint;

    iput-object v2, p0, Lcom/glu/android/iap/IAP$IAPView;->m_roundRectOuterPaint:Landroid/graphics/Paint;

    iput-object v2, p0, Lcom/glu/android/iap/IAP$IAPView;->m_roundRectInnerPaint:Landroid/graphics/Paint;

    iput v0, p0, Lcom/glu/android/iap/IAP$IAPView;->m_dialogTimer:I

    const-wide/16 v1, 0x0

    iput-wide v1, p0, Lcom/glu/android/iap/IAP$IAPView;->m_lastTickTime:J

    new-instance v1, Landroid/graphics/RectF;

    invoke-direct {v1}, Landroid/graphics/RectF;-><init>()V

    iput-object v1, p0, Lcom/glu/android/iap/IAP$IAPView;->m_innerRectBounds:Landroid/graphics/RectF;

    new-instance v1, Landroid/graphics/RectF;

    invoke-direct {v1}, Landroid/graphics/RectF;-><init>()V

    iput-object v1, p0, Lcom/glu/android/iap/IAP$IAPView;->m_outerRectBounds:Landroid/graphics/RectF;

    new-instance v1, Landroid/graphics/Rect;

    invoke-direct {v1}, Landroid/graphics/Rect;-><init>()V

    iput-object v1, p0, Lcom/glu/android/iap/IAP$IAPView;->m_buttonPositiveRectBounds:Landroid/graphics/Rect;

    new-instance v1, Landroid/graphics/Rect;

    invoke-direct {v1}, Landroid/graphics/Rect;-><init>()V

    iput-object v1, p0, Lcom/glu/android/iap/IAP$IAPView;->m_buttonNegativeRectBounds:Landroid/graphics/Rect;

    new-instance v1, Landroid/graphics/Rect;

    invoke-direct {v1}, Landroid/graphics/Rect;-><init>()V

    iput-object v1, p0, Lcom/glu/android/iap/IAP$IAPView;->m_buttonNeutralRectBounds:Landroid/graphics/Rect;

    iput v0, p0, Lcom/glu/android/iap/IAP$IAPView;->m_dialogType:I

    iput v0, p0, Lcom/glu/android/iap/IAP$IAPView;->m_subviewMask:I

    const/4 v1, 0x2

    new-array v1, v1, [Landroid/graphics/Rect;

    iput-object v1, p0, Lcom/glu/android/iap/IAP$IAPView;->m_subviewRects:[Landroid/graphics/Rect;

    :goto_0
    iget-object v1, p0, Lcom/glu/android/iap/IAP$IAPView;->m_subviewRects:[Landroid/graphics/Rect;

    array-length v1, v1

    if-ge v0, v1, :cond_0

    iget-object v1, p0, Lcom/glu/android/iap/IAP$IAPView;->m_subviewRects:[Landroid/graphics/Rect;

    new-instance v2, Landroid/graphics/Rect;

    invoke-direct {v2, v4, v4, v4, v4}, Landroid/graphics/Rect;-><init>(IIII)V

    aput-object v2, v1, v0

    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_0
    new-instance v0, Landroid/graphics/Paint;

    invoke-direct {v0}, Landroid/graphics/Paint;-><init>()V

    iput-object v0, p0, Lcom/glu/android/iap/IAP$IAPView;->m_textPaint:Landroid/graphics/Paint;

    iget-object v0, p0, Lcom/glu/android/iap/IAP$IAPView;->m_textPaint:Landroid/graphics/Paint;

    invoke-virtual {v0, v3}, Landroid/graphics/Paint;->setAntiAlias(Z)V

    iget-object v0, p0, Lcom/glu/android/iap/IAP$IAPView;->m_textPaint:Landroid/graphics/Paint;

    invoke-virtual {v0, v3}, Landroid/graphics/Paint;->setFilterBitmap(Z)V

    iget-object v0, p0, Lcom/glu/android/iap/IAP$IAPView;->m_textPaint:Landroid/graphics/Paint;

    iget v1, p0, Lcom/glu/android/iap/IAP$IAPView;->FONT_SIZE:I

    int-to-float v1, v1

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setTextSize(F)V

    iget-object v0, p0, Lcom/glu/android/iap/IAP$IAPView;->m_textPaint:Landroid/graphics/Paint;

    const v1, -0x3f000001    # -7.9999995f

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setColor(I)V

    iget-object v0, p0, Lcom/glu/android/iap/IAP$IAPView;->m_textPaint:Landroid/graphics/Paint;

    sget-object v1, Landroid/graphics/Paint$Align;->CENTER:Landroid/graphics/Paint$Align;

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setTextAlign(Landroid/graphics/Paint$Align;)V

    iget-object v0, p0, Lcom/glu/android/iap/IAP$IAPView;->m_textPaint:Landroid/graphics/Paint;

    invoke-virtual {v0, v3}, Landroid/graphics/Paint;->setFakeBoldText(Z)V

    new-instance v0, Landroid/graphics/Paint;

    invoke-direct {v0}, Landroid/graphics/Paint;-><init>()V

    iput-object v0, p0, Lcom/glu/android/iap/IAP$IAPView;->m_roundRectOuterPaint:Landroid/graphics/Paint;

    iget-object v0, p0, Lcom/glu/android/iap/IAP$IAPView;->m_roundRectOuterPaint:Landroid/graphics/Paint;

    invoke-virtual {v0, v3}, Landroid/graphics/Paint;->setAntiAlias(Z)V

    iget-object v0, p0, Lcom/glu/android/iap/IAP$IAPView;->m_roundRectOuterPaint:Landroid/graphics/Paint;

    iget v1, p0, Lcom/glu/android/iap/IAP$IAPView;->ROUND_RECT_STROKE_WIDTH:I

    int-to-float v1, v1

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStrokeWidth(F)V

    iget-object v0, p0, Lcom/glu/android/iap/IAP$IAPView;->m_roundRectOuterPaint:Landroid/graphics/Paint;

    const v1, -0x3fe45fc8

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setColor(I)V

    new-instance v0, Landroid/graphics/Paint;

    invoke-direct {v0}, Landroid/graphics/Paint;-><init>()V

    iput-object v0, p0, Lcom/glu/android/iap/IAP$IAPView;->m_roundRectInnerPaint:Landroid/graphics/Paint;

    iget-object v0, p0, Lcom/glu/android/iap/IAP$IAPView;->m_roundRectInnerPaint:Landroid/graphics/Paint;

    invoke-virtual {v0, v3}, Landroid/graphics/Paint;->setAntiAlias(Z)V

    iget-object v0, p0, Lcom/glu/android/iap/IAP$IAPView;->m_roundRectInnerPaint:Landroid/graphics/Paint;

    iget v1, p0, Lcom/glu/android/iap/IAP$IAPView;->ROUND_RECT_STROKE_WIDTH:I

    int-to-float v1, v1

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStrokeWidth(F)V

    iget-object v0, p0, Lcom/glu/android/iap/IAP$IAPView;->m_roundRectInnerPaint:Landroid/graphics/Paint;

    const v1, -0x3fd400a7

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setColor(I)V

    return-void
.end method


# virtual methods
.method public onDraw(Landroid/graphics/Canvas;)V
    .locals 0

    return-void
.end method

.method public onWindowVisibilityChanged(I)V
    .locals 2

    invoke-super {p0, p1}, Landroid/view/View;->onWindowVisibilityChanged(I)V

    const/4 v0, 0x4

    if-ne p1, v0, :cond_1

    const/4 v0, 0x0

    iput v0, p0, Lcom/glu/android/iap/IAP$IAPView;->m_dialogTimer:I

    :cond_0
    :goto_0
    return-void

    :cond_1
    if-nez p1, :cond_0

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    iput-wide v0, p0, Lcom/glu/android/iap/IAP$IAPView;->m_lastTickTime:J

    goto :goto_0
.end method

.method public setSubviewBounds(IIIII)V
    .locals 1

    iget-object v0, p0, Lcom/glu/android/iap/IAP$IAPView;->m_subviewRects:[Landroid/graphics/Rect;

    aget-object v0, v0, p1

    iput p2, v0, Landroid/graphics/Rect;->left:I

    iget-object v0, p0, Lcom/glu/android/iap/IAP$IAPView;->m_subviewRects:[Landroid/graphics/Rect;

    aget-object v0, v0, p1

    iput p3, v0, Landroid/graphics/Rect;->top:I

    iget-object v0, p0, Lcom/glu/android/iap/IAP$IAPView;->m_subviewRects:[Landroid/graphics/Rect;

    aget-object v0, v0, p1

    iput p4, v0, Landroid/graphics/Rect;->right:I

    iget-object v0, p0, Lcom/glu/android/iap/IAP$IAPView;->m_subviewRects:[Landroid/graphics/Rect;

    aget-object v0, v0, p1

    iput p5, v0, Landroid/graphics/Rect;->bottom:I

    return-void
.end method

.method public setSubviewVisible(IZ)V
    .locals 6

    const/4 v1, 0x1

    const/4 v2, -0x1

    if-eqz p2, :cond_0

    iget v0, p0, Lcom/glu/android/iap/IAP$IAPView;->m_subviewMask:I

    shl-int/2addr v1, p1

    or-int/2addr v0, v1

    iput v0, p0, Lcom/glu/android/iap/IAP$IAPView;->m_subviewMask:I

    :goto_0
    return-void

    :cond_0
    iget v0, p0, Lcom/glu/android/iap/IAP$IAPView;->m_subviewMask:I

    shl-int/2addr v1, p1

    xor-int/lit8 v1, v1, -0x1

    and-int/2addr v0, v1

    iput v0, p0, Lcom/glu/android/iap/IAP$IAPView;->m_subviewMask:I

    move-object v0, p0

    move v1, p1

    move v3, v2

    move v4, v2

    move v5, v2

    invoke-virtual/range {v0 .. v5}, Lcom/glu/android/iap/IAP$IAPView;->setSubviewBounds(IIIII)V

    goto :goto_0
.end method
