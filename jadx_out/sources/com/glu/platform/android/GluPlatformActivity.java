package com.glu.platform.android;

import android.app.Activity;
import android.app.ActivityManager;
import android.app.AlertDialog;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.IntentFilter;
import android.content.pm.ConfigurationInfo;
import android.content.pm.PackageManager;
import android.content.res.AssetFileDescriptor;
import android.content.res.AssetManager;
import android.content.res.Configuration;
import android.hardware.Sensor;
import android.hardware.SensorEvent;
import android.hardware.SensorEventListener;
import android.hardware.SensorManager;
import android.media.AudioManager;
import android.media.AudioTrack;
import android.media.MediaPlayer;
import android.net.Uri;
import android.os.Build;
import android.os.Bundle;
import android.os.Debug;
import android.os.Environment;
import android.os.Handler;
import android.os.Message;
import android.os.PowerManager;
import android.os.Process;
import android.os.Vibrator;
import android.provider.Settings;
import android.view.Display;
import android.view.KeyEvent;
import android.view.MotionEvent;
import android.view.OrientationEventListener;
import android.view.SurfaceHolder;
import android.widget.FrameLayout;
import com.glu.android.tools.community.GluOpenFeint;
import com.glu.platform.android.facebook.GluFBConnect;
import com.glu.platform.android.resdl.ResDL;
import com.tapjoy.TapjoyConstants;
import com.urbanairship.analytics.EventDataManager;
import com.urbanairship.push.PushManager;
import java.io.File;
import java.io.IOException;
import java.lang.reflect.Method;
import java.util.Locale;
import javax.microedition.khronos.egl.EGL10;
import javax.microedition.khronos.egl.EGLContext;

/* JADX INFO: loaded from: classes.dex */
public class GluPlatformActivity extends Activity implements SensorEventListener, AudioTrack.OnPlaybackPositionUpdateListener, SurfaceHolder.Callback, GluCallback {
    static final /* synthetic */ boolean $assertionsDisabled;
    public static Method GETPOINTERCOUNT;
    public static Method GETPOINTERID;
    public static Method GETSOURCE;
    public static Method GETX;
    public static Method GETY;
    public static String SPECIAL_URL_FORCE_UPGRADE;
    public static String SPECIAL_URL_MORE_GAMES;
    public static String SPECIAL_URL_RATE_ME;
    public static int activePads;
    public static int activePointers;
    private static boolean initialized;
    public static GluPlatformActivity instance;
    protected static int m_OSVersion;
    public static boolean multitouchReported;
    public static boolean multitouchSupported;
    private static Object[] param;
    public static boolean touchpadSupported;
    private int TOUCH_MOVE_THRESHOLD;
    public int displayHeight;
    private String[] m_Enum;
    private boolean m_EnumDirs;
    private int m_EnumIndex;
    private String m_ExternalPath;
    private String m_InternalPath;
    private boolean m_ListeningToAccelerometer;
    private GluMainView m_MainView;
    private int m_NativeHandle;
    private Intent m_NotificationIntent;
    private long m_Orientation0;
    private long m_Orientation180;
    private long m_Orientation270;
    private long m_Orientation90;
    private byte[] m_PCMBuffer;
    private int m_PCMBufferSizeInBytes;
    private int m_PCMBufferSizeInFrames;
    private AudioTrack m_PCMMediaPlayer;
    private boolean m_SupportsMultiTouch;
    private boolean m_SupportsTouch;
    private boolean m_UsePCMMixing;
    private Vibrator m_Vibrator;
    private PowerManager.WakeLock m_WakeLock;
    private TouchTracker[] m_aTouches;
    private boolean m_bMultiTouchEnabled;
    private int m_cTouches;
    private OrientationEventListener m_oel;
    private Bundle savedInstanceState = null;
    boolean touchPad = false;
    final int EVENT_SPECIAL_URL_RATE_ME = 1;
    final int EVENT_SPECIAL_URL_FORCE_UPGRADE = 2;
    final int EVENT_SPECIAL_URL_MORE_GAMES = 3;
    public Handler m_SMBHandler = new Handler() { // from class: com.glu.platform.android.GluPlatformActivity.3
        @Override // android.os.Handler
        public final void handleMessage(Message message) {
            switch (message.what) {
                case 0:
                    final SystemMessageBoxMessage systemMessageBoxMessage = (SystemMessageBoxMessage) message.obj;
                    AlertDialog.Builder builder = new AlertDialog.Builder(systemMessageBoxMessage.m_Context);
                    builder.setTitle(systemMessageBoxMessage.m_Title);
                    builder.setMessage(systemMessageBoxMessage.m_Text);
                    builder.setCancelable(false);
                    builder.setNeutralButton("OK", new DialogInterface.OnClickListener() { // from class: com.glu.platform.android.GluPlatformActivity.3.1
                        @Override // android.content.DialogInterface.OnClickListener
                        public final void onClick(DialogInterface dialogInterface, int i) {
                            systemMessageBoxMessage.m_Runner.markAsDone();
                        }
                    });
                    builder.show();
                    break;
            }
        }
    };
    private Handler m_Handler = new Handler();
    private GluPlatformActivityJNI m_jni = new GluPlatformActivityJNI();
    private int m_TickRateMS = -1;
    private int m_Orientation = 0;
    private int m_PCMBufferOffset = 0;
    public Handler m_Terminator = new Handler() { // from class: com.glu.platform.android.GluPlatformActivity.4
        static final /* synthetic */ boolean $assertionsDisabled;

        static {
            $assertionsDisabled = !GluPlatformActivity.class.desiredAssertionStatus();
        }

        @Override // android.os.Handler
        public final void handleMessage(Message message) {
            switch (message.what) {
                case 1:
                    GluPlatformActivity.this.finish();
                    return;
                case 2:
                    GluFBConnect.instance.login();
                    return;
                case 3:
                    GluFBConnect.instance.logout();
                    return;
                case 4:
                case 5:
                case 6:
                default:
                    if (!$assertionsDisabled) {
                        throw new AssertionError();
                    }
                    return;
                case 7:
                    GluOpenFeint.instance.initialize();
                    return;
            }
        }
    };
    private boolean[] m_ValidOrientations = new boolean[4];
    private int m_CurrentOrientation = -1;
    private boolean m_bNotificationReceiverRegistered = false;
    private BroadcastReceiver m_NotificationReceiver = new BroadcastReceiver() { // from class: com.glu.platform.android.GluPlatformActivity.5
        @Override // android.content.BroadcastReceiver
        public final void onReceive(Context context, Intent intent) {
            String stringExtra = intent.getStringExtra("com.glu.platform.android.NOTIFICATION_TITLE");
            String stringExtra2 = intent.getStringExtra("com.glu.platform.android.NOTIFICATION_MESSAGE");
            String str = "About to fire notification - title: " + stringExtra + ", message: " + stringExtra2;
            GluPlatformActivity.this.m_jni.LocalEvent(GluPlatformActivity.this.m_NativeHandle, stringExtra, stringExtra2);
        }
    };

    class Runner {
        Runner() {
        }

        final synchronized void markAsDone() {
            notify();
        }

        final synchronized void waitTillDone() {
            try {
                wait();
            } catch (InterruptedException e) {
            }
        }
    }

