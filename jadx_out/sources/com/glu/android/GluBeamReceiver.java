package com.glu.android;

import android.app.Activity;
import android.content.Intent;
import android.content.pm.ActivityInfo;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.nfc.NdefMessage;
import android.os.Bundle;
import android.os.Parcelable;

/* JADX INFO: loaded from: classes.dex */
public class GluBeamReceiver extends Activity {
    public static String MAIN_ACTIVITY = null;
    private static String[] THIS_LIST_IS_A_HACK = {"com.glu.android.tapjoy.TapjoyPluginActivity"};

    @Override // android.app.Activity
    protected void onCreate(Bundle bundle) {
        GluBeam.log("GluBeamReceiver.onCreate()");
        super.onCreate(bundle);
        Intent intent = getIntent();
        GluBeam.log("Intent extras...");
        GluBeamUtil.printBundle(intent.getExtras());
        String action = intent.getAction();
        if ("android.nfc.action.TAG_DISCOVERED".equals(action) || "android.nfc.action.NDEF_DISCOVERED".equals(action) || "android.nfc.action.TECH_DISCOVERED".equals(action)) {
            Parcelable[] parcelableArrayExtra = intent.getParcelableArrayExtra("android.nfc.extra.NDEF_MESSAGES");
            if (parcelableArrayExtra != null) {
                NdefMessage[] ndefMessageArr = new NdefMessage[parcelableArrayExtra.length];
                for (int i = 0; i < parcelableArrayExtra.length; i++) {
                    ndefMessageArr[i] = (NdefMessage) parcelableArrayExtra[i];
                }
                if (GluBeam.onMessagesReceived(ndefMessageArr)) {
                    GluBeam.log("Messages passed to game successfully.");
                } else {
                    GluBeam.log("Messages not passed to game. Opening game...");
                    PackageManager packageManager = getApplication().getPackageManager();
                    String packageName = getApplication().getPackageName();
                    String str = null;
                    GluBeam.log("Activities... " + packageName);
                    try {
                        PackageInfo packageInfo = packageManager.getPackageInfo(packageName, -1);
                        if (packageInfo == null) {
                            GluBeam.log("PackageInfo object is null.");
                        } else if (packageInfo.activities == null) {
                            GluBeam.log("PackageInfo activities is null.");
                        } else {
                            for (ActivityInfo activityInfo : packageInfo.activities) {
                                GluBeam.log("Activity: " + activityInfo.targetActivity + "      taskAffinity=" + activityInfo.taskAffinity + "      permission=" + activityInfo.permission + "      name=" + activityInfo.name + "      processName=" + activityInfo.processName + "      packageName=" + activityInfo.packageName);
                                if (activityInfo.metaData != null) {
                                    GluBeamUtil.printBundle(activityInfo.metaData);
                                }
                                if (activityInfo.name.startsWith(packageName)) {
                                    str = activityInfo.name;
                                    GluBeam.log("Going with class: " + str);
                                    break;
                                }
                                GluBeam.log("Rejected. (probably not our main activity)");
                            }
                            if (str == null) {
                                for (ActivityInfo activityInfo2 : packageInfo.activities) {
                                    for (String str2 : THIS_LIST_IS_A_HACK) {
                                        if (activityInfo2.name.startsWith(str2)) {
                                            str = activityInfo2.name;
                                            GluBeam.log("Going with class: " + str);
                                            break;
                                        }
                                    }
                                    if (str != null) {
                                        break;
                                    }
                                }
                            }
                            if (str == null) {
                                GluBeam.log("Activity couldn't be found. There's a list in GluBeamReceiver that needs to be updated.");
                            }
                        }
                    } catch (Exception e) {
                        GluBeam.log("Fail!", e);
                    }
                    try {
                        GluBeam.log("Launching activity. (hopefully)");
                        startActivity(new Intent(this, Class.forName(str)));
                    } catch (Throwable th) {
                        GluBeam.log("Failed to launch activity: " + str, th);
                    }
                }
            } else {
                GluBeam.log("Tossing out junk tag.");
            }
        } else {
            GluBeam.log("Unknown intent " + intent);
        }
        finish();
    }
}
