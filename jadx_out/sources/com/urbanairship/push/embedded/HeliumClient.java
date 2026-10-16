package com.urbanairship.push.embedded;

import android.os.Build;
import com.google.protobuf.ByteString;
import com.google.protobuf.CodedInputStream;
import com.urbanairship.Logger;
import com.urbanairship.UAirship;
import com.urbanairship.push.PushManager;
import com.urbanairship.push.PushPreferences;
import com.urbanairship.push.proto.Messages;
import com.urbanairship.push.proto.Rpc;
import com.urbanairship.util.Base64;
import com.urbanairship.util.Base64DecoderException;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.Socket;
import java.nio.ByteBuffer;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public class HeliumClient {
    private BoxOfficeClient boxOfficeClient;
    private CodedInputStream in;
    private OutputStream out;
    private PushPreferences prefs = PushManager.shared().getPreferences();
    private HashMap<String, String> pushIDs = new HashMap<>();

    public class HeliumException extends Exception {
        private static final long serialVersionUID = 1;

        public HeliumException(String str) {
            super(str);
        }
    }

    public class HeliumInvalidPackageException extends HeliumException {
        private static final long serialVersionUID = 1;

        public HeliumInvalidPackageException(String str) {
            super(str);
        }
    }

    public HeliumClient(Socket socket, BoxOfficeClient boxOfficeClient) throws IOException {
        this.boxOfficeClient = boxOfficeClient;
        this.in = CodedInputStream.newInstance(socket.getInputStream());
        this.out = socket.getOutputStream();
    }

    private void handleNotification(Messages.PushNotification pushNotification) {
        String packageName = pushNotification.getPackageName();
        String messageId = pushNotification.getMessageId();
        Logger.verbose("Got app id: " + packageName);
        if (messageAlreadySent(packageName, messageId)) {
            Logger.info("Message " + messageId + " already sent. Discarding.");
            return;
        }
        Logger.info("Message " + messageId + " received.");
        recordMessage(packageName, messageId);
        if (this.prefs.isPushEnabled()) {
            EmbeddedPushManager.deliverPush(pushNotification);
        } else {
            Logger.warn(String.format("Got push notification, but Push is disabled", new Object[0]));
        }
    }

    private void handleRegistration(Messages.RegistrationResponse registrationResponse) throws HeliumInvalidPackageException {
        String str;
        String str2;
        Logger.debug("Registration response received!");
        List<Messages.Relier> validReliersList = registrationResponse.getValidReliersList();
        List<Messages.Relier> invalidReliersList = registrationResponse.getInvalidReliersList();
        String str3 = "";
        Iterator<Messages.Relier> it = validReliersList.iterator();
        while (true) {
            str = str3;
            if (!it.hasNext()) {
                break;
            }
            str3 = str + it.next().getPackage() + " ";
        }
        String str4 = "";
        Iterator<Messages.Relier> it2 = invalidReliersList.iterator();
        while (true) {
            str2 = str4;
            if (!it2.hasNext()) {
                break;
            }
            str4 = str2 + it2.next().getPackage() + " ";
        }
        Logger.verbose("Valid: " + str);
        Logger.verbose("Invalid: " + str2);
        if (validReliersList.size() > 0) {
            EmbeddedPushManager.sendRegistrationResponse(true);
        } else if (invalidReliersList.size() > 0) {
            throw new HeliumInvalidPackageException("Package name on server does not match the application package name.");
        }
        this.boxOfficeClient.resetFailureCount();
    }

    private boolean messageAlreadySent(String str, String str2) {
        return this.pushIDs.containsKey(str) && this.pushIDs.get(str).equals(str2);
    }

    private static ArrayList<Messages.Relier> protoReliers(String str, String str2) {
        ArrayList<Messages.Relier> arrayList = new ArrayList<>();
        arrayList.add(Messages.Relier.newBuilder().setPackage(str).setAppKey(str2).build());
        return arrayList;
    }

    private void recordMessage(String str, String str2) {
        this.pushIDs.put(str, str2);
    }

    private void sendRequest(Messages.AirshipMethod airshipMethod, ByteString byteString) throws IOException {
        Rpc.Request requestBuild = Rpc.Request.newBuilder().setBody(byteString).setMethodId(airshipMethod).build();
        short serializedSize = (short) requestBuild.getSerializedSize();
        Logger.verbose("HeliumClient.sendRequest() - Protobuf Request Size: " + ((int) serializedSize));
        ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream(serializedSize + 2);
        byteArrayOutputStream.write((serializedSize >> 8) & 255);
        byteArrayOutputStream.write(serializedSize & 255);
        requestBuild.writeTo(byteArrayOutputStream);
        this.out.write(byteArrayOutputStream.toByteArray());
        this.out.flush();
    }

    protected void readResponse() throws HeliumException, Base64DecoderException, IOException, Crypto.NullUUID {
        short s = ByteBuffer.wrap(this.in.readRawBytes(2)).getShort();
        Logger.verbose("HeliumClient.readResponse() - Protobuf Response Size: " + ((int) s));
        if (s == 0) {
            Logger.verbose("HeliumClient.readResponse() - Keepalive Read");
            return;
        }
        if (this.boxOfficeClient.getEncryptionKey() == null) {
            throw new HeliumException("HeliumClient.readResponse() - No Key");
        }
        Rpc.Request from = Rpc.Request.parseFrom(new Crypto(this.boxOfficeClient.getEncryptionKey()).decrypt(Base64.decode(this.in.readRawBytes(s))));
        Logger.verbose("response read");
        if (from.getMethodId() == Messages.AirshipMethod.REGISTER) {
            handleRegistration(Messages.RegistrationResponse.parseFrom(from.getBody()));
        } else if (from.getMethodId() == Messages.AirshipMethod.PUSH_NOTIFICATION) {
            handleNotification(Messages.PushNotification.parseFrom(from.getBody()));
        } else {
            Logger.error("HeliumClient.readResponse() - Recevied an unknown Helium method type.");
        }
    }

    protected void register() throws IOException, Crypto.NullUUID {
        sendRequest(Messages.AirshipMethod.REGISTER, Messages.RegistrationEnvelope.newBuilder().setApid(this.prefs.getPushId()).setRegistration(ByteString.copyFrom(Base64.encodeBytesToBytes(new Crypto(this.boxOfficeClient.getEncryptionKey()).encrypt(Messages.Register.newBuilder().setApid(this.prefs.getPushId()).setOs(Messages.OS.ANDROID).setOsVersion(Build.VERSION.RELEASE).setUaVersion(EmbeddedPushManager.version).setSecret(this.prefs.getPushSecret()).addAllReliers(protoReliers(UAirship.getPackageName(), UAirship.shared().getAirshipConfigOptions().getAppKey())).build().toByteArray())))).build().toByteString());
    }
}
