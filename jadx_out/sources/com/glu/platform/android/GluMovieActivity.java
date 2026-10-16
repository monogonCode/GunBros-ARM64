package com.glu.platform.android;

import android.app.Activity;
import android.media.MediaPlayer;
import android.os.Bundle;
import android.os.PowerManager;
import android.view.MotionEvent;
import android.view.SurfaceHolder;
import android.view.SurfaceView;
import android.widget.FrameLayout;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

/* JADX INFO: loaded from: classes.dex */
public class GluMovieActivity extends Activity implements MediaPlayer.OnCompletionListener, MediaPlayer.OnInfoListener, MediaPlayer.OnPreparedListener, MediaPlayer.OnVideoSizeChangedListener, SurfaceHolder.Callback {
    static final /* synthetic */ boolean $assertionsDisabled;
    private long m_ExtraMovieEvent;
    private String m_ExtraMovieExternalPath;
    private String m_ExtraMovieFilename;
    private String m_ExtraMovieInternalPath;
    private int m_Height;
    private SurfaceHolder m_Holder;
    private boolean m_IsPrepared;
    private boolean m_IsVideoSizeKnown;
    private String m_Path = "Gman_intro.3gp";
    private MediaPlayer m_Player;
    private SurfaceView m_Preview;
    private boolean m_TouchDownReceived;
    private PowerManager.WakeLock m_WakeLock;
    private int m_Width;

    static {
        $assertionsDisabled = !GluMovieActivity.class.desiredAssertionStatus();
    }

    private void doCleanUp() {
        this.m_Width = 0;
        this.m_Height = 0;
        this.m_IsVideoSizeKnown = false;
        this.m_IsPrepared = false;
    }

    private void finishMovieActivity() {
        OnMovieComplete(this.m_ExtraMovieEvent);
        finish();
    }

    private boolean setDataSource() {
        String str;
        if (!this.m_ExtraMovieFilename.startsWith("apk:")) {
            if (this.m_ExtraMovieFilename.startsWith("data:")) {
                str = this.m_ExtraMovieInternalPath + this.m_ExtraMovieFilename.substring("data:".length());
            } else {
                str = this.m_ExtraMovieFilename.startsWith(File.separator) ? this.m_ExtraMovieFilename : this.m_ExtraMovieExternalPath + this.m_ExtraMovieFilename;
            }
            try {
                this.m_Player.setDataSource(str);
                return true;
            } catch (IOException e) {
                String str2 = "Data IOException: " + e;
                return false;
            }
        }
        String strSubstring = this.m_ExtraMovieFilename.substring("apk:".length());
        String str3 = this.m_ExtraMovieExternalPath + strSubstring;
        if (new File(str3).canRead()) {
            try {
                this.m_Player.setDataSource(str3);
                return true;
            } catch (IOException e2) {
                String str4 = "Application IOException: " + e2;
                return false;
            }
        }
        getResources().getAssets();
        try {
            this.m_Player.setDataSource(new FileInputStream(GluUtil.findMediaResourceFile(strSubstring)).getFD());
            return true;
        } catch (IOException e3) {
            String str5 = "APK IOException: " + e3;
            return false;
        }
    }

    private void tryPlayback() {
        if (this.m_IsPrepared && this.m_IsVideoSizeKnown) {
            this.m_Holder.setFixedSize(this.m_Width, this.m_Height);
            finishMovieActivity();
        }
    }

    public native void OnMovieComplete(long j);

    @Override // android.app.Activity
    public void onBackPressed() {
        finishMovieActivity();
    }

    @Override // android.media.MediaPlayer.OnCompletionListener
    public void onCompletion(MediaPlayer mediaPlayer) {
        finishMovieActivity();
    }

