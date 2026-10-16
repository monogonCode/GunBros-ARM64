.class public final Lcom/openfeint/internal/analytics/internal/TimeUtil;
.super Ljava/lang/Object;


# static fields
.field private static accumulated_ms:J


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static getAccumulated_ms()J
    .locals 2

    sget-wide v0, Lcom/openfeint/internal/analytics/internal/TimeUtil;->accumulated_ms:J

    return-wide v0
.end method
