package com.glu.platform.android.resdl;

import android.os.Environment;
import android.os.StatFs;
import com.glu.android.gunbros_free.R;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.ProtocolException;
import java.net.UnknownHostException;
import java.util.Vector;

/* JADX INFO: loaded from: classes.dex */
public final class GluDownloadResMgr {
    public static GluDownloadResMgr instance = null;
    public boolean m_mainResFileInterrupted;
    public boolean m_secondaryFilesPassedOnce;
    public byte[] m_prevVerifiedVersion = new byte[4];
    public byte[] m_reserved = new byte[251];
    public Thread m_downloadThread = null;
    public String m_specialCurrentFilename = null;
    private Vector<SplitDownloadSpec> m_splitSpecialDownloads = new Vector<>();
    private boolean m_specialFilesChecksummed = false;
    private boolean m_specialFilesBeingChecksummed = false;
    private int m_specialFilePartCompletedSoFar = 0;
    private int m_specialFilePartTotal = 0;
    private Thread m_specialChecksumThread = null;

    public static class SplitDownloadSpec {
        public long checksum;
        public int downloadLength;
        public int downloadOffset;
        public String fullFilename;
        private boolean m_checksumDetermined = false;
        private boolean m_checksumResult = false;

        public SplitDownloadSpec(String str, long j, int i, int i2) {
            this.fullFilename = null;
            this.checksum = 0L;
            this.downloadOffset = 0;
            this.downloadLength = 0;
            this.fullFilename = str;
            this.checksum = j;
            this.downloadOffset = i;
            this.downloadLength = i2;
        }

        public final boolean checksumPassed() {
            return this.m_checksumDetermined ? this.m_checksumResult : redoChecksum();
        }

        public final boolean redoChecksum() {
            boolean z = false;
            File file = new File(this.fullFilename);
            if (file.exists()) {
                if (GluUtil.performChecksum(file, this.checksum, this.downloadLength) == null && file.length() == this.downloadLength) {
                    z = true;
                }
                this.m_checksumResult = z;
            } else {
                this.m_checksumResult = false;
            }
            this.m_checksumDetermined = true;
            return this.m_checksumResult;
        }
    }

    public GluDownloadResMgr() {
        this.m_mainResFileInterrupted = false;
        this.m_secondaryFilesPassedOnce = false;
        instance = this;
        if (!getDataFile().exists()) {
            initialize(true);
            return;
        }
        try {
            File dataFile = getDataFile();
            boolean z = dataFile.exists() && dataFile.length() == 1;
            initialize(false);
            FileInputStream fileInputStream = new FileInputStream(getDataFile());
            this.m_mainResFileInterrupted = fileInputStream.read() == 1;
            this.m_secondaryFilesPassedOnce = fileInputStream.read() == 1;
            if (!z) {
                fileInputStream.read(this.m_prevVerifiedVersion);
                fileInputStream.read(this.m_reserved);
            }
            fileInputStream.close();
            Debug.log("Read resource download data file.");
            if (z) {
                Debug.log("Updating old template dlstatus.dat");
                saveFile();
            }
        } catch (Exception e) {
            Debug.log("Error reading resource download data file. Will initialize.", e);
            initialize(true);
        }
    }

    static /* synthetic */ String access$200$5bdf26ba(GluDownloadResMgr gluDownloadResMgr, String str, int i, int i2) {
        return gluDownloadResMgr.downloadFile$5e52f91b((byte) 2, str, i, i2);
    }

    static /* synthetic */ int access$312(GluDownloadResMgr gluDownloadResMgr, int i) {
        int i2 = gluDownloadResMgr.m_specialFilePartCompletedSoFar + i;
        gluDownloadResMgr.m_specialFilePartCompletedSoFar = i2;
        return i2;
    }

    static /* synthetic */ String access$400$1bc0119a(GluDownloadResMgr gluDownloadResMgr, byte b) {
        return gluDownloadResMgr.downloadFile$5e52f91b(b, null, -1, -1);
    }

    static /* synthetic */ void access$500(GluDownloadResMgr gluDownloadResMgr) {
        gluDownloadResMgr.m_splitSpecialDownloads.removeAllElements();
        gluDownloadResMgr.m_specialFilesChecksummed = false;
        gluDownloadResMgr.m_specialFilesBeingChecksummed = false;
        gluDownloadResMgr.m_specialFilePartTotal = 0;
        gluDownloadResMgr.m_specialFilePartCompletedSoFar = 0;
    }

    static /* synthetic */ void access$600(GluDownloadResMgr gluDownloadResMgr) {
        File fileFindResourceFile = GluUtil.findResourceFile();
        if (fileFindResourceFile != null) {
            String fileDirectoryWithEnder = GluUtil.getFileDirectoryWithEnder(fileFindResourceFile.getAbsolutePath());
            int i = 0;
            for (int i2 = 0; i2 < GameLet.SPECIAL_RES_FILENAME_ARRAY.length; i2++) {
                gluDownloadResMgr.m_splitSpecialDownloads.addElement(new SplitDownloadSpec(fileDirectoryWithEnder + GameLet.SPECIAL_RES_FILENAME_ARRAY[i2], GameLet.SPECIAL_RES_CHECKSUM_ARRAY[i2], i, GameLet.SPECIAL_RES_FILESIZE_ARRAY[i2]));
                i += GameLet.SPECIAL_RES_FILESIZE_ARRAY[i2];
            }
            for (int size = gluDownloadResMgr.m_splitSpecialDownloads.size() - 1; size >= 0; size--) {
                if (gluDownloadResMgr.m_splitSpecialDownloads.elementAt(size).checksumPassed()) {
                    gluDownloadResMgr.m_splitSpecialDownloads.removeElementAt(size);
                } else {
                    File file = new File(gluDownloadResMgr.m_splitSpecialDownloads.elementAt(size).fullFilename);
                    if (file.exists()) {
                        file.delete();
                    }
                    gluDownloadResMgr.m_specialFilePartTotal = gluDownloadResMgr.m_splitSpecialDownloads.elementAt(size).downloadLength + gluDownloadResMgr.m_specialFilePartTotal;
                }
            }
        } else {
            Debug.devDie("Res file can't be null at this point. Fix it.");
        }
        gluDownloadResMgr.m_specialFilesChecksummed = true;
        gluDownloadResMgr.m_specialFilesBeingChecksummed = false;
        gluDownloadResMgr.m_specialChecksumThread = null;
    }

    /* JADX WARN: Code duplicated, block: B:15:0x004b  */
    public static boolean areSpecialFilesSequential() {
        File fileFindResourceFile;
        if (GameLet.SPECIAL_RES_FILENAME_ARRAY == null || (fileFindResourceFile = GluUtil.findResourceFile()) == null) {
            return false;
        }
        String fileDirectoryWithEnder = GluUtil.getFileDirectoryWithEnder(fileFindResourceFile.getAbsolutePath());
        boolean z = true;
        for (int i = 0; i < GameLet.SPECIAL_RES_FILENAME_ARRAY.length; i++) {
            File file = new File(fileDirectoryWithEnder + GameLet.SPECIAL_RES_FILENAME_ARRAY[i]);
            if (!file.exists()) {
                z = false;
            } else {
                if (!z) {
                    return false;
                }
                if (file.length() != GameLet.SPECIAL_RES_FILESIZE_ARRAY[i]) {
                    z = false;
                }
            }
        }
        return true;
    }

    public static boolean areThereSpecialFiles() {
        return GameLet.SPECIAL_RES_FILENAME_ARRAY != null;
    }

    public static void createDummyPrimaryResource(String str) {
        try {
            FileOutputStream fileOutputStream = new FileOutputStream(new File(str), false);
            fileOutputStream.write(0);
            fileOutputStream.close();
        } catch (Exception e) {
            Debug.log("Cannot create a 1 byte file. That's not good. Filename=" + str, e);
        }
    }

    public static void deleteSpecialFiles() {
        File fileFindResourceFile;
        if (GameLet.SPECIAL_RES_FILENAME_ARRAY == null || (fileFindResourceFile = GluUtil.findResourceFile()) == null) {
            return;
        }
        try {
            throw new Exception();
        } catch (Exception e) {
            Debug.log("Deleting special resource files.", e);
            String fileDirectoryWithEnder = GluUtil.getFileDirectoryWithEnder(fileFindResourceFile.getAbsolutePath());
            for (int i = 0; i < GameLet.SPECIAL_RES_FILENAME_ARRAY.length; i++) {
                File file = new File(fileDirectoryWithEnder + GameLet.SPECIAL_RES_FILENAME_ARRAY[i]);
                if (file.exists()) {
                    file.delete();
                }
            }
        }
    }

