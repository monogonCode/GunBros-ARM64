package com.urbanairship.push.embedded;

import android.content.Context;
import android.content.pm.PackageInfo;
import android.os.Build;
import android.provider.Settings;
import com.tapjoy.TapjoyConstants;
import com.urbanairship.Logger;
import com.urbanairship.UAirship;
import com.urbanairship.push.PushManager;
import com.urbanairship.push.PushPreferences;
import com.urbanairship.restclient.Request;
import com.urbanairship.restclient.Response;
import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.UUID;
import org.apache.http.Header;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.message.BasicNameValuePair;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.json.JSONTokener;

/* JADX INFO: loaded from: classes.dex */
public class BoxOfficeClient {
    private HeliumServer currentServer;
    private UUID encryptionKey;
    private final LinkedList<HeliumServer> servers = new LinkedList<>();

    public static class BoxOfficeException extends Exception {
        private static final long serialVersionUID = 1;

        public BoxOfficeException(String str) {
            super(str);
        }
    }

    public static class FatalBoxOfficeException extends BoxOfficeException {
        private static final long serialVersionUID = 1;

        public FatalBoxOfficeException(String str) {
            super(str);
        }
    }

    public static class FirstRunForbiddenException extends FatalBoxOfficeException {
        private static final long serialVersionUID = 1;

        public FirstRunForbiddenException(String str) {
            super(str);
        }
    }

    protected class HeliumServer {
        private String address;
        private int failureCount = 0;
        private long discoveredAt = System.currentTimeMillis();

        public HeliumServer(String str) {
            this.address = str;
        }

        static /* synthetic */ int access$108(HeliumServer heliumServer) {
            int i = heliumServer.failureCount;
            heliumServer.failureCount = i + 1;
            return i;
        }

        public boolean isValid() {
            long jCurrentTimeMillis = System.currentTimeMillis() - this.discoveredAt;
            Logger.verbose("Failure count for Helium server " + this.address + " is " + this.failureCount);
            Logger.verbose("Cache TTL for Helium server " + this.address + " is " + (Config.Helium.heliumCacheTTL - jCurrentTimeMillis) + "ms");
            if (jCurrentTimeMillis < 0) {
                return false;
            }
            if (jCurrentTimeMillis >= Config.Helium.minHeliumCacheTTL) {
                return jCurrentTimeMillis < Config.Helium.heliumCacheTTL && this.failureCount < 3;
            }
            Logger.verbose("Server valid. Age less than minimum cache TTL.");
            return true;
        }
    }

    public static class InvalidSecretException extends BoxOfficeException {
        private static final long serialVersionUID = 1;

        public InvalidSecretException(String str) {
            super(str);
        }
    }

    private void doLookup() throws BoxOfficeException {
        Logger.info("Performing BoxOffice lookup.");
        PushPreferences preferences = PushManager.shared().getPreferences();
        BasicNameValuePair basicNameValuePair = new BasicNameValuePair("apid", preferences.getPushId());
        BasicNameValuePair basicNameValuePair2 = new BasicNameValuePair("secret", preferences.getPushSecret());
        ArrayList arrayList = new ArrayList();
        arrayList.add(basicNameValuePair);
        arrayList.add(basicNameValuePair2);
        Request request = new Request("POST", Config.BoxOffice.url + "/lookup");
        try {
            request.setEntity(new UrlEncodedFormEntity(arrayList, "UTF-8"));
            setRequestHeaders(request);
            PackageInfo packageInfo = UAirship.getPackageInfo();
            String str = packageInfo != null ? packageInfo.versionName : "Unavailable";
            Logger.verbose("Set package version header:" + str);
            request.setHeader("X-UA-Package-Version", str);
            request.setHeader("User-Agent", String.format("Embedded Push/%s Android/%s [%s]", EmbeddedPushManager.version, Build.VERSION.RELEASE, UAirship.getPackageName()));
            try {
                Response responseExecute = request.execute();
                if (responseExecute == null) {
                    throw new BoxOfficeException("Error posting to /lookup");
                }
                int iStatus = responseExecute.status();
                if (iStatus == 401) {
                    preferences.setPushSecret(null);
                    preferences.setPushId(null);
                    throw new InvalidSecretException("Error posting to lookup; bad secret. Clearing APID and secret.");
                }
                if (iStatus != 200) {
                    throw new BoxOfficeException("Error posting to /lookup: " + iStatus);
                }
                processCacheHeaders(responseExecute);
                String strContentType = responseExecute.contentType();
                String strTrim = responseExecute.body().trim();
                if (strContentType == null || !strContentType.equals("application/json")) {
                    throw new BoxOfficeException("Received invalid BoxOffice response; content type is not application/json");
                }
                processJSONLookup(strTrim);
                try {
                    Thread.sleep(Config.Helium.postLookupDelay);
                } catch (InterruptedException e) {
                    Thread.currentThread().interrupt();
                }
            } catch (Exception e2) {
                throw new BoxOfficeException("Error posting to /lookup");
            }
        } catch (UnsupportedEncodingException e3) {
            throw new BoxOfficeException("Failed to post to /firstrun; UTF-8 unsupported!");
        }
    }

