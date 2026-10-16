.class final Lcom/glu/platform/android/facebook/GluFBConnect$2;
.super Lcom/facebook/android/AsyncRequestListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/glu/platform/android/facebook/GluFBConnect;->getUserInfo()V
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

    iput-object p1, p0, Lcom/glu/platform/android/facebook/GluFBConnect$2;->this$0:Lcom/glu/platform/android/facebook/GluFBConnect;

    invoke-direct {p0}, Lcom/facebook/android/AsyncRequestListener;-><init>()V

    return-void
.end method


# virtual methods
.method public final onComplete(Lorg/json/JSONObject;)V
    .locals 6

    const/4 v5, 0x0

    :try_start_0
    const-string v0, "id"

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "name"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-static {}, Lcom/glu/platform/android/facebook/Debug;->log$552c4e01()V

    sget-object v2, Lcom/glu/platform/android/GluPlatformActivity;->instance:Lcom/glu/platform/android/GluPlatformActivity;

    const/4 v3, 0x6

    const/4 v4, 0x0

    invoke-static {v0}, Lcom/glu/platform/android/facebook/GluUtil;->stringToNativeByteArray(Ljava/lang/String;)[B

    move-result-object v0

    invoke-virtual {v2, v3, v4, v0}, Lcom/glu/platform/android/GluPlatformActivity;->javaToNativeFacebook(II[B)V

    sget-object v0, Lcom/glu/platform/android/GluPlatformActivity;->instance:Lcom/glu/platform/android/GluPlatformActivity;

    const/16 v2, 0x8

    const/4 v3, 0x0

    invoke-static {v1}, Lcom/glu/platform/android/facebook/GluUtil;->stringToNativeByteArray(Ljava/lang/String;)[B

    move-result-object v1

    invoke-virtual {v0, v2, v3, v1}, Lcom/glu/platform/android/GluPlatformActivity;->javaToNativeFacebook(II[B)V

    sget-object v0, Lcom/glu/platform/android/GluPlatformActivity;->instance:Lcom/glu/platform/android/GluPlatformActivity;

    const/4 v1, 0x4

    const/4 v2, 0x1

    const/4 v3, 0x0

    invoke-virtual {v0, v1, v2, v3}, Lcom/glu/platform/android/GluPlatformActivity;->javaToNativeFacebook(II[B)V

    const/4 v0, 0x1

    invoke-virtual {p0, v0}, Lcom/glu/platform/android/facebook/GluFBConnect$2;->wrapUp(Z)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return-void

    :catch_0
    move-exception v0

    invoke-static {}, Lcom/glu/platform/android/facebook/Debug;->log$2d473e19()V

    invoke-virtual {p0, v5}, Lcom/glu/platform/android/facebook/GluFBConnect$2;->wrapUp(Z)V

    goto :goto_0
.end method

.method public final wrapUp(Z)V
    .locals 4

    const/4 v3, 0x0

    const/4 v2, 0x5

    if-nez p1, :cond_0

    sget-object v0, Lcom/glu/platform/android/GluPlatformActivity;->instance:Lcom/glu/platform/android/GluPlatformActivity;

    const/4 v1, 0x4

    invoke-virtual {v0, v1, v2, v3}, Lcom/glu/platform/android/GluPlatformActivity;->javaToNativeFacebook(II[B)V

    sput v2, Lcom/glu/platform/android/facebook/GluFBConnect;->m_facebookState:I

    :cond_0
    iget-object v0, p0, Lcom/glu/platform/android/facebook/GluFBConnect$2;->this$0:Lcom/glu/platform/android/facebook/GluFBConnect;

    invoke-static {v0, v3}, Lcom/glu/platform/android/facebook/GluFBConnect;->access$102(Lcom/glu/platform/android/facebook/GluFBConnect;Lcom/facebook/android/AsyncFacebookRunner;)Lcom/facebook/android/AsyncFacebookRunner;

    return-void
.end method