    /* JADX WARN: Code duplicated, block: B:226:0x04fa  */
    /* JADX WARN: Code duplicated, block: B:243:0x0535 A[Catch: all -> 0x0507, TRY_ENTER, TRY_LEAVE, TryCatch #63 {all -> 0x0507, blocks: (B:32:0x00a7, B:34:0x00bd, B:35:0x00c5, B:38:0x0100, B:40:0x010c, B:43:0x0118, B:45:0x0134, B:46:0x0155, B:47:0x015a, B:224:0x04df, B:228:0x04ff, B:229:0x0506, B:138:0x030d, B:139:0x0315, B:141:0x0353, B:147:0x0363, B:151:0x036d, B:152:0x038a, B:153:0x038f, B:243:0x0535, B:293:0x0647, B:214:0x04b3, B:215:0x04c3, B:183:0x03f8, B:184:0x03fd, B:185:0x0401, B:209:0x04a4, B:211:0x04ab, B:220:0x04ce, B:221:0x04da, B:238:0x0518, B:239:0x0530, B:173:0x03de, B:164:0x03b7, B:162:0x03b1, B:108:0x0294, B:107:0x028f, B:104:0x0276), top: B:456:0x00a7 }] */
    /* JADX WARN: Code duplicated, block: B:312:0x0690  */
    /* JADX WARN: Code duplicated, block: B:313:0x0693  */
    /* JADX WARN: Code duplicated, block: B:315:0x0698  */
    /* JADX WARN: Code duplicated, block: B:321:0x06aa  */
    /* JADX WARN: Code duplicated, block: B:322:0x06ac  */
    /* JADX WARN: Code duplicated, block: B:324:0x06b2 A[ADDED_TO_REGION] */
    /* JADX WARN: Code duplicated, block: B:435:0x07ba  */
    /* JADX WARN: Code duplicated, block: B:436:0x07bd  */
    /* JADX WARN: Code duplicated, block: B:437:0x07c0  */
    /* JADX WARN: Code duplicated, block: B:443:0x056e A[EXC_TOP_SPLITTER, SYNTHETIC] */
    /* JADX WARN: Code duplicated, block: B:445:0x0514 A[EXC_TOP_SPLITTER, SYNTHETIC] */
    /* JADX WARN: Code duplicated, block: B:449:0x050f A[EXC_TOP_SPLITTER, SYNTHETIC] */
    /* JADX WARN: Code duplicated, block: B:458:0x0674 A[EXC_TOP_SPLITTER, SYNTHETIC] */
    /* JADX WARN: Code duplicated, block: B:477:0x0564 A[EXC_TOP_SPLITTER, SYNTHETIC] */
    /* JADX WARN: Code duplicated, block: B:483:0x066f A[EXC_TOP_SPLITTER, SYNTHETIC] */
    /* JADX WARN: Code duplicated, block: B:486:0x050a A[EXC_TOP_SPLITTER, SYNTHETIC] */
    /* JADX WARN: Code duplicated, block: B:488:0x0569 A[EXC_TOP_SPLITTER, SYNTHETIC] */
    /* JADX WARN: Code duplicated, block: B:490:0x0188 A[EXC_TOP_SPLITTER, SYNTHETIC] */
    /* JADX WARN: Code duplicated, block: B:496:0x066a A[EXC_TOP_SPLITTER, SYNTHETIC] */
    /* JADX WARN: Code duplicated, block: B:498:0x0192 A[EXC_TOP_SPLITTER, SYNTHETIC] */
    /* JADX WARN: Code duplicated, block: B:500:0x018d A[EXC_TOP_SPLITTER, SYNTHETIC] */
    /* JADX WARN: Code duplicated, block: B:532:? A[SYNTHETIC] */
    /* JADX WARN: Code duplicated, block: B:59:0x019b  */
    /* JADX WARN: Code duplicated, block: B:61:0x01a5  */
    /* JADX WARN: Code duplicated, block: B:64:0x01af A[ADDED_TO_REGION] */
    /* JADX WARN: Code duplicated, block: B:71:0x01c2  */
    /* JADX WARN: Code duplicated, block: B:74:0x01cb A[ADDED_TO_REGION] */
    /* JADX WARN: Code duplicated, block: B:77:0x01dc A[DONT_INVERT] */
    /* JADX WARN: Code duplicated, block: B:78:0x01de  */
    private String downloadFile$5e52f91b(byte b, String str, int i, int i2) throws Throwable {
        File file;
        String str2;
        int[] iArr;
        String str3;
        File file2;
        ArrayIndexOutOfBoundsException arrayIndexOutOfBoundsException;
        String string;
        FileOutputStream fileOutputStream;
        InputStream inputStream;
        boolean z;
        String string2;
        int i3;
        HttpURLConnection httpURLConnection;
        String str4;
        int i4;
        int i5;
        int i6;
        File file3;
        FileOutputStream fileOutputStream2;
        String str5;
        boolean z2 = b == 0;
        ResFileDownloadView resFileDownloadView = ResFileDownloadView.instance;
        if (resFileDownloadView == null) {
            return "app done";
        }
        if (b == 1) {
            int[] iArr2 = new int[3];
            getSpecialStartPosition(iArr2);
            resFileDownloadView.m_bytesDownloaded = iArr2[0];
            String str6 = GameLet.instance.m_nativeProperties.get(GameLet.KEY_SPECIAL_FILE_URL);
            int i7 = resFileDownloadView.m_bytesDownloaded;
            int i8 = 0;
            int i9 = 0;
            while (true) {
                if (i9 >= GameLet.SPECIAL_RES_FILENAME_ARRAY.length) {
                    str5 = GameLet.SPECIAL_RES_FILENAME_ARRAY[GameLet.SPECIAL_RES_FILENAME_ARRAY.length - 1];
                    break;
                }
                i8 += GameLet.SPECIAL_RES_FILESIZE_ARRAY[i9];
                if (i8 > i7) {
                    str5 = GameLet.SPECIAL_RES_FILENAME_ARRAY[i9];
                    break;
                }
                i9++;
            }
            this.m_specialCurrentFilename = GluUtil.getRelativeFilename(str5);
            file = getSecondaryFile(str5);
            str2 = str6;
            iArr = iArr2;
        } else if (b == 2) {
            String str7 = GameLet.instance.m_nativeProperties.get(GameLet.KEY_SPECIAL_FILE_URL);
            this.m_specialCurrentFilename = GluUtil.getRelativeFilename(str);
            File file4 = new File(str);
            ResFileDownloadView.instance.m_bytesDownloaded = 0;
            file = file4;
            str2 = str7;
            iArr = null;
        } else {
            String str8 = GameLet.instance.m_nativeProperties.get(GameLet.RES_FILE_URL_KEY_TO_USE);
            file = new File(resFileDownloadView.m_downloadFilename);
            str2 = str8;
            iArr = null;
        }
        File file5 = new File(resFileDownloadView.m_tempFilename);
        StringBuilder sbAppend = new StringBuilder().append("Downloading ");
        if (b == 0) {
            str3 = "main";
        } else if (b == 1) {
            str3 = "special";
        } else if (b == 2) {
            str3 = "special_part";
        } else {
            str3 = b == 3 ? "DLC" : "unknown";
        }
        Debug.log(sbAppend.append(str3).append(" file from URL: ").append(str2).toString());
        String str9 = null;
        HttpURLConnection httpURLConnectionCreateURLConnection = null;
        int responseCode = -1;
        InputStream inputStream2 = null;
        FileOutputStream fileOutputStream3 = null;
        boolean z3 = resFileDownloadView.m_bytesDownloaded != 0;
        int i10 = resFileDownloadView.m_bytesDownloaded;
        boolean z4 = b == 1 ? file.exists() && file.length() > 0 : b == 2 ? false : z3;
        try {
            try {
                try {
                    try {
                        try {
                            Debug.log(file.getAbsolutePath());
                            StatFs statFs = new StatFs(file.getAbsolutePath().indexOf("/sdcard/") == -1 ? Environment.getDataDirectory().getAbsolutePath() : "/sdcard/");
                            Debug.printStatFs("root FS", new StatFs(Environment.getDataDirectory().getAbsolutePath()));
                            Debug.printStatFs("sdcard FS", new StatFs("/sdcard/"));
                            Debug.printStatFs("target FS", statFs);
                            byte[] bArr = new byte[4092];
                            long blockSize = statFs.getBlockCount() == 0 ? -1L : ((long) statFs.getBlockSize()) * ((long) statFs.getAvailableBlocks());
                            long specialFileSize = GameLet.RES_FILE_SIZE_TO_USE - ((long) i10);
                            if (b == 1) {
                                specialFileSize = getSpecialFileSize() - i10;
                            } else if (b == 2) {
                                specialFileSize = i2;
                            }
                            try {
                                if (blockSize != -1) {
                                    Debug.log("Space available: " + blockSize);
                                    if (specialFileSize > blockSize) {
                                        Debug.log("Insufficient storage. bailing...");
                                        String.format(GluUtil.getString(R.string.IDS_DOWNLOAD_FAILED_INSUFFICIENT_STORAGE_DETAILED), GluUtil.getBytesStringNice(specialFileSize), GluUtil.getBytesStringNice(blockSize));
                                        throw new Exception();
                                    }
                                } else {
                                    Debug.log("Could not determine space available. Doing it the old fashioned way.");
                                    FileOutputStream fileOutputStream4 = new FileOutputStream(file5, false);
                                    try {
                                        try {
                                            try {
                                                try {
                                                    file5.delete();
                                                    file5.createNewFile();
                                                    for (int i11 = 0; i11 < specialFileSize && !resFileDownloadView.m_downloadCancelled; i11 += 4092) {
                                                        try {
                                                            fileOutputStream4.write(bArr, 0, 4092);
                                                        } catch (IOException e) {
                                                            Debug.log("Could not create temp file. Insufficient storage. bailing...");
                                                            str9 = String.format(GluUtil.getString(R.string.IDS_DOWNLOAD_FAILED_INSUFFICIENT_STORAGE), GluUtil.getBytesStringNice(specialFileSize));
                                                            try {
                                                                fileOutputStream4.close();
                                                                fileOutputStream = null;
                                                            } catch (ArrayIndexOutOfBoundsException e2) {
                                                                fileOutputStream3 = fileOutputStream4;
                                                                file2 = file;
                                                                arrayIndexOutOfBoundsException = e2;
                                                                string = str9;
                                                                Debug.log("Logic error: " + arrayIndexOutOfBoundsException, arrayIndexOutOfBoundsException);
                                                                if (b != 1) {
                                                                }
                                                                throw new RuntimeException("Your special *.gpk resource pack is the wrong URL. (filesize larger than expected) Fix it in the properties file.");
                                                            } catch (Exception e3) {
                                                                fileOutputStream = fileOutputStream4;
                                                            }
                                                            try {
                                                                try {
                                                                    if (file5.exists()) {
                                                                        file5.delete();
                                                                    }
                                                                } catch (Exception e4) {
                                                                }
                                                                try {
                                                                    throw new Exception();
                                                                } catch (Exception e5) {
                                                                    e = e5;
                                                                    fileOutputStream3 = fileOutputStream;
                                                                    file2 = file;
                                                                    if (str9 == null) {
                                                                        Debug.log("Unknown download error.", e);
                                                                        string = GluUtil.getString(R.string.IDS_DOWNLOAD_FAILED_UNKNOWN_REASON) + " (" + e.toString() + ")";
                                                                    } else {
                                                                        string = str9;
                                                                    }
                                                                    if (fileOutputStream3 != null) {
                                                                        try {
                                                                            fileOutputStream3.close();
                                                                        } catch (Exception e6) {
                                                                        }
                                                                    }
                                                                    if (inputStream2 != null) {
                                                                        try {
                                                                            inputStream2.close();
                                                                        } catch (Exception e7) {
                                                                        }
                                                                    }
                                                                    if (httpURLConnectionCreateURLConnection != null) {
                                                                        try {
                                                                            httpURLConnectionCreateURLConnection.disconnect();
                                                                        } catch (Exception e8) {
                                                                        }
                                                                    }
                                                                    if (!file2.exists()) {
                                                                        z = false;
                                                                    } else if (file2.length() == 0) {
                                                                        file2.delete();
                                                                        z = false;
                                                                    } else {
                                                                        z = true;
                                                                    }
                                                                    if (resFileDownloadView.m_bytesDownloaded == 0) {
                                                                        z = false;
                                                                        if (file2.exists()) {
                                                                            file2.delete();
                                                                        }
                                                                    }
                                                                    if (file2.exists()) {
                                                                        string2 = string;
                                                                    } else {
                                                                        string2 = string;
                                                                    }
                                                                    if (string2 == null) {
                                                                        if (b == 0) {
                                                                            this.m_mainResFileInterrupted = z;
                                                                            saveFile();
                                                                        } else if (b != 1) {
                                                                            throw new RuntimeException("implement me!!!");
                                                                        }
                                                                    } else if (b == 0) {
                                                                        if (this.m_mainResFileInterrupted) {
                                                                        }
                                                                        this.m_mainResFileInterrupted = z;
                                                                        saveFile();
                                                                    }
                                                                    return string2;
                                                                }
                                                            } catch (ArrayIndexOutOfBoundsException e9) {
                                                                fileOutputStream3 = fileOutputStream;
                                                                file2 = file;
                                                                arrayIndexOutOfBoundsException = e9;
                                                                string = str9;
                                                                Debug.log("Logic error: " + arrayIndexOutOfBoundsException, arrayIndexOutOfBoundsException);
                                                                if (b != 1) {
                                                                }
                                                                throw new RuntimeException("Your special *.gpk resource pack is the wrong URL. (filesize larger than expected) Fix it in the properties file.");
                                                            } catch (ProtocolException e10) {
                                                                e = e10;
                                                                file2 = file;
                                                                inputStream = null;
                                                                try {
                                                                    Debug.log("Connection failed, error: " + responseCode + "  " + e, e);
                                                                    string = GluUtil.getString(R.string.IDS_DOWNLOAD_FAILED_CONNECTION_FAILED);
                                                                    if (fileOutputStream != null) {
                                                                        try {
                                                                            fileOutputStream.close();
                                                                        } catch (Exception e11) {
                                                                        }
                                                                    }
                                                                    if (inputStream != null) {
                                                                        try {
                                                                            inputStream.close();
                                                                        } catch (Exception e12) {
                                                                        }
                                                                    }
                                                                    if (httpURLConnectionCreateURLConnection != null) {
                                                                        try {
                                                                            httpURLConnectionCreateURLConnection.disconnect();
                                                                        } catch (Exception e13) {
                                                                        }
                                                                    }
                                                                    if (!file2.exists()) {
                                                                        z = false;
                                                                    } else if (file2.length() == 0) {
                                                                        file2.delete();
                                                                        z = false;
                                                                    } else {
                                                                        z = true;
                                                                    }
                                                                    if (resFileDownloadView.m_bytesDownloaded == 0) {
                                                                        z = false;
                                                                        if (file2.exists()) {
                                                                            file2.delete();
                                                                        }
                                                                    }
                                                                    if (file2.exists()) {
                                                                        string2 = string;
                                                                    } else {
                                                                        string2 = string;
                                                                    }
                                                                    if (string2 == null) {
                                                                        if (b == 0) {
                                                                            this.m_mainResFileInterrupted = z;
                                                                            saveFile();
                                                                        } else if (b != 1) {
                                                                            throw new RuntimeException("implement me!!!");
                                                                        }
                                                                    } else if (b == 0) {
                                                                        if (this.m_mainResFileInterrupted) {
                                                                        }
                                                                        this.m_mainResFileInterrupted = z;
                                                                        saveFile();
                                                                    }
                                                                    return string2;
                                                                } catch (Throwable th) {
                                                                    th = th;
                                                                    fileOutputStream3 = fileOutputStream;
                                                                    inputStream2 = inputStream;
                                                                    if (fileOutputStream3 != null) {
                                                                        try {
                                                                            fileOutputStream3.close();
                                                                        } catch (Exception e14) {
                                                                        }
                                                                    }
                                                                    if (inputStream2 != null) {
                                                                        try {
                                                                            inputStream2.close();
                                                                        } catch (Exception e15) {
                                                                        }
                                                                    }
                                                                    if (httpURLConnectionCreateURLConnection != null) {
                                                                        throw th;
                                                                    }
                                                                    try {
                                                                        httpURLConnectionCreateURLConnection.disconnect();
                                                                        throw th;
                                                                    } catch (Exception e16) {
                                                                        throw th;
                                                                    }
                                                                }
                                                            } catch (IOException e17) {
                                                                e = e17;
                                                                fileOutputStream3 = fileOutputStream;
                                                                file2 = file;
                                                                Debug.log("Filename: " + file2.getAbsolutePath(), e);
                                                                string = GluUtil.getString(R.string.IDS_DOWNLOAD_FAILED_CONNECTION_DROPPED);
                                                                if (fileOutputStream3 != null) {
                                                                    try {
                                                                        fileOutputStream3.close();
                                                                    } catch (Exception e18) {
                                                                    }
                                                                }
                                                                if (inputStream2 != null) {
                                                                    try {
                                                                        inputStream2.close();
                                                                    } catch (Exception e19) {
                                                                    }
                                                                }
                                                                if (httpURLConnectionCreateURLConnection != null) {
                                                                    try {
                                                                        httpURLConnectionCreateURLConnection.disconnect();
                                                                    } catch (Exception e20) {
                                                                    }
                                                                }
                                                                if (!file2.exists()) {
                                                                    z = false;
                                                                } else if (file2.length() == 0) {
                                                                    file2.delete();
                                                                    z = false;
                                                                } else {
                                                                    z = true;
                                                                }
                                                                if (resFileDownloadView.m_bytesDownloaded == 0) {
                                                                    z = false;
                                                                    if (file2.exists()) {
                                                                        file2.delete();
                                                                    }
                                                                }
                                                                if (file2.exists()) {
                                                                    string2 = string;
                                                                } else {
                                                                    string2 = string;
                                                                }
                                                                if (string2 == null) {
                                                                    if (b == 0) {
                                                                        this.m_mainResFileInterrupted = z;
                                                                        saveFile();
                                                                    } else if (b != 1) {
                                                                        throw new RuntimeException("implement me!!!");
                                                                    }
                                                                } else if (b == 0) {
                                                                    if (this.m_mainResFileInterrupted) {
                                                                    }
                                                                    this.m_mainResFileInterrupted = z;
                                                                    saveFile();
                                                                }
                                                                return string2;
                                                            } catch (Throwable th2) {
                                                                th = th2;
                                                                fileOutputStream3 = fileOutputStream;
                                                                if (fileOutputStream3 != null) {
                                                                    fileOutputStream3.close();
                                                                }
                                                                if (inputStream2 != null) {
                                                                    inputStream2.close();
                                                                }
                                                                if (httpURLConnectionCreateURLConnection != null) {
                                                                    throw th;
                                                                }
                                                                httpURLConnectionCreateURLConnection.disconnect();
                                                                throw th;
                                                            }
                                                        }
                                                    }
                                                    try {
                                                        fileOutputStream4.close();
                                                        fileOutputStream4 = null;
                                                    } catch (Exception e21) {
                                                    }
                                                    try {
                                                        if (file5.exists()) {
                                                            file5.delete();
                                                        }
                                                        fileOutputStream3 = fileOutputStream4;
                                                    } catch (Exception e22) {
                                                        fileOutputStream3 = fileOutputStream4;
                                                    }
                                                } catch (IOException e23) {
                                                    e = e23;
                                                    fileOutputStream3 = fileOutputStream4;
                                                    file2 = file;
                                                }
                                            } catch (ArrayIndexOutOfBoundsException e24) {
                                                fileOutputStream3 = fileOutputStream4;
                                                file2 = file;
                                                arrayIndexOutOfBoundsException = e24;
                                                string = null;
                                            }
                                        } catch (Exception e25) {
                                            e = e25;
                                            fileOutputStream3 = fileOutputStream4;
                                            file2 = file;
                                        }
                                    } catch (ProtocolException e26) {
                                        e = e26;
                                        fileOutputStream = fileOutputStream4;
                                        file2 = file;
                                        inputStream = null;
                                    } catch (Throwable th3) {
                                        th = th3;
                                        fileOutputStream3 = fileOutputStream4;
                                    }
                                }
                                try {
                                    try {
                                        try {
                                            httpURLConnectionCreateURLConnection = (i < 0 || i2 <= 0) ? GluUtil.createURLConnection(str2, i10) : GluUtil.createURLConnection(str2, i, i2);
                                            try {
                                                responseCode = httpURLConnectionCreateURLConnection.getResponseCode();
                                                Debug.log("Response message: " + httpURLConnectionCreateURLConnection.getResponseMessage());
                                                Debug.log("Response method: " + httpURLConnectionCreateURLConnection.getRequestMethod());
                                                int contentLength = GluUtil.getContentLength(httpURLConnectionCreateURLConnection);
                                                if (contentLength == 0) {
                                                    Debug.log("Will not do file size check.");
                                                } else {
                                                    Debug.log("Will do file size check, content-length=" + contentLength);
                                                }
                                                boolean z5 = true;
                                                if (b == 1) {
                                                    z5 = (responseCode == 206 ? i10 : 0) + contentLength == getSpecialFileSize();
                                                } else if (b == 0) {
                                                    z5 = ((long) ((responseCode == 206 ? i10 : 0) + contentLength)) == GameLet.RES_FILE_SIZE_TO_USE;
                                                } else if (b == 2) {
                                                    z5 = true;
                                                }
                                                if (!z5) {
                                                    String str10 = String.format(GluUtil.getString(R.string.IDS_DOWNLOAD_FAILED_BAD_SIZE), GluUtil.getString(R.string.app_name), GameLet.instance.m_fullVersion);
                                                    try {
                                                        throw new Exception();
                                                    } catch (UnknownHostException e27) {
                                                        e = e27;
                                                        httpURLConnection = httpURLConnectionCreateURLConnection;
                                                        str4 = str10;
                                                        i3 = responseCode;
                                                        try {
                                                            Debug.log(e.getMessage(), e);
                                                            throw new ProtocolException(e.getMessage());
                                                        } catch (ArrayIndexOutOfBoundsException e28) {
                                                            httpURLConnectionCreateURLConnection = httpURLConnection;
                                                            file2 = file;
                                                            arrayIndexOutOfBoundsException = e28;
                                                            string = str4;
                                                            Debug.log("Logic error: " + arrayIndexOutOfBoundsException, arrayIndexOutOfBoundsException);
                                                            if (b != 1) {
                                                            }
                                                            throw new RuntimeException("Your special *.gpk resource pack is the wrong URL. (filesize larger than expected) Fix it in the properties file.");
                                                        } catch (ProtocolException e29) {
                                                            e = e29;
                                                            responseCode = i3;
                                                            httpURLConnectionCreateURLConnection = httpURLConnection;
                                                            fileOutputStream = fileOutputStream3;
                                                            file2 = file;
                                                            inputStream = null;
                                                            Debug.log("Connection failed, error: " + responseCode + "  " + e, e);
                                                            string = GluUtil.getString(R.string.IDS_DOWNLOAD_FAILED_CONNECTION_FAILED);
                                                            if (fileOutputStream != null) {
                                                                fileOutputStream.close();
                                                            }
                                                            if (inputStream != null) {
                                                                inputStream.close();
                                                            }
                                                            if (httpURLConnectionCreateURLConnection != null) {
                                                                httpURLConnectionCreateURLConnection.disconnect();
                                                            }
                                                            if (!file2.exists()) {
                                                                z = false;
                                                            } else if (file2.length() == 0) {
                                                                file2.delete();
                                                                z = false;
                                                            } else {
                                                                z = true;
                                                            }
                                                            if (resFileDownloadView.m_bytesDownloaded == 0) {
                                                                z = false;
                                                                if (file2.exists()) {
                                                                    file2.delete();
                                                                }
                                                            }
                                                            if (file2.exists()) {
                                                                string2 = string;
                                                            } else {
                                                                string2 = string;
                                                            }
                                                            if (string2 == null) {
                                                                if (b == 0) {
                                                                    this.m_mainResFileInterrupted = z;
                                                                    saveFile();
                                                                } else if (b != 1) {
                                                                    throw new RuntimeException("implement me!!!");
                                                                }
                                                            } else if (b == 0) {
                                                                if (this.m_mainResFileInterrupted) {
                                                                }
                                                                this.m_mainResFileInterrupted = z;
                                                                saveFile();
                                                            }
                                                            return string2;
                                                        } catch (IOException e30) {
                                                            e = e30;
                                                            httpURLConnectionCreateURLConnection = httpURLConnection;
                                                            file2 = file;
                                                            Debug.log("Filename: " + file2.getAbsolutePath(), e);
                                                            string = GluUtil.getString(R.string.IDS_DOWNLOAD_FAILED_CONNECTION_DROPPED);
                                                            if (fileOutputStream3 != null) {
                                                                fileOutputStream3.close();
                                                            }
                                                            if (inputStream2 != null) {
                                                                inputStream2.close();
                                                            }
                                                            if (httpURLConnectionCreateURLConnection != null) {
                                                                httpURLConnectionCreateURLConnection.disconnect();
                                                            }
                                                            if (!file2.exists()) {
                                                                z = false;
                                                            } else if (file2.length() == 0) {
                                                                file2.delete();
                                                                z = false;
                                                            } else {
                                                                z = true;
                                                            }
                                                            if (resFileDownloadView.m_bytesDownloaded == 0) {
                                                                z = false;
                                                                if (file2.exists()) {
                                                                    file2.delete();
                                                                }
                                                            }
                                                            if (file2.exists()) {
                                                                string2 = string;
                                                            } else {
                                                                string2 = string;
                                                            }
                                                            if (string2 == null) {
                                                                if (b == 0) {
                                                                    this.m_mainResFileInterrupted = z;
                                                                    saveFile();
                                                                } else if (b != 1) {
                                                                    throw new RuntimeException("implement me!!!");
                                                                }
                                                            } else if (b == 0) {
                                                                if (this.m_mainResFileInterrupted) {
                                                                }
                                                                this.m_mainResFileInterrupted = z;
                                                                saveFile();
                                                            }
                                                            return string2;
                                                        } catch (Exception e31) {
                                                            e = e31;
                                                            httpURLConnectionCreateURLConnection = httpURLConnection;
                                                            str9 = str4;
                                                            file2 = file;
                                                            if (str9 == null) {
                                                                Debug.log("Unknown download error.", e);
                                                                string = GluUtil.getString(R.string.IDS_DOWNLOAD_FAILED_UNKNOWN_REASON) + " (" + e.toString() + ")";
                                                            } else {
                                                                string = str9;
                                                            }
                                                            if (fileOutputStream3 != null) {
                                                                fileOutputStream3.close();
                                                            }
                                                            if (inputStream2 != null) {
                                                                inputStream2.close();
                                                            }
                                                            if (httpURLConnectionCreateURLConnection != null) {
                                                                httpURLConnectionCreateURLConnection.disconnect();
                                                            }
                                                            if (!file2.exists()) {
                                                                z = false;
                                                            } else if (file2.length() == 0) {
                                                                file2.delete();
                                                                z = false;
                                                            } else {
                                                                z = true;
                                                            }
                                                            if (resFileDownloadView.m_bytesDownloaded == 0) {
                                                                z = false;
                                                                if (file2.exists()) {
                                                                    file2.delete();
                                                                }
                                                            }
                                                            if (file2.exists()) {
                                                                string2 = string;
                                                            } else {
                                                                string2 = string;
                                                            }
                                                            if (string2 == null) {
                                                                if (b == 0) {
                                                                    this.m_mainResFileInterrupted = z;
                                                                    saveFile();
                                                                } else if (b != 1) {
                                                                    throw new RuntimeException("implement me!!!");
                                                                }
                                                            } else if (b == 0) {
                                                                if (this.m_mainResFileInterrupted) {
                                                                }
                                                                this.m_mainResFileInterrupted = z;
                                                                saveFile();
                                                            }
                                                            return string2;
                                                        } catch (Throwable th4) {
                                                            th = th4;
                                                            httpURLConnectionCreateURLConnection = httpURLConnection;
                                                            if (fileOutputStream3 != null) {
                                                                fileOutputStream3.close();
                                                            }
                                                            if (inputStream2 != null) {
                                                                inputStream2.close();
                                                            }
                                                            if (httpURLConnectionCreateURLConnection != null) {
                                                                throw th;
                                                            }
                                                            httpURLConnectionCreateURLConnection.disconnect();
                                                            throw th;
                                                        }
                                                    } catch (IOException e32) {
                                                        e = e32;
                                                        Debug.log(e.getMessage(), e);
                                                        throw new ProtocolException(e.getMessage());
                                                    } catch (ArrayIndexOutOfBoundsException e33) {
                                                        string = str10;
                                                        file2 = file;
                                                        arrayIndexOutOfBoundsException = e33;
                                                        Debug.log("Logic error: " + arrayIndexOutOfBoundsException, arrayIndexOutOfBoundsException);
                                                        if (b != 1) {
                                                        }
                                                        throw new RuntimeException("Your special *.gpk resource pack is the wrong URL. (filesize larger than expected) Fix it in the properties file.");
                                                    } catch (Exception e34) {
                                                        e = e34;
                                                        str9 = str10;
                                                        file2 = file;
                                                        if (str9 == null) {
                                                            Debug.log("Unknown download error.", e);
                                                            string = GluUtil.getString(R.string.IDS_DOWNLOAD_FAILED_UNKNOWN_REASON) + " (" + e.toString() + ")";
                                                        } else {
                                                            string = str9;
                                                        }
                                                        if (fileOutputStream3 != null) {
                                                            fileOutputStream3.close();
                                                        }
                                                        if (inputStream2 != null) {
                                                            inputStream2.close();
                                                        }
                                                        if (httpURLConnectionCreateURLConnection != null) {
                                                            httpURLConnectionCreateURLConnection.disconnect();
                                                        }
                                                        if (!file2.exists()) {
                                                            z = false;
                                                        } else if (file2.length() == 0) {
                                                            file2.delete();
                                                            z = false;
                                                        } else {
                                                            z = true;
                                                        }
                                                        if (resFileDownloadView.m_bytesDownloaded == 0) {
                                                            z = false;
                                                            if (file2.exists()) {
                                                                file2.delete();
                                                            }
                                                        }
                                                        if (file2.exists()) {
                                                            string2 = string;
                                                        } else {
                                                            string2 = string;
                                                        }
                                                        if (string2 == null) {
                                                            if (b == 0) {
                                                                this.m_mainResFileInterrupted = z;
                                                                saveFile();
                                                            } else if (b != 1) {
                                                                throw new RuntimeException("implement me!!!");
                                                            }
                                                        } else if (b == 0) {
                                                            if (this.m_mainResFileInterrupted) {
                                                            }
                                                            this.m_mainResFileInterrupted = z;
                                                            saveFile();
                                                        }
                                                        return string2;
                                                    }
                                                }
                                                if (responseCode == 206) {
                                                    Debug.log("Resume successful.");
                                                } else {
                                                    if (responseCode != 200) {
                                                        if (responseCode != 416) {
                                                            throw new IOException("Response code: " + responseCode);
                                                        }
                                                        Debug.log("416: Requested range not satisfiable. The optional resource file is probably fine.");
                                                        throw new ProtocolException("Everything's fine.");
                                                    }
                                                    if (i10 != 0) {
                                                        Debug.log("Resume not supported.");
                                                        if (z2) {
                                                            ResFileDownloadView.instance.m_bytesDownloaded = 0;
                                                        }
                                                    }
                                                }
                                                inputStream2 = httpURLConnectionCreateURLConnection.getInputStream();
                                                try {
                                                    fileOutputStream = new FileOutputStream(file, z4);
                                                    try {
                                                        try {
                                                            Debug.log("Download: Starting to grab from buffer. bufferSize=" + bArr.length + " File=" + file.getAbsolutePath());
                                                            while (true) {
                                                                try {
                                                                    try {
                                                                        try {
                                                                            try {
                                                                                i4 = inputStream2.read(bArr);
                                                                                try {
                                                                                    if (i4 == -1 || ResFileDownloadView.instance.m_downloadCancelled) {
                                                                                        break;
                                                                                    }
                                                                                    if (b == 1) {
                                                                                        int i12 = 0;
                                                                                        while (i4 > 0) {
                                                                                            try {
                                                                                                int i13 = GameLet.SPECIAL_RES_FILESIZE_ARRAY[iArr[1]] - iArr[2];
                                                                                                if (i13 == i4) {
                                                                                                    fileOutputStream.write(bArr, i12, i4);
                                                                                                    iArr[1] = iArr[1] + 1;
                                                                                                    iArr[2] = 0;
                                                                                                    iArr[0] = i4 + iArr[0];
                                                                                                    i5 = i12;
                                                                                                    i6 = 0;
                                                                                                } else if (i13 > i4) {
                                                                                                    fileOutputStream.write(bArr, i12, i4);
                                                                                                    iArr[2] = iArr[2] + i4;
                                                                                                    iArr[0] = i4 + iArr[0];
                                                                                                    i5 = i12;
                                                                                                    i6 = 0;
                                                                                                } else {
                                                                                                    fileOutputStream.write(bArr, i12, i13);
                                                                                                    iArr[1] = iArr[1] + 1;
                                                                                                    iArr[2] = 0;
                                                                                                    iArr[0] = iArr[0] + i13;
                                                                                                    int i14 = i4 - i13;
                                                                                                    i5 = i12 + i13;
                                                                                                    i6 = i14;
                                                                                                }
                                                                                                if (iArr[2] != 0 || iArr[1] >= GameLet.SPECIAL_RES_FILESIZE_ARRAY.length) {
                                                                                                    FileOutputStream fileOutputStream5 = fileOutputStream;
                                                                                                    file3 = file;
                                                                                                    fileOutputStream2 = fileOutputStream5;
                                                                                                } else {
                                                                                                    fileOutputStream.close();
                                                                                                    String str11 = GameLet.SPECIAL_RES_FILENAME_ARRAY[iArr[1]];
                                                                                                    this.m_specialCurrentFilename = GluUtil.getRelativeFilename(str11);
                                                                                                    File secondaryFile = getSecondaryFile(str11);
                                                                                                    try {
                                                                                                        fileOutputStream2 = new FileOutputStream(secondaryFile, false);
                                                                                                        file3 = secondaryFile;
                                                                                                    } catch (IOException e35) {
                                                                                                        e = e35;
                                                                                                        file = secondaryFile;
                                                                                                        Debug.log("Download failed.", e);
                                                                                                        String str12 = String.format(GluUtil.getString(R.string.IDS_DOWNLOAD_FAILED_INSUFFICIENT_STORAGE), GluUtil.getBytesStringNice(GameLet.RES_FILE_SIZE_TO_USE));
                                                                                                        try {
                                                                                                            try {
                                                                                                                fileOutputStream.close();
                                                                                                                fileOutputStream = null;
                                                                                                                try {
                                                                                                                    if (file.exists() && z2) {
                                                                                                                        ResFileDownloadView.instance.m_bytesDownloaded = (int) file.length();
                                                                                                                    }
                                                                                                                    throw new Exception();
                                                                                                                } catch (ArrayIndexOutOfBoundsException e36) {
                                                                                                                    fileOutputStream3 = null;
                                                                                                                    file2 = file;
                                                                                                                    arrayIndexOutOfBoundsException = e36;
                                                                                                                    string = str12;
                                                                                                                    Debug.log("Logic error: " + arrayIndexOutOfBoundsException, arrayIndexOutOfBoundsException);
                                                                                                                    if (b != 1 || b == 2) {
                                                                                                                        throw new RuntimeException("Your special *.gpk resource pack is the wrong URL. (filesize larger than expected) Fix it in the properties file.");
                                                                                                                    }
                                                                                                                    if (fileOutputStream3 != null) {
                                                                                                                        try {
                                                                                                                            fileOutputStream3.close();
                                                                                                                        } catch (Exception e37) {
                                                                                                                        }
                                                                                                                    }
                                                                                                                    if (inputStream2 != null) {
                                                                                                                        try {
                                                                                                                            inputStream2.close();
                                                                                                                        } catch (Exception e38) {
                                                                                                                        }
                                                                                                                    }
                                                                                                                    if (httpURLConnectionCreateURLConnection != null) {
                                                                                                                        try {
                                                                                                                            httpURLConnectionCreateURLConnection.disconnect();
                                                                                                                        } catch (Exception e39) {
                                                                                                                        }
                                                                                                                    }
                                                                                                                    if (!file2.exists()) {
                                                                                                                        z = false;
                                                                                                                    } else if (file2.length() == 0) {
                                                                                                                        file2.delete();
                                                                                                                        z = false;
                                                                                                                    } else {
                                                                                                                        z = true;
                                                                                                                    }
                                                                                                                    if (resFileDownloadView.m_bytesDownloaded == 0) {
                                                                                                                        z = false;
                                                                                                                        if (file2.exists()) {
                                                                                                                            file2.delete();
                                                                                                                        }
                                                                                                                    }
                                                                                                                    if (file2.exists()) {
                                                                                                                        string2 = string;
                                                                                                                    } else {
                                                                                                                        string2 = string;
                                                                                                                    }
                                                                                                                    if (string2 == null) {
                                                                                                                        if (b == 0) {
                                                                                                                            this.m_mainResFileInterrupted = z;
                                                                                                                            saveFile();
                                                                                                                        } else if (b != 1) {
                                                                                                                            throw new RuntimeException("implement me!!!");
                                                                                                                        }
                                                                                                                    } else if (b == 0) {
                                                                                                                        if (this.m_mainResFileInterrupted) {
                                                                                                                        }
                                                                                                                        this.m_mainResFileInterrupted = z;
                                                                                                                        saveFile();
                                                                                                                    }
                                                                                                                    return string2;
                                                                                                                }
                                                                                                            } catch (ArrayIndexOutOfBoundsException e40) {
                                                                                                                fileOutputStream3 = fileOutputStream;
                                                                                                                file2 = file;
                                                                                                                arrayIndexOutOfBoundsException = e40;
                                                                                                                string = str12;
                                                                                                            }
                                                                                                        } catch (Exception e41) {
                                                                                                        }
                                                                                                    } catch (ArrayIndexOutOfBoundsException e42) {
                                                                                                        arrayIndexOutOfBoundsException = e42;
                                                                                                        fileOutputStream3 = fileOutputStream;
                                                                                                        file2 = secondaryFile;
                                                                                                        string = null;
                                                                                                        Debug.log("Logic error: " + arrayIndexOutOfBoundsException, arrayIndexOutOfBoundsException);
                                                                                                        if (b != 1) {
                                                                                                        }
                                                                                                        throw new RuntimeException("Your special *.gpk resource pack is the wrong URL. (filesize larger than expected) Fix it in the properties file.");
                                                                                                    } catch (ProtocolException e43) {
                                                                                                        e = e43;
                                                                                                        inputStream = inputStream2;
                                                                                                        file2 = secondaryFile;
                                                                                                        Debug.log("Connection failed, error: " + responseCode + "  " + e, e);
                                                                                                        string = GluUtil.getString(R.string.IDS_DOWNLOAD_FAILED_CONNECTION_FAILED);
                                                                                                        if (fileOutputStream != null) {
                                                                                                            fileOutputStream.close();
                                                                                                        }
                                                                                                        if (inputStream != null) {
                                                                                                            inputStream.close();
                                                                                                        }
                                                                                                        if (httpURLConnectionCreateURLConnection != null) {
                                                                                                            httpURLConnectionCreateURLConnection.disconnect();
                                                                                                        }
                                                                                                        if (!file2.exists()) {
                                                                                                            z = false;
                                                                                                        } else if (file2.length() == 0) {
                                                                                                            file2.delete();
                                                                                                            z = false;
                                                                                                        } else {
                                                                                                            z = true;
                                                                                                        }
                                                                                                        if (resFileDownloadView.m_bytesDownloaded == 0) {
                                                                                                            z = false;
                                                                                                            if (file2.exists()) {
                                                                                                                file2.delete();
                                                                                                            }
                                                                                                        }
                                                                                                        if (file2.exists()) {
                                                                                                            string2 = string;
                                                                                                        } else {
                                                                                                            string2 = string;
                                                                                                        }
                                                                                                        if (string2 == null) {
                                                                                                            if (b == 0) {
                                                                                                                this.m_mainResFileInterrupted = z;
                                                                                                                saveFile();
                                                                                                            } else if (b != 1) {
                                                                                                                throw new RuntimeException("implement me!!!");
                                                                                                            }
                                                                                                        } else if (b == 0) {
                                                                                                            if (this.m_mainResFileInterrupted) {
                                                                                                            }
                                                                                                            this.m_mainResFileInterrupted = z;
                                                                                                            saveFile();
                                                                                                        }
                                                                                                        return string2;
                                                                                                    } catch (Exception e44) {
                                                                                                        e = e44;
                                                                                                        fileOutputStream3 = fileOutputStream;
                                                                                                        file2 = secondaryFile;
                                                                                                        if (str9 == null) {
                                                                                                            Debug.log("Unknown download error.", e);
                                                                                                            string = GluUtil.getString(R.string.IDS_DOWNLOAD_FAILED_UNKNOWN_REASON) + " (" + e.toString() + ")";
                                                                                                        } else {
                                                                                                            string = str9;
                                                                                                        }
                                                                                                        if (fileOutputStream3 != null) {
                                                                                                            fileOutputStream3.close();
                                                                                                        }
                                                                                                        if (inputStream2 != null) {
                                                                                                            inputStream2.close();
                                                                                                        }
                                                                                                        if (httpURLConnectionCreateURLConnection != null) {
                                                                                                            httpURLConnectionCreateURLConnection.disconnect();
                                                                                                        }
                                                                                                        if (!file2.exists()) {
                                                                                                            z = false;
                                                                                                        } else if (file2.length() == 0) {
                                                                                                            file2.delete();
                                                                                                            z = false;
                                                                                                        } else {
                                                                                                            z = true;
                                                                                                        }
                                                                                                        if (resFileDownloadView.m_bytesDownloaded == 0) {
                                                                                                            z = false;
                                                                                                            if (file2.exists()) {
                                                                                                                file2.delete();
                                                                                                            }
                                                                                                        }
                                                                                                        if (file2.exists()) {
                                                                                                            string2 = string;
                                                                                                        } else {
                                                                                                            string2 = string;
                                                                                                        }
                                                                                                        if (string2 == null) {
                                                                                                            if (b == 0) {
                                                                                                                this.m_mainResFileInterrupted = z;
                                                                                                                saveFile();
                                                                                                            } else if (b != 1) {
                                                                                                                throw new RuntimeException("implement me!!!");
                                                                                                            }
                                                                                                        } else if (b == 0) {
                                                                                                            if (this.m_mainResFileInterrupted) {
                                                                                                            }
                                                                                                            this.m_mainResFileInterrupted = z;
                                                                                                            saveFile();
                                                                                                        }
                                                                                                        return string2;
                                                                                                    }
                                                                                                }
                                                                                                i4 = i6;
                                                                                                i12 = i5;
                                                                                                File file6 = file3;
                                                                                                fileOutputStream = fileOutputStream2;
                                                                                                file = file6;
                                                                                            } catch (IOException e45) {
                                                                                                e = e45;
                                                                                            }
                                                                                        }
                                                                                        resFileDownloadView.m_bytesDownloaded = iArr[0];
                                                                                    } else {
                                                                                        fileOutputStream.write(bArr, 0, i4);
                                                                                        if (z2 || b == 2) {
                                                                                            ResFileDownloadView resFileDownloadView2 = ResFileDownloadView.instance;
                                                                                            resFileDownloadView2.m_bytesDownloaded = i4 + resFileDownloadView2.m_bytesDownloaded;
                                                                                        }
                                                                                    }
                                                                                } catch (IOException e46) {
                                                                                    e = e46;
                                                                                    fileOutputStream3 = fileOutputStream;
                                                                                    file2 = file;
                                                                                    Debug.log("Filename: " + file2.getAbsolutePath(), e);
                                                                                    string = GluUtil.getString(R.string.IDS_DOWNLOAD_FAILED_CONNECTION_DROPPED);
                                                                                    if (fileOutputStream3 != null) {
                                                                                        fileOutputStream3.close();
                                                                                    }
                                                                                    if (inputStream2 != null) {
                                                                                        inputStream2.close();
                                                                                    }
                                                                                    if (httpURLConnectionCreateURLConnection != null) {
                                                                                        httpURLConnectionCreateURLConnection.disconnect();
                                                                                    }
                                                                                } catch (Throwable th5) {
                                                                                    th = th5;
                                                                                    fileOutputStream3 = fileOutputStream;
                                                                                    if (fileOutputStream3 != null) {
                                                                                        fileOutputStream3.close();
                                                                                    }
                                                                                    if (inputStream2 != null) {
                                                                                        inputStream2.close();
                                                                                    }
                                                                                    if (httpURLConnectionCreateURLConnection != null) {
                                                                                        throw th;
                                                                                    }
                                                                                    httpURLConnectionCreateURLConnection.disconnect();
                                                                                    throw th;
                                                                                }
                                                                            } catch (ArrayIndexOutOfBoundsException e47) {
                                                                                fileOutputStream3 = fileOutputStream;
                                                                                file2 = file;
                                                                                arrayIndexOutOfBoundsException = e47;
                                                                                string = null;
                                                                            }
                                                                        } catch (IOException e48) {
                                                                            e = e48;
                                                                            fileOutputStream3 = fileOutputStream;
                                                                            file2 = file;
                                                                        }
                                                                    } catch (Exception e49) {
                                                                        e = e49;
                                                                        fileOutputStream3 = fileOutputStream;
                                                                        file2 = file;
                                                                    }
                                                                } catch (Throwable th6) {
                                                                    th = th6;
                                                                    fileOutputStream3 = fileOutputStream;
                                                                }
                                                            }
                                                            Debug.log("Download: Finished grabbing from server.   count=" + i4);
                                                            fileOutputStream.close();
                                                            try {
                                                                string = ResFileDownloadView.instance.m_downloadCancelled ? GluUtil.getString(R.string.IDS_DOWNLOAD_CANCELLED_BY_USER) : null;
                                                                if (inputStream2 != null) {
                                                                    try {
                                                                        inputStream2.close();
                                                                    } catch (Exception e50) {
                                                                    }
                                                                }
                                                                if (httpURLConnectionCreateURLConnection != null) {
                                                                    try {
                                                                        httpURLConnectionCreateURLConnection.disconnect();
                                                                    } catch (Exception e51) {
                                                                        file2 = file;
                                                                    }
                                                                }
                                                                file2 = file;
                                                            } catch (ArrayIndexOutOfBoundsException e52) {
                                                                fileOutputStream3 = null;
                                                                file2 = file;
                                                                arrayIndexOutOfBoundsException = e52;
                                                                string = null;
                                                                Debug.log("Logic error: " + arrayIndexOutOfBoundsException, arrayIndexOutOfBoundsException);
                                                                if (b != 1) {
                                                                }
                                                                throw new RuntimeException("Your special *.gpk resource pack is the wrong URL. (filesize larger than expected) Fix it in the properties file.");
                                                            } catch (Exception e53) {
                                                                e = e53;
                                                                fileOutputStream3 = null;
                                                                file2 = file;
                                                                if (str9 == null) {
                                                                    Debug.log("Unknown download error.", e);
                                                                    string = GluUtil.getString(R.string.IDS_DOWNLOAD_FAILED_UNKNOWN_REASON) + " (" + e.toString() + ")";
                                                                } else {
                                                                    string = str9;
                                                                }
                                                                if (fileOutputStream3 != null) {
                                                                    fileOutputStream3.close();
                                                                }
                                                                if (inputStream2 != null) {
                                                                    inputStream2.close();
                                                                }
                                                                if (httpURLConnectionCreateURLConnection != null) {
                                                                    httpURLConnectionCreateURLConnection.disconnect();
                                                                }
                                                            }
                                                        } catch (ProtocolException e54) {
                                                            e = e54;
                                                            file2 = file;
                                                            inputStream = inputStream2;
                                                        }
                                                    } catch (IOException e55) {
                                                        e = e55;
                                                        fileOutputStream3 = fileOutputStream;
                                                        file2 = file;
                                                    } catch (ArrayIndexOutOfBoundsException e56) {
                                                        fileOutputStream3 = fileOutputStream;
                                                        file2 = file;
                                                        arrayIndexOutOfBoundsException = e56;
                                                        string = null;
                                                    } catch (Exception e57) {
                                                        e = e57;
                                                        fileOutputStream3 = fileOutputStream;
                                                        file2 = file;
                                                    } catch (Throwable th7) {
                                                        th = th7;
                                                        fileOutputStream3 = fileOutputStream;
                                                    }
                                                } catch (ProtocolException e58) {
                                                    e = e58;
                                                    fileOutputStream = fileOutputStream3;
                                                    file2 = file;
                                                    inputStream = inputStream2;
                                                }
                                            } catch (UnknownHostException e59) {
                                                e = e59;
                                                i3 = -1;
                                                httpURLConnection = httpURLConnectionCreateURLConnection;
                                                str4 = null;
                                            }
                                        } catch (UnknownHostException e60) {
                                            e = e60;
                                            i3 = responseCode;
                                            httpURLConnection = httpURLConnectionCreateURLConnection;
                                            str4 = null;
                                        }
                                    } catch (ProtocolException e61) {
                                        e = e61;
                                        fileOutputStream = fileOutputStream3;
                                        file2 = file;
                                        inputStream = null;
                                    }
                                } catch (IOException e62) {
                                    e = e62;
                                }
                            } catch (ArrayIndexOutOfBoundsException e63) {
                                file2 = file;
                                arrayIndexOutOfBoundsException = e63;
                                string = null;
                            }
                        } catch (ProtocolException e64) {
                            e = e64;
                            fileOutputStream = null;
                            file2 = file;
                            inputStream = null;
                        }
                    } catch (Exception e65) {
                        e = e65;
                        file2 = file;
                    }
                } catch (IOException e66) {
                    e = e66;
                    file2 = file;
                }
            } catch (ArrayIndexOutOfBoundsException e67) {
                file2 = file;
                arrayIndexOutOfBoundsException = e67;
                string = null;
            }
            if (!file2.exists()) {
                z = false;
            } else if (file2.length() == 0) {
                file2.delete();
                z = false;
            } else {
                z = true;
            }
            if (resFileDownloadView.m_bytesDownloaded == 0 && (b == 0 || b == 1 || b == 2)) {
                z = false;
                if (file2.exists()) {
                    file2.delete();
                }
            }
            if (file2.exists() || string != null) {
                string2 = string;
            } else {
                Debug.log("unknown download error... file doesn't exist");
                string2 = GluUtil.getString(R.string.IDS_DOWNLOAD_FAILED_COULD_NOT_SAVE);
            }
            if (string2 == null) {
                if (b == 0) {
                    this.m_mainResFileInterrupted = z;
                    saveFile();
                } else if (b != 1 && b != 2 && b == 3) {
                    throw new RuntimeException("implement me!!!");
                }
            } else if (b == 0) {
                boolean z6 = !this.m_mainResFileInterrupted || z;
                this.m_mainResFileInterrupted = z6;
                saveFile();
            }
            return string2;
        } catch (Throwable th8) {
            th = th8;
        }
    }

