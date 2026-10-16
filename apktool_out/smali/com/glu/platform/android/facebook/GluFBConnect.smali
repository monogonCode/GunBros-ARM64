.class public Lcom/glu/platform/android/facebook/GluFBConnect;
.super Ljava/lang/Thread;

# interfaces
.implements Lcom/facebook/android/Facebook$DialogListener;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/glu/platform/android/facebook/GluFBConnect$FBItem;
    }
.end annotation


# static fields
.field public static final CNGS_CONNECTION_COMPLETE:I = 0x2

.field public static final CNGS_CONNECTION_CONNECTING:I = 0x1

.field public static final CNGS_CONNECTION_FAIL:I = 0x3

.field public static final CNGS_CONNECTION_IDLE:I = 0x0

.field public static final CNSG_CONNECTION_CANCEL:I = 0x4

.field public static final FACEBOOK_DIALOG_CANCELLED:I = 0x2

.field public static final FACEBOOK_DIALOG_FAILURE:I = 0x3

.field public static final FACEBOOK_DIALOG_SUCCESS:I = 0x1

.field public static final FACEBOOK_EVENT_FREE_ALL_FRIEND_PICS:I = 0x9

.field public static final FACEBOOK_EVENT_LOGIN:I = 0x1

.field public static final FACEBOOK_EVENT_LOGOUT:I = 0x2

.field public static final FACEBOOK_EVENT_QUEUE_FEED_BODY:I = 0xc

.field public static final FACEBOOK_EVENT_QUEUE_FEED_CAPTION:I = 0x17

.field public static final FACEBOOK_EVENT_QUEUE_FEED_HEADER:I = 0xb

.field public static final FACEBOOK_EVENT_QUEUE_FEED_PROMPT:I = 0xa

.field public static final FACEBOOK_EVENT_QUEUE_FRIEND_CAPTION:I = 0x18

.field public static final FACEBOOK_EVENT_QUEUE_FRIEND_IMAGE_URL:I = 0x12

.field public static final FACEBOOK_EVENT_QUEUE_FRIEND_LINK:I = 0x10

.field public static final FACEBOOK_EVENT_QUEUE_FRIEND_MESSAGE:I = 0xe

.field public static final FACEBOOK_EVENT_QUEUE_FRIEND_TEXT_FOR_LINK:I = 0x11

.field public static final FACEBOOK_EVENT_QUEUE_FRIEND_UID:I = 0xf

.field public static final FACEBOOK_EVENT_REQUEST_FRIEND_NAME_FROM_UID:I = 0x14

.field public static final FACEBOOK_EVENT_REQUEST_FRIEND_PICS:I = 0x8

.field public static final FACEBOOK_EVENT_REQUEST_LOAD_FRIENDS:I = 0x6

.field public static final FACEBOOK_EVENT_REQUEST_USER_INFO:I = 0x3

.field public static final FACEBOOK_EVENT_SEND_FEED:I = 0x4

.field public static final FACEBOOK_EVENT_SEND_INVITE:I = 0x5

.field public static final FACEBOOK_EVENT_SET_APP_ID:I = 0x7

.field public static final FACEBOOK_EVENT_SET_NEXT_FRIEND_REQUEST_SIZE:I = 0x15

.field public static final FACEBOOK_EVENT_SET_OK_TO_LOGIN_TO_FACEBOOK:I = 0x19

.field public static final FACEBOOK_EVENT_SET_SECRET_ID:I = 0x16

.field public static final FACEBOOK_EVENT_SUBMIT_QUEUED_FEED:I = 0xd

.field public static final FACEBOOK_EVENT_SUBMIT_QUEUED_FRIEND_FEED:I = 0x13

.field public static final FACEBOOK_FL_NAME_INDEX:I = 0x1

.field public static final FACEBOOK_FL_UID_INDEX:I = 0x0

.field public static final FACEBOOK_LOGIN_LOGGED_IN:I = 0x1

.field public static final FACEBOOK_LOGIN_LOGGED_OUT:I = 0x4

.field public static final FACEBOOK_LOGIN_LOGGING_IN:I = 0x2

.field public static final FACEBOOK_LOGIN_LOGGING_OUT:I = 0x3

.field public static final FACEBOOK_LOGIN_LOGIN_FAILED:I = 0x5

.field public static final FACEBOOK_LOGIN_LOGOUT_FAILED:I = 0x6

.field public static final FACEBOOK_LOGIN_POSTING_TO_WALL:I = 0x7

.field public static final FACEBOOK_NUM_FL_INDEXES:I = 0x2

.field public static final FB_CHECK_FILE:Ljava/lang/String; = "fbcheck230"

.field public static FIVE_THOUSAND_FRIENDS_TEST:Z = false

