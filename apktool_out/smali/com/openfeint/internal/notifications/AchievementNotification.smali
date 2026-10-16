.class public final Lcom/openfeint/internal/notifications/AchievementNotification;
.super Lcom/openfeint/internal/notifications/NotificationBase;


# direct methods
.method private constructor <init>(Ljava/util/Map;)V
    .locals 6
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Map",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/Object;",
            ">;)V"
        }
    .end annotation

    const-string v0, "of_achievement_unlocked"

    invoke-static {v0}, Lcom/openfeint/internal/RR;->string(Ljava/lang/String;)I

    move-result v0

    invoke-static {v0}, Lcom/openfeint/internal/OpenFeintInternal;->getRString(I)Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    sget-object v3, Lcom/openfeint/api/Notification$Category;->Achievement:Lcom/openfeint/api/Notification$Category;

    sget-object v4, Lcom/openfeint/api/Notification$Type;->Success:Lcom/openfeint/api/Notification$Type;

    move-object v0, p0

    move-object v5, p1

    invoke-direct/range {v0 .. v5}, Lcom/openfeint/internal/notifications/NotificationBase;-><init>(Ljava/lang/String;Ljava/lang/String;Lcom/openfeint/api/Notification$Category;Lcom/openfeint/api/Notification$Type;Ljava/util/Map;)V

    return-void
.end method

.method public static showStatus(Lcom/openfeint/api/resource/Achievement;)V
    .locals 2

    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    const-string v1, "achievement"

    invoke-interface {v0, v1, p0}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    new-instance v1, Lcom/openfeint/internal/notifications/AchievementNotification;

    invoke-direct {v1, v0}, Lcom/openfeint/internal/notifications/AchievementNotification;-><init>(Ljava/util/Map;)V

    invoke-virtual {v1}, Lcom/openfeint/internal/notifications/AchievementNotification;->checkDelegateAndView()V

    return-void
.end method


