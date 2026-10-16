.class public abstract Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonGeneratorBase;
.super Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonGenerator;


# instance fields
.field protected _cfgNumbersAsStrings:Z

.field protected _closed:Z

.field protected _features:I

.field protected _objectCodec:Lcom/openfeint/internal/vendor/org/codehaus/jackson/ObjectCodec;

.field protected _writeContext:Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonWriteContext;


# direct methods
.method protected constructor <init>(ILcom/openfeint/internal/vendor/org/codehaus/jackson/ObjectCodec;)V
    .locals 1

    invoke-direct {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonGenerator;-><init>()V

    iput p1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonGeneratorBase;->_features:I

    new-instance v0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/RootWContext;

    invoke-direct {v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/RootWContext;-><init>()V

    iput-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonGeneratorBase;->_writeContext:Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonWriteContext;

    iput-object p2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonGeneratorBase;->_objectCodec:Lcom/openfeint/internal/vendor/org/codehaus/jackson/ObjectCodec;

    sget-object v0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonGenerator$Feature;->WRITE_NUMBERS_AS_STRINGS:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonGenerator$Feature;

    invoke-virtual {p0, v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonGeneratorBase;->isEnabled(Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonGenerator$Feature;)Z

    move-result v0

    iput-boolean v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonGeneratorBase;->_cfgNumbersAsStrings:Z

    return-void
.end method

.method protected static _reportError(Ljava/lang/String;)V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonGenerationException;
        }
    .end annotation

    new-instance v0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonGenerationException;

    invoke-direct {v0, p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonGenerationException;-><init>(Ljava/lang/String;)V

    throw v0
.end method


# virtual methods
.method protected abstract _verifyValueWrite(Ljava/lang/String;)V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonGenerationException;
        }
    .end annotation
.end method

.method protected abstract _writeEndArray()V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonGenerationException;
        }
    .end annotation
.end method

.method protected abstract _writeEndObject()V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonGenerationException;
        }
    .end annotation
.end method

.method protected abstract _writeFieldName(Ljava/lang/String;Z)V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonGenerationException;
        }
    .end annotation
.end method

.method protected abstract _writeStartArray()V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonGenerationException;
        }
    .end annotation
.end method

.method protected abstract _writeStartObject()V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonGenerationException;
        }
    .end annotation
.end method

.method public close()V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonGeneratorBase;->_closed:Z

    return-void
.end method

.method public final getOutputContext()Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonWriteContext;
    .locals 1

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonGeneratorBase;->_writeContext:Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonWriteContext;

    return-object v0
.end method

