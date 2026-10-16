.class public final Lcom/openfeint/internal/analytics/internal/AnalyticsRequest;
.super Lcom/openfeint/internal/request/BaseRequest;


# instance fields
.field endid:Ljava/lang/Long;

.field startid:Ljava/lang/Long;

.field public final tag:Ljava/lang/String;


# direct methods
.method public constructor <init>(Ljava/lang/Long;Ljava/lang/Long;Lcom/openfeint/internal/request/OrderedArgList;)V
    .locals 1

    invoke-direct {p0, p3}, Lcom/openfeint/internal/request/BaseRequest;-><init>(Lcom/openfeint/internal/request/OrderedArgList;)V

    const-string v0, "AnalyticsRequest"

    iput-object v0, p0, Lcom/openfeint/internal/analytics/internal/AnalyticsRequest;->tag:Ljava/lang/String;

    iput-object p1, p0, Lcom/openfeint/internal/analytics/internal/AnalyticsRequest;->startid:Ljava/lang/Long;

    iput-object p2, p0, Lcom/openfeint/internal/analytics/internal/AnalyticsRequest;->endid:Ljava/lang/Long;

    return-void
.end method


# virtual methods
.method public final method()Ljava/lang/String;
    .locals 1

    const-string v0, "POST"

    return-object v0
.end method

.method public final onResponse(I[B)V
    .locals 6

    const/4 v3, 0x2

    const/4 v5, 0x1

    const/4 v4, 0x0

    const-string v0, "AnalyticsRequest"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "ResponseCode:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/openfeint/internal/logcat/OFLog;->v(Ljava/lang/String;Ljava/lang/String;)V

    const/16 v0, 0xc8

    if-gt v0, p1, :cond_0

    const/16 v0, 0x12c

    if-ge p1, v0, :cond_0

    const-string v0, "AnalyticsRequest"

    const-string v1, "push log num form %d to %d, Success!"

    new-array v2, v3, [Ljava/lang/Object;

    iget-object v3, p0, Lcom/openfeint/internal/analytics/internal/AnalyticsRequest;->startid:Ljava/lang/Long;

    aput-object v3, v2, v4

    iget-object v3, p0, Lcom/openfeint/internal/analytics/internal/AnalyticsRequest;->endid:Ljava/lang/Long;

    aput-object v3, v2, v5

    invoke-static {v1, v2}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/openfeint/internal/logcat/OFLog;->d(Ljava/lang/String;Ljava/lang/String;)V

    invoke-static {}, Lcom/openfeint/internal/analytics/AnalyticsManager;->instance()Lcom/openfeint/internal/analytics/AnalyticsManager;

    move-result-object v0

    iget-object v1, p0, Lcom/openfeint/internal/analytics/internal/AnalyticsRequest;->startid:Ljava/lang/Long;

    iget-object v2, p0, Lcom/openfeint/internal/analytics/internal/AnalyticsRequest;->endid:Ljava/lang/Long;

    invoke-virtual {v0, v1, v2}, Lcom/openfeint/internal/analytics/AnalyticsManager;->deleteLog(Ljava/lang/Long;Ljava/lang/Long;)V

    invoke-static {}, Lcom/openfeint/internal/analytics/AnalyticsManager;->instance()Lcom/openfeint/internal/analytics/AnalyticsManager;

    move-result-object v0

    invoke-virtual {v0}, Lcom/openfeint/internal/analytics/AnalyticsManager;->unlock()V

    :goto_0
    return-void

    :cond_0
    const-string v0, "AnalyticsRequest"

    const-string v1, "push log num form %d to %d, Failed!"

    new-array v2, v3, [Ljava/lang/Object;

    iget-object v3, p0, Lcom/openfeint/internal/analytics/internal/AnalyticsRequest;->startid:Ljava/lang/Long;

    aput-object v3, v2, v4

    iget-object v3, p0, Lcom/openfeint/internal/analytics/internal/AnalyticsRequest;->endid:Ljava/lang/Long;

    aput-object v3, v2, v5

    invoke-static {v1, v2}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/openfeint/internal/logcat/OFLog;->w(Ljava/lang/String;Ljava/lang/String;)V

    invoke-static {}, Lcom/openfeint/internal/analytics/AnalyticsManager;->instance()Lcom/openfeint/internal/analytics/AnalyticsManager;

    move-result-object v0

    invoke-virtual {v0}, Lcom/openfeint/internal/analytics/AnalyticsManager;->unlock()V

    goto :goto_0
.end method

.method public final path()Ljava/lang/String;
    .locals 1

    const-string v0, "/xp/events"

    return-object v0
.end method
