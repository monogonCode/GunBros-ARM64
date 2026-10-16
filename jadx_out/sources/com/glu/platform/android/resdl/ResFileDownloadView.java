package com.glu.platform.android.resdl;

import android.content.Context;
import android.graphics.Canvas;
import android.graphics.LightingColorFilter;
import android.graphics.Paint;
import android.graphics.Rect;
import android.graphics.drawable.Drawable;
import android.os.Environment;
import android.view.KeyEvent;
import android.view.MotionEvent;
import android.view.View;
import com.glu.android.gunbros_free.R;
import com.glu.platform.android.GluPlatformActivity;
import com.urbanairship.push.PushPreferences;
import java.io.File;
import java.util.Vector;

/* JADX INFO: loaded from: classes.dex */
public class ResFileDownloadView extends View {
    public static int FONT_SIZE = 24;
    public static int MARGIN = 6;
    public static int TOOLTIP_PADDING = 20;
    public static ResFileDownloadView instance = null;
    private boolean gameStarted;
    public GluWidget m_activeWidget;
    public int m_annunciatorBarHeight;
    public boolean m_backPressed;
    public Paint m_buttonPaint;
    public int m_bytesDownloaded;
    public boolean m_checksumDone;
    public String m_checksumError;
    public boolean m_checksumInProgress;
    public boolean m_checksumPassed;
    public String m_deleteMessage;
    public boolean m_downloadCancelled;
    public boolean m_downloadDone;
    public String m_downloadError;
    public boolean m_downloadFailed;
    public String m_downloadFilename;
    public boolean m_downloadToDisk;
    public boolean m_heightNeedsCorrection;
    public long m_lastTickTime;
    public Paint m_marqueePaint;
    public Drawable m_mutedLogoImg;
    public boolean m_pointerLatched;
    public int m_preparingTimer;
    public int m_prevState;
    public int m_screenHeight;
    public int m_screenWidth;
    private int m_sdButtonNegative;
    private int m_sdButtonPositive;
    private String m_sdErrorText;
    private boolean m_showedWiFiPopup;
    public boolean m_specialCheckPassed;
    public int m_state;
    public String m_tempFilename;
    public Paint m_textAreaPaint;
    public Paint m_titlebarPaint;
    public LightingColorFilter m_tooltipColorFilter;
    public Drawable m_tooltipImg;
    public boolean m_usesAltSDCardPath;
    public Vector<GluWidget> m_widgets;

    public static class GluButton extends GluWidget {
        public String m_label;
        public Paint m_paint;
        public Rect m_rectBounds;
        public Vector<String> m_wrappedLabel;

        public GluButton(String str, int i) {
            super(ResFileDownloadView.instance, i);
            this.m_rectBounds = new Rect();
            this.m_label = str;
            this.m_paint = ResFileDownloadView.instance.m_buttonPaint;
        }

        @Override // com.glu.platform.android.resdl.ResFileDownloadView.GluWidget
        public final void draw(Canvas canvas) {
            GluUtil.paintButton(canvas, this.m_rectBounds, this.pointerActive ? GluUtil.CF_BUTTON_SELECTED : GluUtil.CF_BUTTON_DEFAULT, this.m_wrappedLabel, this.m_paint);
        }

        @Override // com.glu.platform.android.resdl.ResFileDownloadView.GluWidget
        public final void setBounds(int i, int i2, int i3, int i4) {
            super.setBounds(i, i2, i3, GluUtil.scaleRelativeToG1(61));
            this.m_rectBounds.left = this.m_x;
            this.m_rectBounds.top = this.m_y;
            this.m_rectBounds.right = this.m_dx;
            this.m_rectBounds.bottom = this.m_dy;
            this.m_wrappedLabel = GluUtil.wrapText(this.m_label, i3, this.m_paint);
        }

        @Override // com.glu.platform.android.resdl.ResFileDownloadView.GluWidget
        public final void tick(int i) {
        }
    }

    public static class GluTextArea extends GluWidget {
        public Paint m_paint;
        public String m_text;
        public Vector<String> m_wrappedText;

        public GluTextArea(String str) {
            super(ResFileDownloadView.instance, -1);
            this.m_text = str;
            this.m_paint = ResFileDownloadView.instance.m_textAreaPaint;
        }

        @Override // com.glu.platform.android.resdl.ResFileDownloadView.GluWidget
        public final void draw(Canvas canvas) {
            float textSize = this.m_paint.getTextSize();
            int size = this.m_wrappedText.size();
            float f = this.m_y + ((this.m_dy - this.m_y) / 2);
            for (int i = 0; i < size; i++) {
                canvas.drawText(this.m_wrappedText.elementAt(i), this.m_x + ((this.m_dx - this.m_x) / 2), (i * textSize) + f + (textSize / 2.0f), this.m_paint);
            }
        }

        @Override // com.glu.platform.android.resdl.ResFileDownloadView.GluWidget
        public final void setBounds(int i, int i2, int i3, int i4) {
            super.setBounds(i, i2, i3, i4);
            this.m_wrappedText = GluUtil.wrapText(this.m_text, i3, this.m_paint);
        }

        @Override // com.glu.platform.android.resdl.ResFileDownloadView.GluWidget
        public final void tick(int i) {
        }
    }

    public static class GluTitlebar extends GluWidget {
        public String m_label;
        public Paint m_paint;

        public GluTitlebar(String str) {
            super(ResFileDownloadView.instance, -1);
            this.m_label = str;
            this.m_paint = ResFileDownloadView.instance.m_titlebarPaint;
        }

        @Override // com.glu.platform.android.resdl.ResFileDownloadView.GluWidget
        public final void draw(Canvas canvas) {
            Drawable drawable = GluUtil.getDrawable(R.drawable.titlebar);
            int iScaleRelativeToG1 = GluUtil.scaleRelativeToG1(38);
            int iScaleRelativeToG2 = GluUtil.scaleRelativeToG1(32);
            for (int i = this.m_x; i < this.m_dx; i += iScaleRelativeToG2) {
                drawable.setBounds(i, this.m_y, i + iScaleRelativeToG2, this.m_y + iScaleRelativeToG1);
            }
            canvas.drawText(this.m_label, this.m_x + 10, this.m_y + ((this.m_dy - this.m_y) / 2) + (this.m_paint.getTextSize() / 2.0f), this.m_paint);
        }