    private final class SystemMessageBoxMessage {
        final Context m_Context;
        final SystemMessageBoxRunner m_Runner;
        final String m_Text;
        final String m_Title;

        SystemMessageBoxMessage(String str, String str2, Context context, SystemMessageBoxRunner systemMessageBoxRunner) {
            this.m_Title = str;
            this.m_Text = str2;
            this.m_Context = context;
            this.m_Runner = systemMessageBoxRunner;
        }
    }

    class SystemMessageBoxRunner extends Runner implements Runnable {
        String m_Text;
        String m_Title;

        SystemMessageBoxRunner(String str, String str2) {
            super();
            this.m_Title = str;
            this.m_Text = str2;
        }

        @Override // java.lang.Runnable
        public final void run() {
            GluPlatformActivity.this.displaySystemMessageBox(this.m_Title, this.m_Text, this);
            waitTillDone();
        }
    }

    private class TouchTracker {
        public int m_Index;
        public int m_Mode;
        public int m_MoveThreshold;
        public int m_PointerId;
        public int m_X;
        public int m_Y;

        /* synthetic */ TouchTracker(GluPlatformActivity gluPlatformActivity) {
            this((byte) 0);
        }

        private TouchTracker(byte b) {
        }

        public final String toString() {
            String str;
            switch (this.m_Mode) {
                case 1:
                    str = "BEGAN";
                    break;
                case 2:
                    str = "MOVED";
                    break;
                case 3:
                    str = "ENDED";
                    break;
                case 4:
                    str = "CANCELLED";
                    break;
                default:
                    str = "UNKNOWN";
                    break;
            }
            return "pid=" + this.m_PointerId + " x=" + this.m_X + " y=" + this.m_Y + " m=" + str + " t=" + this.m_MoveThreshold;
        }
    }

    static {
        $assertionsDisabled = !GluPlatformActivity.class.desiredAssertionStatus();
        instance = null;
        activePointers = 0;
        activePads = 0;
        multitouchSupported = false;
        multitouchReported = false;
        touchpadSupported = false;
        param = new Integer[1];
        initialized = false;
        m_OSVersion = 0;
    }

    private TouchTracker getTouchTracker(int i) {
        for (int i2 = 0; i2 < this.m_cTouches; i2++) {
            TouchTracker touchTracker = this.m_aTouches[i2];
            if (touchTracker.m_PointerId == i) {
                return touchTracker;
            }
        }
        if (this.m_cTouches >= 10) {
            return null;
        }
        TouchTracker[] touchTrackerArr = this.m_aTouches;
        int i3 = this.m_cTouches;
        this.m_cTouches = i3 + 1;
        TouchTracker touchTracker2 = touchTrackerArr[i3];
        touchTracker2.m_PointerId = i;
        touchTracker2.m_Mode = 0;
        return touchTracker2;
    }

    public static void initializeTouch() {
        if (initialized) {
            return;
        }
        try {
            multitouchReported = ((Boolean) Class.forName("android.content.pm.PackageManager").getMethod("hasSystemFeature", new String().getClass()).invoke(instance.m_MainView.getContext().getPackageManager(), new String("android.hardware.touchscreen.multitouch"))).booleanValue();
        } catch (Throwable th) {
            multitouchReported = false;
        }
        try {
            Class<?> cls = Class.forName("android.view.MotionEvent");
            Class<?>[] clsArr = {Integer.TYPE};
            GETPOINTERCOUNT = cls.getMethod("getPointerCount", null);
            GETPOINTERID = cls.getMethod("getPointerId", clsArr);
            GETX = cls.getMethod("getX", clsArr);
            GETY = cls.getMethod("getY", clsArr);
            multitouchSupported = true;
        } catch (Throwable th2) {
            th2.printStackTrace();
            multitouchSupported = false;
        }
        try {
            GETSOURCE = Class.forName("android.view.InputEvent").getMethod("getSource", null);
            touchpadSupported = true;
        } catch (Throwable th3) {
            touchpadSupported = false;
        }
        if (touchpadSupported) {
            try {
                Class.forName("android.view.ViewRoot").getMethod("setProcessPositionEvents", Boolean.TYPE).invoke(instance.getWindow().getDecorView().getRootView().getParent(), new Boolean(true));
                touchpadSupported = true;
            } catch (Throwable th4) {
                touchpadSupported = false;
            }
        }
        initialized = true;
    }

    private static boolean isVolumeKey(int i) {
        return 25 == i || 24 == i;
    }

    public static int nfcEnabled() {
        return Build.VERSION.SDK_INT;
    }

    public static void onResDLDone() {
        instance.iOnResDLDone();
    }

    private void removeTouchTracker(TouchTracker touchTracker) {
        touchTracker.m_PointerId = -1;
        touchTracker.m_Mode = 0;
        this.m_cTouches--;
        if (touchTracker.m_Index < this.m_cTouches) {
            TouchTracker touchTracker2 = this.m_aTouches[this.m_cTouches];
            this.m_aTouches[touchTracker.m_Index] = touchTracker2;
            touchTracker2.m_Index = touchTracker.m_Index;
            this.m_aTouches[this.m_cTouches] = touchTracker;
            touchTracker.m_Index = this.m_cTouches;
        }
    }

    private void setState(int i) {
        Intent intent = new Intent(this, (Class<?>) GluNotificationService.class);
        intent.setAction("com.glu.platform.android.APP_STATE");
        intent.putExtra("com.glu.platform.andoird.APP_STATE_STATE", i);
        startService(intent);
    }

    private void touchBegan(int i, int i2, int i3) {
        double d;
        double d2;
        double d3;
        if (i < 0) {
            i = 0;
        }
        TouchTracker touchTracker = getTouchTracker(i3);
        if (touchTracker == null || touchTracker.m_Mode == 1 || touchTracker.m_Mode == 2) {
            return;
        }
        touchTracker.m_X = i;
        touchTracker.m_Y = i2;
        touchTracker.m_Mode = 1;
        touchTracker.m_MoveThreshold = this.TOUCH_MOVE_THRESHOLD;
        if (!IsPSP()) {
            this.m_jni.TouchBegan(this.m_NativeHandle, i, i2, i3);
            return;
        }
        double d4 = i;
        double d5 = i2;
        if (this.touchPad) {
            if (d4 < 370.0d) {
                d3 = ((d4 - 180.0d) * 0.4d) + 93.0d;
            } else if (d4 <= 596.0d) {
                return;
            } else {
                d3 = ((d4 - 786.0d) * 0.4d) + 760.0d;
            }
            double d6 = ((d5 - 180.0d) * (-0.4d)) + 385.0d;
            d = d3;
            d2 = d6;
        } else {
            d = d4;
            d2 = d5;
        }
        this.m_jni.TouchBegan(this.m_NativeHandle, (int) d, (int) d2, i3);
    }

    private void touchCancelled(int i, int i2, int i3) {
        TouchTracker touchTracker = getTouchTracker(i3);
        if (touchTracker != null) {
            if (touchTracker.m_Mode == 1 || touchTracker.m_Mode == 2) {
                touchTracker.m_X = i;
                touchTracker.m_Y = i2;
                touchTracker.m_Mode = 4;
                this.m_jni.TouchCancelled(this.m_NativeHandle, i, i2, i3);
                removeTouchTracker(touchTracker);
            }
        }
    }

