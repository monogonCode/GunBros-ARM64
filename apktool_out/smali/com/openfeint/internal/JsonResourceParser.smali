.class public final Lcom/openfeint/internal/JsonResourceParser;
.super Ljava/lang/Object;


# instance fields
.field private mParser:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser;


# direct methods
.method public constructor <init>(Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/openfeint/internal/JsonResourceParser;->mParser:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser;

    return-void
.end method

.method private parseOpenedArray()Ljava/util/ArrayList;
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/ArrayList",
            "<",
            "Lcom/openfeint/internal/resource/Resource;",
            ">;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParseException;,
            Ljava/io/IOException;
        }
    .end annotation

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    :goto_0
    iget-object v1, p0, Lcom/openfeint/internal/JsonResourceParser;->mParser:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser;

    invoke-virtual {v1}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser;->nextToken()Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;

    move-result-object v1

    sget-object v2, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;->END_ARRAY:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;

    if-eq v1, v2, :cond_3

    iget-object v1, p0, Lcom/openfeint/internal/JsonResourceParser;->mParser:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser;

    invoke-virtual {v1}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser;->nextToken()Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;

    move-result-object v1

    sget-object v2, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;->FIELD_NAME:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;

    if-eq v1, v2, :cond_0

    new-instance v0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParseException;

    const-string v1, "Couldn\'t find wrapper object."

    iget-object v2, p0, Lcom/openfeint/internal/JsonResourceParser;->mParser:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser;

    invoke-virtual {v2}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser;->getTokenLocation()Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonLocation;

    move-result-object v2

    invoke-direct {v0, v1, v2}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParseException;-><init>(Ljava/lang/String;Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonLocation;)V

    throw v0

    :cond_0
    iget-object v1, p0, Lcom/openfeint/internal/JsonResourceParser;->mParser:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser;

    invoke-virtual {v1}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser;->getText()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/openfeint/internal/resource/Resource;->getKlass(Ljava/lang/String;)Lcom/openfeint/internal/resource/ResourceClass;

    move-result-object v2

    if-nez v2, :cond_1

    new-instance v0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParseException;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Don\'t know class \'"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "\'."

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lcom/openfeint/internal/JsonResourceParser;->mParser:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser;

    invoke-virtual {v2}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser;->getTokenLocation()Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonLocation;

    move-result-object v2

    invoke-direct {v0, v1, v2}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParseException;-><init>(Ljava/lang/String;Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonLocation;)V

    throw v0

    :cond_1
    invoke-direct {p0, v2}, Lcom/openfeint/internal/JsonResourceParser;->parseResource(Lcom/openfeint/internal/resource/ResourceClass;)Lcom/openfeint/internal/resource/Resource;

    move-result-object v1

    iget-object v2, p0, Lcom/openfeint/internal/JsonResourceParser;->mParser:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser;

    invoke-virtual {v2}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser;->nextToken()Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;

    move-result-object v2

    sget-object v3, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;->END_OBJECT:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;

    if-eq v2, v3, :cond_2

    new-instance v0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParseException;

    const-string v1, "Expected only one k/v in wrapper object."

    iget-object v2, p0, Lcom/openfeint/internal/JsonResourceParser;->mParser:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser;

    invoke-virtual {v2}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser;->getTokenLocation()Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonLocation;

    move-result-object v2

    invoke-direct {v0, v1, v2}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParseException;-><init>(Ljava/lang/String;Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonLocation;)V

    throw v0

    :cond_2
    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_0

    :cond_3
    return-object v0
.end method

.method private parseOpenedHash()Ljava/util/HashMap;
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/HashMap",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/Integer;",
            ">;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParseException;,
            Ljava/io/IOException;
        }
    .end annotation

    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    :goto_0
    iget-object v1, p0, Lcom/openfeint/internal/JsonResourceParser;->mParser:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser;

    invoke-virtual {v1}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser;->nextToken()Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;

    move-result-object v1

    sget-object v2, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;->FIELD_NAME:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;

    if-ne v1, v2, :cond_0

    iget-object v1, p0, Lcom/openfeint/internal/JsonResourceParser;->mParser:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser;

    invoke-virtual {v1}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser;->getText()Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lcom/openfeint/internal/JsonResourceParser;->mParser:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser;

    invoke-virtual {v2}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser;->nextToken()Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;

    iget-object v2, p0, Lcom/openfeint/internal/JsonResourceParser;->mParser:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser;

    invoke-virtual {v2}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser;->getIntValue()I

    move-result v2

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_0

    :cond_0
    return-object v0
.end method

