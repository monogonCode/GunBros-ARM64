.class final Lcom/glu/platform/android/GluTextBox$6;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/glu/platform/android/GluTextBox;->SetText(Ljava/lang/String;Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/glu/platform/android/GluTextBox;

.field final synthetic val$hint:Ljava/lang/String;

.field final synthetic val$text:Ljava/lang/String;


# direct methods
.method constructor <init>(Lcom/glu/platform/android/GluTextBox;Ljava/lang/String;Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lcom/glu/platform/android/GluTextBox$6;->this$0:Lcom/glu/platform/android/GluTextBox;

    iput-object p2, p0, Lcom/glu/platform/android/GluTextBox$6;->val$text:Ljava/lang/String;

    iput-object p3, p0, Lcom/glu/platform/android/GluTextBox$6;->val$hint:Ljava/lang/String;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final run()V
    .locals 2

    iget-object v0, p0, Lcom/glu/platform/android/GluTextBox$6;->this$0:Lcom/glu/platform/android/GluTextBox;

    invoke-static {v0}, Lcom/glu/platform/android/GluTextBox;->access$000(Lcom/glu/platform/android/GluTextBox;)Landroid/widget/EditText;

    move-result-object v0

    iget-object v1, p0, Lcom/glu/platform/android/GluTextBox$6;->val$text:Ljava/lang/String;

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lcom/glu/platform/android/GluTextBox$6;->this$0:Lcom/glu/platform/android/GluTextBox;

    invoke-static {v0}, Lcom/glu/platform/android/GluTextBox;->access$000(Lcom/glu/platform/android/GluTextBox;)Landroid/widget/EditText;

    move-result-object v0

    iget-object v1, p0, Lcom/glu/platform/android/GluTextBox$6;->val$hint:Ljava/lang/String;

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setHint(Ljava/lang/CharSequence;)V

    return-void
.end method
