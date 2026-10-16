package com.glu.platform.android.facebook;

import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import com.facebook.android.AsyncFacebookRunner;
import com.facebook.android.AsyncRequestListener;
import com.facebook.android.DialogError;
import com.facebook.android.Facebook;
import com.facebook.android.FacebookError;
import com.glu.platform.android.GluPlatformActivity;
import com.urbanairship.analytics.EventDataManager;
import java.io.File;
import java.io.FileOutputStream;
import java.util.Hashtable;
import java.util.Vector;
import org.json.JSONArray;
import org.json.JSONObject;

/* JADX INFO: loaded from: classes.dex */
public class GluFBConnect extends Thread implements Facebook.DialogListener {
    public static final int CNGS_CONNECTION_COMPLETE = 2;
    public static final int CNGS_CONNECTION_CONNECTING = 1;
    public static final int CNGS_CONNECTION_FAIL = 3;
    public static final int CNGS_CONNECTION_IDLE = 0;
    public static final int CNSG_CONNECTION_CANCEL = 4;
    public static final int FACEBOOK_DIALOG_CANCELLED = 2;
    public static final int FACEBOOK_DIALOG_FAILURE = 3;
    public static final int FACEBOOK_DIALOG_SUCCESS = 1;
    public static final int FACEBOOK_EVENT_FREE_ALL_FRIEND_PICS = 9;
    public static final int FACEBOOK_EVENT_LOGIN = 1;
    public static final int FACEBOOK_EVENT_LOGOUT = 2;
    public static final int FACEBOOK_EVENT_QUEUE_FEED_BODY = 12;
    public static final int FACEBOOK_EVENT_QUEUE_FEED_CAPTION = 23;
    public static final int FACEBOOK_EVENT_QUEUE_FEED_HEADER = 11;
    public static final int FACEBOOK_EVENT_QUEUE_FEED_PROMPT = 10;
    public static final int FACEBOOK_EVENT_QUEUE_FRIEND_CAPTION = 24;
    public static final int FACEBOOK_EVENT_QUEUE_FRIEND_IMAGE_URL = 18;
    public static final int FACEBOOK_EVENT_QUEUE_FRIEND_LINK = 16;
    public static final int FACEBOOK_EVENT_QUEUE_FRIEND_MESSAGE = 14;
    public static final int FACEBOOK_EVENT_QUEUE_FRIEND_TEXT_FOR_LINK = 17;
    public static final int FACEBOOK_EVENT_QUEUE_FRIEND_UID = 15;
    public static final int FACEBOOK_EVENT_REQUEST_FRIEND_NAME_FROM_UID = 20;
    public static final int FACEBOOK_EVENT_REQUEST_FRIEND_PICS = 8;
    public static final int FACEBOOK_EVENT_REQUEST_LOAD_FRIENDS = 6;
    public static final int FACEBOOK_EVENT_REQUEST_USER_INFO = 3;
    public static final int FACEBOOK_EVENT_SEND_FEED = 4;
    public static final int FACEBOOK_EVENT_SEND_INVITE = 5;
    public static final int FACEBOOK_EVENT_SET_APP_ID = 7;
    public static final int FACEBOOK_EVENT_SET_NEXT_FRIEND_REQUEST_SIZE = 21;
    public static final int FACEBOOK_EVENT_SET_OK_TO_LOGIN_TO_FACEBOOK = 25;
    public static final int FACEBOOK_EVENT_SET_SECRET_ID = 22;
    public static final int FACEBOOK_EVENT_SUBMIT_QUEUED_FEED = 13;
    public static final int FACEBOOK_EVENT_SUBMIT_QUEUED_FRIEND_FEED = 19;
    public static final int FACEBOOK_FL_NAME_INDEX = 1;
    public static final int FACEBOOK_FL_UID_INDEX = 0;
    public static final int FACEBOOK_LOGIN_LOGGED_IN = 1;
    public static final int FACEBOOK_LOGIN_LOGGED_OUT = 4;
    public static final int FACEBOOK_LOGIN_LOGGING_IN = 2;
    public static final int FACEBOOK_LOGIN_LOGGING_OUT = 3;
    public static final int FACEBOOK_LOGIN_LOGIN_FAILED = 5;
    public static final int FACEBOOK_LOGIN_LOGOUT_FAILED = 6;
    public static final int FACEBOOK_LOGIN_POSTING_TO_WALL = 7;
    public static final int FACEBOOK_NUM_FL_INDEXES = 2;
    public static final String FB_CHECK_FILE = "fbcheck230";
    private static final int MESSAGE_SUBMIT_QUEUED_FEED = 1;
    private static final int MESSAGE_SUBMIT_QUEUED_FRIEND_MESSAGE = 2;
    public static final int NATIVE_FACEBOOK_EVENT_DIALOG_STATUS = 5;
    public static final int NATIVE_FACEBOOK_EVENT_ERROR_CODE = 1;
    public static final int NATIVE_FACEBOOK_EVENT_ERROR_DESCRIPTION = 2;
    public static final int NATIVE_FACEBOOK_EVENT_ERROR_REASON = 3;
    public static final int NATIVE_FACEBOOK_EVENT_LOAD_FRIENDS = 9;
    public static final int NATIVE_FACEBOOK_EVENT_LOGIN_STATUS = 4;
    public static final int NATIVE_FACEBOOK_EVENT_REPORT_FRIEND_NAME = 10;
    public static final int NATIVE_FACEBOOK_EVENT_REPORT_SID = 7;
    public static final int NATIVE_FACEBOOK_EVENT_REPORT_UID = 6;
    public static final int NATIVE_FACEBOOK_EVENT_REPORT_USERNAME = 8;
    public static int m_connectionState;
    public static int m_facebookState;
    public static int sm_actualWidth = 1;
    public static int sm_actualHeight = 1;
    public static boolean FIVE_THOUSAND_FRIENDS_TEST = false;
    public static GluFBConnect instance = null;
    public static final String[] NGS_TEMP_FILES = {"Credentials.dat", "ActiveCred.dat", "Session.dat"};
    public static final long[] FIVE_THOUSAND_UIDS = {1520127098, 1541113634, 1564604708, 1625827744, 1720142423, 1720742598, 1723022388, 1734572441, 1759472461, 1779332415, 100000480510456L, 100000496050451L, 100000556844939L, 100000675844419L, 100001476931041L, 100001622937929L, 100001733488574L, 100001749721546L, 100001751577431L, 100001766876036L, 100001793274756L, 100001817067960L, 100002008093439L, 100002240411329L, 100002245451705L};
    public static final String[] FIVE_THOUSAND_NAMES = {"Lori Cox Glu", "Thomas Glu", "Nikita Glu Kupriyanov", "Spark Glu", "Glufour Fbtester", "Gluten Fbtester", "Glutwo Fbtester", "Gluone Fbtester", "Gluthree Fbtester", "Glufive Fbtester", "Atom Fbtester", "Atom Tester", "Noah Glu", "Thunder Cracker", "Lingzhi Glu", "Tf-tracks Glu", "FB-Cosmos Glu", "Adam Ellington", "FB-Mirage Glu", "FB-Warpath Glu", "Tf-grimlock Glu", "FB-Defensor Glu", "David Jimenez", "Glu Francisco", "Duff Glu"};
    public Facebook m_facebook = null;
    private String m_appID = null;
    private String m_secretID = null;
    public String[] m_friendInfo = null;
    public Hashtable<String, String> m_quickAccessFriendInfo = new Hashtable<>();
    private AsyncFacebookRunner m_loadFriendsRunner = null;
    private AsyncFacebookRunner m_getUserInfoRunner = null;
    public String m_prompt = null;
    public String m_header = null;
    public String m_body = null;
    public String m_friendMessage = null;
    public String m_friendUID = null;
    public String m_friendLink = null;
    public String m_friendLinkText = null;
    public String m_friendLinkImageURL = null;
    private Handler m_viewManipulationHandler = new Handler() { // from class: com.glu.platform.android.facebook.GluFBConnect.3
        @Override // android.os.Handler
        public final void handleMessage(Message message) {
            if (message.what == 1) {
                GluFBConnect.m_facebookState = 7;
                MixedHash mixedHash = new MixedHash();
                Debug.log$552c4e01();
                mixedHash.putString("name", GluFBConnect.this.m_header);
                mixedHash.putString("href", "https://market.android.com/details?id=");
                mixedHash.putString("description", GluFBConnect.this.m_body);
                MixedHash mixedHash2 = new MixedHash();
                mixedHash2.putString(EventDataManager.Events.COLUMN_NAME_TYPE, "image");
                mixedHash2.putString("src", "http://gcs.glu.com/gcs/images/gunbros2.0_ANDROID_114icon.PNG");
                mixedHash2.putString("href", "https://market.android.com/details?id=");
                Vector<MixedHash> vector = new Vector<>();
                vector.addElement(mixedHash2);
                mixedHash.putMixedHashVector("media", vector);
                MixedHash mixedHash3 = new MixedHash();
                mixedHash3.putString("text", GluFBConnect.this.m_prompt);
                mixedHash3.putString("href", "https://market.android.com/details?id=");
                new Bundle().putString("user_message_prompt", GluFBConnect.this.m_prompt);
                GluFBConnect.this.m_prompt = null;
                GluFBConnect.this.m_header = null;
                GluFBConnect.this.m_body = null;
                return;
            }
            if (message.what == 2) {
                GluFBConnect.m_facebookState = 7;
                MixedHash mixedHash4 = new MixedHash();
                Debug.log$552c4e01();
                MixedHash mixedHash5 = new MixedHash();
                mixedHash5.putString(EventDataManager.Events.COLUMN_NAME_TYPE, "image");
                mixedHash5.putString("src", GluFBConnect.this.m_friendLinkImageURL == null ? "http://gcs.glu.com/gcs/images/gunbros2.0_ANDROID_114icon.PNG" : GluFBConnect.this.m_friendLinkImageURL);
                mixedHash5.putString("href", GluFBConnect.this.m_friendLink == null ? "https://market.android.com/details?id=" : GluFBConnect.this.m_friendLink);
                Vector<MixedHash> vector2 = new Vector<>();
                vector2.addElement(mixedHash5);
                mixedHash4.putMixedHashVector("media", vector2);
                MixedHash mixedHash6 = new MixedHash();
                mixedHash6.putString("text", GluFBConnect.this.m_friendLinkText == null ? "Gun Bros" : GluFBConnect.this.m_friendLinkText);
                mixedHash6.putString("href", GluFBConnect.this.m_friendLink == null ? "https://market.android.com/details?id=" : GluFBConnect.this.m_friendLink);
                Bundle bundle = new Bundle();
                bundle.putString("message", GluFBConnect.this.m_friendMessage);
                bundle.putString("target_id", GluFBConnect.this.m_friendUID);
                GluFBConnect.this.m_friendMessage = null;
                GluFBConnect.this.m_friendUID = null;
                GluFBConnect.this.m_friendLink = null;
                GluFBConnect.this.m_friendLinkText = null;
                GluFBConnect.this.m_friendLinkImageURL = null;
            }
        }
    };
    public boolean RUNNING = false;
    public Vector<FBItem> m_friendRequestQueue = new Vector<>();
    public String m_nextImageSize = "small";

