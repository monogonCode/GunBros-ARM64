.class public final Lcom/glu/platform/android/DeviceSound;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/glu/platform/android/DeviceSound$ManualAudioTrackNotifier;
    }
.end annotation


# static fields
.field public static instance:Lcom/glu/platform/android/DeviceSound;


# instance fields
.field private bytesWritten:I

.field public m_audioData:[B

.field public m_audioManager:Landroid/media/AudioManager;

.field private m_audioTrack:Lcom/glu/platform/android/DeviceTrack;

.field public m_emptyData:[B

.field private m_lastSoundPlayed:Ljava/lang/String;

.field private m_leftVolume:F

.field private m_lowerGameAudioForPrioritySource:Z

.field public m_manualNotifierThread:Lcom/glu/platform/android/DeviceSound$ManualAudioTrackNotifier;

.field private m_mp3Enabled:Z

.field private m_mp3IsPaused:Z

.field private m_nativeBitRate:I

.field private m_nativeFrequency:I

.field private m_nativeNumChannels:I

.field public m_oemAudioPlaying:Z

.field public m_oemAudioVolume:I

.field private m_ourMP3:Landroid/media/MediaPlayer;

.field private m_pcmVolumeZeroToTen:I

.field private m_rightVolume:F

.field public m_soundForcedByUser:Z

.field public vibrator:Landroid/os/Vibrator;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    const/4 v0, 0x0

    sput-object v0, Lcom/glu/platform/android/DeviceSound;->instance:Lcom/glu/platform/android/DeviceSound;

    return-void
.end method

.method public constructor <init>()V
    .locals 4

    const/high16 v3, 0x3f000000    # 0.5f

    const/4 v0, -0x1

    const/4 v2, 0x0

    const/4 v1, 0x0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object v1, p0, Lcom/glu/platform/android/DeviceSound;->m_audioTrack:Lcom/glu/platform/android/DeviceTrack;

    iput-object v1, p0, Lcom/glu/platform/android/DeviceSound;->vibrator:Landroid/os/Vibrator;

    iput v2, p0, Lcom/glu/platform/android/DeviceSound;->bytesWritten:I

    iput-object v1, p0, Lcom/glu/platform/android/DeviceSound;->m_audioData:[B

    iput-object v1, p0, Lcom/glu/platform/android/DeviceSound;->m_emptyData:[B

    iput-object v1, p0, Lcom/glu/platform/android/DeviceSound;->m_audioManager:Landroid/media/AudioManager;

    iput-boolean v2, p0, Lcom/glu/platform/android/DeviceSound;->m_soundForcedByUser:Z

    iput-boolean v2, p0, Lcom/glu/platform/android/DeviceSound;->m_oemAudioPlaying:Z

    iput v2, p0, Lcom/glu/platform/android/DeviceSound;->m_oemAudioVolume:I

    iput v0, p0, Lcom/glu/platform/android/DeviceSound;->m_nativeBitRate:I

    iput v0, p0, Lcom/glu/platform/android/DeviceSound;->m_nativeNumChannels:I

    iput v0, p0, Lcom/glu/platform/android/DeviceSound;->m_nativeFrequency:I

    const/4 v0, 0x5

    iput v0, p0, Lcom/glu/platform/android/DeviceSound;->m_pcmVolumeZeroToTen:I

    iput-object v1, p0, Lcom/glu/platform/android/DeviceSound;->m_ourMP3:Landroid/media/MediaPlayer;

    iput-object v1, p0, Lcom/glu/platform/android/DeviceSound;->m_lastSoundPlayed:Ljava/lang/String;

    iput-boolean v2, p0, Lcom/glu/platform/android/DeviceSound;->m_mp3IsPaused:Z

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/glu/platform/android/DeviceSound;->m_mp3Enabled:Z

    iput v3, p0, Lcom/glu/platform/android/DeviceSound;->m_leftVolume:F

    iput v3, p0, Lcom/glu/platform/android/DeviceSound;->m_rightVolume:F

    iput-boolean v2, p0, Lcom/glu/platform/android/DeviceSound;->m_lowerGameAudioForPrioritySource:Z

    iput-object v1, p0, Lcom/glu/platform/android/DeviceSound;->m_manualNotifierThread:Lcom/glu/platform/android/DeviceSound$ManualAudioTrackNotifier;

    sput-object p0, Lcom/glu/platform/android/DeviceSound;->instance:Lcom/glu/platform/android/DeviceSound;

    iget-object v0, p0, Lcom/glu/platform/android/DeviceSound;->vibrator:Landroid/os/Vibrator;

    if-nez v0, :cond_0

    sget-object v0, Lcom/glu/platform/android/GluPlatformActivity;->instance:Lcom/glu/platform/android/GluPlatformActivity;

    const-string v1, "vibrator"

    invoke-virtual {v0, v1}, Lcom/glu/platform/android/GluPlatformActivity;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/os/Vibrator;

    iput-object v0, p0, Lcom/glu/platform/android/DeviceSound;->vibrator:Landroid/os/Vibrator;

    :cond_0
    iget-object v0, p0, Lcom/glu/platform/android/DeviceSound;->m_audioManager:Landroid/media/AudioManager;

    if-nez v0, :cond_1

    sget-object v0, Lcom/glu/platform/android/GluPlatformActivity;->instance:Lcom/glu/platform/android/GluPlatformActivity;

    const-string v1, "audio"

    invoke-virtual {v0, v1}, Lcom/glu/platform/android/GluPlatformActivity;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/media/AudioManager;

    iput-object v0, p0, Lcom/glu/platform/android/DeviceSound;->m_audioManager:Landroid/media/AudioManager;

    :cond_1
    sget-object v0, Lcom/glu/platform/android/DeviceSound;->instance:Lcom/glu/platform/android/DeviceSound;

    iget-object v0, v0, Lcom/glu/platform/android/DeviceSound;->m_audioManager:Landroid/media/AudioManager;

    invoke-virtual {v0}, Landroid/media/AudioManager;->isMusicActive()Z

    move-result v0

    iput-boolean v0, p0, Lcom/glu/platform/android/DeviceSound;->m_oemAudioPlaying:Z

    iget-boolean v0, p0, Lcom/glu/platform/android/DeviceSound;->m_oemAudioPlaying:Z

    if-eqz v0, :cond_2

    sget-object v0, Lcom/glu/platform/android/DeviceSound;->instance:Lcom/glu/platform/android/DeviceSound;

    iget-object v0, v0, Lcom/glu/platform/android/DeviceSound;->m_audioManager:Landroid/media/AudioManager;

    const/4 v1, 0x3

    invoke-virtual {v0, v1}, Landroid/media/AudioManager;->getStreamVolume(I)I

    move-result v0

    iput v0, p0, Lcom/glu/platform/android/DeviceSound;->m_oemAudioVolume:I

    :cond_2
    return-void
.end method


# virtual methods
.method public final pauseMP3()V
    .locals 1

    iget-object v0, p0, Lcom/glu/platform/android/DeviceSound;->m_ourMP3:Landroid/media/MediaPlayer;

    if-nez v0, :cond_1

    :cond_0
    :goto_0
    return-void

    :cond_1
    iget-boolean v0, p0, Lcom/glu/platform/android/DeviceSound;->m_mp3IsPaused:Z

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/glu/platform/android/DeviceSound;->m_ourMP3:Landroid/media/MediaPlayer;

    invoke-virtual {v0}, Landroid/media/MediaPlayer;->pause()V

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/glu/platform/android/DeviceSound;->m_mp3IsPaused:Z

    goto :goto_0
.end method

.method public final playMP3(Ljava/lang/String;Z)V
    .locals 4

    const/4 v3, 0x0

    sget-object v0, Lcom/glu/platform/android/DeviceSound;->instance:Lcom/glu/platform/android/DeviceSound;

    iget-boolean v0, v0, Lcom/glu/platform/android/DeviceSound;->m_oemAudioPlaying:Z

    if-eqz v0, :cond_1

    iget-boolean v0, p0, Lcom/glu/platform/android/DeviceSound;->m_soundForcedByUser:Z

    if-nez v0, :cond_1

    :cond_0
    :goto_0
    return-void

    :cond_1
    iget-object v0, p0, Lcom/glu/platform/android/DeviceSound;->m_lastSoundPlayed:Ljava/lang/String;

    if-nez v0, :cond_2

    const-string v0, "null"

    :cond_2
    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_4

    iget-object v0, p0, Lcom/glu/platform/android/DeviceSound;->m_ourMP3:Landroid/media/MediaPlayer;

    if-eqz v0, :cond_4

    iget-object v0, p0, Lcom/glu/platform/android/DeviceSound;->m_ourMP3:Landroid/media/MediaPlayer;

    invoke-virtual {v0}, Landroid/media/MediaPlayer;->isPlaying()Z

    move-result v0

    if-nez v0, :cond_0

    :cond_3
    invoke-virtual {p0}, Lcom/glu/platform/android/DeviceSound;->stopAndDestroyMP3()V

    invoke-static {p1}, Lcom/glu/platform/android/GluUtil;->findMediaResourceFile(Ljava/lang/String;)Ljava/io/File;

    move-result-object v0

    if-eqz v0, :cond_0

    :try_start_0
    new-instance v1, Ljava/io/FileInputStream;

    invoke-direct {v1, v0}, Ljava/io/FileInputStream;-><init>(Ljava/io/File;)V

    new-instance v0, Landroid/media/MediaPlayer;

    invoke-direct {v0}, Landroid/media/MediaPlayer;-><init>()V

    iput-object v0, p0, Lcom/glu/platform/android/DeviceSound;->m_ourMP3:Landroid/media/MediaPlayer;

    iget-object v0, p0, Lcom/glu/platform/android/DeviceSound;->m_ourMP3:Landroid/media/MediaPlayer;

    invoke-virtual {v1}, Ljava/io/FileInputStream;->getFD()Ljava/io/FileDescriptor;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/media/MediaPlayer;->setDataSource(Ljava/io/FileDescriptor;)V

    iget-object v0, p0, Lcom/glu/platform/android/DeviceSound;->m_ourMP3:Landroid/media/MediaPlayer;

    invoke-virtual {v0}, Landroid/media/MediaPlayer;->prepare()V

    iget-object v0, p0, Lcom/glu/platform/android/DeviceSound;->m_ourMP3:Landroid/media/MediaPlayer;

    invoke-virtual {v0, p2}, Landroid/media/MediaPlayer;->setLooping(Z)V

    iget-object v0, p0, Lcom/glu/platform/android/DeviceSound;->m_ourMP3:Landroid/media/MediaPlayer;

    iget v1, p0, Lcom/glu/platform/android/DeviceSound;->m_leftVolume:F

    iget v2, p0, Lcom/glu/platform/android/DeviceSound;->m_rightVolume:F

    invoke-virtual {v0, v1, v2}, Landroid/media/MediaPlayer;->setVolume(FF)V

    iget-object v0, p0, Lcom/glu/platform/android/DeviceSound;->m_ourMP3:Landroid/media/MediaPlayer;

    invoke-virtual {v0}, Landroid/media/MediaPlayer;->start()V

    iput-object p1, p0, Lcom/glu/platform/android/DeviceSound;->m_lastSoundPlayed:Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    iput-object v3, p0, Lcom/glu/platform/android/DeviceSound;->m_ourMP3:Landroid/media/MediaPlayer;

    iput-object v3, p0, Lcom/glu/platform/android/DeviceSound;->m_lastSoundPlayed:Ljava/lang/String;

    goto :goto_0

    :cond_4
    iget-boolean v0, p0, Lcom/glu/platform/android/DeviceSound;->m_mp3Enabled:Z

    if-nez v0, :cond_3

    goto :goto_0
.end method

.method public final resumeMP3()V
    .locals 2

    const/4 v1, 0x0

    iget-object v0, p0, Lcom/glu/platform/android/DeviceSound;->m_ourMP3:Landroid/media/MediaPlayer;

    if-nez v0, :cond_1

    iput-boolean v1, p0, Lcom/glu/platform/android/DeviceSound;->m_mp3IsPaused:Z

    :cond_0
    :goto_0
    return-void

    :cond_1
    iget-boolean v0, p0, Lcom/glu/platform/android/DeviceSound;->m_mp3Enabled:Z

    if-eqz v0, :cond_0

    iget-boolean v0, p0, Lcom/glu/platform/android/DeviceSound;->m_mp3IsPaused:Z

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/glu/platform/android/DeviceSound;->m_ourMP3:Landroid/media/MediaPlayer;

    invoke-virtual {v0}, Landroid/media/MediaPlayer;->start()V

    iput-boolean v1, p0, Lcom/glu/platform/android/DeviceSound;->m_mp3IsPaused:Z

    goto :goto_0
.end method

.method public final stop()V
    .locals 2

    const/4 v1, 0x0

    invoke-virtual {p0}, Lcom/glu/platform/android/DeviceSound;->pauseMP3()V

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/glu/platform/android/DeviceSound;->m_mp3Enabled:Z

    iget-object v0, p0, Lcom/glu/platform/android/DeviceSound;->m_audioTrack:Lcom/glu/platform/android/DeviceTrack;

    if-nez v0, :cond_0

    :goto_0
    return-void

    :cond_0
    iget-object v0, p0, Lcom/glu/platform/android/DeviceSound;->m_audioTrack:Lcom/glu/platform/android/DeviceTrack;

    invoke-virtual {v0}, Lcom/glu/platform/android/DeviceTrack;->stop()V

    iget-object v0, p0, Lcom/glu/platform/android/DeviceSound;->m_manualNotifierThread:Lcom/glu/platform/android/DeviceSound$ManualAudioTrackNotifier;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/glu/platform/android/DeviceSound;->m_manualNotifierThread:Lcom/glu/platform/android/DeviceSound$ManualAudioTrackNotifier;

    invoke-virtual {v0}, Lcom/glu/platform/android/DeviceSound$ManualAudioTrackNotifier;->wrapUp()V

    iput-object v1, p0, Lcom/glu/platform/android/DeviceSound;->m_manualNotifierThread:Lcom/glu/platform/android/DeviceSound$ManualAudioTrackNotifier;

    :cond_1
    iput-object v1, p0, Lcom/glu/platform/android/DeviceSound;->m_audioTrack:Lcom/glu/platform/android/DeviceTrack;

    goto :goto_0
.end method

.method public final stopAndDestroyMP3()V
    .locals 1

    iget-object v0, p0, Lcom/glu/platform/android/DeviceSound;->m_ourMP3:Landroid/media/MediaPlayer;

    if-nez v0, :cond_0

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/glu/platform/android/DeviceSound;->m_mp3IsPaused:Z

    :goto_0
    return-void

    :cond_0
    iget-object v0, p0, Lcom/glu/platform/android/DeviceSound;->m_ourMP3:Landroid/media/MediaPlayer;

    invoke-virtual {v0}, Landroid/media/MediaPlayer;->stop()V

    iget-object v0, p0, Lcom/glu/platform/android/DeviceSound;->m_ourMP3:Landroid/media/MediaPlayer;

    invoke-virtual {v0}, Landroid/media/MediaPlayer;->release()V

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/glu/platform/android/DeviceSound;->m_ourMP3:Landroid/media/MediaPlayer;

    goto :goto_0
.end method

.method public final volumeSetMP3(I)V
    .locals 5

    const v2, 0x3dcccccd    # 0.1f

    const/high16 v4, 0x3f800000    # 1.0f

    const/4 v1, 0x0

    int-to-float v0, p1

    const/high16 v3, 0x42c80000    # 100.0f

    div-float/2addr v0, v3

    iput v0, p0, Lcom/glu/platform/android/DeviceSound;->m_rightVolume:F

    iput v0, p0, Lcom/glu/platform/android/DeviceSound;->m_leftVolume:F

    iget v0, p0, Lcom/glu/platform/android/DeviceSound;->m_leftVolume:F

    cmpg-float v0, v0, v1

    if-gez v0, :cond_3

    iput v1, p0, Lcom/glu/platform/android/DeviceSound;->m_leftVolume:F

    :cond_0
    :goto_0
    iget v0, p0, Lcom/glu/platform/android/DeviceSound;->m_rightVolume:F

    cmpg-float v0, v0, v1

    if-gez v0, :cond_4

    iput v1, p0, Lcom/glu/platform/android/DeviceSound;->m_rightVolume:F

    :cond_1
    :goto_1
    iget-object v0, p0, Lcom/glu/platform/android/DeviceSound;->m_ourMP3:Landroid/media/MediaPlayer;

    if-eqz v0, :cond_2

    iget-boolean v0, p0, Lcom/glu/platform/android/DeviceSound;->m_lowerGameAudioForPrioritySource:Z

    if-eqz v0, :cond_7

    iget-object v3, p0, Lcom/glu/platform/android/DeviceSound;->m_ourMP3:Landroid/media/MediaPlayer;

    iget v0, p0, Lcom/glu/platform/android/DeviceSound;->m_leftVolume:F

    cmpg-float v0, v0, v1

    if-gtz v0, :cond_5

    move v0, v1

    :goto_2
    iget v4, p0, Lcom/glu/platform/android/DeviceSound;->m_rightVolume:F

    cmpg-float v4, v4, v1

    if-gtz v4, :cond_6

    :goto_3
    invoke-virtual {v3, v0, v1}, Landroid/media/MediaPlayer;->setVolume(FF)V

    :cond_2
    :goto_4
    return-void

    :cond_3
    iget v0, p0, Lcom/glu/platform/android/DeviceSound;->m_leftVolume:F

    cmpl-float v0, v0, v4

    if-lez v0, :cond_0

    iput v4, p0, Lcom/glu/platform/android/DeviceSound;->m_leftVolume:F

    goto :goto_0

    :cond_4
    iget v0, p0, Lcom/glu/platform/android/DeviceSound;->m_rightVolume:F

    cmpl-float v0, v0, v4

    if-lez v0, :cond_1

    iput v4, p0, Lcom/glu/platform/android/DeviceSound;->m_rightVolume:F

    goto :goto_1

    :cond_5
    move v0, v2

    goto :goto_2

    :cond_6
    move v1, v2

    goto :goto_3

    :cond_7
    iget-object v0, p0, Lcom/glu/platform/android/DeviceSound;->m_ourMP3:Landroid/media/MediaPlayer;

    iget v1, p0, Lcom/glu/platform/android/DeviceSound;->m_leftVolume:F

    iget v2, p0, Lcom/glu/platform/android/DeviceSound;->m_rightVolume:F

    invoke-virtual {v0, v1, v2}, Landroid/media/MediaPlayer;->setVolume(FF)V

    goto :goto_4
.end method
