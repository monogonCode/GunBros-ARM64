.class final Lcom/glu/platform/android/resdl/GameLet$1;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/glu/platform/android/resdl/GameLet;->onHandledOpenModalDialog()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = null
.end annotation


# direct methods
.method constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final onClick(Landroid/content/DialogInterface;I)V
    .locals 7

    const/4 v1, 0x1

    const/4 v0, 0x0

    sget-object v2, Lcom/glu/platform/android/resdl/GameLet;->m_dialogCallback:Ljava/lang/reflect/Method;

    if-eqz v2, :cond_1

    :try_start_0
    sget-object v2, Lcom/glu/platform/android/resdl/GameLet;->m_dialogCallback:Ljava/lang/reflect/Method;

    const/4 v3, 0x0

    const/4 v4, 0x1

    new-array v4, v4, [Ljava/lang/Object;

    const/4 v5, 0x0

    invoke-static {p2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v6

    aput-object v6, v4, v5

    invoke-virtual {v2, v3, v4}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    if-eqz v0, :cond_0

    const-string v0, "No callback provided (or usable) for this dialog. This onClick action will close the dialog."

    invoke-static {v0}, Lcom/glu/platform/android/resdl/Debug;->log(Ljava/lang/String;)V

    invoke-static {}, Lcom/glu/platform/android/resdl/GameLet;->handleModalDialogClosed()V

    sget-object v0, Lcom/glu/platform/android/resdl/GameLet;->m_modalDialog:Landroid/app/AlertDialog;

    invoke-virtual {v0}, Landroid/app/AlertDialog;->dismiss()V

    :cond_0
    return-void

    :catch_0
    move-exception v0

    const-string v2, "Error: Exception with the modal dialog callback."

    invoke-static {v2, v0}, Lcom/glu/platform/android/resdl/Debug;->log(Ljava/lang/String;Ljava/lang/Throwable;)V

    :cond_1
    move v0, v1

    goto :goto_0
.end method
