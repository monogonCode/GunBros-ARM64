package com.tapjoy;

import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Environment;
import android.util.Log;
import java.io.BufferedInputStream;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.net.SocketTimeoutException;
import java.net.URL;
import java.net.URLConnection;
import java.util.Enumeration;
import java.util.Hashtable;
import java.util.Vector;
import javax.xml.parsers.DocumentBuilderFactory;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

/* JADX INFO: loaded from: classes.dex */
public class TapjoyVideo {
    public static final String TAPJOY_VIDEO = "TapjoyVideo";
    public static String imageBackgroundLocation = null;
    private static final String imageBackgroundUrl = "https://s3.amazonaws.com/tapjoy/videos/assets/background.png";
    public static String imagePlaceholderLocation = null;
    private static final String imagePlaceholderUrl = "https://s3.amazonaws.com/tapjoy/videos/assets/placeholder.png";
    public static String imageTapjoyLocation = null;
    private static final String imageTapjoyUrl = "https://s3.amazonaws.com/tapjoy/videos/assets/tapjoy.png";
    private static TapjoyVideo tapjoyVideo = null;
    private static TapjoyVideoNotifier tapjoyVideoNotifier;
    private Hashtable<String, TapjoyVideoObject> cachedVideos;
    Context context;
    private Vector<String> imageQueue;
    private Hashtable<String, String> uncachedImages;
    private Hashtable<String, TapjoyVideoObject> uncachedVideos;
    private Vector<String> videoQueue;
    public TapjoyVideoObject videoToPlay;
    private String videoCacheDir = null;
    private String imageCacheDir = null;
    private int videoCacheLimit = 5;

