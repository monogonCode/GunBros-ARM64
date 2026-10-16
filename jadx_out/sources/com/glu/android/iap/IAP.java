package com.glu.android.iap;

import android.content.Context;
import android.graphics.Canvas;
import android.graphics.Paint;
import android.graphics.Rect;
import android.graphics.RectF;
import android.view.View;
import com.glu.platform.android.facebook.GluFBConnect;
import java.util.Enumeration;
import java.util.Hashtable;

/* JADX INFO: loaded from: classes.dex */
public final class IAP {
    public static IAPObject instance = null;
    public static final Hashtable<String, Long> IAP_PROVIDER_MASKS = new SettingsHash();
    public static int sm_transactionState = -1;
    public static Hashtable<String, String> m_realToNativeProductIdHash = new Hashtable<>();
    private static Thread m_getDataFromServerThread = null;
    private static String JSON_PROPERTY_GAME = "game";
    private static String JSON_PROPERTY_MARKET = "market";
    private static String JSON_PROPERTY_PRODUCTS = "products";
    private static String JSON_PROPERTY_PRODUCTS_PRODUCT = "product";
    private static String JSON_PROPERTY_PRODUCTS_PRICE = "price_us";
    private static String JSON_PROPERTY_PRODUCTS_NAME = "name";

    public interface IAPObject {
        void buyProduct(String str);

        boolean forceAsynchronousPurchaseAward();

        int getIAPId();

        int getProductType(String str);

        String getRealProductId(String str);

        boolean hasInventoryLoaded();

        void init();

        boolean isGoogleServiceConnected();

        boolean isIAPConnected();

        boolean isIAPSupported();

        boolean isItemAvailable(String str);

        boolean isProductValid(String str);

        boolean isSubscriptionSupported();

        void onIAPDestroy();

        void querySingleProduct(String str);

        void restoreUnclaimedItems();

        void setButtonCenterXY(int i);

        void setButtonVisible(int i);

        void tick(int i);
    }

    public static class IAPView extends View {
        private int BUTTON_BOTTOM_MARGIN;
        private int BUTTON_CENTER_MARGIN;
        private int BUTTON_HEIGHT;
        private int BUTTON_WIDTH;
        private int DIALOG_HEIGHT;
        private int DIALOG_WIDTH;
        private int FONT_SIZE;
        private int ROUND_RECT_STROKE_WIDTH;
        private Rect m_buttonNegativeRectBounds;
        private Rect m_buttonNeutralRectBounds;
        private Rect m_buttonPositiveRectBounds;
        private int m_dialogTimer;
        private int m_dialogType;
        private RectF m_innerRectBounds;
        private long m_lastTickTime;
        private RectF m_outerRectBounds;
        private Paint m_roundRectInnerPaint;
        private Paint m_roundRectOuterPaint;
        private int m_subviewMask;
        private Rect[] m_subviewRects;
        private Paint m_textPaint;

        /* JADX WARN: 'super' call moved to the top of the method (can break code semantics) */
        public IAPView(Context context) {
            super(context);
            this.FONT_SIZE = 18;
            this.ROUND_RECT_STROKE_WIDTH = 6;
            this.DIALOG_WIDTH = 280;
            this.DIALOG_HEIGHT = 150;
            this.BUTTON_WIDTH = 60;
            this.BUTTON_HEIGHT = 40;
            this.BUTTON_BOTTOM_MARGIN = 12;
            this.BUTTON_CENTER_MARGIN = 24;
            this.m_textPaint = null;
            this.m_roundRectOuterPaint = null;
            this.m_roundRectInnerPaint = null;
            this.m_dialogTimer = 0;
            this.m_lastTickTime = 0L;
            this.m_innerRectBounds = new RectF();
            this.m_outerRectBounds = new RectF();
            this.m_buttonPositiveRectBounds = new Rect();
            this.m_buttonNegativeRectBounds = new Rect();
            this.m_buttonNeutralRectBounds = new Rect();
            this.m_dialogType = 0;
            this.m_subviewMask = 0;
            this.m_subviewRects = new Rect[2];
            for (int i = 0; i < this.m_subviewRects.length; i++) {
                this.m_subviewRects[i] = new Rect(-1, -1, -1, -1);
            }
            this.m_textPaint = new Paint();
            this.m_textPaint.setAntiAlias(true);
            this.m_textPaint.setFilterBitmap(true);
            this.m_textPaint.setTextSize(this.FONT_SIZE);
            this.m_textPaint.setColor(-1056964609);
            this.m_textPaint.setTextAlign(Paint.Align.CENTER);
            this.m_textPaint.setFakeBoldText(true);
            this.m_roundRectOuterPaint = new Paint();
            this.m_roundRectOuterPaint.setAntiAlias(true);
            this.m_roundRectOuterPaint.setStrokeWidth(this.ROUND_RECT_STROKE_WIDTH);
            this.m_roundRectOuterPaint.setColor(-1071931336);
            this.m_roundRectInnerPaint = new Paint();
            this.m_roundRectInnerPaint.setAntiAlias(true);
            this.m_roundRectInnerPaint.setStrokeWidth(this.ROUND_RECT_STROKE_WIDTH);
            this.m_roundRectInnerPaint.setColor(-1070858407);
        }

        @Override // android.view.View
        public void onDraw(Canvas canvas) {
        }

        @Override // android.view.View
        public void onWindowVisibilityChanged(int i) {
            super.onWindowVisibilityChanged(i);
            if (i == 4) {
                this.m_dialogTimer = 0;
            } else if (i == 0) {
                this.m_lastTickTime = System.currentTimeMillis();
            }
        }

