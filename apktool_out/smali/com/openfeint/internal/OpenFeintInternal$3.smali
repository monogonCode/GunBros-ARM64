.class final Lcom/openfeint/internal/OpenFeintInternal$3;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/openfeint/internal/OpenFeintInternal;->loginUser(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/openfeint/internal/request/IRawRequestDelegate;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/openfeint/internal/OpenFeintInternal;

.field final synthetic val$delegate:Lcom/openfeint/internal/request/IRawRequestDelegate;

.field final synthetic val$password:Ljava/lang/String;

.field final synthetic val$userID:Ljava/lang/String;

.field final synthetic val$userName:Ljava/lang/String;


# direct methods
.method constructor <init>(Lcom/openfeint/internal/OpenFeintInternal;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/openfeint/internal/request/IRawRequestDelegate;)V
    .locals 0

    iput-object p1, p0, Lcom/openfeint/internal/OpenFeintInternal$3;->this$0:Lcom/openfeint/internal/OpenFeintInternal;

    iput-object p2, p0, Lcom/openfeint/internal/OpenFeintInternal$3;->val$userName:Ljava/lang/String;

    iput-object p3, p0, Lcom/openfeint/internal/OpenFeintInternal$3;->val$password:Ljava/lang/String;

    iput-object p4, p0, Lcom/openfeint/internal/OpenFeintInternal$3;->val$userID:Ljava/lang/String;

    iput-object p5, p0, Lcom/openfeint/internal/OpenFeintInternal$3;->val$delegate:Lcom/openfeint/internal/request/IRawRequestDelegate;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final run()V
    .locals 5

    iget-object v0, p0, Lcom/openfeint/internal/OpenFeintInternal$3;->this$0:Lcom/openfeint/internal/OpenFeintInternal;

    iget-object v1, p0, Lcom/openfeint/internal/OpenFeintInternal$3;->val$userName:Ljava/lang/String;

    iget-object v2, p0, Lcom/openfeint/internal/OpenFeintInternal$3;->val$password:Ljava/lang/String;

    iget-object v3, p0, Lcom/openfeint/internal/OpenFeintInternal$3;->val$userID:Ljava/lang/String;

    iget-object v4, p0, Lcom/openfeint/internal/OpenFeintInternal$3;->val$delegate:Lcom/openfeint/internal/request/IRawRequestDelegate;

    invoke-virtual {v0, v1, v2, v3, v4}, Lcom/openfeint/internal/OpenFeintInternal;->loginUser(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/openfeint/internal/request/IRawRequestDelegate;)V

    return-void
.end method