    private void touchEnded(int i, int i2, int i3) {
        double d;
        double d2;
        if (i < 0) {
            i = 0;
        }
        TouchTracker touchTracker = getTouchTracker(i3);
        if (touchTracker != null) {
            if (touchTracker.m_Mode == 1 || touchTracker.m_Mode == 2) {
                touchTracker.m_X = i;
                touchTracker.m_Y = i2;
                touchTracker.m_Mode = 3;
                if (IsPSP()) {
                    double d3 = i;
                    double d4 = i2;
                    if (this.touchPad) {
                        double d5 = ((d4 - 180.0d) * (-0.4d)) + 385.0d;
                        d = d3 < 483.0d ? ((d3 - 180.0d) * 0.4d) + 93.0d : ((d3 - 786.0d) * 0.4d) + 760.0d;
                        d2 = d5;
                    } else {
                        d = d3;
                        d2 = d4;
                    }
                    this.m_jni.TouchEnded(this.m_NativeHandle, (int) d, (int) d2, i3);
                } else {
                    this.m_jni.TouchEnded(this.m_NativeHandle, i, i2, i3);
                }
                removeTouchTracker(touchTracker);
            }
        }
    }

    private void touchMoved(int i, int i2, int i3) {
        double d;
        double d2;
        double d3;
        if (i < 0) {
            i = 0;
        }
        TouchTracker touchTracker = getTouchTracker(i3);
        if (touchTracker != null) {
            if (touchTracker.m_Mode == 1 || touchTracker.m_Mode == 2) {
                int i4 = touchTracker.m_X - i;
                int i5 = touchTracker.m_Y - i2;
                if (i4 < 0) {
                    i4 = -i4;
                }
                if (i5 < 0) {
                    i5 = -i5;
                }
                if (i4 >= touchTracker.m_MoveThreshold || i5 >= touchTracker.m_MoveThreshold) {
                    touchTracker.m_X = i;
                    touchTracker.m_Y = i2;
                    touchTracker.m_Mode = 2;
                    touchTracker.m_MoveThreshold = 1;
                    if (!IsPSP()) {
                        this.m_jni.TouchMoved(this.m_NativeHandle, i, i2, i3);
                        return;
                    }
                    double d4 = i;
                    double d5 = i2;
                    if (this.touchPad) {
                        if (d4 < 370.0d) {
                            d3 = ((d4 - 180.0d) * 0.4d) + 93.0d;
                        } else if (d4 <= 596.0d) {
                            return;
                        } else {
                            d3 = ((d4 - 786.0d) * 0.4d) + 760.0d;
                        }
                        double d6 = ((d5 - 180.0d) * (-0.4d)) + 385.0d;
                        d = d3;
                        d2 = d6;
                    } else {
                        d = d4;
                        d2 = d5;
                    }
                    this.m_jni.TouchMoved(this.m_NativeHandle, (int) d, (int) d2, this.touchPad ? 1 : 0);
                }
            }
        }
    }

    private int translateKeyCode(int i, KeyEvent keyEvent) {
        if (i >= 7 && i <= 16) {
            return (i + 48) - 7;
        }
        if (i >= 29 && i <= 54) {
            return (keyEvent.isShiftPressed() ? 65 : 97) + (i - 29);
        }
        switch (i) {
            case 4:
                return 12;
            case 5:
                return 2;
            case 6:
            case GluFBConnect.FACEBOOK_EVENT_QUEUE_FRIEND_TEXT_FOR_LINK /* 17 */:
                return 42;
            case GluFBConnect.FACEBOOK_EVENT_QUEUE_FRIEND_IMAGE_URL /* 18 */:
                return 35;
            case GluFBConnect.FACEBOOK_EVENT_SUBMIT_QUEUED_FRIEND_FEED /* 19 */:
                return 4;
            case GluFBConnect.FACEBOOK_EVENT_REQUEST_FRIEND_NAME_FROM_UID /* 20 */:
                return 5;
            case GluFBConnect.FACEBOOK_EVENT_SET_NEXT_FRIEND_REQUEST_SIZE /* 21 */:
                return 6;
            case GluFBConnect.FACEBOOK_EVENT_SET_SECRET_ID /* 22 */:
                return 7;
            case GluFBConnect.FACEBOOK_EVENT_QUEUE_FEED_CAPTION /* 23 */:
                return 11;
            case GluFBConnect.FACEBOOK_EVENT_QUEUE_FRIEND_CAPTION /* 24 */:
                return 17;
            case GluFBConnect.FACEBOOK_EVENT_SET_OK_TO_LOGIN_TO_FACEBOOK /* 25 */:
                return 18;
            case 26:
                return 1;
            case 55:
                return 44;
            case 56:
                return 46;
            case 61:
                return 9;
            case 62:
                return 32;
            case 66:
                return 19;
            case 67:
                return 8;
            case 68:
                return 96;
            case 69:
                return 45;
            case 70:
                return 61;
            case 71:
                return 91;
            case 72:
                return 93;
            case 73:
                return 92;
            case 74:
                return 59;
            case 75:
                return 39;
            case 76:
                return 47;
            case 77:
                return 64;
            case 81:
                return 43;
            case 82:
                return 140;
            default:
                return IsPSP() ? i + 268435456 : i;
        }
    }

    @Override // com.glu.platform.android.GluCallback
    public boolean APKExistsDir(String str) {
        try {
            return getResources().getAssets().list(str) != null;
        } catch (IOException e) {
            return false;
        }
    }

    @Override // com.glu.platform.android.GluCallback
    public void AddLocalNotification(long j, long j2, String str, String str2) {
        Intent intent = new Intent(this, (Class<?>) GluNotificationService.class);
        intent.setAction("com.glu.platform.android.ADD_NOTIFICATION");
        intent.putExtra("com.glu.platform.android.NOTIFICATION_WHEN", (int) j);
        intent.putExtra("com.glu.platform.android.NOTIFICATION_TITLE", str);
        intent.putExtra("com.glu.platform.android.NOTIFICATION_MESSAGE", str2);
        intent.putExtra("com.glu.platform.android.NOTIFICATION_BADGE", (int) j2);
        startService(intent);
    }

    @Override // com.glu.platform.android.GluCallback
    public void CancelAllLocalNotifications() {
        Intent intent = new Intent(this, (Class<?>) GluNotificationService.class);
        intent.setAction("com.glu.platform.android.REMOVE_ALL_NOTIFICATIONS");
        startService(intent);
    }

    @Override // com.glu.platform.android.GluCallback
    public EGL10 CreateEGL() {
        return (EGL10) EGLContext.getEGL();
    }

    @Override // com.glu.platform.android.GluCallback
    public synchronized void DestroySoundEngine() {
        if (this.m_UsePCMMixing) {
            if (this.m_PCMMediaPlayer != null) {
                this.m_PCMMediaPlayer.setPlaybackPositionUpdateListener(null);
                this.m_PCMMediaPlayer.stop();
                this.m_PCMMediaPlayer.release();
                this.m_PCMMediaPlayer = null;
                this.m_PCMBuffer = null;
                this.m_PCMBufferSizeInBytes = 0;
                this.m_PCMBufferOffset = 0;
            }
            if (!$assertionsDisabled && this.m_PCMMediaPlayer != null) {
                throw new AssertionError();
            }
            if (!$assertionsDisabled && this.m_PCMBuffer != null) {
                throw new AssertionError();
            }
        }
    }

