package com.urbanairship.push.embedded;

import com.google.protobuf.InvalidProtocolBufferException;
import com.urbanairship.Logger;
import com.urbanairship.push.PushManager;
import java.io.IOException;
import java.io.InterruptedIOException;
import java.net.InetSocketAddress;
import java.net.Socket;

/* JADX INFO: loaded from: classes.dex */
public class HeliumConnection extends Thread {
    public static final int CONNECTION_TIMEOUT = 60000;
    private BoxOfficeClient boxOffice;
    private HeliumClient helium;
    private EmbeddedPushManager manager;
    private Socket socket;
    private volatile boolean running = false;
    private long retryInterval = 10000;

    public HeliumConnection(EmbeddedPushManager embeddedPushManager, BoxOfficeClient boxOfficeClient) {
        this.manager = embeddedPushManager;
        this.boxOffice = boxOfficeClient;
        setName("HeliumConnectionThread");
    }

    private void close(Socket socket) {
        if (socket != null) {
            try {
                if (!socket.isConnected() || socket.isClosed()) {
                    return;
                }
                socket.close();
            } catch (IOException e) {
                Logger.warn("Error closing socket.");
            }
        }
    }

    private boolean sleepForRetryInterval(long j) {
        long jMin = System.currentTimeMillis() - j < Config.Helium.retryResetThreshold ? Math.min(this.retryInterval * ((long) 2), Config.Helium.maxRetryInterval) : 10000L;
        Logger.debug("Rescheduling connection in " + jMin + "ms.");
        this.retryInterval = jMin;
        try {
            Thread.sleep(jMin);
            return true;
        } catch (InterruptedException e) {
            return false;
        }
    }

    public void abort() {
        Logger.debug("Connection aborting.");
        this.running = false;
        Logger.debug("Closing socket.");
        if (this.socket != null) {
            close(this.socket);
        }
        Logger.debug("Service stopped, socket closed successfully.");
    }

    public long getRetryInterval() {
        return this.retryInterval;
    }

    public boolean isConnected() {
        return (this.socket == null || !this.socket.isConnected() || this.socket.isClosed()) ? false : true;
    }

