package com.openfeint.internal.vendor.org.codehaus.jackson.sym;

/* JADX INFO: loaded from: classes.dex */
public final class Name1 extends Name {
    static final Name1 sEmptyName = new Name1("", 0, 0);
    final int mQuad;

    Name1(String str, int i, int i2) {
        super(str, i);
        this.mQuad = i2;
    }

    static final Name1 getEmptyName() {
        return sEmptyName;
    }

    @Override // com.openfeint.internal.vendor.org.codehaus.jackson.sym.Name
    public final boolean equals(int i) {
        return i == this.mQuad;
    }

    @Override // com.openfeint.internal.vendor.org.codehaus.jackson.sym.Name
    public final boolean equals(int i, int i2) {
        return i == this.mQuad && i2 == 0;
    }

    @Override // com.openfeint.internal.vendor.org.codehaus.jackson.sym.Name
    public final boolean equals(int[] iArr, int i) {
        return i == 1 && iArr[0] == this.mQuad;
    }
}