        @Override // com.glu.platform.android.resdl.ResFileDownloadView.GluWidget
        public final void setBounds(int i, int i2, int i3, int i4) {
            super.setBounds(i, i2, i3, GluUtil.scaleRelativeToG1(38));
        }

        @Override // com.glu.platform.android.resdl.ResFileDownloadView.GluWidget
        public final void tick(int i) {
        }
    }

    public static class GluTooltip extends GluWidget {
        public int m_elapsedTime;
        public String m_popupText;
        public String m_popupTitle;
        public float m_scaleFactor;

        public GluTooltip(String str) {
            super(ResFileDownloadView.instance, 12);
            this.m_elapsedTime = 0;
            this.m_scaleFactor = 1.0f;
            this.m_popupTitle = GluUtil.getString(R.string.IDS_TOOLTIP_TITLE);
            this.m_popupText = str;
            this.m_boundsOverreachFactor = 2.0f;
        }

        @Override // com.glu.platform.android.resdl.ResFileDownloadView.GluWidget
        public final void draw(Canvas canvas) {
            Drawable drawable = ResFileDownloadView.instance.m_tooltipImg;
            drawable.setColorFilter(ResFileDownloadView.instance.m_tooltipColorFilter);
            int iScaleRelativeToG1 = GluUtil.scaleRelativeToG1(26);
            int i = (((int) (iScaleRelativeToG1 * this.m_scaleFactor)) >> 1) - (iScaleRelativeToG1 >> 1);
            int i2 = (((int) (iScaleRelativeToG1 * this.m_scaleFactor)) >> 1) - (iScaleRelativeToG1 >> 1);
            drawable.setBounds(this.m_x - i, this.m_y - i2, i + ((this.m_x + iScaleRelativeToG1) - 1), ((iScaleRelativeToG1 + this.m_y) - 1) + i2);
            drawable.draw(canvas);
            drawable.setColorFilter(null);
        }

        @Override // com.glu.platform.android.resdl.ResFileDownloadView.GluWidget
        public final void tick(int i) {
            this.m_elapsedTime += i;
            int i2 = this.m_elapsedTime % 1000;
            this.m_elapsedTime = i2;
            if (i2 < 500) {
                if (i2 > 250) {
                    i2 = 500 - i2;
                }
                this.m_scaleFactor = (i2 / 2000.0f) + 1.0f;
            } else {
                int i3 = i2 - 500;
                if (i3 > 250) {
                    i3 = 500 - i3;
                }
                this.m_scaleFactor = 1.0f - (i3 / 2000.0f);
            }
        }
    }

    public static abstract class GluWidget {
        public ResFileDownloadView m_parent;
        public int m_widgetID;
        public int pointerX = 0;
        public int pointerY = 0;
        public boolean pointerActive = false;
        public int m_x = 0;
        public int m_y = 0;
        public int m_dx = 0;
        public int m_dy = 0;
        public float m_boundsOverreachFactor = 1.0f;

        public GluWidget(ResFileDownloadView resFileDownloadView, int i) {
            this.m_parent = resFileDownloadView;
            this.m_widgetID = i;
        }

        public final boolean containsCoords(int i, int i2) {
            if (this.m_boundsOverreachFactor != 1.0f) {
                int i3 = (((int) ((this.m_dx - this.m_x) * this.m_boundsOverreachFactor)) >> 1) - ((this.m_dx - this.m_x) >> 1);
                int i4 = (((int) ((this.m_dy - this.m_y) * this.m_boundsOverreachFactor)) >> 1) - ((this.m_dy - this.m_y) >> 1);
                if (i >= this.m_x - i3 && i <= i3 + this.m_dx && i2 >= this.m_y - i4 && i2 <= this.m_dy + i4) {
                    return true;
                }
            } else if (i >= this.m_x && i <= this.m_dx && i2 >= this.m_y && i2 <= this.m_dy) {
                return true;
            }
            return false;
        }

        public abstract void draw(Canvas canvas);

        public void setBounds(int i, int i2, int i3, int i4) {
            this.m_x = i;
            this.m_y = i2;
            this.m_dx = (i + i3) - 1;
            this.m_dy = (i2 + i4) - 1;
        }

        public abstract void tick(int i);
    }

    public ResFileDownloadView(Context context) {
        super(context);
        this.m_widgets = new Vector<>();
        this.m_activeWidget = null;
        this.m_state = -1;
        this.m_prevState = -1;
        this.m_backPressed = false;
        this.m_pointerLatched = false;
        this.m_downloadDone = false;
        this.m_downloadFailed = false;
        this.m_downloadToDisk = false;
        this.m_downloadCancelled = false;
        this.m_bytesDownloaded = 0;
        this.m_downloadFilename = null;
        this.m_tempFilename = null;
        this.m_checksumInProgress = false;
        this.m_checksumPassed = false;
        this.m_specialCheckPassed = false;
        this.m_checksumDone = false;
        this.m_usesAltSDCardPath = false;
        this.m_mutedLogoImg = null;
        this.m_titlebarPaint = null;
        this.m_buttonPaint = null;
        this.m_textAreaPaint = null;
        this.m_marqueePaint = null;
        this.m_checksumError = null;
        this.m_downloadError = null;
        this.m_deleteMessage = null;
        this.m_tooltipImg = null;
        this.m_tooltipColorFilter = null;
        this.m_preparingTimer = 0;
        this.m_heightNeedsCorrection = true;
        this.m_annunciatorBarHeight = 0;
        this.gameStarted = false;
        this.m_sdErrorText = null;
        this.m_sdButtonPositive = -2;
        this.m_sdButtonNegative = -2;
        this.m_showedWiFiPopup = false;
        this.m_lastTickTime = System.currentTimeMillis();
        setId(4342351);
    }

