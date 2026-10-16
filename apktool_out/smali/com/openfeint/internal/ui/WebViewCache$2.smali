.class final Lcom/openfeint/internal/ui/WebViewCache$2;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/openfeint/internal/ui/WebViewCache;->setRootUriInternal()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/openfeint/internal/ui/WebViewCache;

.field final synthetic val$baseDir:Ljava/io/File;


# direct methods
.method constructor <init>(Lcom/openfeint/internal/ui/WebViewCache;Ljava/io/File;)V
    .locals 0

    iput-object p1, p0, Lcom/openfeint/internal/ui/WebViewCache$2;->this$0:Lcom/openfeint/internal/ui/WebViewCache;

    iput-object p2, p0, Lcom/openfeint/internal/ui/WebViewCache$2;->val$baseDir:Ljava/io/File;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final run()V
    .locals 2

    iget-object v0, p0, Lcom/openfeint/internal/ui/WebViewCache$2;->this$0:Lcom/openfeint/internal/ui/WebViewCache;

    iget-object v1, p0, Lcom/openfeint/internal/ui/WebViewCache$2;->val$baseDir:Ljava/io/File;

    invoke-static {v0, v1}, Lcom/openfeint/internal/ui/WebViewCache;->access$200(Lcom/openfeint/internal/ui/WebViewCache;Ljava/io/File;)V

    return-void
.end method
