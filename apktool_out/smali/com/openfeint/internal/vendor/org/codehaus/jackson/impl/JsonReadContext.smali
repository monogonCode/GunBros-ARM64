.class public final Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonReadContext;
.super Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonStreamContext;


# instance fields
.field _child:Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonReadContext;

.field protected _columnNr:I

.field protected _currentName:Ljava/lang/String;

.field protected _lineNr:I

.field protected final _parent:Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonReadContext;


# direct methods
.method public constructor <init>(Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonReadContext;III)V
    .locals 1

    invoke-direct {p0, p2}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonStreamContext;-><init>(I)V

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonReadContext;->_child:Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonReadContext;

    iput-object p1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonReadContext;->_parent:Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonReadContext;

    iput p3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonReadContext;->_lineNr:I

    iput p4, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonReadContext;->_columnNr:I

    return-void
.end method

.method private reset(III)V
    .locals 1

    iput p1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonReadContext;->_type:I

    const/4 v0, -0x1

    iput v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonReadContext;->_index:I

    iput p2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonReadContext;->_lineNr:I

    iput p3, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonReadContext;->_columnNr:I

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonReadContext;->_currentName:Ljava/lang/String;

    return-void
.end method


# virtual methods
.method public final createChildArrayContext(II)Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonReadContext;
    .locals 2

    const/4 v1, 0x1

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonReadContext;->_child:Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonReadContext;

    if-nez v0, :cond_0

    new-instance v0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonReadContext;

    invoke-direct {v0, p0, v1, p1, p2}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonReadContext;-><init>(Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonReadContext;III)V

    iput-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonReadContext;->_child:Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonReadContext;

    :goto_0
    return-object v0

    :cond_0
    invoke-direct {v0, v1, p1, p2}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonReadContext;->reset(III)V

    goto :goto_0
.end method

.method public final createChildObjectContext(II)Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonReadContext;
    .locals 2

    const/4 v1, 0x2

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonReadContext;->_child:Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonReadContext;

    if-nez v0, :cond_0

    new-instance v0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonReadContext;

    invoke-direct {v0, p0, v1, p1, p2}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonReadContext;-><init>(Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonReadContext;III)V

    iput-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonReadContext;->_child:Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonReadContext;

    :goto_0
    return-object v0

    :cond_0
    invoke-direct {v0, v1, p1, p2}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonReadContext;->reset(III)V

    goto :goto_0
.end method

.method public final expectComma()Z
    .locals 2

    iget v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonReadContext;->_index:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonReadContext;->_index:I

    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonReadContext;->_type:I

    if-eqz v1, :cond_0

    if-lez v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public final getCurrentName()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonReadContext;->_currentName:Ljava/lang/String;

    return-object v0
.end method

.method public final getParent()Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonReadContext;
    .locals 1

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonReadContext;->_parent:Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonReadContext;

    return-object v0
.end method

.method public final getStartLocation(Ljava/lang/Object;)Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonLocation;
    .locals 7

    new-instance v0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonLocation;

    const-wide/16 v2, -0x1

    iget v4, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonReadContext;->_lineNr:I

    iget v5, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonReadContext;->_columnNr:I

    const/4 v6, 0x0

    move-object v1, p1

    invoke-direct/range {v0 .. v6}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonLocation;-><init>(Ljava/lang/Object;JIIB)V

    return-object v0
.end method

.method public final setCurrentName(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonReadContext;->_currentName:Ljava/lang/String;

    return-void
.end method

.method public final toString()Ljava/lang/String;
    .locals 4

    const/16 v3, 0x5d

    const/16 v2, 0x22

    new-instance v0, Ljava/lang/StringBuilder;

    const/16 v1, 0x40

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(I)V

    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonReadContext;->_type:I

    packed-switch v1, :pswitch_data_0

    :goto_0
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0

    :pswitch_0
    const-string v1, "/"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_0

    :pswitch_1
    const/16 v1, 0x5b

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    invoke-virtual {p0}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonReadContext;->getCurrentIndex()I

    move-result v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    goto :goto_0

    :pswitch_2
    const/16 v1, 0x7b

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    iget-object v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonReadContext;->_currentName:Ljava/lang/String;

    if-eqz v1, :cond_0

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    iget-object v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/impl/JsonReadContext;->_currentName:Ljava/lang/String;

    invoke-static {v0, v1}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/util/CharTypes;->appendQuoted(Ljava/lang/StringBuilder;Ljava/lang/String;)V

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    :goto_1
    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    goto :goto_0

    :cond_0
    const/16 v1, 0x3f

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    goto :goto_1

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_0
        :pswitch_1
        :pswitch_2
    .end packed-switch
.end method
