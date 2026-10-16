.class final Lcom/glu/platform/android/GluPlatformActivity$SystemMessageBoxMessage;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/glu/platform/android/GluPlatformActivity;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x12
    name = "SystemMessageBoxMessage"
.end annotation


# instance fields
.field final m_Context:Landroid/content/Context;

.field final m_Runner:Lcom/glu/platform/android/GluPlatformActivity$SystemMessageBoxRunner;

.field final m_Text:Ljava/lang/String;

.field final m_Title:Ljava/lang/String;

.field final synthetic this$0:Lcom/glu/platform/android/GluPlatformActivity;


# direct methods
.method constructor <init>(Lcom/glu/platform/android/GluPlatformActivity;Ljava/lang/String;Ljava/lang/String;Landroid/content/Context;Lcom/glu/platform/android/GluPlatformActivity$SystemMessageBoxRunner;)V
    .locals 0

    iput-object p1, p0, Lcom/glu/platform/android/GluPlatformActivity$SystemMessageBoxMessage;->this$0:Lcom/glu/platform/android/GluPlatformActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p2, p0, Lcom/glu/platform/android/GluPlatformActivity$SystemMessageBoxMessage;->m_Title:Ljava/lang/String;

    iput-object p3, p0, Lcom/glu/platform/android/GluPlatformActivity$SystemMessageBoxMessage;->m_Text:Ljava/lang/String;

    iput-object p4, p0, Lcom/glu/platform/android/GluPlatformActivity$SystemMessageBoxMessage;->m_Context:Landroid/content/Context;

    iput-object p5, p0, Lcom/glu/platform/android/GluPlatformActivity$SystemMessageBoxMessage;->m_Runner:Lcom/glu/platform/android/GluPlatformActivity$SystemMessageBoxRunner;

    return-void
.end method
