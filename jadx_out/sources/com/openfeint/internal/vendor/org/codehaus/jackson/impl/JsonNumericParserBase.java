package com.openfeint.internal.vendor.org.codehaus.jackson.impl;

import com.openfeint.internal.vendor.org.codehaus.jackson.JsonParseException;
import com.openfeint.internal.vendor.org.codehaus.jackson.JsonToken;
import com.openfeint.internal.vendor.org.codehaus.jackson.io.IOContext;
import com.openfeint.internal.vendor.org.codehaus.jackson.io.NumberInput;
import java.io.IOException;
import java.math.BigDecimal;
import java.math.BigInteger;

/* JADX INFO: loaded from: classes.dex */
public abstract class JsonNumericParserBase extends JsonParserBase {
    protected int _numTypesValid;
    protected BigDecimal _numberBigDecimal;
    protected BigInteger _numberBigInt;
    protected double _numberDouble;
    protected int _numberInt;
    protected long _numberLong;
    protected boolean _numberNegative;
    protected int mExpLength;
    protected int mFractLength;
    protected int mIntLength;
    static final BigDecimal BD_MIN_LONG = new BigDecimal(Long.MIN_VALUE);
    static final BigDecimal BD_MAX_LONG = new BigDecimal(Long.MAX_VALUE);
    static final BigDecimal BD_MIN_INT = new BigDecimal(Long.MIN_VALUE);
    static final BigDecimal BD_MAX_INT = new BigDecimal(Long.MAX_VALUE);

    protected JsonNumericParserBase(IOContext iOContext, int i) {
        super(iOContext, i);
        this._numTypesValid = 0;
    }

    private void parseNumericValue(int i) throws JsonParseException {
        if (this._currToken == null || !this._currToken.isNumeric()) {
            _reportError("Current token (" + this._currToken + ") not numeric, can not use numeric value accessors");
        }
        try {
            if (this._currToken != JsonToken.VALUE_NUMBER_INT) {
                if (i == 16) {
                    this._numberBigDecimal = this._textBuffer.contentsAsDecimal();
                    this._numTypesValid = 16;
                    return;
                } else {
                    this._numberDouble = this._textBuffer.contentsAsDouble();
                    this._numTypesValid = 8;
                    return;
                }
            }
            char[] textBuffer = this._textBuffer.getTextBuffer();
            int textOffset = this._textBuffer.getTextOffset();
            int i2 = this.mIntLength;
            if (this._numberNegative) {
                textOffset++;
            }
            if (i2 <= 9) {
                int i3 = NumberInput.parseInt(textBuffer, textOffset, i2);
                if (this._numberNegative) {
                    i3 = -i3;
                }
                this._numberInt = i3;
                this._numTypesValid = 1;
                return;
            }
            if (i2 > 18) {
                String strContentsAsString = this._textBuffer.contentsAsString();
                if (NumberInput.inLongRange(textBuffer, textOffset, i2, this._numberNegative)) {
                    this._numberLong = Long.parseLong(strContentsAsString);
                    this._numTypesValid = 2;
                    return;
                } else {
                    this._numberBigInt = new BigInteger(strContentsAsString);
                    this._numTypesValid = 4;
                    return;
                }
            }
            long j = NumberInput.parseLong(textBuffer, textOffset, i2);
            if (this._numberNegative) {
                j = -j;
            }
            if (i2 == 10) {
                if (this._numberNegative) {
                    if (j >= -2147483648L) {
                        this._numberInt = (int) j;
                        this._numTypesValid = 1;
                        return;
                    }
                } else if (j <= 2147483647L) {
                    this._numberInt = (int) j;
                    this._numTypesValid = 1;
                    return;
                }
            }
            this._numberLong = j;
            this._numTypesValid = 2;
        } catch (NumberFormatException e) {
            throw new JsonParseException("Malformed numeric value '" + this._textBuffer.contentsAsString() + "'", getCurrentLocation(), e);
        }
    }

    private void reportOverflowInt() throws IOException {
        _reportError("Numeric value (" + getText() + ") out of range of int (-2147483648 - 2147483647)");
    }

    private void reportOverflowLong() throws IOException {
        _reportError("Numeric value (" + getText() + ") out of range of long (-9223372036854775808 - 9223372036854775807)");
    }