    private void createPromptLayout(String str, int i, String str2, int i2, String str3) {
        int usableY = getUsableY();
        int i3 = (((this.m_screenHeight - usableY) * 2) / 3) + usableY;
        int i4 = this.m_screenWidth >> 1;
        GluTextArea gluTextArea = new GluTextArea(str);
        gluTextArea.setBounds(MARGIN, usableY, this.m_screenWidth - (MARGIN << 1), i3 - usableY);
        this.m_widgets.addElement(gluTextArea);
        GluButton gluButton = new GluButton(str2, i);
        gluButton.setBounds(MARGIN, i3, i4 - (MARGIN << 1), 0);
        this.m_widgets.addElement(gluButton);
        GluButton gluButton2 = new GluButton(str3, i2);
        gluButton2.setBounds(MARGIN + i4, i3, i4 - (MARGIN << 1), 0);
        this.m_widgets.addElement(gluButton2);
    }

    private void createTextOnlyLayout(String str) {
        int usableY = getUsableY();
        GluTextArea gluTextArea = new GluTextArea(str);
        gluTextArea.setBounds(MARGIN, usableY, this.m_screenWidth - (MARGIN << 1), this.m_screenHeight - usableY);
        this.m_widgets.addElement(gluTextArea);
    }

    private static void deleteResFile() {
        File file = new File(GluUtil.getDiskFilename());
        if (file.exists()) {
            file.delete();
            return;
        }
        File file2 = new File(GluUtil.getPrimaryResSDCardFilename());
        if (file2.exists()) {
            file2.delete();
        }
    }

    private int getAllFilesBytesDownloaded$134621() {
        int specialFilePartDownloaded = GluDownloadResMgr.instance.specialChecksumPassed() ? this.m_bytesDownloaded : GluDownloadResMgr.instance.getSpecialFilePartDownloaded();
        GluDownloadResMgr gluDownloadResMgr = GluDownloadResMgr.instance;
        GluDownloadResMgr.areThereSpecialFiles();
        return specialFilePartDownloaded;
    }

    private static int getAllFilesBytesTotal() {
        if (!GluDownloadResMgr.instance.specialChecksumPassed()) {
            return GluDownloadResMgr.instance.getSpecialFilePartTotal() + 0;
        }
        GluDownloadResMgr gluDownloadResMgr = GluDownloadResMgr.instance;
        if (!GluDownloadResMgr.areThereSpecialFiles()) {
            return 0;
        }
        GluDownloadResMgr gluDownloadResMgr2 = GluDownloadResMgr.instance;
        return GluDownloadResMgr.getSpecialFileSize() + 0;
    }

    private static String getSDButtonText(int i) {
        if (i == 17) {
            return GluUtil.getString(R.string.IDS_SD_STARTUP_OVERRIDE);
        }
        if (i == 18) {
            return GluUtil.getString(R.string.IDS_SD_STARTUP_RETRY);
        }
        return i == 19 ? GluUtil.getString(R.string.IDS_SD_STARTUP_QUIT) : "null";
    }

    private int getUsableY() {
        if (this.m_widgets.size() == 0) {
            return 0;
        }
        return this.m_widgets.elementAt(0).m_dy;
    }

    private static boolean resourceIsOnDisk() {
        File file = new File(GluUtil.getDiskFilename());
        return file.exists() && !file.isDirectory();
    }

    private void showWiFiPopup() {
        if (this.m_showedWiFiPopup || GluUtil.isUserOnWiFi()) {
            return;
        }
        GluUtil.openModalDialog(GluUtil.getString(R.string.IDS_DOWNLOAD_WIFI_POPUP_TITLE), GluUtil.getString(R.string.IDS_DOWNLOAD_WIFI_WARNING), GluUtil.getString(R.string.IDS_OK));
        this.m_showedWiFiPopup = true;
    }

    public final void init(int i, int i2) {
        Debug.log("~~ init(" + i + ", " + i2 + ")");
        GluPlatformActivity.instance.displayHeight = i2;
        FONT_SIZE = GluUtil.scaleRelativeToDroid(24);
        MARGIN = GluUtil.scaleRelativeToDroid(6);
        TOOLTIP_PADDING = GluUtil.scaleRelativeToDroid(39);
        instance = this;
        this.m_screenWidth = i;
        this.m_screenHeight = i2;
        boolean z = GluDownloadResMgr.instance.m_mainResFileInterrupted;
        if (resourceIsOnDisk()) {
            this.m_downloadToDisk = true;
        } else {
            File file = new File(GluUtil.getPrimaryResSDCardFilename());
            if (file.exists() && !file.isDirectory()) {
                this.m_downloadToDisk = false;
            } else {
                GluDownloadResMgr.instance.m_mainResFileInterrupted = false;
            }
        }
        this.m_mutedLogoImg = GluUtil.getDrawable(R.drawable.glu_logo_muted);
        this.m_tooltipImg = GluUtil.getDrawable(R.drawable.gns_about);
        this.m_tooltipColorFilter = new LightingColorFilter(-16777216, -2282);
        this.m_titlebarPaint = new Paint();
        this.m_titlebarPaint.setFlags(32);
        this.m_titlebarPaint.setColor(-1);
        this.m_titlebarPaint.setTextSize(FONT_SIZE);
        this.m_titlebarPaint.setTextAlign(Paint.Align.LEFT);
        this.m_titlebarPaint.setFilterBitmap(true);
        this.m_titlebarPaint.setAntiAlias(true);
        this.m_buttonPaint = new Paint();
        this.m_buttonPaint.setColor(-16777216);
        this.m_buttonPaint.setTextSize(FONT_SIZE);
        this.m_buttonPaint.setTextAlign(Paint.Align.CENTER);
        this.m_buttonPaint.setFilterBitmap(true);
        this.m_buttonPaint.setAntiAlias(true);
        this.m_textAreaPaint = new Paint();
        this.m_textAreaPaint.setColor(-1);
        this.m_textAreaPaint.setTextSize(FONT_SIZE);
        this.m_textAreaPaint.setTextAlign(Paint.Align.CENTER);
        this.m_textAreaPaint.setFilterBitmap(true);
        this.m_textAreaPaint.setAntiAlias(true);
        this.m_marqueePaint = new Paint();
        this.m_marqueePaint.setColor(-1);
        this.m_marqueePaint.setTextSize(FONT_SIZE);
        this.m_marqueePaint.setTextAlign(Paint.Align.LEFT);
        this.m_marqueePaint.setFilterBitmap(true);
        this.m_marqueePaint.setAntiAlias(true);
        setFocusable(true);
        setFocusableInTouchMode(true);
    }

