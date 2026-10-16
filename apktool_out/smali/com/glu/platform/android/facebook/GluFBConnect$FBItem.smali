.class public final Lcom/glu/platform/android/facebook/GluFBConnect$FBItem;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/glu/platform/android/facebook/GluFBConnect;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "FBItem"
.end annotation


# instance fields
.field public imageSize:Ljava/lang/String;

.field public imageUser:Ljava/lang/String;


# direct methods
.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1

    const/4 v0, 0x0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object v0, p0, Lcom/glu/platform/android/facebook/GluFBConnect$FBItem;->imageSize:Ljava/lang/String;

    iput-object v0, p0, Lcom/glu/platform/android/facebook/GluFBConnect$FBItem;->imageUser:Ljava/lang/String;

    iput-object p1, p0, Lcom/glu/platform/android/facebook/GluFBConnect$FBItem;->imageSize:Ljava/lang/String;

    iput-object p2, p0, Lcom/glu/platform/android/facebook/GluFBConnect$FBItem;->imageUser:Ljava/lang/String;

    return-void
.end method
