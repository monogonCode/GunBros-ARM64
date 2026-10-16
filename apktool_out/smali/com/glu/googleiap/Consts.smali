.class public final Lcom/glu/googleiap/Consts;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/glu/googleiap/Consts$PurchaseState;,
        Lcom/glu/googleiap/Consts$ResponseCode;
    }
.end annotation


# static fields
.field public static BILLING_RESPONSE_INVALID_REQUEST_ID:J


# direct methods
.method static constructor <clinit>()V
    .locals 2

    const-wide/16 v0, -0x1

    sput-wide v0, Lcom/glu/googleiap/Consts;->BILLING_RESPONSE_INVALID_REQUEST_ID:J

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method
