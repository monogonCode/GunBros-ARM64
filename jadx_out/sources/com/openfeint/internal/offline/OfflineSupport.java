package com.openfeint.internal.offline;

import android.content.Context;
import com.openfeint.api.Notification;
import com.openfeint.api.resource.Leaderboard;
import com.openfeint.api.resource.Score;
import com.openfeint.internal.Encryption;
import com.openfeint.internal.OpenFeintInternal;
import com.openfeint.internal.RR;
import com.openfeint.internal.Util;
import com.openfeint.internal.logcat.OFLog;
import com.openfeint.internal.notifications.SimpleNotification;
import com.openfeint.internal.request.BaseRequest;
import com.openfeint.internal.request.OrderedArgList;
import com.openfeint.internal.resource.DateResourceProperty;
import com.openfeint.internal.vendor.org.apache.commons.codec.binary.Hex;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.concurrent.atomic.AtomicBoolean;
import javax.crypto.CipherOutputStream;

/* JADX INFO: loaded from: classes.dex */
public final class OfflineSupport {
    private static DB db = null;
    private static String userID = null;
    private static AtomicBoolean updateInProgress = new AtomicBoolean(false);

    public static class DB {
        public ArrayList<OfflineAchievement> achievements = new ArrayList<>();
        public ArrayList<OfflineScore> scores = new ArrayList<>();

        public static DB load(String str) throws Throwable {
            ObjectInputStream objectInputStream;
            DB db = new DB();
            ObjectInputStream objectInputStream2 = null;
            try {
                if (str != null) {
                    try {
                        objectInputStream = new ObjectInputStream(Encryption.decryptionWrap(OpenFeintInternal.getInstance().getContext().openFileInput(str)));
                        try {
                            int i = objectInputStream.readInt();
                            switch (i) {
                                case 0:
                                    for (int i2 = objectInputStream.readInt(); i2 > 0; i2--) {
                                        OfflineAchievement offlineAchievement = new OfflineAchievement();
                                        offlineAchievement.resourceID = (String) objectInputStream.readObject();
                                        offlineAchievement.clientCompletionPercentage = objectInputStream.readFloat();
                                        offlineAchievement.serverCompletionPercentage = objectInputStream.readFloat();
                                        offlineAchievement.timestamp = (String) objectInputStream.readObject();
                                        db.achievements.add(offlineAchievement);
                                    }
                                    for (int i3 = objectInputStream.readInt(); i3 > 0; i3--) {
                                        OfflineScore offlineScore = new OfflineScore();
                                        offlineScore.leaderboardID = (String) objectInputStream.readObject();
                                        offlineScore.score = objectInputStream.readLong();
                                        offlineScore.displayText = (String) objectInputStream.readObject();
                                        offlineScore.customData = (String) objectInputStream.readObject();
                                        offlineScore.blobFileName = (String) objectInputStream.readObject();
                                        offlineScore.timestamp = (String) objectInputStream.readObject();
                                        db.scores.add(offlineScore);
                                    }
                                    try {
                                        objectInputStream.close();
                                    } catch (IOException e) {
                                    }
                                    break;
                                default:
                                    throw new Exception(String.format("Unrecognized stream version %d", Integer.valueOf(i)));
                            }
                        } catch (Exception e2) {
                            e = e2;
                            OFLog.e("OfflineSupport", "Couldn't load offline achievements - " + e.getMessage());
                            db.achievements.clear();
                            db.scores.clear();
                            if (objectInputStream != null) {
                                try {
                                    objectInputStream.close();
                                } catch (IOException e3) {
                                }
                            }
                        }
                    } catch (Exception e4) {
                        e = e4;
                        objectInputStream = null;
                    } catch (Throwable th) {
                        th = th;
                        if (0 != 0) {
                            try {
                                objectInputStream2.close();
                            } catch (IOException e5) {
                            }
                        }
                        throw th;
                    }
                }
                return db;
            } catch (Throwable th2) {
                th = th2;
            }
        }

        public final OfflineAchievement findAchievement(String str) {
            for (OfflineAchievement offlineAchievement : this.achievements) {
                if (offlineAchievement.resourceID.equals(str)) {
                    return offlineAchievement;
                }
            }
            return null;
        }

        public final void removeReferencedBlobs() {
            Iterator<OfflineScore> it = this.scores.iterator();
            while (it.hasNext()) {
                OfflineSupport.deleteDataFile(it.next().blobFileName);
            }
        }
    }

