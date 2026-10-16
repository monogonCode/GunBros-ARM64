package com.openfeint.internal.vendor.org.codehaus.jackson.util;

import java.math.BigDecimal;
import java.util.ArrayList;

/* JADX INFO: loaded from: classes.dex */
public final class TextBuffer {
    static final char[] NO_CHARS = new char[0];
    private final BufferRecycler _allocator;
    private char[] _currentSegment;
    private int _currentSize;
    private boolean _hasSegments = false;
    private char[] _inputBuffer;
    private int _inputLen;
    private int _inputStart;
    private char[] _resultArray;
    private String _resultString;
    private int _segmentSize;
    private ArrayList<char[]> _segments;

    public TextBuffer(BufferRecycler bufferRecycler) {
        this._allocator = bufferRecycler;
    }

    private final void clearSegments() {
        this._hasSegments = false;
        this._segments.clear();
        this._segmentSize = 0;
        this._currentSize = 0;
    }

    private char[] contentsAsArray() {
        int i;
        char[] charArray = this._resultArray;
        if (charArray == null) {
            if (this._resultString != null) {
                charArray = this._resultString.toCharArray();
            } else if (this._inputStart < 0) {
                int size = size();
                if (size <= 0) {
                    charArray = NO_CHARS;
                } else {
                    char[] cArr = new char[size];
                    if (this._segments != null) {
                        int size2 = this._segments.size();
                        int i2 = 0;
                        for (int i3 = 0; i3 < size2; i3++) {
                            char[] cArr2 = this._segments.get(i3);
                            int length = cArr2.length;
                            System.arraycopy(cArr2, 0, cArr, i2, length);
                            i2 += length;
                        }
                        i = i2;
                    } else {
                        i = 0;
                    }
                    System.arraycopy(this._currentSegment, 0, cArr, i, this._currentSize);
                    charArray = cArr;
                }
            } else if (this._inputLen <= 0) {
                charArray = NO_CHARS;
            } else {
                charArray = new char[this._inputLen];
                System.arraycopy(this._inputBuffer, this._inputStart, charArray, 0, this._inputLen);
            }
            this._resultArray = charArray;
        }
        return charArray;
    }

    private void expand(int i) {
        if (this._segments == null) {
            this._segments = new ArrayList<>();
        }
        char[] cArr = this._currentSegment;
        this._hasSegments = true;
        this._segments.add(cArr);
        this._segmentSize += cArr.length;
        int length = cArr.length;
        int i2 = length >> 1;
        if (i2 >= i) {
            i = i2;
        }
        char[] cArr2 = new char[Math.min(262144, length + i)];
        this._currentSize = 0;
        this._currentSegment = cArr2;
    }

    private final char[] findBuffer(int i) {
        return this._allocator.allocCharBuffer(BufferRecycler.CharBufferType.TEXT_BUFFER, i);
    }

    private void resetWithEmpty() {
        this._inputBuffer = null;
        this._inputStart = -1;
        this._inputLen = 0;
        this._resultString = null;
        this._resultArray = null;
        if (this._hasSegments) {
            clearSegments();
        }
        this._currentSize = 0;
    }

    private void unshare(int i) {
        int i2 = this._inputLen;
        this._inputLen = 0;
        char[] cArr = this._inputBuffer;
        this._inputBuffer = null;
        int i3 = this._inputStart;
        this._inputStart = -1;
        int i4 = i2 + i;
        if (this._currentSegment == null || i4 > this._currentSegment.length) {
            this._currentSegment = findBuffer(i4);
        }
        if (i2 > 0) {
            System.arraycopy(cArr, i3, this._currentSegment, 0, i2);
        }
        this._segmentSize = 0;
        this._currentSize = i2;
    }

    public final BigDecimal contentsAsDecimal() throws NumberFormatException {
        if (this._resultArray != null) {
            return new BigDecimal(this._resultArray);
        }
        if (this._inputStart >= 0) {
            return new BigDecimal(this._inputBuffer, this._inputStart, this._inputLen);
        }
        return this._segmentSize == 0 ? new BigDecimal(this._currentSegment, 0, this._currentSize) : new BigDecimal(contentsAsArray());
    }

    public final double contentsAsDouble() throws NumberFormatException {
        return Double.parseDouble(contentsAsString());
    }

