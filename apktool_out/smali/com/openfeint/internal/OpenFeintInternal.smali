.class public final Lcom/openfeint/internal/OpenFeintInternal;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/openfeint/internal/OpenFeintInternal$IUploadDelegate;,
        Lcom/openfeint/internal/OpenFeintInternal$LoginDelegate;
    }
.end annotation


# static fields
.field private static createUserSource:Ljava/lang/String;

.field private static sInstance:Lcom/openfeint/internal/OpenFeintInternal;

.field private static userEnableSource:Ljava/lang/String;


# instance fields
.field mAppVersion:I

.field private mApproved:Z

.field private mBanned:Z

.field mClient:Lcom/openfeint/internal/request/Client;

.field private mContext:Landroid/content/Context;

.field private mCreatingDeviceSession:Z

.field private mCurrentUser:Lcom/openfeint/api/resource/CurrentUser;

.field private mCurrentlyLoggingIn:Z

.field private mDeclined:Z

.field mDelegate:Lcom/openfeint/api/OpenFeintDelegate;

.field private mDeserializedAlready:Z

.field private mDeviceSessionCreated:Z

.field private mGSDI:Ljava/lang/String;

.field mInternalProperties:Ljava/util/Properties;

.field private mLoginDelegate:Lcom/openfeint/internal/OpenFeintInternal$LoginDelegate;

.field mMainThreadHandler:Landroid/os/Handler;

.field private mParentalControlsEnabled:Z

.field private mPostDeviceSessionRunnable:Ljava/lang/Runnable;

.field private mPostLoginRunnable:Ljava/lang/Runnable;

.field private mPrefs:Lcom/openfeint/internal/SyncedStore;

.field private mQueuedPostDeviceSessionRunnables:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Ljava/lang/Runnable;",
            ">;"
        }
    .end annotation
.end field

.field private mQueuedPostLoginRunnables:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Ljava/lang/Runnable;",
            ">;"
        }
    .end annotation
.end field

.field mServerUrl:Ljava/lang/String;

.field private mSessionID:Ljava/lang/String;

.field private mSessionStartDate:Ljava/util/Date;

.field mSettings:Lcom/openfeint/api/OpenFeintSettings;

.field private mUDID:Ljava/lang/String;


# direct methods
.method private constructor <init>(Lcom/openfeint/api/OpenFeintSettings;Landroid/content/Context;)V
    .locals 4

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, -0x1

    iput v0, p0, Lcom/openfeint/internal/OpenFeintInternal;->mAppVersion:I

    sput-object p0, Lcom/openfeint/internal/OpenFeintInternal;->sInstance:Lcom/openfeint/internal/OpenFeintInternal;

    iput-object p2, p0, Lcom/openfeint/internal/OpenFeintInternal;->mContext:Landroid/content/Context;

    iput-object p1, p0, Lcom/openfeint/internal/OpenFeintInternal;->mSettings:Lcom/openfeint/api/OpenFeintSettings;

    new-instance v0, Ljava/util/Date;

    invoke-direct {v0}, Ljava/util/Date;-><init>()V

    iput-object v0, p0, Lcom/openfeint/internal/OpenFeintInternal;->mSessionStartDate:Ljava/util/Date;

    invoke-static {}, Ljava/util/UUID;->randomUUID()Ljava/util/UUID;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/UUID;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/openfeint/internal/OpenFeintInternal;->mSessionID:Ljava/lang/String;

    invoke-direct {p0}, Lcom/openfeint/internal/OpenFeintInternal;->getPrefs()Lcom/openfeint/internal/SyncedStore;

    move-result-object v0

    invoke-virtual {v0}, Lcom/openfeint/internal/SyncedStore;->read()Lcom/openfeint/internal/SyncedStore$Reader;

    move-result-object v1

    :try_start_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v2, p0, Lcom/openfeint/internal/OpenFeintInternal;->mContext:Landroid/content/Context;

    invoke-virtual {v2}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v2, ".of_declined"

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const/4 v2, 0x0

    invoke-virtual {v1, v0, v2}, Lcom/openfeint/internal/SyncedStore$Reader;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_1

    const/4 v0, 0x1

    :goto_0
    iput-boolean v0, p0, Lcom/openfeint/internal/OpenFeintInternal;->mDeclined:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    invoke-virtual {v1}, Lcom/openfeint/internal/SyncedStore$Reader;->complete()V

    new-instance v0, Landroid/os/Handler;

    invoke-direct {v0}, Landroid/os/Handler;-><init>()V

    iput-object v0, p0, Lcom/openfeint/internal/OpenFeintInternal;->mMainThreadHandler:Landroid/os/Handler;

    new-instance v0, Ljava/util/Properties;

    invoke-direct {v0}, Ljava/util/Properties;-><init>()V

    iput-object v0, p0, Lcom/openfeint/internal/OpenFeintInternal;->mInternalProperties:Ljava/util/Properties;

    iget-object v0, p0, Lcom/openfeint/internal/OpenFeintInternal;->mInternalProperties:Ljava/util/Properties;

    const-string v1, "server-url"

    const-string v2, "https://api.openfeint.com"

    invoke-virtual {v0, v1, v2}, Ljava/util/Properties;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Lcom/openfeint/internal/OpenFeintInternal;->mInternalProperties:Ljava/util/Properties;

    const-string v1, "ad-server-url"

    const-string v2, "http://ads.openfeint.com"

    invoke-virtual {v0, v1, v2}, Ljava/util/Properties;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Lcom/openfeint/internal/OpenFeintInternal;->mInternalProperties:Ljava/util/Properties;

    const-string v1, "of-version"

    const-string v2, "1.10.2"

    invoke-virtual {v0, v1, v2}, Ljava/util/Properties;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Lcom/openfeint/internal/OpenFeintInternal;->mInternalProperties:Ljava/util/Properties;

    const-string v1, "@xml/openfeint_internal_settings"

    invoke-virtual {p0, v1}, Lcom/openfeint/internal/OpenFeintInternal;->getResource(Ljava/lang/String;)I

    move-result v1

    invoke-direct {p0, v0, v1}, Lcom/openfeint/internal/OpenFeintInternal;->loadPropertiesFromXMLResource(Ljava/util/Properties;I)V

    const-string v0, "OpenFeintInternal"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Using OpenFeint version "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/openfeint/internal/OpenFeintInternal;->mInternalProperties:Ljava/util/Properties;

    const-string v3, "of-version"

    invoke-virtual {v2, v3}, Ljava/util/Properties;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " ("

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/openfeint/internal/OpenFeintInternal;->mInternalProperties:Ljava/util/Properties;

    const-string v3, "server-url"

    invoke-virtual {v2, v3}, Ljava/util/Properties;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ")"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    new-instance v0, Ljava/util/Properties;

    invoke-direct {v0}, Ljava/util/Properties;-><init>()V

    const-string v1, "@xml/openfeint_app_settings"

    invoke-virtual {p0, v1}, Lcom/openfeint/internal/OpenFeintInternal;->getResource(Ljava/lang/String;)I

    move-result v1

    invoke-direct {p0, v0, v1}, Lcom/openfeint/internal/OpenFeintInternal;->loadPropertiesFromXMLResource(Ljava/util/Properties;I)V

    iget-object v1, p0, Lcom/openfeint/internal/OpenFeintInternal;->mSettings:Lcom/openfeint/api/OpenFeintSettings;

    invoke-virtual {v1, v0}, Lcom/openfeint/api/OpenFeintSettings;->applyOverrides(Ljava/util/Properties;)V

    iget-object v0, p0, Lcom/openfeint/internal/OpenFeintInternal;->mSettings:Lcom/openfeint/api/OpenFeintSettings;

    invoke-virtual {v0}, Lcom/openfeint/api/OpenFeintSettings;->verify()V

    invoke-static {}, Lcom/openfeint/internal/Encryption;->initialized()Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/openfeint/internal/OpenFeintInternal;->mSettings:Lcom/openfeint/api/OpenFeintSettings;

    iget-object v0, v0, Lcom/openfeint/api/OpenFeintSettings;->secret:Ljava/lang/String;

    invoke-static {v0}, Lcom/openfeint/internal/Encryption;->init(Ljava/lang/String;)Z

    :cond_0
    new-instance v0, Lcom/openfeint/internal/request/Client;

    iget-object v1, p0, Lcom/openfeint/internal/OpenFeintInternal;->mSettings:Lcom/openfeint/api/OpenFeintSettings;

    iget-object v1, v1, Lcom/openfeint/api/OpenFeintSettings;->key:Ljava/lang/String;

    iget-object v2, p0, Lcom/openfeint/internal/OpenFeintInternal;->mSettings:Lcom/openfeint/api/OpenFeintSettings;

    iget-object v2, v2, Lcom/openfeint/api/OpenFeintSettings;->secret:Ljava/lang/String;

    invoke-direct {p0}, Lcom/openfeint/internal/OpenFeintInternal;->getPrefs()Lcom/openfeint/internal/SyncedStore;

    move-result-object v3

    invoke-direct {v0, v1, v2, v3}, Lcom/openfeint/internal/request/Client;-><init>(Ljava/lang/String;Ljava/lang/String;Lcom/openfeint/internal/SyncedStore;)V

    iput-object v0, p0, Lcom/openfeint/internal/OpenFeintInternal;->mClient:Lcom/openfeint/internal/request/Client;

    invoke-static {p2}, Lcom/openfeint/internal/Util;->moveWebCache(Landroid/content/Context;)V

    invoke-static {p2}, Lcom/openfeint/internal/ui/WebViewCache;->initialize(Landroid/content/Context;)Lcom/openfeint/internal/ui/WebViewCache;

    invoke-static {p2}, Lcom/openfeint/internal/db/DB;->createDB(Landroid/content/Context;)V

    invoke-static {}, Lcom/openfeint/internal/ui/WebViewCache;->start()V

    const-string v0, "OpenFeintInternal"

    const-string v1, "init EventDispacherSystem"

    invoke-static {v0, v1}, Lcom/openfeint/internal/logcat/OFLog;->w(Ljava/lang/String;Ljava/lang/String;)V

    new-instance v0, Lcom/openfeint/internal/eventlog/SDKEventListener;

    invoke-direct {v0}, Lcom/openfeint/internal/eventlog/SDKEventListener;-><init>()V

    invoke-static {}, Lcom/openfeint/internal/eventlog/EventLogDispatcher;->getInstance()Lcom/openfeint/internal/eventlog/EventLogDispatcher;

    move-result-object v1

    const-string v2, "prompt_enable_of.openfeint.com"

    invoke-virtual {v1, v2, v0}, Lcom/openfeint/internal/eventlog/EventLogDispatcher;->subscribe(Ljava/lang/String;Lcom/openfeint/internal/eventlog/IEventListener;)Z

    invoke-static {}, Lcom/openfeint/internal/eventlog/EventLogDispatcher;->getInstance()Lcom/openfeint/internal/eventlog/EventLogDispatcher;

    move-result-object v1

    const-string v2, "accepted_of.openfeint.com"

    invoke-virtual {v1, v2, v0}, Lcom/openfeint/internal/eventlog/EventLogDispatcher;->subscribe(Ljava/lang/String;Lcom/openfeint/internal/eventlog/IEventListener;)Z

    invoke-static {}, Lcom/openfeint/internal/eventlog/EventLogDispatcher;->getInstance()Lcom/openfeint/internal/eventlog/EventLogDispatcher;

    move-result-object v1

    const-string v2, "declined_of.openfeint.com"

    invoke-virtual {v1, v2, v0}, Lcom/openfeint/internal/eventlog/EventLogDispatcher;->subscribe(Ljava/lang/String;Lcom/openfeint/internal/eventlog/IEventListener;)Z

    invoke-static {}, Lcom/openfeint/internal/eventlog/EventLogDispatcher;->getInstance()Lcom/openfeint/internal/eventlog/EventLogDispatcher;

    move-result-object v1

    const-string v2, "enabled_of.openfeint.com"

    invoke-virtual {v1, v2, v0}, Lcom/openfeint/internal/eventlog/EventLogDispatcher;->subscribe(Ljava/lang/String;Lcom/openfeint/internal/eventlog/IEventListener;)Z

    invoke-static {}, Lcom/openfeint/internal/eventlog/EventLogDispatcher;->getInstance()Lcom/openfeint/internal/eventlog/EventLogDispatcher;

    move-result-object v1

    const-string v2, "new_user.openfeint.com"

    invoke-virtual {v1, v2, v0}, Lcom/openfeint/internal/eventlog/EventLogDispatcher;->subscribe(Ljava/lang/String;Lcom/openfeint/internal/eventlog/IEventListener;)Z

    invoke-static {}, Lcom/openfeint/internal/eventlog/EventLogDispatcher;->getInstance()Lcom/openfeint/internal/eventlog/EventLogDispatcher;

    move-result-object v1

    const-string v2, "dashboard_start.openfeint.com"

    invoke-virtual {v1, v2, v0}, Lcom/openfeint/internal/eventlog/EventLogDispatcher;->subscribe(Ljava/lang/String;Lcom/openfeint/internal/eventlog/IEventListener;)Z

    invoke-static {}, Lcom/openfeint/internal/eventlog/EventLogDispatcher;->getInstance()Lcom/openfeint/internal/eventlog/EventLogDispatcher;

    move-result-object v1

    const-string v2, "dashboard_end.openfeint.com"

    invoke-virtual {v1, v2, v0}, Lcom/openfeint/internal/eventlog/EventLogDispatcher;->subscribe(Ljava/lang/String;Lcom/openfeint/internal/eventlog/IEventListener;)Z

    invoke-static {}, Lcom/openfeint/internal/eventlog/EventLogDispatcher;->getInstance()Lcom/openfeint/internal/eventlog/EventLogDispatcher;

    move-result-object v1

    const-string v2, "game_start.openfeint.com"

    invoke-virtual {v1, v2, v0}, Lcom/openfeint/internal/eventlog/EventLogDispatcher;->subscribe(Ljava/lang/String;Lcom/openfeint/internal/eventlog/IEventListener;)Z

    invoke-static {}, Lcom/openfeint/internal/eventlog/EventLogDispatcher;->getInstance()Lcom/openfeint/internal/eventlog/EventLogDispatcher;

    move-result-object v1

    const-string v2, "game_background.openfeint.com"

    invoke-virtual {v1, v2, v0}, Lcom/openfeint/internal/eventlog/EventLogDispatcher;->subscribe(Ljava/lang/String;Lcom/openfeint/internal/eventlog/IEventListener;)Z

    invoke-static {}, Lcom/openfeint/internal/eventlog/EventLogDispatcher;->getInstance()Lcom/openfeint/internal/eventlog/EventLogDispatcher;

    move-result-object v1

    const-string v2, "game_foreground.openfeint.com"

    invoke-virtual {v1, v2, v0}, Lcom/openfeint/internal/eventlog/EventLogDispatcher;->subscribe(Ljava/lang/String;Lcom/openfeint/internal/eventlog/IEventListener;)Z

    invoke-static {}, Lcom/openfeint/internal/eventlog/EventLogDispatcher;->getInstance()Lcom/openfeint/internal/eventlog/EventLogDispatcher;

    move-result-object v1

    const-string v2, "game_exit.openfeint.com"

    invoke-virtual {v1, v2, v0}, Lcom/openfeint/internal/eventlog/EventLogDispatcher;->subscribe(Ljava/lang/String;Lcom/openfeint/internal/eventlog/IEventListener;)Z

    iget-object v0, p0, Lcom/openfeint/internal/OpenFeintInternal;->mContext:Landroid/content/Context;

    invoke-static {v0}, Lcom/openfeint/internal/analytics/AnalyticsManager;->instance(Landroid/content/Context;)Lcom/openfeint/internal/analytics/AnalyticsManager;

    return-void

    :cond_1
    const/4 v0, 0x0

    goto/16 :goto_0

    :catchall_0
    move-exception v0

    invoke-virtual {v1}, Lcom/openfeint/internal/SyncedStore$Reader;->complete()V

    throw v0