    public static class FBItem {
        public String imageSize;
        public String imageUser;

        public FBItem(String str, String str2) {
            this.imageSize = null;
            this.imageUser = null;
            this.imageSize = str;
            this.imageUser = str2;
        }
    }

    public GluFBConnect() {
        if (FIVE_THOUSAND_FRIENDS_TEST) {
            Debug.relDie("Set FIVE_THOUSAND_FRIENDS_TEST to false.");
        }
        instance = this;
        m_connectionState = 0;
        m_facebookState = 4;
    }

    public static void createFBCanLoginFile() {
        try {
            FileOutputStream fileOutputStream = new FileOutputStream(new File(GluUtil.getSecureSaveDirectory() + FB_CHECK_FILE), false);
            fileOutputStream.write(0);
            fileOutputStream.close();
        } catch (Exception e) {
            Debug.log$552c4e01();
        }
    }

    private void deleteSingleUserFile(String str, String str2) {
        new File(str + str2 + ".png").delete();
        new File(str + str2 + ".jpg").delete();
    }

    private void displayPostingToWallFailureModal() {
    }

    public static void facebookEvent(int i, int i2, byte[] bArr, char[] cArr) {
        String str = "in facebookEvent event:" + i;
        Debug.log$552c4e01();
        if (i == 1) {
            GluPlatformActivity.instance.m_Terminator.sendEmptyMessage(2);
            return;
        }
        if (i == 2) {
            GluPlatformActivity.instance.m_Terminator.sendEmptyMessage(3);
            return;
        }
        if (i != 3) {
            if (i == 6) {
                instance.loadFriends();
                return;
            }
            if (i == 4 || i == 5) {
                return;
            }
            if (i == 7) {
                Debug.log$552c4e01();
                instance.setAppID("175053615859789");
                Debug.log$552c4e01();
                return;
            }
            if (i == 8) {
                instance.requestFriendPicsStartingWith(new String(cArr));
                return;
            }
            if (i == 9) {
                instance.freeAllFriendPics();
                return;
            }
            if (i == 10) {
                instance.queueFeedPrompt(cArr != null ? new String(cArr) : null);
                return;
            }
            if (i == 11) {
                instance.queueFeedHeader(cArr != null ? new String(cArr) : null);
                return;
            }
            if (i == 12) {
                instance.queueFeedBody(cArr != null ? new String(cArr) : null);
                return;
            }
            if (i == 13) {
                instance.submitQueuedFeed();
                return;
            }
            if (i == 14) {
                instance.queueFriendMessage(cArr != null ? new String(cArr) : null);
                return;
            }
            if (i == 15) {
                instance.queueFriendUID(cArr != null ? new String(cArr) : null);
                return;
            }
            if (i == 16) {
                instance.queueFriendLink(cArr != null ? new String(cArr) : null);
                return;
            }
            if (i == 17) {
                instance.queueFriendLinkText(cArr != null ? new String(cArr) : null);
                return;
            }
            if (i == 18) {
                instance.queueFriendImageURL(cArr != null ? new String(cArr) : null);
                return;
            }
            if (i == 19) {
                instance.submitQueuedFriendFeed();
                return;
            }
            if (i == 20) {
                instance.requestFriendNameFromUID(cArr != null ? new String(cArr) : null);
                return;
            }
            if (i == 21) {
                instance.setNextFriendRequestSize(cArr != null ? new String(cArr) : null);
                return;
            }
            if (i != 22) {
                if (i == 25) {
                    createFBCanLoginFile();
                }
            } else {
                Debug.log$552c4e01();
                String str2 = cArr != null ? "175053615859789" : null;
                Debug.log$552c4e01();
                instance.setSecretID(str2);
            }
        }
    }

