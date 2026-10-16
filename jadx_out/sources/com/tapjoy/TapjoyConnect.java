package com.tapjoy;

import android.content.Context;
import android.util.Log;

/* JADX INFO: loaded from: classes.dex */
public final class TapjoyConnect {
    public static final String TAPJOY_ACTION_SUBSCRIBE = "4f9ddcd4-ad1a-499c-8042-749f99347f5f";
    public static final String TAPJOY_CONNECT = "TapjoyConnect";
    private static TapjoyConnect tapjoyConnectInstance = null;
    private static TJCOffers tapjoyOffers = null;
    private static TapjoyFeaturedApp tapjoyFeaturedApp = null;
    private static TapjoyDisplayAd tapjoyDisplayAd = null;
    private static TapjoyVideo tapjoyVideo = null;

    private TapjoyConnect(Context context, String str, String str2) {
        TapjoyConnectCore.requestTapjoyConnect(context, str, str2);
    }

    public static TapjoyConnect getTapjoyConnectInstance() {
        if (tapjoyConnectInstance == null) {
            Log.e("TapjoyConnect", "----------------------------------------");
            Log.e("TapjoyConnect", "ERROR -- call requestTapjoyConnect before any other Tapjoy methods");
            Log.e("TapjoyConnect", "----------------------------------------");
        }
        return tapjoyConnectInstance;
    }

    public static void requestTapjoyConnect(Context context, String str, String str2) {
        tapjoyConnectInstance = new TapjoyConnect(context, str, str2);
        tapjoyOffers = new TJCOffers(context);
        tapjoyFeaturedApp = new TapjoyFeaturedApp(context);
        tapjoyDisplayAd = new TapjoyDisplayAd(context);
        tapjoyVideo = new TapjoyVideo(context);
    }

    public final void actionComplete(String str) {
        TapjoyConnectCore.getInstance().actionComplete(str);
    }

    public final void awardTapPoints(int i, TapjoyAwardPointsNotifier tapjoyAwardPointsNotifier) {
        tapjoyOffers.awardTapPoints(i, tapjoyAwardPointsNotifier);
    }

    public final void enablePaidAppWithActionID(String str) {
        TapjoyConnectCore.getInstance().enablePaidAppWithActionID(str);
    }

    public final String getAppID() {
        return TapjoyConnectCore.getAppID();
    }

    public final float getCurrencyMultiplier() {
        return TapjoyConnectCore.getInstance().getCurrencyMultiplier();
    }

    public final void getDisplayAd(TapjoyDisplayAdNotifier tapjoyDisplayAdNotifier) {
        tapjoyDisplayAd.getDisplayAd(tapjoyDisplayAdNotifier);
    }

    public final void getDisplayAdWithCurrencyID(String str, TapjoyDisplayAdNotifier tapjoyDisplayAdNotifier) {
        tapjoyDisplayAd.getDisplayAd(str, tapjoyDisplayAdNotifier);
    }

    public final void getFeaturedApp(TapjoyFeaturedAppNotifier tapjoyFeaturedAppNotifier) {
        tapjoyFeaturedApp.getFeaturedApp(tapjoyFeaturedAppNotifier);
    }

    public final void getFeaturedAppWithCurrencyID(String str, TapjoyFeaturedAppNotifier tapjoyFeaturedAppNotifier) {
        tapjoyFeaturedApp.getFeaturedApp(str, tapjoyFeaturedAppNotifier);
    }

    public final void getTapPoints(TapjoyNotifier tapjoyNotifier) {
        tapjoyOffers.getTapPoints(tapjoyNotifier);
    }

    public final String getUserID() {
        return TapjoyConnectCore.getUserID();
    }

    public final void initVideoAd(TapjoyVideoNotifier tapjoyVideoNotifier) {
        tapjoyVideo.initVideoAd(tapjoyVideoNotifier);
    }

    public final void setBannerAdSize(String str) {
        tapjoyDisplayAd.setBannerAdSize(str);
    }

    public final void setCurrencyMultiplier(float f) {
        TapjoyConnectCore.getInstance().setCurrencyMultiplier(f);
    }

    public final void setEarnedPointsNotifier(TapjoyEarnedPointsNotifier tapjoyEarnedPointsNotifier) {
        tapjoyOffers.setEarnedPointsNotifier(tapjoyEarnedPointsNotifier);
    }

    public final void setFeaturedAppDisplayCount(int i) {
        tapjoyFeaturedApp.setDisplayCount(i);
    }

    public final void setUserID(String str) {
        TapjoyConnectCore.setUserID(str);
    }

    public final void setVideoCacheCount(int i) {
        tapjoyVideo.setVideoCacheCount(i);
    }

    public final void showFeaturedAppFullScreenAd() {
        tapjoyFeaturedApp.showFeaturedAppFullScreenAd();
    }

    public final void showOffers() {
        tapjoyOffers.showOffers();
    }

    public final void showOffersWithCurrencyID(String str, boolean z) {
        tapjoyOffers.showOffersWithCurrencyID(str, z);
    }

    public final void spendTapPoints(int i, TapjoySpendPointsNotifier tapjoySpendPointsNotifier) {
        tapjoyOffers.spendTapPoints(i, tapjoySpendPointsNotifier);
    }
}
