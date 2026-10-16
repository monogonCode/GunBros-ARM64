.class public final Lcom/openfeint/internal/analytics/AnalyticsManager;
.super Ljava/lang/Object;


# static fields
.field private static batch_num_trigger:I

.field private static instance:Lcom/openfeint/internal/analytics/AnalyticsManager;


# instance fields
.field private client_application_id:Ljava/lang/String;

.field private count:I

.field private country:Ljava/lang/String;

.field private hardware:Ljava/lang/String;

.field private info:Ljava/util/Map;
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

.field private locale:Ljava/lang/String;

.field private mContext:Landroid/content/Context;

.field private of_version:Ljava/lang/String;

.field private os_version:Ljava/lang/String;

.field private platform:Ljava/lang/String;

.field private tag:Ljava/lang/String;

.field private version:Ljava/lang/String;

.field private waiting:Z


# direct methods
.method private constructor <init>(Landroid/content/Context;)V
    .locals 2

    const/4 v1, 0x0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const-string v0, "AnalyticsManager"

    iput-object v0, p0, Lcom/openfeint/internal/analytics/AnalyticsManager;->tag:Ljava/lang/String;

    iput-object p1, p0, Lcom/openfeint/internal/analytics/AnalyticsManager;->mContext:Landroid/content/Context;

    iput v1, p0, Lcom/openfeint/internal/analytics/AnalyticsManager;->count:I

    sget v0, Lcom/openfeint/internal/analytics/AnalyticsManager;->batch_num_trigger:I

    if-nez v0, :cond_0

    const/16 v0, 0xa

    sput v0, Lcom/openfeint/internal/analytics/AnalyticsManager;->batch_num_trigger:I

    :cond_0
    iput-boolean v1, p0, Lcom/openfeint/internal/analytics/AnalyticsManager;->waiting:Z

    invoke-direct {p0}, Lcom/openfeint/internal/analytics/AnalyticsManager;->initInfo()V

    return-void
.end method

.method private getInfo()Ljava/util/Map;
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

    iget-object v0, p0, Lcom/openfeint/internal/analytics/AnalyticsManager;->info:Ljava/util/Map;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/openfeint/internal/analytics/AnalyticsManager;->info:Ljava/util/Map;

    invoke-interface {v0}, Ljava/util/Map;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_1

    :cond_0
    invoke-direct {p0}, Lcom/openfeint/internal/analytics/AnalyticsManager;->initInfo()V

    :cond_1
    iget-object v0, p0, Lcom/openfeint/internal/analytics/AnalyticsManager;->info:Ljava/util/Map;

    return-object v0
.end method