    private boolean shouldFileBeReplaced(String str, String str2, long j) {
        File file = new File(str + str2 + ".png");
        File file2 = new File(str + str2 + ".jpg");
        if (!file.exists() && !file2.exists()) {
            return true;
        }
        if (!file.exists() || file.lastModified() > j) {
            return file2.exists() && file2.lastModified() <= j;
        }
        return true;
    }

    private String shouldFileBeReplacedIfNotGetExtension(String str, String str2, long j) {
        File file = new File(str + str2 + ".png");
        File file2 = new File(str + str2 + ".jpg");
        if (!file.exists() && !file2.exists()) {
            return null;
        }
        if (file.exists() && file.lastModified() <= j) {
            return null;
        }
        if (file2.exists() && file2.lastModified() <= j) {
            return null;
        }
        if (file.exists()) {
            return ".png";
        }
        return file2.exists() ? ".jpg" : ".wtf";
    }

    public static boolean testFBCanLoginFile() {
        return new File(GluUtil.getSecureSaveDirectory() + FB_CHECK_FILE).exists();
    }

    public void freeAllFriendPics() {
        GluUtil.rmrf(new File(GluUtil.getFacebookSaveDirectory()));
    }

    public void getUserInfo() {
        Debug.log$552c4e01();
        if (m_facebookState != 1) {
            Debug.log$552c4e01();
        } else {
            if (this.m_getUserInfoRunner != null) {
                Debug.log$552c4e01();
                return;
            }
            AsyncFacebookRunner asyncFacebookRunner = new AsyncFacebookRunner(this.m_facebook);
            this.m_getUserInfoRunner = asyncFacebookRunner;
            asyncFacebookRunner.request("/me", new AsyncRequestListener() { // from class: com.glu.platform.android.facebook.GluFBConnect.2
                @Override // com.facebook.android.AsyncRequestListener
                public final void onComplete(JSONObject jSONObject) {
                    try {
                        String strOptString = jSONObject.optString("id");
                        String strOptString2 = jSONObject.optString("name");
                        Debug.log$552c4e01();
                        GluPlatformActivity.instance.javaToNativeFacebook(6, 0, GluUtil.stringToNativeByteArray(strOptString));
                        GluPlatformActivity.instance.javaToNativeFacebook(8, 0, GluUtil.stringToNativeByteArray(strOptString2));
                        GluPlatformActivity.instance.javaToNativeFacebook(4, 1, null);
                        wrapUp(true);
                    } catch (Exception e) {
                        Debug.log$2d473e19();
                        wrapUp(false);
                    }
                }

                @Override // com.facebook.android.AsyncRequestListener
                public final void wrapUp(boolean z) {
                    if (!z) {
                        GluPlatformActivity.instance.javaToNativeFacebook(4, 5, null);
                        GluFBConnect.m_facebookState = 5;
                    }
                    GluFBConnect.this.m_getUserInfoRunner = null;
                }
            });
        }
    }

