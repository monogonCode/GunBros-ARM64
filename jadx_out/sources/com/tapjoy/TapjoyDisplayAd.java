package com.tapjoy;

import android.content.Context;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.drawable.BitmapDrawable;
import android.net.Uri;
import android.view.View;
import android.view.ViewGroup;
import android.view.WindowManager;
import com.glu.platform.android.GluPlatformActivity;
import java.io.ByteArrayInputStream;
import javax.xml.parsers.DocumentBuilderFactory;
import org.w3c.dom.Document;

/* JADX INFO: loaded from: classes.dex */
public class TapjoyDisplayAd {
    private static final int MASK_8BITS = 255;
    private static String adClickURL;
    private static TapjoyDisplayAdNotifier displayAdNotifier;
    private static String displayAdSize;
    public static String displayAdURLParams;
    final String TAPJOY_DISPLAY_AD = "Display Ad";
    View adView;
    Bitmap bitmapImage;
    private byte[] buffer;
    private Context context;
    private boolean eof;
    private int modulus;
    private int pos;
    private int x;
    private static TapjoyURLConnection tapjoyURLConnection = null;
    private static GluPlatformActivity usedActivity = null;
    private static final byte PAD = 61;
    private static final byte[] DECODE_TABLE = {-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 62, -1, 62, -1, 63, 52, 53, 54, 55, 56, 57, 58, 59, 60, PAD, -1, -1, -1, -1, -1, -1, -1, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, -1, -1, -1, -1, 63, -1, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51};

