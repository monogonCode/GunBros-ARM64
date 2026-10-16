.class public abstract Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonWriteContext;
.super Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonStreamContext;


# instance fields
.field _childArray:Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonWriteContext;

.field _childObject:Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonWriteContext;

.field protected final _parent:Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonWriteContext;


# direct methods
.method protected constructor <init>(ILcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonWriteContext;)V
    .locals 1

    const/4 v0, 0x0

    invoke-direct {p0, p1}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonStreamContext;-><init>(I)V

    iput-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonWriteContext;->_childArray:Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonWriteContext;

    iput-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonWriteContext;->_childObject:Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonWriteContext;

    iput-object p2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonWriteContext;->_parent:Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonWriteContext;

    return-void
.end method


# virtual methods
.method protected abstract appendDesc(Ljava/lang/StringBuilder;)V
.end method

.method public final createChildArrayContext()Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonWriteContext;
    .locals 2

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonWriteContext;->_childArray:Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonWriteContext;

    if-nez v0, :cond_0

    new-instance v0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ArrayWContext;

    invoke-direct {v0, p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ArrayWContext;-><init>(Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonWriteContext;)V

    iput-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonWriteContext;->_childArray:Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonWriteContext;

    :goto_0
    return-object v0

    :cond_0
    const/4 v1, -0x1

    iput v1, v0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonWriteContext;->_index:I

    goto :goto_0
.end method

.method public final createChildObjectContext()Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonWriteContext;
    .locals 2

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonWriteContext;->_childObject:Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonWriteContext;

    if-nez v0, :cond_0

    new-instance v0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ObjectWContext;

    invoke-direct {v0, p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ObjectWContext;-><init>(Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonWriteContext;)V

    iput-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonWriteContext;->_childObject:Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonWriteContext;

    :goto_0
    return-object v0

    :cond_0
    const/4 v1, -0x1

    iput v1, v0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonWriteContext;->_index:I

    goto :goto_0
.end method

.method public final getParent()Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonWriteContext;
    .locals 1

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonWriteContext;->_parent:Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonWriteContext;

    return-object v0
.end method

.method public final toString()Ljava/lang/String;
    .locals 2

    new-instance v0, Ljava/lang/StringBuilder;

    const/16 v1, 0x40

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(I)V

    invoke-virtual {p0, v0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonWriteContext;->appendDesc(Ljava/lang/StringBuilder;)V

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public abstract writeFieldName(Ljava/lang/String;)I
.end method

.method public abstract writeValue()I
.end method
