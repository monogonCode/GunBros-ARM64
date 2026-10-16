package com.openfeint.internal;

import android.content.Context;
import android.content.pm.ApplicationInfo;
import com.openfeint.internal.logcat.OFLog;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.StreamCorruptedException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.concurrent.locks.ReentrantReadWriteLock;

/* JADX INFO: loaded from: classes.dex */
public final class SyncedStore {
    private Context mContext;
    private HashMap<String, String> mMap = new HashMap<>();
    private ReentrantReadWriteLock mLock = new ReentrantReadWriteLock();

    public class Editor {
        public Editor() {
        }

        public final void commit() throws Throwable {
            SyncedStore.this.save();
            SyncedStore.this.mLock.writeLock().unlock();
        }

        public final void putString(String str, String str2) {
            SyncedStore.this.mMap.put(str, str2);
        }

        public final void remove(String str) {
            SyncedStore.this.mMap.remove(str);
        }
    }

    public class Reader {
        public Reader() {
        }

        public final void complete() {
            SyncedStore.this.mLock.readLock().unlock();
        }

        public final String getString(String str, String str2) {
            String str3 = (String) SyncedStore.this.mMap.get(str);
            return str3 != null ? str3 : str2;
        }
    }

    public SyncedStore(Context context) throws Throwable {
        this.mContext = context;
        load();
    }

    private void load() throws Throwable {
        ApplicationInfo next;
        File file;
        boolean z;
        boolean z2 = false;
        this.mMap = null;
        long jCurrentTimeMillis = System.currentTimeMillis();
        File fileStreamPath = this.mContext.getFileStreamPath("of_prefs");
        this.mLock.writeLock().lock();
        try {
            List<ApplicationInfo> installedApplications = this.mContext.getPackageManager().getInstalledApplications(0);
            Iterator<ApplicationInfo> it = installedApplications.iterator();
            do {
                if (!it.hasNext()) {
                    next = null;
                    break;
                }
                next = it.next();
            } while (!next.packageName.equals(this.mContext.getPackageName()));
            String canonicalPath = fileStreamPath.getCanonicalPath();
            if (next != null && canonicalPath.startsWith(next.dataDir)) {
                String strSubstring = canonicalPath.substring(next.dataDir.length());
                Iterator<ApplicationInfo> it2 = installedApplications.iterator();
                while (it2.hasNext()) {
                    File file2 = new File(it2.next().dataDir, strSubstring);
                    if (fileStreamPath.lastModified() < file2.lastModified()) {
                        z = true;
                        file = file2;
                    } else {
                        file = fileStreamPath;
                        z = z2;
                    }
                    fileStreamPath = file;
                    z2 = z;
                }
                this.mMap = mapFromStore(fileStreamPath);
            }
            if (this.mMap == null) {
                this.mMap = new HashMap<>();
            }
        } catch (IOException e) {
            OFLog.e("DistributedPrefs", "broken");
        } finally {
            this.mLock.writeLock().unlock();
        }
        if (z2) {
            save();
        }
        OFLog.d("DistributedPrefs", "Loading prefs took " + new Long(System.currentTimeMillis() - jCurrentTimeMillis).toString() + " millis");
    }

