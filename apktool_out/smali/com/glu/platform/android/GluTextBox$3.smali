.class final Lcom/glu/platform/android/GluTextBox$3;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/glu/platform/android/GluTextBox;->createTextView(IIII)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/glu/platform/android/GluTextBox;

.field final synthetic val$h:I

.field final synthetic val$w:I

.field final synthetic val$x:I

.field final synthetic val$y:I


# direct methods
.method constructor <init>(Lcom/glu/platform/android/GluTextBox;IIII)V
    .locals 0

    iput-object p1, p0, Lcom/glu/platform/android/GluTextBox$3;->this$0:Lcom/glu/platform/android/GluTextBox;

    iput p2, p0, Lcom/glu/platform/android/GluTextBox$3;->val$w:I

    iput p3, p0, Lcom/glu/platform/android/GluTextBox$3;->val$h:I

    iput p4, p0, Lcom/glu/platform/android/GluTextBox$3;->val$x:I

    iput p5, p0, Lcom/glu/platform/android/GluTextBox$3;->val$y:I

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final run()V
    .locals 7

    const/4 v6, -0x1

    const/16 v5, 0xa

    const/4 v4, 0x0

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "running GluTextBox["

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "].createTextView()"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    iget-object v0, p0, Lcom/glu/platform/android/GluTextBox$3;->this$0:Lcom/glu/platform/android/GluTextBox;

    invoke-static {v0}, Lcom/glu/platform/android/GluTextBox;->access$100(Lcom/glu/platform/android/GluTextBox;)Lcom/glu/platform/android/GluPlatformActivity;

    move-result-object v0

    const-string v1, "window"

    invoke-virtual {v0, v1}, Lcom/glu/platform/android/GluPlatformActivity;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    iget-object v0, p0, Lcom/glu/platform/android/GluTextBox$3;->this$0:Lcom/glu/platform/android/GluTextBox;

    invoke-static {v0}, Lcom/glu/platform/android/GluTextBox;->access$000(Lcom/glu/platform/android/GluTextBox;)Landroid/widget/EditText;

    move-result-object v0

    new-instance v1, Landroid/view/ViewGroup$LayoutParams;

    iget v2, p0, Lcom/glu/platform/android/GluTextBox$3;->val$w:I

    iget v3, p0, Lcom/glu/platform/android/GluTextBox$3;->val$h:I

    invoke-direct {v1, v2, v3}, Landroid/view/ViewGroup$LayoutParams;-><init>(II)V

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    iget-object v0, p0, Lcom/glu/platform/android/GluTextBox$3;->this$0:Lcom/glu/platform/android/GluTextBox;

    invoke-static {v0}, Lcom/glu/platform/android/GluTextBox;->access$000(Lcom/glu/platform/android/GluTextBox;)Landroid/widget/EditText;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/EditText;->setSingleLine()V

    iget-object v0, p0, Lcom/glu/platform/android/GluTextBox$3;->this$0:Lcom/glu/platform/android/GluTextBox;

    invoke-static {v0}, Lcom/glu/platform/android/GluTextBox;->access$000(Lcom/glu/platform/android/GluTextBox;)Landroid/widget/EditText;

    move-result-object v0

    const/high16 v1, 0x41200000    # 10.0f

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setTextSize(F)V

    iget-object v0, p0, Lcom/glu/platform/android/GluTextBox$3;->this$0:Lcom/glu/platform/android/GluTextBox;

    invoke-static {v0}, Lcom/glu/platform/android/GluTextBox;->access$000(Lcom/glu/platform/android/GluTextBox;)Landroid/widget/EditText;

    move-result-object v0

    const/16 v1, 0xd

    invoke-virtual {v0, v5, v5, v5, v1}, Landroid/widget/EditText;->setPadding(IIII)V

    iget-object v0, p0, Lcom/glu/platform/android/GluTextBox$3;->this$0:Lcom/glu/platform/android/GluTextBox;

    invoke-static {v0}, Lcom/glu/platform/android/GluTextBox;->access$200(Lcom/glu/platform/android/GluTextBox;)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/glu/platform/android/GluTextBox$3;->this$0:Lcom/glu/platform/android/GluTextBox;

    invoke-static {v0}, Lcom/glu/platform/android/GluTextBox;->access$000(Lcom/glu/platform/android/GluTextBox;)Landroid/widget/EditText;

    move-result-object v0

    new-instance v1, Landroid/text/method/PasswordTransformationMethod;

    invoke-direct {v1}, Landroid/text/method/PasswordTransformationMethod;-><init>()V

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setTransformationMethod(Landroid/text/method/TransformationMethod;)V

    iget-object v0, p0, Lcom/glu/platform/android/GluTextBox$3;->this$0:Lcom/glu/platform/android/GluTextBox;

    invoke-static {v0}, Lcom/glu/platform/android/GluTextBox;->access$000(Lcom/glu/platform/android/GluTextBox;)Landroid/widget/EditText;

    move-result-object v0

    const v1, 0x80081

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setInputType(I)V

    :goto_0
    iget-object v0, p0, Lcom/glu/platform/android/GluTextBox$3;->this$0:Lcom/glu/platform/android/GluTextBox;

    invoke-static {v0}, Lcom/glu/platform/android/GluTextBox;->access$300(Lcom/glu/platform/android/GluTextBox;)Z

    move-result v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/glu/platform/android/GluTextBox$3;->this$0:Lcom/glu/platform/android/GluTextBox;

    invoke-static {v0}, Lcom/glu/platform/android/GluTextBox;->access$000(Lcom/glu/platform/android/GluTextBox;)Landroid/widget/EditText;

    move-result-object v0

    invoke-virtual {v0, v4}, Landroid/widget/EditText;->setVisibility(I)V

    :goto_1
    iget-object v0, p0, Lcom/glu/platform/android/GluTextBox$3;->this$0:Lcom/glu/platform/android/GluTextBox;

    new-instance v1, Landroid/widget/LinearLayout;

    iget-object v2, p0, Lcom/glu/platform/android/GluTextBox$3;->this$0:Lcom/glu/platform/android/GluTextBox;

    invoke-static {v2}, Lcom/glu/platform/android/GluTextBox;->access$100(Lcom/glu/platform/android/GluTextBox;)Lcom/glu/platform/android/GluPlatformActivity;

    move-result-object v2

    invoke-direct {v1, v2}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    invoke-static {v0, v1}, Lcom/glu/platform/android/GluTextBox;->access$402(Lcom/glu/platform/android/GluTextBox;Landroid/widget/LinearLayout;)Landroid/widget/LinearLayout;

    iget-object v0, p0, Lcom/glu/platform/android/GluTextBox$3;->this$0:Lcom/glu/platform/android/GluTextBox;

    invoke-static {v0}, Lcom/glu/platform/android/GluTextBox;->access$400(Lcom/glu/platform/android/GluTextBox;)Landroid/widget/LinearLayout;

    move-result-object v0

    new-instance v1, Landroid/view/ViewGroup$LayoutParams;

    iget v2, p0, Lcom/glu/platform/android/GluTextBox$3;->val$w:I

    iget v3, p0, Lcom/glu/platform/android/GluTextBox$3;->val$h:I

    invoke-direct {v1, v2, v3}, Landroid/view/ViewGroup$LayoutParams;-><init>(II)V

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    iget-object v0, p0, Lcom/glu/platform/android/GluTextBox$3;->this$0:Lcom/glu/platform/android/GluTextBox;

    invoke-static {v0}, Lcom/glu/platform/android/GluTextBox;->access$400(Lcom/glu/platform/android/GluTextBox;)Landroid/widget/LinearLayout;

    move-result-object v0

    const/16 v1, 0x30

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setGravity(I)V

    iget-object v0, p0, Lcom/glu/platform/android/GluTextBox$3;->this$0:Lcom/glu/platform/android/GluTextBox;

    invoke-static {v0}, Lcom/glu/platform/android/GluTextBox;->access$400(Lcom/glu/platform/android/GluTextBox;)Landroid/widget/LinearLayout;

    move-result-object v0

    iget v1, p0, Lcom/glu/platform/android/GluTextBox$3;->val$x:I

    iget v2, p0, Lcom/glu/platform/android/GluTextBox$3;->val$y:I

    add-int/lit8 v2, v2, -0xa

    invoke-virtual {v0, v1, v2, v4, v4}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    iget-object v0, p0, Lcom/glu/platform/android/GluTextBox$3;->this$0:Lcom/glu/platform/android/GluTextBox;

    invoke-static {v0}, Lcom/glu/platform/android/GluTextBox;->access$400(Lcom/glu/platform/android/GluTextBox;)Landroid/widget/LinearLayout;

    move-result-object v0

    iget-object v1, p0, Lcom/glu/platform/android/GluTextBox$3;->this$0:Lcom/glu/platform/android/GluTextBox;

    invoke-static {v1}, Lcom/glu/platform/android/GluTextBox;->access$000(Lcom/glu/platform/android/GluTextBox;)Landroid/widget/EditText;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    iget-object v0, p0, Lcom/glu/platform/android/GluTextBox$3;->this$0:Lcom/glu/platform/android/GluTextBox;

    invoke-static {v0}, Lcom/glu/platform/android/GluTextBox;->access$100(Lcom/glu/platform/android/GluTextBox;)Lcom/glu/platform/android/GluPlatformActivity;

    move-result-object v0

    invoke-virtual {v0}, Lcom/glu/platform/android/GluPlatformActivity;->getWindow()Landroid/view/Window;

    move-result-object v0

    iget-object v1, p0, Lcom/glu/platform/android/GluTextBox$3;->this$0:Lcom/glu/platform/android/GluTextBox;

    invoke-static {v1}, Lcom/glu/platform/android/GluTextBox;->access$400(Lcom/glu/platform/android/GluTextBox;)Landroid/widget/LinearLayout;

    move-result-object v1

    new-instance v2, Landroid/view/ViewGroup$LayoutParams;

    invoke-direct {v2, v6, v6}, Landroid/view/ViewGroup$LayoutParams;-><init>(II)V

    invoke-virtual {v0, v1, v2}, Landroid/view/Window;->addContentView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    iget-object v0, p0, Lcom/glu/platform/android/GluTextBox$3;->this$0:Lcom/glu/platform/android/GluTextBox;

    invoke-static {v0}, Lcom/glu/platform/android/GluTextBox;->access$400(Lcom/glu/platform/android/GluTextBox;)Landroid/widget/LinearLayout;

    move-result-object v0

    invoke-virtual {v0, v4}, Landroid/widget/LinearLayout;->setVisibility(I)V

    return-void

    :cond_0
    iget-object v0, p0, Lcom/glu/platform/android/GluTextBox$3;->this$0:Lcom/glu/platform/android/GluTextBox;

    invoke-static {v0}, Lcom/glu/platform/android/GluTextBox;->access$000(Lcom/glu/platform/android/GluTextBox;)Landroid/widget/EditText;

    move-result-object v0

    const v1, 0x80001

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setInputType(I)V

    goto/16 :goto_0

    :cond_1
    iget-object v0, p0, Lcom/glu/platform/android/GluTextBox$3;->this$0:Lcom/glu/platform/android/GluTextBox;

    invoke-static {v0}, Lcom/glu/platform/android/GluTextBox;->access$000(Lcom/glu/platform/android/GluTextBox;)Landroid/widget/EditText;

    move-result-object v0

    const/4 v1, 0x4

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setVisibility(I)V

    goto/16 :goto_1
.end method
