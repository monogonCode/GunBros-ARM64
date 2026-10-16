package com.glu.platform.android;

import android.app.Notification;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.app.Service;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Handler;
import android.os.IBinder;
import android.os.Message;
import com.glu.android.gunbros_free.R;
import com.urbanairship.push.PushManager;
import com.urbanairship.push.PushPreferences;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.Serializable;
import java.util.Iterator;
import java.util.Vector;
import java.util.concurrent.ScheduledFuture;
import java.util.concurrent.ScheduledThreadPoolExecutor;
import java.util.concurrent.TimeUnit;

/* JADX INFO: loaded from: classes.dex */
public class GluNotificationService extends Service {
    static final /* synthetic */ boolean $assertionsDisabled;
    private ScheduledFuture m_eventFuture;
    private ScheduledThreadPoolExecutor m_executor;
    private Handler m_fireHandler = new Handler() { // from class: com.glu.platform.android.GluNotificationService.1
        static final /* synthetic */ boolean $assertionsDisabled;

        static {
            $assertionsDisabled = !GluNotificationService.class.desiredAssertionStatus();
        }

        @Override // android.os.Handler
        public final void handleMessage(Message message) throws Throwable {
            switch (message.what) {
                case 1:
                    GluNotificationService.access$100(GluNotificationService.this, message.arg1);
                    GluNotificationService.this.m_notifications.remove(message.arg1);
                    GluNotificationService.this.saveNotifications(GluNotificationService.this.getApplicationContext());
                    GluNotificationService.this.resetTimer();
                    GluNotificationService.this.dumpNotifications();
                    return;
                default:
                    if (!$assertionsDisabled) {
                        throw new AssertionError();
                    }
                    return;
            }
        }
    };
    private Vector<NotificationRecord> m_notifications = new Vector<>();
    private Vector<PushRecord> m_pushes = new Vector<>();
    private int m_state = 2;
    private int m_notificationId = 1;

    private class FireTask implements Runnable {
        private int m_index;

        public FireTask(int i) {
            this.m_index = i;
        }

        @Override // java.lang.Runnable
        public final void run() {
            String str = "Triggered - index: " + this.m_index;
            GluNotificationService.this.m_fireHandler.sendMessage(GluNotificationService.this.m_fireHandler.obtainMessage(1, this.m_index, 0));
        }
    }

    private static class NotificationRecord implements Serializable {
        public long m_addedAt;
        public int m_badge;
        public long m_fireAt;
        public int m_icon;
        public String m_message;
        public String m_title;
        public int m_when;

        public NotificationRecord() {
        }

        public NotificationRecord(int i, String str, String str2, int i2, int i3) {
            this.m_when = i;
            this.m_title = str;
            this.m_message = str2;
            this.m_badge = i2;
            this.m_icon = i3;
        }

        public final boolean equal(NotificationRecord notificationRecord) {
            return notificationRecord.m_title.equals(this.m_title) && notificationRecord.m_message.equals(this.m_message);
        }
    }

    private static class PushRecord implements Serializable {
        public String m_alert;
        public int m_id;

        public PushRecord() {
        }

        public PushRecord(int i, String str) {
            this.m_id = i;
            this.m_alert = str;
        }
    }

    static {
        $assertionsDisabled = !GluNotificationService.class.desiredAssertionStatus();
    }

    public static boolean AreNotificationsEnabled(Context context) {
        SharedPreferences sharedPreferences = context.getSharedPreferences("com.glu.platform.android.NotificationService", 0);
        if (sharedPreferences != null) {
            return sharedPreferences.getBoolean("com.glu.platform.android.NotificationServiceEnabled", false);
        }
        return false;
    }

