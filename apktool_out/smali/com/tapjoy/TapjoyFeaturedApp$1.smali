.class Lcom/tapjoy/TapjoyFeaturedApp$1;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/tapjoy/TapjoyFeaturedApp;->getFeaturedApp(Ljava/lang/String;Lcom/tapjoy/TapjoyFeaturedAppNotifier;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/tapjoy/TapjoyFeaturedApp;


# direct methods
.method constructor <init>(Lcom/tapjoy/TapjoyFeaturedApp;)V
    .locals 0

    iput-object p1, p0, Lcom/tapjoy/TapjoyFeaturedApp$1;->this$0:Lcom/tapjoy/TapjoyFeaturedApp;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 4

    const/4 v0, 0x0

    invoke-static {}, Lcom/tapjoy/TapjoyFeaturedApp;->access$000()Lcom/tapjoy/TapjoyURLConnection;

    move-result-object v1

    const-string v2, "https://ws.tapjoyads.com/get_offers/featured?"

    sget-object v3, Lcom/tapjoy/TapjoyFeaturedApp;->featuredAppURLParams:Ljava/lang/String;

    invoke-virtual {v1, v2, v3}, Lcom/tapjoy/TapjoyURLConnection;->connectToURL(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_0

    iget-object v0, p0, Lcom/tapjoy/TapjoyFeaturedApp$1;->this$0:Lcom/tapjoy/TapjoyFeaturedApp;

    invoke-static {v0, v1}, Lcom/tapjoy/TapjoyFeaturedApp;->access$100(Lcom/tapjoy/TapjoyFeaturedApp;Ljava/lang/String;)Z

    move-result v0

    :cond_0
    if-nez v0, :cond_1

    invoke-static {}, Lcom/tapjoy/TapjoyFeaturedApp;->access$200()Lcom/tapjoy/TapjoyFeaturedAppNotifier;

    move-result-object v0

    const-string v1, "Error retrieving featured app data from the server."

    invoke-interface {v0, v1}, Lcom/tapjoy/TapjoyFeaturedAppNotifier;->getFeaturedAppResponseFailed(Ljava/lang/String;)V

    :cond_1
    return-void
.end method
