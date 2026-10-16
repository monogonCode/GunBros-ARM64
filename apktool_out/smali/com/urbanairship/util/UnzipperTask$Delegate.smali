.class public abstract Lcom/urbanairship/util/UnzipperTask$Delegate;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/urbanairship/util/UnzipperTask;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x409
    name = "Delegate"
.end annotation


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public abstract onFail(Ljava/lang/Exception;)V
.end method

.method public abstract onProgressUpdate(I)V
.end method

.method public abstract onSuccess()V
.end method
