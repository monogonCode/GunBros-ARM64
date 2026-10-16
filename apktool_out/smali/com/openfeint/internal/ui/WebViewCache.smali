.class public final Lcom/openfeint/internal/ui/WebViewCache;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/openfeint/internal/ui/WebViewCache$SaxHandler;,
        Lcom/openfeint/internal/ui/WebViewCache$ManifestRequest;,
        Lcom/openfeint/internal/ui/WebViewCache$PathAndCallback;,
        Lcom/openfeint/internal/ui/WebViewCache$ItemAndCallback;,
        Lcom/openfeint/internal/ui/WebViewCache$ManifestData;,
        Lcom/openfeint/internal/ui/WebViewCache$ManifestItem;
    }
.end annotation


# static fields
.field private static diskError:Z

.field public static manifestProductOverride:Ljava/lang/String;

.field private static rootPath:Ljava/lang/String;

.field private static rootUri:Ljava/lang/String;

.field static sInstance:Lcom/openfeint/internal/ui/WebViewCache;

.field public static serverOverride:Ljava/net/URI;


# instance fields
.field appContext:Landroid/content/Context;

.field batchesAreBroken:Z

.field clientManifest:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field finishWhenClientManifestDone:Z

.field globalsFinished:Z

.field loadingFinished:Z

.field mDelayHandler:Landroid/os/Handler;

.field mHandler:Landroid/os/Handler;

.field pathsToLoad:Ljava/util/Set;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Set",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field prioritizedPaths:Ljava/util/Set;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Set",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field serverManifest:Lcom/openfeint/internal/ui/WebViewCache$ManifestData;

.field final serverURI:Ljava/net/URI;

.field trackedItems:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map",
            "<",
            "Ljava/lang/String;",
            "Lcom/openfeint/internal/ui/WebViewCache$ItemAndCallback;",
            ">;"
        }
    .end annotation
.end field

.field trackedPaths:Ljava/util/Set;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Set",
            "<",
            "Lcom/openfeint/internal/ui/WebViewCache$PathAndCallback;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 1

    const/4 v0, 0x0

    sput-boolean v0, Lcom/openfeint/internal/ui/WebViewCache;->diskError:Z

    return-void
.end method

.method private constructor <init>(Landroid/content/Context;)V
    .locals 1

    const/4 v0, 0x0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-boolean v0, p0, Lcom/openfeint/internal/ui/WebViewCache;->loadingFinished:Z

    iput-boolean v0, p0, Lcom/openfeint/internal/ui/WebViewCache;->globalsFinished:Z

    iput-boolean v0, p0, Lcom/openfeint/internal/ui/WebViewCache;->batchesAreBroken:Z

    iput-boolean v0, p0, Lcom/openfeint/internal/ui/WebViewCache;->finishWhenClientManifestDone:Z

    invoke-static {}, Lcom/openfeint/internal/ui/WebViewCache;->getServerURI()Ljava/net/URI;

    move-result-object v0

    iput-object v0, p0, Lcom/openfeint/internal/ui/WebViewCache;->serverURI:Ljava/net/URI;

    iput-object p1, p0, Lcom/openfeint/internal/ui/WebViewCache;->appContext:Landroid/content/Context;

    new-instance v0, Ljava/util/HashSet;

    invoke-direct {v0}, Ljava/util/HashSet;-><init>()V

    iput-object v0, p0, Lcom/openfeint/internal/ui/WebViewCache;->trackedPaths:Ljava/util/Set;

    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lcom/openfeint/internal/ui/WebViewCache;->trackedItems:Ljava/util/Map;

    new-instance v0, Ljava/util/HashSet;

    invoke-direct {v0}, Ljava/util/HashSet;-><init>()V

    iput-object v0, p0, Lcom/openfeint/internal/ui/WebViewCache;->pathsToLoad:Ljava/util/Set;

    new-instance v0, Ljava/util/HashSet;

    invoke-direct {v0}, Ljava/util/HashSet;-><init>()V

    iput-object v0, p0, Lcom/openfeint/internal/ui/WebViewCache;->prioritizedPaths:Ljava/util/Set;

    new-instance v0, Landroid/os/Handler;

    invoke-direct {v0}, Landroid/os/Handler;-><init>()V

    iput-object v0, p0, Lcom/openfeint/internal/ui/WebViewCache;->mDelayHandler:Landroid/os/Handler;

    new-instance v0, Lcom/openfeint/internal/ui/WebViewCache$3;

    invoke-direct {v0, p0}, Lcom/openfeint/internal/ui/WebViewCache$3;-><init>(Lcom/openfeint/internal/ui/WebViewCache;)V

    iput-object v0, p0, Lcom/openfeint/internal/ui/WebViewCache;->mHandler:Landroid/os/Handler;

    return-void
.end method

.method static synthetic access$000(Lcom/openfeint/internal/ui/WebViewCache;)V
    .locals 0

    invoke-direct {p0}, Lcom/openfeint/internal/ui/WebViewCache;->deleteAll()V

    return-void
.end method

.method static synthetic access$100(Lcom/openfeint/internal/ui/WebViewCache;)V
    .locals 0

    invoke-direct {p0}, Lcom/openfeint/internal/ui/WebViewCache;->clientManifestReady()V

    return-void
.end method

.method static synthetic access$1100(Lcom/openfeint/internal/ui/WebViewCache;)V
    .locals 3

    iget-object v0, p0, Lcom/openfeint/internal/ui/WebViewCache;->mHandler:Landroid/os/Handler;

    const/4 v1, 0x4

    const/4 v2, 0x0

    invoke-static {v0, v1, v2}, Landroid/os/Message;->obtain(Landroid/os/Handler;ILjava/lang/Object;)Landroid/os/Message;

    move-result-object v0

    invoke-virtual {v0}, Landroid/os/Message;->sendToTarget()V

    return-void
.end method

