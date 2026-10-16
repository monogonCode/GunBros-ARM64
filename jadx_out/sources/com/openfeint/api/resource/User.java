package com.openfeint.api.resource;

import com.openfeint.internal.APICallback;
import com.openfeint.internal.request.JSONRequest;
import com.openfeint.internal.resource.BooleanResourceProperty;
import com.openfeint.internal.resource.DoubleResourceProperty;
import com.openfeint.internal.resource.IntResourceProperty;
import com.openfeint.internal.resource.Resource;
import com.openfeint.internal.resource.ResourceClass;
import com.openfeint.internal.resource.StringResourceProperty;

/* JADX INFO: loaded from: classes.dex */
public class User extends Resource {
    public boolean followedByLocalUser;
    public boolean followsLocalUser;
    public int gamerScore;
    public String lastPlayedGameId;
    public String lastPlayedGameName;
    public double latitude;
    public double longitude;
    public String name;
    public boolean online;
    public String profilePictureSource;
    public String profilePictureUrl;
    public boolean usesFacebookProfilePicture;

    public static abstract class LoadCB extends APICallback {
    }

    public static ResourceClass getResourceClass() {
        ResourceClass resourceClass = new ResourceClass(User.class, "user") { // from class: com.openfeint.api.resource.User.6
            @Override // com.openfeint.internal.resource.ResourceClass
            public final Resource factory() {
                return new User();
            }
        };
        resourceClass.mProperties.put("name", new StringResourceProperty() { // from class: com.openfeint.api.resource.User.7
            @Override // com.openfeint.internal.resource.StringResourceProperty
            public final String get(Resource resource) {
                return ((User) resource).name;
            }

            @Override // com.openfeint.internal.resource.StringResourceProperty
            public final void set(Resource resource, String str) {
                ((User) resource).name = str;
            }
        });
        resourceClass.mProperties.put("profile_picture_url", new StringResourceProperty() { // from class: com.openfeint.api.resource.User.8
            @Override // com.openfeint.internal.resource.StringResourceProperty
            public final String get(Resource resource) {
                return ((User) resource).profilePictureUrl;
            }

            @Override // com.openfeint.internal.resource.StringResourceProperty
            public final void set(Resource resource, String str) {
                ((User) resource).profilePictureUrl = str;
            }
        });
        resourceClass.mProperties.put("profile_picture_source", new StringResourceProperty() { // from class: com.openfeint.api.resource.User.9
            @Override // com.openfeint.internal.resource.StringResourceProperty
            public final String get(Resource resource) {
                return ((User) resource).profilePictureSource;
            }

            @Override // com.openfeint.internal.resource.StringResourceProperty
            public final void set(Resource resource, String str) {
                ((User) resource).profilePictureSource = str;
            }
        });
        resourceClass.mProperties.put("uses_facebook_profile_picture", new BooleanResourceProperty() { // from class: com.openfeint.api.resource.User.10
            @Override // com.openfeint.internal.resource.BooleanResourceProperty
            public final boolean get(Resource resource) {
                return ((User) resource).usesFacebookProfilePicture;
            }

            @Override // com.openfeint.internal.resource.BooleanResourceProperty
            public final void set(Resource resource, boolean z) {
                ((User) resource).usesFacebookProfilePicture = z;
            }
        });
        resourceClass.mProperties.put("last_played_game_id", new StringResourceProperty() { // from class: com.openfeint.api.resource.User.11
            @Override // com.openfeint.internal.resource.StringResourceProperty
            public final String get(Resource resource) {
                return ((User) resource).lastPlayedGameId;
            }

            @Override // com.openfeint.internal.resource.StringResourceProperty
            public final void set(Resource resource, String str) {
                ((User) resource).lastPlayedGameId = str;
            }
        });
        resourceClass.mProperties.put("last_played_game_name", new StringResourceProperty() { // from class: com.openfeint.api.resource.User.12
            @Override // com.openfeint.internal.resource.StringResourceProperty
            public final String get(Resource resource) {
                return ((User) resource).lastPlayedGameName;
            }

            @Override // com.openfeint.internal.resource.StringResourceProperty
            public final void set(Resource resource, String str) {
                ((User) resource).lastPlayedGameName = str;
            }
        });
        resourceClass.mProperties.put("gamer_score", new IntResourceProperty() { // from class: com.openfeint.api.resource.User.13
            @Override // com.openfeint.internal.resource.IntResourceProperty
            public final int get(Resource resource) {
                return ((User) resource).gamerScore;
            }

            @Override // com.openfeint.internal.resource.IntResourceProperty
            public final void set(Resource resource, int i) {
                ((User) resource).gamerScore = i;
            }
        });
        resourceClass.mProperties.put("following_local_user", new BooleanResourceProperty() { // from class: com.openfeint.api.resource.User.14
            @Override // com.openfeint.internal.resource.BooleanResourceProperty
            public final boolean get(Resource resource) {
                return ((User) resource).followsLocalUser;
            }

            @Override // com.openfeint.internal.resource.BooleanResourceProperty
            public final void set(Resource resource, boolean z) {
                ((User) resource).followsLocalUser = z;
            }
        });
        resourceClass.mProperties.put("followed_by_local_user", new BooleanResourceProperty() { // from class: com.openfeint.api.resource.User.15
            @Override // com.openfeint.internal.resource.BooleanResourceProperty
            public final boolean get(Resource resource) {
                return ((User) resource).followedByLocalUser;
            }

            @Override // com.openfeint.internal.resource.BooleanResourceProperty
            public final void set(Resource resource, boolean z) {
                ((User) resource).followedByLocalUser = z;
            }
        });
        resourceClass.mProperties.put("online", new BooleanResourceProperty() { // from class: com.openfeint.api.resource.User.16
            @Override // com.openfeint.internal.resource.BooleanResourceProperty
            public final boolean get(Resource resource) {
                return ((User) resource).online;
            }

            @Override // com.openfeint.internal.resource.BooleanResourceProperty
            public final void set(Resource resource, boolean z) {
                ((User) resource).online = z;
            }
        });
        resourceClass.mProperties.put("lat", new DoubleResourceProperty() { // from class: com.openfeint.api.resource.User.17
            @Override // com.openfeint.internal.resource.DoubleResourceProperty
            public final double get(Resource resource) {
                return ((User) resource).latitude;
            }

            @Override // com.openfeint.internal.resource.DoubleResourceProperty
            public final void set(Resource resource, double d) {
                ((User) resource).latitude = d;
            }
        });
        resourceClass.mProperties.put("lng", new DoubleResourceProperty() { // from class: com.openfeint.api.resource.User.18
            @Override // com.openfeint.internal.resource.DoubleResourceProperty
            public final double get(Resource resource) {
                return ((User) resource).longitude;
            }

            @Override // com.openfeint.internal.resource.DoubleResourceProperty
            public final void set(Resource resource, double d) {
                ((User) resource).longitude = d;
            }
        });
        return resourceClass;
    }

    public final void load$70059c05() {
        new JSONRequest() { // from class: com.openfeint.api.resource.User.1
            final /* synthetic */ LoadCB val$cb = null;

            @Override // com.openfeint.internal.request.BaseRequest
            public final String method() {
                return "GET";
            }

            @Override // com.openfeint.internal.request.JSONRequest
            public final void onFailure(String str) {
                super.onFailure(str);
                if (this.val$cb != null) {
                    this.val$cb.onFailure(str);
                }
            }

            @Override // com.openfeint.internal.request.JSONRequest
            public final void onSuccess(Object obj) {
                User.this.shallowCopyAncestorType((User) obj);
                if (this.val$cb != null) {
                    LoadCB loadCB = this.val$cb;
                }
            }

            @Override // com.openfeint.internal.request.BaseRequest
            public final String path() {
                return "/xp/users/" + User.this.resourceID();
            }
        }.launch();
    }

    public final String userID() {
        return resourceID();
    }
}
