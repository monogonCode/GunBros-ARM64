package com.tapjoy;

import android.app.Activity;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Canvas;
import android.graphics.Paint;
import android.graphics.PorterDuff;
import android.graphics.PorterDuffXfermode;
import android.graphics.RectF;
import android.graphics.Shader;
import android.graphics.Typeface;
import android.graphics.drawable.BitmapDrawable;
import android.graphics.drawable.GradientDrawable;
import android.graphics.drawable.StateListDrawable;
import android.media.MediaPlayer;
import android.net.Uri;
import android.os.Build;
import android.os.Bundle;
import android.os.Handler;
import android.util.Log;
import android.view.Display;
import android.view.KeyEvent;
import android.view.View;
import android.webkit.WebView;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;
import android.widget.TextView;
import android.widget.VideoView;
import java.net.URL;
import java.net.URLConnection;
import java.util.Timer;
import java.util.TimerTask;

/* JADX INFO: loaded from: classes.dex */
public class TapjoyVideoView extends Activity implements MediaPlayer.OnCompletionListener, MediaPlayer.OnErrorListener, MediaPlayer.OnPreparedListener {
    private static final String TJC_VIDEO_AD_TEXT_FONT_COLOR = "#909090";
    private static final String TJC_VIDEO_CURRENCY_TEXT_COLOR = "#004194";
    private static final String TJC_VIDEO_FONT_COLOR = "\"black\"";
    private static final String TJC_VIDEO_FONT_TYPE = "\"helvetica\"";
    static final int stateFocused = 16842908;
    static final int statePressed = 16842919;
    static final int stateSelected = 16842913;
    private static final String videoSecondsText = " seconds";
    private static final String videoWillResumeText = "";
    private String adText;
    private String currencyAmount;
    private String currencyName;
    int deviceScreenDensity;
    int deviceScreenLayoutSize;
    private String iconURL;
    private LinearLayout linearLayout;
    private RelativeLayout relativeLayout;
    private ImageView tapjoyImage;
    private ImageView thumbnailImage;
    private TapjoyVideoObject videoData;
    private Bitmap videoScreenshot;
    private static String TJC_VIDEO_FONT_SIZE = "\"4\"";
    private static String TJC_VIDEO_AD_TEXT_FONT_SIZE = "\"3\"";
    static int textSize = 16;
    static int padding = 10;
    static int buttonHeight = -1;
    static final int[] colorsBackground = {-7697782, -12303292};
    static final int[] colorsInfo = {-1, -1513240};
    static final int[] colorsButtons = {-1, -1513240};
    static final float[] cornerAll = {10.0f, 10.0f, 10.0f, 10.0f, 10.0f, 10.0f, 10.0f, 10.0f};
    static final float[] outerRadii = {12.0f, 12.0f, 12.0f, 12.0f, 0.0f, 0.0f, 0.0f, 0.0f};
    static final RectF inset = new RectF(6.0f, 6.0f, 6.0f, 6.0f);
    static final float[] innerRadii = {12.0f, 12.0f, 0.0f, 0.0f, 12.0f, 12.0f, 0.0f, 0.0f};
    private VideoView videoView = null;
    private String videoPath = null;
    private TextView overlayText = null;
    private TextView detailsText = null;
    private TextView whatNowText = null;
    private Button replayButton = null;
    private Button closeButton = null;
    private Button linkButton = null;
    private Button linkAltButton = null;
    Timer timer = null;
    private boolean clickRequestSuccess = false;
    private boolean allowBackKey = false;
    private int timeRemaining = 0;
    private int seekTime = 0;
    final String TAPJOY_VIDEO = "VIDEO";
    final Handler mHandler = new Handler();
    final Runnable mUpdateResults = new Runnable() { // from class: com.tapjoy.TapjoyVideoView.7
        @Override // java.lang.Runnable
        public void run() {
            TapjoyVideoView.this.overlayText.setText(TapjoyVideoView.videoWillResumeText + TapjoyVideoView.this.getRemainingVideoTime() + TapjoyVideoView.videoSecondsText);
        }
    };

    private class RemainingTime extends TimerTask {
        private RemainingTime() {
        }

        @Override // java.util.TimerTask, java.lang.Runnable
        public void run() {
            TapjoyVideoView.this.mHandler.post(TapjoyVideoView.this.mUpdateResults);
        }
    }

