.class public final Lcom/openfeint/internal/SyncedStore$Editor;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/openfeint/internal/SyncedStore;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1
    name = "Editor"
.end annotation


# instance fields
.field final synthetic this$0:Lcom/openfeint/internal/SyncedStore;


# direct methods
.method public constructor <init>(Lcom/openfeint/internal/SyncedStore;)V
    .locals 0

    iput-object p1, p0, Lcom/openfeint/internal/SyncedStore$Editor;->this$0:Lcom/openfeint/internal/SyncedStore;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final commit()V
    .locals 1

    iget-object v0, p0, Lcom/openfeint/internal/SyncedStore$Editor;->this$0:Lcom/openfeint/internal/SyncedStore;

    invoke-virtual {v0}, Lcom/openfeint/internal/SyncedStore;->save()V

    iget-object v0, p0, Lcom/openfeint/internal/SyncedStore$Editor;->this$0:Lcom/openfeint/internal/SyncedStore;

    invoke-static {v0}, Lcom/openfeint/internal/SyncedStore;->access$100(Lcom/openfeint/internal/SyncedStore;)Ljava/util/concurrent/locks/ReentrantReadWriteLock;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/concurrent/locks/ReentrantReadWriteLock;->writeLock()Ljava/util/concurrent/locks/ReentrantReadWriteLock$WriteLock;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/concurrent/locks/ReentrantReadWriteLock$WriteLock;->unlock()V

    return-void
.end method

.method public final putString(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1

    iget-object v0, p0, Lcom/openfeint/internal/SyncedStore$Editor;->this$0:Lcom/openfeint/internal/SyncedStore;

    invoke-static {v0}, Lcom/openfeint/internal/SyncedStore;->access$000(Lcom/openfeint/internal/SyncedStore;)Ljava/util/HashMap;

    move-result-object v0

    invoke-virtual {v0, p1, p2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    return-void
.end method

.method public final remove(Ljava/lang/String;)V
    .locals 1

    iget-object v0, p0, Lcom/openfeint/internal/SyncedStore$Editor;->this$0:Lcom/openfeint/internal/SyncedStore;

    invoke-static {v0}, Lcom/openfeint/internal/SyncedStore;->access$000(Lcom/openfeint/internal/SyncedStore;)Ljava/util/HashMap;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/util/HashMap;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    return-void
.end method
