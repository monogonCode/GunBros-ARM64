.class public Lcom/glu/platform/android/GluTextBox;
.super Ljava/lang/Object;


# static fields
.field private static final TAG:Ljava/lang/String; = "GluTextBox"


# instance fields
.field private isMasked:Z

.field private isVisible:Z

.field private m_activity:Lcom/glu/platform/android/GluPlatformActivity;

.field private m_linearLayout:Landroid/widget/LinearLayout;

.field private screenHeight:I

.field private screenWidth:I

.field private textView:Landroid/widget/EditText;


# direct methods
.method public constructor <init>()V
    .locals 2

    const/4 v1, 0x0

    const/4 v0, 0x0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object v1, p0, Lcom/glu/platform/android/GluTextBox;->m_activity:Lcom/glu/platform/android/GluPlatformActivity;

    iput-object v1, p0, Lcom/glu/platform/android/GluTextBox;->m_linearLayout:Landroid/widget/LinearLayout;

    iput-boolean v0, p0, Lcom/glu/platform/android/GluTextBox;->isMasked:Z

    iput-boolean v0, p0, Lcom/glu/platform/android/GluTextBox;->isVisible:Z

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "GluTextBox["

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "].GluTextBox()"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    sget-object v0, Lcom/glu/platform/android/GluPlatformActivity;->instance:Lcom/glu/platform/android/GluPlatformActivity;

    iput-object v0, p0, Lcom/glu/platform/android/GluTextBox;->m_activity:Lcom/glu/platform/android/GluPlatformActivity;

    new-instance v0, Lcom/glu/platform/android/GluTextBox$1;

    invoke-direct {v0, p0}, Lcom/glu/platform/android/GluTextBox$1;-><init>(Lcom/glu/platform/android/GluTextBox;)V

    iget-object v1, p0, Lcom/glu/platform/android/GluTextBox;->m_activity:Lcom/glu/platform/android/GluPlatformActivity;

    invoke-virtual {v1}, Lcom/glu/platform/android/GluPlatformActivity;->getHandler()Landroid/os/Handler;

    move-result-object v1

    invoke-virtual {v1, v0}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void
.end method

.method static synthetic access$000(Lcom/glu/platform/android/GluTextBox;)Landroid/widget/EditText;
    .locals 1

    iget-object v0, p0, Lcom/glu/platform/android/GluTextBox;->textView:Landroid/widget/EditText;

    return-object v0
.end method

.method static synthetic access$002(Lcom/glu/platform/android/GluTextBox;Landroid/widget/EditText;)Landroid/widget/EditText;
    .locals 0

    iput-object p1, p0, Lcom/glu/platform/android/GluTextBox;->textView:Landroid/widget/EditText;

    return-object p1
.end method

.method static synthetic access$100(Lcom/glu/platform/android/GluTextBox;)Lcom/glu/platform/android/GluPlatformActivity;
    .locals 1

    iget-object v0, p0, Lcom/glu/platform/android/GluTextBox;->m_activity:Lcom/glu/platform/android/GluPlatformActivity;

    return-object v0
.end method

.method static synthetic access$200(Lcom/glu/platform/android/GluTextBox;)Z
    .locals 1

    iget-boolean v0, p0, Lcom/glu/platform/android/GluTextBox;->isMasked:Z

    return v0
.end method

.method static synthetic access$300(Lcom/glu/platform/android/GluTextBox;)Z
    .locals 1

    iget-boolean v0, p0, Lcom/glu/platform/android/GluTextBox;->isVisible:Z

    return v0
.end method

.method static synthetic access$400(Lcom/glu/platform/android/GluTextBox;)Landroid/widget/LinearLayout;
    .locals 1

    iget-object v0, p0, Lcom/glu/platform/android/GluTextBox;->m_linearLayout:Landroid/widget/LinearLayout;

    return-object v0
.end method

.method static synthetic access$402(Lcom/glu/platform/android/GluTextBox;Landroid/widget/LinearLayout;)Landroid/widget/LinearLayout;
    .locals 0

    iput-object p1, p0, Lcom/glu/platform/android/GluTextBox;->m_linearLayout:Landroid/widget/LinearLayout;

    return-object p1
.end method


# virtual methods
.method public GetText()Ljava/lang/String;
    .locals 2

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "GluTextBox["

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "].GetText()"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    iget-object v0, p0, Lcom/glu/platform/android/GluTextBox;->textView:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public RemoveTextView()V
    .locals 2

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "GluTextBox["

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "].RemoveTextView()"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    new-instance v0, Lcom/glu/platform/android/GluTextBox$7;

    invoke-direct {v0, p0}, Lcom/glu/platform/android/GluTextBox$7;-><init>(Lcom/glu/platform/android/GluTextBox;)V

    iget-object v1, p0, Lcom/glu/platform/android/GluTextBox;->m_activity:Lcom/glu/platform/android/GluPlatformActivity;

    invoke-virtual {v1}, Lcom/glu/platform/android/GluPlatformActivity;->getHandler()Landroid/os/Handler;

    move-result-object v1

    invoke-virtual {v1, v0}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void