    @Override // java.lang.Thread, java.lang.Runnable
    public void run() {
        Logger.verbose("HeliumConnection - run");
        this.running = true;
        while (this.running) {
            String strTypeName = Network.typeName();
            try {
                String strLookup = this.boxOffice.lookup();
                if (strLookup == null) {
                    throw new BoxOfficeClient.BoxOfficeException("No Helium servers available for connection.");
                }
                if (Thread.interrupted()) {
                    Logger.debug("Thread interrupted during lookup.");
                    this.running = false;
                    return;
                }
                String[] strArrSplit = strLookup.split(":");
                String str = strArrSplit[0];
                Integer num = new Integer(strArrSplit[1]);
                if (!this.running) {
                    Logger.debug("Connection sequence aborted. Ending prior to opening Helium connection.");
                    return;
                }
                Logger.debug("Connecting to " + str + ":" + num);
                long jCurrentTimeMillis = System.currentTimeMillis();
                try {
                    try {
                        try {
                            try {
                                try {
                                    try {
                                        try {
                                            this.socket = new Socket();
                                            this.socket.setTcpNoDelay(false);
                                            this.socket.setSoTimeout((int) Config.Helium.max_keepalive_interval);
                                            this.socket.connect(new InetSocketAddress(str, num.intValue()), 60000);
                                            Logger.info("Connection established to " + this.socket.getInetAddress() + ":" + num + " on network type " + strTypeName);
                                            this.helium = new HeliumClient(this.socket, this.boxOffice);
                                            this.helium.register();
                                            while (this.running) {
                                                this.helium.readResponse();
                                                Thread.sleep(100L);
                                            }
                                            if (this.running) {
                                                close(this.socket);
                                                if (!Network.isConnected() || this.manager.isInHoldingPattern()) {
                                                    this.running = false;
                                                } else {
                                                    this.boxOffice.incrementFailureCount();
                                                    if (!sleepForRetryInterval(jCurrentTimeMillis)) {
                                                        this.running = false;
                                                        return;
                                                    }
                                                }
                                            } else {
                                                Logger.debug("Connection aborted, shutting down. Network type=" + strTypeName);
                                            }
                                        } catch (InterruptedIOException e) {
                                            Logger.debug("Socket timed out.");
                                            if (this.running) {
                                                close(this.socket);
                                                if (!Network.isConnected() || this.manager.isInHoldingPattern()) {
                                                    this.running = false;
                                                } else {
                                                    this.boxOffice.incrementFailureCount();
                                                    if (!sleepForRetryInterval(jCurrentTimeMillis)) {
                                                        this.running = false;
                                                        return;
                                                    }
                                                }
                                            } else {
                                                Logger.debug("Connection aborted, shutting down. Network type=" + strTypeName);
                                            }
                                        }
                                    } catch (HeliumClient.HeliumException e2) {
                                        Logger.debug("Helium exception - secret not set.");
                                        if (this.running) {
                                            close(this.socket);
                                            if (!Network.isConnected() || this.manager.isInHoldingPattern()) {
                                                this.running = false;
                                            } else {
                                                this.boxOffice.incrementFailureCount();
                                                if (!sleepForRetryInterval(jCurrentTimeMillis)) {
                                                    this.running = false;
                                                    return;
                                                }
                                            }
                                        } else {
                                            Logger.debug("Connection aborted, shutting down. Network type=" + strTypeName);
                                        }
                                    }
                                } catch (HeliumClient.HeliumInvalidPackageException e3) {
                                    Logger.error(e3.getMessage());
                                    EmbeddedPushManager.shared().stopHeartBeat();
                                    PushManager.stopService();
                                    EmbeddedPushManager.sendRegistrationResponse(false);
                                    this.running = false;
                                    if (!this.running) {
                                        Logger.debug("Connection aborted, shutting down. Network type=" + strTypeName);
                                        return;
                                    }
                                    close(this.socket);
                                    if (!Network.isConnected() || this.manager.isInHoldingPattern()) {
                                        this.running = false;
                                        return;
                                    }
                                    this.boxOffice.incrementFailureCount();
                                    if (!sleepForRetryInterval(jCurrentTimeMillis)) {
                                        this.running = false;
                                        return;
                                    }
                                }
                            } catch (InterruptedException e4) {
                                Logger.debug("Connection thread interrupted.");
                                this.running = false;
                                if (!this.running) {
                                    Logger.debug("Connection aborted, shutting down. Network type=" + strTypeName);
                                    return;
                                }
                                close(this.socket);
                                if (!Network.isConnected() || this.manager.isInHoldingPattern()) {
                                    this.running = false;
                                    return;
                                }
                                this.boxOffice.incrementFailureCount();
                                if (!sleepForRetryInterval(jCurrentTimeMillis)) {
                                    this.running = false;
                                    return;
                                }
                            }
                        } catch (Exception e5) {
                            Logger.debug("Exception in Helium connection. Network type=" + strTypeName + " " + e5.getMessage());
                            if (this.running) {
                                close(this.socket);
                                if (!Network.isConnected() || this.manager.isInHoldingPattern()) {
                                    this.running = false;
                                } else {
                                    this.boxOffice.incrementFailureCount();
                                    if (!sleepForRetryInterval(jCurrentTimeMillis)) {
                                        this.running = false;
                                        return;
                                    }
                                }
                            } else {
                                Logger.debug("Connection aborted, shutting down. Network type=" + strTypeName);
                            }
                        }
                    } catch (InvalidProtocolBufferException e6) {
                        Logger.debug("Invalid protobuf exception (Expected, likely due to socket interruption).");
                        if (this.running) {
                            close(this.socket);
                            if (!Network.isConnected() || this.manager.isInHoldingPattern()) {
                                this.running = false;
                            } else {
                                this.boxOffice.incrementFailureCount();
                                if (!sleepForRetryInterval(jCurrentTimeMillis)) {
                                    this.running = false;
                                    return;
                                }
                            }
                        } else {
                            Logger.debug("Connection aborted, shutting down. Network type=" + strTypeName);
                        }
                    } catch (IOException e7) {
                        Logger.debug("IOException (Expected following restart or connectivity change).");
                        if (this.running) {
                            close(this.socket);
                            if (!Network.isConnected() || this.manager.isInHoldingPattern()) {
                                this.running = false;
                            } else {
                                this.boxOffice.incrementFailureCount();
                                if (!sleepForRetryInterval(jCurrentTimeMillis)) {
                                    this.running = false;
                                    return;
                                }
                            }
                        } else {
                            Logger.debug("Connection aborted, shutting down. Network type=" + strTypeName);
                        }
                    }
                } catch (Throwable th) {
                    if (this.running) {
                        close(this.socket);
                        if (!Network.isConnected() || this.manager.isInHoldingPattern()) {
                            this.running = false;
                        } else {
                            this.boxOffice.incrementFailureCount();
                            if (!sleepForRetryInterval(jCurrentTimeMillis)) {
                                this.running = false;
                                return;
                            }
                        }
                    } else {
                        Logger.debug("Connection aborted, shutting down. Network type=" + strTypeName);
                    }
                    throw th;
                }
            } catch (BoxOfficeClient.FirstRunForbiddenException e8) {
                Logger.error(e8.getMessage());
                EmbeddedPushManager.shared().stopHeartBeat();
                PushManager.stopService();
                this.running = false;
                return;
            } catch (BoxOfficeClient.FatalBoxOfficeException e9) {
                Logger.error(e9.getMessage());
                PushManager.stopService();
                this.running = false;
                return;
            } catch (BoxOfficeClient.BoxOfficeException e10) {
                Logger.error(e10.getMessage());
                if (!sleepForRetryInterval(System.currentTimeMillis())) {
                    this.running = false;
                    return;
                }
            }
        }
    }

    public void setRetryInterval(long j) {
        this.retryInterval = Math.min(j, Config.Helium.maxRetryInterval);
    }
}