    public void init() {
        this.m_appID = null;
    }

    public void loadFriends() {
        Debug.log$552c4e01();
        if (m_facebookState != 1) {
            return;
        }
        if (this.m_loadFriendsRunner != null) {
            Debug.log$552c4e01();
            return;
        }
        AsyncFacebookRunner asyncFacebookRunner = new AsyncFacebookRunner(this.m_facebook);
        this.m_loadFriendsRunner = asyncFacebookRunner;
        asyncFacebookRunner.request("me/friends", new AsyncRequestListener() { // from class: com.glu.platform.android.facebook.GluFBConnect.1
            @Override // com.facebook.android.AsyncRequestListener
            public final void onComplete(JSONObject jSONObject) {
                char[][] cArr;
                try {
                    JSONArray jSONArray = jSONObject.getJSONArray(EventDataManager.Events.COLUMN_NAME_DATA);
                    int length = jSONArray.length();
                    if (GluFBConnect.FIVE_THOUSAND_FRIENDS_TEST) {
                        length = 5000;
                        cArr = new char[10000][];
                        GluFBConnect.this.m_friendInfo = new String[cArr.length];
                        int i = 0;
                        while (i < 200) {
                            for (int i2 = 0; i2 < 25; i2++) {
                                String str = (GluFBConnect.FIVE_THOUSAND_UIDS[i2] + ((long) i)) + "";
                                String str2 = GluFBConnect.FIVE_THOUSAND_NAMES[i2] + (i == 0 ? "" : Character.valueOf((char) (i + 289)));
                                String str3 = "uid[" + ((i * 25) + i2) + "] = " + str + ", name[" + ((i * 25) + i2) + "] = " + str2;
                                Debug.log$552c4e01();
                                GluFBConnect.this.m_friendInfo[(((i * 25) + i2) * 2) + 0] = str;
                                GluFBConnect.this.m_friendInfo[(((i * 25) + i2) * 2) + 1] = str2;
                                cArr[(((i * 25) + i2) * 2) + 0] = GluUtil.stringToNativeCharArray(str);
                                cArr[(((i * 25) + i2) * 2) + 1] = GluUtil.stringToNativeCharArray(str2);
                            }
                            i++;
                        }
                    } else {
                        cArr = length > 0 ? new char[length * 2][] : null;
                        GluFBConnect.this.m_friendInfo = new String[length * 2];
                        GluFBConnect.this.m_quickAccessFriendInfo.clear();
                        for (int i3 = 0; i3 < length; i3++) {
                            JSONObject jSONObject2 = jSONArray.getJSONObject(i3);
                            String string = jSONObject2.getString("id");
                            String string2 = jSONObject2.getString("name");
                            String str4 = "uid[" + i3 + "] = " + string + ", name[" + i3 + "] = " + string2;
                            Debug.log$552c4e01();
                            GluFBConnect.this.m_friendInfo[(i3 * 2) + 0] = string;
                            GluFBConnect.this.m_friendInfo[(i3 * 2) + 1] = string2;
                            cArr[(i3 * 2) + 0] = GluUtil.stringToNativeCharArray(string);
                            cArr[(i3 * 2) + 1] = GluUtil.stringToNativeCharArray(string2);
                            GluFBConnect.this.m_quickAccessFriendInfo.put(string, string2);
                        }
                    }
                    wrapUp(true);
                    Debug.log$552c4e01();
                    GluPlatformActivity.instance.javaToNativeFacebook(9, length, null, cArr);
                } catch (Exception e) {
                    Debug.log$2d473e19();
                    wrapUp(false);
                }
            }

            @Override // com.facebook.android.AsyncRequestListener
            public final void wrapUp(boolean z) {
                GluFBConnect.this.m_loadFriendsRunner = null;
            }
        });
    }

