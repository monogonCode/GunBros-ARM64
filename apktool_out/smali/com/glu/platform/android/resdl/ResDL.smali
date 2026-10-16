.class public final Lcom/glu/platform/android/resdl/ResDL;
.super Ljava/lang/Object;


# static fields
.field private static m_WakeLock:Landroid/os/PowerManager$WakeLock;

.field public static m_viewManipulationHandler:Landroid/os/Handler;

.field public static sm_actualHeight:I

.field public static sm_actualWidth:I

.field private static sm_context:Landroid/app/Activity;

.field private static sm_contextClass:Ljava/lang/Class;

.field public static sm_dummyView:Lcom/glu/platform/android/resdl/DummyGLView;

.field private static sm_onCompletionCallback:Ljava/lang/reflect/Method;

.field private static sm_resDLState:I

.field public static sm_resDLView:Lcom/glu/platform/android/resdl/ResDownloadViewGroup;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    const/4 v0, 0x1

    const/4 v1, 0x0

    sput-object v1, Lcom/glu/platform/android/resdl/ResDL;->sm_context:Landroid/app/Activity;

    sput-object v1, Lcom/glu/platform/android/resdl/ResDL;->sm_contextClass:Ljava/lang/Class;

    sput v0, Lcom/glu/platform/android/resdl/ResDL;->sm_actualWidth:I

    sput v0, Lcom/glu/platform/android/resdl/ResDL;->sm_actualHeight:I

    sput-object v1, Lcom/glu/platform/android/resdl/ResDL;->sm_onCompletionCallback:Ljava/lang/reflect/Method;

    const/4 v0, 0x0

    sput v0, Lcom/glu/platform/android/resdl/ResDL;->sm_resDLState:I

    sput-object v1, Lcom/glu/platform/android/resdl/ResDL;->sm_dummyView:Lcom/glu/platform/android/resdl/DummyGLView;

    sput-object v1, Lcom/glu/platform/android/resdl/ResDL;->sm_resDLView:Lcom/glu/platform/android/resdl/ResDownloadViewGroup;

    sput-object v1, Lcom/glu/platform/android/resdl/ResDL;->m_viewManipulationHandler:Landroid/os/Handler;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static getContext()Landroid/app/Activity;
    .locals 1

    sget-object v0, Lcom/glu/platform/android/resdl/ResDL;->sm_context:Landroid/app/Activity;

    return-object v0
.end method

