package com.glu.platform.android.resdl;

import android.opengl.GLSurfaceView;
import javax.microedition.khronos.egl.EGLConfig;
import javax.microedition.khronos.opengles.GL10;

/* JADX INFO: loaded from: classes.dex */
public class DummyGLView extends GLSurfaceView {
    private boolean m_switchedAlready;

    public DummyGLView() {
        super(ResDL.getContext());
        this.m_switchedAlready = false;
        setRenderer(new GLSurfaceView.Renderer() { // from class: com.glu.platform.android.resdl.DummyGLView.1
            @Override // android.opengl.GLSurfaceView.Renderer
            public final void onDrawFrame(GL10 gl10) {
                gl10.glClearColor(0.0f, 0.0f, 0.0f, 1.0f);
                gl10.glClear(16640);
            }

            @Override // android.opengl.GLSurfaceView.Renderer
            public final void onSurfaceChanged(GL10 gl10, int i, int i2) {
                gl10.glViewport(0, 0, i, i2);
                Debug.log("dummy onSurfaceChanged(" + i + ", " + i2 + ")");
                if (i != 0 && i2 != 0) {
                    ResDL.sm_actualWidth = i;
                    ResDL.sm_actualHeight = i2;
                }
                GameLet.instance.setBuildVariant();
                if (DummyGLView.this.m_switchedAlready) {
                    return;
                }
                GameLet.instance.handlerSwitchToResView();
                DummyGLView.access$002$6ec9ed30(DummyGLView.this);
            }

            @Override // android.opengl.GLSurfaceView.Renderer
            public final void onSurfaceCreated(GL10 gl10, EGLConfig eGLConfig) {
                Debug.log("GL Vendor: " + gl10.glGetString(7936));
                Debug.log("GL Renderer: " + gl10.glGetString(7937));
                Debug.log("GL Version: " + gl10.glGetString(7938));
                String strGlGetString = gl10.glGetString(7939);
                Debug.log("GL Extensions: " + strGlGetString);
                GameLet.instance.m_supportsDXTCCompression = strGlGetString.contains("GL_EXT_texture_compression_dxt1");
                GameLet.instance.m_supportsPVRTCCompression = strGlGetString.contains("GL_IMG_texture_compression_pvrtc");
                GameLet.instance.m_supportsATITCCompression = strGlGetString.contains("GL_ATI_texture_compression_atitc");
                Debug.log("This device " + (GameLet.instance.m_supportsATITCCompression ? "supports" : "doesn't support") + " ATITC texture compression");
                Debug.log("This device " + (GameLet.instance.m_supportsDXTCCompression ? "supports" : "doesn't support") + " DXTC texture compression");
                Debug.log("This device " + (GameLet.instance.m_supportsPVRTCCompression ? "supports" : "doesn't support") + " PVRTC texture compression");
            }
        });
        setFocusable(true);
        setFocusableInTouchMode(true);
    }

    static /* synthetic */ boolean access$002$6ec9ed30(DummyGLView dummyGLView) {
        dummyGLView.m_switchedAlready = true;
        return true;
    }
}
