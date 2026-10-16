package com.urbanairship.push;

import android.app.Notification;
import java.util.Map;

/* JADX INFO: loaded from: classes.dex */
public interface PushNotificationBuilder {
    Notification buildNotification(String str, Map<String, String> map);

    int getNextId(String str, Map<String, String> map);
}
