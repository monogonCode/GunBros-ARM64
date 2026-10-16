.class public final Lcom/openfeint/internal/SyncedStore$Reader;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/openfeint/internal/SyncedStore;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1
    name = "Reader"
.end annotation


# instance fields
.field final synthetic this$0:Lcom/openfeint/internal/SyncedStore;


# direct methods
.method public constructor <init>(Lcom/openfeint/internal/SyncedStore;)V
    .locals 0

    iput-object p1, p0, Lcom/openfeint/internal/SyncedStore$Reader;->this$0:Lcom/openfeint/internal/SyncedStore;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final complete()V
    .locals 1

    iget-object v0, p0, Lcom/openfeint/internal/SyncedStore$Reader;->this$0:Lcom/openfeint/internal/SyncedStore;

    invoke-static {v0}, Lcom/openfeint/internal/SyncedStore;->access$100(Lcom/openfeint/internal/SyncedStore;)Ljava/util/concurrent/locks/ReentrantReadWriteLock;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/concurrent/locks/ReentrantReadWriteLock;->readLock()Ljava/util/concurrent/locks/ReentrantReadWriteLock$ReadLock;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/concurrent/locks/ReentrantReadWriteLock$ReadLock;->unlock()V

    return-void
.end method

.method public final getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/openfeint/internal/SyncedStore$Reader;->this$0:Lcom/openfeint/internal/SyncedStore;

    invoke-static {v0}, Lcom/openfeint/internal/SyncedStore;->access$000(Lcom/openfeint/internal/SyncedStore;)Ljava/util/HashMap;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    if-eqz v0, :cond_0

    :goto_0
    return-object v0

    :cond_0
    move-object v0, p2

    goto :goto_0
.end method
