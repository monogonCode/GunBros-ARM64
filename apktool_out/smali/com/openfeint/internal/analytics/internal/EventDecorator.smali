.class public final Lcom/openfeint/internal/analytics/internal/EventDecorator;
.super Lcom/openfeint/internal/analytics/internal/BaseAnalyticsDecorator;


# instance fields
.field protected event:Ljava/util/Map;
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
.method public constructor <init>(Lcom/openfeint/internal/analytics/IAnalyticsLogger;)V
    .locals 2

    invoke-direct {p0, p1}, Lcom/openfeint/internal/analytics/internal/BaseAnalyticsDecorator;-><init>(Lcom/openfeint/internal/analytics/IAnalyticsLogger;)V

    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lcom/openfeint/internal/analytics/internal/EventDecorator;->event:Ljava/util/Map;

    const-string v0, "event"

    iget-object v1, p0, Lcom/openfeint/internal/analytics/internal/EventDecorator;->event:Ljava/util/Map;

    invoke-interface {p1, v0, v1}, Lcom/openfeint/internal/analytics/IAnalyticsLogger;->makeEvent(Ljava/lang/String;Ljava/lang/Object;)V

    return-void
.end method


# virtual methods
.method public final getMap()Ljava/util/Map;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/Map",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/Object;",
            ">;"
        }
    .end annotation

    iget-object v0, p0, Lcom/openfeint/internal/analytics/internal/EventDecorator;->logger:Lcom/openfeint/internal/analytics/IAnalyticsLogger;

    invoke-interface {v0}, Lcom/openfeint/internal/analytics/IAnalyticsLogger;->getMap()Ljava/util/Map;

    move-result-object v0

    return-object v0
.end method

.method public final makeEvent(Ljava/lang/String;Ljava/lang/Object;)V
    .locals 1

    iget-object v0, p0, Lcom/openfeint/internal/analytics/internal/EventDecorator;->event:Ljava/util/Map;

    invoke-interface {v0, p1, p2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    return-void
.end method
