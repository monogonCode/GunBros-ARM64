.class public Lcom/glu/platform/android/GluMovieActivity;
.super Landroid/app/Activity;

# interfaces
.implements Landroid/media/MediaPlayer$OnCompletionListener;
.implements Landroid/media/MediaPlayer$OnInfoListener;
.implements Landroid/media/MediaPlayer$OnPreparedListener;
.implements Landroid/media/MediaPlayer$OnVideoSizeChangedListener;
.implements Landroid/view/SurfaceHolder$Callback;


# static fields
.field static final synthetic $assertionsDisabled:Z


# instance fields
.field private m_ExtraMovieEvent:J

.field private m_ExtraMovieExternalPath:Ljava/lang/String;

.field private m_ExtraMovieFilename:Ljava/lang/String;

.field private m_ExtraMovieInternalPath:Ljava/lang/String;

.field private m_Height:I

.field private m_Holder:Landroid/view/SurfaceHolder;

.field private m_IsPrepared:Z

.field private m_IsVideoSizeKnown:Z

.field private m_Path:Ljava/lang/String;

.field private m_Player:Landroid/media/MediaPlayer;

.field private m_Preview:Landroid/view/SurfaceView;

.field private m_TouchDownReceived:Z

.field private m_WakeLock:Landroid/os/PowerManager$WakeLock;

.field private m_Width:I


# direct methods
.method static constructor <clinit>()V
    .locals 1

    const-class v0, Lcom/glu/platform/android/GluMovieActivity;

    invoke-virtual {v0}, Ljava/lang/Class;->desiredAssertionStatus()Z

    move-result v0

    if-nez v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    sput-boolean v0, Lcom/glu/platform/android/GluMovieActivity;->$assertionsDisabled:Z

    return-void

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Landroid/app/Activity;-><init>()V

    const-string v0, "Gman_intro.3gp"

    iput-object v0, p0, Lcom/glu/platform/android/GluMovieActivity;->m_Path:Ljava/lang/String;

    return-void
.end method

.method private doCleanUp()V
    .locals 1

    const/4 v0, 0x0

    iput v0, p0, Lcom/glu/platform/android/GluMovieActivity;->m_Width:I

    iput v0, p0, Lcom/glu/platform/android/GluMovieActivity;->m_Height:I

    iput-boolean v0, p0, Lcom/glu/platform/android/GluMovieActivity;->m_IsVideoSizeKnown:Z

    iput-boolean v0, p0, Lcom/glu/platform/android/GluMovieActivity;->m_IsPrepared:Z

    return-void
.end method

.method private finishMovieActivity()V
    .locals 2

    iget-wide v0, p0, Lcom/glu/platform/android/GluMovieActivity;->m_ExtraMovieEvent:J

    invoke-virtual {p0, v0, v1}, Lcom/glu/platform/android/GluMovieActivity;->OnMovieComplete(J)V

    invoke-virtual {p0}, Lcom/glu/platform/android/GluMovieActivity;->finish()V

    return-void
.end method

