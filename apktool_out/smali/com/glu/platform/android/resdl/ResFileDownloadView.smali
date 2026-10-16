.class public Lcom/glu/platform/android/resdl/ResFileDownloadView;
.super Landroid/view/View;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/glu/platform/android/resdl/ResFileDownloadView$GluTooltip;,
        Lcom/glu/platform/android/resdl/ResFileDownloadView$GluTitlebar;,
        Lcom/glu/platform/android/resdl/ResFileDownloadView$GluButton;,
        Lcom/glu/platform/android/resdl/ResFileDownloadView$GluTextArea;,
        Lcom/glu/platform/android/resdl/ResFileDownloadView$GluWidget;
    }
.end annotation


# static fields
.field public static FONT_SIZE:I

.field public static MARGIN:I

.field public static TOOLTIP_PADDING:I

.field public static instance:Lcom/glu/platform/android/resdl/ResFileDownloadView;


# instance fields
.field private gameStarted:Z

.field public m_activeWidget:Lcom/glu/platform/android/resdl/ResFileDownloadView$GluWidget;

.field public m_annunciatorBarHeight:I

.field public m_backPressed:Z

.field public m_buttonPaint:Landroid/graphics/Paint;

.field public m_bytesDownloaded:I

.field public m_checksumDone:Z

.field public m_checksumError:Ljava/lang/String;

.field public m_checksumInProgress:Z

.field public m_checksumPassed:Z

.field public m_deleteMessage:Ljava/lang/String;

.field public m_downloadCancelled:Z

.field public m_downloadDone:Z

.field public m_downloadError:Ljava/lang/String;

.field public m_downloadFailed:Z

.field public m_downloadFilename:Ljava/lang/String;

.field public m_downloadToDisk:Z

.field public m_heightNeedsCorrection:Z

.field public m_lastTickTime:J

.field public m_marqueePaint:Landroid/graphics/Paint;

.field public m_mutedLogoImg:Landroid/graphics/drawable/Drawable;

.field public m_pointerLatched:Z

.field public m_preparingTimer:I

.field public m_prevState:I

.field public m_screenHeight:I

.field public m_screenWidth:I

.field private m_sdButtonNegative:I

.field private m_sdButtonPositive:I

.field private m_sdErrorText:Ljava/lang/String;

.field private m_showedWiFiPopup:Z

.field public m_specialCheckPassed:Z

.field public m_state:I

.field public m_tempFilename:Ljava/lang/String;

.field public m_textAreaPaint:Landroid/graphics/Paint;

.field public m_titlebarPaint:Landroid/graphics/Paint;

.field public m_tooltipColorFilter:Landroid/graphics/LightingColorFilter;

.field public m_tooltipImg:Landroid/graphics/drawable/Drawable;

.field public m_usesAltSDCardPath:Z

.field public m_widgets:Ljava/util/Vector;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Vector",
            "<",
            "Lcom/glu/platform/android/resdl/ResFileDownloadView$GluWidget;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 1

    const/16 v0, 0x18

    sput v0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->FONT_SIZE:I

    const/4 v0, 0x6

    sput v0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->MARGIN:I

    const/16 v0, 0x14

    sput v0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->TOOLTIP_PADDING:I

    const/4 v0, 0x0

    sput-object v0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->instance:Lcom/glu/platform/android/resdl/ResFileDownloadView;

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;)V
    .locals 5

    const/4 v4, -0x1

    const/4 v3, -0x2

    const/4 v2, 0x0

    const/4 v1, 0x0

    invoke-direct {p0, p1}, Landroid/view/View;-><init>(Landroid/content/Context;)V

    new-instance v0, Ljava/util/Vector;

    invoke-direct {v0}, Ljava/util/Vector;-><init>()V

    iput-object v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_widgets:Ljava/util/Vector;

    iput-object v2, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_activeWidget:Lcom/glu/platform/android/resdl/ResFileDownloadView$GluWidget;

    iput v4, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_state:I

    iput v4, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_prevState:I

    iput-boolean v1, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_backPressed:Z

    iput-boolean v1, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_pointerLatched:Z

    iput-boolean v1, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_downloadDone:Z

    iput-boolean v1, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_downloadFailed:Z

    iput-boolean v1, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_downloadToDisk:Z

    iput-boolean v1, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_downloadCancelled:Z

    iput v1, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_bytesDownloaded:I

    iput-object v2, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_downloadFilename:Ljava/lang/String;

    iput-object v2, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_tempFilename:Ljava/lang/String;

    iput-boolean v1, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_checksumInProgress:Z

    iput-boolean v1, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_checksumPassed:Z

    iput-boolean v1, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_specialCheckPassed:Z

    iput-boolean v1, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_checksumDone:Z

    iput-boolean v1, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_usesAltSDCardPath:Z

    iput-object v2, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_mutedLogoImg:Landroid/graphics/drawable/Drawable;

    iput-object v2, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_titlebarPaint:Landroid/graphics/Paint;

    iput-object v2, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_buttonPaint:Landroid/graphics/Paint;

    iput-object v2, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_textAreaPaint:Landroid/graphics/Paint;

    iput-object v2, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_marqueePaint:Landroid/graphics/Paint;

    iput-object v2, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_checksumError:Ljava/lang/String;

    iput-object v2, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_downloadError:Ljava/lang/String;

    iput-object v2, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_deleteMessage:Ljava/lang/String;

    iput-object v2, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_tooltipImg:Landroid/graphics/drawable/Drawable;

    iput-object v2, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_tooltipColorFilter:Landroid/graphics/LightingColorFilter;

    iput v1, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_preparingTimer:I

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_heightNeedsCorrection:Z

    iput v1, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_annunciatorBarHeight:I

    iput-boolean v1, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->gameStarted:Z

    iput-object v2, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_sdErrorText:Ljava/lang/String;

    iput v3, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_sdButtonPositive:I

    iput v3, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_sdButtonNegative:I

    iput-boolean v1, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_showedWiFiPopup:Z

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    iput-wide v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_lastTickTime:J

    const v0, 0x42424f

    invoke-virtual {p0, v0}, Lcom/glu/platform/android/resdl/ResFileDownloadView;->setId(I)V

    return-void
.end method

.method private createPromptLayout(Ljava/lang/String;ILjava/lang/String;ILjava/lang/String;)V
    .locals 8

    const/4 v7, 0x0

    invoke-direct {p0}, Lcom/glu/platform/android/resdl/ResFileDownloadView;->getUsableY()I

    move-result v0

    iget v1, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_screenHeight:I

    sub-int/2addr v1, v0

    mul-int/lit8 v1, v1, 0x2

    div-int/lit8 v1, v1, 0x3

    add-int/2addr v1, v0

    iget v2, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_screenWidth:I

    shr-int/lit8 v2, v2, 0x1

    new-instance v3, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluTextArea;

    invoke-direct {v3, p1}, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluTextArea;-><init>(Ljava/lang/String;)V

    sget v4, Lcom/glu/platform/android/resdl/ResFileDownloadView;->MARGIN:I

    iget v5, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_screenWidth:I

    sget v6, Lcom/glu/platform/android/resdl/ResFileDownloadView;->MARGIN:I

    shl-int/lit8 v6, v6, 0x1

    sub-int/2addr v5, v6

    sub-int v6, v1, v0

    invoke-virtual {v3, v4, v0, v5, v6}, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluTextArea;->setBounds(IIII)V

    iget-object v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_widgets:Ljava/util/Vector;

    invoke-virtual {v0, v3}, Ljava/util/Vector;->addElement(Ljava/lang/Object;)V

    new-instance v0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluButton;

    invoke-direct {v0, p3, p2}, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluButton;-><init>(Ljava/lang/String;I)V

    sget v3, Lcom/glu/platform/android/resdl/ResFileDownloadView;->MARGIN:I

    sget v4, Lcom/glu/platform/android/resdl/ResFileDownloadView;->MARGIN:I

    shl-int/lit8 v4, v4, 0x1

    sub-int v4, v2, v4

    invoke-virtual {v0, v3, v1, v4, v7}, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluButton;->setBounds(IIII)V

    iget-object v3, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_widgets:Ljava/util/Vector;

    invoke-virtual {v3, v0}, Ljava/util/Vector;->addElement(Ljava/lang/Object;)V

    new-instance v0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluButton;

    invoke-direct {v0, p5, p4}, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluButton;-><init>(Ljava/lang/String;I)V

    sget v3, Lcom/glu/platform/android/resdl/ResFileDownloadView;->MARGIN:I

    add-int/2addr v3, v2

    sget v4, Lcom/glu/platform/android/resdl/ResFileDownloadView;->MARGIN:I

    shl-int/lit8 v4, v4, 0x1

    sub-int/2addr v2, v4

    invoke-virtual {v0, v3, v1, v2, v7}, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluButton;->setBounds(IIII)V

    iget-object v1, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_widgets:Ljava/util/Vector;

    invoke-virtual {v1, v0}, Ljava/util/Vector;->addElement(Ljava/lang/Object;)V

    return-void
.end method

.method private createTextOnlyLayout(Ljava/lang/String;)V
    .locals 5

    invoke-direct {p0}, Lcom/glu/platform/android/resdl/ResFileDownloadView;->getUsableY()I

    move-result v0

    new-instance v1, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluTextArea;

    invoke-direct {v1, p1}, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluTextArea;-><init>(Ljava/lang/String;)V

    sget v2, Lcom/glu/platform/android/resdl/ResFileDownloadView;->MARGIN:I

    iget v3, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_screenWidth:I

    sget v4, Lcom/glu/platform/android/resdl/ResFileDownloadView;->MARGIN:I

    shl-int/lit8 v4, v4, 0x1

    sub-int/2addr v3, v4

    iget v4, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_screenHeight:I

    sub-int/2addr v4, v0

    invoke-virtual {v1, v2, v0, v3, v4}, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluTextArea;->setBounds(IIII)V

    iget-object v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_widgets:Ljava/util/Vector;

    invoke-virtual {v0, v1}, Ljava/util/Vector;->addElement(Ljava/lang/Object;)V

    return-void
.end method

.method private static deleteResFile()V
    .locals 2

    new-instance v0, Ljava/io/File;

    invoke-static {}, Lcom/glu/platform/android/resdl/GluUtil;->getDiskFilename()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-virtual {v0}, Ljava/io/File;->delete()Z

    :cond_0
    :goto_0
    return-void

    :cond_1
    new-instance v0, Ljava/io/File;

    invoke-static {}, Lcom/glu/platform/android/resdl/GluUtil;->getPrimaryResSDCardFilename()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-virtual {v0}, Ljava/io/File;->delete()Z

    goto :goto_0
.end method

.method private getAllFilesBytesDownloaded$134621()I
    .locals 2

    sget-object v0, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->instance:Lcom/glu/platform/android/resdl/GluDownloadResMgr;

    invoke-virtual {v0}, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->specialChecksumPassed()Z

    move-result v0

    if-eqz v0, :cond_0

    iget v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_bytesDownloaded:I

    :goto_0
    sget-object v1, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->instance:Lcom/glu/platform/android/resdl/GluDownloadResMgr;

    invoke-static {}, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->areThereSpecialFiles()Z

    return v0

    :cond_0
    sget-object v0, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->instance:Lcom/glu/platform/android/resdl/GluDownloadResMgr;

    invoke-virtual {v0}, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->getSpecialFilePartDownloaded()I

    move-result v0

    goto :goto_0
.end method

