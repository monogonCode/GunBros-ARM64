.class public Lcom/glu/platform/android/resdl/DummyGLView;
.super Landroid/opengl/GLSurfaceView;


# instance fields
.field private m_switchedAlready:Z


# direct methods
.method public constructor <init>()V
    .locals 2

    const/4 v1, 0x1

    invoke-static {}, Lcom/glu/platform/android/resdl/ResDL;->getContext()Landroid/app/Activity;

    move-result-object v0

    invoke-direct {p0, v0}, Landroid/opengl/GLSurfaceView;-><init>(Landroid/content/Context;)V

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/glu/platform/android/resdl/DummyGLView;->m_switchedAlready:Z

    new-instance v0, Lcom/glu/platform/android/resdl/DummyGLView$1;

    invoke-direct {v0, p0}, Lcom/glu/platform/android/resdl/DummyGLView$1;-><init>(Lcom/glu/platform/android/resdl/DummyGLView;)V

    invoke-virtual {p0, v0}, Lcom/glu/platform/android/resdl/DummyGLView;->setRenderer(Landroid/opengl/GLSurfaceView$Renderer;)V

    invoke-virtual {p0, v1}, Lcom/glu/platform/android/resdl/DummyGLView;->setFocusable(Z)V

    invoke-virtual {p0, v1}, Lcom/glu/platform/android/resdl/DummyGLView;->setFocusableInTouchMode(Z)V

    return-void
.end method

.method static synthetic access$000(Lcom/glu/platform/android/resdl/DummyGLView;)Z
    .locals 1

    iget-boolean v0, p0, Lcom/glu/platform/android/resdl/DummyGLView;->m_switchedAlready:Z

    return v0
.end method

.method static synthetic access$002$6ec9ed30(Lcom/glu/platform/android/resdl/DummyGLView;)Z
    .locals 1

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/glu/platform/android/resdl/DummyGLView;->m_switchedAlready:Z

    return v0
.end method
