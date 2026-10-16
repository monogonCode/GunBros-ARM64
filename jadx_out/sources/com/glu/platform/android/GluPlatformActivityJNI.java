package com.glu.platform.android;

import android.content.Context;
import android.os.Handler;
import android.view.SurfaceHolder;

/* JADX INFO: loaded from: classes.dex */
class GluPlatformActivityJNI {
    private int ID;
    private int nextID;

    static {
        System.loadLibrary("androidplatformjni");
    }

    GluPlatformActivityJNI() {
        this.nextID = 0;
        this.ID = 0;
        int i = this.nextID + 1;
        this.nextID = i;
        this.ID = i;
    }

    public native void LocalEvent(int i, String str, String str2);

    public native void MouseButtonDown(int i, int i2, int i3);

    public native void MouseButtonUp(int i, int i2, int i3);

    public native void MouseMove(int i, int i2, int i3);

    public native void SoundEventCompleted(int i, long j);

    public native void TouchBegan(int i, int i2, int i3, int i4);

    public native void TouchCancelled(int i, int i2, int i3, int i4);

    public native void TouchEnded(int i, int i2, int i3, int i4);

    public native void TouchMoved(int i, int i2, int i3, int i4);

    public native void feedPCMMediaPlayer(int i, byte[] bArr, int i2);

    public native void initialise(Context context, Handler handler, String str, String str2, String str3, String str4, String str5, String str6, boolean z, boolean z2, boolean z3, String str7, String str8, String str9, String str10, int i, int i2, int i3, int i4, String str11);

    public native void javaToNativeFacebook(int i, int i2, int i3, byte[] bArr, char[][] cArr);

    public native int onCreate(byte[] bArr, GluCallback gluCallback);

    public native void onDestroy(int i);

    public native void onDrawFrame(int i, long j, boolean z);

    public native boolean onKeyDown(int i, int i2);

    public native boolean onKeyUp(int i, int i2);

    public native void onLowMemory(int i);

    public native void onOrientationChanged(int i);

    public native void onPause(int i);

    public native void onRestart(int i);

    public native void onResume(int i);

    public native void onStart(int i);

    public native void onStop(int i);

    public native void onSurfaceChanged(int i, int i2, int i3);

    public native void onSurfaceCreated(int i);

    public native void pushAccelerometerValues(int i, float f, float f2, float f3);

    public native void setUseBeam(int i, boolean z);

    public native void setWindow(SurfaceHolder surfaceHolder);

    public native void surfaceChanged(int i, int i2, int i3, int i4);

    public native void surfaceCreated(int i);

    public native void surfaceDestroyed(int i);

    public native void tidy(int i);

    public native void uninitialise();
}