    public static class OfflineAchievement {
        public float clientCompletionPercentage;
        public String resourceID;
        public float serverCompletionPercentage;
        public String timestamp;

        public final OfflineAchievement dup() {
            OfflineAchievement offlineAchievement = new OfflineAchievement();
            offlineAchievement.resourceID = this.resourceID;
            offlineAchievement.clientCompletionPercentage = this.clientCompletionPercentage;
            offlineAchievement.serverCompletionPercentage = this.serverCompletionPercentage;
            offlineAchievement.timestamp = this.timestamp;
            return offlineAchievement;
        }
    }

    public static class OfflineScore {
        public String blobFileName;
        public String customData;
        public String displayText;
        public String leaderboardID;
        public long score;
        public String timestamp;
    }

    static /* synthetic */ boolean access$000(String str, String str2) {
        if (str == null) {
            return str2 == null;
        }
        return str.equals(str2);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static void deleteDataFile(String str) {
        try {
            Context context = OpenFeintInternal.getInstance().getContext();
            context.deleteFile(context.getFileStreamPath(str).getPath());
        } catch (Exception e) {
        }
    }

    private static String filename(String str) {
        String appID;
        if (str == null || (appID = OpenFeintInternal.getInstance().getAppID()) == null) {
            return null;
        }
        return "of.offline." + str + "." + appID;
    }

    private static String fullPath(String str) {
        return OpenFeintInternal.getInstance().getContext().getFileStreamPath(str).getPath();
    }

    public static float getClientCompletionPercentage(String str) {
        OfflineAchievement offlineAchievementFindAchievement = db.findAchievement(str);
        if (offlineAchievementFindAchievement == null) {
            return 0.0f;
        }
        return offlineAchievementFindAchievement.clientCompletionPercentage;
    }

    private static boolean isUserTemporary() {
        return "0".equals(userID);
    }

    private static String now() {
        return DateResourceProperty.sDateParser.format(new Date());
    }

    public static void postOfflineScore(Score score, Leaderboard leaderboard) {
        OfflineScore next;
        if (userID == null) {
            return;
        }
        OfflineScore offlineScore = new OfflineScore();
        offlineScore.leaderboardID = leaderboard.resourceID();
        offlineScore.score = score.score;
        offlineScore.displayText = score.displayText;
        offlineScore.customData = score.customData;
        offlineScore.timestamp = now();
        if (score.blob != null) {
            Iterator<OfflineScore> it = db.scores.iterator();
            do {
                if (!it.hasNext()) {
                    next = null;
                    break;
                }
                next = it.next();
            } while (!offlineScore.leaderboardID.equals(next.leaderboardID));
            if (next != null) {
                if (!leaderboard.allowsWorseScores && ((!leaderboard.descendingSortOrder || next.score >= score.score) && (leaderboard.descendingSortOrder || next.score <= score.score))) {
                    return;
                }
                deleteDataFile(next.blobFileName);
                db.scores.remove(next);
            }
            String str = "unknown.blob";
            try {
                MessageDigest messageDigest = MessageDigest.getInstance("SHA1");
                messageDigest.update(score.blob);
                str = String.format("%s.blob", new String(Hex.encodeHex(messageDigest.digest())));
            } catch (NoSuchAlgorithmException e) {
            }
            try {
                Util.saveFile(score.blob, fullPath(str));
                offlineScore.blobFileName = str;
            } catch (IOException e2) {
                return;
            }
        }
        db.scores.add(offlineScore);
        save();
        if (isUserTemporary()) {
            return;
        }
        SimpleNotification.show(OpenFeintInternal.getRString(RR.string("of_score_submitted_notification")), "@drawable/of_icon_highscore_notification", Notification.Category.HighScore, Notification.Type.Success);
    }

    static final void removeAndUploadNext(OfflineScore offlineScore) throws Throwable {
        db.scores.remove(offlineScore);
        save();
        uploadScoresWithBlobs();
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static void save() throws Throwable {
        ObjectOutputStream objectOutputStream;
        Throwable th;
        CipherOutputStream cipherOutputStreamEncryptionWrap;
        ObjectOutputStream objectOutputStream2;
        CipherOutputStream cipherOutputStream = null;
        String strFilename = filename(userID);
        if (strFilename == null) {
            return;
        }
        DB db2 = db;
        try {
            cipherOutputStreamEncryptionWrap = Encryption.encryptionWrap(OpenFeintInternal.getInstance().getContext().openFileOutput(strFilename, 0));
            try {
                objectOutputStream = new ObjectOutputStream(cipherOutputStreamEncryptionWrap);
                try {
                    objectOutputStream.writeInt(0);
                    objectOutputStream.writeInt(db2.achievements.size());
                    for (OfflineAchievement offlineAchievement : db2.achievements) {
                        objectOutputStream.writeObject(offlineAchievement.resourceID);
                        objectOutputStream.writeFloat(offlineAchievement.clientCompletionPercentage);
                        objectOutputStream.writeFloat(offlineAchievement.serverCompletionPercentage);
                        objectOutputStream.writeObject(offlineAchievement.timestamp);
                    }
                    objectOutputStream.writeInt(db2.scores.size());
                    for (OfflineScore offlineScore : db2.scores) {
                        objectOutputStream.writeObject(offlineScore.leaderboardID);
                        objectOutputStream.writeLong(offlineScore.score);
                        objectOutputStream.writeObject(offlineScore.displayText);
                        objectOutputStream.writeObject(offlineScore.customData);
                        objectOutputStream.writeObject(offlineScore.blobFileName);
                        objectOutputStream.writeObject(offlineScore.timestamp);
                    }
                    objectOutputStream.close();
                    try {
                        objectOutputStream.close();
                    } catch (IOException e) {
                    }
                    if (cipherOutputStreamEncryptionWrap != null) {
                        try {
                            cipherOutputStreamEncryptionWrap.close();
                        } catch (IOException e2) {
                        }
                    }
                } catch (Exception e3) {
                    cipherOutputStream = cipherOutputStreamEncryptionWrap;
                    objectOutputStream2 = objectOutputStream;
                    if (objectOutputStream2 != null) {
                        try {
                            objectOutputStream2.close();
                        } catch (IOException e4) {
                        }
                    }
                    if (cipherOutputStream != null) {
                        try {
                            cipherOutputStream.close();
                        } catch (IOException e5) {
                        }
                    }
                } catch (Throwable th2) {
                    th = th2;
                    if (objectOutputStream != null) {
                        try {
                            objectOutputStream.close();
                        } catch (IOException e6) {
                        }
                    }
                    if (cipherOutputStreamEncryptionWrap == null) {
                        throw th;
                    }
                    try {
                        cipherOutputStreamEncryptionWrap.close();
                        throw th;
                    } catch (IOException e7) {
                        throw th;
                    }
                }
            } catch (Exception e8) {
                objectOutputStream2 = null;
                cipherOutputStream = cipherOutputStreamEncryptionWrap;
            } catch (Throwable th3) {
                objectOutputStream = null;
                th = th3;
            }
        } catch (Exception e9) {
            objectOutputStream2 = null;
        } catch (Throwable th4) {
            objectOutputStream = null;
            th = th4;
            cipherOutputStreamEncryptionWrap = null;
        }
    }

    public static void setUserDeclined() {
        setUserID(null);
    }

    public static void setUserID(String str) {
        if (str == null || !str.equals(userID)) {
            DB dbLoad = DB.load(filename(str));
            if (isUserTemporary()) {
                DB db2 = db;
                for (OfflineAchievement offlineAchievement : dbLoad.achievements) {
                    OfflineAchievement offlineAchievementFindAchievement = db2.findAchievement(offlineAchievement.resourceID);
                    if (offlineAchievementFindAchievement == null) {
                        db2.achievements.add(offlineAchievement.dup());
                    } else {
                        if (offlineAchievementFindAchievement.clientCompletionPercentage < offlineAchievement.clientCompletionPercentage) {
                            offlineAchievementFindAchievement.clientCompletionPercentage = offlineAchievement.clientCompletionPercentage;
                            offlineAchievementFindAchievement.timestamp = offlineAchievement.timestamp;
                        }
                        offlineAchievementFindAchievement.serverCompletionPercentage = Math.max(offlineAchievementFindAchievement.serverCompletionPercentage, offlineAchievement.serverCompletionPercentage);
                    }
                }
                db2.scores.addAll(dbLoad.scores);
                deleteDataFile(filename("0"));
            } else {
                db = dbLoad;
            }
            userID = str;
            trySubmitOfflineData();
        }
    }

    public static void setUserTemporary() {
        setUserID("0");
    }

    public static void trySubmitOfflineData() {
        if (userID == null || userID.equals("0") || !OpenFeintInternal.getInstance().isUserLoggedIn()) {
            return;
        }
        updateToServer();
    }

    public static void updateClientCompletionPercentage(String str, float f) {
        if (userID == null) {
            return;
        }
        OfflineAchievement offlineAchievementFindAchievement = db.findAchievement(str);
        if (offlineAchievementFindAchievement != null) {
            if (offlineAchievementFindAchievement.clientCompletionPercentage < f) {
                offlineAchievementFindAchievement.clientCompletionPercentage = f;
                offlineAchievementFindAchievement.timestamp = now();
                save();
                return;
            }
            return;
        }
        OfflineAchievement offlineAchievement = new OfflineAchievement();
        offlineAchievement.resourceID = str;
        offlineAchievement.serverCompletionPercentage = 0.0f;
        offlineAchievement.clientCompletionPercentage = f;
        offlineAchievement.timestamp = now();
        db.achievements.add(offlineAchievement);
        save();
    }

    public static void updateServerCompletionPercentage(String str, float f) {
        if (userID == null) {
            return;
        }
        OfflineAchievement offlineAchievementFindAchievement = db.findAchievement(str);
        if (offlineAchievementFindAchievement == null) {
            offlineAchievementFindAchievement = new OfflineAchievement();
            offlineAchievementFindAchievement.resourceID = str;
            offlineAchievementFindAchievement.clientCompletionPercentage = f;
            db.achievements.add(offlineAchievementFindAchievement);
        }
        offlineAchievementFindAchievement.serverCompletionPercentage = f;
        offlineAchievementFindAchievement.timestamp = now();
        save();
    }

    private static synchronized void updateToServer() {
        int i;
        int i2;
        int i3 = 0;
        synchronized (OfflineSupport.class) {
            if (updateInProgress.compareAndSet(false, true)) {
                DB db2 = db;
                final DB db3 = new DB();
                for (OfflineScore offlineScore : db2.scores) {
                    ArrayList<OfflineScore> arrayList = db3.scores;
                    OfflineScore offlineScore2 = new OfflineScore();
                    offlineScore2.leaderboardID = offlineScore.leaderboardID;
                    offlineScore2.score = offlineScore.score;
                    offlineScore2.displayText = offlineScore.displayText;
                    offlineScore2.customData = offlineScore.customData;
                    offlineScore2.blobFileName = offlineScore.blobFileName;
                    offlineScore2.timestamp = offlineScore.timestamp;
                    arrayList.add(offlineScore2);
                }
                Iterator<OfflineAchievement> it = db2.achievements.iterator();
                while (it.hasNext()) {
                    db3.achievements.add(it.next().dup());
                }
                OrderedArgList orderedArgList = new OrderedArgList();
                int i4 = 0;
                for (OfflineAchievement offlineAchievement : db3.achievements) {
                    if (offlineAchievement.clientCompletionPercentage != offlineAchievement.serverCompletionPercentage) {
                        OFLog.d("OfflineSupport", String.format("Updating achievement %s from known %f to %f completion", offlineAchievement.resourceID, Float.valueOf(offlineAchievement.serverCompletionPercentage), Float.valueOf(offlineAchievement.clientCompletionPercentage)));
                        orderedArgList.put(String.format("achievements[%d][id]", Integer.valueOf(i4)), offlineAchievement.resourceID);
                        orderedArgList.put(String.format("achievements[%d][percent_complete]", Integer.valueOf(i4)), Float.toString(offlineAchievement.clientCompletionPercentage));
                        orderedArgList.put(String.format("achievements[%d][timestamp]", Integer.valueOf(i4)), offlineAchievement.timestamp);
                        i2 = i4 + 1;
                    } else {
                        i2 = i4;
                    }
                    i4 = i2;
                }
                for (OfflineScore offlineScore3 : db3.scores) {
                    if (offlineScore3.blobFileName == null) {
                        OFLog.d("OfflineSupport", String.format("Posting score %d to leaderboard %s", Long.valueOf(offlineScore3.score), offlineScore3.leaderboardID));
                        orderedArgList.put(String.format("high_scores[%d][leaderboard_id]", Integer.valueOf(i3)), offlineScore3.leaderboardID);
                        orderedArgList.put(String.format("high_scores[%d][score]", Integer.valueOf(i3)), Long.toString(offlineScore3.score));
                        if (offlineScore3.displayText != null) {
                            orderedArgList.put(String.format("high_scores[%d][display_text]", Integer.valueOf(i3)), offlineScore3.displayText);
                        }
                        if (offlineScore3.customData != null) {
                            orderedArgList.put(String.format("high_scores[%d][custom_data]", Integer.valueOf(i3)), offlineScore3.customData);
                        }
                        orderedArgList.put(String.format("high_scores[%d][timestamp]", Integer.valueOf(i3)), offlineScore3.timestamp);
                        i = i3 + 1;
                    } else {
                        i = i3;
                    }
                    i3 = i;
                }
                if (i4 == 0 && i3 == 0) {
                    uploadScoresWithBlobs();
                } else {
                    final String str = "/xp/games/" + OpenFeintInternal.getInstance().getAppID() + "/offline_syncs";
                    new BaseRequest(orderedArgList) { // from class: com.openfeint.internal.offline.OfflineSupport.2
                        @Override // com.openfeint.internal.request.BaseRequest
                        public final String method() {
                            return "POST";
                        }

                        @Override // com.openfeint.internal.request.BaseRequest
                        public final void onResponse(int i5, byte[] bArr) {
                        }

                        @Override // com.openfeint.internal.request.BaseRequest
                        public final void onResponseOffMainThread(int i5, byte[] bArr) throws Throwable {
                            boolean z;
                            if (200 > i5 || i5 >= 300) {
                                if (i5 != 0 && 500 > i5) {
                                    OfflineSupport.db.removeReferencedBlobs();
                                    DB db4 = OfflineSupport.db;
                                    db4.achievements.clear();
                                    db4.scores.clear();
                                    OfflineSupport.save();
                                }
                                OfflineSupport.updateInProgress.set(false);
                                return;
                            }
                            DB db5 = OfflineSupport.db;
                            DB db6 = db3;
                            for (OfflineAchievement offlineAchievement2 : db6.achievements) {
                                OfflineAchievement offlineAchievementFindAchievement = db5.findAchievement(offlineAchievement2.resourceID);
                                if (offlineAchievementFindAchievement == null) {
                                    offlineAchievementFindAchievement = offlineAchievement2.dup();
                                    db5.achievements.add(offlineAchievementFindAchievement);
                                }
                                offlineAchievementFindAchievement.serverCompletionPercentage = Math.max(offlineAchievementFindAchievement.serverCompletionPercentage, offlineAchievement2.clientCompletionPercentage);
                            }
                            ArrayList<OfflineScore> arrayList2 = db5.scores;
                            db5.scores = new ArrayList<>();
                            for (OfflineScore offlineScore4 : arrayList2) {
                                if (offlineScore4.blobFileName != null) {
                                    db5.scores.add(offlineScore4);
                                } else {
                                    Iterator<OfflineScore> it2 = db6.scores.iterator();
                                    while (true) {
                                        if (!it2.hasNext()) {
                                            z = false;
                                            break;
                                        }
                                        OfflineScore next = it2.next();
                                        if (OfflineSupport.access$000(offlineScore4.leaderboardID, next.leaderboardID) && offlineScore4.score == next.score && OfflineSupport.access$000(offlineScore4.displayText, next.displayText) && OfflineSupport.access$000(offlineScore4.customData, next.customData) && OfflineSupport.access$000(offlineScore4.blobFileName, next.blobFileName) && OfflineSupport.access$000(offlineScore4.timestamp, next.timestamp)) {
                                            z = true;
                                            break;
                                        }
                                    }
                                    if (!z) {
                                        db5.scores.add(offlineScore4);
                                    }
                                }
                            }
                            OfflineSupport.save();
                            OfflineSupport.uploadScoresWithBlobs();
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

    /* JADX INFO: Access modifiers changed from: private */
    public static void uploadScoresWithBlobs() throws Throwable {
        for (final OfflineScore offlineScore : db.scores) {
            if (offlineScore.blobFileName != null) {
                Score score = new Score(offlineScore.score);
                score.customData = offlineScore.customData;
                score.displayText = offlineScore.displayText;
                try {
                    score.blob = Util.readWholeFile(fullPath(offlineScore.blobFileName));
                } catch (IOException e) {
                }
                if (score.blob == null) {
                    removeAndUploadNext(offlineScore);
                    return;
                } else {
                    score.submitToFromOffline(new Leaderboard(offlineScore.leaderboardID), offlineScore.timestamp, new Score.SubmitToCB() { // from class: com.openfeint.internal.offline.OfflineSupport.1
                        @Override // com.openfeint.internal.APICallback
                        public final void onFailure(String str) {
                            OfflineSupport.updateInProgress.set(false);
                        }

                        @Override // com.openfeint.api.resource.Score.SubmitToCB
                        public final void onSuccess$1385ff() throws Throwable {
                            OfflineSupport.removeAndUploadNext(offlineScore);
                        }
                    });
                    return;
                }
            }
        }
        updateInProgress.set(false);
    }
}