# virtual methods
.method protected final createView()Z
    .locals 7

    const/4 v4, 0x1

    const/4 v3, 0x0

    const/4 v6, 0x4

    invoke-virtual {p0}, Lcom/openfeint/internal/notifications/AchievementNotification;->getUserData()Ljava/util/Map;

    move-result-object v0

    const-string v1, "achievement"

    invoke-interface {v0, v1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/openfeint/api/resource/Achievement;

    invoke-static {}, Lcom/openfeint/internal/OpenFeintInternal;->getInstance()Lcom/openfeint/internal/OpenFeintInternal;

    move-result-object v1

    invoke-virtual {v1}, Lcom/openfeint/internal/OpenFeintInternal;->getContext()Landroid/content/Context;

    move-result-object v1

    const-string v2, "layout_inflater"

    invoke-virtual {v1, v2}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/view/LayoutInflater;

    const-string v2, "of_achievement_notification"

    invoke-static {v2}, Lcom/openfeint/internal/RR;->layout(Ljava/lang/String;)I

    move-result v2

    const/4 v5, 0x0

    invoke-virtual {v1, v2, v5}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v1

    iput-object v1, p0, Lcom/openfeint/internal/notifications/AchievementNotification;->displayView:Landroid/view/View;

    iget-boolean v1, v0, Lcom/openfeint/api/resource/Achievement;->isUnlocked:Z

    if-eqz v1, :cond_1

    iget-object v1, p0, Lcom/openfeint/internal/notifications/AchievementNotification;->displayView:Landroid/view/View;

    const-string v2, "of_achievement_progress_icon"

    invoke-static {v2}, Lcom/openfeint/internal/RR;->id(Ljava/lang/String;)I

    move-result v2

    invoke-virtual {v1, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    invoke-virtual {v1, v6}, Landroid/view/View;->setVisibility(I)V

    iget v1, v0, Lcom/openfeint/api/resource/Achievement;->gamerscore:I

    if-nez v1, :cond_0

    iget-object v1, p0, Lcom/openfeint/internal/notifications/AchievementNotification;->displayView:Landroid/view/View;

    const-string v2, "of_achievement_score_icon"

    invoke-static {v2}, Lcom/openfeint/internal/RR;->id(Ljava/lang/String;)I

    move-result v2

    invoke-virtual {v1, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    invoke-virtual {v1, v6}, Landroid/view/View;->setVisibility(I)V

    iget-object v1, p0, Lcom/openfeint/internal/notifications/AchievementNotification;->displayView:Landroid/view/View;

    const-string v2, "of_achievement_score"

    invoke-static {v2}, Lcom/openfeint/internal/RR;->id(Ljava/lang/String;)I

    move-result v2

    invoke-virtual {v1, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    invoke-virtual {v1, v6}, Landroid/view/View;->setVisibility(I)V

    :cond_0
    :goto_0
    iget-object v1, p0, Lcom/openfeint/internal/notifications/AchievementNotification;->displayView:Landroid/view/View;

    const-string v2, "of_achievement_text"

    invoke-static {v2}, Lcom/openfeint/internal/RR;->id(Ljava/lang/String;)I

    move-result v2

    invoke-virtual {v1, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/TextView;

    iget-object v2, v0, Lcom/openfeint/api/resource/Achievement;->title:Ljava/lang/String;

    if-eqz v2, :cond_2

    iget-object v2, v0, Lcom/openfeint/api/resource/Achievement;->title:Ljava/lang/String;

    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v2

    if-lez v2, :cond_2

    iget-object v2, v0, Lcom/openfeint/api/resource/Achievement;->title:Ljava/lang/String;

    :goto_1
    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-boolean v1, v0, Lcom/openfeint/api/resource/Achievement;->isUnlocked:Z

    if-eqz v1, :cond_3

    iget v1, v0, Lcom/openfeint/api/resource/Achievement;->gamerscore:I

    invoke-static {v1}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object v1

    move-object v2, v1

    :goto_2
    iget-object v1, p0, Lcom/openfeint/internal/notifications/AchievementNotification;->displayView:Landroid/view/View;

    const-string v5, "of_achievement_score"

    invoke-static {v5}, Lcom/openfeint/internal/RR;->id(Ljava/lang/String;)I

    move-result v5

    invoke-virtual {v1, v5}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/TextView;

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v1, v0, Lcom/openfeint/api/resource/Achievement;->iconUrl:Ljava/lang/String;

    if-eqz v1, :cond_5

    iget-object v1, v0, Lcom/openfeint/api/resource/Achievement;->iconUrl:Ljava/lang/String;

    invoke-static {v1}, Lcom/openfeint/internal/notifications/AchievementNotification;->getResourceDrawable(Ljava/lang/String;)Landroid/graphics/drawable/Drawable;

    move-result-object v1

    if-nez v1, :cond_4

    new-instance v1, Lcom/openfeint/internal/notifications/AchievementNotification$1;

    iget-object v2, v0, Lcom/openfeint/api/resource/Achievement;->iconUrl:Ljava/lang/String;

    invoke-direct {v1, p0, v2, v0}, Lcom/openfeint/internal/notifications/AchievementNotification$1;-><init>(Lcom/openfeint/internal/notifications/AchievementNotification;Ljava/lang/String;Lcom/openfeint/api/resource/Achievement;)V

    invoke-virtual {v1}, Lcom/openfeint/internal/request/BitmapRequest;->launch()V

    move v0, v3

    :goto_3
    return v0

    :cond_1
    iget-object v1, p0, Lcom/openfeint/internal/notifications/AchievementNotification;->displayView:Landroid/view/View;

    const-string v2, "of_achievement_score_icon"

    invoke-static {v2}, Lcom/openfeint/internal/RR;->id(Ljava/lang/String;)I

    move-result v2

    invoke-virtual {v1, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    invoke-virtual {v1, v6}, Landroid/view/View;->setVisibility(I)V

    goto :goto_0

    :cond_2
    const-string v2, "of_achievement_unlocked"

    invoke-static {v2}, Lcom/openfeint/internal/RR;->string(Ljava/lang/String;)I

    move-result v2

    invoke-static {v2}, Lcom/openfeint/internal/OpenFeintInternal;->getRString(I)Ljava/lang/String;

    move-result-object v2

    goto :goto_1

    :cond_3
    const-string v1, "%d%%"

    new-array v2, v4, [Ljava/lang/Object;

    iget v5, v0, Lcom/openfeint/api/resource/Achievement;->percentComplete:F

    float-to-int v5, v5

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    aput-object v5, v2, v3

    invoke-static {v1, v2}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    move-object v2, v1

    goto :goto_2

    :cond_4
    iget-object v0, p0, Lcom/openfeint/internal/notifications/AchievementNotification;->displayView:Landroid/view/View;

    const-string v2, "of_achievement_icon"

    invoke-static {v2}, Lcom/openfeint/internal/RR;->id(Ljava/lang/String;)I

    move-result v2

    invoke-virtual {v0, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageView;

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setImageDrawable(Landroid/graphics/drawable/Drawable;)V

    :cond_5
    move v0, v4

    goto :goto_3
.end method
