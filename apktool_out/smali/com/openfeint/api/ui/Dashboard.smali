.class public Lcom/openfeint/api/ui/Dashboard;
.super Lcom/openfeint/internal/ui/WebNav;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/openfeint/api/ui/Dashboard$DashboardActionHandler;
    }
.end annotation


# static fields
.field private static openfrom:Ljava/lang/String;

.field private static sOpenDashboards:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Lcom/openfeint/api/ui/Dashboard;",
            ">;"
        }
    .end annotation
.end field


# instance fields
.field mRootIsHome:Z


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    sput-object v0, Lcom/openfeint/api/ui/Dashboard;->sOpenDashboards:Ljava/util/List;

    return-void
.end method

.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Lcom/openfeint/internal/ui/WebNav;-><init>()V

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/openfeint/api/ui/Dashboard;->mRootIsHome:Z

    return-void
.end method

.method public static open()V
    .locals 2

    const/4 v0, 0x0

    const/4 v1, 0x0

    invoke-static {v0, v1}, Lcom/openfeint/api/ui/Dashboard;->open(Ljava/lang/String;Z)V

    return-void
.end method

.method private static open(Ljava/lang/String;Z)V
    .locals 4

    invoke-static {}, Lcom/openfeint/internal/offline/OfflineSupport;->trySubmitOfflineData()V

    invoke-static {}, Lcom/openfeint/internal/OpenFeintInternal;->getInstance()Lcom/openfeint/internal/OpenFeintInternal;

    move-result-object v0

    invoke-virtual {v0}, Lcom/openfeint/internal/OpenFeintInternal;->isFeintServerReachable()Z

    move-result v1

    if-nez v1, :cond_0

    invoke-static {}, Lcom/openfeint/internal/OpenFeintInternal;->getInstance()Lcom/openfeint/internal/OpenFeintInternal;

    move-result-object v0

    invoke-virtual {v0}, Lcom/openfeint/internal/OpenFeintInternal;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    const-string v1, "of_offline_notification"

    invoke-static {v1}, Lcom/openfeint/internal/RR;->string(Ljava/lang/String;)I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object v1

    const-string v2, "of_offline_notification_line2"

    invoke-static {v2}, Lcom/openfeint/internal/RR;->string(Ljava/lang/String;)I

    move-result v2

    invoke-virtual {v0, v2}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object v0

    sget-object v2, Lcom/openfeint/api/Notification$Category;->Foreground:Lcom/openfeint/api/Notification$Category;

    sget-object v3, Lcom/openfeint/api/Notification$Type;->NetworkOffline:Lcom/openfeint/api/Notification$Type;

    invoke-static {v1, v0, v2, v3}, Lcom/openfeint/internal/notifications/TwoLineNotification;->show(Ljava/lang/String;Ljava/lang/String;Lcom/openfeint/api/Notification$Category;Lcom/openfeint/api/Notification$Type;)V

    :goto_0
    return-void

    :cond_0
    invoke-static {}, Lcom/openfeint/internal/eventlog/EventLogDispatcher;->getInstance()Lcom/openfeint/internal/eventlog/EventLogDispatcher;

    move-result-object v1

    const-string v2, "dashboard_start.openfeint.com"

    sget-object v3, Lcom/openfeint/api/ui/Dashboard;->openfrom:Ljava/lang/String;

    invoke-virtual {v1, v2, v3}, Lcom/openfeint/internal/eventlog/EventLogDispatcher;->postEvent(Ljava/lang/String;Ljava/lang/Object;)V

    new-instance v1, Landroid/content/Intent;

    invoke-virtual {v0}, Lcom/openfeint/internal/OpenFeintInternal;->getContext()Landroid/content/Context;

    move-result-object v2

    const-class v3, Lcom/openfeint/api/ui/Dashboard;

    invoke-direct {v1, v2, v3}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    if-eqz p0, :cond_1

    const-string v2, "screenName"

    invoke-virtual {v1, v2, p0}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    :cond_1
    invoke-virtual {v0, v1, p1}, Lcom/openfeint/internal/OpenFeintInternal;->submitIntent(Landroid/content/Intent;Z)V

    goto :goto_0
