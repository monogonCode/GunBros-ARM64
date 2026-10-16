package com.openfeint.internal.vendor.org.codehaus.jackson.sym;

import com.openfeint.internal.vendor.org.codehaus.jackson.util.InternCache;
import java.util.Arrays;

/* JADX INFO: loaded from: classes.dex */
public final class BytesToNameCanonicalizer {
    private int _collCount;
    private int _collEnd;
    private Bucket[] _collList;
    private boolean _collListShared;
    private int _count;
    final boolean _intern;
    private int[] _mainHash;
    private int _mainHashMask;
    private boolean _mainHashShared;
    private Name[] _mainNames;
    private boolean _mainNamesShared;
    private transient boolean _needRehash;
    final BytesToNameCanonicalizer _parent;

    static final class Bucket {
        final Name mName;
        final Bucket mNext;

        Bucket(Name name, Bucket bucket) {
            this.mName = name;
            this.mNext = bucket;
        }

        public final Name find(int i, int i2, int i3) {
            if (this.mName.hashCode() == i && this.mName.equals(i2, i3)) {
                return this.mName;
            }
            for (Bucket bucket = this.mNext; bucket != null; bucket = bucket.mNext) {
                Name name = bucket.mName;
                if (name.hashCode() == i && name.equals(i2, i3)) {
                    return name;
                }
            }
            return null;
        }
    }

    private BytesToNameCanonicalizer() {
        this._parent = null;
        this._intern = true;
        initTables$13462e();
    }

    private BytesToNameCanonicalizer(BytesToNameCanonicalizer bytesToNameCanonicalizer, boolean z) {
        this._parent = bytesToNameCanonicalizer;
        this._intern = z;
        this._count = bytesToNameCanonicalizer._count;
        this._mainHashMask = bytesToNameCanonicalizer._mainHashMask;
        this._mainHash = bytesToNameCanonicalizer._mainHash;
        this._mainNames = bytesToNameCanonicalizer._mainNames;
        this._collList = bytesToNameCanonicalizer._collList;
        this._collCount = bytesToNameCanonicalizer._collCount;
        this._collEnd = bytesToNameCanonicalizer._collEnd;
        this._needRehash = false;
        this._mainHashShared = true;
        this._mainNamesShared = true;
        this._collListShared = true;
    }

    private static int calcHash(int[] iArr, int i) {
        int i2 = iArr[0];
        for (int i3 = 1; i3 < i; i3++) {
            i2 = (i2 * 31) + iArr[i3];
        }
        int i4 = (i2 >>> 16) ^ i2;
        return i4 ^ (i4 >>> 8);
    }

    public static BytesToNameCanonicalizer createRoot() {
        return new BytesToNameCanonicalizer();
    }

    private void expandCollision() {
        Bucket[] bucketArr = this._collList;
        int length = bucketArr.length;
        this._collList = new Bucket[length + length];
        System.arraycopy(bucketArr, 0, this._collList, 0, length);
    }

    private int findBestBucket() {
        Bucket[] bucketArr = this._collList;
        int i = Integer.MAX_VALUE;
        int i2 = -1;
        int i3 = 0;
        int i4 = this._collEnd;
        while (i3 < i4) {
            int i5 = 1;
            for (Bucket bucket = bucketArr[i3].mNext; bucket != null; bucket = bucket.mNext) {
                i5++;
            }
            if (i5 >= i) {
                i5 = i;
            } else {
                if (i5 == 1) {
                    return i3;
                }
                i2 = i3;
            }
            i3++;
            i = i5;
        }
        return i2;
    }

    public static Name getEmptyName() {
        return Name1.getEmptyName();
    }

    private void initTables$13462e() {
        this._count = 0;
        this._mainHash = new int[64];
        this._mainNames = new Name[64];
        this._mainHashShared = false;
        this._mainNamesShared = false;
        this._mainHashMask = 63;
        this._collListShared = true;
        this._collList = null;
        this._collEnd = 0;
        this._needRehash = false;
    }

    private synchronized void mergeChild(BytesToNameCanonicalizer bytesToNameCanonicalizer) {
        if (bytesToNameCanonicalizer._count > this._count) {
            if (bytesToNameCanonicalizer._count > 6000) {
                initTables$13462e();
            } else {
                this._count = bytesToNameCanonicalizer._count;
                this._mainHash = bytesToNameCanonicalizer._mainHash;
                this._mainNames = bytesToNameCanonicalizer._mainNames;
                this._mainHashShared = true;
                this._mainNamesShared = true;
                this._mainHashMask = bytesToNameCanonicalizer._mainHashMask;
                this._collList = bytesToNameCanonicalizer._collList;
                this._collCount = bytesToNameCanonicalizer._collCount;
                this._collEnd = bytesToNameCanonicalizer._collEnd;
            }
        }
    }

