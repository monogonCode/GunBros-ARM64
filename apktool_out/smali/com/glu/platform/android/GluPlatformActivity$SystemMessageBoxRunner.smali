.class final Lcom/glu/platform/android/GluPlatformActivity$SystemMessageBoxRunner;
.super Lcom/glu/platform/android/GluPlatformActivity$Runner;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/glu/platform/android/GluPlatformActivity;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = "SystemMessageBoxRunner"
.end annotation


# instance fields
.field m_Text:Ljava/lang/String;

.field m_Title:Ljava/lang/String;

.field final synthetic this$0:Lcom/glu/platform/android/GluPlatformActivity;


# direct methods
.method constructor <init>(Lcom/glu/platform/android/GluPlatformActivity;Ljava/lang/String;Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lcom/glu/platform/android/GluPlatformActivity$SystemMessageBoxRunner;->this$0:Lcom/glu/platform/android/GluPlatformActivity;

    invoke-direct {p0, p1}, Lcom/glu/platform/android/GluPlatformActivity$Runner;-><init>(Lcom/glu/platform/android/GluPlatformActivity;)V

    iput-object p2, p0, Lcom/glu/platform/android/GluPlatformActivity$SystemMessageBoxRunner;->m_Title:Ljava/lang/String;

    iput-object p3, p0, Lcom/glu/platform/android/GluPlatformActivity$SystemMessageBoxRunner;->m_Text:Ljava/lang/String;

    return-void
.end method


# virtual methods
.method public final run()V
    .locals 3

    iget-object v0, p0, Lcom/glu/platform/android/GluPlatformActivity$SystemMessageBoxRunner;->this$0:Lcom/glu/platform/android/GluPlatformActivity;

    iget-object v1, p0, Lcom/glu/platform/android/GluPlatformActivity$SystemMessageBoxRunner;->m_Title:Ljava/lang/String;

    iget-object v2, p0, Lcom/glu/platform/android/GluPlatformActivity$SystemMessageBoxRunner;->m_Text:Ljava/lang/String;

    invoke-virtual {v0, v1, v2, p0}, Lcom/glu/platform/android/GluPlatformActivity;->displaySystemMessageBox(Ljava/lang/String;Ljava/lang/String;Lcom/glu/platform/android/GluPlatformActivity$SystemMessageBoxRunner;)V

    invoke-virtual {p0}, Lcom/glu/platform/android/GluPlatformActivity$SystemMessageBoxRunner;->waitTillDone()V

    return-void
.end method
