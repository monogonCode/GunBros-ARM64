.class public Lcom/glu/platform/android/GluPlatformActivity;
.super Landroid/app/Activity;

# interfaces
.implements Landroid/hardware/SensorEventListener;
.implements Landroid/media/AudioTrack$OnPlaybackPositionUpdateListener;
.implements Landroid/view/SurfaceHolder$Callback;
.implements Lcom/glu/platform/android/GluCallback;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/glu/platform/android/GluPlatformActivity$SystemMessageBoxRunner;,
        Lcom/glu/platform/android/GluPlatformActivity$Runner;,
        Lcom/glu/platform/android/GluPlatformActivity$SystemMessageBoxMessage;,
        Lcom/glu/platform/android/GluPlatformActivity$TouchTracker;
    }
.end annotation


# static fields
.field static final synthetic $assertionsDisabled:Z

.field public static GETPOINTERCOUNT:Ljava/lang/reflect/Method;

.field public static GETPOINTERID:Ljava/lang/reflect/Method;

.field public static GETSOURCE:Ljava/lang/reflect/Method;

.field public static GETX:Ljava/lang/reflect/Method;

.field public static GETY:Ljava/lang/reflect/Method;

.field public static SPECIAL_URL_FORCE_UPGRADE:Ljava/lang/String;

.field public static SPECIAL_URL_MORE_GAMES:Ljava/lang/String;

.field public static SPECIAL_URL_RATE_ME:Ljava/lang/String;

.field public static activePads:I

.field public static activePointers:I

.field private static initialized:Z

.field public static instance:Lcom/glu/platform/android/GluPlatformActivity;

.field protected static m_OSVersion:I

.field public static multitouchReported:Z

.field public static multitouchSupported:Z

