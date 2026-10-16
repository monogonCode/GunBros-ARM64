.class public final Lcom/openfeint/internal/db/DB$DataStorageHelperX;
.super Lcom/openfeint/internal/db/SQLiteOpenHelperX;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/openfeint/internal/db/DB;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "DataStorageHelperX"
.end annotation


# direct methods
.method constructor <init>(Landroid/content/Context;)V
    .locals 1

    new-instance v0, Lcom/openfeint/internal/db/DB$DataStorageHelper;

    invoke-direct {v0, p1}, Lcom/openfeint/internal/db/DB$DataStorageHelper;-><init>(Landroid/content/Context;)V

    invoke-direct {p0, v0}, Lcom/openfeint/internal/db/SQLiteOpenHelperX;-><init>(Landroid/database/sqlite/SQLiteOpenHelper;)V

    return-void
.end method

.method constructor <init>(Ljava/lang/String;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/openfeint/internal/db/SQLiteOpenHelperX;-><init>(Ljava/lang/String;)V

    return-void
.end method


# virtual methods
.method public final onCreate(Landroid/database/sqlite/SQLiteDatabase;)V
    .locals 0

    invoke-static {p1}, Lcom/openfeint/internal/db/DB;->access$000(Landroid/database/sqlite/SQLiteDatabase;)V

    return-void
.end method

.method public final onUpgrade(Landroid/database/sqlite/SQLiteDatabase;II)V
    .locals 0

    invoke-static {p1, p2, p3}, Lcom/openfeint/internal/db/DB;->access$100(Landroid/database/sqlite/SQLiteDatabase;II)V

    return-void
.end method
