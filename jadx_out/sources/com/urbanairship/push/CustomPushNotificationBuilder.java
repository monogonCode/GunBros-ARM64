package com.urbanairship.push;

import android.app.Notification;
import android.net.Uri;
import android.widget.RemoteViews;
import com.urbanairship.UAirship;
import com.urbanairship.util.NotificationIDGenerator;
import java.util.Map;

/* JADX INFO: loaded from: classes.dex */
public class CustomPushNotificationBuilder implements PushNotificationBuilder {
    public int layout;
    public int layoutIconId;
    public int layoutMessageId;
    public int layoutSubjectId;
    public Uri soundUri;
    public int layoutIconDrawableId = UAirship.getAppInfo().icon;
    public int statusBarIconDrawableId = UAirship.getAppInfo().icon;
    public int constantNotificationId = -1;

    @Override // com.urbanairship.push.PushNotificationBuilder
    public Notification buildNotification(String str, Map<String, String> map) {
        if (str == null || str.length() == 0) {
            return null;
        }
        Notification notification = new Notification(this.statusBarIconDrawableId, str, System.currentTimeMillis());
        notification.flags = 16;
        notification.defaults = 0;
        RemoteViews remoteViews = new RemoteViews(UAirship.shared().getApplicationContext().getPackageName(), this.layout);
        remoteViews.setTextViewText(this.layoutSubjectId, UAirship.getAppName());
        remoteViews.setTextViewText(this.layoutMessageId, str);
        remoteViews.setImageViewResource(this.layoutIconId, this.layoutIconDrawableId);
        notification.contentView = remoteViews;
        PushPreferences preferences = PushManager.shared().getPreferences();
        if (preferences.isInQuietTime()) {
            return notification;
        }
        if (preferences.isVibrateEnabled()) {
            notification.defaults |= 2;
        }
        if (!preferences.isSoundEnabled()) {
            return notification;
        }
        if (this.soundUri != null) {
            notification.sound = this.soundUri;
            return notification;
        }
        notification.defaults |= 1;
        return notification;
    }

    @Override // com.urbanairship.push.PushNotificationBuilder
    public int getNextId(String str, Map<String, String> map) {
        return this.constantNotificationId > 0 ? this.constantNotificationId : NotificationIDGenerator.nextID();
    }
}