.end method

.method public static openAchievements()V
    .locals 2

    const-string v0, "achievements"

    const/4 v1, 0x0

    invoke-static {v0, v1}, Lcom/openfeint/api/ui/Dashboard;->open(Ljava/lang/String;Z)V

    return-void
.end method

.method public static openFromSpotlight()V
    .locals 2

    const-string v0, "user.json?spotlight=true"

    const/4 v1, 0x1

    invoke-static {v0, v1}, Lcom/openfeint/api/ui/Dashboard;->open(Ljava/lang/String;Z)V

    return-void
.end method

.method public static openLeaderboard$552c4e01()V
    .locals 2

    const-string v0, "leaderboards"

    const/4 v1, 0x0

    invoke-static {v0, v1}, Lcom/openfeint/api/ui/Dashboard;->open(Ljava/lang/String;Z)V

    return-void
.end method

.method public static openUser(Ljava/lang/String;)V
    .locals 2

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "profile.json?user_id="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x0

    invoke-static {v0, v1}, Lcom/openfeint/api/ui/Dashboard;->open(Ljava/lang/String;Z)V

    return-void
.end method


# virtual methods
.method protected createActionHandler(Lcom/openfeint/internal/ui/WebNav;)Lcom/openfeint/internal/ui/WebNav$ActionHandler;
    .locals 1

    new-instance v0, Lcom/openfeint/api/ui/Dashboard$DashboardActionHandler;

    invoke-direct {v0, p0, p1}, Lcom/openfeint/api/ui/Dashboard$DashboardActionHandler;-><init>(Lcom/openfeint/api/ui/Dashboard;Lcom/openfeint/internal/ui/WebNav;)V

    return-object v0
.end method

.method protected initialContentPath()Ljava/lang/String;
    .locals 3

    invoke-virtual {p0}, Lcom/openfeint/api/ui/Dashboard;->getIntent()Landroid/content/Intent;

    move-result-object v0

    const-string v1, "screenName"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_0

    const/4 v1, 0x0

    iput-boolean v1, p0, Lcom/openfeint/api/ui/Dashboard;->mRootIsHome:Z

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "dashboard/"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    :goto_0
    return-object v0

    :cond_0
    const-string v0, "dashboard/user"

    goto :goto_0
.end method

.method public onCreateOptionsMenu(Landroid/view/Menu;)Z
    .locals 2

    invoke-virtual {p0}, Lcom/openfeint/api/ui/Dashboard;->getMenuInflater()Landroid/view/MenuInflater;

    move-result-object v0

    const-string v1, "of_dashboard"

    invoke-static {v1}, Lcom/openfeint/internal/RR;->menu(Ljava/lang/String;)I

    move-result v1

    invoke-virtual {v0, v1, p1}, Landroid/view/MenuInflater;->inflate(ILandroid/view/Menu;)V

    const/4 v0, 0x1

    return v0
.end method

.method public onDestroy()V
    .locals 1

    invoke-super {p0}, Lcom/openfeint/internal/ui/WebNav;->onDestroy()V

    sget-object v0, Lcom/openfeint/api/ui/Dashboard;->sOpenDashboards:Ljava/util/List;

    invoke-interface {v0, p0}, Ljava/util/List;->remove(Ljava/lang/Object;)Z

    return-void
.end method

