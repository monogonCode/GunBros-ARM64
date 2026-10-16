.class public final Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonLocation;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/io/Serializable;


# static fields
.field public static final NA:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonLocation;


# instance fields
.field final _columnNr:I

.field final _lineNr:I

.field final _sourceRef:Ljava/lang/Object;

.field final _totalBytes:J

.field final _totalChars:J


# direct methods
.method static constructor <clinit>()V
    .locals 6

    const/4 v4, -0x1

    new-instance v0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonLocation;

    const-string v1, "N/A"

    const-wide/16 v2, -0x1

    move v5, v4

    invoke-direct/range {v0 .. v5}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonLocation;-><init>(Ljava/lang/Object;JII)V

    sput-object v0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonLocation;->NA:Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonLocation;

    return-void
.end method

.method private constructor <init>(Ljava/lang/Object;JII)V
    .locals 2

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonLocation;->_sourceRef:Ljava/lang/Object;

    const-wide/16 v0, -0x1

    iput-wide v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonLocation;->_totalBytes:J

    iput-wide p2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonLocation;->_totalChars:J

    iput p4, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonLocation;->_lineNr:I

    iput p5, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonLocation;->_columnNr:I

    return-void
.end method

.method public constructor <init>(Ljava/lang/Object;JIIB)V
    .locals 0

    invoke-direct/range {p0 .. p5}, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonLocation;-><init>(Ljava/lang/Object;JII)V

    return-void
.end method


# virtual methods
.method public final equals(Ljava/lang/Object;)Z
    .locals 6

    const/4 v0, 0x1

    const/4 v1, 0x0

    if-ne p1, p0, :cond_1

    :cond_0
    :goto_0
    return v0

    :cond_1
    if-nez p1, :cond_2

    move v0, v1

    goto :goto_0

    :cond_2
    instance-of v2, p1, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonLocation;

    if-nez v2, :cond_3

    move v0, v1

    goto :goto_0

    :cond_3
    check-cast p1, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonLocation;

    iget-object v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonLocation;->_sourceRef:Ljava/lang/Object;

    if-nez v2, :cond_4

    iget-object v2, p1, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonLocation;->_sourceRef:Ljava/lang/Object;

    if-eqz v2, :cond_5

    move v0, v1

    goto :goto_0

    :cond_4
    iget-object v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonLocation;->_sourceRef:Ljava/lang/Object;

    iget-object v3, p1, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonLocation;->_sourceRef:Ljava/lang/Object;

    invoke-virtual {v2, v3}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_5

    move v0, v1

    goto :goto_0

    :cond_5
    iget v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonLocation;->_lineNr:I

    iget v3, p1, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonLocation;->_lineNr:I

    if-ne v2, v3, :cond_6

    iget v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonLocation;->_columnNr:I

    iget v3, p1, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonLocation;->_columnNr:I

    if-ne v2, v3, :cond_6

    iget-wide v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonLocation;->_totalChars:J

    iget-wide v4, p1, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonLocation;->_totalChars:J

    cmp-long v2, v2, v4

    if-nez v2, :cond_6

    iget-wide v2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonLocation;->_totalBytes:J

    iget-wide v4, p1, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonLocation;->_totalBytes:J

    cmp-long v2, v2, v4

    if-eqz v2, :cond_0

    :cond_6
    move v0, v1

    goto :goto_0
.end method

.method public final hashCode()I
    .locals 3

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonLocation;->_sourceRef:Ljava/lang/Object;

    if-nez v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonLocation;->_lineNr:I

    xor-int/2addr v0, v1

    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonLocation;->_columnNr:I

    add-int/2addr v0, v1

    iget-wide v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonLocation;->_totalChars:J

    long-to-int v1, v1

    xor-int/2addr v0, v1

    iget-wide v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonLocation;->_totalBytes:J

    long-to-int v1, v1

    add-int/2addr v0, v1

    return v0

    :cond_0
    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonLocation;->_sourceRef:Ljava/lang/Object;

    invoke-virtual {v0}, Ljava/lang/Object;->hashCode()I

    move-result v0

    goto :goto_0
.end method

.method public final toString()Ljava/lang/String;
    .locals 2

    new-instance v0, Ljava/lang/StringBuilder;

    const/16 v1, 0x50

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(I)V

    const-string v1, "[Source: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonLocation;->_sourceRef:Ljava/lang/Object;

    if-nez v1, :cond_0

    const-string v1, "UNKNOWN"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    :goto_0
    const-string v1, "; line: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonLocation;->_lineNr:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v1, ", column: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonLocation;->_columnNr:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const/16 v1, 0x5d

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0

    :cond_0
    iget-object v1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/JsonLocation;->_sourceRef:Ljava/lang/Object;

    invoke-virtual {v1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_0
.end method
