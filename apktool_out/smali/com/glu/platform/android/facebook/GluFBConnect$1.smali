.class final Lcom/glu/platform/android/facebook/GluFBConnect$1;
.super Lcom/facebook/android/AsyncRequestListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/glu/platform/android/facebook/GluFBConnect;->loadFriends()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/glu/platform/android/facebook/GluFBConnect;


# direct methods
.method constructor <init>(Lcom/glu/platform/android/facebook/GluFBConnect;)V
    .locals 0

    iput-object p1, p0, Lcom/glu/platform/android/facebook/GluFBConnect$1;->this$0:Lcom/glu/platform/android/facebook/GluFBConnect;

    invoke-direct {p0}, Lcom/facebook/android/AsyncRequestListener;-><init>()V

    return-void
.end method


# virtual methods
.method public final onComplete(Lorg/json/JSONObject;)V
    .locals 10

    const/4 v1, 0x0

    const/4 v3, 0x0

    :try_start_0
    const-string v0, "data"

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->getJSONArray(Ljava/lang/String;)Lorg/json/JSONArray;

    move-result-object v4

    invoke-virtual {v4}, Lorg/json/JSONArray;->length()I

    move-result v0

    sget-boolean v2, Lcom/glu/platform/android/facebook/GluFBConnect;->FIVE_THOUSAND_FRIENDS_TEST:Z

    if-eqz v2, :cond_2

    const/16 v0, 0x1388

    const/16 v1, 0x2710

    new-array v1, v1, [[C

    iget-object v2, p0, Lcom/glu/platform/android/facebook/GluFBConnect$1;->this$0:Lcom/glu/platform/android/facebook/GluFBConnect;

    array-length v4, v1

    new-array v4, v4, [Ljava/lang/String;

    iput-object v4, v2, Lcom/glu/platform/android/facebook/GluFBConnect;->m_friendInfo:[Ljava/lang/String;

    move v5, v3

    :goto_0
    const/16 v2, 0xc8

    if-ge v5, v2, :cond_4

    move v4, v3

    :goto_1
    const/16 v2, 0x19

    if-ge v4, v2, :cond_1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v6, Lcom/glu/platform/android/facebook/GluFBConnect;->FIVE_THOUSAND_UIDS:[J

    aget-wide v6, v6, v4

    int-to-long v8, v5

    add-long/2addr v6, v8

    invoke-virtual {v2, v6, v7}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v6, ""

    invoke-virtual {v2, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v7, Lcom/glu/platform/android/facebook/GluFBConnect;->FIVE_THOUSAND_NAMES:[Ljava/lang/String;

    aget-object v7, v7, v4

    invoke-virtual {v2, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    if-nez v5, :cond_0

    const-string v2, ""

    :goto_2
    invoke-virtual {v7, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "uid["

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    mul-int/lit8 v8, v5, 0x19

    add-int/2addr v8, v4

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, "] = "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, ", name["

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    mul-int/lit8 v8, v5, 0x19

    add-int/2addr v8, v4

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, "] = "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    invoke-static {}, Lcom/glu/platform/android/facebook/Debug;->log$552c4e01()V

    iget-object v7, p0, Lcom/glu/platform/android/facebook/GluFBConnect$1;->this$0:Lcom/glu/platform/android/facebook/GluFBConnect;

    iget-object v7, v7, Lcom/glu/platform/android/facebook/GluFBConnect;->m_friendInfo:[Ljava/lang/String;

    mul-int/lit8 v8, v5, 0x19

    add-int/2addr v8, v4

    mul-int/lit8 v8, v8, 0x2

    add-int/lit8 v8, v8, 0x0

    aput-object v6, v7, v8

    iget-object v7, p0, Lcom/glu/platform/android/facebook/GluFBConnect$1;->this$0:Lcom/glu/platform/android/facebook/GluFBConnect;

    iget-object v7, v7, Lcom/glu/platform/android/facebook/GluFBConnect;->m_friendInfo:[Ljava/lang/String;

    mul-int/lit8 v8, v5, 0x19

    add-int/2addr v8, v4

    mul-int/lit8 v8, v8, 0x2

    add-int/lit8 v8, v8, 0x1

    aput-object v2, v7, v8

    mul-int/lit8 v7, v5, 0x19

    add-int/2addr v7, v4

    mul-int/lit8 v7, v7, 0x2

    add-int/lit8 v7, v7, 0x0

    invoke-static {v6}, Lcom/glu/platform/android/facebook/GluUtil;->stringToNativeCharArray(Ljava/lang/String;)[C

    move-result-object v6

    aput-object v6, v1, v7

    mul-int/lit8 v6, v5, 0x19

    add-int/2addr v6, v4

    mul-int/lit8 v6, v6, 0x2

    add-int/lit8 v6, v6, 0x1

    invoke-static {v2}, Lcom/glu/platform/android/facebook/GluUtil;->stringToNativeCharArray(Ljava/lang/String;)[C

    move-result-object v2

    aput-object v2, v1, v6

    add-int/lit8 v2, v4, 0x1

    move v4, v2

    goto/16 :goto_1

    :cond_0
    add-int/lit16 v2, v5, 0x121

    int-to-char v2, v2

    invoke-static {v2}, Ljava/lang/Character;->valueOf(C)Ljava/lang/Character;

    move-result-object v2

    goto/16 :goto_2

    :cond_1
    add-int/lit8 v2, v5, 0x1

    move v5, v2

    goto/16 :goto_0

    :cond_2
    if-lez v0, :cond_3

    mul-int/lit8 v1, v0, 0x2

    new-array v1, v1, [[C

    :cond_3
    iget-object v2, p0, Lcom/glu/platform/android/facebook/GluFBConnect$1;->this$0:Lcom/glu/platform/android/facebook/GluFBConnect;

    mul-int/lit8 v5, v0, 0x2

    new-array v5, v5, [Ljava/lang/String;

    iput-object v5, v2, Lcom/glu/platform/android/facebook/GluFBConnect;->m_friendInfo:[Ljava/lang/String;

    iget-object v2, p0, Lcom/glu/platform/android/facebook/GluFBConnect$1;->this$0:Lcom/glu/platform/android/facebook/GluFBConnect;

    iget-object v2, v2, Lcom/glu/platform/android/facebook/GluFBConnect;->m_quickAccessFriendInfo:Ljava/util/Hashtable;

    invoke-virtual {v2}, Ljava/util/Hashtable;->clear()V

    move v2, v3

    :goto_3
    if-ge v2, v0, :cond_4

    invoke-virtual {v4, v2}, Lorg/json/JSONArray;->getJSONObject(I)Lorg/json/JSONObject;

    move-result-object v5

    const-string v6, "id"

    invoke-virtual {v5, v6}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    const-string v7, "name"

    invoke-virtual {v5, v7}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "uid["

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, "] = "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, ", name["

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, "] = "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    invoke-static {}, Lcom/glu/platform/android/facebook/Debug;->log$552c4e01()V

    iget-object v7, p0, Lcom/glu/platform/android/facebook/GluFBConnect$1;->this$0:Lcom/glu/platform/android/facebook/GluFBConnect;

    iget-object v7, v7, Lcom/glu/platform/android/facebook/GluFBConnect;->m_friendInfo:[Ljava/lang/String;

    mul-int/lit8 v8, v2, 0x2

    add-int/lit8 v8, v8, 0x0

    aput-object v6, v7, v8

    iget-object v7, p0, Lcom/glu/platform/android/facebook/GluFBConnect$1;->this$0:Lcom/glu/platform/android/facebook/GluFBConnect;

    iget-object v7, v7, Lcom/glu/platform/android/facebook/GluFBConnect;->m_friendInfo:[Ljava/lang/String;

    mul-int/lit8 v8, v2, 0x2

    add-int/lit8 v8, v8, 0x1

    aput-object v5, v7, v8

    mul-int/lit8 v7, v2, 0x2

    add-int/lit8 v7, v7, 0x0

    invoke-static {v6}, Lcom/glu/platform/android/facebook/GluUtil;->stringToNativeCharArray(Ljava/lang/String;)[C

    move-result-object v8

    aput-object v8, v1, v7

    mul-int/lit8 v7, v2, 0x2

    add-int/lit8 v7, v7, 0x1

    invoke-static {v5}, Lcom/glu/platform/android/facebook/GluUtil;->stringToNativeCharArray(Ljava/lang/String;)[C

    move-result-object v8

    aput-object v8, v1, v7

    iget-object v7, p0, Lcom/glu/platform/android/facebook/GluFBConnect$1;->this$0:Lcom/glu/platform/android/facebook/GluFBConnect;

    iget-object v7, v7, Lcom/glu/platform/android/facebook/GluFBConnect;->m_quickAccessFriendInfo:Ljava/util/Hashtable;

    invoke-virtual {v7, v6, v5}, Ljava/util/Hashtable;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    add-int/lit8 v2, v2, 0x1

    goto :goto_3

    :cond_4
    const/4 v2, 0x1

    invoke-virtual {p0, v2}, Lcom/glu/platform/android/facebook/GluFBConnect$1;->wrapUp(Z)V

    invoke-static {}, Lcom/glu/platform/android/facebook/Debug;->log$552c4e01()V

    sget-object v2, Lcom/glu/platform/android/GluPlatformActivity;->instance:Lcom/glu/platform/android/GluPlatformActivity;

    const/16 v4, 0x9

    const/4 v5, 0x0

    invoke-virtual {v2, v4, v0, v5, v1}, Lcom/glu/platform/android/GluPlatformActivity;->javaToNativeFacebook(II[B[[C)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :goto_4
    return-void

    :catch_0
    move-exception v0

    invoke-static {}, Lcom/glu/platform/android/facebook/Debug;->log$2d473e19()V

    invoke-virtual {p0, v3}, Lcom/glu/platform/android/facebook/GluFBConnect$1;->wrapUp(Z)V

    goto :goto_4
.end method

.method public final wrapUp(Z)V
    .locals 2

    iget-object v0, p0, Lcom/glu/platform/android/facebook/GluFBConnect$1;->this$0:Lcom/glu/platform/android/facebook/GluFBConnect;

    const/4 v1, 0x0

    invoke-static {v0, v1}, Lcom/glu/platform/android/facebook/GluFBConnect;->access$002(Lcom/glu/platform/android/facebook/GluFBConnect;Lcom/facebook/android/AsyncFacebookRunner;)Lcom/facebook/android/AsyncFacebookRunner;

    return-void
.end method
