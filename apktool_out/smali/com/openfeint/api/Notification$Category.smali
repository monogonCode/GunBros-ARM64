.class public final enum Lcom/openfeint/api/Notification$Category;
.super Ljava/lang/Enum;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/openfeint/api/Notification;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x4019
    name = "Category"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum",
        "<",
        "Lcom/openfeint/api/Notification$Category;",
        ">;"
    }
.end annotation


# static fields
.field private static final synthetic $VALUES:[Lcom/openfeint/api/Notification$Category;

.field public static final enum Achievement:Lcom/openfeint/api/Notification$Category;

.field public static final enum Challenge:Lcom/openfeint/api/Notification$Category;

.field public static final enum Foreground:Lcom/openfeint/api/Notification$Category;

.field public static final enum HighScore:Lcom/openfeint/api/Notification$Category;

.field public static final enum Leaderboard:Lcom/openfeint/api/Notification$Category;

.field public static final enum Login:Lcom/openfeint/api/Notification$Category;

.field public static final enum Multiplayer:Lcom/openfeint/api/Notification$Category;

.field public static final enum Presence:Lcom/openfeint/api/Notification$Category;

.field public static final enum SocialNotification:Lcom/openfeint/api/Notification$Category;


# direct methods
.method static constructor <clinit>()V
    .locals 8

    const/4 v7, 0x4

    const/4 v6, 0x3

    const/4 v5, 0x2

    const/4 v4, 0x1

    const/4 v3, 0x0

    new-instance v0, Lcom/openfeint/api/Notification$Category;

    const-string v1, "Foreground"

    invoke-direct {v0, v1, v3}, Lcom/openfeint/api/Notification$Category;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/openfeint/api/Notification$Category;->Foreground:Lcom/openfeint/api/Notification$Category;

    new-instance v0, Lcom/openfeint/api/Notification$Category;

    const-string v1, "Login"

    invoke-direct {v0, v1, v4}, Lcom/openfeint/api/Notification$Category;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/openfeint/api/Notification$Category;->Login:Lcom/openfeint/api/Notification$Category;

    new-instance v0, Lcom/openfeint/api/Notification$Category;

    const-string v1, "Challenge"

    invoke-direct {v0, v1, v5}, Lcom/openfeint/api/Notification$Category;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/openfeint/api/Notification$Category;->Challenge:Lcom/openfeint/api/Notification$Category;

    new-instance v0, Lcom/openfeint/api/Notification$Category;

    const-string v1, "HighScore"

    invoke-direct {v0, v1, v6}, Lcom/openfeint/api/Notification$Category;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/openfeint/api/Notification$Category;->HighScore:Lcom/openfeint/api/Notification$Category;

    new-instance v0, Lcom/openfeint/api/Notification$Category;

    const-string v1, "Leaderboard"

    invoke-direct {v0, v1, v7}, Lcom/openfeint/api/Notification$Category;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/openfeint/api/Notification$Category;->Leaderboard:Lcom/openfeint/api/Notification$Category;

    new-instance v0, Lcom/openfeint/api/Notification$Category;

    const-string v1, "Achievement"

    const/4 v2, 0x5

    invoke-direct {v0, v1, v2}, Lcom/openfeint/api/Notification$Category;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/openfeint/api/Notification$Category;->Achievement:Lcom/openfeint/api/Notification$Category;

    new-instance v0, Lcom/openfeint/api/Notification$Category;

    const-string v1, "SocialNotification"

    const/4 v2, 0x6

    invoke-direct {v0, v1, v2}, Lcom/openfeint/api/Notification$Category;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/openfeint/api/Notification$Category;->SocialNotification:Lcom/openfeint/api/Notification$Category;

    new-instance v0, Lcom/openfeint/api/Notification$Category;

    const-string v1, "Presence"

    const/4 v2, 0x7

    invoke-direct {v0, v1, v2}, Lcom/openfeint/api/Notification$Category;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/openfeint/api/Notification$Category;->Presence:Lcom/openfeint/api/Notification$Category;

    new-instance v0, Lcom/openfeint/api/Notification$Category;

    const-string v1, "Multiplayer"

    const/16 v2, 0x8

    invoke-direct {v0, v1, v2}, Lcom/openfeint/api/Notification$Category;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/openfeint/api/Notification$Category;->Multiplayer:Lcom/openfeint/api/Notification$Category;

    const/16 v0, 0x9

    new-array v0, v0, [Lcom/openfeint/api/Notification$Category;

    sget-object v1, Lcom/openfeint/api/Notification$Category;->Foreground:Lcom/openfeint/api/Notification$Category;

    aput-object v1, v0, v3

    sget-object v1, Lcom/openfeint/api/Notification$Category;->Login:Lcom/openfeint/api/Notification$Category;

    aput-object v1, v0, v4

    sget-object v1, Lcom/openfeint/api/Notification$Category;->Challenge:Lcom/openfeint/api/Notification$Category;

    aput-object v1, v0, v5

    sget-object v1, Lcom/openfeint/api/Notification$Category;->HighScore:Lcom/openfeint/api/Notification$Category;

    aput-object v1, v0, v6

    sget-object v1, Lcom/openfeint/api/Notification$Category;->Leaderboard:Lcom/openfeint/api/Notification$Category;

    aput-object v1, v0, v7

    const/4 v1, 0x5

    sget-object v2, Lcom/openfeint/api/Notification$Category;->Achievement:Lcom/openfeint/api/Notification$Category;

    aput-object v2, v0, v1

    const/4 v1, 0x6

    sget-object v2, Lcom/openfeint/api/Notification$Category;->SocialNotification:Lcom/openfeint/api/Notification$Category;

    aput-object v2, v0, v1

    const/4 v1, 0x7

    sget-object v2, Lcom/openfeint/api/Notification$Category;->Presence:Lcom/openfeint/api/Notification$Category;

    aput-object v2, v0, v1

    const/16 v1, 0x8

    sget-object v2, Lcom/openfeint/api/Notification$Category;->Multiplayer:Lcom/openfeint/api/Notification$Category;

    aput-object v2, v0, v1

    sput-object v0, Lcom/openfeint/api/Notification$Category;->$VALUES:[Lcom/openfeint/api/Notification$Category;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;I)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    return-void
.end method

.method public static valueOf(Ljava/lang/String;)Lcom/openfeint/api/Notification$Category;
    .locals 1

    const-class v0, Lcom/openfeint/api/Notification$Category;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object v0

    check-cast v0, Lcom/openfeint/api/Notification$Category;

    return-object v0
.end method

.method public static values()[Lcom/openfeint/api/Notification$Category;
    .locals 1

    sget-object v0, Lcom/openfeint/api/Notification$Category;->$VALUES:[Lcom/openfeint/api/Notification$Category;

    invoke-virtual {v0}, [Lcom/openfeint/api/Notification$Category;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/openfeint/api/Notification$Category;

    return-object v0
.end method
