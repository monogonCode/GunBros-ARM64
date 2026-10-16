package com.glu.platform.android;

import android.content.res.AssetFileDescriptor;
import android.media.MediaPlayer;
import javax.microedition.khronos.egl.EGL10;

/* JADX INFO: loaded from: classes.dex */
interface GluCallback {
    boolean APKExistsDir(String str);

    void AddLocalNotification(long j, long j2, String str, String str2);

    void CancelAllLocalNotifications();

    EGL10 CreateEGL();

    void DestroySoundEngine();

    void DestroyVibrationEngine();

    void EnableMultipleTouch(boolean z);

    void EnablePushNotifications(boolean z);

    boolean EnumInit(String str, boolean z);

    EnumResult EnumNext();

    void FinishApp();

    int GetAndroidMinBufferSize(int i, int i2, int i3);

    long GetDeviceAvailableMemory();

    int GetDeviceOrientation();

    boolean InitialiseSoundEngine(boolean z, int i, int i2, int i3, int i4, int i5);

    MediaPlayer InitialiseSoundEvent(String str, long j);

    boolean InitialiseVibrationEngine();

    boolean IsPSP();

    boolean IsUserOnWiFi();

    boolean LaunchURL(String str, int i);

    AssetFileDescriptor OpenAPKFile(String str);

    boolean PlayVibration(long j);

    void RemoveLocalNotification(String str, String str2);

    void SetAutoRotationValues(long j, long j2, long j3, long j4);

    boolean SetDeviceOrientation(int i);

    void SetTickRate(int i);

    void SetVolume(byte b);

    boolean StartAudioStream();

    boolean StartAutoRotation(long j);

    void StartLocalNotificationService();

    boolean StartMovieActivity(String str, long j);

    void StopAudioStream();

    void StopAutoRotation();

    boolean StopVibration();

    void SystemMessageBox(String str, String str2);

    int mp3Event(int i, int i2, String str);
}