.method private static getAllFilesBytesTotal()I
    .locals 2

    const/4 v0, 0x0

    sget-object v1, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->instance:Lcom/glu/platform/android/resdl/GluDownloadResMgr;

    invoke-virtual {v1}, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->specialChecksumPassed()Z

    move-result v1

    if-nez v1, :cond_1

    sget-object v0, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->instance:Lcom/glu/platform/android/resdl/GluDownloadResMgr;

    invoke-virtual {v0}, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->getSpecialFilePartTotal()I

    move-result v0

    add-int/lit8 v0, v0, 0x0

    :cond_0
    :goto_0
    return v0

    :cond_1
    sget-object v1, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->instance:Lcom/glu/platform/android/resdl/GluDownloadResMgr;

    invoke-static {}, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->areThereSpecialFiles()Z

    move-result v1

    if-eqz v1, :cond_0

    sget-object v0, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->instance:Lcom/glu/platform/android/resdl/GluDownloadResMgr;

    invoke-static {}, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->getSpecialFileSize()I

    move-result v0

    add-int/lit8 v0, v0, 0x0

    goto :goto_0
.end method

.method private static getSDButtonText(I)Ljava/lang/String;
    .locals 1

    const/16 v0, 0x11

    if-ne p0, v0, :cond_0

    const v0, 0x7f060061

    invoke-static {v0}, Lcom/glu/platform/android/resdl/GluUtil;->getString(I)Ljava/lang/String;

    move-result-object v0

    :goto_0
    return-object v0

    :cond_0
    const/16 v0, 0x12

    if-ne p0, v0, :cond_1

    const v0, 0x7f060060

    invoke-static {v0}, Lcom/glu/platform/android/resdl/GluUtil;->getString(I)Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    :cond_1
    const/16 v0, 0x13

    if-ne p0, v0, :cond_2

    const v0, 0x7f060062

    invoke-static {v0}, Lcom/glu/platform/android/resdl/GluUtil;->getString(I)Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    :cond_2
    const-string v0, "null"

    goto :goto_0
.end method