.method private setDataSource()Z
    .locals 5

    const/4 v0, 0x1

    const/4 v1, 0x0

    const-string v2, "apk:"

    const-string v3, "data:"

    iget-object v4, p0, Lcom/glu/platform/android/GluMovieActivity;->m_ExtraMovieFilename:Ljava/lang/String;

    invoke-virtual {v4, v2}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_1

    iget-object v3, p0, Lcom/glu/platform/android/GluMovieActivity;->m_ExtraMovieFilename:Ljava/lang/String;

    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v2

    invoke-virtual {v3, v2}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v2

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v4, p0, Lcom/glu/platform/android/GluMovieActivity;->m_ExtraMovieExternalPath:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    new-instance v4, Ljava/io/File;

    invoke-direct {v4, v3}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v4}, Ljava/io/File;->canRead()Z

    move-result v4

    if-eqz v4, :cond_0

    :try_start_0
    iget-object v2, p0, Lcom/glu/platform/android/GluMovieActivity;->m_Player:Landroid/media/MediaPlayer;

    invoke-virtual {v2, v3}, Landroid/media/MediaPlayer;->setDataSource(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return v0

    :catch_0
    move-exception v0

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Application IOException: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move v0, v1

    goto :goto_0

    :cond_0
    invoke-virtual {p0}, Lcom/glu/platform/android/GluMovieActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v3

    invoke-virtual {v3}, Landroid/content/res/Resources;->getAssets()Landroid/content/res/AssetManager;

    :try_start_1
    invoke-static {v2}, Lcom/glu/platform/android/GluUtil;->findMediaResourceFile(Ljava/lang/String;)Ljava/io/File;

    move-result-object v2

    new-instance v3, Ljava/io/FileInputStream;

    invoke-direct {v3, v2}, Ljava/io/FileInputStream;-><init>(Ljava/io/File;)V

    iget-object v2, p0, Lcom/glu/platform/android/GluMovieActivity;->m_Player:Landroid/media/MediaPlayer;

    invoke-virtual {v3}, Ljava/io/FileInputStream;->getFD()Ljava/io/FileDescriptor;

    move-result-object v3

    invoke-virtual {v2, v3}, Landroid/media/MediaPlayer;->setDataSource(Ljava/io/FileDescriptor;)V
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_1

    goto :goto_0

    :catch_1
    move-exception v0

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "APK IOException: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move v0, v1

    goto :goto_0

    :cond_1
    iget-object v2, p0, Lcom/glu/platform/android/GluMovieActivity;->m_ExtraMovieFilename:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_2

    iget-object v2, p0, Lcom/glu/platform/android/GluMovieActivity;->m_ExtraMovieFilename:Ljava/lang/String;

    invoke-virtual {v3}, Ljava/lang/String;->length()I

    move-result v3

    invoke-virtual {v2, v3}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v2

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v4, p0, Lcom/glu/platform/android/GluMovieActivity;->m_ExtraMovieInternalPath:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    :goto_1
    :try_start_2
    iget-object v3, p0, Lcom/glu/platform/android/GluMovieActivity;->m_Player:Landroid/media/MediaPlayer;

    invoke-virtual {v3, v2}, Landroid/media/MediaPlayer;->setDataSource(Ljava/lang/String;)V
    :try_end_2
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_2

    goto :goto_0

    :catch_2
    move-exception v0

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Data IOException: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move v0, v1

    goto/16 :goto_0

    :cond_2
    iget-object v2, p0, Lcom/glu/platform/android/GluMovieActivity;->m_ExtraMovieFilename:Ljava/lang/String;

    sget-object v3, Ljava/io/File;->separator:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_3

    iget-object v2, p0, Lcom/glu/platform/android/GluMovieActivity;->m_ExtraMovieFilename:Ljava/lang/String;

    goto :goto_1

    :cond_3
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v3, p0, Lcom/glu/platform/android/GluMovieActivity;->m_ExtraMovieExternalPath:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, p0, Lcom/glu/platform/android/GluMovieActivity;->m_ExtraMovieFilename:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    goto :goto_1
.end method

.method private tryPlayback()V
    .locals 3

    iget-boolean v0, p0, Lcom/glu/platform/android/GluMovieActivity;->m_IsPrepared:Z

    if-eqz v0, :cond_0

    iget-boolean v0, p0, Lcom/glu/platform/android/GluMovieActivity;->m_IsVideoSizeKnown:Z

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/glu/platform/android/GluMovieActivity;->m_Holder:Landroid/view/SurfaceHolder;

    iget v1, p0, Lcom/glu/platform/android/GluMovieActivity;->m_Width:I

    iget v2, p0, Lcom/glu/platform/android/GluMovieActivity;->m_Height:I

    invoke-interface {v0, v1, v2}, Landroid/view/SurfaceHolder;->setFixedSize(II)V

    invoke-direct {p0}, Lcom/glu/platform/android/GluMovieActivity;->finishMovieActivity()V

    :cond_0
    return-void
.end method


# virtual methods
.method public native OnMovieComplete(J)V
.end method

.method public onBackPressed()V
    .locals 0

    invoke-direct {p0}, Lcom/glu/platform/android/GluMovieActivity;->finishMovieActivity()V

    return-void
.end method

.method public onCompletion(Landroid/media/MediaPlayer;)V
    .locals 0

    invoke-direct {p0}, Lcom/glu/platform/android/GluMovieActivity;->finishMovieActivity()V

    return-void
.end method

.method public onCreate(Landroid/os/Bundle;)V
    .locals 4

    const/16 v1, 0x400

    invoke-super {p0, p1}, Landroid/app/Activity;->onCreate(Landroid/os/Bundle;)V

    const/4 v0, 0x1

    invoke-virtual {p0, v0}, Lcom/glu/platform/android/GluMovieActivity;->requestWindowFeature(I)Z

    invoke-virtual {p0}, Lcom/glu/platform/android/GluMovieActivity;->getWindow()Landroid/view/Window;

    move-result-object v0

    invoke-virtual {v0, v1, v1}, Landroid/view/Window;->setFlags(II)V

    new-instance v0, Landroid/widget/FrameLayout;

    invoke-direct {v0, p0}, Landroid/widget/FrameLayout;-><init>(Landroid/content/Context;)V

    new-instance v1, Landroid/view/SurfaceView;

    invoke-direct {v1, p0}, Landroid/view/SurfaceView;-><init>(Landroid/content/Context;)V

    iput-object v1, p0, Lcom/glu/platform/android/GluMovieActivity;->m_Preview:Landroid/view/SurfaceView;

    iget-object v1, p0, Lcom/glu/platform/android/GluMovieActivity;->m_Preview:Landroid/view/SurfaceView;

    invoke-virtual {v0, v1}, Landroid/widget/FrameLayout;->addView(Landroid/view/View;)V

    iget-object v1, p0, Lcom/glu/platform/android/GluMovieActivity;->m_Preview:Landroid/view/SurfaceView;

    invoke-virtual {v1}, Landroid/view/SurfaceView;->getHolder()Landroid/view/SurfaceHolder;

    move-result-object v1

    iput-object v1, p0, Lcom/glu/platform/android/GluMovieActivity;->m_Holder:Landroid/view/SurfaceHolder;

    iget-object v1, p0, Lcom/glu/platform/android/GluMovieActivity;->m_Holder:Landroid/view/SurfaceHolder;

    invoke-interface {v1, p0}, Landroid/view/SurfaceHolder;->addCallback(Landroid/view/SurfaceHolder$Callback;)V

    iget-object v1, p0, Lcom/glu/platform/android/GluMovieActivity;->m_Holder:Landroid/view/SurfaceHolder;

    const/4 v2, 0x3

    invoke-interface {v1, v2}, Landroid/view/SurfaceHolder;->setType(I)V

    invoke-virtual {p0, v0}, Lcom/glu/platform/android/GluMovieActivity;->setContentView(Landroid/view/View;)V

    invoke-virtual {p0}, Lcom/glu/platform/android/GluMovieActivity;->getIntent()Landroid/content/Intent;

    move-result-object v0

    const-string v1, "com.glu.platform.android.Event"

    const-wide/16 v2, 0x0

    invoke-virtual {v0, v1, v2, v3}, Landroid/content/Intent;->getLongExtra(Ljava/lang/String;J)J

    move-result-wide v0

    iput-wide v0, p0, Lcom/glu/platform/android/GluMovieActivity;->m_ExtraMovieEvent:J

    invoke-virtual {p0}, Lcom/glu/platform/android/GluMovieActivity;->getIntent()Landroid/content/Intent;

    move-result-object v0

    const-string v1, "com.glu.platform.android.Filename"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/glu/platform/android/GluMovieActivity;->m_ExtraMovieFilename:Ljava/lang/String;

    invoke-virtual {p0}, Lcom/glu/platform/android/GluMovieActivity;->getIntent()Landroid/content/Intent;

    move-result-object v0

    const-string v1, "com.glu.platform.android.InternalPath"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/glu/platform/android/GluMovieActivity;->m_ExtraMovieInternalPath:Ljava/lang/String;

    invoke-virtual {p0}, Lcom/glu/platform/android/GluMovieActivity;->getIntent()Landroid/content/Intent;

    move-result-object v0

    const-string v1, "com.glu.platform.android.ExternalPath"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/glu/platform/android/GluMovieActivity;->m_ExtraMovieExternalPath:Ljava/lang/String;

    return-void
.end method

.method protected onDestroy()V
    .locals 1

    invoke-super {p0}, Landroid/app/Activity;->onDestroy()V

    iget-object v0, p0, Lcom/glu/platform/android/GluMovieActivity;->m_Player:Landroid/media/MediaPlayer;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/glu/platform/android/GluMovieActivity;->m_Player:Landroid/media/MediaPlayer;

    invoke-virtual {v0}, Landroid/media/MediaPlayer;->release()V

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/glu/platform/android/GluMovieActivity;->m_Player:Landroid/media/MediaPlayer;

    :cond_0
    invoke-direct {p0}, Lcom/glu/platform/android/GluMovieActivity;->doCleanUp()V

    return-void
.end method

.method public onInfo(Landroid/media/MediaPlayer;II)Z
    .locals 2

    sparse-switch p2, :sswitch_data_0

    const-string v0, "Other"

    :goto_0
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ": "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    const/4 v0, 0x0

    return v0

    :sswitch_0
    const-string v0, "Unknown"

    goto :goto_0

    :sswitch_1
    const-string v0, "VideoTrack Lagging"

    goto :goto_0

    :sswitch_2
    const-string v0, "Bad Interleaving"

    goto :goto_0

    :sswitch_3
    const-string v0, "Not Seekable"

    goto :goto_0

    :sswitch_4
    const-string v0, "Metadata Update"

    goto :goto_0

    :sswitch_data_0
    .sparse-switch
        0x1 -> :sswitch_0
        0x2bc -> :sswitch_1
        0x320 -> :sswitch_2
        0x321 -> :sswitch_3
        0x322 -> :sswitch_4
    .end sparse-switch
.end method

.method protected onPause()V
    .locals 1

    iget-object v0, p0, Lcom/glu/platform/android/GluMovieActivity;->m_WakeLock:Landroid/os/PowerManager$WakeLock;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/glu/platform/android/GluMovieActivity;->m_WakeLock:Landroid/os/PowerManager$WakeLock;

    invoke-virtual {v0}, Landroid/os/PowerManager$WakeLock;->release()V

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/glu/platform/android/GluMovieActivity;->m_WakeLock:Landroid/os/PowerManager$WakeLock;

    :cond_0
    iget-object v0, p0, Lcom/glu/platform/android/GluMovieActivity;->m_Player:Landroid/media/MediaPlayer;

    invoke-virtual {v0}, Landroid/media/MediaPlayer;->stop()V

    invoke-direct {p0}, Lcom/glu/platform/android/GluMovieActivity;->finishMovieActivity()V

    invoke-super {p0}, Landroid/app/Activity;->onPause()V

    return-void
.end method

.method public onPrepared(Landroid/media/MediaPlayer;)V
    .locals 1

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/glu/platform/android/GluMovieActivity;->m_IsPrepared:Z

    invoke-direct {p0}, Lcom/glu/platform/android/GluMovieActivity;->tryPlayback()V

    return-void
.end method

.method protected onResume()V
    .locals 3

    invoke-super {p0}, Landroid/app/Activity;->onResume()V

    const-string v0, "power"

    invoke-virtual {p0, v0}, Lcom/glu/platform/android/GluMovieActivity;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/os/PowerManager;

    if-eqz v0, :cond_0

    const v1, 0x2000000a

    const-string v2, "AndroidMovieActivity"

    invoke-virtual {v0, v1, v2}, Landroid/os/PowerManager;->newWakeLock(ILjava/lang/String;)Landroid/os/PowerManager$WakeLock;

    move-result-object v0

    iput-object v0, p0, Lcom/glu/platform/android/GluMovieActivity;->m_WakeLock:Landroid/os/PowerManager$WakeLock;

    iget-object v0, p0, Lcom/glu/platform/android/GluMovieActivity;->m_WakeLock:Landroid/os/PowerManager$WakeLock;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/glu/platform/android/GluMovieActivity;->m_WakeLock:Landroid/os/PowerManager$WakeLock;

    invoke-virtual {v0}, Landroid/os/PowerManager$WakeLock;->acquire()V

    :cond_0
    return-void
.end method

.method public onTouchEvent(Landroid/view/MotionEvent;)Z
    .locals 3

    const/4 v0, 0x1

    const/4 v1, 0x0

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getAction()I

    move-result v2

    packed-switch v2, :pswitch_data_0

    move v0, v1

    :cond_0
    :goto_0
    return v0

    :pswitch_0
    iput-boolean v0, p0, Lcom/glu/platform/android/GluMovieActivity;->m_TouchDownReceived:Z

    goto :goto_0

    :pswitch_1
    iget-boolean v2, p0, Lcom/glu/platform/android/GluMovieActivity;->m_TouchDownReceived:Z

    if-eqz v2, :cond_0

    iput-boolean v1, p0, Lcom/glu/platform/android/GluMovieActivity;->m_TouchDownReceived:Z

    invoke-direct {p0}, Lcom/glu/platform/android/GluMovieActivity;->finishMovieActivity()V

    goto :goto_0

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_0
        :pswitch_1
    .end packed-switch
.end method

.method public onVideoSizeChanged(Landroid/media/MediaPlayer;II)V
    .locals 2

    if-lez p2, :cond_0

    if-lez p3, :cond_0

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/glu/platform/android/GluMovieActivity;->m_IsVideoSizeKnown:Z

    iput p2, p0, Lcom/glu/platform/android/GluMovieActivity;->m_Width:I

    iput p3, p0, Lcom/glu/platform/android/GluMovieActivity;->m_Height:I

    invoke-direct {p0}, Lcom/glu/platform/android/GluMovieActivity;->tryPlayback()V

    :goto_0
    return-void

    :cond_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Invalid vide size - width: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", height: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    goto :goto_0
.end method

.method public surfaceChanged(Landroid/view/SurfaceHolder;III)V
    .locals 0

    return-void
.end method

.method public surfaceCreated(Landroid/view/SurfaceHolder;)V
    .locals 2

    sget-boolean v0, Lcom/glu/platform/android/GluMovieActivity;->$assertionsDisabled:Z

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/glu/platform/android/GluMovieActivity;->m_Path:Ljava/lang/String;

    if-nez v0, :cond_0

    new-instance v0, Ljava/lang/AssertionError;

    invoke-direct {v0}, Ljava/lang/AssertionError;-><init>()V

    throw v0

    :cond_0
    invoke-direct {p0}, Lcom/glu/platform/android/GluMovieActivity;->doCleanUp()V

    new-instance v0, Landroid/media/MediaPlayer;

    invoke-direct {v0}, Landroid/media/MediaPlayer;-><init>()V

    iput-object v0, p0, Lcom/glu/platform/android/GluMovieActivity;->m_Player:Landroid/media/MediaPlayer;

    invoke-direct {p0}, Lcom/glu/platform/android/GluMovieActivity;->setDataSource()Z

    move-result v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/glu/platform/android/GluMovieActivity;->m_Player:Landroid/media/MediaPlayer;

    iget-object v1, p0, Lcom/glu/platform/android/GluMovieActivity;->m_Holder:Landroid/view/SurfaceHolder;

    invoke-virtual {v0, v1}, Landroid/media/MediaPlayer;->setDisplay(Landroid/view/SurfaceHolder;)V

    iget-object v0, p0, Lcom/glu/platform/android/GluMovieActivity;->m_Player:Landroid/media/MediaPlayer;

    invoke-virtual {v0}, Landroid/media/MediaPlayer;->prepareAsync()V

    iget-object v0, p0, Lcom/glu/platform/android/GluMovieActivity;->m_Player:Landroid/media/MediaPlayer;

    invoke-virtual {v0, p0}, Landroid/media/MediaPlayer;->setOnCompletionListener(Landroid/media/MediaPlayer$OnCompletionListener;)V

    iget-object v0, p0, Lcom/glu/platform/android/GluMovieActivity;->m_Player:Landroid/media/MediaPlayer;

    invoke-virtual {v0, p0}, Landroid/media/MediaPlayer;->setOnPreparedListener(Landroid/media/MediaPlayer$OnPreparedListener;)V

    iget-object v0, p0, Lcom/glu/platform/android/GluMovieActivity;->m_Player:Landroid/media/MediaPlayer;

    invoke-virtual {v0, p0}, Landroid/media/MediaPlayer;->setOnVideoSizeChangedListener(Landroid/media/MediaPlayer$OnVideoSizeChangedListener;)V

    iget-object v0, p0, Lcom/glu/platform/android/GluMovieActivity;->m_Player:Landroid/media/MediaPlayer;

    const/4 v1, 0x3

    invoke-virtual {v0, v1}, Landroid/media/MediaPlayer;->setAudioStreamType(I)V

    :cond_1
    return-void
.end method

.method public surfaceDestroyed(Landroid/view/SurfaceHolder;)V
    .locals 0

    return-void
.end method
