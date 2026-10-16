.class public Lcom/urbanairship/util/DrawableCache;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/urbanairship/util/DrawableCache$LRUCache;
    }
.end annotation


# instance fields
.field private currentSize:I

.field private final drawableMap:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map",
            "<",
            "Ljava/lang/String;",
            "Landroid/graphics/drawable/Drawable;",
            ">;"
        }
    .end annotation
.end field

.field private maxSize:I


# direct methods
.method public constructor <init>(I)V
    .locals 3

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    new-instance v0, Lcom/urbanairship/util/DrawableCache$LRUCache;

    const/16 v1, 0x14

    const/high16 v2, 0x3f400000    # 0.75f

    invoke-direct {v0, p0, v1, v2}, Lcom/urbanairship/util/DrawableCache$LRUCache;-><init>(Lcom/urbanairship/util/DrawableCache;IF)V

    invoke-static {v0}, Ljava/util/Collections;->synchronizedMap(Ljava/util/Map;)Ljava/util/Map;

    move-result-object v0

    iput-object v0, p0, Lcom/urbanairship/util/DrawableCache;->drawableMap:Ljava/util/Map;

    invoke-virtual {p0, p1}, Lcom/urbanairship/util/DrawableCache;->setMaxSize(I)V

    return-void
.end method

.method static synthetic access$000(Lcom/urbanairship/util/DrawableCache;Ljava/lang/Object;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/urbanairship/util/DrawableCache;->incrementSizeBy(Ljava/lang/Object;)V

    return-void
.end method

.method static synthetic access$100(Lcom/urbanairship/util/DrawableCache;Ljava/lang/Object;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/urbanairship/util/DrawableCache;->decrementSizeBy(Ljava/lang/Object;)V

    return-void
.end method

.method private decrementSizeBy(Ljava/lang/Object;)V
    .locals 2

    iget v0, p0, Lcom/urbanairship/util/DrawableCache;->currentSize:I

    check-cast p1, Landroid/graphics/drawable/Drawable;

    invoke-direct {p0, p1}, Lcom/urbanairship/util/DrawableCache;->estimatedSize(Landroid/graphics/drawable/Drawable;)I

    move-result v1

    sub-int/2addr v0, v1

    iput v0, p0, Lcom/urbanairship/util/DrawableCache;->currentSize:I

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "DrawableCache decrement: ~"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/urbanairship/util/DrawableCache;->currentSize:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " bytes"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/urbanairship/Logger;->verbose(Ljava/lang/String;)V

    return-void
.end method

.method private estimatedSize(Landroid/graphics/drawable/Drawable;)I
    .locals 2

    invoke-virtual {p1}, Landroid/graphics/drawable/Drawable;->getIntrinsicWidth()I

    move-result v0

    invoke-virtual {p1}, Landroid/graphics/drawable/Drawable;->getIntrinsicHeight()I

    move-result v1

    if-ltz v0, :cond_0

    if-gez v1, :cond_1

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0

    :cond_1
    mul-int/2addr v0, v1

    mul-int/lit8 v0, v0, 0x4

    goto :goto_0
.end method

.method private housekeeping()V
    .locals 5

    iget v0, p0, Lcom/urbanairship/util/DrawableCache;->currentSize:I

    iget v1, p0, Lcom/urbanairship/util/DrawableCache;->maxSize:I

    if-le v0, v1, :cond_1

    const-string v0, "DrawableCache: purge"

    invoke-static {v0}, Lcom/urbanairship/Logger;->verbose(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/urbanairship/util/DrawableCache;->drawableMap:Ljava/util/Map;

    invoke-interface {v0}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object v0

    iget-object v1, p0, Lcom/urbanairship/util/DrawableCache;->drawableMap:Ljava/util/Map;

    monitor-enter v1

    :try_start_0
    invoke-interface {v0}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_0

    iget v0, p0, Lcom/urbanairship/util/DrawableCache;->currentSize:I

    iget v3, p0, Lcom/urbanairship/util/DrawableCache;->maxSize:I

    if-le v0, v3, :cond_0

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/Map$Entry;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "DrawableCache: removing "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-interface {v0}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/urbanairship/Logger;->verbose(Ljava/lang/String;)V

    invoke-interface {v2}, Ljava/util/Iterator;->remove()V

    goto :goto_0

    :catchall_0
    move-exception v0

    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0

    :cond_0
    :try_start_1
    monitor-exit v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    :cond_1
    return-void
.end method

.method private incrementSizeBy(Ljava/lang/Object;)V
    .locals 2

    iget v0, p0, Lcom/urbanairship/util/DrawableCache;->currentSize:I

    check-cast p1, Landroid/graphics/drawable/Drawable;

    invoke-direct {p0, p1}, Lcom/urbanairship/util/DrawableCache;->estimatedSize(Landroid/graphics/drawable/Drawable;)I

    move-result v1

    add-int/2addr v0, v1

    iput v0, p0, Lcom/urbanairship/util/DrawableCache;->currentSize:I

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "DrawableCache increment: ~"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/urbanairship/util/DrawableCache;->currentSize:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " bytes"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/urbanairship/Logger;->verbose(Ljava/lang/String;)V

    return-void
.end method


# virtual methods
.method public containsKey(Ljava/lang/String;)Z
    .locals 1

    iget-object v0, p0, Lcom/urbanairship/util/DrawableCache;->drawableMap:Ljava/util/Map;

    invoke-interface {v0, p1}, Ljava/util/Map;->containsKey(Ljava/lang/Object;)Z

    move-result v0

    return v0
.end method

.method public get(Ljava/lang/String;)Landroid/graphics/drawable/Drawable;
    .locals 1

    iget-object v0, p0, Lcom/urbanairship/util/DrawableCache;->drawableMap:Ljava/util/Map;

    invoke-interface {v0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/graphics/drawable/Drawable;

    return-object v0
.end method

.method public put(Ljava/lang/String;Landroid/graphics/drawable/Drawable;)Landroid/graphics/drawable/Drawable;
    .locals 1

    iget-object v0, p0, Lcom/urbanairship/util/DrawableCache;->drawableMap:Ljava/util/Map;

    invoke-interface {v0, p1, p2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    invoke-direct {p0}, Lcom/urbanairship/util/DrawableCache;->housekeeping()V

    return-object p2
.end method

.method public remove(Ljava/lang/String;)Landroid/graphics/drawable/Drawable;
    .locals 1

    iget-object v0, p0, Lcom/urbanairship/util/DrawableCache;->drawableMap:Ljava/util/Map;

    invoke-interface {v0, p1}, Ljava/util/Map;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/graphics/drawable/Drawable;

    return-object v0
.end method

.method public setMaxSize(I)V
    .locals 0

    iput p1, p0, Lcom/urbanairship/util/DrawableCache;->maxSize:I

    return-void
.end method
