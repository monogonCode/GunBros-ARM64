.class public Lcom/tapjoy/TapjoyDisplayAdSize;
.super Ljava/lang/Object;


# static fields
.field public static TJC_AD_BANNERSIZE_320X50:Ljava/lang/String;

.field public static TJC_AD_BANNERSIZE_640X100:Ljava/lang/String;

.field public static TJC_AD_BANNERSIZE_768X90:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    const-string v0, "320x50"

    sput-object v0, Lcom/tapjoy/TapjoyDisplayAdSize;->TJC_AD_BANNERSIZE_320X50:Ljava/lang/String;

    const-string v0, "640x100"

    sput-object v0, Lcom/tapjoy/TapjoyDisplayAdSize;->TJC_AD_BANNERSIZE_640X100:Ljava/lang/String;

    const-string v0, "768x90"

    sput-object v0, Lcom/tapjoy/TapjoyDisplayAdSize;->TJC_AD_BANNERSIZE_768X90:Ljava/lang/String;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method
