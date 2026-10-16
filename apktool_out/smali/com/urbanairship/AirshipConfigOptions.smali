.class public Lcom/urbanairship/AirshipConfigOptions;
.super Lcom/urbanairship/Options;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/urbanairship/AirshipConfigOptions$TransportType;
    }
.end annotation


# instance fields
.field public analyticsEnabled:Z

.field public analyticsServer:Ljava/lang/String;

.field public c2dmSender:Ljava/lang/String;

.field public developmentAppKey:Ljava/lang/String;

.field public developmentAppSecret:Ljava/lang/String;

.field public hostURL:Ljava/lang/String;

.field public iapEnabled:Z

.field public inProduction:Z

.field public productionAppKey:Ljava/lang/String;

.field public productionAppSecret:Ljava/lang/String;

.field public pushServiceEnabled:Z

.field public transport:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 2

    const/4 v1, 0x1

    invoke-direct {p0}, Lcom/urbanairship/Options;-><init>()V

    const-string v0, "https://go.urbanairship.com/"

    iput-object v0, p0, Lcom/urbanairship/AirshipConfigOptions;->hostURL:Ljava/lang/String;

    const-string v0, "https://combine.urbanairship.com/"

    iput-object v0, p0, Lcom/urbanairship/AirshipConfigOptions;->analyticsServer:Ljava/lang/String;

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/urbanairship/AirshipConfigOptions;->inProduction:Z

    iput-boolean v1, p0, Lcom/urbanairship/AirshipConfigOptions;->pushServiceEnabled:Z

    iput-boolean v1, p0, Lcom/urbanairship/AirshipConfigOptions;->iapEnabled:Z

    iput-boolean v1, p0, Lcom/urbanairship/AirshipConfigOptions;->analyticsEnabled:Z

    return-void
.end method

.method public static loadDefaultOptions(Landroid/content/Context;)Lcom/urbanairship/AirshipConfigOptions;
    .locals 1

    new-instance v0, Lcom/urbanairship/AirshipConfigOptions;

    invoke-direct {v0}, Lcom/urbanairship/AirshipConfigOptions;-><init>()V

    invoke-virtual {v0, p0}, Lcom/urbanairship/AirshipConfigOptions;->loadFromProperties(Landroid/content/Context;)V

    return-object v0
.end method


# virtual methods
.method public getAppKey()Ljava/lang/String;
    .locals 1

    iget-boolean v0, p0, Lcom/urbanairship/AirshipConfigOptions;->inProduction:Z

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/urbanairship/AirshipConfigOptions;->productionAppKey:Ljava/lang/String;

    :goto_0
    return-object v0

    :cond_0
    iget-object v0, p0, Lcom/urbanairship/AirshipConfigOptions;->developmentAppKey:Ljava/lang/String;

    goto :goto_0
.end method

.method public getAppSecret()Ljava/lang/String;
    .locals 1

    iget-boolean v0, p0, Lcom/urbanairship/AirshipConfigOptions;->inProduction:Z

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/urbanairship/AirshipConfigOptions;->productionAppSecret:Ljava/lang/String;

    :goto_0
    return-object v0

    :cond_0
    iget-object v0, p0, Lcom/urbanairship/AirshipConfigOptions;->developmentAppSecret:Ljava/lang/String;

    goto :goto_0
.end method

.method public getDefaultPropertiesFilename()Ljava/lang/String;
    .locals 1

    const-string v0, "airshipconfig.properties"

    return-object v0
.end method

