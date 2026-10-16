.class Lcom/urbanairship/push/PushManager$UpdateApidReceiver;
.super Landroid/content/BroadcastReceiver;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/urbanairship/push/PushManager;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "UpdateApidReceiver"
.end annotation


# instance fields
.field final synthetic this$0:Lcom/urbanairship/push/PushManager;


# direct methods
.method private constructor <init>(Lcom/urbanairship/push/PushManager;)V
    .locals 0

    iput-object p1, p0, Lcom/urbanairship/push/PushManager$UpdateApidReceiver;->this$0:Lcom/urbanairship/push/PushManager;

    invoke-direct {p0}, Landroid/content/BroadcastReceiver;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lcom/urbanairship/push/PushManager;Lcom/urbanairship/push/PushManager$1;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/urbanairship/push/PushManager$UpdateApidReceiver;-><init>(Lcom/urbanairship/push/PushManager;)V

    return-void
.end method


# virtual methods
.method public onReceive(Landroid/content/Context;Landroid/content/Intent;)V
    .locals 1

    iget-object v0, p0, Lcom/urbanairship/push/PushManager$UpdateApidReceiver;->this$0:Lcom/urbanairship/push/PushManager;

    invoke-static {v0}, Lcom/urbanairship/push/PushManager;->access$400(Lcom/urbanairship/push/PushManager;)V

    return-void
.end method
