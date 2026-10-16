.class public final Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer$Bucket;
    }
.end annotation


# instance fields
.field private _collCount:I

.field private _collEnd:I

.field private _collList:[Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer$Bucket;

.field private _collListShared:Z

.field private _count:I

.field final _intern:Z

.field private _mainHash:[I

.field private _mainHashMask:I

.field private _mainHashShared:Z

.field private _mainNames:[Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/Name;

.field private _mainNamesShared:Z

.field private transient _needRehash:Z

.field final _parent:Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;


# direct methods
.method private constructor <init>()V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_parent:Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_intern:Z

    invoke-direct {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->initTables$13462e()V

    return-void
.end method

.method private constructor <init>(Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;Z)V
    .locals 2

    const/4 v1, 0x1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_parent:Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;

    iput-boolean p2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_intern:Z

    iget v0, p1, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_count:I

    iput v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_count:I

    iget v0, p1, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_mainHashMask:I

    iput v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_mainHashMask:I

    iget-object v0, p1, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_mainHash:[I

    iput-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_mainHash:[I

    iget-object v0, p1, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_mainNames:[Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/Name;

    iput-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_mainNames:[Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/Name;

    iget-object v0, p1, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_collList:[Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer$Bucket;

    iput-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_collList:[Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer$Bucket;

    iget v0, p1, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_collCount:I

    iput v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_collCount:I

    iget v0, p1, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_collEnd:I

    iput v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_collEnd:I

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_needRehash:Z

    iput-boolean v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_mainHashShared:Z

    iput-boolean v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_mainNamesShared:Z

    iput-boolean v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_collListShared:Z

    return-void
.end method

.method private static calcHash([II)I
    .locals 3

    const/4 v0, 0x0

    aget v1, p0, v0

    const/4 v0, 0x1

    :goto_0
    if-ge v0, p1, :cond_0

    mul-int/lit8 v1, v1, 0x1f

    aget v2, p0, v0

    add-int/2addr v1, v2

    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_0
    ushr-int/lit8 v0, v1, 0x10

    xor-int/2addr v0, v1

    ushr-int/lit8 v1, v0, 0x8

    xor-int/2addr v0, v1

    return v0
.end method

.method public static createRoot()Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;
    .locals 1

    new-instance v0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;

    invoke-direct {v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;-><init>()V

    return-object v0
.end method

.method private expandCollision()V
    .locals 4

    const/4 v3, 0x0

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_collList:[Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer$Bucket;

    array-length v1, v0

    add-int v2, v1, v1

    new-array v2, v2, [Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer$Bucket;

    iput-object v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_collList:[Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer$Bucket;

    iget-object v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_collList:[Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer$Bucket;

    invoke-static {v0, v3, v2, v3, v1}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    return-void
.end method

.method private findBestBucket()I
    .locals 8

    const/4 v4, 0x1

    iget-object v6, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_collList:[Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer$Bucket;

    const v3, 0x7fffffff

    const/4 v0, -0x1

    const/4 v1, 0x0

    iget v7, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_collEnd:I

    :goto_0
    if-ge v1, v7, :cond_2

    aget-object v2, v6, v1

    iget-object v2, v2, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer$Bucket;->mNext:Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer$Bucket;

    move-object v5, v2

    move v2, v4

    :goto_1
    if-eqz v5, :cond_0

    add-int/lit8 v2, v2, 0x1

    iget-object v5, v5, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer$Bucket;->mNext:Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer$Bucket;

    goto :goto_1

    :cond_0
    if-ge v2, v3, :cond_3

    if-ne v2, v4, :cond_1

    :goto_2
    return v1

    :cond_1
    move v0, v1

    :goto_3
    add-int/lit8 v1, v1, 0x1

    move v3, v2

    goto :goto_0

    :cond_2
    move v1, v0

    goto :goto_2

    :cond_3
    move v2, v3

    goto :goto_3
.end method

.method public static getEmptyName()Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/Name;
    .locals 1

    invoke-static {}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/Name1;->getEmptyName()Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/Name1;

    move-result-object v0

    return-object v0
.end method

.method private initTables$13462e()V
    .locals 3

    const/16 v2, 0x40

    const/4 v1, 0x0

    iput v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_count:I

    new-array v0, v2, [I

    iput-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_mainHash:[I

    new-array v0, v2, [Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/Name;

    iput-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_mainNames:[Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/Name;

    iput-boolean v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_mainHashShared:Z

    iput-boolean v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_mainNamesShared:Z

    const/16 v0, 0x3f

    iput v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_mainHashMask:I

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_collListShared:Z

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_collList:[Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer$Bucket;

    iput v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_collEnd:I

    iput-boolean v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_needRehash:Z

    return-void
.end method

.method private declared-synchronized mergeChild(Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;)V
    .locals 2

    monitor-enter p0

    :try_start_0
    iget v0, p1, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_count:I

    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_count:I
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-gt v0, v1, :cond_0

    :goto_0
    monitor-exit p0

    return-void

    :cond_0
    :try_start_1
    iget v0, p1, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_count:I

    const/16 v1, 0x1770

    if-le v0, v1, :cond_1

    invoke-direct {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->initTables$13462e()V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0

    :cond_1
    :try_start_2
    iget v0, p1, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_count:I

    iput v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_count:I

    iget-object v0, p1, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_mainHash:[I

    iput-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_mainHash:[I

    iget-object v0, p1, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_mainNames:[Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/Name;

    iput-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_mainNames:[Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/Name;

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_mainHashShared:Z

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_mainNamesShared:Z

    iget v0, p1, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_mainHashMask:I

    iput v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_mainHashMask:I

    iget-object v0, p1, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_collList:[Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer$Bucket;

    iput-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_collList:[Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer$Bucket;

    iget v0, p1, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_collCount:I

    iput v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_collCount:I

    iget v0, p1, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_collEnd:I

    iput v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_collEnd:I
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    goto :goto_0
.end method


# virtual methods
.method public final addName(Ljava/lang/String;[II)Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/Name;
    .locals 15

    iget-boolean v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_intern:Z

    if-eqz v1, :cond_16

    sget-object v1, Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/InternCache;->instance:Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/InternCache;

    move-object/from16 v0, p1

    invoke-virtual {v1, v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/InternCache;->intern(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    :goto_0
    invoke-static/range {p2 .. p3}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->calcHash([II)I

    move-result v3

    const/4 v1, 0x4

    move/from16 v0, p3

    if-ge v0, v1, :cond_0

    packed-switch p3, :pswitch_data_0

    :cond_0
    move/from16 v0, p3

    new-array v4, v0, [I

    const/4 v1, 0x0

    :goto_1
    move/from16 v0, p3

    if-ge v1, v0, :cond_5

    aget v5, p2, v1

    aput v5, v4, v1

    add-int/lit8 v1, v1, 0x1

    goto :goto_1

    :pswitch_0
    new-instance v1, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/Name1;

    const/4 v4, 0x0

    aget v4, p2, v4

    invoke-direct {v1, v2, v3, v4}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/Name1;-><init>(Ljava/lang/String;II)V

    :goto_2
    iget-boolean v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_mainHashShared:Z

    if-eqz v2, :cond_1

    iget-object v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_mainHash:[I

    iget-object v4, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_mainHash:[I

    array-length v4, v4

    new-array v5, v4, [I

    iput-object v5, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_mainHash:[I

    const/4 v5, 0x0

    iget-object v6, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_mainHash:[I

    const/4 v7, 0x0

    invoke-static {v2, v5, v6, v7, v4}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    const/4 v2, 0x0

    iput-boolean v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_mainHashShared:Z

    :cond_1
    iget-boolean v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_needRehash:Z

    if-eqz v2, :cond_2

    const/4 v2, 0x0

    iput-boolean v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_needRehash:Z

    const/4 v2, 0x0

    iput-boolean v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_mainNamesShared:Z

    iget-object v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_mainHash:[I

    array-length v5, v2

    add-int v2, v5, v5

    const/high16 v4, 0x10000

    if-le v2, v4, :cond_6

    const/4 v2, 0x0

    iput v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_count:I

    iget-object v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_mainHash:[I

    const/4 v4, 0x0

    invoke-static {v2, v4}, Ljava/util/Arrays;->fill([II)V

    iget-object v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_mainNames:[Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/Name;

    const/4 v4, 0x0

    invoke-static {v2, v4}, Ljava/util/Arrays;->fill([Ljava/lang/Object;Ljava/lang/Object;)V

    iget-object v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_collList:[Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer$Bucket;

    const/4 v4, 0x0

    invoke-static {v2, v4}, Ljava/util/Arrays;->fill([Ljava/lang/Object;Ljava/lang/Object;)V

    const/4 v2, 0x0

    iput v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_collCount:I

    const/4 v2, 0x0

    iput v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_collEnd:I

    :cond_2
    iget v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_count:I

    add-int/lit8 v2, v2, 0x1

    iput v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_count:I

    iget v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_mainHashMask:I

    and-int v4, v3, v2

    iget-object v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_mainNames:[Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/Name;

    aget-object v2, v2, v4

    if-nez v2, :cond_f

    iget-object v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_mainHash:[I

    shl-int/lit8 v3, v3, 0x8

    aput v3, v2, v4

    iget-boolean v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_mainNamesShared:Z

    if-eqz v2, :cond_3

    iget-object v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_mainNames:[Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/Name;

    array-length v3, v2

    new-array v5, v3, [Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/Name;

    iput-object v5, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_mainNames:[Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/Name;

    const/4 v5, 0x0

    iget-object v6, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_mainNames:[Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/Name;

    const/4 v7, 0x0

    invoke-static {v2, v5, v6, v7, v3}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    const/4 v2, 0x0

    iput-boolean v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_mainNamesShared:Z

    :cond_3
    iget-object v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_mainNames:[Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/Name;

    aput-object v1, v2, v4

    :goto_3
    iget-object v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_mainHash:[I

    array-length v2, v2

    iget v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_count:I

    shr-int/lit8 v4, v2, 0x1

    if-le v3, v4, :cond_4

    shr-int/lit8 v3, v2, 0x2

    iget v4, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_count:I

    sub-int/2addr v2, v3

    if-le v4, v2, :cond_15

    const/4 v2, 0x1

    iput-boolean v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_needRehash:Z

    :cond_4
    :goto_4
    return-object v1

    :pswitch_1
    new-instance v1, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/Name2;

    const/4 v4, 0x0

    aget v4, p2, v4

    const/4 v5, 0x1

    aget v5, p2, v5

    invoke-direct {v1, v2, v3, v4, v5}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/Name2;-><init>(Ljava/lang/String;III)V

    goto/16 :goto_2

    :pswitch_2
    new-instance v1, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/Name3;

    const/4 v4, 0x0

    aget v4, p2, v4

    const/4 v5, 0x1

    aget v5, p2, v5

    const/4 v6, 0x2

    aget v6, p2, v6

    invoke-direct/range {v1 .. v6}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/Name3;-><init>(Ljava/lang/String;IIII)V

    goto/16 :goto_2

    :cond_5
    new-instance v1, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/NameN;

    move/from16 v0, p3

    invoke-direct {v1, v2, v3, v4, v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/NameN;-><init>(Ljava/lang/String;I[II)V

    goto/16 :goto_2

    :cond_6
    new-array v4, v2, [I

    iput-object v4, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_mainHash:[I

    add-int/lit8 v4, v2, -0x1

    iput v4, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_mainHashMask:I

    iget-object v6, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_mainNames:[Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/Name;

    new-array v2, v2, [Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/Name;

    iput-object v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_mainNames:[Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/Name;

    const/4 v4, 0x0

    const/4 v2, 0x0

    move v14, v2

    move v2, v4

    move v4, v14

    :goto_5
    if-ge v4, v5, :cond_8

    aget-object v7, v6, v4

    if-eqz v7, :cond_7

    add-int/lit8 v2, v2, 0x1

    invoke-virtual {v7}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/Name;->hashCode()I

    move-result v8

    iget v9, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_mainHashMask:I

    and-int/2addr v9, v8

    iget-object v10, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_mainNames:[Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/Name;

    aput-object v7, v10, v9

    iget-object v7, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_mainHash:[I

    shl-int/lit8 v8, v8, 0x8

    aput v8, v7, v9

    :cond_7
    add-int/lit8 v4, v4, 0x1

    goto :goto_5

    :cond_8
    iget v7, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_collEnd:I

    if-eqz v7, :cond_2

    const/4 v4, 0x0

    iput v4, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_collCount:I

    const/4 v4, 0x0

    iput v4, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_collEnd:I

    const/4 v4, 0x0

    iput-boolean v4, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_collListShared:Z

    iget-object v8, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_collList:[Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer$Bucket;

    array-length v4, v8

    new-array v4, v4, [Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer$Bucket;

    iput-object v4, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_collList:[Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer$Bucket;

    const/4 v4, 0x0

    :goto_6
    if-ge v4, v7, :cond_e

    aget-object v5, v8, v4

    move-object v6, v5

    move v5, v2

    :goto_7
    if-eqz v6, :cond_d

    add-int/lit8 v5, v5, 0x1

    iget-object v9, v6, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer$Bucket;->mName:Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/Name;

    invoke-virtual {v9}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/Name;->hashCode()I

    move-result v2

    iget v10, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_mainHashMask:I

    and-int/2addr v10, v2

    iget-object v11, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_mainHash:[I

    aget v11, v11, v10

    iget-object v12, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_mainNames:[Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/Name;

    aget-object v12, v12, v10

    if-nez v12, :cond_9

    iget-object v11, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_mainHash:[I

    shl-int/lit8 v2, v2, 0x8

    aput v2, v11, v10

    iget-object v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_mainNames:[Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/Name;

    aput-object v9, v2, v10

    :goto_8
    iget-object v2, v6, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer$Bucket;->mNext:Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer$Bucket;

    move-object v6, v2

    goto :goto_7

    :cond_9
    iget v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_collCount:I

    add-int/lit8 v2, v2, 0x1

    iput v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_collCount:I

    and-int/lit16 v2, v11, 0xff

    if-nez v2, :cond_c

    iget v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_collEnd:I

    const/16 v12, 0xfe

    if-gt v2, v12, :cond_b

    iget v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_collEnd:I

    iget v12, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_collEnd:I

    add-int/lit8 v12, v12, 0x1

    iput v12, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_collEnd:I

    iget-object v12, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_collList:[Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer$Bucket;

    array-length v12, v12

    if-lt v2, v12, :cond_a

    invoke-direct {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->expandCollision()V

    :cond_a
    :goto_9
    iget-object v12, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_mainHash:[I

    and-int/lit16 v11, v11, -0x100

    add-int/lit8 v13, v2, 0x1

    or-int/2addr v11, v13

    aput v11, v12, v10

    :goto_a
    iget-object v10, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_collList:[Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer$Bucket;

    new-instance v11, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer$Bucket;

    iget-object v12, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_collList:[Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer$Bucket;

    aget-object v12, v12, v2

    invoke-direct {v11, v9, v12}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer$Bucket;-><init>(Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/Name;Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer$Bucket;)V

    aput-object v11, v10, v2

    goto :goto_8

    :cond_b
    invoke-direct {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->findBestBucket()I

    move-result v2

    goto :goto_9

    :cond_c
    add-int/lit8 v2, v2, -0x1

    goto :goto_a

    :cond_d
    add-int/lit8 v2, v4, 0x1

    move v4, v2

    move v2, v5

    goto :goto_6

    :cond_e
    iget v4, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_count:I

    if-eq v2, v4, :cond_2

    new-instance v1, Ljava/lang/RuntimeException;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Internal error: count after rehash "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "; should be "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_count:I

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    throw v1

    :cond_f
    iget-boolean v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_collListShared:Z

    if-eqz v2, :cond_10

    iget-object v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_collList:[Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer$Bucket;

    if-nez v2, :cond_12

    const/16 v2, 0x20

    new-array v2, v2, [Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer$Bucket;

    iput-object v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_collList:[Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer$Bucket;

    :goto_b
    const/4 v2, 0x0

    iput-boolean v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_collListShared:Z

    :cond_10
    iget v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_collCount:I

    add-int/lit8 v2, v2, 0x1

    iput v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_collCount:I

    iget-object v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_mainHash:[I

    aget v3, v2, v4

    and-int/lit16 v2, v3, 0xff

    if-nez v2, :cond_14

    iget v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_collEnd:I

    const/16 v5, 0xfe

    if-gt v2, v5, :cond_13

    iget v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_collEnd:I

    iget v5, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_collEnd:I

    add-int/lit8 v5, v5, 0x1

    iput v5, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_collEnd:I

    iget-object v5, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_collList:[Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer$Bucket;

    array-length v5, v5

    if-lt v2, v5, :cond_11

    invoke-direct {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->expandCollision()V

    :cond_11
    :goto_c
    iget-object v5, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_mainHash:[I

    and-int/lit16 v3, v3, -0x100

    add-int/lit8 v6, v2, 0x1

    or-int/2addr v3, v6

    aput v3, v5, v4

    :goto_d
    iget-object v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_collList:[Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer$Bucket;

    new-instance v4, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer$Bucket;

    iget-object v5, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_collList:[Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer$Bucket;

    aget-object v5, v5, v2

    invoke-direct {v4, v1, v5}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer$Bucket;-><init>(Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/Name;Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer$Bucket;)V

    aput-object v4, v3, v2

    goto/16 :goto_3

    :cond_12
    array-length v3, v2

    new-array v5, v3, [Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer$Bucket;

    iput-object v5, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_collList:[Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer$Bucket;

    const/4 v5, 0x0

    iget-object v6, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_collList:[Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer$Bucket;

    const/4 v7, 0x0

    invoke-static {v2, v5, v6, v7, v3}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    goto :goto_b

    :cond_13
    invoke-direct {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->findBestBucket()I

    move-result v2

    goto :goto_c

    :cond_14
    add-int/lit8 v2, v2, -0x1

    goto :goto_d

    :cond_15
    iget v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_collCount:I

    if-lt v2, v3, :cond_4

    const/4 v2, 0x1

    iput-boolean v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_needRehash:Z

    goto/16 :goto_4

    :cond_16
    move-object/from16 v2, p1

    goto/16 :goto_0

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_0
        :pswitch_1
        :pswitch_2
    .end packed-switch
.end method

.method public final findName(I)Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/Name;
    .locals 5

    const/4 v0, 0x0

    ushr-int/lit8 v1, p1, 0x10

    xor-int/2addr v1, p1

    ushr-int/lit8 v2, v1, 0x8

    xor-int/2addr v2, v1

    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_mainHashMask:I

    and-int/2addr v1, v2

    iget-object v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_mainHash:[I

    aget v3, v3, v1

    shr-int/lit8 v4, v3, 0x8

    xor-int/2addr v4, v2

    shl-int/lit8 v4, v4, 0x8

    if-nez v4, :cond_2

    iget-object v4, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_mainNames:[Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/Name;

    aget-object v1, v4, v1

    if-nez v1, :cond_1

    :cond_0
    :goto_0
    return-object v0

    :cond_1
    invoke-virtual {v1, p1}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/Name;->equals(I)Z

    move-result v4

    if-eqz v4, :cond_3

    move-object v0, v1

    goto :goto_0

    :cond_2
    if-eqz v3, :cond_0

    :cond_3
    and-int/lit16 v1, v3, 0xff

    if-lez v1, :cond_0

    add-int/lit8 v1, v1, -0x1

    iget-object v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_collList:[Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer$Bucket;

    aget-object v1, v3, v1

    if-eqz v1, :cond_0

    const/4 v0, 0x0

    invoke-virtual {v1, v2, p1, v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer$Bucket;->find(III)Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/Name;

    move-result-object v0

    goto :goto_0
.end method

.method public final findName(II)Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/Name;
    .locals 5

    const/4 v0, 0x0

    mul-int/lit8 v1, p1, 0x1f

    add-int/2addr v1, p2

    ushr-int/lit8 v2, v1, 0x10

    xor-int/2addr v1, v2

    ushr-int/lit8 v2, v1, 0x8

    xor-int/2addr v2, v1

    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_mainHashMask:I

    and-int/2addr v1, v2

    iget-object v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_mainHash:[I

    aget v3, v3, v1

    shr-int/lit8 v4, v3, 0x8

    xor-int/2addr v4, v2

    shl-int/lit8 v4, v4, 0x8

    if-nez v4, :cond_2

    iget-object v4, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_mainNames:[Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/Name;

    aget-object v1, v4, v1

    if-nez v1, :cond_1

    :cond_0
    :goto_0
    return-object v0

    :cond_1
    invoke-virtual {v1, p1, p2}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/Name;->equals(II)Z

    move-result v4

    if-eqz v4, :cond_3

    move-object v0, v1

    goto :goto_0

    :cond_2
    if-eqz v3, :cond_0

    :cond_3
    and-int/lit16 v1, v3, 0xff

    if-lez v1, :cond_0

    add-int/lit8 v1, v1, -0x1

    iget-object v3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_collList:[Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer$Bucket;

    aget-object v1, v3, v1

    if-eqz v1, :cond_0

    invoke-virtual {v1, v2, p1, p2}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer$Bucket;->find(III)Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/Name;

    move-result-object v0

    goto :goto_0
.end method

.method public final findName([II)Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/Name;
    .locals 5

    const/4 v1, 0x0

    invoke-static {p1, p2}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->calcHash([II)I

    move-result v3

    iget v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_mainHashMask:I

    and-int/2addr v0, v3

    iget-object v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_mainHash:[I

    aget v2, v2, v0

    shr-int/lit8 v4, v2, 0x8

    xor-int/2addr v4, v3

    shl-int/lit8 v4, v4, 0x8

    if-nez v4, :cond_1

    iget-object v4, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_mainNames:[Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/Name;

    aget-object v0, v4, v0

    if-eqz v0, :cond_0

    invoke-virtual {v0, p1, p2}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/Name;->equals([II)Z

    move-result v4

    if-eqz v4, :cond_2

    :cond_0
    :goto_0
    return-object v0

    :cond_1
    if-nez v2, :cond_2

    move-object v0, v1

    goto :goto_0

    :cond_2
    and-int/lit16 v0, v2, 0xff

    if-lez v0, :cond_6

    add-int/lit8 v0, v0, -0x1

    iget-object v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_collList:[Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer$Bucket;

    aget-object v0, v2, v0

    if-eqz v0, :cond_6

    iget-object v2, v0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer$Bucket;->mName:Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/Name;

    invoke-virtual {v2}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/Name;->hashCode()I

    move-result v2

    if-ne v2, v3, :cond_3

    iget-object v2, v0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer$Bucket;->mName:Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/Name;

    invoke-virtual {v2, p1, p2}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/Name;->equals([II)Z

    move-result v2

    if-eqz v2, :cond_3

    iget-object v0, v0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer$Bucket;->mName:Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/Name;

    goto :goto_0

    :cond_3
    iget-object v0, v0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer$Bucket;->mNext:Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer$Bucket;

    move-object v2, v0

    :goto_1
    if-eqz v2, :cond_5

    iget-object v0, v2, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer$Bucket;->mName:Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/Name;

    invoke-virtual {v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/Name;->hashCode()I

    move-result v4

    if-ne v4, v3, :cond_4

    invoke-virtual {v0, p1, p2}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/Name;->equals([II)Z

    move-result v4

    if-nez v4, :cond_0

    :cond_4
    iget-object v0, v2, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer$Bucket;->mNext:Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer$Bucket;

    move-object v2, v0

    goto :goto_1

    :cond_5
    move-object v0, v1

    goto :goto_0

    :cond_6
    move-object v0, v1

    goto :goto_0
.end method

.method public final declared-synchronized makeChild$5e0e244d(Z)Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;
    .locals 1

    monitor-enter p0

    :try_start_0
    new-instance v0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;

    invoke-direct {v0, p0, p1}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;-><init>(Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;Z)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return-object v0

    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public final release()V
    .locals 2

    const/4 v1, 0x1

    iget-boolean v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_mainHashShared:Z

    if-nez v0, :cond_1

    move v0, v1

    :goto_0
    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_parent:Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_parent:Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;

    invoke-direct {v0, p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->mergeChild(Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;)V

    iput-boolean v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_mainHashShared:Z

    iput-boolean v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_mainNamesShared:Z

    iput-boolean v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/BytesToNameCanonicalizer;->_collListShared:Z

    :cond_0
    return-void

    :cond_1
    const/4 v0, 0x0

    goto :goto_0
.end method
