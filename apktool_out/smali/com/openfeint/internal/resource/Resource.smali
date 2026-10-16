.class public abstract Lcom/openfeint/internal/resource/Resource;
.super Ljava/lang/Object;


# static fields
.field private static sNameMap:Ljava/util/HashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/HashMap",
            "<",
            "Ljava/lang/String;",
            "Lcom/openfeint/internal/resource/ResourceClass;",
            ">;"
        }
    .end annotation
.end field

.field private static sSubclassMap:Ljava/util/HashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/HashMap",
            "<",
            "Ljava/lang/Class",
            "<+",
            "Lcom/openfeint/internal/resource/Resource;",
            ">;",
            "Lcom/openfeint/internal/resource/ResourceClass;",
            ">;"
        }
    .end annotation
.end field


# instance fields
.field mID:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    sput-object v0, Lcom/openfeint/internal/resource/Resource;->sSubclassMap:Ljava/util/HashMap;

    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    sput-object v0, Lcom/openfeint/internal/resource/Resource;->sNameMap:Ljava/util/HashMap;

    invoke-static {}, Lcom/openfeint/internal/resource/Resource;->getResourceClass()Lcom/openfeint/internal/resource/ResourceClass;

    move-result-object v0

    invoke-static {v0}, Lcom/openfeint/internal/resource/Resource;->registerSubclass(Lcom/openfeint/internal/resource/ResourceClass;)V

    invoke-static {}, Lcom/openfeint/internal/resource/ServerException;->getResourceClass()Lcom/openfeint/internal/resource/ResourceClass;

    move-result-object v0

    invoke-static {v0}, Lcom/openfeint/internal/resource/Resource;->registerSubclass(Lcom/openfeint/internal/resource/ResourceClass;)V

    invoke-static {}, Lcom/openfeint/internal/resource/Device;->getResourceClass()Lcom/openfeint/internal/resource/ResourceClass;

    move-result-object v0

    invoke-static {v0}, Lcom/openfeint/internal/resource/Resource;->registerSubclass(Lcom/openfeint/internal/resource/ResourceClass;)V

    invoke-static {}, Lcom/openfeint/internal/resource/ParentalControl;->getResourceClass()Lcom/openfeint/internal/resource/ResourceClass;

    move-result-object v0

    invoke-static {v0}, Lcom/openfeint/internal/resource/Resource;->registerSubclass(Lcom/openfeint/internal/resource/ResourceClass;)V

    invoke-static {}, Lcom/openfeint/api/resource/ServerTimestamp;->getResourceClass()Lcom/openfeint/internal/resource/ResourceClass;

    move-result-object v0

    invoke-static {v0}, Lcom/openfeint/internal/resource/Resource;->registerSubclass(Lcom/openfeint/internal/resource/ResourceClass;)V

    invoke-static {}, Lcom/openfeint/internal/resource/BlobUploadParameters;->getResourceClass()Lcom/openfeint/internal/resource/ResourceClass;

    move-result-object v0

    invoke-static {v0}, Lcom/openfeint/internal/resource/Resource;->registerSubclass(Lcom/openfeint/internal/resource/ResourceClass;)V

    invoke-static {}, Lcom/openfeint/api/resource/Achievement;->getResourceClass()Lcom/openfeint/internal/resource/ResourceClass;

    move-result-object v0

    invoke-static {v0}, Lcom/openfeint/internal/resource/Resource;->registerSubclass(Lcom/openfeint/internal/resource/ResourceClass;)V

    invoke-static {}, Lcom/openfeint/api/resource/Leaderboard;->getResourceClass()Lcom/openfeint/internal/resource/ResourceClass;

    move-result-object v0

    invoke-static {v0}, Lcom/openfeint/internal/resource/Resource;->registerSubclass(Lcom/openfeint/internal/resource/ResourceClass;)V

    invoke-static {}, Lcom/openfeint/api/resource/Score;->getResourceClass()Lcom/openfeint/internal/resource/ResourceClass;

    move-result-object v0

    invoke-static {v0}, Lcom/openfeint/internal/resource/Resource;->registerSubclass(Lcom/openfeint/internal/resource/ResourceClass;)V

    invoke-static {}, Lcom/openfeint/api/resource/User;->getResourceClass()Lcom/openfeint/internal/resource/ResourceClass;

    move-result-object v0

    invoke-static {v0}, Lcom/openfeint/internal/resource/Resource;->registerSubclass(Lcom/openfeint/internal/resource/ResourceClass;)V

    invoke-static {}, Lcom/openfeint/api/resource/CurrentUser;->getResourceClass()Lcom/openfeint/internal/resource/ResourceClass;

    move-result-object v0

    invoke-static {v0}, Lcom/openfeint/internal/resource/Resource;->registerSubclass(Lcom/openfeint/internal/resource/ResourceClass;)V

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private generate(Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonGenerator;)V
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonGenerationException;,
            Ljava/io/IOException;
        }
    .end annotation

    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v0

    invoke-static {v0}, Lcom/openfeint/internal/resource/Resource;->getKlass(Ljava/lang/Class;)Lcom/openfeint/internal/resource/ResourceClass;

    move-result-object v0

    invoke-virtual {p1}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonGenerator;->writeStartObject()V

    iget-object v1, v0, Lcom/openfeint/internal/resource/ResourceClass;->mResourceName:Ljava/lang/String;

    invoke-virtual {p1, v1}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonGenerator;->writeFieldName(Ljava/lang/String;)V

    invoke-virtual {p1}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonGenerator;->writeStartObject()V

    iget-object v0, v0, Lcom/openfeint/internal/resource/ResourceClass;->mProperties:Ljava/util/HashMap;

    invoke-virtual {v0}, Ljava/util/HashMap;->entrySet()Ljava/util/Set;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :cond_0
    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_6

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/Map$Entry;

    invoke-interface {v0}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/openfeint/internal/resource/ResourceProperty;

    instance-of v3, v1, Lcom/openfeint/internal/resource/PrimitiveResourceProperty;

    if-eqz v3, :cond_1

    check-cast v1, Lcom/openfeint/internal/resource/PrimitiveResourceProperty;

    invoke-interface {v0}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    invoke-virtual {v1, p0, p1, v0}, Lcom/openfeint/internal/resource/PrimitiveResourceProperty;->generate(Lcom/openfeint/internal/resource/Resource;Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonGenerator;Ljava/lang/String;)V

    goto :goto_0

    :cond_1
    instance-of v3, v1, Lcom/openfeint/internal/resource/ArrayResourceProperty;

    if-eqz v3, :cond_3

    check-cast v1, Lcom/openfeint/internal/resource/ArrayResourceProperty;

    invoke-virtual {v1, p0}, Lcom/openfeint/internal/resource/ArrayResourceProperty;->get(Lcom/openfeint/internal/resource/Resource;)Ljava/util/List;

    move-result-object v3

    if-eqz v3, :cond_0

    invoke-interface {v0}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    invoke-virtual {p1, v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonGenerator;->writeFieldName(Ljava/lang/String;)V

    invoke-virtual {v1}, Lcom/openfeint/internal/resource/ArrayResourceProperty;->elementType()Ljava/lang/Class;

    move-result-object v0

    invoke-static {v0}, Lcom/openfeint/internal/resource/Resource;->getKlass(Ljava/lang/Class;)Lcom/openfeint/internal/resource/ResourceClass;

    move-result-object v0

    invoke-virtual {p1}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonGenerator;->writeStartObject()V

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v0, v0, Lcom/openfeint/internal/resource/ResourceClass;->mResourceName:Ljava/lang/String;

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "s"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonGenerator;->writeFieldName(Ljava/lang/String;)V

    invoke-virtual {p1}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonGenerator;->writeStartArray()V

    invoke-interface {v3}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_1
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_2

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/openfeint/internal/resource/Resource;

    invoke-direct {v0, p1}, Lcom/openfeint/internal/resource/Resource;->generate(Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonGenerator;)V

    goto :goto_1

    :cond_2
    invoke-virtual {p1}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonGenerator;->writeEndArray()V

    invoke-virtual {p1}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonGenerator;->writeEndObject()V

    goto :goto_0

    :cond_3
    instance-of v3, v1, Lcom/openfeint/internal/resource/NestedResourceProperty;

    if-eqz v3, :cond_4

    check-cast v1, Lcom/openfeint/internal/resource/NestedResourceProperty;

    invoke-virtual {v1, p0}, Lcom/openfeint/internal/resource/NestedResourceProperty;->get(Lcom/openfeint/internal/resource/Resource;)Lcom/openfeint/internal/resource/Resource;

    move-result-object v1

    if-eqz v1, :cond_0

    invoke-interface {v0}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    invoke-virtual {p1, v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonGenerator;->writeFieldName(Ljava/lang/String;)V

    invoke-direct {v1, p1}, Lcom/openfeint/internal/resource/Resource;->generate(Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonGenerator;)V

    goto/16 :goto_0

    :cond_4
    instance-of v3, v1, Lcom/openfeint/internal/resource/HashIntResourceProperty;

    if-eqz v3, :cond_0

    check-cast v1, Lcom/openfeint/internal/resource/HashIntResourceProperty;

    invoke-virtual {v1}, Lcom/openfeint/internal/resource/HashIntResourceProperty;->get$44556ed()Ljava/util/HashMap;

    move-result-object v1

    if-eqz v1, :cond_0

    invoke-virtual {v1}, Ljava/util/HashMap;->size()I

    move-result v3

    if-lez v3, :cond_0

    invoke-interface {v0}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    invoke-virtual {p1, v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonGenerator;->writeFieldName(Ljava/lang/String;)V

    invoke-virtual {p1}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonGenerator;->writeStartObject()V

    invoke-virtual {v1}, Ljava/util/HashMap;->entrySet()Ljava/util/Set;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :goto_2
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_5

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/Map$Entry;

    invoke-interface {v0}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    invoke-virtual {p1, v1}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonGenerator;->writeFieldName(Ljava/lang/String;)V

    invoke-interface {v0}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Integer;

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    invoke-virtual {p1, v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonGenerator;->writeNumber(I)V

    goto :goto_2

    :cond_5
    invoke-virtual {p1}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonGenerator;->writeEndObject()V

    goto/16 :goto_0

    :cond_6
    invoke-virtual {p1}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonGenerator;->writeEndObject()V

    invoke-virtual {p1}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonGenerator;->writeEndObject()V

    return-void
.end method

.method public static getKlass(Ljava/lang/Class;)Lcom/openfeint/internal/resource/ResourceClass;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Class",
            "<*>;)",
            "Lcom/openfeint/internal/resource/ResourceClass;"
        }
    .end annotation

    sget-object v0, Lcom/openfeint/internal/resource/Resource;->sSubclassMap:Ljava/util/HashMap;

    invoke-virtual {v0, p0}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/openfeint/internal/resource/ResourceClass;

    return-object v0
.end method

.method public static getKlass(Ljava/lang/String;)Lcom/openfeint/internal/resource/ResourceClass;
    .locals 1

    sget-object v0, Lcom/openfeint/internal/resource/Resource;->sNameMap:Ljava/util/HashMap;

    invoke-virtual {v0, p0}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/openfeint/internal/resource/ResourceClass;

    return-object v0
.end method

.method public static getResourceClass()Lcom/openfeint/internal/resource/ResourceClass;
    .locals 4

    new-instance v0, Lcom/openfeint/internal/resource/Resource$1;

    const-class v1, Lcom/openfeint/internal/resource/Resource;

    invoke-direct {v0, v1}, Lcom/openfeint/internal/resource/Resource$1;-><init>(Ljava/lang/Class;)V

    iget-object v1, v0, Lcom/openfeint/internal/resource/ResourceClass;->mProperties:Ljava/util/HashMap;

    const-string v2, "id"

    new-instance v3, Lcom/openfeint/internal/resource/Resource$2;

    invoke-direct {v3}, Lcom/openfeint/internal/resource/Resource$2;-><init>()V

    invoke-virtual {v1, v2, v3}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    return-object v0
.end method

.method private static registerSubclass(Lcom/openfeint/internal/resource/ResourceClass;)V
    .locals 2

    sget-object v0, Lcom/openfeint/internal/resource/Resource;->sSubclassMap:Ljava/util/HashMap;

    iget-object v1, p0, Lcom/openfeint/internal/resource/ResourceClass;->mObjectClass:Ljava/lang/Class;

    invoke-virtual {v0, v1, p0}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Lcom/openfeint/internal/resource/ResourceClass;->mResourceName:Ljava/lang/String;

    if-eqz v0, :cond_0

    sget-object v0, Lcom/openfeint/internal/resource/Resource;->sNameMap:Ljava/util/HashMap;

    iget-object v1, p0, Lcom/openfeint/internal/resource/ResourceClass;->mResourceName:Ljava/lang/String;

    invoke-virtual {v0, v1, p0}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    :cond_0
    return-void
.end method

.method private final unguardedShallowCopy(Lcom/openfeint/internal/resource/Resource;)V
    .locals 3

    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v0

    invoke-static {v0}, Lcom/openfeint/internal/resource/Resource;->getKlass(Ljava/lang/Class;)Lcom/openfeint/internal/resource/ResourceClass;

    move-result-object v0

    iget-object v0, v0, Lcom/openfeint/internal/resource/ResourceClass;->mProperties:Ljava/util/HashMap;

    invoke-virtual {v0}, Ljava/util/HashMap;->entrySet()Ljava/util/Set;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :cond_0
    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_3

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/Map$Entry;

    invoke-interface {v0}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/openfeint/internal/resource/ResourceProperty;

    instance-of v1, v0, Lcom/openfeint/internal/resource/PrimitiveResourceProperty;

    if-eqz v1, :cond_1

    check-cast v0, Lcom/openfeint/internal/resource/PrimitiveResourceProperty;

    invoke-virtual {v0, p0, p1}, Lcom/openfeint/internal/resource/PrimitiveResourceProperty;->copy(Lcom/openfeint/internal/resource/Resource;Lcom/openfeint/internal/resource/Resource;)V

    goto :goto_0

    :cond_1
    instance-of v1, v0, Lcom/openfeint/internal/resource/ArrayResourceProperty;

    if-eqz v1, :cond_2

    move-object v1, v0

    check-cast v1, Lcom/openfeint/internal/resource/ArrayResourceProperty;

    check-cast v0, Lcom/openfeint/internal/resource/ArrayResourceProperty;

    invoke-virtual {v0, p1}, Lcom/openfeint/internal/resource/ArrayResourceProperty;->get(Lcom/openfeint/internal/resource/Resource;)Ljava/util/List;

    move-result-object v0

    invoke-virtual {v1, p0, v0}, Lcom/openfeint/internal/resource/ArrayResourceProperty;->set(Lcom/openfeint/internal/resource/Resource;Ljava/util/List;)V

    goto :goto_0

    :cond_2
    instance-of v1, v0, Lcom/openfeint/internal/resource/NestedResourceProperty;

    if-eqz v1, :cond_0

    move-object v1, v0

    check-cast v1, Lcom/openfeint/internal/resource/NestedResourceProperty;

    check-cast v0, Lcom/openfeint/internal/resource/NestedResourceProperty;

    invoke-virtual {v0, p1}, Lcom/openfeint/internal/resource/NestedResourceProperty;->get(Lcom/openfeint/internal/resource/Resource;)Lcom/openfeint/internal/resource/Resource;

    move-result-object v0

    invoke-virtual {v1, p0, v0}, Lcom/openfeint/internal/resource/NestedResourceProperty;->set(Lcom/openfeint/internal/resource/Resource;Lcom/openfeint/internal/resource/Resource;)V

    goto :goto_0

    :cond_3
    return-void
.end method


# virtual methods
.method public final generate()Ljava/lang/String;
    .locals 3

    new-instance v0, Ljava/io/StringWriter;

    invoke-direct {v0}, Ljava/io/StringWriter;-><init>()V

    new-instance v1, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonFactory;

    const/4 v2, 0x0

    invoke-direct {v1, v2}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonFactory;-><init>(B)V

    :try_start_0
    invoke-virtual {v1, v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonFactory;->createJsonGenerator(Ljava/io/Writer;)Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonGenerator;

    move-result-object v1

    invoke-direct {p0, v1}, Lcom/openfeint/internal/resource/Resource;->generate(Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonGenerator;)V

    invoke-virtual {v1}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonGenerator;->close()V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    invoke-virtual {v0}, Ljava/io/StringWriter;->toString()Ljava/lang/String;

    move-result-object v0

    :goto_0
    return-object v0

    :catch_0
    move-exception v0

    const-string v1, "Resource"

    invoke-virtual {v0}, Ljava/io/IOException;->getMessage()Ljava/lang/String;

    move-result-object v0

    invoke-static {v1, v0}, Lcom/openfeint/internal/logcat/OFLog;->e(Ljava/lang/String;Ljava/lang/String;)V

    const/4 v0, 0x0

    goto :goto_0
.end method

.method public final resourceID()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/openfeint/internal/resource/Resource;->mID:Ljava/lang/String;

    return-object v0
.end method

.method public final setResourceID(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lcom/openfeint/internal/resource/Resource;->mID:Ljava/lang/String;

    return-void
.end method

.method public final shallowCopy(Lcom/openfeint/internal/resource/Resource;)V
    .locals 2

    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v0

    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v1

    if-eq v0, v1, :cond_0

    new-instance v0, Ljava/lang/UnsupportedOperationException;

    const-string v1, "You can only shallowCopy the same type of resource"

    invoke-direct {v0, v1}, Ljava/lang/UnsupportedOperationException;-><init>(Ljava/lang/String;)V

    throw v0

    :cond_0
    invoke-direct {p0, p1}, Lcom/openfeint/internal/resource/Resource;->unguardedShallowCopy(Lcom/openfeint/internal/resource/Resource;)V

    return-void
.end method

.method public final shallowCopyAncestorType(Lcom/openfeint/internal/resource/Resource;)V
    .locals 3

    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v0

    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v1

    const-class v2, Lcom/openfeint/internal/resource/Resource;

    if-eq v1, v2, :cond_1

    :goto_0
    if-eq v0, v1, :cond_0

    const-class v2, Lcom/openfeint/internal/resource/Resource;

    if-eq v0, v2, :cond_0

    invoke-virtual {v0}, Ljava/lang/Class;->getSuperclass()Ljava/lang/Class;

    move-result-object v0

    goto :goto_0

    :cond_0
    const-class v2, Lcom/openfeint/internal/resource/Resource;

    if-ne v0, v2, :cond_1

    new-instance v0, Ljava/lang/UnsupportedOperationException;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " is not a superclass of "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/UnsupportedOperationException;-><init>(Ljava/lang/String;)V

    throw v0

    :cond_1
    invoke-direct {p0, p1}, Lcom/openfeint/internal/resource/Resource;->unguardedShallowCopy(Lcom/openfeint/internal/resource/Resource;)V

    return-void
.end method
