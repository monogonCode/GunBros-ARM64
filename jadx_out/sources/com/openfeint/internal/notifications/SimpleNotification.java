package com.openfeint.internal.notifications;

import android.graphics.Bitmap;
import android.graphics.drawable.BitmapDrawable;
import android.graphics.drawable.Drawable;
import android.view.LayoutInflater;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;
import com.openfeint.api.Notification;
import com.openfeint.internal.OpenFeintInternal;
import com.openfeint.internal.RR;
import com.openfeint.internal.logcat.OFLog;
import com.openfeint.internal.request.BitmapRequest;

/* JADX INFO: loaded from: classes.dex */
public final class SimpleNotification extends NotificationBase {
    private SimpleNotification(String str, String str2, Notification.Category category, Notification.Type type) {
        super(str, str2, category, type, null);
    }

    public static void show(String str, Notification.Category category, Notification.Type type) {
        show(str, null, category, type);
    }

    public static void show(String str, String str2, Notification.Category category, Notification.Type type) {
        new SimpleNotification(str, str2, category, type).checkDelegateAndView();
    }

    @Override // com.openfeint.internal.notifications.NotificationBase
    protected final boolean createView() {
        this.displayView = ((LayoutInflater) OpenFeintInternal.getInstance().getContext().getSystemService("layout_inflater")).inflate(RR.layout("of_simple_notification"), (ViewGroup) null);
        ((TextView) this.displayView.findViewById(RR.id("of_text"))).setText(getText());
        final ImageView imageView = (ImageView) this.displayView.findViewById(RR.id("of_icon"));
        if (this.imageName != null) {
            Drawable resourceDrawable = getResourceDrawable(this.imageName);
            if (resourceDrawable == null) {
                new BitmapRequest() { // from class: com.openfeint.internal.notifications.SimpleNotification.1
                    @Override // com.openfeint.internal.request.DownloadRequest
                    public final void onFailure(String str) {
                        OFLog.e("NotificationImage", "Failed to load image " + SimpleNotification.this.imageName + ":" + str);
                        imageView.setVisibility(4);
                        SimpleNotification.this.showToast();
                    }

                    @Override // com.openfeint.internal.request.BitmapRequest
                    public final void onSuccess(Bitmap bitmap) {
                        imageView.setImageDrawable(new BitmapDrawable(bitmap));
                        SimpleNotification.this.showToast();
                    }

                    @Override // com.openfeint.internal.request.BaseRequest
                    public final String path() {
                        return SimpleNotification.this.imageName;
                    }
                }.launch();
                return false;
            }
            imageView.setImageDrawable(resourceDrawable);
        } else {
            imageView.setVisibility(4);
        }
        return true;
    }
}
