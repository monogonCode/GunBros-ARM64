package com.openfeint.api.resource;

import com.openfeint.internal.APICallback;
import com.openfeint.internal.OpenFeintInternal;
import com.openfeint.internal.notifications.AchievementNotification;
import com.openfeint.internal.offline.OfflineSupport;
import com.openfeint.internal.request.JSONRequest;
import com.openfeint.internal.request.OrderedArgList;
import com.openfeint.internal.resource.BooleanResourceProperty;
import com.openfeint.internal.resource.DateResourceProperty;
import com.openfeint.internal.resource.FloatResourceProperty;
import com.openfeint.internal.resource.IntResourceProperty;
import com.openfeint.internal.resource.Resource;
import com.openfeint.internal.resource.ResourceClass;
import com.openfeint.internal.resource.StringResourceProperty;
import java.util.Date;

/* JADX INFO: loaded from: classes.dex */
public class Achievement extends Resource {
    public String description;
    public String endVersion;
    public int gamerscore;
    public String iconUrl;
    public boolean isSecret;
    public boolean isUnlocked;
    public float percentComplete;
    public int position;
    public String startVersion;
    public String title;
    public Date unlockDate;

    public static abstract class UpdateProgressionCB extends APICallback {
    }

    public Achievement() {
    }

    public Achievement(String str) {
        setResourceID(str);
    }

    public static ResourceClass getResourceClass() {
        ResourceClass resourceClass = new ResourceClass(Achievement.class, "achievement") { // from class: com.openfeint.api.resource.Achievement.6
            @Override // com.openfeint.internal.resource.ResourceClass
            public final Resource factory() {
                return new Achievement();
            }
        };
        resourceClass.mProperties.put("title", new StringResourceProperty() { // from class: com.openfeint.api.resource.Achievement.7
            @Override // com.openfeint.internal.resource.StringResourceProperty
            public final String get(Resource resource) {
                return ((Achievement) resource).title;
            }

            @Override // com.openfeint.internal.resource.StringResourceProperty
            public final void set(Resource resource, String str) {
                ((Achievement) resource).title = str;
            }
        });
        resourceClass.mProperties.put("description", new StringResourceProperty() { // from class: com.openfeint.api.resource.Achievement.8
            @Override // com.openfeint.internal.resource.StringResourceProperty
            public final String get(Resource resource) {
                return ((Achievement) resource).description;
            }

            @Override // com.openfeint.internal.resource.StringResourceProperty
            public final void set(Resource resource, String str) {
                ((Achievement) resource).description = str;
            }
        });
        resourceClass.mProperties.put("gamerscore", new IntResourceProperty() { // from class: com.openfeint.api.resource.Achievement.9
            @Override // com.openfeint.internal.resource.IntResourceProperty
            public final int get(Resource resource) {
                return ((Achievement) resource).gamerscore;
            }

            @Override // com.openfeint.internal.resource.IntResourceProperty
            public final void set(Resource resource, int i) {
                ((Achievement) resource).gamerscore = i;
            }
        });
        resourceClass.mProperties.put("icon_url", new StringResourceProperty() { // from class: com.openfeint.api.resource.Achievement.10
            @Override // com.openfeint.internal.resource.StringResourceProperty
            public final String get(Resource resource) {
                return ((Achievement) resource).iconUrl;
            }

            @Override // com.openfeint.internal.resource.StringResourceProperty
            public final void set(Resource resource, String str) {
                ((Achievement) resource).iconUrl = str;
            }
        });
        resourceClass.mProperties.put("is_secret", new BooleanResourceProperty() { // from class: com.openfeint.api.resource.Achievement.11
            @Override // com.openfeint.internal.resource.BooleanResourceProperty
            public final boolean get(Resource resource) {
                return ((Achievement) resource).isSecret;
            }

            @Override // com.openfeint.internal.resource.BooleanResourceProperty
            public final void set(Resource resource, boolean z) {
                ((Achievement) resource).isSecret = z;
            }
        });
        resourceClass.mProperties.put("is_unlocked", new BooleanResourceProperty() { // from class: com.openfeint.api.resource.Achievement.12
            @Override // com.openfeint.internal.resource.BooleanResourceProperty
            public final boolean get(Resource resource) {
                return ((Achievement) resource).isUnlocked;
            }

            @Override // com.openfeint.internal.resource.BooleanResourceProperty
            public final void set(Resource resource, boolean z) {
                ((Achievement) resource).isUnlocked = z;
            }
        });
        resourceClass.mProperties.put("percent_complete", new FloatResourceProperty() { // from class: com.openfeint.api.resource.Achievement.13
            @Override // com.openfeint.internal.resource.FloatResourceProperty
            public final float get(Resource resource) {
                return ((Achievement) resource).percentComplete;
            }

            @Override // com.openfeint.internal.resource.FloatResourceProperty
            public final void set(Resource resource, float f) {
                ((Achievement) resource).percentComplete = f;
            }
        });
        resourceClass.mProperties.put("unlocked_at", new DateResourceProperty() { // from class: com.openfeint.api.resource.Achievement.14
            @Override // com.openfeint.internal.resource.DateResourceProperty
            public final Date get(Resource resource) {
                return ((Achievement) resource).unlockDate;
            }

            @Override // com.openfeint.internal.resource.DateResourceProperty
            public final void set(Resource resource, Date date) {
                ((Achievement) resource).unlockDate = date;
            }
        });
        resourceClass.mProperties.put("position", new IntResourceProperty() { // from class: com.openfeint.api.resource.Achievement.15
            @Override // com.openfeint.internal.resource.IntResourceProperty
            public final int get(Resource resource) {
                return ((Achievement) resource).position;
            }

            @Override // com.openfeint.internal.resource.IntResourceProperty
            public final void set(Resource resource, int i) {
                ((Achievement) resource).position = i;
            }
        });
        resourceClass.mProperties.put("end_version", new StringResourceProperty() { // from class: com.openfeint.api.resource.Achievement.16
            @Override // com.openfeint.internal.resource.StringResourceProperty
            public final String get(Resource resource) {
                return ((Achievement) resource).endVersion;
            }

            @Override // com.openfeint.internal.resource.StringResourceProperty
            public final void set(Resource resource, String str) {
                ((Achievement) resource).endVersion = str;
            }
        });
        resourceClass.mProperties.put("start_version", new StringResourceProperty() { // from class: com.openfeint.api.resource.Achievement.17
            @Override // com.openfeint.internal.resource.StringResourceProperty
            public final String get(Resource resource) {
                return ((Achievement) resource).startVersion;
            }

            @Override // com.openfeint.internal.resource.StringResourceProperty
            public final void set(Resource resource, String str) {
                ((Achievement) resource).startVersion = str;
            }
        });
        return resourceClass;
    }