.method public onOptionsItemSelected(Landroid/view/MenuItem;)Z
    .locals 5

    const/4 v0, 0x1

    const/4 v1, 0x0

    invoke-interface {p1}, Landroid/view/MenuItem;->getItemId()I

    move-result v2

    const-string v3, "home"

    invoke-static {v3}, Lcom/openfeint/internal/RR;->id(Ljava/lang/String;)I

    move-result v3

    if-ne v2, v3, :cond_1

    const-string v1, "home"

    iput-boolean v0, p0, Lcom/openfeint/api/ui/Dashboard;->mRootIsHome:Z

    :cond_0
    :goto_0
    if-nez v1, :cond_3

    invoke-super {p0, p1}, Lcom/openfeint/internal/ui/WebNav;->onOptionsItemSelected(Landroid/view/MenuItem;)Z

    move-result v0

    :goto_1
    return v0

    :cond_1
    invoke-interface {p1}, Landroid/view/MenuItem;->getItemId()I

    move-result v2

    const-string v3, "settings"

    invoke-static {v3}, Lcom/openfeint/internal/RR;->id(Ljava/lang/String;)I

    move-result v3

    if-ne v2, v3, :cond_2

    const-string v1, "settings"

    goto :goto_0

    :cond_2
    invoke-interface {p1}, Landroid/view/MenuItem;->getItemId()I

    move-result v2

    const-string v3, "exit_feint"

    invoke-static {v3}, Lcom/openfeint/internal/RR;->id(Ljava/lang/String;)I

    move-result v3

    if-ne v2, v3, :cond_0

    const-string v1, "exit"

    goto :goto_0

    :cond_3
    const-string v2, "OF.menu(\'%s\')"

    new-array v3, v0, [Ljava/lang/Object;

    const/4 v4, 0x0

    aput-object v1, v3, v4

    invoke-static {v2, v3}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v1}, Lcom/openfeint/api/ui/Dashboard;->executeJavascript(Ljava/lang/String;)V

    goto :goto_1
.end method

.method public onPrepareOptionsMenu(Landroid/view/Menu;)Z
    .locals 3

    const/4 v1, 0x1

    const-string v0, "home"

    invoke-static {v0}, Lcom/openfeint/internal/RR;->id(Ljava/lang/String;)I

    move-result v0

    invoke-interface {p1, v0}, Landroid/view/Menu;->findItem(I)Landroid/view/MenuItem;

    move-result-object v2

    iget-boolean v0, p0, Lcom/openfeint/api/ui/Dashboard;->mRootIsHome:Z

    if-eqz v0, :cond_0

    iget v0, p0, Lcom/openfeint/api/ui/Dashboard;->pageStackCount:I

    if-le v0, v1, :cond_1

    :cond_0
    move v0, v1

    :goto_0
    invoke-interface {v2, v0}, Landroid/view/MenuItem;->setVisible(Z)Landroid/view/MenuItem;

    return v1

    :cond_1
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public onResume()V
    .locals 1

    invoke-super {p0}, Lcom/openfeint/internal/ui/WebNav;->onResume()V

    sget-object v0, Lcom/openfeint/api/ui/Dashboard;->sOpenDashboards:Ljava/util/List;

    invoke-interface {v0, p0}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    sget-object v0, Lcom/openfeint/api/ui/Dashboard;->sOpenDashboards:Ljava/util/List;

    invoke-interface {v0, p0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_0
    invoke-static {}, Lcom/openfeint/internal/OpenFeintInternal;->getInstance()Lcom/openfeint/internal/OpenFeintInternal;

    move-result-object v0

    invoke-virtual {v0}, Lcom/openfeint/internal/OpenFeintInternal;->getCurrentUser()Lcom/openfeint/api/resource/CurrentUser;

    move-result-object v0

    if-nez v0, :cond_1

    invoke-virtual {p0}, Lcom/openfeint/api/ui/Dashboard;->finish()V

    :cond_1
    return-void
.end method

.method public onStop()V
    .locals 3

    invoke-static {}, Lcom/openfeint/internal/eventlog/EventLogDispatcher;->getInstance()Lcom/openfeint/internal/eventlog/EventLogDispatcher;

    move-result-object v0

    const-string v1, "dashboard_end.openfeint.com"

    sget-object v2, Lcom/openfeint/api/ui/Dashboard;->openfrom:Ljava/lang/String;

    invoke-virtual {v0, v1, v2}, Lcom/openfeint/internal/eventlog/EventLogDispatcher;->postEvent(Ljava/lang/String;Ljava/lang/Object;)V

    invoke-super {p0}, Lcom/openfeint/internal/ui/WebNav;->onStop()V

    return-void
.end method