    /* JADX WARN: Code duplicated, block: B:11:0x0021 A[LOOP:3: B:9:0x001d->B:11:0x0021, LOOP_END] */
    /* JADX WARN: Code duplicated, block: B:8:0x0018  */
    public final Name addName(String str, int[] iArr, int i) {
        int[] iArr2;
        int i2;
        Name nameN;
        int iFindBestBucket;
        int iFindBestBucket2;
        String strIntern = this._intern ? InternCache.instance.intern(str) : str;
        int iCalcHash = calcHash(iArr, i);
        if (i < 4) {
            switch (i) {
                case 1:
                    nameN = new Name1(strIntern, iCalcHash, iArr[0]);
                    break;
                case 2:
                    nameN = new Name2(strIntern, iCalcHash, iArr[0], iArr[1]);
                    break;
                case 3:
                    nameN = new Name3(strIntern, iCalcHash, iArr[0], iArr[1], iArr[2]);
                    break;
                default:
                    iArr2 = new int[i];
                    for (i2 = 0; i2 < i; i2++) {
                        iArr2[i2] = iArr[i2];
                    }
                    nameN = new NameN(strIntern, iCalcHash, iArr2, i);
                    break;
            }
        } else {
            iArr2 = new int[i];
            while (i2 < i) {
                iArr2[i2] = iArr[i2];
            }
            nameN = new NameN(strIntern, iCalcHash, iArr2, i);
        }
        if (this._mainHashShared) {
            int[] iArr3 = this._mainHash;
            int length = this._mainHash.length;
            this._mainHash = new int[length];
            System.arraycopy(iArr3, 0, this._mainHash, 0, length);
            this._mainHashShared = false;
        }
        if (this._needRehash) {
            this._needRehash = false;
            this._mainNamesShared = false;
            int length2 = this._mainHash.length;
            int i3 = length2 + length2;
            if (i3 > 65536) {
                this._count = 0;
                Arrays.fill(this._mainHash, 0);
                Arrays.fill(this._mainNames, (Object) null);
                Arrays.fill(this._collList, (Object) null);
                this._collCount = 0;
                this._collEnd = 0;
            } else {
                this._mainHash = new int[i3];
                this._mainHashMask = i3 - 1;
                Name[] nameArr = this._mainNames;
                this._mainNames = new Name[i3];
                int i4 = 0;
                for (int i5 = 0; i5 < length2; i5++) {
                    Name name = nameArr[i5];
                    if (name != null) {
                        i4++;
                        int iHashCode = name.hashCode();
                        int i6 = this._mainHashMask & iHashCode;
                        this._mainNames[i6] = name;
                        this._mainHash[i6] = iHashCode << 8;
                    }
                }
                int i7 = this._collEnd;
                if (i7 != 0) {
                    this._collCount = 0;
                    this._collEnd = 0;
                    this._collListShared = false;
                    Bucket[] bucketArr = this._collList;
                    this._collList = new Bucket[bucketArr.length];
                    int i8 = 0;
                    while (i8 < i7) {
                        int i9 = i4;
                        for (Bucket bucket = bucketArr[i8]; bucket != null; bucket = bucket.mNext) {
                            i9++;
                            Name name2 = bucket.mName;
                            int iHashCode2 = name2.hashCode();
                            int i10 = this._mainHashMask & iHashCode2;
                            int i11 = this._mainHash[i10];
                            if (this._mainNames[i10] == null) {
                                this._mainHash[i10] = iHashCode2 << 8;
                                this._mainNames[i10] = name2;
                            } else {
                                this._collCount++;
                                int i12 = i11 & 255;
                                if (i12 == 0) {
                                    if (this._collEnd <= 254) {
                                        iFindBestBucket2 = this._collEnd;
                                        this._collEnd++;
                                        if (iFindBestBucket2 >= this._collList.length) {
                                            expandCollision();
                                        }
                                    } else {
                                        iFindBestBucket2 = findBestBucket();
                                    }
                                    this._mainHash[i10] = (i11 & (-256)) | (iFindBestBucket2 + 1);
                                } else {
                                    iFindBestBucket2 = i12 - 1;
                                }
                                this._collList[iFindBestBucket2] = new Bucket(name2, this._collList[iFindBestBucket2]);
                            }
                        }
                        i8++;
                        i4 = i9;
                    }
                    if (i4 != this._count) {
                        throw new RuntimeException("Internal error: count after rehash " + i4 + "; should be " + this._count);
                    }
                }
            }
        }
        this._count++;
        int i13 = iCalcHash & this._mainHashMask;
        if (this._mainNames[i13] == null) {
            this._mainHash[i13] = iCalcHash << 8;
            if (this._mainNamesShared) {
                Name[] nameArr2 = this._mainNames;
                int length3 = nameArr2.length;
                this._mainNames = new Name[length3];
                System.arraycopy(nameArr2, 0, this._mainNames, 0, length3);
                this._mainNamesShared = false;
            }
            this._mainNames[i13] = nameN;
        } else {
            if (this._collListShared) {
                Bucket[] bucketArr2 = this._collList;
                if (bucketArr2 == null) {
                    this._collList = new Bucket[32];
                } else {
                    int length4 = bucketArr2.length;
                    this._collList = new Bucket[length4];
                    System.arraycopy(bucketArr2, 0, this._collList, 0, length4);
                }
                this._collListShared = false;
            }
            this._collCount++;
            int i14 = this._mainHash[i13];
            int i15 = i14 & 255;
            if (i15 == 0) {
                if (this._collEnd <= 254) {
                    iFindBestBucket = this._collEnd;
                    this._collEnd++;
                    if (iFindBestBucket >= this._collList.length) {
                        expandCollision();
                    }
                } else {
                    iFindBestBucket = findBestBucket();
                }
                this._mainHash[i13] = (i14 & (-256)) | (iFindBestBucket + 1);
            } else {
                iFindBestBucket = i15 - 1;
            }
            this._collList[iFindBestBucket] = new Bucket(nameN, this._collList[iFindBestBucket]);
        }
        int length5 = this._mainHash.length;
        if (this._count > (length5 >> 1)) {
            int i16 = length5 >> 2;
            if (this._count > length5 - i16 || this._collCount >= i16) {
                this._needRehash = true;
            }
        }
        return nameN;
    }