.method public getTransport()Lcom/urbanairship/AirshipConfigOptions$TransportType;
    .locals 2

    sget-object v0, Lcom/urbanairship/AirshipConfigOptions$TransportType;->C2DM:Lcom/urbanairship/AirshipConfigOptions$TransportType;

    invoke-virtual {v0}, Lcom/urbanairship/AirshipConfigOptions$TransportType;->toString()Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Lcom/urbanairship/AirshipConfigOptions;->transport:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    sget-object v0, Lcom/urbanairship/AirshipConfigOptions$TransportType;->C2DM:Lcom/urbanairship/AirshipConfigOptions$TransportType;

    :goto_0
    return-object v0

    :cond_0
    sget-object v0, Lcom/urbanairship/AirshipConfigOptions$TransportType;->HELIUM:Lcom/urbanairship/AirshipConfigOptions$TransportType;

    invoke-virtual {v0}, Lcom/urbanairship/AirshipConfigOptions$TransportType;->toString()Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Lcom/urbanairship/AirshipConfigOptions;->transport:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    sget-object v0, Lcom/urbanairship/AirshipConfigOptions$TransportType;->HELIUM:Lcom/urbanairship/AirshipConfigOptions$TransportType;

    goto :goto_0

    :cond_1
    sget-object v0, Lcom/urbanairship/AirshipConfigOptions$TransportType;->HYBRID:Lcom/urbanairship/AirshipConfigOptions$TransportType;

    invoke-virtual {v0}, Lcom/urbanairship/AirshipConfigOptions$TransportType;->toString()Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Lcom/urbanairship/AirshipConfigOptions;->transport:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_2

    sget-object v0, Lcom/urbanairship/AirshipConfigOptions$TransportType;->HYBRID:Lcom/urbanairship/AirshipConfigOptions$TransportType;

    goto :goto_0

    :cond_2
    iget-object v0, p0, Lcom/urbanairship/AirshipConfigOptions;->c2dmSender:Ljava/lang/String;

    if-eqz v0, :cond_3

    iget-object v0, p0, Lcom/urbanairship/AirshipConfigOptions;->c2dmSender:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v0

    if-lez v0, :cond_3

    sget-object v0, Lcom/urbanairship/AirshipConfigOptions$TransportType;->C2DM:Lcom/urbanairship/AirshipConfigOptions$TransportType;

    goto :goto_0

    :cond_3
    sget-object v0, Lcom/urbanairship/AirshipConfigOptions$TransportType;->HELIUM:Lcom/urbanairship/AirshipConfigOptions$TransportType;

    goto :goto_0
.end method

.method public isValid()Z
    .locals 5

    const/16 v4, 0x20

    const/4 v2, 0x0

    const/4 v1, 0x1

    iget-boolean v0, p0, Lcom/urbanairship/AirshipConfigOptions;->inProduction:Z

    if-eqz v0, :cond_5

    const-string v0, "production"

    :goto_0
    invoke-virtual {p0}, Lcom/urbanairship/AirshipConfigOptions;->getAppKey()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_0

    invoke-virtual {p0}, Lcom/urbanairship/AirshipConfigOptions;->getAppKey()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->length()I

    move-result v3

    if-eqz v3, :cond_0

    invoke-virtual {p0}, Lcom/urbanairship/AirshipConfigOptions;->getAppKey()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3, v4}, Ljava/lang/String;->indexOf(I)I

    move-result v3

    if-lez v3, :cond_1

    :cond_0
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "AirshipConfigOptions does not contain a valid "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v3, " app key"

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/urbanairship/Logger;->error(Ljava/lang/String;)V

    move v1, v2

    :cond_1
    invoke-virtual {p0}, Lcom/urbanairship/AirshipConfigOptions;->getAppSecret()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_2

    invoke-virtual {p0}, Lcom/urbanairship/AirshipConfigOptions;->getAppSecret()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->length()I

    move-result v3

    if-eqz v3, :cond_2

    invoke-virtual {p0}, Lcom/urbanairship/AirshipConfigOptions;->getAppSecret()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3, v4}, Ljava/lang/String;->indexOf(I)I

    move-result v3

    if-lez v3, :cond_3

    :cond_2
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "AirshipConfigOptions does not contain a valid "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " app secret"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/urbanairship/Logger;->error(Ljava/lang/String;)V

    move v1, v2

    :cond_3
    if-nez v1, :cond_4

    :try_start_0
    const-class v0, Lcom/urbanairship/AirshipConfigOptions;

    const-string v2, "productionAppKey"

    invoke-virtual {v0, v2}, Ljava/lang/Class;->getField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v0

    if-eqz v0, :cond_4

    const-string v0, "Invalid config, but AirshipConfigOptions does not appear to be obfuscated."

    invoke-static {v0}, Lcom/urbanairship/Logger;->verbose(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/SecurityException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/NoSuchFieldException; {:try_start_0 .. :try_end_0} :catch_0

    :cond_4
    :goto_1
    return v1

    :cond_5
    const-string v0, "development"

    goto/16 :goto_0

    :catch_0
    move-exception v0

    const-string v0, "AirshipConfigOptions appears to be obfuscated. If using Proguard, add the following to your proguard.cfg:"

    invoke-static {v0}, Lcom/urbanairship/Logger;->error(Ljava/lang/String;)V

    const-string v0, "\t-keepclasseswithmembernames public class * extends com.urbanairship.Options {"

    invoke-static {v0}, Lcom/urbanairship/Logger;->error(Ljava/lang/String;)V

    const-string v0, "\t\tpublic *;"

    invoke-static {v0}, Lcom/urbanairship/Logger;->error(Ljava/lang/String;)V

    const-string v0, "\t}"

    invoke-static {v0}, Lcom/urbanairship/Logger;->error(Ljava/lang/String;)V

    goto :goto_1

    :catch_1
    move-exception v0

    goto :goto_1
.end method
