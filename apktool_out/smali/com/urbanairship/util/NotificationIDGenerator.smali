.class public Lcom/urbanairship/util/NotificationIDGenerator;
.super Ljava/lang/Object;


# static fields
.field private static final COUNT_KEY:Ljava/lang/String; = "count"

.field private static RANGE:I = 0x0

.field private static final SHARED_PREFERENCES_FILE:Ljava/lang/String; = "com.urbanairship.notificationidgenerator"

.field private static START:I


# direct methods
.method static constructor <clinit>()V
    .locals 1

    const/16 v0, 0x3e8

    sput v0, Lcom/urbanairship/util/NotificationIDGenerator;->START:I

    const/16 v0, 0x64

    sput v0, Lcom/urbanairship/util/NotificationIDGenerator;->RANGE:I

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static getInt(Ljava/lang/String;I)I
    .locals 1

    invoke-static {}, Lcom/urbanairship/util/NotificationIDGenerator;->getPreferences()Landroid/content/SharedPreferences;

    move-result-object v0

    invoke-interface {v0, p0, p1}, Landroid/content/SharedPreferences;->getInt(Ljava/lang/String;I)I

    move-result v0

    return v0
.end method

.method private static getPreferences()Landroid/content/SharedPreferences;
    .locals 3

    invoke-static {}, Lcom/urbanairship/UAirship;->shared()Lcom/urbanairship/UAirship;

    move-result-object v0

    invoke-virtual {v0}, Lcom/urbanairship/UAirship;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    const-string v1, "com.urbanairship.notificationidgenerator"

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v0

    return-object v0
.end method

.method public static getRange()I
    .locals 2

    const-class v1, Lcom/urbanairship/util/NotificationIDGenerator;

    monitor-enter v1

    :try_start_0
    sget v0, Lcom/urbanairship/util/NotificationIDGenerator;->RANGE:I

    monitor-exit v1

    return v0

    :catchall_0
    move-exception v0

    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0
.end method

.method public static getStart()I
    .locals 2

    const-class v1, Lcom/urbanairship/util/NotificationIDGenerator;

    monitor-enter v1

    :try_start_0
    sget v0, Lcom/urbanairship/util/NotificationIDGenerator;->START:I

    monitor-exit v1

    return v0

    :catchall_0
    move-exception v0

    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0
.end method

.method public static nextID()I
    .locals 4

    const-class v1, Lcom/urbanairship/util/NotificationIDGenerator;

    monitor-enter v1

    :try_start_0
    invoke-static {}, Lcom/urbanairship/util/NotificationIDGenerator;->getStart()I

    move-result v0

    invoke-static {}, Lcom/urbanairship/util/NotificationIDGenerator;->getRange()I

    move-result v2

    const-string v3, "count"

    invoke-static {v3, v0}, Lcom/urbanairship/util/NotificationIDGenerator;->getInt(Ljava/lang/String;I)I

    move-result v3

    add-int/2addr v2, v0

    if-ge v3, v2, :cond_0

    const-string v0, "incrementing notification id count"

    invoke-static {v0}, Lcom/urbanairship/Logger;->verbose(Ljava/lang/String;)V

    const-string v0, "count"

    add-int/lit8 v2, v3, 0x1

    invoke-static {v0, v2}, Lcom/urbanairship/util/NotificationIDGenerator;->putInt(Ljava/lang/String;I)V

    :goto_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "notification id: "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/urbanairship/Logger;->verbose(Ljava/lang/String;)V

    monitor-exit v1

    return v3

    :cond_0
    const-string v2, "resetting notification id count"

    invoke-static {v2}, Lcom/urbanairship/Logger;->verbose(Ljava/lang/String;)V

    const-string v2, "count"

    invoke-static {v2, v0}, Lcom/urbanairship/util/NotificationIDGenerator;->putInt(Ljava/lang/String;I)V

    goto :goto_0

    :catchall_0
    move-exception v0

    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0
.end method

.method private static putInt(Ljava/lang/String;I)V
    .locals 1

    invoke-static {}, Lcom/urbanairship/util/NotificationIDGenerator;->getPreferences()Landroid/content/SharedPreferences;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0, p0, p1}, Landroid/content/SharedPreferences$Editor;->putInt(Ljava/lang/String;I)Landroid/content/SharedPreferences$Editor;

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->commit()Z

    return-void
.end method

.method public static setRange(I)V
    .locals 3

    const-class v1, Lcom/urbanairship/util/NotificationIDGenerator;

    monitor-enter v1

    :try_start_0
    const-string v0, "count"

    sget v2, Lcom/urbanairship/util/NotificationIDGenerator;->START:I

    invoke-static {v0, v2}, Lcom/urbanairship/util/NotificationIDGenerator;->putInt(Ljava/lang/String;I)V

    sput p0, Lcom/urbanairship/util/NotificationIDGenerator;->RANGE:I

    monitor-exit v1

    return-void

    :catchall_0
    move-exception v0

    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0
.end method

.method public static setStart(I)V
    .locals 2

    const-class v1, Lcom/urbanairship/util/NotificationIDGenerator;

    monitor-enter v1

    :try_start_0
    const-string v0, "count"

    invoke-static {v0, p0}, Lcom/urbanairship/util/NotificationIDGenerator;->putInt(Ljava/lang/String;I)V

    sput p0, Lcom/urbanairship/util/NotificationIDGenerator;->START:I

    monitor-exit v1

    return-void

    :catchall_0
    move-exception v0

    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0
.end method
