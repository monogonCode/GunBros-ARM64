.class public final Lcom/glu/platform/android/facebook/GluUtil;
.super Ljava/lang/Object;


# static fields
.field public static final CF_BUTTON_DARK:Landroid/graphics/LightingColorFilter;

.field public static final CF_BUTTON_DEFAULT:Landroid/graphics/LightingColorFilter;

.field public static final CF_BUTTON_SELECTED:Landroid/graphics/LightingColorFilter;

.field public static final DIALOG_CALLBACK_PARAMS:[Ljava/lang/Class;

.field public static final PARAMS_BOOLEAN:[Ljava/lang/Class;

.field public static final PARAMS_INT:[Ljava/lang/Class;

.field public static m_gradientPaint:Landroid/graphics/Paint;

.field public static randomizer:Ljava/util/Random;

.field public static sm_canPlayVideo:Z

.field private static sm_canVideoViewBeLargerThanScreen:Z

.field private static sm_canVideoViewHaveNegativeCoordinates:Z

.field private static sm_canVideoViewSizeBeSlightlyInaccurate:Z

.field public static sm_notID:I

.field private static sm_shouldHideGameView:Z

.field private static sm_shouldShrinkGameView:Z

.field private static sm_shouldUseDMAActivity:Z


# direct methods
.method static constructor <clinit>()V
    .locals 6

    const/4 v5, 0x0

    const v4, 0xffffff

    const/4 v3, 0x1

    const/4 v2, 0x0

    sput-object v5, Lcom/glu/platform/android/facebook/GluUtil;->m_gradientPaint:Landroid/graphics/Paint;

    new-instance v0, Landroid/graphics/LightingColorFilter;

    const v1, 0xd38100

    invoke-direct {v0, v4, v1}, Landroid/graphics/LightingColorFilter;-><init>(II)V

    sput-object v0, Lcom/glu/platform/android/facebook/GluUtil;->CF_BUTTON_SELECTED:Landroid/graphics/LightingColorFilter;

    new-instance v0, Landroid/graphics/LightingColorFilter;

    const v1, 0xa0a0a0

    invoke-direct {v0, v4, v1}, Landroid/graphics/LightingColorFilter;-><init>(II)V

    sput-object v0, Lcom/glu/platform/android/facebook/GluUtil;->CF_BUTTON_DEFAULT:Landroid/graphics/LightingColorFilter;

    new-instance v0, Landroid/graphics/LightingColorFilter;

    const v1, 0x464646

    invoke-direct {v0, v4, v1}, Landroid/graphics/LightingColorFilter;-><init>(II)V

    sput-object v0, Lcom/glu/platform/android/facebook/GluUtil;->CF_BUTTON_DARK:Landroid/graphics/LightingColorFilter;

    sput-object v5, Lcom/glu/platform/android/facebook/GluUtil;->randomizer:Ljava/util/Random;

    const/16 v0, 0x64

    sput v0, Lcom/glu/platform/android/facebook/GluUtil;->sm_notID:I

    new-array v0, v3, [Ljava/lang/Class;

    sget-object v1, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    aput-object v1, v0, v2

    sput-object v0, Lcom/glu/platform/android/facebook/GluUtil;->DIALOG_CALLBACK_PARAMS:[Ljava/lang/Class;

    new-array v0, v3, [Ljava/lang/Class;

    sget-object v1, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    aput-object v1, v0, v2

    sput-object v0, Lcom/glu/platform/android/facebook/GluUtil;->PARAMS_INT:[Ljava/lang/Class;

    new-array v0, v3, [Ljava/lang/Class;

    sget-object v1, Ljava/lang/Boolean;->TYPE:Ljava/lang/Class;

    aput-object v1, v0, v2

    sput-object v0, Lcom/glu/platform/android/facebook/GluUtil;->PARAMS_BOOLEAN:[Ljava/lang/Class;

    sput-boolean v2, Lcom/glu/platform/android/facebook/GluUtil;->sm_shouldUseDMAActivity:Z

    sput-boolean v2, Lcom/glu/platform/android/facebook/GluUtil;->sm_shouldHideGameView:Z

    sput-boolean v2, Lcom/glu/platform/android/facebook/GluUtil;->sm_shouldShrinkGameView:Z

    sput-boolean v2, Lcom/glu/platform/android/facebook/GluUtil;->sm_canVideoViewHaveNegativeCoordinates:Z

    sput-boolean v2, Lcom/glu/platform/android/facebook/GluUtil;->sm_canVideoViewBeLargerThanScreen:Z

    sput-boolean v2, Lcom/glu/platform/android/facebook/GluUtil;->sm_canVideoViewSizeBeSlightlyInaccurate:Z

    sput-boolean v2, Lcom/glu/platform/android/facebook/GluUtil;->sm_canPlayVideo:Z

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static copyFile(Ljava/io/File;Ljava/io/File;)Z
    .locals 1

    invoke-static {p0, p1}, Lcom/glu/platform/android/facebook/GluUtil;->copyFile$c0646c4(Ljava/io/File;Ljava/io/File;)Z

    move-result v0

    return v0
.end method

.method private static copyFile$c0646c4(Ljava/io/File;Ljava/io/File;)Z
    .locals 7

    const/16 v6, 0x2f

    const/4 v1, 0x0

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Copying "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {p0}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v2, " to "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {p1}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    invoke-static {}, Lcom/glu/platform/android/facebook/Debug;->log$552c4e01()V

    :try_start_0
    new-instance v0, Ljava/io/FileInputStream;

    invoke-direct {v0, p0}, Ljava/io/FileInputStream;-><init>(Ljava/io/File;)V

    new-instance v2, Ljava/io/FileOutputStream;

    const/4 v3, 0x0

    invoke-direct {v2, p1, v3}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;Z)V

    const v3, 0x8000

    new-array v3, v3, [B

    :goto_0
    invoke-virtual {v0, v3}, Ljava/io/FileInputStream;->read([B)I

    move-result v4

    if-lez v4, :cond_0

    const/4 v5, 0x0

    invoke-virtual {v2, v3, v5, v4}, Ljava/io/FileOutputStream;->write([BII)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    move-object v2, v0

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Warning: Cannot copy "

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {p0}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/glu/platform/android/facebook/GluUtil;->filePathNoEnder(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0, v6}, Ljava/lang/String;->lastIndexOf(I)I

    move-result v4

    const/4 v5, -0x1

    if-ne v4, v5, :cond_2

    :goto_1
    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v3, ": "

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    invoke-static {}, Lcom/glu/platform/android/facebook/Debug;->log$2d473e19()V

    move v0, v1

    :goto_2
    return v0

    :cond_0
    :try_start_1
    invoke-virtual {v0}, Ljava/io/FileInputStream;->close()V

    invoke-virtual {v2}, Ljava/io/FileOutputStream;->close()V

    invoke-virtual {p1}, Ljava/io/File;->exists()Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-virtual {p0}, Ljava/io/File;->length()J

    move-result-wide v2

    invoke-virtual {p1}, Ljava/io/File;->length()J
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    move-result-wide v4

    cmp-long v0, v2, v4

    if-nez v0, :cond_1

    const/4 v0, 0x1

    goto :goto_2

    :cond_1
    move v0, v1

    goto :goto_2

    :cond_2
    invoke-virtual {v0, v6}, Ljava/lang/String;->lastIndexOf(I)I

    move-result v4

    add-int/lit8 v4, v4, 0x1

    invoke-virtual {v0, v4}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v0

    goto :goto_1
.end method

.method public static final filePathNoEnder(Ljava/lang/String;)Ljava/lang/String;
    .locals 2

    if-eqz p0, :cond_0

    const-string v0, ""

    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_2

    :cond_0
    const-string v0, "."

    :cond_1
    :goto_0
    return-object v0

    :cond_2
    const-string v0, "/"

    invoke-virtual {p0, v0}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_4

    const/4 v0, 0x0

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v1

    add-int/lit8 v1, v1, -0x1

    invoke-virtual {p0, v0, v1}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v0

    :goto_1
    if-eqz v0, :cond_3

    const-string v1, ""

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_1

    :cond_3
    const-string v0, "."

    goto :goto_0

    :cond_4
    move-object v0, p0

    goto :goto_1
.end method

.method public static final filePathWithEnder(Ljava/lang/String;)Ljava/lang/String;
    .locals 2

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-static {p0}, Lcom/glu/platform/android/facebook/GluUtil;->filePathNoEnder(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "/"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static getByteArrayContentsFromURL$44c4d6c8(Ljava/lang/String;)[B
    .locals 3

    :try_start_0
    new-instance v0, Ljava/net/URL;

    invoke-direct {v0, p0}, Ljava/net/URL;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0}, Ljava/net/URL;->openConnection()Ljava/net/URLConnection;

    move-result-object v0

    check-cast v0, Ljava/net/HttpURLConnection;

    const-wide/16 v1, 0x0

    invoke-virtual {v0, v1, v2}, Ljava/net/HttpURLConnection;->setIfModifiedSince(J)V

    const v1, 0xea60

    invoke-virtual {v0, v1}, Ljava/net/HttpURLConnection;->setReadTimeout(I)V

    invoke-static {v0}, Lcom/glu/platform/android/facebook/GluUtil;->getByteArrayContentsFromURLConnection$f1df1a7(Ljava/net/HttpURLConnection;)[B
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    :goto_0
    return-object v0

    :catch_0
    move-exception v0

    const/4 v0, 0x0

    goto :goto_0
.end method

.method private static getByteArrayContentsFromURLConnection$2c39be92(Ljava/net/HttpURLConnection;I)[B
    .locals 9

    const/4 v0, 0x0

    const/16 v1, 0xc8

    if-ne p1, v1, :cond_3

    :try_start_0
    invoke-static {p0}, Lcom/glu/platform/android/facebook/GluUtil;->getContentLength$7c5bcde9(Ljava/net/HttpURLConnection;)I

    move-result v1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "contentLength="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    invoke-static {}, Lcom/glu/platform/android/facebook/Debug;->log$552c4e01()V

    invoke-virtual {p0}, Ljava/net/HttpURLConnection;->getInputStream()Ljava/io/InputStream;

    move-result-object v3

    if-lez v1, :cond_0

    new-array v1, v1, [B

    invoke-virtual {v3, v1}, Ljava/io/InputStream;->read([B)I
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-object v0, v1

    :goto_0
    :try_start_1
    invoke-virtual {v3}, Ljava/io/InputStream;->close()V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1

    :goto_1
    return-object v0

    :cond_0
    :try_start_2
    invoke-static {}, Lcom/glu/platform/android/facebook/Debug;->log$552c4e01()V

    const/16 v1, 0x2000

    new-array v4, v1, [B

    move-object v1, v0

    :cond_1
    :goto_2
    invoke-virtual {v3, v4}, Ljava/io/InputStream;->read([B)I

    move-result v5

    const/4 v2, -0x1

    if-eq v5, v2, :cond_4

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "readCount="

    invoke-virtual {v2, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    invoke-static {}, Lcom/glu/platform/android/facebook/Debug;->log$552c4e01()V

    if-lez v5, :cond_1

    if-nez v1, :cond_2

    new-array v1, v5, [B

    const/4 v2, 0x0

    const/4 v6, 0x0

    invoke-static {v4, v2, v1, v6, v5}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    goto :goto_2

    :catch_0
    move-exception v1

    goto :goto_1

    :cond_2
    array-length v2, v1

    add-int/2addr v2, v5

    new-array v2, v2, [B

    const/4 v6, 0x0

    const/4 v7, 0x0

    array-length v8, v1

    invoke-static {v1, v6, v2, v7, v8}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    const/4 v6, 0x0

    array-length v1, v1

    invoke-static {v4, v6, v2, v1, v5}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    move-object v1, v2

    goto :goto_2

    :cond_3
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Bad response code: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    invoke-static {}, Lcom/glu/platform/android/facebook/Debug;->log$552c4e01()V
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_0

    goto :goto_1

    :catch_1
    move-exception v1

    goto :goto_1

    :cond_4
    move-object v0, v1

    goto :goto_0
.end method

.method private static getByteArrayContentsFromURLConnection$f1df1a7(Ljava/net/HttpURLConnection;)[B
    .locals 1

    :try_start_0
    invoke-virtual {p0}, Ljava/net/HttpURLConnection;->getResponseCode()I

    move-result v0

    invoke-static {p0, v0}, Lcom/glu/platform/android/facebook/GluUtil;->getByteArrayContentsFromURLConnection$2c39be92(Ljava/net/HttpURLConnection;I)[B
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    :goto_0
    return-object v0

    :catch_0
    move-exception v0

    const/4 v0, 0x0

    goto :goto_0
.end method

.method private static getContentLength$7c5bcde9(Ljava/net/HttpURLConnection;)I
    .locals 3

    const/4 v1, 0x0

    :try_start_0
    invoke-virtual {p0}, Ljava/net/HttpURLConnection;->getHeaderFields()Ljava/util/Map;

    move-result-object v0

    const-string v2, "content-length"

    invoke-interface {v0, v2}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/List;

    if-eqz v0, :cond_0

    invoke-interface {v0}, Ljava/util/List;->size()I
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_1

    move-result v2

    if-lez v2, :cond_0

    const/4 v2, 0x0

    :try_start_1
    invoke-interface {v0, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    invoke-static {v0}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    move-result v0

    :goto_0
    return v0

    :catch_0
    move-exception v0

    :try_start_2
    invoke-static {}, Lcom/glu/platform/android/facebook/Debug;->log$2d473e19()V
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_1

    :cond_0
    move v0, v1

    goto :goto_0

    :catch_1
    move-exception v0

    move v0, v1

    goto :goto_0
.end method

.method public static getFacebookSaveDirectory()Ljava/lang/String;
    .locals 3

    sget-object v0, Lcom/glu/platform/android/GluApplication;->instance:Lcom/glu/platform/android/GluApplication;

    const-string v1, "fb"

    sget-object v2, Lcom/glu/platform/android/GluApplication;->instance:Lcom/glu/platform/android/GluApplication;

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/content/Context;->getDir(Ljava/lang/String;I)Ljava/io/File;

    move-result-object v0

    invoke-virtual {v0}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/glu/platform/android/facebook/GluUtil;->filePathWithEnder(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static getFourByteHexNice$79bb807([B)Ljava/lang/String;
    .locals 4

    const/4 v3, 0x3

    if-eqz p0, :cond_0

    array-length v0, p0

    if-gt v0, v3, :cond_1

    :cond_0
    const-string v0, "invalid"

    :goto_0
    return-object v0

    :cond_1
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "0x"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const/4 v1, 0x0

    aget-byte v1, p0, v1

    shl-int/lit8 v1, v1, 0x18

    const/4 v2, 0x1

    aget-byte v2, p0, v2

    shl-int/lit8 v2, v2, 0x10

    or-int/2addr v1, v2

    const/4 v2, 0x2

    aget-byte v2, p0, v2

    shl-int/lit8 v2, v2, 0x8

    or-int/2addr v1, v2

    aget-byte v2, p0, v3

    or-int/2addr v1, v2

    invoke-static {v1}, Ljava/lang/Integer;->toHexString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_0
.end method

.method public static getMIMEType([B)I
    .locals 7

    const/4 v6, 0x3

    const/4 v5, 0x2

    const/4 v0, -0x1

    const/4 v4, 0x1

    const/4 v3, 0x0

    aget-byte v1, p0, v3

    if-ne v1, v0, :cond_1

    aget-byte v1, p0, v4

    const/16 v2, -0x28

    if-ne v1, v2, :cond_1

    const v0, 0xffd8

    :cond_0
    :goto_0
    return v0

    :cond_1
    aget-byte v1, p0, v3

    const/16 v2, -0x77

    if-ne v1, v2, :cond_2

    aget-byte v1, p0, v4

    const/16 v2, 0x50

    if-ne v1, v2, :cond_2

    aget-byte v1, p0, v5

    const/16 v2, 0x4e

    if-ne v1, v2, :cond_2

    aget-byte v1, p0, v6

    const/16 v2, 0x47

    if-ne v1, v2, :cond_2

    const v0, -0x76afb1b9

    goto :goto_0

    :cond_2
    aget-byte v1, p0, v3

    const/16 v2, 0x47

    if-ne v1, v2, :cond_3

    aget-byte v1, p0, v4

    const/16 v2, 0x49

    if-ne v1, v2, :cond_3

    aget-byte v1, p0, v5

    const/16 v2, 0x46

    if-ne v1, v2, :cond_3

    aget-byte v1, p0, v6

    const/16 v2, 0x38

    if-ne v1, v2, :cond_3

    const v0, 0x47494638

    goto :goto_0

    :cond_3
    aget-byte v1, p0, v3

    const/16 v2, 0x42

    if-ne v1, v2, :cond_0

    aget-byte v1, p0, v4

    const/16 v2, 0x4d

    if-ne v1, v2, :cond_0

    const/16 v0, 0x424d

    goto :goto_0
.end method

.method public static getSecureSaveDirectory()Ljava/lang/String;
    .locals 3

    sget-object v0, Lcom/glu/platform/android/GluApplication;->instance:Lcom/glu/platform/android/GluApplication;

    const-string v1, "etc"

    sget-object v2, Lcom/glu/platform/android/GluApplication;->instance:Lcom/glu/platform/android/GluApplication;

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/content/Context;->getDir(Ljava/lang/String;I)Ljava/io/File;

    move-result-object v0

    invoke-virtual {v0}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/glu/platform/android/facebook/GluUtil;->filePathWithEnder(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static final mimeTypeToExtension(I)Ljava/lang/String;
    .locals 1

    const v0, 0xffd8

    if-ne p0, v0, :cond_0

    const-string v0, ".jpg"

    :goto_0
    return-object v0

    :cond_0
    const v0, -0x76afb1b9

    if-ne p0, v0, :cond_1

    const-string v0, ".png"

    goto :goto_0

    :cond_1
    const v0, 0x47494638

    if-ne p0, v0, :cond_2

    const-string v0, ".gif"

    goto :goto_0

    :cond_2
    const/16 v0, 0x424d

    if-ne p0, v0, :cond_3

    const-string v0, ".bmp"

    goto :goto_0

    :cond_3
    const-string v0, ""

    goto :goto_0
.end method

.method public static rmrf(Ljava/io/File;)V
    .locals 5

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "rmrf("

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {p0}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ")"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    invoke-static {}, Lcom/glu/platform/android/facebook/Debug;->log$552c4e01()V

    invoke-virtual {p0}, Ljava/io/File;->isDirectory()Z

    move-result v0

    if-nez v0, :cond_1

    :cond_0
    :goto_0
    return-void

    :cond_1
    invoke-virtual {p0}, Ljava/io/File;->listFiles()[Ljava/io/File;

    move-result-object v2

    if-nez v2, :cond_2

    invoke-static {}, Lcom/glu/platform/android/facebook/Debug;->log$552c4e01()V

    goto :goto_0

    :cond_2
    const/4 v0, 0x0

    :goto_1
    array-length v1, v2

    if-ge v0, v1, :cond_0

    aget-object v1, v2, v0

    invoke-virtual {v1}, Ljava/io/File;->isDirectory()Z

    move-result v1

    if-eqz v1, :cond_3

    aget-object v3, v2, v0

    invoke-static {v3}, Lcom/glu/platform/android/facebook/GluUtil;->rmrf(Ljava/io/File;)V

    :cond_3
    aget-object v3, v2, v0

    invoke-virtual {v3}, Ljava/io/File;->delete()Z

    move-result v3

    if-eqz v3, :cond_5

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Deleted "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    if-eqz v1, :cond_4

    const-string v1, "directory"

    :goto_2
    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v3, " successfully: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    aget-object v3, v2, v0

    invoke-virtual {v3}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    invoke-static {}, Lcom/glu/platform/android/facebook/Debug;->log$552c4e01()V

    :goto_3
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    :cond_4
    const-string v1, "file"

    goto :goto_2

    :cond_5
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "!!!CANNOT DELETE "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    if-eqz v1, :cond_6

    const-string v1, "DIRECTORY"

    :goto_4
    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v3, "!!!: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    aget-object v3, v2, v0

    invoke-virtual {v3}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    invoke-static {}, Lcom/glu/platform/android/facebook/Debug;->log$552c4e01()V

    goto :goto_3

    :cond_6
    const-string v1, "FILE"

    goto :goto_4
.end method

.method public static sleep$1349ef()V
    .locals 4

    const-wide/16 v2, 0x1388

    const-wide/16 v0, 0x1388

    :try_start_0
    invoke-static {v0, v1}, Ljava/lang/Thread;->sleep(J)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return-void

    :catch_0
    move-exception v0

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Sleep for "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v2, v3}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "ms interrupted...somehow."

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    invoke-static {}, Lcom/glu/platform/android/facebook/Debug;->log$2d473e19()V

    goto :goto_0
.end method

.method public static final stringToNativeByteArray(Ljava/lang/String;)[B
    .locals 5

    const/4 v1, 0x0

    invoke-virtual {p0}, Ljava/lang/String;->toCharArray()[C

    move-result-object v2

    array-length v0, v2

    add-int/lit8 v0, v0, 0x1

    new-array v3, v0, [B

    move v0, v1

    :goto_0
    array-length v4, v2

    if-ge v0, v4, :cond_0

    aget-char v4, v2, v0

    int-to-byte v4, v4

    aput-byte v4, v3, v0

    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_0
    array-length v0, v2

    aput-byte v1, v3, v0

    return-object v3
.end method

.method public static final stringToNativeCharArray(Ljava/lang/String;)[C
    .locals 5

    const/4 v1, 0x0

    invoke-virtual {p0}, Ljava/lang/String;->toCharArray()[C

    move-result-object v2

    array-length v0, v2

    add-int/lit8 v0, v0, 0x1

    new-array v3, v0, [C

    move v0, v1

    :goto_0
    array-length v4, v2

    if-ge v0, v4, :cond_0

    aget-char v4, v2, v0

    aput-char v4, v3, v0

    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_0
    array-length v0, v2

    aput-char v1, v3, v0

    return-object v3
.end method

.method public static writeByteArray(Ljava/io/FileOutputStream;[B)V
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    invoke-virtual {p0, p1}, Ljava/io/FileOutputStream;->write([B)V

    return-void
.end method
