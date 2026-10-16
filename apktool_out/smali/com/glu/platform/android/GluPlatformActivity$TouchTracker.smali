.class final Lcom/glu/platform/android/GluPlatformActivity$TouchTracker;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/glu/platform/android/GluPlatformActivity;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "TouchTracker"
.end annotation


# instance fields
.field public m_Index:I

.field public m_Mode:I

.field public m_MoveThreshold:I

.field public m_PointerId:I

.field public m_X:I

.field public m_Y:I

.field final synthetic this$0:Lcom/glu/platform/android/GluPlatformActivity;


# direct methods
.method synthetic constructor <init>(Lcom/glu/platform/android/GluPlatformActivity;)V
    .locals 1

    const/4 v0, 0x0

    invoke-direct {p0, p1, v0}, Lcom/glu/platform/android/GluPlatformActivity$TouchTracker;-><init>(Lcom/glu/platform/android/GluPlatformActivity;B)V

    return-void
.end method

.method private constructor <init>(Lcom/glu/platform/android/GluPlatformActivity;B)V
    .locals 0

    iput-object p1, p0, Lcom/glu/platform/android/GluPlatformActivity$TouchTracker;->this$0:Lcom/glu/platform/android/GluPlatformActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final toString()Ljava/lang/String;
    .locals 3

    iget v0, p0, Lcom/glu/platform/android/GluPlatformActivity$TouchTracker;->m_Mode:I

    packed-switch v0, :pswitch_data_0

    const-string v0, "UNKNOWN"

    :goto_0
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "pid="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v2, p0, Lcom/glu/platform/android/GluPlatformActivity$TouchTracker;->m_PointerId:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " x="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v2, p0, Lcom/glu/platform/android/GluPlatformActivity$TouchTracker;->m_X:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " y="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v2, p0, Lcom/glu/platform/android/GluPlatformActivity$TouchTracker;->m_Y:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " m="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " t="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/glu/platform/android/GluPlatformActivity$TouchTracker;->m_MoveThreshold:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0

    :pswitch_0
    const-string v0, "BEGAN"

    goto :goto_0

    :pswitch_1
    const-string v0, "MOVED"

    goto :goto_0

    :pswitch_2
    const-string v0, "ENDED"

    goto :goto_0

    :pswitch_3
    const-string v0, "CANCELLED"

    goto :goto_0

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_0
        :pswitch_1
        :pswitch_2
        :pswitch_3
    .end packed-switch
.end method
