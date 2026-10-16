package com.glu.platform.android;

import android.content.Context;
import android.os.Handler;
import android.os.Message;
import android.os.SystemClock;
import android.view.SurfaceHolder;
import android.view.SurfaceView;
import java.util.concurrent.ScheduledFuture;
import java.util.concurrent.ScheduledThreadPoolExecutor;
import java.util.concurrent.TimeUnit;

/* JADX INFO: loaded from: classes.dex */
public class GluMainView extends SurfaceView implements SurfaceHolder.Callback {
    private GluPlatformActivity m_Activity;
    private ScheduledThreadPoolExecutor m_Executor;
    private boolean m_JavaSurfaceExists;
    private Handler m_Kicker;
    private boolean m_TickRateChanged;
    private ScheduledFuture m_TickTaskFuture;
    private boolean m_Ticking;

    class TickTask implements Runnable {
        private boolean m_Ticking;

        public TickTask(boolean z) {
            this.m_Ticking = z;
        }

        @Override // java.lang.Runnable
        public final void run() {
            GluMainView.this.m_Activity.onDrawFrame(SystemClock.uptimeMillis(), this.m_Ticking);
            if (GluMainView.this.m_TickRateChanged) {
                GluMainView.access$102$664717f3(GluMainView.this);
                GluMainView.this.m_Kicker.sendEmptyMessage(1);
            }
        }
    }

    public GluMainView(Context context, GluPlatformActivity gluPlatformActivity) {
        super(context);
        this.m_Kicker = new Handler() { // from class: com.glu.platform.android.GluMainView.1
            static final /* synthetic */ boolean $assertionsDisabled;

            static {
                $assertionsDisabled = !GluMainView.class.desiredAssertionStatus();
            }

            @Override // android.os.Handler
            public final void handleMessage(Message message) {
                switch (message.what) {
                    case 1:
                        GluMainView.access$302$664717f3(GluMainView.this);
                        GluMainView.this.m_TickTaskFuture.cancel(false);
                        try {
                            GluMainView.this.m_TickTaskFuture.get();
                            break;
                        } catch (Exception e) {
                        }
                        int iGetTickRate = GluMainView.this.m_Activity.GetTickRate();
                        if (GluMainView.this.m_Executor == null) {
                            GluMainView.this.m_Executor = new ScheduledThreadPoolExecutor(1);
                        }
                        GluMainView.this.m_TickTaskFuture = GluMainView.this.m_Executor.scheduleAtFixedRate(GluMainView.this.new TickTask(true), iGetTickRate, iGetTickRate, TimeUnit.MILLISECONDS);
                        return;
                    default:
                        if (!$assertionsDisabled) {
                            throw new AssertionError();
                        }
                        return;
                }
            }
        };
        this.m_TickRateChanged = false;
        getHolder().addCallback(this);
        this.m_Activity = gluPlatformActivity;
    }

    static /* synthetic */ boolean access$102$664717f3(GluMainView gluMainView) {
        gluMainView.m_TickRateChanged = false;
        return false;
    }

    static /* synthetic */ boolean access$302$664717f3(GluMainView gluMainView) {
        gluMainView.m_Ticking = false;
        return false;
    }

    private void kick() {
        if (this.m_Executor == null) {
            this.m_Executor = new ScheduledThreadPoolExecutor(1);
        }
        stopTimer(false);
    }

    private void startTimer() {
        if (this.m_Executor == null) {
            this.m_Executor = new ScheduledThreadPoolExecutor(1);
        }
        if (this.m_Executor == null || this.m_Ticking || !this.m_JavaSurfaceExists) {
            return;
        }
        int iGetTickRate = this.m_Activity.GetTickRate();
        String str = "tickrate: " + iGetTickRate;
        if (-1 == iGetTickRate) {
            this.m_Executor.execute(new TickTask(true));
        } else {
            this.m_Ticking = true;
            this.m_TickTaskFuture = this.m_Executor.scheduleAtFixedRate(new TickTask(true), iGetTickRate, iGetTickRate, TimeUnit.MILLISECONDS);
        }
    }

    private void stopTimer(boolean z) {
        if (this.m_Executor != null) {
            this.m_Executor.execute(new TickTask(z));
            this.m_Executor.shutdown();
            try {
                this.m_Executor.awaitTermination(60L, TimeUnit.SECONDS);
            } catch (InterruptedException e) {
                this.m_Executor.shutdownNow();
            }
            this.m_Executor = null;
            this.m_Ticking = false;
        }
    }

    public final void TickRateChanged() {
        this.m_TickRateChanged = true;
    }

    public final void onDestroy() {
        kick();
    }

    public final void onPause() {
        stopTimer(true);
    }

    public final void onResume() {
        startTimer();
    }

    public final void onStop() {
        kick();
    }

    @Override // android.view.View
    public void onWindowFocusChanged(boolean z) {
        if (z) {
            this.m_Activity.resumeAfterGainedWindowFocus();
        }
        super.onWindowFocusChanged(z);
    }

    @Override // android.view.SurfaceHolder.Callback
    public void surfaceChanged(SurfaceHolder surfaceHolder, int i, int i2, int i3) {
    }

    @Override // android.view.SurfaceHolder.Callback
    public void surfaceCreated(SurfaceHolder surfaceHolder) {
        this.m_JavaSurfaceExists = true;
        startTimer();
    }

    @Override // android.view.SurfaceHolder.Callback
    public void surfaceDestroyed(SurfaceHolder surfaceHolder) {
        this.m_JavaSurfaceExists = false;
    }
}
