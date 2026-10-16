package com.glu.platform.android.resdl;

import android.app.Activity;
import android.os.Handler;
import android.os.Message;
import android.os.PowerManager;
import com.glu.platform.android.GluPlatformActivity;
import java.lang.reflect.Method;

/* JADX INFO: loaded from: classes.dex */
public final class ResDL {
    private static PowerManager.WakeLock m_WakeLock;
    private static Activity sm_context = null;
    private static Class sm_contextClass = null;
    public static int sm_actualWidth = 1;
    public static int sm_actualHeight = 1;
    private static Method sm_onCompletionCallback = null;
    private static int sm_resDLState = 0;
    public static DummyGLView sm_dummyView = null;
    public static ResDownloadViewGroup sm_resDLView = null;
    public static Handler m_viewManipulationHandler = null;

    static Activity getContext() {
        return sm_context;
    }

    public static String getResourceFilePath() {
        if (sm_resDLState != 3) {
            onAssertionFailed("Must get res path only after ResDL done.");
        }
        String absolutePath = GluUtil.findResourceFile().getAbsolutePath();
        return GluUtil.filePathWithEnder(absolutePath.substring(0, absolutePath.lastIndexOf(47)));
    }

    public static void init$35ff8c7e(Activity activity, Class cls) {
        Debug.log("ResDL.init()");
        if (sm_resDLState != 0) {
            onAssertionFailed("Called init while not in STATE_NONE. Did you remember to call onActivityDestroy()?");
        }
        sm_context = activity;
        sm_contextClass = cls;
        Debug.DEBUG = false;
        sm_resDLState = 1;
        m_viewManipulationHandler = new Handler() { // from class: com.glu.platform.android.resdl.ResDL.1
            @Override // android.os.Handler
            public final void handleMessage(Message message) {
                int i = message.what;
                if (i == 0) {
                    GameLet.instance.onHandledOpenModalDialog();
                } else if (i == 1) {
                    GameLet.instance.onHandledCloseModalDialog();
                } else if (i == 2) {
                    ResDL.onReadyToSwitchToResView();
                }
            }
        };
        GameLet.populate();
    }

    public static boolean isResDLDone() {
        return sm_resDLState == 3;
    }

    public static void loadResDownloadView(Method method) {
        Debug.log("ResDL.loadResDownloadView()");
        if (sm_resDLState != 1) {
            onAssertionFailed("Cannot load res download view without initting first.");
        }
        sm_onCompletionCallback = method;
        sm_resDLState = 2;
        Activity activity = sm_context;
        DummyGLView dummyGLView = new DummyGLView();
        sm_dummyView = dummyGLView;
        activity.setContentView(dummyGLView);
    }

    public static void onActivityDestroy() {
        Debug.log("ResDL.onActivityDestroy()");
        GameLet.instance.m_appPaused = true;
        sm_dummyView = null;
        sm_resDLView = null;
        sm_context = null;
        ResFileDownloadView.instance = null;
        ResDownloadViewGroup.instance = null;
        sm_onCompletionCallback = null;
        sm_resDLState = 0;
    }

    public static void onActivityPause() {
        Debug.log("ResDL.onActivityPause()");
        if (m_WakeLock != null) {
            m_WakeLock.release();
            m_WakeLock = null;
        }
        GameLet.instance.m_appPaused = true;
    }

    public static void onActivityResume() {
        Debug.log("ResDL.onActivityResume()");
        PowerManager powerManager = (PowerManager) GluPlatformActivity.instance.getSystemService("power");
        if (powerManager != null) {
            PowerManager.WakeLock wakeLockNewWakeLock = powerManager.newWakeLock(536870922, "Resdl");
            m_WakeLock = wakeLockNewWakeLock;
            if (wakeLockNewWakeLock != null) {
                m_WakeLock.acquire();
            }
        }
        GameLet.instance.m_appPaused = false;
    }

    private static void onAssertionFailed(String str) {
        throw new RuntimeException(str);
    }

    static void onReadyToLaunchGame() {
        Debug.log("ready to launch game...");
        sm_resDLView = null;
        sm_resDLState = 3;
        try {
            sm_onCompletionCallback.invoke(null, new Object[0]);
        } catch (Throwable th) {
            Debug.log("Dead.", th);
            throw new RuntimeException("Bad callback. (did you exclude it from obfuscation?)");
        }
    }

    static void onReadyToSwitchToResView() {
        sm_dummyView = null;
        GameLet.instance.setBuildVariant();
        new GluDownloadResMgr();
        ResDownloadViewGroup resDownloadViewGroup = new ResDownloadViewGroup(sm_context);
        sm_resDLView = resDownloadViewGroup;
        resDownloadViewGroup.init();
        sm_context.setContentView(sm_resDLView);
        sm_resDLView.requestFocus();
    }
}
