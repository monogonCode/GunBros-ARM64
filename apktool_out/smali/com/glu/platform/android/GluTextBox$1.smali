.class final Lcom/glu/platform/android/GluTextBox$1;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/glu/platform/android/GluTextBox;-><init>()V
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

    iput-object p1, p0, Lcom/glu/platform/android/GluTextBox$1;->this$0:Lcom/glu/platform/android/GluTextBox;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final run()V
    .locals 3

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "run GluTextBox["

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "].GluTextBox()"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    iget-object v0, p0, Lcom/glu/platform/android/GluTextBox$1;->this$0:Lcom/glu/platform/android/GluTextBox;

    new-instance v1, Landroid/widget/EditText;

    iget-object v2, p0, Lcom/glu/platform/android/GluTextBox$1;->this$0:Lcom/glu/platform/android/GluTextBox;

    invoke-static {v2}, Lcom/glu/platform/android/GluTextBox;->access$100(Lcom/glu/platform/android/GluTextBox;)Lcom/glu/platform/android/GluPlatformActivity;

    move-result-object v2

    invoke-direct {v1, v2}, Landroid/widget/EditText;-><init>(Landroid/content/Context;)V

    invoke-static {v0, v1}, Lcom/glu/platform/android/GluTextBox;->access$002(Lcom/glu/platform/android/GluTextBox;Landroid/widget/EditText;)Landroid/widget/EditText;

    return-void
.end method