    private static File getDataFile() {
        return new File(GluUtil.getLocalSaveDirectory() + "dlstatus.dat");
    }

    private static File getSecondaryFile(String str) {
        File fileFindResourceFile = GluUtil.findResourceFile();
        if (fileFindResourceFile == null) {
            return null;
        }
        String absolutePath = fileFindResourceFile.getAbsolutePath();
        if (absolutePath.lastIndexOf("/") != -1) {
            return new File(absolutePath.substring(0, absolutePath.lastIndexOf("/") + 1) + str);
        }
        return null;
    }

    public static int getSpecialFileSize() {
        if (areThereSpecialFiles()) {
            return GluUtil.sumIntArray(GameLet.SPECIAL_RES_FILESIZE_ARRAY);
        }
        return 0;
    }

    public static void getSpecialStartPosition(int[] iArr) {
        int i;
        int i2;
        int i3;
        File fileFindResourceFile = GluUtil.findResourceFile();
        if (fileFindResourceFile != null) {
            String fileDirectoryWithEnder = GluUtil.getFileDirectoryWithEnder(fileFindResourceFile.getAbsolutePath());
            i = 0;
            i2 = 0;
            i3 = 0;
            for (int i4 = 0; i4 < GameLet.SPECIAL_RES_FILENAME_ARRAY.length; i4++) {
                File file = new File(fileDirectoryWithEnder + GameLet.SPECIAL_RES_FILENAME_ARRAY[i4]);
                if (!file.exists()) {
                    break;
                }
                int length = (int) file.length();
                if (length != GameLet.SPECIAL_RES_FILESIZE_ARRAY[i4]) {
                    i3--;
                    i = length;
                }
                i3++;
                i2 += length;
                if (i != 0) {
                    break;
                }
            }
        } else {
            i = 0;
            i2 = 0;
            i3 = 0;
        }
        iArr[0] = i2;
        iArr[1] = i3;
        iArr[2] = i;
        Debug.log("stats[SPECIAL_STAT_BYTE_START] = " + i2);
        Debug.log("stats[SPECIAL_STAT_NTH_FILE_START] = " + i3);
        Debug.log("stats[SPECIAL_STAT_SINGLE_FILE_BYTE_START] = " + i);
    }

