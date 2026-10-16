.class final Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile$GIAPSingleItem;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "GIAPSingleItem"
.end annotation


# instance fields
.field private consumed:Z

.field private longId:J

.field private productId:Ljava/lang/String;

.field private reserved:[B

.field final synthetic this$0:Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile;


# direct methods
.method public constructor <init>(Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile;)V
    .locals 4

    const/4 v1, 0x0

    iput-object p1, p0, Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile$GIAPSingleItem;->this$0:Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile$GIAPSingleItem;->productId:Ljava/lang/String;

    iput-boolean v1, p0, Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile$GIAPSingleItem;->consumed:Z

    const-wide/16 v2, 0x0

    iput-wide v2, p0, Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile$GIAPSingleItem;->longId:J

    const/16 v0, 0x20

    new-array v0, v0, [B

    iput-object v0, p0, Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile$GIAPSingleItem;->reserved:[B

    move v0, v1

    :goto_0
    iget-object v2, p0, Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile$GIAPSingleItem;->reserved:[B

    array-length v2, v2

    if-ge v0, v2, :cond_0

    iget-object v2, p0, Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile$GIAPSingleItem;->reserved:[B

    aput-byte v1, v2, v0

    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_0
    return-void
.end method

.method static synthetic access$1600(Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile$GIAPSingleItem;)J
    .locals 2

    iget-wide v0, p0, Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile$GIAPSingleItem;->longId:J

    return-wide v0
.end method

.method static synthetic access$1602(Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile$GIAPSingleItem;J)J
    .locals 0

    iput-wide p1, p0, Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile$GIAPSingleItem;->longId:J

    return-wide p1
.end method

.method static synthetic access$1700(Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile$GIAPSingleItem;)Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile$GIAPSingleItem;->productId:Ljava/lang/String;

    return-object v0
.end method

.method static synthetic access$1702(Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile$GIAPSingleItem;Ljava/lang/String;)Ljava/lang/String;
    .locals 0

    iput-object p1, p0, Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile$GIAPSingleItem;->productId:Ljava/lang/String;

    return-object p1
.end method

.method static synthetic access$1800(Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile$GIAPSingleItem;)Z
    .locals 1

    iget-boolean v0, p0, Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile$GIAPSingleItem;->consumed:Z

    return v0
.end method

.method static synthetic access$1802(Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile$GIAPSingleItem;Z)Z
    .locals 0

    iput-boolean p1, p0, Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile$GIAPSingleItem;->consumed:Z

    return p1
.end method

.method static synthetic access$2100(Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile$GIAPSingleItem;)[B
    .locals 1

    iget-object v0, p0, Lcom/glu/android/iap/GluGoogleIAP$GIAPSaveFile$GIAPSingleItem;->reserved:[B

    return-object v0
.end method
