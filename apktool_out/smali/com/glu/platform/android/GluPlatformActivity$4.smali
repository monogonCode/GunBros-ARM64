.class final Lcom/glu/platform/android/GluPlatformActivity$4;
.super Landroid/os/Handler;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/glu/platform/android/GluPlatformActivity;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# static fields
.field static final synthetic $assertionsDisabled:Z


# instance fields
.field final synthetic this$0:Lcom/glu/platform/android/GluPlatformActivity;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    const-class v0, Lcom/glu/platform/android/GluPlatformActivity;

    invoke-virtual {v0}, Ljava/lang/Class;->desiredAssertionStatus()Z

    move-result v0

    if-nez v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    sput-boolean v0, Lcom/glu/platform/android/GluPlatformActivity$4;->$assertionsDisabled:Z

    return-void

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method constructor <init>(Lcom/glu/platform/android/GluPlatformActivity;)V
    .locals 0

    iput-object p1, p0, Lcom/glu/platform/android/GluPlatformActivity$4;->this$0:Lcom/glu/platform/android/GluPlatformActivity;

    invoke-direct {p0}, Landroid/os/Handler;-><init>()V

    return-void
.end method


# virtual methods
.method public final handleMessage(Landroid/os/Message;)V
    .locals 1

    iget v0, p1, Landroid/os/Message;->what:I

    packed-switch v0, :pswitch_data_0

    :pswitch_0
    sget-boolean v0, Lcom/glu/platform/android/GluPlatformActivity$4;->$assertionsDisabled:Z

    if-nez v0, :cond_0

    new-instance v0, Ljava/lang/AssertionError;

    invoke-direct {v0}, Ljava/lang/AssertionError;-><init>()V

    throw v0

    :pswitch_1
    iget-object v0, p0, Lcom/glu/platform/android/GluPlatformActivity$4;->this$0:Lcom/glu/platform/android/GluPlatformActivity;

    invoke-virtual {v0}, Lcom/glu/platform/android/GluPlatformActivity;->finish()V

    :cond_0
    :goto_0
    return-void

    :pswitch_2
    sget-object v0, Lcom/glu/platform/android/facebook/GluFBConnect;->instance:Lcom/glu/platform/android/facebook/GluFBConnect;

    invoke-virtual {v0}, Lcom/glu/platform/android/facebook/GluFBConnect;->login()V

    goto :goto_0

    :pswitch_3
    sget-object v0, Lcom/glu/platform/android/facebook/GluFBConnect;->instance:Lcom/glu/platform/android/facebook/GluFBConnect;

    invoke-virtual {v0}, Lcom/glu/platform/android/facebook/GluFBConnect;->logout()V

    goto :goto_0

    :pswitch_4
    sget-object v0, Lcom/glu/android/tools/community/GluOpenFeint;->instance:Lcom/glu/android/tools/community/GluOpenFeint;

    invoke-virtual {v0}, Lcom/glu/android/tools/community/GluOpenFeint;->initialize()V

    goto :goto_0

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_1
        :pswitch_2
        :pswitch_3
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_4
    .end packed-switch
.end method
