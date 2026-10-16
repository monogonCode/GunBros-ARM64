package com.glu.android.tools.community;

import com.glu.platform.android.GluPlatformActivity;
import com.glu.platform.android.resdl.Debug;
import com.openfeint.api.OpenFeintDelegate;
import com.openfeint.api.OpenFeintSettings;
import com.openfeint.api.resource.Achievement;
import com.openfeint.api.resource.Leaderboard;
import com.openfeint.api.resource.Score;
import com.openfeint.api.ui.Dashboard;
import com.openfeint.internal.OpenFeintInternal;

/* JADX INFO: loaded from: classes.dex */
public final class GluOpenFeint extends OpenFeintDelegate {
    private static boolean m_initialized = false;
    public static GluOpenFeint instance = null;
    public String OF_GAME_NAME = null;
    public String OF_KEY = null;
    public String OF_SECRET = null;
    public String OF_ID = null;
    public char[] DUMMY_CA_RETURN = new char[1];

    public GluOpenFeint() {
        instance = this;
    }

    private static char[] GluUtil_stringToNativeCharArray(String str) {
        char[] charArray = str.toCharArray();
        char[] cArr = new char[charArray.length + 1];
        for (int i = 0; i < charArray.length; i++) {
            cArr[i] = charArray[i];
        }
        cArr[charArray.length] = 0;
        return cArr;
    }

    public static int achievementEvent(int i, int i2, int i3, int i4) {
        String string = Integer.toString(i);
        if (!m_initialized || !OpenFeintInternal.getInstance().isUserLoggedIn()) {
            return 0;
        }
        Debug.log("Achievement event: " + string + " unlocked=" + i2 + " currentValue=" + i3 + " goalValue=" + i4);
        Achievement achievement = new Achievement(string);
        if (i3 != 0) {
            float f = i4 == 0 ? i3 : (i4 / i3) * 100.0f;
            if (f <= 100.0f && f > 0.0f) {
                achievement.updateProgression$45f61eed(f);
                if (f == 100.0f) {
                    i2 = 1;
                }
            }
        }
        if (i2 == 0) {
            return 1;
        }
        achievement.unlock$26d5f281();
        return 1;
    }

    public static int leaderboardEvent(int i, long j, float f) {
        int i2 = 0;
        String string = Integer.toString(i);
        if (m_initialized && OpenFeintInternal.getInstance().isUserLoggedIn()) {
            i2 = 1;
            Debug.log("Leaderboard event: " + string + " lScore=" + j + " fScore=" + f);
            if (f != 0.0f) {
                j = (long) f;
            }
            if (j != 0) {
                new Score(j).submitTo$487f3c2c(new Leaderboard(string));
            }
        }
        return i2;
    }

    /* JADX WARN: Can't fix incorrect switch cases order, some code will duplicate */
    /* JADX WARN: Code duplicated, block: B:22:0x0050  */
    public final char[] communityEvent(int i, int i2, String str) {
        int i3 = 1;
        if (i == 7) {
            GluPlatformActivity.instance.m_Terminator.sendEmptyMessage(7);
            i3 = 0;
        } else if (i == 10) {
            this.OF_GAME_NAME = new String(str);
            i3 = 0;
        } else if (i == 11) {
            this.OF_KEY = new String(str);
            i3 = 0;
        } else if (i == 12) {
            this.OF_SECRET = new String(str);
            i3 = 0;
        } else if (i == 13) {
            this.OF_ID = new String(str);
            i3 = 0;
        } else if (m_initialized) {
            switch (i) {
                case 1:
                    Dashboard.open();
                    i3 = 0;
                    break;
                case 2:
                    Dashboard.openAchievements();
                    i3 = 0;
                    break;
                case 3:
                    new String(str);
                    Dashboard.open("leaderboards", false);
                    i3 = 0;
                    break;
                case 4:
                    break;
                case 5:
                case 6:
                    return OpenFeintInternal.getInstance().isUserLoggedIn() ? GluUtil_stringToNativeCharArray(OpenFeintInternal.getInstance().getCurrentUser().name) : GluUtil_stringToNativeCharArray("Player");
                case 7:
                case 8:
                case 10:
                case 11:
                case 12:
                case 13:
                default:
                    i3 = 0;
                    break;
                case 9:
                    boolean z = m_initialized;
                    break;
                case 14:
                    break;
                case 15:
                    Dashboard.openUser(i2 + "");
                    i3 = 0;
                    break;
                case 16:
                    if (OpenFeintInternal.getInstance().isUserLoggedIn()) {
                        return GluUtil_stringToNativeCharArray(OpenFeintInternal.getInstance().getCurrentUser().userID());
                    }
                    Debug.log("WARNING: Requested username when they're not logged in. Using default.");
                    return GluUtil_stringToNativeCharArray("0");
            }
            if (!m_initialized || !OpenFeintInternal.getInstance().isUserLoggedIn()) {
                i3 = 0;
            }
        } else {
            i3 = 0;
        }
        this.DUMMY_CA_RETURN[0] = (char) i3;
        return this.DUMMY_CA_RETURN;
    }

    public final void initialize() {
        if (this.OF_GAME_NAME == null || this.OF_KEY == null || this.OF_SECRET == null || this.OF_ID == null) {
            throw new RuntimeException("Insufficient info to initialize openfeint.");
        }
        OpenFeintInternal.initializeWithoutLoggingIn(GluPlatformActivity.instance, new OpenFeintSettings(this.OF_GAME_NAME, this.OF_KEY, this.OF_SECRET, this.OF_ID), this);
        OpenFeintInternal openFeintInternal = OpenFeintInternal.getInstance();
        if (openFeintInternal != null) {
            openFeintInternal.login(false);
        }
        m_initialized = true;
    }
}