    @Override // com.openfeint.internal.vendor.org.codehaus.jackson.JsonParser
    public final double getDoubleValue() throws IOException {
        if ((this._numTypesValid & 8) == 0) {
            if (this._numTypesValid == 0) {
                parseNumericValue(8);
            }
            if ((this._numTypesValid & 8) == 0) {
                if ((this._numTypesValid & 16) != 0) {
                    this._numberDouble = this._numberBigDecimal.doubleValue();
                } else if ((this._numTypesValid & 4) != 0) {
                    this._numberDouble = this._numberBigInt.doubleValue();
                } else if ((this._numTypesValid & 2) != 0) {
                    this._numberDouble = this._numberLong;
                } else if ((this._numTypesValid & 1) != 0) {
                    this._numberDouble = this._numberInt;
                } else {
                    _throwInternal();
                }
                this._numTypesValid |= 8;
            }
        }
        return this._numberDouble;
    }

    @Override // com.openfeint.internal.vendor.org.codehaus.jackson.JsonParser
    public final float getFloatValue() throws IOException {
        return (float) getDoubleValue();
    }

    @Override // com.openfeint.internal.vendor.org.codehaus.jackson.JsonParser
    public final int getIntValue() throws IOException {
        if ((this._numTypesValid & 1) == 0) {
            if (this._numTypesValid == 0) {
                parseNumericValue(1);
            }
            if ((this._numTypesValid & 1) == 0) {
                if ((this._numTypesValid & 2) != 0) {
                    int i = (int) this._numberLong;
                    if (i != this._numberLong) {
                        _reportError("Numeric value (" + getText() + ") out of range of int");
                    }
                    this._numberInt = i;
                } else if ((this._numTypesValid & 4) != 0) {
                    this._numberInt = this._numberBigInt.intValue();
                } else if ((this._numTypesValid & 8) != 0) {
                    if (this._numberDouble < -2.147483648E9d || this._numberDouble > 2.147483647E9d) {
                        reportOverflowInt();
                    }
                    this._numberInt = (int) this._numberDouble;
                } else if ((this._numTypesValid & 16) != 0) {
                    if (BD_MIN_INT.compareTo(this._numberBigDecimal) > 0 || BD_MAX_INT.compareTo(this._numberBigDecimal) < 0) {
                        reportOverflowInt();
                    }
                    this._numberInt = this._numberBigDecimal.intValue();
                } else {
                    _throwInternal();
                }
                this._numTypesValid |= 1;
            }
        }
        return this._numberInt;
    }

    @Override // com.openfeint.internal.vendor.org.codehaus.jackson.JsonParser
    public final long getLongValue() throws IOException {
        if ((this._numTypesValid & 2) == 0) {
            if (this._numTypesValid == 0) {
                parseNumericValue(2);
            }
            if ((this._numTypesValid & 2) == 0) {
                if ((this._numTypesValid & 1) != 0) {
                    this._numberLong = this._numberInt;
                } else if ((this._numTypesValid & 4) != 0) {
                    this._numberLong = this._numberBigInt.longValue();
                } else if ((this._numTypesValid & 8) != 0) {
                    if (this._numberDouble < -9.223372036854776E18d || this._numberDouble > 9.223372036854776E18d) {
                        reportOverflowLong();
                    }
                    this._numberLong = (long) this._numberDouble;
                } else if ((this._numTypesValid & 16) != 0) {
                    if (BD_MIN_LONG.compareTo(this._numberBigDecimal) > 0 || BD_MAX_LONG.compareTo(this._numberBigDecimal) < 0) {
                        reportOverflowLong();
                    }
                    this._numberLong = this._numberBigDecimal.longValue();
                } else {
                    _throwInternal();
                }
                this._numTypesValid |= 2;
            }
        }
        return this._numberLong;
    }

    protected final void reportInvalidNumber(String str) throws JsonParseException {
        _reportError("Invalid numeric value: " + str);
    }

    protected final void reportUnexpectedNumberChar(int i, String str) throws JsonParseException {
        String str2 = "Unexpected character (" + _getCharDesc(i) + ") in numeric value";
        if (str != null) {
            str2 = str2 + ": " + str;
        }
        _reportError(str2);
    }

    protected final JsonToken reset(boolean z, int i, int i2, int i3) {
        this._numberNegative = z;
        this.mIntLength = i;
        this.mFractLength = i2;
        this.mExpLength = i3;
        this._numTypesValid = 0;
        return (i2 > 0 || i3 > 0) ? JsonToken.VALUE_NUMBER_FLOAT : JsonToken.VALUE_NUMBER_INT;
    }
}
