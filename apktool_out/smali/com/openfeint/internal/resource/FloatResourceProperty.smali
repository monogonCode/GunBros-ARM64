.class public abstract Lcom/openfeint/internal/resource/FloatResourceProperty;
.super Lcom/openfeint/internal/resource/PrimitiveResourceProperty;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Lcom/openfeint/internal/resource/PrimitiveResourceProperty;-><init>()V

    return-void
.end method


# virtual methods
.method public final copy(Lcom/openfeint/internal/resource/Resource;Lcom/openfeint/internal/resource/Resource;)V
    .locals 1

    invoke-virtual {p0, p2}, Lcom/openfeint/internal/resource/FloatResourceProperty;->get(Lcom/openfeint/internal/resource/Resource;)F

    move-result v0

    invoke-virtual {p0, p1, v0}, Lcom/openfeint/internal/resource/FloatResourceProperty;->set(Lcom/openfeint/internal/resource/Resource;F)V

    return-void
.end method

.method public final generate(Lcom/openfeint/internal/resource/Resource;Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonGenerator;Ljava/lang/String;)V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonGenerationException;,
            Ljava/io/IOException;
        }
    .end annotation

    invoke-virtual {p2, p3}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonGenerator;->writeFieldName(Ljava/lang/String;)V

    invoke-virtual {p0, p1}, Lcom/openfeint/internal/resource/FloatResourceProperty;->get(Lcom/openfeint/internal/resource/Resource;)F

    move-result v0

    invoke-virtual {p2, v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonGenerator;->writeNumber(F)V

    return-void
.end method

.method public abstract get(Lcom/openfeint/internal/resource/Resource;)F
.end method

.method public final parse(Lcom/openfeint/internal/resource/Resource;Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser;)V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParseException;,
            Ljava/io/IOException;
        }
    .end annotation

    :try_start_0
    invoke-virtual {p2}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParser;->getFloatValue()F

    move-result v0

    invoke-virtual {p0, p1, v0}, Lcom/openfeint/internal/resource/FloatResourceProperty;->set(Lcom/openfeint/internal/resource/Resource;F)V
    :try_end_0
    .catch Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonParseException; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return-void

    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method public abstract set(Lcom/openfeint/internal/resource/Resource;F)V
.end method