    private String generateApid() throws BoxOfficeException {
        String string = UUID.randomUUID().toString();
        Logger.debug("Generating APID: " + string);
        if (PushManager.shared().getPreferences().setPushId(string)) {
            return string;
        }
        throw new BoxOfficeException("The APID was invalid or failed to save.");
    }

    private String generateOrRetrieveApid() throws BoxOfficeException {
        String pushId = PushManager.shared().getPreferences().getPushId();
        return pushId != null ? pushId : generateApid();
    }

    private static String getHashedDeviceId(Context context) {
        String string;
        if (context == null || (string = Settings.Secure.getString(context.getContentResolver(), TapjoyConstants.TJC_ANDROID_ID)) == null) {
            return "";
        }
        byte[] bytes = string.getBytes();
        try {
            MessageDigest messageDigest = MessageDigest.getInstance("SHA-1");
            messageDigest.update(bytes, 0, bytes.length);
            byte[] bArrDigest = messageDigest.digest();
            StringBuilder sb = new StringBuilder();
            for (byte b : bArrDigest) {
                sb.append(String.format("%02x", Byte.valueOf(b)));
            }
            return sb.toString();
        } catch (NoSuchAlgorithmException e) {
            Logger.error("Unable to hash the device ID: SHA1 digester not present");
            return "";
        }
    }

    private void processCacheHeaders(Response response) {
        Logger.verbose("Helium Cache TTL is " + Config.Helium.heliumCacheTTL + " ms");
        Logger.verbose("Helium Cache Min TTL is " + Config.Helium.minHeliumCacheTTL + " ms");
        Header firstHeader = response.getFirstHeader("X-UA-Helium-TTL-MaxSec");
        if (firstHeader != null) {
            int i = 0;
            try {
                i = Integer.parseInt(firstHeader.getValue());
            } catch (NumberFormatException e) {
            }
            if (i > 0 && i <= Config.Helium.MAX_HELIUM_CACHE_TTL_MS) {
                Config.Helium.heliumCacheTTL = i * 1000;
                Logger.verbose("Set Helium Cache TTL to " + Config.Helium.heliumCacheTTL + " ms");
            }
        }
        Header firstHeader2 = response.getFirstHeader("X-UA-Helium-TTL-MinSec");
        if (firstHeader2 != null) {
            int i2 = -1;
            try {
                i2 = Integer.parseInt(firstHeader2.getValue());
            } catch (NumberFormatException e2) {
            }
            if (i2 < 0 || i2 > Config.Helium.heliumCacheTTL) {
                return;
            }
            Config.Helium.minHeliumCacheTTL = i2 * 1000;
            Logger.verbose("Set Helium Cache Min TTL to " + Config.Helium.minHeliumCacheTTL + " ms");
        }
    }

    private void processJSONLookup(String str) throws BoxOfficeException {
        Logger.debug("Received lookup response from BoxOffice.");
        try {
            JSONObject jSONObject = (JSONObject) new JSONTokener(str).nextValue();
            if (jSONObject.has("retry_after")) {
                EmbeddedPushManager.shared().setHoldingPattern(jSONObject.getLong("retry_after"));
                Logger.error("This application is in a holding pattern, most likely because your account does not have Helium access. To sign up for a free trial, visit https://go.urbanairship.com/apps/free-trial/.  Once granted permission, youshould fully uninstall the app before testing again, in order to clear this flag.");
                throw new FatalBoxOfficeException("Stop connecting. In a holding pattern.");
            }
            this.encryptionKey = UUID.fromString(jSONObject.getString("tut"));
            this.servers.clear();
            JSONArray jSONArray = jSONObject.getJSONArray("servers");
            Logger.verbose("Helium servers returned: " + jSONArray.toString());
            int length = jSONArray.length();
            for (int i = 0; i < length; i++) {
                this.servers.add(new HeliumServer(jSONArray.getString(i)));
            }
            if (jSONObject.has("max_keepalive_interval")) {
                Config.Helium.max_keepalive_interval = jSONObject.getInt("max_keepalive_interval") * 1000;
            }
        } catch (NullPointerException e) {
            throw new BoxOfficeException(String.format("Invalid Response: '%s'", str));
        } catch (JSONException e2) {
            throw new BoxOfficeException(String.format("Unparseable JSON: '%s'", str));
        }
    }

