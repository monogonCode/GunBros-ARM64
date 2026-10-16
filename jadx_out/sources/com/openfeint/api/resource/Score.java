package com.openfeint.api.resource;

import com.openfeint.api.Notification;
import com.openfeint.internal.APICallback;
import com.openfeint.internal.OpenFeintInternal;
import com.openfeint.internal.RR;
import com.openfeint.internal.notifications.SimpleNotification;
import com.openfeint.internal.offline.OfflineSupport;
import com.openfeint.internal.request.CompressedBlobDownloadRequest;
import com.openfeint.internal.request.CompressedBlobPostRequest;
import com.openfeint.internal.request.IRawRequestDelegate;
import com.openfeint.internal.request.JSONRequest;
import com.openfeint.internal.request.OrderedArgList;
import com.openfeint.internal.resource.BlobUploadParameters;
import com.openfeint.internal.resource.DoubleResourceProperty;
import com.openfeint.internal.resource.IntResourceProperty;
import com.openfeint.internal.resource.LongResourceProperty;
import com.openfeint.internal.resource.NestedResourceProperty;
import com.openfeint.internal.resource.Resource;
import com.openfeint.internal.resource.ResourceClass;
import com.openfeint.internal.resource.StringResourceProperty;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public class Score extends Resource {
    public byte[] blob;
    private BlobUploadParameters blobUploadParameters;
    private String blobUrl;
    public String customData;
    public String displayText;
    public double latitude;
    public int leaderboardId;
    public double longitude;
    public int rank;
    public long score;
    public User user;

    public static abstract class BlobDownloadedDelegate {
    }

    public static abstract class DownloadBlobCB extends APICallback {
        public abstract void onSuccess();
    }

    public static abstract class SubmitToCB extends APICallback {
        public abstract void onSuccess$1385ff();
    }

    public Score() {
    }

    public Score(long j) {
        this.score = j;
    }

    public static ResourceClass getResourceClass() {
        ResourceClass resourceClass = new ResourceClass(Score.class, "high_score") { // from class: com.openfeint.api.resource.Score.3
            @Override // com.openfeint.internal.resource.ResourceClass
            public final Resource factory() {
                return new Score();
            }
        };
        resourceClass.mProperties.put("score", new LongResourceProperty() { // from class: com.openfeint.api.resource.Score.4
            @Override // com.openfeint.internal.resource.LongResourceProperty
            public final long get(Resource resource) {
                return ((Score) resource).score;
            }

            @Override // com.openfeint.internal.resource.LongResourceProperty
            public final void set(Resource resource, long j) {
                ((Score) resource).score = j;
            }
        });
        resourceClass.mProperties.put("rank", new IntResourceProperty() { // from class: com.openfeint.api.resource.Score.5
            @Override // com.openfeint.internal.resource.IntResourceProperty
            public final int get(Resource resource) {
                return ((Score) resource).rank;
            }

            @Override // com.openfeint.internal.resource.IntResourceProperty
            public final void set(Resource resource, int i) {
                ((Score) resource).rank = i;
            }
        });
        resourceClass.mProperties.put("leaderboard_id", new IntResourceProperty() { // from class: com.openfeint.api.resource.Score.6
            @Override // com.openfeint.internal.resource.IntResourceProperty
            public final int get(Resource resource) {
                return ((Score) resource).leaderboardId;
            }

            @Override // com.openfeint.internal.resource.IntResourceProperty
            public final void set(Resource resource, int i) {
                ((Score) resource).leaderboardId = i;
            }
        });
        resourceClass.mProperties.put("display_text", new StringResourceProperty() { // from class: com.openfeint.api.resource.Score.7
            @Override // com.openfeint.internal.resource.StringResourceProperty
            public final String get(Resource resource) {
                return ((Score) resource).displayText;
            }

            @Override // com.openfeint.internal.resource.StringResourceProperty
            public final void set(Resource resource, String str) {
                ((Score) resource).displayText = str;
            }
        });
        resourceClass.mProperties.put("custom_data", new StringResourceProperty() { // from class: com.openfeint.api.resource.Score.8
            @Override // com.openfeint.internal.resource.StringResourceProperty
            public final String get(Resource resource) {
                return ((Score) resource).customData;
            }

            @Override // com.openfeint.internal.resource.StringResourceProperty
            public final void set(Resource resource, String str) {
                ((Score) resource).customData = str;
            }
        });
        resourceClass.mProperties.put("lat", new DoubleResourceProperty() { // from class: com.openfeint.api.resource.Score.9
            @Override // com.openfeint.internal.resource.DoubleResourceProperty
            public final double get(Resource resource) {
                return ((Score) resource).latitude;
            }

            @Override // com.openfeint.internal.resource.DoubleResourceProperty
            public final void set(Resource resource, double d) {
                ((Score) resource).latitude = d;
            }
        });
        resourceClass.mProperties.put("lng", new DoubleResourceProperty() { // from class: com.openfeint.api.resource.Score.10
            @Override // com.openfeint.internal.resource.DoubleResourceProperty
            public final double get(Resource resource) {
                return ((Score) resource).longitude;
            }

            @Override // com.openfeint.internal.resource.DoubleResourceProperty
            public final void set(Resource resource, double d) {
                ((Score) resource).longitude = d;
            }
        });
        resourceClass.mProperties.put("user", new NestedResourceProperty(User.class) { // from class: com.openfeint.api.resource.Score.11
            @Override // com.openfeint.internal.resource.NestedResourceProperty
            public final Resource get(Resource resource) {
                return ((Score) resource).user;
            }

            @Override // com.openfeint.internal.resource.NestedResourceProperty
            public final void set(Resource resource, Resource resource2) {
                ((Score) resource).user = (User) resource2;
            }
        });
        resourceClass.mProperties.put("blob_url", new StringResourceProperty() { // from class: com.openfeint.api.resource.Score.12
            @Override // com.openfeint.internal.resource.StringResourceProperty
            public final String get(Resource resource) {
                return ((Score) resource).blobUrl;
            }

            @Override // com.openfeint.internal.resource.StringResourceProperty
            public final void set(Resource resource, String str) {
                ((Score) resource).blobUrl = str;
            }
        });
        resourceClass.mProperties.put("blob_upload_parameters", new NestedResourceProperty(BlobUploadParameters.class) { // from class: com.openfeint.api.resource.Score.13
            @Override // com.openfeint.internal.resource.NestedResourceProperty
            public final Resource get(Resource resource) {
                return ((Score) resource).blobUploadParameters;
            }

            @Override // com.openfeint.internal.resource.NestedResourceProperty
            public final void set(Resource resource, Resource resource2) {
                ((Score) resource).blobUploadParameters = (BlobUploadParameters) resource2;
            }
        });
        return resourceClass;
    }

    private void submitToInternal(final Leaderboard leaderboard, String str, final SubmitToCB submitToCB, final boolean z) {
        if (leaderboard == null || leaderboard.resourceID() == null || leaderboard.resourceID().length() == 0) {
            if (submitToCB != null) {
                submitToCB.onFailure("No leaderboard ID provided.  Please provide a leaderboard ID from the Dev Dashboard.");
                return;
            }
            return;
        }
        if (!OpenFeintInternal.getInstance().isUserLoggedIn()) {
            OfflineSupport.postOfflineScore(this, leaderboard);
            if (submitToCB != null) {
                submitToCB.onSuccess$1385ff();
                return;
            }
            return;
        }
        final String str2 = "/xp/games/" + OpenFeintInternal.getInstance().getAppID() + "/leaderboards/" + leaderboard.resourceID() + "/high_scores";
        OrderedArgList orderedArgList = new OrderedArgList();
        orderedArgList.put("high_score[score]", new Long(this.score).toString());
        if (this.displayText != null) {
            orderedArgList.put("high_score[display_text]", this.displayText);
        }
        final boolean z2 = this.blob != null;
        orderedArgList.put("high_score[has_blob]", z2 ? "1" : "0");
        if (str != null) {
            orderedArgList.put("high_score[timestamp]", str);
        }
        new JSONRequest(orderedArgList) { // from class: com.openfeint.api.resource.Score.1
            @Override // com.openfeint.internal.request.BaseRequest
            public final String method() {
                return "POST";
            }

            @Override // com.openfeint.internal.request.JSONRequest
            public final void onFailure(String str3) {
                super.onFailure(str3);
                if (submitToCB != null) {
                    submitToCB.onFailure(str3);
                }
            }

            @Override // com.openfeint.internal.request.JSONRequest
            protected final void onResponse(int i, Object obj) {
                if (201 == i) {
                    if (!z) {
                        SimpleNotification.show(OpenFeintInternal.getInstance().getContext().getResources().getString(RR.string("of_score_submitted_notification")), "@drawable/of_icon_highscore_notification", Notification.Category.HighScore, Notification.Type.Success);
                    }
                    if (submitToCB != null) {
                        submitToCB.onSuccess$1385ff();
                    }
                    if (z2 && (obj instanceof List)) {
                        Score score = (Score) ((List) obj).get(0);
                        CompressedBlobPostRequest compressedBlobPostRequest = new CompressedBlobPostRequest(score.blobUploadParameters, String.format("blob.%s.bin", score.resourceID()), Score.this.blob);
                        if (submitToCB != null) {
                            compressedBlobPostRequest.setDelegate(new IRawRequestDelegate() { // from class: com.openfeint.api.resource.Score.1.1
                                @Override // com.openfeint.internal.request.IRawRequestDelegate
                                public final void onResponse(int i2, String str3) {
                                    if (200 > i2 || i2 >= 300) {
                                        SubmitToCB submitToCB2 = submitToCB;
                                    } else {
                                        SubmitToCB submitToCB3 = submitToCB;
                                    }
                                }
                            });
                        }
                        OpenFeintInternal.makeRequest(compressedBlobPostRequest);
                        return;
                    }
                    return;
                }
                if (200 <= i && i < 300) {
                    if (submitToCB != null) {
                        submitToCB.onSuccess$1385ff();
                    }
                } else {
                    if ((i != 0 && 500 > i) || z) {
                        onFailure(obj);
                        return;
                    }
                    OfflineSupport.postOfflineScore(Score.this, leaderboard);
                    if (submitToCB != null) {
                        submitToCB.onSuccess$1385ff();
                    }
                }
            }

            @Override // com.openfeint.internal.request.BaseRequest
            public final String path() {
                return str2;
            }
        }.launch();
    }

    public final void downloadBlob(final DownloadBlobCB downloadBlobCB) {
        if (this.blobUrl != null) {
            new CompressedBlobDownloadRequest() { // from class: com.openfeint.api.resource.Score.2
                @Override // com.openfeint.internal.request.DownloadRequest
                public final void onFailure(String str) {
                    super.onFailure(str);
                    if (downloadBlobCB != null) {
                        downloadBlobCB.onFailure(str);
                    }
                }

                @Override // com.openfeint.internal.request.CompressedBlobDownloadRequest
                protected final void onSuccessDecompress(byte[] bArr) {
                    Score.this.blob = bArr;
                    if (downloadBlobCB != null) {
                        downloadBlobCB.onSuccess();
                    }
                }

                @Override // com.openfeint.internal.request.BaseRequest
                public final String path() {
                    return "";
                }

                @Override // com.openfeint.internal.request.BaseRequest
                public final boolean signed() {
                    return false;
                }

                @Override // com.openfeint.internal.request.BaseRequest
                public final String url() {
                    return Score.this.blobUrl;
                }
            }.launch();
        } else if (downloadBlobCB != null) {
            downloadBlobCB.onFailure(OpenFeintInternal.getRString(RR.string("of_no_blob")));
        }
    }

    public final void submitTo$487f3c2c(Leaderboard leaderboard) {
        submitToInternal(leaderboard, null, null, false);
    }

    public final void submitToFromOffline(Leaderboard leaderboard, String str, SubmitToCB submitToCB) {
        submitToInternal(leaderboard, str, submitToCB, true);
    }
}
