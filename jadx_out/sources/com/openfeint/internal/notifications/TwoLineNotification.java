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
import java.util.HashMap;
import java.util.Map;

/* JADX INFO: loaded from: classes.dex */
public final class TwoLineNotification extends NotificationBase {
    private TwoLineNotification(String str, Notification.Category category, Notification.Type type, Map<String, Object> map) {
        super(str, null, category, type, map);
    }

    public static void show(String str, String str2, Notification.Category category, Notification.Type type) {
        HashMap map = new HashMap();
        map.put("extra", str2);
        new TwoLineNotification(str, category, type, map).checkDelegateAndView();
    }

    @Override // com.openfeint.internal.notifications.NotificationBase
    protected final boolean createView() {
        this.displayView = ((LayoutInflater) OpenFeintInternal.getInstance().getContext().getSystemService("layout_inflater")).inflate(RR.layout("of_two_line_notification"), (ViewGroup) null);
        ((TextView) this.displayView.findViewById(RR.id("of_text1"))).setText(getText());
        ((TextView) this.displayView.findViewById(RR.id("of_text2"))).setText((String) getUserData().get("extra"));
        final ImageView imageView = (ImageView) this.displayView.findViewById(RR.id("of_icon"));
        if (this.imageName != null) {
            Drawable resourceDrawable = getResourceDrawable(this.imageName);
            if (resourceDrawable == null) {
                new BitmapRequest() { // from class: com.openfeint.internal.notifications.TwoLineNotification.1
                    @Override // com.openfeint.internal.request.DownloadRequest
                    public final void onFailure(String str) {
                        OFLog.e("NotificationImage", "Failed to load image " + TwoLineNotification.this.imageName + ":" + str);
                        imageView.setVisibility(4);
                        TwoLineNotification.this.showToast();
                    }

                    @Override // com.openfeint.internal.request.BitmapRequest
                    public final void onSuccess(Bitmap bitmap) {
                        imageView.setImageDrawable(new BitmapDrawable(bitmap));
                        TwoLineNotification.this.showToast();
                    }

                    @Override // com.openfeint.internal.request.BaseRequest
                    public final String path() {
                        return TwoLineNotification.this.imageName;
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
