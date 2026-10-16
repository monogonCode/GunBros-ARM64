.class final Lcom/openfeint/internal/OpenFeintInternal$6;
.super Lcom/openfeint/internal/request/RawRequest;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/openfeint/internal/OpenFeintInternal;->logoutUser(Lcom/openfeint/internal/request/IRawRequestDelegate;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/openfeint/internal/OpenFeintInternal;


# direct methods
.method constructor <init>(Lcom/openfeint/internal/OpenFeintInternal;Lcom/openfeint/internal/request/OrderedArgList;)V
    .locals 0

    iput-object p1, p0, Lcom/openfeint/internal/OpenFeintInternal$6;->this$0:Lcom/openfeint/internal/OpenFeintInternal;

    invoke-direct {p0, p2}, Lcom/openfeint/internal/request/RawRequest;-><init>(Lcom/openfeint/internal/request/OrderedArgList;)V

    return-void
.end method


# virtual methods
.method public final method()Ljava/lang/String;
    .locals 1

    const-string v0, "DELETE"

    return-object v0
.end method

.method public final path()Ljava/lang/String;
    .locals 1

    const-string v0, "/xp/sessions.json"

    return-object v0
.end method