    public final void newState(int i) {
        String diskFilename;
        String string;
        int length;
        StringBuilder sbAppend;
        int i2;
        String string2;
        while (i != -1) {
            Debug.log("newState=" + i);
            if (this.m_widgets.size() > 0 && !(this.m_widgets.elementAt(0) instanceof GluTitlebar)) {
                this.m_widgets.removeAllElements();
            }
            if (this.m_widgets.size() == 0) {
                GluTitlebar gluTitlebar = new GluTitlebar(GluUtil.getString(R.string.app_name));
                gluTitlebar.setBounds(0, 0, this.m_screenWidth, 0);
                this.m_widgets.addElement(gluTitlebar);
            } else {
                while (this.m_widgets.size() > 1) {
                    this.m_widgets.removeElementAt(1);
                }
            }
            switch (i) {
                case 1:
                    if (!GluDownloadResMgr.instance.performSpecialChecksumAsync()) {
                        createTextOnlyLayout(GluUtil.getString(R.string.IDS_CHECKSUM));
                    } else {
                        i = 2;
                    }
                    break;
                case 2:
                    this.m_checksumPassed = true;
                    this.m_checksumDone = true;
                    this.m_specialCheckPassed = false;
                    if (!this.m_specialCheckPassed) {
                        int[] iArr = new int[3];
                        GluDownloadResMgr gluDownloadResMgr = GluDownloadResMgr.instance;
                        GluDownloadResMgr.getSpecialStartPosition(iArr);
                        if (iArr[0] > 0) {
                            this.m_specialCheckPassed = GluDownloadResMgr.instance.verifySpecialFileIntegrity();
                            if (this.m_specialCheckPassed) {
                                GluDownloadResMgr.instance.setSecondaryFilesPassed(this.m_specialCheckPassed);
                            } else if (!this.m_specialCheckPassed && GluDownloadResMgr.instance.m_secondaryFilesPassedOnce) {
                                GluDownloadResMgr.instance.setSecondaryFilesPassed(false);
                                if (!GluDownloadResMgr.instance.wereSpecialFilesChecksummed()) {
                                    GluDownloadResMgr gluDownloadResMgr2 = GluDownloadResMgr.instance;
                                    GluDownloadResMgr.deleteSpecialFiles();
                                }
                            }
                        } else {
                            i = 3;
                        }
                    } else {
                        int[] iArr2 = new int[3];
                        GluDownloadResMgr gluDownloadResMgr3 = GluDownloadResMgr.instance;
                        GluDownloadResMgr.getSpecialStartPosition(iArr2);
                        if (iArr2[0] <= 0) {
                            this.m_specialCheckPassed = false;
                            if (GluDownloadResMgr.instance.m_secondaryFilesPassedOnce && !GluDownloadResMgr.instance.wereSpecialFilesChecksummed()) {
                                GluDownloadResMgr gluDownloadResMgr4 = GluDownloadResMgr.instance;
                                GluDownloadResMgr.deleteSpecialFiles();
                            }
                            GluDownloadResMgr.instance.setSecondaryFilesPassed(false);
                        }
                    }
                    break;
                case 3:
                    String str = (this.m_prevState != 1 || this.m_checksumError == null) ? "" : this.m_checksumError + "\n";
                    if (this.m_checksumPassed) {
                        sbAppend = new StringBuilder().append(str);
                        i2 = R.string.IDS_DOWNLOAD_PROMPT_WITH_SPECIAL;
                    } else {
                        sbAppend = new StringBuilder().append(str);
                        GluDownloadResMgr gluDownloadResMgr5 = GluDownloadResMgr.instance;
                        i2 = GluDownloadResMgr.areThereSpecialFiles() ? R.string.IDS_DOWNLOAD_PROMPT_WITH_SPECIAL : R.string.IDS_DOWNLOAD_PROMPT;
                    }
                    createPromptLayout(sbAppend.append(String.format(GluUtil.getString(i2), GluUtil.getKilobyteString(getAllFilesBytesTotal()))).toString(), 0, GluUtil.getString(R.string.IDS_DOWNLOAD_OPTION_PHONE_MEMORY), 1, GluUtil.getString(R.string.IDS_DOWNLOAD_OPTION_SD_CARD));
                    break;
                case 4:
                    showWiFiPopup();
                    if (GluDownloadResMgr.instance.m_mainResFileInterrupted) {
                        File file = new File(GluUtil.getDiskFilename());
                        if (file.exists()) {
                            length = (int) file.length();
                        } else {
                            File file2 = new File(GluUtil.getPrimaryResSDCardFilename());
                            length = file2.exists() ? (int) file2.length() : 0;
                        }
                        this.m_bytesDownloaded = length;
                    } else {
                        this.m_bytesDownloaded = 0;
                    }
                    String string3 = GluUtil.getString(R.string.IDS_DOWNLOADING);
                    Object[] objArr = new Object[1];
                    if (getAllFilesBytesTotal() == 0) {
                        string = "0%";
                    } else {
                        StringBuilder sb = new StringBuilder();
                        int i3 = this.m_state;
                        string = sb.append((int) ((100.0d * ((double) getAllFilesBytesDownloaded$134621())) / ((double) getAllFilesBytesTotal()))).append("%").toString();
                    }
                    objArr[0] = string;
                    createTextOnlyLayout(String.format(string3, objArr));
                    if (this.m_downloadToDisk) {
                        this.m_downloadFilename = GluUtil.getDiskFilename();
                        this.m_tempFilename = GluUtil.getTempDiskFilename();
                    } else {
                        this.m_downloadFilename = GluUtil.getPrimaryResSDCardFilename();
                        this.m_tempFilename = GluUtil.getTempSDCardFilename();
                    }
                    this.m_downloadError = null;
                    this.m_downloadDone = false;
                    this.m_downloadFailed = false;
                    this.m_downloadCancelled = false;
                    GluDownloadResMgr.instance.downloadResFile();
                    break;
                case 5:
                    showWiFiPopup();
                    GluDownloadResMgr.instance.m_specialCurrentFilename = null;
                    createTextOnlyLayout("");
                    if (this.m_downloadToDisk) {
                        this.m_downloadFilename = GluUtil.getDiskFilename();
                        this.m_tempFilename = GluUtil.getTempDiskFilename();
                        diskFilename = GluUtil.getPrimaryResSDCardFilename();
                    } else {
                        this.m_downloadFilename = GluUtil.getPrimaryResSDCardFilename();
                        this.m_tempFilename = GluUtil.getTempSDCardFilename();
                        diskFilename = GluUtil.getDiskFilename();
                    }
                    Debug.log("Download filename is: " + this.m_downloadFilename);
                    File file3 = new File(diskFilename);
                    if (file3.exists()) {
                        file3.delete();
                    }
                    GluDownloadResMgr gluDownloadResMgr6 = GluDownloadResMgr.instance;
                    GluDownloadResMgr.createDummyPrimaryResource(this.m_downloadFilename);
                    this.m_downloadError = null;
                    this.m_downloadDone = false;
                    this.m_downloadFailed = false;
                    this.m_downloadCancelled = false;
                    GluDownloadResMgr.instance.downloadSpecialResFile();
                    break;
                case 6:
                    this.m_preparingTimer = 10000;
                    createTextOnlyLayout(GluUtil.getString(R.string.IDS_PREPARING));
                    break;
                case 7:
                    createPromptLayout(this.m_downloadError, 6, GluUtil.getString(R.string.IDS_RETRY), 7, GluUtil.getString(R.string.IDS_EXIT));
                    break;
                case 8:
                    createPromptLayout(String.format(GluUtil.getString(GluDownloadResMgr.instance.wereSpecialFilesChecksummed() ? R.string.IDS_DOWNLOAD_AFTER_UPDATE : R.string.IDS_DOWNLOAD_RESUME_PROMPT), this.m_downloadToDisk ? GluUtil.getString(R.string.IDS_DOWNLOAD_OPTION_PHONE_MEMORY) : GluUtil.getString(R.string.IDS_DOWNLOAD_OPTION_SD_CARD)), 10, GluUtil.getString(R.string.IDS_RESUME), 11, GluUtil.getString(R.string.IDS_RESTART));
                    break;
                case 9:
                    createPromptLayout(GluUtil.getString(R.string.IDS_RESTART_CONFIRM), 8, GluUtil.getString(R.string.IDS_YES), 9, GluUtil.getString(R.string.IDS_NO));
                    break;
                case 10:
                    i = 14;
                    continue;
                case 11:
                    createPromptLayout(String.format(GluUtil.getString(R.string.IDS_DELETE_CONFIRM), GluUtil.getKilobyteString(getAllFilesBytesTotal())) + "", 4, GluUtil.getString(R.string.IDS_YES), 5, GluUtil.getString(R.string.IDS_NO));
                    break;
                case 12:
                    GluDownloadResMgr.instance.setSecondaryFilesPassed(false);
                    GluDownloadResMgr gluDownloadResMgr7 = GluDownloadResMgr.instance;
                    GluDownloadResMgr.deleteSpecialFiles();
                    File file4 = new File(GluUtil.getDiskFilename());
                    Debug.log("Deleting " + file4.getAbsolutePath());
                    if (file4.delete()) {
                        this.m_deleteMessage = GluUtil.getString(R.string.IDS_DELETE_SUCCESS);
                    } else {
                        this.m_deleteMessage = GluUtil.getString(R.string.IDS_DELETE_FAILED);
                    }
                    createTextOnlyLayout(this.m_deleteMessage);
                    break;
                case 13:
                    i = 14;
                    continue;
                case 14:
                    Debug.log("new state play");
                    break;
                case 15:
                    GameLet.instance.finishApp();
                    break;
                case 100:
                    createPromptLayout(this.m_sdErrorText, this.m_sdButtonPositive, getSDButtonText(this.m_sdButtonPositive), this.m_sdButtonNegative, getSDButtonText(this.m_sdButtonNegative));
                    break;
                default:
                    Debug.log("newState() unhandled state: " + i);
                    break;
            }
            if (i == 3) {
                string2 = GameLet.instance.m_platformVersionI < 5 ? GluUtil.getString(R.string.IDS_DOWNLOAD_PROMPT_TOOLTIP_16) : GluUtil.getString(R.string.IDS_DOWNLOAD_PROMPT_TOOLTIP);
            } else if (i == 4 || i == 5) {
                string2 = GameLet.instance.m_platformVersionI < 5 ? GluUtil.getString(R.string.IDS_DOWNLOAD_PROMPT_TOOLTIP_16) : GluUtil.getString(R.string.IDS_DOWNLOAD_PROMPT_TOOLTIP) + " " + GluUtil.getString(R.string.IDS_DOWNLOADING_TOOLTIP_ADDENDUM);
            } else {
                string2 = null;
            }
            if (string2 != null) {
                int iScaleRelativeToG1 = GluUtil.scaleRelativeToG1(38);
                int i4 = iScaleRelativeToG1 == 0 ? TOOLTIP_PADDING >> 1 : TOOLTIP_PADDING;
                int i5 = TOOLTIP_PADDING;
                GluTooltip gluTooltip = new GluTooltip(string2);
                gluTooltip.setBounds((GluUtil.getScreenWidth() - this.m_tooltipImg.getIntrinsicWidth()) - i5, i4 + iScaleRelativeToG1, this.m_tooltipImg.getIntrinsicWidth(), this.m_tooltipImg.getIntrinsicHeight());
                this.m_widgets.addElement(gluTooltip);
            }
            this.m_prevState = this.m_state;
            this.m_state = i;
            return;
        }
    }

