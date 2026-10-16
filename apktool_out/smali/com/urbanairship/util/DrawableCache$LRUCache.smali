.class Lcom/urbanairship/util/DrawableCache$LRUCache;
.super Ljava/util/LinkedHashMap;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/urbanairship/util/DrawableCache;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "LRUCache"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "<K:",
        "Ljava/lang/Object;",
        "V:",
        "Ljava/lang/Object;",
        ">",
        "Ljava/util/LinkedHashMap",
        "<TK;TV;>;"
    }
.end annotation


# static fields
.field private static final serialVersionUID:J = 0x1L


# instance fields
.field final synthetic this$0:Lcom/urbanairship/util/DrawableCache;


# direct methods
.method public constructor <init>(Lcom/urbanairship/util/DrawableCache;IF)V
    .locals 1

    iput-object p1, p0, Lcom/urbanairship/util/DrawableCache$LRUCache;->this$0:Lcom/urbanairship/util/DrawableCache;

    const/4 v0, 0x1

    invoke-direct {p0, p2, p3, v0}, Ljava/util/LinkedHashMap;-><init>(IFZ)V

    return-void
.end method


# virtual methods
.method public put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TK;TV;)TV;"
        }
    .end annotation

    iget-object v0, p0, Lcom/urbanairship/util/DrawableCache$LRUCache;->this$0:Lcom/urbanairship/util/DrawableCache;

    invoke-static {v0, p2}, Lcom/urbanairship/util/DrawableCache;->access$000(Lcom/urbanairship/util/DrawableCache;Ljava/lang/Object;)V

    invoke-super {p0, p1, p2}, Ljava/util/LinkedHashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public remove(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Object;",
            ")TV;"
        }
    .end annotation

    invoke-super {p0, p1}, Ljava/util/LinkedHashMap;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    iget-object v1, p0, Lcom/urbanairship/util/DrawableCache$LRUCache;->this$0:Lcom/urbanairship/util/DrawableCache;

    invoke-static {v1, v0}, Lcom/urbanairship/util/DrawableCache;->access$100(Lcom/urbanairship/util/DrawableCache;Ljava/lang/Object;)V

    return-object v0
.end method

.method protected removeEldestEntry(Ljava/util/Map$Entry;)Z
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Map$Entry",
            "<TK;TV;>;)Z"
        }
    .end annotation

    const/4 v0, 0x0

    return v0
.end method
