.class final Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ArrayWContext;
.super Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonWriteContext;


# direct methods
.method public constructor <init>(Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonWriteContext;)V
    .locals 1

    const/4 v0, 0x1

    invoke-direct {p0, v0, p1}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonWriteContext;-><init>(ILcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonWriteContext;)V

    return-void
.end method


# virtual methods
.method protected final appendDesc(Ljava/lang/StringBuilder;)V
    .locals 1

    const/16 v0, 0x5b

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    invoke-virtual {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ArrayWContext;->getCurrentIndex()I

    move-result v0

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const/16 v0, 0x5d

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    return-void
.end method

.method public final writeFieldName(Ljava/lang/String;)I
    .locals 1

    const/4 v0, 0x4

    return v0
.end method

.method public final writeValue()I
    .locals 2

    iget v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ArrayWContext;->_index:I

    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ArrayWContext;->_index:I

    add-int/lit8 v1, v1, 0x1

    iput v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/ArrayWContext;->_index:I

    if-gez v0, :cond_0

    const/4 v0, 0x0

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x1

    goto :goto_0
.end method
