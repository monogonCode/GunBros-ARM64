.class final Lcom/openfeint/internal/ui/WebViewCache$1;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/openfeint/internal/ui/WebViewCache;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/openfeint/internal/ui/WebViewCache;

.field final synthetic val$baseDir:Ljava/io/File;

.field final synthetic val$inPhoneWebui:Ljava/io/File;

.field final synthetic val$webui:Ljava/io/File;


# direct methods
.method constructor <init>(Lcom/openfeint/internal/ui/WebViewCache;Ljava/io/File;Ljava/io/File;Ljava/io/File;)V
    .locals 0

    iput-object p1, p0, Lcom/openfeint/internal/ui/WebViewCache$1;->this$0:Lcom/openfeint/internal/ui/WebViewCache;

    iput-object p2, p0, Lcom/openfeint/internal/ui/WebViewCache$1;->val$inPhoneWebui:Ljava/io/File;

    iput-object p3, p0, Lcom/openfeint/internal/ui/WebViewCache$1;->val$webui:Ljava/io/File;

    iput-object p4, p0, Lcom/openfeint/internal/ui/WebViewCache$1;->val$baseDir:Ljava/io/File;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final run()V
    .locals 2

    :try_start_0
    iget-object v0, p0, Lcom/openfeint/internal/ui/WebViewCache$1;->val$inPhoneWebui:Ljava/io/File;

    invoke-virtual {v0}, Ljava/io/File;->isDirectory()Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/openfeint/internal/ui/WebViewCache$1;->val$inPhoneWebui:Ljava/io/File;

    iget-object v1, p0, Lcom/openfeint/internal/ui/WebViewCache$1;->val$webui:Ljava/io/File;

    invoke-static {v0, v1}, Lcom/openfeint/internal/Util;->copyDirectory(Ljava/io/File;Ljava/io/File;)V

    iget-object v0, p0, Lcom/openfeint/internal/ui/WebViewCache$1;->this$0:Lcom/openfeint/internal/ui/WebViewCache;

    invoke-static {v0}, Lcom/openfeint/internal/ui/WebViewCache;->access$000(Lcom/openfeint/internal/ui/WebViewCache;)V

    const-string v0, "WebViewCache"

    const-string v1, "copy in phone data finish"

    invoke-static {v0, v1}, Lcom/openfeint/internal/logcat/OFLog;->i(Ljava/lang/String;Ljava/lang/String;)V

    iget-object v0, p0, Lcom/openfeint/internal/ui/WebViewCache$1;->this$0:Lcom/openfeint/internal/ui/WebViewCache;

    invoke-static {v0}, Lcom/openfeint/internal/ui/WebViewCache;->access$100(Lcom/openfeint/internal/ui/WebViewCache;)V

    :goto_0
    return-void

    :cond_0
    const-string v0, "WebViewCache"

    const-string v1, "copy from asset"

    invoke-static {v0, v1}, Lcom/openfeint/internal/logcat/OFLog;->i(Ljava/lang/String;Ljava/lang/String;)V

    iget-object v0, p0, Lcom/openfeint/internal/ui/WebViewCache$1;->this$0:Lcom/openfeint/internal/ui/WebViewCache;

    iget-object v1, p0, Lcom/openfeint/internal/ui/WebViewCache$1;->val$baseDir:Ljava/io/File;

    invoke-static {v0, v1}, Lcom/openfeint/internal/ui/WebViewCache;->access$200(Lcom/openfeint/internal/ui/WebViewCache;Ljava/io/File;)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    const-string v1, "WebViewCache"

    invoke-virtual {v0}, Ljava/io/IOException;->getMessage()Ljava/lang/String;

    move-result-object v0

    invoke-static {v1, v0}, Lcom/openfeint/internal/logcat/OFLog;->e(Ljava/lang/String;Ljava/lang/String;)V

    iget-object v0, p0, Lcom/openfeint/internal/ui/WebViewCache$1;->this$0:Lcom/openfeint/internal/ui/WebViewCache;

    invoke-virtual {v0}, Lcom/openfeint/internal/ui/WebViewCache;->setRootUriInternal()V

    goto :goto_0
.end method