    @Override // android.app.Activity
    public void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        requestWindowFeature(1);
        getWindow().setFlags(1024, 1024);
        FrameLayout frameLayout = new FrameLayout(this);
        this.m_Preview = new SurfaceView(this);
        frameLayout.addView(this.m_Preview);
        this.m_Holder = this.m_Preview.getHolder();
        this.m_Holder.addCallback(this);
        this.m_Holder.setType(3);
        setContentView(frameLayout);
        this.m_ExtraMovieEvent = getIntent().getLongExtra("com.glu.platform.android.Event", 0L);
        this.m_ExtraMovieFilename = getIntent().getStringExtra("com.glu.platform.android.Filename");
        this.m_ExtraMovieInternalPath = getIntent().getStringExtra("com.glu.platform.android.InternalPath");
        this.m_ExtraMovieExternalPath = getIntent().getStringExtra("com.glu.platform.android.ExternalPath");
    }

    @Override // android.app.Activity
    protected void onDestroy() {
        super.onDestroy();
        if (this.m_Player != null) {
            this.m_Player.release();
            this.m_Player = null;
        }
        doCleanUp();
    }

    @Override // android.media.MediaPlayer.OnInfoListener
    public boolean onInfo(MediaPlayer mediaPlayer, int i, int i2) {
        String str;
        switch (i) {
            case 1:
                str = "Unknown";
                break;
            case 700:
                str = "VideoTrack Lagging";
                break;
            case 800:
                str = "Bad Interleaving";
                break;
            case 801:
                str = "Not Seekable";
                break;
            case 802:
                str = "Metadata Update";
                break;
            default:
                str = "Other";
                break;
        }
        String str2 = str + ": " + i2;
        return false;
    }

    @Override // android.app.Activity
    protected void onPause() {
        if (this.m_WakeLock != null) {
            this.m_WakeLock.release();
            this.m_WakeLock = null;
        }
        this.m_Player.stop();
        finishMovieActivity();
        super.onPause();
    }

    @Override // android.media.MediaPlayer.OnPreparedListener
    public void onPrepared(MediaPlayer mediaPlayer) {
        this.m_IsPrepared = true;
        tryPlayback();
    }

    @Override // android.app.Activity
    protected void onResume() {
        super.onResume();
        PowerManager powerManager = (PowerManager) getSystemService("power");
        if (powerManager != null) {
            this.m_WakeLock = powerManager.newWakeLock(536870922, "AndroidMovieActivity");
            if (this.m_WakeLock != null) {
                this.m_WakeLock.acquire();
            }
        }
    }

    @Override // android.app.Activity
    public boolean onTouchEvent(MotionEvent motionEvent) {
        switch (motionEvent.getAction()) {
            case 0:
                this.m_TouchDownReceived = true;
                return true;
            case 1:
                if (!this.m_TouchDownReceived) {
                    return true;
                }
                this.m_TouchDownReceived = false;
                finishMovieActivity();
                return true;
            default:
                return false;
        }
    }

    @Override // android.media.MediaPlayer.OnVideoSizeChangedListener
    public void onVideoSizeChanged(MediaPlayer mediaPlayer, int i, int i2) {
        if (i <= 0 || i2 <= 0) {
            String str = "Invalid vide size - width: " + i + ", height: " + i2;
            return;
        }
        this.m_IsVideoSizeKnown = true;
        this.m_Width = i;
        this.m_Height = i2;
        tryPlayback();
    }

    @Override // android.view.SurfaceHolder.Callback
    public void surfaceChanged(SurfaceHolder surfaceHolder, int i, int i2, int i3) {
    }

    @Override // android.view.SurfaceHolder.Callback
    public void surfaceCreated(SurfaceHolder surfaceHolder) {
        if (!$assertionsDisabled && this.m_Path == null) {
            throw new AssertionError();
        }
        doCleanUp();
        this.m_Player = new MediaPlayer();
        if (setDataSource()) {
            this.m_Player.setDisplay(this.m_Holder);
            this.m_Player.prepareAsync();
            this.m_Player.setOnCompletionListener(this);
            this.m_Player.setOnPreparedListener(this);
            this.m_Player.setOnVideoSizeChangedListener(this);
            this.m_Player.setAudioStreamType(3);
        }
    }

    @Override // android.view.SurfaceHolder.Callback
    public void surfaceDestroyed(SurfaceHolder surfaceHolder) {
    }
}