    private void initialize(boolean z) {
        GluUtil.zero(this.m_prevVerifiedVersion);
        GluUtil.zero(this.m_reserved);
        if (z) {
            saveFile();
        }
    }

    public final void downloadResFile() {
        this.m_downloadThread = new Thread() { // from class: com.glu.platform.android.resdl.GluDownloadResMgr.2
            @Override // java.lang.Thread, java.lang.Runnable
            public final void run() {
                GluDownloadResMgr gluDownloadResMgr = GluDownloadResMgr.this;
                boolean z = GluDownloadResMgr.areThereSpecialFiles() && !GluDownloadResMgr.this.verifySpecialFileIntegrity();
                ResFileDownloadView resFileDownloadView = ResFileDownloadView.instance;
                if (resFileDownloadView == null) {
                    return;
                }
                try {
                    resFileDownloadView.m_downloadError = GluDownloadResMgr.access$400$1bc0119a(GluDownloadResMgr.this, (byte) 0);
                } catch (Exception e) {
                    resFileDownloadView.m_downloadError = GluUtil.getString(R.string.IDS_DOWNLOAD_FAILED_GENERIC);
                }
                resFileDownloadView.m_downloadFailed = resFileDownloadView.m_downloadError != null;
                resFileDownloadView.m_downloadDone = true;
                if (GluUtil.isAppPaused() && (!z || resFileDownloadView.m_downloadFailed)) {
                    if (resFileDownloadView.m_downloadFailed) {
                        Debug.log("===============================================================\n= !!!!!!!!!!!!!!!!!!!!! DOWNLOAD FAILED !!!!!!!!!!!!!!!!!!!!! =\n===============================================================");
                        GluUtil.sendNotification$3b99ba1a(GluUtil.getString(R.string.IDS_NOTIFICATION_DOWNLOAD_FAILURE_SHORT), GluUtil.getString(R.string.IDS_NOTIFICATION_DOWNLOAD_FAILURE_TICKER));
                    } else {
                        Debug.log("***************************************************************\n********************** DOWNLOAD IS DONE ***********************\n***************************************************************");
                        GluUtil.sendNotification$3b99ba1a(GluUtil.getString(R.string.IDS_NOTIFICATION_DOWNLOAD_SUCCESS_SHORT), GluUtil.getString(R.string.IDS_NOTIFICATION_DOWNLOAD_SUCCESS_TICKER));
                    }
                }
                GluDownloadResMgr.this.m_downloadThread = null;
                if (resFileDownloadView.m_downloadFailed) {
                    return;
                }
                if (z) {
                    resFileDownloadView.newState(5);
                    return;
                }
                GluDownloadResMgr gluDownloadResMgr2 = GluDownloadResMgr.instance;
                if (GluDownloadResMgr.areThereSpecialFiles()) {
                    resFileDownloadView.newState(1);
                }
            }
        };
        this.m_downloadThread.start();
    }

