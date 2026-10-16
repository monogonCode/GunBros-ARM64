.class public final Lcom/glu/android/iap/Debug;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/glu/android/iap/Debug$Watermark;
    }
.end annotation


# static fields
.field public static final EGL_ATTRIBUTES:[I

.field public static final EGL_ATTRIBUTE_NAMES:[Ljava/lang/String;

.field private static m_debugFile:Ljava/io/File;

.field public static rawLine:[C

.field protected static sm_appMustClose:Z

.field protected static sm_debugPopupMessage:Ljava/lang/String;

.field protected static sm_fileInvalid:Z


# direct methods
.method static constructor <clinit>()V
    .locals 4

    const/4 v3, 0x0

    const/16 v1, 0x21

    const/4 v2, 0x0

    sput-object v3, Lcom/glu/android/iap/Debug;->m_debugFile:Ljava/io/File;

    const/16 v0, 0x50

    new-array v0, v0, [C

    sput-object v0, Lcom/glu/android/iap/Debug;->rawLine:[C

    sput-boolean v2, Lcom/glu/android/iap/Debug;->sm_fileInvalid:Z

    sput-boolean v2, Lcom/glu/android/iap/Debug;->sm_appMustClose:Z

    sput-object v3, Lcom/glu/android/iap/Debug;->sm_debugPopupMessage:Ljava/lang/String;

    new-array v0, v1, [I

    fill-array-data v0, :array_0

    sput-object v0, Lcom/glu/android/iap/Debug;->EGL_ATTRIBUTES:[I

    new-array v0, v1, [Ljava/lang/String;

    const-string v1, "EGL_BUFFER_SIZE"

    aput-object v1, v0, v2

    const/4 v1, 0x1

    const-string v2, "EGL_ALPHA_SIZE"

    aput-object v2, v0, v1

    const/4 v1, 0x2

    const-string v2, "EGL_BLUE_SIZE"

    aput-object v2, v0, v1

    const/4 v1, 0x3

    const-string v2, "EGL_GREEN_SIZE"

    aput-object v2, v0, v1

    const/4 v1, 0x4

    const-string v2, "EGL_RED_SIZE"

    aput-object v2, v0, v1

    const/4 v1, 0x5

    const-string v2, "EGL_DEPTH_SIZE"

    aput-object v2, v0, v1

    const/4 v1, 0x6

    const-string v2, "EGL_STENCIL_SIZE"

    aput-object v2, v0, v1

    const/4 v1, 0x7

    const-string v2, "EGL_CONFIG_CAVEAT"

    aput-object v2, v0, v1

    const/16 v1, 0x8

    const-string v2, "EGL_CONFIG_ID"

    aput-object v2, v0, v1

    const/16 v1, 0x9

    const-string v2, "EGL_LEVEL"

    aput-object v2, v0, v1

    const/16 v1, 0xa

    const-string v2, "EGL_MAX_PBUFFER_HEIGHT"

    aput-object v2, v0, v1

    const/16 v1, 0xb

    const-string v2, "EGL_MAX_PBUFFER_PIXELS"

    aput-object v2, v0, v1

    const/16 v1, 0xc

    const-string v2, "EGL_MAX_PBUFFER_WIDTH"

    aput-object v2, v0, v1

    const/16 v1, 0xd

    const-string v2, "EGL_NATIVE_RENDERABLE"

    aput-object v2, v0, v1

    const/16 v1, 0xe

    const-string v2, "EGL_NATIVE_VISUAL_ID"

    aput-object v2, v0, v1

    const/16 v1, 0xf

    const-string v2, "EGL_NATIVE_VISUAL_TYPE"

    aput-object v2, v0, v1

    const/16 v1, 0x10

    const-string v2, "EGL_PRESERVED_RESOURCES"

    aput-object v2, v0, v1

    const/16 v1, 0x11

    const-string v2, "EGL_SAMPLES"

    aput-object v2, v0, v1

    const/16 v1, 0x12

    const-string v2, "EGL_SAMPLE_BUFFERS"

    aput-object v2, v0, v1

    const/16 v1, 0x13

    const-string v2, "EGL_SURFACE_TYPE"

    aput-object v2, v0, v1

    const/16 v1, 0x14

    const-string v2, "EGL_TRANSPARENT_TYPE"

    aput-object v2, v0, v1

    const/16 v1, 0x15

    const-string v2, "EGL_TRANSPARENT_RED_VALUE"

    aput-object v2, v0, v1

    const/16 v1, 0x16

    const-string v2, "EGL_TRANSPARENT_GREEN_VALUE"

    aput-object v2, v0, v1

    const/16 v1, 0x17

    const-string v2, "EGL_TRANSPARENT_BLUE_VALUE"

    aput-object v2, v0, v1

    const/16 v1, 0x18

    const-string v2, "EGL_BIND_TO_TEXTURE_RGB"

    aput-object v2, v0, v1

    const/16 v1, 0x19

    const-string v2, "EGL_BIND_TO_TEXTURE_RGBA"

    aput-object v2, v0, v1

    const/16 v1, 0x1a

    const-string v2, "EGL_MIN_SWAP_INTERVAL"

    aput-object v2, v0, v1

    const/16 v1, 0x1b

    const-string v2, "EGL_MAX_SWAP_INTERVAL"

    aput-object v2, v0, v1

    const/16 v1, 0x1c

    const-string v2, "EGL_LUMINANCE_SIZE"

    aput-object v2, v0, v1

    const/16 v1, 0x1d

    const-string v2, "EGL_ALPHA_MASK_SIZE"

    aput-object v2, v0, v1

    const/16 v1, 0x1e

    const-string v2, "EGL_COLOR_BUFFER_TYPE"

    aput-object v2, v0, v1

    const/16 v1, 0x1f

    const-string v2, "EGL_RENDERABLE_TYPE"

    aput-object v2, v0, v1

    const/16 v1, 0x20

    const-string v2, "EGL_CONFORMANT"

    aput-object v2, v0, v1

    sput-object v0, Lcom/glu/android/iap/Debug;->EGL_ATTRIBUTE_NAMES:[Ljava/lang/String;

    return-void

    nop

    :array_0
    .array-data 4
        0x3020
        0x3021
        0x3022
        0x3023
        0x3024
        0x3025
        0x3026
        0x3027
        0x3028
        0x3029
        0x302a
        0x302b
        0x302c
        0x302d
        0x302e
        0x302f
        0x3030
        0x3031
        0x3032
        0x3033
        0x3034
        0x3037
        0x3036
        0x3035
        0x3039
        0x303a
        0x303b
        0x303c
        0x303d
        0x303e
        0x303f
        0x3040
        0x3042
    .end array-data
.end method

.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static log$16da05f7()V
    .locals 0

    return-void
.end method

.method public static log$2d473e19()V
    .locals 0

    return-void
.end method

.method public static log$552c4e01()V
    .locals 0

    return-void
.end method
