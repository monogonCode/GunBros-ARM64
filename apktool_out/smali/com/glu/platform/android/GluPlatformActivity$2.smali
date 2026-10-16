.class final Lcom/glu/platform/android/GluPlatformActivity$2;
.super Landroid/view/OrientationEventListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/glu/platform/android/GluPlatformActivity;->StartAutoRotation(J)Z
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/glu/platform/android/GluPlatformActivity;


# direct methods
.method constructor <init>(Lcom/glu/platform/android/GluPlatformActivity;Landroid/content/Context;)V
    .locals 1

    iput-object p1, p0, Lcom/glu/platform/android/GluPlatformActivity$2;->this$0:Lcom/glu/platform/android/GluPlatformActivity;

    const/4 v0, 0x3

    invoke-direct {p0, p2, v0}, Landroid/view/OrientationEventListener;-><init>(Landroid/content/Context;I)V

    return-void
.end method


# virtual methods
.method public final onOrientationChanged(I)V
    .locals 4

    const/4 v1, 0x1

    const/4 v2, 0x0

    const/4 v0, -0x1

    if-eq v0, p1, :cond_5

    iget-object v0, p0, Lcom/glu/platform/android/GluPlatformActivity$2;->this$0:Lcom/glu/platform/android/GluPlatformActivity;

    invoke-static {v0}, Lcom/glu/platform/android/GluPlatformActivity;->access$300(Lcom/glu/platform/android/GluPlatformActivity;)I

    move-result v0

    iget-object v3, p0, Lcom/glu/platform/android/GluPlatformActivity$2;->this$0:Lcom/glu/platform/android/GluPlatformActivity;

    invoke-static {v3}, Lcom/glu/platform/android/GluPlatformActivity;->access$400(Lcom/glu/platform/android/GluPlatformActivity;)[Z

    move-result-object v3

    aget-boolean v3, v3, v2

    if-eqz v3, :cond_1

    const/16 v3, 0x15e

    if-ge p1, v3, :cond_0

    const/16 v3, 0xa

    if-ge p1, v3, :cond_1

    :cond_0
    move v0, v1

    :cond_1
    iget-object v3, p0, Lcom/glu/platform/android/GluPlatformActivity$2;->this$0:Lcom/glu/platform/android/GluPlatformActivity;

    invoke-static {v3}, Lcom/glu/platform/android/GluPlatformActivity;->access$400(Lcom/glu/platform/android/GluPlatformActivity;)[Z

    move-result-object v3

    aget-boolean v1, v3, v1

    if-eqz v1, :cond_2

    const/16 v1, 0x50

    if-lt p1, v1, :cond_2

    const/16 v1, 0x64

    if-ge p1, v1, :cond_2

    const/16 v0, 0x8

    :cond_2
    iget-object v1, p0, Lcom/glu/platform/android/GluPlatformActivity$2;->this$0:Lcom/glu/platform/android/GluPlatformActivity;

    invoke-static {v1}, Lcom/glu/platform/android/GluPlatformActivity;->access$400(Lcom/glu/platform/android/GluPlatformActivity;)[Z

    move-result-object v1

    const/4 v3, 0x2

    aget-boolean v1, v1, v3

    if-eqz v1, :cond_3

    const/16 v1, 0xaa

    if-lt p1, v1, :cond_3

    const/16 v1, 0xbe

    if-ge p1, v1, :cond_3

    const/16 v0, 0x9

    :cond_3
    iget-object v1, p0, Lcom/glu/platform/android/GluPlatformActivity$2;->this$0:Lcom/glu/platform/android/GluPlatformActivity;

    invoke-static {v1}, Lcom/glu/platform/android/GluPlatformActivity;->access$400(Lcom/glu/platform/android/GluPlatformActivity;)[Z

    move-result-object v1

    const/4 v3, 0x3

    aget-boolean v1, v1, v3

    if-eqz v1, :cond_4

    const/16 v1, 0x104

    if-lt p1, v1, :cond_4

    const/16 v1, 0x118

    if-ge p1, v1, :cond_4

    move v0, v2

    :cond_4
    iget-object v1, p0, Lcom/glu/platform/android/GluPlatformActivity$2;->this$0:Lcom/glu/platform/android/GluPlatformActivity;

    invoke-static {v1}, Lcom/glu/platform/android/GluPlatformActivity;->access$300(Lcom/glu/platform/android/GluPlatformActivity;)I

    move-result v1

    if-eq v0, v1, :cond_5

    iget-object v1, p0, Lcom/glu/platform/android/GluPlatformActivity$2;->this$0:Lcom/glu/platform/android/GluPlatformActivity;

    invoke-static {v1, v0}, Lcom/glu/platform/android/GluPlatformActivity;->access$302(Lcom/glu/platform/android/GluPlatformActivity;I)I

    iget-object v1, p0, Lcom/glu/platform/android/GluPlatformActivity$2;->this$0:Lcom/glu/platform/android/GluPlatformActivity;

    invoke-virtual {v1, v0}, Lcom/glu/platform/android/GluPlatformActivity;->setRequestedOrientation(I)V

    :cond_5
    return-void
.end method
