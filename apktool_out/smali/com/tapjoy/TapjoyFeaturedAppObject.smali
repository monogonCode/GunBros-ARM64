.class public Lcom/tapjoy/TapjoyFeaturedAppObject;
.super Ljava/lang/Object;


# instance fields
.field public amount:I

.field public cost:Ljava/lang/String;

.field public description:Ljava/lang/String;

.field public fullScreenAdURL:Ljava/lang/String;

.field public iconURL:Ljava/lang/String;

.field public maxTimesToDisplayThisApp:I

.field public name:Ljava/lang/String;

.field public redirectURL:Ljava/lang/String;

.field public storeID:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const-string v0, ""

    iput-object v0, p0, Lcom/tapjoy/TapjoyFeaturedAppObject;->cost:Ljava/lang/String;

    const-string v0, ""

    iput-object v0, p0, Lcom/tapjoy/TapjoyFeaturedAppObject;->storeID:Ljava/lang/String;

    const-string v0, ""

    iput-object v0, p0, Lcom/tapjoy/TapjoyFeaturedAppObject;->name:Ljava/lang/String;

    const-string v0, ""

    iput-object v0, p0, Lcom/tapjoy/TapjoyFeaturedAppObject;->description:Ljava/lang/String;

    const-string v0, ""

    iput-object v0, p0, Lcom/tapjoy/TapjoyFeaturedAppObject;->iconURL:Ljava/lang/String;

    const-string v0, ""

    iput-object v0, p0, Lcom/tapjoy/TapjoyFeaturedAppObject;->redirectURL:Ljava/lang/String;

    const-string v0, ""

    iput-object v0, p0, Lcom/tapjoy/TapjoyFeaturedAppObject;->fullScreenAdURL:Ljava/lang/String;

    return-void
.end method
