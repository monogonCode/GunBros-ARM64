.class public Lcom/glu/android/GluBeam;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/glu/android/GluBeam$NFCListener;
    }
.end annotation


# static fields
.field private static final BEAM_EVENT_DEBUG_ANYSIZE:I = 0x3ea

.field private static final BEAM_EVENT_DEBUG_BIG_MESSAGE:I = 0x3e8

.field private static final BEAM_EVENT_DEBUG_UDID:I = 0x3e9

.field private static final BEAM_EVENT_DESTROY:I = 0x5

.field private static final BEAM_EVENT_INIT_OUTGOING_DOMAIN_INFO:I = 0x7

.field private static final BEAM_EVENT_IS_DISABLED_BY_USER:I = 0x6

.field private static final BEAM_EVENT_QUEUE_PAYLOAD:I = 0x1

.field private static final BEAM_EVENT_REMOVE_ALL_PAYLOADS:I = 0x3

.field private static final BEAM_EVENT_REMOVE_PAYLOAD:I = 0x2

.field private static final BEAM_EVENT_TICK:I = 0x4

.field private static final FIX_MULTIPLE_MESSAGE_BUG:Z = true

.field private static final IGNORE_MSG:[B

.field private static instance:Lcom/glu/android/GluBeam;

.field private static m_pendingMessages:[Landroid/nfc/NdefMessage;


# instance fields
.field private m_activity:Landroid/app/Activity;

.field private m_adapter:Landroid/nfc/NfcAdapter;

.field private m_incomingMessages:Ljava/util/Vector;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Vector",
            "<[B>;"
        }
    .end annotation
.end field

.field private m_listener:Lcom/glu/android/GluBeam$NFCListener;

.field private m_outgoingRecords:[Landroid/nfc/NdefRecord;

.field private m_outgoingSize:I

.field private m_overrideNDEFType:Ljava/lang/String;

.field private m_testPayload:[B

.field private m_trueRecords:Ljava/util/Hashtable;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Hashtable",
            "<",
            "Ljava/lang/Integer;",
            "Landroid/nfc/NdefRecord;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 2

    const/4 v1, 0x0

    :try_start_0
    const-string v0, "glubeam"

    invoke-static {v0}, Ljava/lang/System;->loadLibrary(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    :goto_0
    :try_start_1
    const-string v0, "glubeam_at"

    invoke-static {v0}, Ljava/lang/System;->loadLibrary(Ljava/lang/String;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    :goto_1
    sput-object v1, Lcom/glu/android/GluBeam;->instance:Lcom/glu/android/GluBeam;

    sput-object v1, Lcom/glu/android/GluBeam;->m_pendingMessages:[Landroid/nfc/NdefMessage;

    const/16 v0, 0x8

    new-array v0, v0, [B

    fill-array-data v0, :array_0

    sput-object v0, Lcom/glu/android/GluBeam;->IGNORE_MSG:[B

    return-void

    :catch_0
    move-exception v0

    goto :goto_1

    :catch_1
    move-exception v0

    goto :goto_0

    nop

    :array_0
    .array-data 1
        0x63t
        0x6ft
        0x6dt
        0x2et
        0x67t
        0x6ct
        0x75t
        0x2et
    .end array-data
.end method

.method private constructor <init>()V
    .locals 2

    const/4 v1, 0x0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object v1, p0, Lcom/glu/android/GluBeam;->m_activity:Landroid/app/Activity;

    iput-object v1, p0, Lcom/glu/android/GluBeam;->m_adapter:Landroid/nfc/NfcAdapter;

    new-instance v0, Ljava/util/Hashtable;

    invoke-direct {v0}, Ljava/util/Hashtable;-><init>()V

    iput-object v0, p0, Lcom/glu/android/GluBeam;->m_trueRecords:Ljava/util/Hashtable;

    new-instance v0, Ljava/util/Vector;

    invoke-direct {v0}, Ljava/util/Vector;-><init>()V

    iput-object v0, p0, Lcom/glu/android/GluBeam;->m_incomingMessages:Ljava/util/Vector;

    iput-object v1, p0, Lcom/glu/android/GluBeam;->m_outgoingRecords:[Landroid/nfc/NdefRecord;

    const/4 v0, 0x0

    iput v0, p0, Lcom/glu/android/GluBeam;->m_outgoingSize:I

    iput-object v1, p0, Lcom/glu/android/GluBeam;->m_overrideNDEFType:Ljava/lang/String;

    new-instance v0, Lcom/glu/android/GluBeam$NFCListener;

    invoke-direct {v0, p0}, Lcom/glu/android/GluBeam$NFCListener;-><init>(Lcom/glu/android/GluBeam;)V

    iput-object v0, p0, Lcom/glu/android/GluBeam;->m_listener:Lcom/glu/android/GluBeam$NFCListener;

    iput-object v1, p0, Lcom/glu/android/GluBeam;->m_testPayload:[B

    const-string v0, "Instance created..."

    invoke-static {v0}, Lcom/glu/android/GluBeam;->log(Ljava/lang/String;)V

    sget-object v0, Lcom/glu/android/GluBeam;->m_pendingMessages:[Landroid/nfc/NdefMessage;

    if-eqz v0, :cond_0

    sget-object v0, Lcom/glu/android/GluBeam;->m_pendingMessages:[Landroid/nfc/NdefMessage;

    invoke-direct {p0, v0}, Lcom/glu/android/GluBeam;->onMessagesReceivedI([Landroid/nfc/NdefMessage;)Z

    sput-object v1, Lcom/glu/android/GluBeam;->m_pendingMessages:[Landroid/nfc/NdefMessage;

    :cond_0
    return-void
.end method

.method static synthetic access$100(Lcom/glu/android/GluBeam;)[Landroid/nfc/NdefRecord;
    .locals 1

    iget-object v0, p0, Lcom/glu/android/GluBeam;->m_outgoingRecords:[Landroid/nfc/NdefRecord;

    return-object v0
.end method

.method static synthetic access$200(Lcom/glu/android/GluBeam;)I
    .locals 1

    iget v0, p0, Lcom/glu/android/GluBeam;->m_outgoingSize:I

    return v0
.end method

.method private addOutgoingRecord(I[B)V
    .locals 6

    const/4 v5, 0x0

    if-nez p2, :cond_0

    :goto_0
    return-void

    :cond_0
    iget-object v0, p0, Lcom/glu/android/GluBeam;->m_overrideNDEFType:Ljava/lang/String;

    if-nez v0, :cond_1

    iget-object v0, p0, Lcom/glu/android/GluBeam;->m_activity:Landroid/app/Activity;

    invoke-virtual {v0}, Landroid/app/Activity;->getApplication()Landroid/app/Application;

    move-result-object v0

    invoke-virtual {v0}, Landroid/app/Application;->getPackageName()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/glu/android/GluBeam;->m_overrideNDEFType:Ljava/lang/String;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "glu.com:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/glu/android/GluBeam;->m_overrideNDEFType:Ljava/lang/String;

    iget-object v2, p0, Lcom/glu/android/GluBeam;->m_overrideNDEFType:Ljava/lang/String;

    const/16 v3, 0x2e

    invoke-virtual {v2, v3}, Ljava/lang/String;->lastIndexOf(I)I

    move-result v2

    add-int/lit8 v2, v2, 0x1

    invoke-virtual {v1, v2}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/glu/android/GluBeam;->m_overrideNDEFType:Ljava/lang/String;

    :cond_1
    iget-object v0, p0, Lcom/glu/android/GluBeam;->m_trueRecords:Ljava/util/Hashtable;

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    new-instance v2, Landroid/nfc/NdefRecord;

    const/4 v3, 0x4

    iget-object v4, p0, Lcom/glu/android/GluBeam;->m_overrideNDEFType:Ljava/lang/String;

    invoke-static {v4}, Lcom/glu/android/GluBeam;->stringToByteArray(Ljava/lang/String;)[B

    move-result-object v4

    new-array v5, v5, [B

    invoke-direct {v2, v3, v4, v5, p2}, Landroid/nfc/NdefRecord;-><init>(S[B[B[B)V

    invoke-virtual {v0, v1, v2}, Ljava/util/Hashtable;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    invoke-direct {p0}, Lcom/glu/android/GluBeam;->resetRecordArray()V

    goto :goto_0
.end method

.method public static baStartsWith([B[B)Z
    .locals 4

    const/4 v1, 0x0

    array-length v0, p0

    array-length v2, p1

    if-ge v0, v2, :cond_1

    :cond_0
    :goto_0
    return v1

    :cond_1
    move v0, v1

    :goto_1
    array-length v2, p1

    if-ge v0, v2, :cond_2

    aget-byte v2, p0, v0

    aget-byte v3, p1, v0

    if-ne v2, v3, :cond_0

    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    :cond_2
    const/4 v1, 0x1

    goto :goto_0
.end method

.method public static beamEvent(II[B)I
    .locals 5

    const/4 v4, 0x0

    const/4 v1, 0x1

    const/4 v0, 0x0

    sget-object v2, Lcom/glu/android/GluBeam;->instance:Lcom/glu/android/GluBeam;

    if-nez v2, :cond_1

    :cond_0
    :goto_0
    return v0

    :cond_1
    if-ne p0, v1, :cond_2

    sget-object v0, Lcom/glu/android/GluBeam;->instance:Lcom/glu/android/GluBeam;

    invoke-direct {v0, p1, p2}, Lcom/glu/android/GluBeam;->addOutgoingRecord(I[B)V

    move v0, v1

    goto :goto_0

    :cond_2
    const/4 v2, 0x2

    if-ne p0, v2, :cond_3

    sget-object v1, Lcom/glu/android/GluBeam;->instance:Lcom/glu/android/GluBeam;

    invoke-direct {v1, p1}, Lcom/glu/android/GluBeam;->removeOutgoingRecord(I)V

    goto :goto_0

    :cond_3
    const/4 v2, 0x3

    if-ne p0, v2, :cond_4

    sget-object v1, Lcom/glu/android/GluBeam;->instance:Lcom/glu/android/GluBeam;

    invoke-direct {v1}, Lcom/glu/android/GluBeam;->removeAllOutgoingRecords()V

    goto :goto_0

    :cond_4
    const/4 v2, 0x4

    if-ne p0, v2, :cond_5

    sget-object v1, Lcom/glu/android/GluBeam;->instance:Lcom/glu/android/GluBeam;

    invoke-direct {v1, p1}, Lcom/glu/android/GluBeam;->tick(I)V

    goto :goto_0

    :cond_5
    const/4 v2, 0x5

    if-ne p0, v2, :cond_6

    sget-object v1, Lcom/glu/android/GluBeam;->instance:Lcom/glu/android/GluBeam;

    iget-object v1, v1, Lcom/glu/android/GluBeam;->m_adapter:Landroid/nfc/NfcAdapter;

    sget-object v2, Lcom/glu/android/GluBeam;->instance:Lcom/glu/android/GluBeam;

    iget-object v2, v2, Lcom/glu/android/GluBeam;->m_activity:Landroid/app/Activity;

    new-array v3, v0, [Landroid/app/Activity;

    invoke-virtual {v1, v4, v2, v3}, Landroid/nfc/NfcAdapter;->setNdefPushMessageCallback(Landroid/nfc/NfcAdapter$CreateNdefMessageCallback;Landroid/app/Activity;[Landroid/app/Activity;)V

    sget-object v1, Lcom/glu/android/GluBeam;->instance:Lcom/glu/android/GluBeam;

    iget-object v1, v1, Lcom/glu/android/GluBeam;->m_adapter:Landroid/nfc/NfcAdapter;

    sget-object v2, Lcom/glu/android/GluBeam;->instance:Lcom/glu/android/GluBeam;

    iget-object v2, v2, Lcom/glu/android/GluBeam;->m_activity:Landroid/app/Activity;

    new-array v3, v0, [Landroid/app/Activity;

    invoke-virtual {v1, v4, v2, v3}, Landroid/nfc/NfcAdapter;->setOnNdefPushCompleteCallback(Landroid/nfc/NfcAdapter$OnNdefPushCompleteCallback;Landroid/app/Activity;[Landroid/app/Activity;)V

    sput-object v4, Lcom/glu/android/GluBeam;->instance:Lcom/glu/android/GluBeam;

    goto :goto_0

    :cond_6
    const/4 v2, 0x6

    if-ne p0, v2, :cond_7

    sget-object v2, Lcom/glu/android/GluBeam;->instance:Lcom/glu/android/GluBeam;

    iget-object v2, v2, Lcom/glu/android/GluBeam;->m_adapter:Landroid/nfc/NfcAdapter;

    invoke-virtual {v2}, Landroid/nfc/NfcAdapter;->isEnabled()Z

    move-result v2

    if-nez v2, :cond_0

    move v0, v1

    goto :goto_0

    :cond_7
    const/4 v1, 0x7

    if-ne p0, v1, :cond_9

    if-eqz p2, :cond_8

    sget-object v1, Lcom/glu/android/GluBeam;->instance:Lcom/glu/android/GluBeam;

    new-instance v2, Ljava/lang/String;

    invoke-direct {v2, p2}, Ljava/lang/String;-><init>([B)V

    iput-object v2, v1, Lcom/glu/android/GluBeam;->m_overrideNDEFType:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Activity name set to: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    sget-object v2, Lcom/glu/android/GluBeam;->instance:Lcom/glu/android/GluBeam;

    iget-object v2, v2, Lcom/glu/android/GluBeam;->m_overrideNDEFType:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/glu/android/GluBeam;->log(Ljava/lang/String;)V

    goto :goto_0

    :cond_8
    const-string v1, "Failed to init outgoing domain info: It\'s null!"

    invoke-static {v1}, Lcom/glu/android/GluBeam;->log(Ljava/lang/String;)V

    goto/16 :goto_0

    :cond_9
    const/16 v1, 0x3e8

    if-lt p0, v1, :cond_0

    sget-object v1, Lcom/glu/android/GluBeam;->instance:Lcom/glu/android/GluBeam;

    invoke-direct {v1, p0, p1}, Lcom/glu/android/GluBeam;->debugEvent(II)V

    goto/16 :goto_0
.end method

.method public static final charArrayToByteArray([CZ)[B
    .locals 4

    const/4 v1, 0x0

    array-length v2, p0

    if-eqz p1, :cond_0

    const/4 v0, 0x1

    :goto_0
    add-int/2addr v0, v2

    new-array v2, v0, [B

    move v0, v1

    :goto_1
    array-length v3, p0

    if-ge v0, v3, :cond_1

    aget-char v3, p0, v0

    int-to-byte v3, v3

    aput-byte v3, v2, v0

    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    :cond_0
    move v0, v1

    goto :goto_0

    :cond_1
    if-eqz p1, :cond_2

    array-length v0, p0

    aput-byte v1, v2, v0

    :cond_2
    return-object v2
.end method

.method private createCustomLengthPayload(I)V
    .locals 3

    :try_start_0
    new-array v0, p1, [B

    iput-object v0, p0, Lcom/glu/android/GluBeam;->m_testPayload:[B

    new-instance v0, Ljava/util/Random;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    invoke-direct {v0, v1, v2}, Ljava/util/Random;-><init>(J)V

    iget-object v1, p0, Lcom/glu/android/GluBeam;->m_testPayload:[B

    invoke-virtual {v0, v1}, Ljava/util/Random;->nextBytes([B)V

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Created payload of size: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/glu/android/GluBeam;->log(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return-void

    :catch_0
    move-exception v0

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "OOM trying to create custom payload of size: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/glu/android/GluBeam;->log(Ljava/lang/String;)V

    goto :goto_0
.end method

.method private createHugePayload()V
    .locals 4

    const/high16 v0, 0x400000

    :cond_0
    :try_start_0
    new-array v1, v0, [B

    iput-object v1, p0, Lcom/glu/android/GluBeam;->m_testPayload:[B

    new-instance v1, Ljava/util/Random;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    invoke-direct {v1, v2, v3}, Ljava/util/Random;-><init>(J)V

    iget-object v2, p0, Lcom/glu/android/GluBeam;->m_testPayload:[B

    invoke-virtual {v1, v2}, Ljava/util/Random;->nextBytes([B)V

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Created payload of size: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/glu/android/GluBeam;->log(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    iget-object v1, p0, Lcom/glu/android/GluBeam;->m_testPayload:[B

    if-nez v1, :cond_1

    if-gtz v0, :cond_0

    :cond_1
    return-void

    :catch_0
    move-exception v1

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "OOM trying to create payload of size: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/glu/android/GluBeam;->log(Ljava/lang/String;)V

    const/4 v1, 0x0

    iput-object v1, p0, Lcom/glu/android/GluBeam;->m_testPayload:[B

    shr-int/lit8 v0, v0, 0x1

    goto :goto_0
.end method

.method private createUDIDPayload()V
    .locals 2

    iget-object v0, p0, Lcom/glu/android/GluBeam;->m_activity:Landroid/app/Activity;

    invoke-virtual {v0}, Landroid/app/Activity;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    const-string v1, "android_id"

    invoke-static {v0, v1}, Landroid/provider/Settings$Secure;->getString(Landroid/content/ContentResolver;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/glu/android/GluBeam;->stringToByteArray(Ljava/lang/String;)[B

    move-result-object v0

    iput-object v0, p0, Lcom/glu/android/GluBeam;->m_testPayload:[B

    return-void
.end method

.method private debugEvent(II)V
    .locals 2

    const/16 v0, 0x3e8

    if-ne p1, v0, :cond_2

    invoke-direct {p0}, Lcom/glu/android/GluBeam;->createHugePayload()V

    :cond_0
    :goto_0
    iget-object v0, p0, Lcom/glu/android/GluBeam;->m_testPayload:[B

    if-eqz v0, :cond_1

    const v0, -0x21524111

    iget-object v1, p0, Lcom/glu/android/GluBeam;->m_testPayload:[B

    invoke-direct {p0, v0, v1}, Lcom/glu/android/GluBeam;->addOutgoingRecord(I[B)V

    :cond_1
    return-void

    :cond_2
    const/16 v0, 0x3e9

    if-ne p1, v0, :cond_3

    invoke-direct {p0}, Lcom/glu/android/GluBeam;->createUDIDPayload()V

    goto :goto_0

    :cond_3
    const/16 v0, 0x3ea

    if-ne p1, v0, :cond_0

    invoke-direct {p0, p2}, Lcom/glu/android/GluBeam;->createCustomLengthPayload(I)V

    goto :goto_0
.end method

.method public static init(Landroid/app/Activity;)V
    .locals 5

    const/4 v4, 0x0

    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0xe

    if-ge v0, v1, :cond_0

    :goto_0
    return-void

    :cond_0
    new-instance v0, Lcom/glu/android/GluBeam;

    invoke-direct {v0}, Lcom/glu/android/GluBeam;-><init>()V

    sput-object v0, Lcom/glu/android/GluBeam;->instance:Lcom/glu/android/GluBeam;

    iput-object p0, v0, Lcom/glu/android/GluBeam;->m_activity:Landroid/app/Activity;

    sget-object v0, Lcom/glu/android/GluBeam;->instance:Lcom/glu/android/GluBeam;

    invoke-static {p0}, Landroid/nfc/NfcAdapter;->getDefaultAdapter(Landroid/content/Context;)Landroid/nfc/NfcAdapter;

    move-result-object v1

    iput-object v1, v0, Lcom/glu/android/GluBeam;->m_adapter:Landroid/nfc/NfcAdapter;

    sget-object v0, Lcom/glu/android/GluBeam;->instance:Lcom/glu/android/GluBeam;

    iget-object v0, v0, Lcom/glu/android/GluBeam;->m_adapter:Landroid/nfc/NfcAdapter;

    if-nez v0, :cond_1

    const/4 v0, 0x0

    sput-object v0, Lcom/glu/android/GluBeam;->instance:Lcom/glu/android/GluBeam;

    goto :goto_0

    :cond_1
    sget-object v0, Lcom/glu/android/GluBeam;->instance:Lcom/glu/android/GluBeam;

    iget-object v0, v0, Lcom/glu/android/GluBeam;->m_adapter:Landroid/nfc/NfcAdapter;

    sget-object v1, Lcom/glu/android/GluBeam;->instance:Lcom/glu/android/GluBeam;

    iget-object v1, v1, Lcom/glu/android/GluBeam;->m_listener:Lcom/glu/android/GluBeam$NFCListener;

    sget-object v2, Lcom/glu/android/GluBeam;->instance:Lcom/glu/android/GluBeam;

    iget-object v2, v2, Lcom/glu/android/GluBeam;->m_activity:Landroid/app/Activity;

    new-array v3, v4, [Landroid/app/Activity;

    invoke-virtual {v0, v1, v2, v3}, Landroid/nfc/NfcAdapter;->setNdefPushMessageCallback(Landroid/nfc/NfcAdapter$CreateNdefMessageCallback;Landroid/app/Activity;[Landroid/app/Activity;)V

    sget-object v0, Lcom/glu/android/GluBeam;->instance:Lcom/glu/android/GluBeam;

    iget-object v0, v0, Lcom/glu/android/GluBeam;->m_adapter:Landroid/nfc/NfcAdapter;

    sget-object v1, Lcom/glu/android/GluBeam;->instance:Lcom/glu/android/GluBeam;

    iget-object v1, v1, Lcom/glu/android/GluBeam;->m_listener:Lcom/glu/android/GluBeam$NFCListener;

    sget-object v2, Lcom/glu/android/GluBeam;->instance:Lcom/glu/android/GluBeam;

    iget-object v2, v2, Lcom/glu/android/GluBeam;->m_activity:Landroid/app/Activity;

    new-array v3, v4, [Landroid/app/Activity;

    invoke-virtual {v0, v1, v2, v3}, Landroid/nfc/NfcAdapter;->setOnNdefPushCompleteCallback(Landroid/nfc/NfcAdapter$OnNdefPushCompleteCallback;Landroid/app/Activity;[Landroid/app/Activity;)V

    goto :goto_0
.end method

.method public static log(Ljava/lang/String;)V
    .locals 0

    return-void
.end method

.method public static log(Ljava/lang/String;Ljava/lang/Throwable;)V
    .locals 0

    return-void
.end method

.method public static native onIncomingNFCDataReceived([B)Z
.end method

.method public static onMessagesReceived([Landroid/nfc/NdefMessage;)Z
    .locals 5

    const/4 v1, 0x0

    sget-object v0, Lcom/glu/android/GluBeam;->instance:Lcom/glu/android/GluBeam;

    if-nez v0, :cond_3

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    array-length v2, p0

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v2, " messages received."

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/glu/android/GluBeam;->log(Ljava/lang/String;)V

    sput-object p0, Lcom/glu/android/GluBeam;->m_pendingMessages:[Landroid/nfc/NdefMessage;

    move v0, v1

    :goto_0
    array-length v2, p0

    if-ge v0, v2, :cond_4

    aget-object v2, p0, v0

    invoke-virtual {v2}, Landroid/nfc/NdefMessage;->getRecords()[Landroid/nfc/NdefRecord;

    move-result-object v3

    if-eqz v3, :cond_1

    move v2, v1

    :goto_1
    array-length v4, v3

    if-ge v2, v4, :cond_0

    aget-object v4, v3, v2

    invoke-virtual {v4}, Landroid/nfc/NdefRecord;->getType()[B

    move-result-object v4

    if-eqz v4, :cond_2

    new-instance v2, Ljava/lang/String;

    invoke-direct {v2, v4}, Ljava/lang/String;-><init>([B)V

    sput-object v2, Lcom/glu/android/GluBeamReceiver;->MAIN_ACTIVITY:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Main activity: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    sget-object v3, Lcom/glu/android/GluBeamReceiver;->MAIN_ACTIVITY:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/glu/android/GluBeam;->log(Ljava/lang/String;)V

    :cond_0
    sget-object v2, Lcom/glu/android/GluBeamReceiver;->MAIN_ACTIVITY:Ljava/lang/String;

    if-nez v2, :cond_4

    :cond_1
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_2
    add-int/lit8 v2, v2, 0x1

    goto :goto_1

    :cond_3
    sget-object v0, Lcom/glu/android/GluBeam;->instance:Lcom/glu/android/GluBeam;

    invoke-direct {v0, p0}, Lcom/glu/android/GluBeam;->onMessagesReceivedI([Landroid/nfc/NdefMessage;)Z

    move-result v1

    :cond_4
    return v1
.end method

.method private onMessagesReceivedI([Landroid/nfc/NdefMessage;)Z
    .locals 7

    const/4 v1, 0x0

    move v0, v1

    :goto_0
    array-length v2, p1

    if-ge v0, v2, :cond_2

    aget-object v2, p1, v0

    invoke-virtual {v2}, Landroid/nfc/NdefMessage;->getRecords()[Landroid/nfc/NdefRecord;

    move-result-object v3

    if-eqz v3, :cond_1

    move v2, v1

    :goto_1
    array-length v4, v3

    if-ge v2, v4, :cond_1

    aget-object v4, v3, v2

    invoke-virtual {v4}, Landroid/nfc/NdefRecord;->getPayload()[B

    move-result-object v4

    if-eqz v4, :cond_0

    sget-object v5, Lcom/glu/android/GluBeam;->IGNORE_MSG:[B

    invoke-static {v4, v5}, Lcom/glu/android/GluBeam;->baStartsWith([B[B)Z

    move-result v5

    if-nez v5, :cond_0

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "Adding record of length: "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    array-length v6, v4

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v5}, Lcom/glu/android/GluBeam;->log(Ljava/lang/String;)V

    const-string v5, "Record"

    invoke-static {v5, v4}, Lcom/glu/android/GluBeamUtil;->printHexDump(Ljava/lang/String;[B)V

    iget-object v5, p0, Lcom/glu/android/GluBeam;->m_incomingMessages:Ljava/util/Vector;

    invoke-virtual {v5, v4}, Ljava/util/Vector;->addElement(Ljava/lang/Object;)V

    :cond_0
    add-int/lit8 v2, v2, 0x1

    goto :goto_1

    :cond_1
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_2
    const/4 v0, 0x1

    return v0
.end method

.method private removeAllOutgoingRecords()V
    .locals 1

    iget-object v0, p0, Lcom/glu/android/GluBeam;->m_trueRecords:Ljava/util/Hashtable;

    invoke-virtual {v0}, Ljava/util/Hashtable;->clear()V

    invoke-direct {p0}, Lcom/glu/android/GluBeam;->resetRecordArray()V

    return-void
.end method

.method private removeOutgoingRecord(I)V
    .locals 3

    const/4 v2, 0x0

    iget-object v0, p0, Lcom/glu/android/GluBeam;->m_trueRecords:Ljava/util/Hashtable;

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/util/Hashtable;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    if-nez v0, :cond_0

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "No record to remove: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/glu/android/GluBeam;->log(Ljava/lang/String;)V

    :goto_0
    invoke-direct {p0}, Lcom/glu/android/GluBeam;->resetRecordArray()V

    return-void

    :cond_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Removed record at: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/glu/android/GluBeam;->log(Ljava/lang/String;)V

    goto :goto_0
.end method

.method private resetRecordArray()V
    .locals 7

    const/4 v2, 0x0

    iget-object v0, p0, Lcom/glu/android/GluBeam;->m_trueRecords:Ljava/util/Hashtable;

    invoke-virtual {v0}, Ljava/util/Hashtable;->size()I

    move-result v3

    if-gtz v3, :cond_0

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/glu/android/GluBeam;->m_outgoingRecords:[Landroid/nfc/NdefRecord;

    :goto_0
    return-void

    :cond_0
    add-int/lit8 v0, v3, 0x1

    new-array v4, v0, [Landroid/nfc/NdefRecord;

    iget-object v0, p0, Lcom/glu/android/GluBeam;->m_trueRecords:Ljava/util/Hashtable;

    invoke-virtual {v0}, Ljava/util/Hashtable;->keySet()Ljava/util/Set;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v5

    move v1, v2

    :goto_1
    invoke-interface {v5}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-interface {v5}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Integer;

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    iget-object v6, p0, Lcom/glu/android/GluBeam;->m_trueRecords:Ljava/util/Hashtable;

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    invoke-virtual {v6, v0}, Ljava/util/Hashtable;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/nfc/NdefRecord;

    aput-object v0, v4, v2

    aget-object v0, v4, v2

    invoke-virtual {v0}, Landroid/nfc/NdefRecord;->getPayload()[B

    move-result-object v0

    array-length v0, v0

    add-int/lit8 v0, v0, 0x3

    add-int/2addr v0, v1

    move v1, v0

    goto :goto_1

    :cond_1
    iget-object v0, p0, Lcom/glu/android/GluBeam;->m_activity:Landroid/app/Activity;

    invoke-virtual {v0}, Landroid/app/Activity;->getApplication()Landroid/app/Application;

    move-result-object v0

    invoke-virtual {v0}, Landroid/app/Application;->getPackageName()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Landroid/nfc/NdefRecord;->createApplicationRecord(Ljava/lang/String;)Landroid/nfc/NdefRecord;

    move-result-object v0

    aput-object v0, v4, v3

    iput-object v4, p0, Lcom/glu/android/GluBeam;->m_outgoingRecords:[Landroid/nfc/NdefRecord;

    iput v1, p0, Lcom/glu/android/GluBeam;->m_outgoingSize:I

    goto :goto_0
.end method

.method public static final stringToByteArray(Ljava/lang/String;)[B
    .locals 2

    invoke-virtual {p0}, Ljava/lang/String;->toCharArray()[C

    move-result-object v0

    const/4 v1, 0x0

    invoke-static {v0, v1}, Lcom/glu/android/GluBeam;->charArrayToByteArray([CZ)[B

    move-result-object v0

    return-object v0
.end method

.method private tick(I)V
    .locals 3

    iget-object v2, p0, Lcom/glu/android/GluBeam;->m_incomingMessages:Ljava/util/Vector;

    monitor-enter v2

    :try_start_0
    iget-object v0, p0, Lcom/glu/android/GluBeam;->m_incomingMessages:Ljava/util/Vector;

    invoke-virtual {v0}, Ljava/util/Vector;->size()I

    move-result v0

    if-lez v0, :cond_0

    const/4 v1, 0x0

    :goto_0
    iget-object v0, p0, Lcom/glu/android/GluBeam;->m_incomingMessages:Ljava/util/Vector;

    invoke-virtual {v0}, Ljava/util/Vector;->size()I

    move-result v0

    if-ge v1, v0, :cond_0

    iget-object v0, p0, Lcom/glu/android/GluBeam;->m_incomingMessages:Ljava/util/Vector;

    invoke-virtual {v0, v1}, Ljava/util/Vector;->elementAt(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [B

    invoke-static {v0}, Lcom/glu/android/GluBeam;->onIncomingNFCDataReceived([B)Z

    move-result v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/glu/android/GluBeam;->m_incomingMessages:Ljava/util/Vector;

    invoke-virtual {v0, v1}, Ljava/util/Vector;->removeElementAt(I)V

    add-int/lit8 v0, v1, -0x1

    :goto_1
    add-int/lit8 v1, v0, 0x1

    goto :goto_0

    :cond_0
    monitor-exit v2
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    return-void

    :catchall_0
    move-exception v0

    monitor-exit v2

    throw v0

    :cond_1
    move v0, v1

    goto :goto_1
.end method
