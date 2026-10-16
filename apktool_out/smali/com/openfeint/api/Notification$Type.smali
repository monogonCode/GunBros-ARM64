.class public final enum Lcom/openfeint/api/Notification$Type;
.super Ljava/lang/Enum;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/openfeint/api/Notification;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x4019
    name = "Type"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum",
        "<",
        "Lcom/openfeint/api/Notification$Type;",
        ">;"
    }
.end annotation


# static fields
.field private static final synthetic $VALUES:[Lcom/openfeint/api/Notification$Type;

.field public static final enum Downloading:Lcom/openfeint/api/Notification$Type;

.field public static final enum Error:Lcom/openfeint/api/Notification$Type;

.field public static final enum Multiplayer:Lcom/openfeint/api/Notification$Type;

.field public static final enum NetworkOffline:Lcom/openfeint/api/Notification$Type;

.field public static final enum NewMessage:Lcom/openfeint/api/Notification$Type;

.field public static final enum NewResources:Lcom/openfeint/api/Notification$Type;

.field public static final enum None:Lcom/openfeint/api/Notification$Type;

.field public static final enum Submitting:Lcom/openfeint/api/Notification$Type;

.field public static final enum Success:Lcom/openfeint/api/Notification$Type;

.field public static final enum UserPresenceOffline:Lcom/openfeint/api/Notification$Type;

.field public static final enum UserPresenceOnLine:Lcom/openfeint/api/Notification$Type;


# direct methods
.method static constructor <clinit>()V
    .locals 8

    const/4 v7, 0x4

    const/4 v6, 0x3

    const/4 v5, 0x2

    const/4 v4, 0x1

    const/4 v3, 0x0

    new-instance v0, Lcom/openfeint/api/Notification$Type;

    const-string v1, "None"

    invoke-direct {v0, v1, v3}, Lcom/openfeint/api/Notification$Type;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/openfeint/api/Notification$Type;->None:Lcom/openfeint/api/Notification$Type;

    new-instance v0, Lcom/openfeint/api/Notification$Type;

    const-string v1, "Submitting"

    invoke-direct {v0, v1, v4}, Lcom/openfeint/api/Notification$Type;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/openfeint/api/Notification$Type;->Submitting:Lcom/openfeint/api/Notification$Type;

    new-instance v0, Lcom/openfeint/api/Notification$Type;

    const-string v1, "Downloading"

    invoke-direct {v0, v1, v5}, Lcom/openfeint/api/Notification$Type;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/openfeint/api/Notification$Type;->Downloading:Lcom/openfeint/api/Notification$Type;

    new-instance v0, Lcom/openfeint/api/Notification$Type;

    const-string v1, "Error"

    invoke-direct {v0, v1, v6}, Lcom/openfeint/api/Notification$Type;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/openfeint/api/Notification$Type;->Error:Lcom/openfeint/api/Notification$Type;

    new-instance v0, Lcom/openfeint/api/Notification$Type;

    const-string v1, "Success"

    invoke-direct {v0, v1, v7}, Lcom/openfeint/api/Notification$Type;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/openfeint/api/Notification$Type;->Success:Lcom/openfeint/api/Notification$Type;

    new-instance v0, Lcom/openfeint/api/Notification$Type;

    const-string v1, "NewResources"

    const/4 v2, 0x5

    invoke-direct {v0, v1, v2}, Lcom/openfeint/api/Notification$Type;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/openfeint/api/Notification$Type;->NewResources:Lcom/openfeint/api/Notification$Type;

    new-instance v0, Lcom/openfeint/api/Notification$Type;

    const-string v1, "UserPresenceOnLine"

    const/4 v2, 0x6

    invoke-direct {v0, v1, v2}, Lcom/openfeint/api/Notification$Type;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/openfeint/api/Notification$Type;->UserPresenceOnLine:Lcom/openfeint/api/Notification$Type;

    new-instance v0, Lcom/openfeint/api/Notification$Type;

    const-string v1, "UserPresenceOffline"

    const/4 v2, 0x7

    invoke-direct {v0, v1, v2}, Lcom/openfeint/api/Notification$Type;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/openfeint/api/Notification$Type;->UserPresenceOffline:Lcom/openfeint/api/Notification$Type;

    new-instance v0, Lcom/openfeint/api/Notification$Type;

    const-string v1, "NewMessage"

    const/16 v2, 0x8

    invoke-direct {v0, v1, v2}, Lcom/openfeint/api/Notification$Type;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/openfeint/api/Notification$Type;->NewMessage:Lcom/openfeint/api/Notification$Type;

    new-instance v0, Lcom/openfeint/api/Notification$Type;

    const-string v1, "Multiplayer"

    const/16 v2, 0x9

    invoke-direct {v0, v1, v2}, Lcom/openfeint/api/Notification$Type;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/openfeint/api/Notification$Type;->Multiplayer:Lcom/openfeint/api/Notification$Type;

    new-instance v0, Lcom/openfeint/api/Notification$Type;

    const-string v1, "NetworkOffline"

    const/16 v2, 0xa

    invoke-direct {v0, v1, v2}, Lcom/openfeint/api/Notification$Type;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/openfeint/api/Notification$Type;->NetworkOffline:Lcom/openfeint/api/Notification$Type;

    const/16 v0, 0xb

    new-array v0, v0, [Lcom/openfeint/api/Notification$Type;

    sget-object v1, Lcom/openfeint/api/Notification$Type;->None:Lcom/openfeint/api/Notification$Type;

    aput-object v1, v0, v3

    sget-object v1, Lcom/openfeint/api/Notification$Type;->Submitting:Lcom/openfeint/api/Notification$Type;

    aput-object v1, v0, v4

    sget-object v1, Lcom/openfeint/api/Notification$Type;->Downloading:Lcom/openfeint/api/Notification$Type;

    aput-object v1, v0, v5

    sget-object v1, Lcom/openfeint/api/Notification$Type;->Error:Lcom/openfeint/api/Notification$Type;

    aput-object v1, v0, v6

    sget-object v1, Lcom/openfeint/api/Notification$Type;->Success:Lcom/openfeint/api/Notification$Type;

    aput-object v1, v0, v7

    const/4 v1, 0x5

    sget-object v2, Lcom/openfeint/api/Notification$Type;->NewResources:Lcom/openfeint/api/Notification$Type;

    aput-object v2, v0, v1

    const/4 v1, 0x6

    sget-object v2, Lcom/openfeint/api/Notification$Type;->UserPresenceOnLine:Lcom/openfeint/api/Notification$Type;

    aput-object v2, v0, v1

    const/4 v1, 0x7

    sget-object v2, Lcom/openfeint/api/Notification$Type;->UserPresenceOffline:Lcom/openfeint/api/Notification$Type;

    aput-object v2, v0, v1

    const/16 v1, 0x8

    sget-object v2, Lcom/openfeint/api/Notification$Type;->NewMessage:Lcom/openfeint/api/Notification$Type;

    aput-object v2, v0, v1

    const/16 v1, 0x9

    sget-object v2, Lcom/openfeint/api/Notification$Type;->Multiplayer:Lcom/openfeint/api/Notification$Type;

    aput-object v2, v0, v1

    const/16 v1, 0xa

    sget-object v2, Lcom/openfeint/api/Notification$Type;->NetworkOffline:Lcom/openfeint/api/Notification$Type;

    aput-object v2, v0, v1

    sput-object v0, Lcom/openfeint/api/Notification$Type;->$VALUES:[Lcom/openfeint/api/Notification$Type;

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

.method public static valueOf(Ljava/lang/String;)Lcom/openfeint/api/Notification$Type;
    .locals 1

    const-class v0, Lcom/openfeint/api/Notification$Type;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object v0

    check-cast v0, Lcom/openfeint/api/Notification$Type;

    return-object v0
.end method

.method public static values()[Lcom/openfeint/api/Notification$Type;
    .locals 1

    sget-object v0, Lcom/openfeint/api/Notification$Type;->$VALUES:[Lcom/openfeint/api/Notification$Type;

    invoke-virtual {v0}, [Lcom/openfeint/api/Notification$Type;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/openfeint/api/Notification$Type;

    return-object v0
.end method
