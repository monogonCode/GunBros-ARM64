package com.urbanairship.util;

import android.os.AsyncTask;
import com.google.protobuf.CodedOutputStream;
import com.urbanairship.Logger;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Collections;
import java.util.zip.ZipEntry;
import java.util.zip.ZipFile;

/* JADX INFO: loaded from: classes.dex */
public class UnzipperTask extends AsyncTask<File, Integer, Exception> {
    private Delegate delegate;

    public static abstract class Delegate {
        public abstract void onFail(Exception exc);

        public abstract void onProgressUpdate(int i);

        public abstract void onSuccess();
    }

    /* JADX INFO: Access modifiers changed from: protected */
    @Override // android.os.AsyncTask
    public Exception doInBackground(File... fileArr) {
        if (fileArr.length != 2) {
            throw new IllegalArgumentException();
        }
        File file = fileArr[0];
        File file2 = fileArr[1];
        try {
            ZipFile zipFile = new ZipFile(file.getCanonicalPath());
            ArrayList<ZipEntry> list = Collections.list(zipFile.entries());
            Logger.verbose("Zip file: " + zipFile.getName() + " contains " + list.size() + " files");
            for (ZipEntry zipEntry : list) {
                if (zipEntry.getSize() != 0) {
                    String name = zipEntry.getName();
                    Logger.info("Unzipping file entry: " + name);
                    File canonicalFile = new File(file2, name).getCanonicalFile();
                    Logger.debug("Creating file " + canonicalFile);
                    if (!canonicalFile.getParentFile().mkdirs()) {
                        Logger.debug("Couldn't create or didn't need to create " + canonicalFile.getParentFile());
                    }
                    canonicalFile.createNewFile();
                    InputStream inputStream = zipFile.getInputStream(zipEntry);
                    FileOutputStream fileOutputStream = new FileOutputStream(canonicalFile);
                    byte[] bArr = new byte[CodedOutputStream.DEFAULT_BUFFER_SIZE];
                    while (true) {
                        int i = inputStream.read(bArr);
                        if (i <= 0) {
                            break;
                        }
                        fileOutputStream.write(bArr, 0, i);
                    }
                    fileOutputStream.flush();
                    inputStream.close();
                    fileOutputStream.close();
                }
            }
            file.delete();
            return null;
        } catch (Exception e) {
            file.delete();
            return e;
        }
    }

    /* JADX INFO: Access modifiers changed from: protected */
    @Override // android.os.AsyncTask
    public void onPostExecute(Exception exc) {
        if (exc != null) {
            this.delegate.onFail(exc);
        } else {
            this.delegate.onSuccess();
        }
    }

    /* JADX INFO: Access modifiers changed from: protected */
    @Override // android.os.AsyncTask
    public void onProgressUpdate(Integer... numArr) {
        this.delegate.onProgressUpdate(numArr[0].intValue());
    }

    public void setDelegate(Delegate delegate) {
        this.delegate = delegate;
    }
}