.field public static final FIVE_THOUSAND_NAMES:[Ljava/lang/String;

.field public static final FIVE_THOUSAND_UIDS:[J

.field private static final MESSAGE_SUBMIT_QUEUED_FEED:I = 0x1

.field private static final MESSAGE_SUBMIT_QUEUED_FRIEND_MESSAGE:I = 0x2

.field public static final NATIVE_FACEBOOK_EVENT_DIALOG_STATUS:I = 0x5

.field public static final NATIVE_FACEBOOK_EVENT_ERROR_CODE:I = 0x1

.field public static final NATIVE_FACEBOOK_EVENT_ERROR_DESCRIPTION:I = 0x2

.field public static final NATIVE_FACEBOOK_EVENT_ERROR_REASON:I = 0x3

.field public static final NATIVE_FACEBOOK_EVENT_LOAD_FRIENDS:I = 0x9

.field public static final NATIVE_FACEBOOK_EVENT_LOGIN_STATUS:I = 0x4

.field public static final NATIVE_FACEBOOK_EVENT_REPORT_FRIEND_NAME:I = 0xa

.field public static final NATIVE_FACEBOOK_EVENT_REPORT_SID:I = 0x7

.field public static final NATIVE_FACEBOOK_EVENT_REPORT_UID:I = 0x6

.field public static final NATIVE_FACEBOOK_EVENT_REPORT_USERNAME:I = 0x8

.field public static final NGS_TEMP_FILES:[Ljava/lang/String;

.field public static instance:Lcom/glu/platform/android/facebook/GluFBConnect;

.field public static m_connectionState:I

.field public static m_facebookState:I

.field public static sm_actualHeight:I

.field public static sm_actualWidth:I


# instance fields
.field public RUNNING:Z

.field private m_appID:Ljava/lang/String;

.field public m_body:Ljava/lang/String;

.field public m_facebook:Lcom/facebook/android/Facebook;

.field public m_friendInfo:[Ljava/lang/String;

.field public m_friendLink:Ljava/lang/String;

.field public m_friendLinkImageURL:Ljava/lang/String;

.field public m_friendLinkText:Ljava/lang/String;

.field public m_friendMessage:Ljava/lang/String;

.field public m_friendRequestQueue:Ljava/util/Vector;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Vector",
            "<",
            "Lcom/glu/platform/android/facebook/GluFBConnect$FBItem;",
            ">;"
        }
    .end annotation
.end field

.field public m_friendUID:Ljava/lang/String;

.field private m_getUserInfoRunner:Lcom/facebook/android/AsyncFacebookRunner;

.field public m_header:Ljava/lang/String;

.field private m_loadFriendsRunner:Lcom/facebook/android/AsyncFacebookRunner;

.field public m_nextImageSize:Ljava/lang/String;

.field public m_prompt:Ljava/lang/String;

.field public m_quickAccessFriendInfo:Ljava/util/Hashtable;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Hashtable",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private m_secretID:Ljava/lang/String;

.field private m_viewManipulationHandler:Landroid/os/Handler;


# direct methods
.method static constructor <clinit>()V
    .locals 7

    const/16 v6, 0x19

    const/4 v5, 0x3

    const/4 v4, 0x2

    const/4 v3, 0x0

    const/4 v2, 0x1

    sput v2, Lcom/glu/platform/android/facebook/GluFBConnect;->sm_actualWidth:I

    sput v2, Lcom/glu/platform/android/facebook/GluFBConnect;->sm_actualHeight:I

    sput-boolean v3, Lcom/glu/platform/android/facebook/GluFBConnect;->FIVE_THOUSAND_FRIENDS_TEST:Z

    const/4 v0, 0x0

    sput-object v0, Lcom/glu/platform/android/facebook/GluFBConnect;->instance:Lcom/glu/platform/android/facebook/GluFBConnect;

    new-array v0, v5, [Ljava/lang/String;

    const-string v1, "Credentials.dat"

    aput-object v1, v0, v3

    const-string v1, "ActiveCred.dat"

    aput-object v1, v0, v2

    const-string v1, "Session.dat"

    aput-object v1, v0, v4

    sput-object v0, Lcom/glu/platform/android/facebook/GluFBConnect;->NGS_TEMP_FILES:[Ljava/lang/String;

    new-array v0, v6, [J

    fill-array-data v0, :array_0

    sput-object v0, Lcom/glu/platform/android/facebook/GluFBConnect;->FIVE_THOUSAND_UIDS:[J

    new-array v0, v6, [Ljava/lang/String;

    const-string v1, "Lori Cox Glu"

    aput-object v1, v0, v3

    const-string v1, "Thomas Glu"

    aput-object v1, v0, v2

    const-string v1, "Nikita Glu Kupriyanov"

    aput-object v1, v0, v4

    const-string v1, "Spark Glu"

    aput-object v1, v0, v5

    const/4 v1, 0x4

    const-string v2, "Glufour Fbtester"

    aput-object v2, v0, v1

    const/4 v1, 0x5

    const-string v2, "Gluten Fbtester"

    aput-object v2, v0, v1

    const/4 v1, 0x6

    const-string v2, "Glutwo Fbtester"

    aput-object v2, v0, v1

    const/4 v1, 0x7

    const-string v2, "Gluone Fbtester"

    aput-object v2, v0, v1

    const/16 v1, 0x8

    const-string v2, "Gluthree Fbtester"

    aput-object v2, v0, v1

    const/16 v1, 0x9

    const-string v2, "Glufive Fbtester"

    aput-object v2, v0, v1

    const/16 v1, 0xa

    const-string v2, "Atom Fbtester"

    aput-object v2, v0, v1

    const/16 v1, 0xb

    const-string v2, "Atom Tester"

    aput-object v2, v0, v1

    const/16 v1, 0xc

    const-string v2, "Noah Glu"

    aput-object v2, v0, v1

    const/16 v1, 0xd

    const-string v2, "Thunder Cracker"

    aput-object v2, v0, v1

    const/16 v1, 0xe

    const-string v2, "Lingzhi Glu"

    aput-object v2, v0, v1

    const/16 v1, 0xf

    const-string v2, "Tf-tracks Glu"

    aput-object v2, v0, v1

    const/16 v1, 0x10

    const-string v2, "FB-Cosmos Glu"

    aput-object v2, v0, v1

    const/16 v1, 0x11

    const-string v2, "Adam Ellington"

    aput-object v2, v0, v1

    const/16 v1, 0x12

    const-string v2, "FB-Mirage Glu"

    aput-object v2, v0, v1

    const/16 v1, 0x13

    const-string v2, "FB-Warpath Glu"

    aput-object v2, v0, v1

    const/16 v1, 0x14

    const-string v2, "Tf-grimlock Glu"

    aput-object v2, v0, v1

    const/16 v1, 0x15

    const-string v2, "FB-Defensor Glu"

    aput-object v2, v0, v1

    const/16 v1, 0x16

    const-string v2, "David Jimenez"

    aput-object v2, v0, v1

    const/16 v1, 0x17

    const-string v2, "Glu Francisco"

    aput-object v2, v0, v1

    const/16 v1, 0x18

    const-string v2, "Duff Glu"

    aput-object v2, v0, v1

    sput-object v0, Lcom/glu/platform/android/facebook/GluFBConnect;->FIVE_THOUSAND_NAMES:[Ljava/lang/String;

    return-void

    nop

    :array_0
    .array-data 8
        0x5a9b4c7a
        0x5bdb8722
        0x5d41f924
        0x60e829a0
        0x66874a57
        0x669072c6
        0x66b33c34
        0x67637999
        0x68df6b4d
        0x6a0e753f
        0x5af32d1e41f8L
        0x5af32e0b6113L
        0x5af331ab078bL
        0x5af338c2d143L
        0x5af368826de1L
        0x5af371365149L    # 4.94073664220007E-310
        0x5af377cd2fbeL
        0x5af378c4e1caL
        0x5af378e13357L
        0x5af379caa384L
        0x5af37b5d7384L
        0x5af37cc881b8L
        0x5af3882b52ffL
        0x5af3960436c1L
        0x5af396511fb9L
    .end array-data
.end method

.method public constructor <init>()V
    .locals 3

    const/4 v2, 0x0

    const/4 v1, 0x0

    invoke-direct {p0}, Ljava/lang/Thread;-><init>()V

    iput-object v1, p0, Lcom/glu/platform/android/facebook/GluFBConnect;->m_facebook:Lcom/facebook/android/Facebook;

    iput-object v1, p0, Lcom/glu/platform/android/facebook/GluFBConnect;->m_appID:Ljava/lang/String;

    iput-object v1, p0, Lcom/glu/platform/android/facebook/GluFBConnect;->m_secretID:Ljava/lang/String;

    iput-object v1, p0, Lcom/glu/platform/android/facebook/GluFBConnect;->m_friendInfo:[Ljava/lang/String;

    new-instance v0, Ljava/util/Hashtable;

    invoke-direct {v0}, Ljava/util/Hashtable;-><init>()V

    iput-object v0, p0, Lcom/glu/platform/android/facebook/GluFBConnect;->m_quickAccessFriendInfo:Ljava/util/Hashtable;

    iput-object v1, p0, Lcom/glu/platform/android/facebook/GluFBConnect;->m_loadFriendsRunner:Lcom/facebook/android/AsyncFacebookRunner;

    iput-object v1, p0, Lcom/glu/platform/android/facebook/GluFBConnect;->m_getUserInfoRunner:Lcom/facebook/android/AsyncFacebookRunner;

    iput-object v1, p0, Lcom/glu/platform/android/facebook/GluFBConnect;->m_prompt:Ljava/lang/String;

    iput-object v1, p0, Lcom/glu/platform/android/facebook/GluFBConnect;->m_header:Ljava/lang/String;

    iput-object v1, p0, Lcom/glu/platform/android/facebook/GluFBConnect;->m_body:Ljava/lang/String;

    iput-object v1, p0, Lcom/glu/platform/android/facebook/GluFBConnect;->m_friendMessage:Ljava/lang/String;

    iput-object v1, p0, Lcom/glu/platform/android/facebook/GluFBConnect;->m_friendUID:Ljava/lang/String;

    iput-object v1, p0, Lcom/glu/platform/android/facebook/GluFBConnect;->m_friendLink:Ljava/lang/String;

    iput-object v1, p0, Lcom/glu/platform/android/facebook/GluFBConnect;->m_friendLinkText:Ljava/lang/String;

    iput-object v1, p0, Lcom/glu/platform/android/facebook/GluFBConnect;->m_friendLinkImageURL:Ljava/lang/String;

    new-instance v0, Lcom/glu/platform/android/facebook/GluFBConnect$3;

    invoke-direct {v0, p0}, Lcom/glu/platform/android/facebook/GluFBConnect$3;-><init>(Lcom/glu/platform/android/facebook/GluFBConnect;)V

    iput-object v0, p0, Lcom/glu/platform/android/facebook/GluFBConnect;->m_viewManipulationHandler:Landroid/os/Handler;

    iput-boolean v2, p0, Lcom/glu/platform/android/facebook/GluFBConnect;->RUNNING:Z

    new-instance v0, Ljava/util/Vector;

    invoke-direct {v0}, Ljava/util/Vector;-><init>()V

    iput-object v0, p0, Lcom/glu/platform/android/facebook/GluFBConnect;->m_friendRequestQueue:Ljava/util/Vector;

    const-string v0, "small"

    iput-object v0, p0, Lcom/glu/platform/android/facebook/GluFBConnect;->m_nextImageSize:Ljava/lang/String;

    sget-boolean v0, Lcom/glu/platform/android/facebook/GluFBConnect;->FIVE_THOUSAND_FRIENDS_TEST:Z

    if-eqz v0, :cond_0

    const-string v0, "Set FIVE_THOUSAND_FRIENDS_TEST to false."

    invoke-static {v0}, Lcom/glu/platform/android/facebook/Debug;->relDie(Ljava/lang/String;)V

    :cond_0
    sput-object p0, Lcom/glu/platform/android/facebook/GluFBConnect;->instance:Lcom/glu/platform/android/facebook/GluFBConnect;

    sput v2, Lcom/glu/platform/android/facebook/GluFBConnect;->m_connectionState:I

    const/4 v0, 0x4

    sput v0, Lcom/glu/platform/android/facebook/GluFBConnect;->m_facebookState:I

    return-void
.end method

.method static synthetic access$002(Lcom/glu/platform/android/facebook/GluFBConnect;Lcom/facebook/android/AsyncFacebookRunner;)Lcom/facebook/android/AsyncFacebookRunner;
    .locals 0

    iput-object p1, p0, Lcom/glu/platform/android/facebook/GluFBConnect;->m_loadFriendsRunner:Lcom/facebook/android/AsyncFacebookRunner;

    return-object p1
.end method

.method static synthetic access$102(Lcom/glu/platform/android/facebook/GluFBConnect;Lcom/facebook/android/AsyncFacebookRunner;)Lcom/facebook/android/AsyncFacebookRunner;
    .locals 0

    iput-object p1, p0, Lcom/glu/platform/android/facebook/GluFBConnect;->m_getUserInfoRunner:Lcom/facebook/android/AsyncFacebookRunner;

    return-object p1
.end method

.method public static createFBCanLoginFile()V
    .locals 3

    new-instance v0, Ljava/io/File;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-static {}, Lcom/glu/platform/android/facebook/GluUtil;->getSecureSaveDirectory()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "fbcheck230"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    :try_start_0
    new-instance v1, Ljava/io/FileOutputStream;

    const/4 v2, 0x0

    invoke-direct {v1, v0, v2}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;Z)V

    const/4 v0, 0x0

    invoke-virtual {v1, v0}, Ljava/io/FileOutputStream;->write(I)V

    invoke-virtual {v1}, Ljava/io/FileOutputStream;->close()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return-void

    :catch_0
    move-exception v0

    invoke-static {}, Lcom/glu/platform/android/facebook/Debug;->log$552c4e01()V

    goto :goto_0
.end method

.method private deleteSingleUserFile(Ljava/lang/String;Ljava/lang/String;)V
    .locals 3

    new-instance v0, Ljava/io/File;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ".png"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0}, Ljava/io/File;->delete()Z

    new-instance v0, Ljava/io/File;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ".jpg"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0}, Ljava/io/File;->delete()Z

    return-void
.end method

.method private displayPostingToWallFailureModal()V
    .locals 0

    return-void
.end method

.method public static facebookEvent(II[B[C)V
    .locals 5

    const/4 v4, 0x3

    const/4 v3, 0x2

    const/4 v0, 0x0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "in facebookEvent event:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    invoke-static {}, Lcom/glu/platform/android/facebook/Debug;->log$552c4e01()V

    const/4 v1, 0x1

    if-ne p0, v1, :cond_1

    sget-object v0, Lcom/glu/platform/android/GluPlatformActivity;->instance:Lcom/glu/platform/android/GluPlatformActivity;

    iget-object v0, v0, Lcom/glu/platform/android/GluPlatformActivity;->m_Terminator:Landroid/os/Handler;

    invoke-virtual {v0, v3}, Landroid/os/Handler;->sendEmptyMessage(I)Z

    :cond_0
    :goto_0
    return-void

    :cond_1
    if-ne p0, v3, :cond_2

    sget-object v0, Lcom/glu/platform/android/GluPlatformActivity;->instance:Lcom/glu/platform/android/GluPlatformActivity;

    iget-object v0, v0, Lcom/glu/platform/android/GluPlatformActivity;->m_Terminator:Landroid/os/Handler;

    invoke-virtual {v0, v4}, Landroid/os/Handler;->sendEmptyMessage(I)Z

    goto :goto_0

    :cond_2
    if-eq p0, v4, :cond_0

    const/4 v1, 0x6

    if-ne p0, v1, :cond_3

    sget-object v0, Lcom/glu/platform/android/facebook/GluFBConnect;->instance:Lcom/glu/platform/android/facebook/GluFBConnect;

    invoke-virtual {v0}, Lcom/glu/platform/android/facebook/GluFBConnect;->loadFriends()V

    goto :goto_0

    :cond_3
    const/4 v1, 0x4

    if-eq p0, v1, :cond_0

    const/4 v1, 0x5

    if-eq p0, v1, :cond_0

    const/4 v1, 0x7

    if-ne p0, v1, :cond_4

    invoke-static {}, Lcom/glu/platform/android/facebook/Debug;->log$552c4e01()V

    sget-object v0, Lcom/glu/platform/android/facebook/GluFBConnect;->instance:Lcom/glu/platform/android/facebook/GluFBConnect;

    const-string v1, "175053615859789"

    invoke-virtual {v0, v1}, Lcom/glu/platform/android/facebook/GluFBConnect;->setAppID(Ljava/lang/String;)V

    invoke-static {}, Lcom/glu/platform/android/facebook/Debug;->log$552c4e01()V

    goto :goto_0

    :cond_4
    const/16 v1, 0x8

    if-ne p0, v1, :cond_5

    sget-object v0, Lcom/glu/platform/android/facebook/GluFBConnect;->instance:Lcom/glu/platform/android/facebook/GluFBConnect;

    new-instance v1, Ljava/lang/String;

    invoke-direct {v1, p3}, Ljava/lang/String;-><init>([C)V

    invoke-virtual {v0, v1}, Lcom/glu/platform/android/facebook/GluFBConnect;->requestFriendPicsStartingWith(Ljava/lang/String;)V

    goto :goto_0

    :cond_5
    const/16 v1, 0x9

    if-ne p0, v1, :cond_6

    sget-object v0, Lcom/glu/platform/android/facebook/GluFBConnect;->instance:Lcom/glu/platform/android/facebook/GluFBConnect;

    invoke-virtual {v0}, Lcom/glu/platform/android/facebook/GluFBConnect;->freeAllFriendPics()V

    goto :goto_0

    :cond_6
    const/16 v1, 0xa

    if-ne p0, v1, :cond_8

    sget-object v1, Lcom/glu/platform/android/facebook/GluFBConnect;->instance:Lcom/glu/platform/android/facebook/GluFBConnect;

    if-nez p3, :cond_7

    :goto_1
    invoke-virtual {v1, v0}, Lcom/glu/platform/android/facebook/GluFBConnect;->queueFeedPrompt(Ljava/lang/String;)V

    goto :goto_0

    :cond_7
    new-instance v0, Ljava/lang/String;

    invoke-direct {v0, p3}, Ljava/lang/String;-><init>([C)V

    goto :goto_1

    :cond_8
    const/16 v1, 0xb

    if-ne p0, v1, :cond_a

    sget-object v1, Lcom/glu/platform/android/facebook/GluFBConnect;->instance:Lcom/glu/platform/android/facebook/GluFBConnect;

    if-nez p3, :cond_9

    :goto_2
    invoke-virtual {v1, v0}, Lcom/glu/platform/android/facebook/GluFBConnect;->queueFeedHeader(Ljava/lang/String;)V

    goto :goto_0

    :cond_9
    new-instance v0, Ljava/lang/String;

    invoke-direct {v0, p3}, Ljava/lang/String;-><init>([C)V

    goto :goto_2

    :cond_a
    const/16 v1, 0xc

    if-ne p0, v1, :cond_c

    sget-object v1, Lcom/glu/platform/android/facebook/GluFBConnect;->instance:Lcom/glu/platform/android/facebook/GluFBConnect;

    if-nez p3, :cond_b

    :goto_3
    invoke-virtual {v1, v0}, Lcom/glu/platform/android/facebook/GluFBConnect;->queueFeedBody(Ljava/lang/String;)V

    goto :goto_0

    :cond_b
    new-instance v0, Ljava/lang/String;

    invoke-direct {v0, p3}, Ljava/lang/String;-><init>([C)V

    goto :goto_3

    :cond_c
    const/16 v1, 0xd

    if-ne p0, v1, :cond_d

    sget-object v0, Lcom/glu/platform/android/facebook/GluFBConnect;->instance:Lcom/glu/platform/android/facebook/GluFBConnect;

    invoke-virtual {v0}, Lcom/glu/platform/android/facebook/GluFBConnect;->submitQueuedFeed()V

    goto/16 :goto_0

    :cond_d
    const/16 v1, 0xe

    if-ne p0, v1, :cond_f

    sget-object v1, Lcom/glu/platform/android/facebook/GluFBConnect;->instance:Lcom/glu/platform/android/facebook/GluFBConnect;

    if-nez p3, :cond_e

    :goto_4
    invoke-virtual {v1, v0}, Lcom/glu/platform/android/facebook/GluFBConnect;->queueFriendMessage(Ljava/lang/String;)V

    goto/16 :goto_0

    :cond_e
    new-instance v0, Ljava/lang/String;

    invoke-direct {v0, p3}, Ljava/lang/String;-><init>([C)V

    goto :goto_4

    :cond_f
    const/16 v1, 0xf

    if-ne p0, v1, :cond_11

    sget-object v1, Lcom/glu/platform/android/facebook/GluFBConnect;->instance:Lcom/glu/platform/android/facebook/GluFBConnect;

    if-nez p3, :cond_10

    :goto_5
    invoke-virtual {v1, v0}, Lcom/glu/platform/android/facebook/GluFBConnect;->queueFriendUID(Ljava/lang/String;)V

    goto/16 :goto_0

    :cond_10
    new-instance v0, Ljava/lang/String;

    invoke-direct {v0, p3}, Ljava/lang/String;-><init>([C)V

    goto :goto_5

    :cond_11
    const/16 v1, 0x10

    if-ne p0, v1, :cond_13

    sget-object v1, Lcom/glu/platform/android/facebook/GluFBConnect;->instance:Lcom/glu/platform/android/facebook/GluFBConnect;

    if-nez p3, :cond_12

    :goto_6
    invoke-virtual {v1, v0}, Lcom/glu/platform/android/facebook/GluFBConnect;->queueFriendLink(Ljava/lang/String;)V

    goto/16 :goto_0

    :cond_12
    new-instance v0, Ljava/lang/String;

    invoke-direct {v0, p3}, Ljava/lang/String;-><init>([C)V

    goto :goto_6

    :cond_13
    const/16 v1, 0x11

    if-ne p0, v1, :cond_15

    sget-object v1, Lcom/glu/platform/android/facebook/GluFBConnect;->instance:Lcom/glu/platform/android/facebook/GluFBConnect;

    if-nez p3, :cond_14

    :goto_7
    invoke-virtual {v1, v0}, Lcom/glu/platform/android/facebook/GluFBConnect;->queueFriendLinkText(Ljava/lang/String;)V

    goto/16 :goto_0

    :cond_14
    new-instance v0, Ljava/lang/String;

    invoke-direct {v0, p3}, Ljava/lang/String;-><init>([C)V

    goto :goto_7

    :cond_15
    const/16 v1, 0x12

    if-ne p0, v1, :cond_17

    sget-object v1, Lcom/glu/platform/android/facebook/GluFBConnect;->instance:Lcom/glu/platform/android/facebook/GluFBConnect;

    if-nez p3, :cond_16

    :goto_8
    invoke-virtual {v1, v0}, Lcom/glu/platform/android/facebook/GluFBConnect;->queueFriendImageURL(Ljava/lang/String;)V

    goto/16 :goto_0

    :cond_16
    new-instance v0, Ljava/lang/String;

    invoke-direct {v0, p3}, Ljava/lang/String;-><init>([C)V

    goto :goto_8

    :cond_17
    const/16 v1, 0x13

    if-ne p0, v1, :cond_18

    sget-object v0, Lcom/glu/platform/android/facebook/GluFBConnect;->instance:Lcom/glu/platform/android/facebook/GluFBConnect;

    invoke-virtual {v0}, Lcom/glu/platform/android/facebook/GluFBConnect;->submitQueuedFriendFeed()V

    goto/16 :goto_0

    :cond_18
    const/16 v1, 0x14

    if-ne p0, v1, :cond_1a

    sget-object v1, Lcom/glu/platform/android/facebook/GluFBConnect;->instance:Lcom/glu/platform/android/facebook/GluFBConnect;

    if-nez p3, :cond_19

    :goto_9
    invoke-virtual {v1, v0}, Lcom/glu/platform/android/facebook/GluFBConnect;->requestFriendNameFromUID(Ljava/lang/String;)V

    goto/16 :goto_0

    :cond_19
    new-instance v0, Ljava/lang/String;

    invoke-direct {v0, p3}, Ljava/lang/String;-><init>([C)V

    goto :goto_9

    :cond_1a
    const/16 v1, 0x15

    if-ne p0, v1, :cond_1c

    sget-object v1, Lcom/glu/platform/android/facebook/GluFBConnect;->instance:Lcom/glu/platform/android/facebook/GluFBConnect;

    if-nez p3, :cond_1b

    :goto_a
    invoke-virtual {v1, v0}, Lcom/glu/platform/android/facebook/GluFBConnect;->setNextFriendRequestSize(Ljava/lang/String;)V

    goto/16 :goto_0

    :cond_1b
    new-instance v0, Ljava/lang/String;

    invoke-direct {v0, p3}, Ljava/lang/String;-><init>([C)V

    goto :goto_a

    :cond_1c
    const/16 v1, 0x16

    if-ne p0, v1, :cond_1e

    invoke-static {}, Lcom/glu/platform/android/facebook/Debug;->log$552c4e01()V

    if-nez p3, :cond_1d

    :goto_b
    invoke-static {}, Lcom/glu/platform/android/facebook/Debug;->log$552c4e01()V

    sget-object v1, Lcom/glu/platform/android/facebook/GluFBConnect;->instance:Lcom/glu/platform/android/facebook/GluFBConnect;

    invoke-virtual {v1, v0}, Lcom/glu/platform/android/facebook/GluFBConnect;->setSecretID(Ljava/lang/String;)V

    goto/16 :goto_0

    :cond_1d
    const-string v0, "175053615859789"

    goto :goto_b

    :cond_1e
    const/16 v0, 0x19

    if-ne p0, v0, :cond_0

    invoke-static {}, Lcom/glu/platform/android/facebook/GluFBConnect;->createFBCanLoginFile()V

    goto/16 :goto_0
.end method

.method private shouldFileBeReplaced(Ljava/lang/String;Ljava/lang/String;J)Z
    .locals 5

    const/4 v0, 0x1

    new-instance v1, Ljava/io/File;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ".png"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    new-instance v2, Ljava/io/File;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, ".jpg"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-direct {v2, v3}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1}, Ljava/io/File;->exists()Z

    move-result v3

    if-nez v3, :cond_1

    invoke-virtual {v2}, Ljava/io/File;->exists()Z

    move-result v3

    if-nez v3, :cond_1

    :cond_0
    :goto_0
    return v0

    :cond_1
    invoke-virtual {v1}, Ljava/io/File;->exists()Z

    move-result v3

    if-eqz v3, :cond_2

    invoke-virtual {v1}, Ljava/io/File;->lastModified()J

    move-result-wide v3

    cmp-long v1, v3, p3

    if-lez v1, :cond_0

    :cond_2
    invoke-virtual {v2}, Ljava/io/File;->exists()Z

    move-result v1

    if-eqz v1, :cond_3

    invoke-virtual {v2}, Ljava/io/File;->lastModified()J

    move-result-wide v1

    cmp-long v1, v1, p3

    if-lez v1, :cond_0

    :cond_3
    const/4 v0, 0x0

    goto :goto_0
.end method

.method private shouldFileBeReplacedIfNotGetExtension(Ljava/lang/String;Ljava/lang/String;J)Ljava/lang/String;
    .locals 5

    const/4 v0, 0x0

    new-instance v1, Ljava/io/File;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ".png"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    new-instance v2, Ljava/io/File;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, ".jpg"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-direct {v2, v3}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1}, Ljava/io/File;->exists()Z

    move-result v3

    if-nez v3, :cond_1

    invoke-virtual {v2}, Ljava/io/File;->exists()Z

    move-result v3

    if-nez v3, :cond_1

    :cond_0
    :goto_0
    return-object v0

    :cond_1
    invoke-virtual {v1}, Ljava/io/File;->exists()Z

    move-result v3

    if-eqz v3, :cond_2

    invoke-virtual {v1}, Ljava/io/File;->lastModified()J

    move-result-wide v3

    cmp-long v3, v3, p3

    if-lez v3, :cond_0

    :cond_2
    invoke-virtual {v2}, Ljava/io/File;->exists()Z

    move-result v3

    if-eqz v3, :cond_3

    invoke-virtual {v2}, Ljava/io/File;->lastModified()J

    move-result-wide v3

    cmp-long v3, v3, p3

    if-lez v3, :cond_0

    :cond_3
    invoke-virtual {v1}, Ljava/io/File;->exists()Z

    move-result v0

    if-eqz v0, :cond_4

    const-string v0, ".png"

    goto :goto_0

    :cond_4
    invoke-virtual {v2}, Ljava/io/File;->exists()Z

    move-result v0

    if-eqz v0, :cond_5

    const-string v0, ".jpg"

    goto :goto_0

    :cond_5
    const-string v0, ".wtf"

    goto :goto_0
.end method

.method public static testFBCanLoginFile()Z
    .locals 3

    new-instance v0, Ljava/io/File;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-static {}, Lcom/glu/platform/android/facebook/GluUtil;->getSecureSaveDirectory()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "fbcheck230"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v0

    return v0
.end method


# virtual methods
.method public freeAllFriendPics()V
    .locals 2

    new-instance v0, Ljava/io/File;

    invoke-static {}, Lcom/glu/platform/android/facebook/GluUtil;->getFacebookSaveDirectory()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-static {v0}, Lcom/glu/platform/android/facebook/GluUtil;->rmrf(Ljava/io/File;)V

    return-void
.end method

.method public getUserInfo()V
    .locals 3

    invoke-static {}, Lcom/glu/platform/android/facebook/Debug;->log$552c4e01()V

    sget v0, Lcom/glu/platform/android/facebook/GluFBConnect;->m_facebookState:I

    const/4 v1, 0x1

    if-eq v0, v1, :cond_0

    invoke-static {}, Lcom/glu/platform/android/facebook/Debug;->log$552c4e01()V

    :goto_0
    return-void

    :cond_0
    iget-object v0, p0, Lcom/glu/platform/android/facebook/GluFBConnect;->m_getUserInfoRunner:Lcom/facebook/android/AsyncFacebookRunner;

    if-eqz v0, :cond_1

    invoke-static {}, Lcom/glu/platform/android/facebook/Debug;->log$552c4e01()V

    goto :goto_0

    :cond_1
    new-instance v0, Lcom/facebook/android/AsyncFacebookRunner;

    iget-object v1, p0, Lcom/glu/platform/android/facebook/GluFBConnect;->m_facebook:Lcom/facebook/android/Facebook;

    invoke-direct {v0, v1}, Lcom/facebook/android/AsyncFacebookRunner;-><init>(Lcom/facebook/android/Facebook;)V

    iput-object v0, p0, Lcom/glu/platform/android/facebook/GluFBConnect;->m_getUserInfoRunner:Lcom/facebook/android/AsyncFacebookRunner;

    const-string v1, "/me"

    new-instance v2, Lcom/glu/platform/android/facebook/GluFBConnect$2;

    invoke-direct {v2, p0}, Lcom/glu/platform/android/facebook/GluFBConnect$2;-><init>(Lcom/glu/platform/android/facebook/GluFBConnect;)V

    invoke-virtual {v0, v1, v2}, Lcom/facebook/android/AsyncFacebookRunner;->request(Ljava/lang/String;Lcom/facebook/android/AsyncFacebookRunner$RequestListener;)V

    goto :goto_0
.end method

.method public init()V
    .locals 1

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/glu/platform/android/facebook/GluFBConnect;->m_appID:Ljava/lang/String;

    return-void
.end method

.method public loadFriends()V
    .locals 3

    invoke-static {}, Lcom/glu/platform/android/facebook/Debug;->log$552c4e01()V

    sget v0, Lcom/glu/platform/android/facebook/GluFBConnect;->m_facebookState:I

    const/4 v1, 0x1

    if-eq v0, v1, :cond_0

    :goto_0
    return-void

    :cond_0
    iget-object v0, p0, Lcom/glu/platform/android/facebook/GluFBConnect;->m_loadFriendsRunner:Lcom/facebook/android/AsyncFacebookRunner;

    if-eqz v0, :cond_1

    invoke-static {}, Lcom/glu/platform/android/facebook/Debug;->log$552c4e01()V

    goto :goto_0

    :cond_1
    new-instance v0, Lcom/facebook/android/AsyncFacebookRunner;

    iget-object v1, p0, Lcom/glu/platform/android/facebook/GluFBConnect;->m_facebook:Lcom/facebook/android/Facebook;

    invoke-direct {v0, v1}, Lcom/facebook/android/AsyncFacebookRunner;-><init>(Lcom/facebook/android/Facebook;)V

    iput-object v0, p0, Lcom/glu/platform/android/facebook/GluFBConnect;->m_loadFriendsRunner:Lcom/facebook/android/AsyncFacebookRunner;

    const-string v1, "me/friends"

    new-instance v2, Lcom/glu/platform/android/facebook/GluFBConnect$1;

    invoke-direct {v2, p0}, Lcom/glu/platform/android/facebook/GluFBConnect$1;-><init>(Lcom/glu/platform/android/facebook/GluFBConnect;)V

    invoke-virtual {v0, v1, v2}, Lcom/facebook/android/AsyncFacebookRunner;->request(Ljava/lang/String;Lcom/facebook/android/AsyncFacebookRunner$RequestListener;)V

    goto :goto_0
.end method

.method public login()V
    .locals 4

    invoke-static {}, Lcom/glu/platform/android/facebook/GluFBConnect;->testFBCanLoginFile()Z

    move-result v0

    if-nez v0, :cond_0

    invoke-static {}, Lcom/glu/platform/android/facebook/Debug;->log$552c4e01()V

    sget-object v0, Lcom/glu/platform/android/GluPlatformActivity;->instance:Lcom/glu/platform/android/GluPlatformActivity;

    const/4 v1, 0x4

    const/4 v2, 0x5

    const/4 v3, 0x0

    invoke-virtual {v0, v1, v2, v3}, Lcom/glu/platform/android/GluPlatformActivity;->javaToNativeFacebook(II[B)V

    :goto_0
    return-void

    :cond_0
    invoke-static {}, Lcom/glu/platform/android/facebook/Debug;->log$552c4e01()V

    const/4 v0, 0x1

    sput v0, Lcom/glu/platform/android/facebook/GluFBConnect;->m_connectionState:I

    const/4 v0, 0x2

    sput v0, Lcom/glu/platform/android/facebook/GluFBConnect;->m_facebookState:I

    iget-object v0, p0, Lcom/glu/platform/android/facebook/GluFBConnect;->m_appID:Ljava/lang/String;

    if-nez v0, :cond_1

    invoke-static {}, Lcom/glu/platform/android/facebook/Debug;->log$552c4e01()V

    goto :goto_0

    :cond_1
    iget-object v0, p0, Lcom/glu/platform/android/facebook/GluFBConnect;->m_facebook:Lcom/facebook/android/Facebook;

    sget-object v1, Lcom/glu/platform/android/GluPlatformActivity;->instance:Lcom/glu/platform/android/GluPlatformActivity;

    invoke-virtual {v0, v1, p0}, Lcom/facebook/android/Facebook;->authorize(Landroid/app/Activity;Lcom/facebook/android/Facebook$DialogListener;)V

    invoke-static {}, Lcom/glu/platform/android/facebook/Debug;->log$552c4e01()V

    goto :goto_0
.end method

.method public logout()V
    .locals 3

    const/4 v0, 0x1

    sput v0, Lcom/glu/platform/android/facebook/GluFBConnect;->m_connectionState:I

    const/4 v0, 0x3

    sput v0, Lcom/glu/platform/android/facebook/GluFBConnect;->m_facebookState:I

    :try_start_0
    iget-object v0, p0, Lcom/glu/platform/android/facebook/GluFBConnect;->m_facebook:Lcom/facebook/android/Facebook;

    sget-object v1, Lcom/glu/platform/android/GluPlatformActivity;->instance:Lcom/glu/platform/android/GluPlatformActivity;

    invoke-virtual {v0, v1}, Lcom/facebook/android/Facebook;->logout(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Logged out with response: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    invoke-static {}, Lcom/glu/platform/android/facebook/Debug;->log$552c4e01()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return-void

    :catch_0
    move-exception v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "FB logout exception (probably harmless): "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    invoke-static {}, Lcom/glu/platform/android/facebook/Debug;->log$552c4e01()V

    goto :goto_0
.end method

.method public onCancel()V
    .locals 5

    const/4 v3, 0x5

    const/4 v2, 0x4

    sput v2, Lcom/glu/platform/android/facebook/GluFBConnect;->m_connectionState:I

    invoke-static {}, Lcom/glu/platform/android/facebook/Debug;->log$552c4e01()V

    sget v0, Lcom/glu/platform/android/facebook/GluFBConnect;->m_facebookState:I

    const/4 v1, 0x2

    if-ne v0, v1, :cond_3

    sget-object v0, Lcom/glu/platform/android/GluPlatformActivity;->instance:Lcom/glu/platform/android/GluPlatformActivity;

    const/4 v1, 0x0

    invoke-virtual {v0, v2, v3, v1}, Lcom/glu/platform/android/GluPlatformActivity;->javaToNativeFacebook(II[B)V

    sput v3, Lcom/glu/platform/android/facebook/GluFBConnect;->m_facebookState:I

    sget-object v0, Lcom/glu/platform/android/GluPlatformActivity;->instance:Lcom/glu/platform/android/GluPlatformActivity;

    invoke-virtual {v0}, Lcom/glu/platform/android/GluPlatformActivity;->getCacheDir()Ljava/io/File;

    move-result-object v0

    new-instance v1, Ljava/io/File;

    invoke-virtual {v0}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/glu/platform/android/facebook/GluUtil;->filePathNoEnder(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    const-string v3, "/cache"

    const-string v4, "/databases/webview.db"

    invoke-virtual {v2, v3, v4}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    new-instance v2, Ljava/io/File;

    invoke-virtual {v0}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/glu/platform/android/facebook/GluUtil;->filePathNoEnder(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    const-string v3, "/cache"

    const-string v4, "/databases/webviewCache.db"

    invoke-virtual {v0, v3, v4}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v0

    invoke-direct {v2, v0}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1}, Ljava/io/File;->exists()Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-virtual {v1}, Ljava/io/File;->delete()Z

    :goto_0
    invoke-virtual {v2}, Ljava/io/File;->exists()Z

    move-result v0

    if-eqz v0, :cond_2

    invoke-virtual {v2}, Ljava/io/File;->delete()Z

    :cond_0
    :goto_1
    return-void

    :cond_1
    invoke-static {}, Lcom/glu/platform/android/facebook/Debug;->log$552c4e01()V

    goto :goto_0

    :cond_2
    invoke-static {}, Lcom/glu/platform/android/facebook/Debug;->log$552c4e01()V

    goto :goto_1

    :cond_3
    sget v0, Lcom/glu/platform/android/facebook/GluFBConnect;->m_facebookState:I

    const/4 v1, 0x3

    if-ne v0, v1, :cond_4

    sput v2, Lcom/glu/platform/android/facebook/GluFBConnect;->m_facebookState:I

    goto :goto_1

    :cond_4
    sget v0, Lcom/glu/platform/android/facebook/GluFBConnect;->m_facebookState:I

    const/4 v1, 0x7

    if-ne v0, v1, :cond_0

    const/4 v0, 0x1

    sput v0, Lcom/glu/platform/android/facebook/GluFBConnect;->m_facebookState:I

    goto :goto_1
.end method

.method public onComplete(Landroid/os/Bundle;)V
    .locals 3

    const/4 v1, 0x2

    const/4 v2, 0x1

    invoke-static {}, Lcom/glu/platform/android/facebook/Debug;->log$552c4e01()V

    sput v1, Lcom/glu/platform/android/facebook/GluFBConnect;->m_connectionState:I

    sget v0, Lcom/glu/platform/android/facebook/GluFBConnect;->m_facebookState:I

    if-ne v0, v1, :cond_1

    sput v2, Lcom/glu/platform/android/facebook/GluFBConnect;->m_facebookState:I

    invoke-static {}, Lcom/glu/platform/android/facebook/Debug;->log$552c4e01()V

    invoke-virtual {p0}, Lcom/glu/platform/android/facebook/GluFBConnect;->getUserInfo()V

    :cond_0
    :goto_0
    return-void

    :cond_1
    sget v0, Lcom/glu/platform/android/facebook/GluFBConnect;->m_facebookState:I

    const/4 v1, 0x3

    if-ne v0, v1, :cond_2

    const/4 v0, 0x4

    sput v0, Lcom/glu/platform/android/facebook/GluFBConnect;->m_facebookState:I

    goto :goto_0

    :cond_2
    sget v0, Lcom/glu/platform/android/facebook/GluFBConnect;->m_facebookState:I

    const/4 v1, 0x7

    if-ne v0, v1, :cond_0

    sput v2, Lcom/glu/platform/android/facebook/GluFBConnect;->m_facebookState:I

    goto :goto_0
.end method

.method public onError(Lcom/facebook/android/DialogError;)V
    .locals 5

    const/4 v4, 0x5

    const/4 v3, 0x4

    const/4 v2, 0x3

    sput v2, Lcom/glu/platform/android/facebook/GluFBConnect;->m_connectionState:I

    invoke-static {}, Lcom/glu/platform/android/facebook/Debug;->log$552c4e01()V

    sget v0, Lcom/glu/platform/android/facebook/GluFBConnect;->m_facebookState:I

    const/4 v1, 0x2

    if-ne v0, v1, :cond_1

    sget-object v0, Lcom/glu/platform/android/GluPlatformActivity;->instance:Lcom/glu/platform/android/GluPlatformActivity;

    const/4 v1, 0x0

    invoke-virtual {v0, v3, v4, v1}, Lcom/glu/platform/android/GluPlatformActivity;->javaToNativeFacebook(II[B)V

    sput v4, Lcom/glu/platform/android/facebook/GluFBConnect;->m_facebookState:I

    :cond_0
    :goto_0
    return-void

    :cond_1
    sget v0, Lcom/glu/platform/android/facebook/GluFBConnect;->m_facebookState:I

    if-ne v0, v2, :cond_2

    sput v3, Lcom/glu/platform/android/facebook/GluFBConnect;->m_facebookState:I

    goto :goto_0

    :cond_2
    sget v0, Lcom/glu/platform/android/facebook/GluFBConnect;->m_facebookState:I

    const/4 v1, 0x7

    if-ne v0, v1, :cond_0

    const/4 v0, 0x1

    sput v0, Lcom/glu/platform/android/facebook/GluFBConnect;->m_facebookState:I

    goto :goto_0
.end method

.method public onFacebookError(Lcom/facebook/android/FacebookError;)V
    .locals 5

    const/4 v4, 0x5

    const/4 v3, 0x4

    const/4 v2, 0x3

    sput v2, Lcom/glu/platform/android/facebook/GluFBConnect;->m_connectionState:I

    invoke-static {}, Lcom/glu/platform/android/facebook/Debug;->log$552c4e01()V

    sget v0, Lcom/glu/platform/android/facebook/GluFBConnect;->m_facebookState:I

    const/4 v1, 0x2

    if-ne v0, v1, :cond_1

    sget-object v0, Lcom/glu/platform/android/GluPlatformActivity;->instance:Lcom/glu/platform/android/GluPlatformActivity;

    const/4 v1, 0x0

    invoke-virtual {v0, v3, v4, v1}, Lcom/glu/platform/android/GluPlatformActivity;->javaToNativeFacebook(II[B)V

    sput v4, Lcom/glu/platform/android/facebook/GluFBConnect;->m_facebookState:I

    :cond_0
    :goto_0
    return-void

    :cond_1
    sget v0, Lcom/glu/platform/android/facebook/GluFBConnect;->m_facebookState:I

    if-ne v0, v2, :cond_2

    sput v3, Lcom/glu/platform/android/facebook/GluFBConnect;->m_facebookState:I

    goto :goto_0

    :cond_2
    sget v0, Lcom/glu/platform/android/facebook/GluFBConnect;->m_facebookState:I

    const/4 v1, 0x7

    if-ne v0, v1, :cond_0

    const/4 v0, 0x1

    sput v0, Lcom/glu/platform/android/facebook/GluFBConnect;->m_facebookState:I

    goto :goto_0
.end method

.method public queueFeedBody(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lcom/glu/platform/android/facebook/GluFBConnect;->m_body:Ljava/lang/String;

    return-void
.end method

.method public queueFeedHeader(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lcom/glu/platform/android/facebook/GluFBConnect;->m_header:Ljava/lang/String;

    return-void
.end method

.method public queueFeedPrompt(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lcom/glu/platform/android/facebook/GluFBConnect;->m_prompt:Ljava/lang/String;

    return-void
.end method

.method public queueFriendImageURL(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lcom/glu/platform/android/facebook/GluFBConnect;->m_friendLinkImageURL:Ljava/lang/String;

    return-void
.end method

.method public queueFriendLink(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lcom/glu/platform/android/facebook/GluFBConnect;->m_friendLink:Ljava/lang/String;

    return-void
.end method

.method public queueFriendLinkText(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lcom/glu/platform/android/facebook/GluFBConnect;->m_friendLinkText:Ljava/lang/String;

    return-void
.end method

.method public queueFriendMessage(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lcom/glu/platform/android/facebook/GluFBConnect;->m_friendMessage:Ljava/lang/String;

    return-void
.end method

.method public queueFriendUID(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lcom/glu/platform/android/facebook/GluFBConnect;->m_friendUID:Ljava/lang/String;

    return-void
.end method

.method public requestFriendNameFromUID(Ljava/lang/String;)V
    .locals 1

    iget-object v0, p0, Lcom/glu/platform/android/facebook/GluFBConnect;->m_quickAccessFriendInfo:Ljava/util/Hashtable;

    invoke-virtual {v0, p1}, Ljava/util/Hashtable;->get(Ljava/lang/Object;)Ljava/lang/Object;

    return-void
.end method

.method public requestFriendPicsStartingWith(Ljava/lang/String;)V
    .locals 4

    iget-object v0, p0, Lcom/glu/platform/android/facebook/GluFBConnect;->m_friendInfo:[Ljava/lang/String;

    if-nez v0, :cond_0

    invoke-static {}, Lcom/glu/platform/android/facebook/Debug;->log$552c4e01()V

    :goto_0
    return-void

    :cond_0
    iget-object v1, p0, Lcom/glu/platform/android/facebook/GluFBConnect;->m_friendRequestQueue:Ljava/util/Vector;

    monitor-enter v1

    :try_start_0
    iget-object v0, p0, Lcom/glu/platform/android/facebook/GluFBConnect;->m_friendRequestQueue:Ljava/util/Vector;

    new-instance v2, Lcom/glu/platform/android/facebook/GluFBConnect$FBItem;

    iget-object v3, p0, Lcom/glu/platform/android/facebook/GluFBConnect;->m_nextImageSize:Ljava/lang/String;

    invoke-direct {v2, v3, p1}, Lcom/glu/platform/android/facebook/GluFBConnect$FBItem;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {v0, v2}, Ljava/util/Vector;->addElement(Ljava/lang/Object;)V

    iget-boolean v0, p0, Lcom/glu/platform/android/facebook/GluFBConnect;->RUNNING:Z

    if-eqz v0, :cond_1

    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    :catchall_0
    move-exception v0

    monitor-exit v1

    throw v0

    :cond_1
    monitor-exit v1

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/glu/platform/android/facebook/GluFBConnect;->RUNNING:Z

    invoke-virtual {p0}, Lcom/glu/platform/android/facebook/GluFBConnect;->start()V

    goto :goto_0
.end method

.method public run()V
    .locals 15

    const/4 v1, 0x1

    const/4 v2, 0x0

    invoke-static {}, Lcom/glu/platform/android/facebook/GluUtil;->getFacebookSaveDirectory()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/glu/platform/android/facebook/GluUtil;->filePathWithEnder(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    iget-object v0, p0, Lcom/glu/platform/android/facebook/GluFBConnect;->m_friendInfo:[Ljava/lang/String;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v5

    const-wide/32 v7, 0xf731400

    sub-long/2addr v5, v7

    iget-object v0, p0, Lcom/glu/platform/android/facebook/GluFBConnect;->m_friendRequestQueue:Ljava/util/Vector;

    invoke-virtual {v0}, Ljava/util/Vector;->size()I

    move-result v0

    if-lez v0, :cond_1

    move v0, v1

    :goto_0
    iput-boolean v0, p0, Lcom/glu/platform/android/facebook/GluFBConnect;->RUNNING:Z

    :goto_1
    iget-boolean v0, p0, Lcom/glu/platform/android/facebook/GluFBConnect;->RUNNING:Z

    if-eqz v0, :cond_c

    iget-object v0, p0, Lcom/glu/platform/android/facebook/GluFBConnect;->m_friendRequestQueue:Ljava/util/Vector;

    invoke-virtual {v0, v2}, Ljava/util/Vector;->elementAt(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/glu/platform/android/facebook/GluFBConnect$FBItem;

    iget-object v7, v0, Lcom/glu/platform/android/facebook/GluFBConnect$FBItem;->imageUser:Ljava/lang/String;

    iget-object v8, v0, Lcom/glu/platform/android/facebook/GluFBConnect$FBItem;->imageSize:Ljava/lang/String;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v3, "_"

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-direct {p0, v4, v9, v5, v6}, Lcom/glu/platform/android/facebook/GluFBConnect;->shouldFileBeReplacedIfNotGetExtension(Ljava/lang/String;Ljava/lang/String;J)Ljava/lang/String;

    move-result-object v0

    if-nez v0, :cond_8

    const/4 v3, 0x5

    :goto_2
    if-lez v3, :cond_8

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "http://graph.facebook.com/"

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    const-string v11, "/picture?type="

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    const-string v12, "Checking URL: "

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    invoke-static {}, Lcom/glu/platform/android/facebook/Debug;->log$552c4e01()V

    invoke-static {v10}, Lcom/glu/platform/android/facebook/GluUtil;->getByteArrayContentsFromURL$44c4d6c8(Ljava/lang/String;)[B

    move-result-object v11

    if-eqz v11, :cond_0

    array-length v12, v11

    const/4 v13, 0x4

    if-ge v12, v13, :cond_2

    :cond_0
    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    const-string v12, "Failed, will retry in 5sec: "

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    invoke-static {}, Lcom/glu/platform/android/facebook/Debug;->log$552c4e01()V

    invoke-static {}, Lcom/glu/platform/android/facebook/GluUtil;->sleep$1349ef()V

    add-int/lit8 v3, v3, -0x1

    goto :goto_2

    :cond_1
    move v0, v2

    goto/16 :goto_0

    :cond_2
    const/4 v3, 0x0

    invoke-static {v11}, Lcom/glu/platform/android/facebook/GluUtil;->getMIMEType([B)I

    move-result v10

    const v12, -0x76afb1b9

    if-eq v10, v12, :cond_3

    const v12, 0xffd8

    if-ne v10, v12, :cond_5

    :cond_3
    invoke-static {v10}, Lcom/glu/platform/android/facebook/GluUtil;->mimeTypeToExtension(I)Ljava/lang/String;

    move-result-object v3

    new-instance v0, Ljava/io/File;

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v10, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-direct {v0, v10}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    :goto_3
    if-eqz v0, :cond_4

    :try_start_0
    invoke-direct {p0, v4, v7}, Lcom/glu/platform/android/facebook/GluFBConnect;->deleteSingleUserFile(Ljava/lang/String;Ljava/lang/String;)V

    new-instance v10, Ljava/io/FileOutputStream;

    invoke-direct {v10, v0}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V

    invoke-static {v10, v11}, Lcom/glu/platform/android/facebook/GluUtil;->writeByteArray(Ljava/io/FileOutputStream;[B)V

    invoke-virtual {v10}, Ljava/io/FileOutputStream;->close()V

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "Successfully changed: "

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v0}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v10, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    invoke-static {}, Lcom/glu/platform/android/facebook/Debug;->log$552c4e01()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :cond_4
    :goto_4
    move-object v0, v3

    move v3, v2

    goto/16 :goto_2

    :cond_5
    const v12, 0x47494638

    if-ne v10, v12, :cond_6

    invoke-static {}, Lcom/glu/platform/android/facebook/Debug;->log$552c4e01()V

    move-object v14, v3

    move-object v3, v0

    move-object v0, v14

    goto :goto_3

    :cond_6
    const/16 v12, 0x424d

    if-ne v10, v12, :cond_7

    invoke-static {}, Lcom/glu/platform/android/facebook/Debug;->log$552c4e01()V

    move-object v14, v3

    move-object v3, v0

    move-object v0, v14

    goto :goto_3

    :cond_7
    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v12, "Unknown file type..."

    invoke-virtual {v10, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-static {v11}, Lcom/glu/platform/android/facebook/GluUtil;->getFourByteHexNice$79bb807([B)Ljava/lang/String;

    move-result-object v12

    invoke-virtual {v10, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    const-string v12, " ...using filler pic."

    invoke-virtual {v10, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-object v14, v3

    move-object v3, v0

    move-object v0, v14

    invoke-static {}, Lcom/glu/platform/android/facebook/Debug;->log$552c4e01()V

    goto :goto_3

    :catch_0
    move-exception v0

    invoke-static {}, Lcom/glu/platform/android/facebook/Debug;->log$552c4e01()V

    goto :goto_4

    :cond_8
    if-eqz v0, :cond_9

    new-instance v3, Ljava/io/File;

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v10, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-direct {v3, v9}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    new-instance v9, Ljava/io/File;

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v10, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {v9, v0}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-static {v3, v9}, Lcom/glu/platform/android/facebook/GluUtil;->copyFile(Ljava/io/File;Ljava/io/File;)Z

    move-result v0

    if-eqz v0, :cond_a

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "Copied successfully for native. OLD="

    invoke-virtual {v0, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v3}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v0, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v7, "  NEW="

    invoke-virtual {v0, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v3}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    invoke-static {}, Lcom/glu/platform/android/facebook/Debug;->log$552c4e01()V

    :cond_9
    :goto_5
    iget-object v3, p0, Lcom/glu/platform/android/facebook/GluFBConnect;->m_friendRequestQueue:Ljava/util/Vector;

    monitor-enter v3

    :try_start_1
    iget-object v0, p0, Lcom/glu/platform/android/facebook/GluFBConnect;->m_friendRequestQueue:Ljava/util/Vector;

    const/4 v7, 0x0

    invoke-virtual {v0, v7}, Ljava/util/Vector;->removeElementAt(I)V

    iget-object v0, p0, Lcom/glu/platform/android/facebook/GluFBConnect;->m_friendRequestQueue:Ljava/util/Vector;

    invoke-virtual {v0}, Ljava/util/Vector;->size()I

    move-result v0

    if-lez v0, :cond_b

    move v0, v1

    :goto_6
    iput-boolean v0, p0, Lcom/glu/platform/android/facebook/GluFBConnect;->RUNNING:Z

    monitor-exit v3
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto/16 :goto_1

    :catchall_0
    move-exception v0

    monitor-exit v3

    throw v0

    :cond_a
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Failed to copy file over for friend pic.   UID="

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v3, "   SIZE="

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    invoke-static {}, Lcom/glu/platform/android/facebook/Debug;->log$552c4e01()V

    goto :goto_5

    :cond_b
    move v0, v2

    goto :goto_6

    :cond_c
    return-void
.end method

.method public sendFeed(Ljava/lang/String;)V
    .locals 2

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "GluFBConnect.sendFeed: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    invoke-static {}, Lcom/glu/platform/android/facebook/Debug;->log$552c4e01()V

    new-instance v0, Landroid/os/Bundle;

    invoke-direct {v0}, Landroid/os/Bundle;-><init>()V

    const-string v1, "message"

    invoke-virtual {v0, v1, p1}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method public sendInvite(Ljava/lang/String;)V
    .locals 4

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "GluFBConnect.sendInvite: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    invoke-static {}, Lcom/glu/platform/android/facebook/Debug;->log$552c4e01()V

    const/16 v0, 0x7e

    invoke-virtual {p1, v0}, Ljava/lang/String;->indexOf(I)I

    move-result v0

    const/4 v1, -0x1

    if-ne v0, v1, :cond_0

    invoke-static {}, Lcom/glu/platform/android/facebook/Debug;->log$552c4e01()V

    :goto_0
    return-void

    :cond_0
    new-instance v1, Landroid/os/Bundle;

    invoke-direct {v1}, Landroid/os/Bundle;-><init>()V

    const-string v2, "message"

    const/4 v3, 0x0

    invoke-virtual {p1, v3, v0}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    const-string v2, "uid"

    add-int/lit8 v0, v0, 0x1

    invoke-virtual {p1, v0}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v2, v0}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0
.end method

.method public setAppID(Ljava/lang/String;)V
    .locals 2

    iput-object p1, p0, Lcom/glu/platform/android/facebook/GluFBConnect;->m_appID:Ljava/lang/String;

    new-instance v0, Lcom/facebook/android/Facebook;

    iget-object v1, p0, Lcom/glu/platform/android/facebook/GluFBConnect;->m_appID:Ljava/lang/String;

    invoke-direct {v0, v1}, Lcom/facebook/android/Facebook;-><init>(Ljava/lang/String;)V

    iput-object v0, p0, Lcom/glu/platform/android/facebook/GluFBConnect;->m_facebook:Lcom/facebook/android/Facebook;

    return-void
.end method

.method public setNextFriendRequestSize(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lcom/glu/platform/android/facebook/GluFBConnect;->m_nextImageSize:Ljava/lang/String;

    return-void
.end method

.method public setSecretID(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lcom/glu/platform/android/facebook/GluFBConnect;->m_secretID:Ljava/lang/String;

    return-void
.end method

.method public submitQueuedFeed()V
    .locals 3

    const/4 v2, 0x1

    iget-object v0, p0, Lcom/glu/platform/android/facebook/GluFBConnect;->m_body:Ljava/lang/String;

    if-nez v0, :cond_0

    invoke-static {}, Lcom/glu/platform/android/facebook/Debug;->log$552c4e01()V

    :goto_0
    return-void

    :cond_0
    sget v0, Lcom/glu/platform/android/facebook/GluFBConnect;->m_facebookState:I

    if-eq v0, v2, :cond_1

    invoke-static {}, Lcom/glu/platform/android/facebook/Debug;->log$552c4e01()V

    goto :goto_0

    :cond_1
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "GluFBConnect.submitQueuedFeed: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/glu/platform/android/facebook/GluFBConnect;->m_body:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    invoke-static {}, Lcom/glu/platform/android/facebook/Debug;->log$552c4e01()V

    iget-object v0, p0, Lcom/glu/platform/android/facebook/GluFBConnect;->m_viewManipulationHandler:Landroid/os/Handler;

    invoke-virtual {v0, v2}, Landroid/os/Handler;->sendEmptyMessage(I)Z

    goto :goto_0
.end method

.method public submitQueuedFriendFeed()V
    .locals 3

    const/4 v2, 0x0

    iget-object v0, p0, Lcom/glu/platform/android/facebook/GluFBConnect;->m_friendMessage:Ljava/lang/String;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/glu/platform/android/facebook/GluFBConnect;->m_friendUID:Ljava/lang/String;

    if-nez v0, :cond_1

    :cond_0
    invoke-static {}, Lcom/glu/platform/android/facebook/Debug;->log$552c4e01()V

    :goto_0
    return-void

    :cond_1
    sget v0, Lcom/glu/platform/android/facebook/GluFBConnect;->m_facebookState:I

    const/4 v1, 0x1

    if-eq v0, v1, :cond_2

    invoke-static {}, Lcom/glu/platform/android/facebook/Debug;->log$552c4e01()V

    goto :goto_0

    :cond_2
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "GluFBConnect.submitQueuedFriendFeed: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/glu/platform/android/facebook/GluFBConnect;->m_friendMessage:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    invoke-static {}, Lcom/glu/platform/android/facebook/Debug;->log$552c4e01()V

    iget-object v0, p0, Lcom/glu/platform/android/facebook/GluFBConnect;->m_friendLink:Ljava/lang/String;

    if-eqz v0, :cond_3

    iget-object v0, p0, Lcom/glu/platform/android/facebook/GluFBConnect;->m_friendLink:Ljava/lang/String;

    const-string v1, ""

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_3

    iput-object v2, p0, Lcom/glu/platform/android/facebook/GluFBConnect;->m_friendLink:Ljava/lang/String;

    :cond_3
    iget-object v0, p0, Lcom/glu/platform/android/facebook/GluFBConnect;->m_friendLinkText:Ljava/lang/String;

    if-eqz v0, :cond_4

    iget-object v0, p0, Lcom/glu/platform/android/facebook/GluFBConnect;->m_friendLinkText:Ljava/lang/String;

    const-string v1, ""

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_4

    iput-object v2, p0, Lcom/glu/platform/android/facebook/GluFBConnect;->m_friendLinkText:Ljava/lang/String;

    :cond_4
    iget-object v0, p0, Lcom/glu/platform/android/facebook/GluFBConnect;->m_friendLinkImageURL:Ljava/lang/String;

    if-eqz v0, :cond_5

    iget-object v0, p0, Lcom/glu/platform/android/facebook/GluFBConnect;->m_friendLinkImageURL:Ljava/lang/String;

    const-string v1, ""

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_5

    iput-object v2, p0, Lcom/glu/platform/android/facebook/GluFBConnect;->m_friendLinkImageURL:Ljava/lang/String;

    :cond_5
    iget-object v0, p0, Lcom/glu/platform/android/facebook/GluFBConnect;->m_viewManipulationHandler:Landroid/os/Handler;

    const/4 v1, 0x2

    invoke-virtual {v0, v1}, Landroid/os/Handler;->sendEmptyMessage(I)Z

    goto :goto_0
.end method
