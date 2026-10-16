.class final Lcom/glu/platform/android/GluTextBox$7;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/glu/platform/android/GluTextBox;->RemoveTextView()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/glu/platform/android/GluTextBox;


# direct methods
.method constructor <init>(Lcom/glu/platform/android/GluTextBox;)V
    .locals 0

    iput-object p1, p0, Lcom/glu/platform/android/GluTextBox$7;->this$0:Lcom/glu/platform/android/GluTextBox;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final run()V
    .locals 2

    const/4 v1, 0x4

    iget-object v0, p0, Lcom/glu/platform/android/GluTextBox$7;->this$0:Lcom/glu/platform/android/GluTextBox;

    invoke-static {v0}, Lcom/glu/platform/android/GluTextBox;->access$000(Lcom/glu/platform/android/GluTextBox;)Landroid/widget/EditText;

    move-result-object v0

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setVisibility(I)V

    iget-object v0, p0, Lcom/glu/platform/android/GluTextBox$7;->this$0:Lcom/glu/platform/android/GluTextBox;

    invoke-static {v0}, Lcom/glu/platform/android/GluTextBox;->access$400(Lcom/glu/platform/android/GluTextBox;)Landroid/widget/LinearLayout;

    move-result-object v0

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setVisibility(I)V

    return-void
.end method
