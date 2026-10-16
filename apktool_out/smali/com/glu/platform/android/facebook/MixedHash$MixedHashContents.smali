.class final Lcom/glu/platform/android/facebook/MixedHash$MixedHashContents;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/glu/platform/android/facebook/MixedHash;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "MixedHashContents"
.end annotation


# instance fields
.field private m_boolean:Z

.field private m_booleanHasBeenSet:Z

.field private m_hash:Lcom/glu/platform/android/facebook/MixedHash;

.field private m_hashVector:Ljava/util/Vector;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Vector",
            "<",
            "Lcom/glu/platform/android/facebook/MixedHash;",
            ">;"
        }
    .end annotation
.end field

.field private m_int:I

.field private m_string:Ljava/lang/String;


# direct methods
.method synthetic constructor <init>()V
    .locals 1

    const/4 v0, 0x0

    invoke-direct {p0, v0}, Lcom/glu/platform/android/facebook/MixedHash$MixedHashContents;-><init>(B)V

    return-void
.end method

.method private constructor <init>(B)V
    .locals 3

    const/4 v2, 0x0

    const/4 v1, 0x0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object v1, p0, Lcom/glu/platform/android/facebook/MixedHash$MixedHashContents;->m_hash:Lcom/glu/platform/android/facebook/MixedHash;

    iput-object v1, p0, Lcom/glu/platform/android/facebook/MixedHash$MixedHashContents;->m_hashVector:Ljava/util/Vector;

    const/high16 v0, -0x80000000

    iput v0, p0, Lcom/glu/platform/android/facebook/MixedHash$MixedHashContents;->m_int:I

    iput-object v1, p0, Lcom/glu/platform/android/facebook/MixedHash$MixedHashContents;->m_string:Ljava/lang/String;

    iput-boolean v2, p0, Lcom/glu/platform/android/facebook/MixedHash$MixedHashContents;->m_boolean:Z

    iput-boolean v2, p0, Lcom/glu/platform/android/facebook/MixedHash$MixedHashContents;->m_booleanHasBeenSet:Z

    return-void
.end method

.method static synthetic access$002(Lcom/glu/platform/android/facebook/MixedHash$MixedHashContents;Ljava/lang/String;)Ljava/lang/String;
    .locals 0

    iput-object p1, p0, Lcom/glu/platform/android/facebook/MixedHash$MixedHashContents;->m_string:Ljava/lang/String;

    return-object p1
.end method

.method static synthetic access$402(Lcom/glu/platform/android/facebook/MixedHash$MixedHashContents;Ljava/util/Vector;)Ljava/util/Vector;
    .locals 0

    iput-object p1, p0, Lcom/glu/platform/android/facebook/MixedHash$MixedHashContents;->m_hashVector:Ljava/util/Vector;

    return-object p1
.end method