.method private parseOpenedResource(Lcom/openfeint/internal/resource/ResourceClass;)Lcom/openfeint/internal/resource/Resource;
    .locals 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParseException;,
            Ljava/io/IOException;
        }
    .end annotation

    invoke-virtual {p1}, Lcom/openfeint/internal/resource/ResourceClass;->factory()Lcom/openfeint/internal/resource/Resource;

    move-result-object v2

    :cond_0
    :goto_0
    iget-object v0, p0, Lcom/openfeint/internal/JsonResourceParser;->mParser:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser;

    invoke-virtual {v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser;->nextToken()Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;

    move-result-object v0

    sget-object v1, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;->FIELD_NAME:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;

    if-ne v0, v1, :cond_a

    iget-object v0, p0, Lcom/openfeint/internal/JsonResourceParser;->mParser:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser;

    invoke-virtual {v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser;->getText()Ljava/lang/String;

    move-result-object v0

    iget-object v1, p1, Lcom/openfeint/internal/resource/ResourceClass;->mProperties:Ljava/util/HashMap;

    invoke-virtual {v1, v0}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/openfeint/internal/resource/ResourceProperty;

    if-nez v0, :cond_1

    iget-object v0, p0, Lcom/openfeint/internal/JsonResourceParser;->mParser:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser;

    invoke-virtual {v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser;->nextToken()Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;

    iget-object v0, p0, Lcom/openfeint/internal/JsonResourceParser;->mParser:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser;

    invoke-virtual {v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser;->skipChildren()Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser;

    goto :goto_0

    :cond_1
    instance-of v1, v0, Lcom/openfeint/internal/resource/PrimitiveResourceProperty;

    if-eqz v1, :cond_2

    check-cast v0, Lcom/openfeint/internal/resource/PrimitiveResourceProperty;

    iget-object v1, p0, Lcom/openfeint/internal/JsonResourceParser;->mParser:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser;

    invoke-virtual {v1}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser;->nextToken()Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;

    iget-object v1, p0, Lcom/openfeint/internal/JsonResourceParser;->mParser:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser;

    invoke-virtual {v0, v2, v1}, Lcom/openfeint/internal/resource/PrimitiveResourceProperty;->parse(Lcom/openfeint/internal/resource/Resource;Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser;)V

    goto :goto_0

    :cond_2
    instance-of v1, v0, Lcom/openfeint/internal/resource/NestedResourceProperty;

    if-eqz v1, :cond_4

    check-cast v0, Lcom/openfeint/internal/resource/NestedResourceProperty;

    invoke-virtual {v0}, Lcom/openfeint/internal/resource/NestedResourceProperty;->getType()Ljava/lang/Class;

    move-result-object v1

    invoke-static {v1}, Lcom/openfeint/internal/resource/Resource;->getKlass(Ljava/lang/Class;)Lcom/openfeint/internal/resource/ResourceClass;

    move-result-object v1

    if-eqz v1, :cond_3

    invoke-direct {p0, v1}, Lcom/openfeint/internal/JsonResourceParser;->parseResource(Lcom/openfeint/internal/resource/ResourceClass;)Lcom/openfeint/internal/resource/Resource;

    move-result-object v1

    invoke-virtual {v0, v2, v1}, Lcom/openfeint/internal/resource/NestedResourceProperty;->set(Lcom/openfeint/internal/resource/Resource;Lcom/openfeint/internal/resource/Resource;)V

    goto :goto_0

    :cond_3
    const-string v1, "JsonResourceParser"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "unknown "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v0}, Lcom/openfeint/internal/resource/NestedResourceProperty;->getType()Ljava/lang/Class;

    move-result-object v0

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v1, v0}, Lcom/openfeint/internal/logcat/OFLog;->e(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0

    :cond_4
    instance-of v1, v0, Lcom/openfeint/internal/resource/ArrayResourceProperty;

    if-eqz v1, :cond_7

    check-cast v0, Lcom/openfeint/internal/resource/ArrayResourceProperty;

    iget-object v1, p0, Lcom/openfeint/internal/JsonResourceParser;->mParser:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser;

    invoke-virtual {v1}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser;->nextToken()Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;

    move-result-object v1

    sget-object v3, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;->VALUE_NULL:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;

    if-ne v1, v3, :cond_5

    const/4 v1, 0x0

    :goto_1
    invoke-virtual {v0, v2, v1}, Lcom/openfeint/internal/resource/ArrayResourceProperty;->set(Lcom/openfeint/internal/resource/Resource;Ljava/util/List;)V

    goto :goto_0

    :cond_5
    sget-object v3, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;->START_ARRAY:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;

    if-eq v1, v3, :cond_6

    new-instance v0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParseException;

    const-string v1, "Wanted START_ARRAY"

    iget-object v2, p0, Lcom/openfeint/internal/JsonResourceParser;->mParser:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser;

    invoke-virtual {v2}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser;->getCurrentLocation()Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonLocation;

    move-result-object v2

    invoke-direct {v0, v1, v2}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParseException;-><init>(Ljava/lang/String;Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonLocation;)V

    throw v0

    :cond_6
    invoke-direct {p0}, Lcom/openfeint/internal/JsonResourceParser;->parseOpenedArray()Ljava/util/ArrayList;

    move-result-object v1

    goto :goto_1

    :cond_7
    instance-of v0, v0, Lcom/openfeint/internal/resource/HashIntResourceProperty;

    if-eqz v0, :cond_9

    iget-object v0, p0, Lcom/openfeint/internal/JsonResourceParser;->mParser:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser;

    invoke-virtual {v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser;->nextToken()Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;

    move-result-object v0

    sget-object v1, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;->VALUE_NULL:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;

    if-eq v0, v1, :cond_0

    sget-object v1, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;->START_OBJECT:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;

    if-eq v0, v1, :cond_8

    new-instance v0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParseException;

    const-string v1, "Expected START_OBJECT"

    iget-object v2, p0, Lcom/openfeint/internal/JsonResourceParser;->mParser:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser;

    invoke-virtual {v2}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser;->getCurrentLocation()Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonLocation;

    move-result-object v2

    invoke-direct {v0, v1, v2}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParseException;-><init>(Ljava/lang/String;Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonLocation;)V

    throw v0

    :cond_8
    invoke-direct {p0}, Lcom/openfeint/internal/JsonResourceParser;->parseOpenedHash()Ljava/util/HashMap;

    goto/16 :goto_0

    :cond_9
    const-string v0, "JsonResourceParser"

    const-string v1, "Totally don\'t know what to do about this property"

    invoke-static {v0, v1}, Lcom/openfeint/internal/logcat/OFLog;->e(Ljava/lang/String;Ljava/lang/String;)V

    iget-object v0, p0, Lcom/openfeint/internal/JsonResourceParser;->mParser:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser;

    invoke-virtual {v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser;->skipChildren()Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser;

    goto/16 :goto_0

    :cond_a
    iget-object v0, p0, Lcom/openfeint/internal/JsonResourceParser;->mParser:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser;

    invoke-virtual {v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser;->getCurrentToken()Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;

    move-result-object v0

    sget-object v1, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;->END_OBJECT:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;

    if-eq v0, v1, :cond_b

    new-instance v0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParseException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Expected END_OBJECT of "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p1, Lcom/openfeint/internal/resource/ResourceClass;->mResourceName:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lcom/openfeint/internal/JsonResourceParser;->mParser:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser;

    invoke-virtual {v2}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser;->getCurrentLocation()Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonLocation;

    move-result-object v2

    invoke-direct {v0, v1, v2}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParseException;-><init>(Ljava/lang/String;Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonLocation;)V

    throw v0

    :cond_b
    return-object v2
.end method

.method private parseResource(Lcom/openfeint/internal/resource/ResourceClass;)Lcom/openfeint/internal/resource/Resource;
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParseException;,
            Ljava/io/IOException;
        }
    .end annotation

    iget-object v0, p0, Lcom/openfeint/internal/JsonResourceParser;->mParser:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser;

    invoke-virtual {v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser;->nextToken()Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;

    move-result-object v0

    sget-object v1, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;->VALUE_NULL:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;

    if-ne v0, v1, :cond_0

    const/4 v0, 0x0

    :goto_0
    return-object v0

    :cond_0
    sget-object v1, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;->START_OBJECT:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;

    if-eq v0, v1, :cond_1

    new-instance v0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParseException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Expected START_OBJECT of "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p1, Lcom/openfeint/internal/resource/ResourceClass;->mResourceName:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lcom/openfeint/internal/JsonResourceParser;->mParser:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser;

    invoke-virtual {v2}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser;->getCurrentLocation()Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonLocation;

    move-result-object v2

    invoke-direct {v0, v1, v2}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParseException;-><init>(Ljava/lang/String;Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonLocation;)V

    throw v0

    :cond_1
    invoke-direct {p0, p1}, Lcom/openfeint/internal/JsonResourceParser;->parseOpenedResource(Lcom/openfeint/internal/resource/ResourceClass;)Lcom/openfeint/internal/resource/Resource;

    move-result-object v0

    goto :goto_0
.end method


# virtual methods
.method public final parse()Ljava/lang/Object;
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParseException;,
            Ljava/io/IOException;
        }
    .end annotation

    iget-object v0, p0, Lcom/openfeint/internal/JsonResourceParser;->mParser:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser;

    invoke-virtual {v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser;->nextToken()Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;

    move-result-object v0

    if-nez v0, :cond_1

    const/4 v0, 0x0

    :cond_0
    return-object v0

    :cond_1
    sget-object v1, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;->START_OBJECT:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;

    if-eq v0, v1, :cond_2

    new-instance v0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParseException;

    const-string v1, "Couldn\'t find toplevel wrapper object."

    iget-object v2, p0, Lcom/openfeint/internal/JsonResourceParser;->mParser:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser;

    invoke-virtual {v2}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser;->getTokenLocation()Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonLocation;

    move-result-object v2

    invoke-direct {v0, v1, v2}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParseException;-><init>(Ljava/lang/String;Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonLocation;)V

    throw v0

    :cond_2
    iget-object v0, p0, Lcom/openfeint/internal/JsonResourceParser;->mParser:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser;

    invoke-virtual {v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser;->nextToken()Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;

    move-result-object v0

    sget-object v1, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;->FIELD_NAME:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;

    if-eq v0, v1, :cond_3

    new-instance v0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParseException;

    const-string v1, "Couldn\'t find toplevel wrapper object."

    iget-object v2, p0, Lcom/openfeint/internal/JsonResourceParser;->mParser:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser;

    invoke-virtual {v2}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser;->getTokenLocation()Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonLocation;

    move-result-object v2

    invoke-direct {v0, v1, v2}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParseException;-><init>(Ljava/lang/String;Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonLocation;)V

    throw v0

    :cond_3
    iget-object v0, p0, Lcom/openfeint/internal/JsonResourceParser;->mParser:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser;

    invoke-virtual {v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser;->getText()Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Lcom/openfeint/internal/JsonResourceParser;->mParser:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser;

    invoke-virtual {v1}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser;->nextToken()Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;

    move-result-object v1

    sget-object v2, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;->START_ARRAY:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;

    if-ne v1, v2, :cond_4

    invoke-direct {p0}, Lcom/openfeint/internal/JsonResourceParser;->parseOpenedArray()Ljava/util/ArrayList;

    move-result-object v0

    :goto_0
    iget-object v1, p0, Lcom/openfeint/internal/JsonResourceParser;->mParser:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser;

    invoke-virtual {v1}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser;->nextToken()Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;

    move-result-object v1

    sget-object v2, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;->END_OBJECT:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;

    if-eq v1, v2, :cond_0

    new-instance v0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParseException;

    const-string v1, "Expected only one k/v in toplevel wrapper object."

    iget-object v2, p0, Lcom/openfeint/internal/JsonResourceParser;->mParser:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser;

    invoke-virtual {v2}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser;->getTokenLocation()Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonLocation;

    move-result-object v2

    invoke-direct {v0, v1, v2}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParseException;-><init>(Ljava/lang/String;Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonLocation;)V

    throw v0

    :cond_4
    sget-object v2, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;->START_OBJECT:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonToken;

    if-ne v1, v2, :cond_6

    invoke-static {v0}, Lcom/openfeint/internal/resource/Resource;->getKlass(Ljava/lang/String;)Lcom/openfeint/internal/resource/ResourceClass;

    move-result-object v1

    if-nez v1, :cond_5

    new-instance v1, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParseException;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Unknown toplevel class \'"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v2, "\'."

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iget-object v2, p0, Lcom/openfeint/internal/JsonResourceParser;->mParser:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser;

    invoke-virtual {v2}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser;->getTokenLocation()Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonLocation;

    move-result-object v2

    invoke-direct {v1, v0, v2}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParseException;-><init>(Ljava/lang/String;Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonLocation;)V

    throw v1

    :cond_5
    invoke-direct {p0, v1}, Lcom/openfeint/internal/JsonResourceParser;->parseOpenedResource(Lcom/openfeint/internal/resource/ResourceClass;)Lcom/openfeint/internal/resource/Resource;

    move-result-object v0

    goto :goto_0

    :cond_6
    new-instance v0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParseException;

    const-string v1, "Expected object or array at top level."

    iget-object v2, p0, Lcom/openfeint/internal/JsonResourceParser;->mParser:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser;

    invoke-virtual {v2}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser;->getTokenLocation()Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonLocation;

    move-result-object v2

    invoke-direct {v0, v1, v2}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParseException;-><init>(Ljava/lang/String;Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonLocation;)V

    throw v0
.end method