    public final void downloadSpecialResFile() {
        this.m_downloadThread = new Thread() { // from class: com.glu.platform.android.resdl.GluDownloadResMgr.1
            @Override // java.lang.Thread, java.lang.Runnable
            public final void run() {
                ResFileDownloadView resFileDownloadView = ResFileDownloadView.instance;
                if (resFileDownloadView == null) {
                    return;
                }
                try {
                    if (GluDownloadResMgr.this.m_specialFilesChecksummed && GluDownloadResMgr.this.m_splitSpecialDownloads.size() > 0) {
                        for (int size = GluDownloadResMgr.this.m_splitSpecialDownloads.size() - 1; size >= 0; size--) {
                            SplitDownloadSpec splitDownloadSpec = (SplitDownloadSpec) GluDownloadResMgr.this.m_splitSpecialDownloads.elementAt(size);
                            Debug.log("Downloading a file in part, offset=" + splitDownloadSpec.downloadOffset + "   length=" + splitDownloadSpec.downloadLength);
                            resFileDownloadView.m_downloadError = GluDownloadResMgr.access$200$5bdf26ba(GluDownloadResMgr.this, splitDownloadSpec.fullFilename, splitDownloadSpec.downloadOffset, splitDownloadSpec.downloadLength);
                            if (resFileDownloadView.m_downloadError != null) {
                                break;
                            }
                            GluDownloadResMgr.access$312(GluDownloadResMgr.this, splitDownloadSpec.downloadLength);
                            ResFileDownloadView.instance.m_bytesDownloaded = 0;
                            if (!splitDownloadSpec.redoChecksum()) {
                                resFileDownloadView.m_downloadError = GluUtil.getString(R.string.IDS_DOWNLOAD_FAILED_GENERIC);
                                break;
                            }
                            GluDownloadResMgr.this.m_splitSpecialDownloads.removeElementAt(size);
                        }
                    } else {
                        resFileDownloadView.m_downloadError = GluDownloadResMgr.access$400$1bc0119a(GluDownloadResMgr.this, (byte) 1);
                    }
                } catch (Exception e) {
                    resFileDownloadView.m_downloadError = GluUtil.getString(R.string.IDS_DOWNLOAD_FAILED_GENERIC);
                }
                resFileDownloadView.m_downloadFailed = resFileDownloadView.m_downloadError != null;
                if (!resFileDownloadView.m_downloadFailed) {
                    GluDownloadResMgr.access$500(GluDownloadResMgr.this);
                }
                resFileDownloadView.m_downloadDone = true;
                if (GluUtil.isAppPaused()) {
                    if (resFileDownloadView.m_downloadFailed) {
                        Debug.log("===============================================================\n= !!!!!!!!!!!!!!!!!!!!! DOWNLOAD FAILED !!!!!!!!!!!!!!!!!!!!! =\n===============================================================");
                        GluUtil.sendNotification$3b99ba1a(GluUtil.getString(R.string.IDS_NOTIFICATION_DOWNLOAD_FAILURE_SHORT), GluUtil.getString(R.string.IDS_NOTIFICATION_DOWNLOAD_FAILURE_TICKER));
                    } else {
                        Debug.log("***************************************************************\n********************** DOWNLOAD IS DONE ***********************\n***************************************************************");
                        GluUtil.sendNotification$3b99ba1a(GluUtil.getString(R.string.IDS_NOTIFICATION_DOWNLOAD_SUCCESS_SHORT), GluUtil.getString(R.string.IDS_NOTIFICATION_DOWNLOAD_SUCCESS_TICKER));
                    }
                }
                GluDownloadResMgr.this.m_downloadThread = null;
            }
        };
        this.m_downloadThread.start();
    }

