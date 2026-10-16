package com.glu.platform.gwallet;

import android.content.Context;

/* JADX INFO: loaded from: classes.dex */
public class GWallet {

    private static class InstanceHolder {
        public static GWallet instance = new GWallet();

        private InstanceHolder() {
        }
    }

    static {
        try {
            System.loadLibrary("gwallet");
        } catch (UnsatisfiedLinkError e) {
        }
    }

    /* synthetic */ GWallet() {
        this((byte) 0);
    }

    private GWallet(byte b) {
    }

    private native int addCurrency(int i);

    private native int create(byte[] bArr, Object obj);

    private native void destroy(int i);

    private native int getBalance();

    public static GWallet getInstance() {
        return InstanceHolder.instance;
    }

    private native void handleupdate(Context context, long j);

    private native void initialise(Context context, String str, String str2, String str3, String str4);

    private native void pause(int i);

    private native void restart(int i);

    private native void resume(int i);

    private native void start(int i);

    private native void stop(int i);

    private native int subscribeWithReceipt(String str, Object obj);

    private native int subtractCurrency(int i);

    private native void uninitialise();

    public int doAddCurrency(int i) {
        return addCurrency(i);
    }

    public int doGetBalance() {
        return getBalance();
    }

    public int doSubscribe(String str, Object obj) {
        return subscribeWithReceipt(str, obj);
    }

    public int doSubtractCurrency(int i) {
        return subtractCurrency(i);
    }

    public int onCreate(byte[] bArr, Object obj) {
        return create(bArr, obj);
    }

    public void onDestroy(int i) {
        destroy(i);
    }

    public void onHandleUpdate(Context context, long j) {
        handleupdate(context, j);
    }

    public void onInitialise(Context context, String str, String str2, String str3, String str4) {
        initialise(context, str, str2, str3, str4);
    }

    public void onPause(int i) {
        pause(i);
    }

    public void onResume(int i) {
        resume(i);
    }

    public void onStart(int i) {
        start(i);
    }

    public void onStop(int i) {
        stop(i);
    }

    public void onUninitialise() {
        uninitialise();
    }
}
