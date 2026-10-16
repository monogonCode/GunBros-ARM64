package com.openfeint.internal.ui;

import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;
import android.widget.Toast;
import com.openfeint.internal.OpenFeintInternal;
import com.openfeint.internal.RR;
import com.openfeint.internal.request.IRawRequestDelegate;
import java.util.List;
import java.util.Map;

/* JADX INFO: loaded from: classes.dex */
public class Settings extends WebNav {
    String mOldUserId;

    private class SettingsActionHandler extends WebNav.ActionHandler {
        public SettingsActionHandler(WebNav webNav) {
            super(webNav);
        }

        @Override // com.openfeint.internal.ui.WebNav.ActionHandler
        public void apiRequest(Map<String, String> map) {
            super.apiRequest(map);
            OpenFeintInternal.getInstance().getCurrentUser().load$70059c05();
        }

        public final void introFlow(Map<String, String> map) {
            Settings.this.startActivity(new Intent(Settings.this, (Class<?>) IntroFlow.class).putExtra("content_name", "login?mode=switch"));
        }

        public final void logout(Map<String, String> map) throws Throwable {
            OpenFeintInternal.getInstance().logoutUser(new IRawRequestDelegate() { // from class: com.openfeint.internal.ui.Settings.SettingsActionHandler.1
                @Override // com.openfeint.internal.request.IRawRequestDelegate
                public final void onResponse(int i, String str) {
                    Settings.this.finish();
                }
            });
        }

        @Override // com.openfeint.internal.ui.WebNav.ActionHandler
        protected void populateActionList(List<String> list) {
            super.populateActionList(list);
            list.add("logout");
            list.add("introFlow");
        }
    }

    public static void open() {
        Context context = OpenFeintInternal.getInstance().getContext();
        Intent intent = new Intent(context, (Class<?>) Settings.class);
        intent.addFlags(268435456);
        context.startActivity(intent);
    }

    @Override // com.openfeint.internal.ui.WebNav
    protected WebNav.ActionHandler createActionHandler(WebNav webNav) {
        return new SettingsActionHandler(webNav);
    }

    @Override // com.openfeint.internal.ui.WebNav
    protected String initialContentPath() {
        Bundle extras;
        String string;
        Intent intent = getIntent();
        return (intent == null || (extras = intent.getExtras()) == null || (string = extras.getString("com.openfeint.internal.ui.Settings.subPage")) == null) ? "settings/index" : "settings/" + string;
    }

    @Override // com.openfeint.internal.ui.WebNav, android.app.Activity
    protected void onActivityResult(int i, int i2, Intent intent) {
        super.onActivityResult(i, i2, intent);
        if (i != 10009 || intent == null) {
            return;
        }
        Toast.makeText(this, OpenFeintInternal.getRString(RR.string("of_profile_pic_changed")), 0).show();
    }

    @Override // com.openfeint.internal.ui.WebNav, android.app.Activity
    public void onResume() {
        if (this.mOldUserId == null) {
            this.mOldUserId = OpenFeintInternal.getInstance().getCurrentUser().resourceID();
        } else if (!this.mOldUserId.equals(OpenFeintInternal.getInstance().getCurrentUser().resourceID())) {
            new AlertDialog.Builder(this).setTitle(OpenFeintInternal.getRString(RR.string("of_switched_accounts"))).setMessage(String.format(OpenFeintInternal.getRString(RR.string("of_now_logged_in_as_format")), OpenFeintInternal.getInstance().getCurrentUser().name)).setNegativeButton(OpenFeintInternal.getRString(RR.string("of_ok")), new DialogInterface.OnClickListener() { // from class: com.openfeint.internal.ui.Settings.1
                @Override // android.content.DialogInterface.OnClickListener
                public final void onClick(DialogInterface dialogInterface, int i) {
                    Settings.this.finish();
                }
            }).show();
        }
        super.onResume();
    }
}