    public void login() {
        if (!testFBCanLoginFile()) {
            Debug.log$552c4e01();
            GluPlatformActivity.instance.javaToNativeFacebook(4, 5, null);
            return;
        }
        Debug.log$552c4e01();
        m_connectionState = 1;
        m_facebookState = 2;
        if (this.m_appID == null) {
            Debug.log$552c4e01();
        } else {
            this.m_facebook.authorize(GluPlatformActivity.instance, this);
            Debug.log$552c4e01();
        }
    }

    public void logout() {
        m_connectionState = 1;
        m_facebookState = 3;
        try {
            String str = "Logged out with response: " + this.m_facebook.logout(GluPlatformActivity.instance);
            Debug.log$552c4e01();
        } catch (Exception e) {
            String str2 = "FB logout exception (probably harmless): " + e;
            Debug.log$552c4e01();
        }
    }

    @Override // com.facebook.android.Facebook.DialogListener
    public void onCancel() {
        m_connectionState = 4;
        Debug.log$552c4e01();
        if (m_facebookState != 2) {
            if (m_facebookState == 3) {
                m_facebookState = 4;
                return;
            } else {
                if (m_facebookState == 7) {
                    m_facebookState = 1;
                    return;
                }
                return;
            }
        }
        GluPlatformActivity.instance.javaToNativeFacebook(4, 5, null);
        m_facebookState = 5;
        File cacheDir = GluPlatformActivity.instance.getCacheDir();
        File file = new File(GluUtil.filePathNoEnder(cacheDir.getAbsolutePath()).replace("/cache", "/databases/webview.db"));
        File file2 = new File(GluUtil.filePathNoEnder(cacheDir.getAbsolutePath()).replace("/cache", "/databases/webviewCache.db"));
        if (file.exists()) {
            file.delete();
        } else {
            Debug.log$552c4e01();
        }
        if (file2.exists()) {
            file2.delete();
        } else {
            Debug.log$552c4e01();
        }
    }