    private void setRequestHeaders(Request request) {
        request.setHeader("X-UA-Device-Family", "Android");
        request.setHeader("X-UA-Device-Model", Build.MODEL);
        request.setHeader("X-UA-OS-Version", Build.VERSION.RELEASE);
        request.setHeader("X-UA-Lib-Version", EmbeddedPushManager.version);
        request.setHeader("X-UA-Package-Name", UAirship.getPackageName());
        request.setHeader("X-UA-Sent-At", new DecimalFormat("0.000").format(System.currentTimeMillis() / 1000.0d));
        request.setHeader("X-UA-App-Key", UAirship.shared().getAirshipConfigOptions().getAppKey());
        if (UAirship.shared().getAirshipConfigOptions().analyticsEnabled) {
            request.setHeader("X-UA-Device-ID", getHashedDeviceId(UAirship.shared().getApplicationContext()));
        }
    }

    public String firstRun() throws BoxOfficeException {
        Logger.info("Performing BoxOffice firstRun.");
        String strGenerateOrRetrieveApid = generateOrRetrieveApid();
        ArrayList arrayList = new ArrayList();
        arrayList.add(new BasicNameValuePair("package", UAirship.getPackageName()));
        arrayList.add(new BasicNameValuePair("apid", strGenerateOrRetrieveApid));
        Request request = new Request("POST", Config.BoxOffice.url + "/firstrun");
        try {
            request.setEntity(new UrlEncodedFormEntity(arrayList, "UTF-8"));
            setRequestHeaders(request);
            Response responseExecute = request.execute();
            PushPreferences preferences = PushManager.shared().getPreferences();
            if (responseExecute == null) {
                throw new BoxOfficeException("Failed to post to /firstrun; request failed");
            }
            int iStatus = responseExecute.status();
            if (iStatus == 409) {
                preferences.setPushId(null);
                throw new BoxOfficeException("Unrecoverable firstrun state. Clearing APID.");
            }
            if (iStatus == 403) {
                throw new FirstRunForbiddenException("Failed to post to firstrun; forbidden. Reason:\n" + responseExecute.body());
            }
            if (iStatus != 200) {
                throw new BoxOfficeException("Failed to post to /firstrun: " + iStatus + ". Check your airship configuration, particularly your app key and secret.");
            }
            String strTrim = responseExecute.body().trim();
            if (preferences.setPushSecret(strTrim)) {
                return strTrim;
            }
            throw new BoxOfficeException("Failed to post to /firstrun; The secret was invalid or failed to save.");
        } catch (UnsupportedEncodingException e) {
            throw new BoxOfficeException("Failed to post to /firstrun; UTF-8 unsupported!");
        }
    }

    protected UUID getEncryptionKey() {
        return this.encryptionKey;
    }

    protected void incrementFailureCount() {
        if (this.currentServer != null) {
            HeliumServer.access$108(this.currentServer);
            Logger.debug("Set failure count for " + this.currentServer.address + " to " + this.currentServer.failureCount);
        }
    }

    public String lookup() throws BoxOfficeException {
        HeliumServer heliumServerRemove;
        PushPreferences preferences = PushManager.shared().getPreferences();
        if (preferences.getPushSecret() == null || preferences.getPushId() == null) {
            firstRun();
        }
        do {
            if (this.servers.isEmpty()) {
                doLookup();
            }
            if (this.servers.isEmpty()) {
                Logger.debug("No Helium servers returned from BoxOffice lookup.");
                return null;
            }
            heliumServerRemove = this.servers.remove();
        } while (!heliumServerRemove.isValid());
        if (heliumServerRemove.address.split(":").length != 2) {
            throw new BoxOfficeException(String.format("Got invalid server: '%s'", heliumServerRemove));
        }
        this.servers.add(heliumServerRemove);
        this.currentServer = heliumServerRemove;
        return heliumServerRemove.address;
    }

    protected void resetFailureCount() {
        if (this.currentServer != null) {
            Logger.debug("Reset failure count for " + this.currentServer.address + " to 0.");
            this.currentServer.failureCount = 0;
        }
    }
}
