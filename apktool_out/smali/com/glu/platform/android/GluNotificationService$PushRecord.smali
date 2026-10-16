.class final Lcom/glu/platform/android/GluNotificationService$PushRecord;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/io/Serializable;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/glu/platform/android/GluNotificationService;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "PushRecord"
.end annotation


# instance fields
.field public m_alert:Ljava/lang/String;

.field public m_id:I


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public constructor <init>(ILjava/lang/String;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput p1, p0, Lcom/glu/platform/android/GluNotificationService$PushRecord;->m_id:I

    iput-object p2, p0, Lcom/glu/platform/android/GluNotificationService$PushRecord;->m_alert:Ljava/lang/String;

    return-void
.end method
