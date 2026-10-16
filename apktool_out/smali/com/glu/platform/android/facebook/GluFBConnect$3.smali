.class final Lcom/glu/platform/android/facebook/GluFBConnect$3;
.super Landroid/os/Handler;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/glu/platform/android/facebook/GluFBConnect;
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

    iput-object p1, p0, Lcom/glu/platform/android/facebook/GluFBConnect$3;->this$0:Lcom/glu/platform/android/facebook/GluFBConnect;

    invoke-direct {p0}, Landroid/os/Handler;-><init>()V

    return-void
.end method


# virtual methods
.method public final handleMessage(Landroid/os/Message;)V
    .locals 5

    const/4 v2, 0x7

    const/4 v4, 0x0

    iget v0, p1, Landroid/os/Message;->what:I

    const/4 v1, 0x1

    if-ne v0, v1, :cond_1

    sput v2, Lcom/glu/platform/android/facebook/GluFBConnect;->m_facebookState:I

    new-instance v0, Lcom/glu/platform/android/facebook/MixedHash;

    invoke-direct {v0}, Lcom/glu/platform/android/facebook/MixedHash;-><init>()V

    invoke-static {}, Lcom/glu/platform/android/facebook/Debug;->log$552c4e01()V

    const-string v1, "name"

    iget-object v2, p0, Lcom/glu/platform/android/facebook/GluFBConnect$3;->this$0:Lcom/glu/platform/android/facebook/GluFBConnect;

    iget-object v2, v2, Lcom/glu/platform/android/facebook/GluFBConnect;->m_header:Ljava/lang/String;

    invoke-virtual {v0, v1, v2}, Lcom/glu/platform/android/facebook/MixedHash;->putString(Ljava/lang/String;Ljava/lang/String;)V

    const-string v1, "href"

    const-string v2, "https://market.android.com/details?id="

    invoke-virtual {v0, v1, v2}, Lcom/glu/platform/android/facebook/MixedHash;->putString(Ljava/lang/String;Ljava/lang/String;)V

    const-string v1, "description"

    iget-object v2, p0, Lcom/glu/platform/android/facebook/GluFBConnect$3;->this$0:Lcom/glu/platform/android/facebook/GluFBConnect;

    iget-object v2, v2, Lcom/glu/platform/android/facebook/GluFBConnect;->m_body:Ljava/lang/String;

    invoke-virtual {v0, v1, v2}, Lcom/glu/platform/android/facebook/MixedHash;->putString(Ljava/lang/String;Ljava/lang/String;)V

    new-instance v1, Lcom/glu/platform/android/facebook/MixedHash;

    invoke-direct {v1}, Lcom/glu/platform/android/facebook/MixedHash;-><init>()V

    const-string v2, "type"

    const-string v3, "image"

    invoke-virtual {v1, v2, v3}, Lcom/glu/platform/android/facebook/MixedHash;->putString(Ljava/lang/String;Ljava/lang/String;)V

    const-string v2, "src"

    const-string v3, "http://gcs.glu.com/gcs/images/gunbros2.0_ANDROID_114icon.PNG"

    invoke-virtual {v1, v2, v3}, Lcom/glu/platform/android/facebook/MixedHash;->putString(Ljava/lang/String;Ljava/lang/String;)V

    const-string v2, "href"

    const-string v3, "https://market.android.com/details?id="

    invoke-virtual {v1, v2, v3}, Lcom/glu/platform/android/facebook/MixedHash;->putString(Ljava/lang/String;Ljava/lang/String;)V

    new-instance v2, Ljava/util/Vector;

    invoke-direct {v2}, Ljava/util/Vector;-><init>()V

    invoke-virtual {v2, v1}, Ljava/util/Vector;->addElement(Ljava/lang/Object;)V

    const-string v1, "media"

    invoke-virtual {v0, v1, v2}, Lcom/glu/platform/android/facebook/MixedHash;->putMixedHashVector(Ljava/lang/String;Ljava/util/Vector;)V

    new-instance v0, Lcom/glu/platform/android/facebook/MixedHash;

    invoke-direct {v0}, Lcom/glu/platform/android/facebook/MixedHash;-><init>()V

    const-string v1, "text"

    iget-object v2, p0, Lcom/glu/platform/android/facebook/GluFBConnect$3;->this$0:Lcom/glu/platform/android/facebook/GluFBConnect;

    iget-object v2, v2, Lcom/glu/platform/android/facebook/GluFBConnect;->m_prompt:Ljava/lang/String;

    invoke-virtual {v0, v1, v2}, Lcom/glu/platform/android/facebook/MixedHash;->putString(Ljava/lang/String;Ljava/lang/String;)V

    const-string v1, "href"

    const-string v2, "https://market.android.com/details?id="

    invoke-virtual {v0, v1, v2}, Lcom/glu/platform/android/facebook/MixedHash;->putString(Ljava/lang/String;Ljava/lang/String;)V

    new-instance v0, Landroid/os/Bundle;

    invoke-direct {v0}, Landroid/os/Bundle;-><init>()V

    const-string v1, "user_message_prompt"

    iget-object v2, p0, Lcom/glu/platform/android/facebook/GluFBConnect$3;->this$0:Lcom/glu/platform/android/facebook/GluFBConnect;

    iget-object v2, v2, Lcom/glu/platform/android/facebook/GluFBConnect;->m_prompt:Ljava/lang/String;

    invoke-virtual {v0, v1, v2}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    iget-object v0, p0, Lcom/glu/platform/android/facebook/GluFBConnect$3;->this$0:Lcom/glu/platform/android/facebook/GluFBConnect;

    iput-object v4, v0, Lcom/glu/platform/android/facebook/GluFBConnect;->m_prompt:Ljava/lang/String;

    iget-object v0, p0, Lcom/glu/platform/android/facebook/GluFBConnect$3;->this$0:Lcom/glu/platform/android/facebook/GluFBConnect;

    iput-object v4, v0, Lcom/glu/platform/android/facebook/GluFBConnect;->m_header:Ljava/lang/String;

    iget-object v0, p0, Lcom/glu/platform/android/facebook/GluFBConnect$3;->this$0:Lcom/glu/platform/android/facebook/GluFBConnect;

    iput-object v4, v0, Lcom/glu/platform/android/facebook/GluFBConnect;->m_body:Ljava/lang/String;

    :cond_0
    :goto_0
    return-void

    :cond_1
    iget v0, p1, Landroid/os/Message;->what:I

    const/4 v1, 0x2

    if-ne v0, v1, :cond_0

    sput v2, Lcom/glu/platform/android/facebook/GluFBConnect;->m_facebookState:I

    new-instance v1, Lcom/glu/platform/android/facebook/MixedHash;

    invoke-direct {v1}, Lcom/glu/platform/android/facebook/MixedHash;-><init>()V

    invoke-static {}, Lcom/glu/platform/android/facebook/Debug;->log$552c4e01()V

    new-instance v2, Lcom/glu/platform/android/facebook/MixedHash;

    invoke-direct {v2}, Lcom/glu/platform/android/facebook/MixedHash;-><init>()V

    const-string v0, "type"

    const-string v3, "image"

    invoke-virtual {v2, v0, v3}, Lcom/glu/platform/android/facebook/MixedHash;->putString(Ljava/lang/String;Ljava/lang/String;)V

    const-string v3, "src"

    iget-object v0, p0, Lcom/glu/platform/android/facebook/GluFBConnect$3;->this$0:Lcom/glu/platform/android/facebook/GluFBConnect;

    iget-object v0, v0, Lcom/glu/platform/android/facebook/GluFBConnect;->m_friendLinkImageURL:Ljava/lang/String;

    if-nez v0, :cond_2

    const-string v0, "http://gcs.glu.com/gcs/images/gunbros2.0_ANDROID_114icon.PNG"

    :goto_1
    invoke-virtual {v2, v3, v0}, Lcom/glu/platform/android/facebook/MixedHash;->putString(Ljava/lang/String;Ljava/lang/String;)V

    const-string v3, "href"

    iget-object v0, p0, Lcom/glu/platform/android/facebook/GluFBConnect$3;->this$0:Lcom/glu/platform/android/facebook/GluFBConnect;

    iget-object v0, v0, Lcom/glu/platform/android/facebook/GluFBConnect;->m_friendLink:Ljava/lang/String;

    if-nez v0, :cond_3

    const-string v0, "https://market.android.com/details?id="

    :goto_2
    invoke-virtual {v2, v3, v0}, Lcom/glu/platform/android/facebook/MixedHash;->putString(Ljava/lang/String;Ljava/lang/String;)V

    new-instance v0, Ljava/util/Vector;

    invoke-direct {v0}, Ljava/util/Vector;-><init>()V

    invoke-virtual {v0, v2}, Ljava/util/Vector;->addElement(Ljava/lang/Object;)V

    const-string v2, "media"

    invoke-virtual {v1, v2, v0}, Lcom/glu/platform/android/facebook/MixedHash;->putMixedHashVector(Ljava/lang/String;Ljava/util/Vector;)V

    new-instance v1, Lcom/glu/platform/android/facebook/MixedHash;

    invoke-direct {v1}, Lcom/glu/platform/android/facebook/MixedHash;-><init>()V

    const-string v2, "text"

    iget-object v0, p0, Lcom/glu/platform/android/facebook/GluFBConnect$3;->this$0:Lcom/glu/platform/android/facebook/GluFBConnect;

    iget-object v0, v0, Lcom/glu/platform/android/facebook/GluFBConnect;->m_friendLinkText:Ljava/lang/String;

    if-nez v0, :cond_4

    const-string v0, "Gun Bros"

    :goto_3
    invoke-virtual {v1, v2, v0}, Lcom/glu/platform/android/facebook/MixedHash;->putString(Ljava/lang/String;Ljava/lang/String;)V

    const-string v2, "href"

    iget-object v0, p0, Lcom/glu/platform/android/facebook/GluFBConnect$3;->this$0:Lcom/glu/platform/android/facebook/GluFBConnect;

    iget-object v0, v0, Lcom/glu/platform/android/facebook/GluFBConnect;->m_friendLink:Ljava/lang/String;

    if-nez v0, :cond_5

    const-string v0, "https://market.android.com/details?id="

    :goto_4
    invoke-virtual {v1, v2, v0}, Lcom/glu/platform/android/facebook/MixedHash;->putString(Ljava/lang/String;Ljava/lang/String;)V

    new-instance v0, Landroid/os/Bundle;

    invoke-direct {v0}, Landroid/os/Bundle;-><init>()V

    const-string v1, "message"

    iget-object v2, p0, Lcom/glu/platform/android/facebook/GluFBConnect$3;->this$0:Lcom/glu/platform/android/facebook/GluFBConnect;

    iget-object v2, v2, Lcom/glu/platform/android/facebook/GluFBConnect;->m_friendMessage:Ljava/lang/String;

    invoke-virtual {v0, v1, v2}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    const-string v1, "target_id"

    iget-object v2, p0, Lcom/glu/platform/android/facebook/GluFBConnect$3;->this$0:Lcom/glu/platform/android/facebook/GluFBConnect;

    iget-object v2, v2, Lcom/glu/platform/android/facebook/GluFBConnect;->m_friendUID:Ljava/lang/String;

    invoke-virtual {v0, v1, v2}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    iget-object v0, p0, Lcom/glu/platform/android/facebook/GluFBConnect$3;->this$0:Lcom/glu/platform/android/facebook/GluFBConnect;

    iput-object v4, v0, Lcom/glu/platform/android/facebook/GluFBConnect;->m_friendMessage:Ljava/lang/String;

    iget-object v0, p0, Lcom/glu/platform/android/facebook/GluFBConnect$3;->this$0:Lcom/glu/platform/android/facebook/GluFBConnect;

    iput-object v4, v0, Lcom/glu/platform/android/facebook/GluFBConnect;->m_friendUID:Ljava/lang/String;

    iget-object v0, p0, Lcom/glu/platform/android/facebook/GluFBConnect$3;->this$0:Lcom/glu/platform/android/facebook/GluFBConnect;

    iput-object v4, v0, Lcom/glu/platform/android/facebook/GluFBConnect;->m_friendLink:Ljava/lang/String;

    iget-object v0, p0, Lcom/glu/platform/android/facebook/GluFBConnect$3;->this$0:Lcom/glu/platform/android/facebook/GluFBConnect;

    iput-object v4, v0, Lcom/glu/platform/android/facebook/GluFBConnect;->m_friendLinkText:Ljava/lang/String;

    iget-object v0, p0, Lcom/glu/platform/android/facebook/GluFBConnect$3;->this$0:Lcom/glu/platform/android/facebook/GluFBConnect;

    iput-object v4, v0, Lcom/glu/platform/android/facebook/GluFBConnect;->m_friendLinkImageURL:Ljava/lang/String;

    goto/16 :goto_0

    :cond_2
    iget-object v0, p0, Lcom/glu/platform/android/facebook/GluFBConnect$3;->this$0:Lcom/glu/platform/android/facebook/GluFBConnect;

    iget-object v0, v0, Lcom/glu/platform/android/facebook/GluFBConnect;->m_friendLinkImageURL:Ljava/lang/String;

    goto :goto_1

    :cond_3
    iget-object v0, p0, Lcom/glu/platform/android/facebook/GluFBConnect$3;->this$0:Lcom/glu/platform/android/facebook/GluFBConnect;

    iget-object v0, v0, Lcom/glu/platform/android/facebook/GluFBConnect;->m_friendLink:Ljava/lang/String;

    goto :goto_2

    :cond_4
    iget-object v0, p0, Lcom/glu/platform/android/facebook/GluFBConnect$3;->this$0:Lcom/glu/platform/android/facebook/GluFBConnect;

    iget-object v0, v0, Lcom/glu/platform/android/facebook/GluFBConnect;->m_friendLinkText:Ljava/lang/String;

    goto :goto_3

    :cond_5
    iget-object v0, p0, Lcom/glu/platform/android/facebook/GluFBConnect$3;->this$0:Lcom/glu/platform/android/facebook/GluFBConnect;

    iget-object v0, v0, Lcom/glu/platform/android/facebook/GluFBConnect;->m_friendLink:Ljava/lang/String;

    goto :goto_4
.end method