.end method

.method public SetBounds(IIII)V
    .locals 6

    const/16 v5, 0x2b

    if-ge p4, v5, :cond_0

    :goto_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "GluTextBox["

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "].SetBounds("

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ","

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ","

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ","

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ")"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    new-instance v0, Lcom/glu/platform/android/GluTextBox$2;

    move-object v1, p0

    move v2, p1

    move v3, p2

    move v4, p3

    invoke-direct/range {v0 .. v5}, Lcom/glu/platform/android/GluTextBox$2;-><init>(Lcom/glu/platform/android/GluTextBox;IIII)V

    iget-object v1, p0, Lcom/glu/platform/android/GluTextBox;->m_activity:Lcom/glu/platform/android/GluPlatformActivity;

    invoke-virtual {v1}, Lcom/glu/platform/android/GluPlatformActivity;->getHandler()Landroid/os/Handler;

    move-result-object v1

    invoke-virtual {v1, v0}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void

    :cond_0
    move v5, p4

    goto :goto_0
.end method

.method public SetPasswordMask(Z)V
    .locals 2

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "GluTextBox["

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "].SetPasswordMask("

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ")"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    iput-boolean p1, p0, Lcom/glu/platform/android/GluTextBox;->isMasked:Z

    new-instance v0, Lcom/glu/platform/android/GluTextBox$4;

    invoke-direct {v0, p0, p1}, Lcom/glu/platform/android/GluTextBox$4;-><init>(Lcom/glu/platform/android/GluTextBox;Z)V

    iget-object v1, p0, Lcom/glu/platform/android/GluTextBox;->m_activity:Lcom/glu/platform/android/GluPlatformActivity;

    invoke-virtual {v1}, Lcom/glu/platform/android/GluPlatformActivity;->getHandler()Landroid/os/Handler;

    move-result-object v1

    invoke-virtual {v1, v0}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void
.end method

.method public SetText(Ljava/lang/String;Ljava/lang/String;)V
    .locals 2

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "GluTextBox["

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "].SetText("

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ")"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    new-instance v0, Lcom/glu/platform/android/GluTextBox$6;

    invoke-direct {v0, p0, p1, p2}, Lcom/glu/platform/android/GluTextBox$6;-><init>(Lcom/glu/platform/android/GluTextBox;Ljava/lang/String;Ljava/lang/String;)V

    iget-object v1, p0, Lcom/glu/platform/android/GluTextBox;->m_activity:Lcom/glu/platform/android/GluPlatformActivity;

    invoke-virtual {v1}, Lcom/glu/platform/android/GluPlatformActivity;->getHandler()Landroid/os/Handler;

    move-result-object v1

    invoke-virtual {v1, v0}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void
.end method

.method public SetVisible(Z)V
    .locals 2

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "GluTextBox["

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "].SetVisible("

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ")"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    iput-boolean p1, p0, Lcom/glu/platform/android/GluTextBox;->isVisible:Z

    new-instance v0, Lcom/glu/platform/android/GluTextBox$5;

    invoke-direct {v0, p0, p1}, Lcom/glu/platform/android/GluTextBox$5;-><init>(Lcom/glu/platform/android/GluTextBox;Z)V

    iget-object v1, p0, Lcom/glu/platform/android/GluTextBox;->m_activity:Lcom/glu/platform/android/GluPlatformActivity;

    invoke-virtual {v1}, Lcom/glu/platform/android/GluPlatformActivity;->getHandler()Landroid/os/Handler;

    move-result-object v1

    invoke-virtual {v1, v0}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void
.end method

.method public createTextView(IIII)V
    .locals 6

    new-instance v0, Lcom/glu/platform/android/GluTextBox$3;

    move-object v1, p0

    move v2, p3

    move v3, p4

    move v4, p1

    move v5, p2

    invoke-direct/range {v0 .. v5}, Lcom/glu/platform/android/GluTextBox$3;-><init>(Lcom/glu/platform/android/GluTextBox;IIII)V

    iget-object v1, p0, Lcom/glu/platform/android/GluTextBox;->m_activity:Lcom/glu/platform/android/GluPlatformActivity;

    invoke-virtual {v1}, Lcom/glu/platform/android/GluPlatformActivity;->getHandler()Landroid/os/Handler;

    move-result-object v1

    invoke-virtual {v1, v0}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void
.end method
