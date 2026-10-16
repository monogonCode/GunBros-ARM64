.class final Lcom/glu/platform/android/DeviceTrack;
.super Landroid/media/AudioTrack;


# instance fields
.field public frameSize:I


# virtual methods
.method public final play()V
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/IllegalStateException;
        }
    .end annotation

    invoke-super {p0}, Landroid/media/AudioTrack;->play()V

    invoke-virtual {p0}, Lcom/glu/platform/android/DeviceTrack;->getNativeFrameCount()I

    move-result v0

    iget v1, p0, Lcom/glu/platform/android/DeviceTrack;->frameSize:I

    mul-int/2addr v0, v1

    new-array v0, v0, [B

    const/4 v1, 0x0

    array-length v2, v0

    invoke-virtual {p0, v0, v1, v2}, Lcom/glu/platform/android/DeviceTrack;->write([BII)I

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "initial audio data length="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    array-length v0, v0

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    return-void
.end method
