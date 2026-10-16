.class final Lcom/glu/platform/android/GluPlatformActivity$3$1;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/glu/platform/android/GluPlatformActivity$3;->handleMessage(Landroid/os/Message;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lcom/glu/platform/android/GluPlatformActivity$3;

.field final synthetic val$data:Lcom/glu/platform/android/GluPlatformActivity$SystemMessageBoxMessage;


# direct methods
.method constructor <init>(Lcom/glu/platform/android/GluPlatformActivity$3;Lcom/glu/platform/android/GluPlatformActivity$SystemMessageBoxMessage;)V
    .locals 0

    iput-object p1, p0, Lcom/glu/platform/android/GluPlatformActivity$3$1;->this$1:Lcom/glu/platform/android/GluPlatformActivity$3;

    iput-object p2, p0, Lcom/glu/platform/android/GluPlatformActivity$3$1;->val$data:Lcom/glu/platform/android/GluPlatformActivity$SystemMessageBoxMessage;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final onClick(Landroid/content/DialogInterface;I)V
    .locals 1

    iget-object v0, p0, Lcom/glu/platform/android/GluPlatformActivity$3$1;->val$data:Lcom/glu/platform/android/GluPlatformActivity$SystemMessageBoxMessage;

    iget-object v0, v0, Lcom/glu/platform/android/GluPlatformActivity$SystemMessageBoxMessage;->m_Runner:Lcom/glu/platform/android/GluPlatformActivity$SystemMessageBoxRunner;

    invoke-virtual {v0}, Lcom/glu/platform/android/GluPlatformActivity$SystemMessageBoxRunner;->markAsDone()V

    return-void
.end method