.method static synthetic access$1300(Lcom/openfeint/internal/ui/WebViewCache;I[BLjava/lang/String;Ljava/lang/String;ILjava/util/Set;)V
    .locals 7

    const/4 v6, 0x2

    const/4 v5, 0x0

    const/16 v0, 0xc8

    if-gt v0, p1, :cond_3

    const/16 v0, 0x12c

    if-ge p1, v0, :cond_3

    new-instance v1, Ljava/util/HashSet;

    invoke-direct {v1}, Ljava/util/HashSet;-><init>()V

    new-instance v0, Ljava/util/zip/ZipInputStream;

    new-instance v2, Ljava/io/ByteArrayInputStream;

    invoke-direct {v2, p2}, Ljava/io/ByteArrayInputStream;-><init>([B)V

    invoke-direct {v0, v2}, Ljava/util/zip/ZipInputStream;-><init>(Ljava/io/InputStream;)V

    :cond_0
    :goto_0
    :try_start_0
    invoke-virtual {v0}, Ljava/util/zip/ZipInputStream;->getNextEntry()Ljava/util/zip/ZipEntry;

    move-result-object v2

    if-eqz v2, :cond_1

    invoke-virtual {v2}, Ljava/util/zip/ZipEntry;->isDirectory()Z

    move-result v3

    if-nez v3, :cond_0

    invoke-virtual {v2}, Ljava/util/zip/ZipEntry;->getName()Ljava/lang/String;

    move-result-object v2

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v4, Lcom/openfeint/internal/ui/WebViewCache;->rootPath:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v0, v3}, Lcom/openfeint/internal/Util;->saveStreamAndLeaveInputOpen(Ljava/io/InputStream;Ljava/lang/String;)V

    invoke-virtual {v1, v2}, Ljava/util/HashSet;->add(Ljava/lang/Object;)Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    const-string v2, "WebViewCache"

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v0

    invoke-static {v2, v0}, Lcom/openfeint/internal/logcat/OFLog;->e(Ljava/lang/String;Ljava/lang/String;)V

    :cond_1
    invoke-virtual {v1}, Ljava/util/HashSet;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_2

    iget-object v0, p0, Lcom/openfeint/internal/ui/WebViewCache;->mHandler:Landroid/os/Handler;

    const/4 v2, 0x1

    invoke-static {v0, v6, v2, v5, v1}, Landroid/os/Message;->obtain(Landroid/os/Handler;IIILjava/lang/Object;)Landroid/os/Message;

    move-result-object v0

    invoke-virtual {v0}, Landroid/os/Message;->sendToTarget()V

    :goto_1
    return-void

    :cond_2
    iget-object v0, p0, Lcom/openfeint/internal/ui/WebViewCache;->mHandler:Landroid/os/Handler;

    invoke-static {v0, v6, v5, v5, p6}, Landroid/os/Message;->obtain(Landroid/os/Handler;IIILjava/lang/Object;)Landroid/os/Message;

    move-result-object v0

    invoke-virtual {v0}, Landroid/os/Message;->sendToTarget()V

    goto :goto_1

    :cond_3
    const/16 v0, 0x12e

    if-eq v0, p1, :cond_4

    const/16 v0, 0x12f

    if-ne v0, p1, :cond_5

    :cond_4
    invoke-direct {p0, p3, p4, p5, p6}, Lcom/openfeint/internal/ui/WebViewCache;->batchFetch(Ljava/lang/String;Ljava/lang/String;ILjava/util/Set;)V

    goto :goto_1

    :cond_5
    if-eqz p1, :cond_6

    const/16 v0, 0x190

    if-gt v0, p1, :cond_8

    const/16 v0, 0x1f4

    if-ge p1, v0, :cond_8

    :cond_6
    if-lez p5, :cond_7

    iget-object v6, p0, Lcom/openfeint/internal/ui/WebViewCache;->mDelayHandler:Landroid/os/Handler;

    new-instance v0, Lcom/openfeint/internal/ui/WebViewCache$6;

    move-object v1, p0

    move-object v2, p3

    move-object v3, p4

    move-object v4, p6

    move v5, p5

    invoke-direct/range {v0 .. v5}, Lcom/openfeint/internal/ui/WebViewCache$6;-><init>(Lcom/openfeint/internal/ui/WebViewCache;Ljava/lang/String;Ljava/lang/String;Ljava/util/Set;I)V

    const-wide/16 v1, 0x1388

    invoke-virtual {v6, v0, v1, v2}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    goto :goto_1

    :cond_7
    iget-object v0, p0, Lcom/openfeint/internal/ui/WebViewCache;->mHandler:Landroid/os/Handler;

    invoke-static {v0, v6, v5, v5, p6}, Landroid/os/Message;->obtain(Landroid/os/Handler;IIILjava/lang/Object;)Landroid/os/Message;

    move-result-object v0

    invoke-virtual {v0}, Landroid/os/Message;->sendToTarget()V

    goto :goto_1

    :cond_8
    iget-object v0, p0, Lcom/openfeint/internal/ui/WebViewCache;->mHandler:Landroid/os/Handler;

    invoke-static {v0, v6, v5, v5, p6}, Landroid/os/Message;->obtain(Landroid/os/Handler;IIILjava/lang/Object;)Landroid/os/Message;

    move-result-object v0

    invoke-virtual {v0}, Landroid/os/Message;->sendToTarget()V

    goto :goto_1
.end method

.method static synthetic access$1400(Lcom/openfeint/internal/ui/WebViewCache;Ljava/util/Set;I)V
    .locals 0

    invoke-direct {p0, p1, p2}, Lcom/openfeint/internal/ui/WebViewCache;->batchRequest(Ljava/util/Set;I)V

    return-void
.end method

.method static synthetic access$1500(Lcom/openfeint/internal/ui/WebViewCache;Ljava/lang/String;Ljava/lang/String;ILjava/util/Set;)V
    .locals 0

    invoke-direct {p0, p1, p2, p3, p4}, Lcom/openfeint/internal/ui/WebViewCache;->batchFetch(Ljava/lang/String;Ljava/lang/String;ILjava/util/Set;)V

    return-void
.end method

.method static synthetic access$1600()Ljava/lang/String;
    .locals 1

    sget-object v0, Lcom/openfeint/internal/ui/WebViewCache;->rootPath:Ljava/lang/String;

    return-object v0
.end method

.method static synthetic access$200(Lcom/openfeint/internal/ui/WebViewCache;Ljava/io/File;)V
    .locals 3

    new-instance v0, Ljava/util/HashSet;

    invoke-direct {v0}, Ljava/util/HashSet;-><init>()V

    const-string v1, "webui"

    invoke-direct {p0, v1, v0}, Lcom/openfeint/internal/ui/WebViewCache;->gatherDefaultItems(Ljava/lang/String;Ljava/util/Set;)V

    invoke-direct {p0, v0}, Lcom/openfeint/internal/ui/WebViewCache;->stripUnused(Ljava/util/Set;)Ljava/util/Set;

    move-result-object v1

    const-string v0, "webui/manifest.plist"

    invoke-direct {p0, p1, v0, v1}, Lcom/openfeint/internal/ui/WebViewCache;->copySpecific(Ljava/io/File;Ljava/lang/String;Ljava/util/Set;)V

    const-string v0, "webui/javascripts/"

    invoke-direct {p0, p1, v0, v1}, Lcom/openfeint/internal/ui/WebViewCache;->copyDirectory(Ljava/io/File;Ljava/lang/String;Ljava/util/Set;)V

    const-string v0, "webui/stylesheets/"

    invoke-direct {p0, p1, v0, v1}, Lcom/openfeint/internal/ui/WebViewCache;->copyDirectory(Ljava/io/File;Ljava/lang/String;Ljava/util/Set;)V

    const-string v0, "webui/intro/"

    invoke-direct {p0, p1, v0, v1}, Lcom/openfeint/internal/ui/WebViewCache;->copyDirectory(Ljava/io/File;Ljava/lang/String;Ljava/util/Set;)V

    iget-object v0, p0, Lcom/openfeint/internal/ui/WebViewCache;->appContext:Landroid/content/Context;

    invoke-static {v0}, Lcom/openfeint/internal/Util;->getDpiName(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    const-string v2, "mdpi"

    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    const-string v0, "webui/images/space.grid.mdpi.png"

    invoke-direct {p0, p1, v0, v1}, Lcom/openfeint/internal/ui/WebViewCache;->copySpecific(Ljava/io/File;Ljava/lang/String;Ljava/util/Set;)V

    const-string v0, "webui/images/button.gray.mdpi.png"

    invoke-direct {p0, p1, v0, v1}, Lcom/openfeint/internal/ui/WebViewCache;->copySpecific(Ljava/io/File;Ljava/lang/String;Ljava/util/Set;)V

    const-string v0, "webui/images/button.gray.hit.mdpi.png"

    invoke-direct {p0, p1, v0, v1}, Lcom/openfeint/internal/ui/WebViewCache;->copySpecific(Ljava/io/File;Ljava/lang/String;Ljava/util/Set;)V

    const-string v0, "webui/images/button.green.mdpi.png"

    invoke-direct {p0, p1, v0, v1}, Lcom/openfeint/internal/ui/WebViewCache;->copySpecific(Ljava/io/File;Ljava/lang/String;Ljava/util/Set;)V

    const-string v0, "webui/images/button.green.hit.mdpi.png"

    invoke-direct {p0, p1, v0, v1}, Lcom/openfeint/internal/ui/WebViewCache;->copySpecific(Ljava/io/File;Ljava/lang/String;Ljava/util/Set;)V

    const-string v0, "webui/images/logo.small.mdpi.png"

    invoke-direct {p0, p1, v0, v1}, Lcom/openfeint/internal/ui/WebViewCache;->copySpecific(Ljava/io/File;Ljava/lang/String;Ljava/util/Set;)V

    const-string v0, "webui/images/header_bg.mdpi.png"

    invoke-direct {p0, p1, v0, v1}, Lcom/openfeint/internal/ui/WebViewCache;->copySpecific(Ljava/io/File;Ljava/lang/String;Ljava/util/Set;)V

    const-string v0, "webui/images/loading.spinner.mdpi.png"

    invoke-direct {p0, p1, v0, v1}, Lcom/openfeint/internal/ui/WebViewCache;->copySpecific(Ljava/io/File;Ljava/lang/String;Ljava/util/Set;)V

    const-string v0, "webui/images/input.text.mdpi.png"

    invoke-direct {p0, p1, v0, v1}, Lcom/openfeint/internal/ui/WebViewCache;->copySpecific(Ljava/io/File;Ljava/lang/String;Ljava/util/Set;)V

    const-string v0, "webui/images/frame.small.mdpi.png"

    invoke-direct {p0, p1, v0, v1}, Lcom/openfeint/internal/ui/WebViewCache;->copySpecific(Ljava/io/File;Ljava/lang/String;Ljava/util/Set;)V

    const-string v0, "webui/images/icon.leaf.gray.mdpi.png"

    invoke-direct {p0, p1, v0, v1}, Lcom/openfeint/internal/ui/WebViewCache;->copySpecific(Ljava/io/File;Ljava/lang/String;Ljava/util/Set;)V

    const-string v0, "webui/images/tab.divider.mdpi.png"

    invoke-direct {p0, p1, v0, v1}, Lcom/openfeint/internal/ui/WebViewCache;->copySpecific(Ljava/io/File;Ljava/lang/String;Ljava/util/Set;)V

    const-string v0, "webui/images/tab.active_indicator.mdpi.png"

    invoke-direct {p0, p1, v0, v1}, Lcom/openfeint/internal/ui/WebViewCache;->copySpecific(Ljava/io/File;Ljava/lang/String;Ljava/util/Set;)V

    const-string v0, "webui/images/logo.mdpi.png"

    invoke-direct {p0, p1, v0, v1}, Lcom/openfeint/internal/ui/WebViewCache;->copySpecific(Ljava/io/File;Ljava/lang/String;Ljava/util/Set;)V

    const-string v0, "webui/images/header_bg.mdpi.png"

    invoke-direct {p0, p1, v0, v1}, Lcom/openfeint/internal/ui/WebViewCache;->copySpecific(Ljava/io/File;Ljava/lang/String;Ljava/util/Set;)V

    const-string v0, "webui/images/loading.spinner.mdpi.png"

    invoke-direct {p0, p1, v0, v1}, Lcom/openfeint/internal/ui/WebViewCache;->copySpecific(Ljava/io/File;Ljava/lang/String;Ljava/util/Set;)V

    const-string v0, "webui/images/icon.user.male.mdpi.png"

    invoke-direct {p0, p1, v0, v1}, Lcom/openfeint/internal/ui/WebViewCache;->copySpecific(Ljava/io/File;Ljava/lang/String;Ljava/util/Set;)V

    const-string v0, "webui/images/intro.leaderboards.mdpi.png"

    invoke-direct {p0, p1, v0, v1}, Lcom/openfeint/internal/ui/WebViewCache;->copySpecific(Ljava/io/File;Ljava/lang/String;Ljava/util/Set;)V

    const-string v0, "webui/images/intro.friends.mdpi.png"

    invoke-direct {p0, p1, v0, v1}, Lcom/openfeint/internal/ui/WebViewCache;->copySpecific(Ljava/io/File;Ljava/lang/String;Ljava/util/Set;)V

    const-string v0, "webui/images/intro.achievements.mdpi.png"

    invoke-direct {p0, p1, v0, v1}, Lcom/openfeint/internal/ui/WebViewCache;->copySpecific(Ljava/io/File;Ljava/lang/String;Ljava/util/Set;)V

    const-string v0, "webui/images/intro.games.mdpi.png"

    invoke-direct {p0, p1, v0, v1}, Lcom/openfeint/internal/ui/WebViewCache;->copySpecific(Ljava/io/File;Ljava/lang/String;Ljava/util/Set;)V

    :goto_0
    invoke-static {}, Lcom/openfeint/internal/OpenFeintInternal;->getInstance()Lcom/openfeint/internal/OpenFeintInternal;

    move-result-object v0

    invoke-virtual {v0}, Lcom/openfeint/internal/OpenFeintInternal;->getSettings()Ljava/util/Map;

    move-result-object v0

    const-string v2, "com.openfeint.internal.InternalSettings.WebUIDelayUntilCopyFinished"

    invoke-interface {v0, v2}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    if-eqz v0, :cond_1

    const/4 v0, 0x1

    :goto_1
    if-eqz v0, :cond_4

    invoke-interface {v1}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_2
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_2

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    invoke-direct {p0, p1, v0}, Lcom/openfeint/internal/ui/WebViewCache;->copySingleItem(Ljava/io/File;Ljava/lang/String;)V

    goto :goto_2

    :cond_0
    const-string v0, "webui/images/space.grid.hdpi.png"

    invoke-direct {p0, p1, v0, v1}, Lcom/openfeint/internal/ui/WebViewCache;->copySpecific(Ljava/io/File;Ljava/lang/String;Ljava/util/Set;)V

    const-string v0, "webui/images/button.gray.hdpi.png"

    invoke-direct {p0, p1, v0, v1}, Lcom/openfeint/internal/ui/WebViewCache;->copySpecific(Ljava/io/File;Ljava/lang/String;Ljava/util/Set;)V

    const-string v0, "webui/images/button.gray.hit.hdpi.png"

    invoke-direct {p0, p1, v0, v1}, Lcom/openfeint/internal/ui/WebViewCache;->copySpecific(Ljava/io/File;Ljava/lang/String;Ljava/util/Set;)V

    const-string v0, "webui/images/button.green.hdpi.png"

    invoke-direct {p0, p1, v0, v1}, Lcom/openfeint/internal/ui/WebViewCache;->copySpecific(Ljava/io/File;Ljava/lang/String;Ljava/util/Set;)V

    const-string v0, "webui/images/button.green.hit.hdpi.png"

    invoke-direct {p0, p1, v0, v1}, Lcom/openfeint/internal/ui/WebViewCache;->copySpecific(Ljava/io/File;Ljava/lang/String;Ljava/util/Set;)V

    const-string v0, "webui/images/logo.small.hdpi.png"

    invoke-direct {p0, p1, v0, v1}, Lcom/openfeint/internal/ui/WebViewCache;->copySpecific(Ljava/io/File;Ljava/lang/String;Ljava/util/Set;)V

    const-string v0, "webui/images/header_bg.hdpi.png"

    invoke-direct {p0, p1, v0, v1}, Lcom/openfeint/internal/ui/WebViewCache;->copySpecific(Ljava/io/File;Ljava/lang/String;Ljava/util/Set;)V

    const-string v0, "webui/images/loading.spinner.hdpi.png"

    invoke-direct {p0, p1, v0, v1}, Lcom/openfeint/internal/ui/WebViewCache;->copySpecific(Ljava/io/File;Ljava/lang/String;Ljava/util/Set;)V

    const-string v0, "webui/images/input.text.hdpi.png"

    invoke-direct {p0, p1, v0, v1}, Lcom/openfeint/internal/ui/WebViewCache;->copySpecific(Ljava/io/File;Ljava/lang/String;Ljava/util/Set;)V

    const-string v0, "webui/images/frame.small.hdpi.png"

    invoke-direct {p0, p1, v0, v1}, Lcom/openfeint/internal/ui/WebViewCache;->copySpecific(Ljava/io/File;Ljava/lang/String;Ljava/util/Set;)V

    const-string v0, "webui/images/icon.leaf.gray.hdpi.png"

    invoke-direct {p0, p1, v0, v1}, Lcom/openfeint/internal/ui/WebViewCache;->copySpecific(Ljava/io/File;Ljava/lang/String;Ljava/util/Set;)V

    const-string v0, "webui/images/tab.divider.hdpi.png"

    invoke-direct {p0, p1, v0, v1}, Lcom/openfeint/internal/ui/WebViewCache;->copySpecific(Ljava/io/File;Ljava/lang/String;Ljava/util/Set;)V

    const-string v0, "webui/images/tab.active_indicator.hdpi.png"

    invoke-direct {p0, p1, v0, v1}, Lcom/openfeint/internal/ui/WebViewCache;->copySpecific(Ljava/io/File;Ljava/lang/String;Ljava/util/Set;)V

    const-string v0, "webui/images/logo.hdpi.png"

    invoke-direct {p0, p1, v0, v1}, Lcom/openfeint/internal/ui/WebViewCache;->copySpecific(Ljava/io/File;Ljava/lang/String;Ljava/util/Set;)V

    const-string v0, "webui/images/header_bg.hdpi.png"

    invoke-direct {p0, p1, v0, v1}, Lcom/openfeint/internal/ui/WebViewCache;->copySpecific(Ljava/io/File;Ljava/lang/String;Ljava/util/Set;)V

    const-string v0, "webui/images/loading.spinner.hdpi.png"

    invoke-direct {p0, p1, v0, v1}, Lcom/openfeint/internal/ui/WebViewCache;->copySpecific(Ljava/io/File;Ljava/lang/String;Ljava/util/Set;)V

    const-string v0, "webui/images/icon.user.male.hdpi.png"

    invoke-direct {p0, p1, v0, v1}, Lcom/openfeint/internal/ui/WebViewCache;->copySpecific(Ljava/io/File;Ljava/lang/String;Ljava/util/Set;)V

    const-string v0, "webui/images/intro.leaderboards.hdpi.png"

    invoke-direct {p0, p1, v0, v1}, Lcom/openfeint/internal/ui/WebViewCache;->copySpecific(Ljava/io/File;Ljava/lang/String;Ljava/util/Set;)V

    const-string v0, "webui/images/intro.friends.hdpi.png"

    invoke-direct {p0, p1, v0, v1}, Lcom/openfeint/internal/ui/WebViewCache;->copySpecific(Ljava/io/File;Ljava/lang/String;Ljava/util/Set;)V

    const-string v0, "webui/images/intro.achievements.hdpi.png"

    invoke-direct {p0, p1, v0, v1}, Lcom/openfeint/internal/ui/WebViewCache;->copySpecific(Ljava/io/File;Ljava/lang/String;Ljava/util/Set;)V

    const-string v0, "webui/images/intro.games.hdpi.png"

    invoke-direct {p0, p1, v0, v1}, Lcom/openfeint/internal/ui/WebViewCache;->copySpecific(Ljava/io/File;Ljava/lang/String;Ljava/util/Set;)V

    goto/16 :goto_0

    :cond_1
    const/4 v0, 0x0

    goto/16 :goto_1

    :cond_2
    invoke-direct {p0}, Lcom/openfeint/internal/ui/WebViewCache;->clientManifestReady()V

    :cond_3
    return-void

    :cond_4
    invoke-direct {p0}, Lcom/openfeint/internal/ui/WebViewCache;->clientManifestReady()V

    invoke-interface {v1}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_3
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_3

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    invoke-direct {p0, p1, v0}, Lcom/openfeint/internal/ui/WebViewCache;->copySingleItem(Ljava/io/File;Ljava/lang/String;)V

    goto :goto_3
.end method

.method static synthetic access$300(Lcom/openfeint/internal/ui/WebViewCache;)V
    .locals 5

    const-string v0, "WebViewCache"

    const-string v1, "loadedManifest"

    invoke-static {v0, v1}, Lcom/openfeint/internal/logcat/OFLog;->i(Ljava/lang/String;Ljava/lang/String;)V

    iget-object v0, p0, Lcom/openfeint/internal/ui/WebViewCache;->serverManifest:Lcom/openfeint/internal/ui/WebViewCache$ManifestData;

    if-eqz v0, :cond_3

    iget-object v0, p0, Lcom/openfeint/internal/ui/WebViewCache;->clientManifest:Ljava/util/Map;

    if-eqz v0, :cond_3

    iget-object v0, p0, Lcom/openfeint/internal/ui/WebViewCache;->serverManifest:Lcom/openfeint/internal/ui/WebViewCache$ManifestData;

    iget-object v0, v0, Lcom/openfeint/internal/ui/WebViewCache$ManifestData;->objects:Ljava/util/Map;

    invoke-interface {v0}, Ljava/util/Map;->values()Ljava/util/Collection;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :cond_0
    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/openfeint/internal/ui/WebViewCache$ManifestItem;

    iget-object v2, v0, Lcom/openfeint/internal/ui/WebViewCache$ManifestItem;->hash:Ljava/lang/String;

    iget-object v3, p0, Lcom/openfeint/internal/ui/WebViewCache;->clientManifest:Ljava/util/Map;

    iget-object v4, v0, Lcom/openfeint/internal/ui/WebViewCache$ManifestItem;->path:Ljava/lang/String;

    invoke-interface {v3, v4}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_0

    iget-object v2, p0, Lcom/openfeint/internal/ui/WebViewCache;->pathsToLoad:Ljava/util/Set;

    iget-object v0, v0, Lcom/openfeint/internal/ui/WebViewCache$ManifestItem;->path:Ljava/lang/String;

    invoke-interface {v2, v0}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    goto :goto_0

    :cond_1
    invoke-direct {p0}, Lcom/openfeint/internal/ui/WebViewCache;->loadNextItem()V

    :cond_2
    :goto_1
    return-void

    :cond_3
    iget-object v0, p0, Lcom/openfeint/internal/ui/WebViewCache;->clientManifest:Ljava/util/Map;

    if-eqz v0, :cond_2

    iget-boolean v0, p0, Lcom/openfeint/internal/ui/WebViewCache;->finishWhenClientManifestDone:Z

    if-eqz v0, :cond_2

    invoke-direct {p0}, Lcom/openfeint/internal/ui/WebViewCache;->finishWithoutLoading()V

    goto :goto_1
.end method

.method static synthetic access$400(Lcom/openfeint/internal/ui/WebViewCache;Ljava/lang/String;Z)V
    .locals 2

    const/4 v1, 0x1

    new-instance v0, Ljava/util/HashSet;

    invoke-direct {v0, v1}, Ljava/util/HashSet;-><init>(I)V

    invoke-virtual {v0, p1}, Ljava/util/HashSet;->add(Ljava/lang/Object;)Z

    invoke-direct {p0, v0, p2, v1}, Lcom/openfeint/internal/ui/WebViewCache;->finishItems(Ljava/util/Set;ZZ)V

    return-void
.end method

.method static synthetic access$500(Lcom/openfeint/internal/ui/WebViewCache;Ljava/util/Set;Z)V
    .locals 1

    const/4 v0, 0x0

    invoke-direct {p0, p1, p2, v0}, Lcom/openfeint/internal/ui/WebViewCache;->finishItems(Ljava/util/Set;ZZ)V

    return-void
.end method

.method static synthetic access$600(Lcom/openfeint/internal/ui/WebViewCache;)V
    .locals 0

    invoke-direct {p0}, Lcom/openfeint/internal/ui/WebViewCache;->finishWithoutLoading()V

    return-void
.end method

.method static synthetic access$700(Landroid/content/Context;)Ljava/lang/String;
    .locals 5

    sget-object v0, Lcom/openfeint/internal/ui/WebViewCache;->manifestProductOverride:Ljava/lang/String;

    if-eqz v0, :cond_0

    sget-object v0, Lcom/openfeint/internal/ui/WebViewCache;->manifestProductOverride:Ljava/lang/String;

    :goto_0
    const-string v1, "/webui/manifest/%s.%s.%s"

    const/4 v2, 0x3

    new-array v2, v2, [Ljava/lang/Object;

    const/4 v3, 0x0

    const-string v4, "android"

    aput-object v4, v2, v3

    const/4 v3, 0x1

    aput-object v0, v2, v3

    const/4 v0, 0x2

    invoke-static {p0}, Lcom/openfeint/internal/Util;->getDpiName(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v3

    aput-object v3, v2, v0

    invoke-static {v1, v2}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    return-object v0

    :cond_0
    const-string v0, "embed"

    goto :goto_0
.end method

.method private batchFetch(Ljava/lang/String;Ljava/lang/String;ILjava/util/Set;)V
    .locals 6
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "I",
            "Ljava/util/Set",
            "<",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    new-instance v0, Lcom/openfeint/internal/ui/WebViewCache$4;

    move-object v1, p0

    move-object v2, p1

    move-object v3, p2

    move v4, p3

    move-object v5, p4

    invoke-direct/range {v0 .. v5}, Lcom/openfeint/internal/ui/WebViewCache$4;-><init>(Lcom/openfeint/internal/ui/WebViewCache;Ljava/lang/String;Ljava/lang/String;ILjava/util/Set;)V

    invoke-virtual {v0}, Lcom/openfeint/internal/ui/WebViewCache$4;->launch()V

    return-void
.end method

.method private batchRequest(Ljava/util/Set;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Set",
            "<",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    const/4 v0, 0x3

    invoke-direct {p0, p1, v0}, Lcom/openfeint/internal/ui/WebViewCache;->batchRequest(Ljava/util/Set;I)V

    return-void
.end method

.method private batchRequest(Ljava/util/Set;I)V
    .locals 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Set",
            "<",
            "Ljava/lang/String;",
            ">;I)V"
        }
    .end annotation

    const-string v0, "WebViewCache"

    const-string v1, "Syncing %d items"

    const/4 v2, 0x1

    new-array v2, v2, [Ljava/lang/Object;

    const/4 v3, 0x0

    invoke-interface {p1}, Ljava/util/Set;->size()I

    move-result v4

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    aput-object v4, v2, v3

    invoke-static {v1, v2}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/openfeint/internal/logcat/OFLog;->i(Ljava/lang/String;Ljava/lang/String;)V

    new-instance v1, Lcom/openfeint/internal/request/OrderedArgList;

    invoke-direct {v1}, Lcom/openfeint/internal/request/OrderedArgList;-><init>()V

    invoke-interface {p1}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    iget-object v3, p0, Lcom/openfeint/internal/ui/WebViewCache;->serverManifest:Lcom/openfeint/internal/ui/WebViewCache$ManifestData;

    iget-object v3, v3, Lcom/openfeint/internal/ui/WebViewCache$ManifestData;->objects:Ljava/util/Map;

    invoke-interface {v3, v0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/openfeint/internal/ui/WebViewCache$ManifestItem;

    const-string v3, "files[][path]"

    iget-object v4, v0, Lcom/openfeint/internal/ui/WebViewCache$ManifestItem;->path:Ljava/lang/String;

    invoke-virtual {v1, v3, v4}, Lcom/openfeint/internal/request/OrderedArgList;->put(Ljava/lang/String;Ljava/lang/String;)V

    const-string v3, "files[][hash]"

    iget-object v0, v0, Lcom/openfeint/internal/ui/WebViewCache$ManifestItem;->hash:Ljava/lang/String;

    invoke-virtual {v1, v3, v0}, Lcom/openfeint/internal/request/OrderedArgList;->put(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0

    :cond_0
    new-instance v0, Lcom/openfeint/internal/ui/WebViewCache$5;

    invoke-direct {v0, p0, v1, p2, p1}, Lcom/openfeint/internal/ui/WebViewCache$5;-><init>(Lcom/openfeint/internal/ui/WebViewCache;Lcom/openfeint/internal/request/OrderedArgList;ILjava/util/Set;)V

    invoke-virtual {v0}, Lcom/openfeint/internal/ui/WebViewCache$5;->launch()V

    return-void
.end method

.method private clientManifestReady()V
    .locals 3

    invoke-direct {p0}, Lcom/openfeint/internal/ui/WebViewCache;->getDefaultClientManifest()Ljava/util/Map;

    move-result-object v0

    iget-object v1, p0, Lcom/openfeint/internal/ui/WebViewCache;->mHandler:Landroid/os/Handler;

    const/4 v2, 0x3

    invoke-static {v1, v2}, Landroid/os/Message;->obtain(Landroid/os/Handler;I)Landroid/os/Message;

    move-result-object v1

    iput-object v0, v1, Landroid/os/Message;->obj:Ljava/lang/Object;

    invoke-virtual {v1}, Landroid/os/Message;->sendToTarget()V

    return-void
.end method

.method private copyDirectory(Ljava/io/File;Ljava/lang/String;Ljava/util/Set;)V
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/io/File;",
            "Ljava/lang/String;",
            "Ljava/util/Set",
            "<",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    new-instance v1, Ljava/util/HashSet;

    invoke-direct {v1}, Ljava/util/HashSet;-><init>()V

    invoke-interface {p3}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :cond_0
    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    invoke-virtual {v0, p2}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_0

    invoke-interface {v1, v0}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    goto :goto_0

    :cond_1
    invoke-interface {v1}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_1
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_2

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    invoke-direct {p0, p1, v0, p3}, Lcom/openfeint/internal/ui/WebViewCache;->copySpecific(Ljava/io/File;Ljava/lang/String;Ljava/util/Set;)V

    goto :goto_1

    :cond_2
    return-void
.end method

.method private copySingleItem(Ljava/io/File;Ljava/lang/String;)V
    .locals 3

    :try_start_0
    new-instance v0, Ljava/io/File;

    invoke-direct {v0, p1, p2}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    iget-object v1, p0, Lcom/openfeint/internal/ui/WebViewCache;->appContext:Landroid/content/Context;

    invoke-virtual {v1}, Landroid/content/Context;->getAssets()Landroid/content/res/AssetManager;

    move-result-object v1

    invoke-virtual {v1, p2}, Landroid/content/res/AssetManager;->open(Ljava/lang/String;)Ljava/io/InputStream;

    move-result-object v1

    new-instance v2, Ljava/io/DataInputStream;

    invoke-direct {v2, v1}, Ljava/io/DataInputStream;-><init>(Ljava/io/InputStream;)V

    invoke-virtual {v0}, Ljava/io/File;->getParentFile()Ljava/io/File;

    move-result-object v1

    invoke-virtual {v1}, Ljava/io/File;->mkdirs()Z

    new-instance v1, Ljava/io/FileOutputStream;

    invoke-direct {v1, v0}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V

    new-instance v0, Ljava/io/DataOutputStream;

    invoke-direct {v0, v1}, Ljava/io/DataOutputStream;-><init>(Ljava/io/OutputStream;)V

    invoke-static {v2, v0}, Lcom/openfeint/internal/Util;->copyStream(Ljava/io/InputStream;Ljava/io/OutputStream;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return-void

    :catch_0
    move-exception v0

    const-string v1, "WebViewCache"

    invoke-virtual {v0}, Ljava/lang/Exception;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v1, v0}, Lcom/openfeint/internal/logcat/OFLog;->e(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0
.end method

.method private copySpecific(Ljava/io/File;Ljava/lang/String;Ljava/util/Set;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/io/File;",
            "Ljava/lang/String;",
            "Ljava/util/Set",
            "<",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    invoke-interface {p3, p2}, Ljava/util/Set;->contains(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-direct {p0, p1, p2}, Lcom/openfeint/internal/ui/WebViewCache;->copySingleItem(Ljava/io/File;Ljava/lang/String;)V

    invoke-interface {p3, p2}, Ljava/util/Set;->remove(Ljava/lang/Object;)Z

    :cond_0
    return-void
.end method

.method private deleteAll()V
    .locals 3

    iget-object v0, p0, Lcom/openfeint/internal/ui/WebViewCache;->appContext:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getFilesDir()Ljava/io/File;

    move-result-object v0

    new-instance v1, Ljava/io/File;

    const-string v2, "webui"

    invoke-direct {v1, v0, v2}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    invoke-static {v1}, Lcom/openfeint/internal/Util;->deleteFiles(Ljava/io/File;)V

    iget-object v0, p0, Lcom/openfeint/internal/ui/WebViewCache;->appContext:Landroid/content/Context;

    const-string v1, "manifest.db"

    invoke-virtual {v0, v1}, Landroid/content/Context;->getDatabasePath(Ljava/lang/String;)Ljava/io/File;

    move-result-object v0

    invoke-virtual {v0}, Ljava/io/File;->delete()Z

    return-void
.end method

.method public static diskError()V
    .locals 2

    const/4 v0, 0x1

    sput-boolean v0, Lcom/openfeint/internal/ui/WebViewCache;->diskError:Z

    sget-object v0, Lcom/openfeint/internal/ui/WebViewCache;->sInstance:Lcom/openfeint/internal/ui/WebViewCache;

    iget-object v0, v0, Lcom/openfeint/internal/ui/WebViewCache;->trackedPaths:Ljava/util/Set;

    invoke-interface {v0}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/openfeint/internal/ui/WebViewCache$PathAndCallback;

    iget-object v0, v0, Lcom/openfeint/internal/ui/WebViewCache$PathAndCallback;->callback:Lcom/openfeint/internal/ui/WebViewCacheCallback;

    invoke-virtual {v0}, Lcom/openfeint/internal/ui/WebViewCacheCallback;->failLoaded()V

    goto :goto_0

    :cond_0
    sget-object v0, Lcom/openfeint/internal/ui/WebViewCache;->sInstance:Lcom/openfeint/internal/ui/WebViewCache;

    iget-object v0, v0, Lcom/openfeint/internal/ui/WebViewCache;->trackedPaths:Ljava/util/Set;

    invoke-interface {v0}, Ljava/util/Set;->clear()V

    sget-object v0, Lcom/openfeint/internal/ui/WebViewCache;->sInstance:Lcom/openfeint/internal/ui/WebViewCache;

    invoke-direct {v0}, Lcom/openfeint/internal/ui/WebViewCache;->finishWithoutLoading()V

    return-void
.end method

.method private finishItems(Ljava/util/Set;ZZ)V
    .locals 7
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Set",
            "<",
            "Ljava/lang/String;",
            ">;ZZ)V"
        }
    .end annotation

    iget-object v0, p0, Lcom/openfeint/internal/ui/WebViewCache;->serverManifest:Lcom/openfeint/internal/ui/WebViewCache$ManifestData;

    if-nez v0, :cond_0

    :goto_0
    return-void

    :cond_0
    if-nez p2, :cond_1

    if-nez p3, :cond_1

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/openfeint/internal/ui/WebViewCache;->batchesAreBroken:Z

    :goto_1
    invoke-direct {p0}, Lcom/openfeint/internal/ui/WebViewCache;->loadNextItem()V

    goto :goto_0

    :cond_1
    iget-object v0, p0, Lcom/openfeint/internal/ui/WebViewCache;->trackedItems:Ljava/util/Map;

    invoke-interface {v0}, Ljava/util/Map;->values()Ljava/util/Collection;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_2
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_2

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/openfeint/internal/ui/WebViewCache$ItemAndCallback;

    iget-object v0, v0, Lcom/openfeint/internal/ui/WebViewCache$ItemAndCallback;->item:Lcom/openfeint/internal/ui/WebViewCache$ManifestItem;

    iget-object v0, v0, Lcom/openfeint/internal/ui/WebViewCache$ManifestItem;->dependentObjects:Ljava/util/Set;

    invoke-interface {v0, p1}, Ljava/util/Set;->removeAll(Ljava/util/Collection;)Z

    goto :goto_2

    :cond_2
    iget-object v0, p0, Lcom/openfeint/internal/ui/WebViewCache;->pathsToLoad:Ljava/util/Set;

    invoke-interface {v0, p1}, Ljava/util/Set;->removeAll(Ljava/util/Collection;)Z

    iget-object v0, p0, Lcom/openfeint/internal/ui/WebViewCache;->serverManifest:Lcom/openfeint/internal/ui/WebViewCache$ManifestData;

    iget-object v0, v0, Lcom/openfeint/internal/ui/WebViewCache$ManifestData;->globals:Ljava/util/Set;

    invoke-interface {v0, p1}, Ljava/util/Set;->removeAll(Ljava/util/Collection;)Z

    iget-object v0, p0, Lcom/openfeint/internal/ui/WebViewCache;->prioritizedPaths:Ljava/util/Set;

    invoke-interface {v0, p1}, Ljava/util/Set;->removeAll(Ljava/util/Collection;)Z

    iget-boolean v0, p0, Lcom/openfeint/internal/ui/WebViewCache;->globalsFinished:Z

    if-eqz v0, :cond_5

    new-instance v1, Ljava/util/HashSet;

    invoke-direct {v1}, Ljava/util/HashSet;-><init>()V

    iget-object v0, p0, Lcom/openfeint/internal/ui/WebViewCache;->trackedItems:Ljava/util/Map;

    invoke-interface {v0}, Ljava/util/Map;->values()Ljava/util/Collection;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :cond_3
    :goto_3
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_4

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/openfeint/internal/ui/WebViewCache$ItemAndCallback;

    iget-object v3, p0, Lcom/openfeint/internal/ui/WebViewCache;->pathsToLoad:Ljava/util/Set;

    iget-object v4, v0, Lcom/openfeint/internal/ui/WebViewCache$ItemAndCallback;->item:Lcom/openfeint/internal/ui/WebViewCache$ManifestItem;

    iget-object v4, v4, Lcom/openfeint/internal/ui/WebViewCache$ManifestItem;->path:Ljava/lang/String;

    invoke-interface {v3, v4}, Ljava/util/Set;->contains(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_3

    iget-object v3, v0, Lcom/openfeint/internal/ui/WebViewCache$ItemAndCallback;->item:Lcom/openfeint/internal/ui/WebViewCache$ManifestItem;

    iget-object v3, v3, Lcom/openfeint/internal/ui/WebViewCache$ManifestItem;->dependentObjects:Ljava/util/Set;

    invoke-interface {v3}, Ljava/util/Set;->size()I

    move-result v3

    if-nez v3, :cond_3

    iget-object v3, v0, Lcom/openfeint/internal/ui/WebViewCache$ItemAndCallback;->item:Lcom/openfeint/internal/ui/WebViewCache$ManifestItem;

    iget-object v3, v3, Lcom/openfeint/internal/ui/WebViewCache$ManifestItem;->path:Ljava/lang/String;

    invoke-virtual {v1, v3}, Ljava/util/HashSet;->add(Ljava/lang/Object;)Z

    iget-object v3, v0, Lcom/openfeint/internal/ui/WebViewCache$ItemAndCallback;->callback:Lcom/openfeint/internal/ui/WebViewCacheCallback;

    iget-object v0, v0, Lcom/openfeint/internal/ui/WebViewCache$ItemAndCallback;->item:Lcom/openfeint/internal/ui/WebViewCache$ManifestItem;

    iget-object v0, v0, Lcom/openfeint/internal/ui/WebViewCache$ManifestItem;->path:Ljava/lang/String;

    invoke-virtual {v3, v0}, Lcom/openfeint/internal/ui/WebViewCacheCallback;->pathLoaded(Ljava/lang/String;)V

    goto :goto_3

    :cond_4
    invoke-virtual {v1}, Ljava/util/HashSet;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_4
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_5

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    iget-object v2, p0, Lcom/openfeint/internal/ui/WebViewCache;->trackedItems:Ljava/util/Map;

    invoke-interface {v2, v0}, Ljava/util/Map;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_4

    :cond_5
    invoke-interface {p1}, Ljava/util/Set;->size()I

    move-result v0

    new-array v4, v0, [Ljava/lang/String;

    array-length v0, v4

    new-array v5, v0, [Ljava/lang/String;

    const/4 v0, 0x0

    invoke-interface {p1}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v6

    move v2, v0

    :goto_5
    invoke-interface {v6}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_7

    invoke-interface {v6}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    if-eqz p2, :cond_6

    iget-object v1, p0, Lcom/openfeint/internal/ui/WebViewCache;->serverManifest:Lcom/openfeint/internal/ui/WebViewCache$ManifestData;

    iget-object v1, v1, Lcom/openfeint/internal/ui/WebViewCache$ManifestData;->objects:Ljava/util/Map;

    invoke-interface {v1, v0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/openfeint/internal/ui/WebViewCache$ManifestItem;

    iget-object v1, v1, Lcom/openfeint/internal/ui/WebViewCache$ManifestItem;->hash:Ljava/lang/String;

    move-object v3, v1

    :goto_6
    aput-object v0, v4, v2

    aput-object v3, v5, v2

    add-int/lit8 v1, v2, 0x1

    iget-object v2, p0, Lcom/openfeint/internal/ui/WebViewCache;->clientManifest:Ljava/util/Map;

    invoke-interface {v2, v0, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    move v2, v1

    goto :goto_5

    :cond_6
    const-string v1, "INVALID"

    move-object v3, v1

    goto :goto_6

    :cond_7
    invoke-static {v4, v5}, Lcom/openfeint/internal/db/DB;->setClientManifestBatch([Ljava/lang/String;[Ljava/lang/String;)V

    goto/16 :goto_1
.end method

.method private finishLoading()V
    .locals 1

    sget-object v0, Lcom/openfeint/internal/db/DB;->storeHelper:Lcom/openfeint/internal/db/DB$DataStorageHelperX;

    invoke-virtual {v0}, Lcom/openfeint/internal/db/DB$DataStorageHelperX;->close()V

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/openfeint/internal/ui/WebViewCache;->loadingFinished:Z

    return-void
.end method

.method private finishWithoutLoading()V
    .locals 3

    const-string v0, "WebViewCache"

    const-string v1, "finishWithoutLoading"

    invoke-static {v0, v1}, Lcom/openfeint/internal/logcat/OFLog;->i(Ljava/lang/String;Ljava/lang/String;)V

    invoke-direct {p0}, Lcom/openfeint/internal/ui/WebViewCache;->finishLoading()V

    iget-object v0, p0, Lcom/openfeint/internal/ui/WebViewCache;->trackedPaths:Ljava/util/Set;

    invoke-interface {v0}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/openfeint/internal/ui/WebViewCache$PathAndCallback;

    iget-object v2, v0, Lcom/openfeint/internal/ui/WebViewCache$PathAndCallback;->callback:Lcom/openfeint/internal/ui/WebViewCacheCallback;

    iget-object v0, v0, Lcom/openfeint/internal/ui/WebViewCache$PathAndCallback;->path:Ljava/lang/String;

    invoke-virtual {v2, v0}, Lcom/openfeint/internal/ui/WebViewCacheCallback;->pathLoaded(Ljava/lang/String;)V

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lcom/openfeint/internal/ui/WebViewCache;->trackedPaths:Ljava/util/Set;

    invoke-interface {v0}, Ljava/util/Set;->clear()V

    iget-object v0, p0, Lcom/openfeint/internal/ui/WebViewCache;->prioritizedPaths:Ljava/util/Set;

    invoke-interface {v0}, Ljava/util/Set;->clear()V

    iget-object v0, p0, Lcom/openfeint/internal/ui/WebViewCache;->serverManifest:Lcom/openfeint/internal/ui/WebViewCache$ManifestData;

    if-nez v0, :cond_1

    :try_start_0
    new-instance v0, Lcom/openfeint/internal/ui/WebViewCache$ManifestData;

    const/4 v1, 0x0

    new-array v1, v1, [B

    invoke-direct {v0, v1}, Lcom/openfeint/internal/ui/WebViewCache$ManifestData;-><init>([B)V

    iput-object v0, p0, Lcom/openfeint/internal/ui/WebViewCache;->serverManifest:Lcom/openfeint/internal/ui/WebViewCache$ManifestData;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :cond_1
    :goto_1
    iget-object v0, p0, Lcom/openfeint/internal/ui/WebViewCache;->serverManifest:Lcom/openfeint/internal/ui/WebViewCache$ManifestData;

    iget-object v0, v0, Lcom/openfeint/internal/ui/WebViewCache$ManifestData;->globals:Ljava/util/Set;

    invoke-interface {v0}, Ljava/util/Set;->clear()V

    iget-object v0, p0, Lcom/openfeint/internal/ui/WebViewCache;->pathsToLoad:Ljava/util/Set;

    invoke-interface {v0}, Ljava/util/Set;->clear()V

    return-void

    :catch_0
    move-exception v0

    goto :goto_1
.end method

.method private gatherDefaultItems(Ljava/lang/String;Ljava/util/Set;)V
    .locals 6
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/util/Set",
            "<",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    :try_start_0
    iget-object v0, p0, Lcom/openfeint/internal/ui/WebViewCache;->appContext:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getAssets()Landroid/content/res/AssetManager;

    move-result-object v0

    invoke-virtual {v0, p1}, Landroid/content/res/AssetManager;->list(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v1

    array-length v2, v1

    const/4 v0, 0x0

    :goto_0
    if-ge v0, v2, :cond_0

    aget-object v3, v1, v0

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v4, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "/"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_1

    move-result-object v3

    :try_start_1
    iget-object v4, p0, Lcom/openfeint/internal/ui/WebViewCache;->appContext:Landroid/content/Context;

    invoke-virtual {v4}, Landroid/content/Context;->getAssets()Landroid/content/res/AssetManager;

    move-result-object v4

    invoke-virtual {v4, v3}, Landroid/content/res/AssetManager;->open(Ljava/lang/String;)Ljava/io/InputStream;

    move-result-object v4

    invoke-interface {p2, v3}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    invoke-virtual {v4}, Ljava/io/InputStream;->close()V
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_0

    :goto_1
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :catch_0
    move-exception v4

    :try_start_2
    invoke-direct {p0, v3, p2}, Lcom/openfeint/internal/ui/WebViewCache;->gatherDefaultItems(Ljava/lang/String;Ljava/util/Set;)V
    :try_end_2
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_1

    goto :goto_1

    :catch_1
    move-exception v0

    const-string v1, "WebViewCache"

    invoke-virtual {v0}, Ljava/io/IOException;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v1, v0}, Lcom/openfeint/internal/logcat/OFLog;->e(Ljava/lang/String;Ljava/lang/String;)V

    :cond_0
    return-void
.end method

.method private getDefaultClientManifest()Ljava/util/Map;
    .locals 6
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/Map",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    const/4 v0, 0x0

    :try_start_0
    sget-object v1, Lcom/openfeint/internal/db/DB;->storeHelper:Lcom/openfeint/internal/db/DB$DataStorageHelperX;

    invoke-virtual {v1}, Lcom/openfeint/internal/db/DB$DataStorageHelperX;->getReadableDatabase()Landroid/database/sqlite/SQLiteDatabase;

    move-result-object v1

    const-string v2, "SELECT * FROM manifest"

    const/4 v3, 0x0

    invoke-virtual {v1, v2, v3}, Landroid/database/sqlite/SQLiteDatabase;->rawQuery(Ljava/lang/String;[Ljava/lang/String;)Landroid/database/Cursor;
    :try_end_0
    .catch Landroid/database/sqlite/SQLiteDiskIOException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_2
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result-object v1

    :try_start_1
    invoke-interface {v1}, Landroid/database/Cursor;->getCount()I

    move-result v0

    if-lez v0, :cond_1

    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    invoke-interface {v1}, Landroid/database/Cursor;->moveToFirst()Z

    :cond_0
    const/4 v2, 0x0

    invoke-interface {v1, v2}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v2

    const/4 v3, 0x1

    invoke-interface {v1, v3}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v3

    invoke-interface {v0, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    invoke-interface {v1}, Landroid/database/Cursor;->moveToNext()Z

    move-result v2

    if-nez v2, :cond_0

    invoke-interface {v1}, Landroid/database/Cursor;->close()V

    const-string v2, "WebViewCache"

    const-string v3, "create client Manifest from db"

    invoke-static {v2, v3}, Lcom/openfeint/internal/logcat/OFLog;->i(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_1
    .catch Landroid/database/sqlite/SQLiteDiskIOException; {:try_start_1 .. :try_end_1} :catch_8
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_7
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    :try_start_2
    invoke-interface {v1}, Landroid/database/Cursor;->close()V
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_4

    :goto_0
    return-object v0

    :cond_1
    :try_start_3
    invoke-interface {v1}, Landroid/database/Cursor;->close()V
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_5

    :goto_1
    invoke-direct {p0}, Lcom/openfeint/internal/ui/WebViewCache;->getDefaultClientManifestFromAsset()Ljava/util/Map;

    move-result-object v0

    goto :goto_0

    :catch_0
    move-exception v1

    :goto_2
    :try_start_4
    invoke-static {}, Lcom/openfeint/internal/ui/WebViewCache;->diskError()V
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_2

    :try_start_5
    invoke-interface {v0}, Landroid/database/Cursor;->close()V
    :try_end_5
    .catch Ljava/lang/Exception; {:try_start_5 .. :try_end_5} :catch_1

    goto :goto_1

    :catch_1
    move-exception v0

    goto :goto_1

    :catch_2
    move-exception v1

    move-object v5, v1

    move-object v1, v0

    move-object v0, v5

    :goto_3
    :try_start_6
    const-string v2, "WebViewCache"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "SQLite exception. "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v0}, Ljava/lang/Exception;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v2, v0}, Lcom/openfeint/internal/logcat/OFLog;->e(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_1

    :try_start_7
    invoke-interface {v1}, Landroid/database/Cursor;->close()V
    :try_end_7
    .catch Ljava/lang/Exception; {:try_start_7 .. :try_end_7} :catch_3

    goto :goto_1

    :catch_3
    move-exception v0

    goto :goto_1

    :catchall_0
    move-exception v1

    move-object v5, v1

    move-object v1, v0

    move-object v0, v5

    :goto_4
    :try_start_8
    invoke-interface {v1}, Landroid/database/Cursor;->close()V
    :try_end_8
    .catch Ljava/lang/Exception; {:try_start_8 .. :try_end_8} :catch_6

    :goto_5
    throw v0

    :catch_4
    move-exception v1

    goto :goto_0

    :catch_5
    move-exception v0

    goto :goto_1

    :catch_6
    move-exception v1

    goto :goto_5

    :catchall_1
    move-exception v0

    goto :goto_4

    :catchall_2
    move-exception v1

    move-object v5, v1

    move-object v1, v0

    move-object v0, v5

    goto :goto_4

    :catch_7
    move-exception v0

    goto :goto_3

    :catch_8
    move-exception v0

    move-object v0, v1

    goto :goto_2
.end method

.method private getDefaultClientManifestFromAsset()Ljava/util/Map;
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/Map",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    new-instance v0, Ljava/io/File;

    sget-object v1, Lcom/openfeint/internal/ui/WebViewCache;->rootPath:Ljava/lang/String;

    const-string v2, "manifest.plist"

    invoke-direct {v0, v1, v2}, Ljava/io/File;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {v0}, Ljava/io/File;->isFile()Z

    move-result v1

    if-eqz v1, :cond_0

    :try_start_0
    invoke-static {}, Ljavax/xml/parsers/SAXParserFactory;->newInstance()Ljavax/xml/parsers/SAXParserFactory;

    move-result-object v1

    invoke-virtual {v1}, Ljavax/xml/parsers/SAXParserFactory;->newSAXParser()Ljavax/xml/parsers/SAXParser;

    move-result-object v1

    invoke-virtual {v1}, Ljavax/xml/parsers/SAXParser;->getXMLReader()Lorg/xml/sax/XMLReader;

    move-result-object v1

    new-instance v2, Lcom/openfeint/internal/ui/WebViewCache$SaxHandler;

    invoke-direct {v2, p0}, Lcom/openfeint/internal/ui/WebViewCache$SaxHandler;-><init>(Lcom/openfeint/internal/ui/WebViewCache;)V

    invoke-interface {v1, v2}, Lorg/xml/sax/XMLReader;->setContentHandler(Lorg/xml/sax/ContentHandler;)V

    new-instance v3, Ljava/io/FileInputStream;

    invoke-virtual {v0}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object v0

    invoke-direct {v3, v0}, Ljava/io/FileInputStream;-><init>(Ljava/lang/String;)V

    new-instance v0, Lorg/xml/sax/InputSource;

    invoke-direct {v0, v3}, Lorg/xml/sax/InputSource;-><init>(Ljava/io/InputStream;)V

    invoke-interface {v1, v0}, Lorg/xml/sax/XMLReader;->parse(Lorg/xml/sax/InputSource;)V

    invoke-virtual {v2}, Lcom/openfeint/internal/ui/WebViewCache$SaxHandler;->getOutputMap()Ljava/util/Map;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    :goto_0
    return-object v0

    :catch_0
    move-exception v0

    const-string v1, "WebViewCache"

    invoke-virtual {v0}, Ljava/lang/Exception;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v1, v0}, Lcom/openfeint/internal/logcat/OFLog;->e(Ljava/lang/String;Ljava/lang/String;)V

    :cond_0
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    goto :goto_0
.end method

.method public static final getItemUri(Ljava/lang/String;)Ljava/lang/String;
    .locals 2

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v1, Lcom/openfeint/internal/ui/WebViewCache;->rootUri:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method private static final getServerURI()Ljava/net/URI;
    .locals 2

    :try_start_0
    sget-object v0, Lcom/openfeint/internal/ui/WebViewCache;->serverOverride:Ljava/net/URI;

    if-eqz v0, :cond_0

    sget-object v0, Lcom/openfeint/internal/ui/WebViewCache;->serverOverride:Ljava/net/URI;

    :goto_0
    return-object v0

    :cond_0
    new-instance v0, Ljava/net/URI;

    invoke-static {}, Lcom/openfeint/internal/OpenFeintInternal;->getInstance()Lcom/openfeint/internal/OpenFeintInternal;

    move-result-object v1

    invoke-virtual {v1}, Lcom/openfeint/internal/OpenFeintInternal;->getServerUrl()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/net/URI;-><init>(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    const/4 v0, 0x0

    goto :goto_0
.end method

.method public static initialize(Landroid/content/Context;)Lcom/openfeint/internal/ui/WebViewCache;
    .locals 1

    sget-object v0, Lcom/openfeint/internal/ui/WebViewCache;->sInstance:Lcom/openfeint/internal/ui/WebViewCache;

    if-eqz v0, :cond_0

    sget-object v0, Lcom/openfeint/internal/ui/WebViewCache;->sInstance:Lcom/openfeint/internal/ui/WebViewCache;

    invoke-direct {v0}, Lcom/openfeint/internal/ui/WebViewCache;->finishWithoutLoading()V

    :cond_0
    new-instance v0, Lcom/openfeint/internal/ui/WebViewCache;

    invoke-direct {v0, p0}, Lcom/openfeint/internal/ui/WebViewCache;-><init>(Landroid/content/Context;)V

    sput-object v0, Lcom/openfeint/internal/ui/WebViewCache;->sInstance:Lcom/openfeint/internal/ui/WebViewCache;

    return-object v0
.end method

.method public static isDiskError()Z
    .locals 1

    sget-boolean v0, Lcom/openfeint/internal/ui/WebViewCache;->diskError:Z

    return v0
.end method

.method private loadNextItem()V
    .locals 7

    const/4 v6, 0x1

    const-string v0, "WebViewCache"

    const-string v1, "loadNextItem"

    invoke-static {v0, v1}, Lcom/openfeint/internal/logcat/OFLog;->i(Ljava/lang/String;Ljava/lang/String;)V

    iget-object v0, p0, Lcom/openfeint/internal/ui/WebViewCache;->serverManifest:Lcom/openfeint/internal/ui/WebViewCache$ManifestData;

    iget-object v0, v0, Lcom/openfeint/internal/ui/WebViewCache$ManifestData;->globals:Ljava/util/Set;

    iget-object v1, p0, Lcom/openfeint/internal/ui/WebViewCache;->pathsToLoad:Ljava/util/Set;

    invoke-interface {v0, v1}, Ljava/util/Set;->retainAll(Ljava/util/Collection;)Z

    iget-boolean v0, p0, Lcom/openfeint/internal/ui/WebViewCache;->globalsFinished:Z

    if-nez v0, :cond_4

    iget-object v0, p0, Lcom/openfeint/internal/ui/WebViewCache;->serverManifest:Lcom/openfeint/internal/ui/WebViewCache$ManifestData;

    iget-object v0, v0, Lcom/openfeint/internal/ui/WebViewCache$ManifestData;->globals:Ljava/util/Set;

    invoke-interface {v0}, Ljava/util/Set;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_4

    iget-object v0, p0, Lcom/openfeint/internal/ui/WebViewCache;->trackedPaths:Ljava/util/Set;

    invoke-interface {v0}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/openfeint/internal/ui/WebViewCache$PathAndCallback;

    iget-object v1, p0, Lcom/openfeint/internal/ui/WebViewCache;->pathsToLoad:Ljava/util/Set;

    iget-object v3, v0, Lcom/openfeint/internal/ui/WebViewCache$PathAndCallback;->path:Ljava/lang/String;

    invoke-interface {v1, v3}, Ljava/util/Set;->contains(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_0

    iget-object v1, v0, Lcom/openfeint/internal/ui/WebViewCache$PathAndCallback;->callback:Lcom/openfeint/internal/ui/WebViewCacheCallback;

    iget-object v0, v0, Lcom/openfeint/internal/ui/WebViewCache$PathAndCallback;->path:Ljava/lang/String;

    invoke-virtual {v1, v0}, Lcom/openfeint/internal/ui/WebViewCacheCallback;->pathLoaded(Ljava/lang/String;)V

    goto :goto_0

    :cond_0
    iget-object v1, p0, Lcom/openfeint/internal/ui/WebViewCache;->serverManifest:Lcom/openfeint/internal/ui/WebViewCache$ManifestData;

    iget-object v1, v1, Lcom/openfeint/internal/ui/WebViewCache$ManifestData;->objects:Ljava/util/Map;

    iget-object v3, v0, Lcom/openfeint/internal/ui/WebViewCache$PathAndCallback;->path:Ljava/lang/String;

    invoke-interface {v1, v3}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/openfeint/internal/ui/WebViewCache$ManifestItem;

    new-instance v3, Lcom/openfeint/internal/ui/WebViewCache$ManifestItem;

    invoke-direct {v3, v1}, Lcom/openfeint/internal/ui/WebViewCache$ManifestItem;-><init>(Lcom/openfeint/internal/ui/WebViewCache$ManifestItem;)V

    iget-object v1, v3, Lcom/openfeint/internal/ui/WebViewCache$ManifestItem;->dependentObjects:Ljava/util/Set;

    iget-object v4, p0, Lcom/openfeint/internal/ui/WebViewCache;->pathsToLoad:Ljava/util/Set;

    invoke-interface {v1, v4}, Ljava/util/Set;->retainAll(Ljava/util/Collection;)Z

    iget-object v1, p0, Lcom/openfeint/internal/ui/WebViewCache;->trackedItems:Ljava/util/Map;

    iget-object v4, v0, Lcom/openfeint/internal/ui/WebViewCache$PathAndCallback;->path:Ljava/lang/String;

    new-instance v5, Lcom/openfeint/internal/ui/WebViewCache$ItemAndCallback;

    iget-object v0, v0, Lcom/openfeint/internal/ui/WebViewCache$PathAndCallback;->callback:Lcom/openfeint/internal/ui/WebViewCacheCallback;

    invoke-direct {v5, v3, v0}, Lcom/openfeint/internal/ui/WebViewCache$ItemAndCallback;-><init>(Lcom/openfeint/internal/ui/WebViewCache$ManifestItem;Lcom/openfeint/internal/ui/WebViewCacheCallback;)V

    invoke-interface {v1, v4, v5}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_0

    :cond_1
    iget-object v0, p0, Lcom/openfeint/internal/ui/WebViewCache;->trackedPaths:Ljava/util/Set;

    invoke-interface {v0}, Ljava/util/Set;->clear()V

    new-instance v1, Ljava/util/HashSet;

    invoke-direct {v1}, Ljava/util/HashSet;-><init>()V

    iget-object v0, p0, Lcom/openfeint/internal/ui/WebViewCache;->prioritizedPaths:Ljava/util/Set;

    invoke-interface {v0}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :cond_2
    :goto_1
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_3

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    iget-object v3, p0, Lcom/openfeint/internal/ui/WebViewCache;->pathsToLoad:Ljava/util/Set;

    invoke-interface {v3, v0}, Ljava/util/Set;->contains(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_2

    iget-object v3, p0, Lcom/openfeint/internal/ui/WebViewCache;->serverManifest:Lcom/openfeint/internal/ui/WebViewCache$ManifestData;

    iget-object v3, v3, Lcom/openfeint/internal/ui/WebViewCache$ManifestData;->objects:Ljava/util/Map;

    invoke-interface {v3, v0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/openfeint/internal/ui/WebViewCache$ManifestItem;

    if-eqz v0, :cond_2

    iget-object v0, v0, Lcom/openfeint/internal/ui/WebViewCache$ManifestItem;->dependentObjects:Ljava/util/Set;

    invoke-interface {v1, v0}, Ljava/util/Set;->addAll(Ljava/util/Collection;)Z

    goto :goto_1

    :cond_3
    iget-object v0, p0, Lcom/openfeint/internal/ui/WebViewCache;->pathsToLoad:Ljava/util/Set;

    invoke-interface {v1, v0}, Ljava/util/Set;->retainAll(Ljava/util/Collection;)Z

    iget-object v0, p0, Lcom/openfeint/internal/ui/WebViewCache;->prioritizedPaths:Ljava/util/Set;

    invoke-interface {v0, v1}, Ljava/util/Set;->addAll(Ljava/util/Collection;)Z

    iput-boolean v6, p0, Lcom/openfeint/internal/ui/WebViewCache;->globalsFinished:Z

    :cond_4
    iget-object v0, p0, Lcom/openfeint/internal/ui/WebViewCache;->prioritizedPaths:Ljava/util/Set;

    iget-object v1, p0, Lcom/openfeint/internal/ui/WebViewCache;->pathsToLoad:Ljava/util/Set;

    invoke-interface {v0, v1}, Ljava/util/Set;->retainAll(Ljava/util/Collection;)Z

    iget-object v0, p0, Lcom/openfeint/internal/ui/WebViewCache;->serverManifest:Lcom/openfeint/internal/ui/WebViewCache$ManifestData;

    iget-object v0, v0, Lcom/openfeint/internal/ui/WebViewCache$ManifestData;->globals:Ljava/util/Set;

    invoke-interface {v0}, Ljava/util/Set;->size()I

    move-result v0

    iget-object v1, p0, Lcom/openfeint/internal/ui/WebViewCache;->prioritizedPaths:Ljava/util/Set;

    invoke-interface {v1}, Ljava/util/Set;->size()I

    move-result v1

    add-int/2addr v0, v1

    iget-boolean v1, p0, Lcom/openfeint/internal/ui/WebViewCache;->batchesAreBroken:Z

    if-nez v1, :cond_5

    if-le v0, v6, :cond_5

    new-instance v0, Ljava/util/HashSet;

    invoke-direct {v0}, Ljava/util/HashSet;-><init>()V

    iget-object v1, p0, Lcom/openfeint/internal/ui/WebViewCache;->serverManifest:Lcom/openfeint/internal/ui/WebViewCache$ManifestData;

    iget-object v1, v1, Lcom/openfeint/internal/ui/WebViewCache$ManifestData;->globals:Ljava/util/Set;

    invoke-interface {v0, v1}, Ljava/util/Set;->addAll(Ljava/util/Collection;)Z

    iget-object v1, p0, Lcom/openfeint/internal/ui/WebViewCache;->prioritizedPaths:Ljava/util/Set;

    invoke-interface {v0, v1}, Ljava/util/Set;->addAll(Ljava/util/Collection;)Z

    invoke-direct {p0, v0}, Lcom/openfeint/internal/ui/WebViewCache;->batchRequest(Ljava/util/Set;)V

    :goto_2
    return-void

    :cond_5
    iget-object v0, p0, Lcom/openfeint/internal/ui/WebViewCache;->serverManifest:Lcom/openfeint/internal/ui/WebViewCache$ManifestData;

    iget-object v0, v0, Lcom/openfeint/internal/ui/WebViewCache$ManifestData;->globals:Ljava/util/Set;

    invoke-interface {v0}, Ljava/util/Set;->size()I

    move-result v0

    if-lez v0, :cond_6

    iget-object v0, p0, Lcom/openfeint/internal/ui/WebViewCache;->serverManifest:Lcom/openfeint/internal/ui/WebViewCache$ManifestData;

    iget-object v0, v0, Lcom/openfeint/internal/ui/WebViewCache$ManifestData;->globals:Ljava/util/Set;

    invoke-interface {v0}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    invoke-direct {p0, v0}, Lcom/openfeint/internal/ui/WebViewCache;->singleRequest(Ljava/lang/String;)V

    goto :goto_2

    :cond_6
    iget-object v0, p0, Lcom/openfeint/internal/ui/WebViewCache;->prioritizedPaths:Ljava/util/Set;

    invoke-interface {v0}, Ljava/util/Set;->size()I

    move-result v0

    if-lez v0, :cond_7

    iget-object v0, p0, Lcom/openfeint/internal/ui/WebViewCache;->prioritizedPaths:Ljava/util/Set;

    invoke-interface {v0}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    invoke-direct {p0, v0}, Lcom/openfeint/internal/ui/WebViewCache;->singleRequest(Ljava/lang/String;)V

    goto :goto_2

    :cond_7
    iget-boolean v0, p0, Lcom/openfeint/internal/ui/WebViewCache;->batchesAreBroken:Z

    if-nez v0, :cond_8

    iget-object v0, p0, Lcom/openfeint/internal/ui/WebViewCache;->pathsToLoad:Ljava/util/Set;

    invoke-interface {v0}, Ljava/util/Set;->size()I

    move-result v0

    if-le v0, v6, :cond_8

    iget-object v0, p0, Lcom/openfeint/internal/ui/WebViewCache;->pathsToLoad:Ljava/util/Set;

    invoke-direct {p0, v0}, Lcom/openfeint/internal/ui/WebViewCache;->batchRequest(Ljava/util/Set;)V

    goto :goto_2

    :cond_8
    iget-object v0, p0, Lcom/openfeint/internal/ui/WebViewCache;->pathsToLoad:Ljava/util/Set;

    invoke-interface {v0}, Ljava/util/Set;->size()I

    move-result v0

    if-lez v0, :cond_9

    iget-object v0, p0, Lcom/openfeint/internal/ui/WebViewCache;->pathsToLoad:Ljava/util/Set;

    invoke-interface {v0}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    invoke-direct {p0, v0}, Lcom/openfeint/internal/ui/WebViewCache;->singleRequest(Ljava/lang/String;)V

    goto :goto_2

    :cond_9
    invoke-direct {p0}, Lcom/openfeint/internal/ui/WebViewCache;->finishLoading()V

    goto :goto_2
.end method

.method public static prioritize(Ljava/lang/String;)V
    .locals 4

    sget-object v1, Lcom/openfeint/internal/ui/WebViewCache;->sInstance:Lcom/openfeint/internal/ui/WebViewCache;

    iget-boolean v0, v1, Lcom/openfeint/internal/ui/WebViewCache;->loadingFinished:Z

    if-nez v0, :cond_0

    iget-object v0, v1, Lcom/openfeint/internal/ui/WebViewCache;->prioritizedPaths:Ljava/util/Set;

    invoke-interface {v0, p0}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    iget-object v0, v1, Lcom/openfeint/internal/ui/WebViewCache;->serverManifest:Lcom/openfeint/internal/ui/WebViewCache$ManifestData;

    if-eqz v0, :cond_0

    iget-object v0, v1, Lcom/openfeint/internal/ui/WebViewCache;->serverManifest:Lcom/openfeint/internal/ui/WebViewCache$ManifestData;

    iget-object v0, v0, Lcom/openfeint/internal/ui/WebViewCache$ManifestData;->objects:Ljava/util/Map;

    invoke-interface {v0, p0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/openfeint/internal/ui/WebViewCache$ManifestItem;

    if-eqz v0, :cond_0

    new-instance v2, Ljava/util/HashSet;

    iget-object v0, v0, Lcom/openfeint/internal/ui/WebViewCache$ManifestItem;->dependentObjects:Ljava/util/Set;

    invoke-direct {v2, v0}, Ljava/util/HashSet;-><init>(Ljava/util/Collection;)V

    iget-object v0, v1, Lcom/openfeint/internal/ui/WebViewCache;->pathsToLoad:Ljava/util/Set;

    invoke-interface {v2, v0}, Ljava/util/Set;->retainAll(Ljava/util/Collection;)Z

    iget-object v0, v1, Lcom/openfeint/internal/ui/WebViewCache;->prioritizedPaths:Ljava/util/Set;

    invoke-interface {v0, v2}, Ljava/util/Set;->addAll(Ljava/util/Collection;)Z

    const-string v0, "WebViewCache"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Prioritizing "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v3, " deps:"

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v2}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/openfeint/internal/logcat/OFLog;->i(Ljava/lang/String;Ljava/lang/String;)V

    :cond_0
    return-void
.end method

.method public static recover()Z
    .locals 4

    const/4 v1, 0x0

    sget-boolean v0, Lcom/openfeint/internal/ui/WebViewCache;->diskError:Z

    if-eqz v0, :cond_0

    :goto_0
    return v1

    :cond_0
    sget-object v2, Lcom/openfeint/internal/ui/WebViewCache;->sInstance:Lcom/openfeint/internal/ui/WebViewCache;

    iget-object v0, v2, Lcom/openfeint/internal/ui/WebViewCache;->appContext:Landroid/content/Context;

    invoke-static {v0}, Lcom/openfeint/internal/db/DB;->recover(Landroid/content/Context;)Z

    move-result v0

    const/4 v3, 0x0

    iput-object v3, v2, Lcom/openfeint/internal/ui/WebViewCache;->serverManifest:Lcom/openfeint/internal/ui/WebViewCache$ManifestData;

    if-eqz v0, :cond_1

    invoke-direct {v2}, Lcom/openfeint/internal/ui/WebViewCache;->getDefaultClientManifestFromAsset()Ljava/util/Map;

    move-result-object v0

    iput-object v0, v2, Lcom/openfeint/internal/ui/WebViewCache;->clientManifest:Ljava/util/Map;

    iget-object v0, v2, Lcom/openfeint/internal/ui/WebViewCache;->clientManifest:Ljava/util/Map;

    invoke-interface {v0}, Ljava/util/Map;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_2

    const/4 v0, 0x1

    :cond_1
    :goto_1
    iput-boolean v1, v2, Lcom/openfeint/internal/ui/WebViewCache;->loadingFinished:Z

    iput-boolean v1, v2, Lcom/openfeint/internal/ui/WebViewCache;->globalsFinished:Z

    iput-boolean v1, v2, Lcom/openfeint/internal/ui/WebViewCache;->finishWhenClientManifestDone:Z

    invoke-direct {v2}, Lcom/openfeint/internal/ui/WebViewCache;->sync()V

    move v1, v0

    goto :goto_0

    :cond_2
    move v0, v1

    goto :goto_1
.end method

.method private final singleRequest(Ljava/lang/String;)V
    .locals 3

    const-string v0, "WebViewCache"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Syncing item: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/openfeint/internal/logcat/OFLog;->i(Ljava/lang/String;Ljava/lang/String;)V

    new-instance v0, Lcom/openfeint/internal/ui/WebViewCache$7;

    invoke-direct {v0, p0, p1}, Lcom/openfeint/internal/ui/WebViewCache$7;-><init>(Lcom/openfeint/internal/ui/WebViewCache;Ljava/lang/String;)V

    invoke-virtual {v0}, Lcom/openfeint/internal/ui/WebViewCache$7;->launch()V

    return-void
.end method

.method public static start()V
    .locals 7

    sget-object v1, Lcom/openfeint/internal/ui/WebViewCache;->sInstance:Lcom/openfeint/internal/ui/WebViewCache;

    invoke-static {}, Lcom/openfeint/internal/Util;->noSdcardPermission()Z

    move-result v0

    if-eqz v0, :cond_0

    const-string v0, "WebViewCache"

    const-string v2, "no sdcard permission"

    invoke-static {v0, v2}, Lcom/openfeint/internal/logcat/OFLog;->e(Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {v1}, Lcom/openfeint/internal/ui/WebViewCache;->setRootUriInternal()V

    :goto_0
    sget-object v0, Lcom/openfeint/internal/ui/WebViewCache;->sInstance:Lcom/openfeint/internal/ui/WebViewCache;

    invoke-direct {v0}, Lcom/openfeint/internal/ui/WebViewCache;->sync()V

    return-void

    :cond_0
    invoke-static {}, Landroid/os/Environment;->getExternalStorageState()Ljava/lang/String;

    move-result-object v0

    const-string v2, "mounted"

    invoke-virtual {v2, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_5

    invoke-static {}, Landroid/os/Environment;->getExternalStorageDirectory()Ljava/io/File;

    move-result-object v0

    new-instance v2, Ljava/io/File;

    const-string v3, "openfeint"

    invoke-direct {v2, v0, v3}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    new-instance v3, Ljava/io/File;

    const-string v0, "webui"

    invoke-direct {v3, v2, v0}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    invoke-virtual {v3}, Ljava/io/File;->exists()Z

    move-result v0

    if-nez v0, :cond_1

    const/4 v0, 0x1

    :goto_1
    if-eqz v0, :cond_2

    new-instance v4, Ljava/io/File;

    const-string v5, ".nomedia"

    invoke-direct {v4, v2, v5}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    :try_start_0
    invoke-virtual {v4}, Ljava/io/File;->createNewFile()Z
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    :goto_2
    invoke-virtual {v3}, Ljava/io/File;->mkdirs()Z

    move-result v2

    if-nez v2, :cond_2

    invoke-virtual {v1}, Lcom/openfeint/internal/ui/WebViewCache;->setRootUriInternal()V

    goto :goto_0

    :cond_1
    const/4 v0, 0x0

    goto :goto_1

    :cond_2
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v4, "/"

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    sput-object v2, Lcom/openfeint/internal/ui/WebViewCache;->rootPath:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "file://"

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    sget-object v4, Lcom/openfeint/internal/ui/WebViewCache;->rootPath:Ljava/lang/String;

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    sput-object v2, Lcom/openfeint/internal/ui/WebViewCache;->rootUri:Ljava/lang/String;

    if-eqz v0, :cond_4

    iget-object v0, v1, Lcom/openfeint/internal/ui/WebViewCache;->appContext:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getFilesDir()Ljava/io/File;

    move-result-object v0

    new-instance v2, Ljava/io/File;

    const-string v4, "webui"

    invoke-direct {v2, v0, v4}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    invoke-virtual {v2}, Ljava/io/File;->isDirectory()Z

    move-result v4

    if-eqz v4, :cond_3

    :try_start_1
    iget-object v4, v1, Lcom/openfeint/internal/ui/WebViewCache;->appContext:Landroid/content/Context;

    const-string v5, "manifest.db"

    invoke-virtual {v4, v5}, Landroid/content/Context;->getDatabasePath(Ljava/lang/String;)Ljava/io/File;

    move-result-object v4

    new-instance v5, Ljava/io/File;

    const-string v6, "manifest.db"

    invoke-direct {v5, v3, v6}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    invoke-static {v4, v5}, Lcom/openfeint/internal/Util;->copyFile(Ljava/io/File;Ljava/io/File;)V
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_1

    :cond_3
    :goto_3
    new-instance v4, Ljava/lang/Thread;

    new-instance v5, Lcom/openfeint/internal/ui/WebViewCache$1;

    invoke-direct {v5, v1, v2, v3, v0}, Lcom/openfeint/internal/ui/WebViewCache$1;-><init>(Lcom/openfeint/internal/ui/WebViewCache;Ljava/io/File;Ljava/io/File;Ljava/io/File;)V

    invoke-direct {v4, v5}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    invoke-virtual {v4}, Ljava/lang/Thread;->start()V

    goto/16 :goto_0

    :cond_4
    invoke-direct {v1}, Lcom/openfeint/internal/ui/WebViewCache;->clientManifestReady()V

    invoke-direct {v1}, Lcom/openfeint/internal/ui/WebViewCache;->deleteAll()V

    goto/16 :goto_0

    :cond_5
    const-string v2, "WebViewCache"

    invoke-static {v2, v0}, Lcom/openfeint/internal/logcat/OFLog;->i(Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {v1}, Lcom/openfeint/internal/ui/WebViewCache;->setRootUriInternal()V

    goto/16 :goto_0

    :catch_0
    move-exception v2

    goto/16 :goto_2

    :catch_1
    move-exception v4

    goto :goto_3
.end method

.method private stripUnused(Ljava/util/Set;)Ljava/util/Set;
    .locals 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Set",
            "<",
            "Ljava/lang/String;",
            ">;)",
            "Ljava/util/Set",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    iget-object v0, p0, Lcom/openfeint/internal/ui/WebViewCache;->appContext:Landroid/content/Context;

    invoke-static {v0}, Lcom/openfeint/internal/Util;->getDpiName(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "mdpi"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    const-string v0, ".hdpi."

    move-object v1, v0

    :goto_0
    new-instance v2, Ljava/util/HashSet;

    invoke-direct {v2}, Ljava/util/HashSet;-><init>()V

    invoke-interface {p1}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :cond_0
    :goto_1
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_2

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v4

    if-nez v4, :cond_0

    invoke-interface {v2, v0}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    goto :goto_1

    :cond_1
    const-string v0, ".mdpi."

    move-object v1, v0

    goto :goto_0

    :cond_2
    return-object v2
.end method

.method private sync()V
    .locals 2

    const-string v0, "WebViewCache"

    const-string v1, "--- WebViewCache Sync ---"

    invoke-static {v0, v1}, Lcom/openfeint/internal/logcat/OFLog;->i(Ljava/lang/String;Ljava/lang/String;)V

    new-instance v0, Lcom/openfeint/internal/ui/WebViewCache$ManifestRequest;

    const-string v1, "manifest"

    invoke-direct {v0, p0, v1}, Lcom/openfeint/internal/ui/WebViewCache$ManifestRequest;-><init>(Lcom/openfeint/internal/ui/WebViewCache;Ljava/lang/String;)V

    invoke-virtual {v0}, Lcom/openfeint/internal/ui/WebViewCache$ManifestRequest;->launch()V

    return-void
.end method

.method public static trackPath(Ljava/lang/String;Lcom/openfeint/internal/ui/WebViewCacheCallback;)Z
    .locals 5

    const/4 v1, 0x1

    sget-object v2, Lcom/openfeint/internal/ui/WebViewCache;->sInstance:Lcom/openfeint/internal/ui/WebViewCache;

    iget-boolean v0, v2, Lcom/openfeint/internal/ui/WebViewCache;->loadingFinished:Z

    if-nez v0, :cond_1

    iget-object v0, v2, Lcom/openfeint/internal/ui/WebViewCache;->serverManifest:Lcom/openfeint/internal/ui/WebViewCache$ManifestData;

    if-nez v0, :cond_0

    invoke-virtual {p1}, Lcom/openfeint/internal/ui/WebViewCacheCallback;->onTrackingNeeded()V

    iget-object v0, v2, Lcom/openfeint/internal/ui/WebViewCache;->trackedPaths:Ljava/util/Set;

    new-instance v2, Lcom/openfeint/internal/ui/WebViewCache$PathAndCallback;

    invoke-direct {v2, p0, p1}, Lcom/openfeint/internal/ui/WebViewCache$PathAndCallback;-><init>(Ljava/lang/String;Lcom/openfeint/internal/ui/WebViewCacheCallback;)V

    invoke-interface {v0, v2}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    move v0, v1

    :goto_0
    return v0

    :cond_0
    iget-object v0, v2, Lcom/openfeint/internal/ui/WebViewCache;->serverManifest:Lcom/openfeint/internal/ui/WebViewCache$ManifestData;

    iget-object v0, v0, Lcom/openfeint/internal/ui/WebViewCache$ManifestData;->objects:Ljava/util/Map;

    invoke-interface {v0, p0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/openfeint/internal/ui/WebViewCache$ManifestItem;

    if-eqz v0, :cond_1

    invoke-virtual {p1}, Lcom/openfeint/internal/ui/WebViewCacheCallback;->onTrackingNeeded()V

    new-instance v3, Lcom/openfeint/internal/ui/WebViewCache$ManifestItem;

    invoke-direct {v3, v0}, Lcom/openfeint/internal/ui/WebViewCache$ManifestItem;-><init>(Lcom/openfeint/internal/ui/WebViewCache$ManifestItem;)V

    iget-object v0, v3, Lcom/openfeint/internal/ui/WebViewCache$ManifestItem;->dependentObjects:Ljava/util/Set;

    iget-object v4, v2, Lcom/openfeint/internal/ui/WebViewCache;->pathsToLoad:Ljava/util/Set;

    invoke-interface {v0, v4}, Ljava/util/Set;->retainAll(Ljava/util/Collection;)Z

    iget-object v0, v2, Lcom/openfeint/internal/ui/WebViewCache;->trackedItems:Ljava/util/Map;

    new-instance v2, Lcom/openfeint/internal/ui/WebViewCache$ItemAndCallback;

    invoke-direct {v2, v3, p1}, Lcom/openfeint/internal/ui/WebViewCache$ItemAndCallback;-><init>(Lcom/openfeint/internal/ui/WebViewCache$ManifestItem;Lcom/openfeint/internal/ui/WebViewCacheCallback;)V

    invoke-interface {v0, p0, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    move v0, v1

    goto :goto_0

    :cond_1
    invoke-virtual {p1, p0}, Lcom/openfeint/internal/ui/WebViewCacheCallback;->pathLoaded(Ljava/lang/String;)V

    const/4 v0, 0x0

    goto :goto_0
.end method


# virtual methods
.method public final setRootUriInternal()V
    .locals 3

    const-string v0, "WebViewCache"

    const-string v1, "can\'t use sdcard"

    invoke-static {v0, v1}, Lcom/openfeint/internal/logcat/OFLog;->e(Ljava/lang/String;Ljava/lang/String;)V

    iget-object v0, p0, Lcom/openfeint/internal/ui/WebViewCache;->appContext:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getFilesDir()Ljava/io/File;

    move-result-object v0

    new-instance v1, Ljava/io/File;

    const-string v2, "webui"

    invoke-direct {v1, v0, v2}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "/"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    sput-object v1, Lcom/openfeint/internal/ui/WebViewCache;->rootPath:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "file://"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    sget-object v2, Lcom/openfeint/internal/ui/WebViewCache;->rootPath:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    sput-object v1, Lcom/openfeint/internal/ui/WebViewCache;->rootUri:Ljava/lang/String;

    new-instance v1, Ljava/io/File;

    const-string v2, "webui"

    invoke-direct {v1, v0, v2}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    invoke-virtual {v1}, Ljava/io/File;->isDirectory()Z

    move-result v1

    if-nez v1, :cond_0

    new-instance v1, Ljava/lang/Thread;

    new-instance v2, Lcom/openfeint/internal/ui/WebViewCache$2;

    invoke-direct {v2, p0, v0}, Lcom/openfeint/internal/ui/WebViewCache$2;-><init>(Lcom/openfeint/internal/ui/WebViewCache;Ljava/io/File;)V

    invoke-direct {v1, v2}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    invoke-virtual {v1}, Ljava/lang/Thread;->start()V

    :goto_0
    return-void

    :cond_0
    invoke-direct {p0}, Lcom/openfeint/internal/ui/WebViewCache;->clientManifestReady()V

    goto :goto_0
.end method
