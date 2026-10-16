package com.glu.android;

import android.app.Activity;
import android.nfc.NdefMessage;
import android.nfc.NdefRecord;
import android.nfc.NfcAdapter;
import android.nfc.NfcEvent;
import android.os.Build;
import android.provider.Settings;
import com.glu.platform.android.GluPlatformActivity;
import com.tapjoy.TapjoyConstants;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.Random;
import java.util.Vector;

/* JADX INFO: loaded from: classes.dex */
public class GluBeam {
    private static final int BEAM_EVENT_DEBUG_ANYSIZE = 1002;
    private static final int BEAM_EVENT_DEBUG_BIG_MESSAGE = 1000;
    private static final int BEAM_EVENT_DEBUG_UDID = 1001;
    private static final int BEAM_EVENT_DESTROY = 5;
    private static final int BEAM_EVENT_INIT_OUTGOING_DOMAIN_INFO = 7;
    private static final int BEAM_EVENT_IS_DISABLED_BY_USER = 6;
    private static final int BEAM_EVENT_QUEUE_PAYLOAD = 1;
    private static final int BEAM_EVENT_REMOVE_ALL_PAYLOADS = 3;
    private static final int BEAM_EVENT_REMOVE_PAYLOAD = 2;
    private static final int BEAM_EVENT_TICK = 4;
    private static final boolean FIX_MULTIPLE_MESSAGE_BUG = true;
    private static final byte[] IGNORE_MSG;
    private static GluBeam instance;
    private static NdefMessage[] m_pendingMessages;
    private Activity m_activity = null;
    private NfcAdapter m_adapter = null;
    private Hashtable<Integer, NdefRecord> m_trueRecords = new Hashtable<>();
    private Vector<byte[]> m_incomingMessages = new Vector<>();
    private NdefRecord[] m_outgoingRecords = null;
    private int m_outgoingSize = 0;
    private String m_overrideNDEFType = null;
    private NFCListener m_listener = new NFCListener(this);
    private byte[] m_testPayload = null;

    private class NFCListener implements NfcAdapter.CreateNdefMessageCallback, NfcAdapter.OnNdefPushCompleteCallback {
        private int m_mostRecentOutgoingSize;
        private long m_startTime;

        /* synthetic */ NFCListener(GluBeam gluBeam) {
            this((byte) 0);
        }

        private NFCListener(byte b) {
            this.m_startTime = 0L;
            this.m_mostRecentOutgoingSize = 0;
        }

        @Override // android.nfc.NfcAdapter.CreateNdefMessageCallback
        public final NdefMessage createNdefMessage(NfcEvent nfcEvent) {
            if (GluBeam.this.m_outgoingRecords == null || GluBeam.this.m_outgoingRecords.length == 0) {
                GluBeam.log("Creating a null ndef message, as there are no records to send.");
                this.m_startTime = System.currentTimeMillis();
                this.m_mostRecentOutgoingSize = 0;
                return null;
            }
            GluBeam.log("Prompted to create an Ndef message. Created one of length: " + GluBeam.this.m_outgoingRecords.length);
            GluPlatformActivity.instance.setUseBeam(GluBeam.FIX_MULTIPLE_MESSAGE_BUG);
            this.m_startTime = System.currentTimeMillis();
            this.m_mostRecentOutgoingSize = GluBeam.this.m_outgoingSize;
            return new NdefMessage(GluBeam.this.m_outgoingRecords);
        }

        @Override // android.nfc.NfcAdapter.OnNdefPushCompleteCallback
        public final void onNdefPushComplete(NfcEvent nfcEvent) {
            GluBeam.log("Ndef push completed.");
            long jCurrentTimeMillis = System.currentTimeMillis() - this.m_startTime;
            GluBeam.log(this.m_mostRecentOutgoingSize + " bytes transmitted in " + jCurrentTimeMillis + "ms. " + (jCurrentTimeMillis == 0 ? "That was fast!" : (((double) this.m_mostRecentOutgoingSize) / (jCurrentTimeMillis / 0.001d)) + "b/s"));
        }
    }

    static {
        try {
            System.loadLibrary("glubeam");
        } catch (Throwable th) {
        }
        try {
            System.loadLibrary("glubeam_at");
        } catch (Throwable th2) {
        }
        instance = null;
        m_pendingMessages = null;
        IGNORE_MSG = new byte[]{99, 111, 109, 46, 103, 108, 117, 46};
    }

