.class public abstract Lcom/openfeint/api/Notification;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/openfeint/api/Notification$Type;,
        Lcom/openfeint/api/Notification$Category;,
        Lcom/openfeint/api/Notification$Delegate;
    }
.end annotation


# static fields
.field private static sDelegate:Lcom/openfeint/api/Notification$Delegate;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/openfeint/api/Notification$Delegate;

    invoke-direct {v0}, Lcom/openfeint/api/Notification$Delegate;-><init>()V

    sput-object v0, Lcom/openfeint/api/Notification;->sDelegate:Lcom/openfeint/api/Notification$Delegate;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static getDelegate()Lcom/openfeint/api/Notification$Delegate;
    .locals 1

    sget-object v0, Lcom/openfeint/api/Notification;->sDelegate:Lcom/openfeint/api/Notification$Delegate;

    return-object v0
.end method