    @Override // com.facebook.android.Facebook.DialogListener
    public void onComplete(Bundle bundle) {
        Debug.log$552c4e01();
        m_connectionState = 2;
        if (m_facebookState == 2) {
            m_facebookState = 1;
            Debug.log$552c4e01();
            getUserInfo();
        } else if (m_facebookState == 3) {
            m_facebookState = 4;
        } else if (m_facebookState == 7) {
            m_facebookState = 1;
        }
    }

    @Override // com.facebook.android.Facebook.DialogListener
    public void onError(DialogError dialogError) {
        m_connectionState = 3;
        Debug.log$552c4e01();
        if (m_facebookState == 2) {
            GluPlatformActivity.instance.javaToNativeFacebook(4, 5, null);
            m_facebookState = 5;
        } else if (m_facebookState == 3) {
            m_facebookState = 4;
        } else if (m_facebookState == 7) {
            m_facebookState = 1;
        }
    }

    @Override // com.facebook.android.Facebook.DialogListener
    public void onFacebookError(FacebookError facebookError) {
        m_connectionState = 3;
        Debug.log$552c4e01();
        if (m_facebookState == 2) {
            GluPlatformActivity.instance.javaToNativeFacebook(4, 5, null);
            m_facebookState = 5;
        } else if (m_facebookState == 3) {
            m_facebookState = 4;
        } else if (m_facebookState == 7) {
            m_facebookState = 1;
        }
    }

