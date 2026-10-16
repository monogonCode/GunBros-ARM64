.class public final Lcom/openfeint/internal/RR;
.super Ljava/lang/Object;


# static fields
.field private static _packageName:Ljava/lang/String;

.field private static _resources:Landroid/content/res/Resources;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    const/4 v0, 0x0

    sput-object v0, Lcom/openfeint/internal/RR;->_resources:Landroid/content/res/Resources;

    sput-object v0, Lcom/openfeint/internal/RR;->_packageName:Ljava/lang/String;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static final drawable(Ljava/lang/String;)I
    .locals 1

    const-string v0, "drawable"

    invoke-static {p0, v0}, Lcom/openfeint/internal/RR;->identifier(Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    return v0
.end method

.method public static final id(Ljava/lang/String;)I
    .locals 1

    const-string v0, "id"

    invoke-static {p0, v0}, Lcom/openfeint/internal/RR;->identifier(Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    return v0
.end method

.method private static final identifier(Ljava/lang/String;Ljava/lang/String;)I
    .locals 2

    sget-object v0, Lcom/openfeint/internal/RR;->_resources:Landroid/content/res/Resources;

    if-nez v0, :cond_0

    invoke-static {}, Lcom/openfeint/internal/OpenFeintInternal;->getInstance()Lcom/openfeint/internal/OpenFeintInternal;

    move-result-object v0

    invoke-virtual {v0}, Lcom/openfeint/internal/OpenFeintInternal;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    sput-object v0, Lcom/openfeint/internal/RR;->_resources:Landroid/content/res/Resources;

    :cond_0
    sget-object v0, Lcom/openfeint/internal/RR;->_resources:Landroid/content/res/Resources;

    sget-object v1, Lcom/openfeint/internal/RR;->_packageName:Ljava/lang/String;

    if-nez v1, :cond_1

    invoke-static {}, Lcom/openfeint/internal/OpenFeintInternal;->getInstance()Lcom/openfeint/internal/OpenFeintInternal;

    move-result-object v1

    invoke-virtual {v1}, Lcom/openfeint/internal/OpenFeintInternal;->getContext()Landroid/content/Context;

    move-result-object v1

    invoke-virtual {v1}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v1

    sput-object v1, Lcom/openfeint/internal/RR;->_packageName:Ljava/lang/String;

    :cond_1
    sget-object v1, Lcom/openfeint/internal/RR;->_packageName:Ljava/lang/String;

    invoke-virtual {v0, p0, p1, v1}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    return v0
.end method

.method public static final layout(Ljava/lang/String;)I
    .locals 1

    const-string v0, "layout"

    invoke-static {p0, v0}, Lcom/openfeint/internal/RR;->identifier(Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    return v0
.end method

.method public static final menu(Ljava/lang/String;)I
    .locals 1

    const-string v0, "menu"

    invoke-static {p0, v0}, Lcom/openfeint/internal/RR;->identifier(Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    return v0
.end method

.method public static final string(Ljava/lang/String;)I
    .locals 1

    const-string v0, "string"

    invoke-static {p0, v0}, Lcom/openfeint/internal/RR;->identifier(Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    return v0
.end method

.method public static final style(Ljava/lang/String;)I
    .locals 1

    const-string v0, "style"

    invoke-static {p0, v0}, Lcom/openfeint/internal/RR;->identifier(Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    return v0
.end method
