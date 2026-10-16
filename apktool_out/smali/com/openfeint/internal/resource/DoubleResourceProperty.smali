.class public abstract Lcom/openfeint/internal/resource/DoubleResourceProperty;
.super Lcom/openfeint/internal/resource/PrimitiveResourceProperty;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Lcom/openfeint/internal/resource/PrimitiveResourceProperty;-><init>()V

    return-void
.end method


# virtual methods
.method public final copy(Lcom/openfeint/internal/resource/Resource;Lcom/openfeint/internal/resource/Resource;)V
    .locals 2

    invoke-virtual {p0, p2}, Lcom/openfeint/internal/resource/DoubleResourceProperty;->get(Lcom/openfeint/internal/resource/Resource;)D

    move-result-wide v0

    invoke-virtual {p0, p1, v0, v1}, Lcom/openfeint/internal/resource/DoubleResourceProperty;->set(Lcom/openfeint/internal/resource/Resource;D)V

    return-void
.end method

.method public final generate(Lcom/openfeint/internal/resource/Resource;Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonGenerator;Ljava/lang/String;)V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonGenerationException;,
            Ljava/io/IOException;
        }
    .end annotation

    invoke-virtual {p2, p3}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonGenerator;->writeFieldName(Ljava/lang/String;)V

    invoke-virtual {p0, p1}, Lcom/openfeint/internal/resource/DoubleResourceProperty;->get(Lcom/openfeint/internal/resource/Resource;)D

    move-result-wide v0

    invoke-virtual {p2, v0, v1}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonGenerator;->writeNumber(D)V

    return-void
.end method

.method public abstract get(Lcom/openfeint/internal/resource/Resource;)D
.end method

.method public final parse(Lcom/openfeint/internal/resource/Resource;Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser;)V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParseException;,
            Ljava/io/IOException;
        }
    .end annotation

    invoke-virtual {p2}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser;->getDoubleValue()D

    move-result-wide v0

    invoke-virtual {p0, p1, v0, v1}, Lcom/openfeint/internal/resource/DoubleResourceProperty;->set(Lcom/openfeint/internal/resource/Resource;D)V

    return-void
.end method

.method public abstract set(Lcom/openfeint/internal/resource/Resource;D)V
.end method