    /* JADX WARN: Code duplicated, block: B:65:0x00b4 A[Catch: IOException -> 0x00be, TRY_ENTER, TRY_LEAVE, TryCatch #20 {IOException -> 0x00be, blocks: (B:65:0x00b4, B:68:0x00ba), top: B:112:0x00b2 }] */
    /* JADX WARN: Code duplicated, block: B:67:0x00b8 A[DONT_INVERT] */
    /* JADX WARN: Code duplicated, block: B:68:0x00ba A[Catch: IOException -> 0x00be, TRY_ENTER, TRY_LEAVE, TryCatch #20 {IOException -> 0x00be, blocks: (B:65:0x00b4, B:68:0x00ba), top: B:112:0x00b2 }] */
    private static HashMap<String, String> mapFromStore(File file) throws Throwable {
        ObjectInputStream objectInputStream;
        FileInputStream fileInputStream;
        ObjectInputStream objectInputStream2;
        ObjectInputStream objectInputStream3;
        FileInputStream fileInputStream2;
        try {
            try {
                fileInputStream = new FileInputStream(file);
                try {
                    objectInputStream2 = new ObjectInputStream(fileInputStream);
                    try {
                        Object object = objectInputStream2.readObject();
                        if (object != null && (object instanceof HashMap)) {
                            HashMap<String, String> map = (HashMap) object;
                            try {
                                objectInputStream2.close();
                                return map;
                            } catch (IOException e) {
                                OFLog.e("DistributedPrefs", "IOException while cleaning up");
                                return map;
                            }
                        }
                        try {
                            objectInputStream2.close();
                        } catch (IOException e2) {
                            OFLog.e("DistributedPrefs", "IOException while cleaning up");
                        }
                    } catch (FileNotFoundException e3) {
                        objectInputStream3 = objectInputStream2;
                        fileInputStream2 = fileInputStream;
                        try {
                            OFLog.e("DistributedPrefs", "Couldn't open of_prefs");
                            try {
                                if (objectInputStream3 != null) {
                                    objectInputStream3.close();
                                } else if (fileInputStream2 != null) {
                                    fileInputStream2.close();
                                }
                            } catch (IOException e4) {
                                OFLog.e("DistributedPrefs", "IOException while cleaning up");
                            }
                        } catch (Throwable th) {
                            fileInputStream = fileInputStream2;
                            objectInputStream = objectInputStream3;
                            th = th;
                            try {
                                if (objectInputStream != null) {
                                    if (fileInputStream != null) {
                                        fileInputStream.close();
                                    }
                                    throw th;
                                }
                                objectInputStream.close();
                            } catch (IOException e5) {
                                OFLog.e("DistributedPrefs", "IOException while cleaning up");
                            }
                            throw th;
                        }
                    } catch (StreamCorruptedException e6) {
                        OFLog.e("DistributedPrefs", "StreamCorruptedException");
                        try {
                            if (objectInputStream2 != null) {
                                objectInputStream2.close();
                            } else if (fileInputStream != null) {
                                fileInputStream.close();
                            }
                        } catch (IOException e7) {
                            OFLog.e("DistributedPrefs", "IOException while cleaning up");
                        }
                    } catch (IOException e8) {
                        OFLog.e("DistributedPrefs", "IOException while reading");
                        try {
                            if (objectInputStream2 != null) {
                                objectInputStream2.close();
                            } else if (fileInputStream != null) {
                                fileInputStream.close();
                            }
                        } catch (IOException e9) {
                            OFLog.e("DistributedPrefs", "IOException while cleaning up");
                        }
                    } catch (ClassNotFoundException e10) {
                        OFLog.e("DistributedPrefs", "ClassNotFoundException");
                        try {
                            if (objectInputStream2 != null) {
                                objectInputStream2.close();
                            } else if (fileInputStream != null) {
                                fileInputStream.close();
                            }
                        } catch (IOException e11) {
                            OFLog.e("DistributedPrefs", "IOException while cleaning up");
                        }
                    }
                } catch (FileNotFoundException e12) {
                    objectInputStream3 = null;
                    fileInputStream2 = fileInputStream;
                } catch (StreamCorruptedException e13) {
                    objectInputStream2 = null;
                } catch (IOException e14) {
                    objectInputStream2 = null;
                } catch (ClassNotFoundException e15) {
                    objectInputStream2 = null;
                } catch (Throwable th2) {
                    th = th2;
                    objectInputStream = null;
                    if (objectInputStream != null) {
                        if (fileInputStream != null) {
                            fileInputStream.close();
                        }
                        throw th;
                    }
                    objectInputStream.close();
                    throw th;
                }
            } catch (Throwable th3) {
                th = th3;
            }
        } catch (FileNotFoundException e16) {
            objectInputStream3 = null;
            fileInputStream2 = null;
        } catch (StreamCorruptedException e17) {
            objectInputStream2 = null;
            fileInputStream = null;
        } catch (IOException e18) {
            objectInputStream2 = null;
            fileInputStream = null;
        } catch (ClassNotFoundException e19) {
            objectInputStream2 = null;
            fileInputStream = null;
        } catch (Throwable th4) {
            th = th4;
            objectInputStream = null;
            fileInputStream = null;
        }
        return null;
    }

