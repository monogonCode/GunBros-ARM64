.class public final Lcom/glu/platform/android/DeviceSound$ManualAudioTrackNotifier;
.super Ljava/lang/Thread;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/glu/platform/android/DeviceSound;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1
    name = "ManualAudioTrackNotifier"
.end annotation


# instance fields
.field public m_matnRunning:Z


# virtual methods
.method public final run()V
    .locals 4

    const-wide/16 v2, 0x28

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    :goto_0
    iget-boolean v0, p0, Lcom/glu/platform/android/DeviceSound$ManualAudioTrackNotifier;->m_matnRunning:Z

    if-eqz v0, :cond_0

    sget-object v0, Lcom/glu/platform/android/GluPlatformActivity;->instance:Lcom/glu/platform/android/GluPlatformActivity;

    if-nez v0, :cond_1

    :cond_0
    return-void

    :cond_1
    const-wide/16 v0, 0x28

    :try_start_0
    invoke-static {v0, v1}, Ljava/lang/Thread;->sleep(J)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Sleep for "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v2, v3}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "ms interrupted...somehow."

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    goto :goto_0
.end method

.method public final wrapUp()V
    .locals 1

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/glu/platform/android/DeviceSound$ManualAudioTrackNotifier;->m_matnRunning:Z

    return-void
.end method
