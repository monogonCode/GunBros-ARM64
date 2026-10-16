.class Lcom/openfeint/internal/ui/WebNav$WebNavClient$1;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/openfeint/internal/ui/WebNav$WebNavClient;->attemptRecovery(Landroid/webkit/WebView;Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lcom/openfeint/internal/ui/WebNav$WebNavClient;


# direct methods
.method constructor <init>(Lcom/openfeint/internal/ui/WebNav$WebNavClient;)V
    .locals 0

    iput-object p1, p0, Lcom/openfeint/internal/ui/WebNav$WebNavClient$1;->this$1:Lcom/openfeint/internal/ui/WebNav$WebNavClient;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 1

    iget-object v0, p0, Lcom/openfeint/internal/ui/WebNav$WebNavClient$1;->this$1:Lcom/openfeint/internal/ui/WebNav$WebNavClient;

    invoke-virtual {v0}, Lcom/openfeint/internal/ui/WebNav$WebNavClient;->submitCrashReport()V

    return-void
.end method