    @Override // com.glu.platform.android.GluCallback
    public void DestroyVibrationEngine() {
        if (this.m_Vibrator != null) {
            this.m_Vibrator.cancel();
            this.m_Vibrator = null;
        }
    }

    @Override // com.glu.platform.android.GluCallback
    public void EnableMultipleTouch(boolean z) {
        String str = "enable: " + z;
        this.m_bMultiTouchEnabled = z;
    }

    @Override // com.glu.platform.android.GluCallback
    public void EnablePushNotifications(boolean z) {
        Intent intent = new Intent(this, (Class<?>) GluNotificationService.class);
        intent.setAction("com.glu.platform.android.ENABLE_PUSH_NOTIFICATIONS");
        intent.putExtra("com.glu.platform.android.ENABLE_NOTIFICATIONS_ENABLE", z);
        startService(intent);
    }

    @Override // com.glu.platform.android.GluCallback
    public boolean EnumInit(String str, boolean z) {
        AssetManager assets = getResources().getAssets();
        this.m_Enum = null;
        this.m_EnumIndex = 0;
        this.m_EnumDirs = z;
        try {
            this.m_Enum = assets.list(str);
            try {
                for (String str2 : this.m_Enum) {
                    try {
                        assets.open(str2);
                    } catch (IOException e) {
                    }
                }
                return true;
            } catch (IOException e2) {
                return true;
            }
        } catch (IOException e3) {
            return false;
        }
    }

    @Override // com.glu.platform.android.GluCallback
    public EnumResult EnumNext() {
        if (this.m_Enum == null) {
            return null;
        }
        while (this.m_EnumIndex < this.m_Enum.length) {
            AssetManager assets = getResources().getAssets();
            String[] strArr = this.m_Enum;
            int i = this.m_EnumIndex;
            this.m_EnumIndex = i + 1;
            String str = strArr[i];
            long length = 0;
            boolean z = true;
            try {
                length = assets.openFd(str).getLength();
            } catch (IOException e) {
                z = false;
            }
            if ((z && !this.m_EnumDirs) || (!z && this.m_EnumDirs)) {
                EnumResult enumResult = new EnumResult();
                enumResult.m_Filename = str;
                enumResult.m_Length = length;
                return enumResult;
            }
        }
        return null;
    }

    @Override // com.glu.platform.android.GluCallback
    public void FinishApp() {
        this.m_Terminator.sendEmptyMessage(1);
    }

    @Override // com.glu.platform.android.GluCallback
    public int GetAndroidMinBufferSize(int i, int i2, int i3) {
        int minBufferSize = AudioTrack.getMinBufferSize(i, 1 == i2 ? 4 : 12, 8 == i3 ? 3 : 2);
        if (-1 == minBufferSize) {
            return 0;
        }
        return minBufferSize;
    }

    @Override // com.glu.platform.android.GluCallback
    public long GetDeviceAvailableMemory() {
        return Debug.getNativeHeapFreeSize();
    }

    @Override // com.glu.platform.android.GluCallback
    public int GetDeviceOrientation() {
        return getRequestedOrientation();
    }

    public int GetTickRate() {
        return this.m_TickRateMS;
    }

    public void HandlePushNotifications() {
        Intent intent = new Intent(this, (Class<?>) GluNotificationService.class);
        intent.setAction("com.glu.platform.android.HANDLE_PUSH_NOTIFICATIONS");
        startService(intent);
    }

    @Override // com.glu.platform.android.GluCallback
    public boolean InitialiseSoundEngine(boolean z, int i, int i2, int i3, int i4, int i5) {
        this.m_UsePCMMixing = z;
        if (!z) {
            return true;
        }
        if (!$assertionsDisabled && this.m_PCMMediaPlayer != null) {
            throw new AssertionError();
        }
        int i6 = 2 == i2 ? 12 : 4;
        int i7 = 8 == i3 ? 3 : 2;
        if (!$assertionsDisabled && i <= 0) {
            throw new AssertionError();
        }
        if (!$assertionsDisabled && 1 != i2 && 2 != i2) {
            throw new AssertionError();
        }
        if (!$assertionsDisabled && 8 != i3 && 16 != i3) {
            throw new AssertionError();
        }
        if (!$assertionsDisabled && i4 <= 0) {
            throw new AssertionError();
        }
        if (!$assertionsDisabled && i5 <= 0) {
            throw new AssertionError();
        }
        this.m_PCMMediaPlayer = new AudioTrack(3, i, i6, i7, i4, 1);
        if (this.m_PCMMediaPlayer == null) {
            return false;
        }
        this.m_PCMMediaPlayer.setPlaybackPositionUpdateListener(this);
        this.m_PCMMediaPlayer.setPositionNotificationPeriod(i5);
        this.m_PCMBuffer = new byte[i4];
        this.m_PCMBufferSizeInBytes = i4;
        this.m_PCMBufferSizeInFrames = i5;
        this.m_PCMBufferOffset = 0;
        this.m_PCMMediaPlayer.write(this.m_PCMBuffer, 0, i4);
        return true;
    }

    @Override // com.glu.platform.android.GluCallback
    public MediaPlayer InitialiseSoundEvent(String str, final long j) throws Throwable {
        MediaPlayer mediaPlayer;
        MediaPlayer mediaPlayer2 = null;
        try {
            try {
                mediaPlayer2 = new MediaPlayer();
                try {
                    mediaPlayer2.setDataSource(str);
                    mediaPlayer2.setOnCompletionListener(new MediaPlayer.OnCompletionListener() { // from class: com.glu.platform.android.GluPlatformActivity.1
                        @Override // android.media.MediaPlayer.OnCompletionListener
                        public final void onCompletion(MediaPlayer mediaPlayer3) {
                            GluPlatformActivity.this.m_jni.SoundEventCompleted(GluPlatformActivity.this.m_NativeHandle, j);
                        }
                    });
                    mediaPlayer2.prepare();
                } catch (IOException e) {
                    mediaPlayer = mediaPlayer2;
                    e = e;
                    String str2 = "IOException: " + e;
                    if (mediaPlayer != null) {
                        mediaPlayer.release();
                    }
                } catch (IllegalArgumentException e2) {
                    mediaPlayer = mediaPlayer2;
                    e = e2;
                    String str3 = "IllegalArgumentException: " + e;
                    if (mediaPlayer != null) {
                        mediaPlayer.release();
                    }
                } catch (IllegalStateException e3) {
                    mediaPlayer = mediaPlayer2;
                    e = e3;
                    String str4 = "IllegalStateException: " + e;
                    if (mediaPlayer != null) {
                        mediaPlayer.release();
                    }
                } catch (Throwable th) {
                    mediaPlayer = mediaPlayer2;
                    th = th;
                    if (mediaPlayer != null) {
                        mediaPlayer.release();
                    }
                    throw th;
                }
            } catch (Throwable th2) {
                th = th2;
            }
        } catch (IOException e4) {
            e = e4;
            mediaPlayer = null;
        } catch (IllegalArgumentException e5) {
            e = e5;
            mediaPlayer = null;
        } catch (IllegalStateException e6) {
            e = e6;
            mediaPlayer = null;
        } catch (Throwable th3) {
            th = th3;
            mediaPlayer = null;
        }
        return mediaPlayer2;
    }