    public TapjoyDisplayAd(Context context) {
        displayAdSize = TapjoyDisplayAdSize.TJC_AD_BANNERSIZE_320X50;
        this.context = context;
        tapjoyURLConnection = new TapjoyURLConnection();
        usedActivity = (GluPlatformActivity) context;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public boolean buildResponse(String str) {
        try {
            Document document = DocumentBuilderFactory.newInstance().newDocumentBuilder().parse(new ByteArrayInputStream(str.getBytes("UTF-8")));
            adClickURL = TapjoyUtil.getNodeTrimValue(document.getElementsByTagName("ClickURL"));
            String nodeTrimValue = TapjoyUtil.getNodeTrimValue(document.getElementsByTagName("Image"));
            TapjoyLog.i("Display Ad", "decoding...");
            decodeBase64(nodeTrimValue.getBytes(), 0, nodeTrimValue.getBytes().length);
            TapjoyLog.i("Display Ad", "pos: " + this.pos);
            TapjoyLog.i("Display Ad", "buffer_size: " + this.buffer.length);
            this.bitmapImage = BitmapFactory.decodeByteArray(this.buffer, 0, this.pos);
            TapjoyLog.i("Display Ad", "image: " + this.bitmapImage.getWidth() + "x" + this.bitmapImage.getHeight());
            this.adView = new View(this.context);
            WindowManager windowManager = (WindowManager) usedActivity.getSystemService("window");
            int iMin = Math.min(windowManager.getDefaultDisplay().getWidth(), windowManager.getDefaultDisplay().getHeight());
            this.adView.setLayoutParams(new ViewGroup.LayoutParams((this.bitmapImage.getWidth() * iMin) / 600, (iMin * this.bitmapImage.getHeight()) / 600));
            this.adView.setBackgroundDrawable(new BitmapDrawable(this.bitmapImage));
            this.adView.setOnClickListener(new View.OnClickListener() { // from class: com.tapjoy.TapjoyDisplayAd.2
                @Override // android.view.View.OnClickListener
                public void onClick(View view) {
                    TapjoyLog.i("Display Ad", "Opening URL in new browser = [" + TapjoyDisplayAd.adClickURL + "]");
                    Intent intent = new Intent("android.intent.action.VIEW", Uri.parse(TapjoyDisplayAd.adClickURL));
                    intent.setFlags(268435456);
                    TapjoyDisplayAd.this.context.startActivity(intent);
                }
            });
            displayAdNotifier.getDisplayAdResponse(this.adView);
            return true;
        } catch (Exception e) {
            TapjoyLog.e("Display Ad", "Error parsing XML: " + e.toString());
            return false;
        }
    }

    void decodeBase64(byte[] bArr, int i, int i2) {
        byte b;
        int i3 = 0;
        this.buffer = new byte[bArr.length];
        this.pos = 0;
        this.eof = false;
        this.modulus = 0;
        if (i2 < 0) {
            this.eof = true;
        }
        while (i3 < i2) {
            int i4 = i + 1;
            byte b2 = bArr[i];
            if (b2 == 61) {
                this.eof = true;
                break;
            }
            if (b2 >= 0 && b2 < DECODE_TABLE.length && (b = DECODE_TABLE[b2]) >= 0) {
                int i5 = this.modulus + 1;
                this.modulus = i5;
                this.modulus = i5 % 4;
                this.x = b + (this.x << 6);
                if (this.modulus == 0) {
                    byte[] bArr2 = this.buffer;
                    int i6 = this.pos;
                    this.pos = i6 + 1;
                    bArr2[i6] = (byte) ((this.x >> 16) & MASK_8BITS);
                    byte[] bArr3 = this.buffer;
                    int i7 = this.pos;
                    this.pos = i7 + 1;
                    bArr3[i7] = (byte) ((this.x >> 8) & MASK_8BITS);
                    byte[] bArr4 = this.buffer;
                    int i8 = this.pos;
                    this.pos = i8 + 1;
                    bArr4[i8] = (byte) (this.x & MASK_8BITS);
                }
            }
            i3++;
            i = i4;
        }
        if (!this.eof || this.modulus == 0) {
            return;
        }
        this.x <<= 6;
        switch (this.modulus) {
            case 2:
                this.x <<= 6;
                byte[] bArr5 = this.buffer;
                int i9 = this.pos;
                this.pos = i9 + 1;
                bArr5[i9] = (byte) ((this.x >> 16) & MASK_8BITS);
                break;
            case 3:
                byte[] bArr6 = this.buffer;
                int i10 = this.pos;
                this.pos = i10 + 1;
                bArr6[i10] = (byte) ((this.x >> 16) & MASK_8BITS);
                byte[] bArr7 = this.buffer;
                int i11 = this.pos;
                this.pos = i11 + 1;
                bArr7[i11] = (byte) ((this.x >> 8) & MASK_8BITS);
                break;
        }
    }

    public String getBannerAdSize() {
        return displayAdSize;
    }

    public void getDisplayAd(TapjoyDisplayAdNotifier tapjoyDisplayAdNotifier) {
        TapjoyLog.i("Display Ad", "Get display ad");
        getDisplayAd(null, tapjoyDisplayAdNotifier);
    }

    public void getDisplayAd(String str, TapjoyDisplayAdNotifier tapjoyDisplayAdNotifier) {
        TapjoyLog.i("Display Ad", "Get display ad, currencyID: " + str);
        displayAdNotifier = tapjoyDisplayAdNotifier;
        displayAdURLParams = TapjoyConnectCore.getURLParams();
        displayAdURLParams += "&publisher_user_id=" + TapjoyConnectCore.getUserID();
        displayAdURLParams += "&size=" + displayAdSize;
        if (str != null) {
            displayAdURLParams += "&currency_id=" + str;
        }
        new Thread(new Runnable() { // from class: com.tapjoy.TapjoyDisplayAd.1
            @Override // java.lang.Runnable
            public void run() {
                String strConnectToURL = TapjoyDisplayAd.tapjoyURLConnection.connectToURL("https://ws.tapjoyads.com/display_ad?", TapjoyDisplayAd.displayAdURLParams);
                if (strConnectToURL == null || strConnectToURL.length() == 0) {
                    TapjoyDisplayAd.displayAdNotifier.getDisplayAdResponseFailed("Network error.");
                } else {
                    if (TapjoyDisplayAd.this.buildResponse(strConnectToURL)) {
                        return;
                    }
                    TapjoyDisplayAd.displayAdNotifier.getDisplayAdResponseFailed("No ad to display.");
                }
            }
        }).start();
    }

    public void setBannerAdSize(String str) {
        displayAdSize = str;
    }
}
