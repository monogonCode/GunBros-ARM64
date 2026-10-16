.class final Lcom/glu/platform/android/GluPlatformActivity$5;
.super Landroid/content/BroadcastReceiver;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/glu/platform/android/GluPlatformActivity;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/glu/platform/android/GluPlatformActivity;


# direct methods
.method constructor <init>(Lcom/glu/platform/android/GluPlatformActivity;)V
    .locals 0

    iput-object p1, p0, Lcom/glu/platform/android/GluPlatformActivity$5;->this$0:Lcom/glu/platform/android/GluPlatformActivity;

    invoke-direct {p0}, Landroid/content/BroadcastReceiver;-><init>()V

    return-void
.end method


# virtual methods
.method public final onReceive(Landroid/content/Context;Landroid/content/Intent;)V
    .locals 4

    const-string v0, "com.glu.platform.android.NOTIFICATION_TITLE"

    invoke-virtual {p2, v0}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "com.glu.platform.android.NOTIFICATION_MESSAGE"

    invoke-virtual {p2, v1}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "About to fire notification - title: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ", message: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    iget-object v2, p0, Lcom/glu/platform/android/GluPlatformActivity$5;->this$0:Lcom/glu/platform/android/GluPlatformActivity;

    invoke-static {v2}, Lcom/glu/platform/android/GluPlatformActivity;->access$200(Lcom/glu/platform/android/GluPlatformActivity;)Lcom/glu/platform/android/GluPlatformActivityJNI;

    move-result-object v2

    iget-object v3, p0, Lcom/glu/platform/android/GluPlatformActivity$5;->this$0:Lcom/glu/platform/android/GluPlatformActivity;

    invoke-static {v3}, Lcom/glu/platform/android/GluPlatformActivity;->access$100(Lcom/glu/platform/android/GluPlatformActivity;)I

    move-result v3

    invoke-virtual {v2, v3, v0, v1}, Lcom/glu/platform/android/GluPlatformActivityJNI;->LocalEvent(ILjava/lang/String;Ljava/lang/String;)V

    return-void
.end method
