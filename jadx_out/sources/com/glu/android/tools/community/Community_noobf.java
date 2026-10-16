package com.glu.android.tools.community;

import android.app.Activity;

/* JADX INFO: loaded from: classes.dex */
public class Community_noobf extends Activity {
    public static final int COMMUNITY_EVENT_DESTROY = 8;
    public static final int COMMUNITY_EVENT_DISPLAY_ACHIEVEMENTS = 2;
    public static final int COMMUNITY_EVENT_DISPLAY_LEADERBOARDS = 3;
    public static final int COMMUNITY_EVENT_GET_ACHIEVEMENT_USERNAME = 5;
    public static final int COMMUNITY_EVENT_GET_LEADERBOARD_USERNAME = 6;
    public static final int COMMUNITY_EVENT_GET_USER_ID = 16;
    public static final int COMMUNITY_EVENT_INITIALIZE = 7;
    public static final int COMMUNITY_EVENT_IS_INIT = 9;
    public static final int COMMUNITY_EVENT_IS_SUPPORTED = 4;
    public static final int COMMUNITY_EVENT_IS_USER_LOGGED_IN = 14;
    public static final int COMMUNITY_EVENT_OPEN_USER_PROFILE = 15;
    public static final int COMMUNITY_EVENT_QUEUE_GAME_NAME = 10;
    public static final int COMMUNITY_EVENT_QUEUE_ID = 13;
    public static final int COMMUNITY_EVENT_QUEUE_KEY = 11;
    public static final int COMMUNITY_EVENT_QUEUE_SECRET = 12;
    public static final int COMMUNITY_EVENT_SHOW_DASH = 1;
    public static char[] DUMMY_CA_RETURN = {0};

    public static int achievementEvent(int i, int i2, int i3, int i4) {
        initIfNeeded();
        GluOpenFeint gluOpenFeint = GluOpenFeint.instance;
        return GluOpenFeint.achievementEvent(i, i2, i3, i4);
    }

    public static char[] communityEvent(int i, int i2, String str) {
        initIfNeeded();
        if (i != 8) {
            return GluOpenFeint.instance.communityEvent(i, i2, str);
        }
        GluOpenFeint.instance = null;
        return DUMMY_CA_RETURN;
    }

    private static void initIfNeeded() {
        if (GluOpenFeint.instance == null) {
            new GluOpenFeint();
        }
    }

    public static int leaderboardEvent(int i, long j, float f) {
        initIfNeeded();
        GluOpenFeint gluOpenFeint = GluOpenFeint.instance;
        return GluOpenFeint.leaderboardEvent(i, j, f);
    }

    private static void onNativeShutdown() {
        GluOpenFeint.instance = null;
    }
}