.end method

.method private final _makeRequest(Lcom/openfeint/internal/request/BaseRequest;)V
    .locals 2

    invoke-virtual {p0}, Lcom/openfeint/internal/OpenFeintInternal;->isUserLoggedIn()Z

    move-result v0

    if-nez v0, :cond_1

    invoke-virtual {p1}, Lcom/openfeint/internal/request/BaseRequest;->wantsLogin()Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-direct {p0}, Lcom/openfeint/internal/OpenFeintInternal;->lastLoggedInUser()Lcom/openfeint/api/resource/User;

    move-result-object v0

    if-eqz v0, :cond_1

    invoke-virtual {p0}, Lcom/openfeint/internal/OpenFeintInternal;->isFeintServerReachable()Z

    move-result v0

    if-eqz v0, :cond_1

    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Lcom/openfeint/internal/OpenFeintInternal;->login(Z)V

    iget-object v0, p0, Lcom/openfeint/internal/OpenFeintInternal;->mQueuedPostLoginRunnables:Ljava/util/List;

    if-nez v0, :cond_0

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/openfeint/internal/OpenFeintInternal;->mQueuedPostLoginRunnables:Ljava/util/List;

    :cond_0
    iget-object v0, p0, Lcom/openfeint/internal/OpenFeintInternal;->mQueuedPostLoginRunnables:Ljava/util/List;

    new-instance v1, Lcom/openfeint/internal/OpenFeintInternal$7;

    invoke-direct {v1, p0, p1}, Lcom/openfeint/internal/OpenFeintInternal$7;-><init>(Lcom/openfeint/internal/OpenFeintInternal;Lcom/openfeint/internal/request/BaseRequest;)V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :goto_0
    return-void

    :cond_1
    iget-boolean v0, p0, Lcom/openfeint/internal/OpenFeintInternal;->mDeviceSessionCreated:Z

    if-nez v0, :cond_3

    invoke-virtual {p1}, Lcom/openfeint/internal/request/BaseRequest;->needsDeviceSession()Z

    move-result v0

    if-eqz v0, :cond_3

    invoke-direct {p0}, Lcom/openfeint/internal/OpenFeintInternal;->createDeviceSession()V

    iget-object v0, p0, Lcom/openfeint/internal/OpenFeintInternal;->mQueuedPostDeviceSessionRunnables:Ljava/util/List;

    if-nez v0, :cond_2

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/openfeint/internal/OpenFeintInternal;->mQueuedPostDeviceSessionRunnables:Ljava/util/List;

    :cond_2
    iget-object v0, p0, Lcom/openfeint/internal/OpenFeintInternal;->mQueuedPostDeviceSessionRunnables:Ljava/util/List;

    new-instance v1, Lcom/openfeint/internal/OpenFeintInternal$8;

    invoke-direct {v1, p0, p1}, Lcom/openfeint/internal/OpenFeintInternal$8;-><init>(Lcom/openfeint/internal/OpenFeintInternal;Lcom/openfeint/internal/request/BaseRequest;)V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_0

    :cond_3
    iget-object v0, p0, Lcom/openfeint/internal/OpenFeintInternal;->mClient:Lcom/openfeint/internal/request/Client;

    invoke-virtual {v0, p1}, Lcom/openfeint/internal/request/Client;->makeRequest(Lcom/openfeint/internal/request/BaseRequest;)V

    goto :goto_0
.end method

.method static synthetic access$000()Ljava/lang/String;
    .locals 1

    sget-object v0, Lcom/openfeint/internal/OpenFeintInternal;->createUserSource:Ljava/lang/String;

    return-object v0
.end method

