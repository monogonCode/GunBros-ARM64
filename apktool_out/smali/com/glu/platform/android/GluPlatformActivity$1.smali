.class final Lcom/glu/platform/android/GluPlatformActivity$1;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/media/MediaPlayer$OnCompletionListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/glu/platform/android/GluPlatformActivity;->InitialiseSoundEvent(Ljava/lang/String;J)Landroid/media/MediaPlayer;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/glu/platform/android/GluPlatformActivity;

.field final synthetic val$data:J


# direct methods
.method constructor <init>(Lcom/glu/platform/android/GluPlatformActivity;J)V
    .locals 0

    iput-object p1, p0, Lcom/glu/platform/android/GluPlatformActivity$1;->this$0:Lcom/glu/platform/android/GluPlatformActivity;

    iput-wide p2, p0, Lcom/glu/platform/android/GluPlatformActivity$1;->val$data:J

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final onCompletion(Landroid/media/MediaPlayer;)V
    .locals 4

    iget-object v0, p0, Lcom/glu/platform/android/GluPlatformActivity$1;->this$0:Lcom/glu/platform/android/GluPlatformActivity;

    invoke-static {v0}, Lcom/glu/platform/android/GluPlatformActivity;->access$200(Lcom/glu/platform/android/GluPlatformActivity;)Lcom/glu/platform/android/GluPlatformActivityJNI;

    move-result-object v0

    iget-object v1, p0, Lcom/glu/platform/android/GluPlatformActivity$1;->this$0:Lcom/glu/platform/android/GluPlatformActivity;

    invoke-static {v1}, Lcom/glu/platform/android/GluPlatformActivity;->access$100(Lcom/glu/platform/android/GluPlatformActivity;)I

    move-result v1

    iget-wide v2, p0, Lcom/glu/platform/android/GluPlatformActivity$1;->val$data:J

    invoke-virtual {v0, v1, v2, v3}, Lcom/glu/platform/android/GluPlatformActivityJNI;->SoundEventCompleted(IJ)V

    return-void
.end method