.method private initInfo()V
    .locals 3

    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lcom/openfeint/internal/analytics/AnalyticsManager;->info:Ljava/util/Map;

    invoke-static {}, Lcom/openfeint/internal/OpenFeintInternal;->getModelString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/openfeint/internal/analytics/AnalyticsManager;->hardware:Ljava/lang/String;

    invoke-static {}, Lcom/openfeint/internal/OpenFeintInternal;->getInstance()Lcom/openfeint/internal/OpenFeintInternal;

    move-result-object v0

    invoke-virtual {v0}, Lcom/openfeint/internal/OpenFeintInternal;->getAppID()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/openfeint/internal/analytics/AnalyticsManager;->client_application_id:Ljava/lang/String;

    invoke-static {}, Lcom/openfeint/internal/OpenFeintInternal;->getInstance()Lcom/openfeint/internal/OpenFeintInternal;

    move-result-object v0

    invoke-virtual {v0}, Lcom/openfeint/internal/OpenFeintInternal;->getAppVersion()I

    move-result v0

    invoke-static {v0}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/openfeint/internal/analytics/AnalyticsManager;->version:Ljava/lang/String;

    invoke-static {}, Lcom/openfeint/internal/OpenFeintInternal;->getInstance()Lcom/openfeint/internal/OpenFeintInternal;

    move-result-object v0

    invoke-virtual {v0}, Lcom/openfeint/internal/OpenFeintInternal;->getOFVersion()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/openfeint/internal/analytics/AnalyticsManager;->of_version:Ljava/lang/String;

    invoke-static {}, Lcom/openfeint/internal/OpenFeintInternal;->getOSVersionString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/openfeint/internal/analytics/AnalyticsManager;->os_version:Ljava/lang/String;

    const-string v0, "Android"

    iput-object v0, p0, Lcom/openfeint/internal/analytics/AnalyticsManager;->platform:Ljava/lang/String;

    invoke-static {}, Lcom/openfeint/internal/OpenFeintInternal;->getInstance()Lcom/openfeint/internal/OpenFeintInternal;

    move-result-object v0

    invoke-virtual {v0}, Lcom/openfeint/internal/OpenFeintInternal;->getLocaleString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/openfeint/internal/analytics/AnalyticsManager;->locale:Ljava/lang/String;

    invoke-static {}, Lcom/openfeint/internal/OpenFeintInternal;->getInstance()Lcom/openfeint/internal/OpenFeintInternal;

    move-result-object v0

    invoke-virtual {v0}, Lcom/openfeint/internal/OpenFeintInternal;->getCountryString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/openfeint/internal/analytics/AnalyticsManager;->country:Ljava/lang/String;

    iget-object v0, p0, Lcom/openfeint/internal/analytics/AnalyticsManager;->tag:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "hardware:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/openfeint/internal/analytics/AnalyticsManager;->hardware:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/openfeint/internal/logcat/OFLog;->d(Ljava/lang/String;Ljava/lang/String;)V

    iget-object v0, p0, Lcom/openfeint/internal/analytics/AnalyticsManager;->tag:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "client_application_id:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/openfeint/internal/analytics/AnalyticsManager;->client_application_id:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/openfeint/internal/logcat/OFLog;->d(Ljava/lang/String;Ljava/lang/String;)V

    iget-object v0, p0, Lcom/openfeint/internal/analytics/AnalyticsManager;->tag:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "version:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/openfeint/internal/analytics/AnalyticsManager;->version:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/openfeint/internal/logcat/OFLog;->d(Ljava/lang/String;Ljava/lang/String;)V

    iget-object v0, p0, Lcom/openfeint/internal/analytics/AnalyticsManager;->tag:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "of_version:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/openfeint/internal/analytics/AnalyticsManager;->of_version:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/openfeint/internal/logcat/OFLog;->d(Ljava/lang/String;Ljava/lang/String;)V

    iget-object v0, p0, Lcom/openfeint/internal/analytics/AnalyticsManager;->tag:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "os_version:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/openfeint/internal/analytics/AnalyticsManager;->os_version:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/openfeint/internal/logcat/OFLog;->d(Ljava/lang/String;Ljava/lang/String;)V

    iget-object v0, p0, Lcom/openfeint/internal/analytics/AnalyticsManager;->tag:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "platform:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/openfeint/internal/analytics/AnalyticsManager;->platform:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/openfeint/internal/logcat/OFLog;->d(Ljava/lang/String;Ljava/lang/String;)V

    iget-object v0, p0, Lcom/openfeint/internal/analytics/AnalyticsManager;->tag:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "locale:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/openfeint/internal/analytics/AnalyticsManager;->locale:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/openfeint/internal/logcat/OFLog;->d(Ljava/lang/String;Ljava/lang/String;)V

    iget-object v0, p0, Lcom/openfeint/internal/analytics/AnalyticsManager;->tag:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "country:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/openfeint/internal/analytics/AnalyticsManager;->country:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/openfeint/internal/logcat/OFLog;->d(Ljava/lang/String;Ljava/lang/String;)V

    iget-object v0, p0, Lcom/openfeint/internal/analytics/AnalyticsManager;->info:Ljava/util/Map;

    const-string v1, "hardware"

    iget-object v2, p0, Lcom/openfeint/internal/analytics/AnalyticsManager;->hardware:Ljava/lang/String;

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Lcom/openfeint/internal/analytics/AnalyticsManager;->info:Ljava/util/Map;

    const-string v1, "client_application_id"

    iget-object v2, p0, Lcom/openfeint/internal/analytics/AnalyticsManager;->client_application_id:Ljava/lang/String;

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Lcom/openfeint/internal/analytics/AnalyticsManager;->info:Ljava/util/Map;

    const-string v1, "version"

    iget-object v2, p0, Lcom/openfeint/internal/analytics/AnalyticsManager;->version:Ljava/lang/String;

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Lcom/openfeint/internal/analytics/AnalyticsManager;->info:Ljava/util/Map;

    const-string v1, "of_version"

    iget-object v2, p0, Lcom/openfeint/internal/analytics/AnalyticsManager;->of_version:Ljava/lang/String;

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Lcom/openfeint/internal/analytics/AnalyticsManager;->info:Ljava/util/Map;

    const-string v1, "os_version"

    iget-object v2, p0, Lcom/openfeint/internal/analytics/AnalyticsManager;->os_version:Ljava/lang/String;

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Lcom/openfeint/internal/analytics/AnalyticsManager;->info:Ljava/util/Map;

    const-string v1, "platform"

    iget-object v2, p0, Lcom/openfeint/internal/analytics/AnalyticsManager;->platform:Ljava/lang/String;

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Lcom/openfeint/internal/analytics/AnalyticsManager;->info:Ljava/util/Map;

    const-string v1, "locale"

    iget-object v2, p0, Lcom/openfeint/internal/analytics/AnalyticsManager;->locale:Ljava/lang/String;

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Lcom/openfeint/internal/analytics/AnalyticsManager;->info:Ljava/util/Map;

    const-string v1, "country"

    iget-object v2, p0, Lcom/openfeint/internal/analytics/AnalyticsManager;->country:Ljava/lang/String;

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    return-void
.end method