    public final void unlock$26d5f281() {
        updateProgression$45f61eed(100.0f);
    }

    public final void updateProgression$45f61eed(float f) {
        final float f2 = 0.0f;
        if (f >= 0.0f) {
            f2 = f > 100.0f ? 100.0f : f;
        }
        final String strResourceID = resourceID();
        if (strResourceID != null && f2 > OfflineSupport.getClientCompletionPercentage(strResourceID)) {
            OfflineSupport.updateClientCompletionPercentage(strResourceID, f2);
            if (OpenFeintInternal.getInstance().getUserID() == null) {
                this.percentComplete = OfflineSupport.getClientCompletionPercentage(strResourceID);
                this.isUnlocked = this.percentComplete == 100.0f;
            } else {
                final String str = "/xp/games/" + OpenFeintInternal.getInstance().getAppID() + "/achievements/" + strResourceID + "/unlock";
                OrderedArgList orderedArgList = new OrderedArgList();
                orderedArgList.put("percent_complete", new Float(f2).toString());
                new JSONRequest(orderedArgList) { // from class: com.openfeint.api.resource.Achievement.4
                    final /* synthetic */ UpdateProgressionCB val$cb = null;

                    @Override // com.openfeint.internal.request.BaseRequest
                    public final String method() {
                        return "PUT";
                    }

                    @Override // com.openfeint.internal.request.JSONRequest
                    public final void onFailure(String str2) {
                        super.onFailure(str2);
                        if (this.val$cb != null) {
                            this.val$cb.onFailure(str2);
                        }
                    }

                    @Override // com.openfeint.internal.request.JSONRequest
                    protected final void onResponse(int i, Object obj) {
                        if (i >= 200 && i < 300) {
                            Achievement achievement = (Achievement) obj;
                            float f3 = Achievement.this.percentComplete;
                            Achievement.this.shallowCopy(achievement);
                            float f4 = Achievement.this.percentComplete;
                            OfflineSupport.updateServerCompletionPercentage(strResourceID, f4);
                            if (201 == i || f4 > f3) {
                                AchievementNotification.showStatus(achievement);
                            }
                            if (this.val$cb != null) {
                                UpdateProgressionCB updateProgressionCB = this.val$cb;
                                return;
                            }
                            return;
                        }
                        if (400 <= i && i < 500) {
                            onFailure(obj);
                            return;
                        }
                        if (100.0f == f2) {
                            Achievement.this.percentComplete = f2;
                            Achievement.this.isUnlocked = true;
                            AchievementNotification.showStatus(Achievement.this);
                        }
                        if (this.val$cb != null) {
                            UpdateProgressionCB updateProgressionCB2 = this.val$cb;
                        }
                    }

                    @Override // com.openfeint.internal.request.BaseRequest
                    public final String path() {
                        return str;
                    }
                }.launch();
            }
        }
    }
}