    public TapjoyVideo(Context context) {
        this.context = context;
        tapjoyVideo = this;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void cacheImage(final String str) {
        TapjoyLog.i(TAPJOY_VIDEO, "cacheImage: " + str);
        new Thread(new Runnable() { // from class: com.tapjoy.TapjoyVideo.3
            @Override // java.lang.Runnable
            public void run() {
                BufferedInputStream bufferedInputStream;
                BufferedInputStream bufferedInputStream2;
                boolean z;
                boolean z2;
                FileOutputStream fileOutputStream = null;
                long jCurrentTimeMillis = System.currentTimeMillis();
                try {
                    URLConnection uRLConnectionOpenConnection = new URL(str).openConnection();
                    uRLConnectionOpenConnection.setConnectTimeout(15000);
                    uRLConnectionOpenConnection.setReadTimeout(30000);
                    uRLConnectionOpenConnection.connect();
                    bufferedInputStream = new BufferedInputStream(uRLConnectionOpenConnection.getInputStream());
                    try {
                        File file = new File(TapjoyVideo.this.imageCacheDir);
                        String strSubstring = str.substring(0, str.lastIndexOf("/") + 1);
                        String strSubstring2 = str.substring(str.lastIndexOf("/") + 1);
                        TapjoyLog.i(TapjoyVideo.TAPJOY_VIDEO, "fileDir: " + file);
                        TapjoyLog.i(TapjoyVideo.TAPJOY_VIDEO, "path: " + strSubstring);
                        TapjoyLog.i(TapjoyVideo.TAPJOY_VIDEO, "file name: " + strSubstring2);
                        if (file.mkdirs()) {
                            TapjoyLog.i(TapjoyVideo.TAPJOY_VIDEO, "created directory at: " + file.getPath());
                        }
                        File file2 = new File(TapjoyVideo.this.imageCacheDir, strSubstring2);
                        FileOutputStream fileOutputStream2 = new FileOutputStream(file2);
                        try {
                            TapjoyLog.i(TapjoyVideo.TAPJOY_VIDEO, "downloading image file to: " + file2.toString());
                            byte[] bArr = new byte[1024];
                            while (true) {
                                int i = bufferedInputStream.read(bArr);
                                if (i == -1) {
                                    break;
                                } else {
                                    fileOutputStream2.write(bArr, 0, i);
                                }
                            }
                            fileOutputStream2.close();
                            bufferedInputStream.close();
                            TapjoyLog.i(TapjoyVideo.TAPJOY_VIDEO, "FILE SIZE: " + file2.length());
                            fileOutputStream = fileOutputStream2;
                            z2 = file2.length() == 0;
                            z = false;
                        } catch (SocketTimeoutException e) {
                            e = e;
                            fileOutputStream = fileOutputStream2;
                            bufferedInputStream2 = bufferedInputStream;
                            TapjoyLog.e(TapjoyVideo.TAPJOY_VIDEO, "Network timeout: " + e.toString());
                            bufferedInputStream = bufferedInputStream2;
                            z = true;
                            z2 = true;
                        } catch (Exception e2) {
                            e = e2;
                            fileOutputStream = fileOutputStream2;
                            TapjoyLog.e(TapjoyVideo.TAPJOY_VIDEO, "Error caching image file: " + e.toString());
                            z = true;
                            z2 = false;
                        }
                    } catch (SocketTimeoutException e3) {
                        e = e3;
                        bufferedInputStream2 = bufferedInputStream;
                    } catch (Exception e4) {
                        e = e4;
                    }
                } catch (SocketTimeoutException e5) {
                    e = e5;
                    bufferedInputStream2 = null;
                } catch (Exception e6) {
                    e = e6;
                    bufferedInputStream = null;
                }
                if (z2) {
                    TapjoyLog.i(TapjoyVideo.TAPJOY_VIDEO, "Network timeout");
                    try {
                        bufferedInputStream.close();
                        fileOutputStream.close();
                    } catch (Exception e7) {
                    }
                }
                if (z2 || z) {
                    if (TapjoyVideo.this.imageQueue.size() > 0) {
                        TapjoyVideo.this.cacheImage((String) TapjoyVideo.this.imageQueue.elementAt(0));
                    }
                } else {
                    TapjoyVideo.this.imageQueue.removeElementAt(0);
                    if (TapjoyVideo.this.imageQueue.size() > 0) {
                        TapjoyVideo.this.cacheImage((String) TapjoyVideo.this.imageQueue.elementAt(0));
                    }
                    TapjoyLog.i(TapjoyVideo.TAPJOY_VIDEO, "image cached in: " + (System.currentTimeMillis() - jCurrentTimeMillis) + "ms");
                }
            }
        }).start();
    }

    private void cacheVideo(final String str) {
        TapjoyLog.i(TAPJOY_VIDEO, "download and cache video from: " + str);
        new Thread(new Runnable() { // from class: com.tapjoy.TapjoyVideo.2
            @Override // java.lang.Runnable
            public void run() {
                FileOutputStream fileOutputStream;
                BufferedInputStream bufferedInputStream;
                FileOutputStream fileOutputStream2;
                BufferedInputStream bufferedInputStream2;
                boolean z;
                boolean z2;
                File file = null;
                long jCurrentTimeMillis = System.currentTimeMillis();
                try {
                    URLConnection uRLConnectionOpenConnection = new URL(str).openConnection();
                    uRLConnectionOpenConnection.setConnectTimeout(15000);
                    uRLConnectionOpenConnection.setReadTimeout(30000);
                    uRLConnectionOpenConnection.connect();
                    bufferedInputStream = new BufferedInputStream(uRLConnectionOpenConnection.getInputStream());
                    try {
                        File file2 = new File(TapjoyVideo.this.videoCacheDir);
                        String strSubstring = str.substring(0, str.lastIndexOf("/") + 1);
                        String strSubstring2 = str.substring(str.lastIndexOf("/") + 1);
                        TapjoyLog.i(TapjoyVideo.TAPJOY_VIDEO, "fileDir: " + file2);
                        TapjoyLog.i(TapjoyVideo.TAPJOY_VIDEO, "path: " + strSubstring);
                        TapjoyLog.i(TapjoyVideo.TAPJOY_VIDEO, "file name: " + strSubstring2);
                        if (file2.mkdirs()) {
                            TapjoyLog.i(TapjoyVideo.TAPJOY_VIDEO, "created directory at: " + file2.getPath());
                        }
                        File file3 = new File(TapjoyVideo.this.videoCacheDir, strSubstring2);
                        try {
                            fileOutputStream = new FileOutputStream(file3);
                            try {
                                TapjoyLog.i(TapjoyVideo.TAPJOY_VIDEO, "downloading video file to: " + file3.toString());
                                byte[] bArr = new byte[1024];
                                while (true) {
                                    int i = bufferedInputStream.read(bArr);
                                    if (i == -1) {
                                        break;
                                    } else {
                                        fileOutputStream.write(bArr, 0, i);
                                    }
                                }
                                fileOutputStream.close();
                                bufferedInputStream.close();
                                TapjoyLog.i(TapjoyVideo.TAPJOY_VIDEO, "FILE SIZE: " + file3.length());
                                file = file3;
                                z2 = file3.length() == 0;
                                z = false;
                            } catch (SocketTimeoutException e) {
                                e = e;
                                file = file3;
                                fileOutputStream2 = fileOutputStream;
                                bufferedInputStream2 = bufferedInputStream;
                                TapjoyLog.e(TapjoyVideo.TAPJOY_VIDEO, "Network timeout: " + e.toString());
                                bufferedInputStream = bufferedInputStream2;
                                z = true;
                                fileOutputStream = fileOutputStream2;
                                z2 = true;
                            } catch (Exception e2) {
                                e = e2;
                                file = file3;
                                TapjoyLog.e(TapjoyVideo.TAPJOY_VIDEO, "Error caching video file: " + e.toString());
                                z = true;
                                z2 = false;
                            }
                        } catch (SocketTimeoutException e3) {
                            e = e3;
                            bufferedInputStream2 = bufferedInputStream;
                            file = file3;
                            fileOutputStream2 = null;
                        } catch (Exception e4) {
                            e = e4;
                            fileOutputStream = null;
                            file = file3;
                        }
                    } catch (SocketTimeoutException e5) {
                        e = e5;
                        fileOutputStream2 = null;
                        bufferedInputStream2 = bufferedInputStream;
                    } catch (Exception e6) {
                        e = e6;
                        fileOutputStream = null;
                    }
                } catch (SocketTimeoutException e7) {
                    e = e7;
                    fileOutputStream2 = null;
                    bufferedInputStream2 = null;
                } catch (Exception e8) {
                    e = e8;
                    fileOutputStream = null;
                    bufferedInputStream = null;
                }
                if (z2) {
                    TapjoyLog.i(TapjoyVideo.TAPJOY_VIDEO, "Network timeout");
                    try {
                        bufferedInputStream.close();
                        fileOutputStream.close();
                    } catch (Exception e9) {
                    }
                }
                if (z2 || z) {
                    TapjoyVideoNotifier unused = TapjoyVideo.tapjoyVideoNotifier;
                    return;
                }
                String str2 = (String) TapjoyVideo.this.videoQueue.elementAt(0);
                TapjoyVideoObject tapjoyVideoObject = (TapjoyVideoObject) TapjoyVideo.this.uncachedVideos.get(str2);
                tapjoyVideoObject.dataLocation = file.getAbsolutePath();
                SharedPreferences.Editor editorEdit = TapjoyVideo.this.context.getSharedPreferences(TapjoyConstants.TJC_VIDEOS_PREFERENCE, 0).edit();
                editorEdit.putString(str2, str2);
                editorEdit.commit();
                TapjoyVideo.this.cachedVideos.put(str2, tapjoyVideoObject);
                TapjoyVideo.this.uncachedVideos.remove(str2);
                TapjoyVideo.this.videoQueue.removeElementAt(0);
                TapjoyVideo.this.setVideoIDs();
                TapjoyVideo.this.loadNextVideo();
                TapjoyLog.i(TapjoyVideo.TAPJOY_VIDEO, "video cached in: " + (System.currentTimeMillis() - jCurrentTimeMillis) + "ms");
                TapjoyVideoNotifier unused2 = TapjoyVideo.tapjoyVideoNotifier;
            }
        }).start();
    }

    public static TapjoyVideo getInstance() {
        return tapjoyVideo;
    }

    public static TapjoyVideoNotifier getVideoNotifier() {
        return tapjoyVideoNotifier;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public boolean handleGetVideosResponse(String str) {
        DocumentBuilderFactory documentBuilderFactoryNewInstance = DocumentBuilderFactory.newInstance();
        TapjoyLog.i(TAPJOY_VIDEO, "========================================");
        try {
            NodeList elementsByTagName = documentBuilderFactoryNewInstance.newDocumentBuilder().parse(new ByteArrayInputStream(str.getBytes("UTF-8"))).getElementsByTagName("TapjoyVideos");
            NodeList childNodes = elementsByTagName.item(0).getChildNodes();
            TapjoyLog.i(TAPJOY_VIDEO, "nodelistParent length: " + elementsByTagName.getLength());
            TapjoyLog.i(TAPJOY_VIDEO, "nodelist length: " + childNodes.getLength());
            for (int i = 0; i < childNodes.getLength(); i++) {
                Node nodeItem = childNodes.item(i);
                TapjoyVideoObject tapjoyVideoObject = new TapjoyVideoObject();
                if (nodeItem != null && nodeItem.getNodeType() == 1) {
                    Element element = (Element) nodeItem;
                    String nodeTrimValue = TapjoyUtil.getNodeTrimValue(element.getElementsByTagName("ClickURL"));
                    if (nodeTrimValue != null && !nodeTrimValue.equals("")) {
                        tapjoyVideoObject.clickURL = nodeTrimValue;
                    }
                    String nodeTrimValue2 = TapjoyUtil.getNodeTrimValue(element.getElementsByTagName("OfferID"));
                    if (nodeTrimValue2 != null && !nodeTrimValue2.equals("")) {
                        tapjoyVideoObject.offerID = nodeTrimValue2;
                    }
                    String nodeTrimValue3 = TapjoyUtil.getNodeTrimValue(element.getElementsByTagName("Name"));
                    if (nodeTrimValue3 != null && !nodeTrimValue3.equals("")) {
                        tapjoyVideoObject.videoAdName = nodeTrimValue3;
                    }
                    String nodeTrimValue4 = TapjoyUtil.getNodeTrimValue(element.getElementsByTagName("Amount"));
                    if (nodeTrimValue4 != null && !nodeTrimValue4.equals("")) {
                        tapjoyVideoObject.currencyAmount = nodeTrimValue4;
                    }
                    String nodeTrimValue5 = TapjoyUtil.getNodeTrimValue(element.getElementsByTagName("CurrencyName"));
                    if (nodeTrimValue5 != null && !nodeTrimValue5.equals("")) {
                        tapjoyVideoObject.currencyName = nodeTrimValue5;
                    }
                    String nodeTrimValue6 = TapjoyUtil.getNodeTrimValue(element.getElementsByTagName("VideoURL"));
                    if (nodeTrimValue6 != null && !nodeTrimValue6.equals("")) {
                        tapjoyVideoObject.videoURL = nodeTrimValue6;
                    }
                    String nodeTrimValue7 = TapjoyUtil.getNodeTrimValue(element.getElementsByTagName("IconURL"));
                    if (nodeTrimValue7 != null && !nodeTrimValue7.equals("")) {
                        tapjoyVideoObject.iconURL = nodeTrimValue7;
                    }
                    TapjoyLog.i(TAPJOY_VIDEO, "-----");
                    TapjoyLog.i(TAPJOY_VIDEO, "videoObject.clickURL: " + tapjoyVideoObject.clickURL);
                    TapjoyLog.i(TAPJOY_VIDEO, "videoObject.offerID: " + tapjoyVideoObject.offerID);
                    TapjoyLog.i(TAPJOY_VIDEO, "videoObject.videoAdName: " + tapjoyVideoObject.videoAdName);
                    TapjoyLog.i(TAPJOY_VIDEO, "videoObject.currencyAmount: " + tapjoyVideoObject.currencyAmount);
                    TapjoyLog.i(TAPJOY_VIDEO, "videoObject.currencyName: " + tapjoyVideoObject.currencyName);
                    TapjoyLog.i(TAPJOY_VIDEO, "videoObject.videoURL: " + tapjoyVideoObject.videoURL);
                    TapjoyLog.i(TAPJOY_VIDEO, "videoObject.iconURL: " + tapjoyVideoObject.iconURL);
                    NodeList childNodes2 = element.getElementsByTagName("Buttons").item(0).getChildNodes();
                    for (int i2 = 0; i2 < childNodes2.getLength(); i2++) {
                        NodeList childNodes3 = childNodes2.item(i2).getChildNodes();
                        if (childNodes3.getLength() != 0) {
                            String nodeValue = childNodes3.item(0).getFirstChild().getNodeValue();
                            TapjoyLog.i(TAPJOY_VIDEO, "name: " + nodeValue);
                            String nodeValue2 = childNodes3.item(1).getFirstChild().getNodeValue();
                            TapjoyLog.i(TAPJOY_VIDEO, "url: " + nodeValue2);
                            tapjoyVideoObject.addButton(nodeValue, nodeValue2);
                        }
                    }
                    this.videoQueue.addElement(tapjoyVideoObject.offerID);
                    this.uncachedVideos.put(tapjoyVideoObject.offerID, tapjoyVideoObject);
                    setVideoIDs();
                }
            }
            TapjoyLog.i(TAPJOY_VIDEO, "========================================");
            return true;
        } catch (Exception e) {
            TapjoyLog.e(TAPJOY_VIDEO, "Error parsing XML: " + e.toString());
            return false;
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void setVideoIDs() {
        String str;
        String str2 = "";
        if (this.cachedVideos != null && this.cachedVideos.size() > 0) {
            Enumeration<String> enumerationKeys = this.cachedVideos.keys();
            while (true) {
                str = str2;
                if (!enumerationKeys.hasMoreElements()) {
                    break;
                }
                str2 = str + enumerationKeys.nextElement();
                if (enumerationKeys.hasMoreElements()) {
                    str2 = str2 + ",";
                }
            }
            TapjoyLog.i(TAPJOY_VIDEO, "cachedVideos size: " + this.cachedVideos.size());
            str2 = str;
        }
        TapjoyLog.i(TAPJOY_VIDEO, "videoIDs: [" + str2 + "]");
        TapjoyConnectCore.setVideoIDs(str2);
    }

    public TapjoyVideoObject getCurrentVideoData() {
        return this.videoToPlay;
    }

    public void initVideoAd(TapjoyVideoNotifier tapjoyVideoNotifier2) {
        TapjoyLog.i(TAPJOY_VIDEO, "initVideoAd");
        if (tapjoyVideoNotifier2 == null) {
            Log.e(TAPJOY_VIDEO, "Error during initVideoAd -- TapjoyVideoNotifier is null");
            return;
        }
        tapjoyVideoNotifier = tapjoyVideoNotifier2;
        this.videoCacheDir = Environment.getExternalStorageDirectory().toString() + "/tapjoy/cache/videos/";
        this.imageCacheDir = Environment.getExternalStorageDirectory().toString() + "/tapjoy/cache/images/";
        this.videoQueue = new Vector<>();
        this.uncachedVideos = new Hashtable<>();
        this.cachedVideos = new Hashtable<>();
        this.imageQueue = new Vector<>();
        this.imageQueue.addElement(imageBackgroundUrl);
        this.imageQueue.addElement(imagePlaceholderUrl);
        this.imageQueue.addElement(imageTapjoyUrl);
        this.uncachedImages = new Hashtable<>();
        this.uncachedImages.put("background", imageBackgroundUrl);
        this.uncachedImages.put("placeholder", imagePlaceholderUrl);
        this.uncachedImages.put("tapjoy", imageTapjoyUrl);
        imageBackgroundLocation = this.imageCacheDir + "background.png";
        imagePlaceholderLocation = this.imageCacheDir + "placeholder.png";
        imageTapjoyLocation = this.imageCacheDir + "tapjoy.png";
        setVideoIDs();
        if ("mounted".equals(Environment.getExternalStorageState())) {
            new Thread(new Runnable() { // from class: com.tapjoy.TapjoyVideo.1
                @Override // java.lang.Runnable
                public void run() {
                    String strConnectToURL = new TapjoyURLConnection().connectToURL("https://ws.tapjoyads.com/videos?", TapjoyConnectCore.getURLParams() + "&publisher_user_id=" + TapjoyConnectCore.getUserID());
                    if ((strConnectToURL == null || strConnectToURL.length() <= 0) ? false : TapjoyVideo.this.handleGetVideosResponse(strConnectToURL)) {
                        File[] fileArrListFiles = new File(TapjoyVideo.this.videoCacheDir).listFiles();
                        if (fileArrListFiles != null) {
                            for (int i = 0; i < fileArrListFiles.length; i++) {
                                String name = fileArrListFiles[i].getName();
                                String strSubstring = name.substring(0, name.indexOf("."));
                                TapjoyLog.i(TapjoyVideo.TAPJOY_VIDEO, "file[" + i + "]: " + fileArrListFiles[i].getAbsolutePath() + " --- " + fileArrListFiles[i].getName());
                                TapjoyLog.i(TapjoyVideo.TAPJOY_VIDEO, "key: " + strSubstring + ", " + strSubstring);
                                TapjoyLog.i(TapjoyVideo.TAPJOY_VIDEO, "uncachedVideos: " + TapjoyVideo.this.uncachedVideos.keySet().toString());
                                if (TapjoyVideo.this.uncachedVideos.containsKey(strSubstring)) {
                                    TapjoyLog.i(TapjoyVideo.TAPJOY_VIDEO, "*** Match found, comparing file sizes... ***");
                                    TapjoyLog.i(TapjoyVideo.TAPJOY_VIDEO, "local file size: " + fileArrListFiles[i].length());
                                    TapjoyVideoObject tapjoyVideoObject = (TapjoyVideoObject) TapjoyVideo.this.uncachedVideos.get(strSubstring);
                                    String contentLength = new TapjoyURLConnection().getContentLength(tapjoyVideoObject.videoURL);
                                    if (contentLength == null || Integer.parseInt(contentLength) != fileArrListFiles[i].length()) {
                                        TapjoyLog.i(TapjoyVideo.TAPJOY_VIDEO, "file size mismatch --- deleting video: " + fileArrListFiles[i].getAbsolutePath());
                                        TapjoyUtil.deleteFileOrDirectory(fileArrListFiles[i]);
                                    } else {
                                        TapjoyLog.i(TapjoyVideo.TAPJOY_VIDEO, "*** VIDEO ALREADY DOWNLOAD!!! " + strSubstring + " ***");
                                        tapjoyVideoObject.dataLocation = fileArrListFiles[i].getAbsolutePath();
                                        TapjoyVideo.this.cachedVideos.put(strSubstring, TapjoyVideo.this.uncachedVideos.get(strSubstring));
                                        TapjoyVideo.this.uncachedVideos.remove(strSubstring);
                                        TapjoyVideo.this.videoQueue.remove(strSubstring);
                                        TapjoyLog.i(TapjoyVideo.TAPJOY_VIDEO, "setting video location to: " + tapjoyVideoObject.dataLocation);
                                    }
                                } else {
                                    TapjoyLog.i(TapjoyVideo.TAPJOY_VIDEO, "VIDEO EXPIRED? removing video from cache: " + strSubstring + " --- " + fileArrListFiles[i].getAbsolutePath());
                                    TapjoyUtil.deleteFileOrDirectory(fileArrListFiles[i]);
                                }
                            }
                        }
                        TapjoyVideo.this.setVideoIDs();
                        if (TapjoyVideo.this.cachedVideos.size() > 0) {
                            TapjoyVideoNotifier unused = TapjoyVideo.tapjoyVideoNotifier;
                        }
                        TapjoyVideo.this.loadNextVideo();
                        File[] fileArrListFiles2 = new File(TapjoyVideo.this.imageCacheDir).listFiles();
                        TapjoyLog.i(TapjoyVideo.TAPJOY_VIDEO, "------------------------------");
                        TapjoyLog.i(TapjoyVideo.TAPJOY_VIDEO, "checking image cache...");
                        if (fileArrListFiles2 != null) {
                            for (int i2 = 0; i2 < fileArrListFiles2.length; i2++) {
                                String name2 = fileArrListFiles2[i2].getName();
                                String strSubstring2 = name2.substring(0, name2.indexOf("."));
                                TapjoyLog.i(TapjoyVideo.TAPJOY_VIDEO, "file[" + i2 + "]: " + fileArrListFiles2[i2].getAbsolutePath() + " --- " + fileArrListFiles2[i2].getName());
                                TapjoyLog.i(TapjoyVideo.TAPJOY_VIDEO, "key: " + strSubstring2);
                                TapjoyLog.i(TapjoyVideo.TAPJOY_VIDEO, "uncachedVideos: " + TapjoyVideo.this.uncachedVideos.keySet().toString());
                                if (TapjoyVideo.this.uncachedImages.containsKey(strSubstring2)) {
                                    TapjoyLog.i(TapjoyVideo.TAPJOY_VIDEO, "*** Match found, comparing file sizes... ***");
                                    TapjoyLog.i(TapjoyVideo.TAPJOY_VIDEO, "local file size: " + fileArrListFiles2[i2].length());
                                    String contentLength2 = new TapjoyURLConnection().getContentLength((String) TapjoyVideo.this.uncachedImages.get(strSubstring2));
                                    if (contentLength2 == null || Integer.parseInt(contentLength2) != fileArrListFiles2[i2].length()) {
                                        TapjoyLog.i(TapjoyVideo.TAPJOY_VIDEO, "file size mismatch --- deleting image");
                                        TapjoyUtil.deleteFileOrDirectory(fileArrListFiles2[i2]);
                                    } else {
                                        TapjoyLog.i(TapjoyVideo.TAPJOY_VIDEO, "*** image already downloaded, removing from queue: " + ((String) TapjoyVideo.this.uncachedImages.get(strSubstring2)));
                                        TapjoyVideo.this.imageQueue.remove(TapjoyVideo.this.uncachedImages.get(strSubstring2));
                                    }
                                } else {
                                    TapjoyLog.i(TapjoyVideo.TAPJOY_VIDEO, "invalid image");
                                    TapjoyUtil.deleteFileOrDirectory(fileArrListFiles2[i2]);
                                }
                            }
                        }
                        if (TapjoyVideo.this.imageQueue.size() > 0) {
                            TapjoyVideo.this.cacheImage((String) TapjoyVideo.this.imageQueue.elementAt(0));
                        }
                        TapjoyLog.i(TapjoyVideo.TAPJOY_VIDEO, "------------------------------");
                        TapjoyLog.i(TapjoyVideo.TAPJOY_VIDEO, "------------------------------");
                        TapjoyLog.i(TapjoyVideo.TAPJOY_VIDEO, "INIT DONE!");
                        TapjoyLog.i(TapjoyVideo.TAPJOY_VIDEO, "------------------------------");
                    }
                }
            }).start();
        } else {
            TapjoyLog.i(TAPJOY_VIDEO, "Media storage unavailable.");
            TapjoyVideoNotifier tapjoyVideoNotifier3 = tapjoyVideoNotifier;
        }
    }

    public void loadNextVideo() {
        TapjoyLog.i(TAPJOY_VIDEO, "++++++++++++++++++++++++++++++++++++++++");
        TapjoyLog.i(TAPJOY_VIDEO, "LOAD NEXT VIDEO");
        TapjoyLog.i(TAPJOY_VIDEO, "videoQueue size: " + this.videoQueue.size());
        TapjoyLog.i(TAPJOY_VIDEO, "uncachedVideos size: " + this.uncachedVideos.size());
        TapjoyLog.i(TAPJOY_VIDEO, "cachedVideos size: " + this.cachedVideos.size());
        if (this.cachedVideos.size() < this.videoCacheLimit && this.videoQueue.size() > 0) {
            cacheVideo(this.uncachedVideos.get(this.videoQueue.elementAt(0)).videoURL);
        }
        TapjoyLog.i(TAPJOY_VIDEO, "++++++++++++++++++++++++++++++++++++++++");
    }

    public void setVideoCacheCount(int i) {
        this.videoCacheLimit = i;
    }

    public boolean startVideo(String str, String str2, String str3, String str4) {
        TapjoyLog.i(TAPJOY_VIDEO, "Starting video activity with video: " + str);
        this.videoToPlay = this.cachedVideos.get(str);
        if (!"mounted".equals(Environment.getExternalStorageState())) {
            TapjoyLog.e(TAPJOY_VIDEO, "Cannot access external storage");
            TapjoyVideoNotifier tapjoyVideoNotifier2 = tapjoyVideoNotifier;
            return false;
        }
        if (this.videoToPlay == null) {
            TapjoyLog.e(TAPJOY_VIDEO, "null video object?");
            TapjoyLog.e(TAPJOY_VIDEO, "cached videos: " + this.cachedVideos.keys().toString());
            return false;
        }
        this.videoToPlay.currencyName = str2;
        this.videoToPlay.currencyAmount = str3;
        this.videoToPlay.clickURL = str4;
        TapjoyLog.i(TAPJOY_VIDEO, "videoToPlay: " + this.videoToPlay.offerID);
        TapjoyLog.i(TAPJOY_VIDEO, "amount: " + this.videoToPlay.currencyAmount);
        TapjoyLog.i(TAPJOY_VIDEO, "currency: " + this.videoToPlay.currencyName);
        TapjoyLog.i(TAPJOY_VIDEO, "clickURL: " + this.videoToPlay.clickURL);
        TapjoyLog.i(TAPJOY_VIDEO, "location: " + this.videoToPlay.dataLocation);
        if (!new File(this.videoToPlay.dataLocation).exists()) {
            TapjoyLog.e(TAPJOY_VIDEO, "video file does not exist?");
            return false;
        }
        Intent intent = new Intent(this.context, (Class<?>) TapjoyVideoView.class);
        intent.setFlags(268435456);
        intent.putExtra(TapjoyConstants.EXTRA_VIDEO_PATH, str);
        this.context.startActivity(intent);
        return true;
    }
}