.method public static getResourceFilePath()Ljava/lang/String;
    .locals 3

    sget v0, Lcom/glu/platform/android/resdl/ResDL;->sm_resDLState:I

    const/4 v1, 0x3

    if-eq v0, v1, :cond_0

    const-string v0, "Must get res path only after ResDL done."

    invoke-static {v0}, Lcom/glu/platform/android/resdl/ResDL;->onAssertionFailed(Ljava/lang/String;)V

    :cond_0
    invoke-static {}, Lcom/glu/platform/android/resdl/GluUtil;->findResourceFile()Ljava/io/File;

    move-result-object v0

    invoke-virtual {v0}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x0

    const/16 v2, 0x2f

    invoke-virtual {v0, v2}, Ljava/lang/String;->lastIndexOf(I)I

    move-result v2

    invoke-virtual {v0, v1, v2}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/glu/platform/android/resdl/GluUtil;->filePathWithEnder(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static init$35ff8c7e(Landroid/app/Activity;Ljava/lang/Class;)V
    .locals 1

    const-string v0, "ResDL.init()"

    invoke-static {v0}, Lcom/glu/platform/android/resdl/Debug;->log(Ljava/lang/String;)V

    sget v0, Lcom/glu/platform/android/resdl/ResDL;->sm_resDLState:I

    if-eqz v0, :cond_0

    const-string v0, "Called init while not in STATE_NONE. Did you remember to call onActivityDestroy()?"

    invoke-static {v0}, Lcom/glu/platform/android/resdl/ResDL;->onAssertionFailed(Ljava/lang/String;)V

    :cond_0
    sput-object p0, Lcom/glu/platform/android/resdl/ResDL;->sm_context:Landroid/app/Activity;

    sput-object p1, Lcom/glu/platform/android/resdl/ResDL;->sm_contextClass:Ljava/lang/Class;

    const/4 v0, 0x0

    sput-boolean v0, Lcom/glu/platform/android/resdl/Debug;->DEBUG:Z

    const/4 v0, 0x1

    sput v0, Lcom/glu/platform/android/resdl/ResDL;->sm_resDLState:I

    new-instance v0, Lcom/glu/platform/android/resdl/ResDL$1;

    invoke-direct {v0}, Lcom/glu/platform/android/resdl/ResDL$1;-><init>()V

    sput-object v0, Lcom/glu/platform/android/resdl/ResDL;->m_viewManipulationHandler:Landroid/os/Handler;

    invoke-static {}, Lcom/glu/platform/android/resdl/GameLet;->populate()V

    return-void
.end method

.method public static isResDLDone()Z
    .locals 2

    sget v0, Lcom/glu/platform/android/resdl/ResDL;->sm_resDLState:I

    const/4 v1, 0x3

    if-ne v0, v1, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public static loadResDownloadView(Ljava/lang/reflect/Method;)V
    .locals 2

    const-string v0, "ResDL.loadResDownloadView()"

    invoke-static {v0}, Lcom/glu/platform/android/resdl/Debug;->log(Ljava/lang/String;)V

    sget v0, Lcom/glu/platform/android/resdl/ResDL;->sm_resDLState:I

    const/4 v1, 0x1

    if-eq v0, v1, :cond_0

    const-string v0, "Cannot load res download view without initting first."

    invoke-static {v0}, Lcom/glu/platform/android/resdl/ResDL;->onAssertionFailed(Ljava/lang/String;)V

    :cond_0
    sput-object p0, Lcom/glu/platform/android/resdl/ResDL;->sm_onCompletionCallback:Ljava/lang/reflect/Method;

    const/4 v0, 0x2

    sput v0, Lcom/glu/platform/android/resdl/ResDL;->sm_resDLState:I

    sget-object v0, Lcom/glu/platform/android/resdl/ResDL;->sm_context:Landroid/app/Activity;

    new-instance v1, Lcom/glu/platform/android/resdl/DummyGLView;

    invoke-direct {v1}, Lcom/glu/platform/android/resdl/DummyGLView;-><init>()V

    sput-object v1, Lcom/glu/platform/android/resdl/ResDL;->sm_dummyView:Lcom/glu/platform/android/resdl/DummyGLView;

    invoke-virtual {v0, v1}, Landroid/app/Activity;->setContentView(Landroid/view/View;)V

    return-void
.end method

.method public static onActivityDestroy()V
    .locals 2

    const/4 v1, 0x0

    const-string v0, "ResDL.onActivityDestroy()"

    invoke-static {v0}, Lcom/glu/platform/android/resdl/Debug;->log(Ljava/lang/String;)V

    const/4 v0, 0x1

    sput-boolean v0, Lcom/glu/platform/android/resdl/GameLet$instance;->m_appPaused:Z

    sput-object v1, Lcom/glu/platform/android/resdl/ResDL;->sm_dummyView:Lcom/glu/platform/android/resdl/DummyGLView;

    sput-object v1, Lcom/glu/platform/android/resdl/ResDL;->sm_resDLView:Lcom/glu/platform/android/resdl/ResDownloadViewGroup;

    sput-object v1, Lcom/glu/platform/android/resdl/ResDL;->sm_context:Landroid/app/Activity;

    sput-object v1, Lcom/glu/platform/android/resdl/ResFileDownloadView;->instance:Lcom/glu/platform/android/resdl/ResFileDownloadView;

    sput-object v1, Lcom/glu/platform/android/resdl/ResDownloadViewGroup;->instance:Lcom/glu/platform/android/resdl/ResDownloadViewGroup;

    sput-object v1, Lcom/glu/platform/android/resdl/ResDL;->sm_onCompletionCallback:Ljava/lang/reflect/Method;

    const/4 v0, 0x0

    sput v0, Lcom/glu/platform/android/resdl/ResDL;->sm_resDLState:I

    return-void
.end method

.method public static onActivityPause()V
    .locals 1

    const-string v0, "ResDL.onActivityPause()"

    invoke-static {v0}, Lcom/glu/platform/android/resdl/Debug;->log(Ljava/lang/String;)V

    sget-object v0, Lcom/glu/platform/android/resdl/ResDL;->m_WakeLock:Landroid/os/PowerManager$WakeLock;

    if-eqz v0, :cond_0

    sget-object v0, Lcom/glu/platform/android/resdl/ResDL;->m_WakeLock:Landroid/os/PowerManager$WakeLock;

    invoke-virtual {v0}, Landroid/os/PowerManager$WakeLock;->release()V

    const/4 v0, 0x0

    sput-object v0, Lcom/glu/platform/android/resdl/ResDL;->m_WakeLock:Landroid/os/PowerManager$WakeLock;

    :cond_0
    const/4 v0, 0x1

    sput-boolean v0, Lcom/glu/platform/android/resdl/GameLet$instance;->m_appPaused:Z

    return-void
.end method

.method public static onActivityResume()V
    .locals 3

    const-string v0, "ResDL.onActivityResume()"

    invoke-static {v0}, Lcom/glu/platform/android/resdl/Debug;->log(Ljava/lang/String;)V

    sget-object v0, Lcom/glu/platform/android/GluPlatformActivity;->instance:Lcom/glu/platform/android/GluPlatformActivity;

    const-string v1, "power"

    invoke-virtual {v0, v1}, Lcom/glu/platform/android/GluPlatformActivity;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/os/PowerManager;

    if-eqz v0, :cond_0

    const v1, 0x2000000a

    const-string v2, "Resdl"

    invoke-virtual {v0, v1, v2}, Landroid/os/PowerManager;->newWakeLock(ILjava/lang/String;)Landroid/os/PowerManager$WakeLock;

    move-result-object v0

    sput-object v0, Lcom/glu/platform/android/resdl/ResDL;->m_WakeLock:Landroid/os/PowerManager$WakeLock;

    if-eqz v0, :cond_0

    sget-object v0, Lcom/glu/platform/android/resdl/ResDL;->m_WakeLock:Landroid/os/PowerManager$WakeLock;

    invoke-virtual {v0}, Landroid/os/PowerManager$WakeLock;->acquire()V

    :cond_0
    const/4 v0, 0x0

    sput-boolean v0, Lcom/glu/platform/android/resdl/GameLet$instance;->m_appPaused:Z

    return-void
.end method

.method private static onAssertionFailed(Ljava/lang/String;)V
    .locals 1

    new-instance v0, Ljava/lang/RuntimeException;

    invoke-direct {v0, p0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method static onReadyToLaunchGame()V
    .locals 3

    const/4 v1, 0x0

    const-string v0, "ready to launch game..."

    invoke-static {v0}, Lcom/glu/platform/android/resdl/Debug;->log(Ljava/lang/String;)V

    sput-object v1, Lcom/glu/platform/android/resdl/ResDL;->sm_resDLView:Lcom/glu/platform/android/resdl/ResDownloadViewGroup;

    const/4 v0, 0x3

    sput v0, Lcom/glu/platform/android/resdl/ResDL;->sm_resDLState:I

    :try_start_0
    sget-object v0, Lcom/glu/platform/android/resdl/ResDL;->sm_onCompletionCallback:Ljava/lang/reflect/Method;

    const/4 v1, 0x0

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    invoke-virtual {v0, v1, v2}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception v0

    const-string v1, "Dead."

    invoke-static {v1, v0}, Lcom/glu/platform/android/resdl/Debug;->log(Ljava/lang/String;Ljava/lang/Throwable;)V

    new-instance v0, Ljava/lang/RuntimeException;

    const-string v1, "Bad callback. (did you exclude it from obfuscation?)"

    invoke-direct {v0, v1}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method static onReadyToSwitchToResView()V
    .locals 2

    const/4 v0, 0x0

    sput-object v0, Lcom/glu/platform/android/resdl/ResDL;->sm_dummyView:Lcom/glu/platform/android/resdl/DummyGLView;

    invoke-static {}, Lcom/glu/platform/android/resdl/GameLet$instance;->setBuildVariant()V

    new-instance v0, Lcom/glu/platform/android/resdl/GluDownloadResMgr;

    invoke-direct {v0}, Lcom/glu/platform/android/resdl/GluDownloadResMgr;-><init>()V

    new-instance v0, Lcom/glu/platform/android/resdl/ResDownloadViewGroup;

    sget-object v1, Lcom/glu/platform/android/resdl/ResDL;->sm_context:Landroid/app/Activity;

    invoke-direct {v0, v1}, Lcom/glu/platform/android/resdl/ResDownloadViewGroup;-><init>(Landroid/content/Context;)V

    sput-object v0, Lcom/glu/platform/android/resdl/ResDL;->sm_resDLView:Lcom/glu/platform/android/resdl/ResDownloadViewGroup;

    invoke-virtual {v0}, Lcom/glu/platform/android/resdl/ResDownloadViewGroup;->init()V

    sget-object v0, Lcom/glu/platform/android/resdl/ResDL;->sm_context:Landroid/app/Activity;

    sget-object v1, Lcom/glu/platform/android/resdl/ResDL;->sm_resDLView:Lcom/glu/platform/android/resdl/ResDownloadViewGroup;

    invoke-virtual {v0, v1}, Landroid/app/Activity;->setContentView(Landroid/view/View;)V

    sget-object v0, Lcom/glu/platform/android/resdl/ResDL;->sm_resDLView:Lcom/glu/platform/android/resdl/ResDownloadViewGroup;

    invoke-virtual {v0}, Lcom/glu/platform/android/resdl/ResDownloadViewGroup;->requestFocus()Z

    return-void
.end method
