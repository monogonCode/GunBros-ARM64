.class final Lcom/glu/platform/android/GluNotificationService$NotificationRecord;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/io/Serializable;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/glu/platform/android/GluNotificationService;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "NotificationRecord"
.end annotation


# instance fields
.field public m_addedAt:J

.field public m_badge:I

.field public m_fireAt:J

.field public m_icon:I

.field public m_message:Ljava/lang/String;

.field public m_title:Ljava/lang/String;

.field public m_when:I


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public constructor <init>(ILjava/lang/String;Ljava/lang/String;II)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput p1, p0, Lcom/glu/platform/android/GluNotificationService$NotificationRecord;->m_when:I

    iput-object p2, p0, Lcom/glu/platform/android/GluNotificationService$NotificationRecord;->m_title:Ljava/lang/String;

    iput-object p3, p0, Lcom/glu/platform/android/GluNotificationService$NotificationRecord;->m_message:Ljava/lang/String;

    iput p4, p0, Lcom/glu/platform/android/GluNotificationService$NotificationRecord;->m_badge:I

    iput p5, p0, Lcom/glu/platform/android/GluNotificationService$NotificationRecord;->m_icon:I

    return-void
.end method


# virtual methods
.method public final equal(Lcom/glu/platform/android/GluNotificationService$NotificationRecord;)Z
    .locals 2

    iget-object v0, p1, Lcom/glu/platform/android/GluNotificationService$NotificationRecord;->m_title:Ljava/lang/String;

    iget-object v1, p0, Lcom/glu/platform/android/GluNotificationService$NotificationRecord;->m_title:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p1, Lcom/glu/platform/android/GluNotificationService$NotificationRecord;->m_message:Ljava/lang/String;

    iget-object v1, p0, Lcom/glu/platform/android/GluNotificationService$NotificationRecord;->m_message:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method
