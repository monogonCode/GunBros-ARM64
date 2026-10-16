package com.glu.tools.tapjoy;

import android.content.Context;
import android.view.View;
import android.view.ViewGroup;
import android.view.WindowManager;
import android.widget.LinearLayout;
import com.glu.platform.android.GluPlatformActivity;
import com.tapjoy.TapjoyConnect;
import com.tapjoy.TapjoyDisplayAdNotifier;
import com.tapjoy.TapjoyFeaturedAppNotifier;
import com.tapjoy.TapjoyFeaturedAppObject;
import com.tapjoy.TapjoyLog;
import com.tapjoy.TapjoyNotifier;
import com.tapjoy.TapjoySpendPointsNotifier;

/* JADX INFO: loaded from: classes.dex */
public final class TapjoyInterface implements TapjoyDisplayAdNotifier, TapjoyFeaturedAppNotifier, TapjoyNotifier, TapjoySpendPointsNotifier {
    private static final String TAPJOY_INTERFACE = "TapjoyInterface";
    private static TapjoyInterface THIS = new TapjoyInterface();
    private static GluPlatformActivity usedActivity = null;
    private static boolean featuredAppQueryInProgress = false;
    private static TapjoyFeaturedAppObject featuredAppInfo = null;
    private static boolean showFeaturedAppView = false;
    private static int POINTS_EXCHANGE_RATE = 1;
    private static int remainingPointTotal = 0;
    private static int lastTapjoyPointTotal = 0;
    private static int previousConsumedThisSession = 0;
    private static boolean isRemainingTapjoyPointsBeingGot = false;
    private static boolean isBannerRequested = false;
    private static boolean isBannerBeingShown = false;
    private static int retrySeveralTimes = 0;
    private static int bannerPos = 0;
    private static int bannerX = 0;
    private static int bannerY = 0;
    private static View bannerView = null;
    private static LinearLayout bannerLayout = null;
    private static int adCount = 0;
    private static int adCount2 = 0;