    /* JADX WARN: Code duplicated, block: B:101:0x0277  */
    /* JADX WARN: Code duplicated, block: B:103:0x027b  */
    /* JADX WARN: Code duplicated, block: B:105:0x0288  */
    /* JADX WARN: Code duplicated, block: B:107:0x028c  */
    /* JADX WARN: Code duplicated, block: B:17:0x004f  */
    /* JADX WARN: Code duplicated, block: B:181:0x043e  */
    /* JADX WARN: Code duplicated, block: B:183:0x0442  */
    /* JADX WARN: Code duplicated, block: B:203:0x0484  */
    /* JADX WARN: Code duplicated, block: B:86:0x0246  */
    /* JADX WARN: Code duplicated, block: B:88:0x024b  */
    /* JADX WARN: Code duplicated, block: B:90:0x0258  */
    /* JADX WARN: Code duplicated, block: B:92:0x0262  */
    /* JADX WARN: Code duplicated, block: B:93:0x0264  */
    @Override // android.view.View
    public void onDraw(Canvas canvas) {
        int i;
        String string;
        String string2;
        int[] iArr;
        int i2;
        long jCurrentTimeMillis = System.currentTimeMillis();
        int i3 = (int) (jCurrentTimeMillis - this.m_lastTickTime);
        int i4 = this.m_activeWidget != null ? this.m_activeWidget.m_widgetID : -2;
        if (this.m_widgets != null) {
            int i5 = 0;
            while (true) {
                int i6 = i5;
                if (i6 >= this.m_widgets.size()) {
                    break;
                }
                GluWidget gluWidgetElementAt = this.m_widgets.elementAt(i6);
                if (gluWidgetElementAt != null) {
                    gluWidgetElementAt.tick(i3);
                }
                i5 = i6 + 1;
            }
        }
        switch (this.m_state) {
            case PushPreferences.QuietTime.NOT_SET_VAL /* -1 */:
            case 0:
                boolean zCleanupOldSDDir = GluUtil.cleanupOldSDDir();
                this.m_sdErrorText = null;
                File file = new File(GluUtil.getDiskFilename());
                if (!zCleanupOldSDDir && GluDownloadResMgr.instance.m_secondaryFilesPassedOnce && !file.exists()) {
                    String externalStorageState = Environment.getExternalStorageState();
                    Debug.log("SD storage state: " + externalStorageState);
                    if (externalStorageState.equals("shared")) {
                        this.m_sdErrorText = String.format(GluUtil.getString(R.string.IDS_SD_STARTUP_COMPUTER_ACCESSING), GluUtil.getString(R.string.app_name));
                        this.m_sdButtonPositive = 18;
                        this.m_sdButtonNegative = 19;
                    } else if (externalStorageState.equals("checking")) {
                        this.m_sdErrorText = String.format(GluUtil.getString(R.string.IDS_SD_STARTUP_CHECKING), GluUtil.getString(R.string.app_name));
                        this.m_sdButtonPositive = 18;
                        this.m_sdButtonNegative = 19;
                    } else if (externalStorageState.equals("removed") || externalStorageState.equals("bad_removal")) {
                        this.m_sdErrorText = String.format(GluUtil.getString(R.string.IDS_SD_STARTUP_NO_SD_CARD), GluUtil.getString(R.string.app_name));
                        this.m_sdButtonPositive = 17;
                        this.m_sdButtonNegative = 19;
                    } else if (externalStorageState.equals("nofs") || externalStorageState.equals("unmountable") || externalStorageState.equals("unmounted")) {
                        this.m_sdErrorText = String.format(GluUtil.getString(R.string.IDS_SD_STARTUP_GENERIC_UNMOUNTED), GluUtil.getString(R.string.app_name));
                        this.m_sdButtonPositive = 17;
                        this.m_sdButtonNegative = 19;
                    } else if (!new File(GluUtil.getPrimaryResSDCardFilename()).exists()) {
                        this.m_sdErrorText = String.format(GluUtil.getString(R.string.IDS_SD_STARTUP_WRONG_SD_CARD), GluUtil.getString(R.string.app_name));
                        this.m_sdButtonPositive = 17;
                        this.m_sdButtonNegative = 19;
                    }
                }
                if (this.m_sdErrorText == null) {
                    i = !GluDownloadResMgr.instance.m_mainResFileInterrupted ? 1 : 8;
                } else {
                    i = 100;
                }
                break;
            case 1:
                if (!GluDownloadResMgr.instance.specialFilesChecksumInProgress()) {
                    i = 2;
                } else {
                    i = -1;
                }
                break;
            case 2:
                if (!this.m_checksumDone) {
                    if (!this.m_checksumInProgress) {
                        boolean z = false;
                        this.m_checksumError = null;
                        this.m_checksumInProgress = true;
                        String diskFilename = GluUtil.getDiskFilename();
                        File file2 = new File(diskFilename);
                        Debug.log("testing: " + diskFilename + "   exists=" + file2.exists());
                        if (file2.exists()) {
                            this.m_checksumError = GluUtil.performChecksum(file2);
                            z = this.m_checksumError == null;
                        } else {
                            String primaryResSDCardFilename = GluUtil.getPrimaryResSDCardFilename();
                            File file3 = new File(primaryResSDCardFilename);
                            Debug.log("testing: " + primaryResSDCardFilename + "   exists=" + file3.exists());
                            if (file3.exists()) {
                                this.m_checksumError = GluUtil.performChecksum(file3);
                                z = this.m_checksumError == null;
                                if (z) {
                                    this.m_usesAltSDCardPath = true;
                                }
                            }
                        }
                        if (this.m_checksumError != null && !GluDownloadResMgr.instance.m_mainResFileInterrupted) {
                            if (!GluDownloadResMgr.instance.wereSpecialFilesChecksummed()) {
                                GluDownloadResMgr gluDownloadResMgr = GluDownloadResMgr.instance;
                                GluDownloadResMgr.deleteSpecialFiles();
                            }
                            GluDownloadResMgr.instance.setSecondaryFilesPassed(false);
                            deleteResFile();
                        }
                        this.m_checksumPassed = z;
                        this.m_specialCheckPassed = GluDownloadResMgr.instance.verifySpecialFileIntegrity();
                        this.m_checksumDone = true;
                        this.m_checksumInProgress = false;
                        i = -1;
                    } else {
                        i = -1;
                    }
                } else if (this.m_checksumPassed && this.m_specialCheckPassed) {
                    if (this.m_prevState == -1 && resourceIsOnDisk()) {
                        i = 10;
                    } else {
                        i = 13;
                    }
                } else if (this.m_checksumPassed) {
                    GluDownloadResMgr gluDownloadResMgr2 = GluDownloadResMgr.instance;
                    if (GluDownloadResMgr.areThereSpecialFiles()) {
                        i = 8;
                    } else if (this.m_prevState != -1) {
                        iArr = new int[3];
                        GluDownloadResMgr gluDownloadResMgr3 = GluDownloadResMgr.instance;
                        GluDownloadResMgr.getSpecialStartPosition(iArr);
                        if (iArr[0] > 0) {
                            i2 = 8;
                        } else {
                            i2 = 3;
                        }
                        GluDownloadResMgr.instance.initialize();
                        i = i2;
                    } else if (this.m_prevState != 4 || this.m_prevState == 5 || this.m_prevState == 6) {
                        if (this.m_checksumPassed) {
                            if (this.m_checksumError == null) {
                                this.m_checksumError = GluUtil.getString(R.string.IDS_DOWNLOAD_FAILED_COULD_NOT_SAVE);
                            }
                            this.m_downloadError = this.m_checksumError;
                        } else if (this.m_downloadError == null) {
                            this.m_downloadError = GluUtil.getString(R.string.IDS_SPECIAL_DOWNLOAD_FAILED_CHECK);
                        }
                        i = 7;
                    } else {
                        i = -1;
                    }
                } else if (this.m_prevState != -1) {
                    if (this.m_prevState != 4) {
                    }
                    if (this.m_checksumPassed) {
                        if (this.m_checksumError == null) {
                            this.m_checksumError = GluUtil.getString(R.string.IDS_DOWNLOAD_FAILED_COULD_NOT_SAVE);
                        }
                        this.m_downloadError = this.m_checksumError;
                    } else if (this.m_downloadError == null) {
                        this.m_downloadError = GluUtil.getString(R.string.IDS_SPECIAL_DOWNLOAD_FAILED_CHECK);
                    }
                    i = 7;
                } else {
                    iArr = new int[3];
                    GluDownloadResMgr gluDownloadResMgr4 = GluDownloadResMgr.instance;
                    GluDownloadResMgr.getSpecialStartPosition(iArr);
                    if (iArr[0] > 0) {
                        i2 = 8;
                    } else {
                        i2 = 3;
                    }
                    GluDownloadResMgr.instance.initialize();
                    i = i2;
                }
                break;
            case 3:
                if (this.m_backPressed) {
                    i = 15;
                } else if (i4 == 0) {
                    this.m_downloadToDisk = true;
                    i = this.m_checksumPassed ? 5 : 4;
                } else if (i4 != 1) {
                    i = -1;
                } else if (GluUtil.getResourceSDDir() != null) {
                    int i7 = this.m_checksumPassed ? 5 : 4;
                    this.m_downloadToDisk = false;
                    i = i7;
                } else {
                    this.m_downloadError = GluUtil.getString(R.string.IDS_DOWNLOAD_FAILED_NO_SD_CARD);
                    i = 7;
                }
                break;
            case 4:
            case 5:
                if (this.m_widgets.size() > 0) {
                    GluWidget gluWidgetElementAt2 = this.m_widgets.elementAt(0);
                    if (!(gluWidgetElementAt2 instanceof GluTextArea) && this.m_widgets.size() > 1) {
                        gluWidgetElementAt2 = this.m_widgets.elementAt(1);
                    }
                    if (gluWidgetElementAt2 instanceof GluTextArea) {
                        if (this.m_downloadCancelled) {
                            string2 = GluUtil.getString(R.string.IDS_PLEASE_WAIT);
                        } else {
                            String string3 = GluUtil.getString(R.string.IDS_DOWNLOADING);
                            Object[] objArr = new Object[1];
                            if (getAllFilesBytesTotal() == 0) {
                                string = "0%";
                            } else {
                                StringBuilder sb = new StringBuilder();
                                int i8 = this.m_state;
                                string = sb.append((int) ((100.0d * ((double) getAllFilesBytesDownloaded$134621())) / ((double) getAllFilesBytesTotal()))).append("%").toString();
                            }
                            objArr[0] = string;
                            string2 = String.format(string3, objArr);
                        }
                        GluTextArea gluTextArea = (GluTextArea) gluWidgetElementAt2;
                        gluTextArea.m_text = string2;
                        gluTextArea.m_wrappedText = GluUtil.wrapText(gluTextArea.m_text, gluTextArea.m_dx - gluTextArea.m_x, gluTextArea.m_paint);
                    }
                }
                if (this.m_downloadFailed) {
                    i = 7;
                } else if (this.m_downloadDone) {
                    if (this.m_state == 4) {
                        GluDownloadResMgr gluDownloadResMgr5 = GluDownloadResMgr.instance;
                        if (GluDownloadResMgr.areThereSpecialFiles()) {
                            if (this.m_backPressed) {
                                i = -1;
                            } else {
                                this.m_downloadCancelled = true;
                                i = -1;
                            }
                            break;
                        }
                    }
                    i = 1;
                } else if (this.m_backPressed) {
                    i = -1;
                } else {
                    this.m_downloadCancelled = true;
                    i = -1;
                }
                break;
            case 6:
                if (this.m_preparingTimer <= 0) {
                    i = 1;
                } else if (!GluUtil.isAppPaused()) {
                    this.m_preparingTimer -= i3;
                    if (!this.m_backPressed) {
                        i = -1;
                    } else {
                        GameLet.instance.finishApp();
                        i = -1;
                    }
                } else {
                    i = -1;
                }
                break;
            case 7:
                if (this.m_backPressed) {
                    i = 15;
                } else if (i4 != 6) {
                    if (i4 != 7) {
                        i = -1;
                    } else {
                        i = 15;
                    }
                } else if (!GluDownloadResMgr.instance.m_mainResFileInterrupted) {
                    if (this.m_prevState == 5) {
                        GluDownloadResMgr gluDownloadResMgr6 = GluDownloadResMgr.instance;
                        if (GluDownloadResMgr.areSpecialFilesSequential()) {
                            i = 8;
                        }
                    }
                    i = this.m_prevState != 5 ? 3 : 1;
                } else {
                    i = 8;
                }
                break;
            case 8:
                if (this.m_backPressed) {
                    i = 15;
                } else if (i4 != 10) {
                    if (i4 != 11) {
                        i = -1;
                    } else {
                        i = 9;
                    }
                } else if (!this.m_downloadToDisk && GluUtil.getResourceSDDir() == null) {
                    this.m_downloadError = GluUtil.getString(R.string.IDS_DOWNLOAD_FAILED_NO_SD_CARD);
                    i = 7;
                } else {
                    i = this.m_checksumPassed ? 5 : 4;
                }
                break;
            case 9:
                if (this.m_backPressed) {
                    i = 8;
                } else if (i4 == 8) {
                    GluDownloadResMgr.instance.setSecondaryFilesPassed(false);
                    GluDownloadResMgr gluDownloadResMgr7 = GluDownloadResMgr.instance;
                    GluDownloadResMgr.deleteSpecialFiles();
                    deleteResFile();
                    GluDownloadResMgr.instance.m_mainResFileInterrupted = false;
                    GluDownloadResMgr.instance.saveFile();
                    i = 3;
                } else if (i4 != 9) {
                    i = -1;
                } else {
                    i = 8;
                }
                break;
            case 10:
                if (this.m_backPressed) {
                    i = 15;
                } else if (i4 == 2) {
                    i = 13;
                } else if (i4 != 3) {
                    i = -1;
                } else {
                    i = 11;
                }
                break;
            case 11:
                if (this.m_backPressed) {
                    i = 10;
                } else if (i4 == 4) {
                    i = 12;
                } else if (i4 != 5) {
                    i = -1;
                } else {
                    i = 10;
                }
                break;
            case 12:
                if (this.m_backPressed || this.m_pointerLatched) {
                    i = 15;
                } else {
                    i = -1;
                }
                break;
            case 13:
                i = -1;
                break;
            case 14:
                if (!this.gameStarted && hasWindowFocus()) {
                    this.gameStarted = true;
                    GameLet.instance.startGame();
                    i = -1;
                } else {
                    i = -1;
                }
                break;
            case 100:
                if (i4 == 17) {
                    GluDownloadResMgr.instance.setSecondaryFilesPassed(false);
                    GluDownloadResMgr gluDownloadResMgr8 = GluDownloadResMgr.instance;
                    GluDownloadResMgr.deleteSpecialFiles();
                    deleteResFile();
                    GluDownloadResMgr.instance.m_mainResFileInterrupted = false;
                    GluDownloadResMgr.instance.saveFile();
                    i = 0;
                } else if (i4 == 18) {
                    i = 0;
                } else if (i4 == 19 || this.m_backPressed) {
                    i = 15;
                } else {
                    i = -1;
                }
                break;
            default:
                Debug.log("onTick() unhandled state: -1");
                i = -1;
                break;
        }
        if (i4 == 12) {
            GluUtil.openModalDialog(((GluTooltip) this.m_activeWidget).m_popupTitle, ((GluTooltip) this.m_activeWidget).m_popupText, GluUtil.getString(R.string.IDS_OK));
        }
        this.m_pointerLatched = false;
        this.m_backPressed = false;
        this.m_activeWidget = null;
        if (ResDownloadViewGroup.instance != null) {
            ResDownloadViewGroup resDownloadViewGroup = ResDownloadViewGroup.instance;
            ResDownloadViewGroup.tick$13462e();
        }
        newState(i);
        this.m_lastTickTime = jCurrentTimeMillis;
        if (this.m_screenHeight > this.m_screenWidth) {
            int i9 = this.m_screenWidth;
            int intrinsicHeight = (this.m_mutedLogoImg.getIntrinsicHeight() * i9) / this.m_mutedLogoImg.getIntrinsicWidth();
            int i10 = (this.m_screenHeight - intrinsicHeight) >> 1;
            this.m_mutedLogoImg.setBounds(0, i10, i9, intrinsicHeight + i10);
        } else {
            int i11 = this.m_screenHeight - 60;
            int intrinsicWidth = (this.m_mutedLogoImg.getIntrinsicWidth() * i11) / this.m_mutedLogoImg.getIntrinsicHeight();
            int i12 = (this.m_screenWidth - intrinsicWidth) >> 1;
            int i13 = (this.m_screenHeight - i11) >> 1;
            this.m_mutedLogoImg.setBounds(i12, i13, intrinsicWidth + i12, i11 + i13);
        }
        int i14 = 0;
        while (true) {
            int i15 = i14;
            if (i15 >= this.m_widgets.size()) {
                if (GluDownloadResMgr.instance.m_downloadThread != null) {
                    postInvalidateDelayed(100L);
                    return;
                } else {
                    postInvalidateDelayed(10L);
                    return;
                }
            }
            this.m_widgets.elementAt(i15).draw(canvas);
            i14 = i15 + 1;
        }
    }