    @Override // com.glu.platform.android.GluCallback
    public boolean InitialiseVibrationEngine() {
        if (!$assertionsDisabled && this.m_Vibrator != null) {
            throw new AssertionError();
        }
        this.m_Vibrator = (Vibrator) getSystemService("vibrator");
        return this.m_Vibrator != null;
    }

    @Override // com.glu.platform.android.GluCallback
    public boolean IsPSP() {
        return Build.MANUFACTURER.equals("Sony Ericsson") && Build.DEVICE.startsWith("R800");
    }

    @Override // com.glu.platform.android.GluCallback
    public boolean IsUserOnWiFi() {
        return com.glu.platform.android.resdl.GluUtil.isUserOnWiFi();
    }

    public boolean LaunchURL(String str) {
        Intent intent = new Intent("android.intent.action.VIEW", Uri.parse(str));
        intent.setFlags(268435456);
        startActivity(intent);
        return true;
    }

    @Override // com.glu.platform.android.GluCallback
    public boolean LaunchURL(String str, int i) {
        if (i == 1) {
            return LaunchURL(SPECIAL_URL_RATE_ME);
        }
        if (i == 2) {
            return LaunchURL(SPECIAL_URL_FORCE_UPGRADE);
        }
        return i == 3 ? LaunchURL(SPECIAL_URL_MORE_GAMES) : LaunchURL(str);
    }

    @Override // com.glu.platform.android.GluCallback
    public AssetFileDescriptor OpenAPKFile(String str) {
        try {
            return getResources().getAssets().openFd(str);
        } catch (IOException e) {
            return null;
        }
    }

    @Override // com.glu.platform.android.GluCallback
    public boolean PlayVibration(long j) {
        if (this.m_Vibrator == null) {
            return true;
        }
        this.m_Vibrator.vibrate(j);
        return true;
    }

    @Override // com.glu.platform.android.GluCallback
    public void RemoveLocalNotification(String str, String str2) {
        Intent intent = new Intent(this, (Class<?>) GluNotificationService.class);
        intent.setAction("com.glu.platform.android.REMOVE_NOTIFICATION");
        intent.putExtra("com.glu.platform.android.NOTIFICATION_TITLE", str);
        intent.putExtra("com.glu.platform.android.NOTIFICATION_MESSAGE", str2);
        startService(intent);
    }

    @Override // com.glu.platform.android.GluCallback
    public void SetAutoRotationValues(long j, long j2, long j3, long j4) {
        this.m_Orientation0 = j;
        this.m_Orientation90 = j2;
        this.m_Orientation180 = j3;
        this.m_Orientation270 = j4;
    }

    @Override // com.glu.platform.android.GluCallback
    public boolean SetDeviceOrientation(int i) {
        setRequestedOrientation(i);
        return true;
    }

    @Override // com.glu.platform.android.GluCallback
    public void SetTickRate(int i) {
        this.m_TickRateMS = i;
        if (this.m_MainView != null) {
            this.m_MainView.TickRateChanged();
        }
    }

    @Override // com.glu.platform.android.GluCallback
    public void SetVolume(byte b) {
        int streamMaxVolume;
        if (!$assertionsDisabled && (b < 0 || b > 10)) {
            throw new AssertionError();
        }
        AudioManager audioManager = (AudioManager) getSystemService("audio");
        if (audioManager == null || (streamMaxVolume = (audioManager.getStreamMaxVolume(3) * b) / 10) == audioManager.getStreamVolume(3)) {
            return;
        }
        audioManager.setStreamVolume(3, streamMaxVolume, 1);
    }

    @Override // com.glu.platform.android.GluCallback
    public boolean StartAudioStream() {
        if (!this.m_UsePCMMixing || this.m_PCMMediaPlayer == null) {
            return false;
        }
        this.m_PCMMediaPlayer.play();
        return true;
    }

    @Override // com.glu.platform.android.GluCallback
    public boolean StartAutoRotation(long j) {
        boolean z;
        if (this.m_oel == null) {
            this.m_oel = new OrientationEventListener(this) { // from class: com.glu.platform.android.GluPlatformActivity.2
                @Override // android.view.OrientationEventListener
                public final void onOrientationChanged(int i) {
                    if (-1 != i) {
                        int i2 = GluPlatformActivity.this.m_CurrentOrientation;
                        if (GluPlatformActivity.this.m_ValidOrientations[0] && (i >= 350 || i < 10)) {
                            i2 = 1;
                        }
                        if (GluPlatformActivity.this.m_ValidOrientations[1] && i >= 80 && i < 100) {
                            i2 = 8;
                        }
                        if (GluPlatformActivity.this.m_ValidOrientations[2] && i >= 170 && i < 190) {
                            i2 = 9;
                        }
                        if (GluPlatformActivity.this.m_ValidOrientations[3] && i >= 260 && i < 280) {
                            i2 = 0;
                        }
                        if (i2 != GluPlatformActivity.this.m_CurrentOrientation) {
                            GluPlatformActivity.this.m_CurrentOrientation = i2;
                            GluPlatformActivity.this.setRequestedOrientation(i2);
                        }
                    }
                }
            };
            if (this.m_oel.canDetectOrientation()) {
                this.m_CurrentOrientation = getRequestedOrientation();
                this.m_oel.enable();
                z = true;
            } else {
                this.m_oel = null;
                z = false;
            }
        } else {
            z = true;
        }
        this.m_ValidOrientations[0] = this.m_Orientation0 == (this.m_Orientation0 & j);
        this.m_ValidOrientations[1] = this.m_Orientation90 == (this.m_Orientation90 & j);
        this.m_ValidOrientations[2] = this.m_Orientation180 == (this.m_Orientation180 & j);
        this.m_ValidOrientations[3] = this.m_Orientation270 == (this.m_Orientation270 & j);
        return z;
    }

    @Override // com.glu.platform.android.GluCallback
    public void StartLocalNotificationService() {
        Intent intent = new Intent(this, (Class<?>) GluBroadcastHandler.class);
        intent.setAction("com.glu.platform.android.ENABLE_NOTIFICATIONS");
        intent.putExtra("com.glu.platform.android.ENABLE_NOTIFICATIONS_ENABLE", true);
        sendBroadcast(intent);
    }

    @Override // com.glu.platform.android.GluCallback
    public boolean StartMovieActivity(String str, long j) {
        Intent intent = new Intent(this, (Class<?>) GluMovieActivity.class);
        intent.putExtra("com.glu.platform.android.Event", j);
        intent.putExtra("com.glu.platform.android.Filename", str);
        intent.putExtra("com.glu.platform.android.InternalPath", this.m_InternalPath);
        intent.putExtra("com.glu.platform.android.ExternalPath", this.m_ExternalPath);
        startActivity(intent);
        return true;
    }

    @Override // com.glu.platform.android.GluCallback
    public void StopAudioStream() {
        if (!this.m_UsePCMMixing || this.m_PCMMediaPlayer == null) {
            return;
        }
        this.m_PCMMediaPlayer.pause();
    }

    @Override // com.glu.platform.android.GluCallback
    public void StopAutoRotation() {
        if (this.m_oel != null) {
            this.m_oel.disable();
            this.m_oel = null;
        }
    }

    @Override // com.glu.platform.android.GluCallback
    public boolean StopVibration() {
        if (this.m_Vibrator == null) {
            return true;
        }
        this.m_Vibrator.cancel();
        return true;
    }

