.class public final Lcom/glu/platform/android/facebook/MixedHash;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/glu/platform/android/facebook/MixedHash$MixedHashContents;
    }
.end annotation


# instance fields
.field private m_trueHash:Ljava/util/Hashtable;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Hashtable",
            "<",
            "Ljava/lang/String;",
            "Lcom/glu/platform/android/facebook/MixedHash$MixedHashContents;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    new-instance v0, Ljava/util/Hashtable;

    invoke-direct {v0}, Ljava/util/Hashtable;-><init>()V

    iput-object v0, p0, Lcom/glu/platform/android/facebook/MixedHash;->m_trueHash:Ljava/util/Hashtable;

    return-void
.end method


# virtual methods
.method public final putMixedHashVector(Ljava/lang/String;Ljava/util/Vector;)V
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/util/Vector",
            "<",
            "Lcom/glu/platform/android/facebook/MixedHash;",
            ">;)V"
        }
    .end annotation

    new-instance v0, Lcom/glu/platform/android/facebook/MixedHash$MixedHashContents;

    invoke-direct {v0}, Lcom/glu/platform/android/facebook/MixedHash$MixedHashContents;-><init>()V

    invoke-static {v0, p2}, Lcom/glu/platform/android/facebook/MixedHash$MixedHashContents;->access$402(Lcom/glu/platform/android/facebook/MixedHash$MixedHashContents;Ljava/util/Vector;)Ljava/util/Vector;

    iget-object v1, p0, Lcom/glu/platform/android/facebook/MixedHash;->m_trueHash:Ljava/util/Hashtable;

    invoke-virtual {v1, p1, v0}, Ljava/util/Hashtable;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    return-void
.end method

.method public final putString(Ljava/lang/String;Ljava/lang/String;)V
    .locals 2

    new-instance v0, Lcom/glu/platform/android/facebook/MixedHash$MixedHashContents;

    invoke-direct {v0}, Lcom/glu/platform/android/facebook/MixedHash$MixedHashContents;-><init>()V

    invoke-static {v0, p2}, Lcom/glu/platform/android/facebook/MixedHash$MixedHashContents;->access$002(Lcom/glu/platform/android/facebook/MixedHash$MixedHashContents;Ljava/lang/String;)Ljava/lang/String;

    iget-object v1, p0, Lcom/glu/platform/android/facebook/MixedHash;->m_trueHash:Ljava/util/Hashtable;

    invoke-virtual {v1, p1, v0}, Ljava/util/Hashtable;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    return-void
.end method
