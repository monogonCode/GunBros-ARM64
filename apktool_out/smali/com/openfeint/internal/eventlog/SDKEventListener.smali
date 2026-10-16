.class public final Lcom/openfeint/internal/eventlog/SDKEventListener;
.super Ljava/lang/Object;

# interfaces
.implements Lcom/openfeint/internal/eventlog/IEventListener;


# static fields
.field public static tag:Ljava/lang/String;


# instance fields
.field private name:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    const-string v0, "SDKEventListener"

    sput-object v0, Lcom/openfeint/internal/eventlog/SDKEventListener;->tag:Ljava/lang/String;

    return-void
.end method

.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const-string v0, "SDKEventListener"

    iput-object v0, p0, Lcom/openfeint/internal/eventlog/SDKEventListener;->name:Ljava/lang/String;

    return-void
.end method


# virtual methods
.method public final getName()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/openfeint/internal/eventlog/SDKEventListener;->name:Ljava/lang/String;

    return-object v0
.end method

.method public final handleEvent(Ljava/lang/String;Ljava/lang/Object;)V
    .locals 4

    sget-object v0, Lcom/openfeint/internal/eventlog/SDKEventListener;->tag:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "MakeEvent in SDKEventListener:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/openfeint/internal/logcat/OFLog;->d(Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "new_user.openfeint.com"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_2

    iget-object v0, p0, Lcom/openfeint/internal/eventlog/SDKEventListener;->name:Ljava/lang/String;

    invoke-virtual {v0, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    const-string v0, ""

    invoke-static {v0}, Lcom/openfeint/internal/OpenFeintInternal;->setUserEnableSource(Ljava/lang/String;)V

    :cond_0
    const-string v0, "new_user"

    invoke-static {v0}, Lcom/openfeint/internal/analytics/SDKAnalyticsLogFactory;->getNewClientSDKBaseLog(Ljava/lang/String;)Lcom/openfeint/internal/analytics/IAnalyticsLogger;

    move-result-object v0

    invoke-static {}, Lcom/openfeint/internal/analytics/AnalyticsManager;->instance()Lcom/openfeint/internal/analytics/AnalyticsManager;

    move-result-object v1

    sget-object v2, Lcom/openfeint/internal/eventlog/SDKEventListener;->tag:Ljava/lang/String;

    invoke-virtual {v1, v0, v2}, Lcom/openfeint/internal/analytics/AnalyticsManager;->makelog(Lcom/openfeint/internal/analytics/IAnalyticsLogger;Ljava/lang/String;)V

    :cond_1
    :goto_0
    return-void

    :cond_2
    const-string v0, "enabled_of.openfeint.com"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_5

    sget-object v1, Lcom/openfeint/internal/eventlog/SDKEventListener;->tag:Ljava/lang/String;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "ENABLE OLD USER "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    if-nez p2, :cond_4

    const-string v0, ""

    :goto_1
    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v1, v0}, Lcom/openfeint/internal/logcat/OFLog;->d(Ljava/lang/String;Ljava/lang/String;)V

    iget-object v0, p0, Lcom/openfeint/internal/eventlog/SDKEventListener;->name:Ljava/lang/String;

    invoke-virtual {v0, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_3

    const-string v0, ""

    invoke-static {v0}, Lcom/openfeint/internal/OpenFeintInternal;->setUserEnableSource(Ljava/lang/String;)V

    :cond_3
    const-string v0, "enabled_of"

    invoke-static {v0}, Lcom/openfeint/internal/analytics/SDKAnalyticsLogFactory;->getNewClientSDKBaseLog(Ljava/lang/String;)Lcom/openfeint/internal/analytics/IAnalyticsLogger;

    move-result-object v0

    invoke-static {}, Lcom/openfeint/internal/analytics/AnalyticsManager;->instance()Lcom/openfeint/internal/analytics/AnalyticsManager;

    move-result-object v1

    sget-object v2, Lcom/openfeint/internal/eventlog/SDKEventListener;->tag:Ljava/lang/String;

    invoke-virtual {v1, v0, v2}, Lcom/openfeint/internal/analytics/AnalyticsManager;->makelog(Lcom/openfeint/internal/analytics/IAnalyticsLogger;Ljava/lang/String;)V

    goto :goto_0

    :cond_4
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "from "

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_1

    :cond_5
    const-string v0, "prompt_enable_of.openfeint.com"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_8

    sget-object v1, Lcom/openfeint/internal/eventlog/SDKEventListener;->tag:Ljava/lang/String;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "PROMPT_ENABLE_OF "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    if-nez p2, :cond_7

    const-string v0, ""

    :goto_2
    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v1, v0}, Lcom/openfeint/internal/logcat/OFLog;->d(Ljava/lang/String;Ljava/lang/String;)V

    iget-object v0, p0, Lcom/openfeint/internal/eventlog/SDKEventListener;->name:Ljava/lang/String;

    invoke-virtual {v0, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_6

    const-string v0, ""

    invoke-static {v0}, Lcom/openfeint/internal/OpenFeintInternal;->setUserEnableSource(Ljava/lang/String;)V

    :cond_6
    const-string v0, "prompt_enable_of"

    invoke-static {v0}, Lcom/openfeint/internal/analytics/SDKAnalyticsLogFactory;->getNewClientSDKBaseLog(Ljava/lang/String;)Lcom/openfeint/internal/analytics/IAnalyticsLogger;

    move-result-object v0

    invoke-static {}, Lcom/openfeint/internal/analytics/AnalyticsManager;->instance()Lcom/openfeint/internal/analytics/AnalyticsManager;

    move-result-object v1

    sget-object v2, Lcom/openfeint/internal/eventlog/SDKEventListener;->tag:Ljava/lang/String;

    invoke-virtual {v1, v0, v2}, Lcom/openfeint/internal/analytics/AnalyticsManager;->makelog(Lcom/openfeint/internal/analytics/IAnalyticsLogger;Ljava/lang/String;)V

    goto/16 :goto_0

    :cond_7
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "from "

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_2

    :cond_8
    const-string v0, "accepted_of.openfeint.com"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_b

    sget-object v1, Lcom/openfeint/internal/eventlog/SDKEventListener;->tag:Ljava/lang/String;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "ACCEPTED_OF "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    if-nez p2, :cond_a

    const-string v0, ""

    :goto_3
    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v1, v0}, Lcom/openfeint/internal/logcat/OFLog;->d(Ljava/lang/String;Ljava/lang/String;)V

    iget-object v0, p0, Lcom/openfeint/internal/eventlog/SDKEventListener;->name:Ljava/lang/String;

    invoke-virtual {v0, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_9

    const-string v0, ""

    invoke-static {v0}, Lcom/openfeint/internal/OpenFeintInternal;->setUserEnableSource(Ljava/lang/String;)V

    :cond_9
    const-string v0, "accepted_of"

    invoke-static {v0}, Lcom/openfeint/internal/analytics/SDKAnalyticsLogFactory;->getNewClientSDKBaseLog(Ljava/lang/String;)Lcom/openfeint/internal/analytics/IAnalyticsLogger;

    move-result-object v0

    invoke-static {}, Lcom/openfeint/internal/analytics/AnalyticsManager;->instance()Lcom/openfeint/internal/analytics/AnalyticsManager;

    move-result-object v1

    sget-object v2, Lcom/openfeint/internal/eventlog/SDKEventListener;->tag:Ljava/lang/String;

    invoke-virtual {v1, v0, v2}, Lcom/openfeint/internal/analytics/AnalyticsManager;->makelog(Lcom/openfeint/internal/analytics/IAnalyticsLogger;Ljava/lang/String;)V

    goto/16 :goto_0

    :cond_a
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "from "

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_3

    :cond_b
    const-string v0, "declined_of.openfeint.com"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_e

    sget-object v1, Lcom/openfeint/internal/eventlog/SDKEventListener;->tag:Ljava/lang/String;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "DECLINED_OF "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    if-nez p2, :cond_d

    const-string v0, ""

    :goto_4
    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v1, v0}, Lcom/openfeint/internal/logcat/OFLog;->d(Ljava/lang/String;Ljava/lang/String;)V

    iget-object v0, p0, Lcom/openfeint/internal/eventlog/SDKEventListener;->name:Ljava/lang/String;

    invoke-virtual {v0, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_c

    const-string v0, ""

    invoke-static {v0}, Lcom/openfeint/internal/OpenFeintInternal;->setUserEnableSource(Ljava/lang/String;)V

    :cond_c
    const-string v0, "declined_of"

    invoke-static {v0}, Lcom/openfeint/internal/analytics/SDKAnalyticsLogFactory;->getNewClientSDKBaseLog(Ljava/lang/String;)Lcom/openfeint/internal/analytics/IAnalyticsLogger;

    move-result-object v0

    invoke-static {}, Lcom/openfeint/internal/analytics/AnalyticsManager;->instance()Lcom/openfeint/internal/analytics/AnalyticsManager;

    move-result-object v1

    sget-object v2, Lcom/openfeint/internal/eventlog/SDKEventListener;->tag:Ljava/lang/String;

    invoke-virtual {v1, v0, v2}, Lcom/openfeint/internal/analytics/AnalyticsManager;->makelog(Lcom/openfeint/internal/analytics/IAnalyticsLogger;Ljava/lang/String;)V

    goto/16 :goto_0

    :cond_d
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "from "

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_4

    :cond_e
    const-string v0, "game_start.openfeint.com"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_11

    sget-object v1, Lcom/openfeint/internal/eventlog/SDKEventListener;->tag:Ljava/lang/String;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "GAME_START "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    if-nez p2, :cond_10

    const-string v0, ""

    :goto_5
    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v1, v0}, Lcom/openfeint/internal/logcat/OFLog;->d(Ljava/lang/String;Ljava/lang/String;)V

    iget-object v0, p0, Lcom/openfeint/internal/eventlog/SDKEventListener;->name:Ljava/lang/String;

    invoke-virtual {v0, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_f

    const-string v0, ""

    invoke-static {v0}, Lcom/openfeint/internal/OpenFeintInternal;->setUserEnableSource(Ljava/lang/String;)V

    :cond_f
    const-string v0, "game_launch"

    invoke-static {v0}, Lcom/openfeint/internal/analytics/SDKAnalyticsLogFactory;->getNewClientSDKBaseLog(Ljava/lang/String;)Lcom/openfeint/internal/analytics/IAnalyticsLogger;

    move-result-object v0

    invoke-static {}, Lcom/openfeint/internal/analytics/AnalyticsManager;->instance()Lcom/openfeint/internal/analytics/AnalyticsManager;

    move-result-object v1

    sget-object v2, Lcom/openfeint/internal/eventlog/SDKEventListener;->tag:Ljava/lang/String;

    invoke-virtual {v1, v0, v2}, Lcom/openfeint/internal/analytics/AnalyticsManager;->makelog(Lcom/openfeint/internal/analytics/IAnalyticsLogger;Ljava/lang/String;)V

    goto/16 :goto_0

    :cond_10
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "from "

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_5

    :cond_11
    const-string v0, "game_background.openfeint.com"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_14

    sget-object v1, Lcom/openfeint/internal/eventlog/SDKEventListener;->tag:Ljava/lang/String;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "GAME_BACKGROUND "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    if-nez p2, :cond_13

    const-string v0, ""

    :goto_6
    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v1, v0}, Lcom/openfeint/internal/logcat/OFLog;->d(Ljava/lang/String;Ljava/lang/String;)V

    iget-object v0, p0, Lcom/openfeint/internal/eventlog/SDKEventListener;->name:Ljava/lang/String;

    invoke-virtual {v0, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_12

    const-string v0, ""

    invoke-static {v0}, Lcom/openfeint/internal/OpenFeintInternal;->setUserEnableSource(Ljava/lang/String;)V

    :cond_12
    const-string v0, "game_background"

    invoke-static {v0}, Lcom/openfeint/internal/analytics/SDKAnalyticsLogFactory;->getNewClientSDKBaseLog(Ljava/lang/String;)Lcom/openfeint/internal/analytics/IAnalyticsLogger;

    move-result-object v0

    invoke-static {}, Lcom/openfeint/internal/analytics/AnalyticsManager;->instance()Lcom/openfeint/internal/analytics/AnalyticsManager;

    move-result-object v1

    sget-object v2, Lcom/openfeint/internal/eventlog/SDKEventListener;->tag:Ljava/lang/String;

    invoke-virtual {v1, v0, v2}, Lcom/openfeint/internal/analytics/AnalyticsManager;->makelog(Lcom/openfeint/internal/analytics/IAnalyticsLogger;Ljava/lang/String;)V

    goto/16 :goto_0

    :cond_13
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "from "

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_6

    :cond_14
    const-string v0, "game_foreground.openfeint.com"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_17

    sget-object v1, Lcom/openfeint/internal/eventlog/SDKEventListener;->tag:Ljava/lang/String;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "GAME_FOREGROUND "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    if-nez p2, :cond_16

    const-string v0, ""

    :goto_7
    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v1, v0}, Lcom/openfeint/internal/logcat/OFLog;->d(Ljava/lang/String;Ljava/lang/String;)V

    iget-object v0, p0, Lcom/openfeint/internal/eventlog/SDKEventListener;->name:Ljava/lang/String;

    invoke-virtual {v0, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_15

    const-string v0, ""

    invoke-static {v0}, Lcom/openfeint/internal/OpenFeintInternal;->setUserEnableSource(Ljava/lang/String;)V

    :cond_15
    const-string v0, "game_foreground"

    invoke-static {v0}, Lcom/openfeint/internal/analytics/SDKAnalyticsLogFactory;->getNewClientSDKBaseLog(Ljava/lang/String;)Lcom/openfeint/internal/analytics/IAnalyticsLogger;

    move-result-object v0

    invoke-static {}, Lcom/openfeint/internal/analytics/AnalyticsManager;->instance()Lcom/openfeint/internal/analytics/AnalyticsManager;

    move-result-object v1

    sget-object v2, Lcom/openfeint/internal/eventlog/SDKEventListener;->tag:Ljava/lang/String;

    invoke-virtual {v1, v0, v2}, Lcom/openfeint/internal/analytics/AnalyticsManager;->makelog(Lcom/openfeint/internal/analytics/IAnalyticsLogger;Ljava/lang/String;)V

    goto/16 :goto_0

    :cond_16
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "from "

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_7

    :cond_17
    const-string v0, "game_exit.openfeint.com"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    sget-object v1, Lcom/openfeint/internal/eventlog/SDKEventListener;->tag:Ljava/lang/String;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "GAME_EXIT "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    if-nez p2, :cond_19

    const-string v0, ""

    :goto_8
    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v1, v0}, Lcom/openfeint/internal/logcat/OFLog;->d(Ljava/lang/String;Ljava/lang/String;)V

    iget-object v0, p0, Lcom/openfeint/internal/eventlog/SDKEventListener;->name:Ljava/lang/String;

    invoke-virtual {v0, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_18

    const-string v0, ""

    invoke-static {v0}, Lcom/openfeint/internal/OpenFeintInternal;->setUserEnableSource(Ljava/lang/String;)V

    :cond_18
    const-string v0, "game_exit"

    invoke-static {v0}, Lcom/openfeint/internal/analytics/SDKAnalyticsLogFactory;->getNewClientSDKBaseLog(Ljava/lang/String;)Lcom/openfeint/internal/analytics/IAnalyticsLogger;

    move-result-object v0

    invoke-static {}, Lcom/openfeint/internal/analytics/AnalyticsManager;->instance()Lcom/openfeint/internal/analytics/AnalyticsManager;

    move-result-object v1

    sget-object v2, Lcom/openfeint/internal/eventlog/SDKEventListener;->tag:Ljava/lang/String;

    invoke-virtual {v1, v0, v2}, Lcom/openfeint/internal/analytics/AnalyticsManager;->makelog(Lcom/openfeint/internal/analytics/IAnalyticsLogger;Ljava/lang/String;)V

    goto/16 :goto_0

    :cond_19
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "from "

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_8
.end method