.method public final isEnabled(Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonGenerator$Feature;)Z
    .locals 2

    iget v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonGeneratorBase;->_features:I

    invoke-virtual {p1}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonGenerator$Feature;->getMask()I

    move-result v1

    and-int/2addr v0, v1

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public final writeEndArray()V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonGenerationException;
        }
    .end annotation

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonGeneratorBase;->_writeContext:Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonWriteContext;

    invoke-virtual {v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonWriteContext;->inArray()Z

    move-result v0

    if-nez v0, :cond_0

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Current context not an ARRAY but "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonGeneratorBase;->_writeContext:Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonWriteContext;

    invoke-virtual {v1}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonWriteContext;->getTypeDesc()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonGeneratorBase;->_reportError(Ljava/lang/String;)V

    :cond_0
    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonGeneratorBase;->_cfgPrettyPrinter:Lcom/openfeint/internal/vendor/org/codehaus/jackson/PrettyPrinter;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonGeneratorBase;->_cfgPrettyPrinter:Lcom/openfeint/internal/vendor/org/codehaus/jackson/PrettyPrinter;

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonGeneratorBase;->_writeContext:Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonWriteContext;

    invoke-virtual {v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonWriteContext;->getEntryCount()I

    :goto_0
    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonGeneratorBase;->_writeContext:Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonWriteContext;

    invoke-virtual {v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonWriteContext;->getParent()Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonWriteContext;

    move-result-object v0

    iput-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonGeneratorBase;->_writeContext:Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonWriteContext;

    return-void

    :cond_1
    invoke-virtual {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonGeneratorBase;->_writeEndArray()V

    goto :goto_0
.end method

.method public final writeEndObject()V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonGenerationException;
        }
    .end annotation

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonGeneratorBase;->_writeContext:Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonWriteContext;

    invoke-virtual {v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonWriteContext;->inObject()Z

    move-result v0

    if-nez v0, :cond_0

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Current context not an object but "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonGeneratorBase;->_writeContext:Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonWriteContext;

    invoke-virtual {v1}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonWriteContext;->getTypeDesc()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonGeneratorBase;->_reportError(Ljava/lang/String;)V

    :cond_0
    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonGeneratorBase;->_writeContext:Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonWriteContext;

    invoke-virtual {v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonWriteContext;->getParent()Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonWriteContext;

    move-result-object v0

    iput-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonGeneratorBase;->_writeContext:Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonWriteContext;

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonGeneratorBase;->_cfgPrettyPrinter:Lcom/openfeint/internal/vendor/org/codehaus/jackson/PrettyPrinter;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonGeneratorBase;->_cfgPrettyPrinter:Lcom/openfeint/internal/vendor/org/codehaus/jackson/PrettyPrinter;

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonGeneratorBase;->_writeContext:Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonWriteContext;

    invoke-virtual {v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonWriteContext;->getEntryCount()I

    :goto_0
    return-void

    :cond_1
    invoke-virtual {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonGeneratorBase;->_writeEndObject()V

    goto :goto_0
.end method

.method public final writeFieldName(Ljava/lang/String;)V
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonGenerationException;
        }
    .end annotation

    const/4 v0, 0x1

    iget-object v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonGeneratorBase;->_writeContext:Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonWriteContext;

    invoke-virtual {v1, p1}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonWriteContext;->writeFieldName(Ljava/lang/String;)I

    move-result v1

    const/4 v2, 0x4

    if-ne v1, v2, :cond_0

    const-string v2, "Can not write a field name, expecting a value"

    invoke-static {v2}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonGeneratorBase;->_reportError(Ljava/lang/String;)V

    :cond_0
    if-ne v1, v0, :cond_1

    :goto_0
    invoke-virtual {p0, p1, v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonGeneratorBase;->_writeFieldName(Ljava/lang/String;Z)V

    return-void

    :cond_1
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public final writeStartArray()V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonGenerationException;
        }
    .end annotation

    const-string v0, "start an array"

    invoke-virtual {p0, v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonGeneratorBase;->_verifyValueWrite(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonGeneratorBase;->_writeContext:Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonWriteContext;

    invoke-virtual {v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonWriteContext;->createChildArrayContext()Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonWriteContext;

    move-result-object v0

    iput-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonGeneratorBase;->_writeContext:Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonWriteContext;

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonGeneratorBase;->_cfgPrettyPrinter:Lcom/openfeint/internal/vendor/org/codehaus/jackson/PrettyPrinter;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonGeneratorBase;->_cfgPrettyPrinter:Lcom/openfeint/internal/vendor/org/codehaus/jackson/PrettyPrinter;

    :goto_0
    return-void

    :cond_0
    invoke-virtual {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonGeneratorBase;->_writeStartArray()V

    goto :goto_0
.end method

.method public final writeStartObject()V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonGenerationException;
        }
    .end annotation

    const-string v0, "start an object"

    invoke-virtual {p0, v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonGeneratorBase;->_verifyValueWrite(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonGeneratorBase;->_writeContext:Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonWriteContext;

    invoke-virtual {v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonWriteContext;->createChildObjectContext()Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonWriteContext;

    move-result-object v0

    iput-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonGeneratorBase;->_writeContext:Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonWriteContext;

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonGeneratorBase;->_cfgPrettyPrinter:Lcom/openfeint/internal/vendor/org/codehaus/jackson/PrettyPrinter;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonGeneratorBase;->_cfgPrettyPrinter:Lcom/openfeint/internal/vendor/org/codehaus/jackson/PrettyPrinter;

    :goto_0
    return-void

    :cond_0
    invoke-virtual {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonGeneratorBase;->_writeStartObject()V

    goto :goto_0
.end method
