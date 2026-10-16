package com.glu.platform.android.resdl;

import android.app.Activity;

/* JADX INFO: loaded from: classes.dex */
public class ResDLNativeCallback extends Activity {
    public static int resdlEvent(int i, int i2, byte[] bArr) {
        return (i == 2 && GluUtil.isResourceFile(new String(bArr))) ? 1 : 0;
    }

    public static byte[] resdlStringEvent(int i, int i2, byte[] bArr) {
        String resourceFilePath = i == 1 ? ResDL.getResourceFilePath() : null;
        if (resourceFilePath == null) {
            return null;
        }
        return GluUtil.stringToNativeByteArray(resourceFilePath);
    }
}
