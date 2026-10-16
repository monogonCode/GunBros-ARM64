.class final Lcom/openfeint/internal/ui/Settings$SettingsActionHandler$1;
.super Ljava/lang/Object;

# interfaces
.implements Lcom/openfeint/internal/request/IRawRequestDelegate;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/openfeint/internal/ui/Settings$SettingsActionHandler;->logout(Ljava/util/Map;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lcom/openfeint/internal/ui/Settings$SettingsActionHandler;


# direct methods
.method constructor <init>(Lcom/openfeint/internal/ui/Settings$SettingsActionHandler;)V
    .locals 0

    iput-object p1, p0, Lcom/openfeint/internal/ui/Settings$SettingsActionHandler$1;->this$1:Lcom/openfeint/internal/ui/Settings$SettingsActionHandler;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final onResponse(ILjava/lang/String;)V
    .locals 1

    iget-object v0, p0, Lcom/openfeint/internal/ui/Settings$SettingsActionHandler$1;->this$1:Lcom/openfeint/internal/ui/Settings$SettingsActionHandler;

    iget-object v0, v0, Lcom/openfeint/internal/ui/Settings$SettingsActionHandler;->this$0:Lcom/openfeint/internal/ui/Settings;

    invoke-virtual {v0}, Lcom/openfeint/internal/ui/Settings;->finish()V

    return-void
.end method
