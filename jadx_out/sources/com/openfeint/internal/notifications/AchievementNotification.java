package com.openfeint.internal.notifications;

import android.graphics.Bitmap;
import android.graphics.drawable.BitmapDrawable;
import android.graphics.drawable.Drawable;
import android.view.LayoutInflater;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;
import com.openfeint.api.Notification;
import com.openfeint.api.resource.Achievement;
import com.openfeint.internal.OpenFeintInternal;
import com.openfeint.internal.RR;
import com.openfeint.internal.logcat.OFLog;
import com.openfeint.internal.request.ExternalBitmapRequest;
import java.util.HashMap;
import java.util.Map;

/* JADX INFO: loaded from: classes.dex */
public final class AchievementNotification extends NotificationBase {
    private AchievementNotification(Map<String, Object> map) {
        super(OpenFeintInternal.getRString(RR.string("of_achievement_unlocked")), null, Notification.Category.Achievement, Notification.Type.Success, map);
    }

    public static void showStatus(Achievement achievement) {
        HashMap map = new HashMap();
        map.put("achievement", achievement);
        new AchievementNotification(map).checkDelegateAndView();
    }

    @Override // com.openfeint.internal.notifications.NotificationBase
    protected final boolean createView() {
        final Achievement achievement = (Achievement) getUserData().get("achievement");
        this.displayView = ((LayoutInflater) OpenFeintInternal.getInstance().getContext().getSystemService("layout_inflater")).inflate(RR.layout("of_achievement_notification"), (ViewGroup) null);
        if (achievement.isUnlocked) {
            this.displayView.findViewById(RR.id("of_achievement_progress_icon")).setVisibility(4);
            if (achievement.gamerscore == 0) {
                this.displayView.findViewById(RR.id("of_achievement_score_icon")).setVisibility(4);
                this.displayView.findViewById(RR.id("of_achievement_score")).setVisibility(4);
            }
        } else {
            this.displayView.findViewById(RR.id("of_achievement_score_icon")).setVisibility(4);
        }
        ((TextView) this.displayView.findViewById(RR.id("of_achievement_text"))).setText((achievement.title == null || achievement.title.length() <= 0) ? OpenFeintInternal.getRString(RR.string("of_achievement_unlocked")) : achievement.title);
        ((TextView) this.displayView.findViewById(RR.id("of_achievement_score"))).setText(achievement.isUnlocked ? Integer.toString(achievement.gamerscore) : String.format("%d%%", Integer.valueOf((int) achievement.percentComplete)));
        if (achievement.iconUrl != null) {
            Drawable resourceDrawable = getResourceDrawable(achievement.iconUrl);
            if (resourceDrawable == null) {
                new ExternalBitmapRequest(achievement.iconUrl) { // from class: com.openfeint.internal.notifications.AchievementNotification.1
                    @Override // com.openfeint.internal.request.DownloadRequest
                    public final void onFailure(String str) {
                        OFLog.e("NotificationImage", "Failed to load image " + achievement.iconUrl + ":" + str);
                        AchievementNotification.this.showToast();
                    }

                    @Override // com.openfeint.internal.request.BitmapRequest
                    public final void onSuccess(Bitmap bitmap) {
                        ((ImageView) AchievementNotification.this.displayView.findViewById(RR.id("of_achievement_icon"))).setImageDrawable(new BitmapDrawable(bitmap));
                        AchievementNotification.this.showToast();
                    }
                }.launch();
                return false;
            }
            ((ImageView) this.displayView.findViewById(RR.id("of_achievement_icon"))).setImageDrawable(resourceDrawable);
        }
        return true;
    }
}