.field private static param:[Ljava/lang/Object;

.field public static touchpadSupported:Z


# instance fields
.field final EVENT_SPECIAL_URL_FORCE_UPGRADE:I

.field final EVENT_SPECIAL_URL_MORE_GAMES:I

.field final EVENT_SPECIAL_URL_RATE_ME:I

.field private TOUCH_MOVE_THRESHOLD:I

.field public displayHeight:I

.field private m_CurrentOrientation:I

.field private m_Enum:[Ljava/lang/String;

.field private m_EnumDirs:Z

.field private m_EnumIndex:I

.field private m_ExternalPath:Ljava/lang/String;

.field private m_Handler:Landroid/os/Handler;

.field private m_InternalPath:Ljava/lang/String;

.field private m_ListeningToAccelerometer:Z

.field private m_MainView:Lcom/glu/platform/android/GluMainView;

.field private m_NativeHandle:I

.field private m_NotificationIntent:Landroid/content/Intent;

.field private m_NotificationReceiver:Landroid/content/BroadcastReceiver;

.field private m_Orientation:I

.field private m_Orientation0:J

.field private m_Orientation180:J

.field private m_Orientation270:J

.field private m_Orientation90:J

.field private m_PCMBuffer:[B

.field private m_PCMBufferOffset:I

.field private m_PCMBufferSizeInBytes:I

.field private m_PCMBufferSizeInFrames:I

.field private m_PCMMediaPlayer:Landroid/media/AudioTrack;

.field public m_SMBHandler:Landroid/os/Handler;

.field private m_SupportsMultiTouch:Z

.field private m_SupportsTouch:Z

.field public m_Terminator:Landroid/os/Handler;

.field private m_TickRateMS:I

.field private m_UsePCMMixing:Z

.field private m_ValidOrientations:[Z

.field private m_Vibrator:Landroid/os/Vibrator;

.field private m_WakeLock:Landroid/os/PowerManager$WakeLock;

.field private m_aTouches:[Lcom/glu/platform/android/GluPlatformActivity$TouchTracker;

.field private m_bMultiTouchEnabled:Z

.field private m_bNotificationReceiverRegistered:Z

.field private m_cTouches:I

.field private m_jni:Lcom/glu/platform/android/GluPlatformActivityJNI;

.field private m_oel:Landroid/view/OrientationEventListener;

.field private savedInstanceState:Landroid/os/Bundle;

.field touchPad:Z


# direct methods
.method static constructor <clinit>()V
    .locals 3

    const/4 v1, 0x1

    const/4 v2, 0x0

    const-class v0, Lcom/glu/platform/android/GluPlatformActivity;

    invoke-virtual {v0}, Ljava/lang/Class;->desiredAssertionStatus()Z

    move-result v0

    if-nez v0, :cond_0

    move v0, v1

    :goto_0
    sput-boolean v0, Lcom/glu/platform/android/GluPlatformActivity;->$assertionsDisabled:Z

    const/4 v0, 0x0

    sput-object v0, Lcom/glu/platform/android/GluPlatformActivity;->instance:Lcom/glu/platform/android/GluPlatformActivity;

    sput v2, Lcom/glu/platform/android/GluPlatformActivity;->activePointers:I

    sput v2, Lcom/glu/platform/android/GluPlatformActivity;->activePads:I

    sput-boolean v2, Lcom/glu/platform/android/GluPlatformActivity;->multitouchSupported:Z

    sput-boolean v2, Lcom/glu/platform/android/GluPlatformActivity;->multitouchReported:Z

    sput-boolean v2, Lcom/glu/platform/android/GluPlatformActivity;->touchpadSupported:Z

    new-array v0, v1, [Ljava/lang/Integer;

    sput-object v0, Lcom/glu/platform/android/GluPlatformActivity;->param:[Ljava/lang/Object;

    sput-boolean v2, Lcom/glu/platform/android/GluPlatformActivity;->initialized:Z

    sput v2, Lcom/glu/platform/android/GluPlatformActivity;->m_OSVersion:I

    return-void

    :cond_0
    move v0, v2

    goto :goto_0
.end method

.method public constructor <init>()V
    .locals 3

    const/4 v2, -0x1

    const/4 v1, 0x0

    invoke-direct {p0}, Landroid/app/Activity;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->savedInstanceState:Landroid/os/Bundle;

    iput-boolean v1, p0, Lcom/glu/platform/android/GluPlatformActivity;->touchPad:Z

    const/4 v0, 0x1

    iput v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->EVENT_SPECIAL_URL_RATE_ME:I

    const/4 v0, 0x2

    iput v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->EVENT_SPECIAL_URL_FORCE_UPGRADE:I

    const/4 v0, 0x3

    iput v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->EVENT_SPECIAL_URL_MORE_GAMES:I

    new-instance v0, Lcom/glu/platform/android/GluPlatformActivity$3;

    invoke-direct {v0, p0}, Lcom/glu/platform/android/GluPlatformActivity$3;-><init>(Lcom/glu/platform/android/GluPlatformActivity;)V

    iput-object v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_SMBHandler:Landroid/os/Handler;

    new-instance v0, Landroid/os/Handler;

    invoke-direct {v0}, Landroid/os/Handler;-><init>()V

    iput-object v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_Handler:Landroid/os/Handler;

    new-instance v0, Lcom/glu/platform/android/GluPlatformActivityJNI;

    invoke-direct {v0}, Lcom/glu/platform/android/GluPlatformActivityJNI;-><init>()V

    iput-object v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_jni:Lcom/glu/platform/android/GluPlatformActivityJNI;

    iput v2, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_TickRateMS:I

    iput v1, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_Orientation:I

    iput v1, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_PCMBufferOffset:I

    new-instance v0, Lcom/glu/platform/android/GluPlatformActivity$4;

    invoke-direct {v0, p0}, Lcom/glu/platform/android/GluPlatformActivity$4;-><init>(Lcom/glu/platform/android/GluPlatformActivity;)V

    iput-object v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_Terminator:Landroid/os/Handler;

    const/4 v0, 0x4

    new-array v0, v0, [Z

    iput-object v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_ValidOrientations:[Z

    iput v2, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_CurrentOrientation:I

    iput-boolean v1, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_bNotificationReceiverRegistered:Z

    new-instance v0, Lcom/glu/platform/android/GluPlatformActivity$5;

    invoke-direct {v0, p0}, Lcom/glu/platform/android/GluPlatformActivity$5;-><init>(Lcom/glu/platform/android/GluPlatformActivity;)V

    iput-object v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_NotificationReceiver:Landroid/content/BroadcastReceiver;

    return-void
.end method

.method static synthetic access$100(Lcom/glu/platform/android/GluPlatformActivity;)I
    .locals 1

    iget v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_NativeHandle:I

    return v0
.end method

.method static synthetic access$200(Lcom/glu/platform/android/GluPlatformActivity;)Lcom/glu/platform/android/GluPlatformActivityJNI;
    .locals 1

    iget-object v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_jni:Lcom/glu/platform/android/GluPlatformActivityJNI;

    return-object v0
.end method

.method static synthetic access$300(Lcom/glu/platform/android/GluPlatformActivity;)I
    .locals 1

    iget v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_CurrentOrientation:I

    return v0
.end method

.method static synthetic access$302(Lcom/glu/platform/android/GluPlatformActivity;I)I
    .locals 0

    iput p1, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_CurrentOrientation:I

    return p1
.end method

.method static synthetic access$400(Lcom/glu/platform/android/GluPlatformActivity;)[Z
    .locals 1

    iget-object v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_ValidOrientations:[Z

    return-object v0
.end method

.method private getTouchTracker(I)Lcom/glu/platform/android/GluPlatformActivity$TouchTracker;
    .locals 4

    const/4 v1, 0x0

    move v0, v1

    :goto_0
    iget v2, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_cTouches:I

    if-ge v0, v2, :cond_1

    iget-object v2, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_aTouches:[Lcom/glu/platform/android/GluPlatformActivity$TouchTracker;

    aget-object v2, v2, v0

    iget v3, v2, Lcom/glu/platform/android/GluPlatformActivity$TouchTracker;->m_PointerId:I

    if-ne v3, p1, :cond_0

    move-object v0, v2

    :goto_1
    return-object v0

    :cond_0
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_1
    iget v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_cTouches:I

    const/16 v2, 0xa

    if-ge v0, v2, :cond_2

    iget-object v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_aTouches:[Lcom/glu/platform/android/GluPlatformActivity$TouchTracker;

    iget v2, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_cTouches:I

    add-int/lit8 v3, v2, 0x1

    iput v3, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_cTouches:I

    aget-object v0, v0, v2

    iput p1, v0, Lcom/glu/platform/android/GluPlatformActivity$TouchTracker;->m_PointerId:I

    iput v1, v0, Lcom/glu/platform/android/GluPlatformActivity$TouchTracker;->m_Mode:I

    goto :goto_1

    :cond_2
    const/4 v0, 0x0

    goto :goto_1
.end method

.method public static initializeTouch()V
    .locals 9

    const/4 v8, 0x0

    const/4 v7, 0x1

    sget-boolean v0, Lcom/glu/platform/android/GluPlatformActivity;->initialized:Z

    if-eqz v0, :cond_0

    :goto_0
    return-void

    :cond_0
    :try_start_0
    sget-object v0, Lcom/glu/platform/android/GluPlatformActivity;->instance:Lcom/glu/platform/android/GluPlatformActivity;

    iget-object v0, v0, Lcom/glu/platform/android/GluPlatformActivity;->m_MainView:Lcom/glu/platform/android/GluMainView;

    invoke-virtual {v0}, Lcom/glu/platform/android/GluMainView;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v0

    const-string v1, "android.content.pm.PackageManager"

    invoke-static {v1}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v1

    const/4 v2, 0x1

    new-array v2, v2, [Ljava/lang/Class;

    const/4 v3, 0x0

    new-instance v4, Ljava/lang/String;

    invoke-direct {v4}, Ljava/lang/String;-><init>()V

    invoke-virtual {v4}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v4

    aput-object v4, v2, v3

    const/4 v3, 0x1

    new-array v3, v3, [Ljava/lang/Object;

    const/4 v4, 0x0

    new-instance v5, Ljava/lang/String;

    const-string v6, "android.hardware.touchscreen.multitouch"

    invoke-direct {v5, v6}, Ljava/lang/String;-><init>(Ljava/lang/String;)V

    aput-object v5, v3, v4

    const-string v4, "hasSystemFeature"

    invoke-virtual {v1, v4, v2}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v1

    invoke-virtual {v1, v0, v3}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Boolean;

    invoke-virtual {v0}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v0

    sput-boolean v0, Lcom/glu/platform/android/GluPlatformActivity;->multitouchReported:Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :goto_1
    :try_start_1
    const-string v0, "android.view.MotionEvent"

    invoke-static {v0}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0

    const/4 v1, 0x1

    new-array v1, v1, [Ljava/lang/Class;

    const/4 v2, 0x0

    sget-object v3, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    aput-object v3, v1, v2

    const-string v2, "getPointerCount"

    const/4 v3, 0x0

    invoke-virtual {v0, v2, v3}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v2

    sput-object v2, Lcom/glu/platform/android/GluPlatformActivity;->GETPOINTERCOUNT:Ljava/lang/reflect/Method;

    const-string v2, "getPointerId"

    invoke-virtual {v0, v2, v1}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v2

    sput-object v2, Lcom/glu/platform/android/GluPlatformActivity;->GETPOINTERID:Ljava/lang/reflect/Method;

    const-string v2, "getX"

    invoke-virtual {v0, v2, v1}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v2

    sput-object v2, Lcom/glu/platform/android/GluPlatformActivity;->GETX:Ljava/lang/reflect/Method;

    const-string v2, "getY"

    invoke-virtual {v0, v2, v1}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v0

    sput-object v0, Lcom/glu/platform/android/GluPlatformActivity;->GETY:Ljava/lang/reflect/Method;

    const/4 v0, 0x1

    sput-boolean v0, Lcom/glu/platform/android/GluPlatformActivity;->multitouchSupported:Z
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    :goto_2
    :try_start_2
    const-string v0, "android.view.InputEvent"

    invoke-static {v0}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0

    const-string v1, "getSource"

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v0

    sput-object v0, Lcom/glu/platform/android/GluPlatformActivity;->GETSOURCE:Ljava/lang/reflect/Method;

    const/4 v0, 0x1

    sput-boolean v0, Lcom/glu/platform/android/GluPlatformActivity;->touchpadSupported:Z
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_2

    :goto_3
    sget-boolean v0, Lcom/glu/platform/android/GluPlatformActivity;->touchpadSupported:Z

    if-eqz v0, :cond_1

    :try_start_3
    const-string v0, "android.view.ViewRoot"

    invoke-static {v0}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0

    const/4 v1, 0x1

    new-array v1, v1, [Ljava/lang/Class;

    const/4 v2, 0x0

    sget-object v3, Ljava/lang/Boolean;->TYPE:Ljava/lang/Class;

    aput-object v3, v1, v2

    const-string v2, "setProcessPositionEvents"

    invoke-virtual {v0, v2, v1}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v0

    sget-object v1, Lcom/glu/platform/android/GluPlatformActivity;->instance:Lcom/glu/platform/android/GluPlatformActivity;

    invoke-virtual {v1}, Lcom/glu/platform/android/GluPlatformActivity;->getWindow()Landroid/view/Window;

    move-result-object v1

    invoke-virtual {v1}, Landroid/view/Window;->getDecorView()Landroid/view/View;

    move-result-object v1

    invoke-virtual {v1}, Landroid/view/View;->getRootView()Landroid/view/View;

    move-result-object v1

    invoke-virtual {v1}, Landroid/view/View;->getParent()Landroid/view/ViewParent;

    move-result-object v1

    const/4 v2, 0x1

    new-array v2, v2, [Ljava/lang/Object;

    const/4 v3, 0x0

    new-instance v4, Ljava/lang/Boolean;

    const/4 v5, 0x1

    invoke-direct {v4, v5}, Ljava/lang/Boolean;-><init>(Z)V

    aput-object v4, v2, v3

    invoke-virtual {v0, v1, v2}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    const/4 v0, 0x1

    sput-boolean v0, Lcom/glu/platform/android/GluPlatformActivity;->touchpadSupported:Z
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_3

    :cond_1
    :goto_4
    sput-boolean v7, Lcom/glu/platform/android/GluPlatformActivity;->initialized:Z

    goto/16 :goto_0

    :catch_0
    move-exception v0

    sput-boolean v8, Lcom/glu/platform/android/GluPlatformActivity;->multitouchReported:Z

    goto/16 :goto_1

    :catch_1
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    sput-boolean v8, Lcom/glu/platform/android/GluPlatformActivity;->multitouchSupported:Z

    goto :goto_2

    :catch_2
    move-exception v0

    sput-boolean v8, Lcom/glu/platform/android/GluPlatformActivity;->touchpadSupported:Z

    goto :goto_3

    :catch_3
    move-exception v0

    sput-boolean v8, Lcom/glu/platform/android/GluPlatformActivity;->touchpadSupported:Z

    goto :goto_4
.end method

.method private static isVolumeKey(I)Z
    .locals 1

    const/16 v0, 0x19

    if-eq v0, p0, :cond_0

    const/16 v0, 0x18

    if-ne v0, p0, :cond_1

    :cond_0
    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_1
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public static nfcEnabled()I
    .locals 1

    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    return v0
.end method

.method public static onResDLDone()V
    .locals 1

    sget-object v0, Lcom/glu/platform/android/GluPlatformActivity;->instance:Lcom/glu/platform/android/GluPlatformActivity;

    invoke-virtual {v0}, Lcom/glu/platform/android/GluPlatformActivity;->iOnResDLDone()V

    return-void
.end method

.method private removeTouchTracker(Lcom/glu/platform/android/GluPlatformActivity$TouchTracker;)V
    .locals 3

    const/4 v0, -0x1

    iput v0, p1, Lcom/glu/platform/android/GluPlatformActivity$TouchTracker;->m_PointerId:I

    const/4 v0, 0x0

    iput v0, p1, Lcom/glu/platform/android/GluPlatformActivity$TouchTracker;->m_Mode:I

    iget v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_cTouches:I

    add-int/lit8 v0, v0, -0x1

    iput v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_cTouches:I

    iget v0, p1, Lcom/glu/platform/android/GluPlatformActivity$TouchTracker;->m_Index:I

    iget v1, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_cTouches:I

    if-ge v0, v1, :cond_0

    iget-object v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_aTouches:[Lcom/glu/platform/android/GluPlatformActivity$TouchTracker;

    iget v1, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_cTouches:I

    aget-object v0, v0, v1

    iget-object v1, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_aTouches:[Lcom/glu/platform/android/GluPlatformActivity$TouchTracker;

    iget v2, p1, Lcom/glu/platform/android/GluPlatformActivity$TouchTracker;->m_Index:I

    aput-object v0, v1, v2

    iget v1, p1, Lcom/glu/platform/android/GluPlatformActivity$TouchTracker;->m_Index:I

    iput v1, v0, Lcom/glu/platform/android/GluPlatformActivity$TouchTracker;->m_Index:I

    iget-object v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_aTouches:[Lcom/glu/platform/android/GluPlatformActivity$TouchTracker;

    iget v1, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_cTouches:I

    aput-object p1, v0, v1

    iget v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_cTouches:I

    iput v0, p1, Lcom/glu/platform/android/GluPlatformActivity$TouchTracker;->m_Index:I

    :cond_0
    return-void
.end method

.method private setState(I)V
    .locals 2

    new-instance v0, Landroid/content/Intent;

    const-class v1, Lcom/glu/platform/android/GluNotificationService;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const-string v1, "com.glu.platform.android.APP_STATE"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;

    const-string v1, "com.glu.platform.andoird.APP_STATE_STATE"

    invoke-virtual {v0, v1, p1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    invoke-virtual {p0, v0}, Lcom/glu/platform/android/GluPlatformActivity;->startService(Landroid/content/Intent;)Landroid/content/ComponentName;

    return-void
.end method

.method private touchBegan(III)V
    .locals 12

    const/4 v3, 0x1

    const-wide v8, 0x4066800000000000L    # 180.0

    const-wide v6, 0x3fd999999999999aL    # 0.4

    if-gez p1, :cond_0

    const/4 p1, 0x0

    :cond_0
    invoke-direct {p0, p3}, Lcom/glu/platform/android/GluPlatformActivity;->getTouchTracker(I)Lcom/glu/platform/android/GluPlatformActivity$TouchTracker;

    move-result-object v0

    if-eqz v0, :cond_1

    iget v1, v0, Lcom/glu/platform/android/GluPlatformActivity$TouchTracker;->m_Mode:I

    if-eq v1, v3, :cond_1

    iget v1, v0, Lcom/glu/platform/android/GluPlatformActivity$TouchTracker;->m_Mode:I

    const/4 v2, 0x2

    if-eq v1, v2, :cond_1

    iput p1, v0, Lcom/glu/platform/android/GluPlatformActivity$TouchTracker;->m_X:I

    iput p2, v0, Lcom/glu/platform/android/GluPlatformActivity$TouchTracker;->m_Y:I

    iput v3, v0, Lcom/glu/platform/android/GluPlatformActivity$TouchTracker;->m_Mode:I

    iget v1, p0, Lcom/glu/platform/android/GluPlatformActivity;->TOUCH_MOVE_THRESHOLD:I

    iput v1, v0, Lcom/glu/platform/android/GluPlatformActivity$TouchTracker;->m_MoveThreshold:I

    invoke-virtual {p0}, Lcom/glu/platform/android/GluPlatformActivity;->IsPSP()Z

    move-result v0

    if-eqz v0, :cond_3

    int-to-double v0, p1

    int-to-double v2, p2

    iget-boolean v4, p0, Lcom/glu/platform/android/GluPlatformActivity;->touchPad:Z

    if-eqz v4, :cond_4

    const-wide v4, 0x4077200000000000L    # 370.0

    cmpg-double v4, v0, v4

    if-gez v4, :cond_2

    sub-double/2addr v0, v8

    mul-double/2addr v0, v6

    const-wide v4, 0x4057400000000000L    # 93.0

    add-double/2addr v0, v4

    :goto_0
    const-wide v4, -0x4026666666666666L    # -0.4

    sub-double/2addr v2, v8

    mul-double/2addr v2, v4

    const-wide v4, 0x4078100000000000L    # 385.0

    add-double/2addr v2, v4

    move-wide v10, v2

    move-wide v2, v0

    move-wide v0, v10

    :goto_1
    iget-object v4, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_jni:Lcom/glu/platform/android/GluPlatformActivityJNI;

    iget v5, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_NativeHandle:I

    double-to-int v2, v2

    double-to-int v0, v0

    invoke-virtual {v4, v5, v2, v0, p3}, Lcom/glu/platform/android/GluPlatformActivityJNI;->TouchBegan(IIII)V

    :cond_1
    :goto_2
    return-void

    :cond_2
    const-wide v4, 0x4082a00000000000L    # 596.0

    cmpl-double v4, v0, v4

    if-lez v4, :cond_1

    const-wide v4, 0x4088900000000000L    # 786.0

    sub-double/2addr v0, v4

    mul-double/2addr v0, v6

    const-wide v4, 0x4087c00000000000L    # 760.0

    add-double/2addr v0, v4

    goto :goto_0

    :cond_3
    iget-object v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_jni:Lcom/glu/platform/android/GluPlatformActivityJNI;

    iget v1, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_NativeHandle:I

    invoke-virtual {v0, v1, p1, p2, p3}, Lcom/glu/platform/android/GluPlatformActivityJNI;->TouchBegan(IIII)V

    goto :goto_2

    :cond_4
    move-wide v10, v2

    move-wide v2, v0

    move-wide v0, v10

    goto :goto_1
.end method

.method private touchCancelled(III)V
    .locals 3

    invoke-direct {p0, p3}, Lcom/glu/platform/android/GluPlatformActivity;->getTouchTracker(I)Lcom/glu/platform/android/GluPlatformActivity$TouchTracker;

    move-result-object v0

    if-eqz v0, :cond_1

    iget v1, v0, Lcom/glu/platform/android/GluPlatformActivity$TouchTracker;->m_Mode:I

    const/4 v2, 0x1

    if-eq v1, v2, :cond_0

    iget v1, v0, Lcom/glu/platform/android/GluPlatformActivity$TouchTracker;->m_Mode:I

    const/4 v2, 0x2

    if-ne v1, v2, :cond_1

    :cond_0
    iput p1, v0, Lcom/glu/platform/android/GluPlatformActivity$TouchTracker;->m_X:I

    iput p2, v0, Lcom/glu/platform/android/GluPlatformActivity$TouchTracker;->m_Y:I

    const/4 v1, 0x4

    iput v1, v0, Lcom/glu/platform/android/GluPlatformActivity$TouchTracker;->m_Mode:I

    iget-object v1, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_jni:Lcom/glu/platform/android/GluPlatformActivityJNI;

    iget v2, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_NativeHandle:I

    invoke-virtual {v1, v2, p1, p2, p3}, Lcom/glu/platform/android/GluPlatformActivityJNI;->TouchCancelled(IIII)V

    invoke-direct {p0, v0}, Lcom/glu/platform/android/GluPlatformActivity;->removeTouchTracker(Lcom/glu/platform/android/GluPlatformActivity$TouchTracker;)V

    :cond_1
    return-void
.end method

.method private touchEnded(III)V
    .locals 11

    if-gez p1, :cond_0

    const/4 p1, 0x0

    :cond_0
    invoke-direct {p0, p3}, Lcom/glu/platform/android/GluPlatformActivity;->getTouchTracker(I)Lcom/glu/platform/android/GluPlatformActivity$TouchTracker;

    move-result-object v4

    if-eqz v4, :cond_2

    iget v0, v4, Lcom/glu/platform/android/GluPlatformActivity$TouchTracker;->m_Mode:I

    const/4 v1, 0x1

    if-eq v0, v1, :cond_1

    iget v0, v4, Lcom/glu/platform/android/GluPlatformActivity$TouchTracker;->m_Mode:I

    const/4 v1, 0x2

    if-ne v0, v1, :cond_2

    :cond_1
    iput p1, v4, Lcom/glu/platform/android/GluPlatformActivity$TouchTracker;->m_X:I

    iput p2, v4, Lcom/glu/platform/android/GluPlatformActivity$TouchTracker;->m_Y:I

    const/4 v0, 0x3

    iput v0, v4, Lcom/glu/platform/android/GluPlatformActivity$TouchTracker;->m_Mode:I

    invoke-virtual {p0}, Lcom/glu/platform/android/GluPlatformActivity;->IsPSP()Z

    move-result v0

    if-eqz v0, :cond_4

    int-to-double v0, p1

    int-to-double v2, p2

    iget-boolean v5, p0, Lcom/glu/platform/android/GluPlatformActivity;->touchPad:Z

    if-eqz v5, :cond_5

    const-wide v5, 0x407e300000000000L    # 483.0

    cmpg-double v5, v0, v5

    if-gez v5, :cond_3

    const-wide v5, 0x3fd999999999999aL    # 0.4

    const-wide v7, 0x4066800000000000L    # 180.0

    sub-double/2addr v0, v7

    mul-double/2addr v0, v5

    const-wide v5, 0x4057400000000000L    # 93.0

    add-double/2addr v0, v5

    :goto_0
    const-wide v5, -0x4026666666666666L    # -0.4

    const-wide v7, 0x4066800000000000L    # 180.0

    sub-double/2addr v2, v7

    mul-double/2addr v2, v5

    const-wide v5, 0x4078100000000000L    # 385.0

    add-double/2addr v2, v5

    move-wide v9, v2

    move-wide v2, v0

    move-wide v0, v9

    :goto_1
    iget-object v5, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_jni:Lcom/glu/platform/android/GluPlatformActivityJNI;

    iget v6, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_NativeHandle:I

    double-to-int v2, v2

    double-to-int v0, v0

    invoke-virtual {v5, v6, v2, v0, p3}, Lcom/glu/platform/android/GluPlatformActivityJNI;->TouchEnded(IIII)V

    :goto_2
    invoke-direct {p0, v4}, Lcom/glu/platform/android/GluPlatformActivity;->removeTouchTracker(Lcom/glu/platform/android/GluPlatformActivity$TouchTracker;)V

    :cond_2
    return-void

    :cond_3
    const-wide v5, 0x3fd999999999999aL    # 0.4

    const-wide v7, 0x4088900000000000L    # 786.0

    sub-double/2addr v0, v7

    mul-double/2addr v0, v5

    const-wide v5, 0x4087c00000000000L    # 760.0

    add-double/2addr v0, v5

    goto :goto_0

    :cond_4
    iget-object v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_jni:Lcom/glu/platform/android/GluPlatformActivityJNI;

    iget v1, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_NativeHandle:I

    invoke-virtual {v0, v1, p1, p2, p3}, Lcom/glu/platform/android/GluPlatformActivityJNI;->TouchEnded(IIII)V

    goto :goto_2

    :cond_5
    move-wide v9, v2

    move-wide v2, v0

    move-wide v0, v9

    goto :goto_1
.end method

.method private touchMoved(III)V
    .locals 10

    if-gez p1, :cond_0

    const/4 p1, 0x0

    :cond_0
    invoke-direct {p0, p3}, Lcom/glu/platform/android/GluPlatformActivity;->getTouchTracker(I)Lcom/glu/platform/android/GluPlatformActivity$TouchTracker;

    move-result-object v2

    if-eqz v2, :cond_5

    iget v0, v2, Lcom/glu/platform/android/GluPlatformActivity$TouchTracker;->m_Mode:I

    const/4 v1, 0x1

    if-eq v0, v1, :cond_1

    iget v0, v2, Lcom/glu/platform/android/GluPlatformActivity$TouchTracker;->m_Mode:I

    const/4 v1, 0x2

    if-ne v0, v1, :cond_5

    :cond_1
    iget v0, v2, Lcom/glu/platform/android/GluPlatformActivity$TouchTracker;->m_X:I

    sub-int v1, v0, p1

    iget v0, v2, Lcom/glu/platform/android/GluPlatformActivity$TouchTracker;->m_Y:I

    sub-int/2addr v0, p2

    if-gez v1, :cond_2

    neg-int v1, v1

    :cond_2
    if-gez v0, :cond_3

    neg-int v0, v0

    :cond_3
    iget v3, v2, Lcom/glu/platform/android/GluPlatformActivity$TouchTracker;->m_MoveThreshold:I

    if-ge v1, v3, :cond_4

    iget v1, v2, Lcom/glu/platform/android/GluPlatformActivity$TouchTracker;->m_MoveThreshold:I

    if-lt v0, v1, :cond_5

    :cond_4
    iput p1, v2, Lcom/glu/platform/android/GluPlatformActivity$TouchTracker;->m_X:I

    iput p2, v2, Lcom/glu/platform/android/GluPlatformActivity$TouchTracker;->m_Y:I

    const/4 v0, 0x2

    iput v0, v2, Lcom/glu/platform/android/GluPlatformActivity$TouchTracker;->m_Mode:I

    const/4 v0, 0x1

    iput v0, v2, Lcom/glu/platform/android/GluPlatformActivity$TouchTracker;->m_MoveThreshold:I

    invoke-virtual {p0}, Lcom/glu/platform/android/GluPlatformActivity;->IsPSP()Z

    move-result v0

    if-eqz v0, :cond_8

    int-to-double v0, p1

    int-to-double v2, p2

    iget-boolean v4, p0, Lcom/glu/platform/android/GluPlatformActivity;->touchPad:Z

    if-eqz v4, :cond_9

    const-wide v4, 0x4077200000000000L    # 370.0

    cmpg-double v4, v0, v4

    if-gez v4, :cond_6

    const-wide v4, 0x3fd999999999999aL    # 0.4

    const-wide v6, 0x4066800000000000L    # 180.0

    sub-double/2addr v0, v6

    mul-double/2addr v0, v4

    const-wide v4, 0x4057400000000000L    # 93.0

    add-double/2addr v0, v4

    :goto_0
    const-wide v4, -0x4026666666666666L    # -0.4

    const-wide v6, 0x4066800000000000L    # 180.0

    sub-double/2addr v2, v6

    mul-double/2addr v2, v4

    const-wide v4, 0x4078100000000000L    # 385.0

    add-double/2addr v2, v4

    move-wide v8, v2

    move-wide v2, v0

    move-wide v0, v8

    :goto_1
    iget-object v4, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_jni:Lcom/glu/platform/android/GluPlatformActivityJNI;

    iget v5, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_NativeHandle:I

    double-to-int v2, v2

    double-to-int v1, v0

    iget-boolean v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->touchPad:Z

    if-eqz v0, :cond_7

    const/4 v0, 0x1

    :goto_2
    invoke-virtual {v4, v5, v2, v1, v0}, Lcom/glu/platform/android/GluPlatformActivityJNI;->TouchMoved(IIII)V

    :cond_5
    :goto_3
    return-void

    :cond_6
    const-wide v4, 0x4082a00000000000L    # 596.0

    cmpl-double v4, v0, v4

    if-lez v4, :cond_5

    const-wide v4, 0x3fd999999999999aL    # 0.4

    const-wide v6, 0x4088900000000000L    # 786.0

    sub-double/2addr v0, v6

    mul-double/2addr v0, v4

    const-wide v4, 0x4087c00000000000L    # 760.0

    add-double/2addr v0, v4

    goto :goto_0

    :cond_7
    const/4 v0, 0x0

    goto :goto_2

    :cond_8
    iget-object v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_jni:Lcom/glu/platform/android/GluPlatformActivityJNI;

    iget v1, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_NativeHandle:I

    invoke-virtual {v0, v1, p1, p2, p3}, Lcom/glu/platform/android/GluPlatformActivityJNI;->TouchMoved(IIII)V

    goto :goto_3

    :cond_9
    move-wide v8, v2

    move-wide v2, v0

    move-wide v0, v8

    goto :goto_1
.end method

.method private translateKeyCode(ILandroid/view/KeyEvent;)I
    .locals 2

    const/4 v0, 0x7

    if-lt p1, v0, :cond_1

    const/16 v1, 0x10

    if-gt p1, v1, :cond_1

    add-int/lit8 v0, p1, 0x30

    add-int/lit8 p1, v0, -0x7

    :cond_0
    :goto_0
    return p1

    :cond_1
    const/16 v1, 0x1d

    if-lt p1, v1, :cond_3

    const/16 v1, 0x36

    if-gt p1, v1, :cond_3

    add-int/lit8 v1, p1, -0x1d

    invoke-virtual {p2}, Landroid/view/KeyEvent;->isShiftPressed()Z

    move-result v0

    if-eqz v0, :cond_2

    const/16 v0, 0x41

    :goto_1
    add-int p1, v0, v1

    goto :goto_0

    :cond_2
    const/16 v0, 0x61

    goto :goto_1

    :cond_3
    sparse-switch p1, :sswitch_data_0

    invoke-virtual {p0}, Lcom/glu/platform/android/GluPlatformActivity;->IsPSP()Z

    move-result v0

    if-eqz v0, :cond_0

    const/high16 v0, 0x10000000

    add-int/2addr p1, v0

    goto :goto_0

    :sswitch_0
    const/16 p1, 0xc

    goto :goto_0

    :sswitch_1
    const/4 p1, 0x2

    goto :goto_0

    :sswitch_2
    const/16 p1, 0x2a

    goto :goto_0

    :sswitch_3
    const/16 p1, 0x23

    goto :goto_0

    :sswitch_4
    const/4 p1, 0x4

    goto :goto_0

    :sswitch_5
    const/4 p1, 0x5

    goto :goto_0

    :sswitch_6
    const/4 p1, 0x6

    goto :goto_0

    :sswitch_7
    move p1, v0

    goto :goto_0

    :sswitch_8
    const/16 p1, 0xb

    goto :goto_0

    :sswitch_9
    const/16 p1, 0x11

    goto :goto_0

    :sswitch_a
    const/16 p1, 0x12

    goto :goto_0

    :sswitch_b
    const/4 p1, 0x1

    goto :goto_0

    :sswitch_c
    const/16 p1, 0x2c

    goto :goto_0

    :sswitch_d
    const/16 p1, 0x2e

    goto :goto_0

    :sswitch_e
    const/16 p1, 0x9

    goto :goto_0

    :sswitch_f
    const/16 p1, 0x20

    goto :goto_0

    :sswitch_10
    const/16 p1, 0x13

    goto :goto_0

    :sswitch_11
    const/16 p1, 0x8

    goto :goto_0

    :sswitch_12
    const/16 p1, 0x60

    goto :goto_0

    :sswitch_13
    const/16 p1, 0x2d

    goto :goto_0

    :sswitch_14
    const/16 p1, 0x3d

    goto :goto_0

    :sswitch_15
    const/16 p1, 0x5b

    goto :goto_0

    :sswitch_16
    const/16 p1, 0x5d

    goto :goto_0

    :sswitch_17
    const/16 p1, 0x5c

    goto :goto_0

    :sswitch_18
    const/16 p1, 0x3b

    goto :goto_0

    :sswitch_19
    const/16 p1, 0x27

    goto :goto_0

    :sswitch_1a
    const/16 p1, 0x2f

    goto :goto_0

    :sswitch_1b
    const/16 p1, 0x40

    goto :goto_0

    :sswitch_1c
    const/16 p1, 0x2b

    goto :goto_0

    :sswitch_1d
    const/16 p1, 0x8c

    goto :goto_0

    nop

    :sswitch_data_0
    .sparse-switch
        0x4 -> :sswitch_0
        0x5 -> :sswitch_1
        0x6 -> :sswitch_2
        0x11 -> :sswitch_2
        0x12 -> :sswitch_3
        0x13 -> :sswitch_4
        0x14 -> :sswitch_5
        0x15 -> :sswitch_6
        0x16 -> :sswitch_7
        0x17 -> :sswitch_8
        0x18 -> :sswitch_9
        0x19 -> :sswitch_a
        0x1a -> :sswitch_b
        0x37 -> :sswitch_c
        0x38 -> :sswitch_d
        0x3d -> :sswitch_e
        0x3e -> :sswitch_f
        0x42 -> :sswitch_10
        0x43 -> :sswitch_11
        0x44 -> :sswitch_12
        0x45 -> :sswitch_13
        0x46 -> :sswitch_14
        0x47 -> :sswitch_15
        0x48 -> :sswitch_16
        0x49 -> :sswitch_17
        0x4a -> :sswitch_18
        0x4b -> :sswitch_19
        0x4c -> :sswitch_1a
        0x4d -> :sswitch_1b
        0x51 -> :sswitch_1c
        0x52 -> :sswitch_1d
    .end sparse-switch
.end method


# virtual methods
.method public APKExistsDir(Ljava/lang/String;)Z
    .locals 2

    const/4 v0, 0x0

    invoke-virtual {p0}, Lcom/glu/platform/android/GluPlatformActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    invoke-virtual {v1}, Landroid/content/res/Resources;->getAssets()Landroid/content/res/AssetManager;

    move-result-object v1

    :try_start_0
    invoke-virtual {v1, p1}, Landroid/content/res/AssetManager;->list(Ljava/lang/String;)[Ljava/lang/String;
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v1

    if-eqz v1, :cond_0

    const/4 v0, 0x1

    :cond_0
    :goto_0
    return v0

    :catch_0
    move-exception v1

    goto :goto_0
.end method

.method public AddLocalNotification(JJLjava/lang/String;Ljava/lang/String;)V
    .locals 3

    new-instance v0, Landroid/content/Intent;

    const-class v1, Lcom/glu/platform/android/GluNotificationService;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const-string v1, "com.glu.platform.android.ADD_NOTIFICATION"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;

    const-string v1, "com.glu.platform.android.NOTIFICATION_WHEN"

    long-to-int v2, p1

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    const-string v1, "com.glu.platform.android.NOTIFICATION_TITLE"

    invoke-virtual {v0, v1, p5}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    const-string v1, "com.glu.platform.android.NOTIFICATION_MESSAGE"

    invoke-virtual {v0, v1, p6}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    const-string v1, "com.glu.platform.android.NOTIFICATION_BADGE"

    long-to-int v2, p3

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    invoke-virtual {p0, v0}, Lcom/glu/platform/android/GluPlatformActivity;->startService(Landroid/content/Intent;)Landroid/content/ComponentName;

    return-void
.end method

.method public CancelAllLocalNotifications()V
    .locals 2

    new-instance v0, Landroid/content/Intent;

    const-class v1, Lcom/glu/platform/android/GluNotificationService;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const-string v1, "com.glu.platform.android.REMOVE_ALL_NOTIFICATIONS"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;

    invoke-virtual {p0, v0}, Lcom/glu/platform/android/GluPlatformActivity;->startService(Landroid/content/Intent;)Landroid/content/ComponentName;

    return-void
.end method

.method public CreateEGL()Ljavax/microedition/khronos/egl/EGL10;
    .locals 1

    invoke-static {}, Ljavax/microedition/khronos/egl/EGLContext;->getEGL()Ljavax/microedition/khronos/egl/EGL;

    move-result-object v0

    check-cast v0, Ljavax/microedition/khronos/egl/EGL10;

    return-object v0
.end method

.method public declared-synchronized DestroySoundEngine()V
    .locals 2

    monitor-enter p0

    :try_start_0
    iget-boolean v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_UsePCMMixing:Z

    if-eqz v0, :cond_2

    iget-object v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_PCMMediaPlayer:Landroid/media/AudioTrack;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_PCMMediaPlayer:Landroid/media/AudioTrack;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/media/AudioTrack;->setPlaybackPositionUpdateListener(Landroid/media/AudioTrack$OnPlaybackPositionUpdateListener;)V

    iget-object v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_PCMMediaPlayer:Landroid/media/AudioTrack;

    invoke-virtual {v0}, Landroid/media/AudioTrack;->stop()V

    iget-object v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_PCMMediaPlayer:Landroid/media/AudioTrack;

    invoke-virtual {v0}, Landroid/media/AudioTrack;->release()V

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_PCMMediaPlayer:Landroid/media/AudioTrack;

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_PCMBuffer:[B

    const/4 v0, 0x0

    iput v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_PCMBufferSizeInBytes:I

    const/4 v0, 0x0

    iput v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_PCMBufferOffset:I

    :cond_0
    sget-boolean v0, Lcom/glu/platform/android/GluPlatformActivity;->$assertionsDisabled:Z

    if-nez v0, :cond_1

    iget-object v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_PCMMediaPlayer:Landroid/media/AudioTrack;

    if-eqz v0, :cond_1

    new-instance v0, Ljava/lang/AssertionError;

    invoke-direct {v0}, Ljava/lang/AssertionError;-><init>()V

    throw v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0

    :cond_1
    :try_start_1
    sget-boolean v0, Lcom/glu/platform/android/GluPlatformActivity;->$assertionsDisabled:Z

    if-nez v0, :cond_2

    iget-object v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_PCMBuffer:[B

    if-eqz v0, :cond_2

    new-instance v0, Ljava/lang/AssertionError;

    invoke-direct {v0}, Ljava/lang/AssertionError;-><init>()V

    throw v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    :cond_2
    monitor-exit p0

    return-void
.end method

.method public DestroyVibrationEngine()V
    .locals 1

    iget-object v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_Vibrator:Landroid/os/Vibrator;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_Vibrator:Landroid/os/Vibrator;

    invoke-virtual {v0}, Landroid/os/Vibrator;->cancel()V

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_Vibrator:Landroid/os/Vibrator;

    :cond_0
    return-void
.end method

.method public EnableMultipleTouch(Z)V
    .locals 2

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "enable: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    iput-boolean p1, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_bMultiTouchEnabled:Z

    return-void
.end method

.method public EnablePushNotifications(Z)V
    .locals 2

    new-instance v0, Landroid/content/Intent;

    const-class v1, Lcom/glu/platform/android/GluNotificationService;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const-string v1, "com.glu.platform.android.ENABLE_PUSH_NOTIFICATIONS"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;

    const-string v1, "com.glu.platform.android.ENABLE_NOTIFICATIONS_ENABLE"

    invoke-virtual {v0, v1, p1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Z)Landroid/content/Intent;

    invoke-virtual {p0, v0}, Lcom/glu/platform/android/GluPlatformActivity;->startService(Landroid/content/Intent;)Landroid/content/ComponentName;

    return-void
.end method

.method public EnumInit(Ljava/lang/String;Z)Z
    .locals 6

    const/4 v1, 0x0

    invoke-virtual {p0}, Lcom/glu/platform/android/GluPlatformActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getAssets()Landroid/content/res/AssetManager;

    move-result-object v2

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_Enum:[Ljava/lang/String;

    iput v1, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_EnumIndex:I

    iput-boolean p2, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_EnumDirs:Z

    :try_start_0
    invoke-virtual {v2, p1}, Landroid/content/res/AssetManager;->list(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_Enum:[Ljava/lang/String;
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_1

    const/4 v0, 0x1

    :try_start_1
    iget-object v3, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_Enum:[Ljava/lang/String;

    array-length v4, v3

    :goto_0
    if-ge v1, v4, :cond_0

    aget-object v5, v3, v1
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_2

    :try_start_2
    invoke-virtual {v2, v5}, Landroid/content/res/AssetManager;->open(Ljava/lang/String;)Ljava/io/InputStream;
    :try_end_2
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_0

    :goto_1
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :catch_0
    move-exception v5

    goto :goto_1

    :catch_1
    move-exception v0

    move v0, v1

    :cond_0
    :goto_2
    return v0

    :catch_2
    move-exception v1

    goto :goto_2
.end method

.method public EnumNext()Lcom/glu/platform/android/EnumResult;
    .locals 6

    const/4 v0, 0x0

    iget-object v1, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_Enum:[Ljava/lang/String;

    if-eqz v1, :cond_3

    :cond_0
    iget v1, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_EnumIndex:I

    iget-object v2, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_Enum:[Ljava/lang/String;

    array-length v2, v2

    if-ge v1, v2, :cond_3

    invoke-virtual {p0}, Lcom/glu/platform/android/GluPlatformActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    invoke-virtual {v1}, Landroid/content/res/Resources;->getAssets()Landroid/content/res/AssetManager;

    move-result-object v4

    iget-object v1, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_Enum:[Ljava/lang/String;

    iget v2, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_EnumIndex:I

    add-int/lit8 v3, v2, 0x1

    iput v3, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_EnumIndex:I

    aget-object v5, v1, v2

    const-wide/16 v1, 0x0

    const/4 v3, 0x1

    :try_start_0
    invoke-virtual {v4, v5}, Landroid/content/res/AssetManager;->openFd(Ljava/lang/String;)Landroid/content/res/AssetFileDescriptor;

    move-result-object v4

    invoke-virtual {v4}, Landroid/content/res/AssetFileDescriptor;->getLength()J
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-wide v1

    :goto_0
    if-eqz v3, :cond_1

    iget-boolean v4, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_EnumDirs:Z

    if-eqz v4, :cond_2

    :cond_1
    if-nez v3, :cond_0

    iget-boolean v3, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_EnumDirs:Z

    if-eqz v3, :cond_0

    :cond_2
    new-instance v0, Lcom/glu/platform/android/EnumResult;

    invoke-direct {v0}, Lcom/glu/platform/android/EnumResult;-><init>()V

    iput-object v5, v0, Lcom/glu/platform/android/EnumResult;->m_Filename:Ljava/lang/String;

    iput-wide v1, v0, Lcom/glu/platform/android/EnumResult;->m_Length:J

    :cond_3
    return-object v0

    :catch_0
    move-exception v3

    const/4 v3, 0x0

    goto :goto_0
.end method

.method public FinishApp()V
    .locals 2

    iget-object v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_Terminator:Landroid/os/Handler;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Landroid/os/Handler;->sendEmptyMessage(I)Z

    return-void
.end method

.method public GetAndroidMinBufferSize(III)I
    .locals 2

    const/4 v0, 0x1

    if-ne v0, p2, :cond_1

    const/4 v0, 0x4

    move v1, v0

    :goto_0
    const/16 v0, 0x8

    if-ne v0, p3, :cond_2

    const/4 v0, 0x3

    :goto_1
    invoke-static {p1, v1, v0}, Landroid/media/AudioTrack;->getMinBufferSize(III)I

    move-result v0

    const/4 v1, -0x1

    if-ne v1, v0, :cond_0

    const/4 v0, 0x0

    :cond_0
    return v0

    :cond_1
    const/16 v0, 0xc

    move v1, v0

    goto :goto_0

    :cond_2
    const/4 v0, 0x2

    goto :goto_1
.end method

.method public GetDeviceAvailableMemory()J
    .locals 2

    invoke-static {}, Landroid/os/Debug;->getNativeHeapFreeSize()J

    move-result-wide v0

    return-wide v0
.end method

.method public GetDeviceOrientation()I
    .locals 1

    invoke-virtual {p0}, Lcom/glu/platform/android/GluPlatformActivity;->getRequestedOrientation()I

    move-result v0

    return v0
.end method

.method public GetTickRate()I
    .locals 1

    iget v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_TickRateMS:I

    return v0
.end method

.method public HandlePushNotifications()V
    .locals 2

    new-instance v0, Landroid/content/Intent;

    const-class v1, Lcom/glu/platform/android/GluNotificationService;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const-string v1, "com.glu.platform.android.HANDLE_PUSH_NOTIFICATIONS"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;

    invoke-virtual {p0, v0}, Lcom/glu/platform/android/GluPlatformActivity;->startService(Landroid/content/Intent;)Landroid/content/ComponentName;

    return-void
.end method

.method public InitialiseSoundEngine(ZIIIII)Z
    .locals 8

    const/16 v5, 0x8

    const/4 v1, 0x3

    const/4 v0, 0x2

    const/4 v7, 0x0

    const/4 v6, 0x1

    iput-boolean p1, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_UsePCMMixing:Z

    if-eqz p1, :cond_8

    sget-boolean v2, Lcom/glu/platform/android/GluPlatformActivity;->$assertionsDisabled:Z

    if-nez v2, :cond_0

    iget-object v2, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_PCMMediaPlayer:Landroid/media/AudioTrack;

    if-eqz v2, :cond_0

    new-instance v0, Ljava/lang/AssertionError;

    invoke-direct {v0}, Ljava/lang/AssertionError;-><init>()V

    throw v0

    :cond_0
    if-ne v0, p3, :cond_1

    const/16 v3, 0xc

    :goto_0
    if-ne v5, p4, :cond_2

    move v4, v1

    :goto_1
    sget-boolean v2, Lcom/glu/platform/android/GluPlatformActivity;->$assertionsDisabled:Z

    if-nez v2, :cond_3

    if-gtz p2, :cond_3

    new-instance v0, Ljava/lang/AssertionError;

    invoke-direct {v0}, Ljava/lang/AssertionError;-><init>()V

    throw v0

    :cond_1
    const/4 v3, 0x4

    goto :goto_0

    :cond_2
    move v4, v0

    goto :goto_1

    :cond_3
    sget-boolean v2, Lcom/glu/platform/android/GluPlatformActivity;->$assertionsDisabled:Z

    if-nez v2, :cond_4

    if-eq v6, p3, :cond_4

    if-eq v0, p3, :cond_4

    new-instance v0, Ljava/lang/AssertionError;

    invoke-direct {v0}, Ljava/lang/AssertionError;-><init>()V

    throw v0

    :cond_4
    sget-boolean v0, Lcom/glu/platform/android/GluPlatformActivity;->$assertionsDisabled:Z

    if-nez v0, :cond_5

    if-eq v5, p4, :cond_5

    const/16 v0, 0x10

    if-eq v0, p4, :cond_5

    new-instance v0, Ljava/lang/AssertionError;

    invoke-direct {v0}, Ljava/lang/AssertionError;-><init>()V

    throw v0

    :cond_5
    sget-boolean v0, Lcom/glu/platform/android/GluPlatformActivity;->$assertionsDisabled:Z

    if-nez v0, :cond_6

    if-gtz p5, :cond_6

    new-instance v0, Ljava/lang/AssertionError;

    invoke-direct {v0}, Ljava/lang/AssertionError;-><init>()V

    throw v0

    :cond_6
    sget-boolean v0, Lcom/glu/platform/android/GluPlatformActivity;->$assertionsDisabled:Z

    if-nez v0, :cond_7

    if-gtz p6, :cond_7

    new-instance v0, Ljava/lang/AssertionError;

    invoke-direct {v0}, Ljava/lang/AssertionError;-><init>()V

    throw v0

    :cond_7
    new-instance v0, Landroid/media/AudioTrack;

    move v2, p2

    move v5, p5

    invoke-direct/range {v0 .. v6}, Landroid/media/AudioTrack;-><init>(IIIIII)V

    iput-object v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_PCMMediaPlayer:Landroid/media/AudioTrack;

    iget-object v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_PCMMediaPlayer:Landroid/media/AudioTrack;

    if-eqz v0, :cond_9

    iget-object v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_PCMMediaPlayer:Landroid/media/AudioTrack;

    invoke-virtual {v0, p0}, Landroid/media/AudioTrack;->setPlaybackPositionUpdateListener(Landroid/media/AudioTrack$OnPlaybackPositionUpdateListener;)V

    iget-object v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_PCMMediaPlayer:Landroid/media/AudioTrack;

    invoke-virtual {v0, p6}, Landroid/media/AudioTrack;->setPositionNotificationPeriod(I)I

    new-array v0, p5, [B

    iput-object v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_PCMBuffer:[B

    iput p5, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_PCMBufferSizeInBytes:I

    iput p6, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_PCMBufferSizeInFrames:I

    iput v7, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_PCMBufferOffset:I

    iget-object v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_PCMMediaPlayer:Landroid/media/AudioTrack;

    iget-object v1, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_PCMBuffer:[B

    invoke-virtual {v0, v1, v7, p5}, Landroid/media/AudioTrack;->write([BII)I

    :cond_8
    :goto_2
    return v6

    :cond_9
    move v6, v7

    goto :goto_2
.end method

.method public InitialiseSoundEvent(Ljava/lang/String;J)Landroid/media/MediaPlayer;
    .locals 6

    const/4 v1, 0x0

    :try_start_0
    new-instance v0, Landroid/media/MediaPlayer;

    invoke-direct {v0}, Landroid/media/MediaPlayer;-><init>()V
    :try_end_0
    .catch Ljava/lang/IllegalStateException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/IllegalArgumentException; {:try_start_0 .. :try_end_0} :catch_2
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :try_start_1
    invoke-virtual {v0, p1}, Landroid/media/MediaPlayer;->setDataSource(Ljava/lang/String;)V

    new-instance v2, Lcom/glu/platform/android/GluPlatformActivity$1;

    invoke-direct {v2, p0, p2, p3}, Lcom/glu/platform/android/GluPlatformActivity$1;-><init>(Lcom/glu/platform/android/GluPlatformActivity;J)V

    invoke-virtual {v0, v2}, Landroid/media/MediaPlayer;->setOnCompletionListener(Landroid/media/MediaPlayer$OnCompletionListener;)V

    invoke-virtual {v0}, Landroid/media/MediaPlayer;->prepare()V
    :try_end_1
    .catch Ljava/lang/IllegalStateException; {:try_start_1 .. :try_end_1} :catch_5
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_4
    .catch Ljava/lang/IllegalArgumentException; {:try_start_1 .. :try_end_1} :catch_3
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    :goto_0
    return-object v0

    :catch_0
    move-exception v0

    move-object v2, v1

    :goto_1
    :try_start_2
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "IllegalStateException: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_2

    if-eqz v2, :cond_0

    invoke-virtual {v2}, Landroid/media/MediaPlayer;->release()V

    :cond_0
    move-object v0, v1

    goto :goto_0

    :catch_1
    move-exception v0

    move-object v2, v1

    :goto_2
    :try_start_3
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "IOException: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_2

    if-eqz v2, :cond_1

    invoke-virtual {v2}, Landroid/media/MediaPlayer;->release()V

    :cond_1
    move-object v0, v1

    goto :goto_0

    :catch_2
    move-exception v0

    move-object v2, v1

    :goto_3
    :try_start_4
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "IllegalArgumentException: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_2

    if-eqz v2, :cond_2

    invoke-virtual {v2}, Landroid/media/MediaPlayer;->release()V

    :cond_2
    move-object v0, v1

    goto :goto_0

    :catchall_0
    move-exception v0

    move-object v2, v1

    :goto_4
    if-eqz v2, :cond_3

    invoke-virtual {v2}, Landroid/media/MediaPlayer;->release()V

    :cond_3
    throw v0

    :catchall_1
    move-exception v1

    move-object v2, v0

    move-object v0, v1

    goto :goto_4

    :catchall_2
    move-exception v0

    goto :goto_4

    :catch_3
    move-exception v2

    move-object v5, v2

    move-object v2, v0

    move-object v0, v5

    goto :goto_3

    :catch_4
    move-exception v2

    move-object v5, v2

    move-object v2, v0

    move-object v0, v5

    goto :goto_2

    :catch_5
    move-exception v2

    move-object v5, v2

    move-object v2, v0

    move-object v0, v5

    goto :goto_1
.end method

.method public InitialiseVibrationEngine()Z
    .locals 1

    sget-boolean v0, Lcom/glu/platform/android/GluPlatformActivity;->$assertionsDisabled:Z

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_Vibrator:Landroid/os/Vibrator;

    if-eqz v0, :cond_0

    new-instance v0, Ljava/lang/AssertionError;

    invoke-direct {v0}, Ljava/lang/AssertionError;-><init>()V

    throw v0

    :cond_0
    const-string v0, "vibrator"

    invoke-virtual {p0, v0}, Lcom/glu/platform/android/GluPlatformActivity;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/os/Vibrator;

    iput-object v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_Vibrator:Landroid/os/Vibrator;

    iget-object v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_Vibrator:Landroid/os/Vibrator;

    if-eqz v0, :cond_1

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_1
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public IsPSP()Z
    .locals 2

    sget-object v0, Landroid/os/Build;->MANUFACTURER:Ljava/lang/String;

    const-string v1, "Sony Ericsson"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    sget-object v0, Landroid/os/Build;->DEVICE:Ljava/lang/String;

    const-string v1, "R800"

    invoke-virtual {v0, v1}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public IsUserOnWiFi()Z
    .locals 1

    invoke-static {}, Lcom/glu/platform/android/resdl/GluUtil;->isUserOnWiFi()Z

    move-result v0

    return v0
.end method

.method public LaunchURL(Ljava/lang/String;)Z
    .locals 3

    invoke-static {p1}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v0

    new-instance v1, Landroid/content/Intent;

    const-string v2, "android.intent.action.VIEW"

    invoke-direct {v1, v2, v0}, Landroid/content/Intent;-><init>(Ljava/lang/String;Landroid/net/Uri;)V

    const/high16 v0, 0x10000000

    invoke-virtual {v1, v0}, Landroid/content/Intent;->setFlags(I)Landroid/content/Intent;

    invoke-virtual {p0, v1}, Lcom/glu/platform/android/GluPlatformActivity;->startActivity(Landroid/content/Intent;)V

    const/4 v0, 0x1

    return v0
.end method

.method public LaunchURL(Ljava/lang/String;I)Z
    .locals 1

    const/4 v0, 0x1

    if-ne p2, v0, :cond_0

    sget-object v0, Lcom/glu/platform/android/GluPlatformActivity;->SPECIAL_URL_RATE_ME:Ljava/lang/String;

    invoke-virtual {p0, v0}, Lcom/glu/platform/android/GluPlatformActivity;->LaunchURL(Ljava/lang/String;)Z

    move-result v0

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x2

    if-ne p2, v0, :cond_1

    sget-object v0, Lcom/glu/platform/android/GluPlatformActivity;->SPECIAL_URL_FORCE_UPGRADE:Ljava/lang/String;

    invoke-virtual {p0, v0}, Lcom/glu/platform/android/GluPlatformActivity;->LaunchURL(Ljava/lang/String;)Z

    move-result v0

    goto :goto_0

    :cond_1
    const/4 v0, 0x3

    if-ne p2, v0, :cond_2

    sget-object v0, Lcom/glu/platform/android/GluPlatformActivity;->SPECIAL_URL_MORE_GAMES:Ljava/lang/String;

    invoke-virtual {p0, v0}, Lcom/glu/platform/android/GluPlatformActivity;->LaunchURL(Ljava/lang/String;)Z

    move-result v0

    goto :goto_0

    :cond_2
    invoke-virtual {p0, p1}, Lcom/glu/platform/android/GluPlatformActivity;->LaunchURL(Ljava/lang/String;)Z

    move-result v0

    goto :goto_0
.end method

.method public OpenAPKFile(Ljava/lang/String;)Landroid/content/res/AssetFileDescriptor;
    .locals 2

    const/4 v0, 0x0

    invoke-virtual {p0}, Lcom/glu/platform/android/GluPlatformActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    invoke-virtual {v1}, Landroid/content/res/Resources;->getAssets()Landroid/content/res/AssetManager;

    move-result-object v1

    :try_start_0
    invoke-virtual {v1, p1}, Landroid/content/res/AssetManager;->openFd(Ljava/lang/String;)Landroid/content/res/AssetFileDescriptor;
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    :goto_0
    return-object v0

    :catch_0
    move-exception v1

    goto :goto_0
.end method

.method public PlayVibration(J)Z
    .locals 1

    iget-object v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_Vibrator:Landroid/os/Vibrator;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_Vibrator:Landroid/os/Vibrator;

    invoke-virtual {v0, p1, p2}, Landroid/os/Vibrator;->vibrate(J)V

    :cond_0
    const/4 v0, 0x1

    return v0
.end method

.method public RemoveLocalNotification(Ljava/lang/String;Ljava/lang/String;)V
    .locals 2

    new-instance v0, Landroid/content/Intent;

    const-class v1, Lcom/glu/platform/android/GluNotificationService;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const-string v1, "com.glu.platform.android.REMOVE_NOTIFICATION"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;

    const-string v1, "com.glu.platform.android.NOTIFICATION_TITLE"

    invoke-virtual {v0, v1, p1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    const-string v1, "com.glu.platform.android.NOTIFICATION_MESSAGE"

    invoke-virtual {v0, v1, p2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    invoke-virtual {p0, v0}, Lcom/glu/platform/android/GluPlatformActivity;->startService(Landroid/content/Intent;)Landroid/content/ComponentName;

    return-void
.end method

.method public SetAutoRotationValues(JJJJ)V
    .locals 0

    iput-wide p1, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_Orientation0:J

    iput-wide p3, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_Orientation90:J

    iput-wide p5, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_Orientation180:J

    iput-wide p7, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_Orientation270:J

    return-void
.end method

.method public SetDeviceOrientation(I)Z
    .locals 1

    invoke-virtual {p0, p1}, Lcom/glu/platform/android/GluPlatformActivity;->setRequestedOrientation(I)V

    const/4 v0, 0x1

    return v0
.end method

.method public SetTickRate(I)V
    .locals 1

    iput p1, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_TickRateMS:I

    iget-object v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_MainView:Lcom/glu/platform/android/GluMainView;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_MainView:Lcom/glu/platform/android/GluMainView;

    invoke-virtual {v0}, Lcom/glu/platform/android/GluMainView;->TickRateChanged()V

    :cond_0
    return-void
.end method

.method public SetVolume(B)V
    .locals 4

    const/4 v3, 0x3

    sget-boolean v0, Lcom/glu/platform/android/GluPlatformActivity;->$assertionsDisabled:Z

    if-nez v0, :cond_1

    if-ltz p1, :cond_0

    const/16 v0, 0xa

    if-le p1, v0, :cond_1

    :cond_0
    new-instance v0, Ljava/lang/AssertionError;

    invoke-direct {v0}, Ljava/lang/AssertionError;-><init>()V

    throw v0

    :cond_1
    const-string v0, "audio"

    invoke-virtual {p0, v0}, Lcom/glu/platform/android/GluPlatformActivity;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/media/AudioManager;

    if-eqz v0, :cond_2

    invoke-virtual {v0, v3}, Landroid/media/AudioManager;->getStreamMaxVolume(I)I

    move-result v1

    mul-int/2addr v1, p1

    div-int/lit8 v1, v1, 0xa

    invoke-virtual {v0, v3}, Landroid/media/AudioManager;->getStreamVolume(I)I

    move-result v2

    if-eq v1, v2, :cond_2

    const/4 v2, 0x1

    invoke-virtual {v0, v3, v1, v2}, Landroid/media/AudioManager;->setStreamVolume(III)V

    :cond_2
    return-void
.end method

.method public StartAudioStream()Z
    .locals 2

    const/4 v0, 0x0

    iget-boolean v1, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_UsePCMMixing:Z

    if-eqz v1, :cond_0

    iget-object v1, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_PCMMediaPlayer:Landroid/media/AudioTrack;

    if-eqz v1, :cond_0

    iget-object v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_PCMMediaPlayer:Landroid/media/AudioTrack;

    invoke-virtual {v0}, Landroid/media/AudioTrack;->play()V

    const/4 v0, 0x1

    :cond_0
    return v0
.end method

.method public StartAutoRotation(J)Z
    .locals 10

    const/4 v1, 0x1

    const/4 v2, 0x0

    iget-object v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_oel:Landroid/view/OrientationEventListener;

    if-nez v0, :cond_5

    new-instance v0, Lcom/glu/platform/android/GluPlatformActivity$2;

    invoke-direct {v0, p0, p0}, Lcom/glu/platform/android/GluPlatformActivity$2;-><init>(Lcom/glu/platform/android/GluPlatformActivity;Landroid/content/Context;)V

    iput-object v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_oel:Landroid/view/OrientationEventListener;

    iget-object v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_oel:Landroid/view/OrientationEventListener;

    invoke-virtual {v0}, Landroid/view/OrientationEventListener;->canDetectOrientation()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-virtual {p0}, Lcom/glu/platform/android/GluPlatformActivity;->getRequestedOrientation()I

    move-result v0

    iput v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_CurrentOrientation:I

    iget-object v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_oel:Landroid/view/OrientationEventListener;

    invoke-virtual {v0}, Landroid/view/OrientationEventListener;->enable()V

    move v0, v1

    :goto_0
    iget-object v4, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_ValidOrientations:[Z

    iget-wide v5, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_Orientation0:J

    iget-wide v7, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_Orientation0:J

    and-long/2addr v7, p1

    cmp-long v3, v5, v7

    if-nez v3, :cond_1

    move v3, v1

    :goto_1
    aput-boolean v3, v4, v2

    iget-object v4, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_ValidOrientations:[Z

    iget-wide v5, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_Orientation90:J

    iget-wide v7, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_Orientation90:J

    and-long/2addr v7, p1

    cmp-long v3, v5, v7

    if-nez v3, :cond_2

    move v3, v1

    :goto_2
    aput-boolean v3, v4, v1

    iget-object v4, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_ValidOrientations:[Z

    const/4 v5, 0x2

    iget-wide v6, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_Orientation180:J

    iget-wide v8, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_Orientation180:J

    and-long/2addr v8, p1

    cmp-long v3, v6, v8

    if-nez v3, :cond_3

    move v3, v1

    :goto_3
    aput-boolean v3, v4, v5

    iget-object v3, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_ValidOrientations:[Z

    const/4 v4, 0x3

    iget-wide v5, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_Orientation270:J

    iget-wide v7, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_Orientation270:J

    and-long/2addr v7, p1

    cmp-long v5, v5, v7

    if-nez v5, :cond_4

    :goto_4
    aput-boolean v1, v3, v4

    return v0

    :cond_0
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_oel:Landroid/view/OrientationEventListener;

    move v0, v2

    goto :goto_0

    :cond_1
    move v3, v2

    goto :goto_1

    :cond_2
    move v3, v2

    goto :goto_2

    :cond_3
    move v3, v2

    goto :goto_3

    :cond_4
    move v1, v2

    goto :goto_4

    :cond_5
    move v0, v1

    goto :goto_0
.end method

.method public StartLocalNotificationService()V
    .locals 3

    new-instance v0, Landroid/content/Intent;

    const-class v1, Lcom/glu/platform/android/GluBroadcastHandler;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const-string v1, "com.glu.platform.android.ENABLE_NOTIFICATIONS"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;

    const-string v1, "com.glu.platform.android.ENABLE_NOTIFICATIONS_ENABLE"

    const/4 v2, 0x1

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Z)Landroid/content/Intent;

    invoke-virtual {p0, v0}, Lcom/glu/platform/android/GluPlatformActivity;->sendBroadcast(Landroid/content/Intent;)V

    return-void
.end method

.method public StartMovieActivity(Ljava/lang/String;J)Z
    .locals 3

    new-instance v0, Landroid/content/Intent;

    const-class v1, Lcom/glu/platform/android/GluMovieActivity;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const-string v1, "com.glu.platform.android.Event"

    invoke-virtual {v0, v1, p2, p3}, Landroid/content/Intent;->putExtra(Ljava/lang/String;J)Landroid/content/Intent;

    const-string v1, "com.glu.platform.android.Filename"

    invoke-virtual {v0, v1, p1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    const-string v1, "com.glu.platform.android.InternalPath"

    iget-object v2, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_InternalPath:Ljava/lang/String;

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    const-string v1, "com.glu.platform.android.ExternalPath"

    iget-object v2, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_ExternalPath:Ljava/lang/String;

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    invoke-virtual {p0, v0}, Lcom/glu/platform/android/GluPlatformActivity;->startActivity(Landroid/content/Intent;)V

    const/4 v0, 0x1

    return v0
.end method

.method public StopAudioStream()V
    .locals 1

    iget-boolean v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_UsePCMMixing:Z

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_PCMMediaPlayer:Landroid/media/AudioTrack;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_PCMMediaPlayer:Landroid/media/AudioTrack;

    invoke-virtual {v0}, Landroid/media/AudioTrack;->pause()V

    :cond_0
    return-void
.end method

.method public StopAutoRotation()V
    .locals 1

    iget-object v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_oel:Landroid/view/OrientationEventListener;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_oel:Landroid/view/OrientationEventListener;

    invoke-virtual {v0}, Landroid/view/OrientationEventListener;->disable()V

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_oel:Landroid/view/OrientationEventListener;

    :cond_0
    return-void
.end method

.method public StopVibration()Z
    .locals 1

    iget-object v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_Vibrator:Landroid/os/Vibrator;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_Vibrator:Landroid/os/Vibrator;

    invoke-virtual {v0}, Landroid/os/Vibrator;->cancel()V

    :cond_0
    const/4 v0, 0x1

    return v0
.end method

.method public SystemMessageBox(Ljava/lang/String;Ljava/lang/String;)V
    .locals 3

    new-instance v0, Lcom/glu/platform/android/GluPlatformActivity$SystemMessageBoxRunner;

    invoke-direct {v0, p0, p1, p2}, Lcom/glu/platform/android/GluPlatformActivity$SystemMessageBoxRunner;-><init>(Lcom/glu/platform/android/GluPlatformActivity;Ljava/lang/String;Ljava/lang/String;)V

    new-instance v1, Ljava/lang/Thread;

    const-string v2, "SystemMessageBoxThread"

    invoke-direct {v1, v0, v2}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;Ljava/lang/String;)V

    invoke-virtual {v1}, Ljava/lang/Thread;->start()V

    :try_start_0
    invoke-virtual {v1}, Ljava/lang/Thread;->join()V
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return-void

    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method final displaySystemMessageBox(Ljava/lang/String;Ljava/lang/String;Lcom/glu/platform/android/GluPlatformActivity$SystemMessageBoxRunner;)V
    .locals 6

    new-instance v0, Lcom/glu/platform/android/GluPlatformActivity$SystemMessageBoxMessage;

    move-object v1, p0

    move-object v2, p1

    move-object v3, p2

    move-object v4, p0

    move-object v5, p3

    invoke-direct/range {v0 .. v5}, Lcom/glu/platform/android/GluPlatformActivity$SystemMessageBoxMessage;-><init>(Lcom/glu/platform/android/GluPlatformActivity;Ljava/lang/String;Ljava/lang/String;Landroid/content/Context;Lcom/glu/platform/android/GluPlatformActivity$SystemMessageBoxRunner;)V

    iget-object v1, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_SMBHandler:Landroid/os/Handler;

    const/4 v2, 0x0

    invoke-virtual {v1, v2, v0}, Landroid/os/Handler;->obtainMessage(ILjava/lang/Object;)Landroid/os/Message;

    move-result-object v0

    iget-object v1, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_SMBHandler:Landroid/os/Handler;

    invoke-virtual {v1, v0}, Landroid/os/Handler;->sendMessage(Landroid/os/Message;)Z

    return-void
.end method

.method public getDisplayHeight()I
    .locals 1

    iget v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->displayHeight:I

    return v0
.end method

.method public getHandler()Landroid/os/Handler;
    .locals 1

    iget-object v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_Handler:Landroid/os/Handler;

    return-object v0
.end method

.method public iOnResDLDone()V
    .locals 22

    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    sput v1, Lcom/glu/platform/android/GluPlatformActivity;->m_OSVersion:I

    new-instance v1, Landroid/widget/FrameLayout;

    move-object/from16 v0, p0

    invoke-direct {v1, v0}, Landroid/widget/FrameLayout;-><init>(Landroid/content/Context;)V

    new-instance v2, Lcom/glu/platform/android/GluMainView;

    invoke-virtual/range {p0 .. p0}, Lcom/glu/platform/android/GluPlatformActivity;->getApplication()Landroid/app/Application;

    move-result-object v3

    move-object/from16 v0, p0

    invoke-direct {v2, v3, v0}, Lcom/glu/platform/android/GluMainView;-><init>(Landroid/content/Context;Lcom/glu/platform/android/GluPlatformActivity;)V

    move-object/from16 v0, p0

    iput-object v2, v0, Lcom/glu/platform/android/GluPlatformActivity;->m_MainView:Lcom/glu/platform/android/GluMainView;

    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/glu/platform/android/GluPlatformActivity;->m_MainView:Lcom/glu/platform/android/GluMainView;

    invoke-virtual {v1, v2}, Landroid/widget/FrameLayout;->addView(Landroid/view/View;)V

    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/glu/platform/android/GluPlatformActivity;->m_MainView:Lcom/glu/platform/android/GluMainView;

    invoke-virtual {v2}, Lcom/glu/platform/android/GluMainView;->getHolder()Landroid/view/SurfaceHolder;

    move-result-object v2

    const/4 v3, 0x2

    invoke-interface {v2, v3}, Landroid/view/SurfaceHolder;->setType(I)V

    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/glu/platform/android/GluPlatformActivity;->m_MainView:Lcom/glu/platform/android/GluMainView;

    invoke-virtual {v2}, Lcom/glu/platform/android/GluMainView;->getHolder()Landroid/view/SurfaceHolder;

    move-result-object v2

    move-object/from16 v0, p0

    invoke-interface {v2, v0}, Landroid/view/SurfaceHolder;->addCallback(Landroid/view/SurfaceHolder$Callback;)V

    move-object/from16 v0, p0

    invoke-virtual {v0, v1}, Lcom/glu/platform/android/GluPlatformActivity;->setContentView(Landroid/view/View;)V

    invoke-virtual/range {p0 .. p0}, Lcom/glu/platform/android/GluPlatformActivity;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v1

    const/4 v2, 0x0

    move-object/from16 v0, p0

    iput-boolean v2, v0, Lcom/glu/platform/android/GluPlatformActivity;->m_bMultiTouchEnabled:Z

    const-string v2, "android.hardware.touchscreen"

    invoke-virtual {v1, v2}, Landroid/content/pm/PackageManager;->hasSystemFeature(Ljava/lang/String;)Z

    move-result v2

    move-object/from16 v0, p0

    iput-boolean v2, v0, Lcom/glu/platform/android/GluPlatformActivity;->m_SupportsTouch:Z

    const-string v2, "android.hardware.touchscreen.multitouch"

    invoke-virtual {v1, v2}, Landroid/content/pm/PackageManager;->hasSystemFeature(Ljava/lang/String;)Z

    move-result v2

    move-object/from16 v0, p0

    iput-boolean v2, v0, Lcom/glu/platform/android/GluPlatformActivity;->m_SupportsMultiTouch:Z

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Touchscreen - touch: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    move-object/from16 v0, p0

    iget-boolean v3, v0, Lcom/glu/platform/android/GluPlatformActivity;->m_SupportsTouch:Z

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ", multitouch: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    move-object/from16 v0, p0

    iget-boolean v3, v0, Lcom/glu/platform/android/GluPlatformActivity;->m_SupportsMultiTouch:Z

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    const-string v2, "android.hardware.sensor.accelerometer"

    invoke-virtual {v1, v2}, Landroid/content/pm/PackageManager;->hasSystemFeature(Ljava/lang/String;)Z

    move-result v11

    const-string v2, "android.hardware.sensor.gyroscope"

    invoke-virtual {v1, v2}, Landroid/content/pm/PackageManager;->hasSystemFeature(Ljava/lang/String;)Z

    move-result v12

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Accelerometer: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v11}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ", Gyroscope: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v12}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    invoke-static {}, Ljava/util/Locale;->getDefault()Ljava/util/Locale;

    move-result-object v2

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "save"

    const/4 v5, 0x0

    move-object/from16 v0, p0

    invoke-virtual {v0, v4, v5}, Lcom/glu/platform/android/GluPlatformActivity;->getDir(Ljava/lang/String;I)Ljava/io/File;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v3

    sget-object v4, Ljava/io/File;->separator:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    move-object/from16 v0, p0

    iput-object v3, v0, Lcom/glu/platform/android/GluPlatformActivity;->m_InternalPath:Ljava/lang/String;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-static {}, Landroid/os/Environment;->getExternalStorageDirectory()Ljava/io/File;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v3

    sget-object v4, Ljava/io/File;->separator:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "Android"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    sget-object v4, Ljava/io/File;->separator:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "data"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    sget-object v4, Ljava/io/File;->separator:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual/range {p0 .. p0}, Lcom/glu/platform/android/GluPlatformActivity;->getPackageName()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    sget-object v4, Ljava/io/File;->separator:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "files"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    sget-object v4, Ljava/io/File;->separator:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    move-object/from16 v0, p0

    iput-object v3, v0, Lcom/glu/platform/android/GluPlatformActivity;->m_ExternalPath:Ljava/lang/String;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "internalPath: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/glu/platform/android/GluPlatformActivity;->m_InternalPath:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, ", externalPath: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/glu/platform/android/GluPlatformActivity;->m_ExternalPath:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    const-string v13, ""

    :try_start_0
    invoke-virtual/range {p0 .. p0}, Lcom/glu/platform/android/GluPlatformActivity;->getComponentName()Landroid/content/ComponentName;

    move-result-object v3

    invoke-virtual {v3}, Landroid/content/ComponentName;->getPackageName()Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x1

    invoke-virtual {v1, v3, v4}, Landroid/content/pm/PackageManager;->getPackageInfo(Ljava/lang/String;I)Landroid/content/pm/PackageInfo;

    move-result-object v1

    iget-object v13, v1, Landroid/content/pm/PackageInfo;->versionName:Ljava/lang/String;
    :try_end_0
    .catch Landroid/content/pm/PackageManager$NameNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "versionName: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    invoke-virtual/range {p0 .. p0}, Lcom/glu/platform/android/GluPlatformActivity;->getWindowManager()Landroid/view/WindowManager;

    move-result-object v1

    invoke-interface {v1}, Landroid/view/WindowManager;->getDefaultDisplay()Landroid/view/Display;

    move-result-object v1

    invoke-virtual {v1}, Landroid/view/Display;->getWidth()I

    move-result v19

    invoke-virtual {v1}, Landroid/view/Display;->getHeight()I

    move-result v20

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "getWindowManager Screen size - width: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    move/from16 v0, v19

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v3, ", height: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    move/from16 v0, v20

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    const/4 v1, 0x1

    invoke-static/range {v19 .. v20}, Ljava/lang/Math;->min(II)I

    move-result v3

    mul-int/lit8 v3, v3, 0xa

    div-int/lit16 v3, v3, 0x140

    invoke-static {v1, v3}, Ljava/lang/Math;->max(II)I

    move-result v1

    move-object/from16 v0, p0

    iput v1, v0, Lcom/glu/platform/android/GluPlatformActivity;->TOUCH_MOVE_THRESHOLD:I

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "TouchMoveThreshold: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    move-object/from16 v0, p0

    iget v3, v0, Lcom/glu/platform/android/GluPlatformActivity;->TOUCH_MOVE_THRESHOLD:I

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "AppId: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-static {}, Lcom/urbanairship/push/PushManager;->shared()Lcom/urbanairship/push/PushManager;

    move-result-object v3

    invoke-virtual {v3}, Lcom/urbanairship/push/PushManager;->getPreferences()Lcom/urbanairship/push/PushPreferences;

    move-result-object v3

    invoke-virtual {v3}, Lcom/urbanairship/push/PushPreferences;->getPushId()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-object/from16 v0, p0

    iget-object v1, v0, Lcom/glu/platform/android/GluPlatformActivity;->m_jni:Lcom/glu/platform/android/GluPlatformActivityJNI;

    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/glu/platform/android/GluPlatformActivity;->m_Handler:Landroid/os/Handler;

    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/glu/platform/android/GluPlatformActivity;->m_InternalPath:Ljava/lang/String;

    move-object/from16 v0, p0

    iget-object v5, v0, Lcom/glu/platform/android/GluPlatformActivity;->m_ExternalPath:Ljava/lang/String;

    sget-object v6, Ljava/io/File;->separator:Ljava/lang/String;

    invoke-virtual {v2}, Ljava/util/Locale;->getLanguage()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v2}, Ljava/util/Locale;->getCountry()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v2}, Ljava/util/Locale;->getDisplayLanguage()Ljava/lang/String;

    move-result-object v9

    move-object/from16 v0, p0

    iget-boolean v10, v0, Lcom/glu/platform/android/GluPlatformActivity;->m_SupportsMultiTouch:Z

    invoke-virtual/range {p0 .. p0}, Lcom/glu/platform/android/GluPlatformActivity;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v2

    const-string v14, "android_id"

    invoke-static {v2, v14}, Landroid/provider/Settings$Secure;->getString(Landroid/content/ContentResolver;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v14

    sget-object v15, Landroid/os/Build$VERSION;->RELEASE:Ljava/lang/String;

    sget v2, Landroid/os/Build$VERSION;->SDK_INT:I

    invoke-static {v2}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v16

    sget v17, Landroid/os/Build$VERSION;->SDK_INT:I

    invoke-virtual/range {p0 .. p0}, Lcom/glu/platform/android/GluPlatformActivity;->getRequestedOrientation()I

    move-result v18

    invoke-static {}, Lcom/urbanairship/push/PushManager;->shared()Lcom/urbanairship/push/PushManager;

    move-result-object v2

    invoke-virtual {v2}, Lcom/urbanairship/push/PushManager;->getPreferences()Lcom/urbanairship/push/PushPreferences;

    move-result-object v2

    invoke-virtual {v2}, Lcom/urbanairship/push/PushPreferences;->getPushId()Ljava/lang/String;

    move-result-object v21

    move-object/from16 v2, p0

    invoke-virtual/range {v1 .. v21}, Lcom/glu/platform/android/GluPlatformActivityJNI;->initialise(Landroid/content/Context;Landroid/os/Handler;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ZZZLjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;IIIILjava/lang/String;)V

    move-object/from16 v0, p0

    iget-object v1, v0, Lcom/glu/platform/android/GluPlatformActivity;->m_jni:Lcom/glu/platform/android/GluPlatformActivityJNI;

    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/glu/platform/android/GluPlatformActivity;->m_MainView:Lcom/glu/platform/android/GluMainView;

    invoke-virtual {v2}, Lcom/glu/platform/android/GluMainView;->getHolder()Landroid/view/SurfaceHolder;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/glu/platform/android/GluPlatformActivityJNI;->setWindow(Landroid/view/SurfaceHolder;)V

    const/4 v1, 0x0

    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/glu/platform/android/GluPlatformActivity;->savedInstanceState:Landroid/os/Bundle;

    if-eqz v2, :cond_0

    move-object/from16 v0, p0

    iget-object v1, v0, Lcom/glu/platform/android/GluPlatformActivity;->savedInstanceState:Landroid/os/Bundle;

    const-string v2, "GluSavedInstanceState"

    invoke-virtual {v1, v2}, Landroid/os/Bundle;->getByteArray(Ljava/lang/String;)[B

    move-result-object v1

    :cond_0
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/glu/platform/android/GluPlatformActivity;->m_jni:Lcom/glu/platform/android/GluPlatformActivityJNI;

    move-object/from16 v0, p0

    invoke-virtual {v2, v1, v0}, Lcom/glu/platform/android/GluPlatformActivityJNI;->onCreate([BLcom/glu/platform/android/GluCallback;)I

    move-result v1

    move-object/from16 v0, p0

    iput v1, v0, Lcom/glu/platform/android/GluPlatformActivity;->m_NativeHandle:I

    new-instance v1, Landroid/content/Intent;

    const-class v2, Lcom/glu/platform/android/GluNotificationService;

    move-object/from16 v0, p0

    invoke-direct {v1, v0, v2}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    move-object/from16 v0, p0

    iput-object v1, v0, Lcom/glu/platform/android/GluPlatformActivity;->m_NotificationIntent:Landroid/content/Intent;

    const-string v1, "doing onStart()"

    invoke-static {v1}, Lcom/glu/platform/android/resdl/Debug;->log(Ljava/lang/String;)V

    invoke-virtual/range {p0 .. p0}, Lcom/glu/platform/android/GluPlatformActivity;->onStart()V

    const-string v1, "doing onResume()"

    invoke-static {v1}, Lcom/glu/platform/android/resdl/Debug;->log(Ljava/lang/String;)V

    invoke-virtual/range {p0 .. p0}, Lcom/glu/platform/android/GluPlatformActivity;->onResume()V

    invoke-virtual/range {p0 .. p0}, Lcom/glu/platform/android/GluPlatformActivity;->resumeAfterGainedWindowFocus()V

    const-string v1, "done modified code..."

    invoke-static {v1}, Lcom/glu/platform/android/resdl/Debug;->log(Ljava/lang/String;)V

    return-void

    :catch_0
    move-exception v1

    invoke-virtual {v1}, Landroid/content/pm/PackageManager$NameNotFoundException;->printStackTrace()V

    goto/16 :goto_0
.end method

.method public javaToNativeFacebook(II[B)V
    .locals 1

    const/4 v0, 0x0

    invoke-virtual {p0, p1, p2, p3, v0}, Lcom/glu/platform/android/GluPlatformActivity;->javaToNativeFacebook(II[B[[C)V

    return-void
.end method

.method public javaToNativeFacebook(II[B[[C)V
    .locals 6

    iget-object v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_jni:Lcom/glu/platform/android/GluPlatformActivityJNI;

    iget v1, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_NativeHandle:I

    move v2, p1

    move v3, p2

    move-object v4, p3

    move-object v5, p4

    invoke-virtual/range {v0 .. v5}, Lcom/glu/platform/android/GluPlatformActivityJNI;->javaToNativeFacebook(III[B[[C)V

    return-void
.end method

.method public mp3Event(IILjava/lang/String;)I
    .locals 3

    const/4 v0, 0x1

    const/4 v1, 0x0

    if-ne p1, v0, :cond_2

    sget-object v2, Lcom/glu/platform/android/DeviceSound;->instance:Lcom/glu/platform/android/DeviceSound;

    if-nez p2, :cond_0

    move v0, v1

    :cond_0
    invoke-virtual {v2, p3, v0}, Lcom/glu/platform/android/DeviceSound;->playMP3(Ljava/lang/String;Z)V

    :cond_1
    :goto_0
    return v1

    :cond_2
    const/4 v0, 0x2

    if-ne p1, v0, :cond_3

    sget-object v0, Lcom/glu/platform/android/DeviceSound;->instance:Lcom/glu/platform/android/DeviceSound;

    invoke-virtual {v0}, Lcom/glu/platform/android/DeviceSound;->pauseMP3()V

    goto :goto_0

    :cond_3
    const/4 v0, 0x3

    if-ne p1, v0, :cond_4

    sget-object v0, Lcom/glu/platform/android/DeviceSound;->instance:Lcom/glu/platform/android/DeviceSound;

    invoke-virtual {v0}, Lcom/glu/platform/android/DeviceSound;->resumeMP3()V

    goto :goto_0

    :cond_4
    const/4 v0, 0x5

    if-ne p1, v0, :cond_5

    sget-object v0, Lcom/glu/platform/android/DeviceSound;->instance:Lcom/glu/platform/android/DeviceSound;

    invoke-virtual {v0}, Lcom/glu/platform/android/DeviceSound;->stopAndDestroyMP3()V

    goto :goto_0

    :cond_5
    const/16 v0, 0xf

    if-ne p1, v0, :cond_1

    sget-object v0, Lcom/glu/platform/android/DeviceSound;->instance:Lcom/glu/platform/android/DeviceSound;

    invoke-virtual {v0, p2}, Lcom/glu/platform/android/DeviceSound;->volumeSetMP3(I)V

    goto :goto_0
.end method

.method public onAccuracyChanged(Landroid/hardware/Sensor;I)V
    .locals 0

    return-void
.end method

.method public onConfigurationChanged(Landroid/content/res/Configuration;)V
    .locals 2

    invoke-super {p0, p1}, Landroid/app/Activity;->onConfigurationChanged(Landroid/content/res/Configuration;)V

    invoke-static {}, Lcom/glu/platform/android/resdl/ResDL;->isResDLDone()Z

    move-result v0

    if-nez v0, :cond_1

    :cond_0
    :goto_0
    return-void

    :cond_1
    iget v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_Orientation:I

    iget v1, p1, Landroid/content/res/Configuration;->orientation:I

    if-eq v0, v1, :cond_0

    iget-object v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_jni:Lcom/glu/platform/android/GluPlatformActivityJNI;

    iget v1, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_NativeHandle:I

    invoke-virtual {v0, v1}, Lcom/glu/platform/android/GluPlatformActivityJNI;->onOrientationChanged(I)V

    iget v0, p1, Landroid/content/res/Configuration;->orientation:I

    iput v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_Orientation:I

    goto :goto_0
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 3

    invoke-super {p0, p1}, Landroid/app/Activity;->onCreate(Landroid/os/Bundle;)V

    sput-object p0, Lcom/glu/platform/android/GluPlatformActivity;->instance:Lcom/glu/platform/android/GluPlatformActivity;

    iput-object p1, p0, Lcom/glu/platform/android/GluPlatformActivity;->savedInstanceState:Landroid/os/Bundle;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Build.BOARD: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-object v1, Landroid/os/Build;->BOARD:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Build.BRAND: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-object v1, Landroid/os/Build;->BRAND:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Build.CPU_ABI: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-object v1, Landroid/os/Build;->CPU_ABI:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Build.DEVICE: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-object v1, Landroid/os/Build;->DEVICE:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Build.DISPLAY: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-object v1, Landroid/os/Build;->DISPLAY:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Build.FINGERPRINT: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-object v1, Landroid/os/Build;->FINGERPRINT:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Build.HOST: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-object v1, Landroid/os/Build;->HOST:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Build.ID: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-object v1, Landroid/os/Build;->ID:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Build.MANUFACTURER: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-object v1, Landroid/os/Build;->MANUFACTURER:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Build.MODEL: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-object v1, Landroid/os/Build;->MODEL:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Build.PRODUCT: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-object v1, Landroid/os/Build;->PRODUCT:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Build.TAGS: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-object v1, Landroid/os/Build;->TAGS:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Build.TIME: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-wide v1, Landroid/os/Build;->TIME:J

    invoke-virtual {v0, v1, v2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Build.TYPE: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-object v1, Landroid/os/Build;->TYPE:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Build.USER: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-object v1, Landroid/os/Build;->USER:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Build.VERSION.CODENAME: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-object v1, Landroid/os/Build$VERSION;->CODENAME:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Build.VERSION.INCREMENTAL: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-object v1, Landroid/os/Build$VERSION;->INCREMENTAL:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Build.VERSION.RELEASE: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-object v1, Landroid/os/Build$VERSION;->RELEASE:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Build.VERSION.SDK: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-object v1, Landroid/os/Build$VERSION;->SDK:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Build.VERSION.SDK_INT: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Device ID: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {p0}, Lcom/glu/platform/android/GluPlatformActivity;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v1

    const-string v2, "android_id"

    invoke-static {v1, v2}, Landroid/provider/Settings$Secure;->getString(Landroid/content/ContentResolver;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    const-string v0, "activity"

    invoke-virtual {p0, v0}, Lcom/glu/platform/android/GluPlatformActivity;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/ActivityManager;

    invoke-virtual {v0}, Landroid/app/ActivityManager;->getDeviceConfigurationInfo()Landroid/content/pm/ConfigurationInfo;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "GL Version: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v0}, Landroid/content/pm/ConfigurationInfo;->getGlEsVersion()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v0, v0, Landroid/content/pm/ConfigurationInfo;->reqGlEsVersion:I

    invoke-static {v0}, Ljava/lang/Integer;->toHexString(I)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    sput-object p0, Lcom/glu/platform/android/GluPlatformActivity;->instance:Lcom/glu/platform/android/GluPlatformActivity;

    iput-object p1, p0, Lcom/glu/platform/android/GluPlatformActivity;->savedInstanceState:Landroid/os/Bundle;

    const-class v0, Lcom/glu/platform/android/GluPlatformActivity;

    invoke-static {p0, v0}, Lcom/glu/platform/android/resdl/ResDL;->init$35ff8c7e(Landroid/app/Activity;Ljava/lang/Class;)V

    const-string v0, "com.glu.platform.android.GluPlatformActivity"

    const-string v1, "onResDLDone"

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Class;

    invoke-static {v0, v1, v2}, Lcom/glu/platform/android/resdl/GluUtil;->getMethod(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v0

    invoke-static {v0}, Lcom/glu/platform/android/resdl/ResDL;->loadResDownloadView(Ljava/lang/reflect/Method;)V

    new-instance v0, Lcom/glu/platform/android/facebook/GluFBConnect;

    invoke-direct {v0}, Lcom/glu/platform/android/facebook/GluFBConnect;-><init>()V

    new-instance v0, Lcom/glu/platform/android/DeviceSound;

    invoke-direct {v0}, Lcom/glu/platform/android/DeviceSound;-><init>()V

    return-void
.end method

.method protected onDestroy()V
    .locals 3

    const/4 v2, 0x0

    invoke-static {}, Lcom/glu/platform/android/resdl/ResDL;->isResDLDone()Z

    move-result v0

    invoke-static {}, Lcom/glu/platform/android/resdl/ResDL;->onActivityDestroy()V

    if-nez v0, :cond_0

    invoke-super {p0}, Landroid/app/Activity;->onDestroy()V

    :goto_0
    return-void

    :cond_0
    sget-object v0, Lcom/glu/platform/android/DeviceSound;->instance:Lcom/glu/platform/android/DeviceSound;

    invoke-virtual {v0}, Lcom/glu/platform/android/DeviceSound;->stop()V

    sput-object v2, Lcom/glu/platform/android/DeviceSound;->instance:Lcom/glu/platform/android/DeviceSound;

    iget-object v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_jni:Lcom/glu/platform/android/GluPlatformActivityJNI;

    iget v1, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_NativeHandle:I

    invoke-virtual {v0, v1}, Lcom/glu/platform/android/GluPlatformActivityJNI;->onDestroy(I)V

    iget-object v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_MainView:Lcom/glu/platform/android/GluMainView;

    invoke-virtual {v0}, Lcom/glu/platform/android/GluMainView;->onDestroy()V

    iget-object v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_jni:Lcom/glu/platform/android/GluPlatformActivityJNI;

    iget v1, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_NativeHandle:I

    invoke-virtual {v0, v1}, Lcom/glu/platform/android/GluPlatformActivityJNI;->tidy(I)V

    iget-object v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_jni:Lcom/glu/platform/android/GluPlatformActivityJNI;

    invoke-virtual {v0}, Lcom/glu/platform/android/GluPlatformActivityJNI;->uninitialise()V

    iget-object v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_MainView:Lcom/glu/platform/android/GluMainView;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_MainView:Lcom/glu/platform/android/GluMainView;

    invoke-virtual {v0}, Lcom/glu/platform/android/GluMainView;->getHolder()Landroid/view/SurfaceHolder;

    move-result-object v0

    invoke-interface {v0, p0}, Landroid/view/SurfaceHolder;->removeCallback(Landroid/view/SurfaceHolder$Callback;)V

    iput-object v2, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_MainView:Lcom/glu/platform/android/GluMainView;

    :cond_1
    invoke-super {p0}, Landroid/app/Activity;->onDestroy()V

    invoke-static {}, Landroid/os/Process;->myPid()I

    move-result v0

    invoke-static {v0}, Landroid/os/Process;->killProcess(I)V

    goto :goto_0
.end method

.method public onDrawFrame(JZ)V
    .locals 4

    iget-object v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_jni:Lcom/glu/platform/android/GluPlatformActivityJNI;

    iget v1, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_NativeHandle:I

    long-to-int v2, p1

    int-to-long v2, v2

    invoke-virtual {v0, v1, v2, v3, p3}, Lcom/glu/platform/android/GluPlatformActivityJNI;->onDrawFrame(IJZ)V

    return-void
.end method

.method public onKeyDown(ILandroid/view/KeyEvent;)Z
    .locals 5

    const/4 v4, 0x3

    const/4 v3, 0x1

    invoke-static {}, Lcom/glu/platform/android/resdl/ResDL;->isResDLDone()Z

    move-result v0

    if-nez v0, :cond_1

    :cond_0
    :goto_0
    return v3

    :cond_1
    invoke-static {p1}, Lcom/glu/platform/android/GluPlatformActivity;->isVolumeKey(I)Z

    move-result v0

    if-eqz v0, :cond_3

    const-string v0, "audio"

    invoke-virtual {p0, v0}, Lcom/glu/platform/android/GluPlatformActivity;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/media/AudioManager;

    invoke-virtual {v0, v4}, Landroid/media/AudioManager;->getStreamVolume(I)I

    move-result v2

    packed-switch p1, :pswitch_data_0

    :cond_2
    move v1, v2

    :goto_1
    if-eq v1, v2, :cond_0

    invoke-virtual {v0, v4, v1, v3}, Landroid/media/AudioManager;->setStreamVolume(III)V

    goto :goto_0

    :pswitch_0
    if-lez v2, :cond_2

    add-int/lit8 v1, v2, -0x1

    goto :goto_1

    :pswitch_1
    invoke-virtual {v0, v4}, Landroid/media/AudioManager;->getStreamMaxVolume(I)I

    move-result v1

    if-ge v2, v1, :cond_2

    add-int/lit8 v1, v2, 0x1

    goto :goto_1

    :cond_3
    iget-object v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_jni:Lcom/glu/platform/android/GluPlatformActivityJNI;

    iget v1, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_NativeHandle:I

    invoke-direct {p0, p1, p2}, Lcom/glu/platform/android/GluPlatformActivity;->translateKeyCode(ILandroid/view/KeyEvent;)I

    move-result v2

    invoke-virtual {v0, v1, v2}, Lcom/glu/platform/android/GluPlatformActivityJNI;->onKeyDown(II)Z

    goto :goto_0

    nop

    :pswitch_data_0
    .packed-switch 0x18
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method public onKeyMultiple(IILandroid/view/KeyEvent;)Z
    .locals 5

    const/4 v0, 0x1

    const/4 v1, 0x0

    invoke-static {}, Lcom/glu/platform/android/resdl/ResDL;->isResDLDone()Z

    move-result v2

    if-nez v2, :cond_1

    :cond_0
    :goto_0
    return v0

    :cond_1
    if-eqz p1, :cond_2

    invoke-direct {p0, p1, p3}, Lcom/glu/platform/android/GluPlatformActivity;->translateKeyCode(ILandroid/view/KeyEvent;)I

    move-result v2

    :goto_1
    if-ge v1, p2, :cond_0

    iget-object v3, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_jni:Lcom/glu/platform/android/GluPlatformActivityJNI;

    iget v4, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_NativeHandle:I

    invoke-virtual {v3, v4, v2}, Lcom/glu/platform/android/GluPlatformActivityJNI;->onKeyDown(II)Z

    iget-object v3, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_jni:Lcom/glu/platform/android/GluPlatformActivityJNI;

    iget v4, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_NativeHandle:I

    invoke-virtual {v3, v4, v2}, Lcom/glu/platform/android/GluPlatformActivityJNI;->onKeyUp(II)Z

    add-int/lit8 v1, v1, 0x1

    goto :goto_1

    :cond_2
    move v0, v1

    goto :goto_0
.end method

.method public onKeyUp(ILandroid/view/KeyEvent;)Z
    .locals 4

    const/4 v3, 0x1

    invoke-static {}, Lcom/glu/platform/android/resdl/ResDL;->isResDLDone()Z

    move-result v0

    if-nez v0, :cond_1

    :cond_0
    :goto_0
    return v3

    :cond_1
    invoke-static {p1}, Lcom/glu/platform/android/GluPlatformActivity;->isVolumeKey(I)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_jni:Lcom/glu/platform/android/GluPlatformActivityJNI;

    iget v1, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_NativeHandle:I

    invoke-direct {p0, p1, p2}, Lcom/glu/platform/android/GluPlatformActivity;->translateKeyCode(ILandroid/view/KeyEvent;)I

    move-result v2

    invoke-virtual {v0, v1, v2}, Lcom/glu/platform/android/GluPlatformActivityJNI;->onKeyUp(II)Z

    goto :goto_0
.end method

.method public onLowMemory()V
    .locals 2

    invoke-super {p0}, Landroid/app/Activity;->onLowMemory()V

    invoke-static {}, Lcom/glu/platform/android/resdl/ResDL;->isResDLDone()Z

    move-result v0

    if-nez v0, :cond_0

    :goto_0
    return-void

    :cond_0
    iget-object v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_jni:Lcom/glu/platform/android/GluPlatformActivityJNI;

    iget v1, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_NativeHandle:I

    invoke-virtual {v0, v1}, Lcom/glu/platform/android/GluPlatformActivityJNI;->onLowMemory(I)V

    goto :goto_0
.end method

.method public declared-synchronized onMarkerReached(Landroid/media/AudioTrack;)V
    .locals 5

    monitor-enter p0

    :try_start_0
    iget-object v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_PCMMediaPlayer:Landroid/media/AudioTrack;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-nez v0, :cond_0

    :goto_0
    monitor-exit p0

    return-void

    :cond_0
    :try_start_1
    iget v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_PCMBufferOffset:I

    iget v1, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_PCMBufferSizeInBytes:I

    if-ge v0, v1, :cond_2

    iget-object v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_PCMMediaPlayer:Landroid/media/AudioTrack;

    iget-object v1, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_PCMBuffer:[B

    iget v2, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_PCMBufferOffset:I

    iget v3, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_PCMBufferSizeInBytes:I

    iget v4, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_PCMBufferOffset:I

    sub-int/2addr v3, v4

    invoke-virtual {v0, v1, v2, v3}, Landroid/media/AudioTrack;->write([BII)I

    move-result v0

    iget v1, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_PCMBufferOffset:I

    add-int/2addr v0, v1

    iput v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_PCMBufferOffset:I

    iget v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_PCMBufferOffset:I

    iget v1, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_PCMBufferSizeInBytes:I

    if-lt v0, v1, :cond_1

    iget-object v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_jni:Lcom/glu/platform/android/GluPlatformActivityJNI;

    iget v1, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_NativeHandle:I

    iget-object v2, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_PCMBuffer:[B

    iget v3, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_PCMBufferSizeInBytes:I

    invoke-virtual {v0, v1, v2, v3}, Lcom/glu/platform/android/GluPlatformActivityJNI;->feedPCMMediaPlayer(I[BI)V

    iget-object v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_PCMMediaPlayer:Landroid/media/AudioTrack;

    iget-object v1, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_PCMBuffer:[B

    const/4 v2, 0x0

    iget v3, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_PCMBufferSizeInBytes:I

    invoke-virtual {v0, v1, v2, v3}, Landroid/media/AudioTrack;->write([BII)I

    move-result v0

    iput v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_PCMBufferOffset:I

    :cond_1
    :goto_1
    iget-object v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_PCMMediaPlayer:Landroid/media/AudioTrack;

    iget v1, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_PCMBufferSizeInFrames:I

    mul-int/lit8 v1, v1, 0x3

    div-int/lit8 v1, v1, 0x4

    invoke-virtual {v0, v1}, Landroid/media/AudioTrack;->setNotificationMarkerPosition(I)I
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0

    :cond_2
    :try_start_2
    iget-object v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_jni:Lcom/glu/platform/android/GluPlatformActivityJNI;

    iget v1, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_NativeHandle:I

    iget-object v2, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_PCMBuffer:[B

    iget v3, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_PCMBufferSizeInBytes:I

    invoke-virtual {v0, v1, v2, v3}, Lcom/glu/platform/android/GluPlatformActivityJNI;->feedPCMMediaPlayer(I[BI)V

    iget-object v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_PCMMediaPlayer:Landroid/media/AudioTrack;

    iget-object v1, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_PCMBuffer:[B

    const/4 v2, 0x0

    iget v3, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_PCMBufferSizeInBytes:I

    invoke-virtual {v0, v1, v2, v3}, Landroid/media/AudioTrack;->write([BII)I

    move-result v0

    iput v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_PCMBufferOffset:I
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    goto :goto_1
.end method

.method protected onPause()V
    .locals 3

    const/4 v2, 0x0

    sget-object v0, Lcom/glu/platform/android/DeviceSound;->instance:Lcom/glu/platform/android/DeviceSound;

    invoke-virtual {v0}, Lcom/glu/platform/android/DeviceSound;->pauseMP3()V

    invoke-super {p0}, Landroid/app/Activity;->onPause()V

    invoke-static {}, Lcom/glu/platform/android/resdl/ResDL;->onActivityPause()V

    invoke-static {}, Lcom/glu/platform/android/resdl/ResDL;->isResDLDone()Z

    move-result v0

    if-nez v0, :cond_1

    :cond_0
    :goto_0
    return-void

    :cond_1
    const/4 v0, 0x2

    invoke-direct {p0, v0}, Lcom/glu/platform/android/GluPlatformActivity;->setState(I)V

    iget-boolean v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_bNotificationReceiverRegistered:Z

    if-eqz v0, :cond_2

    iget-object v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_NotificationReceiver:Landroid/content/BroadcastReceiver;

    invoke-virtual {p0, v0}, Lcom/glu/platform/android/GluPlatformActivity;->unregisterReceiver(Landroid/content/BroadcastReceiver;)V

    iput-boolean v2, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_bNotificationReceiverRegistered:Z

    :cond_2
    iget-object v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_jni:Lcom/glu/platform/android/GluPlatformActivityJNI;

    iget v1, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_NativeHandle:I

    invoke-virtual {v0, v1}, Lcom/glu/platform/android/GluPlatformActivityJNI;->onPause(I)V

    iget-object v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_MainView:Lcom/glu/platform/android/GluMainView;

    invoke-virtual {v0}, Lcom/glu/platform/android/GluMainView;->onPause()V

    iget-boolean v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_ListeningToAccelerometer:Z

    if-eqz v0, :cond_4

    const-string v0, "sensor"

    invoke-virtual {p0, v0}, Lcom/glu/platform/android/GluPlatformActivity;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/hardware/SensorManager;

    if-eqz v0, :cond_3

    invoke-virtual {v0, p0}, Landroid/hardware/SensorManager;->unregisterListener(Landroid/hardware/SensorEventListener;)V

    :cond_3
    iput-boolean v2, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_ListeningToAccelerometer:Z

    :cond_4
    iget-object v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_WakeLock:Landroid/os/PowerManager$WakeLock;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_WakeLock:Landroid/os/PowerManager$WakeLock;

    invoke-virtual {v0}, Landroid/os/PowerManager$WakeLock;->release()V

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_WakeLock:Landroid/os/PowerManager$WakeLock;

    goto :goto_0
.end method

.method public onPeriodicNotification(Landroid/media/AudioTrack;)V
    .locals 4

    iget-object v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_jni:Lcom/glu/platform/android/GluPlatformActivityJNI;

    iget v1, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_NativeHandle:I

    iget-object v2, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_PCMBuffer:[B

    iget v3, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_PCMBufferSizeInBytes:I

    invoke-virtual {v0, v1, v2, v3}, Lcom/glu/platform/android/GluPlatformActivityJNI;->feedPCMMediaPlayer(I[BI)V

    iget-object v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_PCMMediaPlayer:Landroid/media/AudioTrack;

    iget-object v1, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_PCMBuffer:[B

    const/4 v2, 0x0

    iget v3, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_PCMBufferSizeInBytes:I

    invoke-virtual {v0, v1, v2, v3}, Landroid/media/AudioTrack;->write([BII)I

    return-void
.end method

.method protected onRestart()V
    .locals 2

    invoke-super {p0}, Landroid/app/Activity;->onRestart()V

    invoke-static {}, Lcom/glu/platform/android/resdl/ResDL;->isResDLDone()Z

    move-result v0

    if-nez v0, :cond_0

    :goto_0
    return-void

    :cond_0
    iget-object v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_jni:Lcom/glu/platform/android/GluPlatformActivityJNI;

    iget v1, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_NativeHandle:I

    invoke-virtual {v0, v1}, Lcom/glu/platform/android/GluPlatformActivityJNI;->onRestart(I)V

    goto :goto_0
.end method

.method protected onResume()V
    .locals 6

    const/16 v5, 0xa

    const/4 v4, 0x1

    const/4 v1, 0x0

    invoke-super {p0}, Landroid/app/Activity;->onResume()V

    invoke-virtual {p0, v1}, Lcom/glu/platform/android/GluPlatformActivity;->setUseBeam(Z)V

    invoke-static {}, Lcom/glu/platform/android/resdl/ResDL;->onActivityResume()V

    invoke-static {}, Lcom/glu/platform/android/resdl/ResDL;->isResDLDone()Z

    move-result v0

    if-nez v0, :cond_1

    :cond_0
    :goto_0
    return-void

    :cond_1
    iput v1, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_cTouches:I

    new-array v0, v5, [Lcom/glu/platform/android/GluPlatformActivity$TouchTracker;

    iput-object v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_aTouches:[Lcom/glu/platform/android/GluPlatformActivity$TouchTracker;

    move v0, v1

    :goto_1
    if-ge v0, v5, :cond_2

    new-instance v2, Lcom/glu/platform/android/GluPlatformActivity$TouchTracker;

    invoke-direct {v2, p0}, Lcom/glu/platform/android/GluPlatformActivity$TouchTracker;-><init>(Lcom/glu/platform/android/GluPlatformActivity;)V

    const/4 v3, -0x1

    iput v3, v2, Lcom/glu/platform/android/GluPlatformActivity$TouchTracker;->m_PointerId:I

    iput v1, v2, Lcom/glu/platform/android/GluPlatformActivity$TouchTracker;->m_Mode:I

    iput v0, v2, Lcom/glu/platform/android/GluPlatformActivity$TouchTracker;->m_Index:I

    iget-object v3, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_aTouches:[Lcom/glu/platform/android/GluPlatformActivity$TouchTracker;

    aput-object v2, v3, v0

    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    :cond_2
    iget-object v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_MainView:Lcom/glu/platform/android/GluMainView;

    if-eqz v0, :cond_3

    iget-object v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_MainView:Lcom/glu/platform/android/GluMainView;

    invoke-virtual {v0}, Lcom/glu/platform/android/GluMainView;->onResume()V

    :cond_3
    sget-boolean v0, Lcom/glu/platform/android/GluPlatformActivity;->$assertionsDisabled:Z

    if-nez v0, :cond_4

    iget-object v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_WakeLock:Landroid/os/PowerManager$WakeLock;

    if-eqz v0, :cond_4

    new-instance v0, Ljava/lang/AssertionError;

    invoke-direct {v0}, Ljava/lang/AssertionError;-><init>()V

    throw v0

    :cond_4
    const-string v0, "power"

    invoke-virtual {p0, v0}, Lcom/glu/platform/android/GluPlatformActivity;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/os/PowerManager;

    if-eqz v0, :cond_5

    const v1, 0x2000000a

    const-string v2, "AndroidPlatform"

    invoke-virtual {v0, v1, v2}, Landroid/os/PowerManager;->newWakeLock(ILjava/lang/String;)Landroid/os/PowerManager$WakeLock;

    move-result-object v0

    iput-object v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_WakeLock:Landroid/os/PowerManager$WakeLock;

    iget-object v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_WakeLock:Landroid/os/PowerManager$WakeLock;

    if-eqz v0, :cond_5

    iget-object v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_WakeLock:Landroid/os/PowerManager$WakeLock;

    invoke-virtual {v0}, Landroid/os/PowerManager$WakeLock;->acquire()V

    :cond_5
    const-string v0, "sensor"

    invoke-virtual {p0, v0}, Lcom/glu/platform/android/GluPlatformActivity;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/hardware/SensorManager;

    if-eqz v0, :cond_0

    invoke-virtual {v0, v4}, Landroid/hardware/SensorManager;->getDefaultSensor(I)Landroid/hardware/Sensor;

    move-result-object v1

    invoke-virtual {v0, p0, v1, v4}, Landroid/hardware/SensorManager;->registerListener(Landroid/hardware/SensorEventListener;Landroid/hardware/Sensor;I)Z

    move-result v0

    if-eqz v0, :cond_0

    iput-boolean v4, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_ListeningToAccelerometer:Z

    goto :goto_0
.end method

.method public onSensorChanged(Landroid/hardware/SensorEvent;)V
    .locals 6

    const v1, 0x411ce80a

    invoke-static {}, Lcom/glu/platform/android/resdl/ResDL;->isResDLDone()Z

    move-result v0

    if-nez v0, :cond_0

    :goto_0
    return-void

    :cond_0
    iget-object v0, p1, Landroid/hardware/SensorEvent;->sensor:Landroid/hardware/Sensor;

    invoke-virtual {v0}, Landroid/hardware/Sensor;->getType()I

    move-result v0

    packed-switch v0, :pswitch_data_0

    goto :goto_0

    :pswitch_0
    iget-object v0, p1, Landroid/hardware/SensorEvent;->sensor:Landroid/hardware/Sensor;

    invoke-virtual {v0}, Landroid/hardware/Sensor;->getMaximumRange()F

    move-result v0

    float-to-double v2, v0

    const-wide/16 v4, 0x0

    cmpg-double v2, v2, v4

    if-gtz v2, :cond_1

    move v0, v1

    :cond_1
    iget-object v2, p1, Landroid/hardware/SensorEvent;->values:[F

    const/4 v3, 0x0

    aget v2, v2, v3

    neg-float v2, v2

    div-float/2addr v2, v0

    iget-object v3, p1, Landroid/hardware/SensorEvent;->values:[F

    const/4 v4, 0x1

    aget v3, v3, v4

    div-float v1, v3, v1

    iget-object v3, p1, Landroid/hardware/SensorEvent;->values:[F

    const/4 v4, 0x2

    aget v3, v3, v4

    neg-float v3, v3

    div-float v0, v3, v0

    iget-object v3, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_jni:Lcom/glu/platform/android/GluPlatformActivityJNI;

    iget v4, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_NativeHandle:I

    invoke-virtual {v3, v4, v2, v1, v0}, Lcom/glu/platform/android/GluPlatformActivityJNI;->pushAccelerometerValues(IFFF)V

    goto :goto_0

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_0
    .end packed-switch
.end method

.method protected onStart()V
    .locals 2

    invoke-super {p0}, Landroid/app/Activity;->onStart()V

    invoke-static {}, Lcom/glu/platform/android/resdl/ResDL;->isResDLDone()Z

    move-result v0

    if-nez v0, :cond_0

    :goto_0
    return-void

    :cond_0
    iget-object v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_jni:Lcom/glu/platform/android/GluPlatformActivityJNI;

    iget v1, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_NativeHandle:I

    invoke-virtual {v0, v1}, Lcom/glu/platform/android/GluPlatformActivityJNI;->onStart(I)V

    goto :goto_0
.end method

.method protected onStop()V
    .locals 2

    invoke-super {p0}, Landroid/app/Activity;->onStop()V

    invoke-static {}, Lcom/glu/platform/android/resdl/ResDL;->isResDLDone()Z

    move-result v0

    if-nez v0, :cond_0

    :goto_0
    return-void

    :cond_0
    iget-object v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_jni:Lcom/glu/platform/android/GluPlatformActivityJNI;

    iget v1, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_NativeHandle:I

    invoke-virtual {v0, v1}, Lcom/glu/platform/android/GluPlatformActivityJNI;->onStop(I)V

    iget-object v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_MainView:Lcom/glu/platform/android/GluMainView;

    invoke-virtual {v0}, Lcom/glu/platform/android/GluMainView;->onStop()V

    goto :goto_0
.end method

.method public onSurfaceChanged(II)V
    .locals 2

    iget-object v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_jni:Lcom/glu/platform/android/GluPlatformActivityJNI;

    iget v1, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_NativeHandle:I

    invoke-virtual {v0, v1, p1, p2}, Lcom/glu/platform/android/GluPlatformActivityJNI;->onSurfaceChanged(III)V

    return-void
.end method

.method public onSurfaceCreated()V
    .locals 2

    iget-object v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_jni:Lcom/glu/platform/android/GluPlatformActivityJNI;

    iget v1, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_NativeHandle:I

    invoke-virtual {v0, v1}, Lcom/glu/platform/android/GluPlatformActivityJNI;->onSurfaceCreated(I)V

    return-void
.end method

.method public onTouchEvent(Landroid/view/MotionEvent;)Z
    .locals 9

    const v6, 0xff00

    const/4 v2, 0x0

    const/4 v1, 0x1

    invoke-static {}, Lcom/glu/platform/android/GluPlatformActivity;->initializeTouch()V

    invoke-static {}, Lcom/glu/platform/android/resdl/ResDL;->isResDLDone()Z

    move-result v0

    if-nez v0, :cond_1

    :cond_0
    :goto_0
    return v1

    :cond_1
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getAction()I

    move-result v3

    and-int/lit16 v4, v3, 0xff

    iput-boolean v2, p0, Lcom/glu/platform/android/GluPlatformActivity;->touchPad:Z

    invoke-virtual {p0}, Lcom/glu/platform/android/GluPlatformActivity;->IsPSP()Z

    move-result v0

    if-eqz v0, :cond_2

    :try_start_0
    sget-object v0, Lcom/glu/platform/android/GluPlatformActivity;->GETSOURCE:Ljava/lang/reflect/Method;

    const/4 v5, 0x0

    invoke-virtual {v0, p1, v5}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Integer;

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    const v5, 0x100008

    if-ne v0, v5, :cond_3

    move v0, v1

    :goto_1
    iput-boolean v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->touchPad:Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :cond_2
    :goto_2
    iget-boolean v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_bMultiTouchEnabled:Z

    if-eqz v0, :cond_6

    packed-switch v4, :pswitch_data_0

    :pswitch_0
    move v0, v2

    :goto_3
    move v1, v0

    goto :goto_0

    :cond_3
    move v0, v2

    goto :goto_1

    :pswitch_1
    and-int v0, v3, v6

    shr-int/lit8 v0, v0, 0x8

    invoke-virtual {p1, v0}, Landroid/view/MotionEvent;->getPointerId(I)I

    move-result v2

    invoke-virtual {p1, v0}, Landroid/view/MotionEvent;->getX(I)F

    move-result v3

    float-to-int v3, v3

    invoke-virtual {p1, v0}, Landroid/view/MotionEvent;->getY(I)F

    move-result v0

    float-to-int v0, v0

    invoke-direct {p0, v3, v0, v2}, Lcom/glu/platform/android/GluPlatformActivity;->touchBegan(III)V

    goto :goto_0

    :pswitch_2
    and-int v0, v3, v6

    shr-int/lit8 v0, v0, 0x8

    invoke-virtual {p1, v0}, Landroid/view/MotionEvent;->getPointerId(I)I

    move-result v2

    invoke-virtual {p1, v0}, Landroid/view/MotionEvent;->getX(I)F

    move-result v3

    float-to-int v3, v3

    invoke-virtual {p1, v0}, Landroid/view/MotionEvent;->getY(I)F

    move-result v0

    float-to-int v0, v0

    invoke-direct {p0, v3, v0, v2}, Lcom/glu/platform/android/GluPlatformActivity;->touchEnded(III)V

    goto :goto_0

    :pswitch_3
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getHistorySize()I

    move-result v4

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getPointerCount()I

    move-result v5

    move v3, v2

    :goto_4
    if-ge v3, v4, :cond_5

    move v0, v2

    :goto_5
    if-ge v0, v5, :cond_4

    invoke-virtual {p1, v0, v3}, Landroid/view/MotionEvent;->getHistoricalX(II)F

    move-result v6

    float-to-int v6, v6

    invoke-virtual {p1, v0, v3}, Landroid/view/MotionEvent;->getHistoricalY(II)F

    move-result v7

    float-to-int v7, v7

    invoke-virtual {p1, v0}, Landroid/view/MotionEvent;->getPointerId(I)I

    move-result v8

    invoke-direct {p0, v6, v7, v8}, Lcom/glu/platform/android/GluPlatformActivity;->touchMoved(III)V

    add-int/lit8 v0, v0, 0x1

    goto :goto_5

    :cond_4
    add-int/lit8 v0, v3, 0x1

    move v3, v0

    goto :goto_4

    :cond_5
    :goto_6
    if-ge v2, v5, :cond_0

    invoke-virtual {p1, v2}, Landroid/view/MotionEvent;->getX(I)F

    move-result v0

    float-to-int v0, v0

    invoke-virtual {p1, v2}, Landroid/view/MotionEvent;->getY(I)F

    move-result v3

    float-to-int v3, v3

    invoke-virtual {p1, v2}, Landroid/view/MotionEvent;->getPointerId(I)I

    move-result v4

    invoke-direct {p0, v0, v3, v4}, Lcom/glu/platform/android/GluPlatformActivity;->touchMoved(III)V

    add-int/lit8 v2, v2, 0x1

    goto :goto_6

    :pswitch_4
    and-int v0, v3, v6

    shr-int/lit8 v0, v0, 0x8

    invoke-virtual {p1, v0}, Landroid/view/MotionEvent;->getPointerId(I)I

    move-result v2

    invoke-virtual {p1, v0}, Landroid/view/MotionEvent;->getX(I)F

    move-result v3

    float-to-int v3, v3

    invoke-virtual {p1, v0}, Landroid/view/MotionEvent;->getY(I)F

    move-result v0

    float-to-int v0, v0

    invoke-direct {p0, v3, v0, v2}, Lcom/glu/platform/android/GluPlatformActivity;->touchCancelled(III)V

    goto/16 :goto_0

    :pswitch_5
    and-int v0, v3, v6

    shr-int/lit8 v0, v0, 0x8

    invoke-virtual {p1, v0}, Landroid/view/MotionEvent;->getPointerId(I)I

    move-result v2

    invoke-virtual {p1, v0}, Landroid/view/MotionEvent;->getX(I)F

    move-result v3

    float-to-int v3, v3

    invoke-virtual {p1, v0}, Landroid/view/MotionEvent;->getY(I)F

    move-result v0

    float-to-int v0, v0

    invoke-direct {p0, v3, v0, v2}, Lcom/glu/platform/android/GluPlatformActivity;->touchBegan(III)V

    goto/16 :goto_0

    :pswitch_6
    and-int v0, v3, v6

    shr-int/lit8 v0, v0, 0x8

    invoke-virtual {p1, v0}, Landroid/view/MotionEvent;->getPointerId(I)I

    move-result v2

    invoke-virtual {p1, v0}, Landroid/view/MotionEvent;->getX(I)F

    move-result v3

    float-to-int v3, v3

    invoke-virtual {p1, v0}, Landroid/view/MotionEvent;->getY(I)F

    move-result v0

    float-to-int v0, v0

    invoke-direct {p0, v3, v0, v2}, Lcom/glu/platform/android/GluPlatformActivity;->touchEnded(III)V

    move v0, v1

    goto/16 :goto_3

    :cond_6
    iget-boolean v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_SupportsTouch:Z

    if-eqz v0, :cond_7

    and-int v0, v3, v6

    shr-int/lit8 v0, v0, 0x8

    invoke-virtual {p1, v0}, Landroid/view/MotionEvent;->getPointerId(I)I

    move-result v0

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getX()F

    move-result v3

    float-to-int v3, v3

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getY()F

    move-result v5

    float-to-int v5, v5

    packed-switch v4, :pswitch_data_1

    :cond_7
    :pswitch_7
    move v1, v2

    goto/16 :goto_0

    :pswitch_8
    invoke-direct {p0, v3, v5, v0}, Lcom/glu/platform/android/GluPlatformActivity;->touchBegan(III)V

    goto/16 :goto_0

    :pswitch_9
    invoke-direct {p0, v3, v5, v0}, Lcom/glu/platform/android/GluPlatformActivity;->touchEnded(III)V

    goto/16 :goto_0

    :pswitch_a
    invoke-direct {p0, v3, v5, v0}, Lcom/glu/platform/android/GluPlatformActivity;->touchMoved(III)V

    goto/16 :goto_0

    :pswitch_b
    invoke-direct {p0, v3, v5, v0}, Lcom/glu/platform/android/GluPlatformActivity;->touchCancelled(III)V

    goto/16 :goto_0

    :pswitch_c
    sget-boolean v0, Lcom/glu/platform/android/GluPlatformActivity;->$assertionsDisabled:Z

    if-nez v0, :cond_7

    new-instance v0, Ljava/lang/AssertionError;

    invoke-direct {v0}, Ljava/lang/AssertionError;-><init>()V

    throw v0

    :catch_0
    move-exception v0

    goto/16 :goto_2

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_1
        :pswitch_2
        :pswitch_3
        :pswitch_4
        :pswitch_0
        :pswitch_5
        :pswitch_6
    .end packed-switch

    :pswitch_data_1
    .packed-switch 0x0
        :pswitch_8
        :pswitch_9
        :pswitch_a
        :pswitch_b
        :pswitch_7
        :pswitch_c
        :pswitch_c
    .end packed-switch
.end method

.method public onTrackballEvent(Landroid/view/MotionEvent;)Z
    .locals 1

    invoke-static {}, Lcom/glu/platform/android/resdl/ResDL;->isResDLDone()Z

    move-result v0

    if-nez v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method final resumeAfterGainedWindowFocus()V
    .locals 4

    const/4 v3, 0x1

    sget-object v0, Lcom/glu/platform/android/DeviceSound;->instance:Lcom/glu/platform/android/DeviceSound;

    invoke-virtual {v0}, Lcom/glu/platform/android/DeviceSound;->resumeMP3()V

    iget-object v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_jni:Lcom/glu/platform/android/GluPlatformActivityJNI;

    iget v1, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_NativeHandle:I

    invoke-virtual {v0, v1}, Lcom/glu/platform/android/GluPlatformActivityJNI;->onResume(I)V

    iget-object v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_NotificationReceiver:Landroid/content/BroadcastReceiver;

    new-instance v1, Landroid/content/IntentFilter;

    const-string v2, "com.glu.platform.android.NOTIFICATION_FIRED"

    invoke-direct {v1, v2}, Landroid/content/IntentFilter;-><init>(Ljava/lang/String;)V

    invoke-virtual {p0, v0, v1}, Lcom/glu/platform/android/GluPlatformActivity;->registerReceiver(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;)Landroid/content/Intent;

    iput-boolean v3, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_bNotificationReceiverRegistered:Z

    invoke-direct {p0, v3}, Lcom/glu/platform/android/GluPlatformActivity;->setState(I)V

    invoke-virtual {p0}, Lcom/glu/platform/android/GluPlatformActivity;->HandlePushNotifications()V

    return-void
.end method

.method public setUseBeam(Z)V
    .locals 2

    iget v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_NativeHandle:I

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_jni:Lcom/glu/platform/android/GluPlatformActivityJNI;

    iget v1, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_NativeHandle:I

    invoke-virtual {v0, v1, p1}, Lcom/glu/platform/android/GluPlatformActivityJNI;->setUseBeam(IZ)V

    :cond_0
    return-void
.end method

.method public surfaceChanged(Landroid/view/SurfaceHolder;III)V
    .locals 2

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "width: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " height: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    iget-object v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_jni:Lcom/glu/platform/android/GluPlatformActivityJNI;

    iget v1, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_NativeHandle:I

    invoke-virtual {v0, v1, p2, p3, p4}, Lcom/glu/platform/android/GluPlatformActivityJNI;->surfaceChanged(IIII)V

    return-void
.end method

.method public surfaceCreated(Landroid/view/SurfaceHolder;)V
    .locals 2

    iget-object v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_jni:Lcom/glu/platform/android/GluPlatformActivityJNI;

    iget v1, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_NativeHandle:I

    invoke-virtual {v0, v1}, Lcom/glu/platform/android/GluPlatformActivityJNI;->surfaceCreated(I)V

    return-void
.end method

.method public surfaceDestroyed(Landroid/view/SurfaceHolder;)V
    .locals 2

    sget-object v0, Lcom/glu/platform/android/DeviceSound;->instance:Lcom/glu/platform/android/DeviceSound;

    invoke-virtual {v0}, Lcom/glu/platform/android/DeviceSound;->pauseMP3()V

    iget-object v0, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_jni:Lcom/glu/platform/android/GluPlatformActivityJNI;

    iget v1, p0, Lcom/glu/platform/android/GluPlatformActivity;->m_NativeHandle:I

    invoke-virtual {v0, v1}, Lcom/glu/platform/android/GluPlatformActivityJNI;->surfaceDestroyed(I)V

    return-void
.end method
