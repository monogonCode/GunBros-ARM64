.class final Lcom/glu/platform/android/GluTextBox$4;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/glu/platform/android/GluTextBox;->SetPasswordMask(Z)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/glu/platform/android/GluTextBox;

.field final synthetic val$enabled:Z


# direct methods
.method constructor <init>(Lcom/glu/platform/android/GluTextBox;Z)V
    .locals 0

    iput-object p1, p0, Lcom/glu/platform/android/GluTextBox$4;->this$0:Lcom/glu/platform/android/GluTextBox;

    iput-boolean p2, p0, Lcom/glu/platform/android/GluTextBox$4;->val$enabled:Z

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final run()V
    .locals 2

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "run GluTextBox["

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "].SetPasswordMask("

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-boolean v1, p0, Lcom/glu/platform/android/GluTextBox$4;->val$enabled:Z

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ")"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    iget-boolean v0, p0, Lcom/glu/platform/android/GluTextBox$4;->val$enabled:Z

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/glu/platform/android/GluTextBox$4;->this$0:Lcom/glu/platform/android/GluTextBox;

    invoke-static {v0}, Lcom/glu/platform/android/GluTextBox;->access$000(Lcom/glu/platform/android/GluTextBox;)Landroid/widget/EditText;

    move-result-object v0

    new-instance v1, Landroid/text/method/PasswordTransformationMethod;

    invoke-direct {v1}, Landroid/text/method/PasswordTransformationMethod;-><init>()V

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setTransformationMethod(Landroid/text/method/TransformationMethod;)V

    iget-object v0, p0, Lcom/glu/platform/android/GluTextBox$4;->this$0:Lcom/glu/platform/android/GluTextBox;

    invoke-static {v0}, Lcom/glu/platform/android/GluTextBox;->access$000(Lcom/glu/platform/android/GluTextBox;)Landroid/widget/EditText;

    move-result-object v0

    const v1, 0x80081

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setInputType(I)V

    :goto_0
    return-void

    :cond_0
    iget-object v0, p0, Lcom/glu/platform/android/GluTextBox$4;->this$0:Lcom/glu/platform/android/GluTextBox;

    invoke-static {v0}, Lcom/glu/platform/android/GluTextBox;->access$000(Lcom/glu/platform/android/GluTextBox;)Landroid/widget/EditText;

    move-result-object v0

    const/high16 v1, 0x80000

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setInputType(I)V

    iget-object v0, p0, Lcom/glu/platform/android/GluTextBox$4;->this$0:Lcom/glu/platform/android/GluTextBox;

    invoke-static {v0}, Lcom/glu/platform/android/GluTextBox;->access$000(Lcom/glu/platform/android/GluTextBox;)Landroid/widget/EditText;

    move-result-object v0

    new-instance v1, Landroid/text/method/SingleLineTransformationMethod;

    invoke-direct {v1}, Landroid/text/method/SingleLineTransformationMethod;-><init>()V

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setTransformationMethod(Landroid/text/method/TransformationMethod;)V

    goto :goto_0
.end method
