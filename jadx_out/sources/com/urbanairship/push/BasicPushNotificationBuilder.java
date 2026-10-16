package com.urbanairship.push;

import android.app.Notification;
import com.urbanairship.UAirship;
import com.urbanairship.util.NotificationIDGenerator;
import java.util.Map;

/* JADX INFO: loaded from: classes.dex */
public class BasicPushNotificationBuilder implements PushNotificationBuilder {
    public int iconDrawableId = UAirship.getAppInfo().icon;
    public String appName = UAirship.getAppName();
    public int constantNotificationId = -1;

    @Override // com.urbanairship.push.PushNotificationBuilder
    public Notification buildNotification(String str, Map<String, String> map) {
        if (str == null || str.length() == 0) {
            return null;
        }
        Notification notification = new Notification(this.iconDrawableId, str, System.currentTimeMillis());
        notification.flags = 16;
        notification.setLatestEventInfo(UAirship.shared().getApplicationContext(), this.appName, str, null);
        notification.defaults = 0;
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
        notification.defaults |= 1;
        return notification;
    }

    @Override // com.urbanairship.push.PushNotificationBuilder
    public int getNextId(String str, Map<String, String> map) {
        return this.constantNotificationId > 0 ? this.constantNotificationId : NotificationIDGenerator.nextID();
    }
}