    private GluBeam() {
        log("Instance created...");
        if (m_pendingMessages != null) {
            onMessagesReceivedI(m_pendingMessages);
            m_pendingMessages = null;
        }
    }

    private void addOutgoingRecord(int i, byte[] bArr) {
        if (bArr == null) {
            return;
        }
        if (this.m_overrideNDEFType == null) {
            this.m_overrideNDEFType = this.m_activity.getApplication().getPackageName();
            this.m_overrideNDEFType = "glu.com:" + this.m_overrideNDEFType.substring(this.m_overrideNDEFType.lastIndexOf(46) + 1);
        }
        this.m_trueRecords.put(0, new NdefRecord((short) 4, stringToByteArray(this.m_overrideNDEFType), new byte[0], bArr));
        resetRecordArray();
    }

    public static boolean baStartsWith(byte[] bArr, byte[] bArr2) {
        if (bArr.length < bArr2.length) {
            return false;
        }
        for (int i = 0; i < bArr2.length; i++) {
            if (bArr[i] != bArr2[i]) {
                return false;
            }
        }
        return FIX_MULTIPLE_MESSAGE_BUG;
    }

    public static int beamEvent(int i, int i2, byte[] bArr) {
        if (instance == null) {
            return 0;
        }
        if (i == 1) {
            instance.addOutgoingRecord(i2, bArr);
            return 1;
        }
        if (i == 2) {
            instance.removeOutgoingRecord(i2);
            return 0;
        }
        if (i == 3) {
            instance.removeAllOutgoingRecords();
            return 0;
        }
        if (i == 4) {
            instance.tick(i2);
            return 0;
        }
        if (i == 5) {
            instance.m_adapter.setNdefPushMessageCallback(null, instance.m_activity, new Activity[0]);
            instance.m_adapter.setOnNdefPushCompleteCallback(null, instance.m_activity, new Activity[0]);
            instance = null;
            return 0;
        }
        if (i == 6) {
            return !instance.m_adapter.isEnabled() ? 1 : 0;
        }
        if (i != 7) {
            if (i < BEAM_EVENT_DEBUG_BIG_MESSAGE) {
                return 0;
            }
            instance.debugEvent(i, i2);
            return 0;
        }
        if (bArr == null) {
            log("Failed to init outgoing domain info: It's null!");
            return 0;
        }
        instance.m_overrideNDEFType = new String(bArr);
        log("Activity name set to: " + instance.m_overrideNDEFType);
        return 0;
    }

    public static final byte[] charArrayToByteArray(char[] cArr, boolean z) {
        byte[] bArr = new byte[(z ? 1 : 0) + cArr.length];
        for (int i = 0; i < cArr.length; i++) {
            bArr[i] = (byte) cArr[i];
        }
        if (z) {
            bArr[cArr.length] = 0;
        }
        return bArr;
    }

    private void createCustomLengthPayload(int i) {
        try {
            this.m_testPayload = new byte[i];
            new Random(System.currentTimeMillis()).nextBytes(this.m_testPayload);
            log("Created payload of size: " + i);
        } catch (Throwable th) {
            log("OOM trying to create custom payload of size: " + i);
        }
    }

    private void createHugePayload() {
        int i = 4194304;
        do {
            try {
                this.m_testPayload = new byte[i];
                new Random(System.currentTimeMillis()).nextBytes(this.m_testPayload);
                log("Created payload of size: " + i);
            } catch (Throwable th) {
                log("OOM trying to create payload of size: " + i);
                this.m_testPayload = null;
                i >>= 1;
            }
            if (this.m_testPayload != null) {
                return;
            }
        } while (i > 0);
    }

    private void createUDIDPayload() {
        this.m_testPayload = stringToByteArray(Settings.Secure.getString(this.m_activity.getContentResolver(), TapjoyConstants.TJC_ANDROID_ID));
    }

    private void debugEvent(int i, int i2) {
        if (i == BEAM_EVENT_DEBUG_BIG_MESSAGE) {
            createHugePayload();
        } else if (i == BEAM_EVENT_DEBUG_UDID) {
            createUDIDPayload();
        } else if (i == BEAM_EVENT_DEBUG_ANYSIZE) {
            createCustomLengthPayload(i2);
        }
        if (this.m_testPayload != null) {
            addOutgoingRecord(-559038737, this.m_testPayload);
        }
    }

