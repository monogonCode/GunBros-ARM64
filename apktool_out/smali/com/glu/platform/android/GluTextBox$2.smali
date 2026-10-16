.class final Lcom/glu/platform/android/GluTextBox$2;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/glu/platform/android/GluTextBox;->SetBounds(IIII)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/glu/platform/android/GluTextBox;

.field final synthetic val$minH:I

.field final synthetic val$w:I

.field final synthetic val$x:I

.field final synthetic val$y:I


# direct methods
.method constructor <init>(Lcom/glu/platform/android/GluTextBox;IIII)V
    .locals 0

    iput-object p1, p0, Lcom/glu/platform/android/GluTextBox$2;->this$0:Lcom/glu/platform/android/GluTextBox;

    iput p2, p0, Lcom/glu/platform/android/GluTextBox$2;->val$x:I

    iput p3, p0, Lcom/glu/platform/android/GluTextBox$2;->val$y:I

    iput p4, p0, Lcom/glu/platform/android/GluTextBox$2;->val$w:I

    iput p5, p0, Lcom/glu/platform/android/GluTextBox$2;->val$minH:I

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final run()V
    .locals 5

    iget-object v0, p0, Lcom/glu/platform/android/GluTextBox$2;->this$0:Lcom/glu/platform/android/GluTextBox;

    iget v1, p0, Lcom/glu/platform/android/GluTextBox$2;->val$x:I

    iget v2, p0, Lcom/glu/platform/android/GluTextBox$2;->val$y:I

    iget v3, p0, Lcom/glu/platform/android/GluTextBox$2;->val$w:I

    iget v4, p0, Lcom/glu/platform/android/GluTextBox$2;->val$minH:I

    invoke-virtual {v0, v1, v2, v3, v4}, Lcom/glu/platform/android/GluTextBox;->createTextView(IIII)V

    return-void
.end method