    /* JADX INFO: Access modifiers changed from: private */
    public static synchronized void TryToHideBanner() {
        if (bannerLayout != null) {
            bannerLayout.setVisibility(4);
            TapjoyLog.d(TAPJOY_INTERFACE, "Banner has been hidden");
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static synchronized void TryToRestoreShownBanner() {
        if (isBannerRequested && bannerLayout != null && !isBannerBeingShown) {
            bannerLayout.setVisibility(0);
            isBannerBeingShown = true;
            TapjoyLog.d(TAPJOY_INTERFACE, "Banner has been shown (or rather, restored)");
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static synchronized void TryToShowBanner() {
        int i;
        int i2;
        int i3;
        int i4;
        int i5 = 0;
        synchronized (TapjoyInterface.class) {
            if (isBannerBeingShown && bannerView != null) {
                TapjoyLog.d(TAPJOY_INTERFACE, "Display banner");
                int i6 = bannerView.getLayoutParams().width;
                int i7 = bannerView.getLayoutParams().height;
                TapjoyLog.d(TAPJOY_INTERFACE, "Banner dimensions: " + i6 + " x " + i7);
                WindowManager windowManager = (WindowManager) usedActivity.getSystemService("window");
                int width = windowManager.getDefaultDisplay().getWidth();
                int height = windowManager.getDefaultDisplay().getHeight();
                TapjoyLog.d(TAPJOY_INTERFACE, "Screen dimensions: " + width + " x " + height);
                if (i6 > width) {
                    i = (width * i7) / i6;
                    i2 = width;
                } else {
                    i = i7;
                    i2 = i6;
                }
                if (i > height) {
                    i3 = height;
                    i4 = (i2 * height) / i;
                } else {
                    i3 = i;
                    i4 = i2;
                }
                bannerView.setLayoutParams(new ViewGroup.LayoutParams(i4, i3));
                LinearLayout linearLayout = new LinearLayout(usedActivity);
                linearLayout.setLayoutParams(new ViewGroup.LayoutParams(width, height));
                TapjoyLog.d(TAPJOY_INTERFACE, "bannerPos: " + bannerPos);
                boolean z = bannerPos == 0;
                boolean z2 = (bannerPos & 1) > 0 && (bannerPos & 2) == 0;
                boolean z3 = (bannerPos & 1) > 0 && (bannerPos & 2) > 0;
                boolean z4 = (bannerPos & 8) > 0 && (bannerPos & 4) == 0;
                boolean z5 = (bannerPos & 8) > 0 && (bannerPos & 4) > 0;
                boolean z6 = (bannerPos & 16) > 0 && (bannerPos & 15) == 0;
                int i8 = bannerX;
                int i9 = bannerY;
                if (z || z2 || z3 || z4 || z5) {
                    i8 = (width - i4) / 2;
                    i9 = (height - i3) / 2;
                }
                if (z2 && !z3) {
                    i9 = 0;
                }
                if (z3 && !z2) {
                    i9 = height - i3;
                    i8 = 0;
                }
                if (z4 && !z5) {
                    i8 = width - i4;
                }
                if (z5 && !z4) {
                    i8 = 0;
                }
                if (z6) {
                    i9 = 0;
                } else {
                    i5 = i8;
                }
                linearLayout.setPadding(i5, i9, 0, 0);
                linearLayout.addView(bannerView);
                if (bannerLayout != null) {
                    bannerLayout.setVisibility(8);
                    bannerLayout = null;
                }
                bannerLayout = linearLayout;
                try {
                    usedActivity.getWindow().addContentView(bannerLayout, new ViewGroup.LayoutParams(width, height));
                } catch (Exception e) {
                    TapjoyLog.d(TAPJOY_INTERFACE, "Cannot display banner, error: " + e.getMessage());
                }
                bannerLayout.setVisibility(0);
                TapjoyLog.d(TAPJOY_INTERFACE, "Banner has been shown");
            }
        }
    }

    public static synchronized boolean canDisplayInterface() {
        return TapjoyConnect.getTapjoyConnectInstance() != null;
    }

    public static synchronized void clearGetPointsData() {
        lastTapjoyPointTotal = 0;
    }

    public static synchronized void closeTapjoyInterface() {
    }

    public static synchronized boolean consumeTapjoyPoints(int i) {
        boolean z;
        TapjoyConnect tapjoyConnectInstance = TapjoyConnect.getTapjoyConnectInstance();
        if (tapjoyConnectInstance == null || i < 0 || remainingPointTotal < i) {
            z = false;
        } else {
            tapjoyConnectInstance.spendTapPoints(i, THIS);
            previousConsumedThisSession = i;
            z = true;
        }
        return z;
    }

    public static synchronized int convertPointsToGameCurrency(int i) {
        return POINTS_EXCHANGE_RATE * i;
    }

    public static synchronized void debugGivePoints(int i) {
        remainingPointTotal += i;
    }

    public static synchronized void destroy() {
    }

    public static synchronized int getExchangeRate() {
        return POINTS_EXCHANGE_RATE;
    }

    public static synchronized TapjoyFeaturedAppObject getFeaturedApp() {
        return featuredAppInfo;
    }

    public static synchronized boolean getFeaturedAppQueryState() {
        return featuredAppQueryInProgress;
    }

    public static synchronized int getLastTapjoyPointTotal() {
        TapjoyConnect tapjoyConnectInstance = TapjoyConnect.getTapjoyConnectInstance();
        if (tapjoyConnectInstance != null) {
            tapjoyConnectInstance.getTapPoints(THIS);
        }
        return lastTapjoyPointTotal;
    }

    public static synchronized int getPreviousConsumedThisSession() {
        return previousConsumedThisSession;
    }

    public static synchronized int getRemainingTapjoyPoints() {
        TapjoyConnect tapjoyConnectInstance;
        if (!isRemainingTapjoyPointsBeingGot && (tapjoyConnectInstance = TapjoyConnect.getTapjoyConnectInstance()) != null) {
            tapjoyConnectInstance.getTapPoints(THIS);
            isRemainingTapjoyPointsBeingGot = true;
        }
        return remainingPointTotal;
    }

    public static synchronized void hideAd() {
        isBannerRequested = false;
        if (isBannerBeingShown) {
            isBannerBeingShown = false;
            bannerView = null;
            usedActivity.getHandler().post(new Runnable() { // from class: com.glu.tools.tapjoy.TapjoyInterface.2
                @Override // java.lang.Runnable
                public final void run() {
                    TapjoyInterface.TryToHideBanner();
                }
            });
        }
    }

    public static synchronized void initialize(Context context, String str, String str2) {
        usedActivity = (GluPlatformActivity) context;
        TapjoyConnect.requestTapjoyConnect(context, str, str2);
    }

    public static synchronized boolean interfaceIsOpen() {
        return false;
    }

    public static synchronized boolean isVisible() {
        return isBannerBeingShown;
    }

    public static synchronized void onresume() {
        TapjoyConnect tapjoyConnectInstance = TapjoyConnect.getTapjoyConnectInstance();
        if (tapjoyConnectInstance != null) {
            tapjoyConnectInstance.getTapPoints(THIS);
        }
    }

    public static synchronized void openTapjoyInterface() {
        TapjoyConnect tapjoyConnectInstance = TapjoyConnect.getTapjoyConnectInstance();
        if (tapjoyConnectInstance != null) {
            tapjoyConnectInstance.showOffers();
        }
    }

    public static synchronized void queryFeaturedApp() {
        TapjoyConnect tapjoyConnectInstance = TapjoyConnect.getTapjoyConnectInstance();
        if (tapjoyConnectInstance != null) {
            tapjoyConnectInstance.getFeaturedApp(THIS);
            featuredAppQueryInProgress = true;
        }
    }

    public static synchronized void resetFeaturedApp() {
        featuredAppInfo = null;
        featuredAppQueryInProgress = false;
    }

    public static synchronized int sendSubscribeComplete() {
        TapjoyLog.d(TAPJOY_INTERFACE, "sendSubscribeComplete(): 4f9ddcd4-ad1a-499c-8042-749f99347f5f");
        TapjoyConnect.getTapjoyConnectInstance().actionComplete(TapjoyConnect.TAPJOY_ACTION_SUBSCRIBE);
        return 1;
    }

    public static synchronized void showAd(int i, int i2, int i3) {
        TapjoyConnect tapjoyConnectInstance = TapjoyConnect.getTapjoyConnectInstance();
        if (tapjoyConnectInstance != null) {
            bannerPos = i;
            bannerX = i2;
            bannerY = i3;
            retrySeveralTimes = 1;
            if (!isBannerRequested) {
                isBannerRequested = true;
                tapjoyConnectInstance.getDisplayAd(THIS);
                TapjoyLog.d(TAPJOY_INTERFACE, "showAd requested to display ad");
                if (!isBannerBeingShown) {
                    usedActivity.getHandler().post(new Runnable() { // from class: com.glu.tools.tapjoy.TapjoyInterface.1
                        @Override // java.lang.Runnable
                        public final void run() {
                            TapjoyInterface.TryToRestoreShownBanner();
                        }
                    });
                }
            }
        }
    }

    public static synchronized void tick(int i) {
    }

    @Override // com.tapjoy.TapjoyDisplayAdNotifier
    public final synchronized void getDisplayAdResponse(View view) {
        TapjoyLog.d(TAPJOY_INTERFACE, "getDisplayAd succeeded");
        if (isBannerRequested) {
            bannerView = view;
            isBannerBeingShown = true;
            usedActivity.getHandler().post(new Runnable() { // from class: com.glu.tools.tapjoy.TapjoyInterface.3
                @Override // java.lang.Runnable
                public final void run() {
                    TapjoyInterface.TryToShowBanner();
                }
            });
        }
    }

    @Override // com.tapjoy.TapjoyDisplayAdNotifier
    public final synchronized void getDisplayAdResponseFailed(String str) {
        TapjoyLog.d(TAPJOY_INTERFACE, "getDisplayAd failed, error: " + str);
        if (isBannerRequested) {
            if (retrySeveralTimes > 0) {
                TapjoyLog.d(TAPJOY_INTERFACE, "getDisplayAd will be retried up to " + retrySeveralTimes + " times.");
                retrySeveralTimes--;
                TapjoyConnect.getTapjoyConnectInstance().getDisplayAd(this);
            } else {
                isBannerRequested = false;
            }
        }
    }

    @Override // com.tapjoy.TapjoyFeaturedAppNotifier
    public final synchronized void getFeaturedAppResponse(TapjoyFeaturedAppObject tapjoyFeaturedAppObject) {
        TapjoyLog.d(TAPJOY_INTERFACE, "getFeaturedAppResponse succeeded");
        featuredAppInfo = tapjoyFeaturedAppObject;
        featuredAppQueryInProgress = false;
        showFeaturedAppView = true;
    }

    @Override // com.tapjoy.TapjoyFeaturedAppNotifier
    public final synchronized void getFeaturedAppResponseFailed(String str) {
        TapjoyLog.d(TAPJOY_INTERFACE, "getFeaturedAppResponse failed, error " + str);
        featuredAppInfo = null;
        featuredAppQueryInProgress = false;
    }

    @Override // com.tapjoy.TapjoySpendPointsNotifier
    public final synchronized void getSpendPointsResponse(String str, int i) {
        TapjoyLog.d(TAPJOY_INTERFACE, "spendTapPoints succeeded, currencyName: " + str + ", pointTotal: " + i);
        if (lastTapjoyPointTotal > i) {
            int i2 = remainingPointTotal - (lastTapjoyPointTotal - i);
            remainingPointTotal = i2;
            if (i2 < 0) {
                remainingPointTotal = 0;
            }
            lastTapjoyPointTotal = i;
        }
    }

    @Override // com.tapjoy.TapjoySpendPointsNotifier
    public final synchronized void getSpendPointsResponseFailed(String str) {
        TapjoyLog.d(TAPJOY_INTERFACE, "spendTapPoints failed, error: " + str);
    }

    @Override // com.tapjoy.TapjoyNotifier
    public final synchronized void getUpdatePoints(String str, int i) {
        TapjoyLog.d(TAPJOY_INTERFACE, "getTapPoints succeeded, currencyName: " + str + ", pointTotal: " + i);
        if (i > lastTapjoyPointTotal) {
            remainingPointTotal += i - lastTapjoyPointTotal;
            lastTapjoyPointTotal = i;
        }
        isRemainingTapjoyPointsBeingGot = false;
    }

    @Override // com.tapjoy.TapjoyNotifier
    public final synchronized void getUpdatePointsFailed(String str) {
        TapjoyLog.d(TAPJOY_INTERFACE, "getTapPoints failed, error: " + str);
        isRemainingTapjoyPointsBeingGot = false;
    }
}