    final Editor edit() {
        this.mLock.writeLock().lock();
        return new Editor();
    }

    final Reader read() {
        this.mLock.readLock().lock();
        return new Reader();
    }

    /* JADX WARN: Code duplicated, block: B:33:0x0086 A[Catch: IOException -> 0x0099, all -> 0x00ab, Merged into TryCatch #2 {all -> 0x00ab, IOException -> 0x0099, blocks: (B:33:0x0086, B:37:0x0095, B:40:0x009a), top: B:56:0x0084 }, TRY_ENTER, TRY_LEAVE] */
    /* JADX WARN: Code duplicated, block: B:36:0x0093 A[DONT_INVERT] */
    /* JADX WARN: Code duplicated, block: B:37:0x0095 A[Catch: IOException -> 0x0099, all -> 0x00ab, Merged into TryCatch #2 {all -> 0x00ab, IOException -> 0x0099, blocks: (B:33:0x0086, B:37:0x0095, B:40:0x009a), top: B:56:0x0084 }, TRY_ENTER, TRY_LEAVE] */
    public final void save() throws Throwable {
        FileOutputStream fileOutputStreamOpenFileOutput;
        ObjectOutputStream objectOutputStream;
        ObjectOutputStream objectOutputStream2 = null;
        objectOutputStream2 = null;
        FileOutputStream fileOutputStream = null;
        this.mLock.readLock().lock();
        try {
            fileOutputStreamOpenFileOutput = this.mContext.openFileOutput("of_prefs", 1);
            try {
                objectOutputStream = new ObjectOutputStream(fileOutputStreamOpenFileOutput);
                try {
                    objectOutputStream.writeObject(this.mMap);
                    try {
                        objectOutputStream.close();
                    } catch (IOException e) {
                        OFLog.e("DistributedPrefs", "IOException while cleaning up");
                    } finally {
                        this.mLock.readLock().unlock();
                    }
                } catch (IOException e2) {
                    fileOutputStream = fileOutputStreamOpenFileOutput;
                    try {
                        OFLog.e("DistributedPrefs", "Couldn't open of_prefs for writing");
                        try {
                            if (objectOutputStream == null) {
                                if (fileOutputStream != null) {
                                    fileOutputStream.close();
                                }
                                this.mLock.readLock().unlock();
                            }
                            objectOutputStream.close();
                            this.mLock.readLock().unlock();
                        } catch (IOException e3) {
                            OFLog.e("DistributedPrefs", "IOException while cleaning up");
                        } finally {
                            this.mLock.readLock().unlock();
                        }
                    } catch (Throwable th) {
                        fileOutputStreamOpenFileOutput = fileOutputStream;
                        objectOutputStream2 = objectOutputStream;
                        th = th;
                        try {
                            if (objectOutputStream2 != null) {
                                if (fileOutputStreamOpenFileOutput != null) {
                                    fileOutputStreamOpenFileOutput.close();
                                }
                                this.mLock.readLock().unlock();
                                throw th;
                            }
                            objectOutputStream2.close();
                            this.mLock.readLock().unlock();
                        } catch (IOException e4) {
                            OFLog.e("DistributedPrefs", "IOException while cleaning up");
                        } finally {
                            this.mLock.readLock().unlock();
                        }
                        throw th;
                    }
                } catch (Throwable th2) {
                    objectOutputStream2 = objectOutputStream;
                    th = th2;
                    if (objectOutputStream2 != null) {
                        if (fileOutputStreamOpenFileOutput != null) {
                            fileOutputStreamOpenFileOutput.close();
                        }
                        this.mLock.readLock().unlock();
                        throw th;
                    }
                    objectOutputStream2.close();
                    this.mLock.readLock().unlock();
                    throw th;
                }
            } catch (IOException e5) {
                objectOutputStream = null;
                fileOutputStream = fileOutputStreamOpenFileOutput;
            } catch (Throwable th3) {
                th = th3;
            }
        } catch (IOException e6) {
            objectOutputStream = null;
        } catch (Throwable th4) {
            th = th4;
            fileOutputStreamOpenFileOutput = null;
        }
    }
}
