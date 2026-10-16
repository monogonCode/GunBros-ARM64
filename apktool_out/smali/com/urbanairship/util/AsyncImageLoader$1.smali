.class Lcom/urbanairship/util/AsyncImageLoader$1;
.super Landroid/os/Handler;


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

.field final synthetic val$urlString:Ljava/lang/String;


# direct methods
.method constructor <init>(Lcom/urbanairship/util/AsyncImageLoader;Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lcom/urbanairship/util/AsyncImageLoader$1;->this$0:Lcom/urbanairship/util/AsyncImageLoader;

    iput-object p2, p0, Lcom/urbanairship/util/AsyncImageLoader$1;->val$urlString:Ljava/lang/String;

    invoke-direct {p0}, Landroid/os/Handler;-><init>()V

    return-void
.end method


# virtual methods
.method public handleMessage(Landroid/os/Message;)V
    .locals 3

    iget-object v0, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v0, Landroid/graphics/drawable/Drawable;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/urbanairship/util/AsyncImageLoader$1;->this$0:Lcom/urbanairship/util/AsyncImageLoader;

    invoke-static {v0}, Lcom/urbanairship/util/AsyncImageLoader;->access$000(Lcom/urbanairship/util/AsyncImageLoader;)Lcom/urbanairship/util/AsyncImageLoader$Delegate;

    move-result-object v1

    iget-object v2, p0, Lcom/urbanairship/util/AsyncImageLoader$1;->val$urlString:Ljava/lang/String;

    iget-object v0, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v0, Landroid/graphics/drawable/Drawable;

    invoke-virtual {v1, v2, v0}, Lcom/urbanairship/util/AsyncImageLoader$Delegate;->imageLoaded(Ljava/lang/String;Landroid/graphics/drawable/Drawable;)V

    :cond_0
    return-void
.end method