    public final Name findName(int i) {
        int i2 = (i >>> 16) ^ i;
        int i3 = (i2 >>> 8) ^ i2;
        int i4 = this._mainHashMask & i3;
        int i5 = this._mainHash[i4];
        if ((((i5 >> 8) ^ i3) << 8) == 0) {
            Name name = this._mainNames[i4];
            if (name == null) {
                return null;
            }
            if (name.equals(i)) {
                return name;
            }
        } else if (i5 == 0) {
            return null;
        }
        int i6 = i5 & 255;
        if (i6 <= 0) {
            return null;
        }
        Bucket bucket = this._collList[i6 - 1];
        if (bucket != null) {
            return bucket.find(i3, i, 0);
        }
        return null;
    }

    public final Name findName(int i, int i2) {
        int i3 = (i * 31) + i2;
        int i4 = i3 ^ (i3 >>> 16);
        int i5 = (i4 >>> 8) ^ i4;
        int i6 = this._mainHashMask & i5;
        int i7 = this._mainHash[i6];
        if ((((i7 >> 8) ^ i5) << 8) == 0) {
            Name name = this._mainNames[i6];
            if (name == null) {
                return null;
            }
            if (name.equals(i, i2)) {
                return name;
            }
        } else if (i7 == 0) {
            return null;
        }
        int i8 = i7 & 255;
        if (i8 <= 0) {
            return null;
        }
        Bucket bucket = this._collList[i8 - 1];
        if (bucket != null) {
            return bucket.find(i5, i, i2);
        }
        return null;
    }

    public final Name findName(int[] iArr, int i) {
        int iCalcHash = calcHash(iArr, i);
        int i2 = this._mainHashMask & iCalcHash;
        int i3 = this._mainHash[i2];
        if ((((i3 >> 8) ^ iCalcHash) << 8) == 0) {
            Name name = this._mainNames[i2];
            if (name == null || name.equals(iArr, i)) {
                return name;
            }
        } else if (i3 == 0) {
            return null;
        }
        int i4 = i3 & 255;
        if (i4 > 0) {
            Bucket bucket = this._collList[i4 - 1];
            if (bucket != null) {
                if (bucket.mName.hashCode() == iCalcHash && bucket.mName.equals(iArr, i)) {
                    return bucket.mName;
                }
                for (Bucket bucket2 = bucket.mNext; bucket2 != null; bucket2 = bucket2.mNext) {
                    Name name2 = bucket2.mName;
                    if (name2.hashCode() == iCalcHash && name2.equals(iArr, i)) {
                        return name2;
                    }
                }
                return null;
            }
        }
        return null;
    }

    public final synchronized BytesToNameCanonicalizer makeChild$5e0e244d(boolean z) {
        return new BytesToNameCanonicalizer(this, z);
    }

    public final void release() {
        if (!(!this._mainHashShared) || this._parent == null) {
            return;
        }
        this._parent.mergeChild(this);
        this._mainHashShared = true;
        this._mainNamesShared = true;
        this._collListShared = true;
    }
}
