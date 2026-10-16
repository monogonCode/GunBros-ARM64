.class public final Lcom/openfeint/internal/analytics/internal/BaseAnalyticsLog;
.super Ljava/lang/Object;

# interfaces
.implements Lcom/openfeint/internal/analytics/IAnalyticsLogger;


# instance fields
.field protected base:Ljava/util/Map;
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
.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lcom/openfeint/internal/analytics/internal/BaseAnalyticsLog;->base:Ljava/util/Map;

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

    iget-object v0, p0, Lcom/openfeint/internal/analytics/internal/BaseAnalyticsLog;->base:Ljava/util/Map;

    return-object v0
.end method

.method public final makeEvent(Ljava/lang/String;Ljava/lang/Object;)V
    .locals 1

    iget-object v0, p0, Lcom/openfeint/internal/analytics/internal/BaseAnalyticsLog;->base:Ljava/util/Map;

    invoke-interface {v0, p1, p2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    return-void
.end method