    @Override // com.glu.platform.android.GluCallback
    public void SystemMessageBox(String str, String str2) {
        Thread thread = new Thread(new SystemMessageBoxRunner(str, str2), "SystemMessageBoxThread");
        thread.start();
        try {
            thread.join();
        } catch (InterruptedException e) {
        }
    }

    final void displaySystemMessageBox(String str, String str2, SystemMessageBoxRunner systemMessageBoxRunner) {
        this.m_SMBHandler.sendMessage(this.m_SMBHandler.obtainMessage(0, new SystemMessageBoxMessage(str, str2, this, systemMessageBoxRunner)));
    }

    public int getDisplayHeight() {
        return this.displayHeight;
    }

    public Handler getHandler() {
        return this.m_Handler;
    }

    public void iOnResDLDone() {
        m_OSVersion = Build.VERSION.SDK_INT;
        FrameLayout frameLayout = new FrameLayout(this);
        this.m_MainView = new GluMainView(getApplication(), this);
        frameLayout.addView(this.m_MainView);
        this.m_MainView.getHolder().setType(2);
        this.m_MainView.getHolder().addCallback(this);
        setContentView(frameLayout);
        PackageManager packageManager = getPackageManager();
        this.m_bMultiTouchEnabled = false;
        this.m_SupportsTouch = packageManager.hasSystemFeature("android.hardware.touchscreen");
        this.m_SupportsMultiTouch = packageManager.hasSystemFeature("android.hardware.touchscreen.multitouch");
        String str = "Touchscreen - touch: " + this.m_SupportsTouch + ", multitouch: " + this.m_SupportsMultiTouch;
        boolean zHasSystemFeature = packageManager.hasSystemFeature("android.hardware.sensor.accelerometer");
        boolean zHasSystemFeature2 = packageManager.hasSystemFeature("android.hardware.sensor.gyroscope");
        String str2 = "Accelerometer: " + zHasSystemFeature + ", Gyroscope: " + zHasSystemFeature2;
        Locale locale = Locale.getDefault();
        this.m_InternalPath = getDir("save", 0) + File.separator;
        this.m_ExternalPath = Environment.getExternalStorageDirectory() + File.separator + "Android" + File.separator + EventDataManager.Events.COLUMN_NAME_DATA + File.separator + getPackageName() + File.separator + "files" + File.separator;
        String str3 = "internalPath: " + this.m_InternalPath + ", externalPath: " + this.m_ExternalPath;
        String str4 = "";
        try {
            str4 = packageManager.getPackageInfo(getComponentName().getPackageName(), 1).versionName;
        } catch (PackageManager.NameNotFoundException e) {
            e.printStackTrace();
        }
        String str5 = "versionName: " + str4;
        Display defaultDisplay = getWindowManager().getDefaultDisplay();
        int width = defaultDisplay.getWidth();
        int height = defaultDisplay.getHeight();
        String str6 = "getWindowManager Screen size - width: " + width + ", height: " + height;
        this.TOUCH_MOVE_THRESHOLD = Math.max(1, (Math.min(width, height) * 10) / 320);
        String str7 = "TouchMoveThreshold: " + this.TOUCH_MOVE_THRESHOLD;
        String str8 = "AppId: " + PushManager.shared().getPreferences().getPushId();
        this.m_jni.initialise(this, this.m_Handler, this.m_InternalPath, this.m_ExternalPath, File.separator, locale.getLanguage(), locale.getCountry(), locale.getDisplayLanguage(), this.m_SupportsMultiTouch, zHasSystemFeature, zHasSystemFeature2, str4, Settings.Secure.getString(getContentResolver(), TapjoyConstants.TJC_ANDROID_ID), Build.VERSION.RELEASE, String.valueOf(Build.VERSION.SDK_INT), Build.VERSION.SDK_INT, getRequestedOrientation(), width, height, PushManager.shared().getPreferences().getPushId());
        this.m_jni.setWindow(this.m_MainView.getHolder());
        this.m_NativeHandle = this.m_jni.onCreate(this.savedInstanceState != null ? this.savedInstanceState.getByteArray("GluSavedInstanceState") : null, this);
        this.m_NotificationIntent = new Intent(this, (Class<?>) GluNotificationService.class);
        com.glu.platform.android.resdl.Debug.log("doing onStart()");
        onStart();
        com.glu.platform.android.resdl.Debug.log("doing onResume()");
        onResume();
        resumeAfterGainedWindowFocus();
        com.glu.platform.android.resdl.Debug.log("done modified code...");
    }

    public void javaToNativeFacebook(int i, int i2, byte[] bArr) {
        javaToNativeFacebook(i, i2, bArr, null);
    }

    public void javaToNativeFacebook(int i, int i2, byte[] bArr, char[][] cArr) {
        this.m_jni.javaToNativeFacebook(this.m_NativeHandle, i, i2, bArr, cArr);
    }

    @Override // com.glu.platform.android.GluCallback
    public int mp3Event(int i, int i2, String str) {
        if (i == 1) {
            DeviceSound.instance.playMP3(str, i2 != 0);
        } else if (i == 2) {
            DeviceSound.instance.pauseMP3();
        } else if (i == 3) {
            DeviceSound.instance.resumeMP3();
        } else if (i == 5) {
            DeviceSound.instance.stopAndDestroyMP3();
        } else if (i == 15) {
            DeviceSound.instance.volumeSetMP3(i2);
        }
        return 0;
    }

    @Override // android.hardware.SensorEventListener
    public void onAccuracyChanged(Sensor sensor, int i) {
    }

    @Override // android.app.Activity, android.content.ComponentCallbacks
    public void onConfigurationChanged(Configuration configuration) {
        super.onConfigurationChanged(configuration);
        if (ResDL.isResDLDone() && this.m_Orientation != configuration.orientation) {
            this.m_jni.onOrientationChanged(this.m_NativeHandle);
            this.m_Orientation = configuration.orientation;
        }
    }