    public void queueFeedBody(String str) {
        this.m_body = str;
    }

    public void queueFeedHeader(String str) {
        this.m_header = str;
    }

    public void queueFeedPrompt(String str) {
        this.m_prompt = str;
    }

    public void queueFriendImageURL(String str) {
        this.m_friendLinkImageURL = str;
    }

    public void queueFriendLink(String str) {
        this.m_friendLink = str;
    }

    public void queueFriendLinkText(String str) {
        this.m_friendLinkText = str;
    }

    public void queueFriendMessage(String str) {
        this.m_friendMessage = str;
    }

    public void queueFriendUID(String str) {
        this.m_friendUID = str;
    }

    public void requestFriendNameFromUID(String str) {
        this.m_quickAccessFriendInfo.get(str);
    }

    public void requestFriendPicsStartingWith(String str) {
        if (this.m_friendInfo == null) {
            Debug.log$552c4e01();
            return;
        }
        synchronized (this.m_friendRequestQueue) {
            this.m_friendRequestQueue.addElement(new FBItem(this.m_nextImageSize, str));
            if (this.RUNNING) {
                return;
            }
            this.RUNNING = true;
            start();
        }
    }

    @Override // java.lang.Thread, java.lang.Runnable
    public void run() {
        String strMimeTypeToExtension;
        File file;
        String strFilePathWithEnder = GluUtil.filePathWithEnder(GluUtil.getFacebookSaveDirectory());
        String[] strArr = this.m_friendInfo;
        long jCurrentTimeMillis = System.currentTimeMillis() - 259200000;
        this.RUNNING = this.m_friendRequestQueue.size() > 0;
        while (this.RUNNING) {
            FBItem fBItemElementAt = this.m_friendRequestQueue.elementAt(0);
            String str = fBItemElementAt.imageUser;
            String str2 = fBItemElementAt.imageSize;
            String str3 = str + "_" + str2;
            String strShouldFileBeReplacedIfNotGetExtension = shouldFileBeReplacedIfNotGetExtension(strFilePathWithEnder, str3, jCurrentTimeMillis);
            if (strShouldFileBeReplacedIfNotGetExtension == null) {
                int i = 5;
                while (i > 0) {
                    String str4 = "http://graph.facebook.com/" + str + "/picture?type=" + str2;
                    String str5 = "Checking URL: " + str4;
                    Debug.log$552c4e01();
                    byte[] byteArrayContentsFromURL$44c4d6c8 = GluUtil.getByteArrayContentsFromURL$44c4d6c8(str4);
                    if (byteArrayContentsFromURL$44c4d6c8 == null || byteArrayContentsFromURL$44c4d6c8.length < 4) {
                        String str6 = "Failed, will retry in 5sec: " + str4;
                        Debug.log$552c4e01();
                        GluUtil.sleep$1349ef();
                        i--;
                    } else {
                        int mIMEType = GluUtil.getMIMEType(byteArrayContentsFromURL$44c4d6c8);
                        if (mIMEType == -1991225785 || mIMEType == 65496) {
                            strMimeTypeToExtension = GluUtil.mimeTypeToExtension(mIMEType);
                            file = new File(strFilePathWithEnder + str3 + strMimeTypeToExtension);
                        } else if (mIMEType == 1195984440 || mIMEType == 16973) {
                            Debug.log$552c4e01();
                            strMimeTypeToExtension = strShouldFileBeReplacedIfNotGetExtension;
                            file = null;
                        } else {
                            String str7 = "Unknown file type..." + GluUtil.getFourByteHexNice$79bb807(byteArrayContentsFromURL$44c4d6c8) + " ...using filler pic.";
                            strMimeTypeToExtension = strShouldFileBeReplacedIfNotGetExtension;
                            file = null;
                            Debug.log$552c4e01();
                        }
                        if (file != null) {
                            try {
                                deleteSingleUserFile(strFilePathWithEnder, str);
                                FileOutputStream fileOutputStream = new FileOutputStream(file);
                                GluUtil.writeByteArray(fileOutputStream, byteArrayContentsFromURL$44c4d6c8);
                                fileOutputStream.close();
                                String str8 = "Successfully changed: " + file.getAbsolutePath();
                                Debug.log$552c4e01();
                            } catch (Exception e) {
                                Debug.log$552c4e01();
                            }
                        }
                        strShouldFileBeReplacedIfNotGetExtension = strMimeTypeToExtension;
                        i = 0;
                    }
                }
            }
            if (strShouldFileBeReplacedIfNotGetExtension != null) {
                File file2 = new File(strFilePathWithEnder + str3 + strShouldFileBeReplacedIfNotGetExtension);
                if (GluUtil.copyFile(file2, new File(strFilePathWithEnder + str + strShouldFileBeReplacedIfNotGetExtension))) {
                    String str9 = "Copied successfully for native. OLD=" + file2.getAbsolutePath() + "  NEW=" + file2.getAbsolutePath();
                    Debug.log$552c4e01();
                } else {
                    String str10 = "Failed to copy file over for friend pic.   UID=" + str + "   SIZE=" + str2;
                    Debug.log$552c4e01();
                }
            }
            synchronized (this.m_friendRequestQueue) {
                this.m_friendRequestQueue.removeElementAt(0);
                this.RUNNING = this.m_friendRequestQueue.size() > 0;
            }
        }
    }

