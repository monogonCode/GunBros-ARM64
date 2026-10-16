.class public final Lcom/openfeint/internal/analytics/SDKAnalyticsLogFactory;
.super Ljava/lang/Object;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static getNewClientSDKBaseLog(Ljava/lang/String;)Lcom/openfeint/internal/analytics/IAnalyticsLogger;
    .locals 8

    const/high16 v7, 0x447a0000    # 1000.0f

    new-instance v0, Lcom/openfeint/internal/analytics/internal/BaseAnalyticsLog;

    invoke-direct {v0}, Lcom/openfeint/internal/analytics/internal/BaseAnalyticsLog;-><init>()V

    new-instance v1, Lcom/openfeint/internal/analytics/internal/Client_sdk_AnalyticsDecorator;

    invoke-direct {v1, v0}, Lcom/openfeint/internal/analytics/internal/Client_sdk_AnalyticsDecorator;-><init>(Lcom/openfeint/internal/analytics/IAnalyticsLogger;)V

    new-instance v2, Lcom/openfeint/internal/analytics/internal/EventDecorator;

    invoke-direct {v2, v1}, Lcom/openfeint/internal/analytics/internal/EventDecorator;-><init>(Lcom/openfeint/internal/analytics/IAnalyticsLogger;)V

    const-string v0, "gsdi"

    invoke-static {}, Lcom/openfeint/internal/OpenFeintInternal;->getInstance()Lcom/openfeint/internal/OpenFeintInternal;

    move-result-object v1

    invoke-virtual {v1}, Lcom/openfeint/internal/OpenFeintInternal;->getGSDI()Ljava/lang/String;

    move-result-object v1

    invoke-interface {v2, v0, v1}, Lcom/openfeint/internal/analytics/IAnalyticsLogger;->makeEvent(Ljava/lang/String;Ljava/lang/Object;)V

    const-string v0, "session_id"

    invoke-static {}, Lcom/openfeint/internal/OpenFeintInternal;->getInstance()Lcom/openfeint/internal/OpenFeintInternal;

    move-result-object v1

    invoke-virtual {v1}, Lcom/openfeint/internal/OpenFeintInternal;->getSessionID()Ljava/lang/String;

    move-result-object v1

    invoke-interface {v2, v0, v1}, Lcom/openfeint/internal/analytics/IAnalyticsLogger;->makeEvent(Ljava/lang/String;Ljava/lang/Object;)V

    invoke-static {}, Lcom/openfeint/internal/OpenFeintInternal;->getInstance()Lcom/openfeint/internal/OpenFeintInternal;

    move-result-object v0

    invoke-virtual {v0}, Lcom/openfeint/internal/OpenFeintInternal;->getSessionStartDate()Ljava/util/Date;

    move-result-object v0

    const-string v1, "session_length"

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v3

    invoke-virtual {v0}, Ljava/util/Date;->getTime()J

    move-result-wide v5

    sub-long/2addr v3, v5

    long-to-float v0, v3

    div-float/2addr v0, v7

    invoke-static {v0}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object v0

    invoke-interface {v2, v1, v0}, Lcom/openfeint/internal/analytics/IAnalyticsLogger;->makeEvent(Ljava/lang/String;Ljava/lang/Object;)V

    invoke-static {}, Lcom/openfeint/internal/OpenFeintInternal;->getInstance()Lcom/openfeint/internal/OpenFeintInternal;

    move-result-object v0

    invoke-virtual {v0}, Lcom/openfeint/internal/OpenFeintInternal;->getCurrentUser()Lcom/openfeint/api/resource/CurrentUser;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Lcom/openfeint/api/resource/User;->userID()Ljava/lang/String;

    move-result-object v0

    :goto_0
    const-string v1, "user_id"

    invoke-interface {v2, v1, v0}, Lcom/openfeint/internal/analytics/IAnalyticsLogger;->makeEvent(Ljava/lang/String;Ljava/lang/Object;)V

    invoke-static {}, Lcom/openfeint/internal/analytics/internal/TimeUtil;->getAccumulated_ms()J

    move-result-wide v0

    long-to-float v0, v0

    div-float/2addr v0, v7

    const-string v1, "session_play_time"

    invoke-static {v0}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object v0

    invoke-interface {v2, v1, v0}, Lcom/openfeint/internal/analytics/IAnalyticsLogger;->makeEvent(Ljava/lang/String;Ljava/lang/Object;)V

    const-string v0, "action"

    invoke-interface {v2, v0, p0}, Lcom/openfeint/internal/analytics/IAnalyticsLogger;->makeEvent(Ljava/lang/String;Ljava/lang/Object;)V

    return-object v2

    :cond_0
    const-string v0, "0"

    goto :goto_0
.end method
