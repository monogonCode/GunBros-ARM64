.class final Lcom/glu/android/iap/GluGoogleIAP$1;
.super Ljava/lang/Thread;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/glu/android/iap/GluGoogleIAP;->buyProduct(Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/glu/android/iap/GluGoogleIAP;


# direct methods
.method constructor <init>(Lcom/glu/android/iap/GluGoogleIAP;)V
    .locals 0

    iput-object p1, p0, Lcom/glu/android/iap/GluGoogleIAP$1;->this$0:Lcom/glu/android/iap/GluGoogleIAP;

    invoke-direct {p0}, Ljava/lang/Thread;-><init>()V

    return-void
.end method


# virtual methods
.method public final run()V
    .locals 2

    const-wide/16 v0, 0x3e8

    :try_start_0
    invoke-static {v0, v1}, Ljava/lang/Thread;->sleep(J)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    iget-object v0, p0, Lcom/glu/android/iap/GluGoogleIAP$1;->this$0:Lcom/glu/android/iap/GluGoogleIAP;

    invoke-static {}, Lcom/glu/android/iap/GluGoogleIAP;->access$000()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/glu/android/iap/GluGoogleIAP;->access$100(Lcom/glu/android/iap/GluGoogleIAP;Ljava/lang/String;)V

    const/4 v0, 0x0

    invoke-static {v0}, Lcom/glu/android/iap/GluGoogleIAP;->access$202(Ljava/lang/Thread;)Ljava/lang/Thread;

    return-void

    :catch_0
    move-exception v0

    invoke-static {}, Lcom/glu/android/iap/Debug;->log$2d473e19()V

    goto :goto_0
.end method
