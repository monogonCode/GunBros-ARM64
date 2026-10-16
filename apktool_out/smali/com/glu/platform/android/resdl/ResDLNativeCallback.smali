.class public Lcom/glu/platform/android/resdl/ResDLNativeCallback;
.super Landroid/app/Activity;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Landroid/app/Activity;-><init>()V

    return-void
.end method

.method public static resdlEvent(II[B)I
    .locals 2

    const/4 v0, 0x0

    const/4 v1, 0x2

    if-ne p0, v1, :cond_0

    new-instance v1, Ljava/lang/String;

    invoke-direct {v1, p2}, Ljava/lang/String;-><init>([B)V

    invoke-static {v1}, Lcom/glu/platform/android/resdl/GluUtil;->isResourceFile(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_0

    const/4 v0, 0x1

    :cond_0
    return v0
.end method

.method public static resdlStringEvent(II[B)[B
    .locals 2

    const/4 v0, 0x0

    const/4 v1, 0x1

    if-ne p0, v1, :cond_1

    invoke-static {}, Lcom/glu/platform/android/resdl/ResDL;->getResourceFilePath()Ljava/lang/String;

    move-result-object v1

    :goto_0
    if-nez v1, :cond_0

    :goto_1
    return-object v0

    :cond_0
    invoke-static {v1}, Lcom/glu/platform/android/resdl/GluUtil;->stringToNativeByteArray(Ljava/lang/String;)[B

    move-result-object v0

    goto :goto_1

    :cond_1
    move-object v1, v0

    goto :goto_0
.end method