    public void sendFeed(String str) {
        String str2 = "GluFBConnect.sendFeed: " + str;
        Debug.log$552c4e01();
        new Bundle().putString("message", str);
    }

    public void sendInvite(String str) {
        String str2 = "GluFBConnect.sendInvite: " + str;
        Debug.log$552c4e01();
        int iIndexOf = str.indexOf(126);
        if (iIndexOf == -1) {
            Debug.log$552c4e01();
            return;
        }
        Bundle bundle = new Bundle();
        bundle.putString("message", str.substring(0, iIndexOf));
        bundle.putString("uid", str.substring(iIndexOf + 1));
    }

    public void setAppID(String str) {
        this.m_appID = str;
        this.m_facebook = new Facebook(this.m_appID);
    }

    public void setNextFriendRequestSize(String str) {
        this.m_nextImageSize = str;
    }

    public void setSecretID(String str) {
        this.m_secretID = str;
    }

    public void submitQueuedFeed() {
        if (this.m_body == null) {
            Debug.log$552c4e01();
        } else {
            if (m_facebookState != 1) {
                Debug.log$552c4e01();
                return;
            }
            String str = "GluFBConnect.submitQueuedFeed: " + this.m_body;
            Debug.log$552c4e01();
            this.m_viewManipulationHandler.sendEmptyMessage(1);
        }
    }

    public void submitQueuedFriendFeed() {
        if (this.m_friendMessage == null || this.m_friendUID == null) {
            Debug.log$552c4e01();
            return;
        }
        if (m_facebookState != 1) {
            Debug.log$552c4e01();
            return;
        }
        String str = "GluFBConnect.submitQueuedFriendFeed: " + this.m_friendMessage;
        Debug.log$552c4e01();
        if (this.m_friendLink != null && this.m_friendLink.equals("")) {
            this.m_friendLink = null;
        }
        if (this.m_friendLinkText != null && this.m_friendLinkText.equals("")) {
            this.m_friendLinkText = null;
        }
        if (this.m_friendLinkImageURL != null && this.m_friendLinkImageURL.equals("")) {
            this.m_friendLinkImageURL = null;
        }
        this.m_viewManipulationHandler.sendEmptyMessage(2);
    }
}
