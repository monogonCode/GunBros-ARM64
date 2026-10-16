package com.openfeint.internal.vendor.org.codehaus.jackson.sym;

/* JADX INFO: loaded from: classes.dex */
public abstract class Name {
    protected final int mHashCode;
    protected final String mName;

    protected Name(String str, int i) {
        this.mName = str;
        this.mHashCode = i;
    }

    public abstract boolean equals(int i);

    public abstract boolean equals(int i, int i2);

    public boolean equals(Object obj) {
        return obj == this;
    }

    public abstract boolean equals(int[] iArr, int i);

    public final String getName() {
        return this.mName;
    }

    public final int hashCode() {
        return this.mHashCode;
    }

    public String toString() {
        return this.mName;
    }
}
