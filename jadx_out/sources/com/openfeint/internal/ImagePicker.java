package com.openfeint.internal;

import android.app.Activity;
import android.app.ActivityManager;
import android.content.Intent;
import android.database.Cursor;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Matrix;
import android.provider.MediaStore;
import android.widget.Toast;
import com.openfeint.internal.logcat.OFLog;
import com.openfeint.internal.request.multipart.ByteArrayPartSource;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;

/* JADX INFO: loaded from: classes.dex */
public final class ImagePicker {
    public static void compressAndUpload(Bitmap bitmap, String str, OpenFeintInternal.IUploadDelegate iUploadDelegate) {
        ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
        bitmap.compress(Bitmap.CompressFormat.PNG, 100, byteArrayOutputStream);
        OpenFeintInternal.getInstance().uploadFile(str, new ByteArrayPartSource("profile.png", byteArrayOutputStream.toByteArray()), "image/png", iUploadDelegate);
    }

    public static boolean isImagePickerActivityResult(int i) {
        return i == 10009;
    }

    public static Bitmap onImagePickerActivityResult$1de9c2be(Activity activity, int i, Intent intent) {
        if (i != -1) {
            return null;
        }
        String[] strArr = {"_data", "orientation"};
        Cursor cursorQuery = activity.getContentResolver().query(intent.getData(), strArr, null, null, null);
        if (cursorQuery == null) {
            Toast.makeText(OpenFeintInternal.getInstance().getContext(), OpenFeintInternal.getRString(RR.string("of_profile_picture_download_failed")), 1).show();
            return null;
        }
        cursorQuery.moveToFirst();
        String string = cursorQuery.getString(cursorQuery.getColumnIndex(strArr[0]));
        int i2 = cursorQuery.getInt(cursorQuery.getColumnIndex(strArr[1]));
        cursorQuery.close();
        Bitmap bitmapPreScaleImage$676c1c3e = preScaleImage$676c1c3e(string);
        int width = bitmapPreScaleImage$676c1c3e.getWidth();
        int height = bitmapPreScaleImage$676c1c3e.getHeight();
        boolean z = height > width;
        int i3 = z ? 0 : (width - height) / 2;
        int i4 = z ? (height - width) / 2 : 0;
        if (!z) {
            width = height;
        }
        float f = 152.0f / width;
        Matrix matrix = new Matrix();
        matrix.postScale(f, f);
        matrix.postRotate(i2);
        Bitmap bitmapCreateBitmap = Bitmap.createBitmap(bitmapPreScaleImage$676c1c3e, i3, i4, width, width, matrix, false);
        OFLog.e("ImagePicker", "image! " + bitmapCreateBitmap.getWidth() + "x" + bitmapCreateBitmap.getHeight());
        return bitmapCreateBitmap;
    }

    private static Bitmap preScaleImage$676c1c3e(String str) {
        int i = 1;
        File file = new File(str);
        try {
            BitmapFactory.Options options = new BitmapFactory.Options();
            options.inJustDecodeBounds = true;
            BitmapFactory.decodeStream(new FileInputStream(file), null, options);
            int iMin = Math.min(options.outWidth, options.outHeight);
            while (iMin / 2 > 152) {
                iMin /= 2;
                i++;
            }
            BitmapFactory.Options options2 = new BitmapFactory.Options();
            options2.inSampleSize = i;
            return BitmapFactory.decodeStream(new FileInputStream(file), null, options2);
        } catch (FileNotFoundException e) {
            OFLog.e("ImagePicker", e.toString());
            return null;
        }
    }

    public static void show(Activity activity) {
        ((ActivityManager) activity.getSystemService("activity")).getMemoryInfo(new ActivityManager.MemoryInfo());
        Intent intent = new Intent("android.intent.action.PICK", MediaStore.Images.Media.INTERNAL_CONTENT_URI);
        intent.setType("image/*");
        activity.startActivityForResult(intent, 10009);
    }
}
