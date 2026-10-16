.class public Lcom/glu/android/tools/community/Community_noobf;
.super Landroid/app/Activity;


# static fields
.field public static final COMMUNITY_EVENT_DESTROY:I = 0x8

.field public static final COMMUNITY_EVENT_DISPLAY_ACHIEVEMENTS:I = 0x2

.field public static final COMMUNITY_EVENT_DISPLAY_LEADERBOARDS:I = 0x3

.field public static final COMMUNITY_EVENT_GET_ACHIEVEMENT_USERNAME:I = 0x5

.field public static final COMMUNITY_EVENT_GET_LEADERBOARD_USERNAME:I = 0x6

.field public static final COMMUNITY_EVENT_GET_USER_ID:I = 0x10

.field public static final COMMUNITY_EVENT_INITIALIZE:I = 0x7

.field public static final COMMUNITY_EVENT_IS_INIT:I = 0x9

.field public static final COMMUNITY_EVENT_IS_SUPPORTED:I = 0x4

.field public static final COMMUNITY_EVENT_IS_USER_LOGGED_IN:I = 0xe

.field public static final COMMUNITY_EVENT_OPEN_USER_PROFILE:I = 0xf

.field public static final COMMUNITY_EVENT_QUEUE_GAME_NAME:I = 0xa

.field public static final COMMUNITY_EVENT_QUEUE_ID:I = 0xd

.field public static final COMMUNITY_EVENT_QUEUE_KEY:I = 0xb

.field public static final COMMUNITY_EVENT_QUEUE_SECRET:I = 0xc

.field public static final COMMUNITY_EVENT_SHOW_DASH:I = 0x1

.field public static DUMMY_CA_RETURN:[C


# direct methods
.method static constructor <clinit>()V
    .locals 2

    const/4 v1, 0x0

    const/4 v0, 0x1

    new-array v0, v0, [C

    aput-char v1, v0, v1

    sput-object v0, Lcom/glu/android/tools/community/Community_noobf;->DUMMY_CA_RETURN:[C

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Landroid/app/Activity;-><init>()V

    return-void
.end method

.method public static achievementEvent(IIII)I
    .locals 1

    invoke-static {}, Lcom/glu/android/tools/community/Community_noobf;->initIfNeeded()V

    sget-object v0, Lcom/glu/android/tools/community/GluOpenFeint;->instance:Lcom/glu/android/tools/community/GluOpenFeint;

    invoke-static {p0, p1, p2, p3}, Lcom/glu/android/tools/community/GluOpenFeint;->achievementEvent(IIII)I

    move-result v0

    return v0
.end method

.method public static communityEvent(IILjava/lang/String;)[C
    .locals 1

    invoke-static {}, Lcom/glu/android/tools/community/Community_noobf;->initIfNeeded()V

    const/16 v0, 0x8

    if-ne p0, v0, :cond_0

    const/4 v0, 0x0

    sput-object v0, Lcom/glu/android/tools/community/GluOpenFeint;->instance:Lcom/glu/android/tools/community/GluOpenFeint;

    sget-object v0, Lcom/glu/android/tools/community/Community_noobf;->DUMMY_CA_RETURN:[C

    :goto_0
    return-object v0

    :cond_0
    sget-object v0, Lcom/glu/android/tools/community/GluOpenFeint;->instance:Lcom/glu/android/tools/community/GluOpenFeint;

    invoke-virtual {v0, p0, p1, p2}, Lcom/glu/android/tools/community/GluOpenFeint;->communityEvent(IILjava/lang/String;)[C

    move-result-object v0

    goto :goto_0
.end method

.method private static initIfNeeded()V
    .locals 1

    sget-object v0, Lcom/glu/android/tools/community/GluOpenFeint;->instance:Lcom/glu/android/tools/community/GluOpenFeint;

    if-nez v0, :cond_0

    new-instance v0, Lcom/glu/android/tools/community/GluOpenFeint;

    invoke-direct {v0}, Lcom/glu/android/tools/community/GluOpenFeint;-><init>()V

    :cond_0
    return-void
.end method

.method public static leaderboardEvent(IJF)I
    .locals 1

    invoke-static {}, Lcom/glu/android/tools/community/Community_noobf;->initIfNeeded()V

    sget-object v0, Lcom/glu/android/tools/community/GluOpenFeint;->instance:Lcom/glu/android/tools/community/GluOpenFeint;

    invoke-static {p0, p1, p2, p3}, Lcom/glu/android/tools/community/GluOpenFeint;->leaderboardEvent(IJF)I

    move-result v0

    return v0
.end method

.method private static onNativeShutdown()V
    .locals 1

    const/4 v0, 0x0

    sput-object v0, Lcom/glu/android/tools/community/GluOpenFeint;->instance:Lcom/glu/android/tools/community/GluOpenFeint;

    return-void
.end method
