.class final Lcom/openfeint/internal/ui/WebViewCache$6;
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

.field final synthetic val$currentUrl:Ljava/lang/String;

.field final synthetic val$originalUrl:Ljava/lang/String;

.field final synthetic val$paths:Ljava/util/Set;

.field final synthetic val$retriesLeft:I


# direct methods
.method constructor <init>(Lcom/openfeint/internal/ui/WebViewCache;Ljava/lang/String;Ljava/lang/String;Ljava/util/Set;I)V
    .locals 0

    iput-object p1, p0, Lcom/openfeint/internal/ui/WebViewCache$6;->this$0:Lcom/openfeint/internal/ui/WebViewCache;

    iput-object p2, p0, Lcom/openfeint/internal/ui/WebViewCache$6;->val$originalUrl:Ljava/lang/String;

    iput-object p3, p0, Lcom/openfeint/internal/ui/WebViewCache$6;->val$currentUrl:Ljava/lang/String;

    iput-object p4, p0, Lcom/openfeint/internal/ui/WebViewCache$6;->val$paths:Ljava/util/Set;

    iput p5, p0, Lcom/openfeint/internal/ui/WebViewCache$6;->val$retriesLeft:I

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final run()V
    .locals 5

    iget-object v0, p0, Lcom/openfeint/internal/ui/WebViewCache$6;->val$originalUrl:Ljava/lang/String;

    iget-object v1, p0, Lcom/openfeint/internal/ui/WebViewCache$6;->val$currentUrl:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/openfeint/internal/ui/WebViewCache$6;->this$0:Lcom/openfeint/internal/ui/WebViewCache;

    iget-object v1, p0, Lcom/openfeint/internal/ui/WebViewCache$6;->val$paths:Ljava/util/Set;

    iget v2, p0, Lcom/openfeint/internal/ui/WebViewCache$6;->val$retriesLeft:I

    add-int/lit8 v2, v2, -0x1

    invoke-static {v0, v1, v2}, Lcom/openfeint/internal/ui/WebViewCache;->access$1400(Lcom/openfeint/internal/ui/WebViewCache;Ljava/util/Set;I)V

    :goto_0
    return-void

    :cond_0
    iget-object v0, p0, Lcom/openfeint/internal/ui/WebViewCache$6;->this$0:Lcom/openfeint/internal/ui/WebViewCache;

    iget-object v1, p0, Lcom/openfeint/internal/ui/WebViewCache$6;->val$originalUrl:Ljava/lang/String;

    iget-object v2, p0, Lcom/openfeint/internal/ui/WebViewCache$6;->val$currentUrl:Ljava/lang/String;

    iget v3, p0, Lcom/openfeint/internal/ui/WebViewCache$6;->val$retriesLeft:I

    add-int/lit8 v3, v3, -0x1

    iget-object v4, p0, Lcom/openfeint/internal/ui/WebViewCache$6;->val$paths:Ljava/util/Set;

    invoke-static {v0, v1, v2, v3, v4}, Lcom/openfeint/internal/ui/WebViewCache;->access$1500(Lcom/openfeint/internal/ui/WebViewCache;Ljava/lang/String;Ljava/lang/String;ILjava/util/Set;)V

    goto :goto_0
.end method
