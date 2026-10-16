package com.glu.platform.android;

import android.media.AudioTrack;

/* JADX INFO: loaded from: classes.dex */
final class DeviceTrack extends AudioTrack {
    public int frameSize;

    @Override // android.media.AudioTrack
    public final void play() throws IllegalStateException {
        super.play();
        byte[] bArr = new byte[getNativeFrameCount() * this.frameSize];
        write(bArr, 0, bArr.length);
        String str = "initial audio data length=" + bArr.length;
    }
}
