package com.urbanairship.iap;

/* JADX INFO: loaded from: classes.dex */
public final class IAPManager {
    private static final IAPManager instance = new IAPManager();

    private IAPManager() {
    }

    public static void init() {
    }

    public static IAPManager shared() {
        return instance;
    }

    public static void tearDown() {
    }

    public static void validateManifest() {
    }
}
