.class final Lcom/glu/platform/android/GluPlatformActivity$3;
.super Landroid/os/Handler;


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

    iput-object p1, p0, Lcom/glu/platform/android/GluPlatformActivity$3;->this$0:Lcom/glu/platform/android/GluPlatformActivity;

    invoke-direct {p0}, Landroid/os/Handler;-><init>()V

    return-void
.end method


# virtual methods
.method public final handleMessage(Landroid/os/Message;)V
    .locals 4

    iget v0, p1, Landroid/os/Message;->what:I

    packed-switch v0, :pswitch_data_0

    :goto_0
    return-void

    :pswitch_0
    iget-object v0, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v0, Lcom/glu/platform/android/GluPlatformActivity$SystemMessageBoxMessage;

    new-instance v1, Landroid/app/AlertDialog$Builder;

    iget-object v2, v0, Lcom/glu/platform/android/GluPlatformActivity$SystemMessageBoxMessage;->m_Context:Landroid/content/Context;

    invoke-direct {v1, v2}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    iget-object v2, v0, Lcom/glu/platform/android/GluPlatformActivity$SystemMessageBoxMessage;->m_Title:Ljava/lang/String;

    invoke-virtual {v1, v2}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    iget-object v2, v0, Lcom/glu/platform/android/GluPlatformActivity$SystemMessageBoxMessage;->m_Text:Ljava/lang/String;

    invoke-virtual {v1, v2}, Landroid/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Landroid/app/AlertDialog$Builder;->setCancelable(Z)Landroid/app/AlertDialog$Builder;

    const-string v2, "OK"

    new-instance v3, Lcom/glu/platform/android/GluPlatformActivity$3$1;

    invoke-direct {v3, p0, v0}, Lcom/glu/platform/android/GluPlatformActivity$3$1;-><init>(Lcom/glu/platform/android/GluPlatformActivity$3;Lcom/glu/platform/android/GluPlatformActivity$SystemMessageBoxMessage;)V

    invoke-virtual {v1, v2, v3}, Landroid/app/AlertDialog$Builder;->setNeutralButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    invoke-virtual {v1}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    goto :goto_0

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_0
    .end packed-switch
.end method
