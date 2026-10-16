.class public abstract Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/Name;
.super Ljava/lang/Object;


# instance fields
.field protected final mHashCode:I

.field protected final mName:Ljava/lang/String;


# direct methods
.method protected constructor <init>(Ljava/lang/String;I)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/Name;->mName:Ljava/lang/String;

    iput p2, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/Name;->mHashCode:I

    return-void
.end method


# virtual methods
.method public abstract equals(I)Z
.end method

.method public abstract equals(II)Z
.end method

.method public equals(Ljava/lang/Object;)Z
    .locals 1

    if-ne p1, p0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public abstract equals([II)Z
.end method

.method public final getName()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/Name;->mName:Ljava/lang/String;

    return-object v0
.end method

.method public final hashCode()I
    .locals 1

    iget v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/Name;->mHashCode:I

    return v0
.end method

.method public toString()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/openfeint/internal/vendor/org/codehaus/jackson/sym/Name;->mName:Ljava/lang/String;

    return-object v0
.end method
