.class final Lcom/glu/android/GluBeam$NFCListener;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/nfc/NfcAdapter$CreateNdefMessageCallback;
.implements Landroid/nfc/NfcAdapter$OnNdefPushCompleteCallback;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/glu/android/GluBeam;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "NFCListener"
.end annotation


# instance fields
.field private m_mostRecentOutgoingSize:I

.field private m_startTime:J

.field final synthetic this$0:Lcom/glu/android/GluBeam;


# direct methods
.method synthetic constructor <init>(Lcom/glu/android/GluBeam;)V
    .locals 1

    const/4 v0, 0x0

    invoke-direct {p0, p1, v0}, Lcom/glu/android/GluBeam$NFCListener;-><init>(Lcom/glu/android/GluBeam;B)V

    return-void
.end method

.method private constructor <init>(Lcom/glu/android/GluBeam;B)V
    .locals 2

    iput-object p1, p0, Lcom/glu/android/GluBeam$NFCListener;->this$0:Lcom/glu/android/GluBeam;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const-wide/16 v0, 0x0

    iput-wide v0, p0, Lcom/glu/android/GluBeam$NFCListener;->m_startTime:J

    const/4 v0, 0x0

    iput v0, p0, Lcom/glu/android/GluBeam$NFCListener;->m_mostRecentOutgoingSize:I

    return-void
.end method


# virtual methods
.method public final createNdefMessage(Landroid/nfc/NfcEvent;)Landroid/nfc/NdefMessage;
    .locals 2

    iget-object v0, p0, Lcom/glu/android/GluBeam$NFCListener;->this$0:Lcom/glu/android/GluBeam;

    invoke-static {v0}, Lcom/glu/android/GluBeam;->access$100(Lcom/glu/android/GluBeam;)[Landroid/nfc/NdefRecord;

    move-result-object v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/glu/android/GluBeam$NFCListener;->this$0:Lcom/glu/android/GluBeam;

    invoke-static {v0}, Lcom/glu/android/GluBeam;->access$100(Lcom/glu/android/GluBeam;)[Landroid/nfc/NdefRecord;

    move-result-object v0

    array-length v0, v0

    if-nez v0, :cond_1

    :cond_0
    const-string v0, "Creating a null ndef message, as there are no records to send."

    invoke-static {v0}, Lcom/glu/android/GluBeam;->log(Ljava/lang/String;)V

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    iput-wide v0, p0, Lcom/glu/android/GluBeam$NFCListener;->m_startTime:J

    const/4 v0, 0x0

    iput v0, p0, Lcom/glu/android/GluBeam$NFCListener;->m_mostRecentOutgoingSize:I

    const/4 v0, 0x0

    :goto_0
    return-object v0

    :cond_1
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Prompted to create an Ndef message. Created one of length: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/glu/android/GluBeam$NFCListener;->this$0:Lcom/glu/android/GluBeam;

    invoke-static {v1}, Lcom/glu/android/GluBeam;->access$100(Lcom/glu/android/GluBeam;)[Landroid/nfc/NdefRecord;

    move-result-object v1

    array-length v1, v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/glu/android/GluBeam;->log(Ljava/lang/String;)V

    sget-object v0, Lcom/glu/platform/android/GluPlatformActivity;->instance:Lcom/glu/platform/android/GluPlatformActivity;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Lcom/glu/platform/android/GluPlatformActivity;->setUseBeam(Z)V

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    iput-wide v0, p0, Lcom/glu/android/GluBeam$NFCListener;->m_startTime:J

    iget-object v0, p0, Lcom/glu/android/GluBeam$NFCListener;->this$0:Lcom/glu/android/GluBeam;

    invoke-static {v0}, Lcom/glu/android/GluBeam;->access$200(Lcom/glu/android/GluBeam;)I

    move-result v0

    iput v0, p0, Lcom/glu/android/GluBeam$NFCListener;->m_mostRecentOutgoingSize:I

    new-instance v0, Landroid/nfc/NdefMessage;

    iget-object v1, p0, Lcom/glu/android/GluBeam$NFCListener;->this$0:Lcom/glu/android/GluBeam;

    invoke-static {v1}, Lcom/glu/android/GluBeam;->access$100(Lcom/glu/android/GluBeam;)[Landroid/nfc/NdefRecord;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/nfc/NdefMessage;-><init>([Landroid/nfc/NdefRecord;)V

    goto :goto_0
.end method

.method public final onNdefPushComplete(Landroid/nfc/NfcEvent;)V
    .locals 8

    const-string v0, "Ndef push completed."

    invoke-static {v0}, Lcom/glu/android/GluBeam;->log(Ljava/lang/String;)V

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    iget-wide v2, p0, Lcom/glu/android/GluBeam$NFCListener;->m_startTime:J

    sub-long/2addr v0, v2

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    iget v3, p0, Lcom/glu/android/GluBeam$NFCListener;->m_mostRecentOutgoingSize:I

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " bytes transmitted in "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0, v1}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "ms. "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-wide/16 v3, 0x0

    cmp-long v3, v0, v3

    if-nez v3, :cond_0

    const-string v0, "That was fast!"

    :goto_0
    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/glu/android/GluBeam;->log(Ljava/lang/String;)V

    return-void

    :cond_0
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    iget v4, p0, Lcom/glu/android/GluBeam$NFCListener;->m_mostRecentOutgoingSize:I

    int-to-double v4, v4

    long-to-double v0, v0

    const-wide v6, 0x3f50624dd2f1a9fcL    # 0.001

    div-double/2addr v0, v6

    div-double v0, v4, v0

    invoke-virtual {v3, v0, v1}, Ljava/lang/StringBuilder;->append(D)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "b/s"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_0
.end method