    public static void init(Activity activity) {
        if (Build.VERSION.SDK_INT < 14) {
            return;
        }
        GluBeam gluBeam = new GluBeam();
        instance = gluBeam;
        gluBeam.m_activity = activity;
        instance.m_adapter = NfcAdapter.getDefaultAdapter(activity);
        if (instance.m_adapter == null) {
            instance = null;
        } else {
            instance.m_adapter.setNdefPushMessageCallback(instance.m_listener, instance.m_activity, new Activity[0]);
            instance.m_adapter.setOnNdefPushCompleteCallback(instance.m_listener, instance.m_activity, new Activity[0]);
        }
    }

    public static void log(String str) {
    }

    public static void log(String str, Throwable th) {
    }

    public static native boolean onIncomingNFCDataReceived(byte[] bArr);

    public static boolean onMessagesReceived(NdefMessage[] ndefMessageArr) {
        if (instance != null) {
            return instance.onMessagesReceivedI(ndefMessageArr);
        }
        log(ndefMessageArr.length + " messages received.");
        m_pendingMessages = ndefMessageArr;
        for (NdefMessage ndefMessage : ndefMessageArr) {
            NdefRecord[] records = ndefMessage.getRecords();
            if (records != null) {
                for (NdefRecord ndefRecord : records) {
                    byte[] type = ndefRecord.getType();
                    if (type != null) {
                        GluBeamReceiver.MAIN_ACTIVITY = new String(type);
                        log("Main activity: " + GluBeamReceiver.MAIN_ACTIVITY);
                        break;
                    }
                }
                if (GluBeamReceiver.MAIN_ACTIVITY != null) {
                    return false;
                }
            }
        }
        return false;
    }

    private boolean onMessagesReceivedI(NdefMessage[] ndefMessageArr) {
        for (NdefMessage ndefMessage : ndefMessageArr) {
            NdefRecord[] records = ndefMessage.getRecords();
            if (records != null) {
                for (NdefRecord ndefRecord : records) {
                    byte[] payload = ndefRecord.getPayload();
                    if (payload != null && !baStartsWith(payload, IGNORE_MSG)) {
                        log("Adding record of length: " + payload.length);
                        GluBeamUtil.printHexDump("Record", payload);
                        this.m_incomingMessages.addElement(payload);
                    }
                }
            }
        }
        return FIX_MULTIPLE_MESSAGE_BUG;
    }

    private void removeAllOutgoingRecords() {
        this.m_trueRecords.clear();
        resetRecordArray();
    }

    private void removeOutgoingRecord(int i) {
        if (this.m_trueRecords.remove(0) == null) {
            log("No record to remove: 0");
        } else {
            log("Removed record at: 0");
        }
        resetRecordArray();
    }

    private void resetRecordArray() {
        int size = this.m_trueRecords.size();
        if (size <= 0) {
            this.m_outgoingRecords = null;
            return;
        }
        NdefRecord[] ndefRecordArr = new NdefRecord[size + 1];
        Iterator<Integer> it = this.m_trueRecords.keySet().iterator();
        int length = 0;
        while (it.hasNext()) {
            ndefRecordArr[0] = this.m_trueRecords.get(Integer.valueOf(it.next().intValue()));
            length = ndefRecordArr[0].getPayload().length + 3 + length;
        }
        ndefRecordArr[size] = NdefRecord.createApplicationRecord(this.m_activity.getApplication().getPackageName());
        this.m_outgoingRecords = ndefRecordArr;
        this.m_outgoingSize = length;
    }

    public static final byte[] stringToByteArray(String str) {
        return charArrayToByteArray(str.toCharArray(), false);
    }

    private void tick(int i) {
        int i2;
        synchronized (this.m_incomingMessages) {
            if (this.m_incomingMessages.size() > 0) {
                int i3 = 0;
                while (i3 < this.m_incomingMessages.size()) {
                    if (onIncomingNFCDataReceived(this.m_incomingMessages.elementAt(i3))) {
                        this.m_incomingMessages.removeElementAt(i3);
                        i2 = i3 - 1;
                    } else {
                        i2 = i3;
                    }
                    i3 = i2 + 1;
                }
            }
        }
    }
}