.method private getUsableY()I
    .locals 2

    const/4 v0, 0x0

    iget-object v1, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_widgets:Ljava/util/Vector;

    invoke-virtual {v1}, Ljava/util/Vector;->size()I

    move-result v1

    if-nez v1, :cond_0

    :goto_0
    return v0

    :cond_0
    iget-object v1, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_widgets:Ljava/util/Vector;

    invoke-virtual {v1, v0}, Ljava/util/Vector;->elementAt(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluWidget;

    iget v0, v0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluWidget;->m_dy:I

    goto :goto_0
.end method

.method private static resourceIsOnDisk()Z
    .locals 2

    new-instance v0, Ljava/io/File;

    invoke-static {}, Lcom/glu/platform/android/resdl/GluUtil;->getDiskFilename()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-virtual {v0}, Ljava/io/File;->isDirectory()Z

    move-result v0

    if-nez v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method private showWiFiPopup()V
    .locals 3

    iget-boolean v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_showedWiFiPopup:Z

    if-nez v0, :cond_0

    invoke-static {}, Lcom/glu/platform/android/resdl/GluUtil;->isUserOnWiFi()Z

    move-result v0

    if-nez v0, :cond_0

    const v0, 0x7f060067

    invoke-static {v0}, Lcom/glu/platform/android/resdl/GluUtil;->getString(I)Ljava/lang/String;

    move-result-object v0

    const v1, 0x7f060068

    invoke-static {v1}, Lcom/glu/platform/android/resdl/GluUtil;->getString(I)Ljava/lang/String;

    move-result-object v1

    const v2, 0x7f06002e

    invoke-static {v2}, Lcom/glu/platform/android/resdl/GluUtil;->getString(I)Ljava/lang/String;

    move-result-object v2

    invoke-static {v0, v1, v2}, Lcom/glu/platform/android/resdl/GluUtil;->openModalDialog(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_showedWiFiPopup:Z

    :cond_0
    return-void
.end method


# virtual methods
.method public final init(II)V
    .locals 6

    const/high16 v5, -0x1000000

    const/4 v2, 0x0

    const/4 v4, -0x1

    const/4 v1, 0x1

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "~~ init("

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v3, ", "

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v3, ")"

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/glu/platform/android/resdl/Debug;->log(Ljava/lang/String;)V

    sget-object v0, Lcom/glu/platform/android/GluPlatformActivity;->instance:Lcom/glu/platform/android/GluPlatformActivity;

    iput p2, v0, Lcom/glu/platform/android/GluPlatformActivity;->displayHeight:I

    const/16 v0, 0x18

    invoke-static {v0}, Lcom/glu/platform/android/resdl/GluUtil;->scaleRelativeToDroid(I)I

    move-result v0

    sput v0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->FONT_SIZE:I

    const/4 v0, 0x6

    invoke-static {v0}, Lcom/glu/platform/android/resdl/GluUtil;->scaleRelativeToDroid(I)I

    move-result v0

    sput v0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->MARGIN:I

    const/16 v0, 0x27

    invoke-static {v0}, Lcom/glu/platform/android/resdl/GluUtil;->scaleRelativeToDroid(I)I

    move-result v0

    sput v0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->TOOLTIP_PADDING:I

    sput-object p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->instance:Lcom/glu/platform/android/resdl/ResFileDownloadView;

    iput p1, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_screenWidth:I

    iput p2, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_screenHeight:I

    sget-object v0, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->instance:Lcom/glu/platform/android/resdl/GluDownloadResMgr;

    iget-boolean v0, v0, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->m_mainResFileInterrupted:Z

    invoke-static {}, Lcom/glu/platform/android/resdl/ResFileDownloadView;->resourceIsOnDisk()Z

    move-result v0

    if-eqz v0, :cond_0

    iput-boolean v1, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_downloadToDisk:Z

    :goto_0
    const v0, 0x7f020004

    invoke-static {v0}, Lcom/glu/platform/android/resdl/GluUtil;->getDrawable(I)Landroid/graphics/drawable/Drawable;

    move-result-object v0

    iput-object v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_mutedLogoImg:Landroid/graphics/drawable/Drawable;

    const v0, 0x7f020005

    invoke-static {v0}, Lcom/glu/platform/android/resdl/GluUtil;->getDrawable(I)Landroid/graphics/drawable/Drawable;

    move-result-object v0

    iput-object v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_tooltipImg:Landroid/graphics/drawable/Drawable;

    new-instance v0, Landroid/graphics/LightingColorFilter;

    const/16 v2, -0x8ea

    invoke-direct {v0, v5, v2}, Landroid/graphics/LightingColorFilter;-><init>(II)V

    iput-object v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_tooltipColorFilter:Landroid/graphics/LightingColorFilter;

    new-instance v0, Landroid/graphics/Paint;

    invoke-direct {v0}, Landroid/graphics/Paint;-><init>()V

    iput-object v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_titlebarPaint:Landroid/graphics/Paint;

    iget-object v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_titlebarPaint:Landroid/graphics/Paint;

    const/16 v2, 0x20

    invoke-virtual {v0, v2}, Landroid/graphics/Paint;->setFlags(I)V

    iget-object v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_titlebarPaint:Landroid/graphics/Paint;

    invoke-virtual {v0, v4}, Landroid/graphics/Paint;->setColor(I)V

    iget-object v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_titlebarPaint:Landroid/graphics/Paint;

    sget v2, Lcom/glu/platform/android/resdl/ResFileDownloadView;->FONT_SIZE:I

    int-to-float v2, v2

    invoke-virtual {v0, v2}, Landroid/graphics/Paint;->setTextSize(F)V

    iget-object v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_titlebarPaint:Landroid/graphics/Paint;

    sget-object v2, Landroid/graphics/Paint$Align;->LEFT:Landroid/graphics/Paint$Align;

    invoke-virtual {v0, v2}, Landroid/graphics/Paint;->setTextAlign(Landroid/graphics/Paint$Align;)V

    iget-object v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_titlebarPaint:Landroid/graphics/Paint;

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setFilterBitmap(Z)V

    iget-object v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_titlebarPaint:Landroid/graphics/Paint;

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setAntiAlias(Z)V

    new-instance v0, Landroid/graphics/Paint;

    invoke-direct {v0}, Landroid/graphics/Paint;-><init>()V

    iput-object v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_buttonPaint:Landroid/graphics/Paint;

    iget-object v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_buttonPaint:Landroid/graphics/Paint;

    invoke-virtual {v0, v5}, Landroid/graphics/Paint;->setColor(I)V

    iget-object v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_buttonPaint:Landroid/graphics/Paint;

    sget v2, Lcom/glu/platform/android/resdl/ResFileDownloadView;->FONT_SIZE:I

    int-to-float v2, v2

    invoke-virtual {v0, v2}, Landroid/graphics/Paint;->setTextSize(F)V

    iget-object v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_buttonPaint:Landroid/graphics/Paint;

    sget-object v2, Landroid/graphics/Paint$Align;->CENTER:Landroid/graphics/Paint$Align;

    invoke-virtual {v0, v2}, Landroid/graphics/Paint;->setTextAlign(Landroid/graphics/Paint$Align;)V

    iget-object v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_buttonPaint:Landroid/graphics/Paint;

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setFilterBitmap(Z)V

    iget-object v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_buttonPaint:Landroid/graphics/Paint;

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setAntiAlias(Z)V

    new-instance v0, Landroid/graphics/Paint;

    invoke-direct {v0}, Landroid/graphics/Paint;-><init>()V

    iput-object v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_textAreaPaint:Landroid/graphics/Paint;

    iget-object v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_textAreaPaint:Landroid/graphics/Paint;

    invoke-virtual {v0, v4}, Landroid/graphics/Paint;->setColor(I)V

    iget-object v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_textAreaPaint:Landroid/graphics/Paint;

    sget v2, Lcom/glu/platform/android/resdl/ResFileDownloadView;->FONT_SIZE:I

    int-to-float v2, v2

    invoke-virtual {v0, v2}, Landroid/graphics/Paint;->setTextSize(F)V

    iget-object v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_textAreaPaint:Landroid/graphics/Paint;

    sget-object v2, Landroid/graphics/Paint$Align;->CENTER:Landroid/graphics/Paint$Align;

    invoke-virtual {v0, v2}, Landroid/graphics/Paint;->setTextAlign(Landroid/graphics/Paint$Align;)V

    iget-object v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_textAreaPaint:Landroid/graphics/Paint;

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setFilterBitmap(Z)V

    iget-object v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_textAreaPaint:Landroid/graphics/Paint;

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setAntiAlias(Z)V

    new-instance v0, Landroid/graphics/Paint;

    invoke-direct {v0}, Landroid/graphics/Paint;-><init>()V

    iput-object v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_marqueePaint:Landroid/graphics/Paint;

    iget-object v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_marqueePaint:Landroid/graphics/Paint;

    invoke-virtual {v0, v4}, Landroid/graphics/Paint;->setColor(I)V

    iget-object v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_marqueePaint:Landroid/graphics/Paint;

    sget v2, Lcom/glu/platform/android/resdl/ResFileDownloadView;->FONT_SIZE:I

    int-to-float v2, v2

    invoke-virtual {v0, v2}, Landroid/graphics/Paint;->setTextSize(F)V

    iget-object v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_marqueePaint:Landroid/graphics/Paint;

    sget-object v2, Landroid/graphics/Paint$Align;->LEFT:Landroid/graphics/Paint$Align;

    invoke-virtual {v0, v2}, Landroid/graphics/Paint;->setTextAlign(Landroid/graphics/Paint$Align;)V

    iget-object v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_marqueePaint:Landroid/graphics/Paint;

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setFilterBitmap(Z)V

    iget-object v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_marqueePaint:Landroid/graphics/Paint;

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setAntiAlias(Z)V

    invoke-virtual {p0, v1}, Lcom/glu/platform/android/resdl/ResFileDownloadView;->setFocusable(Z)V

    invoke-virtual {p0, v1}, Lcom/glu/platform/android/resdl/ResFileDownloadView;->setFocusableInTouchMode(Z)V

    return-void

    :cond_0
    new-instance v0, Ljava/io/File;

    invoke-static {}, Lcom/glu/platform/android/resdl/GluUtil;->getPrimaryResSDCardFilename()Ljava/lang/String;

    move-result-object v3

    invoke-direct {v0, v3}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v3

    if-eqz v3, :cond_1

    invoke-virtual {v0}, Ljava/io/File;->isDirectory()Z

    move-result v0

    if-nez v0, :cond_1

    move v0, v1

    :goto_1
    if-eqz v0, :cond_2

    iput-boolean v2, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_downloadToDisk:Z

    goto/16 :goto_0

    :cond_1
    move v0, v2

    goto :goto_1

    :cond_2
    sget-object v0, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->instance:Lcom/glu/platform/android/resdl/GluDownloadResMgr;

    iput-boolean v2, v0, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->m_mainResFileInterrupted:Z

    goto/16 :goto_0
.end method

.method public final newState(I)V
    .locals 13

    const/4 v6, 0x0

    const/4 v12, 0x5

    const/4 v7, 0x3

    const/4 v4, 0x1

    const/4 v2, 0x0

    move-object v0, p0

    :goto_0
    const/4 v1, -0x1

    if-ne p1, v1, :cond_0

    :goto_1
    return-void

    :cond_0
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "newState="

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/glu/platform/android/resdl/Debug;->log(Ljava/lang/String;)V

    iget-object v1, v0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_widgets:Ljava/util/Vector;

    invoke-virtual {v1}, Ljava/util/Vector;->size()I

    move-result v1

    if-lez v1, :cond_1

    iget-object v1, v0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_widgets:Ljava/util/Vector;

    invoke-virtual {v1, v2}, Ljava/util/Vector;->elementAt(I)Ljava/lang/Object;

    move-result-object v1

    instance-of v1, v1, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluTitlebar;

    if-nez v1, :cond_1

    iget-object v1, v0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_widgets:Ljava/util/Vector;

    invoke-virtual {v1}, Ljava/util/Vector;->removeAllElements()V

    :cond_1
    iget-object v1, v0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_widgets:Ljava/util/Vector;

    invoke-virtual {v1}, Ljava/util/Vector;->size()I

    move-result v1

    if-nez v1, :cond_5

    new-instance v1, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluTitlebar;

    const v3, 0x7f06002c

    invoke-static {v3}, Lcom/glu/platform/android/resdl/GluUtil;->getString(I)Ljava/lang/String;

    move-result-object v3

    invoke-direct {v1, v3}, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluTitlebar;-><init>(Ljava/lang/String;)V

    iget v3, v0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_screenWidth:I

    invoke-virtual {v1, v2, v2, v3, v2}, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluTitlebar;->setBounds(IIII)V

    iget-object v3, v0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_widgets:Ljava/util/Vector;

    invoke-virtual {v3, v1}, Ljava/util/Vector;->addElement(Ljava/lang/Object;)V

    :cond_2
    sparse-switch p1, :sswitch_data_0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "newState() unhandled state: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/glu/platform/android/resdl/Debug;->log(Ljava/lang/String;)V

    :cond_3
    :goto_2
    if-ne p1, v7, :cond_19

    sget v1, Lcom/glu/platform/android/resdl/GameLet$instance;->m_platformVersionI:I

    if-ge v1, v12, :cond_18

    const v1, 0x7f060064

    invoke-static {v1}, Lcom/glu/platform/android/resdl/GluUtil;->getString(I)Ljava/lang/String;

    move-result-object v1

    move-object v2, v1

    :goto_3
    if-eqz v2, :cond_4

    const/16 v1, 0x26

    invoke-static {v1}, Lcom/glu/platform/android/resdl/GluUtil;->scaleRelativeToG1(I)I

    move-result v3

    if-nez v3, :cond_1c

    sget v1, Lcom/glu/platform/android/resdl/ResFileDownloadView;->TOOLTIP_PADDING:I

    shr-int/lit8 v1, v1, 0x1

    :goto_4
    sget v4, Lcom/glu/platform/android/resdl/ResFileDownloadView;->TOOLTIP_PADDING:I

    new-instance v5, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluTooltip;

    invoke-direct {v5, v2}, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluTooltip;-><init>(Ljava/lang/String;)V

    invoke-static {}, Lcom/glu/platform/android/resdl/GluUtil;->getScreenWidth()I

    move-result v2

    iget-object v6, v0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_tooltipImg:Landroid/graphics/drawable/Drawable;

    invoke-virtual {v6}, Landroid/graphics/drawable/Drawable;->getIntrinsicWidth()I

    move-result v6

    sub-int/2addr v2, v6

    sub-int/2addr v2, v4

    add-int/2addr v1, v3

    iget-object v3, v0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_tooltipImg:Landroid/graphics/drawable/Drawable;

    invoke-virtual {v3}, Landroid/graphics/drawable/Drawable;->getIntrinsicWidth()I

    move-result v3

    iget-object v4, v0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_tooltipImg:Landroid/graphics/drawable/Drawable;

    invoke-virtual {v4}, Landroid/graphics/drawable/Drawable;->getIntrinsicHeight()I

    move-result v4

    invoke-virtual {v5, v2, v1, v3, v4}, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluTooltip;->setBounds(IIII)V

    iget-object v1, v0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_widgets:Ljava/util/Vector;

    invoke-virtual {v1, v5}, Ljava/util/Vector;->addElement(Ljava/lang/Object;)V

    :cond_4
    iget v1, v0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_state:I

    iput v1, v0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_prevState:I

    iput p1, v0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_state:I

    goto/16 :goto_1

    :cond_5
    :goto_5
    iget-object v1, v0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_widgets:Ljava/util/Vector;

    invoke-virtual {v1}, Ljava/util/Vector;->size()I

    move-result v1

    if-le v1, v4, :cond_2

    iget-object v1, v0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_widgets:Ljava/util/Vector;

    invoke-virtual {v1, v4}, Ljava/util/Vector;->removeElementAt(I)V

    goto :goto_5

    :sswitch_0
    sget-object v1, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->instance:Lcom/glu/platform/android/resdl/GluDownloadResMgr;

    invoke-virtual {v1}, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->performSpecialChecksumAsync()Z

    move-result v1

    if-eqz v1, :cond_6

    const/4 p1, 0x2

    goto/16 :goto_0

    :cond_6
    const v1, 0x7f06003c

    invoke-static {v1}, Lcom/glu/platform/android/resdl/GluUtil;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Lcom/glu/platform/android/resdl/ResFileDownloadView;->createTextOnlyLayout(Ljava/lang/String;)V

    goto :goto_2

    :sswitch_1
    iput-boolean v4, v0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_checksumPassed:Z

    iput-boolean v4, v0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_checksumDone:Z

    iput-boolean v2, v0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_specialCheckPassed:Z

    iget-boolean v1, v0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_specialCheckPassed:Z

    if-nez v1, :cond_9

    new-array v1, v7, [I

    sget-object v3, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->instance:Lcom/glu/platform/android/resdl/GluDownloadResMgr;

    invoke-static {v1}, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->getSpecialStartPosition([I)V

    aget v1, v1, v2

    if-gtz v1, :cond_7

    move p1, v7

    goto/16 :goto_0

    :cond_7
    sget-object v1, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->instance:Lcom/glu/platform/android/resdl/GluDownloadResMgr;

    invoke-virtual {v1}, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->verifySpecialFileIntegrity()Z

    move-result v1

    iput-boolean v1, v0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_specialCheckPassed:Z

    iget-boolean v1, v0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_specialCheckPassed:Z

    if-eqz v1, :cond_8

    sget-object v1, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->instance:Lcom/glu/platform/android/resdl/GluDownloadResMgr;

    iget-boolean v2, v0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_specialCheckPassed:Z

    invoke-virtual {v1, v2}, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->setSecondaryFilesPassed(Z)V

    goto/16 :goto_2

    :cond_8
    iget-boolean v1, v0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_specialCheckPassed:Z

    if-nez v1, :cond_3

    sget-object v1, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->instance:Lcom/glu/platform/android/resdl/GluDownloadResMgr;

    iget-boolean v1, v1, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->m_secondaryFilesPassedOnce:Z

    if-eqz v1, :cond_3

    sget-object v1, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->instance:Lcom/glu/platform/android/resdl/GluDownloadResMgr;

    invoke-virtual {v1, v2}, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->setSecondaryFilesPassed(Z)V

    sget-object v1, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->instance:Lcom/glu/platform/android/resdl/GluDownloadResMgr;

    invoke-virtual {v1}, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->wereSpecialFilesChecksummed()Z

    move-result v1

    if-nez v1, :cond_3

    sget-object v1, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->instance:Lcom/glu/platform/android/resdl/GluDownloadResMgr;

    invoke-static {}, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->deleteSpecialFiles()V

    goto/16 :goto_2

    :cond_9
    new-array v1, v7, [I

    sget-object v3, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->instance:Lcom/glu/platform/android/resdl/GluDownloadResMgr;

    invoke-static {v1}, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->getSpecialStartPosition([I)V

    aget v1, v1, v2

    if-gtz v1, :cond_3

    iput-boolean v2, v0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_specialCheckPassed:Z

    sget-object v1, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->instance:Lcom/glu/platform/android/resdl/GluDownloadResMgr;

    iget-boolean v1, v1, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->m_secondaryFilesPassedOnce:Z

    if-eqz v1, :cond_a

    sget-object v1, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->instance:Lcom/glu/platform/android/resdl/GluDownloadResMgr;

    invoke-virtual {v1}, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->wereSpecialFilesChecksummed()Z

    move-result v1

    if-nez v1, :cond_a

    sget-object v1, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->instance:Lcom/glu/platform/android/resdl/GluDownloadResMgr;

    invoke-static {}, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->deleteSpecialFiles()V

    :cond_a
    sget-object v1, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->instance:Lcom/glu/platform/android/resdl/GluDownloadResMgr;

    invoke-virtual {v1, v2}, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->setSecondaryFilesPassed(Z)V

    goto/16 :goto_2

    :sswitch_2
    iget v1, v0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_prevState:I

    if-ne v1, v4, :cond_b

    iget-object v1, v0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_checksumError:Ljava/lang/String;

    if-eqz v1, :cond_b

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v3, v0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_checksumError:Ljava/lang/String;

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v3, "\n"

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    :goto_6
    iget-boolean v3, v0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_checksumPassed:Z

    if-eqz v3, :cond_c

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const v1, 0x7f060041

    :goto_7
    invoke-static {v1}, Lcom/glu/platform/android/resdl/GluUtil;->getString(I)Ljava/lang/String;

    move-result-object v1

    new-array v5, v4, [Ljava/lang/Object;

    invoke-static {}, Lcom/glu/platform/android/resdl/ResFileDownloadView;->getAllFilesBytesTotal()I

    move-result v8

    invoke-static {v8}, Lcom/glu/platform/android/resdl/GluUtil;->getKilobyteString(I)Ljava/lang/String;

    move-result-object v8

    aput-object v8, v5, v2

    invoke-static {v1, v5}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const v3, 0x7f060042

    invoke-static {v3}, Lcom/glu/platform/android/resdl/GluUtil;->getString(I)Ljava/lang/String;

    move-result-object v3

    const v5, 0x7f060043

    invoke-static {v5}, Lcom/glu/platform/android/resdl/GluUtil;->getString(I)Ljava/lang/String;

    move-result-object v5

    invoke-direct/range {v0 .. v5}, Lcom/glu/platform/android/resdl/ResFileDownloadView;->createPromptLayout(Ljava/lang/String;ILjava/lang/String;ILjava/lang/String;)V

    goto/16 :goto_2

    :cond_b
    const-string v1, ""

    goto :goto_6

    :cond_c
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    sget-object v1, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->instance:Lcom/glu/platform/android/resdl/GluDownloadResMgr;

    invoke-static {}, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->areThereSpecialFiles()Z

    move-result v1

    if-eqz v1, :cond_d

    const v1, 0x7f060041

    goto :goto_7

    :cond_d
    const v1, 0x7f060040

    goto :goto_7

    :sswitch_3
    iget-object v1, v0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_downloadError:Ljava/lang/String;

    const/4 v2, 0x6

    const v3, 0x7f060033

    invoke-static {v3}, Lcom/glu/platform/android/resdl/GluUtil;->getString(I)Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x7

    const v5, 0x7f060034

    invoke-static {v5}, Lcom/glu/platform/android/resdl/GluUtil;->getString(I)Ljava/lang/String;

    move-result-object v5

    invoke-direct/range {v0 .. v5}, Lcom/glu/platform/android/resdl/ResFileDownloadView;->createPromptLayout(Ljava/lang/String;ILjava/lang/String;ILjava/lang/String;)V

    goto/16 :goto_2

    :sswitch_4
    invoke-direct {v0}, Lcom/glu/platform/android/resdl/ResFileDownloadView;->showWiFiPopup()V

    sget-object v1, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->instance:Lcom/glu/platform/android/resdl/GluDownloadResMgr;

    iget-boolean v1, v1, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->m_mainResFileInterrupted:Z

    if-eqz v1, :cond_10

    new-instance v1, Ljava/io/File;

    invoke-static {}, Lcom/glu/platform/android/resdl/GluUtil;->getDiskFilename()Ljava/lang/String;

    move-result-object v3

    invoke-direct {v1, v3}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1}, Ljava/io/File;->exists()Z

    move-result v3

    if-eqz v3, :cond_e

    invoke-virtual {v1}, Ljava/io/File;->length()J

    move-result-wide v8

    long-to-int v1, v8

    :goto_8
    iput v1, v0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_bytesDownloaded:I

    :goto_9
    const v1, 0x7f060044

    invoke-static {v1}, Lcom/glu/platform/android/resdl/GluUtil;->getString(I)Ljava/lang/String;

    move-result-object v3

    new-array v4, v4, [Ljava/lang/Object;

    invoke-static {}, Lcom/glu/platform/android/resdl/ResFileDownloadView;->getAllFilesBytesTotal()I

    move-result v1

    if-nez v1, :cond_11

    const-string v1, "0%"

    :goto_a
    aput-object v1, v4, v2

    invoke-static {v3, v4}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Lcom/glu/platform/android/resdl/ResFileDownloadView;->createTextOnlyLayout(Ljava/lang/String;)V

    iget-boolean v1, v0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_downloadToDisk:Z

    if-eqz v1, :cond_12

    invoke-static {}, Lcom/glu/platform/android/resdl/GluUtil;->getDiskFilename()Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_downloadFilename:Ljava/lang/String;

    invoke-static {}, Lcom/glu/platform/android/resdl/GluUtil;->getTempDiskFilename()Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_tempFilename:Ljava/lang/String;

    :goto_b
    iput-object v6, v0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_downloadError:Ljava/lang/String;

    iput-boolean v2, v0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_downloadDone:Z

    iput-boolean v2, v0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_downloadFailed:Z

    iput-boolean v2, v0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_downloadCancelled:Z

    sget-object v1, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->instance:Lcom/glu/platform/android/resdl/GluDownloadResMgr;

    invoke-virtual {v1}, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->downloadResFile()V

    goto/16 :goto_2

    :cond_e
    new-instance v1, Ljava/io/File;

    invoke-static {}, Lcom/glu/platform/android/resdl/GluUtil;->getPrimaryResSDCardFilename()Ljava/lang/String;

    move-result-object v3

    invoke-direct {v1, v3}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1}, Ljava/io/File;->exists()Z

    move-result v3

    if-eqz v3, :cond_f

    invoke-virtual {v1}, Ljava/io/File;->length()J

    move-result-wide v8

    long-to-int v1, v8

    goto :goto_8

    :cond_f
    move v1, v2

    goto :goto_8

    :cond_10
    iput v2, v0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_bytesDownloaded:I

    goto :goto_9

    :cond_11
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-wide/high16 v8, 0x4059000000000000L    # 100.0

    iget v5, v0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_state:I

    invoke-direct {v0}, Lcom/glu/platform/android/resdl/ResFileDownloadView;->getAllFilesBytesDownloaded$134621()I

    move-result v5

    int-to-double v10, v5

    mul-double/2addr v8, v10

    invoke-static {}, Lcom/glu/platform/android/resdl/ResFileDownloadView;->getAllFilesBytesTotal()I

    move-result v5

    int-to-double v10, v5

    div-double/2addr v8, v10

    double-to-int v5, v8

    invoke-virtual {v1, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v5, "%"

    invoke-virtual {v1, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    goto :goto_a

    :cond_12
    invoke-static {}, Lcom/glu/platform/android/resdl/GluUtil;->getPrimaryResSDCardFilename()Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_downloadFilename:Ljava/lang/String;

    invoke-static {}, Lcom/glu/platform/android/resdl/GluUtil;->getTempSDCardFilename()Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_tempFilename:Ljava/lang/String;

    goto :goto_b

    :sswitch_5
    invoke-direct {v0}, Lcom/glu/platform/android/resdl/ResFileDownloadView;->showWiFiPopup()V

    sget-object v1, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->instance:Lcom/glu/platform/android/resdl/GluDownloadResMgr;

    iput-object v6, v1, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->m_specialCurrentFilename:Ljava/lang/String;

    const-string v1, ""

    invoke-direct {v0, v1}, Lcom/glu/platform/android/resdl/ResFileDownloadView;->createTextOnlyLayout(Ljava/lang/String;)V

    iget-boolean v1, v0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_downloadToDisk:Z

    if-eqz v1, :cond_14

    invoke-static {}, Lcom/glu/platform/android/resdl/GluUtil;->getDiskFilename()Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_downloadFilename:Ljava/lang/String;

    invoke-static {}, Lcom/glu/platform/android/resdl/GluUtil;->getTempDiskFilename()Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_tempFilename:Ljava/lang/String;

    invoke-static {}, Lcom/glu/platform/android/resdl/GluUtil;->getPrimaryResSDCardFilename()Ljava/lang/String;

    move-result-object v1

    :goto_c
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Download filename is: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget-object v4, v0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_downloadFilename:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Lcom/glu/platform/android/resdl/Debug;->log(Ljava/lang/String;)V

    new-instance v3, Ljava/io/File;

    invoke-direct {v3, v1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v3}, Ljava/io/File;->exists()Z

    move-result v1

    if-eqz v1, :cond_13

    invoke-virtual {v3}, Ljava/io/File;->delete()Z

    :cond_13
    sget-object v1, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->instance:Lcom/glu/platform/android/resdl/GluDownloadResMgr;

    iget-object v1, v0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_downloadFilename:Ljava/lang/String;

    invoke-static {v1}, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->createDummyPrimaryResource(Ljava/lang/String;)V

    iput-object v6, v0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_downloadError:Ljava/lang/String;

    iput-boolean v2, v0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_downloadDone:Z

    iput-boolean v2, v0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_downloadFailed:Z

    iput-boolean v2, v0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_downloadCancelled:Z

    sget-object v1, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->instance:Lcom/glu/platform/android/resdl/GluDownloadResMgr;

    invoke-virtual {v1}, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->downloadSpecialResFile()V

    goto/16 :goto_2

    :cond_14
    invoke-static {}, Lcom/glu/platform/android/resdl/GluUtil;->getPrimaryResSDCardFilename()Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_downloadFilename:Ljava/lang/String;

    invoke-static {}, Lcom/glu/platform/android/resdl/GluUtil;->getTempSDCardFilename()Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_tempFilename:Ljava/lang/String;

    invoke-static {}, Lcom/glu/platform/android/resdl/GluUtil;->getDiskFilename()Ljava/lang/String;

    move-result-object v1

    goto :goto_c

    :sswitch_6
    const/16 v1, 0x2710

    iput v1, v0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_preparingTimer:I

    const v1, 0x7f060069

    invoke-static {v1}, Lcom/glu/platform/android/resdl/GluUtil;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Lcom/glu/platform/android/resdl/ResFileDownloadView;->createTextOnlyLayout(Ljava/lang/String;)V

    goto/16 :goto_2

    :sswitch_7
    iget-boolean v1, v0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_downloadToDisk:Z

    if-eqz v1, :cond_15

    const v1, 0x7f060042

    invoke-static {v1}, Lcom/glu/platform/android/resdl/GluUtil;->getString(I)Ljava/lang/String;

    move-result-object v1

    :goto_d
    sget-object v3, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->instance:Lcom/glu/platform/android/resdl/GluDownloadResMgr;

    invoke-virtual {v3}, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->wereSpecialFilesChecksummed()Z

    move-result v3

    if-eqz v3, :cond_16

    const v3, 0x7f060050

    :goto_e
    invoke-static {v3}, Lcom/glu/platform/android/resdl/GluUtil;->getString(I)Ljava/lang/String;

    move-result-object v3

    new-array v4, v4, [Ljava/lang/Object;

    aput-object v1, v4, v2

    invoke-static {v3, v4}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    const/16 v2, 0xa

    const v3, 0x7f060035

    invoke-static {v3}, Lcom/glu/platform/android/resdl/GluUtil;->getString(I)Ljava/lang/String;

    move-result-object v3

    const/16 v4, 0xb

    const v5, 0x7f060036

    invoke-static {v5}, Lcom/glu/platform/android/resdl/GluUtil;->getString(I)Ljava/lang/String;

    move-result-object v5

    invoke-direct/range {v0 .. v5}, Lcom/glu/platform/android/resdl/ResFileDownloadView;->createPromptLayout(Ljava/lang/String;ILjava/lang/String;ILjava/lang/String;)V

    goto/16 :goto_2

    :cond_15
    const v1, 0x7f060043

    invoke-static {v1}, Lcom/glu/platform/android/resdl/GluUtil;->getString(I)Ljava/lang/String;

    move-result-object v1

    goto :goto_d

    :cond_16
    const v3, 0x7f06004f

    goto :goto_e

    :sswitch_8
    const v1, 0x7f060051

    invoke-static {v1}, Lcom/glu/platform/android/resdl/GluUtil;->getString(I)Ljava/lang/String;

    move-result-object v1

    const/16 v2, 0x8

    const v3, 0x7f06002f

    invoke-static {v3}, Lcom/glu/platform/android/resdl/GluUtil;->getString(I)Ljava/lang/String;

    move-result-object v3

    const/16 v4, 0x9

    const v5, 0x7f060030

    invoke-static {v5}, Lcom/glu/platform/android/resdl/GluUtil;->getString(I)Ljava/lang/String;

    move-result-object v5

    invoke-direct/range {v0 .. v5}, Lcom/glu/platform/android/resdl/ResFileDownloadView;->createPromptLayout(Ljava/lang/String;ILjava/lang/String;ILjava/lang/String;)V

    goto/16 :goto_2

    :sswitch_9
    const/16 p1, 0xe

    goto/16 :goto_0

    :sswitch_a
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const v3, 0x7f060055

    invoke-static {v3}, Lcom/glu/platform/android/resdl/GluUtil;->getString(I)Ljava/lang/String;

    move-result-object v3

    new-array v4, v4, [Ljava/lang/Object;

    invoke-static {}, Lcom/glu/platform/android/resdl/ResFileDownloadView;->getAllFilesBytesTotal()I

    move-result v5

    invoke-static {v5}, Lcom/glu/platform/android/resdl/GluUtil;->getKilobyteString(I)Ljava/lang/String;

    move-result-object v5

    aput-object v5, v4, v2

    invoke-static {v3, v4}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ""

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x4

    const v3, 0x7f06002f

    invoke-static {v3}, Lcom/glu/platform/android/resdl/GluUtil;->getString(I)Ljava/lang/String;

    move-result-object v3

    const v4, 0x7f060030

    invoke-static {v4}, Lcom/glu/platform/android/resdl/GluUtil;->getString(I)Ljava/lang/String;

    move-result-object v5

    move v4, v12

    invoke-direct/range {v0 .. v5}, Lcom/glu/platform/android/resdl/ResFileDownloadView;->createPromptLayout(Ljava/lang/String;ILjava/lang/String;ILjava/lang/String;)V

    goto/16 :goto_2

    :sswitch_b
    sget-object v1, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->instance:Lcom/glu/platform/android/resdl/GluDownloadResMgr;

    invoke-virtual {v1, v2}, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->setSecondaryFilesPassed(Z)V

    sget-object v1, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->instance:Lcom/glu/platform/android/resdl/GluDownloadResMgr;

    invoke-static {}, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->deleteSpecialFiles()V

    new-instance v1, Ljava/io/File;

    invoke-static {}, Lcom/glu/platform/android/resdl/GluUtil;->getDiskFilename()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Deleting "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v1}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/glu/platform/android/resdl/Debug;->log(Ljava/lang/String;)V

    invoke-virtual {v1}, Ljava/io/File;->delete()Z

    move-result v1

    if-eqz v1, :cond_17

    const v1, 0x7f060056

    invoke-static {v1}, Lcom/glu/platform/android/resdl/GluUtil;->getString(I)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_deleteMessage:Ljava/lang/String;

    :goto_f
    iget-object v1, v0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_deleteMessage:Ljava/lang/String;

    invoke-direct {v0, v1}, Lcom/glu/platform/android/resdl/ResFileDownloadView;->createTextOnlyLayout(Ljava/lang/String;)V

    goto/16 :goto_2

    :cond_17
    const v1, 0x7f060057

    invoke-static {v1}, Lcom/glu/platform/android/resdl/GluUtil;->getString(I)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_deleteMessage:Ljava/lang/String;

    goto :goto_f

    :sswitch_c
    const/16 p1, 0xe

    goto/16 :goto_0

    :sswitch_d
    const-string v1, "new state play"

    invoke-static {v1}, Lcom/glu/platform/android/resdl/Debug;->log(Ljava/lang/String;)V

    goto/16 :goto_2

    :sswitch_e
    invoke-static {}, Lcom/glu/platform/android/resdl/GameLet$instance;->finishApp()V

    goto/16 :goto_2

    :sswitch_f
    iget-object v1, v0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_sdErrorText:Ljava/lang/String;

    iget v2, v0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_sdButtonPositive:I

    iget v3, v0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_sdButtonPositive:I

    invoke-static {v3}, Lcom/glu/platform/android/resdl/ResFileDownloadView;->getSDButtonText(I)Ljava/lang/String;

    move-result-object v3

    iget v4, v0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_sdButtonNegative:I

    iget v5, v0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_sdButtonNegative:I

    invoke-static {v5}, Lcom/glu/platform/android/resdl/ResFileDownloadView;->getSDButtonText(I)Ljava/lang/String;

    move-result-object v5

    invoke-direct/range {v0 .. v5}, Lcom/glu/platform/android/resdl/ResFileDownloadView;->createPromptLayout(Ljava/lang/String;ILjava/lang/String;ILjava/lang/String;)V

    goto/16 :goto_2

    :cond_18
    const v1, 0x7f060063

    invoke-static {v1}, Lcom/glu/platform/android/resdl/GluUtil;->getString(I)Ljava/lang/String;

    move-result-object v1

    move-object v2, v1

    goto/16 :goto_3

    :cond_19
    const/4 v1, 0x4

    if-eq p1, v1, :cond_1a

    if-ne p1, v12, :cond_1d

    :cond_1a
    sget v1, Lcom/glu/platform/android/resdl/GameLet$instance;->m_platformVersionI:I

    if-ge v1, v12, :cond_1b

    const v1, 0x7f060064

    invoke-static {v1}, Lcom/glu/platform/android/resdl/GluUtil;->getString(I)Ljava/lang/String;

    move-result-object v1

    move-object v2, v1

    goto/16 :goto_3

    :cond_1b
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const v2, 0x7f060063

    invoke-static {v2}, Lcom/glu/platform/android/resdl/GluUtil;->getString(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const v2, 0x7f060065

    invoke-static {v2}, Lcom/glu/platform/android/resdl/GluUtil;->getString(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    move-object v2, v1

    goto/16 :goto_3

    :cond_1c
    sget v1, Lcom/glu/platform/android/resdl/ResFileDownloadView;->TOOLTIP_PADDING:I

    goto/16 :goto_4

    :cond_1d
    move-object v2, v6

    goto/16 :goto_3

    :sswitch_data_0
    .sparse-switch
        0x1 -> :sswitch_0
        0x2 -> :sswitch_1
        0x3 -> :sswitch_2
        0x4 -> :sswitch_4
        0x5 -> :sswitch_5
        0x6 -> :sswitch_6
        0x7 -> :sswitch_3
        0x8 -> :sswitch_7
        0x9 -> :sswitch_8
        0xa -> :sswitch_9
        0xb -> :sswitch_a
        0xc -> :sswitch_b
        0xd -> :sswitch_c
        0xe -> :sswitch_d
        0xf -> :sswitch_e
        0x64 -> :sswitch_f
    .end sparse-switch
.end method

.method public onDraw(Landroid/graphics/Canvas;)V
    .locals 13

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v4

    iget-wide v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_lastTickTime:J

    sub-long v0, v4, v0

    long-to-int v6, v0

    const/4 v3, -0x1

    const/4 v0, -0x2

    iget-object v1, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_activeWidget:Lcom/glu/platform/android/resdl/ResFileDownloadView$GluWidget;

    if-eqz v1, :cond_42

    iget-object v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_activeWidget:Lcom/glu/platform/android/resdl/ResFileDownloadView$GluWidget;

    iget v0, v0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluWidget;->m_widgetID:I

    move v1, v0

    :goto_0
    iget-object v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_widgets:Ljava/util/Vector;

    if-eqz v0, :cond_1

    const/4 v0, 0x0

    move v2, v0

    :goto_1
    iget-object v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_widgets:Ljava/util/Vector;

    invoke-virtual {v0}, Ljava/util/Vector;->size()I

    move-result v0

    if-ge v2, v0, :cond_1

    iget-object v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_widgets:Ljava/util/Vector;

    invoke-virtual {v0, v2}, Ljava/util/Vector;->elementAt(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluWidget;

    if-eqz v0, :cond_0

    invoke-virtual {v0, v6}, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluWidget;->tick(I)V

    :cond_0
    add-int/lit8 v0, v2, 0x1

    move v2, v0

    goto :goto_1

    :cond_1
    iget v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_state:I

    sparse-switch v0, :sswitch_data_0

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "onTick() unhandled state: "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const/4 v2, -0x1

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/glu/platform/android/resdl/Debug;->log(Ljava/lang/String;)V

    :cond_2
    move v2, v3

    :goto_2
    const/16 v0, 0xc

    if-ne v1, v0, :cond_3

    iget-object v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_activeWidget:Lcom/glu/platform/android/resdl/ResFileDownloadView$GluWidget;

    check-cast v0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluTooltip;

    iget-object v1, v0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluTooltip;->m_popupTitle:Ljava/lang/String;

    iget-object v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_activeWidget:Lcom/glu/platform/android/resdl/ResFileDownloadView$GluWidget;

    check-cast v0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluTooltip;

    iget-object v0, v0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluTooltip;->m_popupText:Ljava/lang/String;

    const v3, 0x7f06002e

    invoke-static {v3}, Lcom/glu/platform/android/resdl/GluUtil;->getString(I)Ljava/lang/String;

    move-result-object v3

    invoke-static {v1, v0, v3}, Lcom/glu/platform/android/resdl/GluUtil;->openModalDialog(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    :cond_3
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_pointerLatched:Z

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_backPressed:Z

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_activeWidget:Lcom/glu/platform/android/resdl/ResFileDownloadView$GluWidget;

    sget-object v0, Lcom/glu/platform/android/resdl/ResDownloadViewGroup;->instance:Lcom/glu/platform/android/resdl/ResDownloadViewGroup;

    if-eqz v0, :cond_4

    sget-object v0, Lcom/glu/platform/android/resdl/ResDownloadViewGroup;->instance:Lcom/glu/platform/android/resdl/ResDownloadViewGroup;

    invoke-static {}, Lcom/glu/platform/android/resdl/ResDownloadViewGroup;->tick$13462e()V

    :cond_4
    invoke-virtual {p0, v2}, Lcom/glu/platform/android/resdl/ResFileDownloadView;->newState(I)V

    iput-wide v4, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_lastTickTime:J

    iget v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_screenHeight:I

    iget v1, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_screenWidth:I

    if-le v0, v1, :cond_3f

    iget v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_screenWidth:I

    iget-object v1, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_mutedLogoImg:Landroid/graphics/drawable/Drawable;

    invoke-virtual {v1}, Landroid/graphics/drawable/Drawable;->getIntrinsicHeight()I

    move-result v1

    mul-int/2addr v1, v0

    iget-object v2, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_mutedLogoImg:Landroid/graphics/drawable/Drawable;

    invoke-virtual {v2}, Landroid/graphics/drawable/Drawable;->getIntrinsicWidth()I

    move-result v2

    div-int/2addr v1, v2

    iget v2, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_screenHeight:I

    sub-int/2addr v2, v1

    shr-int/lit8 v2, v2, 0x1

    iget-object v3, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_mutedLogoImg:Landroid/graphics/drawable/Drawable;

    const/4 v4, 0x0

    add-int/2addr v1, v2

    invoke-virtual {v3, v4, v2, v0, v1}, Landroid/graphics/drawable/Drawable;->setBounds(IIII)V

    :goto_3
    const/4 v0, 0x0

    move v1, v0

    :goto_4
    iget-object v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_widgets:Ljava/util/Vector;

    invoke-virtual {v0}, Ljava/util/Vector;->size()I

    move-result v0

    if-ge v1, v0, :cond_40

    iget-object v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_widgets:Ljava/util/Vector;

    invoke-virtual {v0, v1}, Ljava/util/Vector;->elementAt(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluWidget;

    invoke-virtual {v0, p1}, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluWidget;->draw(Landroid/graphics/Canvas;)V

    add-int/lit8 v0, v1, 0x1

    move v1, v0

    goto :goto_4

    :sswitch_0
    invoke-static {}, Lcom/glu/platform/android/resdl/GluUtil;->cleanupOldSDDir()Z

    move-result v0

    const/4 v2, 0x0

    iput-object v2, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_sdErrorText:Ljava/lang/String;

    new-instance v2, Ljava/io/File;

    invoke-static {}, Lcom/glu/platform/android/resdl/GluUtil;->getDiskFilename()Ljava/lang/String;

    move-result-object v3

    invoke-direct {v2, v3}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    if-nez v0, :cond_5

    sget-object v0, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->instance:Lcom/glu/platform/android/resdl/GluDownloadResMgr;

    iget-boolean v0, v0, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->m_secondaryFilesPassedOnce:Z

    if-eqz v0, :cond_5

    invoke-virtual {v2}, Ljava/io/File;->exists()Z

    move-result v0

    if-nez v0, :cond_5

    invoke-static {}, Landroid/os/Environment;->getExternalStorageState()Ljava/lang/String;

    move-result-object v0

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "SD storage state: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/glu/platform/android/resdl/Debug;->log(Ljava/lang/String;)V

    const-string v2, "shared"

    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_6

    const v0, 0x7f06005b

    invoke-static {v0}, Lcom/glu/platform/android/resdl/GluUtil;->getString(I)Ljava/lang/String;

    move-result-object v0

    const/4 v2, 0x1

    new-array v2, v2, [Ljava/lang/Object;

    const/4 v3, 0x0

    const v6, 0x7f06002c

    invoke-static {v6}, Lcom/glu/platform/android/resdl/GluUtil;->getString(I)Ljava/lang/String;

    move-result-object v6

    aput-object v6, v2, v3

    invoke-static {v0, v2}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_sdErrorText:Ljava/lang/String;

    const/16 v0, 0x12

    iput v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_sdButtonPositive:I

    const/16 v0, 0x13

    iput v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_sdButtonNegative:I

    :cond_5
    :goto_5
    iget-object v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_sdErrorText:Ljava/lang/String;

    if-eqz v0, :cond_c

    const/16 v0, 0x64

    move v2, v0

    goto/16 :goto_2

    :cond_6
    const-string v2, "checking"

    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_7

    const v0, 0x7f06005c

    invoke-static {v0}, Lcom/glu/platform/android/resdl/GluUtil;->getString(I)Ljava/lang/String;

    move-result-object v0

    const/4 v2, 0x1

    new-array v2, v2, [Ljava/lang/Object;

    const/4 v3, 0x0

    const v6, 0x7f06002c

    invoke-static {v6}, Lcom/glu/platform/android/resdl/GluUtil;->getString(I)Ljava/lang/String;

    move-result-object v6

    aput-object v6, v2, v3

    invoke-static {v0, v2}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_sdErrorText:Ljava/lang/String;

    const/16 v0, 0x12

    iput v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_sdButtonPositive:I

    const/16 v0, 0x13

    iput v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_sdButtonNegative:I

    goto :goto_5

    :cond_7
    const-string v2, "removed"

    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_8

    const-string v2, "bad_removal"

    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_9

    :cond_8
    const v0, 0x7f06005d

    invoke-static {v0}, Lcom/glu/platform/android/resdl/GluUtil;->getString(I)Ljava/lang/String;

    move-result-object v0

    const/4 v2, 0x1

    new-array v2, v2, [Ljava/lang/Object;

    const/4 v3, 0x0

    const v6, 0x7f06002c

    invoke-static {v6}, Lcom/glu/platform/android/resdl/GluUtil;->getString(I)Ljava/lang/String;

    move-result-object v6

    aput-object v6, v2, v3

    invoke-static {v0, v2}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_sdErrorText:Ljava/lang/String;

    const/16 v0, 0x11

    iput v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_sdButtonPositive:I

    const/16 v0, 0x13

    iput v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_sdButtonNegative:I

    goto :goto_5

    :cond_9
    const-string v2, "nofs"

    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_a

    const-string v2, "unmountable"

    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_a

    const-string v2, "unmounted"

    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_b

    :cond_a
    const v0, 0x7f06005f

    invoke-static {v0}, Lcom/glu/platform/android/resdl/GluUtil;->getString(I)Ljava/lang/String;

    move-result-object v0

    const/4 v2, 0x1

    new-array v2, v2, [Ljava/lang/Object;

    const/4 v3, 0x0

    const v6, 0x7f06002c

    invoke-static {v6}, Lcom/glu/platform/android/resdl/GluUtil;->getString(I)Ljava/lang/String;

    move-result-object v6

    aput-object v6, v2, v3

    invoke-static {v0, v2}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_sdErrorText:Ljava/lang/String;

    const/16 v0, 0x11

    iput v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_sdButtonPositive:I

    const/16 v0, 0x13

    iput v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_sdButtonNegative:I

    goto/16 :goto_5

    :cond_b
    new-instance v0, Ljava/io/File;

    invoke-static {}, Lcom/glu/platform/android/resdl/GluUtil;->getPrimaryResSDCardFilename()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v0, v2}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v0

    if-nez v0, :cond_5

    const v0, 0x7f06005e

    invoke-static {v0}, Lcom/glu/platform/android/resdl/GluUtil;->getString(I)Ljava/lang/String;

    move-result-object v0

    const/4 v2, 0x1

    new-array v2, v2, [Ljava/lang/Object;

    const/4 v3, 0x0

    const v6, 0x7f06002c

    invoke-static {v6}, Lcom/glu/platform/android/resdl/GluUtil;->getString(I)Ljava/lang/String;

    move-result-object v6

    aput-object v6, v2, v3

    invoke-static {v0, v2}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_sdErrorText:Ljava/lang/String;

    const/16 v0, 0x11

    iput v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_sdButtonPositive:I

    const/16 v0, 0x13

    iput v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_sdButtonNegative:I

    goto/16 :goto_5

    :cond_c
    sget-object v0, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->instance:Lcom/glu/platform/android/resdl/GluDownloadResMgr;

    iget-boolean v0, v0, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->m_mainResFileInterrupted:Z

    if-eqz v0, :cond_d

    const/16 v0, 0x8

    move v2, v0

    goto/16 :goto_2

    :cond_d
    const/4 v0, 0x1

    move v2, v0

    goto/16 :goto_2

    :sswitch_1
    sget-object v0, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->instance:Lcom/glu/platform/android/resdl/GluDownloadResMgr;

    invoke-virtual {v0}, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->specialFilesChecksumInProgress()Z

    move-result v0

    if-nez v0, :cond_2

    const/4 v0, 0x2

    move v2, v0

    goto/16 :goto_2

    :sswitch_2
    iget-boolean v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_checksumDone:Z

    if-eqz v0, :cond_18

    iget-boolean v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_checksumPassed:Z

    if-eqz v0, :cond_10

    iget-boolean v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_specialCheckPassed:Z

    if-eqz v0, :cond_10

    iget v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_prevState:I

    const/4 v2, -0x1

    if-ne v0, v2, :cond_f

    invoke-static {}, Lcom/glu/platform/android/resdl/ResFileDownloadView;->resourceIsOnDisk()Z

    move-result v0

    if-eqz v0, :cond_e

    const/16 v0, 0xa

    move v2, v0

    goto/16 :goto_2

    :cond_e
    const/16 v0, 0xd

    move v2, v0

    goto/16 :goto_2

    :cond_f
    const/16 v0, 0xd

    move v2, v0

    goto/16 :goto_2

    :cond_10
    iget-boolean v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_checksumPassed:Z

    if-eqz v0, :cond_11

    sget-object v0, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->instance:Lcom/glu/platform/android/resdl/GluDownloadResMgr;

    invoke-static {}, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->areThereSpecialFiles()Z

    move-result v0

    if-eqz v0, :cond_11

    const/16 v0, 0x8

    move v2, v0

    goto/16 :goto_2

    :cond_11
    iget v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_prevState:I

    const/4 v2, -0x1

    if-ne v0, v2, :cond_13

    const/4 v0, 0x3

    new-array v0, v0, [I

    sget-object v2, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->instance:Lcom/glu/platform/android/resdl/GluDownloadResMgr;

    invoke-static {v0}, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->getSpecialStartPosition([I)V

    const/4 v2, 0x0

    aget v0, v0, v2

    if-lez v0, :cond_12

    const/16 v0, 0x8

    :goto_6
    sget-object v2, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->instance:Lcom/glu/platform/android/resdl/GluDownloadResMgr;

    invoke-virtual {v2}, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->initialize()V

    move v2, v0

    goto/16 :goto_2

    :cond_12
    const/4 v0, 0x3

    goto :goto_6

    :cond_13
    iget v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_prevState:I

    const/4 v2, 0x4

    if-eq v0, v2, :cond_14

    iget v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_prevState:I

    const/4 v2, 0x5

    if-eq v0, v2, :cond_14

    iget v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_prevState:I

    const/4 v2, 0x6

    if-ne v0, v2, :cond_2

    :cond_14
    iget-boolean v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_checksumPassed:Z

    if-eqz v0, :cond_16

    iget-object v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_downloadError:Ljava/lang/String;

    if-nez v0, :cond_15

    const v0, 0x7f06006d

    invoke-static {v0}, Lcom/glu/platform/android/resdl/GluUtil;->getString(I)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_downloadError:Ljava/lang/String;

    :cond_15
    :goto_7
    const/4 v0, 0x7

    move v2, v0

    goto/16 :goto_2

    :cond_16
    iget-object v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_checksumError:Ljava/lang/String;

    if-nez v0, :cond_17

    const v0, 0x7f06004e

    invoke-static {v0}, Lcom/glu/platform/android/resdl/GluUtil;->getString(I)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_checksumError:Ljava/lang/String;

    :cond_17
    iget-object v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_checksumError:Ljava/lang/String;

    iput-object v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_downloadError:Ljava/lang/String;

    goto :goto_7

    :cond_18
    iget-boolean v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_checksumInProgress:Z

    if-nez v0, :cond_2

    const/4 v0, 0x0

    const/4 v2, 0x0

    iput-object v2, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_checksumError:Ljava/lang/String;

    const/4 v2, 0x1

    iput-boolean v2, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_checksumInProgress:Z

    invoke-static {}, Lcom/glu/platform/android/resdl/GluUtil;->getDiskFilename()Ljava/lang/String;

    move-result-object v2

    new-instance v6, Ljava/io/File;

    invoke-direct {v6, v2}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "testing: "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v7, "   exists="

    invoke-virtual {v2, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v6}, Ljava/io/File;->exists()Z

    move-result v7

    invoke-virtual {v2, v7}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/glu/platform/android/resdl/Debug;->log(Ljava/lang/String;)V

    invoke-virtual {v6}, Ljava/io/File;->exists()Z

    move-result v2

    if-eqz v2, :cond_1d

    invoke-static {v6}, Lcom/glu/platform/android/resdl/GluUtil;->performChecksum(Ljava/io/File;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_checksumError:Ljava/lang/String;

    iget-object v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_checksumError:Ljava/lang/String;

    if-nez v0, :cond_1c

    const/4 v0, 0x1

    :cond_19
    :goto_8
    iget-object v2, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_checksumError:Ljava/lang/String;

    if-eqz v2, :cond_1b

    sget-object v2, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->instance:Lcom/glu/platform/android/resdl/GluDownloadResMgr;

    iget-boolean v2, v2, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->m_mainResFileInterrupted:Z

    if-nez v2, :cond_1b

    sget-object v2, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->instance:Lcom/glu/platform/android/resdl/GluDownloadResMgr;

    invoke-virtual {v2}, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->wereSpecialFilesChecksummed()Z

    move-result v2

    if-nez v2, :cond_1a

    sget-object v2, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->instance:Lcom/glu/platform/android/resdl/GluDownloadResMgr;

    invoke-static {}, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->deleteSpecialFiles()V

    :cond_1a
    sget-object v2, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->instance:Lcom/glu/platform/android/resdl/GluDownloadResMgr;

    const/4 v6, 0x0

    invoke-virtual {v2, v6}, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->setSecondaryFilesPassed(Z)V

    invoke-static {}, Lcom/glu/platform/android/resdl/ResFileDownloadView;->deleteResFile()V

    :cond_1b
    iput-boolean v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_checksumPassed:Z

    sget-object v0, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->instance:Lcom/glu/platform/android/resdl/GluDownloadResMgr;

    invoke-virtual {v0}, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->verifySpecialFileIntegrity()Z

    move-result v0

    iput-boolean v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_specialCheckPassed:Z

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_checksumDone:Z

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_checksumInProgress:Z

    move v2, v3

    goto/16 :goto_2

    :cond_1c
    const/4 v0, 0x0

    goto :goto_8

    :cond_1d
    invoke-static {}, Lcom/glu/platform/android/resdl/GluUtil;->getPrimaryResSDCardFilename()Ljava/lang/String;

    move-result-object v2

    new-instance v6, Ljava/io/File;

    invoke-direct {v6, v2}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "testing: "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v7, "   exists="

    invoke-virtual {v2, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v6}, Ljava/io/File;->exists()Z

    move-result v7

    invoke-virtual {v2, v7}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/glu/platform/android/resdl/Debug;->log(Ljava/lang/String;)V

    invoke-virtual {v6}, Ljava/io/File;->exists()Z

    move-result v2

    if-eqz v2, :cond_19

    invoke-static {v6}, Lcom/glu/platform/android/resdl/GluUtil;->performChecksum(Ljava/io/File;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_checksumError:Ljava/lang/String;

    iget-object v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_checksumError:Ljava/lang/String;

    if-nez v0, :cond_1e

    const/4 v0, 0x1

    :goto_9
    if-eqz v0, :cond_19

    const/4 v2, 0x1

    iput-boolean v2, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_usesAltSDCardPath:Z

    goto :goto_8

    :cond_1e
    const/4 v0, 0x0

    goto :goto_9

    :sswitch_3
    iget-boolean v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_backPressed:Z

    if-eqz v0, :cond_1f

    const/16 v0, 0xf

    move v2, v0

    goto/16 :goto_2

    :cond_1f
    if-nez v1, :cond_21

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_downloadToDisk:Z

    iget-boolean v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_checksumPassed:Z

    if-eqz v0, :cond_20

    const/4 v0, 0x5

    :goto_a
    move v2, v0

    goto/16 :goto_2

    :cond_20
    const/4 v0, 0x4

    goto :goto_a

    :cond_21
    const/4 v0, 0x1

    if-ne v1, v0, :cond_2

    invoke-static {}, Lcom/glu/platform/android/resdl/GluUtil;->getResourceSDDir()Ljava/io/File;

    move-result-object v0

    if-nez v0, :cond_22

    const v0, 0x7f06004d

    invoke-static {v0}, Lcom/glu/platform/android/resdl/GluUtil;->getString(I)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_downloadError:Ljava/lang/String;

    const/4 v0, 0x7

    move v2, v0

    goto/16 :goto_2

    :cond_22
    iget-boolean v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_checksumPassed:Z

    if-eqz v0, :cond_23

    const/4 v0, 0x5

    :goto_b
    const/4 v2, 0x0

    iput-boolean v2, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_downloadToDisk:Z

    move v2, v0

    goto/16 :goto_2

    :cond_23
    const/4 v0, 0x4

    goto :goto_b

    :sswitch_4
    iget-object v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_widgets:Ljava/util/Vector;

    invoke-virtual {v0}, Ljava/util/Vector;->size()I

    move-result v0

    if-lez v0, :cond_25

    iget-object v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_widgets:Ljava/util/Vector;

    const/4 v2, 0x0

    invoke-virtual {v0, v2}, Ljava/util/Vector;->elementAt(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluWidget;

    instance-of v2, v0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluTextArea;

    if-nez v2, :cond_24

    iget-object v2, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_widgets:Ljava/util/Vector;

    invoke-virtual {v2}, Ljava/util/Vector;->size()I

    move-result v2

    const/4 v6, 0x1

    if-le v2, v6, :cond_24

    iget-object v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_widgets:Ljava/util/Vector;

    const/4 v2, 0x1

    invoke-virtual {v0, v2}, Ljava/util/Vector;->elementAt(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluWidget;

    :cond_24
    instance-of v2, v0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluTextArea;

    if-eqz v2, :cond_25

    iget-boolean v2, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_downloadCancelled:Z

    if-eqz v2, :cond_26

    const v2, 0x7f060038

    invoke-static {v2}, Lcom/glu/platform/android/resdl/GluUtil;->getString(I)Ljava/lang/String;

    move-result-object v2

    :goto_c
    check-cast v0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluTextArea;

    iput-object v2, v0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluTextArea;->m_text:Ljava/lang/String;

    iget-object v2, v0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluTextArea;->m_text:Ljava/lang/String;

    iget v6, v0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluTextArea;->m_dx:I

    iget v7, v0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluTextArea;->m_x:I

    sub-int/2addr v6, v7

    iget-object v7, v0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluTextArea;->m_paint:Landroid/graphics/Paint;

    invoke-static {v2, v6, v7}, Lcom/glu/platform/android/resdl/GluUtil;->wrapText(Ljava/lang/String;ILandroid/graphics/Paint;)Ljava/util/Vector;

    move-result-object v2

    iput-object v2, v0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluTextArea;->m_wrappedText:Ljava/util/Vector;

    :cond_25
    iget-boolean v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_downloadFailed:Z

    if-eqz v0, :cond_28

    const/4 v0, 0x7

    move v2, v0

    goto/16 :goto_2

    :cond_26
    const v2, 0x7f060044

    invoke-static {v2}, Lcom/glu/platform/android/resdl/GluUtil;->getString(I)Ljava/lang/String;

    move-result-object v6

    const/4 v2, 0x1

    new-array v7, v2, [Ljava/lang/Object;

    const/4 v8, 0x0

    invoke-static {}, Lcom/glu/platform/android/resdl/ResFileDownloadView;->getAllFilesBytesTotal()I

    move-result v2

    if-nez v2, :cond_27

    const-string v2, "0%"

    :goto_d
    aput-object v2, v7, v8

    invoke-static {v6, v7}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    goto :goto_c

    :cond_27
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-wide/high16 v9, 0x4059000000000000L    # 100.0

    iget v11, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_state:I

    invoke-direct {p0}, Lcom/glu/platform/android/resdl/ResFileDownloadView;->getAllFilesBytesDownloaded$134621()I

    move-result v11

    int-to-double v11, v11

    mul-double/2addr v9, v11

    invoke-static {}, Lcom/glu/platform/android/resdl/ResFileDownloadView;->getAllFilesBytesTotal()I

    move-result v11

    int-to-double v11, v11

    div-double/2addr v9, v11

    double-to-int v9, v9

    invoke-virtual {v2, v9}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v9, "%"

    invoke-virtual {v2, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    goto :goto_d

    :cond_28
    iget-boolean v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_downloadDone:Z

    if-eqz v0, :cond_2a

    iget v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_state:I

    const/4 v2, 0x4

    if-ne v0, v2, :cond_29

    sget-object v0, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->instance:Lcom/glu/platform/android/resdl/GluDownloadResMgr;

    invoke-static {}, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->areThereSpecialFiles()Z

    move-result v0

    if-nez v0, :cond_2a

    :cond_29
    const/4 v0, 0x1

    move v2, v0

    goto/16 :goto_2

    :cond_2a
    iget-boolean v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_backPressed:Z

    if-eqz v0, :cond_2

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_downloadCancelled:Z

    move v2, v3

    goto/16 :goto_2

    :sswitch_5
    iget v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_preparingTimer:I

    if-gtz v0, :cond_2b

    const/4 v0, 0x1

    move v2, v0

    goto/16 :goto_2

    :cond_2b
    invoke-static {}, Lcom/glu/platform/android/resdl/GluUtil;->isAppPaused()Z

    move-result v0

    if-nez v0, :cond_2

    iget v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_preparingTimer:I

    sub-int/2addr v0, v6

    iput v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_preparingTimer:I

    iget-boolean v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_backPressed:Z

    if-eqz v0, :cond_2

    invoke-static {}, Lcom/glu/platform/android/resdl/GameLet$instance;->finishApp()V

    move v2, v3

    goto/16 :goto_2

    :sswitch_6
    iget-boolean v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_backPressed:Z

    if-eqz v0, :cond_2c

    const/16 v0, 0xf

    move v2, v0

    goto/16 :goto_2

    :cond_2c
    const/4 v0, 0x6

    if-ne v1, v0, :cond_30

    sget-object v0, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->instance:Lcom/glu/platform/android/resdl/GluDownloadResMgr;

    iget-boolean v0, v0, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->m_mainResFileInterrupted:Z

    if-nez v0, :cond_2d

    iget v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_prevState:I

    const/4 v2, 0x5

    if-ne v0, v2, :cond_2e

    sget-object v0, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->instance:Lcom/glu/platform/android/resdl/GluDownloadResMgr;

    invoke-static {}, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->areSpecialFilesSequential()Z

    move-result v0

    if-eqz v0, :cond_2e

    :cond_2d
    const/16 v0, 0x8

    move v2, v0

    goto/16 :goto_2

    :cond_2e
    iget v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_prevState:I

    const/4 v2, 0x5

    if-ne v0, v2, :cond_2f

    const/4 v0, 0x1

    move v2, v0

    goto/16 :goto_2

    :cond_2f
    const/4 v0, 0x3

    move v2, v0

    goto/16 :goto_2

    :cond_30
    const/4 v0, 0x7

    if-ne v1, v0, :cond_2

    const/16 v0, 0xf

    move v2, v0

    goto/16 :goto_2

    :sswitch_7
    iget-boolean v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_backPressed:Z

    if-eqz v0, :cond_31

    const/16 v0, 0xf

    move v2, v0

    goto/16 :goto_2

    :cond_31
    const/16 v0, 0xa

    if-ne v1, v0, :cond_34

    iget-boolean v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_downloadToDisk:Z

    if-nez v0, :cond_32

    invoke-static {}, Lcom/glu/platform/android/resdl/GluUtil;->getResourceSDDir()Ljava/io/File;

    move-result-object v0

    if-nez v0, :cond_32

    const v0, 0x7f06004d

    invoke-static {v0}, Lcom/glu/platform/android/resdl/GluUtil;->getString(I)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_downloadError:Ljava/lang/String;

    const/4 v0, 0x7

    move v2, v0

    goto/16 :goto_2

    :cond_32
    iget-boolean v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_checksumPassed:Z

    if-eqz v0, :cond_33

    const/4 v0, 0x5

    :goto_e
    move v2, v0

    goto/16 :goto_2

    :cond_33
    const/4 v0, 0x4

    goto :goto_e

    :cond_34
    const/16 v0, 0xb

    if-ne v1, v0, :cond_2

    const/16 v0, 0x9

    move v2, v0

    goto/16 :goto_2

    :sswitch_8
    iget-boolean v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_backPressed:Z

    if-eqz v0, :cond_35

    const/16 v0, 0x8

    move v2, v0

    goto/16 :goto_2

    :cond_35
    const/16 v0, 0x8

    if-ne v1, v0, :cond_36

    sget-object v0, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->instance:Lcom/glu/platform/android/resdl/GluDownloadResMgr;

    const/4 v2, 0x0

    invoke-virtual {v0, v2}, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->setSecondaryFilesPassed(Z)V

    sget-object v0, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->instance:Lcom/glu/platform/android/resdl/GluDownloadResMgr;

    invoke-static {}, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->deleteSpecialFiles()V

    invoke-static {}, Lcom/glu/platform/android/resdl/ResFileDownloadView;->deleteResFile()V

    sget-object v0, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->instance:Lcom/glu/platform/android/resdl/GluDownloadResMgr;

    const/4 v2, 0x0

    iput-boolean v2, v0, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->m_mainResFileInterrupted:Z

    sget-object v0, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->instance:Lcom/glu/platform/android/resdl/GluDownloadResMgr;

    invoke-virtual {v0}, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->saveFile()V

    const/4 v0, 0x3

    move v2, v0

    goto/16 :goto_2

    :cond_36
    const/16 v0, 0x9

    if-ne v1, v0, :cond_2

    const/16 v0, 0x8

    move v2, v0

    goto/16 :goto_2

    :sswitch_9
    iget-boolean v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_backPressed:Z

    if-eqz v0, :cond_37

    const/16 v0, 0xf

    move v2, v0

    goto/16 :goto_2

    :cond_37
    const/4 v0, 0x2

    if-ne v1, v0, :cond_38

    const/16 v0, 0xd

    move v2, v0

    goto/16 :goto_2

    :cond_38
    const/4 v0, 0x3

    if-ne v1, v0, :cond_2

    const/16 v0, 0xb

    move v2, v0

    goto/16 :goto_2

    :sswitch_a
    iget-boolean v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_backPressed:Z

    if-eqz v0, :cond_39

    const/16 v0, 0xa

    move v2, v0

    goto/16 :goto_2

    :cond_39
    const/4 v0, 0x4

    if-ne v1, v0, :cond_3a

    const/16 v0, 0xc

    move v2, v0

    goto/16 :goto_2

    :cond_3a
    const/4 v0, 0x5

    if-ne v1, v0, :cond_2

    const/16 v0, 0xa

    move v2, v0

    goto/16 :goto_2

    :sswitch_b
    iget-boolean v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_backPressed:Z

    if-nez v0, :cond_3b

    iget-boolean v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_pointerLatched:Z

    if-eqz v0, :cond_2

    :cond_3b
    const/16 v0, 0xf

    move v2, v0

    goto/16 :goto_2

    :sswitch_c
    move v2, v3

    goto/16 :goto_2

    :sswitch_d
    iget-boolean v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->gameStarted:Z

    if-nez v0, :cond_2

    invoke-virtual {p0}, Lcom/glu/platform/android/resdl/ResFileDownloadView;->hasWindowFocus()Z

    move-result v0

    if-eqz v0, :cond_2

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->gameStarted:Z

    invoke-static {}, Lcom/glu/platform/android/resdl/GameLet$instance;->startGame()V

    move v2, v3

    goto/16 :goto_2

    :sswitch_e
    const/16 v0, 0x11

    if-ne v1, v0, :cond_3c

    sget-object v0, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->instance:Lcom/glu/platform/android/resdl/GluDownloadResMgr;

    const/4 v2, 0x0

    invoke-virtual {v0, v2}, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->setSecondaryFilesPassed(Z)V

    sget-object v0, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->instance:Lcom/glu/platform/android/resdl/GluDownloadResMgr;

    invoke-static {}, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->deleteSpecialFiles()V

    invoke-static {}, Lcom/glu/platform/android/resdl/ResFileDownloadView;->deleteResFile()V

    sget-object v0, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->instance:Lcom/glu/platform/android/resdl/GluDownloadResMgr;

    const/4 v2, 0x0

    iput-boolean v2, v0, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->m_mainResFileInterrupted:Z

    sget-object v0, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->instance:Lcom/glu/platform/android/resdl/GluDownloadResMgr;

    invoke-virtual {v0}, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->saveFile()V

    const/4 v0, 0x0

    move v2, v0

    goto/16 :goto_2

    :cond_3c
    const/16 v0, 0x12

    if-ne v1, v0, :cond_3d

    const/4 v0, 0x0

    move v2, v0

    goto/16 :goto_2

    :cond_3d
    const/16 v0, 0x13

    if-eq v1, v0, :cond_3e

    iget-boolean v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_backPressed:Z

    if-eqz v0, :cond_2

    :cond_3e
    const/16 v0, 0xf

    move v2, v0

    goto/16 :goto_2

    :cond_3f
    iget v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_screenHeight:I

    add-int/lit8 v0, v0, -0x3c

    iget-object v1, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_mutedLogoImg:Landroid/graphics/drawable/Drawable;

    invoke-virtual {v1}, Landroid/graphics/drawable/Drawable;->getIntrinsicWidth()I

    move-result v1

    mul-int/2addr v1, v0

    iget-object v2, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_mutedLogoImg:Landroid/graphics/drawable/Drawable;

    invoke-virtual {v2}, Landroid/graphics/drawable/Drawable;->getIntrinsicHeight()I

    move-result v2

    div-int/2addr v1, v2

    iget v2, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_screenWidth:I

    sub-int/2addr v2, v1

    shr-int/lit8 v2, v2, 0x1

    iget v3, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_screenHeight:I

    sub-int/2addr v3, v0

    shr-int/lit8 v3, v3, 0x1

    iget-object v4, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_mutedLogoImg:Landroid/graphics/drawable/Drawable;

    add-int/2addr v1, v2

    add-int/2addr v0, v3

    invoke-virtual {v4, v2, v3, v1, v0}, Landroid/graphics/drawable/Drawable;->setBounds(IIII)V

    goto/16 :goto_3

    :cond_40
    sget-object v0, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->instance:Lcom/glu/platform/android/resdl/GluDownloadResMgr;

    iget-object v0, v0, Lcom/glu/platform/android/resdl/GluDownloadResMgr;->m_downloadThread:Ljava/lang/Thread;

    if-eqz v0, :cond_41

    const-wide/16 v0, 0x64

    invoke-virtual {p0, v0, v1}, Lcom/glu/platform/android/resdl/ResFileDownloadView;->postInvalidateDelayed(J)V

    :goto_f
    return-void

    :cond_41
    const-wide/16 v0, 0xa

    invoke-virtual {p0, v0, v1}, Lcom/glu/platform/android/resdl/ResFileDownloadView;->postInvalidateDelayed(J)V

    goto :goto_f

    :cond_42
    move v1, v0

    goto/16 :goto_0

    nop

    :sswitch_data_0
    .sparse-switch
        -0x1 -> :sswitch_0
        0x0 -> :sswitch_0
        0x1 -> :sswitch_1
        0x2 -> :sswitch_2
        0x3 -> :sswitch_3
        0x4 -> :sswitch_4
        0x5 -> :sswitch_4
        0x6 -> :sswitch_5
        0x7 -> :sswitch_6
        0x8 -> :sswitch_7
        0x9 -> :sswitch_8
        0xa -> :sswitch_9
        0xb -> :sswitch_a
        0xc -> :sswitch_b
        0xd -> :sswitch_c
        0xe -> :sswitch_d
        0x64 -> :sswitch_e
    .end sparse-switch
.end method

.method public onKeyDown(ILandroid/view/KeyEvent;)Z
    .locals 2

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "ResFileDownloadView.onKeyDown("

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ")"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/glu/platform/android/resdl/Debug;->log(Ljava/lang/String;)V

    const/4 v0, 0x1

    return v0
.end method

.method public onKeyUp(ILandroid/view/KeyEvent;)Z
    .locals 3

    const/4 v2, 0x1

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "ResFileDownloadView.onKeyUp("

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ")"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/glu/platform/android/resdl/Debug;->log(Ljava/lang/String;)V

    const/4 v0, 0x4

    if-ne p1, v0, :cond_0

    iput-boolean v2, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_backPressed:Z

    :cond_0
    return v2
.end method

.method public onTouchEvent(Landroid/view/MotionEvent;)Z
    .locals 8

    const/4 v7, 0x1

    const/4 v1, 0x0

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getX()F

    move-result v0

    float-to-int v3, v0

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getY()F

    move-result v0

    float-to-int v4, v0

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getAction()I

    move-result v0

    packed-switch v0, :pswitch_data_0

    :cond_0
    :pswitch_0
    return v7

    :pswitch_1
    iput-boolean v7, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_pointerLatched:Z

    :goto_0
    iget-object v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_widgets:Ljava/util/Vector;

    invoke-virtual {v0}, Ljava/util/Vector;->size()I

    move-result v0

    if-ge v1, v0, :cond_0

    iget-object v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_widgets:Ljava/util/Vector;

    invoke-virtual {v0, v1}, Ljava/util/Vector;->elementAt(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluWidget;

    invoke-virtual {v0, v3, v4}, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluWidget;->containsCoords(II)Z

    move-result v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_widgets:Ljava/util/Vector;

    invoke-virtual {v0, v1}, Ljava/util/Vector;->elementAt(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluWidget;

    iput-boolean v7, v0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluWidget;->pointerActive:Z

    :cond_1
    add-int/lit8 v0, v1, 0x1

    move v1, v0

    goto :goto_0

    :pswitch_2
    move v2, v1

    :goto_1
    iget-object v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_widgets:Ljava/util/Vector;

    invoke-virtual {v0}, Ljava/util/Vector;->size()I

    move-result v0

    if-ge v2, v0, :cond_0

    iget-object v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_widgets:Ljava/util/Vector;

    invoke-virtual {v0, v2}, Ljava/util/Vector;->elementAt(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluWidget;

    invoke-virtual {v0, v3, v4}, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluWidget;->containsCoords(II)Z

    move-result v0

    if-eqz v0, :cond_4

    iget-object v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_widgets:Ljava/util/Vector;

    invoke-virtual {v0, v2}, Ljava/util/Vector;->elementAt(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluWidget;

    iget-boolean v5, v0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluWidget;->pointerActive:Z

    if-eqz v5, :cond_3

    iget-object v5, v0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluWidget;->m_parent:Lcom/glu/platform/android/resdl/ResFileDownloadView;

    instance-of v6, v0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluButton;

    if-nez v6, :cond_2

    instance-of v6, v0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluTooltip;

    if-eqz v6, :cond_3

    :cond_2
    iput-object v0, v5, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_activeWidget:Lcom/glu/platform/android/resdl/ResFileDownloadView$GluWidget;

    :cond_3
    iput-boolean v1, v0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluWidget;->pointerActive:Z

    :goto_2
    add-int/lit8 v0, v2, 0x1

    move v2, v0

    goto :goto_1

    :cond_4
    iget-object v0, p0, Lcom/glu/platform/android/resdl/ResFileDownloadView;->m_widgets:Ljava/util/Vector;

    invoke-virtual {v0, v2}, Ljava/util/Vector;->elementAt(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluWidget;

    iput-boolean v1, v0, Lcom/glu/platform/android/resdl/ResFileDownloadView$GluWidget;->pointerActive:Z

    goto :goto_2

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_1
        :pswitch_2
        :pswitch_0
    .end packed-switch
.end method
