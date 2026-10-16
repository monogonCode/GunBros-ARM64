package com.openfeint.api;

/* JADX INFO: loaded from: classes.dex */
public abstract class Notification {
    private static Delegate sDelegate = new Delegate();

    public enum Category {
        Foreground,
        Login,
        Challenge,
        HighScore,
        Leaderboard,
        Achievement,
        SocialNotification,
        Presence,
        Multiplayer
    }

    public static class Delegate {
    }

    public enum Type {
        None,
        Submitting,
        Downloading,
        Error,
        Success,
        NewResources,
        UserPresenceOnLine,
        UserPresenceOffline,
        NewMessage,
        Multiplayer,
        NetworkOffline
    }

    public static Delegate getDelegate() {
        return sDelegate;
    }
}