        public void setSubviewBounds(int i, int i2, int i3, int i4, int i5) {
            this.m_subviewRects[i].left = i2;
            this.m_subviewRects[i].top = i3;
            this.m_subviewRects[i].right = i4;
            this.m_subviewRects[i].bottom = i5;
        }

        public void setSubviewVisible(int i, boolean z) {
            if (z) {
                this.m_subviewMask |= 1 << i;
            } else {
                this.m_subviewMask &= (1 << i) ^ (-1);
                setSubviewBounds(i, -1, -1, -1, -1);
            }
        }
    }

    public static class SettingsHash<K, V> extends Hashtable<K, V> {
    }

    public static void createIAPInstance() {
        instance = null;
        sm_transactionState = -1;
        Debug.log$552c4e01();
        instance = new GluGoogleIAP(null);
        Enumeration<String> enumerationKeys = IAP_PROVIDER_MASKS.keys();
        while (enumerationKeys.hasMoreElements()) {
            initSingleProduct(enumerationKeys.nextElement());
        }
    }

    public static void destroyIAPInstance() {
        sm_transactionState = -1;
        if (instance != null) {
            instance.onIAPDestroy();
        }
        instance = null;
        GluGoogleIAP.instance = null;
        m_getDataFromServerThread = null;
    }

    public static void displayAsyncFailureMessage() {
    }

    public static void displayAsyncSuccessMessage() {
    }

    public static boolean doesIAPHaveButton() {
        return false;
    }

    public static String eventToString(int i) {
        switch (i) {
            case 1:
                return "IAP_EVENT_IS_IAP_SUPPORTED";
            case 2:
                return "IAP_EVENT_BUY_PRODUCT";
            case 3:
                return "IAP_EVENT_RESTORE_UNCLAIMED_ITEMS";
            case 4:
                return "IAP_EVENT_INIT";
            case 5:
                return "IAP_EVENT_GET_TRANSACTION_STATE";
            case 6:
                return "IAP_EVENT_TICK";
            case 7:
                return "IAP_EVENT_GET_PRODUCT_TYPE";
            case 8:
                return "IAP_EVENT_IS_PRODUCT_VALID";
            case 9:
                return "IAP_EVENT_DOES_IAP_HAVE_BUTTON";
            case 10:
                return "IAP_EVENT_SET_BUTTON_CENTER_XY";
            case 11:
                return "IAP_EVENT_SET_BUTTON_VISIBLE";
            case 12:
                return "IAP_EVENT_IS_IAP_CONNECTED";
            case 13:
                return "IAP_EVENT_QUERY_SINGLE_PRODUCT";
            case 14:
                return "IAP_EVENT_IS_ITEM_SUPPORTED";
            case GluFBConnect.FACEBOOK_EVENT_QUEUE_FRIEND_IMAGE_URL /* 18 */:
                return "IAP_EVENT_REQUEST_PRODUCT_DATA";
            case GluFBConnect.FACEBOOK_EVENT_SUBMIT_QUEUED_FRIEND_FEED /* 19 */:
                return "IAP_EVENT_INIT_PUBLIC_KEY";
            case GluFBConnect.FACEBOOK_EVENT_REQUEST_FRIEND_NAME_FROM_UID /* 20 */:
                return "IAP_EVENT_IS_SUBS_SUPPORTED";
            case 101:
                return "IAP_EVENT_REQUEST_ITEM_REAL_PRODUCT_ID";
            case 102:
                return "IAP_EVENT_REQUEST_ITEM_PRODUCT_NAME";
            case 103:
                return "IAP_EVENT_REQUEST_ITEM_PRODUCT_DESCRIPTION";
            case 104:
                return "IAP_EVENT_REQUEST_ITEM_PRODUCT_PRICE";
            case 105:
                return "IAP_EVENT_REQUEST_ITEM_CURRENCY_SYMBOL";
            default:
                return "UNKNOWN (" + i + ")";
        }
    }

    public static final String getCurrencySymbol$7157d249() {
        return "$";
    }

    public static int getTransactionState() {
        return sm_transactionState;
    }

    public static boolean hasInventoryLoaded() {
        if (instance == null) {
            return false;
        }
        return instance.hasInventoryLoaded();
    }

    public static void initSingleProduct(String str) {
        String realProductId = instance.getRealProductId(str);
        m_realToNativeProductIdHash.put(realProductId, str);
        String str2 = "added... " + realProductId + " / " + m_realToNativeProductIdHash.get(realProductId) + " ...to hash";
        Debug.log$552c4e01();
    }

    public static boolean isGoogleServiceConnected() {
        if (instance != null) {
            return instance.isGoogleServiceConnected();
        }
        return false;
    }

    public static boolean isIAPSupported() {
        if (instance == null) {
            return false;
        }
        return instance.isIAPSupported();
    }

    public static boolean isSubscriptionSupported() {
        if (instance == null) {
            return false;
        }
        return instance.isSubscriptionSupported();
    }

    public static boolean nativeIsItemSupported(String str) {
        IAPObject iAPObject = instance;
        if (str == null) {
            return false;
        }
        Long l = IAP_PROVIDER_MASKS.get(str);
        if (l == null || iAPObject == null) {
            return false;
        }
        boolean z = (((long) iAPObject.getIAPId()) & l.longValue()) != 0;
        return z ? iAPObject.isItemAvailable(str) : z;
    }
}
