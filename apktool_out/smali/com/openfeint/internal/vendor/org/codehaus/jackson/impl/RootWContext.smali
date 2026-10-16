.class final Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/RootWContext;
.super Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonWriteContext;


# direct methods
.method public constructor <init>()V
    .locals 2

    const/4 v0, 0x0

    const/4 v1, 0x0

    invoke-direct {p0, v0, v1}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonWriteContext;-><init>(ILcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonWriteContext;)V

    return-void
.end method


# virtual methods
.method protected final appendDesc(Ljava/lang/StringBuilder;)V
    .locals 1

    const-string v0, "/"

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    return-void
.end method

.method public final writeFieldName(Ljava/lang/String;)I
    .locals 1

    const/4 v0, 0x4

    return v0
.end method

.method public final writeValue()I
    .locals 1

    iget v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/RootWContext;->_index:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/RootWContext;->_index:I

    iget v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/RootWContext;->_index:I

    if-nez v0, :cond_0

    const/4 v0, 0x0

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x3

    goto :goto_0
.end method
