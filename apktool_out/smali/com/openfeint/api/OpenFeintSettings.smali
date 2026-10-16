.class public final Lcom/openfeint/api/OpenFeintSettings;
.super Ljava/lang/Object;


# static fields
.field public static tag:Ljava/lang/String;


# instance fields
.field public id:Ljava/lang/String;

.field public key:Ljava/lang/String;

.field public name:Ljava/lang/String;

.field public secret:Ljava/lang/String;

.field public settings:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/Object;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 1

    const-string v0, "OpenFeintSettings"

    sput-object v0, Lcom/openfeint/api/OpenFeintSettings;->tag:Ljava/lang/String;

    return-void
.end method

.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/openfeint/api/OpenFeintSettings;->name:Ljava/lang/String;

    iput-object p2, p0, Lcom/openfeint/api/OpenFeintSettings;->key:Ljava/lang/String;

    iput-object p3, p0, Lcom/openfeint/api/OpenFeintSettings;->secret:Ljava/lang/String;

    iput-object p4, p0, Lcom/openfeint/api/OpenFeintSettings;->id:Ljava/lang/String;

    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lcom/openfeint/api/OpenFeintSettings;->settings:Ljava/util/Map;

    return-void
.end method


# virtual methods
.method public final applyOverrides(Ljava/util/Properties;)V
    .locals 1

    if-nez p1, :cond_1

    :cond_0
    :goto_0
    return-void

    :cond_1
    const-string v0, "app-id"

    invoke-virtual {p1, v0}, Ljava/util/Properties;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_2

    iput-object v0, p0, Lcom/openfeint/api/OpenFeintSettings;->id:Ljava/lang/String;

    :cond_2
    const-string v0, "game-name"

    invoke-virtual {p1, v0}, Ljava/util/Properties;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_3

    iput-object v0, p0, Lcom/openfeint/api/OpenFeintSettings;->name:Ljava/lang/String;

    :cond_3
    const-string v0, "app-key"

    invoke-virtual {p1, v0}, Ljava/util/Properties;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_4

    iput-object v0, p0, Lcom/openfeint/api/OpenFeintSettings;->key:Ljava/lang/String;

    :cond_4
    const-string v0, "app-secret"

    invoke-virtual {p1, v0}, Ljava/util/Properties;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_0

    iput-object v0, p0, Lcom/openfeint/api/OpenFeintSettings;->secret:Ljava/lang/String;

    goto :goto_0
.end method

.method public final verify()V
    .locals 2

    const/4 v0, 0x0

    iget-object v1, p0, Lcom/openfeint/api/OpenFeintSettings;->key:Ljava/lang/String;

    if-nez v1, :cond_2

    const-string v0, "of_key_cannot_be_null"

    invoke-static {v0}, Lcom/openfeint/internal/RR;->string(Ljava/lang/String;)I

    move-result v0

    invoke-static {v0}, Lcom/openfeint/internal/OpenFeintInternal;->getRString(I)Ljava/lang/String;

    move-result-object v0

    :cond_0
    :goto_0
    if-eqz v0, :cond_1

    sget-object v1, Lcom/openfeint/api/OpenFeintSettings;->tag:Ljava/lang/String;

    invoke-static {v1, v0}, Lcom/openfeint/internal/logcat/OFLog;->e(Ljava/lang/String;Ljava/lang/String;)V

    invoke-static {}, Lcom/openfeint/internal/OpenFeintInternal;->getInstance()Lcom/openfeint/internal/OpenFeintInternal;

    invoke-static {v0}, Lcom/openfeint/internal/OpenFeintInternal;->displayErrorDialog(Ljava/lang/CharSequence;)V

    :cond_1
    return-void

    :cond_2
    iget-object v1, p0, Lcom/openfeint/api/OpenFeintSettings;->secret:Ljava/lang/String;

    if-nez v1, :cond_3

    const-string v0, "of_secret_cannot_be_null"

    invoke-static {v0}, Lcom/openfeint/internal/RR;->string(Ljava/lang/String;)I

    move-result v0

    invoke-static {v0}, Lcom/openfeint/internal/OpenFeintInternal;->getRString(I)Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    :cond_3
    iget-object v1, p0, Lcom/openfeint/api/OpenFeintSettings;->id:Ljava/lang/String;

    if-nez v1, :cond_4

    const-string v0, "of_id_cannot_be_null"

    invoke-static {v0}, Lcom/openfeint/internal/RR;->string(Ljava/lang/String;)I

    move-result v0

    invoke-static {v0}, Lcom/openfeint/internal/OpenFeintInternal;->getRString(I)Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    :cond_4
    iget-object v1, p0, Lcom/openfeint/api/OpenFeintSettings;->name:Ljava/lang/String;

    if-nez v1, :cond_0

    const-string v0, "of_name_cannot_be_null"

    invoke-static {v0}, Lcom/openfeint/internal/RR;->string(Ljava/lang/String;)I

    move-result v0

    invoke-static {v0}, Lcom/openfeint/internal/OpenFeintInternal;->getRString(I)Ljava/lang/String;

    move-result-object v0

    goto :goto_0
.end method
