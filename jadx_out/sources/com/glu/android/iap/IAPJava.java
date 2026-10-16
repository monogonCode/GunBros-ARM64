package com.glu.android.iap;

import android.app.Activity;
import com.glu.googleiap.Security;

/* JADX INFO: loaded from: classes.dex */
public class IAPJava {
    public static final int ANDROID_OS_1_0 = 1;
    public static final int ANDROID_OS_1_1 = 2;
    public static final int ANDROID_OS_1_5 = 3;
    public static final int ANDROID_OS_1_6 = 4;
    public static final int ANDROID_OS_2_0 = 5;
    public static final int ANDROID_OS_2_0_1 = 6;
    public static final int ANDROID_OS_2_1 = 7;
    public static final int ANDROID_OS_2_2 = 8;
    public static final int ANDROID_OS_2_3 = 9;
    public static final int ANDROID_OS_2_3_3 = 10;
    public static final int ANDROID_OS_3_0 = 11;
    public static final int ANDROID_OS_3_1 = 12;
    public static Activity m_activity;

    public static native int iapCallbackEvent(int i, int i2, byte[] bArr);

    public static int iapCallbackEventS(int i, int i2, String str) {
        String str2 = "iapCallbackEvent - " + i + ", param - " + str;
        Debug.log$552c4e01();
        if (str == null) {
            return iapCallbackEvent(i, i2, null);
        }
        char[] charArray = str.toCharArray();
        byte[] bArr = new byte[charArray.length + 1];
        for (int i3 = 0; i3 < charArray.length; i3++) {
            bArr[i3] = (byte) charArray[i3];
        }
        bArr[charArray.length] = 0;
        return iapCallbackEvent(i, i2, bArr);
    }

    public static void iapDestroy() {
        IAP.destroyIAPInstance();
    }

    public static int iapEvent(int i, int i2, byte[] bArr) {
        String strTrim = bArr != null ? new String(bArr).trim() : null;
        if (i != 6 && i != 17 && i != 1 && i != 20) {
            String str = "Entering IAPJava.iapEvent(" + IAP.eventToString(i) + ", " + i2 + ", " + strTrim + ") m_activity - " + m_activity.toString();
            Debug.log$552c4e01();
        }
        if (i == 1) {
            return IAP.isIAPSupported() ? 1 : 0;
        }
        if (i == 20) {
            return !IAP.isSubscriptionSupported() ? 0 : 1;
        }
        if (i != 18) {
            if (IAP.instance == null) {
                if (i == 4) {
                    IAP.createIAPInstance();
                    IAP.instance.init();
                }
                return 0;
            }
            if (i == 2) {
                IAP.instance.buyProduct(strTrim);
            } else if (i == 3) {
                IAP.instance.restoreUnclaimedItems();
            } else if (i == 4) {
                IAP.createIAPInstance();
                IAP.instance.init();
            } else {
                if (i == 5) {
                    return IAP.getTransactionState();
                }
                if (i == 6) {
                    IAP.instance.tick(i2);
                } else {
                    if (i == 7) {
                        return IAP.instance.getProductType(strTrim);
                    }
                    if (i == 8) {
                        return !IAP.instance.isProductValid(strTrim) ? 0 : 1;
                    }
                    if (i == 9) {
                        IAP.doesIAPHaveButton();
                        return 0;
                    }
                    if (i == 10) {
                        IAP.instance.setButtonCenterXY(i2);
                    } else if (i == 11) {
                        IAP.instance.setButtonVisible(i2);
                    } else {
                        if (i == 12) {
                            return !IAP.instance.isIAPConnected() ? 0 : 1;
                        }
                        if (i == 13) {
                            IAP.instance.querySingleProduct(strTrim);
                        } else {
                            if (i == 14) {
                                return !IAP.nativeIsItemSupported(strTrim) ? 0 : 1;
                            }
                            if (i == 15) {
                                return !IAP.hasInventoryLoaded() ? 0 : 1;
                            }
                            if (i == 16) {
                                return !IAP.isGoogleServiceConnected() ? 0 : 1;
                            }
                            if (i == 17) {
                                IAP.instance.forceAsynchronousPurchaseAward();
                            } else if (i == 19) {
                                Security.BASE64_ENCODED_PUBLIC_KEY = strTrim;
                            }
                        }
                    }
                }
            }
        }
        return 0;
    }
}
