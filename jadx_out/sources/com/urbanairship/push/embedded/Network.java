package com.urbanairship.push.embedded;

import android.net.ConnectivityManager;
import android.net.NetworkInfo;
import com.urbanairship.Logger;
import com.urbanairship.UAirship;
import java.net.InetAddress;
import java.net.NetworkInterface;
import java.net.SocketException;
import java.util.Enumeration;

/* JADX INFO: loaded from: classes.dex */
public class Network {
    private static ConnectivityManager connMan() {
        return (ConnectivityManager) UAirship.shared().getApplicationContext().getSystemService("connectivity");
    }

    public static String getActiveIPAddress() {
        String str;
        String hostAddress = null;
        try {
            Enumeration<NetworkInterface> networkInterfaces = NetworkInterface.getNetworkInterfaces();
            while (networkInterfaces.hasMoreElements()) {
                try {
                    Enumeration<InetAddress> inetAddresses = networkInterfaces.nextElement().getInetAddresses();
                    while (inetAddresses.hasMoreElements()) {
                        InetAddress inetAddressNextElement = inetAddresses.nextElement();
                        hostAddress = (inetAddressNextElement.isLoopbackAddress() || hostAddress != null) ? hostAddress : inetAddressNextElement.getHostAddress();
                    }
                } catch (SocketException e) {
                    str = hostAddress;
                    Logger.error("Error fetching IP address information");
                }
            }
            str = hostAddress;
        } catch (SocketException e2) {
            str = null;
        }
        Logger.verbose("Detected active IP address as: " + str);
        return str;
    }

    private static NetworkInfo info() {
        ConnectivityManager connectivityManagerConnMan = connMan();
        if (connectivityManagerConnMan != null) {
            return connectivityManagerConnMan.getActiveNetworkInfo();
        }
        Logger.error("Error fetching network info.");
        return null;
    }

    public static boolean isConnected() {
        NetworkInfo networkInfoInfo = info();
        if (networkInfoInfo == null) {
            return false;
        }
        return networkInfoInfo.isConnected();
    }

    public static String typeName() {
        NetworkInfo networkInfoInfo = info();
        return networkInfoInfo == null ? "none" : networkInfoInfo.getTypeName();
    }
}
