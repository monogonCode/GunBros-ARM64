package com.glu.platform.android.facebook;

import java.util.Hashtable;
import java.util.Vector;

/* JADX INFO: loaded from: classes.dex */
public final class MixedHash {
    private Hashtable<String, MixedHashContents> m_trueHash = new Hashtable<>();

    private static class MixedHashContents {
        private boolean m_boolean;
        private boolean m_booleanHasBeenSet;
        private MixedHash m_hash;
        private Vector<MixedHash> m_hashVector;
        private int m_int;
        private String m_string;

        /* synthetic */ MixedHashContents() {
            this((byte) 0);
        }

        private MixedHashContents(byte b) {
            this.m_hash = null;
            this.m_hashVector = null;
            this.m_int = Integer.MIN_VALUE;
            this.m_string = null;
            this.m_boolean = false;
            this.m_booleanHasBeenSet = false;
        }
    }

    public final void putMixedHashVector(String str, Vector<MixedHash> vector) {
        MixedHashContents mixedHashContents = new MixedHashContents();
        mixedHashContents.m_hashVector = vector;
        this.m_trueHash.put(str, mixedHashContents);
    }

    public final void putString(String str, String str2) {
        MixedHashContents mixedHashContents = new MixedHashContents();
        mixedHashContents.m_string = str2;
        this.m_trueHash.put(str, mixedHashContents);
    }
}