    public final String contentsAsString() {
        if (this._resultString == null) {
            if (this._resultArray != null) {
                this._resultString = new String(this._resultArray);
            } else if (this._inputStart < 0) {
                int i = this._segmentSize;
                int i2 = this._currentSize;
                if (i == 0) {
                    this._resultString = i2 == 0 ? "" : new String(this._currentSegment, 0, i2);
                } else {
                    StringBuilder sb = new StringBuilder(i + i2);
                    if (this._segments != null) {
                        int size = this._segments.size();
                        for (int i3 = 0; i3 < size; i3++) {
                            char[] cArr = this._segments.get(i3);
                            sb.append(cArr, 0, cArr.length);
                        }
                    }
                    sb.append(this._currentSegment, 0, this._currentSize);
                    this._resultString = sb.toString();
                }
            } else {
                if (this._inputLen <= 0) {
                    this._resultString = "";
                    return "";
                }
                this._resultString = new String(this._inputBuffer, this._inputStart, this._inputLen);
            }
        }
        return this._resultString;
    }

    public final char[] emptyAndGetCurrentSegment() {
        resetWithEmpty();
        char[] cArr = this._currentSegment;
        if (cArr != null) {
            return cArr;
        }
        char[] cArrFindBuffer = findBuffer(0);
        this._currentSegment = cArrFindBuffer;
        return cArrFindBuffer;
    }

    public final char[] expandCurrentSegment() {
        char[] cArr = this._currentSegment;
        int length = cArr.length;
        this._currentSegment = new char[length == 262144 ? 262145 : Math.min(262144, (length >> 1) + length)];
        System.arraycopy(cArr, 0, this._currentSegment, 0, length);
        return this._currentSegment;
    }

    public final char[] finishCurrentSegment() {
        if (this._segments == null) {
            this._segments = new ArrayList<>();
        }
        this._hasSegments = true;
        this._segments.add(this._currentSegment);
        int length = this._currentSegment.length;
        this._segmentSize += length;
        char[] cArr = new char[Math.min(length + (length >> 1), 262144)];
        this._currentSize = 0;
        this._currentSegment = cArr;
        return cArr;
    }

    public final char[] getCurrentSegment() {
        if (this._inputStart >= 0) {
            unshare(1);
        } else {
            char[] cArr = this._currentSegment;
            if (cArr == null) {
                this._currentSegment = findBuffer(0);
            } else if (this._currentSize >= cArr.length) {
                expand(1);
            }
        }
        return this._currentSegment;
    }

    public final int getCurrentSegmentSize() {
        return this._currentSize;
    }

    public final char[] getTextBuffer() {
        if (this._inputStart >= 0) {
            return this._inputBuffer;
        }
        return !this._hasSegments ? this._currentSegment : contentsAsArray();
    }

    public final int getTextOffset() {
        if (this._inputStart >= 0) {
            return this._inputStart;
        }
        return 0;
    }

    public final void releaseBuffers() {
        if (this._allocator == null || this._currentSegment == null) {
            return;
        }
        resetWithEmpty();
        char[] cArr = this._currentSegment;
        this._currentSegment = null;
        this._allocator.releaseCharBuffer(BufferRecycler.CharBufferType.TEXT_BUFFER, cArr);
    }

    public final void resetWithCopy(char[] cArr, int i, int i2) {
        this._inputBuffer = null;
        this._inputStart = -1;
        this._inputLen = 0;
        this._resultString = null;
        this._resultArray = null;
        if (this._hasSegments) {
            clearSegments();
        } else if (this._currentSegment == null) {
            this._currentSegment = findBuffer(i2);
        }
        this._segmentSize = 0;
        this._currentSize = 0;
        if (this._inputStart >= 0) {
            unshare(i2);
        }
        this._resultString = null;
        this._resultArray = null;
        char[] cArr2 = this._currentSegment;
        int length = cArr2.length - this._currentSize;
        if (length >= i2) {
            System.arraycopy(cArr, i, cArr2, this._currentSize, i2);
            this._currentSize += i2;
            return;
        }
        if (length > 0) {
            System.arraycopy(cArr, i, cArr2, this._currentSize, length);
            i += length;
            i2 -= length;
        }
        expand(i2);
        System.arraycopy(cArr, i, this._currentSegment, 0, i2);
        this._currentSize = i2;
    }

    public final void resetWithShared(char[] cArr, int i, int i2) {
        this._resultString = null;
        this._resultArray = null;
        this._inputBuffer = cArr;
        this._inputStart = i;
        this._inputLen = i2;
        if (this._hasSegments) {
            clearSegments();
        }
    }

    public final void setCurrentLength(int i) {
        this._currentSize = i;
    }

    public final int size() {
        return this._inputStart >= 0 ? this._inputLen : this._segmentSize + this._currentSize;
    }

    public final String toString() {
        return contentsAsString();
    }
}
