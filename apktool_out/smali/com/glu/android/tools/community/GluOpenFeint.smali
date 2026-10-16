.class public final Lcom/glu/android/tools/community/GluOpenFeint;
.super Lcom/openfeint/api/OpenFeintDelegate;


# static fields
.field public static instance:Lcom/glu/android/tools/community/GluOpenFeint;

.field private static m_initialized:Z


# instance fields
.field public DUMMY_CA_RETURN:[C

.field public OF_GAME_NAME:Ljava/lang/String;

.field public OF_ID:Ljava/lang/String;

.field public OF_KEY:Ljava/lang/String;

.field public OF_SECRET:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    const/4 v0, 0x0

    sput-boolean v0, Lcom/glu/android/tools/community/GluOpenFeint;->m_initialized:Z

    const/4 v0, 0x0

    sput-object v0, Lcom/glu/android/tools/community/GluOpenFeint;->instance:Lcom/glu/android/tools/community/GluOpenFeint;

    return-void
.end method

.method public constructor <init>()V
    .locals 1

    const/4 v0, 0x0

    invoke-direct {p0}, Lcom/openfeint/api/OpenFeintDelegate;-><init>()V

    iput-object v0, p0, Lcom/glu/android/tools/community/GluOpenFeint;->OF_GAME_NAME:Ljava/lang/String;

    iput-object v0, p0, Lcom/glu/android/tools/community/GluOpenFeint;->OF_KEY:Ljava/lang/String;

    iput-object v0, p0, Lcom/glu/android/tools/community/GluOpenFeint;->OF_SECRET:Ljava/lang/String;

    iput-object v0, p0, Lcom/glu/android/tools/community/GluOpenFeint;->OF_ID:Ljava/lang/String;

    const/4 v0, 0x1

    new-array v0, v0, [C

    iput-object v0, p0, Lcom/glu/android/tools/community/GluOpenFeint;->DUMMY_CA_RETURN:[C

    sput-object p0, Lcom/glu/android/tools/community/GluOpenFeint;->instance:Lcom/glu/android/tools/community/GluOpenFeint;

    return-void
.end method

.method private static GluUtil_stringToNativeCharArray(Ljava/lang/String;)[C
    .locals 5

    const/4 v1, 0x0

    invoke-virtual {p0}, Ljava/lang/String;->toCharArray()[C

    move-result-object v2

    array-length v0, v2

    add-int/lit8 v0, v0, 0x1

    new-array v3, v0, [C

    move v0, v1

    :goto_0
    array-length v4, v2

    if-ge v0, v4, :cond_0

    aget-char v4, v2, v0

    aput-char v4, v3, v0

    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_0
    array-length v0, v2

    aput-char v1, v3, v0

    return-object v3
.end method

.method public static achievementEvent(IIII)I
    .locals 5

    const/4 v0, 0x1

    const/high16 v4, 0x42c80000    # 100.0f

    const/4 v1, 0x0

    invoke-static {p0}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object v2

    sget-boolean v3, Lcom/glu/android/tools/community/GluOpenFeint;->m_initialized:Z

    if-eqz v3, :cond_3

    invoke-static {}, Lcom/openfeint/internal/OpenFeintInternal;->getInstance()Lcom/openfeint/internal/OpenFeintInternal;

    move-result-object v3

    invoke-virtual {v3}, Lcom/openfeint/internal/OpenFeintInternal;->isUserLoggedIn()Z

    move-result v3

    if-eqz v3, :cond_3

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Achievement event: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v3, " unlocked="

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v3, " currentValue="

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v3, " goalValue="

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/glu/platform/android/resdl/Debug;->log(Ljava/lang/String;)V

    new-instance v3, Lcom/openfeint/api/resource/Achievement;

    invoke-direct {v3, v2}, Lcom/openfeint/api/resource/Achievement;-><init>(Ljava/lang/String;)V

    if-eqz p2, :cond_0

    if-nez p3, :cond_2

    int-to-float v1, p2

    :goto_0
    cmpl-float v2, v1, v4

    if-gtz v2, :cond_0

    const/4 v2, 0x0

    cmpl-float v2, v1, v2

    if-lez v2, :cond_0

    invoke-virtual {v3, v1}, Lcom/openfeint/api/resource/Achievement;->updateProgression$45f61eed(F)V

    cmpl-float v1, v1, v4

    if-nez v1, :cond_0

    move p1, v0

    :cond_0
    if-eqz p1, :cond_1

    invoke-virtual {v3}, Lcom/openfeint/api/resource/Achievement;->unlock$26d5f281()V

    :cond_1
    :goto_1
    return v0

    :cond_2
    int-to-float v1, p3

    int-to-float v2, p2

    div-float/2addr v1, v2

    mul-float/2addr v1, v4

    goto :goto_0

    :cond_3
    move v0, v1

    goto :goto_1
.end method

.method public static leaderboardEvent(IJF)I
    .locals 4

    const/4 v0, 0x0

    invoke-static {p0}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object v1

    sget-boolean v2, Lcom/glu/android/tools/community/GluOpenFeint;->m_initialized:Z

    if-eqz v2, :cond_1

    invoke-static {}, Lcom/openfeint/internal/OpenFeintInternal;->getInstance()Lcom/openfeint/internal/OpenFeintInternal;

    move-result-object v2

    invoke-virtual {v2}, Lcom/openfeint/internal/OpenFeintInternal;->isUserLoggedIn()Z

    move-result v2

    if-eqz v2, :cond_1

    const/4 v0, 0x1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Leaderboard event: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " lScore="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1, p2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " fScore="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p3}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/glu/platform/android/resdl/Debug;->log(Ljava/lang/String;)V

    const/4 v2, 0x0

    cmpl-float v2, p3, v2

    if-eqz v2, :cond_0

    float-to-long p1, p3

    :cond_0
    const-wide/16 v2, 0x0

    cmp-long v2, p1, v2

    if-eqz v2, :cond_1

    new-instance v2, Lcom/openfeint/api/resource/Score;

    invoke-direct {v2, p1, p2}, Lcom/openfeint/api/resource/Score;-><init>(J)V

    new-instance v3, Lcom/openfeint/api/resource/Leaderboard;

    invoke-direct {v3, v1}, Lcom/openfeint/api/resource/Leaderboard;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, v3}, Lcom/openfeint/api/resource/Score;->submitTo$487f3c2c(Lcom/openfeint/api/resource/Leaderboard;)V

    :cond_1
    return v0
.end method


# virtual methods
.method public final communityEvent(IILjava/lang/String;)[C
    .locals 3

    const/4 v2, 0x7

    const/4 v0, 0x1

    const/4 v1, 0x0

    if-ne p1, v2, :cond_1

    sget-object v0, Lcom/glu/platform/android/GluPlatformActivity;->instance:Lcom/glu/platform/android/GluPlatformActivity;

    iget-object v0, v0, Lcom/glu/platform/android/GluPlatformActivity;->m_Terminator:Landroid/os/Handler;

    invoke-virtual {v0, v2}, Landroid/os/Handler;->sendEmptyMessage(I)Z

    move v0, v1

    :cond_0
    :goto_0
    :pswitch_0
    iget-object v2, p0, Lcom/glu/android/tools/community/GluOpenFeint;->DUMMY_CA_RETURN:[C

    int-to-char v0, v0

    aput-char v0, v2, v1

    iget-object v0, p0, Lcom/glu/android/tools/community/GluOpenFeint;->DUMMY_CA_RETURN:[C

    :goto_1
    return-object v0

    :cond_1
    const/16 v2, 0xa

    if-ne p1, v2, :cond_2

    new-instance v0, Ljava/lang/String;

    invoke-direct {v0, p3}, Ljava/lang/String;-><init>(Ljava/lang/String;)V

    iput-object v0, p0, Lcom/glu/android/tools/community/GluOpenFeint;->OF_GAME_NAME:Ljava/lang/String;

    move v0, v1

    goto :goto_0

    :cond_2
    const/16 v2, 0xb

    if-ne p1, v2, :cond_3

    new-instance v0, Ljava/lang/String;

    invoke-direct {v0, p3}, Ljava/lang/String;-><init>(Ljava/lang/String;)V

    iput-object v0, p0, Lcom/glu/android/tools/community/GluOpenFeint;->OF_KEY:Ljava/lang/String;

    move v0, v1

    goto :goto_0

    :cond_3
    const/16 v2, 0xc

    if-ne p1, v2, :cond_4

    new-instance v0, Ljava/lang/String;

    invoke-direct {v0, p3}, Ljava/lang/String;-><init>(Ljava/lang/String;)V

    iput-object v0, p0, Lcom/glu/android/tools/community/GluOpenFeint;->OF_SECRET:Ljava/lang/String;

    move v0, v1

    goto :goto_0

    :cond_4
    const/16 v2, 0xd

    if-ne p1, v2, :cond_5

    new-instance v0, Ljava/lang/String;

    invoke-direct {v0, p3}, Ljava/lang/String;-><init>(Ljava/lang/String;)V

    iput-object v0, p0, Lcom/glu/android/tools/community/GluOpenFeint;->OF_ID:Ljava/lang/String;

    move v0, v1

    goto :goto_0

    :cond_5
    sget-boolean v2, Lcom/glu/android/tools/community/GluOpenFeint;->m_initialized:Z

    if-eqz v2, :cond_6

    packed-switch p1, :pswitch_data_0

    :cond_6
    :pswitch_1
    move v0, v1

    goto :goto_0

    :pswitch_2
    invoke-static {}, Lcom/openfeint/api/ui/Dashboard;->open()V

    move v0, v1

    goto :goto_0

    :pswitch_3
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v2, ""

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/openfeint/api/ui/Dashboard;->openUser(Ljava/lang/String;)V

    move v0, v1

    goto :goto_0

    :pswitch_4
    invoke-static {}, Lcom/openfeint/api/ui/Dashboard;->openAchievements()V

    move v0, v1

    goto :goto_0

    :pswitch_5
    new-instance v0, Ljava/lang/String;

    invoke-direct {v0, p3}, Ljava/lang/String;-><init>(Ljava/lang/String;)V

    invoke-static {}, Lcom/openfeint/api/ui/Dashboard;->openLeaderboard$552c4e01()V

    move v0, v1

    goto :goto_0

    :pswitch_6
    invoke-static {}, Lcom/openfeint/internal/OpenFeintInternal;->getInstance()Lcom/openfeint/internal/OpenFeintInternal;

    move-result-object v0

    invoke-virtual {v0}, Lcom/openfeint/internal/OpenFeintInternal;->isUserLoggedIn()Z

    move-result v0

    if-eqz v0, :cond_7

    invoke-static {}, Lcom/openfeint/internal/OpenFeintInternal;->getInstance()Lcom/openfeint/internal/OpenFeintInternal;

    move-result-object v0

    invoke-virtual {v0}, Lcom/openfeint/internal/OpenFeintInternal;->getCurrentUser()Lcom/openfeint/api/resource/CurrentUser;

    move-result-object v0

    iget-object v0, v0, Lcom/openfeint/api/resource/CurrentUser;->name:Ljava/lang/String;

    invoke-static {v0}, Lcom/glu/android/tools/community/GluOpenFeint;->GluUtil_stringToNativeCharArray(Ljava/lang/String;)[C

    move-result-object v0

    goto/16 :goto_1

    :cond_7
    const-string v0, "Player"

    invoke-static {v0}, Lcom/glu/android/tools/community/GluOpenFeint;->GluUtil_stringToNativeCharArray(Ljava/lang/String;)[C

    move-result-object v0

    goto/16 :goto_1

    :pswitch_7
    invoke-static {}, Lcom/openfeint/internal/OpenFeintInternal;->getInstance()Lcom/openfeint/internal/OpenFeintInternal;

    move-result-object v0

    invoke-virtual {v0}, Lcom/openfeint/internal/OpenFeintInternal;->isUserLoggedIn()Z

    move-result v0

    if-eqz v0, :cond_8

    invoke-static {}, Lcom/openfeint/internal/OpenFeintInternal;->getInstance()Lcom/openfeint/internal/OpenFeintInternal;

    move-result-object v0

    invoke-virtual {v0}, Lcom/openfeint/internal/OpenFeintInternal;->getCurrentUser()Lcom/openfeint/api/resource/CurrentUser;

    move-result-object v0

    invoke-virtual {v0}, Lcom/openfeint/api/resource/CurrentUser;->userID()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/glu/android/tools/community/GluOpenFeint;->GluUtil_stringToNativeCharArray(Ljava/lang/String;)[C

    move-result-object v0

    goto/16 :goto_1

    :cond_8
    const-string v0, "WARNING: Requested username when they\'re not logged in. Using default."

    invoke-static {v0}, Lcom/glu/platform/android/resdl/Debug;->log(Ljava/lang/String;)V

    const-string v0, "0"

    invoke-static {v0}, Lcom/glu/android/tools/community/GluOpenFeint;->GluUtil_stringToNativeCharArray(Ljava/lang/String;)[C

    move-result-object v0

    goto/16 :goto_1

    :pswitch_8
    sget-boolean v2, Lcom/glu/android/tools/community/GluOpenFeint;->m_initialized:Z

    :pswitch_9
    sget-boolean v2, Lcom/glu/android/tools/community/GluOpenFeint;->m_initialized:Z

    if-eqz v2, :cond_9

    invoke-static {}, Lcom/openfeint/internal/OpenFeintInternal;->getInstance()Lcom/openfeint/internal/OpenFeintInternal;

    move-result-object v2

    invoke-virtual {v2}, Lcom/openfeint/internal/OpenFeintInternal;->isUserLoggedIn()Z

    move-result v2

    if-nez v2, :cond_0

    :cond_9
    move v0, v1

    goto/16 :goto_0

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_2
        :pswitch_4
        :pswitch_5
        :pswitch_0
        :pswitch_6
        :pswitch_6
        :pswitch_1
        :pswitch_1
        :pswitch_8
        :pswitch_1
        :pswitch_1
        :pswitch_1
        :pswitch_1
        :pswitch_9
        :pswitch_3
        :pswitch_7
    .end packed-switch
.end method

.method public final initialize()V
    .locals 5

    iget-object v0, p0, Lcom/glu/android/tools/community/GluOpenFeint;->OF_GAME_NAME:Ljava/lang/String;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/glu/android/tools/community/GluOpenFeint;->OF_KEY:Ljava/lang/String;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/glu/android/tools/community/GluOpenFeint;->OF_SECRET:Ljava/lang/String;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/glu/android/tools/community/GluOpenFeint;->OF_ID:Ljava/lang/String;

    if-nez v0, :cond_1

    :cond_0
    new-instance v0, Ljava/lang/RuntimeException;

    const-string v1, "Insufficient info to initialize openfeint."

    invoke-direct {v0, v1}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    throw v0

    :cond_1
    new-instance v0, Lcom/openfeint/api/OpenFeintSettings;

    iget-object v1, p0, Lcom/glu/android/tools/community/GluOpenFeint;->OF_GAME_NAME:Ljava/lang/String;

    iget-object v2, p0, Lcom/glu/android/tools/community/GluOpenFeint;->OF_KEY:Ljava/lang/String;

    iget-object v3, p0, Lcom/glu/android/tools/community/GluOpenFeint;->OF_SECRET:Ljava/lang/String;

    iget-object v4, p0, Lcom/glu/android/tools/community/GluOpenFeint;->OF_ID:Ljava/lang/String;

    invoke-direct {v0, v1, v2, v3, v4}, Lcom/openfeint/api/OpenFeintSettings;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    sget-object v1, Lcom/glu/platform/android/GluPlatformActivity;->instance:Lcom/glu/platform/android/GluPlatformActivity;

    invoke-static {v1, v0, p0}, Lcom/openfeint/internal/OpenFeintInternal;->initializeWithoutLoggingIn(Landroid/content/Context;Lcom/openfeint/api/OpenFeintSettings;Lcom/openfeint/api/OpenFeintDelegate;)V

    invoke-static {}, Lcom/openfeint/internal/OpenFeintInternal;->getInstance()Lcom/openfeint/internal/OpenFeintInternal;

    move-result-object v0

    if-eqz v0, :cond_2

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lcom/openfeint/internal/OpenFeintInternal;->login(Z)V

    :cond_2
    const/4 v0, 0x1

    sput-boolean v0, Lcom/glu/android/tools/community/GluOpenFeint;->m_initialized:Z

    return-void
.end method
