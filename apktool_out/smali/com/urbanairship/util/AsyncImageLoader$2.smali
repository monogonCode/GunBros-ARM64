.class Lcom/urbanairship/util/AsyncImageLoader$2;
.super Ljava/lang/Thread;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/urbanairship/util/AsyncImageLoader;->fetchDrawableOnThread(Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/urbanairship/util/AsyncImageLoader;

.field final synthetic val$handler:Landroid/os/Handler;

.field final synthetic val$urlString:Ljava/lang/String;


# direct methods
.method constructor <init>(Lcom/urbanairship/util/AsyncImageLoader;Ljava/lang/String;Landroid/os/Handler;)V
    .locals 0

    iput-object p1, p0, Lcom/urbanairship/util/AsyncImageLoader$2;->this$0:Lcom/urbanairship/util/AsyncImageLoader;

    iput-object p2, p0, Lcom/urbanairship/util/AsyncImageLoader$2;->val$urlString:Ljava/lang/String;

    iput-object p3, p0, Lcom/urbanairship/util/AsyncImageLoader$2;->val$handler:Landroid/os/Handler;

    invoke-direct {p0}, Ljava/lang/Thread;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    iget-object v0, p0, Lcom/urbanairship/util/AsyncImageLoader$2;->this$0:Lcom/urbanairship/util/AsyncImageLoader;

    iget-object v1, p0, Lcom/urbanairship/util/AsyncImageLoader$2;->val$urlString:Ljava/lang/String;

    invoke-static {v0, v1}, Lcom/urbanairship/util/AsyncImageLoader;->access$100(Lcom/urbanairship/util/AsyncImageLoader;Ljava/lang/String;)Landroid/graphics/drawable/Drawable;

    move-result-object v0

    iget-object v1, p0, Lcom/urbanairship/util/AsyncImageLoader$2;->val$handler:Landroid/os/Handler;

    const/4 v2, 0x1

    invoke-virtual {v1, v2, v0}, Landroid/os/Handler;->obtainMessage(ILjava/lang/Object;)Landroid/os/Message;

    move-result-object v0

    iget-object v1, p0, Lcom/urbanairship/util/AsyncImageLoader$2;->val$handler:Landroid/os/Handler;

    invoke-virtual {v1, v0}, Landroid/os/Handler;->sendMessage(Landroid/os/Message;)Z

    return-void
.end method