    private Button createButton(String str) {
        GradientDrawable gradientDrawableCreateGradient = createGradient(colorsButtons);
        GradientDrawable gradientDrawableCreateGradient2 = createGradient(colorsButtons);
        GradientDrawable gradientDrawableCreateGradient3 = createGradient(colorsButtons);
        StateListDrawable stateListDrawable = new StateListDrawable();
        stateListDrawable.addState(new int[]{16842919}, gradientDrawableCreateGradient);
        stateListDrawable.addState(new int[]{-16842908, -16842913}, gradientDrawableCreateGradient2);
        stateListDrawable.addState(new int[]{-16842908, 16842913}, gradientDrawableCreateGradient3);
        Button button = new Button(this);
        button.setBackgroundDrawable(stateListDrawable);
        button.setText(str);
        button.setTextColor(-16565102);
        button.setTextSize(textSize);
        button.setTypeface(Typeface.create("default", 1), 1);
        if (buttonHeight > 0) {
            button.setHeight(buttonHeight);
        }
        TapjoyLog.i("VIDEO", "padding bottom: " + button.getPaddingBottom());
        TapjoyLog.i("VIDEO", "padding top: " + button.getPaddingTop());
        TapjoyLog.i("VIDEO", "padding left: " + button.getPaddingLeft());
        TapjoyLog.i("VIDEO", "padding right: " + button.getPaddingRight());
        button.setPadding(button.getPaddingLeft(), button.getPaddingBottom(), button.getPaddingRight(), button.getPaddingBottom());
        return button;
    }

