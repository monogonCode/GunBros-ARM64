.class final Lcom/openfeint/api/resource/Score$1$1;
.super Ljava/lang/Object;

# interfaces
.implements Lcom/openfeint/internal/request/IRawRequestDelegate;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/openfeint/api/resource/Score$1;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lcom/openfeint/api/resource/Score$1;


# direct methods
.method constructor <init>(Lcom/openfeint/api/resource/Score$1;)V
    .locals 0

    iput-object p1, p0, Lcom/openfeint/api/resource/Score$1$1;->this$1:Lcom/openfeint/api/resource/Score$1;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final onResponse(ILjava/lang/String;)V
    .locals 1

    const/16 v0, 0xc8

    if-gt v0, p1, :cond_0

    const/16 v0, 0x12c

    if-ge p1, v0, :cond_0

    iget-object v0, p0, Lcom/openfeint/api/resource/Score$1$1;->this$1:Lcom/openfeint/api/resource/Score$1;

    iget-object v0, v0, Lcom/openfeint/api/resource/Score$1;->val$cb:Lcom/openfeint/api/resource/Score$SubmitToCB;

    :goto_0
    return-void

    :cond_0
    iget-object v0, p0, Lcom/openfeint/api/resource/Score$1$1;->this$1:Lcom/openfeint/api/resource/Score$1;

    iget-object v0, v0, Lcom/openfeint/api/resource/Score$1;->val$cb:Lcom/openfeint/api/resource/Score$SubmitToCB;

    goto :goto_0
.end method