    public final int getSpecialFilePartDownloaded() {
        return this.m_specialFilePartCompletedSoFar + ResFileDownloadView.instance.m_bytesDownloaded;
    }

    public final int getSpecialFilePartTotal() {
        return this.m_specialFilePartTotal;
    }

    public final void initialize() {
        initialize(true);
    }

    public final boolean performSpecialChecksumAsync() {
        if (this.m_prevVerifiedVersion[0] == ((byte) GluUtil.safeStringToInt(GameLet.instance.m_versionMajor)) && this.m_prevVerifiedVersion[1] == ((byte) GluUtil.safeStringToInt(GameLet.instance.m_versionMinor)) && this.m_prevVerifiedVersion[2] == ((byte) GluUtil.safeStringToInt(GameLet.instance.m_versionMicro)) && this.m_prevVerifiedVersion[3] == ((byte) GluUtil.safeStringToInt(GameLet.instance.m_versionNano))) {
            Debug.log("Verified version is current, so no checksumming special resources.");
            return true;
        }
        if (GameLet.SPECIAL_RES_FILENAME_ARRAY == null) {
            Debug.log("No special resources to checksum.");
            return true;
        }
        if (this.m_specialFilesChecksummed) {
            Debug.log("Special files already checksummed, but not fully downloaded. Not checksumming again.");
            return true;
        }
        if (GluUtil.findResourceFile() == null) {
            return true;
        }
        if (this.m_splitSpecialDownloads.size() > 0) {
            Debug.devDie("Reset m_splitSpecialDownloads before refilling it.");
            this.m_splitSpecialDownloads.removeAllElements();
        }
        this.m_specialFilesBeingChecksummed = true;
        Thread thread = new Thread() { // from class: com.glu.platform.android.resdl.GluDownloadResMgr.3
            @Override // java.lang.Thread, java.lang.Runnable
            public final void run() {
                GluDownloadResMgr.access$600(GluDownloadResMgr.this);
            }
        };
        this.m_specialChecksumThread = thread;
        thread.start();
        return false;
    }