    @Override // android.view.View, android.view.KeyEvent.Callback
    public boolean onKeyDown(int i, KeyEvent keyEvent) {
        Debug.log("ResFileDownloadView.onKeyDown(" + i + ")");
        return true;
    }

    @Override // android.view.View, android.view.KeyEvent.Callback
    public boolean onKeyUp(int i, KeyEvent keyEvent) {
        Debug.log("ResFileDownloadView.onKeyUp(" + i + ")");
        if (i == 4) {
            this.m_backPressed = true;
        }
        return true;
    }

    /* JADX WARN: Can't fix incorrect switch cases order, some code will duplicate */
    @Override // android.view.View
    public boolean onTouchEvent(MotionEvent motionEvent) {
        int x = (int) motionEvent.getX();
        int y = (int) motionEvent.getY();
        switch (motionEvent.getAction()) {
            case 0:
                this.m_pointerLatched = true;
                for (int i = 0; i < this.m_widgets.size(); i++) {
                    if (this.m_widgets.elementAt(i).containsCoords(x, y)) {
                        this.m_widgets.elementAt(i).pointerActive = true;
                    }
                }
                return true;
            case 1:
                for (int i2 = 0; i2 < this.m_widgets.size(); i2++) {
                    if (this.m_widgets.elementAt(i2).containsCoords(x, y)) {
                        GluWidget gluWidgetElementAt = this.m_widgets.elementAt(i2);
                        if (gluWidgetElementAt.pointerActive) {
                            ResFileDownloadView resFileDownloadView = gluWidgetElementAt.m_parent;
                            if ((gluWidgetElementAt instanceof GluButton) || (gluWidgetElementAt instanceof GluTooltip)) {
                                resFileDownloadView.m_activeWidget = gluWidgetElementAt;
                            }
                        }
                        gluWidgetElementAt.pointerActive = false;
                    } else {
                        this.m_widgets.elementAt(i2).pointerActive = false;
                    }
                }
                return true;
            case 2:
            default:
                return true;
        }
    }
}
