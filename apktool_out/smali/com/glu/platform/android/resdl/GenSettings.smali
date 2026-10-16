.class public final Lcom/glu/platform/android/resdl/GenSettings;
.super Ljava/lang/Object;


# static fields
.field public static final SPECIAL_FILE_URL_KEYS:[Ljava/lang/String;

.field public static final SPECIAL_RES_CHECKSUM_ARRAY:[[J

.field public static final SPECIAL_RES_FILENAME_ARRAY:[[Ljava/lang/String;

.field public static final SPECIAL_RES_FILESIZE_ARRAY:[[I


# direct methods
.method static constructor <clinit>()V
    .locals 10

    const/4 v9, 0x2

    const/4 v8, 0x1

    const/4 v7, 0x0

    const/16 v6, 0x10

    const/16 v5, 0x17

    new-array v0, v9, [Ljava/lang/String;

    const-string v1, "Glu-Special-File-URL-WVGA"

    aput-object v1, v0, v7

    const-string v1, "Glu-Special-File-URL-DVGA"

    aput-object v1, v0, v8

    sput-object v0, Lcom/glu/platform/android/resdl/GenSettings;->SPECIAL_FILE_URL_KEYS:[Ljava/lang/String;

    new-array v0, v9, [[Ljava/lang/String;

    new-array v1, v5, [Ljava/lang/String;

    const-string v2, "Gman_intro.3gp"

    aput-object v2, v1, v7

    const-string v2, "events.dat"

    aput-object v2, v1, v8

    const-string v2, "pack0_core_wvga.big"

    aput-object v2, v1, v9

    const/4 v2, 0x3

    const-string v3, "pack10_wvga.big"

    aput-object v3, v1, v2

    const/4 v2, 0x4

    const-string v3, "pack11_wvga.big"

    aput-object v3, v1, v2

    const/4 v2, 0x5

    const-string v3, "pack12_wvga.big"

    aput-object v3, v1, v2

    const/4 v2, 0x6

    const-string v3, "pack1_wvga.big"

    aput-object v3, v1, v2

    const/4 v2, 0x7

    const-string v3, "pack2_wvga.big"

    aput-object v3, v1, v2

    const/16 v2, 0x8

    const-string v3, "pack3_wvga.big"

    aput-object v3, v1, v2

    const/16 v2, 0x9

    const-string v3, "pack4_wvga.big"

    aput-object v3, v1, v2

    const/16 v2, 0xa

    const-string v3, "pack5_wvga.big"

    aput-object v3, v1, v2

    const/16 v2, 0xb

    const-string v3, "pack6_wvga.big"

    aput-object v3, v1, v2

    const/16 v2, 0xc

    const-string v3, "pack7_wvga.big"

    aput-object v3, v1, v2

    const/16 v2, 0xd

    const-string v3, "pack8_wvga.big"

    aput-object v3, v1, v2

    const/16 v2, 0xe

    const-string v3, "pack9_wvga.big"

    aput-object v3, v1, v2

    const/16 v2, 0xf

    const-string v3, "packTOC_wvga.dat"

    aput-object v3, v1, v2

    const-string v2, "1.mp3"

    aput-object v2, v1, v6

    const/16 v2, 0x11

    const-string v3, "2.mp3"

    aput-object v3, v1, v2

    const/16 v2, 0x12

    const-string v3, "3.mp3"

    aput-object v3, v1, v2

    const/16 v2, 0x13

    const-string v3, "4.mp3"

    aput-object v3, v1, v2

    const/16 v2, 0x14

    const-string v3, "5.mp3"

    aput-object v3, v1, v2

    const/16 v2, 0x15

    const-string v3, "6.mp3"

    aput-object v3, v1, v2

    const/16 v2, 0x16

    const-string v3, "game_0.mp3"

    aput-object v3, v1, v2

    aput-object v1, v0, v7

    new-array v1, v5, [Ljava/lang/String;

    const-string v2, "Gman_intro.3gp"

    aput-object v2, v1, v7

    const-string v2, "events.dat"

    aput-object v2, v1, v8

    const-string v2, "pack0_core_xga.big"

    aput-object v2, v1, v9

    const/4 v2, 0x3

    const-string v3, "pack10_xga.big"

    aput-object v3, v1, v2

    const/4 v2, 0x4

    const-string v3, "pack11_xga.big"

    aput-object v3, v1, v2

    const/4 v2, 0x5

    const-string v3, "pack12_xga.big"

    aput-object v3, v1, v2

    const/4 v2, 0x6

    const-string v3, "pack1_xga.big"

    aput-object v3, v1, v2

    const/4 v2, 0x7

    const-string v3, "pack2_xga.big"

    aput-object v3, v1, v2

    const/16 v2, 0x8

    const-string v3, "pack3_xga.big"

    aput-object v3, v1, v2

    const/16 v2, 0x9

    const-string v3, "pack4_xga.big"

    aput-object v3, v1, v2

    const/16 v2, 0xa

    const-string v3, "pack5_xga.big"

    aput-object v3, v1, v2

    const/16 v2, 0xb

    const-string v3, "pack6_xga.big"

    aput-object v3, v1, v2

    const/16 v2, 0xc

    const-string v3, "pack7_xga.big"

    aput-object v3, v1, v2

    const/16 v2, 0xd

    const-string v3, "pack8_xga.big"

    aput-object v3, v1, v2

    const/16 v2, 0xe

    const-string v3, "pack9_xga.big"

    aput-object v3, v1, v2

    const/16 v2, 0xf

    const-string v3, "packTOC_xga.dat"

    aput-object v3, v1, v2

    const-string v2, "1.mp3"

    aput-object v2, v1, v6

    const/16 v2, 0x11

    const-string v3, "2.mp3"

    aput-object v3, v1, v2

    const/16 v2, 0x12

    const-string v3, "3.mp3"

    aput-object v3, v1, v2

    const/16 v2, 0x13

    const-string v3, "4.mp3"

    aput-object v3, v1, v2

    const/16 v2, 0x14

    const-string v3, "5.mp3"

    aput-object v3, v1, v2

    const/16 v2, 0x15

    const-string v3, "6.mp3"

    aput-object v3, v1, v2

    const/16 v2, 0x16

    const-string v3, "game_0.mp3"

    aput-object v3, v1, v2

    aput-object v1, v0, v8

    sput-object v0, Lcom/glu/platform/android/resdl/GenSettings;->SPECIAL_RES_FILENAME_ARRAY:[[Ljava/lang/String;

    new-array v0, v9, [[I

    new-array v1, v5, [I

    fill-array-data v1, :array_0

    aput-object v1, v0, v7

    new-array v1, v5, [I

    fill-array-data v1, :array_1

    aput-object v1, v0, v8

    sput-object v0, Lcom/glu/platform/android/resdl/GenSettings;->SPECIAL_RES_FILESIZE_ARRAY:[[I

    new-array v0, v9, [[J

    new-array v1, v5, [J

    fill-array-data v1, :array_2

    aput-object v1, v0, v7

    new-array v1, v5, [J

    fill-array-data v1, :array_3

    aput-object v1, v0, v8

    sput-object v0, Lcom/glu/platform/android/resdl/GenSettings;->SPECIAL_RES_CHECKSUM_ARRAY:[[J

    return-void

    :array_0
    .array-data 4
        0x115cf8
        0x174ed
        0x15e4aea
        0x797815
        0xabb48a
        0xda61bb
        0x11e2006
        0x4953f6
        0x152aab
        0x2a7417d
        0x1bd28c4
        0x5f83da
        0x7df95f
        0xaeac57
        0x6880f1
        0x1a8
        0x21efc1
        0x1b4af0
        0x1c4382
        0x17254e
        0x1c8a87
        0x1ad429
        0x1ff980
    .end array-data

    :array_1
    .array-data 4
        0x115cf8
        0x174ed
        0x1cac63f
        0x737e82
        0xae48ce
        0xda61ba
        0x12b4114
        0x4be487
        0x1f900e
        0x2b9c157
        0x1d3aed8
        0x63fba0
        0x7fa602
        0xaf9ef5
        0x6ae6ac
        0x19b
        0x21efc1
        0x1b4af0
        0x1c4382
        0x17254e
        0x1c8a87
        0x1ad429
        0x1ff980
    .end array-data

    :array_2
    .array-data 8
        0x11c61803bL
        0x1270dcbc
        0x15a7c7bf80L
        0x7aaf72bf5L
        0xaa9ab5719L
        0xda35e3813L
        0x12266a24acL
        0x48eded900L
        0x148094c62L
        0x2a3c3d9651L
        0x1bc21bb110L
        0x6230f02b2L
        0x7afdda1f7L
        0xb12552d93L
        0x65a16dbfbL
        0x8132007
        0x203136300L
        0x1aae752abL
        0x1d5bac97eL
        0x1740bb65dL
        0x1cd9b994cL
        0x1a4bcabb2L
        0x1f9f1aaefL
    .end array-data

    :array_3
    .array-data 8
        0x11c61803bL
        0x1270dcbc
        0x1c25ce4bfbL
        0x74735673cL
        0xae12e8e30L
        0xda35e1813L
        0x12daf0e874L
        0x4abe7d352L
        0x1ea5bb1b1L
        0x2b65b49b4aL
        0x1cb4d4b5e8L
        0x6520f7e82L
        0x7d514c4caL
        0xb312da393L
        0x680271e4aL
        0x7160862
        0x203136300L
        0x1aae752abL
        0x1d5bac97eL
        0x1740bb65dL
        0x1cd9b994cL
        0x1a4bcabb2L
        0x1f9f1aaefL
    .end array-data
.end method

.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method