    public final void saveFile() {
        try {
            FileOutputStream fileOutputStream = new FileOutputStream(getDataFile(), false);
            fileOutputStream.write(this.m_mainResFileInterrupted ? 1 : 0);
            fileOutputStream.write(this.m_secondaryFilesPassedOnce ? 1 : 0);
            fileOutputStream.write(this.m_prevVerifiedVersion);
            fileOutputStream.write(this.m_reserved);
            fileOutputStream.close();
            Debug.log("Wrote resource download data file.");
        } catch (Exception e) {
            Debug.log("Error writing resource download data file.", e);
        }
    }

    public final void setSecondaryFilesPassed(boolean z) {
        this.m_secondaryFilesPassedOnce = z;
        if (z) {
            this.m_prevVerifiedVersion[0] = (byte) GluUtil.safeStringToInt(GameLet.instance.m_versionMajor);
            this.m_prevVerifiedVersion[1] = (byte) GluUtil.safeStringToInt(GameLet.instance.m_versionMinor);
            this.m_prevVerifiedVersion[2] = (byte) GluUtil.safeStringToInt(GameLet.instance.m_versionMicro);
            this.m_prevVerifiedVersion[3] = (byte) GluUtil.safeStringToInt(GameLet.instance.m_versionNano);
        }
        saveFile();
    }

