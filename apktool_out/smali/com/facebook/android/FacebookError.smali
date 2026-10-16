.class public final Lcom/facebook/android/FacebookError;
.super Ljava/lang/Throwable;


# instance fields
.field private mErrorCode:I

.field private mErrorType:Ljava/lang/String;


# direct methods
.method public constructor <init>(Ljava/lang/String;)V
    .locals 1

    invoke-direct {p0, p1}, Ljava/lang/Throwable;-><init>(Ljava/lang/String;)V

    const/4 v0, 0x0

    iput v0, p0, Lcom/facebook/android/FacebookError;->mErrorCode:I

    return-void
.end method

.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;I)V
    .locals 1

    invoke-direct {p0, p1}, Ljava/lang/Throwable;-><init>(Ljava/lang/String;)V

    const/4 v0, 0x0

    iput v0, p0, Lcom/facebook/android/FacebookError;->mErrorCode:I

    iput-object p2, p0, Lcom/facebook/android/FacebookError;->mErrorType:Ljava/lang/String;

    iput p3, p0, Lcom/facebook/android/FacebookError;->mErrorCode:I

    return-void
.end method