.method public static instance()Lcom/openfeint/internal/analytics/AnalyticsManager;
    .locals 1

    sget-object v0, Lcom/openfeint/internal/analytics/AnalyticsManager;->instance:Lcom/openfeint/internal/analytics/AnalyticsManager;

    return-object v0
.end method

.method public static instance(Landroid/content/Context;)Lcom/openfeint/internal/analytics/AnalyticsManager;
    .locals 1

    sget-object v0, Lcom/openfeint/internal/analytics/AnalyticsManager;->instance:Lcom/openfeint/internal/analytics/AnalyticsManager;

    if-nez v0, :cond_0

    new-instance v0, Lcom/openfeint/internal/analytics/AnalyticsManager;

    invoke-direct {v0, p0}, Lcom/openfeint/internal/analytics/AnalyticsManager;-><init>(Landroid/content/Context;)V

    sput-object v0, Lcom/openfeint/internal/analytics/AnalyticsManager;->instance:Lcom/openfeint/internal/analytics/AnalyticsManager;

    :cond_0
    sget-object v0, Lcom/openfeint/internal/analytics/AnalyticsManager;->instance:Lcom/openfeint/internal/analytics/AnalyticsManager;

    return-object v0
.end method

.method private upload()V
    .locals 14

    iget-boolean v0, p0, Lcom/openfeint/internal/analytics/AnalyticsManager;->waiting:Z

    const/4 v1, 0x1

    if-ne v0, v1, :cond_1

    iget-object v0, p0, Lcom/openfeint/internal/analytics/AnalyticsManager;->tag:Ljava/lang/String;

    const-string v1, "Waiting for response,skip upload this time"

    invoke-static {v0, v1}, Lcom/openfeint/internal/logcat/OFLog;->d(Ljava/lang/String;Ljava/lang/String;)V

    :cond_0
    :goto_0
    return-void

    :cond_1
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/openfeint/internal/analytics/AnalyticsManager;->waiting:Z

    iget-object v0, p0, Lcom/openfeint/internal/analytics/AnalyticsManager;->mContext:Landroid/content/Context;

    invoke-static {v0}, Lcom/openfeint/internal/analytics/db/AnalyticsDBManager;->instance(Landroid/content/Context;)Lcom/openfeint/internal/analytics/db/AnalyticsDBManager;

    move-result-object v0

    invoke-virtual {v0}, Lcom/openfeint/internal/analytics/db/AnalyticsDBManager;->getAllItems()Ljava/util/List;

    move-result-object v6

    invoke-interface {v6}, Ljava/util/List;->size()I

    move-result v7

    const/4 v0, 0x0

    invoke-interface {v6}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v8

    new-instance v3, Ljava/util/ArrayList;

    const/16 v1, 0x64

    invoke-direct {v3, v1}, Ljava/util/ArrayList;-><init>(I)V

    const/4 v1, 0x0

    move v4, v1

    move-object v5, v0

    :goto_1
    invoke-interface {v8}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_5

    invoke-interface {v8}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/Map;

    const-string v1, "json"

    invoke-interface {v0, v1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    iget-object v2, p0, Lcom/openfeint/internal/analytics/AnalyticsManager;->tag:Ljava/lang/String;

    invoke-static {v2, v1}, Lcom/openfeint/internal/logcat/OFLog;->v(Ljava/lang/String;Ljava/lang/String;)V

    iget-object v2, p0, Lcom/openfeint/internal/analytics/AnalyticsManager;->tag:Ljava/lang/String;

    const-string v9, "--------"

    invoke-static {v2, v9}, Lcom/openfeint/internal/logcat/OFLog;->v(Ljava/lang/String;Ljava/lang/String;)V

    const-string v2, "log_time"

    invoke-interface {v0, v2}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/Long;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v9

    invoke-virtual {v2}, Ljava/lang/Long;->longValue()J

    move-result-wide v11

    sub-long/2addr v9, v11

    invoke-static {v9, v10}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/Long;->longValue()J

    move-result-wide v9

    long-to-float v2, v9

    const/high16 v9, 0x447a0000    # 1000.0f

    div-float/2addr v2, v9

    float-to-double v9, v2

    invoke-static {v1}, Lcom/openfeint/internal/JsonCoder;->parse(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/util/Map;

    invoke-interface {v1}, Ljava/util/Map;->keySet()Ljava/util/Set;

    move-result-object v2

    invoke-interface {v2}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v11

    :cond_2
    :goto_2
    invoke-interface {v11}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_3

    invoke-interface {v11}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    invoke-interface {v1, v2}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/util/Map;

    const-string v12, "event"

    invoke-interface {v2, v12}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/util/Map;

    if-eqz v2, :cond_2

    const-string v12, "time_delta"

    invoke-static {v9, v10}, Ljava/lang/Double;->valueOf(D)Ljava/lang/Double;

    move-result-object v13

    invoke-interface {v2, v12, v13}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_2

    :cond_3
    invoke-interface {v3, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    add-int/lit8 v2, v4, 0x1

    const/4 v1, 0x1

    if-ne v2, v1, :cond_6

    const-string v1, "log_id"

    invoke-interface {v0, v1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/Long;

    move-object v4, v1

    :goto_3
    const/16 v1, 0x64

    if-ne v2, v1, :cond_7

    const-string v1, "log_id"

    invoke-interface {v0, v1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Long;

    new-instance v1, Lcom/openfeint/internal/request/OrderedArgList;

    invoke-direct {v1}, Lcom/openfeint/internal/request/OrderedArgList;-><init>()V

    const-string v2, "event"

    invoke-static {v3}, Lcom/openfeint/internal/JsonCoder;->generateJson(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v1, v2, v5}, Lcom/openfeint/internal/request/OrderedArgList;->put(Ljava/lang/String;Ljava/lang/String;)V

    const-string v2, "info"

    invoke-direct {p0}, Lcom/openfeint/internal/analytics/AnalyticsManager;->getInfo()Ljava/util/Map;

    move-result-object v5

    invoke-static {v5}, Lcom/openfeint/internal/JsonCoder;->generateJson(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v1, v2, v5}, Lcom/openfeint/internal/request/OrderedArgList;->put(Ljava/lang/String;Ljava/lang/String;)V

    invoke-static {}, Lcom/openfeint/internal/logcat/OFLog;->willLog$134632()Z

    move-result v2

    if-eqz v2, :cond_4

    iget-object v2, p0, Lcom/openfeint/internal/analytics/AnalyticsManager;->tag:Ljava/lang/String;

    const-string v5, "try upload from %d to %d :"

    const/4 v9, 0x2

    new-array v9, v9, [Ljava/lang/Object;

    const/4 v10, 0x0

    aput-object v4, v9, v10

    const/4 v10, 0x1

    aput-object v0, v9, v10

    invoke-static {v5, v9}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v5

    invoke-static {v2, v5}, Lcom/openfeint/internal/logcat/OFLog;->d(Ljava/lang/String;Ljava/lang/String;)V

    iget-object v2, p0, Lcom/openfeint/internal/analytics/AnalyticsManager;->tag:Ljava/lang/String;

    invoke-direct {p0}, Lcom/openfeint/internal/analytics/AnalyticsManager;->getInfo()Ljava/util/Map;

    move-result-object v5

    invoke-static {v5}, Lcom/openfeint/internal/JsonCoder;->generateJson(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v5

    invoke-static {v2, v5}, Lcom/openfeint/internal/logcat/OFLog;->d(Ljava/lang/String;Ljava/lang/String;)V

    iget-object v2, p0, Lcom/openfeint/internal/analytics/AnalyticsManager;->tag:Ljava/lang/String;

    invoke-static {v3}, Lcom/openfeint/internal/JsonCoder;->generateJson(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Lcom/openfeint/internal/logcat/OFLog;->d(Ljava/lang/String;Ljava/lang/String;)V

    :cond_4
    new-instance v2, Lcom/openfeint/internal/analytics/internal/AnalyticsRequest;

    invoke-direct {v2, v4, v0, v1}, Lcom/openfeint/internal/analytics/internal/AnalyticsRequest;-><init>(Ljava/lang/Long;Ljava/lang/Long;Lcom/openfeint/internal/request/OrderedArgList;)V

    invoke-virtual {v2}, Lcom/openfeint/internal/analytics/internal/AnalyticsRequest;->launch()V

    new-instance v0, Ljava/util/ArrayList;

    const/16 v1, 0x64

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(I)V

    const/4 v1, 0x0

    :goto_4
    move-object v3, v0

    move-object v5, v4

    move v4, v1

    goto/16 :goto_1

    :cond_5
    if-lez v7, :cond_0

    add-int/lit8 v0, v7, -0x1

    invoke-interface {v6, v0}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/Map;

    const-string v1, "log_id"

    invoke-interface {v0, v1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Long;

    new-instance v1, Lcom/openfeint/internal/request/OrderedArgList;

    invoke-direct {v1}, Lcom/openfeint/internal/request/OrderedArgList;-><init>()V

    const-string v2, "event"

    invoke-static {v3}, Lcom/openfeint/internal/JsonCoder;->generateJson(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v1, v2, v4}, Lcom/openfeint/internal/request/OrderedArgList;->put(Ljava/lang/String;Ljava/lang/String;)V

    const-string v2, "info"

    invoke-direct {p0}, Lcom/openfeint/internal/analytics/AnalyticsManager;->getInfo()Ljava/util/Map;

    move-result-object v4

    invoke-static {v4}, Lcom/openfeint/internal/JsonCoder;->generateJson(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v1, v2, v4}, Lcom/openfeint/internal/request/OrderedArgList;->put(Ljava/lang/String;Ljava/lang/String;)V

    iget-object v2, p0, Lcom/openfeint/internal/analytics/AnalyticsManager;->tag:Ljava/lang/String;

    const-string v4, "try upload from %d to %d :"

    const/4 v6, 0x2

    new-array v6, v6, [Ljava/lang/Object;

    const/4 v7, 0x0

    aput-object v5, v6, v7

    const/4 v7, 0x1

    aput-object v0, v6, v7

    invoke-static {v4, v6}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v4

    invoke-static {v2, v4}, Lcom/openfeint/internal/logcat/OFLog;->d(Ljava/lang/String;Ljava/lang/String;)V

    iget-object v2, p0, Lcom/openfeint/internal/analytics/AnalyticsManager;->tag:Ljava/lang/String;

    invoke-direct {p0}, Lcom/openfeint/internal/analytics/AnalyticsManager;->getInfo()Ljava/util/Map;

    move-result-object v4

    invoke-static {v4}, Lcom/openfeint/internal/JsonCoder;->generateJson(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v4

    invoke-static {v2, v4}, Lcom/openfeint/internal/logcat/OFLog;->d(Ljava/lang/String;Ljava/lang/String;)V

    iget-object v2, p0, Lcom/openfeint/internal/analytics/AnalyticsManager;->tag:Ljava/lang/String;

    invoke-static {v3}, Lcom/openfeint/internal/JsonCoder;->generateJson(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Lcom/openfeint/internal/logcat/OFLog;->d(Ljava/lang/String;Ljava/lang/String;)V

    new-instance v2, Lcom/openfeint/internal/analytics/internal/AnalyticsRequest;

    invoke-direct {v2, v5, v0, v1}, Lcom/openfeint/internal/analytics/internal/AnalyticsRequest;-><init>(Ljava/lang/Long;Ljava/lang/Long;Lcom/openfeint/internal/request/OrderedArgList;)V

    invoke-virtual {v2}, Lcom/openfeint/internal/analytics/internal/AnalyticsRequest;->launch()V

    goto/16 :goto_0

    :cond_6
    move-object v4, v5

    goto/16 :goto_3

    :cond_7
    move-object v0, v3

    move v1, v2

    goto :goto_4
.end method


# virtual methods
.method public final deleteLog(Ljava/lang/Long;Ljava/lang/Long;)V
    .locals 5

    iget-object v0, p0, Lcom/openfeint/internal/analytics/AnalyticsManager;->mContext:Landroid/content/Context;

    invoke-static {v0}, Lcom/openfeint/internal/analytics/db/AnalyticsDBManager;->instance(Landroid/content/Context;)Lcom/openfeint/internal/analytics/db/AnalyticsDBManager;

    move-result-object v0

    invoke-virtual {p1}, Ljava/lang/Long;->longValue()J

    move-result-wide v1

    invoke-virtual {p2}, Ljava/lang/Long;->longValue()J

    move-result-wide v3

    invoke-virtual {v0, v1, v2, v3, v4}, Lcom/openfeint/internal/analytics/db/AnalyticsDBManager;->removeLog(JJ)Z

    return-void
.end method

.method public final makelog(Lcom/openfeint/internal/analytics/IAnalyticsLogger;Ljava/lang/String;)V
    .locals 4

    :try_start_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Log:\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-interface {p1}, Lcom/openfeint/internal/analytics/IAnalyticsLogger;->getMap()Ljava/util/Map;

    move-result-object v1

    invoke-static {v1}, Lcom/openfeint/internal/JsonCoder;->generateJson(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_0

    iget-object v2, p0, Lcom/openfeint/internal/analytics/AnalyticsManager;->mContext:Landroid/content/Context;

    invoke-static {v2}, Lcom/openfeint/internal/analytics/db/AnalyticsDBManager;->instance(Landroid/content/Context;)Lcom/openfeint/internal/analytics/db/AnalyticsDBManager;

    move-result-object v2

    invoke-virtual {v2, v1}, Lcom/openfeint/internal/analytics/db/AnalyticsDBManager;->insertLog(Ljava/lang/String;)J

    :cond_0
    iget v2, p0, Lcom/openfeint/internal/analytics/AnalyticsManager;->count:I

    add-int/lit8 v2, v2, 0x1

    iput v2, p0, Lcom/openfeint/internal/analytics/AnalyticsManager;->count:I

    iget v2, p0, Lcom/openfeint/internal/analytics/AnalyticsManager;->count:I

    sget v3, Lcom/openfeint/internal/analytics/AnalyticsManager;->batch_num_trigger:I

    if-lt v2, v3, :cond_1

    iget-object v2, p0, Lcom/openfeint/internal/analytics/AnalyticsManager;->tag:Ljava/lang/String;

    const-string v3, "log batch upload triggered"

    invoke-static {v2, v3}, Lcom/openfeint/internal/logcat/OFLog;->d(Ljava/lang/String;Ljava/lang/String;)V

    invoke-direct {p0}, Lcom/openfeint/internal/analytics/AnalyticsManager;->upload()V

    const/4 v2, 0x0

    iput v2, p0, Lcom/openfeint/internal/analytics/AnalyticsManager;->count:I

    :cond_1
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {p2, v0}, Lcom/openfeint/internal/logcat/OFLog;->d(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return-void

    :catch_0
    move-exception v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "log save failed"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v0}, Ljava/lang/Exception;->getLocalizedMessage()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {p2, v0}, Lcom/openfeint/internal/logcat/OFLog;->e(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0
.end method

.method public final unlock()V
    .locals 1

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/openfeint/internal/analytics/AnalyticsManager;->waiting:Z

    return-void
.end method