    public final boolean specialChecksumPassed() {
        return this.m_splitSpecialDownloads.size() == 0;
    }

    public final boolean specialFilesChecksumInProgress() {
        return this.m_specialFilesBeingChecksummed;
    }

    public final boolean verifySpecialFileIntegrity() {
        if (GameLet.SPECIAL_RES_FILENAME_ARRAY == null) {
            return true;
        }
        if (this.m_specialFilesChecksummed) {
            return specialChecksumPassed();
        }
        File fileFindResourceFile = GluUtil.findResourceFile();
        if (fileFindResourceFile == null) {
            Debug.log("Special files integrity assumed failed. Not even the resource is file downloaded yet.");
            return false;
        }
        String fileDirectoryWithEnder = GluUtil.getFileDirectoryWithEnder(fileFindResourceFile.getAbsolutePath());
        boolean z = true;
        for (int i = 0; i < GameLet.SPECIAL_RES_FILENAME_ARRAY.length; i++) {
            File file = new File(fileDirectoryWithEnder + GameLet.SPECIAL_RES_FILENAME_ARRAY[i]);
            if (!file.exists() || file.length() != GameLet.SPECIAL_RES_FILESIZE_ARRAY[i]) {
                Debug.log("File " + GameLet.SPECIAL_RES_FILENAME_ARRAY[i] + " failed. f.exists()=" + file.exists());
                if (!file.exists()) {
                    return false;
                }
                Debug.log("length=" + file.length() + "  expected=" + GameLet.SPECIAL_RES_FILESIZE_ARRAY[i]);
                if (file.length() > GameLet.SPECIAL_RES_FILESIZE_ARRAY[i]) {
                    file.delete();
                }
                z = false;
            }
        }
        return z;
    }

    public final boolean wereSpecialFilesChecksummed() {
        return this.m_specialFilesChecksummed;
    }
}