    static /* synthetic */ void access$100(GluNotificationService gluNotificationService, int i) {
        NotificationRecord notificationRecordElementAt = gluNotificationService.m_notifications.elementAt(i);
        switch (gluNotificationService.m_state) {
            case 1:
                Intent intent = new Intent("com.glu.platform.android.NOTIFICATION_FIRED");
                intent.putExtra("com.glu.platform.android.NOTIFICATION_TITLE", notificationRecordElementAt.m_title);
                intent.putExtra("com.glu.platform.android.NOTIFICATION_MESSAGE", notificationRecordElementAt.m_message);
                gluNotificationService.sendBroadcast(intent);
                return;
            case 2:
                Context applicationContext = gluNotificationService.getApplicationContext();
                applicationContext.getSystemService("notification");
                String str = notificationRecordElementAt.m_title;
                String str2 = notificationRecordElementAt.m_message;
                new Notification(notificationRecordElementAt.m_icon, str, System.currentTimeMillis());
                Intent intent2 = new Intent(applicationContext, (Class<?>) ((GluApplication) gluNotificationService.getApplication()).getMainActivityClass());
                PendingIntent.getActivity(applicationContext, 0, intent2, 16);
                gluNotificationService.m_notificationId++;
                if (gluNotificationService.m_notificationId > 5000) {
                    gluNotificationService.m_notificationId = 1;
                }
                String str3 = notificationRecordElementAt.m_message;
                String str4 = notificationRecordElementAt.m_title;
                Context context = GluPlatformActivity.instance;
                if (context == null) {
                    context = GluApplication.instance;
                }
                if (context != null) {
                    String string = context.getResources().getString(R.string.app_name);
                    Notification notification = new Notification(R.drawable.icon, str4, System.currentTimeMillis() + 500);
                    notification.setLatestEventInfo(context, string, str4, PendingIntent.getActivity(context, 0, intent2, 0));
                    notification.flags = 16;
                    ((NotificationManager) context.getSystemService("notification")).notify(i, notification);
                    return;
                }
                return;
            default:
                if (!$assertionsDisabled) {
                    throw new AssertionError();
                }
                return;
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void dumpNotifications() {
        for (NotificationRecord notificationRecord : this.m_notifications) {
            String str = "when: " + notificationRecord.m_when + ", title: " + notificationRecord.m_title + ", message: " + notificationRecord.m_message + ", badge: " + notificationRecord.m_badge + ", icon: " + notificationRecord.m_icon;
        }
    }

    private int findNotification(NotificationRecord notificationRecord) {
        int i;
        int i2 = 0;
        Iterator<NotificationRecord> it = this.m_notifications.iterator();
        while (true) {
            i = i2;
            if (!it.hasNext()) {
                i = -1;
                break;
            }
            if (notificationRecord.equal(it.next())) {
                String str = "Found - index: " + i;
                break;
            }
            i2 = i + 1;
            String str2 = "3 - index: " + i2;
        }
        String str3 = "Exited - res: " + i;
        return i;
    }

    private void handleCommand$7a9ca511(Intent intent) throws Throwable {
        String action = intent.getAction();
        String str = "Entered - Action: " + action;
        if (action.equals("com.glu.platform.android.ENABLE_NOTIFICATIONS")) {
            boolean booleanExtra = intent.getBooleanExtra("com.glu.platform.android.ENABLE_NOTIFICATIONS_ENABLE", false);
            String str2 = "enable: " + booleanExtra;
            SharedPreferences.Editor editorEdit = getApplicationContext().getSharedPreferences("com.glu.platform.android.NotificationService", 0).edit();
            editorEdit.putBoolean("com.glu.platform.android.NotificationServiceEnabled", booleanExtra);
            editorEdit.commit();
            if (!booleanExtra) {
                stopSelf();
            }
        } else if (action.equals("com.glu.platform.android.START_NOTIFICATIONS")) {
            loadNotifications(getApplicationContext());
            removeDeadNotifications();
            this.m_executor = new ScheduledThreadPoolExecutor(1);
            resetTimer();
        } else if (action.equals("com.glu.platform.android.STOP_NOTIFICATIONS")) {
            if (this.m_eventFuture != null) {
                this.m_eventFuture.cancel(false);
                try {
                    this.m_eventFuture.get();
                } catch (Exception e) {
                }
                this.m_eventFuture = null;
            }
            this.m_executor.shutdownNow();
            this.m_executor = null;
            saveNotifications(getApplicationContext());
            savePushes(getApplicationContext());
        } else if (action.equals("com.glu.platform.android.ADD_NOTIFICATION")) {
            int intExtra = intent.getIntExtra("com.glu.platform.android.NOTIFICATION_WHEN", 0);
            NotificationRecord notificationRecord = new NotificationRecord(intExtra, intent.getStringExtra("com.glu.platform.android.NOTIFICATION_TITLE"), intent.getStringExtra("com.glu.platform.android.NOTIFICATION_MESSAGE"), intent.getIntExtra("com.glu.platform.android.NOTIFICATION_BADGE", 0), intent.getIntExtra("com.glu.platform.android.NOTIFICATION_ICON", 0));
            if (-1 == findNotification(notificationRecord)) {
                notificationRecord.m_addedAt = System.currentTimeMillis();
                notificationRecord.m_fireAt = notificationRecord.m_addedAt + (((long) intExtra) * 1000);
                this.m_notifications.addElement(notificationRecord);
                saveNotifications(getApplicationContext());
                resetTimer();
            }
        } else if (action.equals("com.glu.platform.android.REMOVE_NOTIFICATION")) {
            int iFindNotification = findNotification(new NotificationRecord(0, intent.getStringExtra("com.glu.platform.android.NOTIFICATION_TITLE"), intent.getStringExtra("com.glu.platform.android.NOTIFICATION_MESSAGE"), 0, 0));
            if (-1 != iFindNotification) {
                this.m_notifications.remove(iFindNotification);
                saveNotifications(getApplicationContext());
                resetTimer();
                dumpNotifications();
            }
        } else if (action.equals("com.glu.platform.android.REMOVE_ALL_NOTIFICATIONS")) {
            this.m_notifications.clear();
            saveNotifications(getApplicationContext());
            resetTimer();
        } else if (action.equals("com.glu.platform.android.APP_STATE")) {
            this.m_state = intent.getIntExtra("com.glu.platform.andoird.APP_STATE_STATE", 2);
        } else if (action.equals("com.glu.platform.android.ADD_PUSH_NOTIFICATION")) {
            GluNotificationConstants.logIntent(intent);
            PushRecord pushRecord = new PushRecord(intent.getIntExtra(PushManager.EXTRA_NOTIFICATION_ID, 0), intent.getStringExtra("com.glu.platform.android.PUSH_NOTIFICATION_PAYLOAD"));
            loadPushes(getApplicationContext());
            this.m_pushes.addElement(pushRecord);
            savePushes(getApplicationContext());
        } else if (action.equals("com.glu.platform.android.CLEAR_PUSH_NOTIFICATIONS")) {
            GluNotificationConstants.logIntent(intent);
            this.m_pushes.clear();
            savePushes(getApplicationContext());
        } else if (action.equals("com.glu.platform.android.CLEAR_PUSH_NOTIFICATION_OPENED")) {
            GluNotificationConstants.logIntent(intent);
            int intExtra2 = intent.getIntExtra(PushManager.EXTRA_NOTIFICATION_ID, 0);
            String stringExtra = intent.getStringExtra("com.glu.platform.android.PUSH_NOTIFICATION_PAYLOAD");
            PushRecord pushRecord2 = new PushRecord(intExtra2, stringExtra);
            String str3 = "New push, id: " + intExtra2 + ", alert: " + stringExtra;
            loadPushes(getApplicationContext());
            this.m_pushes.addElement(pushRecord2);
            savePushes(getApplicationContext());
            Intent intent2 = new Intent("android.intent.action.MAIN");
            intent2.setClass(getApplicationContext(), ((GluApplication) getApplication()).getMainActivityClass());
            intent2.addCategory("android.intent.category.LAUNCHER");
            intent2.setFlags(268435456);
            getApplicationContext().startActivity(intent2);
        } else if (action.equals("com.glu.platform.android.HANDLE_PUSH_NOTIFICATIONS")) {
            loadPushes(getApplicationContext());
            for (PushRecord pushRecord3 : this.m_pushes) {
                handlePushNotification(pushRecord3.m_id, pushRecord3.m_alert);
            }
            this.m_pushes.clear();
            savePushes(getApplicationContext());
        } else if (action.equals("com.glu.platform.android.ENABLE_PUSH_NOTIFICATIONS")) {
            boolean booleanExtra2 = intent.getBooleanExtra("com.glu.platform.android.ENABLE_NOTIFICATIONS_ENABLE", false);
            PushPreferences preferences = PushManager.shared().getPreferences();
            if (booleanExtra2) {
                if (!preferences.isPushEnabled()) {
                    PushManager.enablePush();
                }
            } else if (preferences.isPushEnabled()) {
                PushManager.disablePush();
                this.m_pushes.clear();
                savePushes(getApplicationContext());
            }
        }
        dumpNotifications();
    }

    private native void handlePushNotification(int i, String str);

    /* JADX WARN: Code duplicated, block: B:48:0x0071 A[Catch: IOException -> 0x0075, TRY_LEAVE, TryCatch #1 {IOException -> 0x0075, blocks: (B:46:0x006c, B:48:0x0071), top: B:70:0x006c }] */
    private void loadNotifications(Context context) throws Throwable {
        FileInputStream fileInputStreamOpenFileInput;
        Throwable th;
        ObjectInputStream objectInputStream;
        FileInputStream fileInputStream;
        ObjectInputStream objectInputStream2 = null;
        try {
            fileInputStreamOpenFileInput = context.openFileInput("notifications.txt");
            if (fileInputStreamOpenFileInput != null) {
                try {
                    objectInputStream = new ObjectInputStream(fileInputStreamOpenFileInput);
                    try {
                        int i = objectInputStream.readInt();
                        this.m_notifications.clear();
                        for (int i2 = 0; i2 < i; i2++) {
                            this.m_notifications.add((NotificationRecord) objectInputStream.readObject());
                        }
                    } catch (FileNotFoundException e) {
                        if (objectInputStream != null) {
                            try {
                                objectInputStream.close();
                            } catch (IOException e2) {
                                return;
                            }
                        }
                        if (fileInputStreamOpenFileInput != null) {
                            fileInputStreamOpenFileInput.close();
                            return;
                        }
                        return;
                    } catch (IOException e3) {
                        if (objectInputStream != null) {
                            try {
                                objectInputStream.close();
                            } catch (IOException e4) {
                                return;
                            }
                        }
                        if (fileInputStreamOpenFileInput != null) {
                            fileInputStreamOpenFileInput.close();
                            return;
                        }
                        return;
                    } catch (ClassNotFoundException e5) {
                        objectInputStream2 = objectInputStream;
                        fileInputStream = fileInputStreamOpenFileInput;
                        if (objectInputStream2 != null) {
                            try {
                                objectInputStream2.close();
                            } catch (IOException e6) {
                                return;
                            }
                        }
                        if (fileInputStream != null) {
                            fileInputStream.close();
                            return;
                        }
                        return;
                    } catch (Throwable th2) {
                        th = th2;
                        if (objectInputStream != null) {
                            try {
                                objectInputStream.close();
                                if (fileInputStreamOpenFileInput != null) {
                                    fileInputStreamOpenFileInput.close();
                                }
                            } catch (IOException e7) {
                                throw th;
                            }
                        } else if (fileInputStreamOpenFileInput != null) {
                            fileInputStreamOpenFileInput.close();
                        }
                        throw th;
                    }
                } catch (FileNotFoundException e8) {
                    objectInputStream = null;
                } catch (IOException e9) {
                    objectInputStream = null;
                } catch (ClassNotFoundException e10) {
                    fileInputStream = fileInputStreamOpenFileInput;
                } catch (Throwable th3) {
                    objectInputStream = null;
                    th = th3;
                }
            } else {
                objectInputStream = null;
            }
            if (objectInputStream != null) {
                try {
                    objectInputStream.close();
                } catch (IOException e11) {
                    return;
                }
            }
            if (fileInputStreamOpenFileInput != null) {
                fileInputStreamOpenFileInput.close();
            }
        } catch (FileNotFoundException e12) {
            objectInputStream = null;
            fileInputStreamOpenFileInput = null;
        } catch (IOException e13) {
            objectInputStream = null;
            fileInputStreamOpenFileInput = null;
        } catch (ClassNotFoundException e14) {
            fileInputStream = null;
        } catch (Throwable th4) {
            fileInputStreamOpenFileInput = null;
            th = th4;
            objectInputStream = null;
        }
    }

    /* JADX WARN: Code duplicated, block: B:48:0x0071 A[Catch: IOException -> 0x0075, TRY_LEAVE, TryCatch #1 {IOException -> 0x0075, blocks: (B:46:0x006c, B:48:0x0071), top: B:70:0x006c }] */
    private void loadPushes(Context context) throws Throwable {
        FileInputStream fileInputStreamOpenFileInput;
        Throwable th;
        ObjectInputStream objectInputStream;
        FileInputStream fileInputStream;
        ObjectInputStream objectInputStream2 = null;
        try {
            fileInputStreamOpenFileInput = context.openFileInput("pushes.txt");
            if (fileInputStreamOpenFileInput != null) {
                try {
                    objectInputStream = new ObjectInputStream(fileInputStreamOpenFileInput);
                    try {
                        int i = objectInputStream.readInt();
                        this.m_pushes.clear();
                        for (int i2 = 0; i2 < i; i2++) {
                            this.m_pushes.add((PushRecord) objectInputStream.readObject());
                        }
                    } catch (FileNotFoundException e) {
                        if (objectInputStream != null) {
                            try {
                                objectInputStream.close();
                            } catch (IOException e2) {
                                return;
                            }
                        }
                        if (fileInputStreamOpenFileInput != null) {
                            fileInputStreamOpenFileInput.close();
                            return;
                        }
                        return;
                    } catch (IOException e3) {
                        if (objectInputStream != null) {
                            try {
                                objectInputStream.close();
                            } catch (IOException e4) {
                                return;
                            }
                        }
                        if (fileInputStreamOpenFileInput != null) {
                            fileInputStreamOpenFileInput.close();
                            return;
                        }
                        return;
                    } catch (ClassNotFoundException e5) {
                        objectInputStream2 = objectInputStream;
                        fileInputStream = fileInputStreamOpenFileInput;
                        if (objectInputStream2 != null) {
                            try {
                                objectInputStream2.close();
                            } catch (IOException e6) {
                                return;
                            }
                        }
                        if (fileInputStream != null) {
                            fileInputStream.close();
                            return;
                        }
                        return;
                    } catch (Throwable th2) {
                        th = th2;
                        if (objectInputStream != null) {
                            try {
                                objectInputStream.close();
                                if (fileInputStreamOpenFileInput != null) {
                                    fileInputStreamOpenFileInput.close();
                                }
                            } catch (IOException e7) {
                                throw th;
                            }
                        } else if (fileInputStreamOpenFileInput != null) {
                            fileInputStreamOpenFileInput.close();
                        }
                        throw th;
                    }
                } catch (FileNotFoundException e8) {
                    objectInputStream = null;
                } catch (IOException e9) {
                    objectInputStream = null;
                } catch (ClassNotFoundException e10) {
                    fileInputStream = fileInputStreamOpenFileInput;
                } catch (Throwable th3) {
                    objectInputStream = null;
                    th = th3;
                }
            } else {
                objectInputStream = null;
            }
            if (objectInputStream != null) {
                try {
                    objectInputStream.close();
                } catch (IOException e11) {
                    return;
                }
            }
            if (fileInputStreamOpenFileInput != null) {
                fileInputStreamOpenFileInput.close();
            }
        } catch (FileNotFoundException e12) {
            objectInputStream = null;
            fileInputStreamOpenFileInput = null;
        } catch (IOException e13) {
            objectInputStream = null;
            fileInputStreamOpenFileInput = null;
        } catch (ClassNotFoundException e14) {
            fileInputStream = null;
        } catch (Throwable th4) {
            fileInputStreamOpenFileInput = null;
            th = th4;
            objectInputStream = null;
        }
    }

    private void removeDeadNotifications() {
        long jCurrentTimeMillis = System.currentTimeMillis();
        Iterator<NotificationRecord> it = this.m_notifications.iterator();
        while (it.hasNext()) {
            if (it.next().m_fireAt < jCurrentTimeMillis) {
                it.remove();
            }
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void resetTimer() {
        long jCurrentTimeMillis = System.currentTimeMillis();
        int i = 0;
        long j = Long.MAX_VALUE;
        int i2 = -1;
        while (true) {
            int i3 = i;
            if (i3 >= this.m_notifications.size()) {
                break;
            }
            long j2 = this.m_notifications.elementAt(i3).m_fireAt - jCurrentTimeMillis;
            if (j2 < j) {
                i2 = i3;
                j = j2;
            }
            i = i3 + 1;
        }
        if (this.m_executor != null) {
            this.m_executor.shutdownNow();
        }
        this.m_executor = new ScheduledThreadPoolExecutor(1);
        if (-1 != i2) {
            this.m_eventFuture = this.m_executor.schedule(new FireTask(i2), j, TimeUnit.MILLISECONDS);
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* JADX WARN: Code duplicated, block: B:40:0x0066 A[Catch: IOException -> 0x006a, TRY_LEAVE, TryCatch #7 {IOException -> 0x006a, blocks: (B:38:0x0061, B:40:0x0066), top: B:62:0x0061 }] */
    public void saveNotifications(Context context) throws Throwable {
        FileOutputStream fileOutputStreamOpenFileOutput;
        Throwable th;
        ObjectOutputStream objectOutputStream;
        FileOutputStream fileOutputStream;
        ObjectOutputStream objectOutputStream2 = null;
        try {
            fileOutputStreamOpenFileOutput = context.openFileOutput("notifications.txt", 0);
            if (fileOutputStreamOpenFileOutput != null) {
                try {
                    objectOutputStream = new ObjectOutputStream(fileOutputStreamOpenFileOutput);
                    try {
                        objectOutputStream.writeInt(this.m_notifications.size());
                        Iterator<NotificationRecord> it = this.m_notifications.iterator();
                        while (it.hasNext()) {
                            objectOutputStream.writeObject(it.next());
                        }
                    } catch (FileNotFoundException e) {
                        objectOutputStream2 = objectOutputStream;
                        fileOutputStream = fileOutputStreamOpenFileOutput;
                        if (objectOutputStream2 != null) {
                            try {
                                objectOutputStream2.close();
                            } catch (IOException e2) {
                                return;
                            }
                        }
                        if (fileOutputStream != null) {
                            fileOutputStream.close();
                            return;
                        }
                        return;
                    } catch (IOException e3) {
                        if (objectOutputStream != null) {
                            try {
                                objectOutputStream.close();
                            } catch (IOException e4) {
                                return;
                            }
                        }
                        if (fileOutputStreamOpenFileOutput != null) {
                            fileOutputStreamOpenFileOutput.close();
                            return;
                        }
                        return;
                    } catch (Throwable th2) {
                        th = th2;
                        if (objectOutputStream != null) {
                            try {
                                objectOutputStream.close();
                                if (fileOutputStreamOpenFileOutput != null) {
                                    fileOutputStreamOpenFileOutput.close();
                                }
                            } catch (IOException e5) {
                                throw th;
                            }
                        } else if (fileOutputStreamOpenFileOutput != null) {
                            fileOutputStreamOpenFileOutput.close();
                        }
                        throw th;
                    }
                } catch (FileNotFoundException e6) {
                    fileOutputStream = fileOutputStreamOpenFileOutput;
                } catch (IOException e7) {
                    objectOutputStream = null;
                } catch (Throwable th3) {
                    objectOutputStream = null;
                    th = th3;
                }
            } else {
                objectOutputStream = null;
            }
            if (objectOutputStream != null) {
                try {
                    objectOutputStream.close();
                } catch (IOException e8) {
                    return;
                }
            }
            if (fileOutputStreamOpenFileOutput != null) {
                fileOutputStreamOpenFileOutput.close();
            }
        } catch (FileNotFoundException e9) {
            fileOutputStream = null;
        } catch (IOException e10) {
            objectOutputStream = null;
            fileOutputStreamOpenFileOutput = null;
        } catch (Throwable th4) {
            fileOutputStreamOpenFileOutput = null;
            th = th4;
            objectOutputStream = null;
        }
    }

    /* JADX WARN: Code duplicated, block: B:40:0x0066 A[Catch: IOException -> 0x006a, TRY_LEAVE, TryCatch #7 {IOException -> 0x006a, blocks: (B:38:0x0061, B:40:0x0066), top: B:62:0x0061 }] */
    private void savePushes(Context context) throws Throwable {
        FileOutputStream fileOutputStreamOpenFileOutput;
        Throwable th;
        ObjectOutputStream objectOutputStream;
        FileOutputStream fileOutputStream;
        ObjectOutputStream objectOutputStream2 = null;
        try {
            fileOutputStreamOpenFileOutput = context.openFileOutput("pushes.txt", 0);
            if (fileOutputStreamOpenFileOutput != null) {
                try {
                    objectOutputStream = new ObjectOutputStream(fileOutputStreamOpenFileOutput);
                    try {
                        objectOutputStream.writeInt(this.m_pushes.size());
                        Iterator<PushRecord> it = this.m_pushes.iterator();
                        while (it.hasNext()) {
                            objectOutputStream.writeObject(it.next());
                        }
                    } catch (FileNotFoundException e) {
                        objectOutputStream2 = objectOutputStream;
                        fileOutputStream = fileOutputStreamOpenFileOutput;
                        if (objectOutputStream2 != null) {
                            try {
                                objectOutputStream2.close();
                            } catch (IOException e2) {
                                return;
                            }
                        }
                        if (fileOutputStream != null) {
                            fileOutputStream.close();
                            return;
                        }
                        return;
                    } catch (IOException e3) {
                        if (objectOutputStream != null) {
                            try {
                                objectOutputStream.close();
                            } catch (IOException e4) {
                                return;
                            }
                        }
                        if (fileOutputStreamOpenFileOutput != null) {
                            fileOutputStreamOpenFileOutput.close();
                            return;
                        }
                        return;
                    } catch (Throwable th2) {
                        th = th2;
                        if (objectOutputStream != null) {
                            try {
                                objectOutputStream.close();
                                if (fileOutputStreamOpenFileOutput != null) {
                                    fileOutputStreamOpenFileOutput.close();
                                }
                            } catch (IOException e5) {
                                throw th;
                            }
                        } else if (fileOutputStreamOpenFileOutput != null) {
                            fileOutputStreamOpenFileOutput.close();
                        }
                        throw th;
                    }
                } catch (FileNotFoundException e6) {
                    fileOutputStream = fileOutputStreamOpenFileOutput;
                } catch (IOException e7) {
                    objectOutputStream = null;
                } catch (Throwable th3) {
                    objectOutputStream = null;
                    th = th3;
                }
            } else {
                objectOutputStream = null;
            }
            if (objectOutputStream != null) {
                try {
                    objectOutputStream.close();
                } catch (IOException e8) {
                    return;
                }
            }
            if (fileOutputStreamOpenFileOutput != null) {
                fileOutputStreamOpenFileOutput.close();
            }
        } catch (FileNotFoundException e9) {
            fileOutputStream = null;
        } catch (IOException e10) {
            objectOutputStream = null;
            fileOutputStreamOpenFileOutput = null;
        } catch (Throwable th4) {
            fileOutputStreamOpenFileOutput = null;
            th = th4;
            objectOutputStream = null;
        }
    }

    @Override // android.app.Service
    public IBinder onBind(Intent intent) {
        return null;
    }

    @Override // android.app.Service
    public void onCreate() throws Throwable {
        loadNotifications(getApplicationContext());
        resetTimer();
    }

    @Override // android.app.Service
    public void onDestroy() {
    }

    @Override // android.app.Service
    public void onStart(Intent intent, int i) throws Throwable {
        if (intent != null) {
            handleCommand$7a9ca511(intent);
        }
    }

    @Override // android.app.Service
    public int onStartCommand(Intent intent, int i, int i2) throws Throwable {
        if (intent == null) {
            return 1;
        }
        handleCommand$7a9ca511(intent);
        return 1;
    }
}
