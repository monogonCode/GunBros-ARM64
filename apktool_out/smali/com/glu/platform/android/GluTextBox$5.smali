.class final Lcom/glu/platform/android/GluTextBox$5;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/glu/platform/android/GluTextBox;->SetVisible(Z)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/glu/platform/android/GluTextBox;

.field final synthetic val$visible:Z


# direct methods
.method constructor <init>(Lcom/glu/platform/android/GluTextBox;Z)V
    .locals 0

    iput-object p1, p0, Lcom/glu/platform/android/GluTextBox$5;->this$0:Lcom/glu/platform/android/GluTextBox;

    iput-boolean p2, p0, Lcom/glu/platform/android/GluTextBox$5;->val$visible:Z

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final run()V
    .locals 3

    const/4 v2, 0x0

    iget-boolean v0, p0, Lcom/glu/platform/android/GluTextBox$5;->val$visible:Z

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/glu/platform/android/GluTextBox$5;->this$0:Lcom/glu/platform/android/GluTextBox;

    invoke-static {v0}, Lcom/glu/platform/android/GluTextBox;->access$000(Lcom/glu/platform/android/GluTextBox;)Landroid/widget/EditText;

    move-result-object v0

    invoke-virtual {v0, v2}, Landroid/widget/EditText;->setVisibility(I)V

    :goto_0
    return-void

    :cond_0
    iget-object v0, p0, Lcom/glu/platform/android/GluTextBox$5;->this$0:Lcom/glu/platform/android/GluTextBox;

    invoke-static {v0}, Lcom/glu/platform/android/GluTextBox;->access$000(Lcom/glu/platform/android/GluTextBox;)Landroid/widget/EditText;

    move-result-object v0

    const/4 v1, 0x4

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setVisibility(I)V

    iget-object v0, p0, Lcom/glu/platform/android/GluTextBox$5;->this$0:Lcom/glu/platform/android/GluTextBox;

    invoke-static {v0}, Lcom/glu/platform/android/GluTextBox;->access$100(Lcom/glu/platform/android/GluTextBox;)Lcom/glu/platform/android/GluPlatformActivity;

    move-result-object v0

    const-string v1, "input_method"

    invoke-virtual {v0, v1}, Lcom/glu/platform/android/GluPlatformActivity;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/view/inputmethod/InputMethodManager;

    iget-object v1, p0, Lcom/glu/platform/android/GluTextBox$5;->this$0:Lcom/glu/platform/android/GluTextBox;

    invoke-static {v1}, Lcom/glu/platform/android/GluTextBox;->access$000(Lcom/glu/platform/android/GluTextBox;)Landroid/widget/EditText;

    move-result-object v1

    invoke-virtual {v1}, Landroid/widget/EditText;->getWindowToken()Landroid/os/IBinder;

    move-result-object v1

    invoke-virtual {v0, v1, v2}, Landroid/view/inputmethod/InputMethodManager;->hideSoftInputFromWindow(Landroid/os/IBinder;I)Z

    goto :goto_0
.end method