.method static synthetic access$100(Lcom/openfeint/internal/OpenFeintInternal;Lcom/openfeint/api/resource/User;)V
    .locals 4

    const/4 v3, 0x0

    new-instance v0, Lcom/openfeint/api/resource/CurrentUser;

    invoke-direct {v0}, Lcom/openfeint/api/resource/CurrentUser;-><init>()V

    iput-object v0, p0, Lcom/openfeint/internal/OpenFeintInternal;->mCurrentUser:Lcom/openfeint/api/resource/CurrentUser;

    iget-object v0, p0, Lcom/openfeint/internal/OpenFeintInternal;->mCurrentUser:Lcom/openfeint/api/resource/CurrentUser;

    invoke-virtual {v0, p1}, Lcom/openfeint/api/resource/CurrentUser;->shallowCopyAncestorType(Lcom/openfeint/internal/resource/Resource;)V

    invoke-static {}, Lcom/openfeint/internal/eventlog/EventLogDispatcher;->getInstance()Lcom/openfeint/internal/eventlog/EventLogDispatcher;

    move-result-object v0

    const-string v1, "login_success.openfeint.com"

    invoke-virtual {v0, v1, v3}, Lcom/openfeint/internal/eventlog/EventLogDispatcher;->postEvent(Ljava/lang/String;Ljava/lang/Object;)V

    invoke-direct {p0}, Lcom/openfeint/internal/OpenFeintInternal;->lastLoggedInUser()Lcom/openfeint/api/resource/User;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Lcom/openfeint/api/resource/User;->resourceID()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1}, Lcom/openfeint/api/resource/User;->resourceID()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_1

    :cond_0
    invoke-static {}, Landroid/webkit/CookieManager;->getInstance()Landroid/webkit/CookieManager;

    move-result-object v0

    invoke-virtual {v0}, Landroid/webkit/CookieManager;->removeAllCookie()V

    :cond_1
    invoke-direct {p0}, Lcom/openfeint/internal/OpenFeintInternal;->getPrefs()Lcom/openfeint/internal/SyncedStore;

    move-result-object v0

    invoke-virtual {v0}, Lcom/openfeint/internal/SyncedStore;->edit()Lcom/openfeint/internal/SyncedStore$Editor;

    move-result-object v1

    :try_start_0
    const-string v0, "last_logged_in_server"

    invoke-virtual {p0}, Lcom/openfeint/internal/OpenFeintInternal;->getServerUrl()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v0, v2}, Lcom/openfeint/internal/SyncedStore$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)V

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v2, p0, Lcom/openfeint/internal/OpenFeintInternal;->mContext:Landroid/content/Context;

    invoke-virtual {v2}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v2, ".of_declined"

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Lcom/openfeint/internal/SyncedStore$Editor;->remove(Ljava/lang/String;)V

    const-string v0, "last_logged_in_user"

    invoke-virtual {p1}, Lcom/openfeint/api/resource/User;->generate()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v0, v2}, Lcom/openfeint/internal/SyncedStore$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    invoke-virtual {v1}, Lcom/openfeint/internal/SyncedStore$Editor;->commit()V

    iget-object v0, p0, Lcom/openfeint/internal/OpenFeintInternal;->mDelegate:Lcom/openfeint/api/OpenFeintDelegate;

    if-eqz v0, :cond_2

    iget-object v0, p0, Lcom/openfeint/internal/OpenFeintInternal;->mDelegate:Lcom/openfeint/api/OpenFeintDelegate;

    iget-object v0, p0, Lcom/openfeint/internal/OpenFeintInternal;->mCurrentUser:Lcom/openfeint/api/resource/CurrentUser;

    :cond_2
    iget-object v0, p0, Lcom/openfeint/internal/OpenFeintInternal;->mLoginDelegate:Lcom/openfeint/internal/OpenFeintInternal$LoginDelegate;

    if-eqz v0, :cond_3

    iget-object v0, p0, Lcom/openfeint/internal/OpenFeintInternal;->mLoginDelegate:Lcom/openfeint/internal/OpenFeintInternal$LoginDelegate;

    iget-object v0, p0, Lcom/openfeint/internal/OpenFeintInternal;->mCurrentUser:Lcom/openfeint/api/resource/CurrentUser;

    :cond_3
    iget-object v0, p0, Lcom/openfeint/internal/OpenFeintInternal;->mPostLoginRunnable:Ljava/lang/Runnable;

    if-eqz v0, :cond_4

    iget-object v0, p0, Lcom/openfeint/internal/OpenFeintInternal;->mMainThreadHandler:Landroid/os/Handler;

    iget-object v1, p0, Lcom/openfeint/internal/OpenFeintInternal;->mPostLoginRunnable:Ljava/lang/Runnable;

    invoke-virtual {v0, v1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    iput-object v3, p0, Lcom/openfeint/internal/OpenFeintInternal;->mPostLoginRunnable:Ljava/lang/Runnable;

    :cond_4
    invoke-virtual {p1}, Lcom/openfeint/api/resource/User;->resourceID()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/openfeint/internal/offline/OfflineSupport;->setUserID(Ljava/lang/String;)V

    return-void

    :catchall_0
    move-exception v0

    invoke-virtual {v1}, Lcom/openfeint/internal/SyncedStore$Editor;->commit()V

    throw v0
.end method

.method static synthetic access$1000(Lcom/openfeint/internal/OpenFeintInternal;)Ljava/util/List;
    .locals 1

    iget-object v0, p0, Lcom/openfeint/internal/OpenFeintInternal;->mQueuedPostLoginRunnables:Ljava/util/List;

    return-object v0
.end method

.method static synthetic access$1002$207cf26(Lcom/openfeint/internal/OpenFeintInternal;)Ljava/util/List;
    .locals 1

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/openfeint/internal/OpenFeintInternal;->mQueuedPostLoginRunnables:Ljava/util/List;

    return-object v0
.end method

.method static synthetic access$1100(Lcom/openfeint/internal/OpenFeintInternal;Lcom/openfeint/internal/request/BaseRequest;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/openfeint/internal/OpenFeintInternal;->_makeRequest(Lcom/openfeint/internal/request/BaseRequest;)V

    return-void
.end method

.method static synthetic access$1200(Lcom/openfeint/internal/OpenFeintInternal;)Z
    .locals 1

    iget-boolean v0, p0, Lcom/openfeint/internal/OpenFeintInternal;->mDeclined:Z

    return v0
.end method

.method static synthetic access$1302$78278a84(Lcom/openfeint/internal/OpenFeintInternal;)Z
    .locals 1

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/openfeint/internal/OpenFeintInternal;->mDeserializedAlready:Z

    return v0
.end method

.method static synthetic access$1400(Lcom/openfeint/internal/OpenFeintInternal;)Lcom/openfeint/api/resource/User;
    .locals 1

    invoke-direct {p0}, Lcom/openfeint/internal/OpenFeintInternal;->lastLoggedInUser()Lcom/openfeint/api/resource/User;

    move-result-object v0

    return-object v0
.end method

.method static synthetic access$1502$78278a84(Lcom/openfeint/internal/OpenFeintInternal;)Z
    .locals 1

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/openfeint/internal/OpenFeintInternal;->mBanned:Z

    return v0
.end method

.method static synthetic access$1600(Lcom/openfeint/internal/OpenFeintInternal;)V
    .locals 0

    invoke-direct {p0}, Lcom/openfeint/internal/OpenFeintInternal;->clearPrefs()V

    return-void
.end method

.method static synthetic access$1700(Lcom/openfeint/internal/OpenFeintInternal;)Z
    .locals 1

    iget-boolean v0, p0, Lcom/openfeint/internal/OpenFeintInternal;->mApproved:Z

    return v0
.end method

.method static synthetic access$202$78278a84(Lcom/openfeint/internal/OpenFeintInternal;)Z
    .locals 1

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/openfeint/internal/OpenFeintInternal;->mCreatingDeviceSession:Z

    return v0
.end method

.method static synthetic access$302(Lcom/openfeint/internal/OpenFeintInternal;Z)Z
    .locals 0

    iput-boolean p1, p0, Lcom/openfeint/internal/OpenFeintInternal;->mParentalControlsEnabled:Z

    return p1
.end method

.method static synthetic access$402$78278a84(Lcom/openfeint/internal/OpenFeintInternal;)Z
    .locals 1

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/openfeint/internal/OpenFeintInternal;->mDeviceSessionCreated:Z

    return v0
.end method

.method static synthetic access$500(Lcom/openfeint/internal/OpenFeintInternal;)Ljava/lang/Runnable;
    .locals 1

    iget-object v0, p0, Lcom/openfeint/internal/OpenFeintInternal;->mPostDeviceSessionRunnable:Ljava/lang/Runnable;

    return-object v0
.end method

.method static synthetic access$502$5f63a5fa(Lcom/openfeint/internal/OpenFeintInternal;)Ljava/lang/Runnable;
    .locals 1

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/openfeint/internal/OpenFeintInternal;->mPostDeviceSessionRunnable:Ljava/lang/Runnable;

    return-object v0
.end method

.method static synthetic access$600(Lcom/openfeint/internal/OpenFeintInternal;)Ljava/lang/Runnable;
    .locals 1

    iget-object v0, p0, Lcom/openfeint/internal/OpenFeintInternal;->mPostLoginRunnable:Ljava/lang/Runnable;

    return-object v0
.end method

.method static synthetic access$602$5f63a5fa(Lcom/openfeint/internal/OpenFeintInternal;)Ljava/lang/Runnable;
    .locals 1

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/openfeint/internal/OpenFeintInternal;->mPostLoginRunnable:Ljava/lang/Runnable;

    return-object v0
.end method

.method static synthetic access$700(Lcom/openfeint/internal/OpenFeintInternal;ILjava/lang/Object;)V
    .locals 0

    invoke-direct {p0, p1, p2}, Lcom/openfeint/internal/OpenFeintInternal;->showOfflineNotification(ILjava/lang/Object;)V

    return-void
.end method

.method static synthetic access$800(Lcom/openfeint/internal/OpenFeintInternal;)Ljava/util/List;
    .locals 1

    iget-object v0, p0, Lcom/openfeint/internal/OpenFeintInternal;->mQueuedPostDeviceSessionRunnables:Ljava/util/List;

    return-object v0
.end method

.method static synthetic access$802$207cf26(Lcom/openfeint/internal/OpenFeintInternal;)Ljava/util/List;
    .locals 1

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/openfeint/internal/OpenFeintInternal;->mQueuedPostDeviceSessionRunnables:Ljava/util/List;

    return-object v0
.end method

.method static synthetic access$900(Lcom/openfeint/internal/OpenFeintInternal;)Z
    .locals 1

    iget-boolean v0, p0, Lcom/openfeint/internal/OpenFeintInternal;->mCurrentlyLoggingIn:Z

    return v0
.end method

.method static synthetic access$902$78278a84(Lcom/openfeint/internal/OpenFeintInternal;)Z
    .locals 1

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/openfeint/internal/OpenFeintInternal;->mCurrentlyLoggingIn:Z

    return v0
.end method

.method private static cat(Ljava/lang/String;)Ljava/util/List;
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")",
            "Ljava/util/List",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    :try_start_0
    new-instance v1, Ljava/io/FileInputStream;

    invoke-direct {v1, p0}, Ljava/io/FileInputStream;-><init>(Ljava/lang/String;)V

    new-instance v2, Ljava/io/BufferedReader;

    new-instance v3, Ljava/io/InputStreamReader;

    invoke-direct {v3, v1}, Ljava/io/InputStreamReader;-><init>(Ljava/io/InputStream;)V

    const/16 v1, 0x2000

    invoke-direct {v2, v3, v1}, Ljava/io/BufferedReader;-><init>(Ljava/io/Reader;I)V

    :goto_0
    invoke-virtual {v2}, Ljava/io/BufferedReader;->readLine()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_0

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_0

    :catch_0
    move-exception v1

    :goto_1
    return-object v0

    :cond_0
    invoke-virtual {v2}, Ljava/io/BufferedReader;->close()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1
.end method

.method private checkBan()Z
    .locals 2

    iget-boolean v0, p0, Lcom/openfeint/internal/OpenFeintInternal;->mBanned:Z

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/openfeint/internal/OpenFeintInternal;->mContext:Landroid/content/Context;

    const-string v1, "of_banned_dialog"

    invoke-static {v1}, Lcom/openfeint/internal/RR;->string(Ljava/lang/String;)I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/content/Context;->getText(I)Ljava/lang/CharSequence;

    move-result-object v0

    invoke-static {v0}, Lcom/openfeint/internal/OpenFeintInternal;->displayErrorDialog(Ljava/lang/CharSequence;)V

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method private clearPrefs()V
    .locals 2

    invoke-direct {p0}, Lcom/openfeint/internal/OpenFeintInternal;->getPrefs()Lcom/openfeint/internal/SyncedStore;

    move-result-object v0

    invoke-virtual {v0}, Lcom/openfeint/internal/SyncedStore;->edit()Lcom/openfeint/internal/SyncedStore$Editor;

    move-result-object v1

    :try_start_0
    const-string v0, "last_logged_in_server"

    invoke-virtual {v1, v0}, Lcom/openfeint/internal/SyncedStore$Editor;->remove(Ljava/lang/String;)V

    const-string v0, "last_logged_in_user_name"

    invoke-virtual {v1, v0}, Lcom/openfeint/internal/SyncedStore$Editor;->remove(Ljava/lang/String;)V

    const-string v0, "last_logged_in_user"

    invoke-virtual {v1, v0}, Lcom/openfeint/internal/SyncedStore$Editor;->remove(Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    invoke-virtual {v1}, Lcom/openfeint/internal/SyncedStore$Editor;->commit()V

    return-void

    :catchall_0
    move-exception v0

    invoke-virtual {v1}, Lcom/openfeint/internal/SyncedStore$Editor;->commit()V

    throw v0
.end method

.method private createDeviceSession()V
    .locals 3

    iget-boolean v0, p0, Lcom/openfeint/internal/OpenFeintInternal;->mCreatingDeviceSession:Z

    if-nez v0, :cond_0

    iget-boolean v0, p0, Lcom/openfeint/internal/OpenFeintInternal;->mDeviceSessionCreated:Z

    if-eqz v0, :cond_1

    :cond_0
    :goto_0
    return-void

    :cond_1
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    const-string v1, "platform"

    const-string v2, "android"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v1, "device"

    invoke-virtual {p0}, Lcom/openfeint/internal/OpenFeintInternal;->getDeviceParams()Ljava/util/Map;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v1, "of-version"

    invoke-virtual {p0}, Lcom/openfeint/internal/OpenFeintInternal;->getOFVersion()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v1, "game_version"

    invoke-virtual {p0}, Lcom/openfeint/internal/OpenFeintInternal;->getAppVersion()I

    move-result v2

    invoke-static {v2}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v1, "protocol_version"

    const-string v2, "1.0"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v1, "gsdi"

    invoke-virtual {p0}, Lcom/openfeint/internal/OpenFeintInternal;->getGSDI()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    new-instance v1, Lcom/openfeint/internal/request/OrderedArgList;

    invoke-direct {v1, v0}, Lcom/openfeint/internal/request/OrderedArgList;-><init>(Ljava/util/Map;)V

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/openfeint/internal/OpenFeintInternal;->mCreatingDeviceSession:Z

    new-instance v0, Lcom/openfeint/internal/OpenFeintInternal$2;

    invoke-direct {v0, p0, v1}, Lcom/openfeint/internal/OpenFeintInternal$2;-><init>(Lcom/openfeint/internal/OpenFeintInternal;Lcom/openfeint/internal/request/OrderedArgList;)V

    invoke-direct {p0, v0}, Lcom/openfeint/internal/OpenFeintInternal;->_makeRequest(Lcom/openfeint/internal/request/BaseRequest;)V

    goto :goto_0
.end method

.method public static displayErrorDialog(Ljava/lang/CharSequence;)V
    .locals 3

    invoke-virtual {p0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    sget-object v1, Lcom/openfeint/api/Notification$Category;->Foreground:Lcom/openfeint/api/Notification$Category;

    sget-object v2, Lcom/openfeint/api/Notification$Type;->Error:Lcom/openfeint/api/Notification$Type;

    invoke-static {v0, v1, v2}, Lcom/openfeint/internal/notifications/SimpleNotification;->show(Ljava/lang/String;Lcom/openfeint/api/Notification$Category;Lcom/openfeint/api/Notification$Type;)V

    return-void
.end method

.method private findUDID()Ljava/lang/String;
    .locals 4

    iget-object v0, p0, Lcom/openfeint/internal/OpenFeintInternal;->mContext:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    const-string v1, "android_id"

    invoke-static {v0, v1}, Landroid/provider/Settings$Secure;->getString(Landroid/content/ContentResolver;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_1

    const-string v1, "9774d56d682e549c"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_1

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "android-id-"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    :cond_0
    :goto_0
    return-object v0

    :cond_1
    invoke-direct {p0}, Lcom/openfeint/internal/OpenFeintInternal;->getPrefs()Lcom/openfeint/internal/SyncedStore;

    move-result-object v0

    invoke-virtual {v0}, Lcom/openfeint/internal/SyncedStore;->read()Lcom/openfeint/internal/SyncedStore$Reader;

    move-result-object v1

    :try_start_0
    const-string v0, "udid"

    const/4 v2, 0x0

    invoke-virtual {v1, v0, v2}, Lcom/openfeint/internal/SyncedStore$Reader;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result-object v0

    invoke-virtual {v1}, Lcom/openfeint/internal/SyncedStore$Reader;->complete()V

    if-nez v0, :cond_0

    const/16 v0, 0x10

    new-array v0, v0, [B

    new-instance v1, Ljava/util/Random;

    invoke-direct {v1}, Ljava/util/Random;-><init>()V

    invoke-virtual {v1, v0}, Ljava/util/Random;->nextBytes([B)V

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "android-emu-"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    new-instance v2, Ljava/lang/String;

    invoke-static {v0}, Lcom/openfeint/internal/vendor/org/apache/commons/codec/binary/Hex;->encodeHex([B)[C

    move-result-object v0

    invoke-direct {v2, v0}, Ljava/lang/String;-><init>([C)V

    const-string v0, "\r\n"

    const-string v3, ""

    invoke-virtual {v2, v0, v3}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0}, Lcom/openfeint/internal/OpenFeintInternal;->getPrefs()Lcom/openfeint/internal/SyncedStore;

    move-result-object v1

    invoke-virtual {v1}, Lcom/openfeint/internal/SyncedStore;->edit()Lcom/openfeint/internal/SyncedStore$Editor;

    move-result-object v1

    :try_start_1
    const-string v2, "udid"

    invoke-virtual {v1, v2, v0}, Lcom/openfeint/internal/SyncedStore$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    invoke-virtual {v1}, Lcom/openfeint/internal/SyncedStore$Editor;->commit()V

    goto :goto_0

    :catchall_0
    move-exception v0

    invoke-virtual {v1}, Lcom/openfeint/internal/SyncedStore$Reader;->complete()V

    throw v0

    :catchall_1
    move-exception v0

    invoke-virtual {v1}, Lcom/openfeint/internal/SyncedStore$Editor;->commit()V

    throw v0
.end method

.method public static genericRequest(Ljava/lang/String;Ljava/lang/String;Ljava/util/Map;Ljava/util/Map;Lcom/openfeint/internal/request/IRawRequestDelegate;)V
    .locals 6
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/util/Map",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/Object;",
            ">;",
            "Ljava/util/Map",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/Object;",
            ">;",
            "Lcom/openfeint/internal/request/IRawRequestDelegate;",
            ")V"
        }
    .end annotation

    new-instance v0, Lcom/openfeint/internal/request/GenericRequest;

    move-object v1, p0

    move-object v2, p1

    move-object v3, p2

    move-object v4, p3

    move-object v5, p4

    invoke-direct/range {v0 .. v5}, Lcom/openfeint/internal/request/GenericRequest;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/util/Map;Ljava/util/Map;Lcom/openfeint/internal/request/IRawRequestDelegate;)V

    invoke-static {v0}, Lcom/openfeint/internal/OpenFeintInternal;->makeRequest(Lcom/openfeint/internal/request/BaseRequest;)V

    return-void
.end method

.method public static getInstance()Lcom/openfeint/internal/OpenFeintInternal;
    .locals 1

    sget-object v0, Lcom/openfeint/internal/OpenFeintInternal;->sInstance:Lcom/openfeint/internal/OpenFeintInternal;

    return-object v0
.end method

.method public static getModelString()Ljava/lang/String;
    .locals 2

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "p("

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-object v1, Landroid/os/Build;->PRODUCT:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ")/m("

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-object v1, Landroid/os/Build;->MODEL:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ")"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static getOSVersionString()Ljava/lang/String;
    .locals 2

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "v"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-object v1, Landroid/os/Build$VERSION;->RELEASE:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " ("

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-object v1, Landroid/os/Build$VERSION;->INCREMENTAL:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ")"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method private getPrefs()Lcom/openfeint/internal/SyncedStore;
    .locals 2

    iget-object v0, p0, Lcom/openfeint/internal/OpenFeintInternal;->mPrefs:Lcom/openfeint/internal/SyncedStore;

    if-nez v0, :cond_0

    new-instance v0, Lcom/openfeint/internal/SyncedStore;

    iget-object v1, p0, Lcom/openfeint/internal/OpenFeintInternal;->mContext:Landroid/content/Context;

    invoke-direct {v0, v1}, Lcom/openfeint/internal/SyncedStore;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lcom/openfeint/internal/OpenFeintInternal;->mPrefs:Lcom/openfeint/internal/SyncedStore;

    :cond_0
    iget-object v0, p0, Lcom/openfeint/internal/OpenFeintInternal;->mPrefs:Lcom/openfeint/internal/SyncedStore;

    return-object v0
.end method

.method private static getProcessorInfo()Ljava/lang/String;
    .locals 5

    const-string v1, "unknown"

    :try_start_0
    const-string v0, "/proc/cpuinfo"

    invoke-static {v0}, Lcom/openfeint/internal/OpenFeintInternal;->cat(Ljava/lang/String;)Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :cond_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    const-string v3, "Processor\t"

    invoke-virtual {v0, v3}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_0

    const-string v1, ":"

    invoke-virtual {v0, v1}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x1

    aget-object v0, v0, v1

    invoke-virtual {v0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0

    :goto_0
    const-string v1, "family(%s) min(%s) max(%s)"

    const/4 v2, 0x3

    new-array v2, v2, [Ljava/lang/Object;

    const/4 v3, 0x0

    aput-object v0, v2, v3

    const/4 v0, 0x1

    const-string v3, "/sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_min_freq"

    invoke-static {v3}, Lcom/openfeint/internal/OpenFeintInternal;->cat(Ljava/lang/String;)Ljava/util/List;

    move-result-object v3

    const/4 v4, 0x0

    invoke-interface {v3, v4}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v3

    aput-object v3, v2, v0

    const/4 v0, 0x2

    const-string v3, "/sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_max_freq"

    invoke-static {v3}, Lcom/openfeint/internal/OpenFeintInternal;->cat(Ljava/lang/String;)Ljava/util/List;

    move-result-object v3

    const/4 v4, 0x0

    invoke-interface {v3, v4}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v3

    aput-object v3, v2, v0

    invoke-static {v1, v2}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    :goto_1
    return-object v0

    :catch_0
    move-exception v0

    const-string v0, "family(unknown) min(unknown) max(unknown)"

    goto :goto_1

    :cond_1
    move-object v0, v1

    goto :goto_0
.end method

.method public static getRString(I)Ljava/lang/String;
    .locals 1

    sget-object v0, Lcom/openfeint/internal/OpenFeintInternal;->sInstance:Lcom/openfeint/internal/OpenFeintInternal;

    iget-object v0, v0, Lcom/openfeint/internal/OpenFeintInternal;->mContext:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method private getUDID()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/openfeint/internal/OpenFeintInternal;->mUDID:Ljava/lang/String;

    if-nez v0, :cond_0

    invoke-direct {p0}, Lcom/openfeint/internal/OpenFeintInternal;->findUDID()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/openfeint/internal/OpenFeintInternal;->mUDID:Ljava/lang/String;

    :cond_0
    iget-object v0, p0, Lcom/openfeint/internal/OpenFeintInternal;->mUDID:Ljava/lang/String;

    return-object v0
.end method

.method public static initializeWithoutLoggingIn(Landroid/content/Context;Lcom/openfeint/api/OpenFeintSettings;Lcom/openfeint/api/OpenFeintDelegate;)V
    .locals 3

    invoke-static {p0}, Lcom/openfeint/internal/OpenFeintInternal;->validateManifest(Landroid/content/Context;)Z

    sget-object v0, Lcom/openfeint/internal/OpenFeintInternal;->sInstance:Lcom/openfeint/internal/OpenFeintInternal;

    if-nez v0, :cond_0

    new-instance v0, Lcom/openfeint/internal/OpenFeintInternal;

    invoke-direct {v0, p1, p0}, Lcom/openfeint/internal/OpenFeintInternal;-><init>(Lcom/openfeint/api/OpenFeintSettings;Landroid/content/Context;)V

    sput-object v0, Lcom/openfeint/internal/OpenFeintInternal;->sInstance:Lcom/openfeint/internal/OpenFeintInternal;

    :cond_0
    sget-object v0, Lcom/openfeint/internal/OpenFeintInternal;->sInstance:Lcom/openfeint/internal/OpenFeintInternal;

    iput-object p2, v0, Lcom/openfeint/internal/OpenFeintInternal;->mDelegate:Lcom/openfeint/api/OpenFeintDelegate;

    sget-object v0, Lcom/openfeint/internal/OpenFeintInternal;->sInstance:Lcom/openfeint/internal/OpenFeintInternal;

    iget-boolean v0, v0, Lcom/openfeint/internal/OpenFeintInternal;->mDeclined:Z

    if-nez v0, :cond_2

    sget-object v0, Lcom/openfeint/internal/OpenFeintInternal;->sInstance:Lcom/openfeint/internal/OpenFeintInternal;

    invoke-virtual {v0}, Lcom/openfeint/internal/OpenFeintInternal;->getUserID()Ljava/lang/String;

    move-result-object v0

    if-nez v0, :cond_1

    invoke-static {}, Lcom/openfeint/internal/offline/OfflineSupport;->setUserTemporary()V

    :goto_0
    sget-object v0, Lcom/openfeint/internal/OpenFeintInternal;->sInstance:Lcom/openfeint/internal/OpenFeintInternal;

    invoke-direct {v0}, Lcom/openfeint/internal/OpenFeintInternal;->createDeviceSession()V

    :goto_1
    invoke-static {}, Lcom/openfeint/internal/eventlog/EventLogDispatcher;->getInstance()Lcom/openfeint/internal/eventlog/EventLogDispatcher;

    move-result-object v0

    const-string v1, "game_start.openfeint.com"

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Lcom/openfeint/internal/eventlog/EventLogDispatcher;->postEvent(Ljava/lang/String;Ljava/lang/Object;)V

    return-void

    :cond_1
    invoke-static {v0}, Lcom/openfeint/internal/offline/OfflineSupport;->setUserID(Ljava/lang/String;)V

    goto :goto_0

    :cond_2
    invoke-static {}, Lcom/openfeint/internal/offline/OfflineSupport;->setUserDeclined()V

    goto :goto_1
.end method

.method private final lastLoggedInUser()Lcom/openfeint/api/resource/User;
    .locals 6

    invoke-direct {p0}, Lcom/openfeint/internal/OpenFeintInternal;->loadUser()Lcom/openfeint/api/resource/User;

    move-result-object v0

    invoke-direct {p0}, Lcom/openfeint/internal/OpenFeintInternal;->getPrefs()Lcom/openfeint/internal/SyncedStore;

    move-result-object v1

    invoke-virtual {v1}, Lcom/openfeint/internal/SyncedStore;->read()Lcom/openfeint/internal/SyncedStore$Reader;

    move-result-object v1

    :try_start_0
    new-instance v2, Ljava/net/URL;

    invoke-virtual {p0}, Lcom/openfeint/internal/OpenFeintInternal;->getServerUrl()Ljava/lang/String;

    move-result-object v3

    invoke-direct {v2, v3}, Ljava/net/URL;-><init>(Ljava/lang/String;)V

    new-instance v3, Ljava/net/URL;

    const-string v4, "last_logged_in_server"

    const-string v5, ""

    invoke-virtual {v1, v4, v5}, Lcom/openfeint/internal/SyncedStore$Reader;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    invoke-direct {v3, v4}, Ljava/net/URL;-><init>(Ljava/lang/String;)V

    if-eqz v0, :cond_0

    invoke-virtual {v2, v3}, Ljava/net/URL;->equals(Ljava/lang/Object;)Z
    :try_end_0
    .catch Ljava/net/MalformedURLException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result v2

    if-eqz v2, :cond_0

    invoke-virtual {v1}, Lcom/openfeint/internal/SyncedStore$Reader;->complete()V

    :goto_0
    return-object v0

    :cond_0
    invoke-virtual {v1}, Lcom/openfeint/internal/SyncedStore$Reader;->complete()V

    :goto_1
    const/4 v0, 0x0

    goto :goto_0

    :catch_0
    move-exception v0

    invoke-virtual {v1}, Lcom/openfeint/internal/SyncedStore$Reader;->complete()V

    goto :goto_1

    :catchall_0
    move-exception v0

    invoke-virtual {v1}, Lcom/openfeint/internal/SyncedStore$Reader;->complete()V

    throw v0
.end method

.method private loadPropertiesFromXMLResource(Ljava/util/Properties;I)V
    .locals 5

    const/4 v1, 0x0

    :try_start_0
    iget-object v0, p0, Lcom/openfeint/internal/OpenFeintInternal;->mContext:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0, p2}, Landroid/content/res/Resources;->getXml(I)Landroid/content/res/XmlResourceParser;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    move-object v2, v0

    :goto_0
    if-eqz v2, :cond_3

    :try_start_1
    invoke-interface {v2}, Landroid/content/res/XmlResourceParser;->getEventType()I

    move-result v0

    :goto_1
    invoke-interface {v2}, Landroid/content/res/XmlResourceParser;->getEventType()I

    move-result v3

    const/4 v4, 0x1

    if-eq v3, v4, :cond_2

    const/4 v3, 0x2

    if-ne v0, v3, :cond_1

    invoke-interface {v2}, Landroid/content/res/XmlResourceParser;->getName()Ljava/lang/String;

    move-result-object v1

    :cond_0
    :goto_2
    invoke-interface {v2}, Landroid/content/res/XmlResourceParser;->next()I

    invoke-interface {v2}, Landroid/content/res/XmlResourceParser;->getEventType()I

    move-result v0

    goto :goto_1

    :catch_0
    move-exception v0

    move-object v2, v1

    goto :goto_0

    :cond_1
    invoke-interface {v2}, Landroid/content/res/XmlResourceParser;->getEventType()I

    move-result v0

    const/4 v3, 0x4

    if-ne v0, v3, :cond_0

    invoke-interface {v2}, Landroid/content/res/XmlResourceParser;->getText()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v1, v0}, Ljava/util/Properties;->setProperty(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/Object;
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1

    goto :goto_2

    :catch_1
    move-exception v0

    new-instance v1, Ljava/lang/RuntimeException;

    invoke-direct {v1, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw v1

    :cond_2
    invoke-interface {v2}, Landroid/content/res/XmlResourceParser;->close()V

    :cond_3
    return-void
.end method

.method private loadUser()Lcom/openfeint/api/resource/User;
    .locals 3

    invoke-direct {p0}, Lcom/openfeint/internal/OpenFeintInternal;->getPrefs()Lcom/openfeint/internal/SyncedStore;

    move-result-object v0

    invoke-virtual {v0}, Lcom/openfeint/internal/SyncedStore;->read()Lcom/openfeint/internal/SyncedStore$Reader;

    move-result-object v1

    :try_start_0
    const-string v0, "last_logged_in_user"

    const/4 v2, 0x0

    invoke-virtual {v1, v0, v2}, Lcom/openfeint/internal/SyncedStore$Reader;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result-object v0

    invoke-virtual {v1}, Lcom/openfeint/internal/SyncedStore$Reader;->complete()V

    invoke-static {v0}, Lcom/openfeint/internal/OpenFeintInternal;->userFromString(Ljava/lang/String;)Lcom/openfeint/api/resource/User;

    move-result-object v0

    return-object v0

    :catchall_0
    move-exception v0

    invoke-virtual {v1}, Lcom/openfeint/internal/SyncedStore$Reader;->complete()V

    throw v0
.end method

.method public static makeRequest(Lcom/openfeint/internal/request/BaseRequest;)V
    .locals 2

    sget-object v0, Lcom/openfeint/internal/OpenFeintInternal;->sInstance:Lcom/openfeint/internal/OpenFeintInternal;

    if-nez v0, :cond_0

    new-instance v0, Lcom/openfeint/internal/resource/ServerException;

    invoke-direct {v0}, Lcom/openfeint/internal/resource/ServerException;-><init>()V

    const-string v1, "NoFeint"

    iput-object v1, v0, Lcom/openfeint/internal/resource/ServerException;->exceptionClass:Ljava/lang/String;

    const-string v1, "OpenFeint has not been initialized."

    iput-object v1, v0, Lcom/openfeint/internal/resource/ServerException;->message:Ljava/lang/String;

    const/4 v1, 0x0

    invoke-virtual {v0}, Lcom/openfeint/internal/resource/ServerException;->generate()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->getBytes()[B

    move-result-object v0

    invoke-virtual {p0, v1, v0}, Lcom/openfeint/internal/request/BaseRequest;->onResponse(I[B)V

    :goto_0
    return-void

    :cond_0
    invoke-direct {v0, p0}, Lcom/openfeint/internal/OpenFeintInternal;->_makeRequest(Lcom/openfeint/internal/request/BaseRequest;)V

    goto :goto_0
.end method

.method public static restoreInstanceState(Landroid/os/Bundle;)V
    .locals 2

    sget-object v1, Lcom/openfeint/internal/OpenFeintInternal;->sInstance:Lcom/openfeint/internal/OpenFeintInternal;

    iget-boolean v0, v1, Lcom/openfeint/internal/OpenFeintInternal;->mDeserializedAlready:Z

    if-nez v0, :cond_1

    if-eqz p0, :cond_1

    const-string v0, "mCurrentUser"

    invoke-virtual {p0, v0}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/openfeint/internal/OpenFeintInternal;->userFromString(Ljava/lang/String;)Lcom/openfeint/api/resource/User;

    move-result-object v0

    check-cast v0, Lcom/openfeint/api/resource/CurrentUser;

    iput-object v0, v1, Lcom/openfeint/internal/OpenFeintInternal;->mCurrentUser:Lcom/openfeint/api/resource/CurrentUser;

    iget-object v0, v1, Lcom/openfeint/internal/OpenFeintInternal;->mClient:Lcom/openfeint/internal/request/Client;

    if-eqz v0, :cond_0

    iget-object v0, v1, Lcom/openfeint/internal/OpenFeintInternal;->mClient:Lcom/openfeint/internal/request/Client;

    invoke-virtual {v0, p0}, Lcom/openfeint/internal/request/Client;->restoreInstanceState(Landroid/os/Bundle;)V

    :cond_0
    const-string v0, "mCurrentlyLoggingIn"

    invoke-virtual {p0, v0}, Landroid/os/Bundle;->getBoolean(Ljava/lang/String;)Z

    move-result v0

    iput-boolean v0, v1, Lcom/openfeint/internal/OpenFeintInternal;->mCurrentlyLoggingIn:Z

    const-string v0, "mCreatingDeviceSession"

    invoke-virtual {p0, v0}, Landroid/os/Bundle;->getBoolean(Ljava/lang/String;)Z

    move-result v0

    iput-boolean v0, v1, Lcom/openfeint/internal/OpenFeintInternal;->mCreatingDeviceSession:Z

    const-string v0, "mDeviceSessionCreated"

    invoke-virtual {p0, v0}, Landroid/os/Bundle;->getBoolean(Ljava/lang/String;)Z

    move-result v0

    iput-boolean v0, v1, Lcom/openfeint/internal/OpenFeintInternal;->mDeviceSessionCreated:Z

    const-string v0, "mBanned"

    invoke-virtual {p0, v0}, Landroid/os/Bundle;->getBoolean(Ljava/lang/String;)Z

    move-result v0

    iput-boolean v0, v1, Lcom/openfeint/internal/OpenFeintInternal;->mBanned:Z

    const-string v0, "mParentalControlsEnabled"

    invoke-virtual {p0, v0}, Landroid/os/Bundle;->getBoolean(Ljava/lang/String;)Z

    move-result v0

    iput-boolean v0, v1, Lcom/openfeint/internal/OpenFeintInternal;->mParentalControlsEnabled:Z

    const-string v0, "mApproved"

    invoke-virtual {p0, v0}, Landroid/os/Bundle;->getBoolean(Ljava/lang/String;)Z

    move-result v0

    iput-boolean v0, v1, Lcom/openfeint/internal/OpenFeintInternal;->mApproved:Z

    const-string v0, "mDeclined"

    invoke-virtual {p0, v0}, Landroid/os/Bundle;->getBoolean(Ljava/lang/String;)Z

    move-result v0

    iput-boolean v0, v1, Lcom/openfeint/internal/OpenFeintInternal;->mDeclined:Z

    const/4 v0, 0x1

    iput-boolean v0, v1, Lcom/openfeint/internal/OpenFeintInternal;->mDeserializedAlready:Z

    :cond_1
    return-void
.end method

.method public static saveInstanceState(Landroid/os/Bundle;)V
    .locals 3

    sget-object v0, Lcom/openfeint/internal/OpenFeintInternal;->sInstance:Lcom/openfeint/internal/OpenFeintInternal;

    iget-object v1, v0, Lcom/openfeint/internal/OpenFeintInternal;->mCurrentUser:Lcom/openfeint/api/resource/CurrentUser;

    if-eqz v1, :cond_0

    const-string v1, "mCurrentUser"

    iget-object v2, v0, Lcom/openfeint/internal/OpenFeintInternal;->mCurrentUser:Lcom/openfeint/api/resource/CurrentUser;

    invoke-virtual {v2}, Lcom/openfeint/api/resource/CurrentUser;->generate()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p0, v1, v2}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    :cond_0
    iget-object v1, v0, Lcom/openfeint/internal/OpenFeintInternal;->mClient:Lcom/openfeint/internal/request/Client;

    if-eqz v1, :cond_1

    iget-object v1, v0, Lcom/openfeint/internal/OpenFeintInternal;->mClient:Lcom/openfeint/internal/request/Client;

    invoke-virtual {v1, p0}, Lcom/openfeint/internal/request/Client;->saveInstanceState(Landroid/os/Bundle;)V

    :cond_1
    const-string v1, "mCurrentlyLoggingIn"

    iget-boolean v2, v0, Lcom/openfeint/internal/OpenFeintInternal;->mCurrentlyLoggingIn:Z

    invoke-virtual {p0, v1, v2}, Landroid/os/Bundle;->putBoolean(Ljava/lang/String;Z)V

    const-string v1, "mCreatingDeviceSession"

    iget-boolean v2, v0, Lcom/openfeint/internal/OpenFeintInternal;->mCreatingDeviceSession:Z

    invoke-virtual {p0, v1, v2}, Landroid/os/Bundle;->putBoolean(Ljava/lang/String;Z)V

    const-string v1, "mDeviceSessionCreated"

    iget-boolean v2, v0, Lcom/openfeint/internal/OpenFeintInternal;->mDeviceSessionCreated:Z

    invoke-virtual {p0, v1, v2}, Landroid/os/Bundle;->putBoolean(Ljava/lang/String;Z)V

    const-string v1, "mBanned"

    iget-boolean v2, v0, Lcom/openfeint/internal/OpenFeintInternal;->mBanned:Z

    invoke-virtual {p0, v1, v2}, Landroid/os/Bundle;->putBoolean(Ljava/lang/String;Z)V

    const-string v1, "mParentalControlsEnabled"

    iget-boolean v2, v0, Lcom/openfeint/internal/OpenFeintInternal;->mParentalControlsEnabled:Z

    invoke-virtual {p0, v1, v2}, Landroid/os/Bundle;->putBoolean(Ljava/lang/String;Z)V

    const-string v1, "mApproved"

    iget-boolean v2, v0, Lcom/openfeint/internal/OpenFeintInternal;->mApproved:Z

    invoke-virtual {p0, v1, v2}, Landroid/os/Bundle;->putBoolean(Ljava/lang/String;Z)V

    const-string v1, "mDeclined"

    iget-boolean v0, v0, Lcom/openfeint/internal/OpenFeintInternal;->mDeclined:Z

    invoke-virtual {p0, v1, v0}, Landroid/os/Bundle;->putBoolean(Ljava/lang/String;Z)V

    return-void
.end method

.method public static setUserEnableSource(Ljava/lang/String;)V
    .locals 0

    sput-object p0, Lcom/openfeint/internal/OpenFeintInternal;->userEnableSource:Ljava/lang/String;

    return-void
.end method

.method private showOfflineNotification(ILjava/lang/Object;)V
    .locals 4

    iget-object v0, p0, Lcom/openfeint/internal/OpenFeintInternal;->mContext:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    const-string v0, "of_offline_notification_line2"

    invoke-static {v0}, Lcom/openfeint/internal/RR;->string(Ljava/lang/String;)I

    move-result v0

    invoke-virtual {v1, v0}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object v0

    if-eqz p1, :cond_1

    const/16 v2, 0x193

    if-ne v2, p1, :cond_0

    const/4 v2, 0x1

    iput-boolean v2, p0, Lcom/openfeint/internal/OpenFeintInternal;->mBanned:Z

    :cond_0
    instance-of v2, p2, Lcom/openfeint/internal/resource/ServerException;

    if-eqz v2, :cond_1

    check-cast p2, Lcom/openfeint/internal/resource/ServerException;

    iget-object v0, p2, Lcom/openfeint/internal/resource/ServerException;->message:Ljava/lang/String;

    :cond_1
    const-string v2, "of_offline_notification"

    invoke-static {v2}, Lcom/openfeint/internal/RR;->string(Ljava/lang/String;)I

    move-result v2

    invoke-virtual {v1, v2}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object v1

    sget-object v2, Lcom/openfeint/api/Notification$Category;->Foreground:Lcom/openfeint/api/Notification$Category;

    sget-object v3, Lcom/openfeint/api/Notification$Type;->NetworkOffline:Lcom/openfeint/api/Notification$Type;

    invoke-static {v1, v0, v2, v3}, Lcom/openfeint/internal/notifications/TwoLineNotification;->show(Ljava/lang/String;Ljava/lang/String;Lcom/openfeint/api/Notification$Category;Lcom/openfeint/api/Notification$Type;)V

    const-string v1, "Reachability"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Unable to launch IntroFlow because: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v1, v0}, Lcom/openfeint/internal/logcat/OFLog;->e(Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method private static userFromString(Ljava/lang/String;)Lcom/openfeint/api/resource/User;
    .locals 4

    const/4 v1, 0x0

    if-nez p0, :cond_0

    move-object v0, v1

    :goto_0
    return-object v0

    :cond_0
    :try_start_0
    new-instance v0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonFactory;

    const/4 v2, 0x0

    invoke-direct {v0, v2}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonFactory;-><init>(B)V

    new-instance v2, Ljava/io/ByteArrayInputStream;

    invoke-virtual {p0}, Ljava/lang/String;->getBytes()[B

    move-result-object v3

    invoke-direct {v2, v3}, Ljava/io/ByteArrayInputStream;-><init>([B)V

    invoke-virtual {v0, v2}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonFactory;->createJsonParser(Ljava/io/InputStream;)Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser;

    move-result-object v0

    new-instance v2, Lcom/openfeint/internal/JsonResourceParser;

    invoke-direct {v2, v0}, Lcom/openfeint/internal/JsonResourceParser;-><init>(Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser;)V

    invoke-virtual {v2}, Lcom/openfeint/internal/JsonResourceParser;->parse()Ljava/lang/Object;

    move-result-object v0

    if-eqz v0, :cond_1

    instance-of v2, v0, Lcom/openfeint/api/resource/User;

    if-eqz v2, :cond_1

    check-cast v0, Lcom/openfeint/api/resource/User;
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    :cond_1
    move-object v0, v1

    goto :goto_0
.end method

.method private static validateManifest(Landroid/content/Context;)Z
    .locals 12

    const/4 v1, 0x1

    const/4 v0, 0x0

    invoke-virtual {p0}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v2

    :try_start_0
    invoke-virtual {p0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x1

    invoke-virtual {v2, v3, v4}, Landroid/content/pm/PackageManager;->getPackageInfo(Ljava/lang/String;I)Landroid/content/pm/PackageInfo;

    move-result-object v4

    const/4 v2, 0x4

    new-array v5, v2, [Ljava/lang/String;

    const/4 v2, 0x0

    const-string v3, "com.openfeint.api.ui.Dashboard"

    aput-object v3, v5, v2

    const/4 v2, 0x1

    const-string v3, "com.openfeint.internal.ui.IntroFlow"

    aput-object v3, v5, v2

    const/4 v2, 0x2

    const-string v3, "com.openfeint.internal.ui.Settings"

    aput-object v3, v5, v2

    const/4 v2, 0x3

    const-string v3, "com.openfeint.internal.ui.NativeBrowser"

    aput-object v3, v5, v2

    array-length v6, v5

    move v3, v0

    :goto_0
    if-ge v3, v6, :cond_4

    aget-object v7, v5, v3

    iget-object v8, v4, Landroid/content/pm/PackageInfo;->activities:[Landroid/content/pm/ActivityInfo;

    array-length v9, v8

    move v2, v0

    :goto_1
    if-ge v2, v9, :cond_6

    aget-object v10, v8, v2

    iget-object v11, v10, Landroid/content/pm/ActivityInfo;->name:Ljava/lang/String;

    invoke-virtual {v11, v7}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v11

    if-eqz v11, :cond_2

    iget v2, v10, Landroid/content/pm/ActivityInfo;->configChanges:I

    and-int/lit16 v2, v2, 0x80

    if-nez v2, :cond_1

    const-string v2, "OpenFeintInternal"

    const-string v3, "ActivityInfo for %s has the wrong configChanges.\nPlease consult README.txt for the correct configuration."

    const/4 v4, 0x1

    new-array v4, v4, [Ljava/lang/Object;

    const/4 v5, 0x0

    aput-object v7, v4, v5

    invoke-static {v3, v4}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    :cond_0
    :goto_2
    return v0

    :cond_1
    move v2, v1

    :goto_3
    if-nez v2, :cond_3

    const-string v2, "OpenFeintInternal"

    const-string v3, "Couldn\'t find ActivityInfo for %s.\nPlease consult README.txt for the correct configuration."

    const/4 v4, 0x1

    new-array v4, v4, [Ljava/lang/Object;

    const/4 v5, 0x0

    aput-object v7, v4, v5

    invoke-static {v3, v4}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_0
    .catch Landroid/content/pm/PackageManager$NameNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_2

    :catch_0
    move-exception v2

    const-string v2, "OpenFeintInternal"

    const-string v3, "Couldn\'t find PackageInfo for %s.\nPlease initialize OF with an Activity that lives in your root package."

    new-array v1, v1, [Ljava/lang/Object;

    invoke-virtual {p0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v4

    aput-object v4, v1, v0

    invoke-static {v3, v1}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v2, v1}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_2

    :cond_2
    add-int/lit8 v2, v2, 0x1

    goto :goto_1

    :cond_3
    add-int/lit8 v2, v3, 0x1

    move v3, v2

    goto :goto_0

    :cond_4
    const/4 v2, 0x1

    :try_start_1
    new-array v3, v2, [Ljava/lang/String;

    const/4 v2, 0x0

    const-string v4, "android.permission.INTERNET"

    aput-object v4, v3, v2

    array-length v4, v3

    move v2, v0

    :goto_4
    if-ge v2, v4, :cond_5

    aget-object v5, v3, v2

    invoke-static {v5, p0}, Lcom/openfeint/internal/Util;->noPermission(Ljava/lang/String;Landroid/content/Context;)Z
    :try_end_1
    .catch Landroid/content/pm/PackageManager$NameNotFoundException; {:try_start_1 .. :try_end_1} :catch_0

    move-result v5

    if-nez v5, :cond_0

    add-int/lit8 v2, v2, 0x1

    goto :goto_4

    :cond_5
    move v0, v1

    goto :goto_2

    :cond_6
    move v2, v0

    goto :goto_3
.end method


# virtual methods
.method public final createUser(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/openfeint/internal/request/IRawRequestDelegate;)V
    .locals 2

    new-instance v0, Lcom/openfeint/internal/request/OrderedArgList;

    invoke-direct {v0}, Lcom/openfeint/internal/request/OrderedArgList;-><init>()V

    const-string v1, "user[name]"

    invoke-virtual {v0, v1, p1}, Lcom/openfeint/internal/request/OrderedArgList;->put(Ljava/lang/String;Ljava/lang/String;)V

    const-string v1, "user[http_basic_credential_attributes][email]"

    invoke-virtual {v0, v1, p2}, Lcom/openfeint/internal/request/OrderedArgList;->put(Ljava/lang/String;Ljava/lang/String;)V

    const-string v1, "user[http_basic_credential_attributes][password]"

    invoke-virtual {v0, v1, p3}, Lcom/openfeint/internal/request/OrderedArgList;->put(Ljava/lang/String;Ljava/lang/String;)V

    const-string v1, "user[http_basic_credential_attributes][password_confirmation]"

    invoke-virtual {v0, v1, p4}, Lcom/openfeint/internal/request/OrderedArgList;->put(Ljava/lang/String;Ljava/lang/String;)V

    new-instance v1, Lcom/openfeint/internal/OpenFeintInternal$1;

    invoke-direct {v1, p0, v0}, Lcom/openfeint/internal/OpenFeintInternal$1;-><init>(Lcom/openfeint/internal/OpenFeintInternal;Lcom/openfeint/internal/request/OrderedArgList;)V

    invoke-virtual {v1, p5}, Lcom/openfeint/internal/request/RawRequest;->setDelegate(Lcom/openfeint/internal/request/IRawRequestDelegate;)V

    invoke-direct {p0, v1}, Lcom/openfeint/internal/OpenFeintInternal;->_makeRequest(Lcom/openfeint/internal/request/BaseRequest;)V

    return-void
.end method

.method public final getAppID()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/openfeint/internal/OpenFeintInternal;->mSettings:Lcom/openfeint/api/OpenFeintSettings;

    iget-object v0, v0, Lcom/openfeint/api/OpenFeintSettings;->id:Ljava/lang/String;

    return-object v0
.end method

.method public final getAppName()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/openfeint/internal/OpenFeintInternal;->mSettings:Lcom/openfeint/api/OpenFeintSettings;

    iget-object v0, v0, Lcom/openfeint/api/OpenFeintSettings;->name:Ljava/lang/String;

    return-object v0
.end method

.method public final getAppVersion()I
    .locals 4

    const/4 v3, 0x0

    iget v0, p0, Lcom/openfeint/internal/OpenFeintInternal;->mAppVersion:I

    const/4 v1, -0x1

    if-ne v0, v1, :cond_0

    iget-object v0, p0, Lcom/openfeint/internal/OpenFeintInternal;->mContext:Landroid/content/Context;

    :try_start_0
    invoke-virtual {v0}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v1

    invoke-virtual {v0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v0

    const/4 v2, 0x0

    invoke-virtual {v1, v0, v2}, Landroid/content/pm/PackageManager;->getPackageInfo(Ljava/lang/String;I)Landroid/content/pm/PackageInfo;

    move-result-object v0

    iget v0, v0, Landroid/content/pm/PackageInfo;->versionCode:I

    iput v0, p0, Lcom/openfeint/internal/OpenFeintInternal;->mAppVersion:I
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :cond_0
    :goto_0
    iget v0, p0, Lcom/openfeint/internal/OpenFeintInternal;->mAppVersion:I

    return v0

    :catch_0
    move-exception v0

    iput v3, p0, Lcom/openfeint/internal/OpenFeintInternal;->mAppVersion:I

    goto :goto_0
.end method

.method public final getClient()Lorg/apache/http/impl/client/AbstractHttpClient;
    .locals 1

    iget-object v0, p0, Lcom/openfeint/internal/OpenFeintInternal;->mClient:Lcom/openfeint/internal/request/Client;

    return-object v0
.end method

.method public final getContext()Landroid/content/Context;
    .locals 1

    iget-object v0, p0, Lcom/openfeint/internal/OpenFeintInternal;->mContext:Landroid/content/Context;

    return-object v0
.end method

.method public final getCountryString()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/openfeint/internal/OpenFeintInternal;->mContext:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getConfiguration()Landroid/content/res/Configuration;

    move-result-object v0

    iget-object v0, v0, Landroid/content/res/Configuration;->locale:Ljava/util/Locale;

    invoke-virtual {v0}, Ljava/util/Locale;->getCountry()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public final getCurrentUser()Lcom/openfeint/api/resource/CurrentUser;
    .locals 1

    iget-object v0, p0, Lcom/openfeint/internal/OpenFeintInternal;->mCurrentUser:Lcom/openfeint/api/resource/CurrentUser;

    return-object v0
.end method

.method public final getDelegate()Lcom/openfeint/api/OpenFeintDelegate;
    .locals 1

    iget-object v0, p0, Lcom/openfeint/internal/OpenFeintInternal;->mDelegate:Lcom/openfeint/api/OpenFeintDelegate;

    return-object v0
.end method

.method public final getDeviceParams()Ljava/util/Map;
    .locals 7
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/Map",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/Object;",
            ">;"
        }
    .end annotation

    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    const-string v1, "identifier"

    invoke-direct {p0}, Lcom/openfeint/internal/OpenFeintInternal;->getUDID()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v1, "hardware"

    invoke-static {}, Lcom/openfeint/internal/OpenFeintInternal;->getModelString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v1, "os"

    invoke-static {}, Lcom/openfeint/internal/OpenFeintInternal;->getOSVersionString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v1, "screen_resolution"

    invoke-static {}, Lcom/openfeint/internal/Util;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v2

    const-string v3, "%dx%d (%f dpi)"

    const/4 v4, 0x3

    new-array v4, v4, [Ljava/lang/Object;

    const/4 v5, 0x0

    iget v6, v2, Landroid/util/DisplayMetrics;->widthPixels:I

    invoke-static {v6}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v6

    aput-object v6, v4, v5

    const/4 v5, 0x1

    iget v6, v2, Landroid/util/DisplayMetrics;->heightPixels:I

    invoke-static {v6}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v6

    aput-object v6, v4, v5

    const/4 v5, 0x2

    iget v2, v2, Landroid/util/DisplayMetrics;->density:F

    invoke-static {v2}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object v2

    aput-object v2, v4, v5

    invoke-static {v3, v4}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v1, "processor"

    invoke-static {}, Lcom/openfeint/internal/OpenFeintInternal;->getProcessorInfo()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    return-object v0
.end method

.method public final getGSDI()Ljava/lang/String;
    .locals 5

    iget-object v0, p0, Lcom/openfeint/internal/OpenFeintInternal;->mGSDI:Ljava/lang/String;

    if-nez v0, :cond_0

    invoke-direct {p0}, Lcom/openfeint/internal/OpenFeintInternal;->getUDID()Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Lcom/openfeint/internal/OpenFeintInternal;->mSettings:Lcom/openfeint/api/OpenFeintSettings;

    iget-object v1, v1, Lcom/openfeint/api/OpenFeintSettings;->id:Ljava/lang/String;

    const-string v2, "OFGSDI.%s.%s"

    const/4 v3, 0x2

    new-array v3, v3, [Ljava/lang/Object;

    const/4 v4, 0x0

    aput-object v0, v3, v4

    const/4 v0, 0x1

    aput-object v1, v3, v0

    invoke-static {v2, v3}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/openfeint/internal/Util;->hexSHA1(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/openfeint/internal/OpenFeintInternal;->mGSDI:Ljava/lang/String;

    :cond_0
    iget-object v0, p0, Lcom/openfeint/internal/OpenFeintInternal;->mGSDI:Ljava/lang/String;

    return-object v0
.end method

.method public final getLocaleString()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/openfeint/internal/OpenFeintInternal;->mContext:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getConfiguration()Landroid/content/res/Configuration;

    move-result-object v0

    iget-object v0, v0, Landroid/content/res/Configuration;->locale:Ljava/util/Locale;

    invoke-virtual {v0}, Ljava/util/Locale;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public final getOFVersion()Ljava/lang/String;
    .locals 2

    iget-object v0, p0, Lcom/openfeint/internal/OpenFeintInternal;->mInternalProperties:Ljava/util/Properties;

    const-string v1, "of-version"

    invoke-virtual {v0, v1}, Ljava/util/Properties;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public final getResource(Ljava/lang/String;)I
    .locals 3

    iget-object v0, p0, Lcom/openfeint/internal/OpenFeintInternal;->mContext:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Lcom/openfeint/internal/OpenFeintInternal;->mContext:Landroid/content/Context;

    invoke-virtual {v1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    const/4 v2, 0x0

    invoke-virtual {v1, p1, v2, v0}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    return v0
.end method

.method public final getServerUrl()Ljava/lang/String;
    .locals 3

    iget-object v0, p0, Lcom/openfeint/internal/OpenFeintInternal;->mServerUrl:Ljava/lang/String;

    if-nez v0, :cond_1

    iget-object v0, p0, Lcom/openfeint/internal/OpenFeintInternal;->mInternalProperties:Ljava/util/Properties;

    const-string v1, "server-url"

    invoke-virtual {v0, v1}, Ljava/util/Properties;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0

    const-string v1, "/"

    invoke-virtual {v0, v1}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_0

    const/4 v1, 0x0

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v2

    add-int/lit8 v2, v2, -0x1

    invoke-virtual {v0, v1, v2}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v0

    :cond_0
    iput-object v0, p0, Lcom/openfeint/internal/OpenFeintInternal;->mServerUrl:Ljava/lang/String;

    :cond_1
    iget-object v0, p0, Lcom/openfeint/internal/OpenFeintInternal;->mServerUrl:Ljava/lang/String;

    return-object v0
.end method

.method public final getSessionID()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/openfeint/internal/OpenFeintInternal;->mSessionID:Ljava/lang/String;

    return-object v0
.end method

.method public final getSessionStartDate()Ljava/util/Date;
    .locals 1

    iget-object v0, p0, Lcom/openfeint/internal/OpenFeintInternal;->mSessionStartDate:Ljava/util/Date;

    return-object v0
.end method

.method public final getSettings()Ljava/util/Map;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/Map",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/Object;",
            ">;"
        }
    .end annotation

    iget-object v0, p0, Lcom/openfeint/internal/OpenFeintInternal;->mSettings:Lcom/openfeint/api/OpenFeintSettings;

    iget-object v0, v0, Lcom/openfeint/api/OpenFeintSettings;->settings:Ljava/util/Map;

    return-object v0
.end method

.method public final getUserID()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/openfeint/internal/OpenFeintInternal;->mCurrentUser:Lcom/openfeint/api/resource/CurrentUser;

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Lcom/openfeint/api/resource/User;->userID()Ljava/lang/String;

    move-result-object v0

    :goto_0
    return-object v0

    :cond_0
    invoke-direct {p0}, Lcom/openfeint/internal/OpenFeintInternal;->lastLoggedInUser()Lcom/openfeint/api/resource/User;

    move-result-object v0

    if-eqz v0, :cond_1

    invoke-virtual {v0}, Lcom/openfeint/api/resource/User;->userID()Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    :cond_1
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public final isFeintServerReachable()Z
    .locals 3

    const/4 v1, 0x1

    const-string v0, "android.permission.ACCESS_NETWORK_STATE"

    iget-object v2, p0, Lcom/openfeint/internal/OpenFeintInternal;->mContext:Landroid/content/Context;

    invoke-static {v0, v2}, Lcom/openfeint/internal/Util;->noPermission(Ljava/lang/String;Landroid/content/Context;)Z

    move-result v0

    if-eqz v0, :cond_0

    move v0, v1

    :goto_0
    return v0

    :cond_0
    iget-object v0, p0, Lcom/openfeint/internal/OpenFeintInternal;->mContext:Landroid/content/Context;

    const-string v2, "connectivity"

    invoke-virtual {v0, v2}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/net/ConnectivityManager;

    invoke-virtual {v0}, Landroid/net/ConnectivityManager;->getActiveNetworkInfo()Landroid/net/NetworkInfo;

    move-result-object v0

    if-eqz v0, :cond_1

    invoke-virtual {v0}, Landroid/net/NetworkInfo;->isConnected()Z

    move-result v0

    if-eqz v0, :cond_1

    move v0, v1

    goto :goto_0

    :cond_1
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public final isUserLoggedIn()Z
    .locals 1

    iget-object v0, p0, Lcom/openfeint/internal/OpenFeintInternal;->mCurrentUser:Lcom/openfeint/api/resource/CurrentUser;

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public final launchIntroFlow(Z)V
    .locals 2

    invoke-direct {p0}, Lcom/openfeint/internal/OpenFeintInternal;->checkBan()Z

    move-result v0

    if-eqz v0, :cond_0

    :goto_0
    return-void

    :cond_0
    invoke-virtual {p0}, Lcom/openfeint/internal/OpenFeintInternal;->isFeintServerReachable()Z

    move-result v0

    if-eqz v0, :cond_5

    iget-object v0, p0, Lcom/openfeint/internal/OpenFeintInternal;->mDelegate:Lcom/openfeint/api/OpenFeintDelegate;

    iget-boolean v1, p0, Lcom/openfeint/internal/OpenFeintInternal;->mApproved:Z

    if-nez v1, :cond_1

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/openfeint/internal/OpenFeintInternal;->mContext:Landroid/content/Context;

    :cond_1
    new-instance v0, Lcom/openfeint/internal/OpenFeintInternal$11;

    invoke-direct {v0, p0, p1}, Lcom/openfeint/internal/OpenFeintInternal$11;-><init>(Lcom/openfeint/internal/OpenFeintInternal;Z)V

    iget-boolean v1, p0, Lcom/openfeint/internal/OpenFeintInternal;->mCreatingDeviceSession:Z

    if-nez v1, :cond_2

    iget-boolean v1, p0, Lcom/openfeint/internal/OpenFeintInternal;->mDeviceSessionCreated:Z

    if-nez v1, :cond_4

    :cond_2
    iget-boolean v1, p0, Lcom/openfeint/internal/OpenFeintInternal;->mCreatingDeviceSession:Z

    if-nez v1, :cond_3

    invoke-direct {p0}, Lcom/openfeint/internal/OpenFeintInternal;->createDeviceSession()V

    :cond_3
    iput-object v0, p0, Lcom/openfeint/internal/OpenFeintInternal;->mPostDeviceSessionRunnable:Ljava/lang/Runnable;

    goto :goto_0

    :cond_4
    invoke-interface {v0}, Ljava/lang/Runnable;->run()V

    goto :goto_0

    :cond_5
    const/4 v0, 0x0

    const-string v1, ""

    invoke-direct {p0, v0, v1}, Lcom/openfeint/internal/OpenFeintInternal;->showOfflineNotification(ILjava/lang/Object;)V

    goto :goto_0
.end method

.method public final login(Z)V
    .locals 2

    new-instance v0, Lcom/openfeint/internal/OpenFeintInternal$10;

    invoke-direct {v0, p0, p1}, Lcom/openfeint/internal/OpenFeintInternal$10;-><init>(Lcom/openfeint/internal/OpenFeintInternal;Z)V

    iget-object v1, p0, Lcom/openfeint/internal/OpenFeintInternal;->mMainThreadHandler:Landroid/os/Handler;

    invoke-virtual {v1, v0}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void
.end method

.method public final loginUser(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/openfeint/internal/request/IRawRequestDelegate;)V
    .locals 6

    const/4 v2, 0x1

    const/4 v0, 0x0

    invoke-direct {p0}, Lcom/openfeint/internal/OpenFeintInternal;->checkBan()Z

    move-result v1

    if-eqz v1, :cond_0

    :goto_0
    return-void

    :cond_0
    iget-boolean v1, p0, Lcom/openfeint/internal/OpenFeintInternal;->mCreatingDeviceSession:Z

    if-nez v1, :cond_1

    iget-boolean v1, p0, Lcom/openfeint/internal/OpenFeintInternal;->mDeviceSessionCreated:Z

    if-nez v1, :cond_3

    :cond_1
    iget-boolean v0, p0, Lcom/openfeint/internal/OpenFeintInternal;->mCreatingDeviceSession:Z

    if-nez v0, :cond_2

    invoke-direct {p0}, Lcom/openfeint/internal/OpenFeintInternal;->createDeviceSession()V

    :cond_2
    const-string v0, "OpenFeintInternal"

    const-string v1, "No device session yet - queueing login."

    invoke-static {v0, v1}, Lcom/openfeint/internal/logcat/OFLog;->i(Ljava/lang/String;Ljava/lang/String;)V

    new-instance v0, Lcom/openfeint/internal/OpenFeintInternal$3;

    move-object v1, p0

    move-object v2, p1

    move-object v3, p2

    move-object v4, p3

    move-object v5, p4

    invoke-direct/range {v0 .. v5}, Lcom/openfeint/internal/OpenFeintInternal$3;-><init>(Lcom/openfeint/internal/OpenFeintInternal;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/openfeint/internal/request/IRawRequestDelegate;)V

    iput-object v0, p0, Lcom/openfeint/internal/OpenFeintInternal;->mPostDeviceSessionRunnable:Ljava/lang/Runnable;

    goto :goto_0

    :cond_3
    new-instance v3, Lcom/openfeint/internal/request/OrderedArgList;

    invoke-direct {v3}, Lcom/openfeint/internal/request/OrderedArgList;-><init>()V

    if-eqz p1, :cond_5

    if-eqz p2, :cond_5

    const-string v1, "login"

    invoke-virtual {v3, v1, p1}, Lcom/openfeint/internal/request/OrderedArgList;->put(Ljava/lang/String;Ljava/lang/String;)V

    const-string v1, "password"

    invoke-virtual {v3, v1, p2}, Lcom/openfeint/internal/request/OrderedArgList;->put(Ljava/lang/String;Ljava/lang/String;)V

    move v1, v0

    :goto_1
    if-eqz p3, :cond_4

    if-eqz p2, :cond_4

    const-string v1, "user_id"

    invoke-virtual {v3, v1, p3}, Lcom/openfeint/internal/request/OrderedArgList;->put(Ljava/lang/String;Ljava/lang/String;)V

    const-string v1, "password"

    invoke-virtual {v3, v1, p2}, Lcom/openfeint/internal/request/OrderedArgList;->put(Ljava/lang/String;Ljava/lang/String;)V

    :goto_2
    iput-boolean v2, p0, Lcom/openfeint/internal/OpenFeintInternal;->mCurrentlyLoggingIn:Z

    new-instance v1, Lcom/openfeint/internal/OpenFeintInternal$4;

    invoke-direct {v1, p0, v3, v0}, Lcom/openfeint/internal/OpenFeintInternal$4;-><init>(Lcom/openfeint/internal/OpenFeintInternal;Lcom/openfeint/internal/request/OrderedArgList;Z)V

    invoke-virtual {v1, p4}, Lcom/openfeint/internal/request/RawRequest;->setDelegate(Lcom/openfeint/internal/request/IRawRequestDelegate;)V

    invoke-direct {p0, v1}, Lcom/openfeint/internal/OpenFeintInternal;->_makeRequest(Lcom/openfeint/internal/request/BaseRequest;)V

    goto :goto_0

    :cond_4
    move v0, v1

    goto :goto_2

    :cond_5
    move v1, v2

    goto :goto_1
.end method

.method public final logoutUser(Lcom/openfeint/internal/request/IRawRequestDelegate;)V
    .locals 3

    new-instance v0, Lcom/openfeint/internal/request/OrderedArgList;

    invoke-direct {v0}, Lcom/openfeint/internal/request/OrderedArgList;-><init>()V

    const-string v1, "platform"

    const-string v2, "android"

    invoke-virtual {v0, v1, v2}, Lcom/openfeint/internal/request/OrderedArgList;->put(Ljava/lang/String;Ljava/lang/String;)V

    new-instance v1, Lcom/openfeint/internal/OpenFeintInternal$6;

    invoke-direct {v1, p0, v0}, Lcom/openfeint/internal/OpenFeintInternal$6;-><init>(Lcom/openfeint/internal/OpenFeintInternal;Lcom/openfeint/internal/request/OrderedArgList;)V

    invoke-virtual {v1, p1}, Lcom/openfeint/internal/request/RawRequest;->setDelegate(Lcom/openfeint/internal/request/IRawRequestDelegate;)V

    invoke-direct {p0, v1}, Lcom/openfeint/internal/OpenFeintInternal;->_makeRequest(Lcom/openfeint/internal/request/BaseRequest;)V

    iget-object v0, p0, Lcom/openfeint/internal/OpenFeintInternal;->mCurrentUser:Lcom/openfeint/api/resource/CurrentUser;

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/openfeint/internal/OpenFeintInternal;->mCurrentUser:Lcom/openfeint/api/resource/CurrentUser;

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/openfeint/internal/OpenFeintInternal;->mDeviceSessionCreated:Z

    invoke-direct {p0}, Lcom/openfeint/internal/OpenFeintInternal;->clearPrefs()V

    iget-object v0, p0, Lcom/openfeint/internal/OpenFeintInternal;->mDelegate:Lcom/openfeint/api/OpenFeintDelegate;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/openfeint/internal/OpenFeintInternal;->mDelegate:Lcom/openfeint/api/OpenFeintDelegate;

    :cond_0
    invoke-static {}, Lcom/openfeint/internal/offline/OfflineSupport;->setUserDeclined()V

    return-void
.end method

.method public final parentalControlsEnabled()Z
    .locals 1

    iget-boolean v0, p0, Lcom/openfeint/internal/OpenFeintInternal;->mParentalControlsEnabled:Z

    return v0
.end method

.method public final runOnUiThread(Ljava/lang/Runnable;)V
    .locals 1

    iget-object v0, p0, Lcom/openfeint/internal/OpenFeintInternal;->mMainThreadHandler:Landroid/os/Handler;

    invoke-virtual {v0, p1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void
.end method

.method public final setParentalControlsEnabled(Z)V
    .locals 0

    iput-boolean p1, p0, Lcom/openfeint/internal/OpenFeintInternal;->mParentalControlsEnabled:Z

    return-void
.end method

.method public final submitIntent(Landroid/content/Intent;Z)V
    .locals 5

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/openfeint/internal/OpenFeintInternal;->mDeclined:Z

    new-instance v1, Lcom/openfeint/internal/OpenFeintInternal$5;

    invoke-direct {v1, p0, p1}, Lcom/openfeint/internal/OpenFeintInternal$5;-><init>(Lcom/openfeint/internal/OpenFeintInternal;Landroid/content/Intent;)V

    invoke-virtual {p0}, Lcom/openfeint/internal/OpenFeintInternal;->isUserLoggedIn()Z

    move-result v2

    if-nez v2, :cond_3

    const-string v2, "OpenFeintInternal"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Not logged in yet - queueing intent "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {p1}, Landroid/content/Intent;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, " for now."

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Lcom/openfeint/internal/logcat/OFLog;->i(Ljava/lang/String;Ljava/lang/String;)V

    iput-object v1, p0, Lcom/openfeint/internal/OpenFeintInternal;->mPostLoginRunnable:Ljava/lang/Runnable;

    iget-boolean v1, p0, Lcom/openfeint/internal/OpenFeintInternal;->mCurrentlyLoggingIn:Z

    if-nez v1, :cond_0

    iget-boolean v1, p0, Lcom/openfeint/internal/OpenFeintInternal;->mCreatingDeviceSession:Z

    if-eqz v1, :cond_1

    :cond_0
    const/4 v0, 0x1

    :cond_1
    if-nez v0, :cond_2

    invoke-virtual {p0, p2}, Lcom/openfeint/internal/OpenFeintInternal;->login(Z)V

    :cond_2
    :goto_0
    return-void

    :cond_3
    iget-object v0, p0, Lcom/openfeint/internal/OpenFeintInternal;->mMainThreadHandler:Landroid/os/Handler;

    invoke-virtual {v0, v1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    goto :goto_0
.end method

.method public final uploadFile(Ljava/lang/String;Lcom/openfeint/internal/request/multipart/PartSource;Ljava/lang/String;Lcom/openfeint/internal/OpenFeintInternal$IUploadDelegate;)V
    .locals 6

    new-instance v0, Lcom/openfeint/internal/OpenFeintInternal$9;

    move-object v1, p0

    move-object v2, p1

    move-object v3, p2

    move-object v4, p3

    move-object v5, p4

    invoke-direct/range {v0 .. v5}, Lcom/openfeint/internal/OpenFeintInternal$9;-><init>(Lcom/openfeint/internal/OpenFeintInternal;Ljava/lang/String;Lcom/openfeint/internal/request/multipart/PartSource;Ljava/lang/String;Lcom/openfeint/internal/OpenFeintInternal$IUploadDelegate;)V

    invoke-direct {p0, v0}, Lcom/openfeint/internal/OpenFeintInternal;->_makeRequest(Lcom/openfeint/internal/request/BaseRequest;)V

    return-void
.end method

.method public final userDeclinedFeint()V
    .locals 3

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/openfeint/internal/OpenFeintInternal;->mApproved:Z

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/openfeint/internal/OpenFeintInternal;->mDeclined:Z

    invoke-static {}, Lcom/openfeint/internal/eventlog/EventLogDispatcher;->getInstance()Lcom/openfeint/internal/eventlog/EventLogDispatcher;

    move-result-object v0

    const-string v1, "declined_of.openfeint.com"

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Lcom/openfeint/internal/eventlog/EventLogDispatcher;->postEvent(Ljava/lang/String;Ljava/lang/Object;)V

    invoke-direct {p0}, Lcom/openfeint/internal/OpenFeintInternal;->getPrefs()Lcom/openfeint/internal/SyncedStore;

    move-result-object v0

    invoke-virtual {v0}, Lcom/openfeint/internal/SyncedStore;->edit()Lcom/openfeint/internal/SyncedStore$Editor;

    move-result-object v1

    :try_start_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v2, p0, Lcom/openfeint/internal/OpenFeintInternal;->mContext:Landroid/content/Context;

    invoke-virtual {v2}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v2, ".of_declined"

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const-string v2, "sadly"

    invoke-virtual {v1, v0, v2}, Lcom/openfeint/internal/SyncedStore$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    invoke-virtual {v1}, Lcom/openfeint/internal/SyncedStore$Editor;->commit()V

    invoke-static {}, Lcom/openfeint/internal/offline/OfflineSupport;->setUserDeclined()V

    return-void

    :catchall_0
    move-exception v0

    invoke-virtual {v1}, Lcom/openfeint/internal/SyncedStore$Editor;->commit()V

    throw v0
.end method
