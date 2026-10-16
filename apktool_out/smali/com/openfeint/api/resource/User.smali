.class public Lcom/openfeint/api/resource/User;
.super Lcom/openfeint/internal/resource/Resource;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/openfeint/api/resource/User$LoadCB;
    }
.end annotation


# instance fields
.field public followedByLocalUser:Z

.field public followsLocalUser:Z

.field public gamerScore:I

.field public lastPlayedGameId:Ljava/lang/String;

.field public lastPlayedGameName:Ljava/lang/String;

.field public latitude:D

.field public longitude:D

.field public name:Ljava/lang/String;

.field public online:Z

.field public profilePictureSource:Ljava/lang/String;

.field public profilePictureUrl:Ljava/lang/String;

.field public usesFacebookProfilePicture:Z


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Lcom/openfeint/internal/resource/Resource;-><init>()V

    return-void
.end method

.method public static getResourceClass()Lcom/openfeint/internal/resource/ResourceClass;
    .locals 4

    new-instance v0, Lcom/openfeint/api/resource/User$6;

    const-class v1, Lcom/openfeint/api/resource/User;

    const-string v2, "user"

    invoke-direct {v0, v1, v2}, Lcom/openfeint/api/resource/User$6;-><init>(Ljava/lang/Class;Ljava/lang/String;)V

    iget-object v1, v0, Lcom/openfeint/internal/resource/ResourceClass;->mProperties:Ljava/util/HashMap;

    const-string v2, "name"

    new-instance v3, Lcom/openfeint/api/resource/User$7;

    invoke-direct {v3}, Lcom/openfeint/api/resource/User$7;-><init>()V

    invoke-virtual {v1, v2, v3}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v1, v0, Lcom/openfeint/internal/resource/ResourceClass;->mProperties:Ljava/util/HashMap;

    const-string v2, "profile_picture_url"

    new-instance v3, Lcom/openfeint/api/resource/User$8;

    invoke-direct {v3}, Lcom/openfeint/api/resource/User$8;-><init>()V

    invoke-virtual {v1, v2, v3}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v1, v0, Lcom/openfeint/internal/resource/ResourceClass;->mProperties:Ljava/util/HashMap;

    const-string v2, "profile_picture_source"

    new-instance v3, Lcom/openfeint/api/resource/User$9;

    invoke-direct {v3}, Lcom/openfeint/api/resource/User$9;-><init>()V

    invoke-virtual {v1, v2, v3}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v1, v0, Lcom/openfeint/internal/resource/ResourceClass;->mProperties:Ljava/util/HashMap;

    const-string v2, "uses_facebook_profile_picture"

    new-instance v3, Lcom/openfeint/api/resource/User$10;

    invoke-direct {v3}, Lcom/openfeint/api/resource/User$10;-><init>()V

    invoke-virtual {v1, v2, v3}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v1, v0, Lcom/openfeint/internal/resource/ResourceClass;->mProperties:Ljava/util/HashMap;

    const-string v2, "last_played_game_id"

    new-instance v3, Lcom/openfeint/api/resource/User$11;

    invoke-direct {v3}, Lcom/openfeint/api/resource/User$11;-><init>()V

    invoke-virtual {v1, v2, v3}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v1, v0, Lcom/openfeint/internal/resource/ResourceClass;->mProperties:Ljava/util/HashMap;

    const-string v2, "last_played_game_name"

    new-instance v3, Lcom/openfeint/api/resource/User$12;

    invoke-direct {v3}, Lcom/openfeint/api/resource/User$12;-><init>()V

    invoke-virtual {v1, v2, v3}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v1, v0, Lcom/openfeint/internal/resource/ResourceClass;->mProperties:Ljava/util/HashMap;

    const-string v2, "gamer_score"

    new-instance v3, Lcom/openfeint/api/resource/User$13;

    invoke-direct {v3}, Lcom/openfeint/api/resource/User$13;-><init>()V

    invoke-virtual {v1, v2, v3}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v1, v0, Lcom/openfeint/internal/resource/ResourceClass;->mProperties:Ljava/util/HashMap;

    const-string v2, "following_local_user"

    new-instance v3, Lcom/openfeint/api/resource/User$14;

    invoke-direct {v3}, Lcom/openfeint/api/resource/User$14;-><init>()V

    invoke-virtual {v1, v2, v3}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v1, v0, Lcom/openfeint/internal/resource/ResourceClass;->mProperties:Ljava/util/HashMap;

    const-string v2, "followed_by_local_user"

    new-instance v3, Lcom/openfeint/api/resource/User$15;

    invoke-direct {v3}, Lcom/openfeint/api/resource/User$15;-><init>()V

    invoke-virtual {v1, v2, v3}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v1, v0, Lcom/openfeint/internal/resource/ResourceClass;->mProperties:Ljava/util/HashMap;

    const-string v2, "online"

    new-instance v3, Lcom/openfeint/api/resource/User$16;

    invoke-direct {v3}, Lcom/openfeint/api/resource/User$16;-><init>()V

    invoke-virtual {v1, v2, v3}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v1, v0, Lcom/openfeint/internal/resource/ResourceClass;->mProperties:Ljava/util/HashMap;

    const-string v2, "lat"

    new-instance v3, Lcom/openfeint/api/resource/User$17;

    invoke-direct {v3}, Lcom/openfeint/api/resource/User$17;-><init>()V

    invoke-virtual {v1, v2, v3}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v1, v0, Lcom/openfeint/internal/resource/ResourceClass;->mProperties:Ljava/util/HashMap;

    const-string v2, "lng"

    new-instance v3, Lcom/openfeint/api/resource/User$18;

    invoke-direct {v3}, Lcom/openfeint/api/resource/User$18;-><init>()V

    invoke-virtual {v1, v2, v3}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    return-object v0
.end method


# virtual methods
.method public final load$70059c05()V
    .locals 1

    new-instance v0, Lcom/openfeint/api/resource/User$1;

    invoke-direct {v0, p0}, Lcom/openfeint/api/resource/User$1;-><init>(Lcom/openfeint/api/resource/User;)V

    invoke-virtual {v0}, Lcom/openfeint/internal/request/JSONRequest;->launch()V

    return-void
.end method

.method public final userID()Ljava/lang/String;
    .locals 1

    invoke-virtual {p0}, Lcom/openfeint/api/resource/User;->resourceID()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