    private static GradientDrawable createGradient(int[] iArr) {
        GradientDrawable gradientDrawable = new GradientDrawable(GradientDrawable.Orientation.TOP_BOTTOM, iArr);
        gradientDrawable.setCornerRadii(cornerAll);
        gradientDrawable.setGradientRadius(50.0f);
        return gradientDrawable;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public int getRemainingVideoTime() {
        int duration = (this.videoView.getDuration() - this.videoView.getCurrentPosition()) / 1000;
        if (duration < 0) {
            return 0;
        }
        return duration;
    }

    private void initVideoUI() {
        Display defaultDisplay = getWindowManager().getDefaultDisplay();
        int width = defaultDisplay.getWidth();
        int height = defaultDisplay.getHeight();
        TapjoyLog.i("VIDEO", "view dimensions: " + width + "x" + height);
        if (Integer.parseInt(Build.VERSION.SDK) > 3) {
            this.deviceScreenLayoutSize = new TapjoyDisplayMetricsUtil(this).getScreenLayoutSize();
            TapjoyLog.i("VIDEO", "deviceScreenLayoutSize: " + this.deviceScreenLayoutSize);
            if (this.deviceScreenLayoutSize == 4) {
                padding = 20;
                textSize = 32;
                buttonHeight = height / 7;
                TJC_VIDEO_FONT_SIZE = "\"10\"";
                TJC_VIDEO_AD_TEXT_FONT_SIZE = "\"6\"";
                TapjoyLog.i("VIDEO", "buttonHeight: " + buttonHeight);
            }
        }
        int i = height / 3;
        int width2 = (defaultDisplay.getWidth() / 2) - (padding * 2);
        this.linearLayout = new LinearLayout(this);
        this.linearLayout.setOrientation(1);
        LinearLayout.LayoutParams layoutParams = new LinearLayout.LayoutParams(-1, -1);
        layoutParams.setMargins(padding, padding, padding, padding);
        this.linearLayout.setLayoutParams(layoutParams);
        this.detailsText = new TextView(this);
        this.detailsText.setText("Details");
        this.detailsText.setTextColor(-1);
        this.detailsText.setTextSize(textSize);
        this.detailsText.setTypeface(Typeface.create("default", 1), 1);
        this.detailsText.setShadowLayer(1.0f, 1.0f, 1.0f, -16777216);
        LinearLayout.LayoutParams layoutParams2 = new LinearLayout.LayoutParams(-2, -2);
        layoutParams2.setMargins(padding, padding, padding, 0);
        this.detailsText.setLayoutParams(layoutParams2);
        this.detailsText.setId(2111);
        try {
            Bitmap bitmapDecodeFile = BitmapFactory.decodeFile(TapjoyVideo.imageBackgroundLocation);
            if (bitmapDecodeFile != null) {
                BitmapDrawable bitmapDrawable = new BitmapDrawable(bitmapDecodeFile);
                bitmapDrawable.setTileModeX(Shader.TileMode.REPEAT);
                bitmapDrawable.setTileModeY(Shader.TileMode.REPEAT);
                this.linearLayout.setBackgroundDrawable(bitmapDrawable);
            }
        } catch (Exception e) {
        }
        this.thumbnailImage = new ImageView(this);
        try {
            Bitmap bitmapDecodeFile2 = this.videoScreenshot != null ? this.videoScreenshot : BitmapFactory.decodeFile(TapjoyVideo.imagePlaceholderLocation);
            if (bitmapDecodeFile2 != null) {
                int width3 = bitmapDecodeFile2.getWidth();
                int height2 = bitmapDecodeFile2.getHeight();
                Canvas canvas = new Canvas(Bitmap.createBitmap(width3, height2, Bitmap.Config.ARGB_8888));
                Paint paint = new Paint(1);
                paint.setColor(-65536);
                canvas.drawRoundRect(new RectF(0.0f, 0.0f, width3, height2), 25.0f, 25.0f, paint);
                paint.setXfermode(new PorterDuffXfermode(PorterDuff.Mode.DST_IN));
                Bitmap bitmapCreateBitmap = Bitmap.createBitmap(width3, height2, Bitmap.Config.ARGB_8888);
                new Canvas(bitmapCreateBitmap).drawBitmap(bitmapDecodeFile2, 0.0f, 0.0f, (Paint) null);
                this.thumbnailImage.setImageBitmap(Bitmap.createScaledBitmap(bitmapCreateBitmap, (width3 * i) / height2, i, true));
                this.thumbnailImage.setPadding(0, 0, 0, 0);
            }
        } catch (Exception e2) {
            e2.printStackTrace();
        }
        WebView webView = new WebView(this);
        webView.setBackgroundColor(0);
        webView.loadData("<html><body><font face=\"helvetica\" color=\"black\" size=" + TJC_VIDEO_FONT_SIZE + "><p>You just earned <font color=" + TJC_VIDEO_CURRENCY_TEXT_COLOR + "><b>" + this.currencyAmount + "</b></font> " + this.currencyName + "! <br /> <font color=" + TJC_VIDEO_AD_TEXT_FONT_COLOR + " size=" + TJC_VIDEO_AD_TEXT_FONT_SIZE + "><b>" + this.adText + "</b></p></font></font></body></html>", "text/html", "utf-8");
        LinearLayout linearLayout = new LinearLayout(this);
        linearLayout.addView(webView);
        linearLayout.setPadding((-padding) / 2, padding / 2, 0, 0);
        LinearLayout linearLayout2 = new LinearLayout(this);
        LinearLayout.LayoutParams layoutParams3 = new LinearLayout.LayoutParams(width - (padding * 2), i);
        layoutParams3.setMargins(padding, padding, padding, padding);
        linearLayout2.setLayoutParams(layoutParams3);
        linearLayout2.setOrientation(0);
        linearLayout2.setPadding(0, padding * 2, 0, padding * 2);
        linearLayout2.setBackgroundDrawable(createGradient(colorsInfo));
        linearLayout2.setGravity(19);
        linearLayout2.addView(this.thumbnailImage);
        linearLayout2.addView(linearLayout);
        this.whatNowText = new TextView(this);
        this.whatNowText.setText("What now?");
        this.whatNowText.setTextColor(-1);
        this.whatNowText.setTextSize(textSize);
        this.whatNowText.setTypeface(Typeface.create("default", 1), 1);
        this.whatNowText.setShadowLayer(1.0f, 1.0f, 1.0f, -16777216);
        LinearLayout.LayoutParams layoutParams4 = new LinearLayout.LayoutParams(-2, -2);
        layoutParams4.setMargins(padding, padding, padding, 0);
        this.whatNowText.setLayoutParams(layoutParams4);
        this.whatNowText.setId(3112);
        this.replayButton = createButton("Replay this video");
        LinearLayout.LayoutParams layoutParams5 = new LinearLayout.LayoutParams(width2, -2);
        layoutParams5.setMargins(padding, padding, padding, padding);
        this.replayButton.setLayoutParams(layoutParams5);
        this.replayButton.setId(1113);
        this.replayButton.setOnClickListener(new View.OnClickListener() { // from class: com.tapjoy.TapjoyVideoView.2
            @Override // android.view.View.OnClickListener
            public void onClick(View view) {
                TapjoyVideoView.this.initVideoView();
            }
        });
        TapjoyLog.i("VIDEO", "button dimensions: " + this.replayButton.getMeasuredWidth() + "x" + this.replayButton.getMeasuredHeight());
        this.closeButton = createButton("View More Offers");
        LinearLayout.LayoutParams layoutParams6 = new LinearLayout.LayoutParams(width2, -2);
        layoutParams6.setMargins(padding, padding, padding, padding);
        this.closeButton.setLayoutParams(layoutParams6);
        this.closeButton.setOnClickListener(new View.OnClickListener() { // from class: com.tapjoy.TapjoyVideoView.3
            @Override // android.view.View.OnClickListener
            public void onClick(View view) {
                TapjoyVideoView.this.finish();
            }
        });
        LinearLayout linearLayout3 = new LinearLayout(this);
        linearLayout3.setLayoutParams(new LinearLayout.LayoutParams(width, -2));
        linearLayout3.setOrientation(0);
        linearLayout3.addView(this.replayButton);
        linearLayout3.addView(this.closeButton);
        TapjoyLog.i("VIDEO", "linear width: " + linearLayout3.getMeasuredWidth());
        this.linearLayout.addView(this.detailsText);
        this.linearLayout.addView(linearLayout2);
        this.linearLayout.addView(this.whatNowText);
        this.linearLayout.addView(linearLayout3);
        if (this.videoData.buttonCount > 0) {
            this.linkButton = createButton(this.videoData.buttonData[0][0]);
            LinearLayout.LayoutParams layoutParams7 = new LinearLayout.LayoutParams(width2, -2);
            layoutParams7.setMargins(padding, padding, padding, padding);
            this.linkButton.setLayoutParams(layoutParams7);
            this.linkButton.setOnClickListener(new View.OnClickListener() { // from class: com.tapjoy.TapjoyVideoView.4
                @Override // android.view.View.OnClickListener
                public void onClick(View view) {
                    Uri uri = Uri.parse(TapjoyVideoView.this.videoData.buttonData[0][1]);
                    try {
                        TapjoyVideoView.this.startActivity(new Intent("android.intent.action.VIEW", uri));
                    } catch (Exception e3) {
                        Log.e("VIDEO BUTTON", "Bad URI " + uri + ": " + e3.toString());
                    }
                }
            });
            if (this.videoData.buttonCount < 2) {
                this.linearLayout.addView(this.linkButton);
                return;
            }
            this.linkAltButton = createButton(this.videoData.buttonData[1][0]);
            new LinearLayout.LayoutParams(width2, -2).setMargins(padding, padding, padding, padding);
            this.linkAltButton.setLayoutParams(layoutParams7);
            this.linkAltButton.setOnClickListener(new View.OnClickListener() { // from class: com.tapjoy.TapjoyVideoView.5
                @Override // android.view.View.OnClickListener
                public void onClick(View view) {
                    Uri uri = Uri.parse(TapjoyVideoView.this.videoData.buttonData[1][1]);
                    try {
                        TapjoyVideoView.this.startActivity(new Intent("android.intent.action.VIEW", uri));
                    } catch (Exception e3) {
                        Log.e("VIDEO BUTTON", "Bad URI " + uri + ": " + e3.toString());
                    }
                }
            });
            LinearLayout linearLayout4 = new LinearLayout(this);
            linearLayout4.setLayoutParams(new LinearLayout.LayoutParams(width, -2));
            linearLayout4.setOrientation(0);
            linearLayout4.addView(this.linkButton);
            linearLayout4.addView(this.linkAltButton);
            this.linearLayout.addView(linearLayout4);
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void initVideoView() {
        this.relativeLayout.removeAllViews();
        this.relativeLayout.setBackgroundColor(-16777216);
        if (this.videoView == null && this.overlayText == null) {
            this.tapjoyImage = new ImageView(this);
            Bitmap bitmapDecodeFile = BitmapFactory.decodeFile(TapjoyVideo.imageTapjoyLocation);
            if (bitmapDecodeFile != null) {
                this.tapjoyImage.setImageBitmap(bitmapDecodeFile);
            }
            RelativeLayout.LayoutParams layoutParams = new RelativeLayout.LayoutParams(-2, -2);
            layoutParams.addRule(12);
            layoutParams.addRule(11);
            this.tapjoyImage.setLayoutParams(layoutParams);
            this.videoView = new VideoView(this);
            this.videoView.setOnCompletionListener(this);
            this.videoView.setOnErrorListener(this);
            this.videoView.setOnPreparedListener(this);
            this.videoView.setVideoPath(this.videoPath);
            RelativeLayout.LayoutParams layoutParams2 = new RelativeLayout.LayoutParams(-2, -2);
            layoutParams2.addRule(13);
            this.videoView.setLayoutParams(layoutParams2);
            this.timeRemaining = this.videoView.getDuration() / 1000;
            TapjoyLog.i("VIDEO", "videoView.getDuration(): " + this.videoView.getDuration());
            TapjoyLog.i("VIDEO", "timeRemaining: " + this.timeRemaining);
            this.overlayText = new TextView(this);
            this.overlayText.setTextSize(textSize);
            this.overlayText.setTypeface(Typeface.create("default", 1), 1);
            this.overlayText.setText(videoWillResumeText + getRemainingVideoTime() + videoSecondsText);
            RelativeLayout.LayoutParams layoutParams3 = new RelativeLayout.LayoutParams(-2, -2);
            layoutParams3.addRule(12);
            this.overlayText.setLayoutParams(layoutParams3);
        }
        startVideo();
        this.relativeLayout.addView(this.videoView);
        this.relativeLayout.addView(this.tapjoyImage);
        this.relativeLayout.addView(this.overlayText);
    }

    private void showVideoUI() {
        this.relativeLayout.removeAllViews();
        this.relativeLayout.setBackgroundDrawable(new GradientDrawable(GradientDrawable.Orientation.TOP_BOTTOM, colorsBackground));
        this.relativeLayout.addView(this.linearLayout);
    }

    private void startVideo() {
        this.videoView.requestFocus();
        this.videoView.seekTo(0);
        TapjoyLog.i("VIDEO", "start");
        this.videoView.start();
        if (this.timer != null) {
            this.timer.cancel();
        }
        this.timer = new Timer();
        this.timer.schedule(new RemainingTime(), 250L, 250L);
        new Thread(new Runnable() { // from class: com.tapjoy.TapjoyVideoView.6
            @Override // java.lang.Runnable
            public void run() {
                if (new TapjoyURLConnection().connectToURL(TapjoyVideoView.this.videoData.clickURL).contains("OK")) {
                    TapjoyLog.i("VIDEO", "CLICK REQUEST SUCCESS!");
                    TapjoyVideoView.this.clickRequestSuccess = true;
                }
            }
        }).start();
    }

    @Override // android.media.MediaPlayer.OnCompletionListener
    public void onCompletion(MediaPlayer mediaPlayer) {
        TapjoyLog.i("VIDEO", "onCompletion");
        if (this.timer != null) {
            this.timer.cancel();
        }
        initVideoUI();
        showVideoUI();
        TapjoyVideo.getVideoNotifier();
        new Thread(new Runnable() { // from class: com.tapjoy.TapjoyVideoView.8
            @Override // java.lang.Runnable
            public void run() {
                if (TapjoyVideoView.this.clickRequestSuccess) {
                    TapjoyConnectCore.getInstance().actionComplete(TapjoyVideoView.this.videoData.offerID);
                }
            }
        }).start();
        this.allowBackKey = true;
    }

    @Override // android.app.Activity
    protected void onCreate(Bundle bundle) {
        TapjoyLog.i("VIDEO", "onCreate");
        this.videoData = TapjoyVideo.getInstance().getCurrentVideoData();
        this.videoPath = this.videoData.dataLocation;
        this.currencyAmount = this.videoData.currencyAmount;
        this.currencyName = this.videoData.currencyName;
        this.adText = this.videoData.videoAdName;
        this.iconURL = this.videoData.iconURL;
        if (this.iconURL != null && this.iconURL.length() > 0) {
            new Thread(new Runnable() { // from class: com.tapjoy.TapjoyVideoView.1
                @Override // java.lang.Runnable
                public void run() {
                    try {
                        URL url = new URL(TapjoyVideoView.this.iconURL);
                        URLConnection uRLConnectionOpenConnection = url.openConnection();
                        uRLConnectionOpenConnection.setConnectTimeout(15000);
                        uRLConnectionOpenConnection.setReadTimeout(25000);
                        uRLConnectionOpenConnection.connect();
                        TapjoyVideoView.this.videoScreenshot = BitmapFactory.decodeStream(url.openConnection().getInputStream());
                    } catch (Exception e) {
                        TapjoyLog.i("VIDEO", "e: " + e.toString());
                    }
                }
            }).start();
        }
        TapjoyLog.i("VIDEO", "videoPath: " + this.videoPath);
        super.onCreate(bundle);
        requestWindowFeature(1);
        this.relativeLayout = new RelativeLayout(this);
        this.relativeLayout.setLayoutParams(new RelativeLayout.LayoutParams(-1, -1));
        setContentView(this.relativeLayout);
        if (Integer.parseInt(Build.VERSION.SDK) > 3) {
            this.deviceScreenLayoutSize = new TapjoyDisplayMetricsUtil(this).getScreenLayoutSize();
            TapjoyLog.i("VIDEO", "deviceScreenLayoutSize: " + this.deviceScreenLayoutSize);
            if (this.deviceScreenLayoutSize == 4) {
                Display defaultDisplay = getWindowManager().getDefaultDisplay();
                int width = defaultDisplay.getWidth();
                int height = defaultDisplay.getHeight();
                TapjoyLog.i("VIDEO", "width: " + width + ", height: " + height);
                padding = 20;
                textSize = 32;
                buttonHeight = height / 7;
                TJC_VIDEO_FONT_SIZE = "\"10\"";
                TJC_VIDEO_AD_TEXT_FONT_SIZE = "\"6\"";
                TapjoyLog.i("VIDEO", "buttonHeight: " + buttonHeight);
            }
        }
        TapjoyLog.i("VIDEO", "padding: " + padding);
        TapjoyLog.i("VIDEO", "textSize: " + textSize);
        initVideoView();
        TapjoyLog.i("VIDEO", "onCreate DONE");
    }

    @Override // android.media.MediaPlayer.OnErrorListener
    public boolean onError(MediaPlayer mediaPlayer, int i, int i2) {
        TapjoyLog.i("VIDEO", "onError");
        TapjoyVideo.getVideoNotifier();
        this.allowBackKey = true;
        if (this.timer == null) {
            return false;
        }
        this.timer.cancel();
        return false;
    }

    @Override // android.app.Activity, android.view.KeyEvent.Callback
    public boolean onKeyDown(int i, KeyEvent keyEvent) {
        if (i == 4) {
            if (!this.allowBackKey) {
                return true;
            }
            if (this.videoView.isPlaying()) {
                this.videoView.stopPlayback();
                showVideoUI();
                if (this.timer == null) {
                    return true;
                }
                this.timer.cancel();
                return true;
            }
        }
        return super.onKeyDown(i, keyEvent);
    }

    @Override // android.app.Activity
    protected void onPause() {
        super.onPause();
        if (this.videoView.isPlaying()) {
            TapjoyLog.i("VIDEO", "onPause");
            this.seekTime = this.videoView.getCurrentPosition();
            TapjoyLog.i("VIDEO", "seekTime: " + this.seekTime);
        }
    }

    @Override // android.media.MediaPlayer.OnPreparedListener
    public void onPrepared(MediaPlayer mediaPlayer) {
        TapjoyLog.i("VIDEO", "onPrepared");
    }

    @Override // android.app.Activity
    protected void onResume() {
        TapjoyLog.i("VIDEO", "onResume");
        setRequestedOrientation(0);
        super.onResume();
        if (this.seekTime > 0) {
            TapjoyLog.i("VIDEO", "seekTime: " + this.seekTime);
            this.videoView.seekTo(this.seekTime);
            this.videoView.start();
        }
    }

    @Override // android.app.Activity, android.view.Window.Callback
    public void onWindowFocusChanged(boolean z) {
        TapjoyLog.i("VIDEO", "onWindowFocusChanged");
        super.onWindowFocusChanged(z);
    }
}
