.class Lcom/glu/platform/android/GluPlatformActivityJNI;
.super Ljava/lang/Object;


# instance fields
.field private ID:I

.field private nextID:I


# direct methods
.method static constructor <clinit>()V
    .locals 1

    const-string v0, "androidplatformjni"

    invoke-static {v0}, Ljava/lang/System;->loadLibrary(Ljava/lang/String;)V

    return-void
.end method

.method constructor <init>()V
    .locals 1

    const/4 v0, 0x0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput v0, p0, Lcom/glu/platform/android/GluPlatformActivityJNI;->nextID:I

    iput v0, p0, Lcom/glu/platform/android/GluPlatformActivityJNI;->ID:I

    iget v0, p0, Lcom/glu/platform/android/GluPlatformActivityJNI;->nextID:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/glu/platform/android/GluPlatformActivityJNI;->nextID:I

    iput v0, p0, Lcom/glu/platform/android/GluPlatformActivityJNI;->ID:I

    return-void
.end method


# virtual methods
.method public native LocalEvent(ILjava/lang/String;Ljava/lang/String;)V
.end method

.method public native MouseButtonDown(III)V
.end method

.method public native MouseButtonUp(III)V
.end method

.method public native MouseMove(III)V
.end method

.method public native SoundEventCompleted(IJ)V
.end method

.method public native TouchBegan(IIII)V
.end method

.method public native TouchCancelled(IIII)V
.end method

.method public native TouchEnded(IIII)V
.end method

.method public native TouchMoved(IIII)V
.end method

.method public native feedPCMMediaPlayer(I[BI)V
.end method

.method public native initialise(Landroid/content/Context;Landroid/os/Handler;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ZZZLjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;IIIILjava/lang/String;)V
.end method

.method public native javaToNativeFacebook(III[B[[C)V
.end method

.method public native onCreate([BLcom/glu/platform/android/GluCallback;)I
.end method

.method public native onDestroy(I)V
.end method

.method public native onDrawFrame(IJZ)V
.end method

.method public native onKeyDown(II)Z
.end method

.method public native onKeyUp(II)Z
.end method

.method public native onLowMemory(I)V
.end method

.method public native onOrientationChanged(I)V
.end method

.method public native onPause(I)V
.end method

.method public native onRestart(I)V
.end method

.method public native onResume(I)V
.end method

.method public native onStart(I)V
.end method

.method public native onStop(I)V
.end method

.method public native onSurfaceChanged(III)V
.end method

.method public native onSurfaceCreated(I)V
.end method

.method public native pushAccelerometerValues(IFFF)V
.end method

.method public native setUseBeam(IZ)V
.end method

.method public native setWindow(Landroid/view/SurfaceHolder;)V
.end method

.method public native surfaceChanged(IIII)V
.end method

.method public native surfaceCreated(I)V
.end method

.method public native surfaceDestroyed(I)V
.end method

.method public native tidy(I)V
.end method

.method public native uninitialise()V
.end method
