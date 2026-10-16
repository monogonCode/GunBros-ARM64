package com.openfeint.internal.notifications;

import android.content.Context;
import android.graphics.drawable.Drawable;
import android.view.View;
import android.widget.Toast;
import com.openfeint.api.Notification;
import com.openfeint.internal.OpenFeintInternal;
import java.util.HashMap;
import java.util.Map;

/* JADX INFO: loaded from: classes.dex */
public abstract class NotificationBase extends Notification {
    static Map<String, Drawable> drawableCache = new HashMap();
    private Notification.Category category;
    View displayView;
    protected String imageName;
    private String text;
    Toast toast;
    private Notification.Type type;
    private Map<String, Object> userData;

    protected NotificationBase(String str, String str2, Notification.Category category, Notification.Type type, Map<String, Object> map) {
        this.text = str;
        this.imageName = str2;
        this.category = category;
        this.type = type;
        this.userData = map;
    }

    static Drawable getResourceDrawable(String str) {
        if (!drawableCache.containsKey(str)) {
            OpenFeintInternal openFeintInternal = OpenFeintInternal.getInstance();
            int resource = openFeintInternal.getResource(str);
            if (resource == 0) {
                drawableCache.put(str, null);
            } else {
                drawableCache.put(str, openFeintInternal.getContext().getResources().getDrawable(resource));
            }
        }
        return drawableCache.get(str);
    }

    protected final void checkDelegateAndView() {
        getDelegate();
        getDelegate();
        if (createView()) {
            showToast();
        }
    }

    protected abstract boolean createView();

    public final String getText() {
        return this.text;
    }

    public final Map<String, Object> getUserData() {
        return this.userData;
    }

    protected final void showToast() {
        OpenFeintInternal.getInstance().runOnUiThread(new Runnable() { // from class: com.openfeint.internal.notifications.NotificationBase.1
            @Override // java.lang.Runnable
            public final void run() {
                Context context = OpenFeintInternal.getInstance().getContext();
                NotificationBase.this.toast = new Toast(context);
                NotificationBase.this.toast.setGravity(48, 0, 0);
                NotificationBase.this.toast.setDuration(1);
                NotificationBase.this.toast.setView(NotificationBase.this.displayView);
                NotificationBase.this.toast.show();
            }
        });
    }
}
