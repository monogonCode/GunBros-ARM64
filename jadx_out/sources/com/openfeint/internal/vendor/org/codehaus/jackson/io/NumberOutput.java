package com.openfeint.internal.vendor.org.codehaus.jackson.io;

/* JADX INFO: loaded from: classes.dex */
public final class NumberOutput {
    static final String[] sSmallIntStrs;
    static final String[] sSmallIntStrs2;
    private static int MILLION = 1000000;
    private static int BILLION = 1000000000;
    private static long TEN_BILLION_L = 10000000000L;
    private static long THOUSAND_L = 1000;
    private static long MIN_INT_AS_LONG = -2147483648L;
    private static long MAX_INT_AS_LONG = 2147483647L;
    static final String SMALLEST_LONG = String.valueOf(Long.MIN_VALUE);
    static final char[] LEADING_TRIPLETS = new char[4000];
    static final char[] FULL_TRIPLETS = new char[4000];

    static {
        int i = 0;
        int i2 = 0;
        while (i < 10) {
            char c = (char) (i + 48);
            char c2 = i == 0 ? (char) 0 : c;
            int i3 = 0;
            while (i3 < 10) {
                char c3 = (char) (i3 + 48);
                char c4 = (i == 0 && i3 == 0) ? (char) 0 : c3;
                int i4 = i2;
                for (int i5 = 0; i5 < 10; i5++) {
                    char c5 = (char) (i5 + 48);
                    LEADING_TRIPLETS[i4] = c2;
                    LEADING_TRIPLETS[i4 + 1] = c4;
                    LEADING_TRIPLETS[i4 + 2] = c5;
                    FULL_TRIPLETS[i4] = c;
                    FULL_TRIPLETS[i4 + 1] = c3;
                    FULL_TRIPLETS[i4 + 2] = c5;
                    i4 += 4;
                }
                i3++;
                i2 = i4;
            }
            i++;
        }
        sSmallIntStrs = new String[]{"0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10"};
        sSmallIntStrs2 = new String[]{"-1", "-2", "-3", "-4", "-5", "-6", "-7", "-8", "-9", "-10"};
    }

    private static int outputFullTriplet(int i, char[] cArr, int i2) {
        int i3 = i << 2;
        int i4 = i2 + 1;
        int i5 = i3 + 1;
        cArr[i2] = FULL_TRIPLETS[i3];
        int i6 = i4 + 1;
        cArr[i4] = FULL_TRIPLETS[i5];
        int i7 = i6 + 1;
        cArr[i6] = FULL_TRIPLETS[i5 + 1];
        return i7;
    }

    public static int outputInt(int i, char[] cArr, int i2) {
        if (i < 0) {
            if (i == Integer.MIN_VALUE) {
                return outputLong(i, cArr, i2);
            }
            cArr[i2] = '-';
            i = -i;
            i2++;
        }
        if (i < MILLION) {
            if (i >= 1000) {
                int i3 = i / 1000;
                return outputFullTriplet(i - (i3 * 1000), cArr, outputLeadingTriplet(i3, cArr, i2));
            }
            if (i >= 10) {
                return outputLeadingTriplet(i, cArr, i2);
            }
            int i4 = i2 + 1;
            cArr[i2] = (char) (i + 48);
            return i4;
        }
        boolean z = i >= BILLION;
        if (z) {
            i -= BILLION;
            if (i >= BILLION) {
                i -= BILLION;
                cArr[i2] = '2';
                i2++;
            } else {
                cArr[i2] = '1';
                i2++;
            }
        }
        int i5 = i / 1000;
        int i6 = i5 / 1000;
        return outputFullTriplet(i - (i5 * 1000), cArr, outputFullTriplet(i5 - (i6 * 1000), cArr, z ? outputFullTriplet(i6, cArr, i2) : outputLeadingTriplet(i6, cArr, i2)));
    }

    private static int outputLeadingTriplet(int i, char[] cArr, int i2) {
        int i3 = i << 2;
        int i4 = i3 + 1;
        char c = LEADING_TRIPLETS[i3];
        if (c != 0) {
            cArr[i2] = c;
            i2++;
        }
        int i5 = i4 + 1;
        char c2 = LEADING_TRIPLETS[i4];
        if (c2 != 0) {
            cArr[i2] = c2;
            i2++;
        }
        int i6 = i2 + 1;
        cArr[i2] = LEADING_TRIPLETS[i5];
        return i6;
    }

    public static int outputLong(long j, char[] cArr, int i) {
        if (j < 0) {
            if (j > MIN_INT_AS_LONG) {
                return outputInt((int) j, cArr, i);
            }
            if (j == Long.MIN_VALUE) {
                int length = SMALLEST_LONG.length();
                SMALLEST_LONG.getChars(0, length, cArr, i);
                return i + length;
            }
            cArr[i] = '-';
            j = -j;
            i++;
        } else if (j <= MAX_INT_AS_LONG) {
            return outputInt((int) j, cArr, i);
        }
        int i2 = 10;
        for (long j2 = TEN_BILLION_L; j >= j2 && i2 != 19; j2 = (j2 << 1) + (j2 << 3)) {
            i2++;
        }
        int i3 = i + i2;
        int i4 = i3;
        while (j > MAX_INT_AS_LONG) {
            i4 -= 3;
            long j3 = j / THOUSAND_L;
            outputFullTriplet((int) (j - (THOUSAND_L * j3)), cArr, i4);
            j = j3;
        }
        int i5 = i4;
        int i6 = (int) j;
        while (i6 >= 1000) {
            int i7 = i5 - 3;
            int i8 = i6 / 1000;
            outputFullTriplet(i6 - (i8 * 1000), cArr, i7);
            i6 = i8;
            i5 = i7;
        }
        outputLeadingTriplet(i6, cArr, i);
        return i3;
    }
}
