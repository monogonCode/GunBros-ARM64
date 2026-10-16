.class public Lcom/glu/android/iap/Debug$Watermark;
.super Landroid/view/View;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/glu/android/iap/Debug;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "Watermark"
.end annotation


# instance fields
.field private final BASE_ALPHA:I

.field private final BASE_COLOR:I

.field private final BASE_COLOR_SHADOW:I

.field private final FADE_TIMER:I

.field private m_fadeTimer:I

.field private m_forTheLoveOfGodDontReleaseThisBuildText:Ljava/lang/String;

.field private m_lastTickTime:J

.field private m_textPaint:Landroid/graphics/Paint;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 3

    const/16 v2, 0x2710

    invoke-direct {p0, p1}, Landroid/view/View;-><init>(Landroid/content/Context;)V

    iput v2, p0, Lcom/glu/android/iap/Debug$Watermark;->FADE_TIMER:I

    const v0, 0xffffff

    iput v0, p0, Lcom/glu/android/iap/Debug$Watermark;->BASE_COLOR:I

    const/4 v0, 0x0

    iput v0, p0, Lcom/glu/android/iap/Debug$Watermark;->BASE_COLOR_SHADOW:I

    const/16 v0, 0xc0

    iput v0, p0, Lcom/glu/android/iap/Debug$Watermark;->BASE_ALPHA:I

    const-wide v0, 0x7fffffffffffffffL

    iput-wide v0, p0, Lcom/glu/android/iap/Debug$Watermark;->m_lastTickTime:J

    iput v2, p0, Lcom/glu/android/iap/Debug$Watermark;->m_fadeTimer:I

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/glu/android/iap/Debug$Watermark;->m_textPaint:Landroid/graphics/Paint;

    const-string v0, "DEV BUILD Not for sale or distribution"

    iput-object v0, p0, Lcom/glu/android/iap/Debug$Watermark;->m_forTheLoveOfGodDontReleaseThisBuildText:Ljava/lang/String;

    return-void
.end method


# virtual methods
.method public onDraw(Landroid/graphics/Canvas;)V
    .locals 0

    return-void
.end method
