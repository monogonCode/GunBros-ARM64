.class public abstract Lcom/glu/platform/android/GluApplication;
.super Landroid/app/Application;


# static fields
.field public static instance:Lcom/glu/platform/android/GluApplication;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    const/4 v0, 0x0

    sput-object v0, Lcom/glu/platform/android/GluApplication;->instance:Lcom/glu/platform/android/GluApplication;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Landroid/app/Application;-><init>()V

    return-void
.end method


# virtual methods
.method protected abstract getMainActivityClass()Ljava/lang/Class;
.end method

.method protected abstract getUADevelopmentAppKey()Ljava/lang/String;
.end method

.method protected abstract getUADevelopmentAppSecret()Ljava/lang/String;
.end method

.method protected abstract getUAProductionAppKey()Ljava/lang/String;
.end method

.method protected abstract getUAProductionAppSecret()Ljava/lang/String;
.end method

.method public onCreate()V
    .locals 3

    const/4 v2, 0x0

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "UrbanAirship instance: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-static {}, Lcom/urbanairship/UAirship;->shared()Lcom/urbanairship/UAirship;

    move-result-object v0

    if-eqz v0, :cond_2

    const-string v0, "Live"

    :goto_0
    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    invoke-static {}, Lcom/urbanairship/UAirship;->shared()Lcom/urbanairship/UAirship;

    move-result-object v0

    if-eqz v0, :cond_0

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "UrbanAirship before takeoff isFlying: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-static {}, Lcom/urbanairship/UAirship;->shared()Lcom/urbanairship/UAirship;

    move-result-object v0

    invoke-virtual {v0}, Lcom/urbanairship/UAirship;->isFlying()Z

    move-result v0

    if-eqz v0, :cond_3

    const-string v0, "Airbourne"

    :goto_1
    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    :cond_0
    invoke-static {p0}, Lcom/urbanairship/AirshipConfigOptions;->loadDefaultOptions(Landroid/content/Context;)Lcom/urbanairship/AirshipConfigOptions;

    move-result-object v0

    invoke-virtual {p0}, Lcom/glu/platform/android/GluApplication;->getUADevelopmentAppKey()Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/urbanairship/AirshipConfigOptions;->developmentAppKey:Ljava/lang/String;

    invoke-virtual {p0}, Lcom/glu/platform/android/GluApplication;->getUADevelopmentAppSecret()Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/urbanairship/AirshipConfigOptions;->developmentAppSecret:Ljava/lang/String;

    invoke-virtual {p0}, Lcom/glu/platform/android/GluApplication;->getUAProductionAppKey()Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/urbanairship/AirshipConfigOptions;->productionAppKey:Ljava/lang/String;

    invoke-virtual {p0}, Lcom/glu/platform/android/GluApplication;->getUAProductionAppSecret()Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/urbanairship/AirshipConfigOptions;->productionAppSecret:Ljava/lang/String;

    const/4 v1, 0x1

    iput-boolean v1, v0, Lcom/urbanairship/AirshipConfigOptions;->inProduction:Z

    iput-boolean v2, v0, Lcom/urbanairship/AirshipConfigOptions;->analyticsEnabled:Z

    iput-boolean v2, v0, Lcom/urbanairship/AirshipConfigOptions;->iapEnabled:Z

    const-string v1, "glunotification@gmail.com"

    iput-object v1, v0, Lcom/urbanairship/AirshipConfigOptions;->c2dmSender:Ljava/lang/String;

    const-string v1, "helium"

    iput-object v1, v0, Lcom/urbanairship/AirshipConfigOptions;->transport:Ljava/lang/String;

    invoke-static {p0, v0}, Lcom/urbanairship/UAirship;->takeOff(Landroid/app/Application;Lcom/urbanairship/AirshipConfigOptions;)V

    const/4 v0, 0x6

    sput v0, Lcom/urbanairship/Logger;->logLevel:I

    invoke-static {}, Lcom/urbanairship/push/PushManager;->shared()Lcom/urbanairship/push/PushManager;

    move-result-object v0

    const-class v1, Lcom/glu/platform/android/GluPushHandler;

    invoke-virtual {v0, v1}, Lcom/urbanairship/push/PushManager;->setIntentReceiver(Ljava/lang/Class;)V

    invoke-static {}, Lcom/urbanairship/UAirship;->shared()Lcom/urbanairship/UAirship;

    move-result-object v0

    if-eqz v0, :cond_1

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "UrbanAirship after takeoff isFlying: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-static {}, Lcom/urbanairship/UAirship;->shared()Lcom/urbanairship/UAirship;

    move-result-object v0

    invoke-virtual {v0}, Lcom/urbanairship/UAirship;->isFlying()Z

    move-result v0

    if-eqz v0, :cond_4

    const-string v0, "Airbourne"

    :goto_2
    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    :cond_1
    invoke-static {}, Lcom/urbanairship/push/PushManager;->shared()Lcom/urbanairship/push/PushManager;

    move-result-object v0

    invoke-virtual {v0}, Lcom/urbanairship/push/PushManager;->getPreferences()Lcom/urbanairship/push/PushPreferences;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "App APID: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v0}, Lcom/urbanairship/push/PushPreferences;->getPushId()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "isPushEnabled: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v0}, Lcom/urbanairship/push/PushPreferences;->isPushEnabled()Z

    move-result v0

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    sput-object p0, Lcom/glu/platform/android/GluApplication;->instance:Lcom/glu/platform/android/GluApplication;

    return-void

    :cond_2
    const-string v0, "Dead"

    goto/16 :goto_0

    :cond_3
    const-string v0, "Grounded"

    goto/16 :goto_1

    :cond_4
    const-string v0, "Grounded"

    goto :goto_2
.end method

.method public onTerminate()V
    .locals 0

    invoke-static {}, Lcom/urbanairship/UAirship;->land()V

    return-void
.end method
