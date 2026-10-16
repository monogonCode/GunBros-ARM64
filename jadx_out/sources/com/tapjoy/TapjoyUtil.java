package com.tapjoy;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import javax.xml.parsers.DocumentBuilderFactory;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

/* JADX INFO: loaded from: classes.dex */
public class TapjoyUtil {
    private static final String TAPJOY_UTIL = "TapjoyUtil";

    public static String SHA256(String str) throws NoSuchAlgorithmException, UnsupportedEncodingException {
        TapjoyLog.i(TAPJOY_UTIL, "SHA256: " + str);
        MessageDigest messageDigest = MessageDigest.getInstance("SHA-256");
        messageDigest.update(str.getBytes("iso-8859-1"), 0, str.length());
        return convertToHex(messageDigest.digest());
    }

    public static Document buildDocument(String str) {
        try {
            return DocumentBuilderFactory.newInstance().newDocumentBuilder().parse(new ByteArrayInputStream(str.getBytes("UTF-8")));
        } catch (Exception e) {
            TapjoyLog.e(TAPJOY_UTIL, "buildDocument exception: " + e.toString());
            return null;
        }
    }

    private static String convertToHex(byte[] bArr) {
        StringBuffer stringBuffer = new StringBuffer();
        for (int i = 0; i < bArr.length; i++) {
            int i2 = (bArr[i] >>> 4) & 15;
            int i3 = 0;
            while (true) {
                if (i2 < 0 || i2 > 9) {
                    stringBuffer.append((char) ((i2 - 10) + 97));
                } else {
                    stringBuffer.append((char) (i2 + 48));
                }
                int i4 = bArr[i] & 15;
                int i5 = i3 + 1;
                if (i3 > 0) {
                    break;
                }
                i3 = i5;
                i2 = i4;
            }
        }
        return stringBuffer.toString();
    }

    public static void deleteFileOrDirectory(File file) {
        if (file.isDirectory()) {
            for (File file2 : file.listFiles()) {
                deleteFileOrDirectory(file2);
            }
        }
        TapjoyLog.i(TAPJOY_UTIL, "****************************************");
        TapjoyLog.i(TAPJOY_UTIL, "deleteFileOrDirectory: " + file.getAbsolutePath());
        TapjoyLog.i(TAPJOY_UTIL, "****************************************");
        file.delete();
    }

    public static String getNodeTrimValue(NodeList nodeList) {
        Element element = (Element) nodeList.item(0);
        if (element == null) {
            return null;
        }
        NodeList childNodes = element.getChildNodes();
        int length = childNodes.getLength();
        String str = "";
        for (int i = 0; i < length; i++) {
            Node nodeItem = childNodes.item(i);
            if (nodeItem != null) {
                str = str + nodeItem.getNodeValue();
            }
        }
        if (str == null || str.equals("")) {
            return null;
        }
        return str.trim();
    }
}
