.class public Lcom/glu/platform/android/resdl/GameLet;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/glu/platform/android/resdl/GameLet$instance;
    }
.end annotation


# static fields
.field public static KEY_SPECIAL_FILE_URL:Ljava/lang/String;

.field public static MAX_SMALL_DIMENSION_FOR_WVGA:I

.field public static RESOURCE_FILENAME:Ljava/lang/String;

.field public static final RESOURCE_FILENAME_ARRAY:[Ljava/lang/String;

.field public static RES_FILE_CHECKSUM_TO_USE:J

.field public static RES_FILE_SIZE_TO_USE:J

.field public static RES_FILE_URL_KEY_TO_USE:Ljava/lang/String;

.field public static SPECIAL_RES_CHECKSUM_ARRAY:[J

.field public static SPECIAL_RES_FILENAME_ARRAY:[Ljava/lang/String;

.field public static SPECIAL_RES_FILESIZE_ARRAY:[I

.field public static TABLET_BUILD_SCALES_NATURALLY:Z

.field public static WVGA_BUILD_SCALES_NATURALLY:Z

.field public static m_appPaused:Z

.field public static m_buildVariant:I

.field public static m_buttonOneText:Ljava/lang/String;

.field public static m_buttonTwoText:Ljava/lang/String;

.field public static m_countryCode:Ljava/lang/String;

.field public static m_deviceID:Ljava/lang/String;

.field public static m_deviceModel:Ljava/lang/String;

.field public static m_dialogCallback:Ljava/lang/reflect/Method;

.field public static m_fullVersion:Ljava/lang/String;

.field public static m_imageStore:Ljava/util/Hashtable;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Hashtable",
            "<",
            "Ljava/lang/Integer;",
            "Landroid/graphics/drawable/Drawable;",
            ">;"
        }
    .end annotation
.end field

.field public static m_language:Ljava/lang/String;

.field public static m_lastDialogCloseAt:J

.field public static m_locale:Ljava/lang/String;

.field public static m_modalDialog:Landroid/app/AlertDialog;

.field public static m_modalDialogText:Ljava/lang/String;

.field public static m_modalDialogTitle:Ljava/lang/String;

.field public static m_nativeProperties:Ljava/util/Hashtable;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Hashtable",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field public static m_packageID:Ljava/lang/String;

.field public static m_platformVersion:Ljava/lang/String;

.field public static m_platformVersionI:I

.field public static m_platformVersionNice:Ljava/lang/String;

.field public static m_serial:Ljava/lang/String;

.field public static m_supportsATITCCompression:Z

.field public static m_supportsDXTCCompression:Z

.field public static m_supportsPVRTCCompression:Z

.field public static m_timezone:Ljava/lang/String;

.field public static m_versionMajor:Ljava/lang/String;

.field public static m_versionMicro:Ljava/lang/String;

.field public static m_versionMinor:Ljava/lang/String;

.field public static m_versionNano:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 6

    const-wide/16 v4, -0x1

    const/4 v1, 0x1

    const/4 v3, 0x0

    const/4 v2, 0x0

    sput-boolean v3, Lcom/glu/platform/android/resdl/GameLet;->m_appPaused:Z

    sput-boolean v1, Lcom/glu/platform/android/resdl/GameLet;->TABLET_BUILD_SCALES_NATURALLY:Z

    sput-boolean v1, Lcom/glu/platform/android/resdl/GameLet;->WVGA_BUILD_SCALES_NATURALLY:Z

    const/16 v0, 0x258

    sput v0, Lcom/glu/platform/android/resdl/GameLet;->MAX_SMALL_DIMENSION_FOR_WVGA:I

    const-string v0, "Glu-Res-File-URL"

    sput-object v0, Lcom/glu/platform/android/resdl/GameLet;->RES_FILE_URL_KEY_TO_USE:Ljava/lang/String;

    sput-wide v4, Lcom/glu/platform/android/resdl/GameLet;->RES_FILE_CHECKSUM_TO_USE:J

    sput-wide v4, Lcom/glu/platform/android/resdl/GameLet;->RES_FILE_SIZE_TO_USE:J

    const/16 v0, 0x10

    new-array v0, v0, [Ljava/lang/String;

    aput-object v2, v0, v3

    aput-object v2, v0, v1

    const/4 v1, 0x2

    aput-object v2, v0, v1

    const/4 v1, 0x3

    aput-object v2, v0, v1

    const/4 v1, 0x4

    aput-object v2, v0, v1

    const/4 v1, 0x5

    aput-object v2, v0, v1

    const/4 v1, 0x6

    aput-object v2, v0, v1

    const/4 v1, 0x7

    aput-object v2, v0, v1

    const/16 v1, 0x8

    aput-object v2, v0, v1

    const/16 v1, 0x9

    aput-object v2, v0, v1

    const/16 v1, 0xa

    aput-object v2, v0, v1

    const/16 v1, 0xb

    aput-object v2, v0, v1

    const/16 v1, 0xc

    aput-object v2, v0, v1

    const/16 v1, 0xd

    aput-object v2, v0, v1

    const/16 v1, 0xe

    aput-object v2, v0, v1

    const/16 v1, 0xf

    aput-object v2, v0, v1

    sput-object v0, Lcom/glu/platform/android/resdl/GameLet;->RESOURCE_FILENAME_ARRAY:[Ljava/lang/String;

    const-string v0, "file.big"

    sput-object v0, Lcom/glu/platform/android/resdl/GameLet;->RESOURCE_FILENAME:Ljava/lang/String;

    sput-object v2, Lcom/glu/platform/android/resdl/GameLet;->SPECIAL_RES_FILENAME_ARRAY:[Ljava/lang/String;

    sput-object v2, Lcom/glu/platform/android/resdl/GameLet;->SPECIAL_RES_FILESIZE_ARRAY:[I

    sput-object v2, Lcom/glu/platform/android/resdl/GameLet;->SPECIAL_RES_CHECKSUM_ARRAY:[J

    sput-object v2, Lcom/glu/platform/android/resdl/GameLet;->KEY_SPECIAL_FILE_URL:Ljava/lang/String;

    new-instance v0, Ljava/util/Hashtable;

    invoke-direct {v0}, Ljava/util/Hashtable;-><init>()V

    sput-object v0, Lcom/glu/platform/android/resdl/GameLet;->m_imageStore:Ljava/util/Hashtable;

    new-instance v0, Ljava/util/Hashtable;

    invoke-direct {v0}, Ljava/util/Hashtable;-><init>()V

    sput-object v0, Lcom/glu/platform/android/resdl/GameLet;->m_nativeProperties:Ljava/util/Hashtable;

    const/4 v0, -0x1

    sput v0, Lcom/glu/platform/android/resdl/GameLet;->m_buildVariant:I

    sput-boolean v3, Lcom/glu/platform/android/resdl/GameLet;->m_supportsATITCCompression:Z

    sput-boolean v3, Lcom/glu/platform/android/resdl/GameLet;->m_supportsDXTCCompression:Z

    sput-boolean v3, Lcom/glu/platform/android/resdl/GameLet;->m_supportsPVRTCCompression:Z

    sput-object v2, Lcom/glu/platform/android/resdl/GameLet;->m_locale:Ljava/lang/String;

    sput-object v2, Lcom/glu/platform/android/resdl/GameLet;->m_language:Ljava/lang/String;

    sput-object v2, Lcom/glu/platform/android/resdl/GameLet;->m_countryCode:Ljava/lang/String;

    sput-object v2, Lcom/glu/platform/android/resdl/GameLet;->m_deviceID:Ljava/lang/String;

    sput-object v2, Lcom/glu/platform/android/resdl/GameLet;->m_serial:Ljava/lang/String;

    sput-object v2, Lcom/glu/platform/android/resdl/GameLet;->m_fullVersion:Ljava/lang/String;

    sput-object v2, Lcom/glu/platform/android/resdl/GameLet;->m_versionMajor:Ljava/lang/String;

    sput-object v2, Lcom/glu/platform/android/resdl/GameLet;->m_versionMinor:Ljava/lang/String;

    sput-object v2, Lcom/glu/platform/android/resdl/GameLet;->m_versionMicro:Ljava/lang/String;

    sput-object v2, Lcom/glu/platform/android/resdl/GameLet;->m_versionNano:Ljava/lang/String;

    sput-object v2, Lcom/glu/platform/android/resdl/GameLet;->m_platformVersion:Ljava/lang/String;

    sput-object v2, Lcom/glu/platform/android/resdl/GameLet;->m_platformVersionNice:Ljava/lang/String;

    sput-object v2, Lcom/glu/platform/android/resdl/GameLet;->m_timezone:Ljava/lang/String;

    sput-object v2, Lcom/glu/platform/android/resdl/GameLet;->m_deviceModel:Ljava/lang/String;

    sput-object v2, Lcom/glu/platform/android/resdl/GameLet;->m_packageID:Ljava/lang/String;

    sput v3, Lcom/glu/platform/android/resdl/GameLet;->m_platformVersionI:I

    sput-object v2, Lcom/glu/platform/android/resdl/GameLet;->m_modalDialog:Landroid/app/AlertDialog;

    sput-object v2, Lcom/glu/platform/android/resdl/GameLet;->m_modalDialogTitle:Ljava/lang/String;

    sput-object v2, Lcom/glu/platform/android/resdl/GameLet;->m_modalDialogText:Ljava/lang/String;

    sput-object v2, Lcom/glu/platform/android/resdl/GameLet;->m_buttonOneText:Ljava/lang/String;

    sput-object v2, Lcom/glu/platform/android/resdl/GameLet;->m_buttonTwoText:Ljava/lang/String;

    sput-object v2, Lcom/glu/platform/android/resdl/GameLet;->m_dialogCallback:Ljava/lang/reflect/Method;

    const-wide v0, -0x7fffffffffffffffL    # -4.9E-324

    sput-wide v0, Lcom/glu/platform/android/resdl/GameLet;->m_lastDialogCloseAt:J

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static finishApp()V
    .locals 1

    invoke-static {}, Lcom/glu/platform/android/resdl/ResDL;->getContext()Landroid/app/Activity;

    move-result-object v0

    invoke-virtual {v0}, Landroid/app/Activity;->finish()V

    return-void
.end method

.method public static handleModalDialogClosed()V
    .locals 2

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    sput-wide v0, Lcom/glu/platform/android/resdl/GameLet;->m_lastDialogCloseAt:J

    return-void
.end method

.method public static handlerOpenModalDialog()V
    .locals 2

    sget-object v0, Lcom/glu/platform/android/resdl/ResDL;->m_viewManipulationHandler:Landroid/os/Handler;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/os/Handler;->sendEmptyMessage(I)Z

    return-void
.end method

.method public static handlerSwitchToResView()V
    .locals 2

    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x8

    if-ge v0, v1, :cond_0

    sget-object v0, Lcom/glu/platform/android/resdl/ResDL;->sm_dummyView:Lcom/glu/platform/android/resdl/DummyGLView;

    invoke-virtual {v0}, Lcom/glu/platform/android/resdl/DummyGLView;->onPause()V

    :cond_0
    sget-object v0, Lcom/glu/platform/android/resdl/ResDL;->m_viewManipulationHandler:Landroid/os/Handler;

    const/4 v1, 0x2

    invoke-virtual {v0, v1}, Landroid/os/Handler;->sendEmptyMessage(I)Z

    return-void
.end method

.method public static onHandledCloseModalDialog()V
    .locals 2

    sget-object v0, Lcom/glu/platform/android/resdl/GameLet;->m_modalDialog:Landroid/app/AlertDialog;

    if-eqz v0, :cond_0

    sget-object v0, Lcom/glu/platform/android/resdl/GameLet;->m_modalDialog:Landroid/app/AlertDialog;

    invoke-virtual {v0}, Landroid/app/AlertDialog;->isShowing()Z

    move-result v0

    if-nez v0, :cond_1

    :cond_0
    const-string v0, "Not closing modal dialog. (nothing to do)"

    invoke-static {v0}, Lcom/glu/platform/android/resdl/Debug;->log(Ljava/lang/String;)V

    :goto_0
    return-void

    :cond_1
    const-string v0, "Closing modal dialog."

    invoke-static {v0}, Lcom/glu/platform/android/resdl/Debug;->log(Ljava/lang/String;)V

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    sput-wide v0, Lcom/glu/platform/android/resdl/GameLet;->m_lastDialogCloseAt:J

    sget-object v0, Lcom/glu/platform/android/resdl/GameLet;->m_modalDialog:Landroid/app/AlertDialog;

    invoke-virtual {v0}, Landroid/app/AlertDialog;->dismiss()V

    const/4 v0, 0x0

    sput-object v0, Lcom/glu/platform/android/resdl/GameLet;->m_modalDialog:Landroid/app/AlertDialog;

    goto :goto_0
.end method

.method public static onHandledOpenModalDialog()V
    .locals 4

    const-string v0, "Opening modal dialog."

    invoke-static {v0}, Lcom/glu/platform/android/resdl/Debug;->log(Ljava/lang/String;)V

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Title="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-object v1, Lcom/glu/platform/android/resdl/GameLet;->m_modalDialogTitle:Ljava/lang/String;

    invoke-static {v1}, Lcom/glu/platform/android/resdl/GluUtil;->safeString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/glu/platform/android/resdl/Debug;->log(Ljava/lang/String;)V

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Text="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-object v1, Lcom/glu/platform/android/resdl/GameLet;->m_modalDialogText:Ljava/lang/String;

    invoke-static {v1}, Lcom/glu/platform/android/resdl/GluUtil;->safeString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/glu/platform/android/resdl/Debug;->log(Ljava/lang/String;)V

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "B1="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-object v1, Lcom/glu/platform/android/resdl/GameLet;->m_buttonOneText:Ljava/lang/String;

    invoke-static {v1}, Lcom/glu/platform/android/resdl/GluUtil;->safeString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/glu/platform/android/resdl/Debug;->log(Ljava/lang/String;)V

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "B2="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-object v1, Lcom/glu/platform/android/resdl/GameLet;->m_buttonTwoText:Ljava/lang/String;

    invoke-static {v1}, Lcom/glu/platform/android/resdl/GluUtil;->safeString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/glu/platform/android/resdl/Debug;->log(Ljava/lang/String;)V

    sget-object v0, Lcom/glu/platform/android/resdl/GameLet;->m_modalDialog:Landroid/app/AlertDialog;

    if-eqz v0, :cond_0

    sget-object v0, Lcom/glu/platform/android/resdl/GameLet;->m_modalDialog:Landroid/app/AlertDialog;

    invoke-virtual {v0}, Landroid/app/AlertDialog;->isShowing()Z

    move-result v0

    if-eqz v0, :cond_0

    :goto_0
    return-void

    :cond_0
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    sget-wide v2, Lcom/glu/platform/android/resdl/GameLet;->m_lastDialogCloseAt:J

    sub-long/2addr v0, v2

    long-to-int v0, v0

    const/16 v1, 0x3e8

    if-ge v0, v1, :cond_1

    rsub-int v0, v0, 0x3e8

    int-to-long v0, v0

    invoke-static {v0, v1}, Lcom/glu/platform/android/resdl/GluUtil;->sleep(J)V

    :cond_1
    new-instance v0, Landroid/app/AlertDialog$Builder;

    invoke-static {}, Lcom/glu/platform/android/resdl/ResDL;->getContext()Landroid/app/Activity;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    new-instance v1, Lcom/glu/platform/android/resdl/GameLet$1;

    invoke-direct {v1}, Lcom/glu/platform/android/resdl/GameLet$1;-><init>()V

    const/4 v2, 0x1

    invoke-virtual {v0, v2}, Landroid/app/AlertDialog$Builder;->setCancelable(Z)Landroid/app/AlertDialog$Builder;

    new-instance v2, Lcom/glu/platform/android/resdl/GameLet$2;

    invoke-direct {v2}, Lcom/glu/platform/android/resdl/GameLet$2;-><init>()V

    invoke-virtual {v0, v2}, Landroid/app/AlertDialog$Builder;->setOnCancelListener(Landroid/content/DialogInterface$OnCancelListener;)Landroid/app/AlertDialog$Builder;

    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->create()Landroid/app/AlertDialog;

    move-result-object v0

    sput-object v0, Lcom/glu/platform/android/resdl/GameLet;->m_modalDialog:Landroid/app/AlertDialog;

    sget-object v2, Lcom/glu/platform/android/resdl/GameLet;->m_modalDialogTitle:Ljava/lang/String;

    invoke-virtual {v0, v2}, Landroid/app/AlertDialog;->setTitle(Ljava/lang/CharSequence;)V

    sget-object v0, Lcom/glu/platform/android/resdl/GameLet;->m_modalDialog:Landroid/app/AlertDialog;

    sget-object v2, Lcom/glu/platform/android/resdl/GameLet;->m_modalDialogText:Ljava/lang/String;

    invoke-virtual {v0, v2}, Landroid/app/AlertDialog;->setMessage(Ljava/lang/CharSequence;)V

    sget-object v0, Lcom/glu/platform/android/resdl/GameLet;->m_buttonTwoText:Ljava/lang/String;

    if-nez v0, :cond_2

    sget-object v0, Lcom/glu/platform/android/resdl/GameLet;->m_modalDialog:Landroid/app/AlertDialog;

    const/4 v2, -0x3

    sget-object v3, Lcom/glu/platform/android/resdl/GameLet;->m_buttonOneText:Ljava/lang/String;

    invoke-virtual {v0, v2, v3, v1}, Landroid/app/AlertDialog;->setButton(ILjava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)V

    :goto_1
    sget-object v0, Lcom/glu/platform/android/resdl/GameLet;->m_modalDialog:Landroid/app/AlertDialog;

    invoke-virtual {v0}, Landroid/app/AlertDialog;->show()V

    goto :goto_0

    :cond_2
    sget-object v0, Lcom/glu/platform/android/resdl/GameLet;->m_modalDialog:Landroid/app/AlertDialog;

    const/4 v2, -0x1

    sget-object v3, Lcom/glu/platform/android/resdl/GameLet;->m_buttonOneText:Ljava/lang/String;

    invoke-virtual {v0, v2, v3, v1}, Landroid/app/AlertDialog;->setButton(ILjava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)V

    sget-object v0, Lcom/glu/platform/android/resdl/GameLet;->m_modalDialog:Landroid/app/AlertDialog;

    const/4 v2, -0x2

    sget-object v3, Lcom/glu/platform/android/resdl/GameLet;->m_buttonTwoText:Ljava/lang/String;

    invoke-virtual {v0, v2, v3, v1}, Landroid/app/AlertDialog;->setButton(ILjava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)V

    goto :goto_1
.end method

.method public static populate()V
    .locals 6

    const/4 v5, 0x0

    const/4 v4, 0x3

    const/4 v1, 0x0

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    sput-wide v2, Lcom/glu/platform/android/resdl/GameLet;->m_lastDialogCloseAt:J

    invoke-static {}, Lcom/glu/platform/android/resdl/GluUtil;->getNativeProperties()Lcom/glu/platform/android/resdl/CaseInsensitiveHash;

    move-result-object v0

    sput-object v0, Lcom/glu/platform/android/resdl/GameLet;->m_nativeProperties:Ljava/util/Hashtable;

    sget-object v0, Lcom/glu/platform/android/resdl/GameLet$instance;->m_nativeProperties:Ljava/util/Hashtable;

    const-string v2, "Glu-Upsell-URL"

    invoke-virtual {v0, v2}, Ljava/util/Hashtable;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    sput-object v0, Lcom/glu/platform/android/GluPlatformActivity;->SPECIAL_URL_MORE_GAMES:Ljava/lang/String;

    sget-object v0, Lcom/glu/platform/android/resdl/GameLet$instance;->m_nativeProperties:Ljava/util/Hashtable;

    const-string v2, "Glu-Forced-Upgrade-URL"

    invoke-virtual {v0, v2}, Ljava/util/Hashtable;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    sput-object v0, Lcom/glu/platform/android/GluPlatformActivity;->SPECIAL_URL_FORCE_UPGRADE:Ljava/lang/String;

    sget-object v0, Lcom/glu/platform/android/resdl/GameLet$instance;->m_nativeProperties:Ljava/util/Hashtable;

    const-string v2, "Glu-Rate-Me-URL"

    invoke-virtual {v0, v2}, Ljava/util/Hashtable;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    sput-object v0, Lcom/glu/platform/android/GluPlatformActivity;->SPECIAL_URL_RATE_ME:Ljava/lang/String;

    invoke-static {}, Ljava/util/Locale;->getDefault()Ljava/util/Locale;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/Locale;->getLanguage()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v0

    const-string v2, "pt"

    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_0

    invoke-static {}, Ljava/util/Locale;->getDefault()Ljava/util/Locale;

    move-result-object v2

    invoke-virtual {v2}, Ljava/util/Locale;->getCountry()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v2

    const-string v3, "br"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_0

    const-string v0, "ptbr"

    :cond_0
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Locale found: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "   country="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-static {}, Ljava/util/Locale;->getDefault()Ljava/util/Locale;

    move-result-object v3

    invoke-virtual {v3}, Ljava/util/Locale;->getCountry()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/glu/platform/android/resdl/Debug;->log(Ljava/lang/String;)V

    sput-object v0, Lcom/glu/platform/android/resdl/GameLet;->m_locale:Ljava/lang/String;

    invoke-static {}, Ljava/util/Locale;->getDefault()Ljava/util/Locale;

    move-result-object v0

    sget-object v2, Ljava/util/Locale;->ENGLISH:Ljava/util/Locale;

    invoke-virtual {v0, v2}, Ljava/util/Locale;->getDisplayLanguage(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/glu/platform/android/resdl/GameLet;->m_language:Ljava/lang/String;

    invoke-static {}, Ljava/util/Locale;->getDefault()Ljava/util/Locale;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/Locale;->getCountry()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/glu/platform/android/resdl/GameLet;->m_countryCode:Ljava/lang/String;

    invoke-static {}, Lcom/glu/platform/android/resdl/ResDL;->getContext()Landroid/app/Activity;

    move-result-object v0

    invoke-virtual {v0}, Landroid/app/Activity;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    const-string v2, "android_id"

    invoke-static {v0, v2}, Landroid/provider/Settings$Secure;->getString(Landroid/content/ContentResolver;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/glu/platform/android/resdl/GameLet;->m_deviceID:Ljava/lang/String;

    if-nez v0, :cond_1

    const-string v0, "unknown"

    sput-object v0, Lcom/glu/platform/android/resdl/GameLet;->m_deviceID:Ljava/lang/String;

    :cond_1
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "UDID: "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-object v2, Lcom/glu/platform/android/resdl/GameLet;->m_deviceID:Ljava/lang/String;

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/glu/platform/android/resdl/Debug;->log(Ljava/lang/String;)V

    :try_start_0
    const-string v0, "android.os.Build"

    const-string v2, "SERIAL"

    invoke-static {v0, v2}, Lcom/glu/platform/android/resdl/GluUtil;->getField(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v0

    const/4 v2, 0x0

    invoke-virtual {v0, v2}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    sput-object v0, Lcom/glu/platform/android/resdl/GameLet;->m_serial:Ljava/lang/String;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Serial found: "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-object v2, Lcom/glu/platform/android/resdl/GameLet;->m_serial:Ljava/lang/String;

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/glu/platform/android/resdl/Debug;->log(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    const-string v0, "1"

    sput-object v0, Lcom/glu/platform/android/resdl/GameLet;->m_versionMajor:Ljava/lang/String;

    const-string v0, "0"

    sput-object v0, Lcom/glu/platform/android/resdl/GameLet;->m_versionMinor:Ljava/lang/String;

    const-string v0, "0"

    sput-object v0, Lcom/glu/platform/android/resdl/GameLet;->m_versionMicro:Ljava/lang/String;

    const-string v0, "0"

    sput-object v0, Lcom/glu/platform/android/resdl/GameLet;->m_versionNano:Ljava/lang/String;

    :try_start_1
    invoke-static {}, Lcom/glu/platform/android/resdl/GluUtil;->grabVersionString()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/glu/platform/android/resdl/GameLet;->m_fullVersion:Ljava/lang/String;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Filtered version string: "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-object v2, Lcom/glu/platform/android/resdl/GameLet;->m_fullVersion:Ljava/lang/String;

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/glu/platform/android/resdl/Debug;->log(Ljava/lang/String;)V

    sget-object v0, Lcom/glu/platform/android/resdl/GameLet;->m_fullVersion:Ljava/lang/String;

    const-string v2, "."

    invoke-static {v0, v2}, Lcom/glu/platform/android/resdl/GluUtil;->simpleTokenizer(Ljava/lang/String;Ljava/lang/String;)Ljava/util/Vector;

    move-result-object v2

    const/4 v0, 0x0

    invoke-virtual {v2, v0}, Ljava/util/Vector;->elementAt(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    sput-object v0, Lcom/glu/platform/android/resdl/GameLet;->m_versionMajor:Ljava/lang/String;

    const/4 v0, 0x1

    invoke-virtual {v2, v0}, Ljava/util/Vector;->elementAt(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    sput-object v0, Lcom/glu/platform/android/resdl/GameLet;->m_versionMinor:Ljava/lang/String;

    const/4 v0, 0x2

    invoke-virtual {v2, v0}, Ljava/util/Vector;->elementAt(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    sput-object v0, Lcom/glu/platform/android/resdl/GameLet;->m_versionMicro:Ljava/lang/String;

    invoke-virtual {v2}, Ljava/util/Vector;->size()I

    move-result v0

    if-le v0, v4, :cond_2

    const/4 v0, 0x3

    invoke-virtual {v2, v0}, Ljava/util/Vector;->elementAt(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    sput-object v0, Lcom/glu/platform/android/resdl/GameLet;->m_versionNano:Ljava/lang/String;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Version is: "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-object v2, Lcom/glu/platform/android/resdl/GameLet;->m_versionMajor:Ljava/lang/String;

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v2, "."

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-object v2, Lcom/glu/platform/android/resdl/GameLet;->m_versionMinor:Ljava/lang/String;

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v2, "."

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-object v2, Lcom/glu/platform/android/resdl/GameLet;->m_versionMicro:Ljava/lang/String;

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v2, "."

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-object v2, Lcom/glu/platform/android/resdl/GameLet;->m_versionNano:Ljava/lang/String;

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/glu/platform/android/resdl/Debug;->log(Ljava/lang/String;)V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1

    :goto_1
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "NOW is: "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    invoke-virtual {v0, v2, v3}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/glu/platform/android/resdl/Debug;->log(Ljava/lang/String;)V

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Platform version codename: "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-object v2, Landroid/os/Build$VERSION;->CODENAME:Ljava/lang/String;

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/glu/platform/android/resdl/Debug;->log(Ljava/lang/String;)V

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Platform version incremental: "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-object v2, Landroid/os/Build$VERSION;->INCREMENTAL:Ljava/lang/String;

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/glu/platform/android/resdl/Debug;->log(Ljava/lang/String;)V

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Platform version release: "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-object v2, Landroid/os/Build$VERSION;->RELEASE:Ljava/lang/String;

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/glu/platform/android/resdl/Debug;->log(Ljava/lang/String;)V

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Platform version SDK: "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-object v2, Landroid/os/Build$VERSION;->SDK:Ljava/lang/String;

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/glu/platform/android/resdl/Debug;->log(Ljava/lang/String;)V

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Platform version SDK (int): "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget v2, Landroid/os/Build$VERSION;->SDK_INT:I

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/glu/platform/android/resdl/Debug;->log(Ljava/lang/String;)V

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Device model: "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-object v2, Landroid/os/Build;->MODEL:Ljava/lang/String;

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/glu/platform/android/resdl/Debug;->log(Ljava/lang/String;)V

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Device manufacturer: "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-object v2, Landroid/os/Build;->MANUFACTURER:Ljava/lang/String;

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/glu/platform/android/resdl/Debug;->log(Ljava/lang/String;)V

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Device \"name of industrial design\": "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-object v2, Landroid/os/Build;->DEVICE:Ljava/lang/String;

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/glu/platform/android/resdl/Debug;->log(Ljava/lang/String;)V

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Device product name: "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-object v2, Landroid/os/Build;->PRODUCT:Ljava/lang/String;

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/glu/platform/android/resdl/Debug;->log(Ljava/lang/String;)V

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Device fingerprint: "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-object v2, Landroid/os/Build;->FINGERPRINT:Ljava/lang/String;

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/glu/platform/android/resdl/Debug;->log(Ljava/lang/String;)V

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Device CPU: "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-object v2, Landroid/os/Build;->CPU_ABI:Ljava/lang/String;

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/glu/platform/android/resdl/Debug;->log(Ljava/lang/String;)V

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Device Brand/Carrier: "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-object v2, Landroid/os/Build;->BRAND:Ljava/lang/String;

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/glu/platform/android/resdl/Debug;->log(Ljava/lang/String;)V

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Device Board: "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-object v2, Landroid/os/Build;->BOARD:Ljava/lang/String;

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/glu/platform/android/resdl/Debug;->log(Ljava/lang/String;)V

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Build Host: "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-object v2, Landroid/os/Build;->HOST:Ljava/lang/String;

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/glu/platform/android/resdl/Debug;->log(Ljava/lang/String;)V

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Build Identifier: "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-object v2, Landroid/os/Build;->ID:Ljava/lang/String;

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/glu/platform/android/resdl/Debug;->log(Ljava/lang/String;)V

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Build Tags: "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-object v2, Landroid/os/Build;->TAGS:Ljava/lang/String;

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/glu/platform/android/resdl/Debug;->log(Ljava/lang/String;)V

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Build Time: "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-wide v2, Landroid/os/Build;->TIME:J

    invoke-virtual {v0, v2, v3}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/glu/platform/android/resdl/Debug;->log(Ljava/lang/String;)V

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Build Type: "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-object v2, Landroid/os/Build;->TYPE:Ljava/lang/String;

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/glu/platform/android/resdl/Debug;->log(Ljava/lang/String;)V

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Build User: "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-object v2, Landroid/os/Build;->USER:Ljava/lang/String;

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/glu/platform/android/resdl/Debug;->log(Ljava/lang/String;)V

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    sget v2, Landroid/os/Build$VERSION;->SDK_INT:I

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v2, ""

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/glu/platform/android/resdl/GameLet;->m_platformVersion:Ljava/lang/String;

    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    sput v0, Lcom/glu/platform/android/resdl/GameLet;->m_platformVersionI:I

    sget-object v0, Landroid/os/Build$VERSION;->RELEASE:Ljava/lang/String;

    const/16 v2, 0x13

    invoke-static {v0, v2}, Lcom/glu/platform/android/resdl/GluUtil;->safeStringTruncate(Ljava/lang/String;I)Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/glu/platform/android/resdl/GameLet;->m_platformVersionNice:Ljava/lang/String;

    invoke-static {}, Ljava/util/TimeZone;->getDefault()Ljava/util/TimeZone;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/TimeZone;->getID()Ljava/lang/String;

    move-result-object v0

    const/16 v2, 0x63

    invoke-static {v0, v2}, Lcom/glu/platform/android/resdl/GluUtil;->safeStringTruncate(Ljava/lang/String;I)Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/glu/platform/android/resdl/GameLet;->m_timezone:Ljava/lang/String;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Time zone is: "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-object v2, Lcom/glu/platform/android/resdl/GameLet;->m_timezone:Ljava/lang/String;

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/glu/platform/android/resdl/Debug;->log(Ljava/lang/String;)V

    sget-object v0, Landroid/os/Build;->MODEL:Ljava/lang/String;

    const/16 v2, 0x31

    invoke-static {v0, v2}, Lcom/glu/platform/android/resdl/GluUtil;->safeStringTruncate(Ljava/lang/String;I)Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/glu/platform/android/resdl/GameLet;->m_deviceModel:Ljava/lang/String;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Passing as device model: "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-object v2, Lcom/glu/platform/android/resdl/GameLet;->m_deviceModel:Ljava/lang/String;

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/glu/platform/android/resdl/Debug;->log(Ljava/lang/String;)V

    invoke-static {}, Lcom/glu/platform/android/resdl/ResDL;->getContext()Landroid/app/Activity;

    move-result-object v0

    invoke-virtual {v0}, Landroid/app/Activity;->getPackageName()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/glu/platform/android/resdl/GameLet;->m_packageID:Ljava/lang/String;

    sget v0, Lcom/glu/platform/android/resdl/GameLet;->m_platformVersionI:I

    sget-object v2, Lcom/glu/platform/android/resdl/GameLet;->m_deviceModel:Ljava/lang/String;

    invoke-static {v0, v2}, Lcom/glu/platform/android/resdl/GluUtil;->determineVideoPlaybackSettings(ILjava/lang/String;)V

    const-string v0, "Printing out system properties, k=v pairs..."

    invoke-static {v0}, Lcom/glu/platform/android/resdl/Debug;->log(Ljava/lang/String;)V

    invoke-static {}, Ljava/lang/System;->getProperties()Ljava/util/Properties;

    move-result-object v2

    invoke-virtual {v2}, Ljava/util/Properties;->propertyNames()Ljava/util/Enumeration;

    move-result-object v3

    new-instance v4, Ljava/util/Vector;

    invoke-direct {v4}, Ljava/util/Vector;-><init>()V

    :goto_2
    invoke-interface {v3}, Ljava/util/Enumeration;->hasMoreElements()Z

    move-result v0

    if-eqz v0, :cond_3

    invoke-interface {v3}, Ljava/util/Enumeration;->nextElement()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    invoke-virtual {v4, v0}, Ljava/util/Vector;->addElement(Ljava/lang/Object;)V

    goto :goto_2

    :catch_0
    move-exception v0

    sput-object v5, Lcom/glu/platform/android/resdl/GameLet;->m_serial:Ljava/lang/String;

    const-string v2, "Could not get serial."

    invoke-static {v2, v0}, Lcom/glu/platform/android/resdl/Debug;->log(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_0

    :cond_2
    :try_start_2
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Version is: "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-object v2, Lcom/glu/platform/android/resdl/GameLet;->m_versionMajor:Ljava/lang/String;

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v2, "."

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-object v2, Lcom/glu/platform/android/resdl/GameLet;->m_versionMinor:Ljava/lang/String;

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v2, "."

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-object v2, Lcom/glu/platform/android/resdl/GameLet;->m_versionMicro:Ljava/lang/String;

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/glu/platform/android/resdl/Debug;->log(Ljava/lang/String;)V
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_1

    goto/16 :goto_1

    :catch_1
    move-exception v0

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Warning: Version string unexpected format. Version is: "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-object v2, Lcom/glu/platform/android/resdl/GameLet;->m_versionMajor:Ljava/lang/String;

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v2, "."

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-object v2, Lcom/glu/platform/android/resdl/GameLet;->m_versionMinor:Ljava/lang/String;

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v2, "."

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-object v2, Lcom/glu/platform/android/resdl/GameLet;->m_versionMicro:Ljava/lang/String;

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/glu/platform/android/resdl/Debug;->log(Ljava/lang/String;)V

    goto/16 :goto_1

    :cond_3
    :goto_3
    invoke-virtual {v4}, Ljava/util/Vector;->size()I

    move-result v0

    if-ge v1, v0, :cond_4

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v4, v1}, Ljava/util/Vector;->elementAt(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v3, "="

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v4, v1}, Ljava/util/Vector;->elementAt(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    const-string v5, "null"

    invoke-virtual {v2, v0, v5}, Ljava/util/Properties;->getProperty(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/glu/platform/android/resdl/Debug;->log(Ljava/lang/String;)V

    add-int/lit8 v0, v1, 0x1

    move v1, v0

    goto :goto_3

    :cond_4
    return-void
.end method

.method public static setBuildVariant()V
    .locals 4

    const/4 v0, 0x0

    const/4 v1, 0x1

    invoke-static {}, Lcom/glu/platform/android/resdl/GluUtil;->getScreenWidth()I

    move-result v2

    invoke-static {}, Lcom/glu/platform/android/resdl/GluUtil;->getScreenHeight()I

    move-result v3

    invoke-static {v2, v3}, Ljava/lang/Math;->min(II)I

    move-result v2

    sget v3, Lcom/glu/platform/android/resdl/GameLet;->MAX_SMALL_DIMENSION_FOR_WVGA:I

    if-le v2, v3, :cond_0

    sput v1, Lcom/glu/platform/android/resdl/GameLet;->m_buildVariant:I

    :goto_0
    sget-object v0, Lcom/glu/platform/android/resdl/GenSettings;->SPECIAL_FILE_URL_KEYS:[Ljava/lang/String;

    sget v1, Lcom/glu/platform/android/resdl/GameLet;->m_buildVariant:I

    aget-object v0, v0, v1

    sput-object v0, Lcom/glu/platform/android/resdl/GameLet;->KEY_SPECIAL_FILE_URL:Ljava/lang/String;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Special file URL for this device: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-object v1, Lcom/glu/platform/android/resdl/GameLet;->KEY_SPECIAL_FILE_URL:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/glu/platform/android/resdl/Debug;->log(Ljava/lang/String;)V

    sget-object v0, Lcom/glu/platform/android/resdl/GenSettings;->SPECIAL_RES_FILENAME_ARRAY:[[Ljava/lang/String;

    sget v1, Lcom/glu/platform/android/resdl/GameLet;->m_buildVariant:I

    aget-object v0, v0, v1

    sput-object v0, Lcom/glu/platform/android/resdl/GameLet;->SPECIAL_RES_FILENAME_ARRAY:[Ljava/lang/String;

    sget-object v0, Lcom/glu/platform/android/resdl/GenSettings;->SPECIAL_RES_FILESIZE_ARRAY:[[I

    sget v1, Lcom/glu/platform/android/resdl/GameLet;->m_buildVariant:I

    aget-object v0, v0, v1

    sput-object v0, Lcom/glu/platform/android/resdl/GameLet;->SPECIAL_RES_FILESIZE_ARRAY:[I

    sget-object v0, Lcom/glu/platform/android/resdl/GenSettings;->SPECIAL_RES_CHECKSUM_ARRAY:[[J

    sget v1, Lcom/glu/platform/android/resdl/GameLet;->m_buildVariant:I

    aget-object v0, v0, v1

    sput-object v0, Lcom/glu/platform/android/resdl/GameLet;->SPECIAL_RES_CHECKSUM_ARRAY:[J

    return-void

    :cond_0
    sput v0, Lcom/glu/platform/android/resdl/GameLet;->m_buildVariant:I

    goto/16 :goto_0
.end method

.method public static startGame()V
    .locals 0

    invoke-static {}, Lcom/glu/platform/android/resdl/ResDL;->onReadyToLaunchGame()V

    return-void
.end method