    @Override // android.app.Activity
    protected void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        instance = this;
        this.savedInstanceState = bundle;
        String str = "Build.BOARD: " + Build.BOARD;
        String str2 = "Build.BRAND: " + Build.BRAND;
        String str3 = "Build.CPU_ABI: " + Build.CPU_ABI;
        String str4 = "Build.DEVICE: " + Build.DEVICE;
        String str5 = "Build.DISPLAY: " + Build.DISPLAY;
        String str6 = "Build.FINGERPRINT: " + Build.FINGERPRINT;
        String str7 = "Build.HOST: " + Build.HOST;
        String str8 = "Build.ID: " + Build.ID;
        String str9 = "Build.MANUFACTURER: " + Build.MANUFACTURER;
        String str10 = "Build.MODEL: " + Build.MODEL;
        String str11 = "Build.PRODUCT: " + Build.PRODUCT;
        String str12 = "Build.TAGS: " + Build.TAGS;
        String str13 = "Build.TIME: " + Build.TIME;
        String str14 = "Build.TYPE: " + Build.TYPE;
        String str15 = "Build.USER: " + Build.USER;
        String str16 = "Build.VERSION.CODENAME: " + Build.VERSION.CODENAME;
        String str17 = "Build.VERSION.INCREMENTAL: " + Build.VERSION.INCREMENTAL;
        String str18 = "Build.VERSION.RELEASE: " + Build.VERSION.RELEASE;
        String str19 = "Build.VERSION.SDK: " + Build.VERSION.SDK;
        String str20 = "Build.VERSION.SDK_INT: " + Build.VERSION.SDK_INT;
        String str21 = "Device ID: " + Settings.Secure.getString(getContentResolver(), TapjoyConstants.TJC_ANDROID_ID);
        ConfigurationInfo deviceConfigurationInfo = ((ActivityManager) getSystemService("activity")).getDeviceConfigurationInfo();
        String str22 = "GL Version: " + deviceConfigurationInfo.getGlEsVersion() + " " + Integer.toHexString(deviceConfigurationInfo.reqGlEsVersion);
        instance = this;
        this.savedInstanceState = bundle;
        ResDL.init$35ff8c7e(this, GluPlatformActivity.class);
        ResDL.loadResDownloadView(com.glu.platform.android.resdl.GluUtil.getMethod("com.glu.platform.android.GluPlatformActivity", "onResDLDone", new Class[0]));
        new GluFBConnect();
        new DeviceSound();
    }

    @Override // android.app.Activity
    protected void onDestroy() {
        boolean zIsResDLDone = ResDL.isResDLDone();
        ResDL.onActivityDestroy();
        if (!zIsResDLDone) {
            super.onDestroy();
            return;
        }
        DeviceSound.instance.stop();
        DeviceSound.instance = null;
        this.m_jni.onDestroy(this.m_NativeHandle);
        this.m_MainView.onDestroy();
        this.m_jni.tidy(this.m_NativeHandle);
        this.m_jni.uninitialise();
        if (this.m_MainView != null) {
            this.m_MainView.getHolder().removeCallback(this);
            this.m_MainView = null;
        }
        super.onDestroy();
        Process.killProcess(Process.myPid());
    }

    public void onDrawFrame(long j, boolean z) {
        this.m_jni.onDrawFrame(this.m_NativeHandle, (int) j, z);
    }

    @Override // android.app.Activity, android.view.KeyEvent.Callback
    public boolean onKeyDown(int i, KeyEvent keyEvent) {
        int i2;
        if (ResDL.isResDLDone()) {
            if (isVolumeKey(i)) {
                AudioManager audioManager = (AudioManager) getSystemService("audio");
                int streamVolume = audioManager.getStreamVolume(3);
                switch (i) {
                    case GluFBConnect.FACEBOOK_EVENT_QUEUE_FRIEND_CAPTION /* 24 */:
                        i2 = streamVolume >= audioManager.getStreamMaxVolume(3) ? streamVolume : streamVolume + 1;
                        break;
                    case GluFBConnect.FACEBOOK_EVENT_SET_OK_TO_LOGIN_TO_FACEBOOK /* 25 */:
                        i2 = streamVolume <= 0 ? streamVolume : streamVolume - 1;
                        break;
                    default:
                        i2 = streamVolume;
                        break;
                }
                if (i2 != streamVolume) {
                    audioManager.setStreamVolume(3, i2, 1);
                }
            } else {
                this.m_jni.onKeyDown(this.m_NativeHandle, translateKeyCode(i, keyEvent));
            }
        }
        return true;
    }

    @Override // android.app.Activity, android.view.KeyEvent.Callback
    public boolean onKeyMultiple(int i, int i2, KeyEvent keyEvent) {
        if (!ResDL.isResDLDone()) {
            return true;
        }
        if (i == 0) {
            return false;
        }
        int iTranslateKeyCode = translateKeyCode(i, keyEvent);
        for (int i3 = 0; i3 < i2; i3++) {
            this.m_jni.onKeyDown(this.m_NativeHandle, iTranslateKeyCode);
            this.m_jni.onKeyUp(this.m_NativeHandle, iTranslateKeyCode);
        }
        return true;
    }

    @Override // android.app.Activity, android.view.KeyEvent.Callback
    public boolean onKeyUp(int i, KeyEvent keyEvent) {
        if (ResDL.isResDLDone() && !isVolumeKey(i)) {
            this.m_jni.onKeyUp(this.m_NativeHandle, translateKeyCode(i, keyEvent));
        }
        return true;
    }

    @Override // android.app.Activity, android.content.ComponentCallbacks
    public void onLowMemory() {
        super.onLowMemory();
        if (ResDL.isResDLDone()) {
            this.m_jni.onLowMemory(this.m_NativeHandle);
        }
    }

    @Override // android.media.AudioTrack.OnPlaybackPositionUpdateListener
    public synchronized void onMarkerReached(AudioTrack audioTrack) {
        if (this.m_PCMMediaPlayer != null) {
            if (this.m_PCMBufferOffset < this.m_PCMBufferSizeInBytes) {
                this.m_PCMBufferOffset = this.m_PCMMediaPlayer.write(this.m_PCMBuffer, this.m_PCMBufferOffset, this.m_PCMBufferSizeInBytes - this.m_PCMBufferOffset) + this.m_PCMBufferOffset;
                if (this.m_PCMBufferOffset >= this.m_PCMBufferSizeInBytes) {
                    this.m_jni.feedPCMMediaPlayer(this.m_NativeHandle, this.m_PCMBuffer, this.m_PCMBufferSizeInBytes);
                    this.m_PCMBufferOffset = this.m_PCMMediaPlayer.write(this.m_PCMBuffer, 0, this.m_PCMBufferSizeInBytes);
                }
            } else {
                this.m_jni.feedPCMMediaPlayer(this.m_NativeHandle, this.m_PCMBuffer, this.m_PCMBufferSizeInBytes);
                this.m_PCMBufferOffset = this.m_PCMMediaPlayer.write(this.m_PCMBuffer, 0, this.m_PCMBufferSizeInBytes);
            }
            this.m_PCMMediaPlayer.setNotificationMarkerPosition((this.m_PCMBufferSizeInFrames * 3) / 4);
        }
    }

    @Override // android.app.Activity
    protected void onPause() {
        DeviceSound.instance.pauseMP3();
        super.onPause();
        ResDL.onActivityPause();
        if (ResDL.isResDLDone()) {
            setState(2);
            if (this.m_bNotificationReceiverRegistered) {
                unregisterReceiver(this.m_NotificationReceiver);
                this.m_bNotificationReceiverRegistered = false;
            }
            this.m_jni.onPause(this.m_NativeHandle);
            this.m_MainView.onPause();
            if (this.m_ListeningToAccelerometer) {
                SensorManager sensorManager = (SensorManager) getSystemService("sensor");
                if (sensorManager != null) {
                    sensorManager.unregisterListener(this);
                }
                this.m_ListeningToAccelerometer = false;
            }
            if (this.m_WakeLock != null) {
                this.m_WakeLock.release();
                this.m_WakeLock = null;
            }
        }
    }

    @Override // android.media.AudioTrack.OnPlaybackPositionUpdateListener
    public void onPeriodicNotification(AudioTrack audioTrack) {
        this.m_jni.feedPCMMediaPlayer(this.m_NativeHandle, this.m_PCMBuffer, this.m_PCMBufferSizeInBytes);
        this.m_PCMMediaPlayer.write(this.m_PCMBuffer, 0, this.m_PCMBufferSizeInBytes);
    }

    @Override // android.app.Activity
    protected void onRestart() {
        super.onRestart();
        if (ResDL.isResDLDone()) {
            this.m_jni.onRestart(this.m_NativeHandle);
        }
    }

    @Override // android.app.Activity
    protected void onResume() {
        super.onResume();
        setUseBeam(false);
        ResDL.onActivityResume();
        if (ResDL.isResDLDone()) {
            this.m_cTouches = 0;
            this.m_aTouches = new TouchTracker[10];
            for (int i = 0; i < 10; i++) {
                TouchTracker touchTracker = new TouchTracker(this);
                touchTracker.m_PointerId = -1;
                touchTracker.m_Mode = 0;
                touchTracker.m_Index = i;
                this.m_aTouches[i] = touchTracker;
            }
            if (this.m_MainView != null) {
                this.m_MainView.onResume();
            }
            if (!$assertionsDisabled && this.m_WakeLock != null) {
                throw new AssertionError();
            }
            PowerManager powerManager = (PowerManager) getSystemService("power");
            if (powerManager != null) {
                this.m_WakeLock = powerManager.newWakeLock(536870922, "AndroidPlatform");
                if (this.m_WakeLock != null) {
                    this.m_WakeLock.acquire();
                }
            }
            SensorManager sensorManager = (SensorManager) getSystemService("sensor");
            if (sensorManager == null || !sensorManager.registerListener(this, sensorManager.getDefaultSensor(1), 1)) {
                return;
            }
            this.m_ListeningToAccelerometer = true;
        }
    }

    @Override // android.hardware.SensorEventListener
    public void onSensorChanged(SensorEvent sensorEvent) {
        if (ResDL.isResDLDone()) {
            switch (sensorEvent.sensor.getType()) {
                case 1:
                    float maximumRange = sensorEvent.sensor.getMaximumRange();
                    if (maximumRange <= 0.0d) {
                        maximumRange = 9.80665f;
                    }
                    this.m_jni.pushAccelerometerValues(this.m_NativeHandle, (-sensorEvent.values[0]) / maximumRange, sensorEvent.values[1] / 9.80665f, (-sensorEvent.values[2]) / maximumRange);
                    break;
            }
        }
    }

    @Override // android.app.Activity
    protected void onStart() {
        super.onStart();
        if (ResDL.isResDLDone()) {
            this.m_jni.onStart(this.m_NativeHandle);
        }
    }

    @Override // android.app.Activity
    protected void onStop() {
        super.onStop();
        if (ResDL.isResDLDone()) {
            this.m_jni.onStop(this.m_NativeHandle);
            this.m_MainView.onStop();
        }
    }

    public void onSurfaceChanged(int i, int i2) {
        this.m_jni.onSurfaceChanged(this.m_NativeHandle, i, i2);
    }

    public void onSurfaceCreated() {
        this.m_jni.onSurfaceCreated(this.m_NativeHandle);
    }

    @Override // android.app.Activity
    public boolean onTouchEvent(MotionEvent motionEvent) {
        boolean z;
        initializeTouch();
        if (!ResDL.isResDLDone()) {
            return true;
        }
        int action = motionEvent.getAction();
        int i = action & 255;
        this.touchPad = false;
        if (IsPSP()) {
            try {
                this.touchPad = ((Integer) GETSOURCE.invoke(motionEvent, null)).intValue() == 1048584;
            } catch (Throwable th) {
            }
        }
        if (!this.m_bMultiTouchEnabled) {
            if (!this.m_SupportsTouch) {
                return false;
            }
            int pointerId = motionEvent.getPointerId((action & 65280) >> 8);
            int x = (int) motionEvent.getX();
            int y = (int) motionEvent.getY();
            switch (i) {
                case 0:
                    touchBegan(x, y, pointerId);
                    return true;
                case 1:
                    touchEnded(x, y, pointerId);
                    return true;
                case 2:
                    touchMoved(x, y, pointerId);
                    return true;
                case 3:
                    touchCancelled(x, y, pointerId);
                    return true;
                case 4:
                default:
                    return false;
                case 5:
                case 6:
                    if ($assertionsDisabled) {
                        return false;
                    }
                    throw new AssertionError();
            }
        }
        switch (i) {
            case 0:
                int i2 = (action & 65280) >> 8;
                touchBegan((int) motionEvent.getX(i2), (int) motionEvent.getY(i2), motionEvent.getPointerId(i2));
                return true;
            case 1:
                int i3 = (action & 65280) >> 8;
                touchEnded((int) motionEvent.getX(i3), (int) motionEvent.getY(i3), motionEvent.getPointerId(i3));
                return true;
            case 2:
                int historySize = motionEvent.getHistorySize();
                int pointerCount = motionEvent.getPointerCount();
                for (int i4 = 0; i4 < historySize; i4++) {
                    for (int i5 = 0; i5 < pointerCount; i5++) {
                        touchMoved((int) motionEvent.getHistoricalX(i5, i4), (int) motionEvent.getHistoricalY(i5, i4), motionEvent.getPointerId(i5));
                    }
                }
                for (int i6 = 0; i6 < pointerCount; i6++) {
                    touchMoved((int) motionEvent.getX(i6), (int) motionEvent.getY(i6), motionEvent.getPointerId(i6));
                }
                return true;
            case 3:
                int i7 = (action & 65280) >> 8;
                touchCancelled((int) motionEvent.getX(i7), (int) motionEvent.getY(i7), motionEvent.getPointerId(i7));
                return true;
            case 4:
            default:
                z = false;
                break;
            case 5:
                int i8 = (action & 65280) >> 8;
                touchBegan((int) motionEvent.getX(i8), (int) motionEvent.getY(i8), motionEvent.getPointerId(i8));
                return true;
            case 6:
                int i9 = (action & 65280) >> 8;
                touchEnded((int) motionEvent.getX(i9), (int) motionEvent.getY(i9), motionEvent.getPointerId(i9));
                z = true;
                break;
        }
        return z;
    }

    @Override // android.app.Activity
    public boolean onTrackballEvent(MotionEvent motionEvent) {
        return !ResDL.isResDLDone();
    }

    final void resumeAfterGainedWindowFocus() {
        DeviceSound.instance.resumeMP3();
        this.m_jni.onResume(this.m_NativeHandle);
        registerReceiver(this.m_NotificationReceiver, new IntentFilter("com.glu.platform.android.NOTIFICATION_FIRED"));
        this.m_bNotificationReceiverRegistered = true;
        setState(1);
        HandlePushNotifications();
    }

    public void setUseBeam(boolean z) {
        if (this.m_NativeHandle != 0) {
            this.m_jni.setUseBeam(this.m_NativeHandle, z);
        }
    }

    @Override // android.view.SurfaceHolder.Callback
    public void surfaceChanged(SurfaceHolder surfaceHolder, int i, int i2, int i3) {
        String str = "width: " + i2 + " height: " + i3;
        this.m_jni.surfaceChanged(this.m_NativeHandle, i, i2, i3);
    }

    @Override // android.view.SurfaceHolder.Callback
    public void surfaceCreated(SurfaceHolder surfaceHolder) {
        this.m_jni.surfaceCreated(this.m_NativeHandle);
    }

    @Override // android.view.SurfaceHolder.Callback
    public void surfaceDestroyed(SurfaceHolder surfaceHolder) {
        DeviceSound.instance.pauseMP3();
        this.m_jni.surfaceDestroyed(this.m_NativeHandle);
    }
}
